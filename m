Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92FB56AE10
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 23:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236951AbiGGV64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 17:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236852AbiGGV6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 17:58:36 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A4C0A1FCD6;
        Thu,  7 Jul 2022 14:58:34 -0700 (PDT)
Received: from localhost.localdomain (unknown [98.59.227.103])
        by linux.microsoft.com (Postfix) with ESMTPSA id 6EA0320A898A;
        Thu,  7 Jul 2022 14:58:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6EA0320A898A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1657231113;
        bh=bf6pX9yrjyYPJdsKED/irGpNKnf5DOG0pyMILhRzdk4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OhCkEtBhKU89KINiA3tZ/nfsUnMN8yXjJbkdfzNkTNSo/Xxy2qApOQ61RjY278o/W
         UL47YNGMj2oIil/HyihWG7/pTtcA/2Hc7RxFd9dT2r4GHS6gePXK7x45xENG22Ry+z
         r3dB2ADHQn7tUlrMolNbkd27EURvf2g+tiRv3t5g=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com
Cc:     linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 6/7] tracing/user_events: Enable setting event limit within namespace
Date:   Thu,  7 Jul 2022 14:58:27 -0700
Message-Id: <20220707215828.2021-7-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220707215828.2021-1-beaub@linux.microsoft.com>
References: <20220707215828.2021-1-beaub@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When granting non-admin users the ability to register and write data to
user events they should have a limit imposed. Using the namespace
options file, operators can change the limit of the events that are
allowed to be created.

There is also a new line in the user_events_status file to let users
know the current limit (and to ask the operator for more if required).

For example, to limit the namespace to only 256 events:
echo user_events_limit=256 > options

From within the namespace root:
cat user_events_status
...
Limit: 256

Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
 kernel/trace/trace_events_user.c | 54 +++++++++++++++++++++++++++++---
 1 file changed, 49 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index ef11706c310f..b3b6f14099fe 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -67,6 +67,7 @@ struct user_event_group {
 	DECLARE_BITMAP(page_bitmap, MAX_EVENTS);
 	refcount_t refcnt;
 	int id;
+	int reg_limit;
 };
 
 static DEFINE_HASHTABLE(group_table, 8);
@@ -234,6 +235,9 @@ static struct user_event_group *user_event_group_create(const char *name,
 			goto error;
 	}
 
+	/* Register limit is 1 under max for bitmap logic */
+	group->reg_limit = MAX_EVENTS - 1;
+
 	group->pages = alloc_pages(GFP_KERNEL | __GFP_ZERO, MAX_PAGE_ORDER);
 
 	if (!group->pages)
@@ -1258,8 +1262,7 @@ static int user_event_parse(struct user_event_group *group, char *name,
 			    char *args, char *flags,
 			    struct user_event **newuser)
 {
-	int ret;
-	int index;
+	int ret, index, limit;
 	u32 key;
 	struct user_event *user;
 
@@ -1278,9 +1281,18 @@ static int user_event_parse(struct user_event_group *group, char *name,
 		return 0;
 	}
 
-	index = find_first_zero_bit(group->page_bitmap, MAX_EVENTS);
+	/*
+	 * Bitmap returns actual max when too big:
+	 * We need to add 1 to this limit to ensure proper logic
+	 */
+	limit = group->reg_limit + 1;
+
+	if (limit > MAX_EVENTS)
+		return -E2BIG;
+
+	index = find_first_zero_bit(group->page_bitmap, limit);
 
-	if (index == MAX_EVENTS)
+	if (index == limit)
 		return -EMFILE;
 
 	user = kzalloc(sizeof(*user), GFP_KERNEL);
@@ -1813,6 +1825,7 @@ static int user_seq_show(struct seq_file *m, void *p)
 	seq_printf(m, "Active: %d\n", active);
 	seq_printf(m, "Busy: %d\n", busy);
 	seq_printf(m, "Max: %ld\n", MAX_EVENTS);
+	seq_printf(m, "Limit: %d\n", group->reg_limit);
 
 	return 0;
 }
@@ -1992,13 +2005,44 @@ static int user_event_ns_remove(struct trace_namespace *ns)
 	return ret;
 }
 
+#define NS_EVENT_LIMIT_PREFIX "user_events_limit="
+
 static int user_event_ns_parse(struct trace_namespace *ns, const char *command)
 {
-	return 0;
+	struct user_event_group *group = user_event_group_find(ns->id);
+	int len, value, ret = -ECANCELED;
+
+	if (!group)
+		return -ECANCELED;
+
+	len = str_has_prefix(command, NS_EVENT_LIMIT_PREFIX);
+	if (len && !kstrtouint(command + len, 0, &value)) {
+		if (value <= 0 || value > MAX_EVENTS) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		group->reg_limit = value;
+		ret = 0;
+		goto out;
+	}
+out:
+	user_event_group_release(group);
+
+	return ret;
 }
 
 static int user_event_ns_show(struct trace_namespace *ns, struct seq_file *m)
 {
+	struct user_event_group *group = user_event_group_find(ns->id);
+
+	if (!group)
+		return 0;
+
+	seq_printf(m, "%s%d\n", NS_EVENT_LIMIT_PREFIX, group->reg_limit);
+
+	user_event_group_release(group);
+
 	return 0;
 }
 
-- 
2.25.1


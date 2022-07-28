Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5335848CF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 01:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233351AbiG1Xw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 19:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbiG1Xwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 19:52:50 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ABB2071731;
        Thu, 28 Jul 2022 16:52:49 -0700 (PDT)
Received: from localhost.localdomain (unknown [76.135.27.191])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1622920FE9AF;
        Thu, 28 Jul 2022 16:52:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1622920FE9AF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1659052369;
        bh=HaSDfOxma22GjtN+QHmKmuwb7fowkhGpnjJEeEWHD1I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IDSBV9uuzKRNHwoO6GlvQi96BtvNyXgAz4hmeQ3SoHWgTlhfTdVOS1Tcj3L40RsuS
         IQlildg0Z9sasvdYcs1qs+LO4imtcTyDrfiiSg3vF8wdJGdQB/mmCY95ZE72uT/N9i
         Pg5GTptIYrD96jUTKpbPcrY3PggMGZEadWDT4Wus=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com
Cc:     linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 6/7] tracing/user_events: Enable setting event limit within namespace
Date:   Thu, 28 Jul 2022 16:52:40 -0700
Message-Id: <20220728235241.2249-7-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220728235241.2249-1-beaub@linux.microsoft.com>
References: <20220728235241.2249-1-beaub@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
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
 kernel/trace/trace_events_user.c | 57 +++++++++++++++++++++++++++++---
 1 file changed, 52 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 9694eee27956..1dc88bbd04f9 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -41,6 +41,7 @@
 #define MAX_PAGES (1 << MAX_PAGE_ORDER)
 #define MAX_BYTES (MAX_PAGES * PAGE_SIZE)
 #define MAX_EVENTS (MAX_BYTES * 8)
+#define MAX_LIMIT (MAX_EVENTS - 1)
 
 /* Limit how long of an event name plus args within the subsystem. */
 #define MAX_EVENT_DESC 512
@@ -85,6 +86,7 @@ struct user_event_group {
 	DECLARE_BITMAP(page_bitmap, MAX_EVENTS);
 	refcount_t refcnt;
 	int id;
+	int reg_limit;
 };
 
 static DEFINE_HASHTABLE(group_table, 8);
@@ -252,6 +254,13 @@ static struct user_event_group *user_event_group_create(const char *name,
 			goto error;
 	}
 
+	/*
+	 * Register limit is based on available events:
+	 * The ABI states event 0 is reserved, so the real max is the amount
+	 * of bits in the bitmap minus 1 (the reserved event slot).
+	 */
+	group->reg_limit = MAX_LIMIT;
+
 	group->pages = alloc_pages(GFP_KERNEL | __GFP_ZERO, MAX_PAGE_ORDER);
 
 	if (!group->pages)
@@ -1276,8 +1285,7 @@ static int user_event_parse(struct user_event_group *group, char *name,
 			    char *args, char *flags,
 			    struct user_event **newuser)
 {
-	int ret;
-	int index;
+	int ret, index, limit;
 	u32 key;
 	struct user_event *user;
 
@@ -1296,9 +1304,16 @@ static int user_event_parse(struct user_event_group *group, char *name,
 		return 0;
 	}
 
-	index = find_first_zero_bit(group->page_bitmap, MAX_EVENTS);
+	/*
+	 * 0 is a reserved bit, so the real limit needs to be one higher.
+	 * An example of this is a limit of 1, bit 0 is always set. To make
+	 * this work, the limit must be 2 in this case (bit 1 will be set).
+	 */
+	limit = min(group->reg_limit + 1, (int)MAX_EVENTS);
+
+	index = find_first_zero_bit(group->page_bitmap, limit);
 
-	if (index == MAX_EVENTS)
+	if (index == limit)
 		return -EMFILE;
 
 	user = kzalloc(sizeof(*user), GFP_KERNEL);
@@ -1831,6 +1846,7 @@ static int user_seq_show(struct seq_file *m, void *p)
 	seq_printf(m, "Active: %d\n", active);
 	seq_printf(m, "Busy: %d\n", busy);
 	seq_printf(m, "Max: %ld\n", MAX_EVENTS);
+	seq_printf(m, "Limit: %d\n", group->reg_limit);
 
 	return 0;
 }
@@ -2010,13 +2026,44 @@ static int user_event_ns_remove(struct trace_namespace *ns)
 	return ret;
 }
 
+#define NS_EVENT_LIMIT_PREFIX "user_events_limit="
+
 static int user_event_ns_parse(struct trace_namespace *ns, const char *command)
 {
-	return -ECANCELED;
+	struct user_event_group *group = user_event_group_find(ns->id);
+	int len, value, ret = -ECANCELED;
+
+	if (!group)
+		return -ECANCELED;
+
+	len = str_has_prefix(command, NS_EVENT_LIMIT_PREFIX);
+	if (len && !kstrtouint(command + len, 0, &value)) {
+		if (value <= 0 || value > MAX_LIMIT) {
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


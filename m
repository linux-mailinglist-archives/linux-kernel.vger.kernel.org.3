Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8142256AE0F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 23:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236940AbiGGV6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 17:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236848AbiGGV6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 17:58:36 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A4B1C1E3D7;
        Thu,  7 Jul 2022 14:58:34 -0700 (PDT)
Received: from localhost.localdomain (unknown [98.59.227.103])
        by linux.microsoft.com (Postfix) with ESMTPSA id 30EC320A8989;
        Thu,  7 Jul 2022 14:58:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 30EC320A8989
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1657231113;
        bh=OCV9hU67hQrPOe3mg7SwfbQWZ0U/+4Ect7gIEY0M4nU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XxUz/lDcTZzpQnodgmMVh0lq5BFD+wHFxNKrtDUIGbMf7m/ORYBKDoaYa31Lg8oAj
         FhZTcCcqSawpgIQLTc8H7YNJ54v0MGMcaxjn94F8z3ov66q05TgqVAJfhqjQ72VIuf
         8hcMP7Zb//VbM7qElL3PpACbahJRqApbqa+zDPvg=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com
Cc:     linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 5/7] tracing/user_events: Register with trace namespace API
Date:   Thu,  7 Jul 2022 14:58:26 -0700
Message-Id: <20220707215828.2021-6-beaub@linux.microsoft.com>
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

Register user_events up to the trace namespace API to allow user
programs to interface with isolated events when required. Each namespace
will have their own user_events_status and user_events_data files that
have the same ABI as before, however, the system name for events created
will be different (user_events.<namespace_name> vs user_events).

Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
 kernel/trace/trace_events_user.c | 169 ++++++++++++++++++++++++++++++-
 1 file changed, 167 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 8ffbb9ce2f1a..ef11706c310f 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -23,6 +23,10 @@
 #include "trace.h"
 #include "trace_dynevent.h"
 
+#ifdef CONFIG_TRACE_NAMESPACE
+#include "trace_namespace.h"
+#endif
+
 #define USER_EVENTS_PREFIX_LEN (sizeof(USER_EVENTS_PREFIX)-1)
 
 #define FIELD_DEPTH_TYPE 0
@@ -150,7 +154,7 @@ static void user_event_group_destroy(struct user_event_group *group)
 		tracefs_remove(group->status_file);
 
 	if (group->data_file)
-		tracefs_remove(group->status_file);
+		tracefs_remove(group->data_file);
 
 	if (group->register_page_data)
 		set_page_reservations(group->register_page_data, false);
@@ -162,6 +166,18 @@ static void user_event_group_destroy(struct user_event_group *group)
 	kfree(group);
 }
 
+static void user_event_group_unlink(struct user_event_group *group)
+{
+	if (WARN_ON(refcount_read(&group->refcnt) != 1))
+		pr_warn("user_event: Group unlink with more than 1 ref\n");
+
+	mutex_lock(&group_mutex);
+	hash_del(&group->node);
+	mutex_unlock(&group_mutex);
+
+	user_event_group_destroy(group);
+}
+
 static char *user_event_group_system_name(const char *name)
 {
 	char *system_name;
@@ -244,6 +260,7 @@ static struct user_event_group *user_event_group_create(const char *name,
 
 	return group;
 error:
+	/* Hash table not added, safe to destroy vs unlink */
 	if (group)
 		user_event_group_destroy(group);
 
@@ -1887,6 +1904,148 @@ static int create_user_tracefs(struct dentry *parent,
 	return -ENODEV;
 }
 
+#ifdef CONFIG_TRACE_NAMESPACE
+static int user_event_ns_create(struct trace_namespace *ns)
+{
+	struct user_event_group *group;
+	int ret;
+
+	group = user_event_group_create(ns->name, ns->id);
+
+	if (!group)
+		return -ENOMEM;
+
+	ret = create_user_tracefs(ns->dir, group);
+
+	user_event_group_release(group);
+
+	if (ret) {
+		user_event_group_unlink(group);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int user_event_ns_remove(struct trace_namespace *ns)
+{
+	struct user_event_group *group = user_event_group_find(ns->id);
+	struct user_event *user;
+	struct hlist_node *tmp;
+	int i, ret = 0;
+
+	if (!group)
+		return -ENOENT;
+
+	/*
+	 * Lock out finding this namespace while we are doing this so that
+	 * user programs trying to open a file owned by this group will block
+	 * until we are done here. The user program upon unblocking will then
+	 * fail to find the group if we removed it.
+	 */
+	mutex_lock(&group_mutex);
+
+	/* Ensure we have the only reference */
+	if (refcount_read(&group->refcnt) != 2) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	/*
+	 * At this point no more files can be opened by user space programs
+	 * while we are holding the group_mutex (they'll block on group_mutex).
+	 * To ensure other parts of the kernel aren't registering something we
+	 * also grab the group register mutex as an extra precaution.
+	 *
+	 * The events might be being recorded, which will result in their
+	 * being busy and we'll bail out.
+	 *
+	 * NOTE: event_mutex is held, locking reg_mutex could deadlock so we
+	 * must try to lock it and treat as busy if we cannot.
+	 */
+	if (!mutex_trylock(&group->reg_mutex)) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	hash_for_each_safe(group->register_table, i, tmp, user, node) {
+		if (!user_event_last_ref(user)) {
+			ret = -EBUSY;
+			break;
+		}
+
+		ret = destroy_user_event(user);
+
+		if (ret)
+			break;
+	}
+
+	mutex_unlock(&group->reg_mutex);
+out:
+	mutex_unlock(&group_mutex);
+
+	user_event_group_release(group);
+
+	if (!ret)
+		user_event_group_unlink(group);
+
+	return ret;
+}
+
+static int user_event_ns_parse(struct trace_namespace *ns, const char *command)
+{
+	return 0;
+}
+
+static int user_event_ns_show(struct trace_namespace *ns, struct seq_file *m)
+{
+	return 0;
+}
+
+static bool user_event_ns_is_busy(struct trace_namespace *ns)
+{
+	struct user_event_group *group = user_event_group_find(ns->id);
+	struct user_event *user;
+	int i;
+	bool busy = false;
+
+	if (!group)
+		return false;
+
+	/*
+	 * Quick check to ensure all events aren't busy:
+	 * The actual remove will do a more exhaustive check including
+	 * finding if any outstanding files are opened, etc.
+	 *
+	 * NOTE: event_mutex is held, locking reg_mutex could deadlock so we
+	 * must try to lock it and treat as busy if we cannot.
+	 */
+	if (!mutex_trylock(&group->reg_mutex))
+		return true;
+
+	hash_for_each(group->register_table, i, user, node) {
+		if (!user_event_last_ref(user)) {
+			busy = true;
+			break;
+		}
+	}
+
+	mutex_unlock(&group->reg_mutex);
+
+	user_event_group_release(group);
+
+	return busy;
+}
+
+static struct trace_namespace_operations user_event_ns_ops = {
+	.create = user_event_ns_create,
+	.remove = user_event_ns_remove,
+	.parse = user_event_ns_parse,
+	.show = user_event_ns_show,
+	.is_busy = user_event_ns_is_busy,
+};
+#endif
+
 static int __init trace_events_user_init(void)
 {
 	int ret;
@@ -1900,7 +2059,8 @@ static int __init trace_events_user_init(void)
 
 	if (ret) {
 		pr_warn("user_events could not register with tracefs\n");
-		user_event_group_destroy(root_group);
+		user_event_group_release(root_group);
+		user_event_group_unlink(root_group);
 		root_group = NULL;
 		return ret;
 	}
@@ -1908,6 +2068,11 @@ static int __init trace_events_user_init(void)
 	if (dyn_event_register(&user_event_dops))
 		pr_warn("user_events could not register with dyn_events\n");
 
+#ifdef CONFIG_TRACE_NAMESPACE
+	if (trace_namespace_register(&user_event_ns_ops))
+		pr_warn("user_events could not register with namespaces\n");
+#endif
+
 	return 0;
 }
 
-- 
2.25.1


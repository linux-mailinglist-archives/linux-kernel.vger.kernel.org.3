Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CEFF5848CB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 01:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233548AbiG1XxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 19:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbiG1Xwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 19:52:50 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AB85A7171A;
        Thu, 28 Jul 2022 16:52:49 -0700 (PDT)
Received: from localhost.localdomain (unknown [76.135.27.191])
        by linux.microsoft.com (Postfix) with ESMTPSA id D887820FE9AC;
        Thu, 28 Jul 2022 16:52:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D887820FE9AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1659052369;
        bh=AUgYkvSQU9ibc65r7fNJmBL+pnRrox56knfluC9Psp0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YLdQu5vLfUh67N0cayijcX5/lq1FjeIDFtaKnK3fJZTpfjspOm3paWB1+5Lf6uxQQ
         zeavhYYpiFLpbq/WOPoXbqWmQsDMUIgAwQ37OLQVxAX/iaoxBhrSR0FpbfFkdh9n/X
         A3Dooz/2a0QT+AxJW4xu43Xxqp1VoqjLnvyMBSlU=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com
Cc:     linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 5/7] tracing/user_events: Register with trace namespace API
Date:   Thu, 28 Jul 2022 16:52:39 -0700
Message-Id: <20220728235241.2249-6-beaub@linux.microsoft.com>
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

Register user_events up to the trace namespace API to allow user
programs to interface with isolated events when required. Each namespace
will have their own user_events_status and user_events_data files that
have the same ABI as before, however, the system name for events created
will be different (user_events.<namespace_name> vs user_events).

Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
 kernel/trace/trace_events_user.c | 167 ++++++++++++++++++++++++++++++-
 1 file changed, 166 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 44f9efd58af5..9694eee27956 100644
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
@@ -180,6 +184,18 @@ static void user_event_group_destroy(struct user_event_group *group)
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
@@ -262,6 +278,7 @@ static struct user_event_group *user_event_group_create(const char *name,
 
 	return group;
 error:
+	/* Hash table not added, safe to destroy vs unlink */
 	if (group)
 		user_event_group_destroy(group);
 
@@ -1905,6 +1922,148 @@ static int create_user_tracefs(struct dentry *parent,
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
+	return -ECANCELED;
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
@@ -1918,7 +2077,8 @@ static int __init trace_events_user_init(void)
 
 	if (ret) {
 		pr_warn("user_events could not register with tracefs\n");
-		user_event_group_destroy(root_group);
+		user_event_group_release(root_group);
+		user_event_group_unlink(root_group);
 		root_group = NULL;
 		return ret;
 	}
@@ -1926,6 +2086,11 @@ static int __init trace_events_user_init(void)
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


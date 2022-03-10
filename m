Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45E684D3DE8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 01:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238921AbiCJAMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 19:12:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbiCJAMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 19:12:44 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 80843EC5C8;
        Wed,  9 Mar 2022 16:11:44 -0800 (PST)
Received: from localhost.localdomain (c-73-140-2-214.hsd1.wa.comcast.net [73.140.2.214])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1BA1520B7178;
        Wed,  9 Mar 2022 16:11:44 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1BA1520B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1646871104;
        bh=2Tm4jHRAvhNun2QtoHcsGtuySYa+7u6fWS5djlNGcM0=;
        h=From:To:Cc:Subject:Date:From;
        b=YgW+A9sFwuaX87VWP7tDUPnfuqdE5AvdWTtt+4+2LrRm0fC5LrIeM7Oj5LVOkprr3
         ARB0O4jU1b26U14eLC81dMk+v6y5IPCtclRRr5YH24zIQ+3UUw8FUUyuXBk2x7jZ/U
         T3Ey9O/1NhmrqJL23S9AnWNL5OPS205qC/+Ke818=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        beaub@linux.microsoft.com
Subject: [PATCH] user_events: Prevent dyn_event delete racing with ioctl add/delete
Date:   Wed,  9 Mar 2022 16:11:41 -0800
Message-Id: <20220310001141.1660-1-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Find user_events always while under the event_mutex and before leaving
the lock, add a ref count to the user_event. This ensures that all paths
under the event_mutex that check the ref counts will be synchronized.

The ioctl add/delete paths are protected by the reg_mutex. However,
dyn_event is only protected by the event_mutex. The dyn_event delete
path cannot acquire reg_mutex, since that could cause a deadlock between
the ioctl delete case acquiring event_mutex after acquiring the reg_mutex.

Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
 kernel/trace/trace_events_user.c | 46 +++++++++++++++++++++++++++-----
 1 file changed, 40 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 2b5e9fdb63a0..1aaef2ab9f9f 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -135,6 +135,8 @@ static struct list_head *user_event_get_fields(struct trace_event_call *call)
  * NOTE: Offsets are from the user data perspective, they are not from the
  * trace_entry/buffer perspective. We automatically add the common properties
  * sizes to the offset for the user.
+ *
+ * Upon success user_event has its ref count increased by 1.
  */
 static int user_event_parse_cmd(char *raw_command, struct user_event **newuser)
 {
@@ -591,8 +593,10 @@ static struct user_event *find_user_event(char *name, u32 *outkey)
 	*outkey = key;
 
 	hash_for_each_possible(register_table, user, node, key)
-		if (!strcmp(EVENT_NAME(user), name))
+		if (!strcmp(EVENT_NAME(user), name)) {
+			atomic_inc(&user->refcnt);
 			return user;
+		}
 
 	return NULL;
 }
@@ -881,7 +885,12 @@ static int user_event_create(const char *raw_command)
 		return -ENOMEM;
 
 	mutex_lock(&reg_mutex);
+
 	ret = user_event_parse_cmd(name, &user);
+
+	if (!ret)
+		atomic_dec(&user->refcnt);
+
 	mutex_unlock(&reg_mutex);
 
 	if (ret)
@@ -1048,6 +1057,7 @@ static int user_event_trace_register(struct user_event *user)
 /*
  * Parses the event name, arguments and flags then registers if successful.
  * The name buffer lifetime is owned by this method for success cases only.
+ * Upon success the returned user_event has its ref count increased by 1.
  */
 static int user_event_parse(char *name, char *args, char *flags,
 			    struct user_event **newuser)
@@ -1055,7 +1065,12 @@ static int user_event_parse(char *name, char *args, char *flags,
 	int ret;
 	int index;
 	u32 key;
-	struct user_event *user = find_user_event(name, &key);
+	struct user_event *user;
+
+	/* Prevent dyn_event from racing */
+	mutex_lock(&event_mutex);
+	user = find_user_event(name, &key);
+	mutex_unlock(&event_mutex);
 
 	if (user) {
 		*newuser = user;
@@ -1119,6 +1134,10 @@ static int user_event_parse(char *name, char *args, char *flags,
 		goto put_user;
 
 	user->index = index;
+
+	/* Ensure we track ref */
+	atomic_inc(&user->refcnt);
+
 	dyn_event_init(&user->devent, &user_event_dops);
 	dyn_event_add(&user->devent, &user->call);
 	set_bit(user->index, page_bitmap);
@@ -1145,12 +1164,21 @@ static int delete_user_event(char *name)
 	if (!user)
 		return -ENOENT;
 
-	if (atomic_read(&user->refcnt) != 0)
-		return -EBUSY;
+	/* Ensure we are the last ref */
+	if (atomic_read(&user->refcnt) != 1) {
+		ret = -EBUSY;
+		goto put_ref;
+	}
 
-	mutex_lock(&event_mutex);
 	ret = destroy_user_event(user);
-	mutex_unlock(&event_mutex);
+
+	if (ret)
+		goto put_ref;
+
+	return ret;
+put_ref:
+	/* No longer have this ref */
+	atomic_dec(&user->refcnt);
 
 	return ret;
 }
@@ -1338,6 +1366,9 @@ static long user_events_ioctl_reg(struct file *file, unsigned long uarg)
 
 	ret = user_events_ref_add(file, user);
 
+	/* No longer need parse ref, ref_add either worked or not */
+	atomic_dec(&user->refcnt);
+
 	/* Positive number is index and valid */
 	if (ret < 0)
 		return ret;
@@ -1362,7 +1393,10 @@ static long user_events_ioctl_del(struct file *file, unsigned long uarg)
 	if (IS_ERR(name))
 		return PTR_ERR(name);
 
+	/* event_mutex prevents dyn_event from racing */
+	mutex_lock(&event_mutex);
 	ret = delete_user_event(name);
+	mutex_unlock(&event_mutex);
 
 	kfree(name);
 

base-commit: 864ea0e10cc90416a01b46f0d47a6f26dc020820
-- 
2.17.1


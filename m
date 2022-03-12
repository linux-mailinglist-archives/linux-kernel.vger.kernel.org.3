Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCC04D7190
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 00:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233017AbiCLX1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 18:27:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbiCLX1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 18:27:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D9893180
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 15:25:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2C6C609E9
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 23:25:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69BABC34103;
        Sat, 12 Mar 2022 23:25:52 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1nTB7P-000Wgs-HR;
        Sat, 12 Mar 2022 18:25:51 -0500
Message-ID: <20220312232551.366511755@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 12 Mar 2022 18:25:33 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Beau Belgrave <beaub@linux.microsoft.com>
Subject: [for-next][PATCH 08/12] user_events: Prevent dyn_event delete racing with ioctl add/delete
References: <20220312232525.234705244@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Beau Belgrave <beaub@linux.microsoft.com>

Find user_events always while under the event_mutex and before leaving
the lock, add a ref count to the user_event. This ensures that all paths
under the event_mutex that check the ref counts will be synchronized.

The ioctl add/delete paths are protected by the reg_mutex. However,
dyn_event is only protected by the event_mutex. The dyn_event delete
path cannot acquire reg_mutex, since that could cause a deadlock between
the ioctl delete case acquiring event_mutex after acquiring the reg_mutex.

Link: https://lkml.kernel.org/r/20220310001141.1660-1-beaub@linux.microsoft.com

Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_user.c | 46 +++++++++++++++++++++++++++-----
 1 file changed, 40 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 9a6191a6a786..4febc1d6ae72 100644
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
@@ -593,8 +595,10 @@ static struct user_event *find_user_event(char *name, u32 *outkey)
 	*outkey = key;
 
 	hash_for_each_possible(register_table, user, node, key)
-		if (!strcmp(EVENT_NAME(user), name))
+		if (!strcmp(EVENT_NAME(user), name)) {
+			atomic_inc(&user->refcnt);
 			return user;
+		}
 
 	return NULL;
 }
@@ -883,7 +887,12 @@ static int user_event_create(const char *raw_command)
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
@@ -1050,6 +1059,7 @@ static int user_event_trace_register(struct user_event *user)
 /*
  * Parses the event name, arguments and flags then registers if successful.
  * The name buffer lifetime is owned by this method for success cases only.
+ * Upon success the returned user_event has its ref count increased by 1.
  */
 static int user_event_parse(char *name, char *args, char *flags,
 			    struct user_event **newuser)
@@ -1057,7 +1067,12 @@ static int user_event_parse(char *name, char *args, char *flags,
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
@@ -1121,6 +1136,10 @@ static int user_event_parse(char *name, char *args, char *flags,
 		goto put_user;
 
 	user->index = index;
+
+	/* Ensure we track ref */
+	atomic_inc(&user->refcnt);
+
 	dyn_event_init(&user->devent, &user_event_dops);
 	dyn_event_add(&user->devent, &user->call);
 	set_bit(user->index, page_bitmap);
@@ -1147,12 +1166,21 @@ static int delete_user_event(char *name)
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
@@ -1340,6 +1368,9 @@ static long user_events_ioctl_reg(struct file *file, unsigned long uarg)
 
 	ret = user_events_ref_add(file, user);
 
+	/* No longer need parse ref, ref_add either worked or not */
+	atomic_dec(&user->refcnt);
+
 	/* Positive number is index and valid */
 	if (ret < 0)
 		return ret;
@@ -1364,7 +1395,10 @@ static long user_events_ioctl_del(struct file *file, unsigned long uarg)
 	if (IS_ERR(name))
 		return PTR_ERR(name);
 
+	/* event_mutex prevents dyn_event from racing */
+	mutex_lock(&event_mutex);
 	ret = delete_user_event(name);
+	mutex_unlock(&event_mutex);
 
 	kfree(name);
 
-- 
2.35.1

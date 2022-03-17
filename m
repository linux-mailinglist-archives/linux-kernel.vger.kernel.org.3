Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F88B4DC9DF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 16:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235748AbiCQP0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 11:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234198AbiCQP0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 11:26:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E0E5205BDB
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 08:25:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F41FF61957
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 15:25:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5928BC36AE2;
        Thu, 17 Mar 2022 15:25:23 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1nUs0A-004zcw-2V;
        Thu, 17 Mar 2022 11:25:22 -0400
Message-ID: <20220317152521.912163921@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 17 Mar 2022 11:24:59 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Beau Belgrave <beaub@linux.microsoft.com>
Subject: [for-next][PATCH 01/13] user_events: Add trace event call as root for low permission cases
References: <20220317152458.213689956@goodmis.org>
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

Tracefs by default is locked down heavily. System operators can open up
some files, such as user_events to a broader set of users. These users
do not have access within tracefs beyond just the user_event files. Due
to this restriction the trace_add_event_call/remove calls will silently
fail since the caller does not have permissions to create directories.

To fix this trace_add_event_call/remove calls will be issued with
override creds of the global root UID. Creds are reverted immediately
afterward.

Link: https://lkml.kernel.org/r/20220308222807.2040-1-beaub@linux.microsoft.com

Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_user.c | 39 ++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index e10ad057e797..8b3d241a31c2 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -562,6 +562,41 @@ static struct trace_event_functions user_event_funcs = {
 	.trace = user_event_print_trace,
 };
 
+static int user_event_set_call_visible(struct user_event *user, bool visible)
+{
+	int ret;
+	const struct cred *old_cred;
+	struct cred *cred;
+
+	cred = prepare_creds();
+
+	if (!cred)
+		return -ENOMEM;
+
+	/*
+	 * While by default tracefs is locked down, systems can be configured
+	 * to allow user_event files to be less locked down. The extreme case
+	 * being "other" has read/write access to user_events_data/status.
+	 *
+	 * When not locked down, processes may not have have permissions to
+	 * add/remove calls themselves to tracefs. We need to temporarily
+	 * switch to root file permission to allow for this scenario.
+	 */
+	cred->fsuid = GLOBAL_ROOT_UID;
+
+	old_cred = override_creds(cred);
+
+	if (visible)
+		ret = trace_add_event_call(&user->call);
+	else
+		ret = trace_remove_event_call(&user->call);
+
+	revert_creds(old_cred);
+	put_cred(cred);
+
+	return ret;
+}
+
 static int destroy_user_event(struct user_event *user)
 {
 	int ret = 0;
@@ -569,7 +604,7 @@ static int destroy_user_event(struct user_event *user)
 	/* Must destroy fields before call removal */
 	user_event_destroy_fields(user);
 
-	ret = trace_remove_event_call(&user->call);
+	ret = user_event_set_call_visible(user, false);
 
 	if (ret)
 		return ret;
@@ -1049,7 +1084,7 @@ static int user_event_trace_register(struct user_event *user)
 	if (!ret)
 		return -ENODEV;
 
-	ret = trace_add_event_call(&user->call);
+	ret = user_event_set_call_visible(user, true);
 
 	if (ret)
 		unregister_trace_event(&user->call.event);
-- 
2.35.1

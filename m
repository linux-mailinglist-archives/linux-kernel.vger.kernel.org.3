Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A074E3CAA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 11:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbiCVKno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 06:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbiCVKnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 06:43:41 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC87A80239
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 03:42:13 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id l7-20020a05600c1d0700b0038c99618859so1497099wms.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 03:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=vCQ8yvQZrq5DlVAWjFgARpvOjjNUPnfe4PnTinAQEg4=;
        b=OSq+o0I6V4hvpejOocVKh4QvbV7PukShyPEtAAfowSaUdbtPIE+DDmHXFr9MCKbCID
         f5swJriUB6SJnYMOOr9x7ilJzNHzbxkd7yoOeYPR5uI5ADkpAGWnchmWj6ozM63VjDux
         CP1f3oaPfFN6FA+gjOQf6pPb3WAic3QoS3H3mujxo+Q+GHDJP+nVM0iGwCfBwELdt7It
         K1c5j2f/PHj35YntxQBS+Z/C29OzupM5g33K7BTG6/w5NgFkZWddLKlCNgyAd36AjknK
         vXfAJaTZLyUkLeqZi/2waAqALHoPQsOflDauHnpN8I3K9uMMbHy/FNUWO1d1rMKI803k
         TBPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=vCQ8yvQZrq5DlVAWjFgARpvOjjNUPnfe4PnTinAQEg4=;
        b=bgB6XvPQhje0zrFOJRnmRsXhAPG1EUfWmVUhRzHuogEOIENpN5l+py/b0PNXvTZXFo
         OZVC7hrG6IIoUWj0u3/a7ypiZV8AnuSiz58WtMKpO6Ig4xtRo5W9KOXRYwrKikz4PxsM
         0UUla+z+oNYucnNI+fhfnJ/RV0GkDvi5/C0aOAY+2qpjWaePHVLAYAm6yYES1VoEE+9r
         PYQedOP8+7w8+BEwxja5T513PpRdzi8wHNzf2/OQIeI0SFXzAmo9GRSRE9MPQL3Ky9rx
         IL/wPNAhUgmoPYdKsifWxCCh5TBT4FOnh2KHjPcG0lIZyjo+5SvW4MLXUDsQCd5McBHN
         /hww==
X-Gm-Message-State: AOAM533PYIien/MUdTVAGKH7g2d+F1qBzFlDziEGMV9lgq25Dq5ht4A0
        5uxh+la4/sDLh5obVb5DM6SKaQ==
X-Google-Smtp-Source: ABdhPJzBs9zqbxV4VovtzRunQCoQQapJqNzsmcJBCU0RZJ/hPmh0128AGwMJWw+sRlqnT96Om2IoMQ==
X-Received: by 2002:a5d:5504:0:b0:203:e3be:518b with SMTP id b4-20020a5d5504000000b00203e3be518bmr21741803wrv.462.1647945732046;
        Tue, 22 Mar 2022 03:42:12 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:3aa9:ba1f:ba59:87ba])
        by smtp.gmail.com with ESMTPSA id q14-20020a1cf30e000000b0038986a18ec8sm1584774wmq.46.2022.03.22.03.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 03:42:11 -0700 (PDT)
Date:   Tue, 22 Mar 2022 11:42:06 +0100
From:   Marco Elver <elver@google.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: RFC: Use of user space handler vs. SIG_DFL on forced signals
Message-ID: <Yjmn/kVblV3TdoAq@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.1.4 (2021-12-11)
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Currently force_sig_info_to_task() will always unblock a blocked signal
but deliver the signal to SIG_DFL:

	[...]
	 * Note: If we unblock the signal, we always reset it to SIG_DFL,
	 * since we do not want to have a signal handler that was blocked
	 * be invoked when user space had explicitly blocked it.
	[...]

Is this requirement part of the POSIX spec? Or is the intent simply to
attempt to do the least-bad thing?

The reason I'm asking is that we've encountered rare crashes with the
new SIGTRAP on perf events, due to patterns like this:

	<set up SIGTRAP on a perf event>
	...
	sigset_t s;
	sigemptyset(&s);
	sigaddset(&s, SIGTRAP | <and others>);
	sigprocmask(SIG_BLOCK, &s, ...);
	...
	<perf event triggers>

When the perf event triggers, while SIGTRAP is blocked, force_sig_perf()
will force the signal, but revert back to the default handler, thus
terminating the task.

For other types of signals, is the assumption here that if user space
blocked the signal, it might not be able to handle it in the first
place?

For SIGTRAP on perf events we found this makes the situation worse,
since the cause of the signal wasn't an error condition, but explicitly
requested monitoring. In this case, we do in fact want delivery of the
signal to user space even if the signal is blocked, i.e.
force_sig_perf() should be an unblockable forced synchronous signal to
user space!

If there is no good reason to choose SIG_DFL, our preference would be to
allow this kind of "unblockable forced" signal to the user space handler
for force_sig_perf() -- with the caveat whoever requests SIGTRAP on perf
events must be able to provide a handler that can always run safely. But
we think that's better than crashing.

The below patch would do what we want, but would like to first confirm
if this is "within spec".

Thoughts?

Thanks,
-- Marco

------ >8 ------

From: Marco Elver <elver@google.com>
Date: Mon, 21 Mar 2022 22:18:09 +0100
Subject: [PATCH RFC] signal: Always unblock signal to user space for
 force_sig_perf()

With SIGTRAP on perf events, we have encountered termination of
processes due to user space attempting to block delivery of SIGTRAP.
Consider this case:

	<set up SIGTRAP on a perf event>
	...
	sigset_t s;
	sigemptyset(&s);
	sigaddset(&s, SIGTRAP | <and others>);
	sigprocmask(SIG_BLOCK, &s, ...);
	...
	<perf event triggers>

When the perf event triggers, while SIGTRAP is blocked, force_sig_perf()
will force the signal, but revert back to the default handler, thus
terminating the task.

With forced signals, the whole premise of sigprocmask() is invalidated
since the signal is still delivered, only to the default signal handler.
The assumption here is that if user space blocked the signal, it might
not be able to handle it in the first place.

However, for SIGTRAP on perf events we found this makes the situation
worse, since the cause of the signal wasn't an error condition, but
explicitly requested monitoring. In this case, we do in fact want
delivery of the signal to user space even if the signal is blocked, i.e.
force_sig_perf() should be an unblockable forced synchronous signal to
user space.

Fixes: 97ba62b27867 ("perf: Add support for SIGTRAP on perf events")
Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/signal.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 38602738866e..04b7a178a5f3 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1303,6 +1303,7 @@ int do_send_sig_info(int sig, struct kernel_siginfo *info, struct task_struct *p
 
 enum sig_handler {
 	HANDLER_CURRENT, /* If reachable use the current handler */
+	HANDLER_UNBLOCK, /* Use the current handler even if blocked */
 	HANDLER_SIG_DFL, /* Always use SIG_DFL handler semantics */
 	HANDLER_EXIT,	 /* Only visible as the process exit code */
 };
@@ -1311,9 +1312,11 @@ enum sig_handler {
  * Force a signal that the process can't ignore: if necessary
  * we unblock the signal and change any SIG_IGN to SIG_DFL.
  *
- * Note: If we unblock the signal, we always reset it to SIG_DFL,
- * since we do not want to have a signal handler that was blocked
- * be invoked when user space had explicitly blocked it.
+ * Note: If we unblock the signal and handler != HANDLER_UNBLOCK, we always
+ * reset it to SIG_DFL, since we do not want to have a signal handler that was
+ * blocked be invoked when user space had explicitly blocked it. If handler is
+ * HANDLER_UNBLOCK, user space will always receive the signal and is expected to
+ * provide a handler that is safe in all contexts.
  *
  * We don't want to have recursive SIGSEGV's etc, for example,
  * that is why we also clear SIGNAL_UNKILLABLE.
@@ -1332,7 +1335,8 @@ force_sig_info_to_task(struct kernel_siginfo *info, struct task_struct *t,
 	ignored = action->sa.sa_handler == SIG_IGN;
 	blocked = sigismember(&t->blocked, sig);
 	if (blocked || ignored || (handler != HANDLER_CURRENT)) {
-		action->sa.sa_handler = SIG_DFL;
+		if (handler != HANDLER_UNBLOCK)
+			action->sa.sa_handler = SIG_DFL;
 		if (handler == HANDLER_EXIT)
 			action->sa.sa_flags |= SA_IMMUTABLE;
 		if (blocked) {
@@ -1816,7 +1820,11 @@ int force_sig_perf(void __user *addr, u32 type, u64 sig_data)
 	info.si_perf_data = sig_data;
 	info.si_perf_type = type;
 
-	return force_sig_info(&info);
+	/*
+	 * Delivering SIGTRAP on perf events must unblock delivery to not
+	 * kill the task, but attempt delivery to the user space handler.
+	 */
+	return force_sig_info_to_task(&info, current, HANDLER_UNBLOCK);
 }
 
 /**
-- 
2.35.1.894.gb6a874cedc-goog


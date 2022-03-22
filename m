Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 113ED4E425F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 15:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237838AbiCVO4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 10:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237042AbiCVO4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 10:56:15 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92FDC85BEE;
        Tue, 22 Mar 2022 07:54:46 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:39214)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nWfuG-001v8O-IA; Tue, 22 Mar 2022 08:54:44 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:38948 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nWfuE-00C5OZ-Bk; Tue, 22 Mar 2022 08:54:44 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Marco Elver <elver@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <Yjmn/kVblV3TdoAq@elver.google.com>
Date:   Tue, 22 Mar 2022 09:54:20 -0500
In-Reply-To: <Yjmn/kVblV3TdoAq@elver.google.com> (Marco Elver's message of
        "Tue, 22 Mar 2022 11:42:06 +0100")
Message-ID: <87ee2uyr4z.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nWfuE-00C5OZ-Bk;;;mid=<87ee2uyr4z.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/Zf+DS0aeIFuu5GoMzm1PpJfqurEDGiuY=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Marco Elver <elver@google.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1603 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 10 (0.6%), b_tie_ro: 8 (0.5%), parse: 1.11 (0.1%),
         extract_message_metadata: 6 (0.4%), get_uri_detail_list: 3.8 (0.2%),
        tests_pri_-1000: 3.6 (0.2%), tests_pri_-950: 1.20 (0.1%),
        tests_pri_-900: 0.96 (0.1%), tests_pri_-90: 132 (8.2%), check_bayes:
        131 (8.1%), b_tokenize: 13 (0.8%), b_tok_get_all: 11 (0.7%),
        b_comp_prob: 3.3 (0.2%), b_tok_touch_all: 99 (6.2%), b_finish: 0.86
        (0.1%), tests_pri_0: 1433 (89.4%), check_dkim_signature: 0.61 (0.0%),
        check_dkim_adsp: 3.1 (0.2%), poll_dns_idle: 1.08 (0.1%), tests_pri_10:
        1.95 (0.1%), tests_pri_500: 6 (0.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: RFC: Use of user space handler vs. SIG_DFL on forced signals
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marco Elver <elver@google.com> writes:

> Hello,
>
> Currently force_sig_info_to_task() will always unblock a blocked signal
> but deliver the signal to SIG_DFL:
>
> 	[...]
> 	 * Note: If we unblock the signal, we always reset it to SIG_DFL,
> 	 * since we do not want to have a signal handler that was blocked
> 	 * be invoked when user space had explicitly blocked it.
> 	[...]
>
> Is this requirement part of the POSIX spec? Or is the intent simply to
> attempt to do the least-bad thing?

I have not found any POSIX language about this.

The options are either we terminate the application, or the application
spins forever re-triggering the trap.


> The reason I'm asking is that we've encountered rare crashes with the
> new SIGTRAP on perf events, due to patterns like this:
>
> 	<set up SIGTRAP on a perf event>
> 	...
> 	sigset_t s;
> 	sigemptyset(&s);
> 	sigaddset(&s, SIGTRAP | <and others>);
> 	sigprocmask(SIG_BLOCK, &s, ...);
> 	...
> 	<perf event triggers>
>
> When the perf event triggers, while SIGTRAP is blocked, force_sig_perf()
> will force the signal, but revert back to the default handler, thus
> terminating the task.
>
> For other types of signals, is the assumption here that if user space
> blocked the signal, it might not be able to handle it in the first
> place?

The assumption is that the signals are synchronous and it is the
actions of userspace that trigger the trap.

> For SIGTRAP on perf events we found this makes the situation worse,
> since the cause of the signal wasn't an error condition, but explicitly
> requested monitoring. In this case, we do in fact want delivery of the
> signal to user space even if the signal is blocked, i.e.
> force_sig_perf() should be an unblockable forced synchronous signal to
> user space!

Which is exactly what we have.  If you block it you get terminated.

> If there is no good reason to choose SIG_DFL, our preference would be to
> allow this kind of "unblockable forced" signal to the user space handler
> for force_sig_perf() -- with the caveat whoever requests SIGTRAP on perf
> events must be able to provide a handler that can always run safely. But
> we think that's better than crashing.

When the signal is blocked there is not user space signal handler.
There is nothing reasonable the kernel can do.


> The below patch would do what we want, but would like to first confirm
> if this is "within spec".
>
> Thoughts?

I think HANDLER_UNBLOCK is pretty much nonsense.

A block signal very much means that userspace is not prepared to handle
the signal.  So calling something that is not ready to be called can't
work.  That is common sense, and I expect in POSIX as well.

I expect that either you are looking for something like what ptrace does
with signal interruptions where another process is notified, and
userspace does not need to be involved, or that this is a don't do that
then.

Or possibly you have some weird asynchronous signal thing happening and
you are calling it synchronous.


Eric

>
> Thanks,
> -- Marco
>
> ------ >8 ------
>
> From: Marco Elver <elver@google.com>
> Date: Mon, 21 Mar 2022 22:18:09 +0100
> Subject: [PATCH RFC] signal: Always unblock signal to user space for
>  force_sig_perf()
>
> With SIGTRAP on perf events, we have encountered termination of
> processes due to user space attempting to block delivery of SIGTRAP.
> Consider this case:
>
> 	<set up SIGTRAP on a perf event>
> 	...
> 	sigset_t s;
> 	sigemptyset(&s);
> 	sigaddset(&s, SIGTRAP | <and others>);
> 	sigprocmask(SIG_BLOCK, &s, ...);
> 	...
> 	<perf event triggers>
>
> When the perf event triggers, while SIGTRAP is blocked, force_sig_perf()
> will force the signal, but revert back to the default handler, thus
> terminating the task.
>
> With forced signals, the whole premise of sigprocmask() is invalidated
> since the signal is still delivered, only to the default signal handler.
> The assumption here is that if user space blocked the signal, it might
> not be able to handle it in the first place.
>
> However, for SIGTRAP on perf events we found this makes the situation
> worse, since the cause of the signal wasn't an error condition, but
> explicitly requested monitoring. In this case, we do in fact want
> delivery of the signal to user space even if the signal is blocked, i.e.
> force_sig_perf() should be an unblockable forced synchronous signal to
> user space.
>
> Fixes: 97ba62b27867 ("perf: Add support for SIGTRAP on perf events")
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>  kernel/signal.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 38602738866e..04b7a178a5f3 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -1303,6 +1303,7 @@ int do_send_sig_info(int sig, struct kernel_siginfo *info, struct task_struct *p
>  
>  enum sig_handler {
>  	HANDLER_CURRENT, /* If reachable use the current handler */
> +	HANDLER_UNBLOCK, /* Use the current handler even if blocked */
>  	HANDLER_SIG_DFL, /* Always use SIG_DFL handler semantics */
>  	HANDLER_EXIT,	 /* Only visible as the process exit code */
>  };
> @@ -1311,9 +1312,11 @@ enum sig_handler {
>   * Force a signal that the process can't ignore: if necessary
>   * we unblock the signal and change any SIG_IGN to SIG_DFL.
>   *
> - * Note: If we unblock the signal, we always reset it to SIG_DFL,
> - * since we do not want to have a signal handler that was blocked
> - * be invoked when user space had explicitly blocked it.
> + * Note: If we unblock the signal and handler != HANDLER_UNBLOCK, we always
> + * reset it to SIG_DFL, since we do not want to have a signal handler that was
> + * blocked be invoked when user space had explicitly blocked it. If handler is
> + * HANDLER_UNBLOCK, user space will always receive the signal and is expected to
> + * provide a handler that is safe in all contexts.
>   *
>   * We don't want to have recursive SIGSEGV's etc, for example,
>   * that is why we also clear SIGNAL_UNKILLABLE.
> @@ -1332,7 +1335,8 @@ force_sig_info_to_task(struct kernel_siginfo *info, struct task_struct *t,
>  	ignored = action->sa.sa_handler == SIG_IGN;
>  	blocked = sigismember(&t->blocked, sig);
>  	if (blocked || ignored || (handler != HANDLER_CURRENT)) {
> -		action->sa.sa_handler = SIG_DFL;
> +		if (handler != HANDLER_UNBLOCK)
> +			action->sa.sa_handler = SIG_DFL;
>  		if (handler == HANDLER_EXIT)
>  			action->sa.sa_flags |= SA_IMMUTABLE;
>  		if (blocked) {
> @@ -1816,7 +1820,11 @@ int force_sig_perf(void __user *addr, u32 type, u64 sig_data)
>  	info.si_perf_data = sig_data;
>  	info.si_perf_type = type;
>  
> -	return force_sig_info(&info);
> +	/*
> +	 * Delivering SIGTRAP on perf events must unblock delivery to not
> +	 * kill the task, but attempt delivery to the user space handler.
> +	 */
> +	return force_sig_info_to_task(&info, current, HANDLER_UNBLOCK);
>  }
>  
>  /**

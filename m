Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 112464B6731
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 10:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235731AbiBOJOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 04:14:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235708AbiBOJOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 04:14:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2951725EA6;
        Tue, 15 Feb 2022 01:14:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B389F616BC;
        Tue, 15 Feb 2022 09:14:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AED21C340EC;
        Tue, 15 Feb 2022 09:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644916446;
        bh=As0zp7KHDdXIFqtOLNpY8KtgPS637bO4Rg8goRTcRaQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MRUpR31BlYi7HvFIep1lZbT6vtfYoy8OvEcqaM0UAN2Fy8YZb7mLZAsN8nz/09WCv
         xJC4WJUfm6LAMbsgKyASgJEyp6RKbbSqjUS0f3P342s23YlrfygrxpZb7zJcNosfVU
         HO7WpLA65QE61OnVLDr0lIZ/r3s10WKiiwoBtpvV0d7HEhLosyZ4CzB+CY/wj9pHro
         NDPXUiaLaREJuy2rdmM4Dvlk0R0qasdAobAMdUXmSkEbu7qhwPNR8n/ys1KMrB9tKP
         +EJHB0LzZWcUxk7l0kt4crbzEnCFaRjmk4AHQIsW0qDp2PaMxxJR7qr3H+YxVfWFbt
         yDsGSxAvMyOKQ==
Date:   Tue, 15 Feb 2022 10:14:00 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Robert =?utf-8?B?xZp3acSZY2tp?= <robert@swiecki.net>,
        Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-api@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/2] exit: Introduce __WCHILDSIGINFO for waitid
Message-ID: <20220215091400.m4koiz4qqhgctnlx@wittgenstein>
References: <20220214213823.3297816-1-keescook@chromium.org>
 <20220214213823.3297816-2-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220214213823.3297816-2-keescook@chromium.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 01:38:22PM -0800, Kees Cook wrote:
> When __WCHILDSIGINFO is specified, copy the child's siginfo into the
> waitid infop instead of constructing the parent's SIGCHLD perspective.
> 
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: "Eric W. Biederman" <ebiederm@xmission.com>
> Cc: Andy Lutomirski <luto@amacapital.net>
> Cc: "Robert Święcki" <robert@swiecki.net>
> Cc: Jann Horn <jannh@google.com>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-api@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/linux/sched.h     |  1 +
>  include/uapi/linux/wait.h |  1 +
>  kernel/exit.c             | 23 +++++++++++++++++++----
>  kernel/signal.c           |  4 ++++
>  4 files changed, 25 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index f5b2be39a78c..e40789e801ef 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1178,6 +1178,7 @@ struct task_struct {
>  #endif
>  	/* Ptrace state: */
>  	unsigned long			ptrace_message;
> +	kernel_siginfo_t		death_siginfo;
>  	kernel_siginfo_t		*last_siginfo;
>  
>  	struct task_io_accounting	ioac;
> diff --git a/include/uapi/linux/wait.h b/include/uapi/linux/wait.h
> index 85b809fc9f11..7258cd4510ba 100644
> --- a/include/uapi/linux/wait.h
> +++ b/include/uapi/linux/wait.h
> @@ -9,6 +9,7 @@
>  #define WCONTINUED	0x00000008
>  #define WNOWAIT		0x01000000	/* Don't reap, just poll status.  */
>  
> +#define __WCHILDSIGINFO	0x10000000	/* Report child's siginfo. */
>  #define __WNOTHREAD	0x20000000	/* Don't wait on children of other threads in this group */
>  #define __WALL		0x40000000	/* Wait on all children, regardless of type */
>  #define __WCLONE	0x80000000	/* Wait only on non-SIGCHLD children */
> diff --git a/kernel/exit.c b/kernel/exit.c
> index b00a25bb4ab9..de6e024976c6 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -953,6 +953,7 @@ struct waitid_info {
>  	uid_t uid;
>  	int status;
>  	int cause;
> +	kernel_siginfo_t siginfo;

Heh, I once got yelled at because I put siginfo in there... :)
If this time it's acceptable it might be worth considering replacing
some of the duplicated fields if possible. But again, on a suboptimal
device because of vacation.

>  };
>  
>  struct wait_opts {
> @@ -964,7 +965,7 @@ struct wait_opts {
>  	int			wo_stat;
>  	struct rusage		*wo_rusage;
>  
> -	wait_queue_entry_t		child_wait;
> +	wait_queue_entry_t	child_wait;
>  	int			notask_error;
>  };
>  
> @@ -1012,11 +1013,16 @@ static int wait_task_zombie(struct wait_opts *wo, struct task_struct *p)
>  	int state, status;
>  	pid_t pid = task_pid_vnr(p);
>  	uid_t uid = from_kuid_munged(current_user_ns(), task_uid(p));
> -	struct waitid_info *infop;
> +	struct waitid_info *infop = wo->wo_info;
>  
>  	if (!likely(wo->wo_flags & WEXITED))
>  		return 0;
>  
> +	/* Before WNOWAIT so a copy can be extracted without reaping. */
> +	if (unlikely(wo->wo_flags & __WCHILDSIGINFO)) {
> +		if (infop && p->last_siginfo)
> +			copy_siginfo(&infop->siginfo, p->last_siginfo);
> +	}
>  	if (unlikely(wo->wo_flags & WNOWAIT)) {
>  		status = (p->signal->flags & SIGNAL_GROUP_EXIT)
>  			? p->signal->group_exit_code : p->exit_code;
> @@ -1121,7 +1127,6 @@ static int wait_task_zombie(struct wait_opts *wo, struct task_struct *p)
>  		release_task(p);
>  
>  out_info:
> -	infop = wo->wo_info;
>  	if (infop) {
>  		if ((status & 0x7f) == 0) {
>  			infop->cause = CLD_EXITED;
> @@ -1564,7 +1569,7 @@ static long kernel_waitid(int which, pid_t upid, struct waitid_info *infop,
>  	unsigned int f_flags = 0;
>  
>  	if (options & ~(WNOHANG|WNOWAIT|WEXITED|WSTOPPED|WCONTINUED|
> -			__WNOTHREAD|__WCLONE|__WALL))
> +			__WNOTHREAD|__WCLONE|__WALL|__WCHILDSIGINFO))
>  		return -EINVAL;
>  	if (!(options & (WEXITED|WSTOPPED|WCONTINUED)))
>  		return -EINVAL;
> @@ -1637,6 +1642,10 @@ SYSCALL_DEFINE5(waitid, int, which, pid_t, upid, struct siginfo __user *,
>  	if (!infop)
>  		return err;
>  
> +	/* __WCHILDSIGINFO */
> +	if (info.siginfo.si_signo)
> +		return copy_siginfo_to_user(infop, &info.siginfo);
> +
>  	if (!user_write_access_begin(infop, sizeof(*infop)))
>  		return -EFAULT;
>  
> @@ -1780,6 +1789,12 @@ COMPAT_SYSCALL_DEFINE5(waitid,
>  	if (!infop)
>  		return err;
>  
> +	/* __WCHILDSIGINFO */
> +	if (info.siginfo.si_signo)
> +		return copy_siginfo_to_user32(
> +				(struct compat_siginfo __user *)infop,
> +				&info.siginfo);
> +

Just to repeat what I said in the earlier thread: if I'm not misreading
this - I have to do this on a suboptimal device because of vacation -
then there's a behavioral change for what fields are initialized and
what additional fields (if any) are zeroed between a __WCHILDSIGINFO
request and a regular waitid() request. I'm a) not sure we want this and
b) we should document it.

>  	if (!user_write_access_begin(infop, sizeof(*infop)))
>  		return -EFAULT;
>  
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 9b04631acde8..41f6ba6b7aa7 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -2825,6 +2825,10 @@ bool get_signal(struct ksignal *ksig)
>  		}
>  
>  	fatal:
> +		/* Allow siginfo to be queried until reaped. */
> +		copy_siginfo(&current->death_siginfo, &ksig->info);
> +		current->last_siginfo = &current->death_siginfo;
> +
>  		spin_unlock_irq(&sighand->siglock);
>  		if (unlikely(cgroup_task_frozen(current)))
>  			cgroup_leave_frozen(true);
> -- 
> 2.30.2
> 

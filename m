Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E1A4D40F3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 06:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239660AbiCJF61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 00:58:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233894AbiCJF6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 00:58:24 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 310803151B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 21:57:24 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id fs4-20020a17090af28400b001bf5624c0aaso4357784pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 21:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YyCSyvaI79j6MhoptvVsWzu+7v+0iJfI/RRUXJN7JVo=;
        b=oeDHnH+n6R5CdcWgUPVt4kqC3U9cfddUrrm5psXKsuxojbfa8sCJoDBz8fvBUzAI3x
         bbo+ybc34veSlU8xXsaukw8srmOWHl7LEDq2+RjDbe/coLjtAxJQUpyQCsTvUcilbzVs
         F212nyR0rwaSJCdxkAlrYJUTyqqCLSKYBCJ9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YyCSyvaI79j6MhoptvVsWzu+7v+0iJfI/RRUXJN7JVo=;
        b=xrl2fmHGg8YVSiSwiGYeLP936TbPoocQcpBTJtkB4/s9XZz8pNhxw1cyr6zbkWEIFT
         /yoncLICoqDTOBFY5ii2E6Q82Ss+WqvqClj455Zoh8hsA0aDCx97QRfdyiG/b36cKj0q
         ogTRm0UKpnd91ILWw1AOEb0G6oE09Hmw5CjIro+a5JXf6YKZe7udmSVpYVajP6+iKej4
         QnLeSrOXTqhw+5/OeDDKx+IlN7FVPFAo8Y0E7eeZzWzdBCf2jru4jEPWcJZqpOgmgLtO
         SZGzzt2FiBfGKuHovHVpb6gJGJ+Y5mdr6LN+WaHTW19V3wQjS9q3JEQ0S1/fqS9lbteo
         CLjw==
X-Gm-Message-State: AOAM531FE8oppHGroCWBBKhsMERHj2LGSvdudeLZS/GesH/bY69l+kcR
        /4GkOAcuCIqYlq7S3xWtheJV7Q==
X-Google-Smtp-Source: ABdhPJyXZNcyqCCkc7TQJg3ftdPL5bfGOWCEK0xoGNMN6l2zez+gJvsG42e08VE9vksbz6MJhbQDRw==
X-Received: by 2002:a17:902:e890:b0:151:e9c1:6386 with SMTP id w16-20020a170902e89000b00151e9c16386mr3274666plg.40.1646891843593;
        Wed, 09 Mar 2022 21:57:23 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id gb5-20020a17090b060500b001bd312f7396sm4574074pjb.45.2022.03.09.21.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 21:57:23 -0800 (PST)
Date:   Wed, 9 Mar 2022 21:57:22 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 08/13] task_work: Call tracehook_notify_signal from
 get_signal on all architectures
Message-ID: <202203091455.D4ED8650@keescook>
References: <87o82gdlu9.fsf_-_@email.froward.int.ebiederm.org>
 <20220309162454.123006-8-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309162454.123006-8-ebiederm@xmission.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 10:24:49AM -0600, Eric W. Biederman wrote:
> Always handle TIF_NOTIFY_SIGNAL in get_signal.  With commit 35d0b389f3b2
> ("task_work: unconditionally run task_work from get_signal()") always
> calling task_wofffffffrk_run all of the work of tracehook_notify_signal is

typo: cat on keyboard

> already happening except clearing TIF_NOTIFY_SIGNAL.
> 
> Factor clear_notify_signal out of tracehook_notify_signal and use it in
> get_signal so that get_signal only needs one call of trask_work_run.

typo: trask -> task

> 
> To keep the semantics in sync update xfer_to_guest_mode_work (which
> does not call get_signal) to call tracehook_notify_signal if either
> _TIF_SIGPENDING or _TIF_NOTIFY_SIGNAL.

I see three logical changes in this patch, I think?

- creation and use of clear_notify_signal()
- removal of handle_signal_work() and removal of
  arch_do_signal_or_restart() has_signal arg
- something with get_signal() I don't understand yet:
  - why is clear_notify_signal() added?
  - why is tracehook_notify_signal() removed?

> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  arch/s390/kernel/signal.c    |  4 ++--
>  arch/x86/kernel/signal.c     |  4 ++--
>  include/linux/entry-common.h |  2 +-
>  include/linux/tracehook.h    |  9 +++++++--
>  kernel/entry/common.c        | 12 ++----------
>  kernel/entry/kvm.c           |  2 +-
>  kernel/signal.c              | 14 +++-----------
>  7 files changed, 18 insertions(+), 29 deletions(-)
> 
> diff --git a/arch/s390/kernel/signal.c b/arch/s390/kernel/signal.c
> index 307f5d99514d..ea9e5e8182cd 100644
> --- a/arch/s390/kernel/signal.c
> +++ b/arch/s390/kernel/signal.c
> @@ -453,7 +453,7 @@ static void handle_signal(struct ksignal *ksig, sigset_t *oldset,
>   * stack-frames in one go after that.
>   */
>  
> -void arch_do_signal_or_restart(struct pt_regs *regs, bool has_signal)
> +void arch_do_signal_or_restart(struct pt_regs *regs)
>  {
>  	struct ksignal ksig;
>  	sigset_t *oldset = sigmask_to_save();
> @@ -466,7 +466,7 @@ void arch_do_signal_or_restart(struct pt_regs *regs, bool has_signal)
>  	current->thread.system_call =
>  		test_pt_regs_flag(regs, PIF_SYSCALL) ? regs->int_code : 0;
>  
> -	if (has_signal && get_signal(&ksig)) {

Right, the only caller of arch_do_signal_or_restart(),
handle_signal_work(), only happens after its caller has already checked
_TIF_SIGPENDING.

> +	if (get_signal(&ksig)) {
>  		/* Whee!  Actually deliver the signal.  */
>  		if (current->thread.system_call) {
>  			regs->int_code = current->thread.system_call;
> diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
> index ec71e06ae364..de3d5b5724d8 100644
> --- a/arch/x86/kernel/signal.c
> +++ b/arch/x86/kernel/signal.c
> @@ -861,11 +861,11 @@ static inline unsigned long get_nr_restart_syscall(const struct pt_regs *regs)
>   * want to handle. Thus you cannot kill init even with a SIGKILL even by
>   * mistake.
>   */
> -void arch_do_signal_or_restart(struct pt_regs *regs, bool has_signal)
> +void arch_do_signal_or_restart(struct pt_regs *regs)
>  {
>  	struct ksignal ksig;
>  
> -	if (has_signal && get_signal(&ksig)) {
> +	if (get_signal(&ksig)) {
>  		/* Whee! Actually deliver the signal.  */
>  		handle_signal(&ksig, regs);
>  		return;
> diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
> index 9efbdda61f7a..3537fd25f14e 100644
> --- a/include/linux/entry-common.h
> +++ b/include/linux/entry-common.h
> @@ -257,7 +257,7 @@ static __always_inline void arch_exit_to_user_mode(void) { }
>   *
>   * Invoked from exit_to_user_mode_loop().
>   */
> -void arch_do_signal_or_restart(struct pt_regs *regs, bool has_signal);
> +void arch_do_signal_or_restart(struct pt_regs *regs);
>  
>  /**
>   * exit_to_user_mode - Fixup state when exiting to user mode
> diff --git a/include/linux/tracehook.h b/include/linux/tracehook.h
> index fa834a22e86e..b44a7820c468 100644
> --- a/include/linux/tracehook.h
> +++ b/include/linux/tracehook.h
> @@ -106,6 +106,12 @@ static inline void tracehook_notify_resume(struct pt_regs *regs)
>  	rseq_handle_notify_resume(NULL, regs);
>  }
>  
> +static inline void clear_notify_signal(void)
> +{
> +	clear_thread_flag(TIF_NOTIFY_SIGNAL);
> +	smp_mb__after_atomic();
> +}
> +
>  /*
>   * called by exit_to_user_mode_loop() if ti_work & _TIF_NOTIFY_SIGNAL. This
>   * is currently used by TWA_SIGNAL based task_work, which requires breaking
> @@ -113,8 +119,7 @@ static inline void tracehook_notify_resume(struct pt_regs *regs)
>   */
>  static inline void tracehook_notify_signal(void)
>  {
> -	clear_thread_flag(TIF_NOTIFY_SIGNAL);
> -	smp_mb__after_atomic();
> +	clear_notify_signal();
>  	if (task_work_pending(current))
>  		task_work_run();
>  }
> diff --git a/kernel/entry/common.c b/kernel/entry/common.c
> index f0b1daa1e8da..79eaf9b4b10d 100644
> --- a/kernel/entry/common.c
> +++ b/kernel/entry/common.c
> @@ -139,15 +139,7 @@ void noinstr exit_to_user_mode(void)
>  }
>  
>  /* Workaround to allow gradual conversion of architecture code */
> -void __weak arch_do_signal_or_restart(struct pt_regs *regs, bool has_signal) { }
> -
> -static void handle_signal_work(struct pt_regs *regs, unsigned long ti_work)
> -{
> -	if (ti_work & _TIF_NOTIFY_SIGNAL)
> -		tracehook_notify_signal();
> -
> -	arch_do_signal_or_restart(regs, ti_work & _TIF_SIGPENDING);
> -}
> +void __weak arch_do_signal_or_restart(struct pt_regs *regs) { }
>  
>  static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
>  					    unsigned long ti_work)
> @@ -170,7 +162,7 @@ static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
>  			klp_update_patch_state(current);
>  
>  		if (ti_work & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL))
> -			handle_signal_work(regs, ti_work);
> +			arch_do_signal_or_restart(regs);
>  
>  		if (ti_work & _TIF_NOTIFY_RESUME)
>  			tracehook_notify_resume(regs);
> diff --git a/kernel/entry/kvm.c b/kernel/entry/kvm.c
> index 96d476e06c77..cabf36a489e4 100644
> --- a/kernel/entry/kvm.c
> +++ b/kernel/entry/kvm.c
> @@ -8,7 +8,7 @@ static int xfer_to_guest_mode_work(struct kvm_vcpu *vcpu, unsigned long ti_work)
>  	do {
>  		int ret;
>  
> -		if (ti_work & _TIF_NOTIFY_SIGNAL)
> +		if (ti_work & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL))
>  			tracehook_notify_signal();
>  
>  		if (ti_work & _TIF_SIGPENDING) {
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 3b4cf25fb9b3..8632b88982c9 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -2626,20 +2626,12 @@ bool get_signal(struct ksignal *ksig)
>  	struct signal_struct *signal = current->signal;
>  	int signr;
>  
> +	clear_notify_signal();

Why is this added?

>  	if (unlikely(task_work_pending(current)))
>  		task_work_run();
>  
> -	/*
> -	 * For non-generic architectures, check for TIF_NOTIFY_SIGNAL so
> -	 * that the arch handlers don't all have to do it. If we get here
> -	 * without TIF_SIGPENDING, just exit after running signal work.
> -	 */
> -	if (!IS_ENABLED(CONFIG_GENERIC_ENTRY)) {
> -		if (test_thread_flag(TIF_NOTIFY_SIGNAL))
> -			tracehook_notify_signal();

I don't see why this gets removed?

> -		if (!task_sigpending(current))
> -			return false;
> -	}
> +	if (!task_sigpending(current))
> +		return false;
>  
>  	if (unlikely(uprobe_deny_signal()))
>  		return false;
> -- 
> 2.29.2
> 

-- 
Kees Cook

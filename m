Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B29094713B0
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 12:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbhLKLuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 06:50:17 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53810 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbhLKLuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 06:50:16 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639223415;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZXmVvWeVFr327aKuDnZsQAcpc7QhDSVmcSsZcSFgDPs=;
        b=iZmRJbGaVW7o47WayeqjS7VlT0VazPEds34xcquZLIuk27qDBDYgrpW0jCLdfzOkrl+FX2
        w2Zj1w6XvsdI7BejKTLOpAJdGeMg9T6/ZjgxTTnnkSPOHAQoxHsHAubWZoXzUwGn3hC/rb
        qsD54Hxzk3W5dIm6iccI4AQEmCZJK2tj3vfRV4X7lMMG6qGscsz54KQ4xuyM5/XWZyLLod
        xemZCWDp15ov5TRBl78auDjUsduwDtuViqPsmjdQhc3SjDs+texsTqzqaHFmdpxI5dztR6
        Uyp5RLaoQXzIfuV1/gmZMwD6XJguLJlA92Kd8+LbYSkOBXUTkIyL0CLhuUiNnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639223415;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZXmVvWeVFr327aKuDnZsQAcpc7QhDSVmcSsZcSFgDPs=;
        b=z/kIlfWeFwsaHzmhp+S6NBJIOR9tcKb5wXURwobItwKFhsgRINGieYNTWGZn9IKY8sicKD
        0yIHdiLJFUDWzPBg==
To:     Peter Collingbourne <pcc@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Mark Rutland <mark.rutland@arm.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Peter Collingbourne <pcc@google.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        David Hildenbrand <david@redhat.com>,
        Xiaofeng Cao <caoxiaofeng@yulong.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Thomas Cedeno <thomascedeno@google.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Evgenii Stepanov <eugenis@google.com>
Subject: Re: [PATCH v4 4/7] uaccess-buffer: add CONFIG_GENERIC_ENTRY support
In-Reply-To: <20211209221545.2333249-5-pcc@google.com>
References: <20211209221545.2333249-1-pcc@google.com>
 <20211209221545.2333249-5-pcc@google.com>
Date:   Sat, 11 Dec 2021 12:50:14 +0100
Message-ID: <87a6h7webt.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter,

On Thu, Dec 09 2021 at 14:15, Peter Collingbourne wrote:
> @@ -197,14 +201,19 @@ static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
>  static void exit_to_user_mode_prepare(struct pt_regs *regs)
>  {
>  	unsigned long ti_work = READ_ONCE(current_thread_info()->flags);
> +	bool uaccess_buffer_pending;
>  
>  	lockdep_assert_irqs_disabled();
>  
>  	/* Flush pending rcuog wakeup before the last need_resched() check */
>  	tick_nohz_user_enter_prepare();
>  
> -	if (unlikely(ti_work & EXIT_TO_USER_MODE_WORK))
> +	if (unlikely(ti_work & EXIT_TO_USER_MODE_WORK)) {
> +		bool uaccess_buffer_pending = uaccess_buffer_pre_exit_loop();
> +
>  		ti_work = exit_to_user_mode_loop(regs, ti_work);
> +		uaccess_buffer_post_exit_loop(uaccess_buffer_pending);

What? Let me look at the these two functions, which are so full of useful
comments:

> +bool __uaccess_buffer_pre_exit_loop(void)
> +{
> +	struct uaccess_buffer_info *buf = &current->uaccess_buffer;
> +	struct uaccess_descriptor __user *desc_ptr;
> +	sigset_t tmp_mask;
> +
> +	if (get_user(desc_ptr, buf->desc_ptr_ptr) || !desc_ptr)
> +		return false;
> +
> +	current->real_blocked = current->blocked;
> +	sigfillset(&tmp_mask);
> +	set_current_blocked(&tmp_mask);

This prevents signal delivery in exit_to_user_mode_loop(), right?

> +	return true;
> +}
> +
> +void __uaccess_buffer_post_exit_loop(void)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&current->sighand->siglock, flags);
> +	current->blocked = current->real_blocked;
> +	recalc_sigpending();

This restores the signal blocked mask _after_ exit_to_user_mode_loop()
has completed, recalculates pending signals and goes out to user space
with eventually pending signals.

How is this supposed to be even remotely correct?

But that aside, let me look at the whole picture as I understand it from
reverse engineering it. Yes, reverse engineering, because there are
neither comments in the code nor any useful information in the
changelogs of 2/7 and 4/7. Also the cover letter and the "documentation"
are not explaining any of this and just blurb about sanitizers and how
wonderful this all is.
 
> @@ -70,6 +71,9 @@ static long syscall_trace_enter(struct pt_regs *regs, long syscall,
>  			return ret;
>  	}
>  
> +	if (work & SYSCALL_WORK_UACCESS_BUFFER_ENTRY)
> +		uaccess_buffer_syscall_entry();

This conditionally sets SYSCALL_WORK_UACCESS_BUFFER_EXIT.

> @@ -247,6 +256,9 @@ static void syscall_exit_work(struct pt_regs *regs, unsigned long work)
>  
>  	audit_syscall_exit(regs);
>  
> +	if (work & SYSCALL_WORK_UACCESS_BUFFER_EXIT)
> +		uaccess_buffer_syscall_exit();

When returning from the syscall and SYSCALL_WORK_UACCESS_BUFFER_EXIT is
set, then uaccess_buffer_syscall_exit() clears
SYSCALL_WORK_UACCESS_BUFFER_EXIT, right?

This is called _before_ exit_to_user_mode_prepare(). So why is this
__uaccess_buffer_pre/post_exit_loop() required at all?

It's not required at all. Why?

Simply because there are only two ways how exit_to_user_mode_prepare()
can be reached:

  1) When returning from a syscall

  2) When returning from an interrupt which hit user mode execution

#1 SYSCALL_WORK_UACCESS_BUFFER_EXIT is cleared _before_
   exit_to_user_mode_prepare() is reached as documented above.

#2 SYSCALL_WORK_UACCESS_BUFFER_EXIT cannot be set because the entry
   to the kernel does not go through syscall_trace_enter().

So what is this pre/post exit loop code about? Handle something which
cannot happen in the first place?

If at all this would warrant a:

	if (WARN_ON_ONCE(test_syscall_work(UACCESS_BUFFER_ENTRY)))
        	do_something_sensible();

instead of adding undocumented voodoo w/o providing any rationale. Well,
I can see why that was not provided because there is no rationale to
begin with.

Seriously, I'm all for better instrumentation and analysis, but if the
code provided for that is incomprehensible, uncommented and
undocumented, then the result is worse than what we have now.

If you think that this qualifies as documentation:

> +/*
> + * uaccess_buffer_syscall_entry - hook to be run before syscall entry
> + */

> +/*
> + * uaccess_buffer_syscall_exit - hook to be run after syscall exit
> + */

> +/*
> + * uaccess_buffer_pre_exit_loop - hook to be run immediately before the
> + * pre-kernel-exit loop that handles signals, tracing etc. Returns a bool to
> + * be passed to uaccess_buffer_post_exit_loop.
> + */

> +/*
> + * uaccess_buffer_post_exit_loop - hook to be run immediately after the
> + * pre-kernel-exit loop that handles signals, tracing etc.
> + * @pending: the bool returned from uaccess_buffer_pre_exit_loop.
> + */

then we have a very differrent understanding of what documentation
should provide.

Thanks,

        tglx

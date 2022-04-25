Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE3750EC6A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 01:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235981AbiDYXJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 19:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbiDYXJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 19:09:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63AC724BC7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 16:06:30 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650927987;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZK23Bt5wj154AWZs7KDVnz4iebbQIn8YxS289Y9WEFk=;
        b=YiSqf9MQGgclWSTA2GFGaS0Q/rIxYx8PrrvxH7lYxF1qRjAc1KTDuiUcVFjF8skazskTgQ
        /X/jLlN4oA7cQQY15K7wKF3ClhHzh2O0uxgkeoCRKZuv4zlvMpwhhg4gggdKom/WxD9RUK
        JIZZZ6KsiKNNcu7vC/swLNdb+ysOBH8DE5S+tHUCT6fdlQHa8JJeQgnqc47Bs88NXdbaRm
        rKbjiYaYwBvgX1OO5faZybgnJfCDkLEQFmPAbZ0+4xMts6R/Pj6Hu5V1kG66xSptPZbzrM
        TYcYaa+rvUbxJWZFG8bqfaUCjA+0sEt7VqIx9lnYs3m3+gMjasiI5zPKb7fckg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650927987;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZK23Bt5wj154AWZs7KDVnz4iebbQIn8YxS289Y9WEFk=;
        b=0JgUp6WzFz0t9X2yPeqsTAf6lpnxQqfrDPVJpItKZKfwtugY/gh0AIbGgf25ajPBeDuudf
        DNwNy/10SPZ0VNAw==
To:     Marcelo Tosatti <mtosatti@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Oscar Shiang <oscar0225@livemail.tw>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [patch v12 05/13] task isolation: sync vmstats on return to
 userspace
In-Reply-To: <20220315153313.952151848@fedora.localdomain>
References: <20220315153132.717153751@fedora.localdomain>
 <20220315153313.952151848@fedora.localdomain>
Date:   Tue, 26 Apr 2022 01:06:27 +0200
Message-ID: <87wnfczrt8.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15 2022 at 12:31, Marcelo Tosatti wrote:
> The logic to disable vmstat worker thread, when entering
> nohz full, does not cover all scenarios. For example, it is possible
> for the following to happen:
>
> 1) enter nohz_full, which calls refresh_cpu_vm_stats, syncing the stats.
> 2) app runs mlock, which increases counters for mlock'ed pages.
> 3) start -RT loop
>
> Since refresh_cpu_vm_stats from nohz_full logic can happen _before_
> the mlock, vmstat shepherd can restart vmstat worker thread on
> the CPU in question.
>
> To fix this, use the task isolation prctl interface to quiesce 
> deferred actions when returning to userspace.
>
> This patch adds hooks to fork and exit code paths.

git grep 'This patch' Documentation/process/

> +void __task_isol_exit(struct task_struct *tsk);
> +static inline void task_isol_exit(struct task_struct *tsk)

I assume the amount of new lines per patch is restricted somehow, right?

Glueing the __task_isol_exit() declaration to the definition of
task_isol_exit() is just annoyingly disturbing the reading flow.

New lines exist for a reason.

> +{
> +	if (tsk->task_isol_info)
> +		__task_isol_exit(tsk);
> +}
>  #else

but ...

> +static inline void task_isol_exit_to_user_mode(void)
> +{
> +}
> +
>  static inline void task_isol_free(struct task_struct *tsk)
>  {
>  }
>  
> +static inline void task_isol_exit(struct task_struct *tsk)
> +{
> +}
> +

here you use plenty of them where it does not matter at all....
What's wrong with:

   static inline void task_isol_exit_to_user_mode(void) { }
   static inline void task_isol_free(struct task_struct *tsk) { }
   static inline void task_isol_exit(struct task_struct *tsk) { }

and spending at least one of the saved newlines for separating the
above:

+ void __task_isol_exit(struct task_struct *tsk);
+ 
+ static inline void task_isol_exit(struct task_struct *tsk)

Hmm?

> @@ -251,6 +257,11 @@ static int cfg_feat_quiesce_set(unsigned
>  	info->quiesce_mask = i_qctrl->quiesce_mask;
>  	info->oneshot_mask = i_qctrl->quiesce_oneshot_mask;
>  	info->conf_mask |= ISOL_F_QUIESCE;
> +
> +	if ((info->active_mask & ISOL_F_QUIESCE) &&
> +	    (info->quiesce_mask & ISOL_F_QUIESCE_VMSTATS))
> +		set_thread_flag(TIF_TASK_ISOL);

Yet more hard coded special purpose muck. Plus the proof of the
inconsistency I described before...

> +void task_isol_exit_to_user_mode(void)
> +{
> +	struct task_isol_info *i;

*i is really a descriptive variable name. Is this supposed to be
submitted to the convoluted C-code contest?

Dammit, we are not short of characters here and 'i' is generally used as
iterator variable which is hardly of type struct task_isol_info *.

> +	clear_thread_flag(TIF_TASK_ISOL);

What? See below....

> +	i = current->task_isol_info;
> +	if (!i)
> +		return;

That really makes sense. Why can a task which has TIF_TASK_ISOL set,
have current->task_isol_info != NULL?

I'm all for defensive programming, but if you really want to check this
then this should be:

	isol_info = current->task_isol_info;
	if (WARN_ON_ONCE(!isol_info))
		return;
No?

> +	if (i->active_mask != ISOL_F_QUIESCE)
> +		return;

Yay, more future proof hard coding!

> +	if (i->quiesce_mask & ISOL_F_QUIESCE_VMSTATS) {
> +		sync_vmstat();
> +		if (i->oneshot_mask & ISOL_F_QUIESCE_VMSTATS)
> +			i->quiesce_mask &= ~ISOL_F_QUIESCE_VMSTATS;

The point of this exercise is?

To clear quiesce_mask because this code path cannot be reached anymore
due to TIF_TASK_ISOL being cleared above.

Of course the active vs. no subfeature configured inconsistency is
preserved here for consistency reasons. At least something which is
consistent.

>  /**
>   * arch_check_user_regs - Architecture specific sanity check for user mode regs
> Index: linux-2.6/kernel/exit.c
> ===================================================================
> --- linux-2.6.orig/kernel/exit.c
> +++ linux-2.6/kernel/exit.c
> @@ -64,6 +64,7 @@
>  #include <linux/compat.h>
>  #include <linux/io_uring.h>
>  #include <linux/kprobes.h>
> +#include <linux/task_isolation.h>
>  
>  #include <linux/uaccess.h>
>  #include <asm/unistd.h>
> @@ -759,6 +760,7 @@ void __noreturn do_exit(long code)
>  	validate_creds_for_do_exit(tsk);
>  
>  	io_uring_files_cancel();
> +	task_isol_exit(tsk);

The purpose of this is?

> +static inline void task_isol_exit(struct task_struct *tsk)
> +{
> +	if (tsk->task_isol_info)
> +		__task_isol_exit(tsk);
> +}

and

>+ void __task_isol_exit(struct task_struct *tsk)
>+ {
>+ }

Makes a lot of sense and is thoroughly explained in the changelog and
comments....

Thanks,

        tglx

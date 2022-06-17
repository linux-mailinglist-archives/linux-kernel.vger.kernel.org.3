Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57D4054F5AB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 12:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381922AbiFQKlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 06:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381609AbiFQKlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 06:41:11 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0BE62CD8;
        Fri, 17 Jun 2022 03:41:08 -0700 (PDT)
Date:   Fri, 17 Jun 2022 18:42:07 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1655462466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ns96x6P4spEdZ9ZJ9BZJaUO6E6PokuaO9NVdJMSa6Ec=;
        b=GFyEMYZhbYALTIWmsIwkHhMnzW3dorFKvHWdQ6MRXkk+pOT+kC3Rv3iEryQFgrg3VVBFu/
        pQHQaYvzPk7ffmvp+ltYOTjopnG9aUJXuWR/AFOe3HrLRG32x8pEqGsiv52zMVy4XPS7R8
        Pmja/UKbQ2oN+pIHAPyVOq/rZ3/EVOw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Tao Zhou <tao.zhou@linux.dev>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-rt-users@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        Arnd Bergmann <arnd@arndb.de>, Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Juri Lelli <jlelli@redhat.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Tao Zhou <tao.zhou@linux.dev>
Subject: Re: [PATCH] panic, kexec: Don't mutex_trylock() in __crash_kexec()
Message-ID: <Yqxaf6V+hvCSXQSM@geo.homenetwork>
References: <20220616123709.347053-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616123709.347053-1-vschneid@redhat.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Valentin,

On Thu, Jun 16, 2022 at 01:37:09PM +0100, Valentin Schneider wrote:
> Attempting to get a crash dump out of a debug PREEMPT_RT kernel via an NMI
> panic() doesn't work. The cause of that lies in the PREEMPT_RT definition
> of mutex_trylock():
> 
> 	if (IS_ENABLED(CONFIG_DEBUG_RT_MUTEXES) && WARN_ON_ONCE(!in_task()))
> 		return 0;
> 
> This prevents an NMI panic() from executing the main body of
> __crash_kexec() which does the actual kexec into the kdump kernel.
> The warning and return are explained by:
> 
>   6ce47fd961fa ("rtmutex: Warn if trylock is called from hard/softirq context")
>   [...]
>   The reasons for this are:
> 
>       1) There is a potential deadlock in the slowpath
> 
>       2) Another cpu which blocks on the rtmutex will boost the task
> 	 which allegedly locked the rtmutex, but that cannot work
> 	 because the hard/softirq context borrows the task context.
> 
> Use a pair of barrier-ordered variables to serialize loading vs executing a
> crash kernel.
> 
> Tested by triggering NMI panics via:
> 
>   $ echo 1 > /proc/sys/kernel/panic_on_unrecovered_nmi
>   $ echo 1 > /proc/sys/kernel/unknown_nmi_panic
>   $ echo 1 > /proc/sys/kernel/panic
> 
>   $ ipmitool power diag
> 
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> ---
> Regarding the original explanation for the WARN & return:
> 
> I don't get why 2) is a problem - if the lock is acquired by the trylock
> then the critical section will be run without interruption since it
> cannot sleep, the interrupted task may get boosted but that will not
> have any actual impact AFAICT.
> Regardless, even if this doesn't sleep, the ->wait_lock in the slowpath
> isn't NMI safe so this needs changing.
> 
> I've thought about trying to defer the kexec out of an NMI (or IRQ)
> context, but that pretty much means deferring the panic() which I'm
> not sure is such a great idea.
> ---
>  include/linux/kexec.h |  2 ++
>  kernel/kexec.c        | 18 ++++++++++++++----
>  kernel/kexec_core.c   | 41 +++++++++++++++++++++++++----------------
>  kernel/kexec_file.c   | 14 ++++++++++++++
>  4 files changed, 55 insertions(+), 20 deletions(-)
> 
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index ce6536f1d269..89bbe150752e 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -369,6 +369,8 @@ extern int kimage_crash_copy_vmcoreinfo(struct kimage *image);
>  
>  extern struct kimage *kexec_image;
>  extern struct kimage *kexec_crash_image;
> +extern bool panic_wants_kexec;
> +extern bool kexec_loading;
>  extern int kexec_load_disabled;
>  
>  #ifndef kexec_flush_icache_page
> diff --git a/kernel/kexec.c b/kernel/kexec.c
> index b5e40f069768..1253f4bb3079 100644
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -94,14 +94,23 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
>  	/*
>  	 * Because we write directly to the reserved memory region when loading
>  	 * crash kernels we need a mutex here to prevent multiple crash kernels
> -	 * from attempting to load simultaneously, and to prevent a crash kernel
> -	 * from loading over the top of a in use crash kernel.
> -	 *
> -	 * KISS: always take the mutex.
> +	 * from attempting to load simultaneously.
>  	 */
>  	if (!mutex_trylock(&kexec_mutex))
>  		return -EBUSY;
>  
> +	/*
> +	 * Prevent loading a new crash kernel while one is in use.
> +	 *
> +	 * Pairs with smp_mb() in __crash_kexec().
> +	 */
> +	WRITE_ONCE(kexec_loading, true);
> +	smp_mb();
> +	if (READ_ONCE(panic_wants_kexec)) {
> +		ret = -EBUSY;
> +		goto out_unlock;
> +	}
> +
>  	if (flags & KEXEC_ON_CRASH) {
>  		dest_image = &kexec_crash_image;
>  		if (kexec_crash_image)
> @@ -165,6 +174,7 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
>  
>  	kimage_free(image);
>  out_unlock:
> +	WRITE_ONCE(kexec_loading, false);
>  	mutex_unlock(&kexec_mutex);
>  	return ret;
>  }
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index 4d34c78334ce..932cc0d4daa3 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -933,6 +933,8 @@ int kimage_load_segment(struct kimage *image,
>  
>  struct kimage *kexec_image;
>  struct kimage *kexec_crash_image;
> +bool panic_wants_kexec;
> +bool kexec_loading;
>  int kexec_load_disabled;
>  #ifdef CONFIG_SYSCTL
>  static struct ctl_table kexec_core_sysctls[] = {
> @@ -964,24 +966,31 @@ late_initcall(kexec_core_sysctl_init);
>   */
>  void __noclone __crash_kexec(struct pt_regs *regs)
>  {
> -	/* Take the kexec_mutex here to prevent sys_kexec_load
> -	 * running on one cpu from replacing the crash kernel
> -	 * we are using after a panic on a different cpu.
> +	/*
> +	 * This should be taking kexec_mutex before doing anything with the
> +	 * kexec_crash_image, but this code can be run in NMI context which
> +	 * means we can't even trylock.
>  	 *
> -	 * If the crash kernel was not located in a fixed area
> -	 * of memory the xchg(&kexec_crash_image) would be
> -	 * sufficient.  But since I reuse the memory...
> +	 * Pairs with smp_mb() in do_kexec_load() and sys_kexec_file_load()
>  	 */
> -	if (mutex_trylock(&kexec_mutex)) {
> -		if (kexec_crash_image) {
> -			struct pt_regs fixed_regs;
> -
> -			crash_setup_regs(&fixed_regs, regs);
> -			crash_save_vmcoreinfo();
> -			machine_crash_shutdown(&fixed_regs);
> -			machine_kexec(kexec_crash_image);
> -		}
> -		mutex_unlock(&kexec_mutex);
> +	WRITE_ONCE(panic_wants_kexec, true);
> +	smp_mb();
> +	/*
> +	 * If we're panic'ing while someone else is messing with the crash
> +	 * kernel, this isn't going to end well.
> +	 */
> +	if (READ_ONCE(kexec_loading)) {
> +		WRITE_ONCE(panic_wants_kexec, false);
> +		return;
> +	}

So this is from NMI. The mutex guarantee that kexec_file_load() or 
do_kexec_load() just one of them beat on cpu. NMI can happen on more
than one cpu. That means that here be cumulativity here IMHO.

kexec_file_load()/                 NMI0                     NMI1..
do_kexec_load()

set kexec_loading=true     
smp_mb()                set panic_wants_kexec=ture
                        smp_mb()
                        see kexec_loading=ture and
                          conditionally set
                          panic_wants_kexec=false;
                                                 set panic_wants_kexec=ture
                                                 smp_mb()
see panic_wants_kexec=ture
  conditionally set
  kexec_loading=false
                                                 see kexec_loading=false
                                                 do kexec nmi things.

You see conditionlly set kexec_loading or panic_wants_kexec there no barrier
there and if the cumulativity to have the effect there should be a acquire-release,
if I am not wrong.

__crash_kexec():

WRITE_ONCE(panic_wants_kexec, true);
smp_mb();
/*
 * If we're panic'ing while someone else is messing with the crash
 * kernel, this isn't going to end well.
 */
if (READ_ONCE(kexec_loading)) {
	smp_store_release(panic_wants_kexec, false);
	return;
}

kexec_file_load()/do_kexec_load():

WRITE_ONCE(kexec_loading, true);
smp_mb();
if (smp_load_acquire(panic_wants_kexec)) {
    WRITE_ONCE(kexec_loading, false);
    ...
}

For those input, I'm sure I lost and feel hot..
I thought that change the patten to load-store and set initial
value but failed.

Thanks,
Tao
> +	if (kexec_crash_image) {
> +		struct pt_regs fixed_regs;
> +
> +		crash_setup_regs(&fixed_regs, regs);
> +		crash_save_vmcoreinfo();
> +		machine_crash_shutdown(&fixed_regs);
> +		machine_kexec(kexec_crash_image);
>  	}
>  }
>  STACK_FRAME_NON_STANDARD(__crash_kexec);
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 145321a5e798..4bb399e6623e 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -337,6 +337,18 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
>  	if (!mutex_trylock(&kexec_mutex))
>  		return -EBUSY;
>  
> +	/*
> +	 * Prevent loading a new crash kernel while one is in use.
> +	 *
> +	 * Pairs with smp_mb() in __crash_kexec().
> +	 */
> +	WRITE_ONCE(kexec_loading, true);
> +	smp_mb();
> +	if (READ_ONCE(panic_wants_kexec)) {
> +		ret = -EBUSY;
> +		goto out_unlock;
> +	}
> +
>  	dest_image = &kexec_image;
>  	if (flags & KEXEC_FILE_ON_CRASH) {
>  		dest_image = &kexec_crash_image;
> @@ -406,6 +418,8 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
>  	if ((flags & KEXEC_FILE_ON_CRASH) && kexec_crash_image)
>  		arch_kexec_protect_crashkres();
>  
> +out_unlock:
> +	WRITE_ONCE(kexec_loading, false);
>  	mutex_unlock(&kexec_mutex);
>  	kimage_free(image);
>  	return ret;
> -- 
> 2.27.0
> 

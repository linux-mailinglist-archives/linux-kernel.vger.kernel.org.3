Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45F67558CD5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 03:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbiFXBap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 21:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiFXBao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 21:30:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6BAF75DC0C
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 18:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656034242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XQueJ1NBfP6rBWtDaDGGyAl5dbRuYQpX5eBYhbGPVcE=;
        b=XoF258+ZOdfneF5GsB93wGBLoT/1HSA7vD0pE5S6XyzvkIe6v/aj+krv4nNx9j2crmxgic
        6okctcJEX03XUz/Vi2tflZ8sbNeBTgsNbzZUxQx9d6k2fYQbMwuENDaJaR2tLgCBVwJvET
        YOJsxC9T8XEDxg27W5jikukBznYzRvs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-618-UtdlkmqBM_65ZRNQOSRZkg-1; Thu, 23 Jun 2022 21:30:37 -0400
X-MC-Unique: UtdlkmqBM_65ZRNQOSRZkg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7AF113C17321;
        Fri, 24 Jun 2022 01:30:29 +0000 (UTC)
Received: from localhost (ovpn-12-66.pek2.redhat.com [10.72.12.66])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 899B640D0168;
        Fri, 24 Jun 2022 01:30:28 +0000 (UTC)
Date:   Fri, 24 Jun 2022 09:30:24 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-rt-users@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        Arnd Bergmann <arnd@arndb.de>, Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Juri Lelli <jlelli@redhat.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Subject: Re: [PATCH v2] panic, kexec: Make __crash_kexec() NMI safe
Message-ID: <YrUTsJiIQb583fKy@MiWiFi-R3L-srv>
References: <20220620111520.1039685-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220620111520.1039685-1-vschneid@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/20/22 at 12:15pm, Valentin Schneider wrote:
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
> Furthermore, grabbing the lock isn't NMI safe, so do away with it and
> use an atomic variable to serialize reads vs writes of
> kexec_crash_image.
> 
> Tested by triggering NMI panics via:
> 
>   $ echo 1 > /proc/sys/kernel/panic_on_unrecovered_nmi
>   $ echo 1 > /proc/sys/kernel/unknown_nmi_panic
>   $ echo 1 > /proc/sys/kernel/panic
> 
>   $ ipmitool power diag
> 
> Fixes: 6ce47fd961fa ("rtmutex: Warn if trylock is called from hard/softirq context")
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> ---
> v1 -> v2
> ++++++++
> 
> o Changed from Peterson-like synchronization to simpler atomic_cmpxchg
>   (Petr)
> o Slightly reworded changelog
> o Added Fixes: tag. Technically should be up to since kexec can happen
>   in an NMI, but that isn't such a clear target
> ---
>  include/linux/kexec.h |  1 +
>  kernel/kexec.c        | 16 ++++++++++++----
>  kernel/kexec_core.c   | 36 +++++++++++++++++++-----------------
>  kernel/kexec_file.c   | 11 +++++++++++
>  4 files changed, 43 insertions(+), 21 deletions(-)
> 
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index ce6536f1d269..5849a15ae3dd 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -369,6 +369,7 @@ extern int kimage_crash_copy_vmcoreinfo(struct kimage *image);
>  
>  extern struct kimage *kexec_image;
>  extern struct kimage *kexec_crash_image;
> +extern atomic_t crash_kexec_lock;
>  extern int kexec_load_disabled;
>  
>  #ifndef kexec_flush_icache_page
> diff --git a/kernel/kexec.c b/kernel/kexec.c
> index b5e40f069768..73e0df2c608f 100644
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -94,14 +94,20 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
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

So kexec_mutex is degenerated to only avoid simultaneous loading,
should we rename to reflect that?, e.g kexec_load_mutex.

>  
> +	/*
> +	 * Prevent loading a new crash kernel while one is in use.
> +	 * See associated comment in __crash_kexec().
> +	 */
> +	if (atomic_cmpxchg_acquire(&crash_kexec_lock, 0, 1)) {
> +		ret = -EBUSY;
> +		goto out_unlock_mutex;
> +	}
> +
>  	if (flags & KEXEC_ON_CRASH) {
>  		dest_image = &kexec_crash_image;
>  		if (kexec_crash_image)
> @@ -165,6 +171,8 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
>  
>  	kimage_free(image);
>  out_unlock:
> +	atomic_set_release(&crash_kexec_lock, 0);
> +out_unlock_mutex:
>  	mutex_unlock(&kexec_mutex);
>  	return ret;
>  }
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index 4d34c78334ce..f957109a266c 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -933,6 +933,7 @@ int kimage_load_segment(struct kimage *image,
>  
>  struct kimage *kexec_image;
>  struct kimage *kexec_crash_image;
> +atomic_t crash_kexec_lock = ATOMIC_INIT(0);
>  int kexec_load_disabled;
>  #ifdef CONFIG_SYSCTL
>  static struct ctl_table kexec_core_sysctls[] = {
> @@ -964,25 +965,26 @@ late_initcall(kexec_core_sysctl_init);
>   */
>  void __noclone __crash_kexec(struct pt_regs *regs)
>  {
> -	/* Take the kexec_mutex here to prevent sys_kexec_load
> -	 * running on one cpu from replacing the crash kernel
> -	 * we are using after a panic on a different cpu.
> -	 *
> -	 * If the crash kernel was not located in a fixed area
> -	 * of memory the xchg(&kexec_crash_image) would be
> -	 * sufficient.  But since I reuse the memory...
> +	/*
> +	 * This should be taking kexec_mutex before doing anything with the
> +	 * kexec_crash_image, but this code can be run in NMI context which
> +	 * means we can't even trylock. This is circumvented by using an
> +	 * atomic variable that is *also* used by the codepaths that take
> +	 * the mutex to modify kexec_crash_image.
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
> +	if (atomic_cmpxchg_acquire(&crash_kexec_lock, 0, 1))
> +		return;
> +
> +	if (kexec_crash_image) {
> +		struct pt_regs fixed_regs;
> +
> +		crash_setup_regs(&fixed_regs, regs);
> +		crash_save_vmcoreinfo();
> +		machine_crash_shutdown(&fixed_regs);
> +		machine_kexec(kexec_crash_image);
>  	}
> +
> +	atomic_set_release(&crash_kexec_lock, 0);
>  }
>  STACK_FRAME_NON_STANDARD(__crash_kexec);
>  
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 145321a5e798..3faec031cfc9 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -337,6 +337,15 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
>  	if (!mutex_trylock(&kexec_mutex))
>  		return -EBUSY;
>  
> +	/*
> +	 * Prevent loading a new crash kernel while one is in use.
> +	 * See associated comment in __crash_kexec().
> +	 */
> +	if (atomic_cmpxchg_acquire(&crash_kexec_lock, 0, 1)) {
> +		ret = -EBUSY;
> +		goto out_mutex_unlock;
> +	}
> +
>  	dest_image = &kexec_image;
>  	if (flags & KEXEC_FILE_ON_CRASH) {
>  		dest_image = &kexec_crash_image;
> @@ -406,6 +415,8 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
>  	if ((flags & KEXEC_FILE_ON_CRASH) && kexec_crash_image)
>  		arch_kexec_protect_crashkres();
>  
> +	atomic_set_release(&crash_kexec_lock, 0);
> +out_mutex_unlock:
>  	mutex_unlock(&kexec_mutex);
>  	kimage_free(image);
>  	return ret;
> -- 
> 2.31.1
> 


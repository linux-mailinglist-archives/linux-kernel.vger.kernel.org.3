Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E16FA5248AA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 11:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351799AbiELJOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 05:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242267AbiELJOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 05:14:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 588A2201C3A
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 02:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652346878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eduSMmTQEjMQfnWD40NIXIqgBY5/xpufm8ND1xKpUcU=;
        b=PPBQwXbYQYQyMXjuueTjS1LxPcbkxhllHt9wMk9KIc4C9yRoeMYJ80lrZI7EHb8ER4dx1h
        TWt58J72cDDV59sZ5O2wuhl3/3xyzOy3MADtjvMWMBiznz9fTMRTHCI3F/pUSmwOjL+bPw
        ucvUS9FNqvBSt+VSQeIpN5ND0uKkeWQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-307-SlP4CmwhNSi_Vo8JkHsXEA-1; Thu, 12 May 2022 05:14:37 -0400
X-MC-Unique: SlP4CmwhNSi_Vo8JkHsXEA-1
Received: by mail-wm1-f70.google.com with SMTP id q128-20020a1c4386000000b003942fe15835so1398005wma.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 02:14:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=eduSMmTQEjMQfnWD40NIXIqgBY5/xpufm8ND1xKpUcU=;
        b=M3gTxm91NhtvUXrBc0T811d6Ky3JR+4Dw3u+Qn5wvHvaNs9yAyP3u8Yu74oI+Wl/I0
         i2iDtik4ypvM+rFIHDfz5Xzt0UsOcqjPVtYWP/PwPvkFzin+SuLtPzg5s0YkK6c0Kbm2
         /eCgtjQxG1NzzHmUbKl0HgcJNGxc+rikmpSv4Spc/Jd8N7zDaBFYZaJeNaT9+cHxF8g+
         gP/ycErqJiFrhtPcvpVKb86iQPvYRuG9hjYuFUI/KIaOpgfxW0mn4/LHjGMgw+vaFyGS
         /72Z26XDU8QgZgR2aWk3/D4IQ58Ok5ssyKWfiXvMWGVlJDO1sSvNIpk7+o9r4lquXgjd
         QiAQ==
X-Gm-Message-State: AOAM533fR7P4A7fUpoJBV9gIr/Ma2CkVPz43YR9TkTtq1I1b/yjReMRX
        R0w9bDbe6K/Kv5TzugICApGVHJp/mPcPxgYXEhQ6spV2j6xOR6uv0OKxaxDxGRn0FUdeHS9Xrr2
        Z/WWaFDJbMCPkhtHMsLOxwI4C
X-Received: by 2002:a05:600c:2249:b0:393:fac7:476b with SMTP id a9-20020a05600c224900b00393fac7476bmr9061389wmm.151.1652346875989;
        Thu, 12 May 2022 02:14:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxouWAsu8t8pIqqG/67XUqyMPQP6AHYkfHYb7bATBpJvWl4G1FvqqOYrF1FPk2ruSloE8OT2A==
X-Received: by 2002:a05:600c:2249:b0:393:fac7:476b with SMTP id a9-20020a05600c224900b00393fac7476bmr9061363wmm.151.1652346875712;
        Thu, 12 May 2022 02:14:35 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id p21-20020a05600c359500b00394755b4479sm2379392wmq.21.2022.05.12.02.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 02:14:35 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Michael Kelley <mikelley@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH 1/2] x86/crash: Disable virt in core NMI crash handler
 to avoid double list_add
In-Reply-To: <20220511234332.3654455-2-seanjc@google.com>
References: <20220511234332.3654455-1-seanjc@google.com>
 <20220511234332.3654455-2-seanjc@google.com>
Date:   Thu, 12 May 2022 11:14:34 +0200
Message-ID: <87bkw3xgcl.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> Disable virtualization in crash_nmi_callback() and skip the requested NMI
> shootdown if a shootdown has already occurred, i.e. a callback has been
> registered.  The NMI crash shootdown path doesn't play nice with multiple
> invocations, e.g. attempting to register the NMI handler multiple times
> will trigger a double list_add() and hang the system (in addition to
> multiple other issues).  If "crash_kexec_post_notifiers" is specified on
> the kernel command line, panic() will invoke crash_smp_send_stop() and
> result in a second call to nmi_shootdown_cpus() during
> native_machine_emergency_restart().

crash_kexec_post_notifiers is also automatically enabled on Hyper-V (see
hv_common_init()) which means the hang should also be observed there.

Cc: Michael and Dexuan

>
> Invoke the callback _before_ disabling virtualization, as the current
> VMCS needs to be cleared before doing VMXOFF.  Note, this results in a
> subtle change in ordering between disabling virtualization and stopping
> Intel PT on the responding CPUs.  While VMX and Intel PT do interact,
> VMXOFF and writes to MSR_IA32_RTIT_CTL do not induce faults between one
> another, which is all that matters when panicking.
>
> WARN if nmi_shootdown_cpus() is called a second time with anything other
> than the reboot path's "nop" handler, as bailing means the requested
> isn't being invoked.  Punt true handling of multiple shootdown callbacks
> until there's an actual use case for doing so (beyond disabling
> virtualization).
>
> Extract the disabling logic to a common helper to deduplicate code, and
> to prepare for doing the shootdown in the emergency reboot path if SVM
> is supported.
>
> Note, prior to commit ed72736183c4 ("x86/reboot: Force all cpus to exit
> VMX root if VMX is supported"), nmi_shootdown_cpus() was subtly protected
> against a second invocation by a cpu_vmx_enabled() check as the kdump
> handler would disable VMX if it ran first.
>
> Fixes: ed72736183c4 ("x86/reboot: Force all cpus to exit VMX root if VMX is supported)
> Cc: stable@vger.kernel.org
> Reported-and-tested-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Link: https://lore.kernel.org/all/20220427224924.592546-2-gpiccoli@igalia.com
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/include/asm/reboot.h |  1 +
>  arch/x86/kernel/crash.c       | 16 +--------------
>  arch/x86/kernel/reboot.c      | 38 ++++++++++++++++++++++++++++++++---
>  3 files changed, 37 insertions(+), 18 deletions(-)
>
> diff --git a/arch/x86/include/asm/reboot.h b/arch/x86/include/asm/reboot.h
> index 04c17be9b5fd..8f2da36435a6 100644
> --- a/arch/x86/include/asm/reboot.h
> +++ b/arch/x86/include/asm/reboot.h
> @@ -25,6 +25,7 @@ void __noreturn machine_real_restart(unsigned int type);
>  #define MRR_BIOS	0
>  #define MRR_APM		1
>  
> +void cpu_crash_disable_virtualization(void);
>  typedef void (*nmi_shootdown_cb)(int, struct pt_regs*);
>  void nmi_panic_self_stop(struct pt_regs *regs);
>  void nmi_shootdown_cpus(nmi_shootdown_cb callback);
> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index e8326a8d1c5d..fe0cf83843ba 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -81,15 +81,6 @@ static void kdump_nmi_callback(int cpu, struct pt_regs *regs)
>  	 */
>  	cpu_crash_vmclear_loaded_vmcss();
>  
> -	/* Disable VMX or SVM if needed.
> -	 *
> -	 * We need to disable virtualization on all CPUs.
> -	 * Having VMX or SVM enabled on any CPU may break rebooting
> -	 * after the kdump kernel has finished its task.
> -	 */
> -	cpu_emergency_vmxoff();
> -	cpu_emergency_svm_disable();
> -
>  	/*
>  	 * Disable Intel PT to stop its logging
>  	 */
> @@ -148,12 +139,7 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
>  	 */
>  	cpu_crash_vmclear_loaded_vmcss();
>  
> -	/* Booting kdump kernel with VMX or SVM enabled won't work,
> -	 * because (among other limitations) we can't disable paging
> -	 * with the virt flags.
> -	 */
> -	cpu_emergency_vmxoff();
> -	cpu_emergency_svm_disable();
> +	cpu_crash_disable_virtualization();
>  
>  	/*
>  	 * Disable Intel PT to stop its logging
> diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
> index fa700b46588e..f9543a4e9b09 100644
> --- a/arch/x86/kernel/reboot.c
> +++ b/arch/x86/kernel/reboot.c
> @@ -528,9 +528,9 @@ static inline void kb_wait(void)
>  	}
>  }
>  
> -static void vmxoff_nmi(int cpu, struct pt_regs *regs)
> +static void nmi_shootdown_nop(int cpu, struct pt_regs *regs)
>  {
> -	cpu_emergency_vmxoff();
> +	/* Nothing to do, the NMI shootdown handler disables virtualization. */
>  }
>  
>  /* Use NMIs as IPIs to tell all CPUs to disable virtualization */
> @@ -554,7 +554,7 @@ static void emergency_vmx_disable_all(void)
>  		__cpu_emergency_vmxoff();
>  
>  		/* Halt and exit VMX root operation on the other CPUs. */
> -		nmi_shootdown_cpus(vmxoff_nmi);
> +		nmi_shootdown_cpus(nmi_shootdown_nop);
>  	}
>  }
>  
> @@ -802,6 +802,18 @@ static nmi_shootdown_cb shootdown_callback;
>  static atomic_t waiting_for_crash_ipi;
>  static int crash_ipi_issued;
>  
> +void cpu_crash_disable_virtualization(void)
> +{
> +	/*
> +	 * Disable virtualization, i.e. VMX or SVM, so that INIT is recognized
> +	 * during reboot.  VMX blocks INIT if the CPU is post-VMXON, and SVM
> +	 * blocks INIT if GIF=0.  Note, CLGI #UDs if SVM isn't enabled, so it's
> +	 * easier to just disable SVM unconditionally.
> +	 */
> +	cpu_emergency_vmxoff();
> +	cpu_emergency_svm_disable();
> +}
> +
>  static int crash_nmi_callback(unsigned int val, struct pt_regs *regs)
>  {
>  	int cpu;
> @@ -819,6 +831,12 @@ static int crash_nmi_callback(unsigned int val, struct pt_regs *regs)
>  
>  	shootdown_callback(cpu, regs);
>  
> +	/*
> +	 * Prepare the CPU for reboot _after_ invoking the callback so that the
> +	 * callback can safely use virtualization instructions, e.g. VMCLEAR.
> +	 */
> +	cpu_crash_disable_virtualization();
> +
>  	atomic_dec(&waiting_for_crash_ipi);
>  	/* Assume hlt works */
>  	halt();
> @@ -840,6 +858,20 @@ void nmi_shootdown_cpus(nmi_shootdown_cb callback)
>  	unsigned long msecs;
>  	local_irq_disable();
>  
> +	/*
> +	 * Invoking multiple callbacks is not currently supported, registering
> +	 * the NMI handler twice will cause a list_add() double add BUG().
> +	 * The exception is the "nop" handler in the emergency reboot path,
> +	 * which can run after e.g. kdump's shootdown.  Do nothing if the crash
> +	 * handler has already run, i.e. has already prepared other CPUs, the
> +	 * reboot path doesn't have any work of its to do, it just needs to
> +	 * ensure all CPUs have prepared for reboot.
> +	 */
> +	if (shootdown_callback) {
> +		WARN_ON_ONCE(callback != nmi_shootdown_nop);
> +		return;
> +	}
> +
>  	/* Make a note of crashing cpu. Will be used in NMI callback. */
>  	crashing_cpu = safe_smp_processor_id();

Assuming I didn't get lost in the (infinite) multiverse of possible
shutdown/reboot/crash/kexec-not-kexec paths,

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly


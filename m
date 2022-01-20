Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D91E1494C63
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 12:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbiATLA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 06:00:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:57850 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230073AbiATLAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 06:00:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642676422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FMNIU2dFMg4J2VO3JalJ3KZtQ/AyvMVk6mbC8jXMDgE=;
        b=fHXo6FsLaVOOy+sq0xMB3iF/GnfnTiK8gkajctSGGG+WXr5EVnLCR3Zr+XpTNlEiCHz0xD
        EvOtCsQbECzKuHsyhDcBhMAUJinhXN94Yl3jQSWqKMl+7mhYTYzglnFPZZpE8S3/yI5l7z
        w/oES/m4Gaz39IlQ5jmE7NAdtUr6h3M=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-517-Utbm6TagMqOgIxYLdTHuVA-1; Thu, 20 Jan 2022 06:00:20 -0500
X-MC-Unique: Utbm6TagMqOgIxYLdTHuVA-1
Received: by mail-wm1-f72.google.com with SMTP id f7-20020a1cc907000000b0034b63f314ccso3822103wmb.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 03:00:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FMNIU2dFMg4J2VO3JalJ3KZtQ/AyvMVk6mbC8jXMDgE=;
        b=hzuOuWtR1cXc2AHqsgYnUwudxSXSrFlLDrK+sxE4mTJ7uMFsmkDgEqSbVaRH3+yFy/
         23VgwnX6sFrYei1Xtfjba+LlSzC8MLrkLu94FaNaqCbfG6wnQeG9145oQhTDB5TgEub9
         xt5qnt1WRhM82+p07fIY0D0RcHLFEGLMIrSQSjZ7ts4FIt4wCFSRieqVlRgMcKpmNkjD
         2+tB6nt7fn7+BDDtw3XY1pOsJ5N/pxjVN5kJsaCNhqyh4mkrmqbs/CcBCVULgj9teBey
         kpv/1eG9MvysB9SPOPSW85f/UBqUaKYJ3Kcv5LRjZBH+RZHpizw0urxr53fjUx5i7V2P
         vGcQ==
X-Gm-Message-State: AOAM530AKJvFT+XHt2umQ9QhjWu1maHqnbO2KW4jcdKlnglG9NzG6LuO
        KLNB61dc2TftiwMPXXAI+MIKIh0IP1BWV6hr54u7C5PaDDFYMg4RynZ3lrm9IzSRTJMZ1C9t4gh
        vj/M8u0Th+PVe5mevMVgaDZty
X-Received: by 2002:a05:600c:4ed3:: with SMTP id g19mr8203482wmq.142.1642676418761;
        Thu, 20 Jan 2022 03:00:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwFI8nQcYnfu7cep/AqFPZtTwy9ckHZ2Lp5psNe0kC4I4ZsvVQL5GdiMcDVHv4d91fJlpz4CA==
X-Received: by 2002:a05:600c:4ed3:: with SMTP id g19mr8203434wmq.142.1642676418379;
        Thu, 20 Jan 2022 03:00:18 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id b1sm2976010wrd.78.2022.01.20.03.00.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jan 2022 03:00:17 -0800 (PST)
Message-ID: <8b2e8f61-6e8d-98ca-7602-5af6d3596715@redhat.com>
Date:   Thu, 20 Jan 2022 12:00:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 2/7] kvm: add guest_state_{enter,exit}_irqoff()
Content-Language: en-US
To:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org
Cc:     aleksandar.qemu.devel@gmail.com, alexandru.elisei@arm.com,
        anup.patel@wdc.com, aou@eecs.berkeley.edu, atish.patra@wdc.com,
        borntraeger@linux.ibm.com, bp@alien8.de, catalin.marinas@arm.com,
        chenhuacai@kernel.org, dave.hansen@linux.intel.com,
        frankja@linux.ibm.com, frederic@kernel.org, gor@linux.ibm.com,
        hca@linux.ibm.com, james.morse@arm.com, jmattson@google.com,
        joro@8bytes.org, luto@kernel.org, maz@kernel.org, mingo@redhat.com,
        mpe@ellerman.id.au, nsaenzju@redhat.com, palmer@dabbelt.com,
        paulmck@kernel.org, paul.walmsley@sifive.com, peterz@infradead.org,
        seanjc@google.com, suzuki.poulose@arm.com, svens@linux.ibm.com,
        tglx@linutronix.de, tsbogend@alpha.franken.de, vkuznets@redhat.com,
        wanpengli@tencent.com, will@kernel.org
References: <20220119105854.3160683-1-mark.rutland@arm.com>
 <20220119105854.3160683-3-mark.rutland@arm.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220119105854.3160683-3-mark.rutland@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/19/22 11:58, Mark Rutland wrote:
> When transitioning to/from guest mode, it is necessary to inform
> lockdep, tracing, and RCU in a specific order, similar to the
> requirements for transitions to/from user mode. Additionally, it is
> necessary to perform vtime accounting for a window around running the
> guest, with RCU enabled, such that timer interrupts taken from the guest
> can be accounted as guest time.
> 
> Most architectures don't handle all the necessary pieces, and a have a
> number of common bugs, including unsafe usage of RCU during the window
> between guest_enter() and guest_exit().
> 
> On x86, this was dealt with across commits:
> 
>    87fa7f3e98a1310e ("x86/kvm: Move context tracking where it belongs")
>    0642391e2139a2c1 ("x86/kvm/vmx: Add hardirq tracing to guest enter/exit")
>    9fc975e9efd03e57 ("x86/kvm/svm: Add hardirq tracing on guest enter/exit")
>    3ebccdf373c21d86 ("x86/kvm/vmx: Move guest enter/exit into .noinstr.text")
>    135961e0a7d555fc ("x86/kvm/svm: Move guest enter/exit into .noinstr.text")
>    160457140187c5fb ("KVM: x86: Defer vtime accounting 'til after IRQ handling")
>    bc908e091b326467 ("KVM: x86: Consolidate guest enter/exit logic to common helpers")
> 
> ... but those fixes are specific to x86, and as the resulting logic
> (while correct) is split across generic helper functions and
> x86-specific helper functions, it is difficult to see that the
> entry/exit accounting is balanced.
> 
> This patch adds generic helpers which architectures can use to handle
> guest entry/exit consistently and correctly. The guest_{enter,exit}()
> helpers are split into guest_timing_{enter,exit}() to perform vtime
> accounting, and guest_context_{enter,exit}() to perform the necessary
> context tracking and RCU management. The existing guest_{enter,exit}()
> heleprs are left as wrappers of these.
> 
> Atop this, new guest_state_enter_irqoff() and guest_state_exit_irqoff()
> helpers are added to handle the ordering of lockdep, tracing, and RCU
> manageent. These are inteneded to mirror exit_to_user_mode() and
> enter_from_user_mode().
> 
> Subsequent patches will migrate architectures over to the new helpers,
> following a sequence:
> 
> 	guest_timing_enter_irqoff();
> 
> 	guest_state_enter_irqoff();
> 	< run the vcpu >
> 	guest_state_exit_irqoff();
> 
> 	< take any pending IRQs >
> 
> 	guest_timing_exit_irqoff();
> 
> This sequences handles all of the above correctly, and more clearly
> balances the entry and exit portions, making it easier to understand.
> 
> The existing helpers are marked as deprecated, and will be removed once
> all architectures have been converted.
> 
> There should be no functional change as a result of this patch.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Reviewed-by: Marc Zyngier <maz@kernel.org>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   include/linux/kvm_host.h | 112 +++++++++++++++++++++++++++++++++++++--
>   1 file changed, 109 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index c310648cc8f1a..774a3b9e9bd8d 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -29,6 +29,8 @@
>   #include <linux/refcount.h>
>   #include <linux/nospec.h>
>   #include <linux/notifier.h>
> +#include <linux/ftrace.h>
> +#include <linux/instrumentation.h>
>   #include <asm/signal.h>
>   
>   #include <linux/kvm.h>
> @@ -362,8 +364,11 @@ struct kvm_vcpu {
>   	int last_used_slot;
>   };
>   
> -/* must be called with irqs disabled */
> -static __always_inline void guest_enter_irqoff(void)
> +/*
> + * Start accounting time towards a guest.
> + * Must be called before entering guest context.
> + */
> +static __always_inline void guest_timing_enter_irqoff(void)
>   {
>   	/*
>   	 * This is running in ioctl context so its safe to assume that it's the
> @@ -372,7 +377,18 @@ static __always_inline void guest_enter_irqoff(void)
>   	instrumentation_begin();
>   	vtime_account_guest_enter();
>   	instrumentation_end();
> +}
>   
> +/*
> + * Enter guest context and enter an RCU extended quiescent state.
> + *
> + * Between guest_context_enter_irqoff() and guest_context_exit_irqoff() it is
> + * unsafe to use any code which may directly or indirectly use RCU, tracing
> + * (including IRQ flag tracing), or lockdep. All code in this period must be
> + * non-instrumentable.
> + */
> +static __always_inline void guest_context_enter_irqoff(void)
> +{
>   	/*
>   	 * KVM does not hold any references to rcu protected data when it
>   	 * switches CPU into a guest mode. In fact switching to a guest mode
> @@ -388,16 +404,79 @@ static __always_inline void guest_enter_irqoff(void)
>   	}
>   }
>   
> -static __always_inline void guest_exit_irqoff(void)
> +/*
> + * Deprecated. Architectures should move to guest_timing_enter_irqoff() and
> + * guest_state_enter_irqoff().
> + */
> +static __always_inline void guest_enter_irqoff(void)
> +{
> +	guest_timing_enter_irqoff();
> +	guest_context_enter_irqoff();
> +}
> +
> +/**
> + * guest_state_enter_irqoff - Fixup state when entering a guest
> + *
> + * Entry to a guest will enable interrupts, but the kernel state is interrupts
> + * disabled when this is invoked. Also tell RCU about it.
> + *
> + * 1) Trace interrupts on state
> + * 2) Invoke context tracking if enabled to adjust RCU state
> + * 3) Tell lockdep that interrupts are enabled
> + *
> + * Invoked from architecture specific code before entering a guest.
> + * Must be called with interrupts disabled and the caller must be
> + * non-instrumentable.
> + * The caller has to invoke guest_timing_enter_irqoff() before this.
> + *
> + * Note: this is analogous to exit_to_user_mode().
> + */
> +static __always_inline void guest_state_enter_irqoff(void)
> +{
> +	instrumentation_begin();
> +	trace_hardirqs_on_prepare();
> +	lockdep_hardirqs_on_prepare(CALLER_ADDR0);
> +	instrumentation_end();
> +
> +	guest_context_enter_irqoff();
> +	lockdep_hardirqs_on(CALLER_ADDR0);
> +}
> +
> +/*
> + * Exit guest context and exit an RCU extended quiescent state.
> + *
> + * Between guest_context_enter_irqoff() and guest_context_exit_irqoff() it is
> + * unsafe to use any code which may directly or indirectly use RCU, tracing
> + * (including IRQ flag tracing), or lockdep. All code in this period must be
> + * non-instrumentable.
> + */
> +static __always_inline void guest_context_exit_irqoff(void)
>   {
>   	context_tracking_guest_exit();
> +}
>   
> +/*
> + * Stop accounting time towards a guest.
> + * Must be called after exiting guest context.
> + */
> +static __always_inline void guest_timing_exit_irqoff(void)
> +{
>   	instrumentation_begin();
>   	/* Flush the guest cputime we spent on the guest */
>   	vtime_account_guest_exit();
>   	instrumentation_end();
>   }
>   
> +/*
> + * Deprecated. Architectures should move to guest_state_exit_irqoff() and
> + * guest_timing_exit_irqoff().
> + */
> +static __always_inline void guest_exit_irqoff(void)
> +{
> +	guest_context_exit_irqoff();
> +	guest_timing_exit_irqoff();
> +}
> +
>   static inline void guest_exit(void)
>   {
>   	unsigned long flags;
> @@ -407,6 +486,33 @@ static inline void guest_exit(void)
>   	local_irq_restore(flags);
>   }
>   
> +/**
> + * guest_state_exit_irqoff - Establish state when returning from guest mode
> + *
> + * Entry from a guest disables interrupts, but guest mode is traced as
> + * interrupts enabled. Also with NO_HZ_FULL RCU might be idle.
> + *
> + * 1) Tell lockdep that interrupts are disabled
> + * 2) Invoke context tracking if enabled to reactivate RCU
> + * 3) Trace interrupts off state
> + *
> + * Invoked from architecture specific code after exiting a guest.
> + * Must be invoked with interrupts disabled and the caller must be
> + * non-instrumentable.
> + * The caller has to invoke guest_timing_exit_irqoff() after this.
> + *
> + * Note: this is analogous to enter_from_user_mode().
> + */
> +static __always_inline void guest_state_exit_irqoff(void)
> +{
> +	lockdep_hardirqs_off(CALLER_ADDR0);
> +	guest_context_exit_irqoff();
> +
> +	instrumentation_begin();
> +	trace_hardirqs_off_finish();
> +	instrumentation_end();
> +}
> +
>   static inline int kvm_vcpu_exiting_guest_mode(struct kvm_vcpu *vcpu)
>   {
>   	/*

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>


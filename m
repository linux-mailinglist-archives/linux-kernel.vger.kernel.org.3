Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 236D548DF32
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 21:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234713AbiAMUuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 15:50:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbiAMUuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 15:50:06 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB80C061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 12:50:05 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id 59-20020a17090a09c100b001b34a13745eso19972968pjo.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 12:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tPApFU58dR1gZgJEEILu+tDGM+PxSeVinprQhzYCrE0=;
        b=U5Eh4w8ILAYJhQL+8Y6Z9iDTqQsglioZ0VFEHhm4/BwRgFS4oNhLFLsxsFiqlA1zAo
         itCSCSrzIrhpEMme3G0z47NlGBGRbIr3+D6R8O9kJYKVUl+9+hrsaIrhEl6DjOdbMJWS
         AR6WaLHIXm35aP+AH3hszxZzhlxt84R4zE/VauBiZSf/Z6Yf9MExY1Qvyoax8K/hUwzD
         dPyMhx9SSUuu5dJ2HOILw6gEdj4UEyNjES+8O/F4y9lTCglxf6WMFliRv5OYa44NoyQ2
         DSgceVnFXObalfg6opXRXYJGjc2XUbF6hGNavkF5+6GwIlrMhmtCeTLQ0nkAvmDBvSsB
         nsCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tPApFU58dR1gZgJEEILu+tDGM+PxSeVinprQhzYCrE0=;
        b=Usf7eYb/OuRua9gIb75yLBbiv9T/xIa6UxkOVqHq/UkUJVNWAukdCUuqYKKagMWDdt
         QvxaFTKyriOielwgy03Xk2h+SM43U9apZ6TQ3Xa9HfA20fcsRC7OhNSKxN5ZeRYSw9N6
         C+q/zrIrJsXd7qDxafzkeWDpDwLXh7hw7U3PxhZsgmmjBirckc/hsjw/O8DyLkglst9Y
         fX1oMvUdKC+4V7IxH/lXkUkdlrPxe7DnWFbrKYeogeHiXvbPFzKpabf6+CEheRmQW6As
         TjN/nG/s4mwIovo0oX9QB3l0J5BR/o/BmexohT3WPSJ0mq6g7Wz1u3DAQSZB4soTlAqa
         ZO8Q==
X-Gm-Message-State: AOAM531yZAaDAk13Fi/FMd/+ou9KNEN2VXtj5Jm8NbryOjhhqgXwZBGE
        DqG6pZRfgJo1a68JbIlgYskdQg==
X-Google-Smtp-Source: ABdhPJwJYCD5/Syd/w/87DQlTR6TI+0Jvof2BT19Yr+6weO4P+lZR1M9vsvHVuZlgMkc5peAaklPcw==
X-Received: by 2002:a17:90b:1651:: with SMTP id il17mr15571035pjb.151.1642107004976;
        Thu, 13 Jan 2022 12:50:04 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id y69sm3549018pfg.171.2022.01.13.12.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 12:50:04 -0800 (PST)
Date:   Thu, 13 Jan 2022 20:50:00 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, aleksandar.qemu.devel@gmail.com,
        alexandru.elisei@arm.com, anup.patel@wdc.com,
        aou@eecs.berkeley.edu, atish.patra@wdc.com,
        benh@kernel.crashing.org, borntraeger@linux.ibm.com, bp@alien8.de,
        catalin.marinas@arm.com, chenhuacai@kernel.org,
        dave.hansen@linux.intel.com, david@redhat.com,
        frankja@linux.ibm.com, frederic@kernel.org, gor@linux.ibm.com,
        hca@linux.ibm.com, imbrenda@linux.ibm.com, james.morse@arm.com,
        jmattson@google.com, joro@8bytes.org, kvm@vger.kernel.org,
        maz@kernel.org, mingo@redhat.com, mpe@ellerman.id.au,
        nsaenzju@redhat.com, palmer@dabbelt.com, paulmck@kernel.org,
        paulus@samba.org, paul.walmsley@sifive.com, pbonzini@redhat.com,
        suzuki.poulose@arm.com, tglx@linutronix.de,
        tsbogend@alpha.franken.de, vkuznets@redhat.com,
        wanpengli@tencent.com, will@kernel.org
Subject: Re: [PATCH 5/5] kvm/x86: rework guest entry logic
Message-ID: <YeCQeHbswboaosoV@google.com>
References: <20220111153539.2532246-1-mark.rutland@arm.com>
 <20220111153539.2532246-6-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111153539.2532246-6-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022, Mark Rutland wrote:
> For consistency and clarity, migrate x86 over to the generic helpers for
> guest timing and lockdep/RCU/tracing management, and remove the
> x86-specific helpers.
> 
> Prior to this patch, the guest timing was entered in
> kvm_guest_enter_irqoff() (called by svm_vcpu_enter_exit() and
> svm_vcpu_enter_exit()), and was exited by the call to
> vtime_account_guest_exit() within vcpu_enter_guest().
> 
> To minimize duplication and to more clearly balance entry and exit, both
> entry and exit of guest timing are placed in vcpu_enter_guest(), using
> the new guest_timing_{enter,exit}_irqoff() helpers. This may result in a
> small amount of additional time being acounted towards guests.

This can be further qualified to state that it only affects time accounting when
using context tracking; tick-based accounting is unaffected because IRQs are
disabled the entire time.

And this might actually be a (benign?) bug fix for context tracking accounting in
the EXIT_FASTPATH_REENTER_GUEST case (commits ae95f566b3d2 "KVM: X86: TSCDEADLINE
MSR emulation fastpath" and 26efe2fd92e5, "KVM: VMX: Handle preemption timer
fastpath").  In those cases, KVM will enter the guest multiple times without
bouncing through vtime_account_guest_exit().  That means vtime_guest_enter() will
be called when the CPU is already "in guest", and call vtime_account_system()
when it really should call vtime_account_guest().  account_system_time() does
check PF_VCPU and redirect to account_guest_time(), so it appears to be benign,
but it's at least odd.

> Other than this, there should be no functional change as a result of
> this patch.

...

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index e50e97ac4408..bd3873b90889 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -9876,6 +9876,8 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
>  		set_debugreg(0, 7);
>  	}
>  
> +	guest_timing_enter_irqoff();
> +
>  	for (;;) {
>  		/*
>  		 * Assert that vCPU vs. VM APICv state is consistent.  An APICv
> @@ -9949,7 +9951,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
>  	 * of accounting via context tracking, but the loss of accuracy is
>  	 * acceptable for all known use cases.
>  	 */
> -	vtime_account_guest_exit();
> +	guest_timing_exit_irqoff();
>  
>  	if (lapic_in_kernel(vcpu)) {
>  		s64 delta = vcpu->arch.apic->lapic_timer.advance_expire_delta;

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC2C484AED
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 23:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235678AbiADWwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 17:52:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235054AbiADWwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 17:52:50 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1BB0C061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 14:52:49 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id h6so24189764plf.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 14:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VxMSZX1HGa/pYxYXS45b2VNpzNPZiDZH28VAovlQ1Cs=;
        b=iawsbHmTCIC5yjOILXtsURiIt1CUlPAzc2Yugmwaujue9UnekQWajk0upsHJviOqvX
         /TEzGW2ZprP+fnDoc41KbMgaz6J0yO8k1zvbjsCBn54Y5nb3W3lqhJgIByhsIjLGHNEd
         IJ/huOtBRSRrvN/dm1eC2BAm9kUT4TXBWw5is/0VoM0kp90Y3hyiRJrKcNFdQgPWyEPu
         5uLTa1SmtVaxz1I2MQm4ihnCNUWuQc7spVhKQsriRSxI86OZZtey0CSqN+WBpu1OxkSV
         WfLlQr8QCyM5oIode1Of9qUx3qsWesYJV5/juSKIkNKHggVae6e5yjeYoP197A/0IPoc
         2HHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VxMSZX1HGa/pYxYXS45b2VNpzNPZiDZH28VAovlQ1Cs=;
        b=UoBqzJhaZmkIT+Qfmj9pCWjfgtrNRGCjVwYxnUqQox/ANcT9OnXH1hgMBEC7TX+OSw
         p6tKaoeCBkSVSbSjZvtB4lwECrJu2JZ0E4E1OwjScm4VL7BY4WmAX7hf7ovkCFq17cgz
         HTuvkEK6YfhUlyrfLGqXCbmqinyCXSUVADjYbRcP3XjumxXKyh5JKAqYw6n+gnhFnbQ/
         8XmDAYkp0qeE5QU8S13RYAxbPzEYsdQA/urOwGDSF+TQMtgfSL8rmQuAOzjCiWfKEOCc
         Qw41I03iWo6F/2R9rNhzGzp+lFZ9N9n0SvUx53ptNnlfzzZgIrJ9g9W4uVbTKG8uLtJ5
         Malw==
X-Gm-Message-State: AOAM530NHHR+12ldWqh6Cp1xDvV5wOQjecO1NLYLX/yznv6bKhcSz/jf
        9tBV8RETNG1OVW3tiYAXi2MA3TyvXfyo8w==
X-Google-Smtp-Source: ABdhPJzbLJqp98rD/4U7kVPEMER04Xrxb9fVUCnDdD98RdmEXnNhZJ/JJK+hWf6kFjkD4+t250lgHA==
X-Received: by 2002:a17:902:e811:b0:149:22b4:d4a6 with SMTP id u17-20020a170902e81100b0014922b4d4a6mr51915667plg.58.1641336769248;
        Tue, 04 Jan 2022 14:52:49 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id oa9sm337834pjb.31.2022.01.04.14.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 14:52:48 -0800 (PST)
Date:   Tue, 4 Jan 2022 22:52:45 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     kvm@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joerg Roedel <joro@8bytes.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v2 3/5] KVM: SVM: fix race between interrupt delivery and
 AVIC inhibition
Message-ID: <YdTPvdY6ysjXMpAU@google.com>
References: <20211213104634.199141-1-mlevitsk@redhat.com>
 <20211213104634.199141-4-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213104634.199141-4-mlevitsk@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021, Maxim Levitsky wrote:
> If svm_deliver_avic_intr is called just after the target vcpu's AVIC got
> inhibited, it might read a stale value of vcpu->arch.apicv_active
> which can lead to the target vCPU not noticing the interrupt.
> 
> To fix this use load-acquire/store-release so that, if the target vCPU
> is IN_GUEST_MODE, we're guaranteed to see a previous disabling of the
> AVIC.  If AVIC has been disabled in the meanwhile, proceed with the
> KVM_REQ_EVENT-based delivery.
> 
> All this complicated logic is actually exactly how we can handle an
> incomplete IPI vmexit; the only difference lies in who sets IRR, whether
> KVM or the processor.
> 
> Also incomplete IPI vmexit, has the same races as svm_deliver_avic_intr.
> therefore just reuse the avic_kick_target_vcpu for it as well.
> 
> Reported-by: Maxim Levitsky <mlevitsk@redhat.com>

Heh, probably don't need a Reported-by for a patch you wrote :-)

> Co-developed-with: Paolo Bonzini <pbonzini@redhat.com>

Co-developed-by: is preferred, and should be accompanied by Paolo's SoB.

> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  arch/x86/kvm/svm/avic.c | 85 +++++++++++++++++++++++++----------------
>  arch/x86/kvm/x86.c      |  4 +-
>  2 files changed, 55 insertions(+), 34 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
> index 90364d02f22aa..34f62da2fbadd 100644
> --- a/arch/x86/kvm/svm/avic.c
> +++ b/arch/x86/kvm/svm/avic.c
> @@ -289,6 +289,47 @@ static int avic_init_backing_page(struct kvm_vcpu *vcpu)
>  	return 0;
>  }
>  
> +static void avic_kick_target_vcpu(struct kvm_vcpu *vcpu)
> +{
> +	bool in_guest_mode;
> +
> +	/*
> +	 * vcpu->arch.apicv_active is read after vcpu->mode.  Pairs

This should say "must be read", not "is read".  It's obvious from the code that
apicv_active is read second, the comment is there to say that it _must_ be read
after vcpu->mode.

> +	 * with smp_store_release in vcpu_enter_guest.
> +	 */
> +	in_guest_mode = (smp_load_acquire(&vcpu->mode) == IN_GUEST_MODE);

IMO, it's marginally clear to initialize the bool.

	bool in_guest_mode = (smp_load_acquire(&vcpu->mode) == IN_GUEST_MODE);

> +	if (READ_ONCE(vcpu->arch.apicv_active)) {
> +		if (in_guest_mode) {
> +			/*
> +			 * Signal the doorbell to tell hardware to inject the IRQ if the vCPU
> +			 * is in the guest.  If the vCPU is not in the guest, hardware will
> +			 * automatically process AVIC interrupts at VMRUN.

Might as well wrap these comments at 80 chars since they're being moved.  Or
maybe even better....

	/* blah blah blah */
	if (!READ_ONCE(vcpu->arch.apicv_active)) {
		kvm_make_request(KVM_REQ_EVENT, vcpu);
		kvm_vcpu_kick(vcpu);
		return;
	}

	if (in_guest_mode) {
		...
	} else {
		....
	}

...so that the existing comments can be preserved as is.

> +			 *
> +			 * Note, the vCPU could get migrated to a different pCPU at any
> +			 * point, which could result in signalling the wrong/previous
> +			 * pCPU.  But if that happens the vCPU is guaranteed to do a
> +			 * VMRUN (after being migrated) and thus will process pending
> +			 * interrupts, i.e. a doorbell is not needed (and the spurious
> +			 * one is harmless).
> +			 */
> +			int cpu = READ_ONCE(vcpu->cpu);
> +			if (cpu != get_cpu())
> +				wrmsrl(SVM_AVIC_DOORBELL, kvm_cpu_get_apicid(cpu));
> +			put_cpu();
> +		} else {
> +			/*
> +			 * Wake the vCPU if it was blocking.  KVM will then detect the
> +			 * pending IRQ when checking if the vCPU has a wake event.
> +			 */
> +			kvm_vcpu_wake_up(vcpu);
> +		}
> +	} else {
> +		/* Compare this case with __apic_accept_irq.  */

Honestly, this comment isn't very helpful.  It only takes a few lines to say:

		/*
		 * Manually signal the event, the __apic_accept_irq() fallback
		 * path can't be used if AVIC is disabled after the vector is
		 * already queued in the vIRR.
		 */

(incorporating more feedback below)

> +		kvm_make_request(KVM_REQ_EVENT, vcpu);
> +		kvm_vcpu_kick(vcpu);
> +	}
> +}
> +
>  static void avic_kick_target_vcpus(struct kvm *kvm, struct kvm_lapic *source,
>  				   u32 icrl, u32 icrh)
>  {
> @@ -304,8 +345,10 @@ static void avic_kick_target_vcpus(struct kvm *kvm, struct kvm_lapic *source,
>  	kvm_for_each_vcpu(i, vcpu, kvm) {
>  		if (kvm_apic_match_dest(vcpu, source, icrl & APIC_SHORT_MASK,
>  					GET_APIC_DEST_FIELD(icrh),
> -					icrl & APIC_DEST_MASK))
> -			kvm_vcpu_wake_up(vcpu);
> +					icrl & APIC_DEST_MASK)) {
> +			vcpu->arch.apic->irr_pending = true;
> +			avic_kick_target_vcpu(vcpu);
> +		}
>  	}
>  }
>  
> @@ -671,9 +714,12 @@ void svm_load_eoi_exitmap(struct kvm_vcpu *vcpu, u64 *eoi_exit_bitmap)
>  
>  int svm_deliver_avic_intr(struct kvm_vcpu *vcpu, int vec)
>  {
> -	if (!vcpu->arch.apicv_active)
> -		return -1;
> -
> +	/*
> +	 * Below, we have to handle anyway the case of AVIC being disabled
> +	 * in the middle of this function, and there is hardly any overhead
> +	 * if AVIC is disabled.  So, we do not bother returning -1 and handle
> +	 * the kick ourselves for disabled APICv.

Hmm, my preference would be to keep the "return -1" even though apicv_active must
be rechecked.  That would help highlight that returning "failure" after this point
is not an option as it would result in kvm_lapic_set_irr() being called twice.

> +	 */
>  	kvm_lapic_set_irr(vec, vcpu->arch.apic);
>  
>  	/*
> @@ -684,34 +730,7 @@ int svm_deliver_avic_intr(struct kvm_vcpu *vcpu, int vec)
>  	 * the doorbell if the vCPU is already running in the guest.
>  	 */
>  	smp_mb__after_atomic();
> -
> -	/*
> -	 * Signal the doorbell to tell hardware to inject the IRQ if the vCPU
> -	 * is in the guest.  If the vCPU is not in the guest, hardware will
> -	 * automatically process AVIC interrupts at VMRUN.
> -	 */
> -	if (vcpu->mode == IN_GUEST_MODE) {
> -		int cpu = READ_ONCE(vcpu->cpu);
> -
> -		/*
> -		 * Note, the vCPU could get migrated to a different pCPU at any
> -		 * point, which could result in signalling the wrong/previous
> -		 * pCPU.  But if that happens the vCPU is guaranteed to do a
> -		 * VMRUN (after being migrated) and thus will process pending
> -		 * interrupts, i.e. a doorbell is not needed (and the spurious
> -		 * one is harmless).
> -		 */
> -		if (cpu != get_cpu())
> -			wrmsrl(SVM_AVIC_DOORBELL, kvm_cpu_get_apicid(cpu));
> -		put_cpu();
> -	} else {
> -		/*
> -		 * Wake the vCPU if it was blocking.  KVM will then detect the
> -		 * pending IRQ when checking if the vCPU has a wake event.
> -		 */
> -		kvm_vcpu_wake_up(vcpu);
> -	}
> -
> +	avic_kick_target_vcpu(vcpu);
>  	return 0;
>  }
>  
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 85127b3e3690b..81a74d86ee5eb 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -9869,7 +9869,9 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
>  	 * result in virtual interrupt delivery.
>  	 */
>  	local_irq_disable();
> -	vcpu->mode = IN_GUEST_MODE;
> +
> +	/* Store vcpu->apicv_active before vcpu->mode.  */
> +	smp_store_release(&vcpu->mode, IN_GUEST_MODE);
>  
>  	srcu_read_unlock(&vcpu->kvm->srcu, vcpu->srcu_idx);
>  
> -- 
> 2.26.3
> 

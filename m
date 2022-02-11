Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83EE84B2B6C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 18:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351929AbiBKRLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 12:11:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351921AbiBKRLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 12:11:42 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07186CC8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 09:11:41 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id w20so5166146plq.12
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 09:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZXZYmwuFavHkw9skfaPMKZ0CfxQ+794cPfuZuwBpzHQ=;
        b=MR7FbxrQM3TfNUFt+Le86WeUiYHc1Y4R/VTLw0WqnjD8jAnT6GlBqZSdt8SwNKBGhS
         g24ZWIvmrQEqVuHN7xheAb7PbUb3D4OjohT5cH3deKtTjjS9e1+U8Kqn1F8lE35ZGsZy
         ug1tdtUXAife5rqOfDsp8uk/8J936mbXgiiqXTMJMpUlC7ZHOt06ei0urU+yUCigjvQk
         jfauip585/5SX8zha4L8EmqcMw+kelErubLX4kxcw84TLRP7+PP2yQa0isZYiOi3ksuP
         23Oaaw0yyV8iRLYNrnrKZT3Q9fYwMpEYS/inpSmY9Wc4E6WiSy8/BJiBTJK0alpSoh2x
         UFfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZXZYmwuFavHkw9skfaPMKZ0CfxQ+794cPfuZuwBpzHQ=;
        b=DxtuGnGJM2utv6YN0FfN9SWg9C70eV1BqrezKjwWMX/U9CMoc4UV04dHIT1Nt/JsOX
         h58G/cZmeIQnm+DqG7oiQNv6ETR9HGW7hj2KkFJS8dzVNVPZm6jWX3g8XtFZAhkkCT6q
         fZ2/+uarT7h/tB/0ZN2dazazuSjNO1RZmlnMqOrcx02VM/fP620vHw4/zKxxHUn1iU7G
         sIZlpD2TC5OabrPEG6H2tD3rNVQzoK7MfGwyOO3Ae+KNbxWRKlZbj32ZP6sfZ0HBHx5Z
         je4lEz0g1gkvoKiA4vcL8oIAo7LR9c+bQLiGO81HqFl3D42L/CW13sRGazL6YevMPZ4A
         NVow==
X-Gm-Message-State: AOAM530P1c9eQ8iKmBW7lUv7Hs5M6rfrXdI115UjhjymPv9DY1ifWmfl
        zENc1X+WoJeSsWTun1aaLDnN7A==
X-Google-Smtp-Source: ABdhPJz0inrAEDyPM30tNsr8GW9SVbbND0L1pBdW9MHimiQUCDLBG94hd9gR+ClYOtXuLF7sj7vhMQ==
X-Received: by 2002:a17:902:e0cd:: with SMTP id e13mr2456716pla.15.1644599500290;
        Fri, 11 Feb 2022 09:11:40 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id 6sm20408169pgx.36.2022.02.11.09.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 09:11:39 -0800 (PST)
Date:   Fri, 11 Feb 2022 17:11:36 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        mlevitsk@redhat.com
Subject: Re: [PATCH 3/3] KVM: SVM: fix race between interrupt delivery and
 AVIC inhibition
Message-ID: <YgaYyJGN0v07vfzc@google.com>
References: <20220211110117.2764381-1-pbonzini@redhat.com>
 <20220211110117.2764381-4-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211110117.2764381-4-pbonzini@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2022, Paolo Bonzini wrote:
> From: Maxim Levitsky <mlevitsk@redhat.com>
> 
> If svm_deliver_avic_intr is called just after the target vcpu's AVIC got
> inhibited, it might read a stale value of vcpu->arch.apicv_active
> which can lead to the target vCPU not noticing the interrupt.
> 
> To fix this use load-acquire/store-release so that, if the target vCPU
> is IN_GUEST_MODE, we're guaranteed to see a previous disabling of the
> AVIC.  If AVIC has been disabled in the meanwhile, proceed with the
> KVM_REQ_EVENT-based delivery.
> 
> Incomplete IPI vmexit has the same races as svm_deliver_avic_intr, and
> in fact it can be handled in exactly the same way; the only difference
> lies in who has set IRR, whether svm_deliver_interrupt or the processor.
> Therefore, svm_complete_interrupt_delivery can be used to fix incomplete
> IPI vmexits as well.
> 
> Co-developed-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Same SoB issues.

Several comments on non-functional things, with those addressed:

Reviewed-by: Sean Christopherson <seanjc@google.com>

> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index cd769ff8af16..2ad158b27e91 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -3299,21 +3299,55 @@ static void svm_set_irq(struct kvm_vcpu *vcpu)
>  		SVM_EVTINJ_VALID | SVM_EVTINJ_TYPE_INTR;
>  }
>  
> -static void svm_deliver_interrupt(struct kvm_lapic *apic, int delivery_mode,
> -				  int trig_mode, int vector)
> +void svm_complete_interrupt_delivery(struct kvm_vcpu *vcpu, int delivery_mode,
> +				     int trig_mode, int vector)
>  {
> -	struct kvm_vcpu *vcpu = apic->vcpu;
> +	/*
> +	 * vcpu->arch.apicv_active must be read after vcpu->mode.
> +	 * Pairs with smp_store_release in vcpu_enter_guest.
> +	 */
> +	bool in_guest_mode = (smp_load_acquire(&vcpu->mode) == IN_GUEST_MODE);
>  
> -	kvm_lapic_set_irr(vector, apic);
> -	if (svm_deliver_avic_intr(vcpu, vector)) {
> +	if (!READ_ONCE(vcpu->arch.apicv_active)) {
> +		/* Process the interrupt with a vmexit.  */

Double spaces at the end.  But I would prefer we omit the comment entirely,
there is no guarantee the vCPU is in the guest or even running.

>  		kvm_make_request(KVM_REQ_EVENT, vcpu);
>  		kvm_vcpu_kick(vcpu);
> +		return;
> +	}
> +
> +	trace_kvm_apicv_accept_irq(vcpu->vcpu_id, delivery_mode, trig_mode, vector);
> +	if (in_guest_mode) {
> +		/*
> +		 * Signal the doorbell to tell hardware to inject the IRQ if the vCPU
> +		 * is in the guest.  If the vCPU is not in the guest, hardware will
> +		 * automatically process AVIC interrupts at VMRUN.

This is a bit confusing because KVM has _just_ checked if the vCPU is in the guest.
Something like this?

		/*
		 * Signal the doorbell to tell hardware to inject the IRQ.  If
		 * the vCPU exits the guest before the doorbell chimes, hardware
		 * will automatically process AVIC interrupts at the next VMRUN.
		 */

> +		 */
> +		avic_ring_doorbell(vcpu);
>  	} else {
> -		trace_kvm_apicv_accept_irq(vcpu->vcpu_id, delivery_mode,
> -					   trig_mode, vector);
> +		/*
> +		 * Wake the vCPU if it was blocking.  KVM will then detect the
> +		 * pending IRQ when checking if the vCPU has a wake event.
> +		 */
> +		kvm_vcpu_wake_up(vcpu);
>  	}
>  }
>  
> +static void svm_deliver_interrupt(struct kvm_lapic *apic,  int delivery_mode,
> +				  int trig_mode, int vector)
> +{
> +	kvm_lapic_set_irr(vector, apic);
> +
> +	/*
> +	 * Pairs with the smp_mb_*() after setting vcpu->guest_mode in
> +	 * vcpu_enter_guest() to ensure the write to the vIRR is ordered before
> +	 * the read of guest_mode.  This guarantees that either VMRUN will see
> +	 * and process the new vIRR entry, or that svm_complete_interrupt_delivery
> +	 * will signal the doorbell if the CPU has already performed vmentry.

How about "if the CPU has already entered the guest" instead of "performed vmentry"?
Mixing VMRUN and vmentry/VM-Entry is confusing because KVM often uses VM-Enter/VM-Entry
to refer to VMRESUME/VMLAUNCH/VMRUN as a single concept (though I agree vmentry is better
than VMRUN here, because ucode checks the vIRR in the middle of VMRUN before "VM entry").
And for that usage, KVM is the one that performs VM-Entry.

> +	 */
> +	smp_mb__after_atomic();
> +	svm_complete_interrupt_delivery(apic->vcpu, delivery_mode, trig_mode, vector);
> +}
> +
>  static void svm_update_cr8_intercept(struct kvm_vcpu *vcpu, int tpr, int irr)
>  {
>  	struct vcpu_svm *svm = to_svm(vcpu);
> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> index 8cc45f27fcbd..dd895f0f5569 100644
> --- a/arch/x86/kvm/svm/svm.h
> +++ b/arch/x86/kvm/svm/svm.h
> @@ -489,6 +489,8 @@ void svm_set_gif(struct vcpu_svm *svm, bool value);
>  int svm_invoke_exit_handler(struct kvm_vcpu *vcpu, u64 exit_code);
>  void set_msr_interception(struct kvm_vcpu *vcpu, u32 *msrpm, u32 msr,
>  			  int read, int write);
> +void svm_complete_interrupt_delivery(struct kvm_vcpu *vcpu, int delivery_mode,
> +		  int trig_mode, int vec);

Please align the params.

>  
>  /* nested.c */
>  
> @@ -572,12 +574,12 @@ bool svm_check_apicv_inhibit_reasons(ulong bit);
>  void svm_load_eoi_exitmap(struct kvm_vcpu *vcpu, u64 *eoi_exit_bitmap);
>  void svm_hwapic_irr_update(struct kvm_vcpu *vcpu, int max_irr);
>  void svm_hwapic_isr_update(struct kvm_vcpu *vcpu, int max_isr);
> -int svm_deliver_avic_intr(struct kvm_vcpu *vcpu, int vec);
>  bool svm_dy_apicv_has_pending_interrupt(struct kvm_vcpu *vcpu);
>  int svm_update_pi_irte(struct kvm *kvm, unsigned int host_irq,
>  		       uint32_t guest_irq, bool set);
>  void avic_vcpu_blocking(struct kvm_vcpu *vcpu);
>  void avic_vcpu_unblocking(struct kvm_vcpu *vcpu);
> +void avic_ring_doorbell(struct kvm_vcpu *vcpu);
>  
>  /* sev.c */
>  
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 7131d735b1ef..641044db415d 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -9983,7 +9983,9 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
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
> 2.31.1
> 

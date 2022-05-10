Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47ACD521D03
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 16:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345008AbiEJOzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 10:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344831AbiEJOy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 10:54:59 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903CC31665F
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 07:15:27 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id o69so15981036pjo.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 07:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Gbt0dQE6hjicFcO+8NOWUYbo4+AYvhvISpo6fy0h7us=;
        b=LXNxKGJlahyUgiXOfqkryAQyceDMXZBUHOBIu3YBuV3QCd4OuWyiEq2pUymYaclMxZ
         zfRXd6qGjRH9H4o2hTAgj25+jyxhMOBGzgVi+kiCNRxq/cPNL4xoQ3bfipbbREYxBOBM
         inOJ6pNhEtQ+BuBTbPMlMnttIbWOpFyyCWQRFoqBmgdp01P7eAqM9I2ORT9JLkXpc/Hl
         piMgho7G226vixsWegnvNyvyEjrA5lCvdUJ3dut0LlMNS4ADHEgDzckpV8i8kobSje/1
         2h4H7F5LIjWchywYmwhd/6UDUAUo/Qnw3GvKLe24L+yXrqy8Jxp4qf2Cjgk/953Mb7PM
         6I+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Gbt0dQE6hjicFcO+8NOWUYbo4+AYvhvISpo6fy0h7us=;
        b=tQGZvy5EXVzNq9pJO2NOBBd7Z3MXQSEKmv+I+YPiLgglPh0oyiTlGbf+lBs2W08On9
         erYxWpSvTGNFqUTI+Dk43X0De25jr+7Y2Nvkr7HTR0Hy0JWbaWDsygWP87UOjJbMLaZB
         cBlG5/kn9UxSqRESroMTet5ybaP8ye4r2vh570f7Jdm2vK6tuPya8URN9ZoGK7ub5W6l
         jn+Lo3Op/Y8VvVRKjMk3cnREMUOCtsXjMY5XoP7DyJtYkPjLCeZyqi5F2XdExgWUbNIP
         Kh2u7wDf3SPhhBvYibj0SbBfI91vmC1Uy64IokD/E9R/s6slo3nnHQ9aDcpXXAkS+TfD
         0jng==
X-Gm-Message-State: AOAM530caX6GDfxciMX/SHVt2ig+26KkBmyIWTKVwojFsEcELb8eMjyM
        nUMI+6r4+99D89Ogiu7xfBksPQ==
X-Google-Smtp-Source: ABdhPJwTCodcB53/XV23AXgSa9OttM/zTr3s+gLPrisR9kO/A3m/E1DWsrUQBNzepFatX0+LwZssAw==
X-Received: by 2002:a17:90b:1b44:b0:1dc:315f:4510 with SMTP id nv4-20020a17090b1b4400b001dc315f4510mr250908pjb.28.1652192126871;
        Tue, 10 May 2022 07:15:26 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id i6-20020a17090332c600b0015e8d4eb261sm2173135plr.171.2022.05.10.07.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 07:15:25 -0700 (PDT)
Date:   Tue, 10 May 2022 14:15:22 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] KVM: LAPIC: Narrow down the timer fastpath to
 tscdeadline timer
Message-ID: <YnpzetR/B3nXVJxu@google.com>
References: <1651830457-11284-1-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1651830457-11284-1-git-send-email-wanpengli@tencent.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 06, 2022, Wanpeng Li wrote:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> The original timer fastpath is developed for tscdeadline timer, however,
> the apic timer periodic/oneshot mode which is emulated by vmx preemption
> timer goes to preemption timer vmexit fastpath quietly, let's leave the 
> complex recompute periodic timer's target expiration and restart apic 
> timer to the slowpath vm-exit. Narrow down the timer fastpath to tscdeadline
> timer mode.

Why?  I get that the original intention was only to handle deadline mode, but
that doesn't mean using it for other modes is inherently flawed/problematic.  KVM
also uses a fastpath for starting the deadline timer on MSR write, i.e. KVM eats
the cost of starting the timer in the fastpath no matter what, and
advance_periodic_target_expiration() isn't _that_ complex.

> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
>  arch/x86/kvm/lapic.c   |  6 ++++++
>  arch/x86/kvm/lapic.h   |  1 +
>  arch/x86/kvm/vmx/vmx.c | 14 +++++++++++---
>  3 files changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index 137c3a2f5180..3e6cb2bf56dc 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -2459,6 +2459,12 @@ static bool lapic_is_periodic(struct kvm_lapic *apic)
>  	return apic_lvtt_period(apic);
>  }
>  
> +bool lapic_is_tscdeadline(struct kvm_lapic *apic)
> +{
> +	return apic_lvtt_tscdeadline(apic);
> +}
> +EXPORT_SYMBOL_GPL(lapic_is_tscdeadline);
> +
>  int apic_has_pending_timer(struct kvm_vcpu *vcpu)
>  {
>  	struct kvm_lapic *apic = vcpu->arch.apic;
> diff --git a/arch/x86/kvm/lapic.h b/arch/x86/kvm/lapic.h
> index 4e4f8a22754f..6e1b2f349237 100644
> --- a/arch/x86/kvm/lapic.h
> +++ b/arch/x86/kvm/lapic.h
> @@ -241,6 +241,7 @@ void kvm_lapic_expired_hv_timer(struct kvm_vcpu *vcpu);
>  bool kvm_lapic_hv_timer_in_use(struct kvm_vcpu *vcpu);
>  void kvm_lapic_restart_hv_timer(struct kvm_vcpu *vcpu);
>  bool kvm_can_use_hv_timer(struct kvm_vcpu *vcpu);
> +bool lapic_is_tscdeadline(struct kvm_lapic *apic);
>  
>  static inline enum lapic_mode kvm_apic_mode(u64 apic_base)
>  {
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index bb09fc9a7e55..2a8f4253df35 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -5713,22 +5713,30 @@ static int handle_pml_full(struct kvm_vcpu *vcpu)
>  	return 1;
>  }
>  
> -static fastpath_t handle_fastpath_preemption_timer(struct kvm_vcpu *vcpu)
> +static bool __handle_preemption_timer(struct kvm_vcpu *vcpu)
>  {
>  	struct vcpu_vmx *vmx = to_vmx(vcpu);
>  
>  	if (!vmx->req_immediate_exit &&
>  	    !unlikely(vmx->loaded_vmcs->hv_timer_soft_disabled)) {
>  		kvm_lapic_expired_hv_timer(vcpu);
> -		return EXIT_FASTPATH_REENTER_GUEST;
> +		return true;
>  	}
>  
> +	return false;

It's a bit odd for the non-fastpath case, but I'd prefer to return fastpath_t
instead of a bool from the inner helper, e.g.

static fastpath_t __handle_preemption_timer(struct kvm_vcpu *vcpu)
{
	struct vcpu_vmx *vmx = to_vmx(vcpu);

	if (!vmx->req_immediate_exit &&
	    !unlikely(vmx->loaded_vmcs->hv_timer_soft_disabled)) {
		kvm_lapic_expired_hv_timer(vcpu);
		return EXIT_FASTPATH_REENTER_GUEST;
	}

	return EXIT_FASTPATH_NONE;
}

static fastpath_t handle_fastpath_preemption_timer(struct kvm_vcpu *vcpu)
{
	if (lapic_is_tscdeadline(vcpu->arch.apic)
		return __handle_preemption_timer(vcpu))

	return EXIT_FASTPATH_NONE;
}

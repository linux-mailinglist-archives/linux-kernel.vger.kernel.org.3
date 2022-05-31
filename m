Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9773A539658
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 20:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235489AbiEaShR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 14:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234460AbiEaShO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 14:37:14 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CA73BF9C
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 11:37:12 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id 187so2414575pfu.9
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 11:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hWj4sjmaINOSES96uQhbfRwwJ0UbCQlM7svVZ1kzGrI=;
        b=Kbix2DiYH8ZEAIQcQ5bIFalB3poaUEBziCzNPKASdCpz4CZjgOqZr1B6YoS/tPzxoH
         9ZWtCY9wwChwnKJI+rY6gNDR47g2aovoKNsCUzVoB3j23ITmRZbthVVruYDOl4MD8XUb
         zQXpKwru07Bv01pvI6SMbuVomQIx34wk7d3Xr4P0wlLNVkSVZXXXXvCL1kxWRyQkor/8
         ovc9Kr/+7AEnudPSJBRvrdH1SUkcgEQJ6cCYypdXwMvYgVxHGgQwZF0OH0CNYBoepBT3
         XD2Bez6QF9y79FkPGcrmbikbmWYp9PkoHGnLKS2o6iRaqj6W4KwBDmh7EoCSZQ3E904x
         E7zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hWj4sjmaINOSES96uQhbfRwwJ0UbCQlM7svVZ1kzGrI=;
        b=wg2SifQnG1Wy1wWXPBFt/301znPt0yo6juOcHEruHDvGl3Cf0p2J0f3SBTRsQu2SY1
         JHhFjNH3SmIgr+areDRpM2hgwJTkYpqVukQQ6Jyr9GivYkXPFbFEEPTUUY0yORbeyms6
         IIWWALMkklRxIERJxQlGhqGvNHPzNe6EmRKJqYTJNMW+hGHwf1Ff41K/6dZCYPZYIfF0
         6AyXpFnZQ2QR4qqoVe1VultWOmiWCq1e+nUvZes9WbOU8PMEaqRi1WxTSTibOAZolMhx
         Gn5+aRepFL/v0wza3icm/JGIQVbiirnjx9StGrL5ScTkx5/Drbc6+ip4HIgCDH+6U+K0
         rKSA==
X-Gm-Message-State: AOAM531nytLwukLi5G6+H+ltHC96bFTl2EYk4iJy8wYgZb5ezS9+XWwD
        nd+kjPY84KLKAf+IrHotS+noRw==
X-Google-Smtp-Source: ABdhPJwhWN04hUpsdexnXO3sDCOAmI9npOONFPFoIY6udV8+iJAWYbTfX7J4vWswnoFjRzcGmdJ9yw==
X-Received: by 2002:a05:6a00:1307:b0:50d:b02e:11df with SMTP id j7-20020a056a00130700b0050db02e11dfmr63123645pfu.4.1654022232218;
        Tue, 31 May 2022 11:37:12 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id a17-20020a170902b59100b00163ffe73300sm2187734pls.137.2022.05.31.11.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 11:37:11 -0700 (PDT)
Date:   Tue, 31 May 2022 18:37:07 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        likexu@tencent.com
Subject: Re: [PATCH 1/2] KVM: vmx, pmu: accept 0 for absent MSRs when
 host-initiated
Message-ID: <YpZgU+vfjkRuHZZR@google.com>
References: <20220531175450.295552-1-pbonzini@redhat.com>
 <20220531175450.295552-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220531175450.295552-2-pbonzini@redhat.com>
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

On Tue, May 31, 2022, Paolo Bonzini wrote:
> Whenever an MSR is part of KVM_GET_MSR_INDEX_LIST, as is the case for
> MSR_IA32_DS_AREA, MSR_ARCH_LBR_DEPTH or MSR_ARCH_LBR_CTL, it has to be
> always settable with KVM_SET_MSR.  Accept a zero value for these MSRs
> to obey the contract.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  arch/x86/kvm/vmx/pmu_intel.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> index 3e04d0407605..66496cb41494 100644
> --- a/arch/x86/kvm/vmx/pmu_intel.c
> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> @@ -367,8 +367,9 @@ static bool arch_lbr_depth_is_valid(struct kvm_vcpu *vcpu, u64 depth)
>  {
>  	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
>  
> -	if (!kvm_cpu_cap_has(X86_FEATURE_ARCH_LBR))
> -		return false;
> +	if (!kvm_cpu_cap_has(X86_FEATURE_ARCH_LBR) ||
> +	    !guest_cpuid_has(vcpu, X86_FEATURE_ARCH_LBR))
> +		return depth == 0;
>  
>  	return (depth == pmu->kvm_arch_lbr_depth);
>  }
> @@ -378,7 +379,7 @@ static bool arch_lbr_ctl_is_valid(struct kvm_vcpu *vcpu, u64 ctl)
>  	struct kvm_cpuid_entry2 *entry;
>  
>  	if (!kvm_cpu_cap_has(X86_FEATURE_ARCH_LBR))
> -		return false;
> +		return ctl == 0;
>  
>  	if (ctl & ~KVM_ARCH_LBR_CTL_MASK)
>  		goto warn;
> @@ -510,6 +511,8 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  		}
>  		break;
>  	case MSR_IA32_DS_AREA:
> +		if (msr_info->host_initiated && data && !guest_cpuid_has(vcpu, X86_FEATURE_DS))
> +			return 1;
>  		if (is_noncanonical_address(data, vcpu))
>  			return 1;
>  		pmu->ds_area = data;
> @@ -525,7 +528,11 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  	case MSR_ARCH_LBR_DEPTH:
>  		if (!arch_lbr_depth_is_valid(vcpu, data))
>  			return 1;
> +
>  		lbr_desc->records.nr = data;
> +		if (!guest_cpuid_has(vcpu, X86_FEATURE_ARCH_LBR))
> +			return 0;

This is wrong, it will allow an unchecked wrmsrl() to MSR_ARCH_LBR_DEPTH if
X86_FEATURE_ARCH_LBR is not supported by hardware but userspace forces it in
guest CPUID. 

This the only user of arch_lbr_depth_is_valid(), just open code the logic.

> +
>  		/*
>  		 * Writing depth MSR from guest could either setting the
>  		 * MSR or resetting the LBR records with the side-effect.
> @@ -535,6 +542,8 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  	case MSR_ARCH_LBR_CTL:
>  		if (!arch_lbr_ctl_is_valid(vcpu, data))
>  			break;
> +		if (!guest_cpuid_has(vcpu, X86_FEATURE_ARCH_LBR))
> +			return 0;

Similar bug here.

Can we just punt this out of kvm/queue until its been properly reviewed?  At the
barest of glances, there are multiple flaws that should block this from being
merged.  Based on the number of checks against X86_FEATURE_ARCH_LBR in KVM, and
my vague recollection of the passthrough behavior, this is a _massive_ feature.

The pr_warn_ratelimited() shouldn't exist; it's better than a non-ratelimited warn,
but it's ultimately useless.

This should check kvm_cpu_has() to ensure the field exists, e.g. if the feature
is supported in hardware but cpu_has_vmx_arch_lbr() returns false for whatever
reason.

	if (!init_event) {
		if (static_cpu_has(X86_FEATURE_ARCH_LBR))
			vmcs_write64(GUEST_IA32_LBR_CTL, 0);

intel_pmu_lbr_is_enabled() is going to be a performance problem, e.g. _should_ be
gated by static_cpu_has() to avoid overhead on CPUs without arch LBRs, and is
going to incur a _guest_ CPUID lookup on X86_FEATURE_PDCM for every VM-Entry if
arch LBRs are exposed to the guest (at least, I think that's what it does).

>  
>  		vmcs_write64(GUEST_IA32_LBR_CTL, data);
>  
> -- 
> 2.31.1
> 
> 

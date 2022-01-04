Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4DE84848A5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 20:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbiADTen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 14:34:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbiADTem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 14:34:42 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35BBC061792
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 11:34:41 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id h1so24524801pls.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 11:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iH/Z6nAOZvy5jh9SWdX0D3TqjQ36VBZBUh4IjIVI2KU=;
        b=dMk5FFsEM0qjjR31iR3kFFqi767xWE85H2DmBOWoO11yT9IFkqKRq9JA1CHZA1/Z7v
         v3dl59VjiW+R3vQEs80sZ0Gw3Buv1tIaD5zGmL0uKB4K1yNQ45fLtf4GNz+G4L1kqRDT
         LKycf/mmhlH6HssLR44W/WvYolYv0I72kY3XytUcX3eKV0OyCWxs4t0IA+OHS71zs8zj
         D39KVQnSbk/DJuBR2ApGPTV8ZPdYLJkz7lU16ak0pw2aPqU0rosVYUJEOjM6mHIW2t7k
         85mqKiB+qZvUJX9jpvywSa9dt4gbzcGFpXOP79kn5SXZ/YRccNPNg7Hv5iHoqPZtVHaR
         GDZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iH/Z6nAOZvy5jh9SWdX0D3TqjQ36VBZBUh4IjIVI2KU=;
        b=YXPoc1Q9fo6V6DkvpC4ruJ2pk4oLN8wL39+7N5pLH2pQh8LjW52GgL9DhJk6PaQKm0
         T7dSQi2Z3XmFK/Myo6vZxdDTIHHCcUPqrM7etqN2z5NAXrngoLUeudakU0NQkFrJiKBt
         5WuIj2tb+mphkj8hohkluDNlqFj2FsmFzsFKZra+c5tCJsAa1RWs5bzX+jLTNGMUmQtg
         HIW7qIWxUlm/dgNxl/vLEArUf1KkPGJC2ou4C6lKbVONVUaIaQnUPSRUb1R2ACByJgrw
         ugXuQYCBPi4cS+DfvesT6Q32/FX3BCoPKJohMmV78in4ctW4NFiVdUkJnPdy6Q7U41w/
         AdfA==
X-Gm-Message-State: AOAM530s3fO56yoxxvfzGEpq81ksOFS73PPoQm07F/SGYRrGPH/9lB1q
        ZCZid82n2Z1J8lRa+GetAIM5zg==
X-Google-Smtp-Source: ABdhPJxPE0ndgN4KPvQI/1/ReXfjEQyQ11SfTQrwjGebIqporUWcpvWGEuKHdwro/qLEY8r94fjELg==
X-Received: by 2002:a17:902:6841:b0:149:6791:5a4f with SMTP id f1-20020a170902684100b0014967915a4fmr38538152pln.123.1641324881041;
        Tue, 04 Jan 2022 11:34:41 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id p32sm33734547pgb.49.2022.01.04.11.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 11:34:40 -0800 (PST)
Date:   Tue, 4 Jan 2022 19:34:36 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Yang Zhong <yang.zhong@intel.com>
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, pbonzini@redhat.com, corbet@lwn.net,
        shuah@kernel.org, jun.nakajima@intel.com, kevin.tian@intel.com,
        jing2.liu@linux.intel.com, jing2.liu@intel.com,
        guang.zeng@intel.com, wei.w.wang@intel.com
Subject: Re: [PATCH v4 14/21] kvm: x86: Disable RDMSR interception of
 IA32_XFD_ERR
Message-ID: <YdShTDdOQISmku2H@google.com>
References: <20211229131328.12283-1-yang.zhong@intel.com>
 <20211229131328.12283-15-yang.zhong@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211229131328.12283-15-yang.zhong@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 29, 2021, Yang Zhong wrote:
> From: Jing Liu <jing2.liu@intel.com>
> 
> Disable read emulation of IA32_XFD_ERR MSR if guest cpuid includes XFD.
> This saves one unnecessary VM-exit in guest #NM handler, given that the
> MSR is already restored with the guest value before the guest is resumed.
> 
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Jing Liu <jing2.liu@intel.com>
> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 6 ++++++
>  arch/x86/kvm/vmx/vmx.h | 2 +-
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 4e51de876085..638665b3e241 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -162,6 +162,7 @@ static u32 vmx_possible_passthrough_msrs[MAX_POSSIBLE_PASSTHROUGH_MSRS] = {
>  	MSR_FS_BASE,
>  	MSR_GS_BASE,
>  	MSR_KERNEL_GS_BASE,
> +	MSR_IA32_XFD_ERR,
>  #endif
>  	MSR_IA32_SYSENTER_CS,
>  	MSR_IA32_SYSENTER_ESP,
> @@ -7228,6 +7229,11 @@ static void vmx_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
>  		}
>  	}
>  
> +	if (boot_cpu_has(X86_FEATURE_XFD))

This should be kvm_cpu_cap_has(), not boot_cpu_has().  If 32-bit kernels don't
suppress XFD in boot_cpu_data, then using boot_cpus_has() is wrong.  And even if
XFD is suppressed, using kvm_cpu_cap_has() is still preferable.

> +		vmx_set_intercept_for_msr(vcpu, MSR_IA32_XFD_ERR, MSR_TYPE_R,
> +					  !guest_cpuid_has(vcpu, X86_FEATURE_XFD));
> +
> +
>  	set_cr4_guest_host_mask(vmx);
>  
>  	vmx_write_encls_bitmap(vcpu, NULL);
> diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
> index 4df2ac24ffc1..bf9d3051cd6c 100644
> --- a/arch/x86/kvm/vmx/vmx.h
> +++ b/arch/x86/kvm/vmx/vmx.h
> @@ -340,7 +340,7 @@ struct vcpu_vmx {
>  	struct lbr_desc lbr_desc;
>  
>  	/* Save desired MSR intercept (read: pass-through) state */
> -#define MAX_POSSIBLE_PASSTHROUGH_MSRS	13
> +#define MAX_POSSIBLE_PASSTHROUGH_MSRS	14
>  	struct {
>  		DECLARE_BITMAP(read, MAX_POSSIBLE_PASSTHROUGH_MSRS);
>  		DECLARE_BITMAP(write, MAX_POSSIBLE_PASSTHROUGH_MSRS);

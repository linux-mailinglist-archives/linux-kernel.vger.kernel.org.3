Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44649490FAB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 18:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235420AbiAQRdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 12:33:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37084 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235461AbiAQRdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 12:33:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642440785;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N82gjADLl4AqILC71ez9KDnc1rxJI4BgOCYZ9+DvRdU=;
        b=LBdQFGY2a4QfqIKkqIHIIT5dIIG20AiVS+NtBX30VdawmrhzCsv9+ijBBxc2+ulKrTFG1+
        hiruGSnVDg7VlpVk8cKhdE/SvsL5lnENGogbtWvtCqjscth0Cwd2PiF9OiUDCBt+kAVY+Y
        j74LDe0ctn+GfNR4q9NVJozPV46G9gk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-548-4KgsGwJcPcGX8Au-C7woPg-1; Mon, 17 Jan 2022 12:33:03 -0500
X-MC-Unique: 4KgsGwJcPcGX8Au-C7woPg-1
Received: by mail-wm1-f69.google.com with SMTP id bg16-20020a05600c3c9000b0034bea12c043so5054453wmb.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 09:33:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=N82gjADLl4AqILC71ez9KDnc1rxJI4BgOCYZ9+DvRdU=;
        b=M2j+Z39S1xt/RKv710X40dbh7kALQe5J24284eqq3WUzhzlCzBZ3LCTBQIU3vnFaEz
         FNd9UcLUrVL2NvwJv67we3dFnGZzFsbzyIxpSv7MmRIKH8M2EPwqyFJSJOzqP2PLnXI9
         0m5TzSLxM+4C9khaYOT9hpgDu1kSWt4xfuYWeUTdxkwEniTzH8UkKlDchl4cTWKarwYH
         DN03YJurcZW7zx8h5i7A/WVjt62iGoX3U2gdjrhPiJib/y1BEeJW8LqxB+7DSP9pGVYH
         pTk0FesfzRKy2rLF6n1lrb8gBh1uqMbjhiozsQGRI/zjalWJbiiU258LjEaku4SEhZmM
         FaMQ==
X-Gm-Message-State: AOAM5308jieGMvKK5IJMrbH3sjFFfkmvDkKw6aRF1CHfgrtzrqmv8b0x
        2ONyU4Vl9epyJvAsI6FNqnzy2hW7uwwFOc2DzRuaFrWVmi3C2LwiJu4c57DG1Fo8Bblg2WFmZYz
        9Rk9chJWwcHB3ZfSY9lcywii3
X-Received: by 2002:adf:efc2:: with SMTP id i2mr21631984wrp.89.1642440782630;
        Mon, 17 Jan 2022 09:33:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwgCOrXZYkaV8olVaHkEQ7xC7mu2axwRY6nfu7Q0U8DZeTJXswqIjBVFPZDNktpT56HoMFdcQ==
X-Received: by 2002:adf:efc2:: with SMTP id i2mr21631965wrp.89.1642440782403;
        Mon, 17 Jan 2022 09:33:02 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id n4sm2328957wri.29.2022.01.17.09.32.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jan 2022 09:33:01 -0800 (PST)
Message-ID: <f9edf9b5-0f84-a424-f8e9-73cad901d993@redhat.com>
Date:   Mon, 17 Jan 2022 18:32:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] KVM: x86: Update the states size cpuid even if
 XCR0/IA32_XSS is reset
Content-Language: en-US
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Sean Christopherson <seanjc@google.com>,
        Jim Mattson <jmattson@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220117082631.86143-1-likexu@tencent.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220117082631.86143-1-likexu@tencent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/22 09:26, Like Xu wrote:
> From: Like Xu <likexu@tencent.com>
> 
> XCR0 is reset to 1 by RESET but not INIT and IA32_XSS is zeroed by
> both RESET and INIT. In both cases, the size in bytes of the XSAVE
> area containing all states enabled by XCR0 or (XCRO | IA32_XSS)
> needs to be updated.
> 
> Fixes: a554d207dc46 ("KVM: X86: Processor States following Reset or INIT")
> Signed-off-by: Like Xu <likexu@tencent.com>

Can you write a test case please?

Thanks,

Paolo

> ---
>   arch/x86/kvm/x86.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 76b4803dd3bd..5748a57e1cb7 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -11134,6 +11134,7 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
>   	struct kvm_cpuid_entry2 *cpuid_0x1;
>   	unsigned long old_cr0 = kvm_read_cr0(vcpu);
>   	unsigned long new_cr0;
> +	bool need_update_cpuid = false;
>   
>   	/*
>   	 * Several of the "set" flows, e.g. ->set_cr0(), read other registers
> @@ -11199,6 +11200,8 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
>   
>   		vcpu->arch.msr_misc_features_enables = 0;
>   
> +		if (vcpu->arch.xcr0 != XFEATURE_MASK_FP)
> +			need_update_cpuid = true;
>   		vcpu->arch.xcr0 = XFEATURE_MASK_FP;
>   	}
>   
> @@ -11216,6 +11219,8 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
>   	cpuid_0x1 = kvm_find_cpuid_entry(vcpu, 1, 0);
>   	kvm_rdx_write(vcpu, cpuid_0x1 ? cpuid_0x1->eax : 0x600);
>   
> +	if (vcpu->arch.ia32_xss)
> +		need_update_cpuid = true;
>   	vcpu->arch.ia32_xss = 0;
>   
>   	static_call(kvm_x86_vcpu_reset)(vcpu, init_event);
> @@ -11264,6 +11269,9 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
>   	 */
>   	if (init_event)
>   		kvm_make_request(KVM_REQ_TLB_FLUSH_GUEST, vcpu);
> +
> +	if (need_update_cpuid)
> +		kvm_update_cpuid_runtime(vcpu);
>   }
>   EXPORT_SYMBOL_GPL(kvm_vcpu_reset);
>   


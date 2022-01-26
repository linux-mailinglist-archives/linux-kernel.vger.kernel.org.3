Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB19249D085
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 18:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243645AbiAZRPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 12:15:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:50024 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234632AbiAZRPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 12:15:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643217321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QG6ySHAezAZJk/nwAFZwk/0OoVXz59pzUB8tyROetQI=;
        b=QBX2E/RTc+pgYtULGTdwACWeIckQHtLcK6Wb9+9WbExVqaTtculFCien+QOn+WolNAeclN
        HzOhqVT+7bYjmplyMHCzO+Q1epNCWGyxh7HBSEH6XqZiMIGsDW5GT14TUPOUqK87VLgUX5
        A7SsPUji276UKWyVkSegitynMJX1dlc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-373-BY7dQn2MMAaoN5MkVsPCGQ-1; Wed, 26 Jan 2022 12:15:20 -0500
X-MC-Unique: BY7dQn2MMAaoN5MkVsPCGQ-1
Received: by mail-ej1-f72.google.com with SMTP id 13-20020a170906328d00b006982d0888a4so225ejw.9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 09:15:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QG6ySHAezAZJk/nwAFZwk/0OoVXz59pzUB8tyROetQI=;
        b=FOrMFjD04MMfVrMbca+Df1a5bBDUcs+O1tls0uxhdciZDLEiwUX+cpGVejBRYu87G7
         ICLqd9Ot7e1E0MU1lKdTRtGhNOWC1hP6x+tPT9Kbv1/Ts898z2+VfL73ftFigAqY6pxp
         5mXw63EiYccspEAttdrlmxah97E1/uS5+qjBT8A5DY2IAGfFowmtTjWGEpm1h7TwcYDg
         t0LzVMSQmQ+ICG2WAKq5pYklFhoLaQ3sSQbMHUqRQfW7t4yV8K+a3xRe0/yTO/dfnUDB
         SzEHwNyhSmud8Cw4zeDW825Gi/n8vWq/wRjMNab07CcWLJ6Af2zyRpt/i9V35n7s8opO
         weiw==
X-Gm-Message-State: AOAM5324JcSTOExZpm7iSyfs2eeRgbCJYzYbQmFSctzus0CEDX3Tt5Yt
        diGzqBJVZpgkugKnmOFNTrC0v2a+jWY9E5hoCwHCcu/7IVVdmlvIAIIWgdEenkuQhtEVSU5+/LF
        lsvp3tKSahMscDyf8oYv1dtU7
X-Received: by 2002:a17:906:17d5:: with SMTP id u21mr20687554eje.348.1643217318353;
        Wed, 26 Jan 2022 09:15:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyJI+NBcV+9lwyIqhuJJlEVa+16GJ2LPjRWvUNrCU+JH8M12jcqkXcQDhl5BnCySYFJy/zHXA==
X-Received: by 2002:a17:906:17d5:: with SMTP id u21mr20687534eje.348.1643217318162;
        Wed, 26 Jan 2022 09:15:18 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id fh23sm7744998ejc.176.2022.01.26.09.15.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 09:15:17 -0800 (PST)
Message-ID: <6decc356-b24b-583e-7a96-b221afd91af8@redhat.com>
Date:   Wed, 26 Jan 2022 18:15:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] KVM: x86: Keep MSR_IA32_XSS unchanged for INIT
Content-Language: en-US
To:     Xiaoyao Li <xiaoyao.li@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220126034750.2495371-1-xiaoyao.li@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220126034750.2495371-1-xiaoyao.li@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/26/22 04:47, Xiaoyao Li wrote:
> It has been corrected from SDM version 075 that MSR_IA32_XSS is reset to
> zero on Power up and Reset but keeps unchanged on INIT.
> 
> Fixes: a554d207dc46 ("KVM: X86: Processor States following Reset or INIT")
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>   arch/x86/kvm/x86.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 55518b7d3b96..c0727939684e 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -11257,6 +11257,7 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
>   		vcpu->arch.msr_misc_features_enables = 0;
>   
>   		vcpu->arch.xcr0 = XFEATURE_MASK_FP;
> +		vcpu->arch.ia32_xss = 0;
>   	}
>   
>   	/* All GPRs except RDX (handled below) are zeroed on RESET/INIT. */
> @@ -11273,8 +11274,6 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
>   	cpuid_0x1 = kvm_find_cpuid_entry(vcpu, 1, 0);
>   	kvm_rdx_write(vcpu, cpuid_0x1 ? cpuid_0x1->eax : 0x600);
>   
> -	vcpu->arch.ia32_xss = 0;
> -
>   	static_call(kvm_x86_vcpu_reset)(vcpu, init_event);
>   
>   	kvm_set_rflags(vcpu, X86_EFLAGS_FIXED);

Queued, thanks.

Paolo


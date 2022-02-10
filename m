Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB8224B1346
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 17:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240213AbiBJQmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 11:42:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244622AbiBJQmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 11:42:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2F3D2EA5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 08:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644511336;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xG2WsMe2j14laQYWR88mxBtxfylSM+Rc2ZUR4//o/cw=;
        b=TFuKl4xlewfVOttVSAK6JegAMcjyaYseZssMRuZTjzhCXtV9ivA+Dc8PdIIr5GD20Vwaa5
        o5hhI1bi4T7I7KWiFm/3SPlFOvAaeNDlxtIpt5avfkuFlfxMV77PZ6I87G9+M621P95lGG
        HojMI/AGvDieCH+ljC9U09o8BXXBA+E=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-587-_DYPkeVpOQSNcYl3pD0KZw-1; Thu, 10 Feb 2022 11:42:12 -0500
X-MC-Unique: _DYPkeVpOQSNcYl3pD0KZw-1
Received: by mail-ed1-f72.google.com with SMTP id s7-20020a508dc7000000b0040f29ccd65aso3690551edh.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 08:42:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xG2WsMe2j14laQYWR88mxBtxfylSM+Rc2ZUR4//o/cw=;
        b=JpZclSI0pE2AGcZdSWrPPuEwTonpziTfM9vX8jlm0ymlm8iB8mALVGJCSGIuZnDDnM
         Lfq7Et7ge6rxu5CVN29LKt0H1zGrZEbCJeD1O1oJLxm5f+lvLVU/cCnEvuauLCzpO5Qm
         0i1wiMa1aDWnZGDP6Y5W2sjcffMV5IXU8B7INOZe5dJ45haLvhEipQTfgfMH5PqQvX9n
         Yipopcxyui28YKx72gQbYN/Y+b+T4zqcSrUlRLMBp8buROCjo0+dt3cSV/xQcbKI2AXj
         PpDxfz/oMtAT0zs8wvF1VBi8xE6WApZd+O09TzKQXHSNQwxa1X+u6IEalHmP40fOv4Zw
         u7tQ==
X-Gm-Message-State: AOAM533O3qBml4szuxLcteeeGVybPDHqn1zLA2xIjDCpRVrZLdR1uHLZ
        LkW+zdy59J7l3olxD/VaQK5sN2Hq32ODZKmsm58aIp/bgVDWkAGdLbRjnQkEql/XKcQ39p5dR6B
        CkD/+bdMZ9vTkNUnL9bWo6Xk2
X-Received: by 2002:a17:907:9852:: with SMTP id jj18mr7086156ejc.467.1644511331724;
        Thu, 10 Feb 2022 08:42:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxD7yhLtaVDYQLY+B3/AoTnDP4/nT4uPQqHfgqGbF4Ra8gjpl1Ubrsj3juR4AfkgIGxmYIHIg==
X-Received: by 2002:a17:907:9852:: with SMTP id jj18mr7086142ejc.467.1644511331525;
        Thu, 10 Feb 2022 08:42:11 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.googlemail.com with ESMTPSA id bq11sm3100115ejb.5.2022.02.10.08.42.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 08:42:10 -0800 (PST)
Message-ID: <e272c421-d860-6656-5c86-0641753a95b8@redhat.com>
Date:   Thu, 10 Feb 2022 17:42:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH MANUALSEL 5.16 8/8] KVM: x86: Report deprecated x87
 features in supported CPUID
Content-Language: en-US
To:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     Jim Mattson <jmattson@google.com>,
        Aaron Lewis <aaronlewis@google.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, kvm@vger.kernel.org
References: <20220209185635.48730-1-sashal@kernel.org>
 <20220209185635.48730-8-sashal@kernel.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220209185635.48730-8-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/9/22 19:56, Sasha Levin wrote:
> From: Jim Mattson <jmattson@google.com>
> 
> [ Upstream commit e3bcfda012edd3564e12551b212afbd2521a1f68 ]

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Paolo

> CPUID.(EAX=7,ECX=0):EBX.FDP_EXCPTN_ONLY[bit 6] and
> CPUID.(EAX=7,ECX=0):EBX.ZERO_FCS_FDS[bit 13] are "defeature"
> bits. Unlike most of the other CPUID feature bits, these bits are
> clear if the features are present and set if the features are not
> present. These bits should be reported in KVM_GET_SUPPORTED_CPUID,
> because if these bits are set on hardware, they cannot be cleared in
> the guest CPUID. Doing so would claim guest support for a feature that
> the hardware doesn't support and that can't be efficiently emulated.
> 
> Of course, any software (e.g WIN87EM.DLL) expecting these features to
> be present likely predates these CPUID feature bits and therefore
> doesn't know to check for them anyway.
> 
> Aaron Lewis added the corresponding X86_FEATURE macros in
> commit cbb99c0f5887 ("x86/cpufeatures: Add FDP_EXCPTN_ONLY and
> ZERO_FCS_FDS"), with the intention of reporting these bits in
> KVM_GET_SUPPORTED_CPUID, but I was unable to find a proposed patch on
> the kvm list.
> 
> Opportunistically reordered the CPUID_7_0_EBX capability bits from
> least to most significant.
> 
> Cc: Aaron Lewis <aaronlewis@google.com>
> Signed-off-by: Jim Mattson <jmattson@google.com>
> Message-Id: <20220204001348.2844660-1-jmattson@google.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>   arch/x86/kvm/cpuid.c | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index add8f58d686e3..bf18679757c70 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -532,12 +532,13 @@ void kvm_set_cpu_caps(void)
>   	);
>   
>   	kvm_cpu_cap_mask(CPUID_7_0_EBX,
> -		F(FSGSBASE) | F(SGX) | F(BMI1) | F(HLE) | F(AVX2) | F(SMEP) |
> -		F(BMI2) | F(ERMS) | F(INVPCID) | F(RTM) | 0 /*MPX*/ | F(RDSEED) |
> -		F(ADX) | F(SMAP) | F(AVX512IFMA) | F(AVX512F) | F(AVX512PF) |
> -		F(AVX512ER) | F(AVX512CD) | F(CLFLUSHOPT) | F(CLWB) | F(AVX512DQ) |
> -		F(SHA_NI) | F(AVX512BW) | F(AVX512VL) | 0 /*INTEL_PT*/
> -	);
> +		F(FSGSBASE) | F(SGX) | F(BMI1) | F(HLE) | F(AVX2) |
> +		F(FDP_EXCPTN_ONLY) | F(SMEP) | F(BMI2) | F(ERMS) | F(INVPCID) |
> +		F(RTM) | F(ZERO_FCS_FDS) | 0 /*MPX*/ | F(AVX512F) |
> +		F(AVX512DQ) | F(RDSEED) | F(ADX) | F(SMAP) | F(AVX512IFMA) |
> +		F(CLFLUSHOPT) | F(CLWB) | 0 /*INTEL_PT*/ | F(AVX512PF) |
> +		F(AVX512ER) | F(AVX512CD) | F(SHA_NI) | F(AVX512BW) |
> +		F(AVX512VL));
>   
>   	kvm_cpu_cap_mask(CPUID_7_ECX,
>   		F(AVX512VBMI) | F(LA57) | F(PKU) | 0 /*OSPKE*/ | F(RDPID) |


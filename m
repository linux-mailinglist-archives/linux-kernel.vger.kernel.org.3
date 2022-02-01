Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2991D4A6239
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 18:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241306AbiBARTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 12:19:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:56957 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232367AbiBARTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 12:19:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643735988;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RTTaaqTexMiviY5ExjYQD5TY+qwuxgKYffBtH4V/lBs=;
        b=b403KkGb+6nrHv67Yb/Cwgaa1E043GglKBIDnPkngmAOfEyMhXZkvtenS4tgBgL+iWLj3f
        wEkb/Wb1L8y3MYE3whbif2QiMAMw7eRZ831i+0Hp86vhHGoUK002YW7F8zP3vr0h/O6FMX
        tL/GKDfT2W6lKe5jXKk+eIqdgux+SZc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-457-b9IJ2hXSMbygHcKMeVXfOA-1; Tue, 01 Feb 2022 12:19:47 -0500
X-MC-Unique: b9IJ2hXSMbygHcKMeVXfOA-1
Received: by mail-ej1-f69.google.com with SMTP id gb4-20020a170907960400b0069d1ebc4538so6871108ejc.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 09:19:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RTTaaqTexMiviY5ExjYQD5TY+qwuxgKYffBtH4V/lBs=;
        b=4fFlBj0FSxr+tqaJ6zJk7i2avRMyTvyuu79WvnQijK3nBiAlJTX+0vDaoqTVVbzdOV
         yYmLd3PaKGhn3wCTUdYVRjf5y+CoglhvO8SCLh8xDLjB0Qk2M7ymS70fM80F9lYPhlKA
         M13dt0tB9VEotLEkHTeZysEHnliA3xeHi1rxnc3fjERCWtlxb2G6RhpK2M7QLzFLMIVK
         yuK5I3nHbVh825vkPCDP+MpBFH0GXTr/qqwUDVHMsGWjRcuW+LqP19uIJYbTB2dyOPtX
         ILDf6tKqhHVZh+seSpyhCwRm9CGbFecdNVF/fHaa13YqPIFS9F+tsM/NrraSlHqo6zFs
         hQ0A==
X-Gm-Message-State: AOAM531bfcIvnHx4j+EtV2L3MnecOik2khjFxw/AWboNNfHTlp3ciIak
        mUu0Y/22QZGm6tJCChO6a1IRM6lQJQZwb88uBVPS1hqoxIyxbkcjftsstQTsjSnUoOVKiFTEgVd
        bT6QFL0FoBDf5Ohfx1X0ov0A9
X-Received: by 2002:a05:6402:50cd:: with SMTP id h13mr20455690edb.256.1643735985847;
        Tue, 01 Feb 2022 09:19:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxlF933YRaA0nrKf+bG82CjueypyRkNC11a8RWjUIFzKHxXTQv77hCavI5mmpHLXF1+ZEsKzw==
X-Received: by 2002:a05:6402:50cd:: with SMTP id h13mr20455676edb.256.1643735985645;
        Tue, 01 Feb 2022 09:19:45 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id d2sm14784098ejw.70.2022.02.01.09.19.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 09:19:45 -0800 (PST)
Message-ID: <2e8b9c10-be9d-e721-30bd-06e89a92d0f1@redhat.com>
Date:   Tue, 1 Feb 2022 18:19:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/1 fyi] tools headers cpufeatures: Sync with the kernel
 sources
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jing Liu <jing2.liu@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <YflQCEO9FRLeTmlB@kernel.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <YflQCEO9FRLeTmlB@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/22 16:21, Arnaldo Carvalho de Melo wrote:
> To pick the changes from:
> 
>    690a757d610e50c2 ("kvm: x86: Add CPUID support for Intel AMX")
> 
> This only causes these perf files to be rebuilt:
> 
>    CC       /tmp/build/perf/bench/mem-memcpy-x86-64-asm.o
>    CC       /tmp/build/perf/bench/mem-memset-x86-64-asm.o
> 
> And addresses this perf build warning:
> 
>    Warning: Kernel ABI header at 'tools/arch/x86/include/asm/cpufeatures.h' differs from latest version at 'arch/x86/include/asm/cpufeatures.h'
>    diff -u tools/arch/x86/include/asm/cpufeatures.h arch/x86/include/asm/cpufeatures.h
> 
> Cc: Jing Liu <jing2.liu@intel.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>   tools/arch/x86/include/asm/cpufeatures.h | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
> index 18de5f76f19856b1..6db4e2932b3d8657 100644
> --- a/tools/arch/x86/include/asm/cpufeatures.h
> +++ b/tools/arch/x86/include/asm/cpufeatures.h
> @@ -299,7 +299,9 @@
>   /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
>   #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */
>   #define X86_FEATURE_AVX512_BF16		(12*32+ 5) /* AVX512 BFLOAT16 instructions */
> +#define X86_FEATURE_AMX_BF16		(18*32+22) /* AMX bf16 Support */
>   #define X86_FEATURE_AMX_TILE		(18*32+24) /* AMX tile Support */
> +#define X86_FEATURE_AMX_INT8		(18*32+25) /* AMX int8 Support */
>   
>   /* AMD-defined CPU features, CPUID level 0x80000008 (EBX), word 13 */
>   #define X86_FEATURE_CLZERO		(13*32+ 0) /* CLZERO instruction */

Thanks!

Paolo


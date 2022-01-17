Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7D9490FA7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 18:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235466AbiAQRcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 12:32:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:26705 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237988AbiAQRcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 12:32:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642440722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=facGYaN7TmsTdJN/2dDbCbC61s3Aifzqr9lBPbfPM3U=;
        b=cM/n2Oz/JIfWfaxEkdBcg6lkqvZ5b0ld1J9NbcwWoH+B5tGypmUyZbJSLtGBdecE2uZmkZ
        QSgjnYvHhKGnAjtlfaM8CHpjMtffCgdC3wQ9QfGRXQiwW3il1I1cW3RRlREDPe66uhH16y
        M0vwfVLZxta/Xiz/+E0B089QFmkZaic=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-145-MawdLP9nPHWGTOGxhTfmnQ-1; Mon, 17 Jan 2022 12:32:01 -0500
X-MC-Unique: MawdLP9nPHWGTOGxhTfmnQ-1
Received: by mail-wm1-f72.google.com with SMTP id n14-20020a7bcbce000000b003488820f0d9so277827wmi.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 09:32:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=facGYaN7TmsTdJN/2dDbCbC61s3Aifzqr9lBPbfPM3U=;
        b=VxyrPj1BA+O/o7AktX1YRJB47kTLPD78wMeVaBr9aiDDRSNv49/UWHrNccQJWr8z1h
         nyyw6YDHoiUnvLsGXG0DyF9U6KFcf0npdQPj22UN5pAA6rDkiSMSlPmZtSj/1mvMU5ed
         erLEE3+Ta0/ArNPO06pnnnOhd2mgB9JtzqEHJfJsN1axK/XZsxWWq5R1QanuEZ4tnBuI
         LKlXO9VAAqk9bCB3OiBFYwLaeHRjeLxDtPdGLnt2wYtNrPJAzoUahMMk7nLNV1TbztOB
         PLKuNP8q2ly+peGyrt4Kws7pOKTA/iS9jptPN4eNAyBY8D1j9uO2ay4HtGhwEUSczRK2
         WidA==
X-Gm-Message-State: AOAM533wcrBEdDI50KCwMPLIQQ/1RKe+rW7apeFwxkh29dobrUaPG61m
        HyP1KXRV337MozuAOkKiJjjrCDWpqYmUbTgWHZJFFVt4YO29UthWg1ny423Iv/EmiHEH/s1y/oN
        TMXrl637/2nvauBWPdyrPt5BS
X-Received: by 2002:adf:fdce:: with SMTP id i14mr85549wrs.576.1642440720627;
        Mon, 17 Jan 2022 09:32:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw0Q5fs7xydS2XJIbfrnGOlACwSA2+DribL1EuLT7jO9E41JhIHZo1NMUFoTPYHWcS8gVfxCg==
X-Received: by 2002:adf:fdce:: with SMTP id i14mr85533wrs.576.1642440720414;
        Mon, 17 Jan 2022 09:32:00 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id w7sm13761219wrv.96.2022.01.17.09.31.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jan 2022 09:31:59 -0800 (PST)
Message-ID: <301d4800-5eab-6e21-e8c1-2f87789fc4b9@redhat.com>
Date:   Mon, 17 Jan 2022 18:31:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] KVM: x86/cpuid: Clear XFD for component i if the base
 feature is missing
Content-Language: en-US
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Jing Liu <jing2.liu@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Jim Mattson <jmattson@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220117074531.76925-1-likexu@tencent.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220117074531.76925-1-likexu@tencent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/22 08:45, Like Xu wrote:
> From: Like Xu <likexu@tencent.com>
> 
> According to Intel extended feature disable (XFD) spec, the sub-function i
> (i > 1) of CPUID function 0DH enumerates "details for state component i.
> ECX[2] enumerates support for XFD support for this state component."
> 
> If KVM does not report F(XFD) feature (e.g. due to CONFIG_X86_64),
> then the corresponding XFD support for any state component i
> should also be removed. Translate this dependency into KVM terms.
> 
> Fixes: 690a757d610e ("kvm: x86: Add CPUID support for Intel AMX")
> Signed-off-by: Like Xu <likexu@tencent.com>
> ---
>   arch/x86/kvm/cpuid.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index c55e57b30e81..e96efef4f048 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -886,6 +886,9 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
>   				--array->nent;
>   				continue;
>   			}
> +
> +			if (!kvm_cpu_cap_has(X86_FEATURE_XFD))
> +				entry->ecx &= ~BIT_ULL(2);
>   			entry->edx = 0;
>   		}
>   		break;

Generally this is something that is left to userspace.  Apart from the 
usecase of "call KVM_GET_SUPPORTED_CPUID and pass it to KVM_SET_CPUID2", 
userspace should know what any changed bits mean.

Paolo


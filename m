Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12CE849B80F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 16:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1582756AbiAYPzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 10:55:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58060 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1582698AbiAYPxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 10:53:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643126008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bNm6xJMnoq6zW3mNekeLpnh8KifXaMMeaJAVDRk+IBI=;
        b=ScMmfZClB2HUkfVTdsyhZwEnXPElkniKNx9kRQbinrX66Aq808keCPqRgMmj3fJ4faN9XS
        bEnH0t3aSihfJIpyLwqptCR6RBX5D1V2I+IDRLsTuoR2Pt5kn0w4VMM9sQBhtfMKxkZIl9
        4WUoefVJXa5t6zl0OutUD+WISaIpbew=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-606-K4fDiOY3O5W2XmFacmuoZA-1; Tue, 25 Jan 2022 10:53:27 -0500
X-MC-Unique: K4fDiOY3O5W2XmFacmuoZA-1
Received: by mail-ej1-f70.google.com with SMTP id b12-20020a17090630cc00b006a7190bdfbaso3595512ejb.18
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 07:53:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bNm6xJMnoq6zW3mNekeLpnh8KifXaMMeaJAVDRk+IBI=;
        b=ISUcP6IUKDWVBHq8EMu109t+KyZvZI9/FEmdjDB2p3mj9KC7rGJ6ZwEK++dODJmnvP
         neZrLX9/ypmoF6A/gej0AkqfPGNz5I8yROV195muLo39SCrtO9VAKFovlTtnwqLJNy7c
         fId7AzRJVOdiabuR3+f6+AZS29/ww+0Mg5WBaxuH2auvkIo/mTrN2hywa2jtXfpO3jz4
         0Mta+7FUPRVMJYtE0CSY9r81WhMIDWpZruD4cCFucbBouhvxWdKhttp0t2MHy8n6sn/q
         PXyFleEmC3V91hoMcFxxHX1uNuzyT/bYpE1rDw8MkHlhnXk3qnvDzMITz2QcHBa3hhdx
         4+KQ==
X-Gm-Message-State: AOAM532UfK4Erfuf4P5O0/bgbZXy7uog6yI+KB3u7x7KnKCGfwHeCzOA
        nbvyPLAGclu+CPe4xwJ1ztCBCqwZy8wJP6NpK0TsLPbTk/d3kHlMdUbOsrzGAteqQTYBn7TIf1O
        HHMNDFs12c04PPoXqEiyPFVp4
X-Received: by 2002:a17:907:20ad:: with SMTP id pw13mr16398321ejb.73.1643126005535;
        Tue, 25 Jan 2022 07:53:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz7y8BjckoEZ7cIu9yG4/V2ksHmeMid11visjnsyfjxuoipmJpu/7QfnaghrmqM09p9GLazZA==
X-Received: by 2002:a17:907:20ad:: with SMTP id pw13mr16398296ejb.73.1643126005168;
        Tue, 25 Jan 2022 07:53:25 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id z8sm6351431ejc.151.2022.01.25.07.53.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jan 2022 07:53:24 -0800 (PST)
Message-ID: <efc05e35-b37f-5d9b-d00e-f4f2edc0441b@redhat.com>
Date:   Tue, 25 Jan 2022 16:53:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 2/5] KVM: SVM: hyper-v: Enable Enlightened MSR-Bitmap
 support for real
Content-Language: en-US
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        linux-kernel@vger.kernel.org
References: <20211220152139.418372-1-vkuznets@redhat.com>
 <20211220152139.418372-3-vkuznets@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20211220152139.418372-3-vkuznets@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/20/21 16:21, Vitaly Kuznetsov wrote:
> Commit c4327f15dfc7 ("KVM: SVM: hyper-v: Enlightened MSR-Bitmap support")
> introduced enlightened MSR-Bitmap support for KVM-on-Hyper-V but it didn't
> actually enable the support. Similar to enlightened NPT TLB flush and
> direct TLB flush features, the guest (KVM) has to tell L0 (Hyper-V) that
> it's using the feature by setting the appropriate feature fit in VMCB
> control area (sw reserved fields).
> 
> Fixes: c4327f15dfc7 ("KVM: SVM: hyper-v: Enlightened MSR-Bitmap support")
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>   arch/x86/kvm/svm/svm_onhyperv.h | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/arch/x86/kvm/svm/svm_onhyperv.h b/arch/x86/kvm/svm/svm_onhyperv.h
> index cdbcfc63d171..489ca56212c6 100644
> --- a/arch/x86/kvm/svm/svm_onhyperv.h
> +++ b/arch/x86/kvm/svm/svm_onhyperv.h
> @@ -46,6 +46,9 @@ static inline void svm_hv_init_vmcb(struct vmcb *vmcb)
>   	if (npt_enabled &&
>   	    ms_hyperv.nested_features & HV_X64_NESTED_ENLIGHTENED_TLB)
>   		hve->hv_enlightenments_control.enlightened_npt_tlb = 1;
> +
> +	if (ms_hyperv.nested_features & HV_X64_NESTED_MSR_BITMAP)
> +		hve->hv_enlightenments_control.msr_bitmap = 1;
>   }
>   
>   static inline void svm_hv_hardware_setup(void)

Queued this one for now.

Paolo


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43B7E534D2B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 12:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245428AbiEZKQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 06:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232907AbiEZKQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 06:16:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8C3B1DE93
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 03:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653560211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NEcgtNSPVqH46dnGy7KtC525rBQMD6rVhdUi+/d9+E4=;
        b=EDp57kzMabYmshqL4+TaO5mC2EtrlHPZNPS5dl4/Rw5WQkLNOuS+YbTiU/mF3NJmI6Li/P
        7+Ftzjp0c6wQYzIN4hGhHTqULyX+/z4B7TqMWLO18UhIbCf6IOVIxEOpsG1kTaDcsdIqEU
        VyoL9DF7P9t4qzU1lVy4L2P5NPPOvco=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-612-26dcZxQIMA27PJR_HI6aFA-1; Thu, 26 May 2022 06:16:50 -0400
X-MC-Unique: 26dcZxQIMA27PJR_HI6aFA-1
Received: by mail-ej1-f70.google.com with SMTP id tc8-20020a1709078d0800b006ff04b9bac4so612957ejc.15
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 03:16:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NEcgtNSPVqH46dnGy7KtC525rBQMD6rVhdUi+/d9+E4=;
        b=LYut4kEdzU30HUdspGKevL9uR8/N9lA+mALiYltKJ6BE1jo8lxP8hcaGXrl0jdmFAx
         uw4rWBKUNo3NVSuuAkXIy8PKH620Iln//0cxGWq0L1a/jtY6GxUYukvm3Qe2Z1RmMKtM
         75pwXCx+8JmvG7/Kw0VOa2+cJW2dUzyzMhTgYMPJAQMdsKjplWF/9uxYmgCydko1FawR
         2GptGhaqp9bysF/viWYWJP0F5/wjNcC6ULxykiJLCKNj3OL1FFq34nYN8SiYQrTaKJcn
         ikrl3iMgg+ab2etYY3T2Du0MnC6leZ7cKxKtckXvXzfZEnU3E1O3eptj4/3aBHUfj0kq
         I4/Q==
X-Gm-Message-State: AOAM533Az7yx6xMKKZfNixrjzvn/KKGouhpdlmR+OhVZgJh/glzfaFa8
        tb3EckHE6LKWf6M1niMtWPjZvI72kd4ABQT2Ely9Rs2tpVTuXWXBf00OP82kZwRqNaFxM6qEm04
        6r37q0OFPm5Sg3Iypt89Qn55a
X-Received: by 2002:a17:907:9485:b0:6ff:1012:1b94 with SMTP id dm5-20020a170907948500b006ff10121b94mr6844146ejc.39.1653560209101;
        Thu, 26 May 2022 03:16:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzaFBvLqjttQfZOBiH5gAT3X0rzGq9vNsfQskG7t7W3U9JABao1KA2KuAWcHs1NOym8gFRCUw==
X-Received: by 2002:a17:907:9485:b0:6ff:1012:1b94 with SMTP id dm5-20020a170907948500b006ff10121b94mr6844125ejc.39.1653560208823;
        Thu, 26 May 2022 03:16:48 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id u26-20020a50c2da000000b0042a9fcd7c73sm603592edf.46.2022.05.26.03.16.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 May 2022 03:16:47 -0700 (PDT)
Message-ID: <8b93ec1f-8aa9-c072-b20f-cfa015625120@redhat.com>
Date:   Thu, 26 May 2022 12:16:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] KVM: x86/pmu: Update pmu->pebs_enable_mask with actual
 counter_mask
Content-Language: en-US
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Yanfei Xu <yanfei.xu@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220526085723.91292-1-likexu@tencent.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220526085723.91292-1-likexu@tencent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/22 10:57, Like Xu wrote:
> Subject:
> [PATCH] KVM: x86/pmu: Update pmu->pebs_enable_mask with actual counter_mask
> From:
> Like Xu <like.xu.linux@gmail.com>
> Date:
> 5/26/22, 10:57
> 
> To:
> Paolo Bonzini <pbonzini@redhat.com>
> CC:
> Yanfei Xu <yanfei.xu@intel.com>, Sean Christopherson 
> <seanjc@google.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Wanpeng Li 
> <wanpengli@tencent.com>, Jim Mattson <jmattson@google.com>, Joerg Roedel 
> <joro@8bytes.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
> 
> 
> From: Like Xu<likexu@tencent.com>
> 
> The blamed commit is posted before the PEBS merge in, but is applied after
> the latter is merged in. Fix dependency of pebs_enable_mask on
> a new reusable counter_mask instead of zero-initialized global_ctrl.
> 
> Fixes: 94e05293f839 ("KVM: x86/pmu: Don't overwrite the pmu->global_ctrl when refreshing")
> Signed-off-by: Like Xu<likexu@tencent.com>
> ---
>   arch/x86/kvm/vmx/pmu_intel.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> index ddf837130d1f..72bbcb3f9f8a 100644
> --- a/arch/x86/kvm/vmx/pmu_intel.c
> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> @@ -621,6 +621,7 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>   	struct kvm_cpuid_entry2 *entry;
>   	union cpuid10_eax eax;
>   	union cpuid10_edx edx;
> +	u64 counter_mask;
>   	int i;
>   
>   	pmu->nr_arch_gp_counters = 0;
> @@ -672,8 +673,9 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>   
>   	for (i = 0; i < pmu->nr_arch_fixed_counters; i++)
>   		pmu->fixed_ctr_ctrl_mask &= ~(0xbull << (i * 4));
> -	pmu->global_ctrl_mask = ~(((1ull << pmu->nr_arch_gp_counters) - 1) |
> +	counter_mask = ~(((1ull << pmu->nr_arch_gp_counters) - 1) |
>   		(((1ull << pmu->nr_arch_fixed_counters) - 1) << INTEL_PMC_IDX_FIXED));
> +	pmu->global_ctrl_mask = counter_mask;
>   	pmu->global_ovf_ctrl_mask = pmu->global_ctrl_mask
>   			& ~(MSR_CORE_PERF_GLOBAL_OVF_CTRL_OVF_BUF |
>   			    MSR_CORE_PERF_GLOBAL_OVF_CTRL_COND_CHGD);
> @@ -713,7 +715,7 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>   	if (vcpu->arch.perf_capabilities & PERF_CAP_PEBS_FORMAT) {
>   		vcpu->arch.ia32_misc_enable_msr &= ~MSR_IA32_MISC_ENABLE_PEBS_UNAVAIL;
>   		if (vcpu->arch.perf_capabilities & PERF_CAP_PEBS_BASELINE) {
> -			pmu->pebs_enable_mask = ~pmu->global_ctrl;
> +			pmu->pebs_enable_mask = counter_mask;
>   			pmu->reserved_bits &= ~ICL_EVENTSEL_ADAPTIVE;
>   			for (i = 0; i < pmu->nr_arch_fixed_counters; i++) {
>   				pmu->fixed_ctr_ctrl_mask &=
> -- 2.36.1
> 

Squashed, thanks.

Paolo


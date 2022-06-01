Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D38AE53A27D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 12:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351726AbiFAKXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 06:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245623AbiFAKXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 06:23:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1641C44767
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 03:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654078988;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p9awC6ut2PTSQbGY3p4pWteTXzbAIaEKO51IEMOl7Y8=;
        b=f/SwYRdDOmDyEiIYdRXgO4vdcfHsEhVeRND9LkvW3NAnsufqGWkTzabdl1owVfDbhP+5+A
        dFh2Hhq/o0Mq7662T994ad/4xadusmhV9hnBqzj5w35fQBiBwL1yVOwM+sTe3kS14Lj0WW
        jymb7qmaYDWIxPM8SG1UygvhiM39+3E=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-28-uPKu9w-xPdC1mPE1Hv2_sQ-1; Wed, 01 Jun 2022 06:23:07 -0400
X-MC-Unique: uPKu9w-xPdC1mPE1Hv2_sQ-1
Received: by mail-wm1-f71.google.com with SMTP id o2-20020a05600c510200b0039747b0216fso3147774wms.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 03:23:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=p9awC6ut2PTSQbGY3p4pWteTXzbAIaEKO51IEMOl7Y8=;
        b=MGSoRLUfcRIH8Jz0Ml72BM8CiCW6q1h/rA7DrwgY0EQCKV+D86EuUtkmVh7lgjP2WF
         VE2TsTualYefcZ+Yuw1/nCbzzbHGqc+eyaaTt2MfUrpjVx2+PllwLoy2I4y7502LMTkV
         q0cyxtYteCuLZJtWzIYJKza6VTzoYA6Dt88x+to/GFOLNY79yhynG1Tej8m+4N7zV1oD
         X1mmQfeVbZM/t2opYd8JbwYO2Rm3v6O/Zn/LGA82kdkV16jlAgd5gFxi/6X1tnif6P+e
         fgbBCALHi9+apALfgXbH0F/pj8C9VlRV9r4ji8OpImiv7xgGb98z8SMLmOpedteKe05I
         kmLA==
X-Gm-Message-State: AOAM530GzYexioTpEngwEcfuMlNTy0SGav8S8PKntdacApPROQHCshXO
        Yqj+MEEjh42DKbFreta943SNb6hrv/0Xa/q+nm87zJCMs69fkpN+U0sVGB9w//5dy76lB5vAjet
        HB9thhDNbJxCSf6RqTaaizVoR
X-Received: by 2002:a5d:6c62:0:b0:20f:cd17:a013 with SMTP id r2-20020a5d6c62000000b0020fcd17a013mr43543311wrz.503.1654078985936;
        Wed, 01 Jun 2022 03:23:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyY5EyeMv70h0gHF2VR5cWe1wh3iQD58gFYE3mNODgR24fbmqqmQdriq6eVTkbTYfoFp9Nqyw==
X-Received: by 2002:a5d:6c62:0:b0:20f:cd17:a013 with SMTP id r2-20020a5d6c62000000b0020fcd17a013mr43543286wrz.503.1654078985705;
        Wed, 01 Jun 2022 03:23:05 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id f6-20020a05600c4e8600b0039466988f6csm6126351wmq.31.2022.06.01.03.22.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 03:23:05 -0700 (PDT)
Message-ID: <483f243c-a244-bc77-ede5-000ce73c1cc8@redhat.com>
Date:   Wed, 1 Jun 2022 12:22:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 1/3] KVM: x86/pmu: Accept 0 for absent PMU MSRs when
 host-initiated if !enable_pmu
Content-Language: en-US
To:     Like Xu <like.xu.linux@gmail.com>,
        Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220601031925.59693-1-likexu@tencent.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220601031925.59693-1-likexu@tencent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/22 05:19, Like Xu wrote:
> From: Like Xu <likexu@tencent.com>
> 
> Whenever an MSR is part of KVM_GET_MSR_INDEX_LIST, as is the case for
> MSR_K7_EVNTSEL0 or MSR_F15H_PERF_CTL0, it has to be always retrievable
> and settable with KVM_GET_MSR and KVM_SET_MSR.
> 
> Accept a zero value for these MSRs to obey the contract.
> 
> Signed-off-by: Like Xu <likexu@tencent.com>
> ---
> Note, if !enable_pmu, it is easy to reproduce and verify it with selftest.
> 
>   arch/x86/kvm/pmu.c     |  8 ++++++++
>   arch/x86/kvm/svm/pmu.c | 11 ++++++++++-
>   2 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> index 7a74691de223..3575a3746bf9 100644
> --- a/arch/x86/kvm/pmu.c
> +++ b/arch/x86/kvm/pmu.c
> @@ -439,11 +439,19 @@ static void kvm_pmu_mark_pmc_in_use(struct kvm_vcpu *vcpu, u32 msr)
>   
>   int kvm_pmu_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>   {
> +	if (msr_info->host_initiated && !vcpu->kvm->arch.enable_pmu) {
> +		msr_info->data = 0;
> +		return 0;
> +	}
> +
>   	return static_call(kvm_x86_pmu_get_msr)(vcpu, msr_info);
>   }
>   
>   int kvm_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>   {
> +	if (msr_info->host_initiated && !vcpu->kvm->arch.enable_pmu)
> +		return !!msr_info->data;
> +
>   	kvm_pmu_mark_pmc_in_use(vcpu, msr_info->index);
>   	return static_call(kvm_x86_pmu_set_msr)(vcpu, msr_info);
>   }
> diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
> index 256244b8f89c..fe520b2649b5 100644
> --- a/arch/x86/kvm/svm/pmu.c
> +++ b/arch/x86/kvm/svm/pmu.c
> @@ -182,7 +182,16 @@ static struct kvm_pmc *amd_rdpmc_ecx_to_pmc(struct kvm_vcpu *vcpu,
>   static bool amd_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr, bool host_initiated)
>   {
>   	/* All MSRs refer to exactly one PMC, so msr_idx_to_pmc is enough.  */
> -	return false;
> +	if (!host_initiated)
> +		return false;
> +
> +	switch (msr) {
> +	case MSR_K7_EVNTSEL0 ... MSR_K7_PERFCTR3:
> +	case MSR_F15H_PERF_CTL0 ... MSR_F15H_PERF_CTR5:
> +		return true;
> +	default:
> +		return false;
> +	}
>   }
>   
>   static struct kvm_pmc *amd_msr_idx_to_pmc(struct kvm_vcpu *vcpu, u32 msr)

Queued all three, thanks.

Paolo


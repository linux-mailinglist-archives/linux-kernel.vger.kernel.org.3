Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F8E52D3E4
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 15:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238730AbiESN0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 09:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238726AbiESNZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 09:25:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0DC9764EA
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 06:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652966749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=75Y0NpupHMOFuzVb3xvKt/AKuCsIT0oTLd57CRpCu3M=;
        b=cx7rcvHxi54OUdQHYMtt7jlGhw1f0RoNLXqe5Y6a+LfU8idY8MsFCsKCgb0mYW7ocKgxzP
        V8976Wi87ebPdmdQBgwH2CZSimKl4ORQ+6DBSoIBtQshq44i7VT2e9GjvXix5vo8N55sLs
        NiJRSpFcjfWJaKl16He71zh+2vTUbtM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-244-6m6_6iRXMJWCTenxcRs6OQ-1; Thu, 19 May 2022 09:25:48 -0400
X-MC-Unique: 6m6_6iRXMJWCTenxcRs6OQ-1
Received: by mail-wm1-f69.google.com with SMTP id e9-20020a05600c4e4900b00394779649b1so4527988wmq.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 06:25:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=75Y0NpupHMOFuzVb3xvKt/AKuCsIT0oTLd57CRpCu3M=;
        b=2j9UYZwMbuGN1OOnWV51xPxxkDow3yG1cCaGtuZ0VF2vzu8Ek+3NeLEcmpOKvHztBp
         hTD8ipPyMi6E2lbR59YO1J6GUJGZawLlnNSuEf0n6XA14fLu6KDViUsTFcyuoiSQ6WRc
         auIknRQUk57ReQXQNrM8S6cmbqc+cUc/DVp0jIFBBA7W6gxzjGGS4mTTHgFz2f2FOeQI
         i2xvmdgTgS0ZdqqtBZROAC9gya7hMFIliNNwbcyRWwLMWPJaeHvdqz8jyKPrJ5O6mFCa
         n++pSgq7Rstu6ZudPBadVNWHC4SHNuTOjhOgvYCUGnGshOv/JpAF46VQz4FlzC3rKJrH
         dqjA==
X-Gm-Message-State: AOAM5308yJGXDnWPI+8aSr/Y2nyWWqdttQ3VT1g9/Ix7aUIwRt1Mhm2C
        bMw2WQJYPgmweoqdhW209/41y0Vdkq0QnUbXjeDBKYxWFJvVOOelbVHOBi8y+4zaVDgDVxruqlk
        a2Hc3StjzfVMtGKTptM8d6hN1kxWFU9QJbXgd9Dr0PwVeoj4TxcTjU97z/CA1pyDHod8iMlu301
        U/
X-Received: by 2002:adf:f90d:0:b0:20c:de32:4d35 with SMTP id b13-20020adff90d000000b0020cde324d35mr3966805wrr.583.1652966746891;
        Thu, 19 May 2022 06:25:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx9W9dMYRQYX3UHOU1Zw7N7bebDtVFsqnIveWxprkdMv9F88Yalhrjguy5n7lJT1Kg8HKj30Q==
X-Received: by 2002:adf:f90d:0:b0:20c:de32:4d35 with SMTP id b13-20020adff90d000000b0020cde324d35mr3966782wrr.583.1652966746637;
        Thu, 19 May 2022 06:25:46 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id o16-20020a05600c511000b003942a244ec8sm4618177wms.13.2022.05.19.06.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 06:25:46 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Siddharth Chandrasekaran <sidcha@amazon.de>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 17/34] KVM: x86: hyper-v: Introduce fast
 kvm_hv_l2_tlb_flush_exposed() check
In-Reply-To: <3a4199c0b7ba7cf82c4eadf2881e24be609c2f0d.camel@redhat.com>
References: <20220414132013.1588929-1-vkuznets@redhat.com>
 <20220414132013.1588929-18-vkuznets@redhat.com>
 <3a4199c0b7ba7cf82c4eadf2881e24be609c2f0d.camel@redhat.com>
Date:   Thu, 19 May 2022 15:25:45 +0200
Message-ID: <877d6hu012.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maxim Levitsky <mlevitsk@redhat.com> writes:

> On Thu, 2022-04-14 at 15:19 +0200, Vitaly Kuznetsov wrote:
>> Introduce a helper to quickly check if KVM needs to handle VMCALL/VMMCALL
>> from L2 in L0 to process L2 TLB flush requests.
>> 
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  arch/x86/include/asm/kvm_host.h | 1 +
>>  arch/x86/kvm/hyperv.c           | 6 ++++++
>>  arch/x86/kvm/hyperv.h           | 7 +++++++
>>  3 files changed, 14 insertions(+)
>> 
>> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
>> index ce62fde5f4ff..168600490bd1 100644
>> --- a/arch/x86/include/asm/kvm_host.h
>> +++ b/arch/x86/include/asm/kvm_host.h
>> @@ -616,6 +616,7 @@ struct kvm_vcpu_hv {
>>  		u32 enlightenments_eax; /* HYPERV_CPUID_ENLIGHTMENT_INFO.EAX */
>>  		u32 enlightenments_ebx; /* HYPERV_CPUID_ENLIGHTMENT_INFO.EBX */
>>  		u32 syndbg_cap_eax; /* HYPERV_CPUID_SYNDBG_PLATFORM_CAPABILITIES.EAX */
>> +		u32 nested_features_eax; /* HYPERV_CPUID_NESTED_FEATURES.EAX */
>>  	} cpuid_cache;
>>  
>>  	struct kvm_vcpu_hv_tlb_flush_ring tlb_flush_ring[HV_NR_TLB_FLUSH_RINGS];
>> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
>> index 79aabe0c33ec..68a0df4e3f66 100644
>> --- a/arch/x86/kvm/hyperv.c
>> +++ b/arch/x86/kvm/hyperv.c
>> @@ -2281,6 +2281,12 @@ void kvm_hv_set_cpuid(struct kvm_vcpu *vcpu)
>>  		hv_vcpu->cpuid_cache.syndbg_cap_eax = entry->eax;
>>  	else
>>  		hv_vcpu->cpuid_cache.syndbg_cap_eax = 0;
>> +
>> +	entry = kvm_find_cpuid_entry(vcpu, HYPERV_CPUID_NESTED_FEATURES, 0);
>> +	if (entry)
>> +		hv_vcpu->cpuid_cache.nested_features_eax = entry->eax;
>> +	else
>> +		hv_vcpu->cpuid_cache.nested_features_eax = 0;
>>  }
>>  
>>  int kvm_hv_set_enforce_cpuid(struct kvm_vcpu *vcpu, bool enforce)
>> diff --git a/arch/x86/kvm/hyperv.h b/arch/x86/kvm/hyperv.h
>> index f593c9fd1dee..d8cb6d70dbc8 100644
>> --- a/arch/x86/kvm/hyperv.h
>> +++ b/arch/x86/kvm/hyperv.h
>> @@ -168,6 +168,13 @@ static inline void kvm_hv_vcpu_empty_flush_tlb(struct kvm_vcpu *vcpu)
>>  	tlb_flush_ring->read_idx = tlb_flush_ring->write_idx;
>>  }
>>  
>> +static inline bool kvm_hv_l2_tlb_flush_exposed(struct kvm_vcpu *vcpu)
>> +{
>> +	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
>> +
>> +	return hv_vcpu && (hv_vcpu->cpuid_cache.nested_features_eax & HV_X64_NESTED_DIRECT_FLUSH);
>> +}
>
> Tiny nipick (feel free to ignore): maybe use 'supported' instead of 'exposed',
> as we don't use this term in KVM often.
>

Indeed we don't. Basically, this is guest_cpuid_has() but for a Hyper-V
bit. I don't quite like 'supported' because we don't actually check
whether KVM or even L1 guest 'support' this feature or not, we check
whether the feature was 'exposed' to L1 so it can actually use it. I'm
going to rename this to

 guest_hv_cpuid_has_l2_tlb_flush()

then.

> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
>

Thanks!

-- 
Vitaly


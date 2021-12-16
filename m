Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA3F5476CCF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 10:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbhLPJEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 04:04:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:22972 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230471AbhLPJES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 04:04:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639645457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tZhTMufb5TDr0HROe0gasaq3hdYpRz0U7Ca0yUIOZ0M=;
        b=P2DV1Xy2mqZ6A/H6FAQnp7WxFO9AleNojx1vk9AXMLoxXPY27XtJyK96P4+4QnOQZyxYfy
        Ha3b6kWKddVt+xUY8g5aA+xSxLgAR2+FcxvPYph7N+1W1jBmGfFbxMDSubluJF2sokqBpz
        GEQAF3kLNvsL9NF1wQwmr9TDkV7TUxI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-99-EFmLAUv-NAardNs8DMEYjw-1; Thu, 16 Dec 2021 04:04:16 -0500
X-MC-Unique: EFmLAUv-NAardNs8DMEYjw-1
Received: by mail-wm1-f69.google.com with SMTP id j25-20020a05600c1c1900b00332372c252dso10027611wms.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 01:04:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=tZhTMufb5TDr0HROe0gasaq3hdYpRz0U7Ca0yUIOZ0M=;
        b=ngZt7ylWe2BuIspO3X+mYj6ZxuLFIL74FMCyZS/lLvg1qMYQPmVd2HT/OfCle/vkpd
         12jQzRBu+eP465JmVQSzkGm+FQwVKqRTGe1bYg7l9ijOdkEf7lZiRO18484tHg1vNpjl
         VGhZsID/QQG/2DLHT7HOb8ZLcaT4l+7Sz/cdVicV6+qxGHv6B8thM/OOgMGbtboeRhuF
         xNiMO/bjIqc99MkAZWQvu2cbRyDfbQD/ZmxNk0/gyKsZOr0tL4WS7VisTXH3X/MtpA3n
         8wkPAj2aWsmMBz92Qb/WevSraNSlbqUIHAVRiN8L+WvYIvqAbCB7cKEQY6bVrwZdAvrO
         X2wQ==
X-Gm-Message-State: AOAM5317JSperFDlUOrbTgck0MvSHx3emMNNIjXtOBw2YLvYOAkq+7nZ
        vVRT9c0+1QS878bOk+u/liPi1jtQJ0NmJwl4hF4n5RLnq5h/iZiIyi2otxdl5CVn/d7hWUiH2yk
        QeuQ7b9kEemiwLSdq3hMKY85GSmn43G4S5XMnt++DYF5yL7xCzjr7t/2AXQdoM5RLSaqJHuJzZW
        qT
X-Received: by 2002:a5d:628f:: with SMTP id k15mr8038304wru.363.1639645455231;
        Thu, 16 Dec 2021 01:04:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwgCGHljKgiTzLfzmiTtVNFv0ympIDiddV9l4IhRFYPM9co5771zBvmQqteXAfU++G9t0t9Nw==
X-Received: by 2002:a5d:628f:: with SMTP id k15mr8038273wru.363.1639645454949;
        Thu, 16 Dec 2021 01:04:14 -0800 (PST)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id o4sm8476455wmq.31.2021.12.16.01.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 01:04:14 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>, oliver.sang@intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: selftests: Avoid KVM_SET_CPUID2 after KVM_RUN in
 vmx_pmu_msrs_test
In-Reply-To: <YbotG5neKyzhv22Z@google.com>
References: <20211215161617.246563-1-vkuznets@redhat.com>
 <YbotG5neKyzhv22Z@google.com>
Date:   Thu, 16 Dec 2021 10:04:13 +0100
Message-ID: <87a6h0vs36.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> On Wed, Dec 15, 2021, Vitaly Kuznetsov wrote:
>> Commit feb627e8d6f6 ("KVM: x86: Forbid KVM_SET_CPUID{,2} after KVM_RUN")
>> forbade chaning vCPU's CPUID data after the first KVM_RUN but
>> vmx_pmu_msrs_test does exactly that. Test VM needs to be re-created after
>> vcpu_run().
>> 
>> Reported-by: kernel test robot <oliver.sang@intel.com>
>> Fixes: feb627e8d6f6 ("KVM: x86: Forbid KVM_SET_CPUID{,2} after KVM_RUN")
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  tools/testing/selftests/kvm/x86_64/vmx_pmu_msrs_test.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>> 
>> diff --git a/tools/testing/selftests/kvm/x86_64/vmx_pmu_msrs_test.c b/tools/testing/selftests/kvm/x86_64/vmx_pmu_msrs_test.c
>> index 23051d84b907..17882f79deed 100644
>> --- a/tools/testing/selftests/kvm/x86_64/vmx_pmu_msrs_test.c
>> +++ b/tools/testing/selftests/kvm/x86_64/vmx_pmu_msrs_test.c
>> @@ -99,6 +99,11 @@ int main(int argc, char *argv[])
>>  	vcpu_run(vm, VCPU_ID);
>>  	ASSERT_EQ(vcpu_get_msr(vm, VCPU_ID, MSR_IA32_PERF_CAPABILITIES), PMU_CAP_FW_WRITES);
>>  
>> +	/* Re-create guest VM after KVM_RUN so CPUID can be changed */
>> +	kvm_vm_free(vm);
>> +	vm = vm_create_default(VCPU_ID, 0, guest_code);
>> +	vcpu_set_cpuid(vm, VCPU_ID, cpuid);
>
> Why is this test even setting CPUID for the below cases?  Guest CPUID shouldn't
> affect host_initiated writes.  This part in particular looks wrong:
>
> 	entry_1_0->ecx |= X86_FEATURE_PDCM;
> 	eax.split.version_id = 0;
> 	entry_1_0->ecx = eax.full;
> 	vcpu_set_cpuid(vm, VCPU_ID, cpuid);
> 	ret = _vcpu_set_msr(vm, 0, MSR_IA32_PERF_CAPABILITIES, PMU_CAP_FW_WRITES);
> 	TEST_ASSERT(ret == 0, "Bad PERF_CAPABILITIES didn't fail.");
>
> As does the KVM code.

I admit my natural laziness and thanks for going the extra mile here!

> The WRMSR path for MSR_IA32_PERF_CAPABILITIES looks especially
> wrong, as rejects a bad write iff userspace set PDCM in guest CPUID.
>
> 		struct kvm_msr_entry msr_ent = {.index = msr, .data = 0};
>
> 		if (!msr_info->host_initiated)
> 			return 1;
> 		if (guest_cpuid_has(vcpu, X86_FEATURE_PDCM) && kvm_get_msr_feature(&msr_ent))  <===== Huh?
> 			return 1;
> 		if (data & ~msr_ent.data)
> 			return 1;
>
> 		vcpu->arch.perf_capabilities = data;
>
> 		return 0;
> 		}
>
> So I think we should fix KVM and then clean up the test accordingly.
>
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 85127b3e3690..65e297875405 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -3424,7 +3424,7 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>
>                 if (!msr_info->host_initiated)
>                         return 1;
> -               if (guest_cpuid_has(vcpu, X86_FEATURE_PDCM) && kvm_get_msr_feature(&msr_ent))
> +               if (kvm_get_msr_feature(&msr_ent))
>                         return 1;
>                 if (data & ~msr_ent.data)
>                         return 1;

This looks OK.

> @@ -3779,14 +3779,12 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>                 msr_info->data = vcpu->arch.microcode_version;
>                 break;
>         case MSR_IA32_ARCH_CAPABILITIES:
> -               if (!msr_info->host_initiated &&
> -                   !guest_cpuid_has(vcpu, X86_FEATURE_ARCH_CAPABILITIES))
> +               if (!msr_info->host_initiated)
>                         return 1;
>                 msr_info->data = vcpu->arch.arch_capabilities;
>                 break;
>         case MSR_IA32_PERF_CAPABILITIES:
> -               if (!msr_info->host_initiated &&
> -                   !guest_cpuid_has(vcpu, X86_FEATURE_PDCM))
> +               if (!msr_info->host_initiated)
>                         return 1;
>                 msr_info->data = vcpu->arch.perf_capabilities;
>                 break;
>

Hm, this change will unconditionally forbid reading
MSR_IA32_ARCH_CAPABILITIES/MSR_IA32_PERF_CAPABILITIES from the guest. Is
this what we want?

>> +
>>  	/* testcase 2, check valid LBR formats are accepted */
>>  	vcpu_set_msr(vm, 0, MSR_IA32_PERF_CAPABILITIES, 0);
>>  	ASSERT_EQ(vcpu_get_msr(vm, VCPU_ID, MSR_IA32_PERF_CAPABILITIES), 0);
>> -- 
>> 2.33.1
>> 
>

-- 
Vitaly


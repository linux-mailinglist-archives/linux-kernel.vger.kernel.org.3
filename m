Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14E6B47600D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 19:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245411AbhLOSAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 13:00:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245258AbhLOSAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 13:00:00 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7FA5C06173E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 09:59:59 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id a23so16158482pgm.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 09:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ggAc5NwHgbAF9NQ5yQbvGZ42z1DyZ9O0jHYH8xXLJJE=;
        b=UHNgNEZTROoPzSn3k142OQynuy8gPCqn4AiAb4DazbLBufkSpzd1vMbjoggiyDC6aT
         EeM9/gE32ezen5sRZioO00/E5LYmlXZen96XCBNsX+NiUYvhm3jOl42pcqOIUWLZiA0s
         zIUHCbZdif/Rk7PRC9FRftqmK9r4oWvCtPVGk1i1Z9ykghyzKcQndXVhTk2BR/KtPzX8
         KMcubm/1lVycqfNdtzlFNKTo23pYLIWnq37lwzFS66lVPdV+VsjqT+EcX1LHxMicpemD
         ut0OyySFVM/MNSnjAIUWbxnagHU6bO1a29hB93XBgKxu7uNv7iL+sW4SBviPyPp6gtZw
         TK2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ggAc5NwHgbAF9NQ5yQbvGZ42z1DyZ9O0jHYH8xXLJJE=;
        b=3A4MLDJVVEXF0k2HVBbh/TTjdkAP9dT1ptBDQYBuR8cTRTr1p5TGcJBiu4kS/O7OiX
         mSQF/U0dERs9TyChx74HE41TVdrGa887DJDTwzoODl3sdfjeAe4UnwTogv9uEOeEKgeJ
         JVY+FA52eWvmYFsLSTAcpDUsflOBdiV18mWLU14eyEC+06/hDsnPhRvOBzQGfsQExoa/
         ZEqyjI27K1Ovxdnvp59+iNUXsuGN4F+NSvqaBAMmdl05/wy+bx26tW7MQVZ2P1o3RCVB
         oMDh48IR+6oY2ZeXSzziITh6NhhEAIOymiRu/jyIIFlXgLFETF+8tlcjwhE9gLRiAik2
         uDPA==
X-Gm-Message-State: AOAM531dhnfJaFH0kF6m0rDjJD4DXUor9AEYjb+VK6wjEtO4bjKi/xal
        Yx4C3skJcGrHj11x0fFUyl7cTw==
X-Google-Smtp-Source: ABdhPJxZITx/2X7Ak7nVdnVGM6felhmNd0m69P7830XVD/z43avptEodeKdGFY58zQdQ8Zv4aehUWg==
X-Received: by 2002:a63:f443:: with SMTP id p3mr8634580pgk.385.1639591199160;
        Wed, 15 Dec 2021 09:59:59 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id z22sm3645466pfe.93.2021.12.15.09.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 09:59:58 -0800 (PST)
Date:   Wed, 15 Dec 2021 17:59:55 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>, oliver.sang@intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: selftests: Avoid KVM_SET_CPUID2 after KVM_RUN in
 vmx_pmu_msrs_test
Message-ID: <YbotG5neKyzhv22Z@google.com>
References: <20211215161617.246563-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215161617.246563-1-vkuznets@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021, Vitaly Kuznetsov wrote:
> Commit feb627e8d6f6 ("KVM: x86: Forbid KVM_SET_CPUID{,2} after KVM_RUN")
> forbade chaning vCPU's CPUID data after the first KVM_RUN but
> vmx_pmu_msrs_test does exactly that. Test VM needs to be re-created after
> vcpu_run().
> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Fixes: feb627e8d6f6 ("KVM: x86: Forbid KVM_SET_CPUID{,2} after KVM_RUN")
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  tools/testing/selftests/kvm/x86_64/vmx_pmu_msrs_test.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/x86_64/vmx_pmu_msrs_test.c b/tools/testing/selftests/kvm/x86_64/vmx_pmu_msrs_test.c
> index 23051d84b907..17882f79deed 100644
> --- a/tools/testing/selftests/kvm/x86_64/vmx_pmu_msrs_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/vmx_pmu_msrs_test.c
> @@ -99,6 +99,11 @@ int main(int argc, char *argv[])
>  	vcpu_run(vm, VCPU_ID);
>  	ASSERT_EQ(vcpu_get_msr(vm, VCPU_ID, MSR_IA32_PERF_CAPABILITIES), PMU_CAP_FW_WRITES);
>  
> +	/* Re-create guest VM after KVM_RUN so CPUID can be changed */
> +	kvm_vm_free(vm);
> +	vm = vm_create_default(VCPU_ID, 0, guest_code);
> +	vcpu_set_cpuid(vm, VCPU_ID, cpuid);

Why is this test even setting CPUID for the below cases?  Guest CPUID shouldn't
affect host_initiated writes.  This part in particular looks wrong:

	entry_1_0->ecx |= X86_FEATURE_PDCM;
	eax.split.version_id = 0;
	entry_1_0->ecx = eax.full;
	vcpu_set_cpuid(vm, VCPU_ID, cpuid);
	ret = _vcpu_set_msr(vm, 0, MSR_IA32_PERF_CAPABILITIES, PMU_CAP_FW_WRITES);
	TEST_ASSERT(ret == 0, "Bad PERF_CAPABILITIES didn't fail.");

As does the KVM code.  The WRMSR path for MSR_IA32_PERF_CAPABILITIES looks especially
wrong, as rejects a bad write iff userspace set PDCM in guest CPUID.

		struct kvm_msr_entry msr_ent = {.index = msr, .data = 0};

		if (!msr_info->host_initiated)
			return 1;
		if (guest_cpuid_has(vcpu, X86_FEATURE_PDCM) && kvm_get_msr_feature(&msr_ent))  <===== Huh?
			return 1;
		if (data & ~msr_ent.data)
			return 1;

		vcpu->arch.perf_capabilities = data;

		return 0;
		}

So I think we should fix KVM and then clean up the test accordingly.

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 85127b3e3690..65e297875405 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3424,7 +3424,7 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)

                if (!msr_info->host_initiated)
                        return 1;
-               if (guest_cpuid_has(vcpu, X86_FEATURE_PDCM) && kvm_get_msr_feature(&msr_ent))
+               if (kvm_get_msr_feature(&msr_ent))
                        return 1;
                if (data & ~msr_ent.data)
                        return 1;
@@ -3779,14 +3779,12 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
                msr_info->data = vcpu->arch.microcode_version;
                break;
        case MSR_IA32_ARCH_CAPABILITIES:
-               if (!msr_info->host_initiated &&
-                   !guest_cpuid_has(vcpu, X86_FEATURE_ARCH_CAPABILITIES))
+               if (!msr_info->host_initiated)
                        return 1;
                msr_info->data = vcpu->arch.arch_capabilities;
                break;
        case MSR_IA32_PERF_CAPABILITIES:
-               if (!msr_info->host_initiated &&
-                   !guest_cpuid_has(vcpu, X86_FEATURE_PDCM))
+               if (!msr_info->host_initiated)
                        return 1;
                msr_info->data = vcpu->arch.perf_capabilities;
                break;

> +
>  	/* testcase 2, check valid LBR formats are accepted */
>  	vcpu_set_msr(vm, 0, MSR_IA32_PERF_CAPABILITIES, 0);
>  	ASSERT_EQ(vcpu_get_msr(vm, VCPU_ID, MSR_IA32_PERF_CAPABILITIES), 0);
> -- 
> 2.33.1
> 

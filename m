Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDD634D5AFC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346912AbiCKF4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 00:56:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346385AbiCKFx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:53:27 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2031F11AA
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:52:22 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id 9-20020a630509000000b0037c8607d296so4213765pgf.22
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=qNHxLuoAyv4DnFmFmSk7rckTIqCWdXG9wIHiYiVPFF8=;
        b=svN7FdfTZzjDmegUq4EAKPhLCe1UY+82AzltGqxG7LOdhTbNfVypJEo1q5HuuhsXZJ
         kZVAo35B5Ju/srfXtsIH4ao2c9uLhqcvrmVJB/JDdHEBQ92YMtYEItHnfnbfQLYuY7O2
         oOasmx5EYjpbsFfRHUF8AbSQdKrwNu67CKHX6eTqgFHwCTvPfDMqeiZPWr9E1tDXb21p
         Ut1bvpl6/qEi5kZnh0LClNKySwNy/Nv4a5NWEnys1xkhGY2n9iCmZgsxEJqNUf4T48xB
         cT6Ueq1jmpM7X66fQUi8lxpd3MW3NppB1EI3NoxnY2xX67eEyv5S6k7SOdMl2XsKHtL/
         AsxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=qNHxLuoAyv4DnFmFmSk7rckTIqCWdXG9wIHiYiVPFF8=;
        b=hBBZfMQBe8FHxToBfnrciQlV/EVTssLSoKkqEs1Qc47RQvRCIz2ha0/gLiipYmi2Zz
         +FOH1wqcRDJhe3vYpW0Mm800E4P57bR4J0POfl7PBHMryEv8t16ihiw2zLSFBCh64fKq
         AeSMsC80ncL4sFpJrsuhVhsIRw2Rijb3JyScaqMEkHsmM+DJSU3QFhsewqpbMxW4wlDq
         /C4bxL9rAI9ZShc+2/iPIXP/reLpuD5uVwduQ0BRWeAOZHKmoyCB7LapNMm9jGJX1eR0
         5/3l7tE7I7MIhlTm76Q5aQTnLvHBNRH5GHGVmdWWjgWDntHJ/9UCjOsag/8F11j83YCM
         gt3g==
X-Gm-Message-State: AOAM530IlIMpkzBQsE/r8I2BJre4wVURhwAYPYoKFRmte6Km0hHqsHJ7
        916aj++Oy6foDLcn/T5TmVeQhNmuiDeV2PrsXeRnaT1MNSSJ9fCPgkY5Gi7Ee8YaQZQ4+BpR7F4
        BgSwNPwbJMX7tfJNdIK8FbBgdMcRLAvyO79jy/SZvr3OntIq0DWsDFCNDEUmcCT+DVJCF0w==
X-Google-Smtp-Source: ABdhPJxGrx2+pbshWIZ3v4K9JdE2MynM19YE3vpbN1xfolqTNevcDNgqjUmDXN3wL59ejqw9nu1B+avi+/E=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90b:1e10:b0:1bf:6c78:54a9 with SMTP id
 pg16-20020a17090b1e1000b001bf6c7854a9mr460700pjb.1.1646977941881; Thu, 10 Mar
 2022 21:52:21 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:49:56 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-46-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 045/105] KVM: selftests: Convert hyperv_cpuid away from VCPU_ID
From:   Sean Christopherson <seanjc@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/x86_64/hyperv_cpuid.c       | 23 +++++++++----------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c b/tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c
index 896e1e7c1df7..d1a22ee98cf3 100644
--- a/tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c
+++ b/tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c
@@ -20,8 +20,6 @@
 #include "processor.h"
 #include "vmx.h"
 
-#define VCPU_ID 0
-
 static void guest_code(void)
 {
 }
@@ -115,25 +113,26 @@ static void test_hv_cpuid(struct kvm_cpuid2 *hv_cpuid_entries,
 	}
 }
 
-void test_hv_cpuid_e2big(struct kvm_vm *vm, bool system)
+void test_hv_cpuid_e2big(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
 {
 	static struct kvm_cpuid2 cpuid = {.nent = 0};
 	int ret;
 
-	if (!system)
-		ret = __vcpu_ioctl(vm, VCPU_ID, KVM_GET_SUPPORTED_HV_CPUID, &cpuid);
+	if (vcpu)
+		ret = __vcpu_ioctl(vm, vcpu->id, KVM_GET_SUPPORTED_HV_CPUID, &cpuid);
 	else
 		ret = __kvm_ioctl(vm_get_kvm_fd(vm), KVM_GET_SUPPORTED_HV_CPUID, &cpuid);
 
 	TEST_ASSERT(ret == -1 && errno == E2BIG,
 		    "%s KVM_GET_SUPPORTED_HV_CPUID didn't fail with -E2BIG when"
-		    " it should have: %d %d", system ? "KVM" : "vCPU", ret, errno);
+		    " it should have: %d %d", !vcpu ? "KVM" : "vCPU", ret, errno);
 }
 
 int main(int argc, char *argv[])
 {
 	struct kvm_vm *vm;
 	struct kvm_cpuid2 *hv_cpuid_entries;
+	struct kvm_vcpu *vcpu;
 
 	/* Tell stdout not to buffer its content */
 	setbuf(stdout, NULL);
@@ -143,12 +142,12 @@ int main(int argc, char *argv[])
 		exit(KSFT_SKIP);
 	}
 
-	vm = vm_create_default(VCPU_ID, 0, guest_code);
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
 
 	/* Test vCPU ioctl version */
-	test_hv_cpuid_e2big(vm, false);
+	test_hv_cpuid_e2big(vm, vcpu);
 
-	hv_cpuid_entries = vcpu_get_supported_hv_cpuid(vm, VCPU_ID);
+	hv_cpuid_entries = vcpu_get_supported_hv_cpuid(vm, vcpu->id);
 	test_hv_cpuid(hv_cpuid_entries, false);
 	free(hv_cpuid_entries);
 
@@ -157,8 +156,8 @@ int main(int argc, char *argv[])
 		print_skip("Enlightened VMCS is unsupported");
 		goto do_sys;
 	}
-	vcpu_enable_evmcs(vm, VCPU_ID);
-	hv_cpuid_entries = vcpu_get_supported_hv_cpuid(vm, VCPU_ID);
+	vcpu_enable_evmcs(vm, vcpu->id);
+	hv_cpuid_entries = vcpu_get_supported_hv_cpuid(vm, vcpu->id);
 	test_hv_cpuid(hv_cpuid_entries, true);
 	free(hv_cpuid_entries);
 
@@ -169,7 +168,7 @@ int main(int argc, char *argv[])
 		goto out;
 	}
 
-	test_hv_cpuid_e2big(vm, true);
+	test_hv_cpuid_e2big(vm, NULL);
 
 	hv_cpuid_entries = kvm_get_supported_hv_cpuid();
 	test_hv_cpuid(hv_cpuid_entries, nested_vmx_supported());
-- 
2.35.1.723.g4982287a31-goog


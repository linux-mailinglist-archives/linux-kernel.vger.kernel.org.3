Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89824D5AED
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346808AbiCKFzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 00:55:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346672AbiCKFxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:53:07 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFDB8ECB30
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:52:05 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id p15-20020a17090a748f00b001bf3ba2ae95so4694968pjk.9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=F7WunbLiKS/wqkMxeA4n9Mz5mHg6sYejl2gq2yFp4zY=;
        b=atD/qZ+53Jwm+gU4v6bfw8wwiWlESo+4csu5HtcfwYavf4FtNNsAIwNLtOTPaiej9+
         74/JrXUUrGmjiXslHVs8+hlRHeX9XPnZTV6SBdmuwtI9h3F4ZRnUTbFtVcAcbEirhrPx
         nk5eDXL6rvJwD517aj8lbP1Yzi+06+4BAjsWUrb+ewdcsiwH2JeXUMk79ZPV95JyvjU7
         3kUQG2Dghn/nhJN7e9Zryslqaq4efvd1xMkxjUF6s3i/5PKHCZN9WDLxiYYxDHNJLhP3
         OeuFAR8HDELsLCTY/OLTuYh2AN6V7cDwbV9oVyI0sVNqrQ6xTljnBUP1qbjrbqApHr7r
         7QDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=F7WunbLiKS/wqkMxeA4n9Mz5mHg6sYejl2gq2yFp4zY=;
        b=TDSxePx5CSPdeTem3rI3tgcdXI7YTawmZMny+O+AZOAIOH+RELNXDXKe1dD1maxAx5
         o/cgRvG7vsCOwMq5j1GASf8p0w8TkylvJbU+mtMB2YLLssrfzW5vrrsqszgEw6Rp3GbU
         rcYCu7Gx2uTbYxXgb1kETLC2T8tB09tTQq19cJil5F0Jsv2tgDsCH1CWAazLFL9d8tja
         NiQocumF/oO+f8Hlca5vpbD9D/fde8bH6p8HetfVa8ALv28axtP+O+Jgd1f/3TlUY3/g
         nz2mytw5ghDbF1a1HXVCx9dH0UYTnk59PBAxyei6kv2D86U5VGimLuI2LDjd7PUN+ej+
         Hz7Q==
X-Gm-Message-State: AOAM532cpW3lzMRSJmEBmSIaKwteUbOEFglb9e225WGKCdBhKygYuXmm
        d7I2U2z7nUnKx00D2CTdHaEE/5xoPCUZR4/NWST2CIw2XD4gQo0v6rhvBCO3M9N0jQc7UONAlMa
        xJ+pbT8mIYAe2Kt9+C3UTOgZ3Y4PmEtqSaH7Cs4bNQSJ1fvHfo879Kv0GwC2RXP/9QZl0ag==
X-Google-Smtp-Source: ABdhPJyEzh3xDiW+Qhe0DkksBdU9lVC32o7WAdXJZm9d1ipPIPPXjkEG4T4fU0qz7vGC9Yh9zarRt4zuA/k=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:1f0c:b0:4f6:fee8:7c8c with SMTP id
 be12-20020a056a001f0c00b004f6fee87c8cmr8716777pfb.60.1646977925169; Thu, 10
 Mar 2022 21:52:05 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:49:46 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-36-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 035/105] KVM: selftests: Convert vmx_pmu_msrs_test away
 from VCPU_ID
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
 .../selftests/kvm/x86_64/vmx_pmu_msrs_test.c  | 25 +++++++++----------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/vmx_pmu_msrs_test.c b/tools/testing/selftests/kvm/x86_64/vmx_pmu_msrs_test.c
index 2454a1f2ca0c..7bb81b7a4825 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_pmu_msrs_test.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_pmu_msrs_test.c
@@ -18,8 +18,6 @@
 #include "kvm_util.h"
 #include "vmx.h"
 
-#define VCPU_ID	      0
-
 #define X86_FEATURE_PDCM	(1<<15)
 #define PMU_CAP_FW_WRITES	(1ULL << 13)
 #define PMU_CAP_LBR_FMT		0x3f
@@ -62,6 +60,7 @@ int main(int argc, char *argv[])
 	struct kvm_cpuid_entry2 *entry_a_0;
 	bool pdcm_supported = false;
 	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
 	int ret;
 	union cpuid10_eax eax;
 	union perf_capabilities host_cap;
@@ -70,7 +69,7 @@ int main(int argc, char *argv[])
 	host_cap.capabilities &= (PMU_CAP_FW_WRITES | PMU_CAP_LBR_FMT);
 
 	/* Create VM */
-	vm = vm_create_default(VCPU_ID, 0, guest_code);
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
 	cpuid = kvm_get_supported_cpuid();
 
 	if (kvm_get_cpuid_max_basic() >= 0xa) {
@@ -89,25 +88,25 @@ int main(int argc, char *argv[])
 	}
 
 	/* testcase 1, set capabilities when we have PDCM bit */
-	vcpu_set_cpuid(vm, VCPU_ID, cpuid);
-	vcpu_set_msr(vm, 0, MSR_IA32_PERF_CAPABILITIES, PMU_CAP_FW_WRITES);
+	vcpu_set_cpuid(vm, vcpu->id, cpuid);
+	vcpu_set_msr(vm, vcpu->id, MSR_IA32_PERF_CAPABILITIES, PMU_CAP_FW_WRITES);
 
 	/* check capabilities can be retrieved with KVM_GET_MSR */
-	ASSERT_EQ(vcpu_get_msr(vm, VCPU_ID, MSR_IA32_PERF_CAPABILITIES), PMU_CAP_FW_WRITES);
+	ASSERT_EQ(vcpu_get_msr(vm, vcpu->id, MSR_IA32_PERF_CAPABILITIES), PMU_CAP_FW_WRITES);
 
 	/* check whatever we write with KVM_SET_MSR is _not_ modified */
-	vcpu_run(vm, VCPU_ID);
-	ASSERT_EQ(vcpu_get_msr(vm, VCPU_ID, MSR_IA32_PERF_CAPABILITIES), PMU_CAP_FW_WRITES);
+	vcpu_run(vm, vcpu->id);
+	ASSERT_EQ(vcpu_get_msr(vm, vcpu->id, MSR_IA32_PERF_CAPABILITIES), PMU_CAP_FW_WRITES);
 
 	/* testcase 2, check valid LBR formats are accepted */
-	vcpu_set_msr(vm, 0, MSR_IA32_PERF_CAPABILITIES, 0);
-	ASSERT_EQ(vcpu_get_msr(vm, VCPU_ID, MSR_IA32_PERF_CAPABILITIES), 0);
+	vcpu_set_msr(vm, vcpu->id, MSR_IA32_PERF_CAPABILITIES, 0);
+	ASSERT_EQ(vcpu_get_msr(vm, vcpu->id, MSR_IA32_PERF_CAPABILITIES), 0);
 
-	vcpu_set_msr(vm, 0, MSR_IA32_PERF_CAPABILITIES, host_cap.lbr_format);
-	ASSERT_EQ(vcpu_get_msr(vm, VCPU_ID, MSR_IA32_PERF_CAPABILITIES), (u64)host_cap.lbr_format);
+	vcpu_set_msr(vm, vcpu->id, MSR_IA32_PERF_CAPABILITIES, host_cap.lbr_format);
+	ASSERT_EQ(vcpu_get_msr(vm, vcpu->id, MSR_IA32_PERF_CAPABILITIES), (u64)host_cap.lbr_format);
 
 	/* testcase 3, check invalid LBR format is rejected */
-	ret = _vcpu_set_msr(vm, 0, MSR_IA32_PERF_CAPABILITIES, PMU_CAP_LBR_FMT);
+	ret = _vcpu_set_msr(vm, vcpu->id, MSR_IA32_PERF_CAPABILITIES, PMU_CAP_LBR_FMT);
 	TEST_ASSERT(ret == 0, "Bad PERF_CAPABILITIES didn't fail.");
 
 	kvm_vm_free(vm);
-- 
2.35.1.723.g4982287a31-goog


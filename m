Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E6D51B300
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 01:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379356AbiEDW53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 18:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379554AbiEDWy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 18:54:29 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B334C796
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 15:50:51 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id z15-20020a25bb0f000000b00613388c7d99so2313260ybg.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 15:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=41MFWSn9Yl6hbCTo9P/xgE3nL1nRp5u5Ax8EGSNS3To=;
        b=mg+ni1fHQIFVdmOLrVP23CuhSqYN/GU3SofLUYcUynGXD3F8g73TVY9cUkwGxGXQ7X
         O7GAbNdcrLm7Jk43X+20FDzfi614UpDzJIf1PNlT0A4crnqswuzB0bis8u3la09kyrsK
         iF3nR9+xhJIdjt04plGyw0ppp4p4z5w6wSzJWy2aNrz59ZqytaoXgvpjcfXrRq7kW5Bb
         nYNjJ+jriFhbeDAOxSzPwtwH4/ZqEuM14uiBlc8/4d4nv+fLjJYK/MGfoGNTZJvasRTT
         RFA2wxGmOCK4kLEJ6CTaDbMZcmBKTZ8FKPrmpfGH0CZiNJ6i8NfWD+t/BnJRDSLj8I6L
         9saQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=41MFWSn9Yl6hbCTo9P/xgE3nL1nRp5u5Ax8EGSNS3To=;
        b=BKfI5nlv0wP7OFob6O35O8ORzROOCQJgMIC46oFr+ALAwHSfUxno//9W9DJrSMGXgc
         hvHpZ8ekp77HNXguvkcjTx/T6beh/SG8MgEoirPJvg1DKFmwkySYMXgEUcpjZvGBkqd7
         c226zyb/vBjUwR9ctf6tUkqV4Hw+84SYYV64HnrMwoULwGw9h1zHurN15lUDPQ6rhABD
         Lgq9yyEgZeUOQLau1zAD6e+r/xhNPkAfGXmnh4aCQ7Zf12Fqnmq2bdqdlmNYopICyehW
         cjHYP6uO0kpbT57oa4DFwURwQOzJVVB7VFMCZtE2eeDg2MNYZ3WpDMBdCwvyYoP3zJjJ
         J+JA==
X-Gm-Message-State: AOAM531x3xkcrL3F1nz72ZGpcpDZGqGhwt4YYFPlqYUNmw1iemhII0E3
        3xA5exPNIEMJ+HUisfnLKW8BejypA3o=
X-Google-Smtp-Source: ABdhPJz1Prw8liqFr+rGy4gY22IlgUJjmHurkwiFzR31oUzeUrVWgVCxwsKeYrJnrxJmuUuZEYM/BhjTHMU=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a05:6902:703:b0:649:3ed0:a132 with SMTP id
 k3-20020a056902070300b006493ed0a132mr22009656ybt.185.1651704651109; Wed, 04
 May 2022 15:50:51 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  4 May 2022 22:47:52 +0000
In-Reply-To: <20220504224914.1654036-1-seanjc@google.com>
Message-Id: <20220504224914.1654036-47-seanjc@google.com>
Mime-Version: 1.0
References: <20220504224914.1654036-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH 046/128] KVM: selftests: Convert vmx_pmu_msrs_test away from VCPU_ID
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>,
        Oliver Upton <oupton@google.com>,
        Sean Christopherson <seanjc@google.com>
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

Convert vmx_pmu_msrs_test to use vm_create_with_one_vcpu() and pass
around a 'struct kvm_vcpu' object instead of using a global VCPU_ID.

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
2.36.0.464.gb9c8b46e94-goog


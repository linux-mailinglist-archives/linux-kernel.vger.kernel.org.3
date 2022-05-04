Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECF9D51B2E2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 01:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379819AbiEDXAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 19:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379524AbiEDWzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 18:55:35 -0400
Received: from mail-oa1-x4a.google.com (mail-oa1-x4a.google.com [IPv6:2001:4860:4864:20::4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D8A546B8
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 15:51:26 -0700 (PDT)
Received: by mail-oa1-x4a.google.com with SMTP id 586e51a60fabf-e998961411so1264505fac.18
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 15:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=ZaWha1EeyIL7FKB60EXSRNFE0pV0CvjL4PHx9TUFww4=;
        b=G6+q6mLGs0V5pDzrmeYwzNADY5R5yeTtkZhWA9zQFnWZQOv+QtZxKiGDselDXmPZFF
         PHATl+/DIKHmAIZukeY1hsRx86WJ6ZgVo1TVGIs8A0MiWwYCcl8Nc7bdCfFq67h4QU5r
         W3xCS4PmJf9hJ1P0YYaZcOIP6dAWGILzAxe9te7KinFM8Rk75Tz+yRGPaaGibjzKofzM
         EHDlGR9VFRamWJFhQ8GeGIvihBCh8M+zAH7Wl39x6cknAeJ/zfrehEC9ouat2thwc5Lu
         lv+7A+EIZp6CyRy0Qjyp7buZwqWSVo8ZluNnsJdsRB0ReSxfGH+s7zNrSdWWlPZBdbSq
         NxOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=ZaWha1EeyIL7FKB60EXSRNFE0pV0CvjL4PHx9TUFww4=;
        b=m1sva5zdqpZqQ5geuVP9obsm39IlVZ1LFvhKVyWxV9j6Osg/EOo1Ehg+LxdBjXrFTn
         aRf+L1hVSzJsq0N4QVN7ji/X96e+0WGMepV4BCNkVYQPqMb+UJTU1ERYqfK2CZqPxxSS
         ZNK8eeszc4Sd+PReBJqFrxn4VEAjZmB38SqyansaAX8MMClPATM+ztcoU0U+tErBX1Ac
         cGW1BSHiXzMGnfTnRn55aDc3bO0MV5Qb6kmE/kQp/1G8pNDsbODUw2834KLXOu/xfubK
         ceBpzoUIxkdWvXtrvnZ31bF+0KjiMYWWqv/z99+O2T3VOXVOBj/C2hHMMihpUVySqSFO
         9LGA==
X-Gm-Message-State: AOAM530Ez/WuOpscEAlTeqHNZVgMa0Jt0YHNPLiJR64Vd+gs3qLfzkVF
        Xnsgho8REeSky+uQStfy7/a0Qg7mfH4=
X-Google-Smtp-Source: ABdhPJzXF1RYIs3qoiLVIRYCjDd3Km64DqLTYRgtHgx1klEeVTnlbuMQtP+HYBWBTsHu4NVgTVGiWRnn2yE=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a05:6870:d18e:b0:e9:76ac:988b with SMTP id
 a14-20020a056870d18e00b000e976ac988bmr918839oac.290.1651704685452; Wed, 04
 May 2022 15:51:25 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  4 May 2022 22:48:12 +0000
In-Reply-To: <20220504224914.1654036-1-seanjc@google.com>
Message-Id: <20220504224914.1654036-67-seanjc@google.com>
Mime-Version: 1.0
References: <20220504224914.1654036-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH 066/128] KVM: selftests: Convert tsc_msrs_test away from VCPU_ID
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert tsc_msrs_test to use vm_create_with_one_vcpu() and pass around a
'struct kvm_vcpu' object instead of using a global VCPU_ID.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/x86_64/tsc_msrs_test.c      | 35 +++++++++----------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/tsc_msrs_test.c b/tools/testing/selftests/kvm/x86_64/tsc_msrs_test.c
index a426078b16a3..3b7bf660eced 100644
--- a/tools/testing/selftests/kvm/x86_64/tsc_msrs_test.c
+++ b/tools/testing/selftests/kvm/x86_64/tsc_msrs_test.c
@@ -9,14 +9,12 @@
 #include "kvm_util.h"
 #include "processor.h"
 
-#define VCPU_ID 0
-
 #define UNITY                  (1ull << 30)
 #define HOST_ADJUST            (UNITY * 64)
 #define GUEST_STEP             (UNITY * 4)
 #define ROUND(x)               ((x + UNITY / 2) & -UNITY)
 #define rounded_rdmsr(x)       ROUND(rdmsr(x))
-#define rounded_host_rdmsr(x)  ROUND(vcpu_get_msr(vm, 0, x))
+#define rounded_host_rdmsr(x)  ROUND(vcpu_get_msr(vm, vcpu->id, x))
 
 static void guest_code(void)
 {
@@ -66,15 +64,13 @@ static void guest_code(void)
 	GUEST_DONE();
 }
 
-static void run_vcpu(struct kvm_vm *vm, uint32_t vcpuid, int stage)
+static void run_vcpu(struct kvm_vcpu *vcpu, int stage)
 {
 	struct ucall uc;
 
-	vcpu_args_set(vm, vcpuid, 1, vcpuid);
+	vcpu_run(vcpu->vm, vcpu->id);
 
-	vcpu_ioctl(vm, vcpuid, KVM_RUN, NULL);
-
-	switch (get_ucall(vm, vcpuid, &uc)) {
+	switch (get_ucall(vcpu->vm, vcpu->id, &uc)) {
 	case UCALL_SYNC:
 		TEST_ASSERT(!strcmp((const char *)uc.args[0], "hello") &&
 			    uc.args[1] == stage + 1, "Stage %d: Unexpected register values vmexit, got %lx",
@@ -88,29 +84,30 @@ static void run_vcpu(struct kvm_vm *vm, uint32_t vcpuid, int stage)
 			    __FILE__, uc.args[1], uc.args[2], uc.args[3]);
 	default:
 		TEST_ASSERT(false, "Unexpected exit: %s",
-			    exit_reason_str(vcpu_state(vm, vcpuid)->exit_reason));
+			    exit_reason_str(vcpu->run->exit_reason));
 	}
 }
 
 int main(void)
 {
+	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
 	uint64_t val;
 
-	vm = vm_create_default(VCPU_ID, 0, guest_code);
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
 
 	val = 0;
 	ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC), val);
 	ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC_ADJUST), val);
 
 	/* Guest: writes to MSR_IA32_TSC affect both MSRs.  */
-	run_vcpu(vm, VCPU_ID, 1);
+	run_vcpu(vcpu, 1);
 	val = 1ull * GUEST_STEP;
 	ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC), val);
 	ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC_ADJUST), val);
 
 	/* Guest: writes to MSR_IA32_TSC_ADJUST affect both MSRs.  */
-	run_vcpu(vm, VCPU_ID, 2);
+	run_vcpu(vcpu, 2);
 	val = 2ull * GUEST_STEP;
 	ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC), val);
 	ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC_ADJUST), val);
@@ -119,18 +116,18 @@ int main(void)
 	 * Host: writes to MSR_IA32_TSC set the host-side offset
 	 * and therefore do not change MSR_IA32_TSC_ADJUST.
 	 */
-	vcpu_set_msr(vm, 0, MSR_IA32_TSC, HOST_ADJUST + val);
+	vcpu_set_msr(vm, vcpu->id, MSR_IA32_TSC, HOST_ADJUST + val);
 	ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC), HOST_ADJUST + val);
 	ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC_ADJUST), val);
-	run_vcpu(vm, VCPU_ID, 3);
+	run_vcpu(vcpu, 3);
 
 	/* Host: writes to MSR_IA32_TSC_ADJUST do not modify the TSC.  */
-	vcpu_set_msr(vm, 0, MSR_IA32_TSC_ADJUST, UNITY * 123456);
+	vcpu_set_msr(vm, vcpu->id, MSR_IA32_TSC_ADJUST, UNITY * 123456);
 	ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC), HOST_ADJUST + val);
-	ASSERT_EQ(vcpu_get_msr(vm, 0, MSR_IA32_TSC_ADJUST), UNITY * 123456);
+	ASSERT_EQ(vcpu_get_msr(vm, vcpu->id, MSR_IA32_TSC_ADJUST), UNITY * 123456);
 
 	/* Restore previous value.  */
-	vcpu_set_msr(vm, 0, MSR_IA32_TSC_ADJUST, val);
+	vcpu_set_msr(vm, vcpu->id, MSR_IA32_TSC_ADJUST, val);
 	ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC), HOST_ADJUST + val);
 	ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC_ADJUST), val);
 
@@ -138,7 +135,7 @@ int main(void)
 	 * Guest: writes to MSR_IA32_TSC_ADJUST do not destroy the
 	 * host-side offset and affect both MSRs.
 	 */
-	run_vcpu(vm, VCPU_ID, 4);
+	run_vcpu(vcpu, 4);
 	val = 3ull * GUEST_STEP;
 	ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC), HOST_ADJUST + val);
 	ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC_ADJUST), val);
@@ -147,7 +144,7 @@ int main(void)
 	 * Guest: writes to MSR_IA32_TSC affect both MSRs, so the host-side
 	 * offset is now visible in MSR_IA32_TSC_ADJUST.
 	 */
-	run_vcpu(vm, VCPU_ID, 5);
+	run_vcpu(vcpu, 5);
 	val = 4ull * GUEST_STEP;
 	ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC), val);
 	ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC_ADJUST), val - HOST_ADJUST);
-- 
2.36.0.464.gb9c8b46e94-goog


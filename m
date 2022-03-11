Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8756E4D5B00
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346855AbiCKF4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 00:56:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346696AbiCKFxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:53:15 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1A3ECB28
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:52:13 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id i72-20020a62874b000000b004f66c5b963cso4612982pfe.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=Qd/x2R16uSY/REGDmxgyGFYaGegCoIrTGo5hh2WV2cY=;
        b=Qeesr7vUc8MvhtHLOxHATcpkGHMENbv/D3MSOMYzoab6utEjo6BZy7gJU6+BNjoKxv
         rH3pEutBIe+kAX0THBT7eBTWfmNrCVAgWikXAlfbH6sDF0X6tFkf9Jsmya4WhbcnciG6
         kt251kdDUAE+44C5VuvcONMu5GUL36JF920dwVt6IgAejnHfm2W4zrTG5kqIDpwmix2O
         ZI3QRRP1ZRtW7Kz+zovBJOfUaeWruoZr+5hC9jenEdXsQWqJ7QRhJQiIkNGhlTdEhDjr
         8gi3Vk46xcmMPiNCfJj/wjs5wzmEY5uOL7Ee+sTtjiTKdz2HA+RsYYgpD7xVYRhQIe+5
         XL1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=Qd/x2R16uSY/REGDmxgyGFYaGegCoIrTGo5hh2WV2cY=;
        b=rIjqkUZT2qVqOVTOMTC81eaWzH1AzFrKEv3f5+VnPHxAXOabrY3wpK4jwYXrmKWUN6
         W5axBc43IgCfm1o4xCMm8oKEBlAl8qTeMqIOL9oWnC/QXoXVBHWDewSlM8RARQKziLwY
         nCln2/GckwljM4jsnx1ohv+DekwSn1FC3gctD46U/aiKuPNEJaP+5LDyxQzmBneS8Snc
         UQ8F2Zl95Tj5rv2DZ402b2OJvKZS8i1ulZmHtRRo9v6YQuyPZWorrMps2gOFk5TZ3hiu
         EqHEzEiB4xCv0Mra9HCBFmdC+gsard1vK3fr5eRDtZ6c3f2qa17TWwD11bP8yy66KR0u
         QMmg==
X-Gm-Message-State: AOAM532sI3THT2KFcAq9j6pESPCeN7VbFiHBmwHtDIG4tjJmOT8SL3Vx
        P8SaXrBfYBKXzt1s1va+T5oR8KD0lLqzoweqy+ZGg6mYmOI1JpgUNLMSLxi5esJsg6BQfi0ABNX
        1UqYCi2G1nWcDjrP+gTvtkDihNI2cK2EdioYqcY7UbJVvT9DLXMkv4/5KA6XVCgIAbOlvtA==
X-Google-Smtp-Source: ABdhPJw1UehOAI7TB7A6XZWEaIezajBM5jIeW9SuODmIutAEugtXb5eJBRnGAl/fVrMEqG/uP27VALfgfHo=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90b:1e10:b0:1bf:6c78:54a9 with SMTP id
 pg16-20020a17090b1e1000b001bf6c7854a9mr460642pjb.1.1646977932208; Thu, 10 Mar
 2022 21:52:12 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:49:50 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-40-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 039/105] KVM: selftests: Convert pmu_event_filter_test
 away from VCPU_ID
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
 .../kvm/x86_64/pmu_event_filter_test.c        | 60 +++++++++----------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
index c715adcbd487..9aaad99f8986 100644
--- a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
+++ b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
@@ -49,7 +49,6 @@ union cpuid10_ebx {
 /* Oddly, this isn't in perf_event.h. */
 #define ARCH_PERFMON_BRANCHES_RETIRED		5
 
-#define VCPU_ID 0
 #define NUM_BRANCHES 42
 
 /*
@@ -173,17 +172,17 @@ static void amd_guest_code(void)
  * Run the VM to the next GUEST_SYNC(value), and return the value passed
  * to the sync. Any other exit from the guest is fatal.
  */
-static uint64_t run_vm_to_sync(struct kvm_vm *vm)
+static uint64_t run_vcpu_to_sync(struct kvm_vcpu *vcpu)
 {
-	struct kvm_run *run = vcpu_state(vm, VCPU_ID);
+	struct kvm_run *run = vcpu->run;
 	struct ucall uc;
 
-	vcpu_run(vm, VCPU_ID);
+	vcpu_run(vcpu->vm, vcpu->id);
 	TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
 		    "Exit_reason other than KVM_EXIT_IO: %u (%s)\n",
 		    run->exit_reason,
 		    exit_reason_str(run->exit_reason));
-	get_ucall(vm, VCPU_ID, &uc);
+	get_ucall(vcpu->vm, vcpu->id, &uc);
 	TEST_ASSERT(uc.cmd == UCALL_SYNC,
 		    "Received ucall other than UCALL_SYNC: %lu", uc.cmd);
 	return uc.args[1];
@@ -197,13 +196,13 @@ static uint64_t run_vm_to_sync(struct kvm_vm *vm)
  * a sanity check and then GUEST_SYNC(success). In the case of failure,
  * the behavior of the guest on resumption is undefined.
  */
-static bool sanity_check_pmu(struct kvm_vm *vm)
+static bool sanity_check_pmu(struct kvm_vcpu *vcpu)
 {
 	bool success;
 
-	vm_install_exception_handler(vm, GP_VECTOR, guest_gp_handler);
-	success = run_vm_to_sync(vm);
-	vm_install_exception_handler(vm, GP_VECTOR, NULL);
+	vm_install_exception_handler(vcpu->vm, GP_VECTOR, guest_gp_handler);
+	success = run_vcpu_to_sync(vcpu);
+	vm_install_exception_handler(vcpu->vm, GP_VECTOR, NULL);
 
 	return success;
 }
@@ -254,9 +253,9 @@ static struct kvm_pmu_event_filter *remove_event(struct kvm_pmu_event_filter *f,
 	return f;
 }
 
-static void test_without_filter(struct kvm_vm *vm)
+static void test_without_filter(struct kvm_vcpu *vcpu)
 {
-	uint64_t count = run_vm_to_sync(vm);
+	uint64_t count = run_vcpu_to_sync(vcpu);
 
 	if (count != NUM_BRANCHES)
 		pr_info("%s: Branch instructions retired = %lu (expected %u)\n",
@@ -264,17 +263,17 @@ static void test_without_filter(struct kvm_vm *vm)
 	TEST_ASSERT(count, "Allowed PMU event is not counting");
 }
 
-static uint64_t test_with_filter(struct kvm_vm *vm,
+static uint64_t test_with_filter(struct kvm_vcpu *vcpu,
 				 struct kvm_pmu_event_filter *f)
 {
-	vm_ioctl(vm, KVM_SET_PMU_EVENT_FILTER, (void *)f);
-	return run_vm_to_sync(vm);
+	vm_ioctl(vcpu->vm, KVM_SET_PMU_EVENT_FILTER, (void *)f);
+	return run_vcpu_to_sync(vcpu);
 }
 
-static void test_member_deny_list(struct kvm_vm *vm)
+static void test_member_deny_list(struct kvm_vcpu *vcpu)
 {
 	struct kvm_pmu_event_filter *f = event_filter(KVM_PMU_EVENT_DENY);
-	uint64_t count = test_with_filter(vm, f);
+	uint64_t count = test_with_filter(vcpu, f);
 
 	free(f);
 	if (count)
@@ -283,10 +282,10 @@ static void test_member_deny_list(struct kvm_vm *vm)
 	TEST_ASSERT(!count, "Disallowed PMU Event is counting");
 }
 
-static void test_member_allow_list(struct kvm_vm *vm)
+static void test_member_allow_list(struct kvm_vcpu *vcpu)
 {
 	struct kvm_pmu_event_filter *f = event_filter(KVM_PMU_EVENT_ALLOW);
-	uint64_t count = test_with_filter(vm, f);
+	uint64_t count = test_with_filter(vcpu, f);
 
 	free(f);
 	if (count != NUM_BRANCHES)
@@ -295,14 +294,14 @@ static void test_member_allow_list(struct kvm_vm *vm)
 	TEST_ASSERT(count, "Allowed PMU event is not counting");
 }
 
-static void test_not_member_deny_list(struct kvm_vm *vm)
+static void test_not_member_deny_list(struct kvm_vcpu *vcpu)
 {
 	struct kvm_pmu_event_filter *f = event_filter(KVM_PMU_EVENT_DENY);
 	uint64_t count;
 
 	remove_event(f, INTEL_BR_RETIRED);
 	remove_event(f, AMD_ZEN_BR_RETIRED);
-	count = test_with_filter(vm, f);
+	count = test_with_filter(vcpu, f);
 	free(f);
 	if (count != NUM_BRANCHES)
 		pr_info("%s: Branch instructions retired = %lu (expected %u)\n",
@@ -310,14 +309,14 @@ static void test_not_member_deny_list(struct kvm_vm *vm)
 	TEST_ASSERT(count, "Allowed PMU event is not counting");
 }
 
-static void test_not_member_allow_list(struct kvm_vm *vm)
+static void test_not_member_allow_list(struct kvm_vcpu *vcpu)
 {
 	struct kvm_pmu_event_filter *f = event_filter(KVM_PMU_EVENT_ALLOW);
 	uint64_t count;
 
 	remove_event(f, INTEL_BR_RETIRED);
 	remove_event(f, AMD_ZEN_BR_RETIRED);
-	count = test_with_filter(vm, f);
+	count = test_with_filter(vcpu, f);
 	free(f);
 	if (count)
 		pr_info("%s: Branch instructions retired = %lu (expected 0)\n",
@@ -390,6 +389,7 @@ static bool use_amd_pmu(void)
 int main(int argc, char *argv[])
 {
 	void (*guest_code)(void) = NULL;
+	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
 	int r;
 
@@ -412,21 +412,21 @@ int main(int argc, char *argv[])
 		exit(KSFT_SKIP);
 	}
 
-	vm = vm_create_default(VCPU_ID, 0, guest_code);
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
 
 	vm_init_descriptor_tables(vm);
-	vcpu_init_descriptor_tables(vm, VCPU_ID);
+	vcpu_init_descriptor_tables(vm, vcpu->id);
 
-	if (!sanity_check_pmu(vm)) {
+	if (!sanity_check_pmu(vcpu)) {
 		print_skip("Guest PMU is not functional");
 		exit(KSFT_SKIP);
 	}
 
-	test_without_filter(vm);
-	test_member_deny_list(vm);
-	test_member_allow_list(vm);
-	test_not_member_deny_list(vm);
-	test_not_member_allow_list(vm);
+	test_without_filter(vcpu);
+	test_member_deny_list(vcpu);
+	test_member_allow_list(vcpu);
+	test_not_member_deny_list(vcpu);
+	test_not_member_allow_list(vcpu);
 
 	kvm_vm_free(vm);
 
-- 
2.35.1.723.g4982287a31-goog


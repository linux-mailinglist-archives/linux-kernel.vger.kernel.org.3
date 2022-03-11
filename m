Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1FFD4D5B24
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345050AbiCKGAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 01:00:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242820AbiCKFzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:55:04 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B392FCB43
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:53:30 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id i4-20020a63b304000000b0038108d6e7cdso761761pgf.14
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=fJcjxxaNZsUzxQ7YsSiwfIENO7Kf+loL8mauwQgQyUk=;
        b=KmMifenitTRX+EPj2GyGPqriFuTx+YIHqGEFXqeP8oE+8WDTxt+4TGZseINy+JmCfi
         DrMs3vuh31aOWtmVyaTEJZWnMLyF7ZM3iyaRunynYe41yk2GidiOaWP3nn+fUe32KaBZ
         gb17nWCRcW9y9pN6h8XZSJpq9IZXi8ZAlnoRLCpgORNEWmsjKosJHytU48DlO6TUMLFN
         7xdtgiixFS+vZ7BB5ETdLsQ14/5oJI2U4mcjrObyFH4+dZnYo5p8Yb/XLgYjKVbpr/vq
         q60xYQU+NDypzZUF4f27XXcUnWLrbj51TYuAPGAgZUlXvHq13FZdSwyQVmoGZphx2NNs
         5xww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=fJcjxxaNZsUzxQ7YsSiwfIENO7Kf+loL8mauwQgQyUk=;
        b=4wHFBYcZhcDqoJEUbs0OeK7sTcvmgRtkLecX06jgrkU3cTWmfwE72KHycPpTFk7mjb
         XVdEThrTGTLNY+l2/Mp61L9HWIqzQTy6WluuuKPMZV2YWP/6Kbri4NihnKRXeHG3+xyn
         iF15EEV1FXsWBgMWptDesvKF3bFAUmnn/PTpPAMtZBcLg5YaEyAGaFQTrdfIZdzc4EQ8
         BGvcyFCZQOR5iU4h68wGJAWkVFqrdZIvFoU1UjNOrIWlxRFIjND3o28H7Cr3t0Y3ODLK
         m/y1esdApSZ/y91gaf3OdKaGnQD07wNWzk2Zleme1ZK/JfIB9i+OHrlitReoHtAdO81D
         PQ0Q==
X-Gm-Message-State: AOAM533U8Y7Oayr+tTSwh2rk1fLsfAPN3BXRidAgzsRg5umGmdydETxO
        escohN0yhMAU5a6Pw9tPhZUGnhBnacVK0zdEKpzU4PsD+IbrKsEQQ7cQl42F7DrZvvV+9zyXX0w
        3dPAwrzunDiYk8iPm8588hyjm4HVOdjPJegn9n/NCLTOcF0EqjpHNPGYCl11C92arlQrdSA==
X-Google-Smtp-Source: ABdhPJxkNLcfAj1SbQ8ffCFB2DJTzWt/d1BJ1ZLLykojRJxeERiZmyOucU+fxNVdb3kkbRqpUU8OljfVQWw=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:902:6b4a:b0:14d:474f:4904 with SMTP id
 g10-20020a1709026b4a00b0014d474f4904mr8943717plt.122.1646978009661; Thu, 10
 Mar 2022 21:53:29 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:50:36 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-86-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 085/105] KVM: selftests: Convert steal_time away from VCPU_ID
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
 tools/testing/selftests/kvm/steal_time.c | 120 +++++++++++------------
 1 file changed, 60 insertions(+), 60 deletions(-)

diff --git a/tools/testing/selftests/kvm/steal_time.c b/tools/testing/selftests/kvm/steal_time.c
index 741892cec1ea..fe64fac0a5f4 100644
--- a/tools/testing/selftests/kvm/steal_time.c
+++ b/tools/testing/selftests/kvm/steal_time.c
@@ -58,36 +58,33 @@ static void guest_code(int cpu)
 	GUEST_DONE();
 }
 
-static void steal_time_init(struct kvm_vm *vm)
+static bool is_steal_time_supported(struct kvm_vcpu *vcpu)
 {
-	int i;
+	struct kvm_cpuid_entry2 *cpuid = kvm_get_supported_cpuid_entry(KVM_CPUID_FEATURES);
 
-	if (!(kvm_get_supported_cpuid_entry(KVM_CPUID_FEATURES)->eax &
-	      KVM_FEATURE_STEAL_TIME)) {
-		print_skip("steal-time not supported");
-		exit(KSFT_SKIP);
-	}
+	return cpuid && (cpuid->eax & KVM_FEATURE_STEAL_TIME);
+}
 
-	for (i = 0; i < NR_VCPUS; ++i) {
-		int ret;
+static void steal_time_init(struct kvm_vcpu *vcpu, uint32_t i)
+{
+	int ret;
 
-		/* ST_GPA_BASE is identity mapped */
-		st_gva[i] = (void *)(ST_GPA_BASE + i * STEAL_TIME_SIZE);
-		sync_global_to_guest(vm, st_gva[i]);
+	/* ST_GPA_BASE is identity mapped */
+	st_gva[i] = (void *)(ST_GPA_BASE + i * STEAL_TIME_SIZE);
+	sync_global_to_guest(vcpu->vm, st_gva[i]);
 
-		ret = _vcpu_set_msr(vm, i, MSR_KVM_STEAL_TIME, (ulong)st_gva[i] | KVM_STEAL_RESERVED_MASK);
-		TEST_ASSERT(ret == 0, "Bad GPA didn't fail");
+	ret = _vcpu_set_msr(vcpu->vm, vcpu->id, MSR_KVM_STEAL_TIME, (ulong)st_gva[i] | KVM_STEAL_RESERVED_MASK);
+	TEST_ASSERT(ret == 0, "Bad GPA didn't fail");
 
-		vcpu_set_msr(vm, i, MSR_KVM_STEAL_TIME, (ulong)st_gva[i] | KVM_MSR_ENABLED);
-	}
+	vcpu_set_msr(vcpu->vm, vcpu->id, MSR_KVM_STEAL_TIME, (ulong)st_gva[i] | KVM_MSR_ENABLED);
 }
 
-static void steal_time_dump(struct kvm_vm *vm, uint32_t vcpuid)
+static void steal_time_dump(struct kvm_vm *vm, uint32_t vcpu_idx)
 {
-	struct kvm_steal_time *st = addr_gva2hva(vm, (ulong)st_gva[vcpuid]);
+	struct kvm_steal_time *st = addr_gva2hva(vm, (ulong)st_gva[vcpu_idx]);
 	int i;
 
-	pr_info("VCPU%d:\n", vcpuid);
+	pr_info("VCPU%d:\n", vcpu_idx);
 	pr_info("    steal:     %lld\n", st->steal);
 	pr_info("    version:   %d\n", st->version);
 	pr_info("    flags:     %d\n", st->flags);
@@ -165,49 +162,50 @@ static void guest_code(int cpu)
 	GUEST_DONE();
 }
 
-static void steal_time_init(struct kvm_vm *vm)
+static bool is_steal_time_supported(struct kvm_vcpu *vcpu)
 {
 	struct kvm_device_attr dev = {
 		.group = KVM_ARM_VCPU_PVTIME_CTRL,
 		.attr = KVM_ARM_VCPU_PVTIME_IPA,
 	};
-	int i, ret;
 
-	ret = __vcpu_ioctl(vm, 0, KVM_HAS_DEVICE_ATTR, &dev);
-	if (ret != 0 && errno == ENXIO) {
-		print_skip("steal-time not supported");
-		exit(KSFT_SKIP);
-	}
-
-	for (i = 0; i < NR_VCPUS; ++i) {
-		uint64_t st_ipa;
+	return !__vcpu_ioctl(vcpu->vm, vcpu->id, KVM_HAS_DEVICE_ATTR, &dev);
+}
 
-		vcpu_ioctl(vm, i, KVM_HAS_DEVICE_ATTR, &dev);
+static void steal_time_init(struct kvm_vcpu *vcpu, uint32_t i)
+{
+	struct kvm_vm *vm = vcpu->vm;
+	uint64_t st_ipa;
+	int ret;
 
-		dev.addr = (uint64_t)&st_ipa;
+	struct kvm_device_attr dev = {
+		.group = KVM_ARM_VCPU_PVTIME_CTRL,
+		.attr = KVM_ARM_VCPU_PVTIME_IPA,
+		.addr = (uint64_t)&st_ipa,
+	};
 
-		/* ST_GPA_BASE is identity mapped */
-		st_gva[i] = (void *)(ST_GPA_BASE + i * STEAL_TIME_SIZE);
-		sync_global_to_guest(vm, st_gva[i]);
+	vcpu_ioctl(vm, vcpu->id, KVM_HAS_DEVICE_ATTR, &dev);
 
-		st_ipa = (ulong)st_gva[i] | 1;
-		ret = __vcpu_ioctl(vm, i, KVM_SET_DEVICE_ATTR, &dev);
-		TEST_ASSERT(ret == -1 && errno == EINVAL, "Bad IPA didn't report EINVAL");
+	/* ST_GPA_BASE is identity mapped */
+	st_gva[i] = (void *)(ST_GPA_BASE + i * STEAL_TIME_SIZE);
+	sync_global_to_guest(vm, st_gva[i]);
 
-		st_ipa = (ulong)st_gva[i];
-		vcpu_ioctl(vm, i, KVM_SET_DEVICE_ATTR, &dev);
+	st_ipa = (ulong)st_gva[i] | 1;
+	ret = __vcpu_ioctl(vm, vcpu->id, KVM_SET_DEVICE_ATTR, &dev);
+	TEST_ASSERT(ret == -1 && errno == EINVAL, "Bad IPA didn't report EINVAL");
 
-		ret = __vcpu_ioctl(vm, i, KVM_SET_DEVICE_ATTR, &dev);
-		TEST_ASSERT(ret == -1 && errno == EEXIST, "Set IPA twice without EEXIST");
+	st_ipa = (ulong)st_gva[i];
+	vcpu_ioctl(vm, vcpu->id, KVM_SET_DEVICE_ATTR, &dev);
 
-	}
+	ret = __vcpu_ioctl(vm, vcpu->id, KVM_SET_DEVICE_ATTR, &dev);
+	TEST_ASSERT(ret == -1 && errno == EEXIST, "Set IPA twice without EEXIST");
 }
 
-static void steal_time_dump(struct kvm_vm *vm, uint32_t vcpuid)
+static void steal_time_dump(struct kvm_vm *vm, uint32_t vcpu_idx)
 {
-	struct st_time *st = addr_gva2hva(vm, (ulong)st_gva[vcpuid]);
+	struct st_time *st = addr_gva2hva(vm, (ulong)st_gva[vcpu_idx]);
 
-	pr_info("VCPU%d:\n", vcpuid);
+	pr_info("VCPU%d:\n", vcpu_idx);
 	pr_info("    rev:     %d\n", st->rev);
 	pr_info("    attr:    %d\n", st->attr);
 	pr_info("    st_time: %ld\n", st->st_time);
@@ -231,15 +229,13 @@ static void *do_steal_time(void *arg)
 	return NULL;
 }
 
-static void run_vcpu(struct kvm_vm *vm, uint32_t vcpuid)
+static void run_vcpu(struct kvm_vcpu *vcpu)
 {
 	struct ucall uc;
 
-	vcpu_args_set(vm, vcpuid, 1, vcpuid);
+	vcpu_run(vcpu->vm, vcpu->id);
 
-	vcpu_ioctl(vm, vcpuid, KVM_RUN, NULL);
-
-	switch (get_ucall(vm, vcpuid, &uc)) {
+	switch (get_ucall(vcpu->vm, vcpu->id, &uc)) {
 	case UCALL_SYNC:
 	case UCALL_DONE:
 		break;
@@ -248,12 +244,13 @@ static void run_vcpu(struct kvm_vm *vm, uint32_t vcpuid)
 			    __FILE__, uc.args[1]);
 	default:
 		TEST_ASSERT(false, "Unexpected exit: %s",
-			    exit_reason_str(vcpu_state(vm, vcpuid)->exit_reason));
+			    exit_reason_str(vcpu->run->exit_reason));
 	}
 }
 
 int main(int ac, char **av)
 {
+	struct kvm_vcpu *vcpus[NR_VCPUS];
 	struct kvm_vm *vm;
 	pthread_attr_t attr;
 	pthread_t thread;
@@ -274,25 +271,28 @@ int main(int ac, char **av)
 	pthread_setaffinity_np(pthread_self(), sizeof(cpu_set_t), &cpuset);
 
 	/* Create a one VCPU guest and an identity mapped memslot for the steal time structure */
-	vm = vm_create_default(0, 0, guest_code);
+	vm = vm_create_with_vcpus(NR_VCPUS, guest_code, vcpus);
 	gpages = vm_calc_num_guest_pages(VM_MODE_DEFAULT, STEAL_TIME_SIZE * NR_VCPUS);
 	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, ST_GPA_BASE, 1, gpages, 0);
 	virt_map(vm, ST_GPA_BASE, ST_GPA_BASE, gpages);
 	ucall_init(vm, NULL);
 
-	/* Add the rest of the VCPUs */
-	for (i = 1; i < NR_VCPUS; ++i)
-		vm_vcpu_add(vm, i, guest_code);
-
-	steal_time_init(vm);
+	if (!is_steal_time_supported(vcpus[0])) {
+		print_skip("steal-time not supported");
+		exit(KSFT_SKIP);\
+	}
 
 	/* Run test on each VCPU */
 	for (i = 0; i < NR_VCPUS; ++i) {
+		steal_time_init(vcpus[i], i);
+		
+		vcpu_args_set(vm, vcpus[i]->id, 1, i);
+
 		/* First VCPU run initializes steal-time */
-		run_vcpu(vm, i);
+		run_vcpu(vcpus[i]);
 
 		/* Second VCPU run, expect guest stolen time to be <= run_delay */
-		run_vcpu(vm, i);
+		run_vcpu(vcpus[i]);
 		sync_global_from_guest(vm, guest_stolen_time[i]);
 		stolen_time = guest_stolen_time[i];
 		run_delay = get_run_delay();
@@ -313,7 +313,7 @@ int main(int ac, char **av)
 			    MIN_RUN_DELAY_NS, run_delay);
 
 		/* Run VCPU again to confirm stolen time is consistent with run_delay */
-		run_vcpu(vm, i);
+		run_vcpu(vcpus[i]);
 		sync_global_from_guest(vm, guest_stolen_time[i]);
 		stolen_time = guest_stolen_time[i] - stolen_time;
 		TEST_ASSERT(stolen_time >= run_delay,
-- 
2.35.1.723.g4982287a31-goog


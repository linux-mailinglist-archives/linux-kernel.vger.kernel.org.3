Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7D04D5B1B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347835AbiCKF7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 00:59:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346698AbiCKFy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:54:29 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E796F94F1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:53:22 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id q7-20020a63e207000000b003801b9bb18dso4222104pgh.15
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=mhB004cy6+dADAkBPE+SuqIl2YbNKraaLFuQQI2+f4o=;
        b=RoFg37Gt//DUkSpnZJhtP+ST7pd4Pdcgnq2kss0spJso9tdIjSXC3yG+yytv/WCN2c
         TTC3tjGCBxwXhcOAzoOvSNUYhr95xOWWY+S3gCRD7EyVtp4C32XQMZWMtorMNys0wOWE
         /1/CZDjS4nMnt43FN86BMQUmCSbuQkQrS1OvhrLMdhVv5L2GZnVFAyH43vIwuX0cOVkj
         vVYy1cMu2bBKgkBCnR3w3nbkwFwsDvzM9lRbu8LU/rN1WkPycL6D97p0lpNcBDMv4AQD
         Qaf1Xj8Wt0ce7ohdz4GSFSXZpr0lajxXfg/0blweewGBEYk9kiKOaVv9zYZZCGV2TUFM
         uZeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=mhB004cy6+dADAkBPE+SuqIl2YbNKraaLFuQQI2+f4o=;
        b=toL53Gig5Nz6hc7W8fwuATKjQqA2iQnRnWZ2o/ta62ddiYzFheiaMJRl9lU9OUwZ6/
         YiGS47O6b4l+rn4VwanfAzLe2KpNdayYUgQlOXgyMfBEQHl6Ga8z/c4XorFLzSsCBFkO
         yHETAsfSdE/ERuRhdt2TSyFqwKsuRM+LzijNbVE+14wMaEUtleCBEvYRi7OsJ3+OkD/V
         A51/MU9zoqrZGtQ4Qry8lanytOIay96qBSM34YhaSZWVIuqnbm0SYGIlct7ZdcC6+jwp
         XdlShqV6FFf/f4BAhIxZWnt5UgUtKcHV2fJqKg+ccFsNpzcdF2KDwPFB8e47seyRJNcz
         DD9w==
X-Gm-Message-State: AOAM532NyM4qt/+e8jkjvmZqdXUDxFPzIneXRAwHix//NZgTvAOOugiB
        mxoixAo5qsNKlHfGoB8LoCWX2tW7YAQKE5bl+bPQIxKSyDcEwXdN5UJIrD6jcHv9KYNCC5ULbkU
        wGVA6+7XQp8MYpy8CU/YMIJGQ61GH6ub250wUCkZNOZ1JwhJCcqXEVij+A1Yt7dNjqFj4zw==
X-Google-Smtp-Source: ABdhPJz+uUSdzHFWt0ewnAph32viOrqhyPHIMsE7YmTtyxZJhquCjPb+vk42jti/XJ0ca3j9tD1urCLmQxY=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90b:1e10:b0:1bf:6c78:54a9 with SMTP id
 pg16-20020a17090b1e1000b001bf6c7854a9mr461092pjb.1.1646978001428; Thu, 10 Mar
 2022 21:53:21 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:50:31 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-81-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 080/105] KVM: selftests: Rename vm_vcpu_add* helpers to
 better show relationships
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
 tools/testing/selftests/kvm/aarch64/get-reg-list.c     |  2 +-
 tools/testing/selftests/kvm/aarch64/psci_cpu_on_test.c |  4 ++--
 tools/testing/selftests/kvm/aarch64/vgic_init.c        | 10 +++++-----
 tools/testing/selftests/kvm/dirty_log_test.c           |  2 +-
 tools/testing/selftests/kvm/hardware_disable_test.c    |  2 +-
 .../testing/selftests/kvm/include/aarch64/processor.h  |  5 ++---
 tools/testing/selftests/kvm/include/kvm_util_base.h    |  7 +++----
 tools/testing/selftests/kvm/kvm_binary_stats_test.c    |  2 +-
 tools/testing/selftests/kvm/kvm_create_max_vcpus.c     |  2 +-
 tools/testing/selftests/kvm/lib/aarch64/processor.c    |  9 ++++-----
 tools/testing/selftests/kvm/lib/kvm_util.c             |  6 +++---
 tools/testing/selftests/kvm/lib/riscv/processor.c      |  2 +-
 tools/testing/selftests/kvm/lib/s390x/processor.c      |  2 +-
 tools/testing/selftests/kvm/lib/x86_64/processor.c     |  2 +-
 tools/testing/selftests/kvm/set_memory_region_test.c   |  2 +-
 tools/testing/selftests/kvm/steal_time.c               |  2 +-
 tools/testing/selftests/kvm/x86_64/set_boot_cpu_id.c   |  4 ++--
 tools/testing/selftests/kvm/x86_64/set_sregs_test.c    |  2 +-
 tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c |  8 ++++----
 tools/testing/selftests/kvm/x86_64/xapic_ipi_test.c    |  2 +-
 20 files changed, 37 insertions(+), 40 deletions(-)

diff --git a/tools/testing/selftests/kvm/aarch64/get-reg-list.c b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
index 0cbee268c953..f486223ac98c 100644
--- a/tools/testing/selftests/kvm/aarch64/get-reg-list.c
+++ b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
@@ -413,7 +413,7 @@ static void run_test(struct vcpu_config *c)
 
 	vm = vm_create(DEFAULT_GUEST_PHY_PAGES);
 	prepare_vcpu_init(c, &init);
-	aarch64_vcpu_add_default(vm, 0, &init, NULL);
+	aarch64_vcpu_add(vm, 0, &init, NULL);
 	finalize_vcpu(vm, 0, c);
 
 	reg_list = vcpu_get_reg_list(vm, 0);
diff --git a/tools/testing/selftests/kvm/aarch64/psci_cpu_on_test.c b/tools/testing/selftests/kvm/aarch64/psci_cpu_on_test.c
index bde7bae20a6e..3677cb2df19c 100644
--- a/tools/testing/selftests/kvm/aarch64/psci_cpu_on_test.c
+++ b/tools/testing/selftests/kvm/aarch64/psci_cpu_on_test.c
@@ -83,13 +83,13 @@ int main(void)
 	vm_ioctl(vm, KVM_ARM_PREFERRED_TARGET, &init);
 	init.features[0] |= (1 << KVM_ARM_VCPU_PSCI_0_2);
 
-	aarch64_vcpu_add_default(vm, VCPU_ID_SOURCE, &init, guest_main);
+	aarch64_vcpu_add(vm, VCPU_ID_SOURCE, &init, guest_main);
 
 	/*
 	 * make sure the target is already off when executing the test.
 	 */
 	init.features[0] |= (1 << KVM_ARM_VCPU_POWER_OFF);
-	aarch64_vcpu_add_default(vm, VCPU_ID_TARGET, &init, guest_main);
+	aarch64_vcpu_add(vm, VCPU_ID_TARGET, &init, guest_main);
 
 	get_reg(vm, VCPU_ID_TARGET, KVM_ARM64_SYS_REG(SYS_MPIDR_EL1), &target_mpidr);
 	vcpu_args_set(vm, VCPU_ID_SOURCE, 1, target_mpidr & MPIDR_HWID_BITMASK);
diff --git a/tools/testing/selftests/kvm/aarch64/vgic_init.c b/tools/testing/selftests/kvm/aarch64/vgic_init.c
index 0329aa04da31..32dac03f5600 100644
--- a/tools/testing/selftests/kvm/aarch64/vgic_init.c
+++ b/tools/testing/selftests/kvm/aarch64/vgic_init.c
@@ -314,7 +314,7 @@ static void test_vgic_then_vcpus(uint32_t gic_dev_type)
 
 	/* Add the rest of the VCPUs */
 	for (i = 1; i < NR_VCPUS; ++i)
-		vm_vcpu_add_default(v.vm, i, guest_code);
+		vm_vcpu_add(v.vm, i, guest_code);
 
 	ret = run_vcpu(v.vm, 3);
 	TEST_ASSERT(ret == -EINVAL, "dist/rdist overlap detected on 1st vcpu run");
@@ -402,17 +402,17 @@ static void test_v3_typer_accesses(void)
 
 	v.gic_fd = kvm_create_device(v.vm, KVM_DEV_TYPE_ARM_VGIC_V3);
 
-	vm_vcpu_add_default(v.vm, 3, guest_code);
+	vm_vcpu_add(v.vm, 3, guest_code);
 
 	ret = v3_redist_reg_get(v.gic_fd, 1, GICR_TYPER, &val);
 	TEST_ASSERT(ret && errno == EINVAL, "attempting to read GICR_TYPER of non created vcpu");
 
-	vm_vcpu_add_default(v.vm, 1, guest_code);
+	vm_vcpu_add(v.vm, 1, guest_code);
 
 	ret = v3_redist_reg_get(v.gic_fd, 1, GICR_TYPER, &val);
 	TEST_ASSERT(ret && errno == EBUSY, "read GICR_TYPER before GIC initialized");
 
-	vm_vcpu_add_default(v.vm, 2, guest_code);
+	vm_vcpu_add(v.vm, 2, guest_code);
 
 	kvm_device_attr_set(v.gic_fd, KVM_DEV_ARM_VGIC_GRP_CTRL,
 			    KVM_DEV_ARM_VGIC_CTRL_INIT, NULL);
@@ -576,7 +576,7 @@ static void test_v3_redist_ipa_range_check_at_vcpu_run(void)
 
 	/* Add the rest of the VCPUs */
 	for (i = 1; i < NR_VCPUS; ++i)
-		vm_vcpu_add_default(v.vm, i, guest_code);
+		vm_vcpu_add(v.vm, i, guest_code);
 
 	kvm_device_attr_set(v.gic_fd, KVM_DEV_ARM_VGIC_GRP_CTRL,
 			    KVM_DEV_ARM_VGIC_CTRL_INIT, NULL);
diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index 1c7d25bf4a5a..e480b503c08b 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -682,7 +682,7 @@ static struct kvm_vm *create_vm(enum vm_guest_mode mode, uint32_t vcpuid,
 	vm_create_irqchip(vm);
 #endif
 	log_mode_create_vm_done(vm);
-	vm_vcpu_add_default(vm, vcpuid, guest_code);
+	vm_vcpu_add(vm, vcpuid, guest_code);
 	return vm;
 }
 
diff --git a/tools/testing/selftests/kvm/hardware_disable_test.c b/tools/testing/selftests/kvm/hardware_disable_test.c
index 81ba8645772a..c31af07fae97 100644
--- a/tools/testing/selftests/kvm/hardware_disable_test.c
+++ b/tools/testing/selftests/kvm/hardware_disable_test.c
@@ -110,7 +110,7 @@ static void run_test(uint32_t run)
 
 	pr_debug("%s: [%d] start vcpus\n", __func__, run);
 	for (i = 0; i < VCPU_NUM; ++i) {
-		vm_vcpu_add_default(vm, i, guest_code);
+		vm_vcpu_add(vm, i, guest_code);
 		payloads[i].vm = vm;
 		payloads[i].index = i;
 
diff --git a/tools/testing/selftests/kvm/include/aarch64/processor.h b/tools/testing/selftests/kvm/include/aarch64/processor.h
index 5999e7ae7b29..f64607c136df 100644
--- a/tools/testing/selftests/kvm/include/aarch64/processor.h
+++ b/tools/testing/selftests/kvm/include/aarch64/processor.h
@@ -64,9 +64,8 @@ static inline void set_reg(struct kvm_vm *vm, uint32_t vcpuid, uint64_t id, uint
 }
 
 void aarch64_vcpu_setup(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_vcpu_init *init);
-struct kvm_vcpu *aarch64_vcpu_add_default(struct kvm_vm *vm, uint32_t vcpu_id,
-					  struct kvm_vcpu_init *init,
-					  void *guest_code);
+struct kvm_vcpu *aarch64_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id,
+				  struct kvm_vcpu_init *init, void *guest_code);
 
 struct ex_regs {
 	u64 regs[31];
diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index 19a7e507b8e7..14457f98080b 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -276,7 +276,7 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
 void vm_mem_region_set_flags(struct kvm_vm *vm, uint32_t slot, uint32_t flags);
 void vm_mem_region_move(struct kvm_vm *vm, uint32_t slot, uint64_t new_gpa);
 void vm_mem_region_delete(struct kvm_vm *vm, uint32_t slot);
-struct kvm_vcpu *vm_vcpu_add(struct kvm_vm *vm, uint32_t vcpuid);
+struct kvm_vcpu *__vm_vcpu_add(struct kvm_vm *vm, uint32_t vcpuid);
 vm_vaddr_t vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min);
 vm_vaddr_t vm_vaddr_alloc_pages(struct kvm_vm *vm, int nr_pages);
 vm_vaddr_t vm_vaddr_alloc_page(struct kvm_vm *vm);
@@ -640,9 +640,8 @@ static inline void vcpu_dump(FILE *stream, struct kvm_vm *vm, uint32_t vcpuid,
 struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id,
 				  void *guest_code);
 
-static inline struct kvm_vcpu *vm_vcpu_add_default(struct kvm_vm *vm,
-						   uint32_t vcpu_id,
-						   void *guest_code)
+static inline struct kvm_vcpu *vm_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id,
+					   void *guest_code)
 {
 	return vm_arch_vcpu_add(vm, vcpu_id, guest_code);
 }
diff --git a/tools/testing/selftests/kvm/kvm_binary_stats_test.c b/tools/testing/selftests/kvm/kvm_binary_stats_test.c
index 0a27b0f85009..77b8967fe702 100644
--- a/tools/testing/selftests/kvm/kvm_binary_stats_test.c
+++ b/tools/testing/selftests/kvm/kvm_binary_stats_test.c
@@ -223,7 +223,7 @@ int main(int argc, char *argv[])
 	for (i = 0; i < max_vm; ++i) {
 		vms[i] = vm_create(DEFAULT_GUEST_PHY_PAGES);
 		for (j = 0; j < max_vcpu; ++j)
-			vm_vcpu_add(vms[i], j);
+			__vm_vcpu_add(vms[i], j);
 	}
 
 	/* Check stats read for every VM and VCPU */
diff --git a/tools/testing/selftests/kvm/kvm_create_max_vcpus.c b/tools/testing/selftests/kvm/kvm_create_max_vcpus.c
index 9de5e1376c49..8fa8db12d452 100644
--- a/tools/testing/selftests/kvm/kvm_create_max_vcpus.c
+++ b/tools/testing/selftests/kvm/kvm_create_max_vcpus.c
@@ -32,7 +32,7 @@ void test_vcpu_creation(int first_vcpu_id, int num_vcpus)
 
 	for (i = first_vcpu_id; i < first_vcpu_id + num_vcpus; i++)
 		/* This asserts that the vCPU was created. */
-		vm_vcpu_add(vm, i);
+		__vm_vcpu_add(vm, i);
 
 	kvm_vm_free(vm);
 }
diff --git a/tools/testing/selftests/kvm/lib/aarch64/processor.c b/tools/testing/selftests/kvm/lib/aarch64/processor.c
index 089e6de2160c..35bec85f43b0 100644
--- a/tools/testing/selftests/kvm/lib/aarch64/processor.c
+++ b/tools/testing/selftests/kvm/lib/aarch64/processor.c
@@ -314,16 +314,15 @@ void vcpu_arch_dump(FILE *stream, struct kvm_vm *vm, uint32_t vcpuid, uint8_t in
 		indent, "", pstate, pc);
 }
 
-struct kvm_vcpu *aarch64_vcpu_add_default(struct kvm_vm *vm, uint32_t vcpu_id,
-					  struct kvm_vcpu_init *init,
-					  void *guest_code)
+struct kvm_vcpu *aarch64_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id,
+				  struct kvm_vcpu_init *init, void *guest_code)
 {
 	size_t stack_size = vm->page_size == 4096 ?
 					DEFAULT_STACK_PGS * vm->page_size :
 					vm->page_size;
 	uint64_t stack_vaddr = vm_vaddr_alloc(vm, stack_size,
 					      DEFAULT_ARM64_GUEST_STACK_VADDR_MIN);
-	struct kvm_vcpu *vcpu = vm_vcpu_add(vm, vcpu_id);
+	struct kvm_vcpu *vcpu = __vm_vcpu_add(vm, vcpu_id);
 
 	aarch64_vcpu_setup(vm, vcpu_id, init);
 
@@ -336,7 +335,7 @@ struct kvm_vcpu *aarch64_vcpu_add_default(struct kvm_vm *vm, uint32_t vcpu_id,
 struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id,
 				  void *guest_code)
 {
-	return aarch64_vcpu_add_default(vm, vcpu_id, NULL, guest_code);
+	return aarch64_vcpu_add(vm, vcpu_id, NULL, guest_code);
 }
 
 void vcpu_args_set(struct kvm_vm *vm, uint32_t vcpuid, unsigned int num, ...)
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 23de0335f22b..1580d4888d74 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -344,7 +344,7 @@ struct kvm_vm *vm_create_with_vcpus(enum vm_guest_mode mode, uint32_t nr_vcpus,
 	for (i = 0; i < nr_vcpus; ++i) {
 		uint32_t vcpuid = vcpuids ? vcpuids[i] : i;
 
-		vm_vcpu_add_default(vm, vcpuid, guest_code);
+		vm_vcpu_add(vm, vcpuid, guest_code);
 	}
 
 	return vm;
@@ -413,7 +413,7 @@ struct kvm_vcpu *vm_recreate_with_one_vcpu(struct kvm_vm *vm)
 {
 	kvm_vm_restart(vm);
 
-	return vm_vcpu_add(vm, 0);
+	return __vm_vcpu_add(vm, 0);
 }
 
 /*
@@ -1060,7 +1060,7 @@ static int vcpu_mmap_sz(void)
  * Adds a virtual CPU to the VM specified by vm with the ID given by vcpu_id.
  * No additional vCPU setup is done.  Returns the vCPU.
  */
-struct kvm_vcpu *vm_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id)
+struct kvm_vcpu *__vm_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id)
 {
 	struct kvm_vcpu *vcpu;
 
diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tools/testing/selftests/kvm/lib/riscv/processor.c
index 34a9f0cf05ba..5a57494751e1 100644
--- a/tools/testing/selftests/kvm/lib/riscv/processor.c
+++ b/tools/testing/selftests/kvm/lib/riscv/processor.c
@@ -286,7 +286,7 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id,
 	struct kvm_mp_state mps;
 	struct kvm_vcpu *vcpu;
 
-	vcpu = vm_vcpu_add(vm, vcpuid);
+	vcpu = __vm_vcpu_add(vm, vcpuid);
 	riscv_vcpu_mmu_setup(vm, vcpuid);
 
 	/*
diff --git a/tools/testing/selftests/kvm/lib/s390x/processor.c b/tools/testing/selftests/kvm/lib/s390x/processor.c
index 5c59a1d7ec6d..f8170e97eeb7 100644
--- a/tools/testing/selftests/kvm/lib/s390x/processor.c
+++ b/tools/testing/selftests/kvm/lib/s390x/processor.c
@@ -170,7 +170,7 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id,
 	stack_vaddr = vm_vaddr_alloc(vm, stack_size,
 				     DEFAULT_GUEST_STACK_VADDR_MIN);
 
-	vcpu = vm_vcpu_add(vm, vcpuid);
+	vcpu = __vm_vcpu_add(vm, vcpu_id);
 
 	/* Setup guest registers */
 	vcpu_regs_get(vm, vcpu_id, &regs);
diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index 24ec376c5d6d..c773f7b1ed4c 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -682,7 +682,7 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id,
 	stack_vaddr = vm_vaddr_alloc(vm, DEFAULT_STACK_PGS * getpagesize(),
 				     DEFAULT_GUEST_STACK_VADDR_MIN);
 
-	vcpu = vm_vcpu_add(vm, vcpu_id);
+	vcpu = __vm_vcpu_add(vm, vcpu_id);
 	vcpu_set_cpuid(vm, vcpu_id, kvm_get_supported_cpuid());
 	vcpu_setup(vm, vcpu_id);
 
diff --git a/tools/testing/selftests/kvm/set_memory_region_test.c b/tools/testing/selftests/kvm/set_memory_region_test.c
index 13859b37e28d..4913d6a5b311 100644
--- a/tools/testing/selftests/kvm/set_memory_region_test.c
+++ b/tools/testing/selftests/kvm/set_memory_region_test.c
@@ -315,7 +315,7 @@ static void test_zero_memory_regions(void)
 	pr_info("Testing KVM_RUN with zero added memory regions\n");
 
 	vm = vm_create(0);
-	vcpu = vm_vcpu_add(vm, 0);
+	vcpu = __vm_vcpu_add(vm, 0);
 
 	vm_ioctl(vm, KVM_SET_NR_MMU_PAGES, (void *)64ul);
 	vcpu_run(vm, vcpu->id);
diff --git a/tools/testing/selftests/kvm/steal_time.c b/tools/testing/selftests/kvm/steal_time.c
index 1d6a91a53eae..741892cec1ea 100644
--- a/tools/testing/selftests/kvm/steal_time.c
+++ b/tools/testing/selftests/kvm/steal_time.c
@@ -282,7 +282,7 @@ int main(int ac, char **av)
 
 	/* Add the rest of the VCPUs */
 	for (i = 1; i < NR_VCPUS; ++i)
-		vm_vcpu_add_default(vm, i, guest_code);
+		vm_vcpu_add(vm, i, guest_code);
 
 	steal_time_init(vm);
 
diff --git a/tools/testing/selftests/kvm/x86_64/set_boot_cpu_id.c b/tools/testing/selftests/kvm/x86_64/set_boot_cpu_id.c
index b4da92ddc1c6..b6a1dceb2be9 100644
--- a/tools/testing/selftests/kvm/x86_64/set_boot_cpu_id.c
+++ b/tools/testing/selftests/kvm/x86_64/set_boot_cpu_id.c
@@ -99,9 +99,9 @@ static struct kvm_vm *create_vm(void)
 static void add_x86_vcpu(struct kvm_vm *vm, uint32_t vcpuid, bool bsp_code)
 {
 	if (bsp_code)
-		vm_vcpu_add_default(vm, vcpuid, guest_bsp_vcpu);
+		vm_vcpu_add(vm, vcpuid, guest_bsp_vcpu);
 	else
-		vm_vcpu_add_default(vm, vcpuid, guest_not_bsp_vcpu);
+		vm_vcpu_add(vm, vcpuid, guest_not_bsp_vcpu);
 }
 
 static void run_vm_bsp(uint32_t bsp_vcpu)
diff --git a/tools/testing/selftests/kvm/x86_64/set_sregs_test.c b/tools/testing/selftests/kvm/x86_64/set_sregs_test.c
index 2b3cae9a1d5b..9bc1d6b33172 100644
--- a/tools/testing/selftests/kvm/x86_64/set_sregs_test.c
+++ b/tools/testing/selftests/kvm/x86_64/set_sregs_test.c
@@ -95,7 +95,7 @@ int main(int argc, char *argv[])
 	 * the vCPU model, i.e. without doing KVM_SET_CPUID2.
 	 */
 	vm = vm_create(DEFAULT_GUEST_PHY_PAGES);
-	vcpu = vm_vcpu_add(vm, 0);
+	vcpu = __vm_vcpu_add(vm, 0);
 
 	vcpu_sregs_get(vm, vcpu->id, &sregs);
 
diff --git a/tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c b/tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c
index fb26d0d85fcb..d8ebae374f88 100644
--- a/tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c
+++ b/tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c
@@ -54,7 +54,7 @@ static struct kvm_vm *sev_vm_create(bool es)
 	vm = vm_create(0);
 	sev_ioctl(vm->fd, es ? KVM_SEV_ES_INIT : KVM_SEV_INIT, NULL);
 	for (i = 0; i < NR_MIGRATE_TEST_VCPUS; ++i)
-		vm_vcpu_add(vm, i);
+		__vm_vcpu_add(vm, i);
 	if (es)
 		start.policy |= SEV_POLICY_ES;
 	sev_ioctl(vm->fd, KVM_SEV_LAUNCH_START, &start);
@@ -73,7 +73,7 @@ static struct kvm_vm *aux_vm_create(bool with_vcpus)
 		return vm;
 
 	for (i = 0; i < NR_MIGRATE_TEST_VCPUS; ++i)
-		vm_vcpu_add(vm, i);
+		__vm_vcpu_add(vm, i);
 
 	return vm;
 }
@@ -177,7 +177,7 @@ static void test_sev_migrate_parameters(void)
 	vm_no_sev = aux_vm_create(true);
 	sev_es_vm_no_vmsa = vm_create(0);
 	sev_ioctl(sev_es_vm_no_vmsa->fd, KVM_SEV_ES_INIT, NULL);
-	vm_vcpu_add(sev_es_vm_no_vmsa, 1);
+	__vm_vcpu_add(sev_es_vm_no_vmsa, 1);
 
 	ret = __sev_migrate_from(sev_vm->fd, sev_es_vm->fd);
 	TEST_ASSERT(
@@ -282,7 +282,7 @@ static void test_sev_mirror(bool es)
 
 	/* Check that we can complete creation of the mirror VM.  */
 	for (i = 0; i < NR_MIGRATE_TEST_VCPUS; ++i)
-		vm_vcpu_add(dst_vm, i);
+		__vm_vcpu_add(dst_vm, i);
 
 	if (es)
 		sev_ioctl(dst_vm->fd, KVM_SEV_LAUNCH_UPDATE_VMSA, NULL);
diff --git a/tools/testing/selftests/kvm/x86_64/xapic_ipi_test.c b/tools/testing/selftests/kvm/x86_64/xapic_ipi_test.c
index afbbc40df884..8b366652be31 100644
--- a/tools/testing/selftests/kvm/x86_64/xapic_ipi_test.c
+++ b/tools/testing/selftests/kvm/x86_64/xapic_ipi_test.c
@@ -425,7 +425,7 @@ int main(int argc, char *argv[])
 
 	virt_pg_map(vm, APIC_DEFAULT_GPA, APIC_DEFAULT_GPA);
 
-	vm_vcpu_add_default(vm, SENDER_VCPU_ID, sender_guest_code);
+	vm_vcpu_add(vm, SENDER_VCPU_ID, sender_guest_code);
 
 	test_data_page_vaddr = vm_vaddr_alloc_page(vm);
 	data =
-- 
2.35.1.723.g4982287a31-goog


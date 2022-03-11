Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC4F4D5AE0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346545AbiCKFwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 00:52:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346536AbiCKFwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:52:18 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8B0ED95A
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:51:15 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id b4-20020a170902a9c400b001532ec9005aso1216345plr.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=dX7IuUZw3sw8TOh4qDkLh9p0JgbEeFWnKwYZjGvVjNg=;
        b=jLWAgMsErc0SGwO5i8qarX1TgIKs4j6J4ki1EaJaMJxeMKQp/giyZ274gZ1D98H7N8
         GXhBPpQY7cIFlkgorWdcZxdvil29szmb/PEbYTZJtFaPpkBLsUptviUMAlJV0Sq3oJOV
         fIoPG+2wJUGyBqqKAJR9HIkNq4/8v2u0T8L/ocAoZjOZE+IaNHZvek5H0rMH8cNI2Dpn
         U/yoUH3lIddfniVNlMbYdlC/3+ygeFRWL4mvHbJrzzn/PxHV2tUEldZ5hgzgePutLKh3
         kOQtzkuIBqWmomlFZz5gUeOsTSfaL1OrqNkZoXgcVvg24nM+Nljub9e/Dtbf969jYtQv
         pi8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=dX7IuUZw3sw8TOh4qDkLh9p0JgbEeFWnKwYZjGvVjNg=;
        b=BpMWdi06kqskBPLg51qwZ70Z3yybHrC28McMw0jTLcVyvBrEe0GU9VURttT/g3Xe4W
         39zuZzB5AgtksqSkEQXMV3P4SdoS2fIOwH6vsVDL655tOzC2WP127kdRm5WoHiJgIhyZ
         AbU0E9CKM7olrV4s15wHGJaa29hhkBQLQYz9r8HnbFdEAyV7VmZSYO9CweH3uUPGFdXT
         1hsyWVdGKI/74OmmSxajXwnj5YdIOEO1RGz2CQfw4V9zjo1lhK9YsNyJiXSx/GrPR+L/
         M1Fuh3u9HsTag9H/4dCXt6A5riESXWzZA2ZMLzSp/gmc1p5jHtmQDiI937Llx92QWa5A
         ctHQ==
X-Gm-Message-State: AOAM531Uwks4P4o/CErGr+3kPe6sBOxNsRl1G+Xbs8SvvcxFsaOwN8EB
        h9izQa/lAaiPPnZOIwK1jcXPUQfhp9hEVU1kP4oBXYXmJE38jPqN6stdgRFgI8TOG3Y7qcSrAzA
        1blkfSP1TAcetuTs7BNsS3fu7T8SllBolXAIMObm8nTVTEvJ3rZQY0V6HeuF74eeAQ5ydhw==
X-Google-Smtp-Source: ABdhPJwuUH5C2NRX0M1Aq3JUBX1L1t2NtpPLPeYUPzVqWbMH9PlDrsGuOQ1y7pxdiWHj1jQT27xf/CTevUg=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90a:8987:b0:1be:dde1:c672 with SMTP id
 v7-20020a17090a898700b001bedde1c672mr9066734pjn.208.1646977874873; Thu, 10
 Mar 2022 21:51:14 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:49:16 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-6-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 005/105] KVM: selftests: Drop @mode from common
 vm_create() helper
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
 .../selftests/kvm/aarch64/get-reg-list.c      |  2 +-
 .../selftests/kvm/aarch64/psci_cpu_on_test.c  |  2 +-
 tools/testing/selftests/kvm/dirty_log_test.c  |  2 +-
 .../selftests/kvm/hardware_disable_test.c     |  2 +-
 .../selftests/kvm/include/kvm_util_base.h     |  3 +-
 .../selftests/kvm/kvm_binary_stats_test.c     |  3 +-
 .../selftests/kvm/kvm_create_max_vcpus.c      |  2 +-
 tools/testing/selftests/kvm/lib/kvm_util.c    | 43 ++++++++++---------
 .../selftests/kvm/set_memory_region_test.c    |  4 +-
 .../selftests/kvm/x86_64/set_boot_cpu_id.c    |  2 +-
 .../selftests/kvm/x86_64/set_sregs_test.c     |  2 +-
 .../selftests/kvm/x86_64/sev_migrate_tests.c  |  8 ++--
 12 files changed, 39 insertions(+), 36 deletions(-)

diff --git a/tools/testing/selftests/kvm/aarch64/get-reg-list.c b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
index 422f9a4792ba..0cbee268c953 100644
--- a/tools/testing/selftests/kvm/aarch64/get-reg-list.c
+++ b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
@@ -411,7 +411,7 @@ static void run_test(struct vcpu_config *c)
 
 	check_supported(c);
 
-	vm = vm_create(VM_MODE_DEFAULT, DEFAULT_GUEST_PHY_PAGES);
+	vm = vm_create(DEFAULT_GUEST_PHY_PAGES);
 	prepare_vcpu_init(c, &init);
 	aarch64_vcpu_add_default(vm, 0, &init, NULL);
 	finalize_vcpu(vm, 0, c);
diff --git a/tools/testing/selftests/kvm/aarch64/psci_cpu_on_test.c b/tools/testing/selftests/kvm/aarch64/psci_cpu_on_test.c
index 15f4b3544ee5..bde7bae20a6e 100644
--- a/tools/testing/selftests/kvm/aarch64/psci_cpu_on_test.c
+++ b/tools/testing/selftests/kvm/aarch64/psci_cpu_on_test.c
@@ -76,7 +76,7 @@ int main(void)
 	struct kvm_vm *vm;
 	struct ucall uc;
 
-	vm = vm_create(VM_MODE_DEFAULT, DEFAULT_GUEST_PHY_PAGES);
+	vm = vm_create(DEFAULT_GUEST_PHY_PAGES);
 	kvm_vm_elf_load(vm, program_invocation_name);
 	ucall_init(vm, NULL);
 
diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index 11bf606e3165..01c01d40201f 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -679,7 +679,7 @@ static struct kvm_vm *create_vm(enum vm_guest_mode mode, uint32_t vcpuid,
 
 	pr_info("Testing guest mode: %s\n", vm_guest_mode_string(mode));
 
-	vm = vm_create(mode, DEFAULT_GUEST_PHY_PAGES + extra_pg_pages);
+	vm = __vm_create(mode, DEFAULT_GUEST_PHY_PAGES + extra_pg_pages);
 	kvm_vm_elf_load(vm, program_invocation_name);
 #ifdef __x86_64__
 	vm_create_irqchip(vm);
diff --git a/tools/testing/selftests/kvm/hardware_disable_test.c b/tools/testing/selftests/kvm/hardware_disable_test.c
index 1c9e2295c75b..81ba8645772a 100644
--- a/tools/testing/selftests/kvm/hardware_disable_test.c
+++ b/tools/testing/selftests/kvm/hardware_disable_test.c
@@ -104,7 +104,7 @@ static void run_test(uint32_t run)
 	for (i = 0; i < VCPU_NUM; i++)
 		CPU_SET(i, &cpu_set);
 
-	vm = vm_create(VM_MODE_DEFAULT, DEFAULT_GUEST_PHY_PAGES);
+	vm = vm_create(DEFAULT_GUEST_PHY_PAGES);
 	kvm_vm_elf_load(vm, program_invocation_name);
 	vm_create_irqchip(vm);
 
diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index 28440c12ffbc..c29606be1268 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -110,7 +110,8 @@ int vcpu_enable_cap(struct kvm_vm *vm, uint32_t vcpu_id,
 void vm_enable_dirty_ring(struct kvm_vm *vm, uint32_t ring_size);
 const char *vm_guest_mode_string(uint32_t i);
 
-struct kvm_vm *vm_create(enum vm_guest_mode mode, uint64_t phy_pages);
+struct kvm_vm *__vm_create(enum vm_guest_mode mode, uint64_t phy_pages);
+struct kvm_vm *vm_create(uint64_t phy_pages);
 void kvm_vm_free(struct kvm_vm *vmp);
 void kvm_vm_restart(struct kvm_vm *vmp);
 void kvm_vm_release(struct kvm_vm *vmp);
diff --git a/tools/testing/selftests/kvm/kvm_binary_stats_test.c b/tools/testing/selftests/kvm/kvm_binary_stats_test.c
index 6217f4630e6c..4b149b383678 100644
--- a/tools/testing/selftests/kvm/kvm_binary_stats_test.c
+++ b/tools/testing/selftests/kvm/kvm_binary_stats_test.c
@@ -229,8 +229,7 @@ int main(int argc, char *argv[])
 	vms = malloc(sizeof(vms[0]) * max_vm);
 	TEST_ASSERT(vms, "Allocate memory for storing VM pointers");
 	for (i = 0; i < max_vm; ++i) {
-		vms[i] = vm_create(VM_MODE_DEFAULT,
-				DEFAULT_GUEST_PHY_PAGES);
+		vms[i] = vm_create(DEFAULT_GUEST_PHY_PAGES);
 		for (j = 0; j < max_vcpu; ++j)
 			vm_vcpu_add(vms[i], j);
 	}
diff --git a/tools/testing/selftests/kvm/kvm_create_max_vcpus.c b/tools/testing/selftests/kvm/kvm_create_max_vcpus.c
index bb69b75eac23..9de5e1376c49 100644
--- a/tools/testing/selftests/kvm/kvm_create_max_vcpus.c
+++ b/tools/testing/selftests/kvm/kvm_create_max_vcpus.c
@@ -28,7 +28,7 @@ void test_vcpu_creation(int first_vcpu_id, int num_vcpus)
 	pr_info("Testing creating %d vCPUs, with IDs %d...%d.\n",
 		num_vcpus, first_vcpu_id, first_vcpu_id + num_vcpus - 1);
 
-	vm = vm_create(VM_MODE_DEFAULT, DEFAULT_GUEST_PHY_PAGES);
+	vm = vm_create(DEFAULT_GUEST_PHY_PAGES);
 
 	for (i = first_vcpu_id; i < first_vcpu_id + num_vcpus; i++)
 		/* This asserts that the vCPU was created. */
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index a6675d9aa7d9..03178004a6c3 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -234,25 +234,7 @@ const struct vm_guest_mode_params vm_guest_mode_params[] = {
 _Static_assert(sizeof(vm_guest_mode_params)/sizeof(struct vm_guest_mode_params) == NUM_VM_MODES,
 	       "Missing new mode params?");
 
-/*
- * VM Create
- *
- * Input Args:
- *   mode - VM Mode (e.g. VM_MODE_P52V48_4K)
- *   phy_pages - Physical memory pages
- *
- * Output Args: None
- *
- * Return:
- *   Pointer to opaque structure that describes the created VM.
- *
- * Creates a VM with the mode specified by mode (e.g. VM_MODE_P52V48_4K).
- * When phy_pages is non-zero, a memory region of phy_pages physical pages
- * is created and mapped starting at guest physical address 0.  The file
- * descriptor to control the created VM is created with the permissions
- * given by perm (e.g. O_RDWR).
- */
-struct kvm_vm *vm_create(enum vm_guest_mode mode, uint64_t phy_pages)
+struct kvm_vm *__vm_create(enum vm_guest_mode mode, uint64_t phy_pages)
 {
 	struct kvm_vm *vm;
 
@@ -361,6 +343,27 @@ struct kvm_vm *vm_create(enum vm_guest_mode mode, uint64_t phy_pages)
 	return vm;
 }
 
+
+/*
+ * VM Create
+ *
+ * Input Args:
+ *   phy_pages - Physical memory pages
+ *
+ * Output Args: None
+ *
+ * Return:
+ *   Pointer to opaque structure that describes the created VM.
+ *
+ * Creates a VM with the default physical/virtual address widths and page size.
+ * When phy_pages is non-zero, a memory region of phy_pages physical pages
+ * is created and mapped starting at guest physical address 0.
+ */
+struct kvm_vm *vm_create(uint64_t phy_pages)
+{
+	return __vm_create(VM_MODE_DEFAULT, phy_pages);
+}
+
 /*
  * VM Create with customized parameters
  *
@@ -411,7 +414,7 @@ struct kvm_vm *vm_create_with_vcpus(enum vm_guest_mode mode, uint32_t nr_vcpus,
 		    nr_vcpus, kvm_check_cap(KVM_CAP_MAX_VCPUS));
 
 	pages = vm_adjust_num_guest_pages(mode, pages);
-	vm = vm_create(mode, pages);
+	vm = __vm_create(mode, pages);
 
 	kvm_vm_elf_load(vm, program_invocation_name);
 
diff --git a/tools/testing/selftests/kvm/set_memory_region_test.c b/tools/testing/selftests/kvm/set_memory_region_test.c
index 6a115d8d2fe3..fa4613010091 100644
--- a/tools/testing/selftests/kvm/set_memory_region_test.c
+++ b/tools/testing/selftests/kvm/set_memory_region_test.c
@@ -314,7 +314,7 @@ static void test_zero_memory_regions(void)
 
 	pr_info("Testing KVM_RUN with zero added memory regions\n");
 
-	vm = vm_create(VM_MODE_DEFAULT, 0);
+	vm = vm_create(0);
 	vm_vcpu_add(vm, VCPU_ID);
 
 	TEST_ASSERT(!ioctl(vm_get_fd(vm), KVM_SET_NR_MMU_PAGES, 64),
@@ -370,7 +370,7 @@ static void test_add_max_memory_regions(void)
 		    "KVM_CAP_NR_MEMSLOTS should be greater than 0");
 	pr_info("Allowed number of memory slots: %i\n", max_mem_slots);
 
-	vm = vm_create(VM_MODE_DEFAULT, 0);
+	vm = vm_create(0);
 
 	/* Check it can be added memory slots up to the maximum allowed */
 	pr_info("Adding slots 0..%i, each memory region with %dK size\n",
diff --git a/tools/testing/selftests/kvm/x86_64/set_boot_cpu_id.c b/tools/testing/selftests/kvm/x86_64/set_boot_cpu_id.c
index ee3d058a9fe1..b4da92ddc1c6 100644
--- a/tools/testing/selftests/kvm/x86_64/set_boot_cpu_id.c
+++ b/tools/testing/selftests/kvm/x86_64/set_boot_cpu_id.c
@@ -88,7 +88,7 @@ static struct kvm_vm *create_vm(void)
 	uint64_t pages = DEFAULT_GUEST_PHY_PAGES + vcpu_pages + extra_pg_pages;
 
 	pages = vm_adjust_num_guest_pages(VM_MODE_DEFAULT, pages);
-	vm = vm_create(VM_MODE_DEFAULT, pages);
+	vm = vm_create(pages);
 
 	kvm_vm_elf_load(vm, program_invocation_name);
 	vm_create_irqchip(vm);
diff --git a/tools/testing/selftests/kvm/x86_64/set_sregs_test.c b/tools/testing/selftests/kvm/x86_64/set_sregs_test.c
index 44711ab735c3..4dc7fd925023 100644
--- a/tools/testing/selftests/kvm/x86_64/set_sregs_test.c
+++ b/tools/testing/selftests/kvm/x86_64/set_sregs_test.c
@@ -95,7 +95,7 @@ int main(int argc, char *argv[])
 	 * use it to verify all supported CR4 bits can be set prior to defining
 	 * the vCPU model, i.e. without doing KVM_SET_CPUID2.
 	 */
-	vm = vm_create(VM_MODE_DEFAULT, DEFAULT_GUEST_PHY_PAGES);
+	vm = vm_create(DEFAULT_GUEST_PHY_PAGES);
 	vm_vcpu_add(vm, VCPU_ID);
 
 	vcpu_sregs_get(vm, VCPU_ID, &sregs);
diff --git a/tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c b/tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c
index 7729ca60a9d7..d29cf773d7bf 100644
--- a/tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c
+++ b/tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c
@@ -52,7 +52,7 @@ static struct kvm_vm *sev_vm_create(bool es)
 	struct kvm_sev_launch_start start = { 0 };
 	int i;
 
-	vm = vm_create(VM_MODE_DEFAULT, 0);
+	vm = vm_create(0);
 	sev_ioctl(vm->fd, es ? KVM_SEV_ES_INIT : KVM_SEV_INIT, NULL);
 	for (i = 0; i < NR_MIGRATE_TEST_VCPUS; ++i)
 		vm_vcpu_add(vm, i);
@@ -69,7 +69,7 @@ static struct kvm_vm *aux_vm_create(bool with_vcpus)
 	struct kvm_vm *vm;
 	int i;
 
-	vm = vm_create(VM_MODE_DEFAULT, 0);
+	vm = vm_create(0);
 	if (!with_vcpus)
 		return vm;
 
@@ -174,9 +174,9 @@ static void test_sev_migrate_parameters(void)
 
 	sev_vm = sev_vm_create(/* es= */ false);
 	sev_es_vm = sev_vm_create(/* es= */ true);
-	vm_no_vcpu = vm_create(VM_MODE_DEFAULT, 0);
+	vm_no_vcpu = vm_create(0);
 	vm_no_sev = aux_vm_create(true);
-	sev_es_vm_no_vmsa = vm_create(VM_MODE_DEFAULT, 0);
+	sev_es_vm_no_vmsa = vm_create(0);
 	sev_ioctl(sev_es_vm_no_vmsa->fd, KVM_SEV_ES_INIT, NULL);
 	vm_vcpu_add(sev_es_vm_no_vmsa, 1);
 
-- 
2.35.1.723.g4982287a31-goog


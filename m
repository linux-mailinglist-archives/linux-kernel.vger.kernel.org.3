Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 010CE4D5AD2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346548AbiCKFwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 00:52:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346526AbiCKFwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:52:14 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C15ECC72
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:51:11 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id e1-20020a17090a280100b001bf44b6d74bso7304455pjd.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=IlAOOfd+yjpBKx3sGohnGp0k5UedDOqO6DTlbC9I7/o=;
        b=AHwe3L1UBOLOFvRnkYn4H5rqgLYsWe/9rz1NcYwFAuzO+/PV9IVsJfia+KUiFrF7Wr
         U/AzC0EsLN0n+vX1BDaSfij2v7ueYoX3j4y6J5B8nvQJGBOVTXMCbuZB+VvfgNzDyzzF
         a3M/4ab8+OifPc0SazONc5ThbREnBXErIUfm5F1kZDEvRxobad+agb1yoV3xp+BY2J4a
         +leFuRiyizESiajG13N7v+49czgVUXGE6HDqv0PVKMVqSOqQ/z94wu/k+HA9PiRcQxDe
         wvehmPCAqf90iClWlccjdmOt54KBc8qlbrtx4jSGY9BVl/MPy/DHSeD4DqZB4qv4w4IX
         g5Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=IlAOOfd+yjpBKx3sGohnGp0k5UedDOqO6DTlbC9I7/o=;
        b=YzOXQFn5obU6MMOYzv6x1WydtvU9bhsLMfKiAjB6NRnTKCo1Ar4ETHm13xGK2CoZXs
         tAHEw9IiWW7hXkLt1qAJ08hKunlOPn9ce6KPYvelivVtMlzBmhWxtioMQMeLWW9Q/+xR
         R3Y52rH95OJ3xonHzaw2Ym+cQZXcfqHW1aGVonTK9XsPT8yxlCmmQDeVgeYWy7AylxlJ
         csfaJb2qY7U9vDFoX1CjxKA1PmLMOR1Q9ExW8NDicn15q6iMCaee2mUTqovbnOcUo0if
         /Pxu0iYTuzOiS2doay5YhSAIUP2qORuiyn78GwVxS3qy/ea+vZivFzWmx9oOI0DyPMsG
         8k4g==
X-Gm-Message-State: AOAM532n+rI1a9ybohI86kPacU/H5qpBIiQlTJljHlmZd3Y/cckQsmwZ
        K3nInCnbABDB1nesra0/bNA59BGOqjWb0lv6vgbgSU6x6Uag09+/bijINWz0LnMb9RCRUcJ27AL
        petOJAN+NwUcO6s5HWlWZErejOzQdfOkbn7yJgip19tHoJaSKjxjRa2t212X5I7ZzxpgLbw==
X-Google-Smtp-Source: ABdhPJwwksVaQQv0UGOboLOCN0S0AnjExM9NOc9xZFogbhfKDDvhXcKDnuZmcFxgnDHNkec7eSX1zl1YCSc=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90b:1e10:b0:1bf:6c78:54a9 with SMTP id
 pg16-20020a17090b1e1000b001bf6c7854a9mr460280pjb.1.1646977870391; Thu, 10 Mar
 2022 21:51:10 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:49:13 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-3-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 002/105] KVM: selftests: Always open VM file descriptors
 with O_RDWR
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
 .../selftests/kvm/include/kvm_util_base.h     |  4 ++--
 .../selftests/kvm/kvm_binary_stats_test.c     |  2 +-
 .../selftests/kvm/kvm_create_max_vcpus.c      |  2 +-
 tools/testing/selftests/kvm/lib/kvm_util.c    | 20 +++++++++----------
 .../selftests/kvm/set_memory_region_test.c    |  4 ++--
 tools/testing/selftests/kvm/x86_64/amx_test.c |  2 +-
 .../testing/selftests/kvm/x86_64/evmcs_test.c |  2 +-
 .../selftests/kvm/x86_64/set_boot_cpu_id.c    |  2 +-
 .../selftests/kvm/x86_64/set_sregs_test.c     |  2 +-
 .../selftests/kvm/x86_64/sev_migrate_tests.c  |  8 ++++----
 tools/testing/selftests/kvm/x86_64/smm_test.c |  2 +-
 .../testing/selftests/kvm/x86_64/state_test.c |  2 +-
 .../kvm/x86_64/vmx_preemption_timer_test.c    |  2 +-
 17 files changed, 30 insertions(+), 32 deletions(-)

diff --git a/tools/testing/selftests/kvm/aarch64/get-reg-list.c b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
index f769fc6cd927..336de3e574d0 100644
--- a/tools/testing/selftests/kvm/aarch64/get-reg-list.c
+++ b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
@@ -411,7 +411,7 @@ static void run_test(struct vcpu_config *c)
 
 	check_supported(c);
 
-	vm = vm_create(VM_MODE_DEFAULT, DEFAULT_GUEST_PHY_PAGES, O_RDWR);
+	vm = vm_create(VM_MODE_DEFAULT, DEFAULT_GUEST_PHY_PAGES);
 	prepare_vcpu_init(c, &init);
 	aarch64_vcpu_add_default(vm, 0, &init, NULL);
 	finalize_vcpu(vm, 0, c);
diff --git a/tools/testing/selftests/kvm/aarch64/psci_cpu_on_test.c b/tools/testing/selftests/kvm/aarch64/psci_cpu_on_test.c
index 4c5f6814030f..15f4b3544ee5 100644
--- a/tools/testing/selftests/kvm/aarch64/psci_cpu_on_test.c
+++ b/tools/testing/selftests/kvm/aarch64/psci_cpu_on_test.c
@@ -76,7 +76,7 @@ int main(void)
 	struct kvm_vm *vm;
 	struct ucall uc;
 
-	vm = vm_create(VM_MODE_DEFAULT, DEFAULT_GUEST_PHY_PAGES, O_RDWR);
+	vm = vm_create(VM_MODE_DEFAULT, DEFAULT_GUEST_PHY_PAGES);
 	kvm_vm_elf_load(vm, program_invocation_name);
 	ucall_init(vm, NULL);
 
diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index 3fcd89e195c7..11bf606e3165 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -679,7 +679,7 @@ static struct kvm_vm *create_vm(enum vm_guest_mode mode, uint32_t vcpuid,
 
 	pr_info("Testing guest mode: %s\n", vm_guest_mode_string(mode));
 
-	vm = vm_create(mode, DEFAULT_GUEST_PHY_PAGES + extra_pg_pages, O_RDWR);
+	vm = vm_create(mode, DEFAULT_GUEST_PHY_PAGES + extra_pg_pages);
 	kvm_vm_elf_load(vm, program_invocation_name);
 #ifdef __x86_64__
 	vm_create_irqchip(vm);
diff --git a/tools/testing/selftests/kvm/hardware_disable_test.c b/tools/testing/selftests/kvm/hardware_disable_test.c
index b21c69a56daa..1c9e2295c75b 100644
--- a/tools/testing/selftests/kvm/hardware_disable_test.c
+++ b/tools/testing/selftests/kvm/hardware_disable_test.c
@@ -104,7 +104,7 @@ static void run_test(uint32_t run)
 	for (i = 0; i < VCPU_NUM; i++)
 		CPU_SET(i, &cpu_set);
 
-	vm = vm_create(VM_MODE_DEFAULT, DEFAULT_GUEST_PHY_PAGES, O_RDWR);
+	vm = vm_create(VM_MODE_DEFAULT, DEFAULT_GUEST_PHY_PAGES);
 	kvm_vm_elf_load(vm, program_invocation_name);
 	vm_create_irqchip(vm);
 
diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index 4ed6aa049a91..bbc66442f91f 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -110,9 +110,9 @@ int vcpu_enable_cap(struct kvm_vm *vm, uint32_t vcpu_id,
 void vm_enable_dirty_ring(struct kvm_vm *vm, uint32_t ring_size);
 const char *vm_guest_mode_string(uint32_t i);
 
-struct kvm_vm *vm_create(enum vm_guest_mode mode, uint64_t phy_pages, int perm);
+struct kvm_vm *vm_create(enum vm_guest_mode mode, uint64_t phy_pages);
 void kvm_vm_free(struct kvm_vm *vmp);
-void kvm_vm_restart(struct kvm_vm *vmp, int perm);
+void kvm_vm_restart(struct kvm_vm *vmp);
 void kvm_vm_release(struct kvm_vm *vmp);
 void kvm_vm_get_dirty_log(struct kvm_vm *vm, int slot, void *log);
 void kvm_vm_clear_dirty_log(struct kvm_vm *vm, int slot, void *log,
diff --git a/tools/testing/selftests/kvm/kvm_binary_stats_test.c b/tools/testing/selftests/kvm/kvm_binary_stats_test.c
index 17f65d514915..6217f4630e6c 100644
--- a/tools/testing/selftests/kvm/kvm_binary_stats_test.c
+++ b/tools/testing/selftests/kvm/kvm_binary_stats_test.c
@@ -230,7 +230,7 @@ int main(int argc, char *argv[])
 	TEST_ASSERT(vms, "Allocate memory for storing VM pointers");
 	for (i = 0; i < max_vm; ++i) {
 		vms[i] = vm_create(VM_MODE_DEFAULT,
-				DEFAULT_GUEST_PHY_PAGES, O_RDWR);
+				DEFAULT_GUEST_PHY_PAGES);
 		for (j = 0; j < max_vcpu; ++j)
 			vm_vcpu_add(vms[i], j);
 	}
diff --git a/tools/testing/selftests/kvm/kvm_create_max_vcpus.c b/tools/testing/selftests/kvm/kvm_create_max_vcpus.c
index aed9dc3ca1e9..bb69b75eac23 100644
--- a/tools/testing/selftests/kvm/kvm_create_max_vcpus.c
+++ b/tools/testing/selftests/kvm/kvm_create_max_vcpus.c
@@ -28,7 +28,7 @@ void test_vcpu_creation(int first_vcpu_id, int num_vcpus)
 	pr_info("Testing creating %d vCPUs, with IDs %d...%d.\n",
 		num_vcpus, first_vcpu_id, first_vcpu_id + num_vcpus - 1);
 
-	vm = vm_create(VM_MODE_DEFAULT, DEFAULT_GUEST_PHY_PAGES, O_RDWR);
+	vm = vm_create(VM_MODE_DEFAULT, DEFAULT_GUEST_PHY_PAGES);
 
 	for (i = first_vcpu_id; i < first_vcpu_id + num_vcpus; i++)
 		/* This asserts that the vCPU was created. */
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index d8cf851ab119..3e9654e65a67 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -173,9 +173,9 @@ void vm_enable_dirty_ring(struct kvm_vm *vm, uint32_t ring_size)
 	vm->dirty_ring_size = ring_size;
 }
 
-static void vm_open(struct kvm_vm *vm, int perm)
+static void vm_open(struct kvm_vm *vm)
 {
-	vm->kvm_fd = _open_kvm_dev_path_or_exit(perm);
+	vm->kvm_fd = _open_kvm_dev_path_or_exit(O_RDWR);
 
 	if (!kvm_check_cap(KVM_CAP_IMMEDIATE_EXIT)) {
 		print_skip("immediate_exit not available");
@@ -240,7 +240,6 @@ _Static_assert(sizeof(vm_guest_mode_params)/sizeof(struct vm_guest_mode_params)
  * Input Args:
  *   mode - VM Mode (e.g. VM_MODE_P52V48_4K)
  *   phy_pages - Physical memory pages
- *   perm - permission
  *
  * Output Args: None
  *
@@ -253,12 +252,12 @@ _Static_assert(sizeof(vm_guest_mode_params)/sizeof(struct vm_guest_mode_params)
  * descriptor to control the created VM is created with the permissions
  * given by perm (e.g. O_RDWR).
  */
-struct kvm_vm *vm_create(enum vm_guest_mode mode, uint64_t phy_pages, int perm)
+struct kvm_vm *vm_create(enum vm_guest_mode mode, uint64_t phy_pages)
 {
 	struct kvm_vm *vm;
 
-	pr_debug("%s: mode='%s' pages='%ld' perm='%d'\n", __func__,
-		 vm_guest_mode_string(mode), phy_pages, perm);
+	pr_debug("%s: mode='%s' pages='%ld'\n", __func__,
+		 vm_guest_mode_string(mode), phy_pages);
 
 	vm = calloc(1, sizeof(*vm));
 	TEST_ASSERT(vm != NULL, "Insufficient Memory");
@@ -340,7 +339,7 @@ struct kvm_vm *vm_create(enum vm_guest_mode mode, uint64_t phy_pages, int perm)
 		vm->type = KVM_VM_TYPE_ARM_IPA_SIZE(vm->pa_bits);
 #endif
 
-	vm_open(vm, perm);
+	vm_open(vm);
 
 	/* Limit to VA-bit canonical virtual addresses. */
 	vm->vpages_valid = sparsebit_alloc();
@@ -412,7 +411,7 @@ struct kvm_vm *vm_create_with_vcpus(enum vm_guest_mode mode, uint32_t nr_vcpus,
 		    nr_vcpus, kvm_check_cap(KVM_CAP_MAX_VCPUS));
 
 	pages = vm_adjust_num_guest_pages(mode, pages);
-	vm = vm_create(mode, pages, O_RDWR);
+	vm = vm_create(mode, pages);
 
 	kvm_vm_elf_load(vm, program_invocation_name);
 
@@ -449,7 +448,6 @@ struct kvm_vm *vm_create_default(uint32_t vcpuid, uint64_t extra_mem_pages,
  *
  * Input Args:
  *   vm - VM that has been released before
- *   perm - permission
  *
  * Output Args: None
  *
@@ -457,12 +455,12 @@ struct kvm_vm *vm_create_default(uint32_t vcpuid, uint64_t extra_mem_pages,
  * global state, such as the irqchip and the memory regions that are mapped
  * into the guest.
  */
-void kvm_vm_restart(struct kvm_vm *vmp, int perm)
+void kvm_vm_restart(struct kvm_vm *vmp)
 {
 	int ctr;
 	struct userspace_mem_region *region;
 
-	vm_open(vmp, perm);
+	vm_open(vmp);
 	if (vmp->has_irqchip)
 		vm_create_irqchip(vmp);
 
diff --git a/tools/testing/selftests/kvm/set_memory_region_test.c b/tools/testing/selftests/kvm/set_memory_region_test.c
index 72a1c9b4882c..6a115d8d2fe3 100644
--- a/tools/testing/selftests/kvm/set_memory_region_test.c
+++ b/tools/testing/selftests/kvm/set_memory_region_test.c
@@ -314,7 +314,7 @@ static void test_zero_memory_regions(void)
 
 	pr_info("Testing KVM_RUN with zero added memory regions\n");
 
-	vm = vm_create(VM_MODE_DEFAULT, 0, O_RDWR);
+	vm = vm_create(VM_MODE_DEFAULT, 0);
 	vm_vcpu_add(vm, VCPU_ID);
 
 	TEST_ASSERT(!ioctl(vm_get_fd(vm), KVM_SET_NR_MMU_PAGES, 64),
@@ -370,7 +370,7 @@ static void test_add_max_memory_regions(void)
 		    "KVM_CAP_NR_MEMSLOTS should be greater than 0");
 	pr_info("Allowed number of memory slots: %i\n", max_mem_slots);
 
-	vm = vm_create(VM_MODE_DEFAULT, 0, O_RDWR);
+	vm = vm_create(VM_MODE_DEFAULT, 0);
 
 	/* Check it can be added memory slots up to the maximum allowed */
 	pr_info("Adding slots 0..%i, each memory region with %dK size\n",
diff --git a/tools/testing/selftests/kvm/x86_64/amx_test.c b/tools/testing/selftests/kvm/x86_64/amx_test.c
index 52a3ef6629e8..89d2423a2ffd 100644
--- a/tools/testing/selftests/kvm/x86_64/amx_test.c
+++ b/tools/testing/selftests/kvm/x86_64/amx_test.c
@@ -432,7 +432,7 @@ int main(int argc, char *argv[])
 		kvm_vm_release(vm);
 
 		/* Restore state in a new VM.  */
-		kvm_vm_restart(vm, O_RDWR);
+		kvm_vm_restart(vm);
 		vm_vcpu_add(vm, VCPU_ID);
 		vcpu_set_cpuid(vm, VCPU_ID, kvm_get_supported_cpuid());
 		vcpu_load_state(vm, VCPU_ID, state);
diff --git a/tools/testing/selftests/kvm/x86_64/evmcs_test.c b/tools/testing/selftests/kvm/x86_64/evmcs_test.c
index d12e043aa2ee..f97049ab045f 100644
--- a/tools/testing/selftests/kvm/x86_64/evmcs_test.c
+++ b/tools/testing/selftests/kvm/x86_64/evmcs_test.c
@@ -184,7 +184,7 @@ static void save_restore_vm(struct kvm_vm *vm)
 	kvm_vm_release(vm);
 
 	/* Restore state in a new VM.  */
-	kvm_vm_restart(vm, O_RDWR);
+	kvm_vm_restart(vm);
 	vm_vcpu_add(vm, VCPU_ID);
 	vcpu_set_hv_cpuid(vm, VCPU_ID);
 	vcpu_enable_evmcs(vm, VCPU_ID);
diff --git a/tools/testing/selftests/kvm/x86_64/set_boot_cpu_id.c b/tools/testing/selftests/kvm/x86_64/set_boot_cpu_id.c
index ae76436af0cc..2fe893ccedd0 100644
--- a/tools/testing/selftests/kvm/x86_64/set_boot_cpu_id.c
+++ b/tools/testing/selftests/kvm/x86_64/set_boot_cpu_id.c
@@ -88,7 +88,7 @@ static struct kvm_vm *create_vm(void)
 	uint64_t pages = DEFAULT_GUEST_PHY_PAGES + vcpu_pages + extra_pg_pages;
 
 	pages = vm_adjust_num_guest_pages(VM_MODE_DEFAULT, pages);
-	vm = vm_create(VM_MODE_DEFAULT, pages, O_RDWR);
+	vm = vm_create(VM_MODE_DEFAULT, pages);
 
 	kvm_vm_elf_load(vm, program_invocation_name);
 	vm_create_irqchip(vm);
diff --git a/tools/testing/selftests/kvm/x86_64/set_sregs_test.c b/tools/testing/selftests/kvm/x86_64/set_sregs_test.c
index 318be0bf77ab..44711ab735c3 100644
--- a/tools/testing/selftests/kvm/x86_64/set_sregs_test.c
+++ b/tools/testing/selftests/kvm/x86_64/set_sregs_test.c
@@ -95,7 +95,7 @@ int main(int argc, char *argv[])
 	 * use it to verify all supported CR4 bits can be set prior to defining
 	 * the vCPU model, i.e. without doing KVM_SET_CPUID2.
 	 */
-	vm = vm_create(VM_MODE_DEFAULT, DEFAULT_GUEST_PHY_PAGES, O_RDWR);
+	vm = vm_create(VM_MODE_DEFAULT, DEFAULT_GUEST_PHY_PAGES);
 	vm_vcpu_add(vm, VCPU_ID);
 
 	vcpu_sregs_get(vm, VCPU_ID, &sregs);
diff --git a/tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c b/tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c
index 80056bbbb003..7729ca60a9d7 100644
--- a/tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c
+++ b/tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c
@@ -52,7 +52,7 @@ static struct kvm_vm *sev_vm_create(bool es)
 	struct kvm_sev_launch_start start = { 0 };
 	int i;
 
-	vm = vm_create(VM_MODE_DEFAULT, 0, O_RDWR);
+	vm = vm_create(VM_MODE_DEFAULT, 0);
 	sev_ioctl(vm->fd, es ? KVM_SEV_ES_INIT : KVM_SEV_INIT, NULL);
 	for (i = 0; i < NR_MIGRATE_TEST_VCPUS; ++i)
 		vm_vcpu_add(vm, i);
@@ -69,7 +69,7 @@ static struct kvm_vm *aux_vm_create(bool with_vcpus)
 	struct kvm_vm *vm;
 	int i;
 
-	vm = vm_create(VM_MODE_DEFAULT, 0, O_RDWR);
+	vm = vm_create(VM_MODE_DEFAULT, 0);
 	if (!with_vcpus)
 		return vm;
 
@@ -174,9 +174,9 @@ static void test_sev_migrate_parameters(void)
 
 	sev_vm = sev_vm_create(/* es= */ false);
 	sev_es_vm = sev_vm_create(/* es= */ true);
-	vm_no_vcpu = vm_create(VM_MODE_DEFAULT, 0, O_RDWR);
+	vm_no_vcpu = vm_create(VM_MODE_DEFAULT, 0);
 	vm_no_sev = aux_vm_create(true);
-	sev_es_vm_no_vmsa = vm_create(VM_MODE_DEFAULT, 0, O_RDWR);
+	sev_es_vm_no_vmsa = vm_create(VM_MODE_DEFAULT, 0);
 	sev_ioctl(sev_es_vm_no_vmsa->fd, KVM_SEV_ES_INIT, NULL);
 	vm_vcpu_add(sev_es_vm_no_vmsa, 1);
 
diff --git a/tools/testing/selftests/kvm/x86_64/smm_test.c b/tools/testing/selftests/kvm/x86_64/smm_test.c
index a626d40fdb48..9757c45575ff 100644
--- a/tools/testing/selftests/kvm/x86_64/smm_test.c
+++ b/tools/testing/selftests/kvm/x86_64/smm_test.c
@@ -206,7 +206,7 @@ int main(int argc, char *argv[])
 
 		state = vcpu_save_state(vm, VCPU_ID);
 		kvm_vm_release(vm);
-		kvm_vm_restart(vm, O_RDWR);
+		kvm_vm_restart(vm);
 		vm_vcpu_add(vm, VCPU_ID);
 		vcpu_set_cpuid(vm, VCPU_ID, kvm_get_supported_cpuid());
 		vcpu_load_state(vm, VCPU_ID, state);
diff --git a/tools/testing/selftests/kvm/x86_64/state_test.c b/tools/testing/selftests/kvm/x86_64/state_test.c
index 2e0a92da8ff5..41f7faaef2ac 100644
--- a/tools/testing/selftests/kvm/x86_64/state_test.c
+++ b/tools/testing/selftests/kvm/x86_64/state_test.c
@@ -213,7 +213,7 @@ int main(int argc, char *argv[])
 		kvm_vm_release(vm);
 
 		/* Restore state in a new VM.  */
-		kvm_vm_restart(vm, O_RDWR);
+		kvm_vm_restart(vm);
 		vm_vcpu_add(vm, VCPU_ID);
 		vcpu_set_cpuid(vm, VCPU_ID, kvm_get_supported_cpuid());
 		vcpu_load_state(vm, VCPU_ID, state);
diff --git a/tools/testing/selftests/kvm/x86_64/vmx_preemption_timer_test.c b/tools/testing/selftests/kvm/x86_64/vmx_preemption_timer_test.c
index ff92e25b6f1e..f5b4ae914131 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_preemption_timer_test.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_preemption_timer_test.c
@@ -239,7 +239,7 @@ int main(int argc, char *argv[])
 		kvm_vm_release(vm);
 
 		/* Restore state in a new VM.  */
-		kvm_vm_restart(vm, O_RDWR);
+		kvm_vm_restart(vm);
 		vm_vcpu_add(vm, VCPU_ID);
 		vcpu_set_cpuid(vm, VCPU_ID, kvm_get_supported_cpuid());
 		vcpu_load_state(vm, VCPU_ID, state);
-- 
2.35.1.723.g4982287a31-goog


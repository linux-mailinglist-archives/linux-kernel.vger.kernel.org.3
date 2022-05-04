Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6090F51B31B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 01:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383910AbiEDXHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 19:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379246AbiEDXAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 19:00:14 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F0E580C9
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 15:53:29 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id d64-20020a17090a6f4600b001da3937032fso3566898pjk.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 15:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=7QC4KbqQ9vxH/kW0U2ZTgMUJb8ldU1+MU4dSvQ/BQb8=;
        b=eFK4c0QDRzOnXRasA/G81rvd9UmRyBFTZP+HM4HUmOCC1erbg/T7R2Ze7WyPQ0PEhT
         W21a6PwVc0xMtbxpABqQegEmNbaPLRXCxQHAAWBG7x6JnlGNFJNSi8/pdJ0wGx8hKMl+
         F3tvJ7kNCz+bOFQo/lIFd23sEC3L+za8CV/OwI2BHoJHI56STs5Mho20ue5n11motCj3
         JAhUJUF2berfimxSFZf/WiyYhN0fzpDKeERz2K7jt6S+nGT/5mqa4Exqx0NsjCfOV8wn
         gsRvzY3SvAu696eYP/ssPYG412/ts6r30TiPNCROffsub8PjwU2YLYGxW18sQlae010f
         QZlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=7QC4KbqQ9vxH/kW0U2ZTgMUJb8ldU1+MU4dSvQ/BQb8=;
        b=Jsa/wt4apBgVFtb15albAkXwpuU0NMz8VihdgORvE/dtaXJGBnsH/dNuv2s8zGQ8Gy
         j0nK+gQwT2vqTewuTvnP4tcTUJYIXiNK1w+CCnBc8+Ahnhowf+lfVJ1Q1UEbzgjL2xsf
         CU+oWZVzsB76N1oo1kf9BxxC/srgMTdWf2rDGmf+t4+Ql6K93lHyteP6mo0puJWSUJSm
         sLoaXd+G9f/FVo0AQbXLqyLnhZ/H1fHK8yVQLCEom2uzfJqe1q5HHx40EuI10xTjzrcc
         jxRKUK5TQdJM7yEGlZP+LUOj0jgeFyOjrLIWBlMQag6HoD6ReRnZ3uVsclwq860+eO+y
         YZRA==
X-Gm-Message-State: AOAM530iKv/uEA53qen6oOquFL/Oz/ZbX9A305ZPlJ1znn2Ueu9SQVWT
        YBVReqfr8/Igfl/FP52PIh1X//R/5u0=
X-Google-Smtp-Source: ABdhPJwYlHudDs2RKFt0FHr6gGZCrsD2tuH6yaKJAPmAg1Zqngqe+WjSV7fz1w9se9vtuRkmDsfYix9b9GU=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:903:20f:b0:158:d86a:f473 with SMTP id
 r15-20020a170903020f00b00158d86af473mr24141253plh.92.1651704778061; Wed, 04
 May 2022 15:52:58 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  4 May 2022 22:49:06 +0000
In-Reply-To: <20220504224914.1654036-1-seanjc@google.com>
Message-Id: <20220504224914.1654036-121-seanjc@google.com>
Mime-Version: 1.0
References: <20220504224914.1654036-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH 120/128] KVM: selftests: Purge vm+vcpu_id == vcpu silliness
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

Take a vCPU directly instead of a VM+vcpu pair in all vCPU-scoped helpers
and ioctls.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/aarch64/arch_timer.c        |  10 +-
 .../selftests/kvm/aarch64/debug-exceptions.c  |   8 +-
 .../selftests/kvm/aarch64/get-reg-list.c      |  14 +-
 .../selftests/kvm/aarch64/psci_cpu_on_test.c  |  12 +-
 .../selftests/kvm/aarch64/vcpu_width_config.c |   8 +-
 .../testing/selftests/kvm/aarch64/vgic_init.c |   2 +-
 .../testing/selftests/kvm/aarch64/vgic_irq.c  |   8 +-
 .../selftests/kvm/access_tracking_perf_test.c |   4 +-
 .../selftests/kvm/demand_paging_test.c        |   5 +-
 .../selftests/kvm/dirty_log_perf_test.c       |   7 +-
 tools/testing/selftests/kvm/dirty_log_test.c  |  10 +-
 .../selftests/kvm/hardware_disable_test.c     |   2 +-
 .../selftests/kvm/include/aarch64/processor.h |  14 +-
 .../selftests/kvm/include/kvm_util_base.h     | 192 +++++++++---------
 .../selftests/kvm/include/riscv/processor.h   |   8 +-
 .../selftests/kvm/include/ucall_common.h      |   2 +-
 .../selftests/kvm/include/x86_64/evmcs.h      |   2 +-
 .../selftests/kvm/include/x86_64/processor.h  |  39 ++--
 .../selftests/kvm/kvm_binary_stats_test.c     |   2 +-
 .../selftests/kvm/kvm_page_table_test.c       |   7 +-
 .../selftests/kvm/lib/aarch64/processor.c     |  45 ++--
 .../testing/selftests/kvm/lib/aarch64/ucall.c |   8 +-
 tools/testing/selftests/kvm/lib/kvm_util.c    | 162 ++++-----------
 .../selftests/kvm/lib/perf_test_util.c        |   2 +-
 .../selftests/kvm/lib/riscv/processor.c       |  94 +++++----
 tools/testing/selftests/kvm/lib/riscv/ucall.c |   8 +-
 .../kvm/lib/s390x/diag318_test_handler.c      |   2 +-
 .../selftests/kvm/lib/s390x/processor.c       |  22 +-
 tools/testing/selftests/kvm/lib/s390x/ucall.c |   8 +-
 .../selftests/kvm/lib/x86_64/processor.c      | 102 ++++------
 .../testing/selftests/kvm/lib/x86_64/ucall.c  |  10 +-
 tools/testing/selftests/kvm/lib/x86_64/vmx.c  |   4 +-
 .../selftests/kvm/max_guest_memory_test.c     |  20 +-
 .../kvm/memslot_modification_stress_test.c    |   5 +-
 .../testing/selftests/kvm/memslot_perf_test.c |   4 +-
 tools/testing/selftests/kvm/rseq_test.c       |   4 +-
 tools/testing/selftests/kvm/s390x/memop.c     |   8 +-
 tools/testing/selftests/kvm/s390x/resets.c    |  28 +--
 .../selftests/kvm/s390x/sync_regs_test.c      |  22 +-
 tools/testing/selftests/kvm/s390x/tprot.c     |   4 +-
 .../selftests/kvm/set_memory_region_test.c    |   8 +-
 tools/testing/selftests/kvm/steal_time.c      |  20 +-
 .../kvm/system_counter_offset_test.c          |  13 +-
 tools/testing/selftests/kvm/x86_64/amx_test.c |  22 +-
 .../testing/selftests/kvm/x86_64/cpuid_test.c |  14 +-
 .../kvm/x86_64/cr4_cpuid_sync_test.c          |   8 +-
 .../testing/selftests/kvm/x86_64/debug_regs.c |  30 +--
 .../kvm/x86_64/emulator_error_test.c          |  20 +-
 .../testing/selftests/kvm/x86_64/evmcs_test.c |  28 +--
 .../selftests/kvm/x86_64/fix_hypercall_test.c |   6 +-
 .../selftests/kvm/x86_64/hyperv_clock.c       |  14 +-
 .../selftests/kvm/x86_64/hyperv_cpuid.c       |   8 +-
 .../selftests/kvm/x86_64/hyperv_features.c    |  28 +--
 .../selftests/kvm/x86_64/hyperv_svm_test.c    |   8 +-
 .../selftests/kvm/x86_64/kvm_clock_test.c     |   6 +-
 .../selftests/kvm/x86_64/kvm_pv_test.c        |  10 +-
 .../selftests/kvm/x86_64/mmu_role_test.c      |  10 +-
 .../selftests/kvm/x86_64/platform_info_test.c |  14 +-
 .../kvm/x86_64/pmu_event_filter_test.c        |   8 +-
 .../selftests/kvm/x86_64/set_boot_cpu_id.c    |   4 +-
 .../selftests/kvm/x86_64/set_sregs_test.c     |  16 +-
 tools/testing/selftests/kvm/x86_64/smm_test.c |  18 +-
 .../testing/selftests/kvm/x86_64/state_test.c |  18 +-
 .../selftests/kvm/x86_64/svm_int_ctl_test.c   |   8 +-
 .../selftests/kvm/x86_64/svm_vmcall_test.c    |   6 +-
 .../selftests/kvm/x86_64/sync_regs_test.c     |  36 ++--
 .../selftests/kvm/x86_64/tsc_msrs_test.c      |  14 +-
 .../selftests/kvm/x86_64/tsc_scaling_sync.c   |   6 +-
 .../selftests/kvm/x86_64/userspace_io_test.c  |   8 +-
 .../kvm/x86_64/userspace_msr_exit_test.c      |  22 +-
 .../kvm/x86_64/vmx_apic_access_test.c         |   6 +-
 .../kvm/x86_64/vmx_close_while_nested_test.c  |   6 +-
 .../selftests/kvm/x86_64/vmx_dirty_log_test.c |   6 +-
 .../vmx_exception_with_invalid_guest_state.c  |  10 +-
 .../x86_64/vmx_invalid_nested_guest_state.c   |  12 +-
 .../kvm/x86_64/vmx_nested_tsc_scaling_test.c  |  11 +-
 .../selftests/kvm/x86_64/vmx_pmu_msrs_test.c  |  20 +-
 .../kvm/x86_64/vmx_preemption_timer_test.c    |  18 +-
 .../kvm/x86_64/vmx_set_nested_state_test.c    |  12 +-
 .../kvm/x86_64/vmx_tsc_adjust_test.c          |   6 +-
 .../selftests/kvm/x86_64/xapic_ipi_test.c     |  10 +-
 .../selftests/kvm/x86_64/xapic_state_test.c   |  42 ++--
 .../selftests/kvm/x86_64/xen_shinfo_test.c    |  38 ++--
 .../selftests/kvm/x86_64/xen_vmcall_test.c    |   6 +-
 .../selftests/kvm/x86_64/xss_msr_test.c       |   6 +-
 85 files changed, 722 insertions(+), 836 deletions(-)

diff --git a/tools/testing/selftests/kvm/aarch64/arch_timer.c b/tools/testing/selftests/kvm/aarch64/arch_timer.c
index a873d9adc558..ca4c08b4e353 100644
--- a/tools/testing/selftests/kvm/aarch64/arch_timer.c
+++ b/tools/testing/selftests/kvm/aarch64/arch_timer.c
@@ -218,14 +218,14 @@ static void *test_vcpu_run(void *arg)
 	struct kvm_vm *vm = vcpu->vm;
 	struct test_vcpu_shared_data *shared_data = &vcpu_shared_data[vcpu_idx];
 
-	vcpu_run(vm, vcpu->id);
+	vcpu_run(vcpu);
 
 	/* Currently, any exit from guest is an indication of completion */
 	pthread_mutex_lock(&vcpu_done_map_lock);
 	set_bit(vcpu_idx, vcpu_done_map);
 	pthread_mutex_unlock(&vcpu_done_map_lock);
 
-	switch (get_ucall(vm, vcpu->id, &uc)) {
+	switch (get_ucall(vcpu, &uc)) {
 	case UCALL_SYNC:
 	case UCALL_DONE:
 		break;
@@ -345,9 +345,9 @@ static void test_run(struct kvm_vm *vm)
 static void test_init_timer_irq(struct kvm_vm *vm)
 {
 	/* Timer initid should be same for all the vCPUs, so query only vCPU-0 */
-	vcpu_device_attr_get(vm, vcpus[0]->id, KVM_ARM_VCPU_TIMER_CTRL,
+	vcpu_device_attr_get(vcpus[0], KVM_ARM_VCPU_TIMER_CTRL,
 			     KVM_ARM_VCPU_TIMER_IRQ_PTIMER, &ptimer_irq);
-	vcpu_device_attr_get(vm, vcpus[0]->id, KVM_ARM_VCPU_TIMER_CTRL,
+	vcpu_device_attr_get(vcpus[0], KVM_ARM_VCPU_TIMER_CTRL,
 			     KVM_ARM_VCPU_TIMER_IRQ_VTIMER, &vtimer_irq);
 
 	sync_global_to_guest(vm, ptimer_irq);
@@ -370,7 +370,7 @@ static struct kvm_vm *test_vm_create(void)
 	vm_install_exception_handler(vm, VECTOR_IRQ_CURRENT, guest_irq_handler);
 
 	for (i = 0; i < nr_vcpus; i++)
-		vcpu_init_descriptor_tables(vm, vcpus[i]->id);
+		vcpu_init_descriptor_tables(vcpus[i]);
 
 	ucall_init(vm, NULL);
 	test_init_timer_irq(vm);
diff --git a/tools/testing/selftests/kvm/aarch64/debug-exceptions.c b/tools/testing/selftests/kvm/aarch64/debug-exceptions.c
index b69db0942169..98ca49ecbf06 100644
--- a/tools/testing/selftests/kvm/aarch64/debug-exceptions.c
+++ b/tools/testing/selftests/kvm/aarch64/debug-exceptions.c
@@ -242,7 +242,7 @@ static int debug_version(struct kvm_vcpu *vcpu)
 {
 	uint64_t id_aa64dfr0;
 
-	get_reg(vcpu->vm, vcpu->id, KVM_ARM64_SYS_REG(SYS_ID_AA64DFR0_EL1), &id_aa64dfr0);
+	get_reg(vcpu, KVM_ARM64_SYS_REG(SYS_ID_AA64DFR0_EL1), &id_aa64dfr0);
 	return id_aa64dfr0 & 0xf;
 }
 
@@ -257,7 +257,7 @@ int main(int argc, char *argv[])
 	ucall_init(vm, NULL);
 
 	vm_init_descriptor_tables(vm);
-	vcpu_init_descriptor_tables(vm, vcpu->id);
+	vcpu_init_descriptor_tables(vcpu);
 
 	if (debug_version(vcpu) < 6) {
 		print_skip("Armv8 debug architecture not supported.");
@@ -277,9 +277,9 @@ int main(int argc, char *argv[])
 				ESR_EC_SVC64, guest_svc_handler);
 
 	for (stage = 0; stage < 11; stage++) {
-		vcpu_run(vm, vcpu->id);
+		vcpu_run(vcpu);
 
-		switch (get_ucall(vm, vcpu->id, &uc)) {
+		switch (get_ucall(vcpu, &uc)) {
 		case UCALL_SYNC:
 			TEST_ASSERT(uc.args[1] == stage,
 				"Stage %d: Unexpected sync ucall, got %lx",
diff --git a/tools/testing/selftests/kvm/aarch64/get-reg-list.c b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
index dae6d5704519..63591486677b 100644
--- a/tools/testing/selftests/kvm/aarch64/get-reg-list.c
+++ b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
@@ -372,7 +372,7 @@ static void prepare_vcpu_init(struct vcpu_config *c, struct kvm_vcpu_init *init)
 			init->features[s->feature / 32] |= 1 << (s->feature % 32);
 }
 
-static void finalize_vcpu(struct kvm_vm *vm, uint32_t vcpuid, struct vcpu_config *c)
+static void finalize_vcpu(struct kvm_vcpu *vcpu, struct vcpu_config *c)
 {
 	struct reg_sublist *s;
 	int feature;
@@ -380,7 +380,7 @@ static void finalize_vcpu(struct kvm_vm *vm, uint32_t vcpuid, struct vcpu_config
 	for_each_sublist(c, s) {
 		if (s->finalize) {
 			feature = s->feature;
-			vcpu_ioctl(vm, vcpuid, KVM_ARM_VCPU_FINALIZE, &feature);
+			vcpu_ioctl(vcpu, KVM_ARM_VCPU_FINALIZE, &feature);
 		}
 	}
 }
@@ -415,9 +415,9 @@ static void run_test(struct vcpu_config *c)
 	vm = vm_create_barebones();
 	prepare_vcpu_init(c, &init);
 	vcpu = aarch64_vcpu_add(vm, 0, &init, NULL);
-	finalize_vcpu(vm, vcpu->id, c);
+	finalize_vcpu(vcpu, c);
 
-	reg_list = vcpu_get_reg_list(vm, vcpu->id);
+	reg_list = vcpu_get_reg_list(vcpu);
 
 	if (fixup_core_regs)
 		core_reg_fixup();
@@ -453,7 +453,7 @@ static void run_test(struct vcpu_config *c)
 		bool reject_reg = false;
 		int ret;
 
-		ret = __vcpu_ioctl(vm, vcpu->id, KVM_GET_ONE_REG, &reg);
+		ret = __vcpu_ioctl(vcpu, KVM_GET_ONE_REG, &reg);
 		if (ret) {
 			printf("%s: Failed to get ", config_name(c));
 			print_reg(c, reg.id);
@@ -465,7 +465,7 @@ static void run_test(struct vcpu_config *c)
 		for_each_sublist(c, s) {
 			if (s->rejects_set && find_reg(s->rejects_set, s->rejects_set_n, reg.id)) {
 				reject_reg = true;
-				ret = __vcpu_ioctl(vm, vcpu->id, KVM_SET_ONE_REG, &reg);
+				ret = __vcpu_ioctl(vcpu, KVM_SET_ONE_REG, &reg);
 				if (ret != -1 || errno != EPERM) {
 					printf("%s: Failed to reject (ret=%d, errno=%d) ", config_name(c), ret, errno);
 					print_reg(c, reg.id);
@@ -477,7 +477,7 @@ static void run_test(struct vcpu_config *c)
 		}
 
 		if (!reject_reg) {
-			ret = __vcpu_ioctl(vm, vcpu->id, KVM_SET_ONE_REG, &reg);
+			ret = __vcpu_ioctl(vcpu, KVM_SET_ONE_REG, &reg);
 			if (ret) {
 				printf("%s: Failed to set ", config_name(c));
 				print_reg(c, reg.id);
diff --git a/tools/testing/selftests/kvm/aarch64/psci_cpu_on_test.c b/tools/testing/selftests/kvm/aarch64/psci_cpu_on_test.c
index 142c3fa2f5f7..3ed8dcbd4227 100644
--- a/tools/testing/selftests/kvm/aarch64/psci_cpu_on_test.c
+++ b/tools/testing/selftests/kvm/aarch64/psci_cpu_on_test.c
@@ -88,11 +88,11 @@ int main(void)
 	init.features[0] |= (1 << KVM_ARM_VCPU_POWER_OFF);
 	vcpu1 = aarch64_vcpu_add(vm, 1, &init, guest_main);
 
-	get_reg(vm, vcpu1->id, KVM_ARM64_SYS_REG(SYS_MPIDR_EL1), &target_mpidr);
-	vcpu_args_set(vm, vcpu0->id, 1, target_mpidr & MPIDR_HWID_BITMASK);
-	vcpu_run(vm, vcpu0->id);
+	get_reg(vcpu1, KVM_ARM64_SYS_REG(SYS_MPIDR_EL1), &target_mpidr);
+	vcpu_args_set(vcpu0, 1, target_mpidr & MPIDR_HWID_BITMASK);
+	vcpu_run(vcpu0);
 
-	switch (get_ucall(vm, vcpu0->id, &uc)) {
+	switch (get_ucall(vcpu0, &uc)) {
 	case UCALL_DONE:
 		break;
 	case UCALL_ABORT:
@@ -103,8 +103,8 @@ int main(void)
 		TEST_FAIL("Unhandled ucall: %lu", uc.cmd);
 	}
 
-	get_reg(vm, vcpu1->id, ARM64_CORE_REG(regs.pc), &obs_pc);
-	get_reg(vm, vcpu1->id, ARM64_CORE_REG(regs.regs[0]), &obs_x0);
+	get_reg(vcpu1, ARM64_CORE_REG(regs.pc), &obs_pc);
+	get_reg(vcpu1, ARM64_CORE_REG(regs.regs[0]), &obs_x0);
 
 	TEST_ASSERT(obs_pc == CPU_ON_ENTRY_ADDR,
 		    "unexpected target cpu pc: %lx (expected: %lx)",
diff --git a/tools/testing/selftests/kvm/aarch64/vcpu_width_config.c b/tools/testing/selftests/kvm/aarch64/vcpu_width_config.c
index e4e66632f05c..dd5a1c4b49e0 100644
--- a/tools/testing/selftests/kvm/aarch64/vcpu_width_config.c
+++ b/tools/testing/selftests/kvm/aarch64/vcpu_width_config.c
@@ -28,12 +28,12 @@ static int add_init_2vcpus(struct kvm_vcpu_init *init0,
 	vm = vm_create_barebones();
 
 	vcpu0 = __vm_vcpu_add(vm, 0);
-	ret = __vcpu_ioctl(vm, vcpu0->id, KVM_ARM_VCPU_INIT, init0);
+	ret = __vcpu_ioctl(vcpu0, KVM_ARM_VCPU_INIT, init0);
 	if (ret)
 		goto free_exit;
 
 	vcpu1 = __vm_vcpu_add(vm, 1);
-	ret = __vcpu_ioctl(vm, vcpu1->id, KVM_ARM_VCPU_INIT, init1);
+	ret = __vcpu_ioctl(vcpu1, KVM_ARM_VCPU_INIT, init1);
 
 free_exit:
 	kvm_vm_free(vm);
@@ -56,11 +56,11 @@ static int add_2vcpus_init_2vcpus(struct kvm_vcpu_init *init0,
 	vcpu0 = __vm_vcpu_add(vm, 0);
 	vcpu1 = __vm_vcpu_add(vm, 1);
 
-	ret = __vcpu_ioctl(vm, vcpu0->id, KVM_ARM_VCPU_INIT, init0);
+	ret = __vcpu_ioctl(vcpu0, KVM_ARM_VCPU_INIT, init0);
 	if (ret)
 		goto free_exit;
 
-	ret = __vcpu_ioctl(vm, vcpu1->id, KVM_ARM_VCPU_INIT, init1);
+	ret = __vcpu_ioctl(vcpu1, KVM_ARM_VCPU_INIT, init1);
 
 free_exit:
 	kvm_vm_free(vm);
diff --git a/tools/testing/selftests/kvm/aarch64/vgic_init.c b/tools/testing/selftests/kvm/aarch64/vgic_init.c
index f93e9fa6ecd4..7ee10f02d4bf 100644
--- a/tools/testing/selftests/kvm/aarch64/vgic_init.c
+++ b/tools/testing/selftests/kvm/aarch64/vgic_init.c
@@ -53,7 +53,7 @@ static int run_vcpu(struct kvm_vcpu *vcpu)
 {
 	ucall_init(vcpu->vm, NULL);
 
-	return __vcpu_run(vcpu->vm, vcpu->id) ? -errno : 0;
+	return __vcpu_run(vcpu) ? -errno : 0;
 }
 
 static struct vm_gic vm_gic_create_with_vcpus(uint32_t gic_dev_type,
diff --git a/tools/testing/selftests/kvm/aarch64/vgic_irq.c b/tools/testing/selftests/kvm/aarch64/vgic_irq.c
index 111170201e9b..90dbba61d72a 100644
--- a/tools/testing/selftests/kvm/aarch64/vgic_irq.c
+++ b/tools/testing/selftests/kvm/aarch64/vgic_irq.c
@@ -759,12 +759,12 @@ static void test_vgic(uint32_t nr_irqs, bool level_sensitive, bool eoi_split)
 	ucall_init(vm, NULL);
 
 	vm_init_descriptor_tables(vm);
-	vcpu_init_descriptor_tables(vm, vcpu->id);
+	vcpu_init_descriptor_tables(vcpu);
 
 	/* Setup the guest args page (so it gets the args). */
 	args_gva = vm_vaddr_alloc_page(vm);
 	memcpy(addr_gva2hva(vm, args_gva), &args, sizeof(args));
-	vcpu_args_set(vm, vcpu->id, 1, args_gva);
+	vcpu_args_set(vcpu, 1, args_gva);
 
 	gic_fd = vgic_v3_setup(vm, 1, nr_irqs,
 			GICD_BASE_GPA, GICR_BASE_GPA);
@@ -777,9 +777,9 @@ static void test_vgic(uint32_t nr_irqs, bool level_sensitive, bool eoi_split)
 		guest_irq_handlers[args.eoi_split][args.level_sensitive]);
 
 	while (1) {
-		vcpu_run(vm, vcpu->id);
+		vcpu_run(vcpu);
 
-		switch (get_ucall(vm, vcpu->id, &uc)) {
+		switch (get_ucall(vcpu, &uc)) {
 		case UCALL_SYNC:
 			kvm_inject_get_call(vm, &uc, &inject_args);
 			run_guest_cmd(vcpu, gic_fd, &inject_args, &args);
diff --git a/tools/testing/selftests/kvm/access_tracking_perf_test.c b/tools/testing/selftests/kvm/access_tracking_perf_test.c
index 86a90222f913..1c771378f7f4 100644
--- a/tools/testing/selftests/kvm/access_tracking_perf_test.c
+++ b/tools/testing/selftests/kvm/access_tracking_perf_test.c
@@ -194,7 +194,7 @@ static void mark_vcpu_memory_idle(struct kvm_vm *vm,
 static void assert_ucall(struct kvm_vcpu *vcpu, uint64_t expected_ucall)
 {
 	struct ucall uc;
-	uint64_t actual_ucall = get_ucall(vcpu->vm, vcpu->id, &uc);
+	uint64_t actual_ucall = get_ucall(vcpu, &uc);
 
 	TEST_ASSERT(expected_ucall == actual_ucall,
 		    "Guest exited unexpectedly (expected ucall %" PRIu64
@@ -226,7 +226,7 @@ static void vcpu_thread_main(struct perf_test_vcpu_args *vcpu_args)
 	while (spin_wait_for_next_iteration(&current_iteration)) {
 		switch (READ_ONCE(iteration_work)) {
 		case ITERATION_ACCESS_MEMORY:
-			vcpu_run(vm, vcpu->id);
+			vcpu_run(vcpu);
 			assert_ucall(vcpu, UCALL_SYNC);
 			break;
 		case ITERATION_MARK_IDLE:
diff --git a/tools/testing/selftests/kvm/demand_paging_test.c b/tools/testing/selftests/kvm/demand_paging_test.c
index c46110721088..779ae54f89c4 100644
--- a/tools/testing/selftests/kvm/demand_paging_test.c
+++ b/tools/testing/selftests/kvm/demand_paging_test.c
@@ -45,7 +45,6 @@ static char *guest_data_prototype;
 static void vcpu_worker(struct perf_test_vcpu_args *vcpu_args)
 {
 	struct kvm_vcpu *vcpu = vcpu_args->vcpu;
-	struct kvm_vm *vm = perf_test_args.vm;
 	int vcpu_idx = vcpu_args->vcpu_idx;
 	struct kvm_run *run = vcpu->run;
 	struct timespec start;
@@ -55,9 +54,9 @@ static void vcpu_worker(struct perf_test_vcpu_args *vcpu_args)
 	clock_gettime(CLOCK_MONOTONIC, &start);
 
 	/* Let the guest access its memory */
-	ret = _vcpu_run(vm, vcpu->id);
+	ret = _vcpu_run(vcpu);
 	TEST_ASSERT(ret == 0, "vcpu_run failed: %d\n", ret);
-	if (get_ucall(vm, vcpu->id, NULL) != UCALL_SYNC) {
+	if (get_ucall(vcpu, NULL) != UCALL_SYNC) {
 		TEST_ASSERT(false,
 			    "Invalid guest sync status: exit_reason=%s\n",
 			    exit_reason_str(run->exit_reason));
diff --git a/tools/testing/selftests/kvm/dirty_log_perf_test.c b/tools/testing/selftests/kvm/dirty_log_perf_test.c
index e0b3639c47b9..b048f4f65f15 100644
--- a/tools/testing/selftests/kvm/dirty_log_perf_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_perf_test.c
@@ -69,7 +69,6 @@ static int vcpu_last_completed_iteration[KVM_MAX_VCPUS];
 static void vcpu_worker(struct perf_test_vcpu_args *vcpu_args)
 {
 	struct kvm_vcpu *vcpu = vcpu_args->vcpu;
-	struct kvm_vm *vm = perf_test_args.vm;
 	int vcpu_idx = vcpu_args->vcpu_idx;
 	uint64_t pages_count = 0;
 	struct kvm_run *run;
@@ -85,18 +84,18 @@ static void vcpu_worker(struct perf_test_vcpu_args *vcpu_args)
 		int current_iteration = READ_ONCE(iteration);
 
 		clock_gettime(CLOCK_MONOTONIC, &start);
-		ret = _vcpu_run(vm, vcpu->id);
+		ret = _vcpu_run(vcpu);
 		ts_diff = timespec_elapsed(start);
 
 		TEST_ASSERT(ret == 0, "vcpu_run failed: %d\n", ret);
-		TEST_ASSERT(get_ucall(vm, vcpu->id, NULL) == UCALL_SYNC,
+		TEST_ASSERT(get_ucall(vcpu, NULL) == UCALL_SYNC,
 			    "Invalid guest sync status: exit_reason=%s\n",
 			    exit_reason_str(run->exit_reason));
 
 		pr_debug("Got sync event from vCPU %d\n", vcpu_idx);
 		vcpu_last_completed_iteration[vcpu_idx] = current_iteration;
 		pr_debug("vCPU %d updated last completed iteration to %d\n",
-			 vcpu->id, vcpu_last_completed_iteration[vcpu_idx]);
+			 vcpu_idx, vcpu_last_completed_iteration[vcpu_idx]);
 
 		if (current_iteration) {
 			pages_count += vcpu_args->pages;
diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index 73c6fd9c850c..378efd08f7b8 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -258,7 +258,7 @@ static void default_after_vcpu_run(struct kvm_vcpu *vcpu, int ret, int err)
 	TEST_ASSERT(ret == 0 || (ret == -1 && err == EINTR),
 		    "vcpu run failed: errno=%d", err);
 
-	TEST_ASSERT(get_ucall(vcpu->vm, vcpu->id, NULL) == UCALL_SYNC,
+	TEST_ASSERT(get_ucall(vcpu, NULL) == UCALL_SYNC,
 		    "Invalid guest sync status: exit_reason=%s\n",
 		    exit_reason_str(run->exit_reason));
 
@@ -349,7 +349,7 @@ static void dirty_ring_collect_dirty_pages(struct kvm_vcpu *vcpu, int slot,
 	}
 
 	/* Only have one vcpu */
-	count = dirty_ring_collect_one(vcpu_map_dirty_ring(vcpu->vm, vcpu->id),
+	count = dirty_ring_collect_one(vcpu_map_dirty_ring(vcpu),
 				       slot, bitmap, num_pages, &fetch_index);
 
 	cleared = kvm_vm_reset_dirty_ring(vcpu->vm);
@@ -372,7 +372,7 @@ static void dirty_ring_after_vcpu_run(struct kvm_vcpu *vcpu, int ret, int err)
 	struct kvm_run *run = vcpu->run;
 
 	/* A ucall-sync or ring-full event is allowed */
-	if (get_ucall(vcpu->vm, vcpu->id, NULL) == UCALL_SYNC) {
+	if (get_ucall(vcpu, NULL) == UCALL_SYNC) {
 		/* We should allow this to continue */
 		;
 	} else if (run->exit_reason == KVM_EXIT_DIRTY_RING_FULL ||
@@ -524,7 +524,7 @@ static void *vcpu_worker(void *data)
 	sigmask->len = 8;
 	pthread_sigmask(0, NULL, sigset);
 	sigdelset(sigset, SIG_IPI);
-	vcpu_ioctl(vm, vcpu->id, KVM_SET_SIGNAL_MASK, sigmask);
+	vcpu_ioctl(vcpu, KVM_SET_SIGNAL_MASK, sigmask);
 
 	sigemptyset(sigset);
 	sigaddset(sigset, SIG_IPI);
@@ -536,7 +536,7 @@ static void *vcpu_worker(void *data)
 		generate_random_array(guest_array, TEST_PAGES_PER_LOOP);
 		pages_count += TEST_PAGES_PER_LOOP;
 		/* Let the guest dirty the random pages */
-		ret = __vcpu_run(vm, vcpu->id);
+		ret = __vcpu_run(vcpu);
 		if (ret == -1 && errno == EINTR) {
 			int sig = -1;
 			sigwait(sigset, &sig);
diff --git a/tools/testing/selftests/kvm/hardware_disable_test.c b/tools/testing/selftests/kvm/hardware_disable_test.c
index b522610f0ba4..f5eecd51fe70 100644
--- a/tools/testing/selftests/kvm/hardware_disable_test.c
+++ b/tools/testing/selftests/kvm/hardware_disable_test.c
@@ -39,7 +39,7 @@ static void *run_vcpu(void *arg)
 	struct kvm_vcpu *vcpu = arg;
 	struct kvm_run *run = vcpu->run;
 
-	vcpu_run(vcpu->vm, vcpu->id);
+	vcpu_run(vcpu);
 
 	TEST_ASSERT(false, "%s: exited with reason %d: %s\n",
 		    __func__, run->exit_reason,
diff --git a/tools/testing/selftests/kvm/include/aarch64/processor.h b/tools/testing/selftests/kvm/include/aarch64/processor.h
index f64607c136df..db01666e7e13 100644
--- a/tools/testing/selftests/kvm/include/aarch64/processor.h
+++ b/tools/testing/selftests/kvm/include/aarch64/processor.h
@@ -47,23 +47,25 @@
 
 #define MPIDR_HWID_BITMASK (0xff00fffffful)
 
-static inline void get_reg(struct kvm_vm *vm, uint32_t vcpuid, uint64_t id, uint64_t *addr)
+static inline void get_reg(struct kvm_vcpu *vcpu, uint64_t id, uint64_t *addr)
 {
 	struct kvm_one_reg reg;
+
 	reg.id = id;
 	reg.addr = (uint64_t)addr;
-	vcpu_ioctl(vm, vcpuid, KVM_GET_ONE_REG, &reg);
+	vcpu_ioctl(vcpu, KVM_GET_ONE_REG, &reg);
 }
 
-static inline void set_reg(struct kvm_vm *vm, uint32_t vcpuid, uint64_t id, uint64_t val)
+static inline void set_reg(struct kvm_vcpu *vcpu, uint64_t id, uint64_t val)
 {
 	struct kvm_one_reg reg;
+
 	reg.id = id;
 	reg.addr = (uint64_t)&val;
-	vcpu_ioctl(vm, vcpuid, KVM_SET_ONE_REG, &reg);
+	vcpu_ioctl(vcpu, KVM_SET_ONE_REG, &reg);
 }
 
-void aarch64_vcpu_setup(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_vcpu_init *init);
+void aarch64_vcpu_setup(struct kvm_vcpu *vcpu, struct kvm_vcpu_init *init);
 struct kvm_vcpu *aarch64_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id,
 				  struct kvm_vcpu_init *init, void *guest_code);
 
@@ -117,7 +119,7 @@ void aarch64_get_supported_page_sizes(uint32_t ipa,
 				      bool *ps4k, bool *ps16k, bool *ps64k);
 
 void vm_init_descriptor_tables(struct kvm_vm *vm);
-void vcpu_init_descriptor_tables(struct kvm_vm *vm, uint32_t vcpuid);
+void vcpu_init_descriptor_tables(struct kvm_vcpu *vcpu);
 
 typedef void(*handler_fn)(struct ex_regs *);
 void vm_install_exception_handler(struct kvm_vm *vm,
diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index 6eeaef797ea1..c0533f2ab418 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -93,7 +93,7 @@ struct kvm_vm {
 			continue;			\
 		else
 
-struct kvm_vcpu *vcpu_get(struct kvm_vm *vm, uint32_t vcpuid);
+struct kvm_vcpu *vcpu_get(struct kvm_vm *vm, uint32_t vcpu_id);
 
 struct userspace_mem_region *
 memslot2region(struct kvm_vm *vm, uint32_t memslot);
@@ -196,12 +196,12 @@ int __vm_ioctl(struct kvm_vm *vm, unsigned long cmd, void *arg);
 void _vm_ioctl(struct kvm_vm *vm, unsigned long cmd, const char *name, void *arg);
 #define vm_ioctl(vm, cmd, arg) _vm_ioctl(vm, cmd, #cmd, arg)
 
-int __vcpu_ioctl(struct kvm_vm *vm, uint32_t vcpuid, unsigned long cmd,
+int __vcpu_ioctl(struct kvm_vcpu *vcpu, unsigned long cmd,
 		 void *arg);
-void _vcpu_ioctl(struct kvm_vm *vm, uint32_t vcpuid, unsigned long cmd,
+void _vcpu_ioctl(struct kvm_vcpu *vcpu, unsigned long cmd,
 		 const char *name, void *arg);
-#define vcpu_ioctl(vm, vcpuid, cmd, arg) \
-	_vcpu_ioctl(vm, vcpuid, cmd, #cmd, arg)
+#define vcpu_ioctl(vcpu, cmd, arg) \
+	_vcpu_ioctl(vcpu, cmd, #cmd, arg)
 
 /*
  * Looks up and returns the value corresponding to the capability
@@ -280,7 +280,7 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
 void vm_mem_region_set_flags(struct kvm_vm *vm, uint32_t slot, uint32_t flags);
 void vm_mem_region_move(struct kvm_vm *vm, uint32_t slot, uint64_t new_gpa);
 void vm_mem_region_delete(struct kvm_vm *vm, uint32_t slot);
-struct kvm_vcpu *__vm_vcpu_add(struct kvm_vm *vm, uint32_t vcpuid);
+struct kvm_vcpu *__vm_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id);
 vm_vaddr_t vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min);
 vm_vaddr_t vm_vaddr_alloc_pages(struct kvm_vm *vm, int nr_pages);
 vm_vaddr_t vm_vaddr_alloc_page(struct kvm_vm *vm);
@@ -292,116 +292,107 @@ void *addr_gva2hva(struct kvm_vm *vm, vm_vaddr_t gva);
 vm_paddr_t addr_hva2gpa(struct kvm_vm *vm, void *hva);
 void *addr_gpa2alias(struct kvm_vm *vm, vm_paddr_t gpa);
 
-struct kvm_run *vcpu_state(struct kvm_vm *vm, uint32_t vcpuid);
-void vcpu_run(struct kvm_vm *vm, uint32_t vcpuid);
-int _vcpu_run(struct kvm_vm *vm, uint32_t vcpuid);
+struct kvm_run *vcpu_state(struct kvm_vcpu *vcpu);
+void vcpu_run(struct kvm_vcpu *vcpu);
+int _vcpu_run(struct kvm_vcpu *vcpu);
 
-static inline int __vcpu_run(struct kvm_vm *vm, uint32_t vcpuid)
+static inline int __vcpu_run(struct kvm_vcpu *vcpu)
 {
-	return __vcpu_ioctl(vm, vcpuid, KVM_RUN, NULL);
+	return __vcpu_ioctl(vcpu, KVM_RUN, NULL);
 }
 
-void vcpu_run_complete_io(struct kvm_vm *vm, uint32_t vcpuid);
-struct kvm_reg_list *vcpu_get_reg_list(struct kvm_vm *vm, uint32_t vcpuid);
+void vcpu_run_complete_io(struct kvm_vcpu *vcpu);
+struct kvm_reg_list *vcpu_get_reg_list(struct kvm_vcpu *vcpu);
 
-static inline void vcpu_enable_cap(struct kvm_vm *vm, uint32_t vcpu_id,
+static inline void vcpu_enable_cap(struct kvm_vcpu *vcpu,
 				   struct kvm_enable_cap *cap)
 {
-	vcpu_ioctl(vm, vcpu_id, KVM_ENABLE_CAP, cap);
+	vcpu_ioctl(vcpu, KVM_ENABLE_CAP, cap);
 }
 
-static inline void vcpu_set_guest_debug(struct kvm_vm *vm, uint32_t vcpuid,
+static inline void vcpu_set_guest_debug(struct kvm_vcpu *vcpu,
 					struct kvm_guest_debug *debug)
 {
-	vcpu_ioctl(vm, vcpuid, KVM_SET_GUEST_DEBUG, debug);
+	vcpu_ioctl(vcpu, KVM_SET_GUEST_DEBUG, debug);
 }
 
-static inline void vcpu_set_mp_state(struct kvm_vm *vm, uint32_t vcpuid,
+static inline void vcpu_set_mp_state(struct kvm_vcpu *vcpu,
 				     struct kvm_mp_state *mp_state)
 {
-	vcpu_ioctl(vm, vcpuid, KVM_SET_MP_STATE, mp_state);
+	vcpu_ioctl(vcpu, KVM_SET_MP_STATE, mp_state);
 }
 
-static inline void vcpu_regs_get(struct kvm_vm *vm, uint32_t vcpuid,
-				 struct kvm_regs *regs)
+static inline void vcpu_regs_get(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 {
-	vcpu_ioctl(vm, vcpuid, KVM_GET_REGS, regs);
+	vcpu_ioctl(vcpu, KVM_GET_REGS, regs);
 }
 
-static inline void vcpu_regs_set(struct kvm_vm *vm, uint32_t vcpuid,
-				 struct kvm_regs *regs)
+static inline void vcpu_regs_set(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 {
-	vcpu_ioctl(vm, vcpuid, KVM_SET_REGS, regs);
+	vcpu_ioctl(vcpu, KVM_SET_REGS, regs);
 }
-static inline void vcpu_sregs_get(struct kvm_vm *vm, uint32_t vcpuid,
-				  struct kvm_sregs *sregs)
+static inline void vcpu_sregs_get(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
 {
-	vcpu_ioctl(vm, vcpuid, KVM_GET_SREGS, sregs);
+	vcpu_ioctl(vcpu, KVM_GET_SREGS, sregs);
 
 }
-static inline void vcpu_sregs_set(struct kvm_vm *vm, uint32_t vcpuid,
-				  struct kvm_sregs *sregs)
+static inline void vcpu_sregs_set(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
 {
-	vcpu_ioctl(vm, vcpuid, KVM_SET_SREGS, sregs);
+	vcpu_ioctl(vcpu, KVM_SET_SREGS, sregs);
 }
-static inline int _vcpu_sregs_set(struct kvm_vm *vm, uint32_t vcpuid,
-				  struct kvm_sregs *sregs)
+static inline int _vcpu_sregs_set(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
 {
-	return __vcpu_ioctl(vm, vcpuid, KVM_SET_SREGS, sregs);
+	return __vcpu_ioctl(vcpu, KVM_SET_SREGS, sregs);
 }
-static inline void vcpu_fpu_get(struct kvm_vm *vm, uint32_t vcpuid,
-				struct kvm_fpu *fpu)
+static inline void vcpu_fpu_get(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
 {
-	vcpu_ioctl(vm, vcpuid, KVM_GET_FPU, fpu);
+	vcpu_ioctl(vcpu, KVM_GET_FPU, fpu);
 }
-static inline void vcpu_fpu_set(struct kvm_vm *vm, uint32_t vcpuid,
-				struct kvm_fpu *fpu)
+static inline void vcpu_fpu_set(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
 {
-	vcpu_ioctl(vm, vcpuid, KVM_SET_FPU, fpu);
+	vcpu_ioctl(vcpu, KVM_SET_FPU, fpu);
 }
-static inline void vcpu_get_reg(struct kvm_vm *vm, uint32_t vcpuid,
-				struct kvm_one_reg *reg)
+static inline void vcpu_get_reg(struct kvm_vcpu *vcpu, struct kvm_one_reg *reg)
 {
-	vcpu_ioctl(vm, vcpuid, KVM_GET_ONE_REG, reg);
+	vcpu_ioctl(vcpu, KVM_GET_ONE_REG, reg);
 }
-static inline void vcpu_set_reg(struct kvm_vm *vm, uint32_t vcpuid,
-				struct kvm_one_reg *reg)
+static inline void vcpu_set_reg(struct kvm_vcpu *vcpu, struct kvm_one_reg *reg)
 {
-	vcpu_ioctl(vm, vcpuid, KVM_SET_ONE_REG, reg);
+	vcpu_ioctl(vcpu, KVM_SET_ONE_REG, reg);
 }
 #ifdef __KVM_HAVE_VCPU_EVENTS
-static inline void vcpu_events_get(struct kvm_vm *vm, uint32_t vcpuid,
+static inline void vcpu_events_get(struct kvm_vcpu *vcpu,
 				   struct kvm_vcpu_events *events)
 {
-	vcpu_ioctl(vm, vcpuid, KVM_GET_VCPU_EVENTS, events);
+	vcpu_ioctl(vcpu, KVM_GET_VCPU_EVENTS, events);
 }
-static inline void vcpu_events_set(struct kvm_vm *vm, uint32_t vcpuid,
+static inline void vcpu_events_set(struct kvm_vcpu *vcpu,
 				   struct kvm_vcpu_events *events)
 {
-	vcpu_ioctl(vm, vcpuid, KVM_SET_VCPU_EVENTS, events);
+	vcpu_ioctl(vcpu, KVM_SET_VCPU_EVENTS, events);
 }
 #endif
 #ifdef __x86_64__
-static inline void vcpu_nested_state_get(struct kvm_vm *vm, uint32_t vcpuid,
+static inline void vcpu_nested_state_get(struct kvm_vcpu *vcpu,
 					 struct kvm_nested_state *state)
 {
-	vcpu_ioctl(vm, vcpuid, KVM_GET_NESTED_STATE, state);
+	vcpu_ioctl(vcpu, KVM_GET_NESTED_STATE, state);
 }
-static inline int __vcpu_nested_state_set(struct kvm_vm *vm, uint32_t vcpuid,
+static inline int __vcpu_nested_state_set(struct kvm_vcpu *vcpu,
 					  struct kvm_nested_state *state)
 {
-	return __vcpu_ioctl(vm, vcpuid, KVM_SET_NESTED_STATE, state);
+	return __vcpu_ioctl(vcpu, KVM_SET_NESTED_STATE, state);
 }
 
-static inline void vcpu_nested_state_set(struct kvm_vm *vm, uint32_t vcpuid,
+static inline void vcpu_nested_state_set(struct kvm_vcpu *vcpu,
 					 struct kvm_nested_state *state)
 {
-	vcpu_ioctl(vm, vcpuid, KVM_SET_NESTED_STATE, state);
+	vcpu_ioctl(vcpu, KVM_SET_NESTED_STATE, state);
 }
 #endif
-static inline int vcpu_get_stats_fd(struct kvm_vm *vm, uint32_t vcpuid)
+static inline int vcpu_get_stats_fd(struct kvm_vcpu *vcpu)
 {
-	int fd = __vcpu_ioctl(vm, vcpuid, KVM_GET_STATS_FD, NULL);
+	int fd = __vcpu_ioctl(vcpu, KVM_GET_STATS_FD, NULL);
 
 	TEST_ASSERT(fd >= 0, KVM_IOCTL_ERROR(KVM_GET_STATS_FD, fd));
 	return fd;
@@ -450,25 +441,42 @@ static inline void kvm_device_attr_set(int dev_fd, uint32_t group,
 	TEST_ASSERT(!ret, KVM_IOCTL_ERROR(KVM_SET_DEVICE_ATTR, ret));
 }
 
-int __vcpu_has_device_attr(struct kvm_vm *vm, uint32_t vcpuid, uint32_t group,
-			   uint64_t attr);
+static inline int __vcpu_has_device_attr(struct kvm_vcpu *vcpu, uint32_t group,
+					 uint64_t attr)
+{
+	return __kvm_has_device_attr(vcpu->fd, group, attr);
+}
 
-static inline void vcpu_has_device_attr(struct kvm_vm *vm, uint32_t vcpuid,
-					uint32_t group, uint64_t attr)
+static inline void vcpu_has_device_attr(struct kvm_vcpu *vcpu, uint32_t group,
+					uint64_t attr)
 {
-	int ret = __vcpu_has_device_attr(vm, vcpuid, group, attr);
+	kvm_has_device_attr(vcpu->fd, group, attr);
+}
 
-	TEST_ASSERT(!ret, KVM_IOCTL_ERROR(KVM_HAS_DEVICE_ATTR, ret));
+static inline int __vcpu_device_attr_get(struct kvm_vcpu *vcpu, uint32_t group,
+					 uint64_t attr, void *val)
+{
+	return __kvm_device_attr_get(vcpu->fd, group, attr, val);
+}
+
+static inline void vcpu_device_attr_get(struct kvm_vcpu *vcpu, uint32_t group,
+					uint64_t attr, void *val)
+{
+	kvm_device_attr_get(vcpu->fd, group, attr, val);
+}
+
+static inline int __vcpu_device_attr_set(struct kvm_vcpu *vcpu, uint32_t group,
+					 uint64_t attr, void *val)
+{
+	return __kvm_device_attr_set(vcpu->fd, group, attr, val);
+}
+
+static inline void vcpu_device_attr_set(struct kvm_vcpu *vcpu, uint32_t group,
+					uint64_t attr, void *val)
+{
+	kvm_device_attr_set(vcpu->fd, group, attr, val);
 }
 
-int __vcpu_device_attr_get(struct kvm_vm *vm, uint32_t vcpuid, uint32_t group,
-			   uint64_t attr, void *val);
-void vcpu_device_attr_get(struct kvm_vm *vm, uint32_t vcpuid, uint32_t group,
-			  uint64_t attr, void *val);
-int __vcpu_device_attr_set(struct kvm_vm *vm, uint32_t vcpuid, uint32_t group,
-			   uint64_t attr, void *val);
-void vcpu_device_attr_set(struct kvm_vm *vm, uint32_t vcpuid, uint32_t group,
-			  uint64_t attr, void *val);
 int __kvm_test_create_device(struct kvm_vm *vm, uint64_t type);
 int __kvm_create_device(struct kvm_vm *vm, uint64_t type);
 
@@ -480,14 +488,13 @@ static inline int kvm_create_device(struct kvm_vm *vm, uint64_t type)
 	return fd;
 }
 
-void *vcpu_map_dirty_ring(struct kvm_vm *vm, uint32_t vcpuid);
+void *vcpu_map_dirty_ring(struct kvm_vcpu *vcpu);
 
 /*
  * VM VCPU Args Set
  *
  * Input Args:
  *   vm - Virtual Machine
- *   vcpuid - VCPU ID
  *   num - number of arguments
  *   ... - arguments, each of type uint64_t
  *
@@ -495,12 +502,12 @@ void *vcpu_map_dirty_ring(struct kvm_vm *vm, uint32_t vcpuid);
  *
  * Return: None
  *
- * Sets the first @num function input registers of the VCPU with @vcpuid,
- * per the C calling convention of the architecture, to the values given
- * as variable args. Each of the variable args is expected to be of type
- * uint64_t. The maximum @num can be is specific to the architecture.
+ * Sets the first @num input parameters for the function at @vcpu's entry point,
+ * per the C calling convention of the architecture, to the values given as
+ * variable args. Each of the variable args is expected to be of type uint64_t.
+ * The maximum @num can be is specific to the architecture.
  */
-void vcpu_args_set(struct kvm_vm *vm, uint32_t vcpuid, unsigned int num, ...);
+void vcpu_args_set(struct kvm_vcpu *vcpu, unsigned int num, ...);
 
 void kvm_irq_line(struct kvm_vm *vm, uint32_t irq, int level);
 int _kvm_irq_line(struct kvm_vm *vm, uint32_t irq, int level);
@@ -605,32 +612,15 @@ kvm_userspace_memory_region_find(struct kvm_vm *vm, uint64_t start,
 	memcpy(&(g), _p, sizeof(g));				\
 })
 
-void assert_on_unhandled_exception(struct kvm_vm *vm, uint32_t vcpuid);
+void assert_on_unhandled_exception(struct kvm_vcpu *vcpu);
 
-/*
- * VM VCPU Dump
- *
- * Input Args:
- *   stream - Output FILE stream
- *   vm     - Virtual Machine
- *   vcpuid - VCPU ID
- *   indent - Left margin indent amount
- *
- * Output Args: None
- *
- * Return: None
- *
- * Dumps the current state of the VCPU specified by @vcpuid, within the VM
- * given by @vm, to the FILE stream given by @stream.
- */
-
-void vcpu_arch_dump(FILE *stream, struct kvm_vm *vm, uint32_t vcpuid,
+void vcpu_arch_dump(FILE *stream, struct kvm_vcpu *vcpu,
 		    uint8_t indent);
 
-static inline void vcpu_dump(FILE *stream, struct kvm_vm *vm, uint32_t vcpuid,
+static inline void vcpu_dump(FILE *stream, struct kvm_vcpu *vcpu,
 			     uint8_t indent)
 {
-	vcpu_arch_dump(stream, vm, vcpuid, indent);
+	vcpu_arch_dump(stream, vcpu, indent);
 }
 
 /*
@@ -638,7 +628,7 @@ static inline void vcpu_dump(FILE *stream, struct kvm_vm *vm, uint32_t vcpuid,
  *
  * Input Args:
  *   vm - Virtual Machine
- *   vcpuid - The id of the VCPU to add to the VM.
+ *   vcpu_id - The id of the VCPU to add to the VM.
  *   guest_code - The vCPU's entry point
  */
 struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id,
diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h b/tools/testing/selftests/kvm/include/riscv/processor.h
index eca5c622efd2..d6d93498ab0b 100644
--- a/tools/testing/selftests/kvm/include/riscv/processor.h
+++ b/tools/testing/selftests/kvm/include/riscv/processor.h
@@ -38,24 +38,24 @@ static inline uint64_t __kvm_reg_id(uint64_t type, uint64_t idx,
 					     KVM_REG_RISCV_TIMER_REG(name), \
 					     KVM_REG_SIZE_U64)
 
-static inline void get_reg(struct kvm_vm *vm, uint32_t vcpuid, uint64_t id,
+static inline void get_reg(struct kvm_vcpu *vcpu, uint64_t id,
 			   unsigned long *addr)
 {
 	struct kvm_one_reg reg;
 
 	reg.id = id;
 	reg.addr = (unsigned long)addr;
-	vcpu_get_reg(vm, vcpuid, &reg);
+	vcpu_get_reg(vcpu, &reg);
 }
 
-static inline void set_reg(struct kvm_vm *vm, uint32_t vcpuid, uint64_t id,
+static inline void set_reg(struct kvm_vcpu *vcpu, uint64_t id,
 			   unsigned long val)
 {
 	struct kvm_one_reg reg;
 
 	reg.id = id;
 	reg.addr = (unsigned long)&val;
-	vcpu_set_reg(vm, vcpuid, &reg);
+	vcpu_set_reg(vcpu, &reg);
 }
 
 /* L3 index Bit[47:39] */
diff --git a/tools/testing/selftests/kvm/include/ucall_common.h b/tools/testing/selftests/kvm/include/ucall_common.h
index 9eecc9d40b79..98562f685151 100644
--- a/tools/testing/selftests/kvm/include/ucall_common.h
+++ b/tools/testing/selftests/kvm/include/ucall_common.h
@@ -26,7 +26,7 @@ struct ucall {
 void ucall_init(struct kvm_vm *vm, void *arg);
 void ucall_uninit(struct kvm_vm *vm);
 void ucall(uint64_t cmd, int nargs, ...);
-uint64_t get_ucall(struct kvm_vm *vm, uint32_t vcpu_id, struct ucall *uc);
+uint64_t get_ucall(struct kvm_vcpu *vcpu, struct ucall *uc);
 
 #define GUEST_SYNC_ARGS(stage, arg1, arg2, arg3, arg4)	\
 				ucall(UCALL_SYNC, 6, "hello", stage, arg1, arg2, arg3, arg4)
diff --git a/tools/testing/selftests/kvm/include/x86_64/evmcs.h b/tools/testing/selftests/kvm/include/x86_64/evmcs.h
index cc5d14a45702..3c9260f8e116 100644
--- a/tools/testing/selftests/kvm/include/x86_64/evmcs.h
+++ b/tools/testing/selftests/kvm/include/x86_64/evmcs.h
@@ -241,7 +241,7 @@ struct hv_enlightened_vmcs {
 extern struct hv_enlightened_vmcs *current_evmcs;
 extern struct hv_vp_assist_page *current_vp_assist;
 
-int vcpu_enable_evmcs(struct kvm_vm *vm, int vcpu_id);
+int vcpu_enable_evmcs(struct kvm_vcpu *vcpu);
 
 static inline int enable_vp_assist(uint64_t vp_assist_pa, void *vp_assist)
 {
diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index 94888d3a13f5..5e7ebeff691f 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -405,26 +405,25 @@ static inline unsigned int x86_model(unsigned int eax)
 	return ((eax >> 12) & 0xf0) | ((eax >> 4) & 0x0f);
 }
 
-struct kvm_x86_state *vcpu_save_state(struct kvm_vm *vm, uint32_t vcpuid);
-void vcpu_load_state(struct kvm_vm *vm, uint32_t vcpuid,
-		     struct kvm_x86_state *state);
+struct kvm_x86_state *vcpu_save_state(struct kvm_vcpu *vcpu);
+void vcpu_load_state(struct kvm_vcpu *vcpu, struct kvm_x86_state *state);
 void kvm_x86_state_cleanup(struct kvm_x86_state *state);
 
 struct kvm_msr_list *kvm_get_msr_index_list(void);
 uint64_t kvm_get_feature_msr(uint64_t msr_index);
 struct kvm_cpuid2 *kvm_get_supported_cpuid(void);
-struct kvm_cpuid2 *vcpu_get_cpuid(struct kvm_vm *vm, uint32_t vcpuid);
+struct kvm_cpuid2 *vcpu_get_cpuid(struct kvm_vcpu *vcpu);
 
-static inline int __vcpu_set_cpuid(struct kvm_vm *vm, uint32_t vcpuid,
+static inline int __vcpu_set_cpuid(struct kvm_vcpu *vcpu,
 				   struct kvm_cpuid2 *cpuid)
 {
-	return __vcpu_ioctl(vm, vcpuid, KVM_SET_CPUID2, cpuid);
+	return __vcpu_ioctl(vcpu, KVM_SET_CPUID2, cpuid);
 }
 
-static inline void vcpu_set_cpuid(struct kvm_vm *vm, uint32_t vcpuid,
+static inline void vcpu_set_cpuid(struct kvm_vcpu *vcpu,
 				  struct kvm_cpuid2 *cpuid)
 {
-	vcpu_ioctl(vm, vcpuid, KVM_SET_CPUID2, cpuid);
+	vcpu_ioctl(vcpu, KVM_SET_CPUID2, cpuid);
 }
 
 struct kvm_cpuid_entry2 *
@@ -436,14 +435,13 @@ kvm_get_supported_cpuid_entry(uint32_t function)
 	return kvm_get_supported_cpuid_index(function, 0);
 }
 
-uint64_t vcpu_get_msr(struct kvm_vm *vm, uint32_t vcpuid, uint64_t msr_index);
-int _vcpu_set_msr(struct kvm_vm *vm, uint32_t vcpuid, uint64_t msr_index,
-		  uint64_t msr_value);
+uint64_t vcpu_get_msr(struct kvm_vcpu *vcpu, uint64_t msr_index);
+int _vcpu_set_msr(struct kvm_vcpu *vcpu, uint64_t msr_index, uint64_t msr_value);
 
-static inline void vcpu_set_msr(struct kvm_vm *vm, uint32_t vcpuid,
-				uint64_t msr_index, uint64_t msr_value)
+static inline void vcpu_set_msr(struct kvm_vcpu *vcpu, uint64_t msr_index,
+				uint64_t msr_value)
 {
-	int r = _vcpu_set_msr(vm, vcpuid, msr_index, msr_value);
+	int r = _vcpu_set_msr(vcpu, msr_index, msr_value);
 
 	TEST_ASSERT(r == 1, KVM_IOCTL_ERROR(KVM_SET_MSRS, r));
 }
@@ -467,13 +465,14 @@ struct ex_regs {
 };
 
 void vm_init_descriptor_tables(struct kvm_vm *vm);
-void vcpu_init_descriptor_tables(struct kvm_vm *vm, uint32_t vcpuid);
+void vcpu_init_descriptor_tables(struct kvm_vcpu *vcpu);
 void vm_install_exception_handler(struct kvm_vm *vm, int vector,
 			void (*handler)(struct ex_regs *));
 
-uint64_t vm_get_page_table_entry(struct kvm_vm *vm, int vcpuid, uint64_t vaddr);
-void vm_set_page_table_entry(struct kvm_vm *vm, int vcpuid, uint64_t vaddr,
-			     uint64_t pte);
+uint64_t vm_get_page_table_entry(struct kvm_vm *vm, struct kvm_vcpu *vcpu,
+				 uint64_t vaddr);
+void vm_set_page_table_entry(struct kvm_vm *vm, struct kvm_vcpu *vcpu,
+			     uint64_t vaddr, uint64_t pte);
 
 /*
  * get_cpuid() - find matching CPUID entry and return pointer to it.
@@ -493,8 +492,8 @@ uint64_t kvm_hypercall(uint64_t nr, uint64_t a0, uint64_t a1, uint64_t a2,
 		       uint64_t a3);
 
 struct kvm_cpuid2 *kvm_get_supported_hv_cpuid(void);
-void vcpu_set_hv_cpuid(struct kvm_vm *vm, uint32_t vcpuid);
-struct kvm_cpuid2 *vcpu_get_supported_hv_cpuid(struct kvm_vm *vm, uint32_t vcpuid);
+void vcpu_set_hv_cpuid(struct kvm_vcpu *vcpu);
+struct kvm_cpuid2 *vcpu_get_supported_hv_cpuid(struct kvm_vcpu *vcpu);
 void vm_xsave_req_perm(int bit);
 
 enum x86_page_size {
diff --git a/tools/testing/selftests/kvm/kvm_binary_stats_test.c b/tools/testing/selftests/kvm/kvm_binary_stats_test.c
index dfc3cf531ced..7f2ddc1535d7 100644
--- a/tools/testing/selftests/kvm/kvm_binary_stats_test.c
+++ b/tools/testing/selftests/kvm/kvm_binary_stats_test.c
@@ -174,7 +174,7 @@ static void vm_stats_test(struct kvm_vm *vm)
 
 static void vcpu_stats_test(struct kvm_vcpu *vcpu)
 {
-	int stats_fd = vcpu_get_stats_fd(vcpu->vm, vcpu->id);
+	int stats_fd = vcpu_get_stats_fd(vcpu);
 
 	stats_test(stats_fd);
 	close(stats_fd);
diff --git a/tools/testing/selftests/kvm/kvm_page_table_test.c b/tools/testing/selftests/kvm/kvm_page_table_test.c
index b577b5999c95..8706ae358444 100644
--- a/tools/testing/selftests/kvm/kvm_page_table_test.c
+++ b/tools/testing/selftests/kvm/kvm_page_table_test.c
@@ -184,7 +184,6 @@ static void guest_code(bool do_write)
 
 static void *vcpu_worker(void *data)
 {
-	struct kvm_vm *vm = test_args.vm;
 	struct kvm_vcpu *vcpu = data;
 	bool do_write = !(vcpu->id % 2);
 	struct timespec start;
@@ -192,7 +191,7 @@ static void *vcpu_worker(void *data)
 	enum test_stage stage;
 	int ret;
 
-	vcpu_args_set(vm, vcpu->id, 1, do_write);
+	vcpu_args_set(vcpu, 1, do_write);
 
 	while (!READ_ONCE(host_quit)) {
 		ret = sem_wait(&test_stage_updated);
@@ -202,11 +201,11 @@ static void *vcpu_worker(void *data)
 			return NULL;
 
 		clock_gettime(CLOCK_MONOTONIC_RAW, &start);
-		ret = _vcpu_run(vm, vcpu->id);
+		ret = _vcpu_run(vcpu);
 		ts_diff = timespec_elapsed(start);
 
 		TEST_ASSERT(ret == 0, "vcpu_run failed: %d\n", ret);
-		TEST_ASSERT(get_ucall(vm, vcpu->id, NULL) == UCALL_SYNC,
+		TEST_ASSERT(get_ucall(vcpu, NULL) == UCALL_SYNC,
 			    "Invalid guest sync status: exit_reason=%s\n",
 			    exit_reason_str(vcpu->run->exit_reason));
 
diff --git a/tools/testing/selftests/kvm/lib/aarch64/processor.c b/tools/testing/selftests/kvm/lib/aarch64/processor.c
index 35bec85f43b0..97b68fce763a 100644
--- a/tools/testing/selftests/kvm/lib/aarch64/processor.c
+++ b/tools/testing/selftests/kvm/lib/aarch64/processor.c
@@ -212,9 +212,10 @@ void virt_arch_dump(FILE *stream, struct kvm_vm *vm, uint8_t indent)
 	}
 }
 
-void aarch64_vcpu_setup(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_vcpu_init *init)
+void aarch64_vcpu_setup(struct kvm_vcpu *vcpu, struct kvm_vcpu_init *init)
 {
 	struct kvm_vcpu_init default_init = { .target = -1, };
+	struct kvm_vm *vm = vcpu->vm;
 	uint64_t sctlr_el1, tcr_el1;
 
 	if (!init)
@@ -226,16 +227,16 @@ void aarch64_vcpu_setup(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_vcpu_init
 		init->target = preferred.target;
 	}
 
-	vcpu_ioctl(vm, vcpuid, KVM_ARM_VCPU_INIT, init);
+	vcpu_ioctl(vcpu, KVM_ARM_VCPU_INIT, init);
 
 	/*
 	 * Enable FP/ASIMD to avoid trapping when accessing Q0-Q15
 	 * registers, which the variable argument list macros do.
 	 */
-	set_reg(vm, vcpuid, KVM_ARM64_SYS_REG(SYS_CPACR_EL1), 3 << 20);
+	set_reg(vcpu, KVM_ARM64_SYS_REG(SYS_CPACR_EL1), 3 << 20);
 
-	get_reg(vm, vcpuid, KVM_ARM64_SYS_REG(SYS_SCTLR_EL1), &sctlr_el1);
-	get_reg(vm, vcpuid, KVM_ARM64_SYS_REG(SYS_TCR_EL1), &tcr_el1);
+	get_reg(vcpu, KVM_ARM64_SYS_REG(SYS_SCTLR_EL1), &sctlr_el1);
+	get_reg(vcpu, KVM_ARM64_SYS_REG(SYS_TCR_EL1), &tcr_el1);
 
 	/* Configure base granule size */
 	switch (vm->mode) {
@@ -296,19 +297,19 @@ void aarch64_vcpu_setup(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_vcpu_init
 	tcr_el1 |= (1 << 8) | (1 << 10) | (3 << 12);
 	tcr_el1 |= (64 - vm->va_bits) /* T0SZ */;
 
-	set_reg(vm, vcpuid, KVM_ARM64_SYS_REG(SYS_SCTLR_EL1), sctlr_el1);
-	set_reg(vm, vcpuid, KVM_ARM64_SYS_REG(SYS_TCR_EL1), tcr_el1);
-	set_reg(vm, vcpuid, KVM_ARM64_SYS_REG(SYS_MAIR_EL1), DEFAULT_MAIR_EL1);
-	set_reg(vm, vcpuid, KVM_ARM64_SYS_REG(SYS_TTBR0_EL1), vm->pgd);
-	set_reg(vm, vcpuid, KVM_ARM64_SYS_REG(SYS_TPIDR_EL1), vcpuid);
+	set_reg(vcpu, KVM_ARM64_SYS_REG(SYS_SCTLR_EL1), sctlr_el1);
+	set_reg(vcpu, KVM_ARM64_SYS_REG(SYS_TCR_EL1), tcr_el1);
+	set_reg(vcpu, KVM_ARM64_SYS_REG(SYS_MAIR_EL1), DEFAULT_MAIR_EL1);
+	set_reg(vcpu, KVM_ARM64_SYS_REG(SYS_TTBR0_EL1), vm->pgd);
+	set_reg(vcpu, KVM_ARM64_SYS_REG(SYS_TPIDR_EL1), vcpu->id);
 }
 
-void vcpu_arch_dump(FILE *stream, struct kvm_vm *vm, uint32_t vcpuid, uint8_t indent)
+void vcpu_arch_dump(FILE *stream, struct kvm_vcpu *vcpu, uint8_t indent)
 {
 	uint64_t pstate, pc;
 
-	get_reg(vm, vcpuid, ARM64_CORE_REG(regs.pstate), &pstate);
-	get_reg(vm, vcpuid, ARM64_CORE_REG(regs.pc), &pc);
+	get_reg(vcpu, ARM64_CORE_REG(regs.pstate), &pstate);
+	get_reg(vcpu, ARM64_CORE_REG(regs.pc), &pc);
 
 	fprintf(stream, "%*spstate: 0x%.16lx pc: 0x%.16lx\n",
 		indent, "", pstate, pc);
@@ -324,10 +325,10 @@ struct kvm_vcpu *aarch64_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id,
 					      DEFAULT_ARM64_GUEST_STACK_VADDR_MIN);
 	struct kvm_vcpu *vcpu = __vm_vcpu_add(vm, vcpu_id);
 
-	aarch64_vcpu_setup(vm, vcpu_id, init);
+	aarch64_vcpu_setup(vcpu, init);
 
-	set_reg(vm, vcpu_id, ARM64_CORE_REG(sp_el1), stack_vaddr + stack_size);
-	set_reg(vm, vcpu_id, ARM64_CORE_REG(regs.pc), (uint64_t)guest_code);
+	set_reg(vcpu, ARM64_CORE_REG(sp_el1), stack_vaddr + stack_size);
+	set_reg(vcpu, ARM64_CORE_REG(regs.pc), (uint64_t)guest_code);
 
 	return vcpu;
 }
@@ -338,7 +339,7 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id,
 	return aarch64_vcpu_add(vm, vcpu_id, NULL, guest_code);
 }
 
-void vcpu_args_set(struct kvm_vm *vm, uint32_t vcpuid, unsigned int num, ...)
+void vcpu_args_set(struct kvm_vcpu *vcpu, unsigned int num, ...)
 {
 	va_list ap;
 	int i;
@@ -349,7 +350,7 @@ void vcpu_args_set(struct kvm_vm *vm, uint32_t vcpuid, unsigned int num, ...)
 	va_start(ap, num);
 
 	for (i = 0; i < num; i++) {
-		set_reg(vm, vcpuid, ARM64_CORE_REG(regs.regs[i]),
+		set_reg(vcpu, ARM64_CORE_REG(regs.regs[i]),
 			va_arg(ap, uint64_t));
 	}
 
@@ -363,11 +364,11 @@ void kvm_exit_unexpected_exception(int vector, uint64_t ec, bool valid_ec)
 		;
 }
 
-void assert_on_unhandled_exception(struct kvm_vm *vm, uint32_t vcpuid)
+void assert_on_unhandled_exception(struct kvm_vcpu *vcpu)
 {
 	struct ucall uc;
 
-	if (get_ucall(vm, vcpuid, &uc) != UCALL_UNHANDLED)
+	if (get_ucall(vcpu, &uc) != UCALL_UNHANDLED)
 		return;
 
 	if (uc.args[2]) /* valid_ec */ {
@@ -385,11 +386,11 @@ struct handlers {
 	handler_fn exception_handlers[VECTOR_NUM][ESR_EC_NUM];
 };
 
-void vcpu_init_descriptor_tables(struct kvm_vm *vm, uint32_t vcpuid)
+void vcpu_init_descriptor_tables(struct kvm_vcpu *vcpu)
 {
 	extern char vectors;
 
-	set_reg(vm, vcpuid, KVM_ARM64_SYS_REG(SYS_VBAR_EL1), (uint64_t)&vectors);
+	set_reg(vcpu, KVM_ARM64_SYS_REG(SYS_VBAR_EL1), (uint64_t)&vectors);
 }
 
 void route_exception(struct ex_regs *regs, int vector)
diff --git a/tools/testing/selftests/kvm/lib/aarch64/ucall.c b/tools/testing/selftests/kvm/lib/aarch64/ucall.c
index e14663ab2056..12a02e77271a 100644
--- a/tools/testing/selftests/kvm/lib/aarch64/ucall.c
+++ b/tools/testing/selftests/kvm/lib/aarch64/ucall.c
@@ -88,9 +88,9 @@ void ucall(uint64_t cmd, int nargs, ...)
 	*ucall_exit_mmio_addr = (vm_vaddr_t)&uc;
 }
 
-uint64_t get_ucall(struct kvm_vm *vm, uint32_t vcpu_id, struct ucall *uc)
+uint64_t get_ucall(struct kvm_vcpu *vcpu, struct ucall *uc)
 {
-	struct kvm_run *run = vcpu_state(vm, vcpu_id);
+	struct kvm_run *run = vcpu->run;
 	struct ucall ucall = {};
 
 	if (uc)
@@ -103,9 +103,9 @@ uint64_t get_ucall(struct kvm_vm *vm, uint32_t vcpu_id, struct ucall *uc)
 		TEST_ASSERT(run->mmio.is_write && run->mmio.len == 8,
 			    "Unexpected ucall exit mmio address access");
 		memcpy(&gva, run->mmio.data, sizeof(gva));
-		memcpy(&ucall, addr_gva2hva(vm, gva), sizeof(ucall));
+		memcpy(&ucall, addr_gva2hva(vcpu->vm, gva), sizeof(ucall));
 
-		vcpu_run_complete_io(vm, vcpu_id);
+		vcpu_run_complete_io(vcpu);
 		if (uc)
 			memcpy(uc, &ucall, sizeof(ucall));
 	}
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 9cc1eacacb4e..822bdcb5c38c 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1399,88 +1399,49 @@ void *addr_gpa2alias(struct kvm_vm *vm, vm_paddr_t gpa)
 	return (void *) ((uintptr_t) region->host_alias + offset);
 }
 
-/*
- * VM Create IRQ Chip
- *
- * Input Args:
- *   vm - Virtual Machine
- *
- * Output Args: None
- *
- * Return: None
- *
- * Creates an interrupt controller chip for the VM specified by vm.
- */
+/* Create an interrupt controller chip for the specified VM. */
 void vm_create_irqchip(struct kvm_vm *vm)
 {
 	vm_ioctl(vm, KVM_CREATE_IRQCHIP, NULL);
 
 	vm->has_irqchip = true;
 }
-
-/*
- * VM VCPU State
- *
- * Input Args:
- *   vm - Virtual Machine
- *   vcpuid - VCPU ID
- *
- * Output Args: None
- *
- * Return:
- *   Pointer to structure that describes the state of the VCPU.
- *
- * Locates and returns a pointer to a structure that describes the
- * state of the VCPU with the given vcpuid.
- */
-struct kvm_run *vcpu_state(struct kvm_vm *vm, uint32_t vcpuid)
+struct kvm_run *vcpu_state(struct kvm_vcpu *vcpu)
 {
-	struct kvm_vcpu *vcpu = vcpu_get(vm, vcpuid);
-
 	return vcpu->run;
 }
 
-/*
- * VM VCPU Run
- *
- * Input Args:
- *   vm - Virtual Machine
- *   vcpuid - VCPU ID
- *
- * Output Args: None
- *
- * Return: None
- *
- * Switch to executing the code for the VCPU given by vcpuid, within the VM
- * given by vm.
- */
-void vcpu_run(struct kvm_vm *vm, uint32_t vcpuid)
-{
-	int ret = _vcpu_run(vm, vcpuid);
 
-	TEST_ASSERT(!ret, KVM_IOCTL_ERROR(KVM_RUN, ret));
-}
-
-int _vcpu_run(struct kvm_vm *vm, uint32_t vcpuid)
+int _vcpu_run(struct kvm_vcpu *vcpu)
 {
 	int rc;
 
 	do {
-		rc = __vcpu_run(vm, vcpuid);
+		rc = __vcpu_run(vcpu);
 	} while (rc == -1 && errno == EINTR);
 
-	assert_on_unhandled_exception(vm, vcpuid);
+	assert_on_unhandled_exception(vcpu);
 
 	return rc;
 }
 
-void vcpu_run_complete_io(struct kvm_vm *vm, uint32_t vcpuid)
+/*
+ * Invoke KVM_RUN on a vCPU until KVM returns something other than -EINTR.
+ * Assert if the KVM returns an error (other than -EINTR).
+ */
+void vcpu_run(struct kvm_vcpu *vcpu)
+{
+	int ret = _vcpu_run(vcpu);
+
+	TEST_ASSERT(!ret, KVM_IOCTL_ERROR(KVM_RUN, ret));
+}
+
+void vcpu_run_complete_io(struct kvm_vcpu *vcpu)
 {
-	struct kvm_vcpu *vcpu = vcpu_get(vm, vcpuid);
 	int ret;
 
 	vcpu->run->immediate_exit = 1;
-	ret = __vcpu_run(vm, vcpuid);
+	ret = __vcpu_run(vcpu);
 	vcpu->run->immediate_exit = 0;
 
 	TEST_ASSERT(ret == -1 && errno == EINTR,
@@ -1489,73 +1450,57 @@ void vcpu_run_complete_io(struct kvm_vm *vm, uint32_t vcpuid)
 }
 
 /*
- * VM VCPU Get Reg List
- *
- * Input Args:
- *   vm - Virtual Machine
- *   vcpuid - VCPU ID
- *
- * Output Args:
- *   None
- *
- * Return:
- *   A pointer to an allocated struct kvm_reg_list
- *
  * Get the list of guest registers which are supported for
- * KVM_GET_ONE_REG/KVM_SET_ONE_REG calls
+ * KVM_GET_ONE_REG/KVM_SET_ONE_REG ioctls.  Returns a kvm_reg_list pointer,
+ * it is the callers responsibility to free the list.
  */
-struct kvm_reg_list *vcpu_get_reg_list(struct kvm_vm *vm, uint32_t vcpuid)
+struct kvm_reg_list *vcpu_get_reg_list(struct kvm_vcpu *vcpu)
 {
 	struct kvm_reg_list reg_list_n = { .n = 0 }, *reg_list;
 	int ret;
 
-	ret = __vcpu_ioctl(vm, vcpuid, KVM_GET_REG_LIST, &reg_list_n);
+	ret = __vcpu_ioctl(vcpu, KVM_GET_REG_LIST, &reg_list_n);
 	TEST_ASSERT(ret == -1 && errno == E2BIG, "KVM_GET_REG_LIST n=0");
+
 	reg_list = calloc(1, sizeof(*reg_list) + reg_list_n.n * sizeof(__u64));
 	reg_list->n = reg_list_n.n;
-	vcpu_ioctl(vm, vcpuid, KVM_GET_REG_LIST, reg_list);
+	vcpu_ioctl(vcpu, KVM_GET_REG_LIST, reg_list);
 	return reg_list;
 }
 
-int __vcpu_ioctl(struct kvm_vm *vm, uint32_t vcpuid,
-		 unsigned long cmd, void *arg)
+int __vcpu_ioctl(struct kvm_vcpu *vcpu, unsigned long cmd, void *arg)
 {
-	struct kvm_vcpu *vcpu = vcpu_get(vm, vcpuid);
-
 	return ioctl(vcpu->fd, cmd, arg);
 }
 
-void _vcpu_ioctl(struct kvm_vm *vm, uint32_t vcpuid, unsigned long cmd,
-		 const char *name, void *arg)
+void _vcpu_ioctl(struct kvm_vcpu *vcpu, unsigned long cmd, const char *name,
+		 void *arg)
 {
-	int ret = __vcpu_ioctl(vm, vcpuid, cmd, arg);
+	int ret = __vcpu_ioctl(vcpu, cmd, arg);
 
 	TEST_ASSERT(!ret, __KVM_IOCTL_ERROR(name, ret));
 }
 
-void *vcpu_map_dirty_ring(struct kvm_vm *vm, uint32_t vcpuid)
+void *vcpu_map_dirty_ring(struct kvm_vcpu *vcpu)
 {
-	struct kvm_vcpu *vcpu = vcpu_get(vm, vcpuid);
-	uint32_t size = vm->dirty_ring_size;
+	uint32_t page_size = vcpu->vm->page_size;
+	uint32_t size = vcpu->vm->dirty_ring_size;
 
 	TEST_ASSERT(size > 0, "Should enable dirty ring first");
 
 	if (!vcpu->dirty_gfns) {
 		void *addr;
 
-		addr = mmap(NULL, size, PROT_READ,
-			    MAP_PRIVATE, vcpu->fd,
-			    vm->page_size * KVM_DIRTY_LOG_PAGE_OFFSET);
+		addr = mmap(NULL, size, PROT_READ, MAP_PRIVATE, vcpu->fd,
+			    page_size * KVM_DIRTY_LOG_PAGE_OFFSET);
 		TEST_ASSERT(addr == MAP_FAILED, "Dirty ring mapped private");
 
-		addr = mmap(NULL, size, PROT_READ | PROT_EXEC,
-			    MAP_PRIVATE, vcpu->fd,
-			    vm->page_size * KVM_DIRTY_LOG_PAGE_OFFSET);
+		addr = mmap(NULL, size, PROT_READ | PROT_EXEC, MAP_PRIVATE, vcpu->fd,
+			    page_size * KVM_DIRTY_LOG_PAGE_OFFSET);
 		TEST_ASSERT(addr == MAP_FAILED, "Dirty ring mapped exec");
 
-		addr = mmap(NULL, size, PROT_READ | PROT_WRITE,
-			    MAP_SHARED, vcpu->fd,
-			    vm->page_size * KVM_DIRTY_LOG_PAGE_OFFSET);
+		addr = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED, vcpu->fd,
+			    page_size * KVM_DIRTY_LOG_PAGE_OFFSET);
 		TEST_ASSERT(addr != MAP_FAILED, "Dirty ring map failed");
 
 		vcpu->dirty_gfns = addr;
@@ -1629,36 +1574,6 @@ int __kvm_device_attr_access(int dev_fd, uint32_t group, uint64_t attr,
 	return __kvm_ioctl(dev_fd, cmd, &kvmattr);
 }
 
-int __vcpu_device_attr_get(struct kvm_vm *vm, uint32_t vcpuid, uint32_t group,
-			   uint64_t attr, void *val)
-{
-	return __kvm_device_attr_get(vcpu_get(vm, vcpuid)->fd, group, attr, val);
-}
-
-void vcpu_device_attr_get(struct kvm_vm *vm, uint32_t vcpuid, uint32_t group,
-			  uint64_t attr, void *val)
-{
-	kvm_device_attr_get(vcpu_get(vm, vcpuid)->fd, group, attr, val);
-}
-
-int __vcpu_device_attr_set(struct kvm_vm *vm, uint32_t vcpuid, uint32_t group,
-			   uint64_t attr, void *val)
-{
-	return __kvm_device_attr_set(vcpu_get(vm, vcpuid)->fd, group, attr, val);
-}
-
-void vcpu_device_attr_set(struct kvm_vm *vm, uint32_t vcpuid, uint32_t group,
-			  uint64_t attr, void *val)
-{
-	kvm_device_attr_set(vcpu_get(vm, vcpuid)->fd, group, attr, val);
-}
-
-int __vcpu_has_device_attr(struct kvm_vm *vm, uint32_t vcpuid, uint32_t group,
-			  uint64_t attr)
-{
-	return __kvm_has_device_attr(vcpu_get(vm, vcpuid)->fd, group, attr);
-}
-
 /*
  * IRQ related functions.
  */
@@ -1774,8 +1689,9 @@ void vm_dump(FILE *stream, struct kvm_vm *vm, uint8_t indent)
 		virt_dump(stream, vm, indent + 4);
 	}
 	fprintf(stream, "%*sVCPUs:\n", indent, "");
+
 	list_for_each_entry(vcpu, &vm->vcpus, list)
-		vcpu_dump(stream, vm, vcpu->id, indent + 2);
+		vcpu_dump(stream, vcpu, indent + 2);
 }
 
 /* Known KVM exit reasons */
diff --git a/tools/testing/selftests/kvm/lib/perf_test_util.c b/tools/testing/selftests/kvm/lib/perf_test_util.c
index 679f64527f1a..7faed18f7719 100644
--- a/tools/testing/selftests/kvm/lib/perf_test_util.c
+++ b/tools/testing/selftests/kvm/lib/perf_test_util.c
@@ -98,7 +98,7 @@ void perf_test_setup_vcpus(struct kvm_vm *vm, int nr_vcpus,
 			vcpu_args->gpa = pta->gpa;
 		}
 
-		vcpu_args_set(vm, vcpus[i]->id, 1, i);
+		vcpu_args_set(vcpus[i], 1, i);
 
 		pr_debug("Added VCPU %d with test mem gpa [%lx, %lx)\n",
 			 i, vcpu_args->gpa, vcpu_args->gpa +
diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tools/testing/selftests/kvm/lib/riscv/processor.c
index d0e52ec87169..5b7ea725af98 100644
--- a/tools/testing/selftests/kvm/lib/riscv/processor.c
+++ b/tools/testing/selftests/kvm/lib/riscv/processor.c
@@ -178,8 +178,9 @@ void virt_arch_dump(FILE *stream, struct kvm_vm *vm, uint8_t indent)
 	}
 }
 
-void riscv_vcpu_mmu_setup(struct kvm_vm *vm, int vcpuid)
+void riscv_vcpu_mmu_setup(struct kvm_vcpu *vcpu)
 {
+	struct kvm_vm *vm = vcpu->vm;
 	unsigned long satp;
 
 	/*
@@ -198,46 +199,46 @@ void riscv_vcpu_mmu_setup(struct kvm_vm *vm, int vcpuid)
 	satp = (vm->pgd >> PGTBL_PAGE_SIZE_SHIFT) & SATP_PPN;
 	satp |= SATP_MODE_48;
 
-	set_reg(vm, vcpuid, RISCV_CSR_REG(satp), satp);
+	set_reg(vcpu, RISCV_CSR_REG(satp), satp);
 }
 
-void vcpu_arch_dump(FILE *stream, struct kvm_vm *vm, uint32_t vcpuid, uint8_t indent)
+void vcpu_arch_dump(FILE *stream, struct kvm_vcpu *vcpu, uint8_t indent)
 {
 	struct kvm_riscv_core core;
 
-	get_reg(vm, vcpuid, RISCV_CORE_REG(mode), &core.mode);
-	get_reg(vm, vcpuid, RISCV_CORE_REG(regs.pc), &core.regs.pc);
-	get_reg(vm, vcpuid, RISCV_CORE_REG(regs.ra), &core.regs.ra);
-	get_reg(vm, vcpuid, RISCV_CORE_REG(regs.sp), &core.regs.sp);
-	get_reg(vm, vcpuid, RISCV_CORE_REG(regs.gp), &core.regs.gp);
-	get_reg(vm, vcpuid, RISCV_CORE_REG(regs.tp), &core.regs.tp);
-	get_reg(vm, vcpuid, RISCV_CORE_REG(regs.t0), &core.regs.t0);
-	get_reg(vm, vcpuid, RISCV_CORE_REG(regs.t1), &core.regs.t1);
-	get_reg(vm, vcpuid, RISCV_CORE_REG(regs.t2), &core.regs.t2);
-	get_reg(vm, vcpuid, RISCV_CORE_REG(regs.s0), &core.regs.s0);
-	get_reg(vm, vcpuid, RISCV_CORE_REG(regs.s1), &core.regs.s1);
-	get_reg(vm, vcpuid, RISCV_CORE_REG(regs.a0), &core.regs.a0);
-	get_reg(vm, vcpuid, RISCV_CORE_REG(regs.a1), &core.regs.a1);
-	get_reg(vm, vcpuid, RISCV_CORE_REG(regs.a2), &core.regs.a2);
-	get_reg(vm, vcpuid, RISCV_CORE_REG(regs.a3), &core.regs.a3);
-	get_reg(vm, vcpuid, RISCV_CORE_REG(regs.a4), &core.regs.a4);
-	get_reg(vm, vcpuid, RISCV_CORE_REG(regs.a5), &core.regs.a5);
-	get_reg(vm, vcpuid, RISCV_CORE_REG(regs.a6), &core.regs.a6);
-	get_reg(vm, vcpuid, RISCV_CORE_REG(regs.a7), &core.regs.a7);
-	get_reg(vm, vcpuid, RISCV_CORE_REG(regs.s2), &core.regs.s2);
-	get_reg(vm, vcpuid, RISCV_CORE_REG(regs.s3), &core.regs.s3);
-	get_reg(vm, vcpuid, RISCV_CORE_REG(regs.s4), &core.regs.s4);
-	get_reg(vm, vcpuid, RISCV_CORE_REG(regs.s5), &core.regs.s5);
-	get_reg(vm, vcpuid, RISCV_CORE_REG(regs.s6), &core.regs.s6);
-	get_reg(vm, vcpuid, RISCV_CORE_REG(regs.s7), &core.regs.s7);
-	get_reg(vm, vcpuid, RISCV_CORE_REG(regs.s8), &core.regs.s8);
-	get_reg(vm, vcpuid, RISCV_CORE_REG(regs.s9), &core.regs.s9);
-	get_reg(vm, vcpuid, RISCV_CORE_REG(regs.s10), &core.regs.s10);
-	get_reg(vm, vcpuid, RISCV_CORE_REG(regs.s11), &core.regs.s11);
-	get_reg(vm, vcpuid, RISCV_CORE_REG(regs.t3), &core.regs.t3);
-	get_reg(vm, vcpuid, RISCV_CORE_REG(regs.t4), &core.regs.t4);
-	get_reg(vm, vcpuid, RISCV_CORE_REG(regs.t5), &core.regs.t5);
-	get_reg(vm, vcpuid, RISCV_CORE_REG(regs.t6), &core.regs.t6);
+	get_reg(vcpu, RISCV_CORE_REG(mode), &core.mode);
+	get_reg(vcpu, RISCV_CORE_REG(regs.pc), &core.regs.pc);
+	get_reg(vcpu, RISCV_CORE_REG(regs.ra), &core.regs.ra);
+	get_reg(vcpu, RISCV_CORE_REG(regs.sp), &core.regs.sp);
+	get_reg(vcpu, RISCV_CORE_REG(regs.gp), &core.regs.gp);
+	get_reg(vcpu, RISCV_CORE_REG(regs.tp), &core.regs.tp);
+	get_reg(vcpu, RISCV_CORE_REG(regs.t0), &core.regs.t0);
+	get_reg(vcpu, RISCV_CORE_REG(regs.t1), &core.regs.t1);
+	get_reg(vcpu, RISCV_CORE_REG(regs.t2), &core.regs.t2);
+	get_reg(vcpu, RISCV_CORE_REG(regs.s0), &core.regs.s0);
+	get_reg(vcpu, RISCV_CORE_REG(regs.s1), &core.regs.s1);
+	get_reg(vcpu, RISCV_CORE_REG(regs.a0), &core.regs.a0);
+	get_reg(vcpu, RISCV_CORE_REG(regs.a1), &core.regs.a1);
+	get_reg(vcpu, RISCV_CORE_REG(regs.a2), &core.regs.a2);
+	get_reg(vcpu, RISCV_CORE_REG(regs.a3), &core.regs.a3);
+	get_reg(vcpu, RISCV_CORE_REG(regs.a4), &core.regs.a4);
+	get_reg(vcpu, RISCV_CORE_REG(regs.a5), &core.regs.a5);
+	get_reg(vcpu, RISCV_CORE_REG(regs.a6), &core.regs.a6);
+	get_reg(vcpu, RISCV_CORE_REG(regs.a7), &core.regs.a7);
+	get_reg(vcpu, RISCV_CORE_REG(regs.s2), &core.regs.s2);
+	get_reg(vcpu, RISCV_CORE_REG(regs.s3), &core.regs.s3);
+	get_reg(vcpu, RISCV_CORE_REG(regs.s4), &core.regs.s4);
+	get_reg(vcpu, RISCV_CORE_REG(regs.s5), &core.regs.s5);
+	get_reg(vcpu, RISCV_CORE_REG(regs.s6), &core.regs.s6);
+	get_reg(vcpu, RISCV_CORE_REG(regs.s7), &core.regs.s7);
+	get_reg(vcpu, RISCV_CORE_REG(regs.s8), &core.regs.s8);
+	get_reg(vcpu, RISCV_CORE_REG(regs.s9), &core.regs.s9);
+	get_reg(vcpu, RISCV_CORE_REG(regs.s10), &core.regs.s10);
+	get_reg(vcpu, RISCV_CORE_REG(regs.s11), &core.regs.s11);
+	get_reg(vcpu, RISCV_CORE_REG(regs.t3), &core.regs.t3);
+	get_reg(vcpu, RISCV_CORE_REG(regs.t4), &core.regs.t4);
+	get_reg(vcpu, RISCV_CORE_REG(regs.t5), &core.regs.t5);
+	get_reg(vcpu, RISCV_CORE_REG(regs.t6), &core.regs.t6);
 
 	fprintf(stream,
 		" MODE:  0x%lx\n", core.mode);
@@ -287,7 +288,7 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id,
 	struct kvm_vcpu *vcpu;
 
 	vcpu = __vm_vcpu_add(vm, vcpu_id);
-	riscv_vcpu_mmu_setup(vm, vcpu_id);
+	riscv_vcpu_mmu_setup(vcpu);
 
 	/*
 	 * With SBI HSM support in KVM RISC-V, all secondary VCPUs are
@@ -295,28 +296,25 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id,
 	 * are powered-on using KVM_SET_MP_STATE ioctl().
 	 */
 	mps.mp_state = KVM_MP_STATE_RUNNABLE;
-	r = __vcpu_ioctl(vm, vcpu_id, KVM_SET_MP_STATE, &mps);
+	r = __vcpu_ioctl(vcpu, KVM_SET_MP_STATE, &mps);
 	TEST_ASSERT(!r, "IOCTL KVM_SET_MP_STATE failed (error %d)", r);
 
 	/* Setup global pointer of guest to be same as the host */
 	asm volatile (
 		"add %0, gp, zero" : "=r" (current_gp) : : "memory");
-	set_reg(vm, vcpu_id, RISCV_CORE_REG(regs.gp), current_gp);
+	set_reg(vcpu, RISCV_CORE_REG(regs.gp), current_gp);
 
 	/* Setup stack pointer and program counter of guest */
-	set_reg(vm, vcpu_id, RISCV_CORE_REG(regs.sp),
-		stack_vaddr + stack_size);
-	set_reg(vm, vcpu_id, RISCV_CORE_REG(regs.pc),
-		(unsigned long)guest_code);
+	set_reg(vcpu, RISCV_CORE_REG(regs.sp), stack_vaddr + stack_size);
+	set_reg(vcpu, RISCV_CORE_REG(regs.pc), (unsigned long)guest_code);
 
 	/* Setup default exception vector of guest */
-	set_reg(vm, vcpu_id, RISCV_CSR_REG(stvec),
-		(unsigned long)guest_hang);
+	set_reg(vcpu, RISCV_CSR_REG(stvec), (unsigned long)guest_hang);
 
 	return vcpu;
 }
 
-void vcpu_args_set(struct kvm_vm *vm, uint32_t vcpuid, unsigned int num, ...)
+void vcpu_args_set(struct kvm_vcpu *vcpu, unsigned int num, ...)
 {
 	va_list ap;
 	uint64_t id = RISCV_CORE_REG(regs.a0);
@@ -354,12 +352,12 @@ void vcpu_args_set(struct kvm_vm *vm, uint32_t vcpuid, unsigned int num, ...)
 			id = RISCV_CORE_REG(regs.a7);
 			break;
 		};
-		set_reg(vm, vcpuid, id, va_arg(ap, uint64_t));
+		set_reg(vcpu, id, va_arg(ap, uint64_t));
 	}
 
 	va_end(ap);
 }
 
-void assert_on_unhandled_exception(struct kvm_vm *vm, uint32_t vcpuid)
+void assert_on_unhandled_exception(struct kvm_vcpu *vcpu)
 {
 }
diff --git a/tools/testing/selftests/kvm/lib/riscv/ucall.c b/tools/testing/selftests/kvm/lib/riscv/ucall.c
index c554ed173b38..4fc723e14797 100644
--- a/tools/testing/selftests/kvm/lib/riscv/ucall.c
+++ b/tools/testing/selftests/kvm/lib/riscv/ucall.c
@@ -63,9 +63,9 @@ void ucall(uint64_t cmd, int nargs, ...)
 		  0, 0, 0, 0, 0);
 }
 
-uint64_t get_ucall(struct kvm_vm *vm, uint32_t vcpu_id, struct ucall *uc)
+uint64_t get_ucall(struct kvm_vcpu *vcpu, struct ucall *uc)
 {
-	struct kvm_run *run = vcpu_state(vm, vcpu_id);
+	struct kvm_run *run = vcpu->run;
 	struct ucall ucall = {};
 
 	if (uc)
@@ -74,10 +74,10 @@ uint64_t get_ucall(struct kvm_vm *vm, uint32_t vcpu_id, struct ucall *uc)
 	if (run->exit_reason == KVM_EXIT_RISCV_SBI &&
 	    run->riscv_sbi.extension_id == KVM_RISCV_SELFTESTS_SBI_EXT &&
 	    run->riscv_sbi.function_id == 0) {
-		memcpy(&ucall, addr_gva2hva(vm, run->riscv_sbi.args[0]),
+		memcpy(&ucall, addr_gva2hva(vcpu->vm, run->riscv_sbi.args[0]),
 			sizeof(ucall));
 
-		vcpu_run_complete_io(vm, vcpu_id);
+		vcpu_run_complete_io(vcpu);
 		if (uc)
 			memcpy(uc, &ucall, sizeof(ucall));
 	}
diff --git a/tools/testing/selftests/kvm/lib/s390x/diag318_test_handler.c b/tools/testing/selftests/kvm/lib/s390x/diag318_test_handler.c
index 21c31fe10c1a..05283f8c9948 100644
--- a/tools/testing/selftests/kvm/lib/s390x/diag318_test_handler.c
+++ b/tools/testing/selftests/kvm/lib/s390x/diag318_test_handler.c
@@ -32,7 +32,7 @@ static uint64_t diag318_handler(void)
 	uint64_t diag318_info;
 
 	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
-	vcpu_run(vm, vcpu->id);
+	vcpu_run(vcpu);
 	run = vcpu->run;
 
 	TEST_ASSERT(run->exit_reason == KVM_EXIT_S390_SIEIC,
diff --git a/tools/testing/selftests/kvm/lib/s390x/processor.c b/tools/testing/selftests/kvm/lib/s390x/processor.c
index f8170e97eeb7..89d7340d9cbd 100644
--- a/tools/testing/selftests/kvm/lib/s390x/processor.c
+++ b/tools/testing/selftests/kvm/lib/s390x/processor.c
@@ -173,23 +173,23 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id,
 	vcpu = __vm_vcpu_add(vm, vcpu_id);
 
 	/* Setup guest registers */
-	vcpu_regs_get(vm, vcpu_id, &regs);
+	vcpu_regs_get(vcpu, &regs);
 	regs.gprs[15] = stack_vaddr + (DEFAULT_STACK_PGS * getpagesize()) - 160;
-	vcpu_regs_set(vm, vcpu_id, &regs);
+	vcpu_regs_set(vcpu, &regs);
 
-	vcpu_sregs_get(vm, vcpu_id, &sregs);
+	vcpu_sregs_get(vcpu, &sregs);
 	sregs.crs[0] |= 0x00040000;		/* Enable floating point regs */
 	sregs.crs[1] = vm->pgd | 0xf;		/* Primary region table */
-	vcpu_sregs_set(vm, vcpu_id, &sregs);
+	vcpu_sregs_set(vcpu, &sregs);
 
-	run = vcpu_state(vm, vcpu_id);
+	run = vcpu->run;
 	run->psw_mask = 0x0400000180000000ULL;  /* DAT enabled + 64 bit mode */
 	run->psw_addr = (uintptr_t)guest_code;
 
 	return vcpu;
 }
 
-void vcpu_args_set(struct kvm_vm *vm, uint32_t vcpuid, unsigned int num, ...)
+void vcpu_args_set(struct kvm_vcpu *vcpu, unsigned int num, ...)
 {
 	va_list ap;
 	struct kvm_regs regs;
@@ -200,23 +200,21 @@ void vcpu_args_set(struct kvm_vm *vm, uint32_t vcpuid, unsigned int num, ...)
 		    num);
 
 	va_start(ap, num);
-	vcpu_regs_get(vm, vcpuid, &regs);
+	vcpu_regs_get(vcpu, &regs);
 
 	for (i = 0; i < num; i++)
 		regs.gprs[i + 2] = va_arg(ap, uint64_t);
 
-	vcpu_regs_set(vm, vcpuid, &regs);
+	vcpu_regs_set(vcpu, &regs);
 	va_end(ap);
 }
 
-void vcpu_arch_dump(FILE *stream, struct kvm_vm *vm, uint32_t vcpuid, uint8_t indent)
+void vcpu_arch_dump(FILE *stream, struct kvm_vcpu *vcpu, uint8_t indent)
 {
-	struct kvm_vcpu *vcpu = vcpu_get(vm, vcpuid);
-
 	fprintf(stream, "%*spstate: psw: 0x%.16llx:0x%.16llx\n",
 		indent, "", vcpu->run->psw_mask, vcpu->run->psw_addr);
 }
 
-void assert_on_unhandled_exception(struct kvm_vm *vm, uint32_t vcpuid)
+void assert_on_unhandled_exception(struct kvm_vcpu *vcpu)
 {
 }
diff --git a/tools/testing/selftests/kvm/lib/s390x/ucall.c b/tools/testing/selftests/kvm/lib/s390x/ucall.c
index 9d3b0f15249a..78dfa2402b5e 100644
--- a/tools/testing/selftests/kvm/lib/s390x/ucall.c
+++ b/tools/testing/selftests/kvm/lib/s390x/ucall.c
@@ -33,9 +33,9 @@ void ucall(uint64_t cmd, int nargs, ...)
 	asm volatile ("diag 0,%0,0x501" : : "a"(&uc) : "memory");
 }
 
-uint64_t get_ucall(struct kvm_vm *vm, uint32_t vcpu_id, struct ucall *uc)
+uint64_t get_ucall(struct kvm_vcpu *vcpu, struct ucall *uc)
 {
-	struct kvm_run *run = vcpu_state(vm, vcpu_id);
+	struct kvm_run *run = vcpu->run;
 	struct ucall ucall = {};
 
 	if (uc)
@@ -47,10 +47,10 @@ uint64_t get_ucall(struct kvm_vm *vm, uint32_t vcpu_id, struct ucall *uc)
 	    (run->s390_sieic.ipb >> 16) == 0x501) {
 		int reg = run->s390_sieic.ipa & 0xf;
 
-		memcpy(&ucall, addr_gva2hva(vm, run->s.regs.gprs[reg]),
+		memcpy(&ucall, addr_gva2hva(vcpu->vm, run->s.regs.gprs[reg]),
 		       sizeof(ucall));
 
-		vcpu_run_complete_io(vm, vcpu_id);
+		vcpu_run_complete_io(vcpu);
 		if (uc)
 			memcpy(uc, &ucall, sizeof(ucall));
 	}
diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index 73738083456b..21c17168d416 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -213,8 +213,9 @@ void virt_arch_pg_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr)
 	__virt_pg_map(vm, vaddr, paddr, X86_PAGE_SIZE_4K);
 }
 
-static uint64_t *_vm_get_page_table_entry(struct kvm_vm *vm, int vcpuid,
-						       uint64_t vaddr)
+static uint64_t *_vm_get_page_table_entry(struct kvm_vm *vm,
+					  struct kvm_vcpu *vcpu,
+					  uint64_t vaddr)
 {
 	uint16_t index[4];
 	uint64_t *pml4e, *pdpe, *pde;
@@ -236,7 +237,7 @@ static uint64_t *_vm_get_page_table_entry(struct kvm_vm *vm, int vcpuid,
 	 * If IA32_EFER.NXE = 0 and the P flag of a paging-structure entry is 1,
 	 * the XD flag (bit 63) is reserved.
 	 */
-	vcpu_sregs_get(vm, vcpuid, &sregs);
+	vcpu_sregs_get(vcpu, &sregs);
 	if ((sregs.efer & EFER_NX) == 0) {
 		rsvd_mask |= PTE_NX_MASK;
 	}
@@ -288,17 +289,18 @@ static uint64_t *_vm_get_page_table_entry(struct kvm_vm *vm, int vcpuid,
 	return &pte[index[0]];
 }
 
-uint64_t vm_get_page_table_entry(struct kvm_vm *vm, int vcpuid, uint64_t vaddr)
+uint64_t vm_get_page_table_entry(struct kvm_vm *vm, struct kvm_vcpu *vcpu,
+				 uint64_t vaddr)
 {
-	uint64_t *pte = _vm_get_page_table_entry(vm, vcpuid, vaddr);
+	uint64_t *pte = _vm_get_page_table_entry(vm, vcpu, vaddr);
 
 	return *(uint64_t *)pte;
 }
 
-void vm_set_page_table_entry(struct kvm_vm *vm, int vcpuid, uint64_t vaddr,
-			     uint64_t pte)
+void vm_set_page_table_entry(struct kvm_vm *vm, struct kvm_vcpu *vcpu,
+			     uint64_t vaddr, uint64_t pte)
 {
-	uint64_t *new_pte = _vm_get_page_table_entry(vm, vcpuid, vaddr);
+	uint64_t *new_pte = _vm_get_page_table_entry(vm, vcpu, vaddr);
 
 	*(uint64_t *)new_pte = pte;
 }
@@ -547,12 +549,12 @@ static void kvm_setup_tss_64bit(struct kvm_vm *vm, struct kvm_segment *segp,
 	kvm_seg_fill_gdt_64bit(vm, segp);
 }
 
-static void vcpu_setup(struct kvm_vm *vm, int vcpuid)
+static void vcpu_setup(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
 {
 	struct kvm_sregs sregs;
 
 	/* Set mode specific system register values. */
-	vcpu_sregs_get(vm, vcpuid, &sregs);
+	vcpu_sregs_get(vcpu, &sregs);
 
 	sregs.idt.limit = 0;
 
@@ -576,7 +578,7 @@ static void vcpu_setup(struct kvm_vm *vm, int vcpuid)
 	}
 
 	sregs.cr3 = vm->pgd;
-	vcpu_sregs_set(vm, vcpuid, &sregs);
+	vcpu_sregs_set(vcpu, &sregs);
 }
 
 #define CPUID_XFD_BIT (1 << 4)
@@ -645,19 +647,19 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id,
 				     DEFAULT_GUEST_STACK_VADDR_MIN);
 
 	vcpu = __vm_vcpu_add(vm, vcpu_id);
-	vcpu_set_cpuid(vm, vcpu_id, kvm_get_supported_cpuid());
-	vcpu_setup(vm, vcpu_id);
+	vcpu_set_cpuid(vcpu, kvm_get_supported_cpuid());
+	vcpu_setup(vm, vcpu);
 
 	/* Setup guest general purpose registers */
-	vcpu_regs_get(vm, vcpu_id, &regs);
+	vcpu_regs_get(vcpu, &regs);
 	regs.rflags = regs.rflags | 0x2;
 	regs.rsp = stack_vaddr + (DEFAULT_STACK_PGS * getpagesize());
 	regs.rip = (unsigned long) guest_code;
-	vcpu_regs_set(vm, vcpu_id, &regs);
+	vcpu_regs_set(vcpu, &regs);
 
 	/* Setup the MP state */
 	mp_state.mp_state = 0;
-	vcpu_set_mp_state(vm, vcpu_id, &mp_state);
+	vcpu_set_mp_state(vcpu, &mp_state);
 
 	return vcpu;
 }
@@ -755,20 +757,7 @@ uint64_t kvm_get_feature_msr(uint64_t msr_index)
 	return buffer.entry.data;
 }
 
-/*
- * VM VCPU CPUID Set
- *
- * Input Args:
- *   vm - Virtual Machine
- *   vcpuid - VCPU id
- *
- * Output Args: None
- *
- * Return: KVM CPUID (KVM_GET_CPUID2)
- *
- * Set the VCPU's CPUID.
- */
-struct kvm_cpuid2 *vcpu_get_cpuid(struct kvm_vm *vm, uint32_t vcpuid)
+struct kvm_cpuid2 *vcpu_get_cpuid(struct kvm_vcpu *vcpu)
 {
 	struct kvm_cpuid2 *cpuid;
 	int max_ent;
@@ -778,7 +767,7 @@ struct kvm_cpuid2 *vcpu_get_cpuid(struct kvm_vm *vm, uint32_t vcpuid)
 	max_ent = cpuid->nent;
 
 	for (cpuid->nent = 1; cpuid->nent <= max_ent; cpuid->nent++) {
-		rc = __vcpu_ioctl(vm, vcpuid, KVM_GET_CPUID2, cpuid);
+		rc = __vcpu_ioctl(vcpu, KVM_GET_CPUID2, cpuid);
 		if (!rc)
 			break;
 
@@ -825,7 +814,7 @@ kvm_get_supported_cpuid_index(uint32_t function, uint32_t index)
 	return entry;
 }
 
-uint64_t vcpu_get_msr(struct kvm_vm *vm, uint32_t vcpuid, uint64_t msr_index)
+uint64_t vcpu_get_msr(struct kvm_vcpu *vcpu, uint64_t msr_index)
 {
 	struct {
 		struct kvm_msrs header;
@@ -836,14 +825,13 @@ uint64_t vcpu_get_msr(struct kvm_vm *vm, uint32_t vcpuid, uint64_t msr_index)
 	buffer.header.nmsrs = 1;
 	buffer.entry.index = msr_index;
 
-	r = __vcpu_ioctl(vm, vcpuid, KVM_GET_MSRS, &buffer.header);
+	r = __vcpu_ioctl(vcpu, KVM_GET_MSRS, &buffer.header);
 	TEST_ASSERT(r == 1, KVM_IOCTL_ERROR(KVM_GET_MSRS, r));
 
 	return buffer.entry.data;
 }
 
-int _vcpu_set_msr(struct kvm_vm *vm, uint32_t vcpuid, uint64_t msr_index,
-		  uint64_t msr_value)
+int _vcpu_set_msr(struct kvm_vcpu *vcpu, uint64_t msr_index, uint64_t msr_value)
 {
 	struct {
 		struct kvm_msrs header;
@@ -855,10 +843,10 @@ int _vcpu_set_msr(struct kvm_vm *vm, uint32_t vcpuid, uint64_t msr_index,
 	buffer.entry.index = msr_index;
 	buffer.entry.data = msr_value;
 
-	return __vcpu_ioctl(vm, vcpuid, KVM_SET_MSRS, &buffer.header);
+	return __vcpu_ioctl(vcpu, KVM_SET_MSRS, &buffer.header);
 }
 
-void vcpu_args_set(struct kvm_vm *vm, uint32_t vcpuid, unsigned int num, ...)
+void vcpu_args_set(struct kvm_vcpu *vcpu, unsigned int num, ...)
 {
 	va_list ap;
 	struct kvm_regs regs;
@@ -868,7 +856,7 @@ void vcpu_args_set(struct kvm_vm *vm, uint32_t vcpuid, unsigned int num, ...)
 		    num);
 
 	va_start(ap, num);
-	vcpu_regs_get(vm, vcpuid, &regs);
+	vcpu_regs_get(vcpu, &regs);
 
 	if (num >= 1)
 		regs.rdi = va_arg(ap, uint64_t);
@@ -888,23 +876,23 @@ void vcpu_args_set(struct kvm_vm *vm, uint32_t vcpuid, unsigned int num, ...)
 	if (num >= 6)
 		regs.r9 = va_arg(ap, uint64_t);
 
-	vcpu_regs_set(vm, vcpuid, &regs);
+	vcpu_regs_set(vcpu, &regs);
 	va_end(ap);
 }
 
-void vcpu_arch_dump(FILE *stream, struct kvm_vm *vm, uint32_t vcpuid, uint8_t indent)
+void vcpu_arch_dump(FILE *stream, struct kvm_vcpu *vcpu, uint8_t indent)
 {
 	struct kvm_regs regs;
 	struct kvm_sregs sregs;
 
-	fprintf(stream, "%*scpuid: %u\n", indent, "", vcpuid);
+	fprintf(stream, "%*svCPU ID: %u\n", indent, "", vcpu->id);
 
 	fprintf(stream, "%*sregs:\n", indent + 2, "");
-	vcpu_regs_get(vm, vcpuid, &regs);
+	vcpu_regs_get(vcpu, &regs);
 	regs_dump(stream, &regs, indent + 4);
 
 	fprintf(stream, "%*ssregs:\n", indent + 2, "");
-	vcpu_sregs_get(vm, vcpuid, &sregs);
+	vcpu_sregs_get(vcpu, &sregs);
 	sregs_dump(stream, &sregs, indent + 4);
 }
 
@@ -958,9 +946,9 @@ static int vcpu_save_xsave_state(struct kvm_vm *vm, struct kvm_vcpu *vcpu,
 		return ioctl(vcpu->fd, KVM_GET_XSAVE2, state->xsave);
 }
 
-struct kvm_x86_state *vcpu_save_state(struct kvm_vm *vm, uint32_t vcpuid)
+struct kvm_x86_state *vcpu_save_state(struct kvm_vcpu *vcpu)
 {
-	struct kvm_vcpu *vcpu = vcpu_get(vm, vcpuid);
+	struct kvm_vm *vm = vcpu->vm;
 	struct kvm_msr_list *list;
 	struct kvm_x86_state *state;
 	int nmsrs, r, i;
@@ -979,7 +967,7 @@ struct kvm_x86_state *vcpu_save_state(struct kvm_vm *vm, uint32_t vcpuid)
 	 * kernel with KVM_RUN.  Complete IO prior to migrating state
 	 * to a new VM.
 	 */
-	vcpu_run_complete_io(vm, vcpuid);
+	vcpu_run_complete_io(vcpu);
 
 	nmsrs = kvm_get_num_msrs(vm);
 	list = malloc(sizeof(*list) + nmsrs * sizeof(list->indices[0]));
@@ -1039,9 +1027,8 @@ struct kvm_x86_state *vcpu_save_state(struct kvm_vm *vm, uint32_t vcpuid)
 	return state;
 }
 
-void vcpu_load_state(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_x86_state *state)
+void vcpu_load_state(struct kvm_vcpu *vcpu, struct kvm_x86_state *state)
 {
-	struct kvm_vcpu *vcpu = vcpu_get(vm, vcpuid);
 	int r;
 
 	r = ioctl(vcpu->fd, KVM_SET_SREGS, &state->sregs);
@@ -1209,17 +1196,18 @@ void vm_init_descriptor_tables(struct kvm_vm *vm)
 			DEFAULT_CODE_SELECTOR);
 }
 
-void vcpu_init_descriptor_tables(struct kvm_vm *vm, uint32_t vcpuid)
+void vcpu_init_descriptor_tables(struct kvm_vcpu *vcpu)
 {
+	struct kvm_vm *vm = vcpu->vm;
 	struct kvm_sregs sregs;
 
-	vcpu_sregs_get(vm, vcpuid, &sregs);
+	vcpu_sregs_get(vcpu, &sregs);
 	sregs.idt.base = vm->idt;
 	sregs.idt.limit = NUM_INTERRUPTS * sizeof(struct idt_entry) - 1;
 	sregs.gdt.base = vm->gdt;
 	sregs.gdt.limit = getpagesize() - 1;
 	kvm_seg_set_kernel_data_64bit(NULL, DEFAULT_DATA_SELECTOR, &sregs.gs);
-	vcpu_sregs_set(vm, vcpuid, &sregs);
+	vcpu_sregs_set(vcpu, &sregs);
 	*(vm_vaddr_t *)addr_gva2hva(vm, (vm_vaddr_t)(&exception_handlers)) = vm->handlers;
 }
 
@@ -1231,11 +1219,11 @@ void vm_install_exception_handler(struct kvm_vm *vm, int vector,
 	handlers[vector] = (vm_vaddr_t)handler;
 }
 
-void assert_on_unhandled_exception(struct kvm_vm *vm, uint32_t vcpuid)
+void assert_on_unhandled_exception(struct kvm_vcpu *vcpu)
 {
 	struct ucall uc;
 
-	if (get_ucall(vm, vcpuid, &uc) == UCALL_UNHANDLED) {
+	if (get_ucall(vcpu, &uc) == UCALL_UNHANDLED) {
 		uint64_t vector = uc.args[0];
 
 		TEST_FAIL("Unexpected vectored event in guest (vector:0x%lx)",
@@ -1306,7 +1294,7 @@ struct kvm_cpuid2 *kvm_get_supported_hv_cpuid(void)
 	return cpuid;
 }
 
-void vcpu_set_hv_cpuid(struct kvm_vm *vm, uint32_t vcpuid)
+void vcpu_set_hv_cpuid(struct kvm_vcpu *vcpu)
 {
 	static struct kvm_cpuid2 *cpuid_full;
 	struct kvm_cpuid2 *cpuid_sys, *cpuid_hv;
@@ -1338,16 +1326,16 @@ void vcpu_set_hv_cpuid(struct kvm_vm *vm, uint32_t vcpuid)
 		cpuid_full->nent = nent + cpuid_hv->nent;
 	}
 
-	vcpu_set_cpuid(vm, vcpuid, cpuid_full);
+	vcpu_set_cpuid(vcpu, cpuid_full);
 }
 
-struct kvm_cpuid2 *vcpu_get_supported_hv_cpuid(struct kvm_vm *vm, uint32_t vcpuid)
+struct kvm_cpuid2 *vcpu_get_supported_hv_cpuid(struct kvm_vcpu *vcpu)
 {
 	static struct kvm_cpuid2 *cpuid;
 
 	cpuid = allocate_kvm_cpuid2();
 
-	vcpu_ioctl(vm, vcpuid, KVM_GET_SUPPORTED_HV_CPUID, cpuid);
+	vcpu_ioctl(vcpu, KVM_GET_SUPPORTED_HV_CPUID, cpuid);
 
 	return cpuid;
 }
diff --git a/tools/testing/selftests/kvm/lib/x86_64/ucall.c b/tools/testing/selftests/kvm/lib/x86_64/ucall.c
index a3489973e290..e39857aa646d 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/ucall.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/ucall.c
@@ -35,9 +35,9 @@ void ucall(uint64_t cmd, int nargs, ...)
 		: : [port] "d" (UCALL_PIO_PORT), "D" (&uc) : "rax", "memory");
 }
 
-uint64_t get_ucall(struct kvm_vm *vm, uint32_t vcpu_id, struct ucall *uc)
+uint64_t get_ucall(struct kvm_vcpu *vcpu, struct ucall *uc)
 {
-	struct kvm_run *run = vcpu_state(vm, vcpu_id);
+	struct kvm_run *run = vcpu->run;
 	struct ucall ucall = {};
 
 	if (uc)
@@ -46,11 +46,11 @@ uint64_t get_ucall(struct kvm_vm *vm, uint32_t vcpu_id, struct ucall *uc)
 	if (run->exit_reason == KVM_EXIT_IO && run->io.port == UCALL_PIO_PORT) {
 		struct kvm_regs regs;
 
-		vcpu_regs_get(vm, vcpu_id, &regs);
-		memcpy(&ucall, addr_gva2hva(vm, (vm_vaddr_t)regs.rdi),
+		vcpu_regs_get(vcpu, &regs);
+		memcpy(&ucall, addr_gva2hva(vcpu->vm, (vm_vaddr_t)regs.rdi),
 		       sizeof(ucall));
 
-		vcpu_run_complete_io(vm, vcpu_id);
+		vcpu_run_complete_io(vcpu);
 		if (uc)
 			memcpy(uc, &ucall, sizeof(ucall));
 	}
diff --git a/tools/testing/selftests/kvm/lib/x86_64/vmx.c b/tools/testing/selftests/kvm/lib/x86_64/vmx.c
index 0d42aa821833..0d66d1704867 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/vmx.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/vmx.c
@@ -42,7 +42,7 @@ struct eptPageTablePointer {
 	uint64_t address:40;
 	uint64_t reserved_63_52:12;
 };
-int vcpu_enable_evmcs(struct kvm_vm *vm, int vcpu_id)
+int vcpu_enable_evmcs(struct kvm_vcpu *vcpu)
 {
 	uint16_t evmcs_ver;
 
@@ -51,7 +51,7 @@ int vcpu_enable_evmcs(struct kvm_vm *vm, int vcpu_id)
 		 .args[0] = (unsigned long)&evmcs_ver
 	};
 
-	vcpu_ioctl(vm, vcpu_id, KVM_ENABLE_CAP, &enable_evmcs_cap);
+	vcpu_ioctl(vcpu, KVM_ENABLE_CAP, &enable_evmcs_cap);
 
 	/* KVM should return supported EVMCS version range */
 	TEST_ASSERT(((evmcs_ver >> 8) >= (evmcs_ver & 0xff)) &&
diff --git a/tools/testing/selftests/kvm/max_guest_memory_test.c b/tools/testing/selftests/kvm/max_guest_memory_test.c
index 956fc56b8c68..2391d071b395 100644
--- a/tools/testing/selftests/kvm/max_guest_memory_test.c
+++ b/tools/testing/selftests/kvm/max_guest_memory_test.c
@@ -51,10 +51,10 @@ static void rendezvous_with_boss(void)
 	}
 }
 
-static void run_vcpu(struct kvm_vm *vm, uint32_t vcpu_id)
+static void run_vcpu(struct kvm_vcpu *vcpu)
 {
-	vcpu_run(vm, vcpu_id);
-	ASSERT_EQ(get_ucall(vm, vcpu_id, NULL), UCALL_DONE);
+	vcpu_run(vcpu);
+	ASSERT_EQ(get_ucall(vcpu, NULL), UCALL_DONE);
 }
 
 static void *vcpu_worker(void *data)
@@ -65,25 +65,25 @@ static void *vcpu_worker(void *data)
 	struct kvm_sregs sregs;
 	struct kvm_regs regs;
 
-	vcpu_args_set(vm, vcpu->id, 3, info->start_gpa, info->end_gpa,
+	vcpu_args_set(vcpu, 3, info->start_gpa, info->end_gpa,
 		      vm_get_page_size(vm));
 
 	/* Snapshot regs before the first run. */
-	vcpu_regs_get(vm, vcpu->id, &regs);
+	vcpu_regs_get(vcpu, &regs);
 	rendezvous_with_boss();
 
-	run_vcpu(vm, vcpu->id);
+	run_vcpu(vcpu);
 	rendezvous_with_boss();
-	vcpu_regs_set(vm, vcpu->id, &regs);
-	vcpu_sregs_get(vm, vcpu->id, &sregs);
+	vcpu_regs_set(vcpu, &regs);
+	vcpu_sregs_get(vcpu, &sregs);
 #ifdef __x86_64__
 	/* Toggle CR0.WP to trigger a MMU context reset. */
 	sregs.cr0 ^= X86_CR0_WP;
 #endif
-	vcpu_sregs_set(vm, vcpu->id, &sregs);
+	vcpu_sregs_set(vcpu, &sregs);
 	rendezvous_with_boss();
 
-	run_vcpu(vm, vcpu->id);
+	run_vcpu(vcpu);
 	rendezvous_with_boss();
 
 	return NULL;
diff --git a/tools/testing/selftests/kvm/memslot_modification_stress_test.c b/tools/testing/selftests/kvm/memslot_modification_stress_test.c
index a3efb3182119..1f9036cdcaa9 100644
--- a/tools/testing/selftests/kvm/memslot_modification_stress_test.c
+++ b/tools/testing/selftests/kvm/memslot_modification_stress_test.c
@@ -39,7 +39,6 @@ static bool run_vcpus = true;
 static void vcpu_worker(struct perf_test_vcpu_args *vcpu_args)
 {
 	struct kvm_vcpu *vcpu = vcpu_args->vcpu;
-	struct kvm_vm *vm = perf_test_args.vm;
 	struct kvm_run *run;
 	int ret;
 
@@ -47,10 +46,10 @@ static void vcpu_worker(struct perf_test_vcpu_args *vcpu_args)
 
 	/* Let the guest access its memory until a stop signal is received */
 	while (READ_ONCE(run_vcpus)) {
-		ret = _vcpu_run(vm, vcpu->id);
+		ret = _vcpu_run(vcpu);
 		TEST_ASSERT(ret == 0, "vcpu_run failed: %d\n", ret);
 
-		if (get_ucall(vm, vcpu->id, NULL) == UCALL_SYNC)
+		if (get_ucall(vcpu, NULL) == UCALL_SYNC)
 			continue;
 
 		TEST_ASSERT(false,
diff --git a/tools/testing/selftests/kvm/memslot_perf_test.c b/tools/testing/selftests/kvm/memslot_perf_test.c
index 009eb19b28af..5f98489e4f4d 100644
--- a/tools/testing/selftests/kvm/memslot_perf_test.c
+++ b/tools/testing/selftests/kvm/memslot_perf_test.c
@@ -146,9 +146,9 @@ static void *vcpu_worker(void *__data)
 	struct ucall uc;
 
 	while (1) {
-		vcpu_run(data->vm, vcpu->id);
+		vcpu_run(vcpu);
 
-		switch (get_ucall(data->vm, vcpu->id, &uc)) {
+		switch (get_ucall(vcpu, &uc)) {
 		case UCALL_SYNC:
 			TEST_ASSERT(uc.args[1] == 0,
 				"Unexpected sync ucall, got %lx",
diff --git a/tools/testing/selftests/kvm/rseq_test.c b/tools/testing/selftests/kvm/rseq_test.c
index fd754de0b74c..68c0c8bb206e 100644
--- a/tools/testing/selftests/kvm/rseq_test.c
+++ b/tools/testing/selftests/kvm/rseq_test.c
@@ -233,8 +233,8 @@ int main(int argc, char *argv[])
 	pthread_create(&migration_thread, NULL, migration_worker, 0);
 
 	for (i = 0; !done; i++) {
-		vcpu_run(vm, vcpu->id);
-		TEST_ASSERT(get_ucall(vm, vcpu->id, NULL) == UCALL_SYNC,
+		vcpu_run(vcpu);
+		TEST_ASSERT(get_ucall(vcpu, NULL) == UCALL_SYNC,
 			    "Guest failed?");
 
 		/*
diff --git a/tools/testing/selftests/kvm/s390x/memop.c b/tools/testing/selftests/kvm/s390x/memop.c
index ba5f645b7565..aa476e1bb7d0 100644
--- a/tools/testing/selftests/kvm/s390x/memop.c
+++ b/tools/testing/selftests/kvm/s390x/memop.c
@@ -149,7 +149,7 @@ static void memop_ioctl(struct test_info info, struct kvm_s390_mem_op *ksmo)
 	if (!vcpu)
 		vm_ioctl(info.vm, KVM_S390_MEM_OP, ksmo);
 	else
-		vcpu_ioctl(vcpu->vm, vcpu->id, KVM_S390_MEM_OP, ksmo);
+		vcpu_ioctl(vcpu, KVM_S390_MEM_OP, ksmo);
 }
 
 static int err_memop_ioctl(struct test_info info, struct kvm_s390_mem_op *ksmo)
@@ -159,7 +159,7 @@ static int err_memop_ioctl(struct test_info info, struct kvm_s390_mem_op *ksmo)
 	if (!vcpu)
 		return __vm_ioctl(info.vm, KVM_S390_MEM_OP, ksmo);
 	else
-		return __vcpu_ioctl(vcpu->vm, vcpu->id, KVM_S390_MEM_OP, ksmo);
+		return __vcpu_ioctl(vcpu, KVM_S390_MEM_OP, ksmo);
 }
 
 #define MEMOP(err, info_p, mop_target_p, access_mode_p, buf_p, size_p, ...)	\
@@ -246,8 +246,8 @@ enum stage {
 	struct ucall uc;						\
 	int __stage = (stage);						\
 									\
-	vcpu_run(__vcpu->vm, __vcpu->id);				\
-	get_ucall(__vcpu->vm, __vcpu->id, &uc);				\
+	vcpu_run(__vcpu);						\
+	get_ucall(__vcpu, &uc);						\
 	ASSERT_EQ(uc.cmd, UCALL_SYNC);					\
 	ASSERT_EQ(uc.args[1], __stage);					\
 })									\
diff --git a/tools/testing/selftests/kvm/s390x/resets.c b/tools/testing/selftests/kvm/s390x/resets.c
index c9233f14689c..a06ed20670fe 100644
--- a/tools/testing/selftests/kvm/s390x/resets.c
+++ b/tools/testing/selftests/kvm/s390x/resets.c
@@ -63,7 +63,7 @@ static void test_one_reg(struct kvm_vcpu *vcpu, uint64_t id, uint64_t value)
 
 	reg.addr = (uintptr_t)&eval_reg;
 	reg.id = id;
-	vcpu_get_reg(vcpu->vm, vcpu->id, &reg);
+	vcpu_get_reg(vcpu, &reg);
 	TEST_ASSERT(eval_reg == value, "value == 0x%lx", value);
 }
 
@@ -74,7 +74,7 @@ static void assert_noirq(struct kvm_vcpu *vcpu)
 
 	irq_state.len = sizeof(buf);
 	irq_state.buf = (unsigned long)buf;
-	irqs = __vcpu_ioctl(vcpu->vm, vcpu->id, KVM_S390_GET_IRQ_STATE, &irq_state);
+	irqs = __vcpu_ioctl(vcpu, KVM_S390_GET_IRQ_STATE, &irq_state);
 	/*
 	 * irqs contains the number of retrieved interrupts. Any interrupt
 	 * (notably, the emergency call interrupt we have injected) should
@@ -91,13 +91,13 @@ static void assert_clear(struct kvm_vcpu *vcpu)
 	struct kvm_regs regs;
 	struct kvm_fpu fpu;
 
-	vcpu_regs_get(vcpu->vm, vcpu->id, &regs);
+	vcpu_regs_get(vcpu, &regs);
 	TEST_ASSERT(!memcmp(&regs.gprs, regs_null, sizeof(regs.gprs)), "grs == 0");
 
-	vcpu_sregs_get(vcpu->vm, vcpu->id, &sregs);
+	vcpu_sregs_get(vcpu, &sregs);
 	TEST_ASSERT(!memcmp(&sregs.acrs, regs_null, sizeof(sregs.acrs)), "acrs == 0");
 
-	vcpu_fpu_get(vcpu->vm, vcpu->id, &fpu);
+	vcpu_fpu_get(vcpu, &fpu);
 	TEST_ASSERT(!memcmp(&fpu.fprs, regs_null, sizeof(fpu.fprs)), "fprs == 0");
 
 	/* sync regs */
@@ -135,7 +135,7 @@ static void assert_initial(struct kvm_vcpu *vcpu)
 	struct kvm_fpu fpu;
 
 	/* KVM_GET_SREGS */
-	vcpu_sregs_get(vcpu->vm, vcpu->id, &sregs);
+	vcpu_sregs_get(vcpu, &sregs);
 	TEST_ASSERT(sregs.crs[0] == 0xE0UL, "cr0 == 0xE0 (KVM_GET_SREGS)");
 	TEST_ASSERT(sregs.crs[14] == 0xC2000000UL,
 		    "cr14 == 0xC2000000 (KVM_GET_SREGS)");
@@ -161,7 +161,7 @@ static void assert_initial(struct kvm_vcpu *vcpu)
 	TEST_ASSERT(vcpu->run->psw_addr == 0, "psw_addr == 0 (kvm_run)");
 	TEST_ASSERT(vcpu->run->psw_mask == 0, "psw_mask == 0 (kvm_run)");
 
-	vcpu_fpu_get(vcpu->vm, vcpu->id, &fpu);
+	vcpu_fpu_get(vcpu, &fpu);
 	TEST_ASSERT(!fpu.fpc, "fpc == 0");
 
 	test_one_reg(vcpu, KVM_REG_S390_GBEA, 1);
@@ -200,7 +200,7 @@ static void inject_irq(struct kvm_vcpu *vcpu)
 	irq_state.buf = (unsigned long)buf;
 	irq->type = KVM_S390_INT_EMERGENCY;
 	irq->u.emerg.code = vcpu->id;
-	irqs = __vcpu_ioctl(vcpu->vm, vcpu->id, KVM_S390_SET_IRQ_STATE, &irq_state);
+	irqs = __vcpu_ioctl(vcpu, KVM_S390_SET_IRQ_STATE, &irq_state);
 	TEST_ASSERT(irqs >= 0, "Error injecting EMERGENCY IRQ errno %d\n", errno);
 }
 
@@ -223,11 +223,11 @@ static void test_normal(void)
 	pr_info("Testing normal reset\n");
 	vm = create_vm(&vcpu);
 
-	vcpu_run(vm, vcpu->id);
+	vcpu_run(vcpu);
 
 	inject_irq(vcpu);
 
-	vcpu_ioctl(vm, vcpu->id, KVM_S390_NORMAL_RESET, 0);
+	vcpu_ioctl(vcpu, KVM_S390_NORMAL_RESET, 0);
 
 	/* must clears */
 	assert_normal(vcpu);
@@ -246,11 +246,11 @@ static void test_initial(void)
 	pr_info("Testing initial reset\n");
 	vm = create_vm(&vcpu);
 
-	vcpu_run(vm, vcpu->id);
+	vcpu_run(vcpu);
 
 	inject_irq(vcpu);
 
-	vcpu_ioctl(vm, vcpu->id, KVM_S390_INITIAL_RESET, 0);
+	vcpu_ioctl(vcpu, KVM_S390_INITIAL_RESET, 0);
 
 	/* must clears */
 	assert_normal(vcpu);
@@ -269,11 +269,11 @@ static void test_clear(void)
 	pr_info("Testing clear reset\n");
 	vm = create_vm(&vcpu);
 
-	vcpu_run(vm, vcpu->id);
+	vcpu_run(vcpu);
 
 	inject_irq(vcpu);
 
-	vcpu_ioctl(vm, vcpu->id, KVM_S390_CLEAR_RESET, 0);
+	vcpu_ioctl(vcpu, KVM_S390_CLEAR_RESET, 0);
 
 	/* must clears */
 	assert_normal(vcpu);
diff --git a/tools/testing/selftests/kvm/s390x/sync_regs_test.c b/tools/testing/selftests/kvm/s390x/sync_regs_test.c
index bf52cabeaed6..13c4c091aa66 100644
--- a/tools/testing/selftests/kvm/s390x/sync_regs_test.c
+++ b/tools/testing/selftests/kvm/s390x/sync_regs_test.c
@@ -97,14 +97,14 @@ int main(int argc, char *argv[])
 
 	/* Request reading invalid register set from VCPU. */
 	run->kvm_valid_regs = INVALID_SYNC_FIELD;
-	rv = _vcpu_run(vm, vcpu->id);
+	rv = _vcpu_run(vcpu);
 	TEST_ASSERT(rv < 0 && errno == EINVAL,
 		    "Invalid kvm_valid_regs did not cause expected KVM_RUN error: %d\n",
 		    rv);
 	run->kvm_valid_regs = 0;
 
 	run->kvm_valid_regs = INVALID_SYNC_FIELD | TEST_SYNC_FIELDS;
-	rv = _vcpu_run(vm, vcpu->id);
+	rv = _vcpu_run(vcpu);
 	TEST_ASSERT(rv < 0 && errno == EINVAL,
 		    "Invalid kvm_valid_regs did not cause expected KVM_RUN error: %d\n",
 		    rv);
@@ -112,14 +112,14 @@ int main(int argc, char *argv[])
 
 	/* Request setting invalid register set into VCPU. */
 	run->kvm_dirty_regs = INVALID_SYNC_FIELD;
-	rv = _vcpu_run(vm, vcpu->id);
+	rv = _vcpu_run(vcpu);
 	TEST_ASSERT(rv < 0 && errno == EINVAL,
 		    "Invalid kvm_dirty_regs did not cause expected KVM_RUN error: %d\n",
 		    rv);
 	run->kvm_dirty_regs = 0;
 
 	run->kvm_dirty_regs = INVALID_SYNC_FIELD | TEST_SYNC_FIELDS;
-	rv = _vcpu_run(vm, vcpu->id);
+	rv = _vcpu_run(vcpu);
 	TEST_ASSERT(rv < 0 && errno == EINVAL,
 		    "Invalid kvm_dirty_regs did not cause expected KVM_RUN error: %d\n",
 		    rv);
@@ -127,7 +127,7 @@ int main(int argc, char *argv[])
 
 	/* Request and verify all valid register sets. */
 	run->kvm_valid_regs = TEST_SYNC_FIELDS;
-	rv = _vcpu_run(vm, vcpu->id);
+	rv = _vcpu_run(vcpu);
 	TEST_ASSERT(rv == 0, "vcpu_run failed: %d\n", rv);
 	TEST_ASSERT(run->exit_reason == KVM_EXIT_S390_SIEIC,
 		    "Unexpected exit reason: %u (%s)\n",
@@ -140,10 +140,10 @@ int main(int argc, char *argv[])
 		    run->s390_sieic.icptcode, run->s390_sieic.ipa,
 		    run->s390_sieic.ipb);
 
-	vcpu_regs_get(vm, vcpu->id, &regs);
+	vcpu_regs_get(vcpu, &regs);
 	compare_regs(&regs, &run->s.regs);
 
-	vcpu_sregs_get(vm, vcpu->id, &sregs);
+	vcpu_sregs_get(vcpu, &sregs);
 	compare_sregs(&sregs, &run->s.regs);
 
 	/* Set and verify various register values */
@@ -158,7 +158,7 @@ int main(int argc, char *argv[])
 		run->kvm_dirty_regs |= KVM_SYNC_DIAG318;
 	}
 
-	rv = _vcpu_run(vm, vcpu->id);
+	rv = _vcpu_run(vcpu);
 	TEST_ASSERT(rv == 0, "vcpu_run failed: %d\n", rv);
 	TEST_ASSERT(run->exit_reason == KVM_EXIT_S390_SIEIC,
 		    "Unexpected exit reason: %u (%s)\n",
@@ -174,10 +174,10 @@ int main(int argc, char *argv[])
 		    "diag318 sync regs value incorrect 0x%llx.",
 		    run->s.regs.diag318);
 
-	vcpu_regs_get(vm, vcpu->id, &regs);
+	vcpu_regs_get(vcpu, &regs);
 	compare_regs(&regs, &run->s.regs);
 
-	vcpu_sregs_get(vm, vcpu->id, &sregs);
+	vcpu_sregs_get(vcpu, &sregs);
 	compare_sregs(&sregs, &run->s.regs);
 
 	/* Clear kvm_dirty_regs bits, verify new s.regs values are
@@ -187,7 +187,7 @@ int main(int argc, char *argv[])
 	run->kvm_dirty_regs = 0;
 	run->s.regs.gprs[11] = 0xDEADBEEF;
 	run->s.regs.diag318 = 0x4B1D;
-	rv = _vcpu_run(vm, vcpu->id);
+	rv = _vcpu_run(vcpu);
 	TEST_ASSERT(rv == 0, "vcpu_run failed: %d\n", rv);
 	TEST_ASSERT(run->exit_reason == KVM_EXIT_S390_SIEIC,
 		    "Unexpected exit reason: %u (%s)\n",
diff --git a/tools/testing/selftests/kvm/s390x/tprot.c b/tools/testing/selftests/kvm/s390x/tprot.c
index 4caa77388033..25bee126c6b9 100644
--- a/tools/testing/selftests/kvm/s390x/tprot.c
+++ b/tools/testing/selftests/kvm/s390x/tprot.c
@@ -186,8 +186,8 @@ static void guest_code(void)
 	struct ucall uc;							\
 	int __stage = (stage);							\
 										\
-	vcpu_run(__vcpu->vm, __vcpu->id);					\
-	get_ucall(__vcpu->vm, __vcpu->id, &uc);					\
+	vcpu_run(__vcpu);							\
+	get_ucall(__vcpu, &uc);							\
 	if (uc.cmd == UCALL_ABORT) {						\
 		TEST_FAIL("line %lu: %s, hints: %lu, %lu", uc.args[1],		\
 			  (const char *)uc.args[0], uc.args[2], uc.args[3]);	\
diff --git a/tools/testing/selftests/kvm/set_memory_region_test.c b/tools/testing/selftests/kvm/set_memory_region_test.c
index d832fc12984e..47b219dd60e4 100644
--- a/tools/testing/selftests/kvm/set_memory_region_test.c
+++ b/tools/testing/selftests/kvm/set_memory_region_test.c
@@ -63,10 +63,10 @@ static void *vcpu_worker(void *data)
 	 * has been deleted or while it is being moved .
 	 */
 	while (1) {
-		vcpu_run(vcpu->vm, vcpu->id);
+		vcpu_run(vcpu);
 
 		if (run->exit_reason == KVM_EXIT_IO) {
-			cmd = get_ucall(vcpu->vm, vcpu->id, &uc);
+			cmd = get_ucall(vcpu, &uc);
 			if (cmd != UCALL_SYNC)
 				break;
 
@@ -291,7 +291,7 @@ static void test_delete_memory_region(void)
 		    run->exit_reason == KVM_EXIT_INTERNAL_ERROR,
 		    "Unexpected exit reason = %d", run->exit_reason);
 
-	vcpu_regs_get(vm, vcpu->id, &regs);
+	vcpu_regs_get(vcpu, &regs);
 
 	/*
 	 * On AMD, after KVM_EXIT_SHUTDOWN the VMCB has been reinitialized already,
@@ -318,7 +318,7 @@ static void test_zero_memory_regions(void)
 	vcpu = __vm_vcpu_add(vm, 0);
 
 	vm_ioctl(vm, KVM_SET_NR_MMU_PAGES, (void *)64ul);
-	vcpu_run(vm, vcpu->id);
+	vcpu_run(vcpu);
 
 	run = vcpu->run;
 	TEST_ASSERT(run->exit_reason == KVM_EXIT_INTERNAL_ERROR,
diff --git a/tools/testing/selftests/kvm/steal_time.c b/tools/testing/selftests/kvm/steal_time.c
index 2aca51d83079..05025a5eade6 100644
--- a/tools/testing/selftests/kvm/steal_time.c
+++ b/tools/testing/selftests/kvm/steal_time.c
@@ -73,11 +73,11 @@ static void steal_time_init(struct kvm_vcpu *vcpu, uint32_t i)
 	st_gva[i] = (void *)(ST_GPA_BASE + i * STEAL_TIME_SIZE);
 	sync_global_to_guest(vcpu->vm, st_gva[i]);
 
-	ret = _vcpu_set_msr(vcpu->vm, vcpu->id, MSR_KVM_STEAL_TIME,
+	ret = _vcpu_set_msr(vcpu, MSR_KVM_STEAL_TIME,
 			    (ulong)st_gva[i] | KVM_STEAL_RESERVED_MASK);
 	TEST_ASSERT(ret == 0, "Bad GPA didn't fail");
 
-	vcpu_set_msr(vcpu->vm, vcpu->id, MSR_KVM_STEAL_TIME, (ulong)st_gva[i] | KVM_MSR_ENABLED);
+	vcpu_set_msr(vcpu, MSR_KVM_STEAL_TIME, (ulong)st_gva[i] | KVM_MSR_ENABLED);
 }
 
 static void steal_time_dump(struct kvm_vm *vm, uint32_t vcpu_idx)
@@ -170,7 +170,7 @@ static bool is_steal_time_supported(struct kvm_vcpu *vcpu)
 		.attr = KVM_ARM_VCPU_PVTIME_IPA,
 	};
 
-	return !__vcpu_ioctl(vcpu->vm, vcpu->id, KVM_HAS_DEVICE_ATTR, &dev);
+	return !__vcpu_ioctl(vcpu, KVM_HAS_DEVICE_ATTR, &dev);
 }
 
 static void steal_time_init(struct kvm_vcpu *vcpu, uint32_t i)
@@ -185,20 +185,20 @@ static void steal_time_init(struct kvm_vcpu *vcpu, uint32_t i)
 		.addr = (uint64_t)&st_ipa,
 	};
 
-	vcpu_ioctl(vm, vcpu->id, KVM_HAS_DEVICE_ATTR, &dev);
+	vcpu_ioctl(vcpu, KVM_HAS_DEVICE_ATTR, &dev);
 
 	/* ST_GPA_BASE is identity mapped */
 	st_gva[i] = (void *)(ST_GPA_BASE + i * STEAL_TIME_SIZE);
 	sync_global_to_guest(vm, st_gva[i]);
 
 	st_ipa = (ulong)st_gva[i] | 1;
-	ret = __vcpu_ioctl(vm, vcpu->id, KVM_SET_DEVICE_ATTR, &dev);
+	ret = __vcpu_ioctl(vcpu, KVM_SET_DEVICE_ATTR, &dev);
 	TEST_ASSERT(ret == -1 && errno == EINVAL, "Bad IPA didn't report EINVAL");
 
 	st_ipa = (ulong)st_gva[i];
-	vcpu_ioctl(vm, vcpu->id, KVM_SET_DEVICE_ATTR, &dev);
+	vcpu_ioctl(vcpu, KVM_SET_DEVICE_ATTR, &dev);
 
-	ret = __vcpu_ioctl(vm, vcpu->id, KVM_SET_DEVICE_ATTR, &dev);
+	ret = __vcpu_ioctl(vcpu, KVM_SET_DEVICE_ATTR, &dev);
 	TEST_ASSERT(ret == -1 && errno == EEXIST, "Set IPA twice without EEXIST");
 }
 
@@ -234,9 +234,9 @@ static void run_vcpu(struct kvm_vcpu *vcpu)
 {
 	struct ucall uc;
 
-	vcpu_run(vcpu->vm, vcpu->id);
+	vcpu_run(vcpu);
 
-	switch (get_ucall(vcpu->vm, vcpu->id, &uc)) {
+	switch (get_ucall(vcpu, &uc)) {
 	case UCALL_SYNC:
 	case UCALL_DONE:
 		break;
@@ -287,7 +287,7 @@ int main(int ac, char **av)
 	for (i = 0; i < NR_VCPUS; ++i) {
 		steal_time_init(vcpus[i], i);
 
-		vcpu_args_set(vm, vcpus[i]->id, 1, i);
+		vcpu_args_set(vcpus[i], 1, i);
 
 		/* First VCPU run initializes steal-time */
 		run_vcpu(vcpus[i]);
diff --git a/tools/testing/selftests/kvm/system_counter_offset_test.c b/tools/testing/selftests/kvm/system_counter_offset_test.c
index 0690ce0ae4fa..7c8be0930737 100644
--- a/tools/testing/selftests/kvm/system_counter_offset_test.c
+++ b/tools/testing/selftests/kvm/system_counter_offset_test.c
@@ -28,8 +28,7 @@ static struct test_case test_cases[] = {
 
 static void check_preconditions(struct kvm_vcpu *vcpu)
 {
-	if (!__vcpu_has_device_attr(vcpu->vm, vcpu->id, KVM_VCPU_TSC_CTRL,
-				    KVM_VCPU_TSC_OFFSET))
+	if (!__vcpu_has_device_attr(vcpu, KVM_VCPU_TSC_CTRL, KVM_VCPU_TSC_OFFSET))
 		return;
 
 	print_skip("KVM_VCPU_TSC_OFFSET not supported; skipping test");
@@ -38,8 +37,8 @@ static void check_preconditions(struct kvm_vcpu *vcpu)
 
 static void setup_system_counter(struct kvm_vcpu *vcpu, struct test_case *test)
 {
-	vcpu_device_attr_set(vcpu->vm, vcpu->id, KVM_VCPU_TSC_CTRL,
-			     KVM_VCPU_TSC_OFFSET, &test->tsc_offset);
+	vcpu_device_attr_set(vcpu, KVM_VCPU_TSC_CTRL, KVM_VCPU_TSC_OFFSET,
+			     &test->tsc_offset);
 }
 
 static uint64_t guest_read_system_counter(struct test_case *test)
@@ -101,10 +100,10 @@ static void enter_guest(struct kvm_vcpu *vcpu)
 
 		setup_system_counter(vcpu, test);
 		start = host_read_guest_system_counter(test);
-		vcpu_run(vcpu->vm, vcpu->id);
+		vcpu_run(vcpu);
 		end = host_read_guest_system_counter(test);
 
-		switch (get_ucall(vcpu->vm, vcpu->id, &uc)) {
+		switch (get_ucall(vcpu, &uc)) {
 		case UCALL_SYNC:
 			handle_sync(&uc, start, end);
 			break;
@@ -113,7 +112,7 @@ static void enter_guest(struct kvm_vcpu *vcpu)
 			return;
 		default:
 			TEST_ASSERT(0, "unhandled ucall %ld\n",
-				    get_ucall(vcpu->vm, vcpu->id, &uc));
+				    get_ucall(vcpu, &uc));
 		}
 	}
 }
diff --git a/tools/testing/selftests/kvm/x86_64/amx_test.c b/tools/testing/selftests/kvm/x86_64/amx_test.c
index 7755fe8fcffb..b421c8369dba 100644
--- a/tools/testing/selftests/kvm/x86_64/amx_test.c
+++ b/tools/testing/selftests/kvm/x86_64/amx_test.c
@@ -351,11 +351,11 @@ int main(int argc, char *argv[])
 	}
 
 	run = vcpu->run;
-	vcpu_regs_get(vm, vcpu->id, &regs1);
+	vcpu_regs_get(vcpu, &regs1);
 
 	/* Register #NM handler */
 	vm_init_descriptor_tables(vm);
-	vcpu_init_descriptor_tables(vm, vcpu->id);
+	vcpu_init_descriptor_tables(vcpu);
 	vm_install_exception_handler(vm, NM_VECTOR, guest_nm_handler);
 
 	/* amx cfg for guest_code */
@@ -369,16 +369,16 @@ int main(int argc, char *argv[])
 	/* xsave data for guest_code */
 	xsavedata = vm_vaddr_alloc_pages(vm, 3);
 	memset(addr_gva2hva(vm, xsavedata), 0, 3 * getpagesize());
-	vcpu_args_set(vm, vcpu->id, 3, amx_cfg, tiledata, xsavedata);
+	vcpu_args_set(vcpu, 3, amx_cfg, tiledata, xsavedata);
 
 	for (stage = 1; ; stage++) {
-		vcpu_run(vm, vcpu->id);
+		vcpu_run(vcpu);
 		TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
 			    "Stage %d: unexpected exit reason: %u (%s),\n",
 			    stage, run->exit_reason,
 			    exit_reason_str(run->exit_reason));
 
-		switch (get_ucall(vm, vcpu->id, &uc)) {
+		switch (get_ucall(vcpu, &uc)) {
 		case UCALL_ABORT:
 			TEST_FAIL("%s at %s:%ld", (const char *)uc.args[0],
 				  __FILE__, uc.args[1]);
@@ -403,7 +403,7 @@ int main(int argc, char *argv[])
 				 * size subtract 8K amx size.
 				 */
 				amx_offset = xsave_restore_size - NUM_TILES*TILE_SIZE;
-				state = vcpu_save_state(vm, vcpu->id);
+				state = vcpu_save_state(vcpu);
 				void *amx_start = (void *)state->xsave + amx_offset;
 				void *tiles_data = (void *)addr_gva2hva(vm, tiledata);
 				/* Only check TMM0 register, 1 tile */
@@ -424,21 +424,21 @@ int main(int argc, char *argv[])
 			TEST_FAIL("Unknown ucall %lu", uc.cmd);
 		}
 
-		state = vcpu_save_state(vm, vcpu->id);
+		state = vcpu_save_state(vcpu);
 		memset(&regs1, 0, sizeof(regs1));
-		vcpu_regs_get(vm, vcpu->id, &regs1);
+		vcpu_regs_get(vcpu, &regs1);
 
 		kvm_vm_release(vm);
 
 		/* Restore state in a new VM.  */
 		vcpu = vm_recreate_with_one_vcpu(vm);
-		vcpu_set_cpuid(vm, vcpu->id, kvm_get_supported_cpuid());
-		vcpu_load_state(vm, vcpu->id, state);
+		vcpu_set_cpuid(vcpu, kvm_get_supported_cpuid());
+		vcpu_load_state(vcpu, state);
 		run = vcpu->run;
 		kvm_x86_state_cleanup(state);
 
 		memset(&regs2, 0, sizeof(regs2));
-		vcpu_regs_get(vm, vcpu->id, &regs2);
+		vcpu_regs_get(vcpu, &regs2);
 		TEST_ASSERT(!memcmp(&regs1, &regs2, sizeof(regs2)),
 			    "Unexpected register values after vcpu_load_state; rdi: %lx rsi: %lx",
 			    (ulong) regs2.rdi, (ulong) regs2.rsi);
diff --git a/tools/testing/selftests/kvm/x86_64/cpuid_test.c b/tools/testing/selftests/kvm/x86_64/cpuid_test.c
index 76cdd0d10757..4aa784932597 100644
--- a/tools/testing/selftests/kvm/x86_64/cpuid_test.c
+++ b/tools/testing/selftests/kvm/x86_64/cpuid_test.c
@@ -120,9 +120,9 @@ static void run_vcpu(struct kvm_vcpu *vcpu, int stage)
 {
 	struct ucall uc;
 
-	vcpu_run(vcpu->vm, vcpu->id);
+	vcpu_run(vcpu);
 
-	switch (get_ucall(vcpu->vm, vcpu->id, &uc)) {
+	switch (get_ucall(vcpu, &uc)) {
 	case UCALL_SYNC:
 		TEST_ASSERT(!strcmp((const char *)uc.args[0], "hello") &&
 			    uc.args[1] == stage + 1,
@@ -159,14 +159,14 @@ static void set_cpuid_after_run(struct kvm_vcpu *vcpu, struct kvm_cpuid2 *cpuid)
 	u32 eax, ebx, x;
 
 	/* Setting unmodified CPUID is allowed */
-	rc = __vcpu_set_cpuid(vcpu->vm, vcpu->id, cpuid);
+	rc = __vcpu_set_cpuid(vcpu, cpuid);
 	TEST_ASSERT(!rc, "Setting unmodified CPUID after KVM_RUN failed: %d", rc);
 
 	/* Changing CPU features is forbidden */
 	ent = get_cpuid(cpuid, 0x7, 0);
 	ebx = ent->ebx;
 	ent->ebx--;
-	rc = __vcpu_set_cpuid(vcpu->vm, vcpu->id, cpuid);
+	rc = __vcpu_set_cpuid(vcpu, cpuid);
 	TEST_ASSERT(rc, "Changing CPU features should fail");
 	ent->ebx = ebx;
 
@@ -175,7 +175,7 @@ static void set_cpuid_after_run(struct kvm_vcpu *vcpu, struct kvm_cpuid2 *cpuid)
 	eax = ent->eax;
 	x = eax & 0xff;
 	ent->eax = (eax & ~0xffu) | (x - 1);
-	rc = __vcpu_set_cpuid(vcpu->vm, vcpu->id, cpuid);
+	rc = __vcpu_set_cpuid(vcpu, cpuid);
 	TEST_ASSERT(rc, "Changing MAXPHYADDR should fail");
 	ent->eax = eax;
 }
@@ -191,13 +191,13 @@ int main(void)
 	vm = vm_create_with_one_vcpu(&vcpu, guest_main);
 
 	supp_cpuid = kvm_get_supported_cpuid();
-	cpuid2 = vcpu_get_cpuid(vm, vcpu->id);
+	cpuid2 = vcpu_get_cpuid(vcpu);
 
 	compare_cpuids(supp_cpuid, cpuid2);
 
 	vcpu_alloc_cpuid(vm, &cpuid_gva, cpuid2);
 
-	vcpu_args_set(vm, vcpu->id, 1, cpuid_gva);
+	vcpu_args_set(vcpu, 1, cpuid_gva);
 
 	for (stage = 0; stage < 3; stage++)
 		run_vcpu(vcpu, stage);
diff --git a/tools/testing/selftests/kvm/x86_64/cr4_cpuid_sync_test.c b/tools/testing/selftests/kvm/x86_64/cr4_cpuid_sync_test.c
index d5615cd0b81b..1635aae970e9 100644
--- a/tools/testing/selftests/kvm/x86_64/cr4_cpuid_sync_test.c
+++ b/tools/testing/selftests/kvm/x86_64/cr4_cpuid_sync_test.c
@@ -82,19 +82,19 @@ int main(int argc, char *argv[])
 	run = vcpu->run;
 
 	while (1) {
-		vcpu_run(vm, vcpu->id);
+		vcpu_run(vcpu);
 
 		TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
 			    "Unexpected exit reason: %u (%s),\n",
 			    run->exit_reason,
 			    exit_reason_str(run->exit_reason));
 
-		switch (get_ucall(vm, vcpu->id, &uc)) {
+		switch (get_ucall(vcpu, &uc)) {
 		case UCALL_SYNC:
 			/* emulate hypervisor clearing CR4.OSXSAVE */
-			vcpu_sregs_get(vm, vcpu->id, &sregs);
+			vcpu_sregs_get(vcpu, &sregs);
 			sregs.cr4 &= ~X86_CR4_OSXSAVE;
-			vcpu_sregs_set(vm, vcpu->id, &sregs);
+			vcpu_sregs_set(vcpu, &sregs);
 			break;
 		case UCALL_ABORT:
 			TEST_FAIL("Guest CR4 bit (OSXSAVE) unsynchronized with CPUID bit.");
diff --git a/tools/testing/selftests/kvm/x86_64/debug_regs.c b/tools/testing/selftests/kvm/x86_64/debug_regs.c
index 487d0ae3e75f..5f07f86efc76 100644
--- a/tools/testing/selftests/kvm/x86_64/debug_regs.c
+++ b/tools/testing/selftests/kvm/x86_64/debug_regs.c
@@ -70,9 +70,9 @@ static void vcpu_skip_insn(struct kvm_vcpu *vcpu, int insn_len)
 {
 	struct kvm_regs regs;
 
-	vcpu_regs_get(vcpu->vm, vcpu->id, &regs);
+	vcpu_regs_get(vcpu, &regs);
 	regs.rip += insn_len;
-	vcpu_regs_set(vcpu->vm, vcpu->id, &regs);
+	vcpu_regs_set(vcpu, &regs);
 }
 
 int main(void)
@@ -106,8 +106,8 @@ int main(void)
 	/* Test software BPs - int3 */
 	memset(&debug, 0, sizeof(debug));
 	debug.control = KVM_GUESTDBG_ENABLE | KVM_GUESTDBG_USE_SW_BP;
-	vcpu_set_guest_debug(vm, vcpu->id, &debug);
-	vcpu_run(vm, vcpu->id);
+	vcpu_set_guest_debug(vcpu, &debug);
+	vcpu_run(vcpu);
 	TEST_ASSERT(run->exit_reason == KVM_EXIT_DEBUG &&
 		    run->debug.arch.exception == BP_VECTOR &&
 		    run->debug.arch.pc == CAST_TO_RIP(sw_bp),
@@ -122,8 +122,8 @@ int main(void)
 		debug.control = KVM_GUESTDBG_ENABLE | KVM_GUESTDBG_USE_HW_BP;
 		debug.arch.debugreg[i] = CAST_TO_RIP(hw_bp);
 		debug.arch.debugreg[7] = 0x400 | (1UL << (2*i+1));
-		vcpu_set_guest_debug(vm, vcpu->id, &debug);
-		vcpu_run(vm, vcpu->id);
+		vcpu_set_guest_debug(vcpu, &debug);
+		vcpu_run(vcpu);
 		target_dr6 = 0xffff0ff0 | (1UL << i);
 		TEST_ASSERT(run->exit_reason == KVM_EXIT_DEBUG &&
 			    run->debug.arch.exception == DB_VECTOR &&
@@ -145,8 +145,8 @@ int main(void)
 		debug.arch.debugreg[i] = CAST_TO_RIP(guest_value);
 		debug.arch.debugreg[7] = 0x00000400 | (1UL << (2*i+1)) |
 		    (0x000d0000UL << (4*i));
-		vcpu_set_guest_debug(vm, vcpu->id, &debug);
-		vcpu_run(vm, vcpu->id);
+		vcpu_set_guest_debug(vcpu, &debug);
+		vcpu_run(vcpu);
 		target_dr6 = 0xffff0ff0 | (1UL << i);
 		TEST_ASSERT(run->exit_reason == KVM_EXIT_DEBUG &&
 			    run->debug.arch.exception == DB_VECTOR &&
@@ -172,8 +172,8 @@ int main(void)
 		debug.control = KVM_GUESTDBG_ENABLE | KVM_GUESTDBG_SINGLESTEP |
 				KVM_GUESTDBG_BLOCKIRQ;
 		debug.arch.debugreg[7] = 0x00000400;
-		vcpu_set_guest_debug(vm, vcpu->id, &debug);
-		vcpu_run(vm, vcpu->id);
+		vcpu_set_guest_debug(vcpu, &debug);
+		vcpu_run(vcpu);
 		TEST_ASSERT(run->exit_reason == KVM_EXIT_DEBUG &&
 			    run->debug.arch.exception == DB_VECTOR &&
 			    run->debug.arch.pc == target_rip &&
@@ -189,8 +189,8 @@ int main(void)
 	memset(&debug, 0, sizeof(debug));
 	debug.control = KVM_GUESTDBG_ENABLE | KVM_GUESTDBG_USE_HW_BP;
 	debug.arch.debugreg[7] = 0x400 | DR7_GD;
-	vcpu_set_guest_debug(vm, vcpu->id, &debug);
-	vcpu_run(vm, vcpu->id);
+	vcpu_set_guest_debug(vcpu, &debug);
+	vcpu_run(vcpu);
 	target_dr6 = 0xffff0ff0 | DR6_BD;
 	TEST_ASSERT(run->exit_reason == KVM_EXIT_DEBUG &&
 		    run->debug.arch.exception == DB_VECTOR &&
@@ -204,11 +204,11 @@ int main(void)
 
 	/* Disable all debug controls, run to the end */
 	memset(&debug, 0, sizeof(debug));
-	vcpu_set_guest_debug(vm, vcpu->id, &debug);
+	vcpu_set_guest_debug(vcpu, &debug);
 
-	vcpu_run(vm, vcpu->id);
+	vcpu_run(vcpu);
 	TEST_ASSERT(run->exit_reason == KVM_EXIT_IO, "KVM_EXIT_IO");
-	cmd = get_ucall(vm, vcpu->id, &uc);
+	cmd = get_ucall(vcpu, &uc);
 	TEST_ASSERT(cmd == UCALL_DONE, "UCALL_DONE");
 
 	kvm_vm_free(vm);
diff --git a/tools/testing/selftests/kvm/x86_64/emulator_error_test.c b/tools/testing/selftests/kvm/x86_64/emulator_error_test.c
index 6a2fe7a9f4a6..2f794755c2df 100644
--- a/tools/testing/selftests/kvm/x86_64/emulator_error_test.c
+++ b/tools/testing/selftests/kvm/x86_64/emulator_error_test.c
@@ -83,9 +83,9 @@ static void process_exit_on_emulation_error(struct kvm_vcpu *vcpu)
 			 * contained an flds instruction that is 2-bytes in
 			 * length (ie: no prefix, no SIB, no displacement).
 			 */
-			vcpu_regs_get(vcpu->vm, vcpu->id, &regs);
+			vcpu_regs_get(vcpu, &regs);
 			regs.rip += 2;
-			vcpu_regs_set(vcpu->vm, vcpu->id, &regs);
+			vcpu_regs_set(vcpu, &regs);
 		}
 	}
 }
@@ -101,7 +101,7 @@ static void check_for_guest_assert(struct kvm_vcpu *vcpu)
 	struct ucall uc;
 
 	if (vcpu->run->exit_reason == KVM_EXIT_IO &&
-	    get_ucall(vcpu->vm, vcpu->id, &uc) == UCALL_ABORT) {
+	    get_ucall(vcpu, &uc) == UCALL_ABORT) {
 		do_guest_assert(&uc);
 	}
 }
@@ -118,7 +118,7 @@ static void process_ucall_done(struct kvm_vcpu *vcpu)
 		    run->exit_reason,
 		    exit_reason_str(run->exit_reason));
 
-	TEST_ASSERT(get_ucall(vcpu->vm, vcpu->id, &uc) == UCALL_DONE,
+	TEST_ASSERT(get_ucall(vcpu, &uc) == UCALL_DONE,
 		    "Unexpected ucall command: %lu, expected UCALL_DONE (%d)",
 		    uc.cmd, UCALL_DONE);
 }
@@ -133,7 +133,7 @@ static uint64_t process_ucall(struct kvm_vcpu *vcpu)
 		    run->exit_reason,
 		    exit_reason_str(run->exit_reason));
 
-	switch (get_ucall(vcpu->vm, vcpu->id, &uc)) {
+	switch (get_ucall(vcpu, &uc)) {
 	case UCALL_SYNC:
 		break;
 	case UCALL_ABORT:
@@ -179,7 +179,7 @@ int main(int argc, char *argv[])
 	entry->eax = (entry->eax & 0xffffff00) | MAXPHYADDR;
 	set_cpuid(cpuid, entry);
 
-	vcpu_set_cpuid(vm, vcpu->id, cpuid);
+	vcpu_set_cpuid(vcpu, cpuid);
 
 	rc = kvm_check_cap(KVM_CAP_EXIT_ON_EMULATION_FAILURE);
 	TEST_ASSERT(rc, "KVM_CAP_EXIT_ON_EMULATION_FAILURE is unavailable");
@@ -194,12 +194,12 @@ int main(int argc, char *argv[])
 	virt_map(vm, MEM_REGION_GVA, MEM_REGION_GPA, 1);
 	hva = addr_gpa2hva(vm, MEM_REGION_GPA);
 	memset(hva, 0, PAGE_SIZE);
-	pte = vm_get_page_table_entry(vm, vcpu->id, MEM_REGION_GVA);
-	vm_set_page_table_entry(vm, vcpu->id, MEM_REGION_GVA, pte | (1ull << 36));
+	pte = vm_get_page_table_entry(vm, vcpu, MEM_REGION_GVA);
+	vm_set_page_table_entry(vm, vcpu, MEM_REGION_GVA, pte | (1ull << 36));
 
-	vcpu_run(vm, vcpu->id);
+	vcpu_run(vcpu);
 	process_exit_on_emulation_error(vcpu);
-	vcpu_run(vm, vcpu->id);
+	vcpu_run(vcpu);
 
 	TEST_ASSERT(process_ucall(vcpu) == UCALL_DONE, "Expected UCALL_DONE");
 
diff --git a/tools/testing/selftests/kvm/x86_64/evmcs_test.c b/tools/testing/selftests/kvm/x86_64/evmcs_test.c
index dc7c1eb28fd4..ee31281b56d8 100644
--- a/tools/testing/selftests/kvm/x86_64/evmcs_test.c
+++ b/tools/testing/selftests/kvm/x86_64/evmcs_test.c
@@ -163,12 +163,12 @@ void inject_nmi(struct kvm_vcpu *vcpu)
 {
 	struct kvm_vcpu_events events;
 
-	vcpu_events_get(vcpu->vm, vcpu->id, &events);
+	vcpu_events_get(vcpu, &events);
 
 	events.nmi.pending = 1;
 	events.flags |= KVM_VCPUEVENT_VALID_NMI_PENDING;
 
-	vcpu_events_set(vcpu->vm, vcpu->id, &events);
+	vcpu_events_set(vcpu, &events);
 }
 
 static struct kvm_vcpu *save_restore_vm(struct kvm_vm *vm,
@@ -177,21 +177,21 @@ static struct kvm_vcpu *save_restore_vm(struct kvm_vm *vm,
 	struct kvm_regs regs1, regs2;
 	struct kvm_x86_state *state;
 
-	state = vcpu_save_state(vm, vcpu->id);
+	state = vcpu_save_state(vcpu);
 	memset(&regs1, 0, sizeof(regs1));
-	vcpu_regs_get(vm, vcpu->id, &regs1);
+	vcpu_regs_get(vcpu, &regs1);
 
 	kvm_vm_release(vm);
 
 	/* Restore state in a new VM.  */
 	vcpu = vm_recreate_with_one_vcpu(vm);
-	vcpu_set_hv_cpuid(vm, vcpu->id);
-	vcpu_enable_evmcs(vm, vcpu->id);
-	vcpu_load_state(vm, vcpu->id, state);
+	vcpu_set_hv_cpuid(vcpu);
+	vcpu_enable_evmcs(vcpu);
+	vcpu_load_state(vcpu, state);
 	kvm_x86_state_cleanup(state);
 
 	memset(&regs2, 0, sizeof(regs2));
-	vcpu_regs_get(vm, vcpu->id, &regs2);
+	vcpu_regs_get(vcpu, &regs2);
 	TEST_ASSERT(!memcmp(&regs1, &regs2, sizeof(regs2)),
 		    "Unexpected register values after vcpu_load_state; rdi: %lx rsi: %lx",
 		    (ulong) regs2.rdi, (ulong) regs2.rsi);
@@ -217,14 +217,14 @@ int main(int argc, char *argv[])
 		exit(KSFT_SKIP);
 	}
 
-	vcpu_set_hv_cpuid(vm, vcpu->id);
-	vcpu_enable_evmcs(vm, vcpu->id);
+	vcpu_set_hv_cpuid(vcpu);
+	vcpu_enable_evmcs(vcpu);
 
 	vcpu_alloc_vmx(vm, &vmx_pages_gva);
-	vcpu_args_set(vm, vcpu->id, 1, vmx_pages_gva);
+	vcpu_args_set(vcpu, 1, vmx_pages_gva);
 
 	vm_init_descriptor_tables(vm);
-	vcpu_init_descriptor_tables(vm, vcpu->id);
+	vcpu_init_descriptor_tables(vcpu);
 	vm_install_exception_handler(vm, UD_VECTOR, guest_ud_handler);
 	vm_install_exception_handler(vm, NMI_VECTOR, guest_nmi_handler);
 
@@ -233,13 +233,13 @@ int main(int argc, char *argv[])
 	for (stage = 1;; stage++) {
 		run = vcpu->run;
 
-		vcpu_run(vm, vcpu->id);
+		vcpu_run(vcpu);
 		TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
 			    "Stage %d: unexpected exit reason: %u (%s),\n",
 			    stage, run->exit_reason,
 			    exit_reason_str(run->exit_reason));
 
-		switch (get_ucall(vm, vcpu->id, &uc)) {
+		switch (get_ucall(vcpu, &uc)) {
 		case UCALL_ABORT:
 			TEST_FAIL("%s at %s:%ld", (const char *)uc.args[0],
 		      		  __FILE__, uc.args[1]);
diff --git a/tools/testing/selftests/kvm/x86_64/fix_hypercall_test.c b/tools/testing/selftests/kvm/x86_64/fix_hypercall_test.c
index 565c4ab8dbb7..3b7ab04f554c 100644
--- a/tools/testing/selftests/kvm/x86_64/fix_hypercall_test.c
+++ b/tools/testing/selftests/kvm/x86_64/fix_hypercall_test.c
@@ -95,7 +95,7 @@ static void guest_main(void)
 static void setup_ud_vector(struct kvm_vcpu *vcpu)
 {
 	vm_init_descriptor_tables(vcpu->vm);
-	vcpu_init_descriptor_tables(vcpu->vm, vcpu->id);
+	vcpu_init_descriptor_tables(vcpu);
 	vm_install_exception_handler(vcpu->vm, UD_VECTOR, guest_ud_handler);
 }
 
@@ -104,8 +104,8 @@ static void enter_guest(struct kvm_vcpu *vcpu)
 	struct kvm_run *run = vcpu->run;
 	struct ucall uc;
 
-	vcpu_run(vcpu->vm, vcpu->id);
-	switch (get_ucall(vcpu->vm, vcpu->id, &uc)) {
+	vcpu_run(vcpu);
+	switch (get_ucall(vcpu, &uc)) {
 	case UCALL_SYNC:
 		pr_info("%s: %016lx\n", (const char *)uc.args[2], uc.args[3]);
 		break;
diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_clock.c b/tools/testing/selftests/kvm/x86_64/hyperv_clock.c
index 43584ddc4de0..c2e37705e5c8 100644
--- a/tools/testing/selftests/kvm/x86_64/hyperv_clock.c
+++ b/tools/testing/selftests/kvm/x86_64/hyperv_clock.c
@@ -176,15 +176,15 @@ static void host_check_tsc_msr_rdtsc(struct kvm_vcpu *vcpu)
 	u64 tsc_freq, r1, r2, t1, t2;
 	s64 delta_ns;
 
-	tsc_freq = vcpu_get_msr(vcpu->vm, vcpu->id, HV_X64_MSR_TSC_FREQUENCY);
+	tsc_freq = vcpu_get_msr(vcpu, HV_X64_MSR_TSC_FREQUENCY);
 	TEST_ASSERT(tsc_freq > 0, "TSC frequency must be nonzero");
 
 	/* First, check MSR-based clocksource */
 	r1 = rdtsc();
-	t1 = vcpu_get_msr(vcpu->vm, vcpu->id, HV_X64_MSR_TIME_REF_COUNT);
+	t1 = vcpu_get_msr(vcpu, HV_X64_MSR_TIME_REF_COUNT);
 	nop_loop();
 	r2 = rdtsc();
-	t2 = vcpu_get_msr(vcpu->vm, vcpu->id, HV_X64_MSR_TIME_REF_COUNT);
+	t2 = vcpu_get_msr(vcpu, HV_X64_MSR_TIME_REF_COUNT);
 
 	TEST_ASSERT(t2 > t1, "Time reference MSR is not monotonic (%ld <= %ld)", t1, t2);
 
@@ -211,24 +211,24 @@ int main(void)
 	vm = vm_create_with_one_vcpu(&vcpu, guest_main);
 	run = vcpu->run;
 
-	vcpu_set_hv_cpuid(vm, vcpu->id);
+	vcpu_set_hv_cpuid(vcpu);
 
 	tsc_page_gva = vm_vaddr_alloc_page(vm);
 	memset(addr_gva2hva(vm, tsc_page_gva), 0x0, getpagesize());
 	TEST_ASSERT((addr_gva2gpa(vm, tsc_page_gva) & (getpagesize() - 1)) == 0,
 		"TSC page has to be page aligned\n");
-	vcpu_args_set(vm, vcpu->id, 2, tsc_page_gva, addr_gva2gpa(vm, tsc_page_gva));
+	vcpu_args_set(vcpu, 2, tsc_page_gva, addr_gva2gpa(vm, tsc_page_gva));
 
 	host_check_tsc_msr_rdtsc(vcpu);
 
 	for (stage = 1;; stage++) {
-		vcpu_run(vm, vcpu->id);
+		vcpu_run(vcpu);
 		TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
 			    "Stage %d: unexpected exit reason: %u (%s),\n",
 			    stage, run->exit_reason,
 			    exit_reason_str(run->exit_reason));
 
-		switch (get_ucall(vm, vcpu->id, &uc)) {
+		switch (get_ucall(vcpu, &uc)) {
 		case UCALL_ABORT:
 			TEST_FAIL("%s at %s:%ld", (const char *)uc.args[0],
 				  __FILE__, uc.args[1]);
diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c b/tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c
index d1a22ee98cf3..af13c48f0f30 100644
--- a/tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c
+++ b/tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c
@@ -119,7 +119,7 @@ void test_hv_cpuid_e2big(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
 	int ret;
 
 	if (vcpu)
-		ret = __vcpu_ioctl(vm, vcpu->id, KVM_GET_SUPPORTED_HV_CPUID, &cpuid);
+		ret = __vcpu_ioctl(vcpu, KVM_GET_SUPPORTED_HV_CPUID, &cpuid);
 	else
 		ret = __kvm_ioctl(vm_get_kvm_fd(vm), KVM_GET_SUPPORTED_HV_CPUID, &cpuid);
 
@@ -147,7 +147,7 @@ int main(int argc, char *argv[])
 	/* Test vCPU ioctl version */
 	test_hv_cpuid_e2big(vm, vcpu);
 
-	hv_cpuid_entries = vcpu_get_supported_hv_cpuid(vm, vcpu->id);
+	hv_cpuid_entries = vcpu_get_supported_hv_cpuid(vcpu);
 	test_hv_cpuid(hv_cpuid_entries, false);
 	free(hv_cpuid_entries);
 
@@ -156,8 +156,8 @@ int main(int argc, char *argv[])
 		print_skip("Enlightened VMCS is unsupported");
 		goto do_sys;
 	}
-	vcpu_enable_evmcs(vm, vcpu->id);
-	hv_cpuid_entries = vcpu_get_supported_hv_cpuid(vm, vcpu->id);
+	vcpu_enable_evmcs(vcpu);
+	hv_cpuid_entries = vcpu_get_supported_hv_cpuid(vcpu);
 	test_hv_cpuid(hv_cpuid_entries, true);
 	free(hv_cpuid_entries);
 
diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_features.c b/tools/testing/selftests/kvm/x86_64/hyperv_features.c
index 52686e2f8d53..d2479f379e28 100644
--- a/tools/testing/selftests/kvm/x86_64/hyperv_features.c
+++ b/tools/testing/selftests/kvm/x86_64/hyperv_features.c
@@ -161,7 +161,7 @@ static void hv_set_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid2 *cpuid,
 		    "failed to set HYPERV_CPUID_ENLIGHTMENT_INFO leaf");
 	TEST_ASSERT(set_cpuid(cpuid, dbg),
 		    "failed to set HYPERV_CPUID_SYNDBG_PLATFORM_CAPABILITIES leaf");
-	vcpu_set_cpuid(vcpu->vm, vcpu->id, cpuid);
+	vcpu_set_cpuid(vcpu, cpuid);
 }
 
 static void guest_test_msrs_access(void)
@@ -195,15 +195,15 @@ static void guest_test_msrs_access(void)
 		memset(addr_gva2hva(vm, msr_gva), 0x0, getpagesize());
 		msr = addr_gva2hva(vm, msr_gva);
 
-		vcpu_args_set(vm, vcpu->id, 1, msr_gva);
-		vcpu_enable_cap(vm, vcpu->id, &cap);
+		vcpu_args_set(vcpu, 1, msr_gva);
+		vcpu_enable_cap(vcpu, &cap);
 
-		vcpu_set_hv_cpuid(vm, vcpu->id);
+		vcpu_set_hv_cpuid(vcpu);
 
 		best = kvm_get_supported_hv_cpuid();
 
 		vm_init_descriptor_tables(vm);
-		vcpu_init_descriptor_tables(vm, vcpu->id);
+		vcpu_init_descriptor_tables(vcpu);
 		vm_install_exception_handler(vm, GP_VECTOR, guest_gp_handler);
 
 		run = vcpu->run;
@@ -339,7 +339,7 @@ static void guest_test_msrs_access(void)
 			 */
 			cap.cap = KVM_CAP_HYPERV_SYNIC2;
 			cap.args[0] = 0;
-			vcpu_enable_cap(vm, vcpu->id, &cap);
+			vcpu_enable_cap(vcpu, &cap);
 			break;
 		case 22:
 			feat.eax |= HV_MSR_SYNIC_AVAILABLE;
@@ -477,12 +477,12 @@ static void guest_test_msrs_access(void)
 		else
 			pr_debug("Stage %d: finish\n", stage);
 
-		vcpu_run(vm, vcpu->id);
+		vcpu_run(vcpu);
 		TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
 			    "unexpected exit reason: %u (%s)",
 			    run->exit_reason, exit_reason_str(run->exit_reason));
 
-		switch (get_ucall(vm, vcpu->id, &uc)) {
+		switch (get_ucall(vcpu, &uc)) {
 		case UCALL_SYNC:
 			TEST_ASSERT(uc.args[1] == 0,
 				    "Unexpected stage: %ld (0 expected)\n",
@@ -530,7 +530,7 @@ static void guest_test_hcalls_access(void)
 		vm = vm_create_with_one_vcpu(&vcpu, guest_hcall);
 
 		vm_init_descriptor_tables(vm);
-		vcpu_init_descriptor_tables(vm, vcpu->id);
+		vcpu_init_descriptor_tables(vcpu);
 		vm_install_exception_handler(vm, UD_VECTOR, guest_ud_handler);
 
 		/* Hypercall input/output */
@@ -541,10 +541,10 @@ static void guest_test_hcalls_access(void)
 		hcall_params = vm_vaddr_alloc_page(vm);
 		memset(addr_gva2hva(vm, hcall_params), 0x0, getpagesize());
 
-		vcpu_args_set(vm, vcpu->id, 2, addr_gva2gpa(vm, hcall_page), hcall_params);
-		vcpu_enable_cap(vm, vcpu->id, &cap);
+		vcpu_args_set(vcpu, 2, addr_gva2gpa(vm, hcall_page), hcall_params);
+		vcpu_enable_cap(vcpu, &cap);
 
-		vcpu_set_hv_cpuid(vm, vcpu->id);
+		vcpu_set_hv_cpuid(vcpu);
 
 		best = kvm_get_supported_hv_cpuid();
 
@@ -651,12 +651,12 @@ static void guest_test_hcalls_access(void)
 		else
 			pr_debug("Stage %d: finish\n", stage);
 
-		vcpu_run(vm, vcpu->id);
+		vcpu_run(vcpu);
 		TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
 			    "unexpected exit reason: %u (%s)",
 			    run->exit_reason, exit_reason_str(run->exit_reason));
 
-		switch (get_ucall(vm, vcpu->id, &uc)) {
+		switch (get_ucall(vcpu, &uc)) {
 		case UCALL_SYNC:
 			TEST_ASSERT(uc.args[1] == 0,
 				    "Unexpected stage: %ld (0 expected)\n",
diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_svm_test.c b/tools/testing/selftests/kvm/x86_64/hyperv_svm_test.c
index 46f1070e7297..02b3e2f3dff3 100644
--- a/tools/testing/selftests/kvm/x86_64/hyperv_svm_test.c
+++ b/tools/testing/selftests/kvm/x86_64/hyperv_svm_test.c
@@ -138,19 +138,19 @@ int main(int argc, char *argv[])
 	}
 	/* Create VM */
 	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
-	vcpu_set_hv_cpuid(vm, vcpu->id);
+	vcpu_set_hv_cpuid(vcpu);
 	run = vcpu->run;
 	vcpu_alloc_svm(vm, &nested_gva);
-	vcpu_args_set(vm, vcpu->id, 1, nested_gva);
+	vcpu_args_set(vcpu, 1, nested_gva);
 
 	for (stage = 1;; stage++) {
-		vcpu_run(vm, vcpu->id);
+		vcpu_run(vcpu);
 		TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
 			    "Stage %d: unexpected exit reason: %u (%s),\n",
 			    stage, run->exit_reason,
 			    exit_reason_str(run->exit_reason));
 
-		switch (get_ucall(vm, vcpu->id, &uc)) {
+		switch (get_ucall(vcpu, &uc)) {
 		case UCALL_ABORT:
 			TEST_FAIL("%s at %s:%ld", (const char *)uc.args[0],
 				  __FILE__, uc.args[1]);
diff --git a/tools/testing/selftests/kvm/x86_64/kvm_clock_test.c b/tools/testing/selftests/kvm/x86_64/kvm_clock_test.c
index 2c1f850c4053..6e3c4bd60b76 100644
--- a/tools/testing/selftests/kvm/x86_64/kvm_clock_test.c
+++ b/tools/testing/selftests/kvm/x86_64/kvm_clock_test.c
@@ -116,14 +116,14 @@ static void enter_guest(struct kvm_vcpu *vcpu)
 
 		vm_ioctl(vm, KVM_GET_CLOCK, &start);
 
-		vcpu_run(vcpu->vm, vcpu->id);
+		vcpu_run(vcpu);
 		vm_ioctl(vm, KVM_GET_CLOCK, &end);
 
 		TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
 			    "unexpected exit reason: %u (%s)",
 			    run->exit_reason, exit_reason_str(run->exit_reason));
 
-		switch (get_ucall(vcpu->vm, vcpu->id, &uc)) {
+		switch (get_ucall(vcpu, &uc)) {
 		case UCALL_SYNC:
 			handle_sync(&uc, &start, &end);
 			break;
@@ -193,7 +193,7 @@ int main(void)
 
 	pvti_gva = vm_vaddr_alloc(vm, getpagesize(), 0x10000);
 	pvti_gpa = addr_gva2gpa(vm, pvti_gva);
-	vcpu_args_set(vm, vcpu->id, 2, pvti_gpa, pvti_gva);
+	vcpu_args_set(vcpu, 2, pvti_gpa, pvti_gva);
 
 	enter_guest(vcpu);
 	kvm_vm_free(vm);
diff --git a/tools/testing/selftests/kvm/x86_64/kvm_pv_test.c b/tools/testing/selftests/kvm/x86_64/kvm_pv_test.c
index cce9016e31a7..79cab212772c 100644
--- a/tools/testing/selftests/kvm/x86_64/kvm_pv_test.c
+++ b/tools/testing/selftests/kvm/x86_64/kvm_pv_test.c
@@ -177,12 +177,12 @@ static void enter_guest(struct kvm_vcpu *vcpu)
 	struct ucall uc;
 
 	while (true) {
-		vcpu_run(vcpu->vm, vcpu->id);
+		vcpu_run(vcpu);
 		TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
 			    "unexpected exit reason: %u (%s)",
 			    run->exit_reason, exit_reason_str(run->exit_reason));
 
-		switch (get_ucall(vcpu->vm, vcpu->id, &uc)) {
+		switch (get_ucall(vcpu, &uc)) {
 		case UCALL_PR_MSR:
 			pr_msr(&uc);
 			break;
@@ -214,14 +214,14 @@ int main(void)
 
 	cap.cap = KVM_CAP_ENFORCE_PV_FEATURE_CPUID;
 	cap.args[0] = 1;
-	vcpu_enable_cap(vm, vcpu->id, &cap);
+	vcpu_enable_cap(vcpu, &cap);
 
 	best = kvm_get_supported_cpuid();
 	clear_kvm_cpuid_features(best);
-	vcpu_set_cpuid(vm, vcpu->id, best);
+	vcpu_set_cpuid(vcpu, best);
 
 	vm_init_descriptor_tables(vm);
-	vcpu_init_descriptor_tables(vm, vcpu->id);
+	vcpu_init_descriptor_tables(vcpu);
 	vm_install_exception_handler(vm, GP_VECTOR, guest_gp_handler);
 
 	enter_guest(vcpu);
diff --git a/tools/testing/selftests/kvm/x86_64/mmu_role_test.c b/tools/testing/selftests/kvm/x86_64/mmu_role_test.c
index 809aa0153cee..62e674095bd2 100644
--- a/tools/testing/selftests/kvm/x86_64/mmu_role_test.c
+++ b/tools/testing/selftests/kvm/x86_64/mmu_role_test.c
@@ -35,7 +35,7 @@ static void mmu_role_test(u32 *cpuid_reg, u32 evil_cpuid_val)
 	/* Map 1gb page without a backing memlot. */
 	__virt_pg_map(vm, MMIO_GPA, MMIO_GPA, X86_PAGE_SIZE_1G);
 
-	vcpu_run(vm, vcpu->id);
+	vcpu_run(vcpu);
 
 	/* Guest access to the 1gb page should trigger MMIO. */
 	TEST_ASSERT(run->exit_reason == KVM_EXIT_MMIO,
@@ -54,7 +54,7 @@ static void mmu_role_test(u32 *cpuid_reg, u32 evil_cpuid_val)
 	 * returns the struct that contains the entry being modified.  Eww.
 	 */
 	*cpuid_reg = evil_cpuid_val;
-	vcpu_set_cpuid(vm, vcpu->id, kvm_get_supported_cpuid());
+	vcpu_set_cpuid(vcpu, kvm_get_supported_cpuid());
 
 	/*
 	 * Add a dummy memslot to coerce KVM into bumping the MMIO generation.
@@ -67,12 +67,12 @@ static void mmu_role_test(u32 *cpuid_reg, u32 evil_cpuid_val)
 
 	/* Set up a #PF handler to eat the RSVD #PF and signal all done! */
 	vm_init_descriptor_tables(vm);
-	vcpu_init_descriptor_tables(vm, vcpu->id);
+	vcpu_init_descriptor_tables(vcpu);
 	vm_install_exception_handler(vm, PF_VECTOR, guest_pf_handler);
 
-	vcpu_run(vm, vcpu->id);
+	vcpu_run(vcpu);
 
-	cmd = get_ucall(vm, vcpu->id, NULL);
+	cmd = get_ucall(vcpu, NULL);
 	TEST_ASSERT(cmd == UCALL_DONE,
 		    "Unexpected guest exit, exit_reason=%s, ucall.cmd = %lu\n",
 		    exit_reason_str(run->exit_reason), cmd);
diff --git a/tools/testing/selftests/kvm/x86_64/platform_info_test.c b/tools/testing/selftests/kvm/x86_64/platform_info_test.c
index 0468a51c05f6..68fb086a8451 100644
--- a/tools/testing/selftests/kvm/x86_64/platform_info_test.c
+++ b/tools/testing/selftests/kvm/x86_64/platform_info_test.c
@@ -50,12 +50,12 @@ static void test_msr_platform_info_enabled(struct kvm_vcpu *vcpu)
 	struct ucall uc;
 
 	set_msr_platform_info_enabled(vcpu->vm, true);
-	vcpu_run(vcpu->vm, vcpu->id);
+	vcpu_run(vcpu);
 	TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
 			"Exit_reason other than KVM_EXIT_IO: %u (%s),\n",
 			run->exit_reason,
 			exit_reason_str(run->exit_reason));
-	get_ucall(vcpu->vm, vcpu->id, &uc);
+	get_ucall(vcpu, &uc);
 	TEST_ASSERT(uc.cmd == UCALL_SYNC,
 			"Received ucall other than UCALL_SYNC: %lu\n", uc.cmd);
 	TEST_ASSERT((uc.args[1] & MSR_PLATFORM_INFO_MAX_TURBO_RATIO) ==
@@ -69,7 +69,7 @@ static void test_msr_platform_info_disabled(struct kvm_vcpu *vcpu)
 	struct kvm_run *run = vcpu->run;
 
 	set_msr_platform_info_enabled(vcpu->vm, false);
-	vcpu_run(vcpu->vm, vcpu->id);
+	vcpu_run(vcpu);
 	TEST_ASSERT(run->exit_reason == KVM_EXIT_SHUTDOWN,
 			"Exit_reason other than KVM_EXIT_SHUTDOWN: %u (%s)\n",
 			run->exit_reason,
@@ -94,12 +94,12 @@ int main(int argc, char *argv[])
 
 	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
 
-	msr_platform_info = vcpu_get_msr(vm, vcpu->id, MSR_PLATFORM_INFO);
-	vcpu_set_msr(vm, vcpu->id, MSR_PLATFORM_INFO,
-		msr_platform_info | MSR_PLATFORM_INFO_MAX_TURBO_RATIO);
+	msr_platform_info = vcpu_get_msr(vcpu, MSR_PLATFORM_INFO);
+	vcpu_set_msr(vcpu, MSR_PLATFORM_INFO,
+		     msr_platform_info | MSR_PLATFORM_INFO_MAX_TURBO_RATIO);
 	test_msr_platform_info_enabled(vcpu);
 	test_msr_platform_info_disabled(vcpu);
-	vcpu_set_msr(vm, vcpu->id, MSR_PLATFORM_INFO, msr_platform_info);
+	vcpu_set_msr(vcpu, MSR_PLATFORM_INFO, msr_platform_info);
 
 	kvm_vm_free(vm);
 
diff --git a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
index e0eed19f669e..592ff0304180 100644
--- a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
+++ b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
@@ -177,12 +177,12 @@ static uint64_t run_vcpu_to_sync(struct kvm_vcpu *vcpu)
 	struct kvm_run *run = vcpu->run;
 	struct ucall uc;
 
-	vcpu_run(vcpu->vm, vcpu->id);
+	vcpu_run(vcpu);
 	TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
 		    "Exit_reason other than KVM_EXIT_IO: %u (%s)\n",
 		    run->exit_reason,
 		    exit_reason_str(run->exit_reason));
-	get_ucall(vcpu->vm, vcpu->id, &uc);
+	get_ucall(vcpu, &uc);
 	TEST_ASSERT(uc.cmd == UCALL_SYNC,
 		    "Received ucall other than UCALL_SYNC: %lu", uc.cmd);
 	return uc.args[1];
@@ -348,7 +348,7 @@ static void test_pmu_config_disable(void (*guest_code)(void))
 
 	vcpu = vm_vcpu_add(vm, 0, guest_code);
 	vm_init_descriptor_tables(vm);
-	vcpu_init_descriptor_tables(vm, vcpu->id);
+	vcpu_init_descriptor_tables(vcpu);
 
 	TEST_ASSERT(!sanity_check_pmu(vcpu),
 		    "Guest should not be able to use disabled PMU.");
@@ -447,7 +447,7 @@ int main(int argc, char *argv[])
 	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
 
 	vm_init_descriptor_tables(vm);
-	vcpu_init_descriptor_tables(vm, vcpu->id);
+	vcpu_init_descriptor_tables(vcpu);
 
 	if (!sanity_check_pmu(vcpu)) {
 		print_skip("Guest PMU is not functional");
diff --git a/tools/testing/selftests/kvm/x86_64/set_boot_cpu_id.c b/tools/testing/selftests/kvm/x86_64/set_boot_cpu_id.c
index b11f12888fad..afc063178c6a 100644
--- a/tools/testing/selftests/kvm/x86_64/set_boot_cpu_id.c
+++ b/tools/testing/selftests/kvm/x86_64/set_boot_cpu_id.c
@@ -49,9 +49,9 @@ static void run_vcpu(struct kvm_vcpu *vcpu)
 
 	for (stage = 0; stage < 2; stage++) {
 
-		vcpu_run(vcpu->vm, vcpu->id);
+		vcpu_run(vcpu);
 
-		switch (get_ucall(vcpu->vm, vcpu->id, &uc)) {
+		switch (get_ucall(vcpu, &uc)) {
 		case UCALL_SYNC:
 			TEST_ASSERT(!strcmp((const char *)uc.args[0], "hello") &&
 					uc.args[1] == stage + 1,
diff --git a/tools/testing/selftests/kvm/x86_64/set_sregs_test.c b/tools/testing/selftests/kvm/x86_64/set_sregs_test.c
index 2e67df3a95ba..dd344439ad33 100644
--- a/tools/testing/selftests/kvm/x86_64/set_sregs_test.c
+++ b/tools/testing/selftests/kvm/x86_64/set_sregs_test.c
@@ -35,11 +35,11 @@ static void test_cr4_feature_bit(struct kvm_vcpu *vcpu, struct kvm_sregs *orig,
 	memcpy(&sregs, orig, sizeof(sregs));
 	sregs.cr4 |= feature_bit;
 
-	rc = _vcpu_sregs_set(vcpu->vm, vcpu->id, &sregs);
+	rc = _vcpu_sregs_set(vcpu, &sregs);
 	TEST_ASSERT(rc, "KVM allowed unsupported CR4 bit (0x%lx)", feature_bit);
 
 	/* Sanity check that KVM didn't change anything. */
-	vcpu_sregs_get(vcpu->vm, vcpu->id, &sregs);
+	vcpu_sregs_get(vcpu, &sregs);
 	TEST_ASSERT(!memcmp(&sregs, orig, sizeof(sregs)), "KVM modified sregs");
 }
 
@@ -97,15 +97,15 @@ int main(int argc, char *argv[])
 	vm = vm_create_barebones();
 	vcpu = __vm_vcpu_add(vm, 0);
 
-	vcpu_sregs_get(vm, vcpu->id, &sregs);
+	vcpu_sregs_get(vcpu, &sregs);
 
 	sregs.cr4 |= calc_cr4_feature_bits(vm);
 	cr4 = sregs.cr4;
 
-	rc = _vcpu_sregs_set(vm, vcpu->id, &sregs);
+	rc = _vcpu_sregs_set(vcpu, &sregs);
 	TEST_ASSERT(!rc, "Failed to set supported CR4 bits (0x%lx)", cr4);
 
-	vcpu_sregs_get(vm, vcpu->id, &sregs);
+	vcpu_sregs_get(vcpu, &sregs);
 	TEST_ASSERT(sregs.cr4 == cr4, "sregs.CR4 (0x%llx) != CR4 (0x%lx)",
 		    sregs.cr4, cr4);
 
@@ -125,13 +125,13 @@ int main(int argc, char *argv[])
 	/* Create a "real" VM and verify APIC_BASE can be set. */
 	vm = vm_create_with_one_vcpu(&vcpu, NULL);
 
-	vcpu_sregs_get(vm, vcpu->id, &sregs);
+	vcpu_sregs_get(vcpu, &sregs);
 	sregs.apic_base = 1 << 10;
-	rc = _vcpu_sregs_set(vm, vcpu->id, &sregs);
+	rc = _vcpu_sregs_set(vcpu, &sregs);
 	TEST_ASSERT(rc, "Set IA32_APIC_BASE to %llx (invalid)",
 		    sregs.apic_base);
 	sregs.apic_base = 1 << 11;
-	rc = _vcpu_sregs_set(vm, vcpu->id, &sregs);
+	rc = _vcpu_sregs_set(vcpu, &sregs);
 	TEST_ASSERT(!rc, "Couldn't set IA32_APIC_BASE to %llx (valid)",
 		    sregs.apic_base);
 
diff --git a/tools/testing/selftests/kvm/x86_64/smm_test.c b/tools/testing/selftests/kvm/x86_64/smm_test.c
index 36165b774a28..3cd1da388b52 100644
--- a/tools/testing/selftests/kvm/x86_64/smm_test.c
+++ b/tools/testing/selftests/kvm/x86_64/smm_test.c
@@ -118,12 +118,12 @@ void inject_smi(struct kvm_vcpu *vcpu)
 {
 	struct kvm_vcpu_events events;
 
-	vcpu_events_get(vcpu->vm, vcpu->id, &events);
+	vcpu_events_get(vcpu, &events);
 
 	events.smi.pending = 1;
 	events.flags |= KVM_VCPUEVENT_VALID_SMM;
 
-	vcpu_events_set(vcpu->vm, vcpu->id, &events);
+	vcpu_events_set(vcpu, &events);
 }
 
 int main(int argc, char *argv[])
@@ -151,7 +151,7 @@ int main(int argc, char *argv[])
 	memcpy(addr_gpa2hva(vm, SMRAM_GPA) + 0x8000, smi_handler,
 	       sizeof(smi_handler));
 
-	vcpu_set_msr(vm, vcpu->id, MSR_IA32_SMBASE, SMRAM_GPA);
+	vcpu_set_msr(vcpu, MSR_IA32_SMBASE, SMRAM_GPA);
 
 	if (kvm_check_cap(KVM_CAP_NESTED_STATE)) {
 		if (nested_svm_supported())
@@ -163,17 +163,17 @@ int main(int argc, char *argv[])
 	if (!nested_gva)
 		pr_info("will skip SMM test with VMX enabled\n");
 
-	vcpu_args_set(vm, vcpu->id, 1, nested_gva);
+	vcpu_args_set(vcpu, 1, nested_gva);
 
 	for (stage = 1;; stage++) {
-		vcpu_run(vm, vcpu->id);
+		vcpu_run(vcpu);
 		TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
 			    "Stage %d: unexpected exit reason: %u (%s),\n",
 			    stage, run->exit_reason,
 			    exit_reason_str(run->exit_reason));
 
 		memset(&regs, 0, sizeof(regs));
-		vcpu_regs_get(vm, vcpu->id, &regs);
+		vcpu_regs_get(vcpu, &regs);
 
 		stage_reported = regs.rax & 0xff;
 
@@ -201,12 +201,12 @@ int main(int argc, char *argv[])
 		if (stage == 10)
 			inject_smi(vcpu);
 
-		state = vcpu_save_state(vm, vcpu->id);
+		state = vcpu_save_state(vcpu);
 		kvm_vm_release(vm);
 
 		vcpu = vm_recreate_with_one_vcpu(vm);
-		vcpu_set_cpuid(vm, vcpu->id, kvm_get_supported_cpuid());
-		vcpu_load_state(vm, vcpu->id, state);
+		vcpu_set_cpuid(vcpu, kvm_get_supported_cpuid());
+		vcpu_load_state(vcpu, state);
 		run = vcpu->run;
 		kvm_x86_state_cleanup(state);
 	}
diff --git a/tools/testing/selftests/kvm/x86_64/state_test.c b/tools/testing/selftests/kvm/x86_64/state_test.c
index b7869efad22a..0bcd78cf7c79 100644
--- a/tools/testing/selftests/kvm/x86_64/state_test.c
+++ b/tools/testing/selftests/kvm/x86_64/state_test.c
@@ -167,7 +167,7 @@ int main(int argc, char *argv[])
 	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
 	run = vcpu->run;
 
-	vcpu_regs_get(vm, vcpu->id, &regs1);
+	vcpu_regs_get(vcpu, &regs1);
 
 	if (kvm_check_cap(KVM_CAP_NESTED_STATE)) {
 		if (nested_svm_supported())
@@ -179,16 +179,16 @@ int main(int argc, char *argv[])
 	if (!nested_gva)
 		pr_info("will skip nested state checks\n");
 
-	vcpu_args_set(vm, vcpu->id, 1, nested_gva);
+	vcpu_args_set(vcpu, 1, nested_gva);
 
 	for (stage = 1;; stage++) {
-		vcpu_run(vm, vcpu->id);
+		vcpu_run(vcpu);
 		TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
 			    "Stage %d: unexpected exit reason: %u (%s),\n",
 			    stage, run->exit_reason,
 			    exit_reason_str(run->exit_reason));
 
-		switch (get_ucall(vm, vcpu->id, &uc)) {
+		switch (get_ucall(vcpu, &uc)) {
 		case UCALL_ABORT:
 			TEST_FAIL("%s at %s:%ld", (const char *)uc.args[0],
 			       	  __FILE__, uc.args[1]);
@@ -206,21 +206,21 @@ int main(int argc, char *argv[])
 			    uc.args[1] == stage, "Stage %d: Unexpected register values vmexit, got %lx",
 			    stage, (ulong)uc.args[1]);
 
-		state = vcpu_save_state(vm, vcpu->id);
+		state = vcpu_save_state(vcpu);
 		memset(&regs1, 0, sizeof(regs1));
-		vcpu_regs_get(vm, vcpu->id, &regs1);
+		vcpu_regs_get(vcpu, &regs1);
 
 		kvm_vm_release(vm);
 
 		/* Restore state in a new VM.  */
 		vcpu = vm_recreate_with_one_vcpu(vm);
-		vcpu_set_cpuid(vm, vcpu->id, kvm_get_supported_cpuid());
-		vcpu_load_state(vm, vcpu->id, state);
+		vcpu_set_cpuid(vcpu, kvm_get_supported_cpuid());
+		vcpu_load_state(vcpu, state);
 		run = vcpu->run;
 		kvm_x86_state_cleanup(state);
 
 		memset(&regs2, 0, sizeof(regs2));
-		vcpu_regs_get(vm, vcpu->id, &regs2);
+		vcpu_regs_get(vcpu, &regs2);
 		TEST_ASSERT(!memcmp(&regs1, &regs2, sizeof(regs2)),
 			    "Unexpected register values after vcpu_load_state; rdi: %lx rsi: %lx",
 			    (ulong) regs2.rdi, (ulong) regs2.rsi);
diff --git a/tools/testing/selftests/kvm/x86_64/svm_int_ctl_test.c b/tools/testing/selftests/kvm/x86_64/svm_int_ctl_test.c
index 8e90e463895a..9c68a47b69e1 100644
--- a/tools/testing/selftests/kvm/x86_64/svm_int_ctl_test.c
+++ b/tools/testing/selftests/kvm/x86_64/svm_int_ctl_test.c
@@ -95,23 +95,23 @@ int main(int argc, char *argv[])
 	vm = vm_create_with_one_vcpu(&vcpu, l1_guest_code);
 
 	vm_init_descriptor_tables(vm);
-	vcpu_init_descriptor_tables(vm, vcpu->id);
+	vcpu_init_descriptor_tables(vcpu);
 
 	vm_install_exception_handler(vm, VINTR_IRQ_NUMBER, vintr_irq_handler);
 	vm_install_exception_handler(vm, INTR_IRQ_NUMBER, intr_irq_handler);
 
 	vcpu_alloc_svm(vm, &svm_gva);
-	vcpu_args_set(vm, vcpu->id, 1, svm_gva);
+	vcpu_args_set(vcpu, 1, svm_gva);
 
 	run = vcpu->run;
 
-	vcpu_run(vm, vcpu->id);
+	vcpu_run(vcpu);
 	TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
 		    "Got exit_reason other than KVM_EXIT_IO: %u (%s)\n",
 		    run->exit_reason,
 		    exit_reason_str(run->exit_reason));
 
-	switch (get_ucall(vm, vcpu->id, &uc)) {
+	switch (get_ucall(vcpu, &uc)) {
 	case UCALL_ABORT:
 		TEST_FAIL("%s", (const char *)uc.args[0]);
 		break;
diff --git a/tools/testing/selftests/kvm/x86_64/svm_vmcall_test.c b/tools/testing/selftests/kvm/x86_64/svm_vmcall_test.c
index 15e389a7cd31..e6d7191866a5 100644
--- a/tools/testing/selftests/kvm/x86_64/svm_vmcall_test.c
+++ b/tools/testing/selftests/kvm/x86_64/svm_vmcall_test.c
@@ -44,19 +44,19 @@ int main(int argc, char *argv[])
 	vm = vm_create_with_one_vcpu(&vcpu, l1_guest_code);
 
 	vcpu_alloc_svm(vm, &svm_gva);
-	vcpu_args_set(vm, vcpu->id, 1, svm_gva);
+	vcpu_args_set(vcpu, 1, svm_gva);
 
 	for (;;) {
 		volatile struct kvm_run *run = vcpu->run;
 		struct ucall uc;
 
-		vcpu_run(vm, vcpu->id);
+		vcpu_run(vcpu);
 		TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
 			    "Got exit_reason other than KVM_EXIT_IO: %u (%s)\n",
 			    run->exit_reason,
 			    exit_reason_str(run->exit_reason));
 
-		switch (get_ucall(vm, vcpu->id, &uc)) {
+		switch (get_ucall(vcpu, &uc)) {
 		case UCALL_ABORT:
 			TEST_FAIL("%s", (const char *)uc.args[0]);
 			/* NOT REACHED */
diff --git a/tools/testing/selftests/kvm/x86_64/sync_regs_test.c b/tools/testing/selftests/kvm/x86_64/sync_regs_test.c
index c971706b49f5..773db9d4f228 100644
--- a/tools/testing/selftests/kvm/x86_64/sync_regs_test.c
+++ b/tools/testing/selftests/kvm/x86_64/sync_regs_test.c
@@ -109,14 +109,14 @@ int main(int argc, char *argv[])
 
 	/* Request reading invalid register set from VCPU. */
 	run->kvm_valid_regs = INVALID_SYNC_FIELD;
-	rv = _vcpu_run(vm, vcpu->id);
+	rv = _vcpu_run(vcpu);
 	TEST_ASSERT(rv < 0 && errno == EINVAL,
 		    "Invalid kvm_valid_regs did not cause expected KVM_RUN error: %d\n",
 		    rv);
 	run->kvm_valid_regs = 0;
 
 	run->kvm_valid_regs = INVALID_SYNC_FIELD | TEST_SYNC_FIELDS;
-	rv = _vcpu_run(vm, vcpu->id);
+	rv = _vcpu_run(vcpu);
 	TEST_ASSERT(rv < 0 && errno == EINVAL,
 		    "Invalid kvm_valid_regs did not cause expected KVM_RUN error: %d\n",
 		    rv);
@@ -124,14 +124,14 @@ int main(int argc, char *argv[])
 
 	/* Request setting invalid register set into VCPU. */
 	run->kvm_dirty_regs = INVALID_SYNC_FIELD;
-	rv = _vcpu_run(vm, vcpu->id);
+	rv = _vcpu_run(vcpu);
 	TEST_ASSERT(rv < 0 && errno == EINVAL,
 		    "Invalid kvm_dirty_regs did not cause expected KVM_RUN error: %d\n",
 		    rv);
 	run->kvm_dirty_regs = 0;
 
 	run->kvm_dirty_regs = INVALID_SYNC_FIELD | TEST_SYNC_FIELDS;
-	rv = _vcpu_run(vm, vcpu->id);
+	rv = _vcpu_run(vcpu);
 	TEST_ASSERT(rv < 0 && errno == EINVAL,
 		    "Invalid kvm_dirty_regs did not cause expected KVM_RUN error: %d\n",
 		    rv);
@@ -140,19 +140,19 @@ int main(int argc, char *argv[])
 	/* Request and verify all valid register sets. */
 	/* TODO: BUILD TIME CHECK: TEST_ASSERT(KVM_SYNC_X86_NUM_FIELDS != 3); */
 	run->kvm_valid_regs = TEST_SYNC_FIELDS;
-	rv = _vcpu_run(vm, vcpu->id);
+	rv = _vcpu_run(vcpu);
 	TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
 		    "Unexpected exit reason: %u (%s),\n",
 		    run->exit_reason,
 		    exit_reason_str(run->exit_reason));
 
-	vcpu_regs_get(vm, vcpu->id, &regs);
+	vcpu_regs_get(vcpu, &regs);
 	compare_regs(&regs, &run->s.regs.regs);
 
-	vcpu_sregs_get(vm, vcpu->id, &sregs);
+	vcpu_sregs_get(vcpu, &sregs);
 	compare_sregs(&sregs, &run->s.regs.sregs);
 
-	vcpu_events_get(vm, vcpu->id, &events);
+	vcpu_events_get(vcpu, &events);
 	compare_vcpu_events(&events, &run->s.regs.events);
 
 	/* Set and verify various register values. */
@@ -162,7 +162,7 @@ int main(int argc, char *argv[])
 
 	run->kvm_valid_regs = TEST_SYNC_FIELDS;
 	run->kvm_dirty_regs = KVM_SYNC_X86_REGS | KVM_SYNC_X86_SREGS;
-	rv = _vcpu_run(vm, vcpu->id);
+	rv = _vcpu_run(vcpu);
 	TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
 		    "Unexpected exit reason: %u (%s),\n",
 		    run->exit_reason,
@@ -174,13 +174,13 @@ int main(int argc, char *argv[])
 		    "apic_base sync regs value incorrect 0x%llx.",
 		    run->s.regs.sregs.apic_base);
 
-	vcpu_regs_get(vm, vcpu->id, &regs);
+	vcpu_regs_get(vcpu, &regs);
 	compare_regs(&regs, &run->s.regs.regs);
 
-	vcpu_sregs_get(vm, vcpu->id, &sregs);
+	vcpu_sregs_get(vcpu, &sregs);
 	compare_sregs(&sregs, &run->s.regs.sregs);
 
-	vcpu_events_get(vm, vcpu->id, &events);
+	vcpu_events_get(vcpu, &events);
 	compare_vcpu_events(&events, &run->s.regs.events);
 
 	/* Clear kvm_dirty_regs bits, verify new s.regs values are
@@ -189,7 +189,7 @@ int main(int argc, char *argv[])
 	run->kvm_valid_regs = TEST_SYNC_FIELDS;
 	run->kvm_dirty_regs = 0;
 	run->s.regs.regs.rbx = 0xDEADBEEF;
-	rv = _vcpu_run(vm, vcpu->id);
+	rv = _vcpu_run(vcpu);
 	TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
 		    "Unexpected exit reason: %u (%s),\n",
 		    run->exit_reason,
@@ -206,8 +206,8 @@ int main(int argc, char *argv[])
 	run->kvm_dirty_regs = 0;
 	run->s.regs.regs.rbx = 0xAAAA;
 	regs.rbx = 0xBAC0;
-	vcpu_regs_set(vm, vcpu->id, &regs);
-	rv = _vcpu_run(vm, vcpu->id);
+	vcpu_regs_set(vcpu, &regs);
+	rv = _vcpu_run(vcpu);
 	TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
 		    "Unexpected exit reason: %u (%s),\n",
 		    run->exit_reason,
@@ -215,7 +215,7 @@ int main(int argc, char *argv[])
 	TEST_ASSERT(run->s.regs.regs.rbx == 0xAAAA,
 		    "rbx sync regs value incorrect 0x%llx.",
 		    run->s.regs.regs.rbx);
-	vcpu_regs_get(vm, vcpu->id, &regs);
+	vcpu_regs_get(vcpu, &regs);
 	TEST_ASSERT(regs.rbx == 0xBAC0 + 1,
 		    "rbx guest value incorrect 0x%llx.",
 		    regs.rbx);
@@ -227,7 +227,7 @@ int main(int argc, char *argv[])
 	run->kvm_valid_regs = 0;
 	run->kvm_dirty_regs = TEST_SYNC_FIELDS;
 	run->s.regs.regs.rbx = 0xBBBB;
-	rv = _vcpu_run(vm, vcpu->id);
+	rv = _vcpu_run(vcpu);
 	TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
 		    "Unexpected exit reason: %u (%s),\n",
 		    run->exit_reason,
@@ -235,7 +235,7 @@ int main(int argc, char *argv[])
 	TEST_ASSERT(run->s.regs.regs.rbx == 0xBBBB,
 		    "rbx sync regs value incorrect 0x%llx.",
 		    run->s.regs.regs.rbx);
-	vcpu_regs_get(vm, vcpu->id, &regs);
+	vcpu_regs_get(vcpu, &regs);
 	TEST_ASSERT(regs.rbx == 0xBBBB + 1,
 		    "rbx guest value incorrect 0x%llx.",
 		    regs.rbx);
diff --git a/tools/testing/selftests/kvm/x86_64/tsc_msrs_test.c b/tools/testing/selftests/kvm/x86_64/tsc_msrs_test.c
index 3b7bf660eced..3165d3f7e065 100644
--- a/tools/testing/selftests/kvm/x86_64/tsc_msrs_test.c
+++ b/tools/testing/selftests/kvm/x86_64/tsc_msrs_test.c
@@ -14,7 +14,7 @@
 #define GUEST_STEP             (UNITY * 4)
 #define ROUND(x)               ((x + UNITY / 2) & -UNITY)
 #define rounded_rdmsr(x)       ROUND(rdmsr(x))
-#define rounded_host_rdmsr(x)  ROUND(vcpu_get_msr(vm, vcpu->id, x))
+#define rounded_host_rdmsr(x)  ROUND(vcpu_get_msr(vcpu, x))
 
 static void guest_code(void)
 {
@@ -68,9 +68,9 @@ static void run_vcpu(struct kvm_vcpu *vcpu, int stage)
 {
 	struct ucall uc;
 
-	vcpu_run(vcpu->vm, vcpu->id);
+	vcpu_run(vcpu);
 
-	switch (get_ucall(vcpu->vm, vcpu->id, &uc)) {
+	switch (get_ucall(vcpu, &uc)) {
 	case UCALL_SYNC:
 		TEST_ASSERT(!strcmp((const char *)uc.args[0], "hello") &&
 			    uc.args[1] == stage + 1, "Stage %d: Unexpected register values vmexit, got %lx",
@@ -116,18 +116,18 @@ int main(void)
 	 * Host: writes to MSR_IA32_TSC set the host-side offset
 	 * and therefore do not change MSR_IA32_TSC_ADJUST.
 	 */
-	vcpu_set_msr(vm, vcpu->id, MSR_IA32_TSC, HOST_ADJUST + val);
+	vcpu_set_msr(vcpu, MSR_IA32_TSC, HOST_ADJUST + val);
 	ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC), HOST_ADJUST + val);
 	ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC_ADJUST), val);
 	run_vcpu(vcpu, 3);
 
 	/* Host: writes to MSR_IA32_TSC_ADJUST do not modify the TSC.  */
-	vcpu_set_msr(vm, vcpu->id, MSR_IA32_TSC_ADJUST, UNITY * 123456);
+	vcpu_set_msr(vcpu, MSR_IA32_TSC_ADJUST, UNITY * 123456);
 	ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC), HOST_ADJUST + val);
-	ASSERT_EQ(vcpu_get_msr(vm, vcpu->id, MSR_IA32_TSC_ADJUST), UNITY * 123456);
+	ASSERT_EQ(vcpu_get_msr(vcpu, MSR_IA32_TSC_ADJUST), UNITY * 123456);
 
 	/* Restore previous value.  */
-	vcpu_set_msr(vm, vcpu->id, MSR_IA32_TSC_ADJUST, val);
+	vcpu_set_msr(vcpu, MSR_IA32_TSC_ADJUST, val);
 	ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC), HOST_ADJUST + val);
 	ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC_ADJUST), val);
 
diff --git a/tools/testing/selftests/kvm/x86_64/tsc_scaling_sync.c b/tools/testing/selftests/kvm/x86_64/tsc_scaling_sync.c
index 728b252597cc..e416af887ca0 100644
--- a/tools/testing/selftests/kvm/x86_64/tsc_scaling_sync.c
+++ b/tools/testing/selftests/kvm/x86_64/tsc_scaling_sync.c
@@ -58,7 +58,7 @@ static void *run_vcpu(void *_cpu_nr)
 
 	if (!first_cpu_done) {
 		first_cpu_done = true;
-		vcpu_set_msr(vm, vcpu->id, MSR_IA32_TSC, TEST_TSC_OFFSET);
+		vcpu_set_msr(vcpu, MSR_IA32_TSC, TEST_TSC_OFFSET);
 	}
 
 	pthread_spin_unlock(&create_lock);
@@ -67,13 +67,13 @@ static void *run_vcpu(void *_cpu_nr)
 		volatile struct kvm_run *run = vcpu->run;
                 struct ucall uc;
 
-		vcpu_run(vm, vcpu->id);
+		vcpu_run(vcpu);
                 TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
                             "Got exit_reason other than KVM_EXIT_IO: %u (%s)\n",
                             run->exit_reason,
                             exit_reason_str(run->exit_reason));
 
-		switch (get_ucall(vm, vcpu->id, &uc)) {
+		switch (get_ucall(vcpu, &uc)) {
                 case UCALL_DONE:
 			goto out;
 
diff --git a/tools/testing/selftests/kvm/x86_64/userspace_io_test.c b/tools/testing/selftests/kvm/x86_64/userspace_io_test.c
index 0ba774ed6476..7538d57a41d5 100644
--- a/tools/testing/selftests/kvm/x86_64/userspace_io_test.c
+++ b/tools/testing/selftests/kvm/x86_64/userspace_io_test.c
@@ -65,14 +65,14 @@ int main(int argc, char *argv[])
 	memset(&regs, 0, sizeof(regs));
 
 	while (1) {
-		vcpu_run(vm, vcpu->id);
+		vcpu_run(vcpu);
 
 		TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
 			    "Unexpected exit reason: %u (%s),\n",
 			    run->exit_reason,
 			    exit_reason_str(run->exit_reason));
 
-		if (get_ucall(vm, vcpu->id, &uc))
+		if (get_ucall(vcpu, &uc))
 			break;
 
 		TEST_ASSERT(run->io.port == 0x80,
@@ -85,13 +85,13 @@ int main(int argc, char *argv[])
 		 * scope from a testing perspective as it's not ABI in any way,
 		 * i.e. it really is abusing internal KVM knowledge.
 		 */
-		vcpu_regs_get(vm, vcpu->id, &regs);
+		vcpu_regs_get(vcpu, &regs);
 		if (regs.rcx == 2)
 			regs.rcx = 1;
 		if (regs.rcx == 3)
 			regs.rcx = 8192;
 		memset((void *)run + run->io.data_offset, 0xaa, 4096);
-		vcpu_regs_set(vm, vcpu->id, &regs);
+		vcpu_regs_set(vcpu, &regs);
 	}
 
 	switch (uc.cmd) {
diff --git a/tools/testing/selftests/kvm/x86_64/userspace_msr_exit_test.c b/tools/testing/selftests/kvm/x86_64/userspace_msr_exit_test.c
index e261c50fac5c..bdb898e751fe 100644
--- a/tools/testing/selftests/kvm/x86_64/userspace_msr_exit_test.c
+++ b/tools/testing/selftests/kvm/x86_64/userspace_msr_exit_test.c
@@ -399,7 +399,7 @@ static void check_for_guest_assert(struct kvm_vcpu *vcpu)
 	struct ucall uc;
 
 	if (vcpu->run->exit_reason == KVM_EXIT_IO &&
-	    get_ucall(vcpu->vm, vcpu->id, &uc) == UCALL_ABORT) {
+	    get_ucall(vcpu, &uc) == UCALL_ABORT) {
 		TEST_FAIL("%s at %s:%ld",
 			  (const char *)uc.args[0], __FILE__, uc.args[1]);
 	}
@@ -483,7 +483,7 @@ static void process_ucall_done(struct kvm_vcpu *vcpu)
 		    run->exit_reason,
 		    exit_reason_str(run->exit_reason));
 
-	TEST_ASSERT(get_ucall(vcpu->vm, vcpu->id, &uc) == UCALL_DONE,
+	TEST_ASSERT(get_ucall(vcpu, &uc) == UCALL_DONE,
 		    "Unexpected ucall command: %lu, expected UCALL_DONE (%d)",
 		    uc.cmd, UCALL_DONE);
 }
@@ -500,7 +500,7 @@ static uint64_t process_ucall(struct kvm_vcpu *vcpu)
 		    run->exit_reason,
 		    exit_reason_str(run->exit_reason));
 
-	switch (get_ucall(vcpu->vm, vcpu->id, &uc)) {
+	switch (get_ucall(vcpu, &uc)) {
 	case UCALL_SYNC:
 		break;
 	case UCALL_ABORT:
@@ -519,26 +519,26 @@ static uint64_t process_ucall(struct kvm_vcpu *vcpu)
 static void run_guest_then_process_rdmsr(struct kvm_vcpu *vcpu,
 					 uint32_t msr_index)
 {
-	vcpu_run(vcpu->vm, vcpu->id);
+	vcpu_run(vcpu);
 	process_rdmsr(vcpu, msr_index);
 }
 
 static void run_guest_then_process_wrmsr(struct kvm_vcpu *vcpu,
 					 uint32_t msr_index)
 {
-	vcpu_run(vcpu->vm, vcpu->id);
+	vcpu_run(vcpu);
 	process_wrmsr(vcpu, msr_index);
 }
 
 static uint64_t run_guest_then_process_ucall(struct kvm_vcpu *vcpu)
 {
-	vcpu_run(vcpu->vm, vcpu->id);
+	vcpu_run(vcpu);
 	return process_ucall(vcpu);
 }
 
 static void run_guest_then_process_ucall_done(struct kvm_vcpu *vcpu)
 {
-	vcpu_run(vcpu->vm, vcpu->id);
+	vcpu_run(vcpu);
 	process_ucall_done(vcpu);
 }
 
@@ -564,7 +564,7 @@ static void test_msr_filter_allow(void)
 	vm_ioctl(vm, KVM_X86_SET_MSR_FILTER, &filter_allow);
 
 	vm_init_descriptor_tables(vm);
-	vcpu_init_descriptor_tables(vm, vcpu->id);
+	vcpu_init_descriptor_tables(vcpu);
 
 	vm_install_exception_handler(vm, GP_VECTOR, guest_gp_handler);
 
@@ -581,7 +581,7 @@ static void test_msr_filter_allow(void)
 	run_guest_then_process_rdmsr(vcpu, MSR_NON_EXISTENT);
 
 	vm_install_exception_handler(vm, UD_VECTOR, guest_ud_handler);
-	vcpu_run(vm, vcpu->id);
+	vcpu_run(vcpu);
 	vm_install_exception_handler(vm, UD_VECTOR, NULL);
 
 	if (process_ucall(vcpu) != UCALL_DONE) {
@@ -612,7 +612,7 @@ static int handle_ucall(struct kvm_vcpu *vcpu)
 {
 	struct ucall uc;
 
-	switch (get_ucall(vcpu->vm, vcpu->id, &uc)) {
+	switch (get_ucall(vcpu, &uc)) {
 	case UCALL_ABORT:
 		TEST_FAIL("Guest assertion not met");
 		break;
@@ -692,7 +692,7 @@ static void test_msr_filter_deny(void)
 	vm_ioctl(vm, KVM_X86_SET_MSR_FILTER, &filter_deny);
 
 	while (1) {
-		vcpu_run(vm, vcpu->id);
+		vcpu_run(vcpu);
 
 		switch (run->exit_reason) {
 		case KVM_EXIT_X86_RDMSR:
diff --git a/tools/testing/selftests/kvm/x86_64/vmx_apic_access_test.c b/tools/testing/selftests/kvm/x86_64/vmx_apic_access_test.c
index 10f9c86029e6..ef7514376b1e 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_apic_access_test.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_apic_access_test.c
@@ -95,13 +95,13 @@ int main(int argc, char *argv[])
 
 	vmx = vcpu_alloc_vmx(vm, &vmx_pages_gva);
 	prepare_virtualize_apic_accesses(vmx, vm);
-	vcpu_args_set(vm, vcpu->id, 2, vmx_pages_gva, high_gpa);
+	vcpu_args_set(vcpu, 2, vmx_pages_gva, high_gpa);
 
 	while (!done) {
 		volatile struct kvm_run *run = vcpu->run;
 		struct ucall uc;
 
-		vcpu_run(vm, vcpu->id);
+		vcpu_run(vcpu);
 		if (apic_access_addr == high_gpa) {
 			TEST_ASSERT(run->exit_reason ==
 				    KVM_EXIT_INTERNAL_ERROR,
@@ -119,7 +119,7 @@ int main(int argc, char *argv[])
 			    run->exit_reason,
 			    exit_reason_str(run->exit_reason));
 
-		switch (get_ucall(vm, vcpu->id, &uc)) {
+		switch (get_ucall(vcpu, &uc)) {
 		case UCALL_ABORT:
 			TEST_FAIL("%s at %s:%ld", (const char *)uc.args[0],
 				  __FILE__, uc.args[1]);
diff --git a/tools/testing/selftests/kvm/x86_64/vmx_close_while_nested_test.c b/tools/testing/selftests/kvm/x86_64/vmx_close_while_nested_test.c
index da0363076fba..40c77bb706a1 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_close_while_nested_test.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_close_while_nested_test.c
@@ -57,13 +57,13 @@ int main(int argc, char *argv[])
 
 	/* Allocate VMX pages and shared descriptors (vmx_pages). */
 	vcpu_alloc_vmx(vm, &vmx_pages_gva);
-	vcpu_args_set(vm, vcpu->id, 1, vmx_pages_gva);
+	vcpu_args_set(vcpu, 1, vmx_pages_gva);
 
 	for (;;) {
 		volatile struct kvm_run *run = vcpu->run;
 		struct ucall uc;
 
-		vcpu_run(vm, vcpu->id);
+		vcpu_run(vcpu);
 		TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
 			    "Got exit_reason other than KVM_EXIT_IO: %u (%s)\n",
 			    run->exit_reason,
@@ -72,7 +72,7 @@ int main(int argc, char *argv[])
 		if (run->io.port == PORT_L0_EXIT)
 			break;
 
-		switch (get_ucall(vm, vcpu->id, &uc)) {
+		switch (get_ucall(vcpu, &uc)) {
 		case UCALL_ABORT:
 			TEST_FAIL("%s", (const char *)uc.args[0]);
 			/* NOT REACHED */
diff --git a/tools/testing/selftests/kvm/x86_64/vmx_dirty_log_test.c b/tools/testing/selftests/kvm/x86_64/vmx_dirty_log_test.c
index fb8c7f7236f7..215ffa0589d4 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_dirty_log_test.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_dirty_log_test.c
@@ -82,7 +82,7 @@ int main(int argc, char *argv[])
 	/* Create VM */
 	vm = vm_create_with_one_vcpu(&vcpu, l1_guest_code);
 	vmx = vcpu_alloc_vmx(vm, &vmx_pages_gva);
-	vcpu_args_set(vm, vcpu->id, 1, vmx_pages_gva);
+	vcpu_args_set(vcpu, 1, vmx_pages_gva);
 	run = vcpu->run;
 
 	/* Add an extra memory slot for testing dirty logging */
@@ -115,13 +115,13 @@ int main(int argc, char *argv[])
 
 	while (!done) {
 		memset(host_test_mem, 0xaa, TEST_MEM_PAGES * 4096);
-		vcpu_run(vm, vcpu->id);
+		vcpu_run(vcpu);
 		TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
 			    "Unexpected exit reason: %u (%s),\n",
 			    run->exit_reason,
 			    exit_reason_str(run->exit_reason));
 
-		switch (get_ucall(vm, vcpu->id, &uc)) {
+		switch (get_ucall(vcpu, &uc)) {
 		case UCALL_ABORT:
 			TEST_FAIL("%s at %s:%ld", (const char *)uc.args[0],
 			       	  __FILE__, uc.args[1]);
diff --git a/tools/testing/selftests/kvm/x86_64/vmx_exception_with_invalid_guest_state.c b/tools/testing/selftests/kvm/x86_64/vmx_exception_with_invalid_guest_state.c
index 70b30583e50d..5bc2cee0d613 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_exception_with_invalid_guest_state.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_exception_with_invalid_guest_state.c
@@ -24,7 +24,7 @@ static void __run_vcpu_with_invalid_state(struct kvm_vcpu *vcpu)
 {
 	struct kvm_run *run = vcpu->run;
 
-	vcpu_run(vcpu->vm, vcpu->id);
+	vcpu_run(vcpu);
 
 	TEST_ASSERT(run->exit_reason == KVM_EXIT_INTERNAL_ERROR,
 		    "Expected KVM_EXIT_INTERNAL_ERROR, got %d (%s)\n",
@@ -60,9 +60,9 @@ static void set_or_clear_invalid_guest_state(struct kvm_vcpu *vcpu, bool set)
 	static struct kvm_sregs sregs;
 
 	if (!sregs.cr0)
-		vcpu_sregs_get(vcpu->vm, vcpu->id, &sregs);
+		vcpu_sregs_get(vcpu, &sregs);
 	sregs.tr.unusable = !!set;
-	vcpu_sregs_set(vcpu->vm, vcpu->id, &sregs);
+	vcpu_sregs_set(vcpu, &sregs);
 }
 
 static void set_invalid_guest_state(struct kvm_vcpu *vcpu)
@@ -91,7 +91,7 @@ static void sigalrm_handler(int sig)
 
 	TEST_ASSERT(sig == SIGALRM, "Unexpected signal = %d", sig);
 
-	vcpu_events_get(vcpu->vm, vcpu->id, &events);
+	vcpu_events_get(vcpu, &events);
 
 	/*
 	 * If an exception is pending, attempt KVM_RUN with invalid guest,
@@ -120,7 +120,7 @@ int main(int argc, char *argv[])
 	get_set_sigalrm_vcpu(vcpu);
 
 	vm_init_descriptor_tables(vm);
-	vcpu_init_descriptor_tables(vm, vcpu->id);
+	vcpu_init_descriptor_tables(vcpu);
 
 	vm_install_exception_handler(vm, UD_VECTOR, guest_ud_handler);
 
diff --git a/tools/testing/selftests/kvm/x86_64/vmx_invalid_nested_guest_state.c b/tools/testing/selftests/kvm/x86_64/vmx_invalid_nested_guest_state.c
index ba534be498f9..683f4f0a1616 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_invalid_nested_guest_state.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_invalid_nested_guest_state.c
@@ -64,9 +64,9 @@ int main(int argc, char *argv[])
 
 	/* Allocate VMX pages and shared descriptors (vmx_pages). */
 	vcpu_alloc_vmx(vm, &vmx_pages_gva);
-	vcpu_args_set(vm, vcpu->id, 1, vmx_pages_gva);
+	vcpu_args_set(vcpu, 1, vmx_pages_gva);
 
-	vcpu_run(vm, vcpu->id);
+	vcpu_run(vcpu);
 
 	run = vcpu->run;
 
@@ -88,13 +88,13 @@ int main(int argc, char *argv[])
 	 * emulating invalid guest state for L2.
 	 */
 	memset(&sregs, 0, sizeof(sregs));
-	vcpu_sregs_get(vm, vcpu->id, &sregs);
+	vcpu_sregs_get(vcpu, &sregs);
 	sregs.tr.unusable = 1;
-	vcpu_sregs_set(vm, vcpu->id, &sregs);
+	vcpu_sregs_set(vcpu, &sregs);
 
-	vcpu_run(vm, vcpu->id);
+	vcpu_run(vcpu);
 
-	switch (get_ucall(vm, vcpu->id, &uc)) {
+	switch (get_ucall(vcpu, &uc)) {
 	case UCALL_DONE:
 		break;
 	case UCALL_ABORT:
diff --git a/tools/testing/selftests/kvm/x86_64/vmx_nested_tsc_scaling_test.c b/tools/testing/selftests/kvm/x86_64/vmx_nested_tsc_scaling_test.c
index c9cb29f06244..647a4320d3bc 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_nested_tsc_scaling_test.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_nested_tsc_scaling_test.c
@@ -182,26 +182,25 @@ int main(int argc, char *argv[])
 
 	vm = vm_create_with_one_vcpu(&vcpu, l1_guest_code);
 	vcpu_alloc_vmx(vm, &vmx_pages_gva);
-	vcpu_args_set(vm, vcpu->id, 1, vmx_pages_gva);
+	vcpu_args_set(vcpu, 1, vmx_pages_gva);
 
-	tsc_khz = __vcpu_ioctl(vm, vcpu->id, KVM_GET_TSC_KHZ, NULL);
+	tsc_khz = __vcpu_ioctl(vcpu, KVM_GET_TSC_KHZ, NULL);
 	TEST_ASSERT(tsc_khz != -1, "vcpu ioctl KVM_GET_TSC_KHZ failed");
 
 	/* scale down L1's TSC frequency */
-	vcpu_ioctl(vm, vcpu->id, KVM_SET_TSC_KHZ,
-		  (void *) (tsc_khz / l1_scale_factor));
+	vcpu_ioctl(vcpu, KVM_SET_TSC_KHZ, (void *) (tsc_khz / l1_scale_factor));
 
 	for (;;) {
 		volatile struct kvm_run *run = vcpu->run;
 		struct ucall uc;
 
-		vcpu_run(vm, vcpu->id);
+		vcpu_run(vcpu);
 		TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
 			    "Got exit_reason other than KVM_EXIT_IO: %u (%s)\n",
 			    run->exit_reason,
 			    exit_reason_str(run->exit_reason));
 
-		switch (get_ucall(vm, vcpu->id, &uc)) {
+		switch (get_ucall(vcpu, &uc)) {
 		case UCALL_ABORT:
 			TEST_FAIL("%s", (const char *) uc.args[0]);
 		case UCALL_SYNC:
diff --git a/tools/testing/selftests/kvm/x86_64/vmx_pmu_msrs_test.c b/tools/testing/selftests/kvm/x86_64/vmx_pmu_msrs_test.c
index 7bb81b7a4825..8a2695975a63 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_pmu_msrs_test.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_pmu_msrs_test.c
@@ -88,25 +88,25 @@ int main(int argc, char *argv[])
 	}
 
 	/* testcase 1, set capabilities when we have PDCM bit */
-	vcpu_set_cpuid(vm, vcpu->id, cpuid);
-	vcpu_set_msr(vm, vcpu->id, MSR_IA32_PERF_CAPABILITIES, PMU_CAP_FW_WRITES);
+	vcpu_set_cpuid(vcpu, cpuid);
+	vcpu_set_msr(vcpu, MSR_IA32_PERF_CAPABILITIES, PMU_CAP_FW_WRITES);
 
 	/* check capabilities can be retrieved with KVM_GET_MSR */
-	ASSERT_EQ(vcpu_get_msr(vm, vcpu->id, MSR_IA32_PERF_CAPABILITIES), PMU_CAP_FW_WRITES);
+	ASSERT_EQ(vcpu_get_msr(vcpu, MSR_IA32_PERF_CAPABILITIES), PMU_CAP_FW_WRITES);
 
 	/* check whatever we write with KVM_SET_MSR is _not_ modified */
-	vcpu_run(vm, vcpu->id);
-	ASSERT_EQ(vcpu_get_msr(vm, vcpu->id, MSR_IA32_PERF_CAPABILITIES), PMU_CAP_FW_WRITES);
+	vcpu_run(vcpu);
+	ASSERT_EQ(vcpu_get_msr(vcpu, MSR_IA32_PERF_CAPABILITIES), PMU_CAP_FW_WRITES);
 
 	/* testcase 2, check valid LBR formats are accepted */
-	vcpu_set_msr(vm, vcpu->id, MSR_IA32_PERF_CAPABILITIES, 0);
-	ASSERT_EQ(vcpu_get_msr(vm, vcpu->id, MSR_IA32_PERF_CAPABILITIES), 0);
+	vcpu_set_msr(vcpu, MSR_IA32_PERF_CAPABILITIES, 0);
+	ASSERT_EQ(vcpu_get_msr(vcpu, MSR_IA32_PERF_CAPABILITIES), 0);
 
-	vcpu_set_msr(vm, vcpu->id, MSR_IA32_PERF_CAPABILITIES, host_cap.lbr_format);
-	ASSERT_EQ(vcpu_get_msr(vm, vcpu->id, MSR_IA32_PERF_CAPABILITIES), (u64)host_cap.lbr_format);
+	vcpu_set_msr(vcpu, MSR_IA32_PERF_CAPABILITIES, host_cap.lbr_format);
+	ASSERT_EQ(vcpu_get_msr(vcpu, MSR_IA32_PERF_CAPABILITIES), (u64)host_cap.lbr_format);
 
 	/* testcase 3, check invalid LBR format is rejected */
-	ret = _vcpu_set_msr(vm, vcpu->id, MSR_IA32_PERF_CAPABILITIES, PMU_CAP_LBR_FMT);
+	ret = _vcpu_set_msr(vcpu, MSR_IA32_PERF_CAPABILITIES, PMU_CAP_LBR_FMT);
 	TEST_ASSERT(ret == 0, "Bad PERF_CAPABILITIES didn't fail.");
 
 	kvm_vm_free(vm);
diff --git a/tools/testing/selftests/kvm/x86_64/vmx_preemption_timer_test.c b/tools/testing/selftests/kvm/x86_64/vmx_preemption_timer_test.c
index 168adc5b2272..b775a11ec08b 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_preemption_timer_test.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_preemption_timer_test.c
@@ -178,19 +178,19 @@ int main(int argc, char *argv[])
 	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
 	run = vcpu->run;
 
-	vcpu_regs_get(vm, vcpu->id, &regs1);
+	vcpu_regs_get(vcpu, &regs1);
 
 	vcpu_alloc_vmx(vm, &vmx_pages_gva);
-	vcpu_args_set(vm, vcpu->id, 1, vmx_pages_gva);
+	vcpu_args_set(vcpu, 1, vmx_pages_gva);
 
 	for (stage = 1;; stage++) {
-		vcpu_run(vm, vcpu->id);
+		vcpu_run(vcpu);
 		TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
 			    "Stage %d: unexpected exit reason: %u (%s),\n",
 			    stage, run->exit_reason,
 			    exit_reason_str(run->exit_reason));
 
-		switch (get_ucall(vm, vcpu->id, &uc)) {
+		switch (get_ucall(vcpu, &uc)) {
 		case UCALL_ABORT:
 			TEST_FAIL("%s at %s:%ld", (const char *)uc.args[0],
 				  __FILE__, uc.args[1]);
@@ -232,22 +232,22 @@ int main(int argc, char *argv[])
 				stage, uc.args[4], uc.args[5]);
 		}
 
-		state = vcpu_save_state(vm, vcpu->id);
+		state = vcpu_save_state(vcpu);
 		memset(&regs1, 0, sizeof(regs1));
-		vcpu_regs_get(vm, vcpu->id, &regs1);
+		vcpu_regs_get(vcpu, &regs1);
 
 		kvm_vm_release(vm);
 
 		/* Restore state in a new VM.  */
 		vcpu = vm_recreate_with_one_vcpu(vm);
 
-		vcpu_set_cpuid(vm, vcpu->id, kvm_get_supported_cpuid());
-		vcpu_load_state(vm, vcpu->id, state);
+		vcpu_set_cpuid(vcpu, kvm_get_supported_cpuid());
+		vcpu_load_state(vcpu, state);
 		run = vcpu->run;
 		kvm_x86_state_cleanup(state);
 
 		memset(&regs2, 0, sizeof(regs2));
-		vcpu_regs_get(vm, vcpu->id, &regs2);
+		vcpu_regs_get(vcpu, &regs2);
 		TEST_ASSERT(!memcmp(&regs1, &regs2, sizeof(regs2)),
 			    "Unexpected register values after vcpu_load_state; rdi: %lx rsi: %lx",
 			    (ulong) regs2.rdi, (ulong) regs2.rsi);
diff --git a/tools/testing/selftests/kvm/x86_64/vmx_set_nested_state_test.c b/tools/testing/selftests/kvm/x86_64/vmx_set_nested_state_test.c
index de38f0e68153..ba783ceb007f 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_set_nested_state_test.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_set_nested_state_test.c
@@ -28,7 +28,7 @@ bool have_evmcs;
 
 void test_nested_state(struct kvm_vcpu *vcpu, struct kvm_nested_state *state)
 {
-	vcpu_nested_state_set(vcpu->vm, vcpu->id, state);
+	vcpu_nested_state_set(vcpu, state);
 }
 
 void test_nested_state_expect_errno(struct kvm_vcpu *vcpu,
@@ -37,7 +37,7 @@ void test_nested_state_expect_errno(struct kvm_vcpu *vcpu,
 {
 	int rv;
 
-	rv = __vcpu_nested_state_set(vcpu->vm, vcpu->id, state);
+	rv = __vcpu_nested_state_set(vcpu, state);
 	TEST_ASSERT(rv == -1 && errno == expected_errno,
 		"Expected %s (%d) from vcpu_nested_state_set but got rv: %i errno: %s (%d)",
 		strerror(expected_errno), expected_errno, rv, strerror(errno),
@@ -121,7 +121,7 @@ void test_vmx_nested_state(struct kvm_vcpu *vcpu)
 	test_nested_state(vcpu, state);
 
 	/* Enable VMX in the guest CPUID. */
-	vcpu_set_cpuid(vcpu->vm, vcpu->id, kvm_get_supported_cpuid());
+	vcpu_set_cpuid(vcpu, kvm_get_supported_cpuid());
 
 	/*
 	 * Setting vmxon_pa == -1ull and vmcs_pa == -1ull exits early without
@@ -137,7 +137,7 @@ void test_vmx_nested_state(struct kvm_vcpu *vcpu)
 	state->flags &= KVM_STATE_NESTED_EVMCS;
 	if (have_evmcs) {
 		test_nested_state_expect_einval(vcpu, state);
-		vcpu_enable_evmcs(vcpu->vm, vcpu->id);
+		vcpu_enable_evmcs(vcpu);
 	}
 	test_nested_state(vcpu, state);
 
@@ -233,7 +233,7 @@ void test_vmx_nested_state(struct kvm_vcpu *vcpu)
 	state->hdr.vmx.vmcs12_pa = -1ull;
 	state->flags = 0;
 	test_nested_state(vcpu, state);
-	vcpu_nested_state_get(vcpu->vm, vcpu->id, state);
+	vcpu_nested_state_get(vcpu, state);
 	TEST_ASSERT(state->size >= sizeof(*state) && state->size <= state_sz,
 		    "Size must be between %ld and %d.  The size returned was %d.",
 		    sizeof(*state), state_sz, state->size);
@@ -255,7 +255,7 @@ void disable_vmx(struct kvm_vcpu *vcpu)
 	TEST_ASSERT(i != cpuid->nent, "CPUID function 1 not found");
 
 	cpuid->entries[i].ecx &= ~CPUID_VMX;
-	vcpu_set_cpuid(vcpu->vm, vcpu->id, cpuid);
+	vcpu_set_cpuid(vcpu, cpuid);
 	cpuid->entries[i].ecx |= CPUID_VMX;
 }
 
diff --git a/tools/testing/selftests/kvm/x86_64/vmx_tsc_adjust_test.c b/tools/testing/selftests/kvm/x86_64/vmx_tsc_adjust_test.c
index 29699d7c16c3..e32bfb102699 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_tsc_adjust_test.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_tsc_adjust_test.c
@@ -133,19 +133,19 @@ int main(int argc, char *argv[])
 
 	/* Allocate VMX pages and shared descriptors (vmx_pages). */
 	vcpu_alloc_vmx(vm, &vmx_pages_gva);
-	vcpu_args_set(vm, vcpu->id, 1, vmx_pages_gva);
+	vcpu_args_set(vcpu, 1, vmx_pages_gva);
 
 	for (;;) {
 		volatile struct kvm_run *run = vcpu->run;
 		struct ucall uc;
 
-		vcpu_run(vm, vcpu->id);
+		vcpu_run(vcpu);
 		TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
 			    "Got exit_reason other than KVM_EXIT_IO: %u (%s)\n",
 			    run->exit_reason,
 			    exit_reason_str(run->exit_reason));
 
-		switch (get_ucall(vm, vcpu->id, &uc)) {
+		switch (get_ucall(vcpu, &uc)) {
 		case UCALL_ABORT:
 			TEST_FAIL("%s", (const char *)uc.args[0]);
 			/* NOT REACHED */
diff --git a/tools/testing/selftests/kvm/x86_64/xapic_ipi_test.c b/tools/testing/selftests/kvm/x86_64/xapic_ipi_test.c
index 4484ee563b18..3d272d7f961e 100644
--- a/tools/testing/selftests/kvm/x86_64/xapic_ipi_test.c
+++ b/tools/testing/selftests/kvm/x86_64/xapic_ipi_test.c
@@ -206,14 +206,14 @@ static void *vcpu_thread(void *arg)
 		    vcpu->id, r);
 
 	fprintf(stderr, "vCPU thread running vCPU %u\n", vcpu->id);
-	vcpu_run(vcpu->vm, vcpu->id);
+	vcpu_run(vcpu);
 	exit_reason = vcpu->run->exit_reason;
 
 	TEST_ASSERT(exit_reason == KVM_EXIT_IO,
 		    "vCPU %u exited with unexpected exit reason %u-%s, expected KVM_EXIT_IO",
 		    vcpu->id, exit_reason, exit_reason_str(exit_reason));
 
-	if (get_ucall(vcpu->vm, vcpu->id, &uc) == UCALL_ABORT) {
+	if (get_ucall(vcpu, &uc) == UCALL_ABORT) {
 		TEST_ASSERT(false,
 			    "vCPU %u exited with error: %s.\n"
 			    "Sending vCPU sent %lu IPIs to halting vCPU\n"
@@ -415,7 +415,7 @@ int main(int argc, char *argv[])
 	vm = vm_create_with_one_vcpu(&params[0].vcpu, halter_guest_code);
 
 	vm_init_descriptor_tables(vm);
-	vcpu_init_descriptor_tables(vm, params[0].vcpu->id);
+	vcpu_init_descriptor_tables(params[0].vcpu);
 	vm_install_exception_handler(vm, IPI_VECTOR, guest_ipi_handler);
 
 	virt_pg_map(vm, APIC_DEFAULT_GPA, APIC_DEFAULT_GPA);
@@ -428,8 +428,8 @@ int main(int argc, char *argv[])
 	params[0].data = data;
 	params[1].data = data;
 
-	vcpu_args_set(vm, params[0].vcpu->id, 1, test_data_page_vaddr);
-	vcpu_args_set(vm, params[1].vcpu->id, 1, test_data_page_vaddr);
+	vcpu_args_set(params[0].vcpu, 1, test_data_page_vaddr);
+	vcpu_args_set(params[1].vcpu, 1, test_data_page_vaddr);
 
 	pipis_rcvd = (uint64_t *)addr_gva2hva(vm, (uint64_t)&ipis_rcvd);
 	params[0].pipis_rcvd = pipis_rcvd;
diff --git a/tools/testing/selftests/kvm/x86_64/xapic_state_test.c b/tools/testing/selftests/kvm/x86_64/xapic_state_test.c
index 56301ee1adee..5c5dc7bbb4e2 100644
--- a/tools/testing/selftests/kvm/x86_64/xapic_state_test.c
+++ b/tools/testing/selftests/kvm/x86_64/xapic_state_test.c
@@ -47,7 +47,7 @@ static void x2apic_guest_code(void)
 	} while (1);
 }
 
-static void ____test_icr(struct kvm_vm *vm, struct xapic_vcpu *x, uint64_t val)
+static void ____test_icr(struct xapic_vcpu *x, uint64_t val)
 {
 	struct kvm_vcpu *vcpu = x->vcpu;
 	struct kvm_lapic_state xapic;
@@ -59,16 +59,16 @@ static void ____test_icr(struct kvm_vm *vm, struct xapic_vcpu *x, uint64_t val)
 	 * all bits are valid and should not be modified by KVM (ignoring the
 	 * fact that vectors 0-15 are technically illegal).
 	 */
-	vcpu_ioctl(vm, vcpu->id, KVM_GET_LAPIC, &xapic);
+	vcpu_ioctl(vcpu, KVM_GET_LAPIC, &xapic);
 	*((u32 *)&xapic.regs[APIC_IRR]) = val;
 	*((u32 *)&xapic.regs[APIC_IRR + 0x10]) = val >> 32;
-	vcpu_ioctl(vm, vcpu->id, KVM_SET_LAPIC, &xapic);
+	vcpu_ioctl(vcpu, KVM_SET_LAPIC, &xapic);
 
-	vcpu_run(vm, vcpu->id);
-	ASSERT_EQ(get_ucall(vm, vcpu->id, &uc), UCALL_SYNC);
+	vcpu_run(vcpu);
+	ASSERT_EQ(get_ucall(vcpu, &uc), UCALL_SYNC);
 	ASSERT_EQ(uc.args[1], val);
 
-	vcpu_ioctl(vm, vcpu->id, KVM_GET_LAPIC, &xapic);
+	vcpu_ioctl(vcpu, KVM_GET_LAPIC, &xapic);
 	icr = (u64)(*((u32 *)&xapic.regs[APIC_ICR])) |
 	      (u64)(*((u32 *)&xapic.regs[APIC_ICR2])) << 32;
 	if (!x->is_x2apic)
@@ -76,24 +76,24 @@ static void ____test_icr(struct kvm_vm *vm, struct xapic_vcpu *x, uint64_t val)
 	ASSERT_EQ(icr, val & ~APIC_ICR_BUSY);
 }
 
-static void __test_icr(struct kvm_vm *vm, struct xapic_vcpu *x, uint64_t val)
+static void __test_icr(struct xapic_vcpu *x, uint64_t val)
 {
-	____test_icr(vm, x, val | APIC_ICR_BUSY);
-	____test_icr(vm, x, val & ~(u64)APIC_ICR_BUSY);
+	____test_icr(x, val | APIC_ICR_BUSY);
+	____test_icr(x, val & ~(u64)APIC_ICR_BUSY);
 }
 
-static void test_icr(struct kvm_vm *vm, struct xapic_vcpu *x)
+static void test_icr(struct xapic_vcpu *x)
 {
 	struct kvm_vcpu *vcpu = x->vcpu;
 	uint64_t icr, i, j;
 
 	icr = APIC_DEST_SELF | APIC_INT_ASSERT | APIC_DM_FIXED;
 	for (i = 0; i <= 0xff; i++)
-		__test_icr(vm, x, icr | i);
+		__test_icr(x, icr | i);
 
 	icr = APIC_INT_ASSERT | APIC_DM_FIXED;
 	for (i = 0; i <= 0xff; i++)
-		__test_icr(vm, x, icr | i);
+		__test_icr(x, icr | i);
 
 	/*
 	 * Send all flavors of IPIs to non-existent vCPUs.  TODO: use number of
@@ -102,18 +102,18 @@ static void test_icr(struct kvm_vm *vm, struct xapic_vcpu *x)
 	icr = APIC_INT_ASSERT | 0xff;
 	for (i = vcpu->id + 1; i < 0xff; i++) {
 		for (j = 0; j < 8; j++)
-			__test_icr(vm, x, i << (32 + 24) | APIC_INT_ASSERT | (j << 8));
+			__test_icr(x, i << (32 + 24) | APIC_INT_ASSERT | (j << 8));
 	}
 
 	/* And again with a shorthand destination for all types of IPIs. */
 	icr = APIC_DEST_ALLBUT | APIC_INT_ASSERT;
 	for (i = 0; i < 8; i++)
-		__test_icr(vm, x, icr | (i << 8));
+		__test_icr(x, icr | (i << 8));
 
 	/* And a few garbage value, just make sure it's an IRQ (blocked). */
-	__test_icr(vm, x, 0xa5a5a5a5a5a5a5a5 & ~APIC_DM_FIXED_MASK);
-	__test_icr(vm, x, 0x5a5a5a5a5a5a5a5a & ~APIC_DM_FIXED_MASK);
-	__test_icr(vm, x, -1ull & ~APIC_DM_FIXED_MASK);
+	__test_icr(x, 0xa5a5a5a5a5a5a5a5 & ~APIC_DM_FIXED_MASK);
+	__test_icr(x, 0x5a5a5a5a5a5a5a5a & ~APIC_DM_FIXED_MASK);
+	__test_icr(x, -1ull & ~APIC_DM_FIXED_MASK);
 }
 
 int main(int argc, char *argv[])
@@ -127,7 +127,7 @@ int main(int argc, char *argv[])
 	int i;
 
 	vm = vm_create_with_one_vcpu(&x.vcpu, x2apic_guest_code);
-	test_icr(vm, &x);
+	test_icr(&x);
 	kvm_vm_free(vm);
 
 	/*
@@ -138,15 +138,15 @@ int main(int argc, char *argv[])
 	vm = vm_create_with_one_vcpu(&x.vcpu, xapic_guest_code);
 	x.is_x2apic = false;
 
-	cpuid = vcpu_get_cpuid(vm, x.vcpu->id);
+	cpuid = vcpu_get_cpuid(x.vcpu);
 	for (i = 0; i < cpuid->nent; i++) {
 		if (cpuid->entries[i].function == 1)
 			break;
 	}
 	cpuid->entries[i].ecx &= ~BIT(21);
-	vcpu_set_cpuid(vm, x.vcpu->id, cpuid);
+	vcpu_set_cpuid(x.vcpu, cpuid);
 
 	virt_pg_map(vm, APIC_DEFAULT_GPA, APIC_DEFAULT_GPA);
-	test_icr(vm, &x);
+	test_icr(&x);
 	kvm_vm_free(vm);
 }
diff --git a/tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c b/tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c
index 5c0abaf0eb60..4340c2f2300f 100644
--- a/tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c
+++ b/tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c
@@ -348,7 +348,7 @@ static void handle_alrm(int sig)
 {
 	if (vinfo)
 		printf("evtchn_upcall_pending 0x%x\n", vinfo->evtchn_upcall_pending);
-	vcpu_dump(stdout, vcpu->vm, vcpu->id, 0);
+	vcpu_dump(stdout, vcpu, 0);
 	TEST_FAIL("IRQ delivery timed out");
 }
 
@@ -423,13 +423,13 @@ int main(int argc, char *argv[])
 		.type = KVM_XEN_VCPU_ATTR_TYPE_VCPU_INFO,
 		.u.gpa = VCPU_INFO_ADDR,
 	};
-	vcpu_ioctl(vm, vcpu->id, KVM_XEN_VCPU_SET_ATTR, &vi);
+	vcpu_ioctl(vcpu, KVM_XEN_VCPU_SET_ATTR, &vi);
 
 	struct kvm_xen_vcpu_attr pvclock = {
 		.type = KVM_XEN_VCPU_ATTR_TYPE_VCPU_TIME_INFO,
 		.u.gpa = PVTIME_ADDR,
 	};
-	vcpu_ioctl(vm, vcpu->id, KVM_XEN_VCPU_SET_ATTR, &pvclock);
+	vcpu_ioctl(vcpu, KVM_XEN_VCPU_SET_ATTR, &pvclock);
 
 	struct kvm_xen_hvm_attr vec = {
 		.type = KVM_XEN_ATTR_TYPE_UPCALL_VECTOR,
@@ -438,7 +438,7 @@ int main(int argc, char *argv[])
 	vm_ioctl(vm, KVM_XEN_HVM_SET_ATTR, &vec);
 
 	vm_init_descriptor_tables(vm);
-	vcpu_init_descriptor_tables(vm, vcpu->id);
+	vcpu_init_descriptor_tables(vcpu);
 	vm_install_exception_handler(vm, EVTCHN_VECTOR, evtchn_handler);
 
 	if (do_runstate_tests) {
@@ -446,7 +446,7 @@ int main(int argc, char *argv[])
 			.type = KVM_XEN_VCPU_ATTR_TYPE_RUNSTATE_ADDR,
 			.u.gpa = RUNSTATE_ADDR,
 		};
-		vcpu_ioctl(vm, vcpu->id, KVM_XEN_VCPU_SET_ATTR, &st);
+		vcpu_ioctl(vcpu, KVM_XEN_VCPU_SET_ATTR, &st);
 	}
 
 	int irq_fd[2] = { -1, -1 };
@@ -522,7 +522,7 @@ int main(int argc, char *argv[])
 		inj.u.evtchn.flags = 0;
 		vm_ioctl(vm, KVM_XEN_HVM_SET_ATTR, &inj);
 
-		vcpu_ioctl(vm, vcpu->id, KVM_XEN_VCPU_SET_ATTR, &tmr);
+		vcpu_ioctl(vcpu, KVM_XEN_VCPU_SET_ATTR, &tmr);
 	}
 	vinfo = addr_gpa2hva(vm, VCPU_INFO_VADDR);
 	vinfo->evtchn_upcall_pending = 0;
@@ -536,14 +536,14 @@ int main(int argc, char *argv[])
 		volatile struct kvm_run *run = vcpu->run;
 		struct ucall uc;
 
-		vcpu_run(vm, vcpu->id);
+		vcpu_run(vcpu);
 
 		TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
 			    "Got exit_reason other than KVM_EXIT_IO: %u (%s)\n",
 			    run->exit_reason,
 			    exit_reason_str(run->exit_reason));
 
-		switch (get_ucall(vm, vcpu->id, &uc)) {
+		switch (get_ucall(vcpu, &uc)) {
 		case UCALL_ABORT:
 			TEST_FAIL("%s", (const char *)uc.args[0]);
 			/* NOT REACHED */
@@ -572,7 +572,7 @@ int main(int argc, char *argv[])
 					printf("Testing runstate %s\n", runstate_names[uc.args[1]]);
 				rst.type = KVM_XEN_VCPU_ATTR_TYPE_RUNSTATE_CURRENT;
 				rst.u.runstate.state = uc.args[1];
-				vcpu_ioctl(vm, vcpu->id, KVM_XEN_VCPU_SET_ATTR, &rst);
+				vcpu_ioctl(vcpu, KVM_XEN_VCPU_SET_ATTR, &rst);
 				break;
 
 			case 4:
@@ -587,7 +587,7 @@ int main(int argc, char *argv[])
 					0x6b6b - rs->time[RUNSTATE_offline];
 				rst.u.runstate.time_runnable = -rst.u.runstate.time_blocked -
 					rst.u.runstate.time_offline;
-				vcpu_ioctl(vm, vcpu->id, KVM_XEN_VCPU_SET_ATTR, &rst);
+				vcpu_ioctl(vcpu, KVM_XEN_VCPU_SET_ATTR, &rst);
 				break;
 
 			case 5:
@@ -599,7 +599,7 @@ int main(int argc, char *argv[])
 				rst.u.runstate.state_entry_time = 0x6b6b + 0x5a;
 				rst.u.runstate.time_blocked = 0x6b6b;
 				rst.u.runstate.time_offline = 0x5a;
-				vcpu_ioctl(vm, vcpu->id, KVM_XEN_VCPU_SET_ATTR, &rst);
+				vcpu_ioctl(vcpu, KVM_XEN_VCPU_SET_ATTR, &rst);
 				break;
 
 			case 6:
@@ -700,7 +700,7 @@ int main(int argc, char *argv[])
 			case 14:
 				memset(&tmr, 0, sizeof(tmr));
 				tmr.type = KVM_XEN_VCPU_ATTR_TYPE_TIMER;
-				vcpu_ioctl(vm, vcpu->id, KVM_XEN_VCPU_GET_ATTR, &tmr);
+				vcpu_ioctl(vcpu, KVM_XEN_VCPU_GET_ATTR, &tmr);
 				TEST_ASSERT(tmr.u.timer.port == EVTCHN_TIMER,
 					    "Timer port not returned");
 				TEST_ASSERT(tmr.u.timer.priority == KVM_IRQ_ROUTING_XEN_EVTCHN_PRIO_2LEVEL,
@@ -720,7 +720,7 @@ int main(int argc, char *argv[])
 					printf("Testing restored oneshot timer\n");
 
 				tmr.u.timer.expires_ns = rs->state_entry_time + 100000000,
-				vcpu_ioctl(vm, vcpu->id, KVM_XEN_VCPU_SET_ATTR, &tmr);
+				vcpu_ioctl(vcpu, KVM_XEN_VCPU_SET_ATTR, &tmr);
 				evtchn_irq_expected = true;
 				alarm(1);
 				break;
@@ -747,7 +747,7 @@ int main(int argc, char *argv[])
 					printf("Testing SCHEDOP_poll wake on masked event\n");
 
 				tmr.u.timer.expires_ns = rs->state_entry_time + 100000000,
-				vcpu_ioctl(vm, vcpu->id, KVM_XEN_VCPU_SET_ATTR, &tmr);
+				vcpu_ioctl(vcpu, KVM_XEN_VCPU_SET_ATTR, &tmr);
 				alarm(1);
 				break;
 
@@ -758,11 +758,11 @@ int main(int argc, char *argv[])
 
 				evtchn_irq_expected = true;
 				tmr.u.timer.expires_ns = rs->state_entry_time + 100000000;
-				vcpu_ioctl(vm, vcpu->id, KVM_XEN_VCPU_SET_ATTR, &tmr);
+				vcpu_ioctl(vcpu, KVM_XEN_VCPU_SET_ATTR, &tmr);
 
 				/* Read it back and check the pending time is reported correctly */
 				tmr.u.timer.expires_ns = 0;
-				vcpu_ioctl(vm, vcpu->id, KVM_XEN_VCPU_GET_ATTR, &tmr);
+				vcpu_ioctl(vcpu, KVM_XEN_VCPU_GET_ATTR, &tmr);
 				TEST_ASSERT(tmr.u.timer.expires_ns == rs->state_entry_time + 100000000,
 					    "Timer not reported pending");
 				alarm(1);
@@ -772,7 +772,7 @@ int main(int argc, char *argv[])
 				TEST_ASSERT(!evtchn_irq_expected,
 					    "Expected event channel IRQ but it didn't happen");
 				/* Read timer and check it is no longer pending */
-				vcpu_ioctl(vm, vcpu->id, KVM_XEN_VCPU_GET_ATTR, &tmr);
+				vcpu_ioctl(vcpu, KVM_XEN_VCPU_GET_ATTR, &tmr);
 				TEST_ASSERT(!tmr.u.timer.expires_ns, "Timer still reported pending");
 
 				shinfo->evtchn_pending[0] = 0;
@@ -781,7 +781,7 @@ int main(int argc, char *argv[])
 
 				evtchn_irq_expected = true;
 				tmr.u.timer.expires_ns = rs->state_entry_time - 100000000ULL;
-				vcpu_ioctl(vm, vcpu->id, KVM_XEN_VCPU_SET_ATTR, &tmr);
+				vcpu_ioctl(vcpu, KVM_XEN_VCPU_SET_ATTR, &tmr);
 				alarm(1);
 				break;
 
@@ -851,7 +851,7 @@ int main(int argc, char *argv[])
 		struct kvm_xen_vcpu_attr rst = {
 			.type = KVM_XEN_VCPU_ATTR_TYPE_RUNSTATE_DATA,
 		};
-		vcpu_ioctl(vm, vcpu->id, KVM_XEN_VCPU_GET_ATTR, &rst);
+		vcpu_ioctl(vcpu, KVM_XEN_VCPU_GET_ATTR, &rst);
 
 		if (verbose) {
 			printf("Runstate: %s(%d), entry %" PRIu64 " ns\n",
diff --git a/tools/testing/selftests/kvm/x86_64/xen_vmcall_test.c b/tools/testing/selftests/kvm/x86_64/xen_vmcall_test.c
index 1411ead620fe..a91f11fb26f4 100644
--- a/tools/testing/selftests/kvm/x86_64/xen_vmcall_test.c
+++ b/tools/testing/selftests/kvm/x86_64/xen_vmcall_test.c
@@ -90,7 +90,7 @@ int main(int argc, char *argv[])
 	}
 
 	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
-	vcpu_set_hv_cpuid(vm, vcpu->id);
+	vcpu_set_hv_cpuid(vcpu);
 
 	struct kvm_xen_hvm_config hvmc = {
 		.flags = KVM_XEN_HVM_CONFIG_INTERCEPT_HCALL,
@@ -107,7 +107,7 @@ int main(int argc, char *argv[])
 		volatile struct kvm_run *run = vcpu->run;
 		struct ucall uc;
 
-		vcpu_run(vm, vcpu->id);
+		vcpu_run(vcpu);
 
 		if (run->exit_reason == KVM_EXIT_XEN) {
 			ASSERT_EQ(run->xen.type, KVM_EXIT_XEN_HCALL);
@@ -129,7 +129,7 @@ int main(int argc, char *argv[])
 			    run->exit_reason,
 			    exit_reason_str(run->exit_reason));
 
-		switch (get_ucall(vm, vcpu->id, &uc)) {
+		switch (get_ucall(vcpu, &uc)) {
 		case UCALL_ABORT:
 			TEST_FAIL("%s", (const char *)uc.args[0]);
 			/* NOT REACHED */
diff --git a/tools/testing/selftests/kvm/x86_64/xss_msr_test.c b/tools/testing/selftests/kvm/x86_64/xss_msr_test.c
index c5672d2949db..d5cdd09b7f96 100644
--- a/tools/testing/selftests/kvm/x86_64/xss_msr_test.c
+++ b/tools/testing/selftests/kvm/x86_64/xss_msr_test.c
@@ -55,11 +55,11 @@ int main(int argc, char *argv[])
 		exit(KSFT_SKIP);
 	}
 
-	xss_val = vcpu_get_msr(vm, vcpu->id, MSR_IA32_XSS);
+	xss_val = vcpu_get_msr(vcpu, MSR_IA32_XSS);
 	TEST_ASSERT(xss_val == 0,
 		    "MSR_IA32_XSS should be initialized to zero\n");
 
-	vcpu_set_msr(vm, vcpu->id, MSR_IA32_XSS, xss_val);
+	vcpu_set_msr(vcpu, MSR_IA32_XSS, xss_val);
 	/*
 	 * At present, KVM only supports a guest IA32_XSS value of 0. Verify
 	 * that trying to set the guest IA32_XSS to an unsupported value fails.
@@ -67,7 +67,7 @@ int main(int argc, char *argv[])
 	 * IA32_XSS is in the KVM_GET_MSR_INDEX_LIST.
 	 */
 	for (i = 0; i < MSR_BITS; ++i) {
-		r = _vcpu_set_msr(vm, vcpu->id, MSR_IA32_XSS, 1ull << i);
+		r = _vcpu_set_msr(vcpu, MSR_IA32_XSS, 1ull << i);
 		TEST_ASSERT(r == 0 || is_supported_msr(MSR_IA32_XSS),
 			    "IA32_XSS was able to be set, but was not found in KVM_GET_MSR_INDEX_LIST.\n");
 	}
-- 
2.36.0.464.gb9c8b46e94-goog


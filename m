Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 710D44D5AD6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346647AbiCKFxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 00:53:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346552AbiCKFwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:52:24 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0CDECC7C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:51:20 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id b1-20020a170902bd4100b00151f3f97b0cso4010491plx.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=HwHmeooBbWLI8npkywCEH99zsYJWGlHEj/+w8MXdpgg=;
        b=Eb1mf8yw9GmK2czBz6kUSHT9/0oI/qe3JPmvh7QyFAp6NcH1ywTCpGHSfeOaBDe7fB
         B97+G7OV269wUCx1xbu27AmYptaBiqCukxm1zRumZeoFfynn1L43q5IulITGVAmY0IOb
         wGsUiyB5B7FL4zXEmr6t/CD/6sbx+MAu97k0FiOkM1rTTmsDAZpqVT5BeGbmAxk5cGlO
         /AOS9ZzCftEWQtWqkvBqYx2MHs6v6alOZ18EUzQC3nHy0yIwRYESDOHEuARIpGXvHGcg
         qWuA8k1BF5dL0yglvkXYgEvq3MPlHmtqRSW2obTXnCcPzd/MSXNMQ6pjN2zjLIgnRpuM
         bV/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=HwHmeooBbWLI8npkywCEH99zsYJWGlHEj/+w8MXdpgg=;
        b=GQhPQEaNOtCExx1Jpxq0wnuTpcFJEHFLsHcWKX1AD6fNXILW/KAOFIQ19mr1CCFNim
         AWYXU5A+9CVskQ/Or5MFqa54y7QF5MSvX82teq8oSXQIZQwC2T2bwZoq4+neTt3JeqWz
         JVtosm2pRvYxztsOdujd041OozTwSfWSEvXqGGLTx9oiwQA0yY4ISuuFOTMldBbsanrC
         umXIXz812cF4iZsnI4nY09aKKx0vvR31Z+DbCR7Mcvc5FjIZiz2HCkaV/ApXEXhp/GP0
         S2cwE4NjFWZxfT9VBLSxRUT1clj8lP5B9rHAZbVmlsma8U6CwndIUklHQ0m3gXthKPyS
         F1EQ==
X-Gm-Message-State: AOAM532TvgHw5pPSEhXJ3S8UpkivSFMZzWvMaEe1foLTYr/2mHEE8eqH
        WwwcLTBNgC+t1vXtqiAla3njwGDQY8TYj1OJtEUC2T5wJqhC4eDPgPk2W3x9rkvz2UUOnWGyqCZ
        UMfSTx/VcVsLHK/tmAAZExBulfUV66OyTPzS/2W8V64aXe40FjS5NeV5Og8Mi9qESqmX+AQ==
X-Google-Smtp-Source: ABdhPJx4FCKW6PeMsftZLkeTDRPPp0gfnKuHxQHHPRNd0ElBS7E+9tAcHfTIIC8n5wBnjMGM+ztWj3cPBwc=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:902:9682:b0:153:2b0b:298f with SMTP id
 n2-20020a170902968200b001532b0b298fmr4421140plp.70.1646977879706; Thu, 10 Mar
 2022 21:51:19 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:49:19 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-9-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 008/105] KVM: sefltests: Use vcpu_ioctl() and
 __vcpu_ioctl() helpers
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
 .../selftests/kvm/include/kvm_util_base.h     | 142 ++++++---
 .../selftests/kvm/include/x86_64/processor.h  |  28 +-
 .../selftests/kvm/kvm_binary_stats_test.c     |   6 +-
 tools/testing/selftests/kvm/lib/kvm_util.c    | 282 ------------------
 .../selftests/kvm/lib/x86_64/processor.c      | 103 +------
 5 files changed, 131 insertions(+), 430 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index aab258f17e91..cebfc667e3db 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -105,8 +105,6 @@ int open_kvm_dev_path_or_exit(void);
 int kvm_check_cap(long cap);
 int vm_check_cap(struct kvm_vm *vm, long cap);
 int vm_enable_cap(struct kvm_vm *vm, struct kvm_enable_cap *cap);
-int vcpu_enable_cap(struct kvm_vm *vm, uint32_t vcpu_id,
-		    struct kvm_enable_cap *cap);
 void vm_enable_dirty_ring(struct kvm_vm *vm, uint32_t ring_size);
 const char *vm_guest_mode_string(uint32_t i);
 
@@ -206,13 +204,112 @@ void vcpu_run(struct kvm_vm *vm, uint32_t vcpuid);
 int _vcpu_run(struct kvm_vm *vm, uint32_t vcpuid);
 int vcpu_get_fd(struct kvm_vm *vm, uint32_t vcpuid);
 void vcpu_run_complete_io(struct kvm_vm *vm, uint32_t vcpuid);
-void vcpu_set_guest_debug(struct kvm_vm *vm, uint32_t vcpuid,
-			  struct kvm_guest_debug *debug);
-void vcpu_set_mp_state(struct kvm_vm *vm, uint32_t vcpuid,
-		       struct kvm_mp_state *mp_state);
 struct kvm_reg_list *vcpu_get_reg_list(struct kvm_vm *vm, uint32_t vcpuid);
-void vcpu_regs_get(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_regs *regs);
-void vcpu_regs_set(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_regs *regs);
+
+static inline void vcpu_enable_cap(struct kvm_vm *vm, uint32_t vcpu_id,
+				   struct kvm_enable_cap *cap)
+{
+	vcpu_ioctl(vm, vcpu_id, KVM_ENABLE_CAP, cap);
+}
+
+static inline void vcpu_set_guest_debug(struct kvm_vm *vm, uint32_t vcpuid,
+					struct kvm_guest_debug *debug)
+{
+	vcpu_ioctl(vm, vcpuid, KVM_SET_GUEST_DEBUG, debug);
+}
+
+static inline void vcpu_set_mp_state(struct kvm_vm *vm, uint32_t vcpuid,
+				     struct kvm_mp_state *mp_state)
+{
+	vcpu_ioctl(vm, vcpuid, KVM_SET_MP_STATE, mp_state);
+}
+
+static inline void vcpu_regs_get(struct kvm_vm *vm, uint32_t vcpuid,
+				 struct kvm_regs *regs)
+{
+	vcpu_ioctl(vm, vcpuid, KVM_GET_REGS, regs);
+}
+
+static inline void vcpu_regs_set(struct kvm_vm *vm, uint32_t vcpuid,
+				 struct kvm_regs *regs)
+{
+	vcpu_ioctl(vm, vcpuid, KVM_SET_REGS, regs);
+}
+static inline void vcpu_sregs_get(struct kvm_vm *vm, uint32_t vcpuid,
+				  struct kvm_sregs *sregs)
+{
+	vcpu_ioctl(vm, vcpuid, KVM_GET_SREGS, sregs);
+
+}
+static inline void vcpu_sregs_set(struct kvm_vm *vm, uint32_t vcpuid,
+				  struct kvm_sregs *sregs)
+{
+	vcpu_ioctl(vm, vcpuid, KVM_SET_SREGS, sregs);
+}
+static inline int _vcpu_sregs_set(struct kvm_vm *vm, uint32_t vcpuid,
+				  struct kvm_sregs *sregs)
+{
+	return __vcpu_ioctl(vm, vcpuid, KVM_SET_SREGS, sregs);
+}
+static inline void vcpu_fpu_get(struct kvm_vm *vm, uint32_t vcpuid,
+				struct kvm_fpu *fpu)
+{
+	vcpu_ioctl(vm, vcpuid, KVM_GET_FPU, fpu);
+}
+static inline void vcpu_fpu_set(struct kvm_vm *vm, uint32_t vcpuid,
+				struct kvm_fpu *fpu)
+{
+	vcpu_ioctl(vm, vcpuid, KVM_SET_FPU, fpu);
+}
+static inline void vcpu_get_reg(struct kvm_vm *vm, uint32_t vcpuid,
+				struct kvm_one_reg *reg)
+{
+	vcpu_ioctl(vm, vcpuid, KVM_GET_ONE_REG, reg);
+}
+static inline void vcpu_set_reg(struct kvm_vm *vm, uint32_t vcpuid,
+				struct kvm_one_reg *reg)
+{
+	vcpu_ioctl(vm, vcpuid, KVM_SET_ONE_REG, reg);
+}
+#ifdef __KVM_HAVE_VCPU_EVENTS
+static inline void vcpu_events_get(struct kvm_vm *vm, uint32_t vcpuid,
+				   struct kvm_vcpu_events *events)
+{
+	vcpu_ioctl(vm, vcpuid, KVM_GET_VCPU_EVENTS, events);
+}
+static inline void vcpu_events_set(struct kvm_vm *vm, uint32_t vcpuid,
+				   struct kvm_vcpu_events *events)
+{
+	vcpu_ioctl(vm, vcpuid, KVM_SET_VCPU_EVENTS, events);
+}
+#endif
+#ifdef __x86_64__
+static inline void vcpu_nested_state_get(struct kvm_vm *vm, uint32_t vcpuid,
+					 struct kvm_nested_state *state)
+{
+	vcpu_ioctl(vm, vcpuid, KVM_GET_NESTED_STATE, state);
+}
+static inline int __vcpu_nested_state_set(struct kvm_vm *vm, uint32_t vcpuid,
+					  struct kvm_nested_state *state)
+{
+	return __vcpu_ioctl(vm, vcpuid, KVM_SET_NESTED_STATE, state);
+}
+
+static inline void vcpu_nested_state_set(struct kvm_vm *vm, uint32_t vcpuid,
+					 struct kvm_nested_state *state)
+{
+	vcpu_ioctl(vm, vcpuid, KVM_SET_NESTED_STATE, state);
+}
+#endif
+static inline int vcpu_get_stats_fd(struct kvm_vm *vm, uint32_t vcpuid)
+{
+	int fd = __vcpu_ioctl(vm, vcpuid, KVM_GET_STATS_FD, NULL);
+
+	TEST_ASSERT(fd >= 0, KVM_IOCTL_ERROR(KVM_GET_STATS_FD, fd));
+	return fd;
+}
+
+void *vcpu_map_dirty_ring(struct kvm_vm *vm, uint32_t vcpuid);
 
 /*
  * VM VCPU Args Set
@@ -234,34 +331,6 @@ void vcpu_regs_set(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_regs *regs);
  */
 void vcpu_args_set(struct kvm_vm *vm, uint32_t vcpuid, unsigned int num, ...);
 
-void vcpu_sregs_get(struct kvm_vm *vm, uint32_t vcpuid,
-		    struct kvm_sregs *sregs);
-void vcpu_sregs_set(struct kvm_vm *vm, uint32_t vcpuid,
-		    struct kvm_sregs *sregs);
-int _vcpu_sregs_set(struct kvm_vm *vm, uint32_t vcpuid,
-		    struct kvm_sregs *sregs);
-void vcpu_fpu_get(struct kvm_vm *vm, uint32_t vcpuid,
-		  struct kvm_fpu *fpu);
-void vcpu_fpu_set(struct kvm_vm *vm, uint32_t vcpuid,
-		  struct kvm_fpu *fpu);
-void vcpu_get_reg(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_one_reg *reg);
-void vcpu_set_reg(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_one_reg *reg);
-#ifdef __KVM_HAVE_VCPU_EVENTS
-void vcpu_events_get(struct kvm_vm *vm, uint32_t vcpuid,
-		     struct kvm_vcpu_events *events);
-void vcpu_events_set(struct kvm_vm *vm, uint32_t vcpuid,
-		     struct kvm_vcpu_events *events);
-#endif
-#ifdef __x86_64__
-void vcpu_nested_state_get(struct kvm_vm *vm, uint32_t vcpuid,
-			   struct kvm_nested_state *state);
-int __vcpu_nested_state_set(struct kvm_vm *vm, uint32_t vcpuid,
-			    struct kvm_nested_state *state);
-void vcpu_nested_state_set(struct kvm_vm *vm, uint32_t vcpuid,
-			   struct kvm_nested_state *state);
-#endif
-void *vcpu_map_dirty_ring(struct kvm_vm *vm, uint32_t vcpuid);
-
 int _kvm_device_check_attr(int dev_fd, uint32_t group, uint64_t attr);
 int kvm_device_check_attr(int dev_fd, uint32_t group, uint64_t attr);
 int _kvm_create_device(struct kvm_vm *vm, uint64_t type, bool test, int *fd);
@@ -402,7 +471,6 @@ int vm_create_device(struct kvm_vm *vm, struct kvm_create_device *cd);
 void assert_on_unhandled_exception(struct kvm_vm *vm, uint32_t vcpuid);
 
 int vm_get_stats_fd(struct kvm_vm *vm);
-int vcpu_get_stats_fd(struct kvm_vm *vm, uint32_t vcpuid);
 
 uint32_t guest_get_vcpuid(void);
 
diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index 8a470da7b71a..b20de7919411 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -391,12 +391,19 @@ void kvm_x86_state_cleanup(struct kvm_x86_state *state);
 struct kvm_msr_list *kvm_get_msr_index_list(void);
 uint64_t kvm_get_feature_msr(uint64_t msr_index);
 struct kvm_cpuid2 *kvm_get_supported_cpuid(void);
-
 struct kvm_cpuid2 *vcpu_get_cpuid(struct kvm_vm *vm, uint32_t vcpuid);
-int __vcpu_set_cpuid(struct kvm_vm *vm, uint32_t vcpuid,
-		     struct kvm_cpuid2 *cpuid);
-void vcpu_set_cpuid(struct kvm_vm *vm, uint32_t vcpuid,
-		    struct kvm_cpuid2 *cpuid);
+
+static inline int __vcpu_set_cpuid(struct kvm_vm *vm, uint32_t vcpuid,
+				   struct kvm_cpuid2 *cpuid)
+{
+	return __vcpu_ioctl(vm, vcpuid, KVM_SET_CPUID2, cpuid);
+}
+
+static inline void vcpu_set_cpuid(struct kvm_vm *vm, uint32_t vcpuid,
+				  struct kvm_cpuid2 *cpuid)
+{
+	vcpu_ioctl(vm, vcpuid, KVM_SET_CPUID2, cpuid);
+}
 
 struct kvm_cpuid_entry2 *
 kvm_get_supported_cpuid_index(uint32_t function, uint32_t index);
@@ -410,8 +417,15 @@ kvm_get_supported_cpuid_entry(uint32_t function)
 uint64_t vcpu_get_msr(struct kvm_vm *vm, uint32_t vcpuid, uint64_t msr_index);
 int _vcpu_set_msr(struct kvm_vm *vm, uint32_t vcpuid, uint64_t msr_index,
 		  uint64_t msr_value);
-void vcpu_set_msr(struct kvm_vm *vm, uint32_t vcpuid, uint64_t msr_index,
-	  	  uint64_t msr_value);
+
+static inline void vcpu_set_msr(struct kvm_vm *vm, uint32_t vcpuid,
+				uint64_t msr_index, uint64_t msr_value)
+{
+	int r = _vcpu_set_msr(vm, vcpuid, msr_index, msr_value);
+
+	TEST_ASSERT(r == 1, KVM_IOCTL_ERROR(KVM_SET_MSRS, r));
+}
+
 
 uint32_t kvm_get_cpuid_max_basic(void);
 uint32_t kvm_get_cpuid_max_extended(void);
diff --git a/tools/testing/selftests/kvm/kvm_binary_stats_test.c b/tools/testing/selftests/kvm/kvm_binary_stats_test.c
index 4b149b383678..bab8b49b52da 100644
--- a/tools/testing/selftests/kvm/kvm_binary_stats_test.c
+++ b/tools/testing/selftests/kvm/kvm_binary_stats_test.c
@@ -178,11 +178,7 @@ static void vm_stats_test(struct kvm_vm *vm)
 
 static void vcpu_stats_test(struct kvm_vm *vm, int vcpu_id)
 {
-	int stats_fd;
-
-	/* Get fd for VCPU stats */
-	stats_fd = vcpu_get_stats_fd(vm, vcpu_id);
-	TEST_ASSERT(stats_fd >= 0, "Get VCPU stats fd");
+	int stats_fd = vcpu_get_stats_fd(vm, vcpu_id);
 
 	stats_test(stats_fd);
 	close(stats_fd);
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 8dabea79e394..c9bbe69513eb 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -135,34 +135,6 @@ int vm_enable_cap(struct kvm_vm *vm, struct kvm_enable_cap *cap)
 	return ret;
 }
 
-/* VCPU Enable Capability
- *
- * Input Args:
- *   vm - Virtual Machine
- *   vcpu_id - VCPU
- *   cap - Capability
- *
- * Output Args: None
- *
- * Return: On success, 0. On failure a TEST_ASSERT failure is produced.
- *
- * Enables a capability (KVM_CAP_*) on the VCPU.
- */
-int vcpu_enable_cap(struct kvm_vm *vm, uint32_t vcpu_id,
-		    struct kvm_enable_cap *cap)
-{
-	struct vcpu *vcpu = vcpu_find(vm, vcpu_id);
-	int r;
-
-	TEST_ASSERT(vcpu, "cannot find vcpu %d", vcpu_id);
-
-	r = ioctl(vcpu->fd, KVM_ENABLE_CAP, cap);
-	TEST_ASSERT(!r, "KVM_ENABLE_CAP vCPU ioctl failed,\n"
-			"  rc: %i, errno: %i", r, errno);
-
-	return r;
-}
-
 void vm_enable_dirty_ring(struct kvm_vm *vm, uint32_t ring_size)
 {
 	struct kvm_enable_cap cap = { 0 };
@@ -1625,43 +1597,6 @@ void vcpu_run_complete_io(struct kvm_vm *vm, uint32_t vcpuid)
 		    ret, errno);
 }
 
-void vcpu_set_guest_debug(struct kvm_vm *vm, uint32_t vcpuid,
-			  struct kvm_guest_debug *debug)
-{
-	struct vcpu *vcpu = vcpu_find(vm, vcpuid);
-	int ret = ioctl(vcpu->fd, KVM_SET_GUEST_DEBUG, debug);
-
-	TEST_ASSERT(ret == 0, "KVM_SET_GUEST_DEBUG failed: %d", ret);
-}
-
-/*
- * VM VCPU Set MP State
- *
- * Input Args:
- *   vm - Virtual Machine
- *   vcpuid - VCPU ID
- *   mp_state - mp_state to be set
- *
- * Output Args: None
- *
- * Return: None
- *
- * Sets the MP state of the VCPU given by vcpuid, to the state given
- * by mp_state.
- */
-void vcpu_set_mp_state(struct kvm_vm *vm, uint32_t vcpuid,
-		       struct kvm_mp_state *mp_state)
-{
-	struct vcpu *vcpu = vcpu_find(vm, vcpuid);
-	int ret;
-
-	TEST_ASSERT(vcpu != NULL, "vcpu not found, vcpuid: %u", vcpuid);
-
-	ret = ioctl(vcpu->fd, KVM_SET_MP_STATE, mp_state);
-	TEST_ASSERT(ret == 0, "KVM_SET_MP_STATE IOCTL failed, "
-		"rc: %i errno: %i", ret, errno);
-}
-
 /*
  * VM VCPU Get Reg List
  *
@@ -1691,216 +1626,6 @@ struct kvm_reg_list *vcpu_get_reg_list(struct kvm_vm *vm, uint32_t vcpuid)
 	return reg_list;
 }
 
-/*
- * VM VCPU Regs Get
- *
- * Input Args:
- *   vm - Virtual Machine
- *   vcpuid - VCPU ID
- *
- * Output Args:
- *   regs - current state of VCPU regs
- *
- * Return: None
- *
- * Obtains the current register state for the VCPU specified by vcpuid
- * and stores it at the location given by regs.
- */
-void vcpu_regs_get(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_regs *regs)
-{
-	struct vcpu *vcpu = vcpu_find(vm, vcpuid);
-	int ret;
-
-	TEST_ASSERT(vcpu != NULL, "vcpu not found, vcpuid: %u", vcpuid);
-
-	ret = ioctl(vcpu->fd, KVM_GET_REGS, regs);
-	TEST_ASSERT(ret == 0, "KVM_GET_REGS failed, rc: %i errno: %i",
-		ret, errno);
-}
-
-/*
- * VM VCPU Regs Set
- *
- * Input Args:
- *   vm - Virtual Machine
- *   vcpuid - VCPU ID
- *   regs - Values to set VCPU regs to
- *
- * Output Args: None
- *
- * Return: None
- *
- * Sets the regs of the VCPU specified by vcpuid to the values
- * given by regs.
- */
-void vcpu_regs_set(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_regs *regs)
-{
-	struct vcpu *vcpu = vcpu_find(vm, vcpuid);
-	int ret;
-
-	TEST_ASSERT(vcpu != NULL, "vcpu not found, vcpuid: %u", vcpuid);
-
-	ret = ioctl(vcpu->fd, KVM_SET_REGS, regs);
-	TEST_ASSERT(ret == 0, "KVM_SET_REGS failed, rc: %i errno: %i",
-		ret, errno);
-}
-
-#ifdef __KVM_HAVE_VCPU_EVENTS
-void vcpu_events_get(struct kvm_vm *vm, uint32_t vcpuid,
-		     struct kvm_vcpu_events *events)
-{
-	struct vcpu *vcpu = vcpu_find(vm, vcpuid);
-	int ret;
-
-	TEST_ASSERT(vcpu != NULL, "vcpu not found, vcpuid: %u", vcpuid);
-
-	ret = ioctl(vcpu->fd, KVM_GET_VCPU_EVENTS, events);
-	TEST_ASSERT(ret == 0, "KVM_GET_VCPU_EVENTS, failed, rc: %i errno: %i",
-		ret, errno);
-}
-
-void vcpu_events_set(struct kvm_vm *vm, uint32_t vcpuid,
-		     struct kvm_vcpu_events *events)
-{
-	struct vcpu *vcpu = vcpu_find(vm, vcpuid);
-	int ret;
-
-	TEST_ASSERT(vcpu != NULL, "vcpu not found, vcpuid: %u", vcpuid);
-
-	ret = ioctl(vcpu->fd, KVM_SET_VCPU_EVENTS, events);
-	TEST_ASSERT(ret == 0, "KVM_SET_VCPU_EVENTS, failed, rc: %i errno: %i",
-		ret, errno);
-}
-#endif
-
-#ifdef __x86_64__
-void vcpu_nested_state_get(struct kvm_vm *vm, uint32_t vcpuid,
-			   struct kvm_nested_state *state)
-{
-	struct vcpu *vcpu = vcpu_find(vm, vcpuid);
-	int ret;
-
-	TEST_ASSERT(vcpu != NULL, "vcpu not found, vcpuid: %u", vcpuid);
-
-	ret = ioctl(vcpu->fd, KVM_GET_NESTED_STATE, state);
-	TEST_ASSERT(ret == 0,
-		"KVM_SET_NESTED_STATE failed, ret: %i errno: %i",
-		ret, errno);
-}
-
-int __vcpu_nested_state_set(struct kvm_vm *vm, uint32_t vcpuid,
-			    struct kvm_nested_state *state)
-{
-	struct vcpu *vcpu = vcpu_find(vm, vcpuid);
-
-	TEST_ASSERT(vcpu != NULL, "vcpu not found, vcpuid: %u", vcpuid);
-
-	return ioctl(vcpu->fd, KVM_SET_NESTED_STATE, state);
-}
-
-void vcpu_nested_state_set(struct kvm_vm *vm, uint32_t vcpuid,
-			   struct kvm_nested_state *state)
-{
-	int ret = __vcpu_nested_state_set(vm, vcpuid, state);
-
-	TEST_ASSERT(!ret, "KVM_SET_NESTED_STATE failed, ret: %i errno: %i", ret, errno);
-}
-#endif
-
-/*
- * VM VCPU System Regs Get
- *
- * Input Args:
- *   vm - Virtual Machine
- *   vcpuid - VCPU ID
- *
- * Output Args:
- *   sregs - current state of VCPU system regs
- *
- * Return: None
- *
- * Obtains the current system register state for the VCPU specified by
- * vcpuid and stores it at the location given by sregs.
- */
-void vcpu_sregs_get(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_sregs *sregs)
-{
-	struct vcpu *vcpu = vcpu_find(vm, vcpuid);
-	int ret;
-
-	TEST_ASSERT(vcpu != NULL, "vcpu not found, vcpuid: %u", vcpuid);
-
-	ret = ioctl(vcpu->fd, KVM_GET_SREGS, sregs);
-	TEST_ASSERT(ret == 0, "KVM_GET_SREGS failed, rc: %i errno: %i",
-		ret, errno);
-}
-
-/*
- * VM VCPU System Regs Set
- *
- * Input Args:
- *   vm - Virtual Machine
- *   vcpuid - VCPU ID
- *   sregs - Values to set VCPU system regs to
- *
- * Output Args: None
- *
- * Return: None
- *
- * Sets the system regs of the VCPU specified by vcpuid to the values
- * given by sregs.
- */
-void vcpu_sregs_set(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_sregs *sregs)
-{
-	int ret = _vcpu_sregs_set(vm, vcpuid, sregs);
-	TEST_ASSERT(ret == 0, "KVM_SET_SREGS IOCTL failed, "
-		"rc: %i errno: %i", ret, errno);
-}
-
-int _vcpu_sregs_set(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_sregs *sregs)
-{
-	struct vcpu *vcpu = vcpu_find(vm, vcpuid);
-
-	TEST_ASSERT(vcpu != NULL, "vcpu not found, vcpuid: %u", vcpuid);
-
-	return ioctl(vcpu->fd, KVM_SET_SREGS, sregs);
-}
-
-void vcpu_fpu_get(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_fpu *fpu)
-{
-	int ret;
-
-	ret = __vcpu_ioctl(vm, vcpuid, KVM_GET_FPU, fpu);
-	TEST_ASSERT(ret == 0, "KVM_GET_FPU failed, rc: %i errno: %i (%s)",
-		    ret, errno, strerror(errno));
-}
-
-void vcpu_fpu_set(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_fpu *fpu)
-{
-	int ret;
-
-	ret = __vcpu_ioctl(vm, vcpuid, KVM_SET_FPU, fpu);
-	TEST_ASSERT(ret == 0, "KVM_SET_FPU failed, rc: %i errno: %i (%s)",
-		    ret, errno, strerror(errno));
-}
-
-void vcpu_get_reg(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_one_reg *reg)
-{
-	int ret;
-
-	ret = __vcpu_ioctl(vm, vcpuid, KVM_GET_ONE_REG, reg);
-	TEST_ASSERT(ret == 0, "KVM_GET_ONE_REG failed, rc: %i errno: %i (%s)",
-		    ret, errno, strerror(errno));
-}
-
-void vcpu_set_reg(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_one_reg *reg)
-{
-	int ret;
-
-	ret = __vcpu_ioctl(vm, vcpuid, KVM_SET_ONE_REG, reg);
-	TEST_ASSERT(ret == 0, "KVM_SET_ONE_REG failed, rc: %i errno: %i (%s)",
-		    ret, errno, strerror(errno));
-}
-
 int __vcpu_ioctl(struct kvm_vm *vm, uint32_t vcpuid,
 		 unsigned long cmd, void *arg)
 {
@@ -2496,10 +2221,3 @@ int vm_get_stats_fd(struct kvm_vm *vm)
 {
 	return ioctl(vm->fd, KVM_GET_STATS_FD, NULL);
 }
-
-int vcpu_get_stats_fd(struct kvm_vm *vm, uint32_t vcpuid)
-{
-	struct vcpu *vcpu = vcpu_find(vm, vcpuid);
-
-	return ioctl(vcpu->fd, KVM_GET_STATS_FD, NULL);
-}
diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index 9f000dfb5594..fb05bed7ec1e 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -901,132 +901,37 @@ kvm_get_supported_cpuid_index(uint32_t function, uint32_t index)
 	return entry;
 }
 
-
-int __vcpu_set_cpuid(struct kvm_vm *vm, uint32_t vcpuid,
-		     struct kvm_cpuid2 *cpuid)
-{
-	struct vcpu *vcpu = vcpu_find(vm, vcpuid);
-
-	TEST_ASSERT(vcpu != NULL, "vcpu not found, vcpuid: %u", vcpuid);
-
-	return ioctl(vcpu->fd, KVM_SET_CPUID2, cpuid);
-}
-
-/*
- * VM VCPU CPUID Set
- *
- * Input Args:
- *   vm - Virtual Machine
- *   vcpuid - VCPU id
- *   cpuid - The CPUID values to set.
- *
- * Output Args: None
- *
- * Return: void
- *
- * Set the VCPU's CPUID.
- */
-void vcpu_set_cpuid(struct kvm_vm *vm,
-		uint32_t vcpuid, struct kvm_cpuid2 *cpuid)
-{
-	int rc;
-
-	rc = __vcpu_set_cpuid(vm, vcpuid, cpuid);
-	TEST_ASSERT(rc == 0, "KVM_SET_CPUID2 failed, rc: %i errno: %i",
-		    rc, errno);
-
-}
-
-/*
- * VCPU Get MSR
- *
- * Input Args:
- *   vm - Virtual Machine
- *   vcpuid - VCPU ID
- *   msr_index - Index of MSR
- *
- * Output Args: None
- *
- * Return: On success, value of the MSR. On failure a TEST_ASSERT is produced.
- *
- * Get value of MSR for VCPU.
- */
 uint64_t vcpu_get_msr(struct kvm_vm *vm, uint32_t vcpuid, uint64_t msr_index)
 {
-	struct vcpu *vcpu = vcpu_find(vm, vcpuid);
 	struct {
 		struct kvm_msrs header;
 		struct kvm_msr_entry entry;
 	} buffer = {};
 	int r;
 
-	TEST_ASSERT(vcpu != NULL, "vcpu not found, vcpuid: %u", vcpuid);
 	buffer.header.nmsrs = 1;
 	buffer.entry.index = msr_index;
-	r = ioctl(vcpu->fd, KVM_GET_MSRS, &buffer.header);
-	TEST_ASSERT(r == 1, "KVM_GET_MSRS IOCTL failed,\n"
-		"  rc: %i errno: %i", r, errno);
+
+	r = __vcpu_ioctl(vm, vcpuid, KVM_GET_MSRS, &buffer.header);
+	TEST_ASSERT(r == 1, KVM_IOCTL_ERROR(KVM_GET_MSRS, r));
 
 	return buffer.entry.data;
 }
 
-/*
- * _VCPU Set MSR
- *
- * Input Args:
- *   vm - Virtual Machine
- *   vcpuid - VCPU ID
- *   msr_index - Index of MSR
- *   msr_value - New value of MSR
- *
- * Output Args: None
- *
- * Return: The result of KVM_SET_MSRS.
- *
- * Sets the value of an MSR for the given VCPU.
- */
 int _vcpu_set_msr(struct kvm_vm *vm, uint32_t vcpuid, uint64_t msr_index,
 		  uint64_t msr_value)
 {
-	struct vcpu *vcpu = vcpu_find(vm, vcpuid);
 	struct {
 		struct kvm_msrs header;
 		struct kvm_msr_entry entry;
 	} buffer = {};
-	int r;
 
-	TEST_ASSERT(vcpu != NULL, "vcpu not found, vcpuid: %u", vcpuid);
 	memset(&buffer, 0, sizeof(buffer));
 	buffer.header.nmsrs = 1;
 	buffer.entry.index = msr_index;
 	buffer.entry.data = msr_value;
-	r = ioctl(vcpu->fd, KVM_SET_MSRS, &buffer.header);
-	return r;
-}
 
-/*
- * VCPU Set MSR
- *
- * Input Args:
- *   vm - Virtual Machine
- *   vcpuid - VCPU ID
- *   msr_index - Index of MSR
- *   msr_value - New value of MSR
- *
- * Output Args: None
- *
- * Return: On success, nothing. On failure a TEST_ASSERT is produced.
- *
- * Set value of MSR for VCPU.
- */
-void vcpu_set_msr(struct kvm_vm *vm, uint32_t vcpuid, uint64_t msr_index,
-	uint64_t msr_value)
-{
-	int r;
-
-	r = _vcpu_set_msr(vm, vcpuid, msr_index, msr_value);
-	TEST_ASSERT(r == 1, "KVM_SET_MSRS IOCTL failed,\n"
-		"  rc: %i errno: %i", r, errno);
+	return __vcpu_ioctl(vm, vcpuid, KVM_SET_MSRS, &buffer.header);
 }
 
 void vcpu_args_set(struct kvm_vm *vm, uint32_t vcpuid, unsigned int num, ...)
-- 
2.35.1.723.g4982287a31-goog


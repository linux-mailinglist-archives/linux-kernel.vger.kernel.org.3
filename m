Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25B024D5AD5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346564AbiCKFw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 00:52:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346518AbiCKFwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:52:15 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E636ECB28
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:51:12 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id y7-20020a626407000000b004f6d39f1b0fso4624192pfb.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=1YQu05ZjZIDjAKhhcQaIwwdAVFlEr0i1APQKfUMRuGA=;
        b=J1nzgrJ0gvXxJINzXXrbak4/+KicAbfXn005ALgbysdtqfrvUgknw+yFGBo6hL+e0p
         Q6McDn9HzoA7ifJjBK11eY7y41OhnZ4sYcylZOSoX51AadicClz7uGNQg3Z0Peo2PQYg
         p7o+syW/OQL/2S7w25M1yoJbsPuGKnMF//IvIjVO8B0xB2IyXcHyGx3N8uS5mIOp85ZZ
         S86BTiFtM6HQjwHvfB6Sqb2Q4T35bCwzge/ei5AkQscsNX0rfy0QGZXIoreKFzJr37Xs
         LKelRQSn4fpQfFRAnvelN5rAJioumZOHcFNeditbXMEX1meQ3gtBjLRwAYgyxxItU0i5
         YFFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=1YQu05ZjZIDjAKhhcQaIwwdAVFlEr0i1APQKfUMRuGA=;
        b=GFpBvYVPBvuVksVOy6qvGBbdbXMqCjSFHtc3NbWtCcdcdatwj/ry1VTRAvbQktRi3K
         VRg3eChoir4kUALPRt/BlQshaYXrHtXq3L9mPgwnbjEt/xliHzf5t6bq0XoPrnyU/EWk
         jOVNMn5qiA3OYOkWwYsEGyU222gv319ZHpW1XY/1YbDdC7F5kaF4jQgb63EHSRj/U+wN
         4Qj/QNnGITwsCWcptDqXz+Se7g6I8BB/Bu7VKQEotPj5NEO7lqwd6p1y3ybkrYxCLGGc
         PB4N/3vl85la9dqC4BdrSThNo/EE5KmbH1L6FWRHx6t9sUkiaPHBLnu1Hdag2NMQ55W1
         GRxA==
X-Gm-Message-State: AOAM531SmdxIeeZcVZyN/5LRZqpw/QVfmtBu2SRgyFSfdYAwkkCyhOzN
        fb4gUZs9f1vI8JgMPuSvkRBtwNtKEb+hL5PCKvEko7LKXkSFcpq/QlJ3fz+uspXQL7QTO0EkL4e
        1LYkq0hbC2xZtucHi5pLbXi7ypks6zok+YOxpl9dezLjK+Gmk8SVD7G38ZOk1j/cIszJgOA==
X-Google-Smtp-Source: ABdhPJzS8MUJHASK8RpsrldDPQRGh13Gd4OuNOZd0cOZ4sG4byqgvHPaDLBhETjHTHVf6qRfceUXJKAyub4=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:198b:b0:4f4:22f3:2fbb with SMTP id
 d11-20020a056a00198b00b004f422f32fbbmr8370157pfl.20.1646977871926; Thu, 10
 Mar 2022 21:51:11 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:49:14 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-4-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 003/105] KVM: selftest: Add another underscore to inner
 ioctl helpers
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
 .../selftests/kvm/aarch64/get-reg-list.c      |  6 ++---
 .../testing/selftests/kvm/aarch64/vgic_init.c |  2 +-
 .../selftests/kvm/include/kvm_util_base.h     |  8 +++----
 tools/testing/selftests/kvm/lib/kvm_util.c    | 24 +++++++++----------
 .../selftests/kvm/lib/riscv/processor.c       |  2 +-
 tools/testing/selftests/kvm/s390x/memop.c     | 14 +++++------
 tools/testing/selftests/kvm/s390x/resets.c    |  4 ++--
 tools/testing/selftests/kvm/steal_time.c      |  6 ++---
 .../selftests/kvm/x86_64/hyperv_cpuid.c       |  4 ++--
 .../selftests/kvm/x86_64/set_boot_cpu_id.c    |  6 ++---
 .../kvm/x86_64/vmx_nested_tsc_scaling_test.c  |  2 +-
 11 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/tools/testing/selftests/kvm/aarch64/get-reg-list.c b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
index 336de3e574d0..422f9a4792ba 100644
--- a/tools/testing/selftests/kvm/aarch64/get-reg-list.c
+++ b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
@@ -452,7 +452,7 @@ static void run_test(struct vcpu_config *c)
 		bool reject_reg = false;
 		int ret;
 
-		ret = _vcpu_ioctl(vm, 0, KVM_GET_ONE_REG, &reg);
+		ret = __vcpu_ioctl(vm, 0, KVM_GET_ONE_REG, &reg);
 		if (ret) {
 			printf("%s: Failed to get ", config_name(c));
 			print_reg(c, reg.id);
@@ -464,7 +464,7 @@ static void run_test(struct vcpu_config *c)
 		for_each_sublist(c, s) {
 			if (s->rejects_set && find_reg(s->rejects_set, s->rejects_set_n, reg.id)) {
 				reject_reg = true;
-				ret = _vcpu_ioctl(vm, 0, KVM_SET_ONE_REG, &reg);
+				ret = __vcpu_ioctl(vm, 0, KVM_SET_ONE_REG, &reg);
 				if (ret != -1 || errno != EPERM) {
 					printf("%s: Failed to reject (ret=%d, errno=%d) ", config_name(c), ret, errno);
 					print_reg(c, reg.id);
@@ -476,7 +476,7 @@ static void run_test(struct vcpu_config *c)
 		}
 
 		if (!reject_reg) {
-			ret = _vcpu_ioctl(vm, 0, KVM_SET_ONE_REG, &reg);
+			ret = __vcpu_ioctl(vm, 0, KVM_SET_ONE_REG, &reg);
 			if (ret) {
 				printf("%s: Failed to set ", config_name(c));
 				print_reg(c, reg.id);
diff --git a/tools/testing/selftests/kvm/aarch64/vgic_init.c b/tools/testing/selftests/kvm/aarch64/vgic_init.c
index 0f046e3e953d..373c8005c2e7 100644
--- a/tools/testing/selftests/kvm/aarch64/vgic_init.c
+++ b/tools/testing/selftests/kvm/aarch64/vgic_init.c
@@ -55,7 +55,7 @@ static void guest_code(void)
 static int run_vcpu(struct kvm_vm *vm, uint32_t vcpuid)
 {
 	ucall_init(vm, NULL);
-	int ret = _vcpu_ioctl(vm, vcpuid, KVM_RUN, NULL);
+	int ret = __vcpu_ioctl(vm, vcpuid, KVM_RUN, NULL);
 	if (ret)
 		return -errno;
 	return 0;
diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index bbc66442f91f..77aaac4d344e 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -154,12 +154,12 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
 
 void vcpu_ioctl(struct kvm_vm *vm, uint32_t vcpuid, unsigned long ioctl,
 		void *arg);
-int _vcpu_ioctl(struct kvm_vm *vm, uint32_t vcpuid, unsigned long ioctl,
-		void *arg);
+int __vcpu_ioctl(struct kvm_vm *vm, uint32_t vcpuid, unsigned long ioctl,
+		 void *arg);
 void vm_ioctl(struct kvm_vm *vm, unsigned long ioctl, void *arg);
-int _vm_ioctl(struct kvm_vm *vm, unsigned long cmd, void *arg);
+int __vm_ioctl(struct kvm_vm *vm, unsigned long cmd, void *arg);
 void kvm_ioctl(struct kvm_vm *vm, unsigned long ioctl, void *arg);
-int _kvm_ioctl(struct kvm_vm *vm, unsigned long ioctl, void *arg);
+int __kvm_ioctl(struct kvm_vm *vm, unsigned long ioctl, void *arg);
 void vm_mem_region_set_flags(struct kvm_vm *vm, uint32_t slot, uint32_t flags);
 void vm_mem_region_move(struct kvm_vm *vm, uint32_t slot, uint64_t new_gpa);
 void vm_mem_region_delete(struct kvm_vm *vm, uint32_t slot);
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 3e9654e65a67..6f515333abe0 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1680,7 +1680,7 @@ struct kvm_reg_list *vcpu_get_reg_list(struct kvm_vm *vm, uint32_t vcpuid)
 	struct kvm_reg_list reg_list_n = { .n = 0 }, *reg_list;
 	int ret;
 
-	ret = _vcpu_ioctl(vm, vcpuid, KVM_GET_REG_LIST, &reg_list_n);
+	ret = __vcpu_ioctl(vm, vcpuid, KVM_GET_REG_LIST, &reg_list_n);
 	TEST_ASSERT(ret == -1 && errno == E2BIG, "KVM_GET_REG_LIST n=0");
 	reg_list = calloc(1, sizeof(*reg_list) + reg_list_n.n * sizeof(__u64));
 	reg_list->n = reg_list_n.n;
@@ -1866,7 +1866,7 @@ void vcpu_fpu_get(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_fpu *fpu)
 {
 	int ret;
 
-	ret = _vcpu_ioctl(vm, vcpuid, KVM_GET_FPU, fpu);
+	ret = __vcpu_ioctl(vm, vcpuid, KVM_GET_FPU, fpu);
 	TEST_ASSERT(ret == 0, "KVM_GET_FPU failed, rc: %i errno: %i (%s)",
 		    ret, errno, strerror(errno));
 }
@@ -1875,7 +1875,7 @@ void vcpu_fpu_set(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_fpu *fpu)
 {
 	int ret;
 
-	ret = _vcpu_ioctl(vm, vcpuid, KVM_SET_FPU, fpu);
+	ret = __vcpu_ioctl(vm, vcpuid, KVM_SET_FPU, fpu);
 	TEST_ASSERT(ret == 0, "KVM_SET_FPU failed, rc: %i errno: %i (%s)",
 		    ret, errno, strerror(errno));
 }
@@ -1884,7 +1884,7 @@ void vcpu_get_reg(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_one_reg *reg)
 {
 	int ret;
 
-	ret = _vcpu_ioctl(vm, vcpuid, KVM_GET_ONE_REG, reg);
+	ret = __vcpu_ioctl(vm, vcpuid, KVM_GET_ONE_REG, reg);
 	TEST_ASSERT(ret == 0, "KVM_GET_ONE_REG failed, rc: %i errno: %i (%s)",
 		    ret, errno, strerror(errno));
 }
@@ -1893,7 +1893,7 @@ void vcpu_set_reg(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_one_reg *reg)
 {
 	int ret;
 
-	ret = _vcpu_ioctl(vm, vcpuid, KVM_SET_ONE_REG, reg);
+	ret = __vcpu_ioctl(vm, vcpuid, KVM_SET_ONE_REG, reg);
 	TEST_ASSERT(ret == 0, "KVM_SET_ONE_REG failed, rc: %i errno: %i (%s)",
 		    ret, errno, strerror(errno));
 }
@@ -1916,13 +1916,13 @@ void vcpu_ioctl(struct kvm_vm *vm, uint32_t vcpuid,
 {
 	int ret;
 
-	ret = _vcpu_ioctl(vm, vcpuid, cmd, arg);
+	ret = __vcpu_ioctl(vm, vcpuid, cmd, arg);
 	TEST_ASSERT(ret == 0, "vcpu ioctl %lu failed, rc: %i errno: %i (%s)",
 		cmd, ret, errno, strerror(errno));
 }
 
-int _vcpu_ioctl(struct kvm_vm *vm, uint32_t vcpuid,
-		unsigned long cmd, void *arg)
+int __vcpu_ioctl(struct kvm_vm *vm, uint32_t vcpuid,
+		 unsigned long cmd, void *arg)
 {
 	struct vcpu *vcpu = vcpu_find(vm, vcpuid);
 	int ret;
@@ -1986,12 +1986,12 @@ void vm_ioctl(struct kvm_vm *vm, unsigned long cmd, void *arg)
 {
 	int ret;
 
-	ret = _vm_ioctl(vm, cmd, arg);
+	ret = __vm_ioctl(vm, cmd, arg);
 	TEST_ASSERT(ret == 0, "vm ioctl %lu failed, rc: %i errno: %i (%s)",
 		cmd, ret, errno, strerror(errno));
 }
 
-int _vm_ioctl(struct kvm_vm *vm, unsigned long cmd, void *arg)
+int __vm_ioctl(struct kvm_vm *vm, unsigned long cmd, void *arg)
 {
 	return ioctl(vm->fd, cmd, arg);
 }
@@ -2017,7 +2017,7 @@ void kvm_ioctl(struct kvm_vm *vm, unsigned long cmd, void *arg)
 		cmd, ret, errno, strerror(errno));
 }
 
-int _kvm_ioctl(struct kvm_vm *vm, unsigned long cmd, void *arg)
+int __kvm_ioctl(struct kvm_vm *vm, unsigned long cmd, void *arg)
 {
 	return ioctl(vm->kvm_fd, cmd, arg);
 }
@@ -2146,7 +2146,7 @@ int _kvm_irq_line(struct kvm_vm *vm, uint32_t irq, int level)
 		.level  = level,
 	};
 
-	return _vm_ioctl(vm, KVM_IRQ_LINE, &irq_level);
+	return __vm_ioctl(vm, KVM_IRQ_LINE, &irq_level);
 }
 
 void kvm_irq_line(struct kvm_vm *vm, uint32_t irq, int level)
diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tools/testing/selftests/kvm/lib/riscv/processor.c
index d377f2603d98..1a404749094a 100644
--- a/tools/testing/selftests/kvm/lib/riscv/processor.c
+++ b/tools/testing/selftests/kvm/lib/riscv/processor.c
@@ -294,7 +294,7 @@ void vm_vcpu_add_default(struct kvm_vm *vm, uint32_t vcpuid, void *guest_code)
 	 * are powered-on using KVM_SET_MP_STATE ioctl().
 	 */
 	mps.mp_state = KVM_MP_STATE_RUNNABLE;
-	r = _vcpu_ioctl(vm, vcpuid, KVM_SET_MP_STATE, &mps);
+	r = __vcpu_ioctl(vm, vcpuid, KVM_SET_MP_STATE, &mps);
 	TEST_ASSERT(!r, "IOCTL KVM_SET_MP_STATE failed (error %d)", r);
 
 	/* Setup global pointer of guest to be same as the host */
diff --git a/tools/testing/selftests/kvm/s390x/memop.c b/tools/testing/selftests/kvm/s390x/memop.c
index 9f49ead380ab..460799cc2098 100644
--- a/tools/testing/selftests/kvm/s390x/memop.c
+++ b/tools/testing/selftests/kvm/s390x/memop.c
@@ -90,7 +90,7 @@ int main(int argc, char *argv[])
 	ksmo.op = KVM_S390_MEMOP_LOGICAL_WRITE;
 	ksmo.buf = (uintptr_t)mem1;
 	ksmo.ar = 0;
-	rv = _vcpu_ioctl(vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
+	rv = __vcpu_ioctl(vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
 	TEST_ASSERT(rv == -1 && errno == E2BIG, "ioctl allows insane sizes");
 
 	/* Zero size: */
@@ -100,7 +100,7 @@ int main(int argc, char *argv[])
 	ksmo.op = KVM_S390_MEMOP_LOGICAL_WRITE;
 	ksmo.buf = (uintptr_t)mem1;
 	ksmo.ar = 0;
-	rv = _vcpu_ioctl(vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
+	rv = __vcpu_ioctl(vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
 	TEST_ASSERT(rv == -1 && (errno == EINVAL || errno == ENOMEM),
 		    "ioctl allows 0 as size");
 
@@ -111,7 +111,7 @@ int main(int argc, char *argv[])
 	ksmo.op = KVM_S390_MEMOP_LOGICAL_WRITE;
 	ksmo.buf = (uintptr_t)mem1;
 	ksmo.ar = 0;
-	rv = _vcpu_ioctl(vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
+	rv = __vcpu_ioctl(vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
 	TEST_ASSERT(rv == -1 && errno == EINVAL, "ioctl allows all flags");
 
 	/* Bad operation: */
@@ -121,7 +121,7 @@ int main(int argc, char *argv[])
 	ksmo.op = -1;
 	ksmo.buf = (uintptr_t)mem1;
 	ksmo.ar = 0;
-	rv = _vcpu_ioctl(vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
+	rv = __vcpu_ioctl(vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
 	TEST_ASSERT(rv == -1 && errno == EINVAL, "ioctl allows bad operations");
 
 	/* Bad guest address: */
@@ -131,7 +131,7 @@ int main(int argc, char *argv[])
 	ksmo.op = KVM_S390_MEMOP_LOGICAL_WRITE;
 	ksmo.buf = (uintptr_t)mem1;
 	ksmo.ar = 0;
-	rv = _vcpu_ioctl(vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
+	rv = __vcpu_ioctl(vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
 	TEST_ASSERT(rv > 0, "ioctl does not report bad guest memory access");
 
 	/* Bad host address: */
@@ -141,7 +141,7 @@ int main(int argc, char *argv[])
 	ksmo.op = KVM_S390_MEMOP_LOGICAL_WRITE;
 	ksmo.buf = 0;
 	ksmo.ar = 0;
-	rv = _vcpu_ioctl(vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
+	rv = __vcpu_ioctl(vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
 	TEST_ASSERT(rv == -1 && errno == EFAULT,
 		    "ioctl does not report bad host memory address");
 
@@ -155,7 +155,7 @@ int main(int argc, char *argv[])
 	ksmo.op = KVM_S390_MEMOP_LOGICAL_WRITE;
 	ksmo.buf = (uintptr_t)mem1;
 	ksmo.ar = 17;
-	rv = _vcpu_ioctl(vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
+	rv = __vcpu_ioctl(vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
 	TEST_ASSERT(rv == -1 && errno == EINVAL, "ioctl allows ARs > 15");
 	run->psw_mask &= ~(3UL << (63 - 17));   /* Disable AR mode */
 	vcpu_run(vm, VCPU_ID);                  /* Run to sync new state */
diff --git a/tools/testing/selftests/kvm/s390x/resets.c b/tools/testing/selftests/kvm/s390x/resets.c
index b143db6d8693..cc4b7c86d69f 100644
--- a/tools/testing/selftests/kvm/s390x/resets.c
+++ b/tools/testing/selftests/kvm/s390x/resets.c
@@ -76,7 +76,7 @@ static void assert_noirq(void)
 
 	irq_state.len = sizeof(buf);
 	irq_state.buf = (unsigned long)buf;
-	irqs = _vcpu_ioctl(vm, VCPU_ID, KVM_S390_GET_IRQ_STATE, &irq_state);
+	irqs = __vcpu_ioctl(vm, VCPU_ID, KVM_S390_GET_IRQ_STATE, &irq_state);
 	/*
 	 * irqs contains the number of retrieved interrupts. Any interrupt
 	 * (notably, the emergency call interrupt we have injected) should
@@ -196,7 +196,7 @@ static void inject_irq(int cpu_id)
 	irq_state.buf = (unsigned long)buf;
 	irq->type = KVM_S390_INT_EMERGENCY;
 	irq->u.emerg.code = cpu_id;
-	irqs = _vcpu_ioctl(vm, cpu_id, KVM_S390_SET_IRQ_STATE, &irq_state);
+	irqs = __vcpu_ioctl(vm, cpu_id, KVM_S390_SET_IRQ_STATE, &irq_state);
 	TEST_ASSERT(irqs >= 0, "Error injecting EMERGENCY IRQ errno %d\n", errno);
 }
 
diff --git a/tools/testing/selftests/kvm/steal_time.c b/tools/testing/selftests/kvm/steal_time.c
index 62f2eb9ee3d5..1d6a91a53eae 100644
--- a/tools/testing/selftests/kvm/steal_time.c
+++ b/tools/testing/selftests/kvm/steal_time.c
@@ -173,7 +173,7 @@ static void steal_time_init(struct kvm_vm *vm)
 	};
 	int i, ret;
 
-	ret = _vcpu_ioctl(vm, 0, KVM_HAS_DEVICE_ATTR, &dev);
+	ret = __vcpu_ioctl(vm, 0, KVM_HAS_DEVICE_ATTR, &dev);
 	if (ret != 0 && errno == ENXIO) {
 		print_skip("steal-time not supported");
 		exit(KSFT_SKIP);
@@ -191,13 +191,13 @@ static void steal_time_init(struct kvm_vm *vm)
 		sync_global_to_guest(vm, st_gva[i]);
 
 		st_ipa = (ulong)st_gva[i] | 1;
-		ret = _vcpu_ioctl(vm, i, KVM_SET_DEVICE_ATTR, &dev);
+		ret = __vcpu_ioctl(vm, i, KVM_SET_DEVICE_ATTR, &dev);
 		TEST_ASSERT(ret == -1 && errno == EINVAL, "Bad IPA didn't report EINVAL");
 
 		st_ipa = (ulong)st_gva[i];
 		vcpu_ioctl(vm, i, KVM_SET_DEVICE_ATTR, &dev);
 
-		ret = _vcpu_ioctl(vm, i, KVM_SET_DEVICE_ATTR, &dev);
+		ret = __vcpu_ioctl(vm, i, KVM_SET_DEVICE_ATTR, &dev);
 		TEST_ASSERT(ret == -1 && errno == EEXIST, "Set IPA twice without EEXIST");
 
 	}
diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c b/tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c
index 8c245ab2d98a..7e45a3df8f98 100644
--- a/tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c
+++ b/tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c
@@ -121,9 +121,9 @@ void test_hv_cpuid_e2big(struct kvm_vm *vm, bool system)
 	int ret;
 
 	if (!system)
-		ret = _vcpu_ioctl(vm, VCPU_ID, KVM_GET_SUPPORTED_HV_CPUID, &cpuid);
+		ret = __vcpu_ioctl(vm, VCPU_ID, KVM_GET_SUPPORTED_HV_CPUID, &cpuid);
 	else
-		ret = _kvm_ioctl(vm, KVM_GET_SUPPORTED_HV_CPUID, &cpuid);
+		ret = __kvm_ioctl(vm, KVM_GET_SUPPORTED_HV_CPUID, &cpuid);
 
 	TEST_ASSERT(ret == -1 && errno == E2BIG,
 		    "%s KVM_GET_SUPPORTED_HV_CPUID didn't fail with -E2BIG when"
diff --git a/tools/testing/selftests/kvm/x86_64/set_boot_cpu_id.c b/tools/testing/selftests/kvm/x86_64/set_boot_cpu_id.c
index 2fe893ccedd0..ee3d058a9fe1 100644
--- a/tools/testing/selftests/kvm/x86_64/set_boot_cpu_id.c
+++ b/tools/testing/selftests/kvm/x86_64/set_boot_cpu_id.c
@@ -42,7 +42,7 @@ static void test_set_boot_busy(struct kvm_vm *vm)
 {
 	int res;
 
-	res = _vm_ioctl(vm, KVM_SET_BOOT_CPU_ID, (void *) VCPU_ID0);
+	res = __vm_ioctl(vm, KVM_SET_BOOT_CPU_ID, (void *) VCPU_ID0);
 	TEST_ASSERT(res == -1 && errno == EBUSY,
 			"KVM_SET_BOOT_CPU_ID set while running vm");
 }
@@ -133,13 +133,13 @@ static void check_set_bsp_busy(void)
 	add_x86_vcpu(vm, VCPU_ID0, true);
 	add_x86_vcpu(vm, VCPU_ID1, false);
 
-	res = _vm_ioctl(vm, KVM_SET_BOOT_CPU_ID, (void *) VCPU_ID1);
+	res = __vm_ioctl(vm, KVM_SET_BOOT_CPU_ID, (void *) VCPU_ID1);
 	TEST_ASSERT(res == -1 && errno == EBUSY, "KVM_SET_BOOT_CPU_ID set after adding vcpu");
 
 	run_vcpu(vm, VCPU_ID0);
 	run_vcpu(vm, VCPU_ID1);
 
-	res = _vm_ioctl(vm, KVM_SET_BOOT_CPU_ID, (void *) VCPU_ID1);
+	res = __vm_ioctl(vm, KVM_SET_BOOT_CPU_ID, (void *) VCPU_ID1);
 	TEST_ASSERT(res == -1 && errno == EBUSY, "KVM_SET_BOOT_CPU_ID set to a terminated vcpu");
 
 	kvm_vm_free(vm);
diff --git a/tools/testing/selftests/kvm/x86_64/vmx_nested_tsc_scaling_test.c b/tools/testing/selftests/kvm/x86_64/vmx_nested_tsc_scaling_test.c
index 280c01fd2412..c35ada9f7f9c 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_nested_tsc_scaling_test.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_nested_tsc_scaling_test.c
@@ -186,7 +186,7 @@ int main(int argc, char *argv[])
 	vcpu_alloc_vmx(vm, &vmx_pages_gva);
 	vcpu_args_set(vm, VCPU_ID, 1, vmx_pages_gva);
 
-	tsc_khz = _vcpu_ioctl(vm, VCPU_ID, KVM_GET_TSC_KHZ, NULL);
+	tsc_khz = __vcpu_ioctl(vm, VCPU_ID, KVM_GET_TSC_KHZ, NULL);
 	TEST_ASSERT(tsc_khz != -1, "vcpu ioctl KVM_GET_TSC_KHZ failed");
 
 	/* scale down L1's TSC frequency */
-- 
2.35.1.723.g4982287a31-goog


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA044D5AEC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346796AbiCKFzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 00:55:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346639AbiCKFw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:52:58 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6435ECC63
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:51:55 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id u4-20020a63b544000000b0037c62d8b0ecso4220634pgo.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=l3UHYcPKeBd+OR5S1cLbaep2Sx81Dz0y9bty361aqfc=;
        b=jyfPOLiM1JZ9rgvPiMtETMD/PbBWyD47C7qF+WaoiCG58xJ2cM42CN+jBdq0Eg/Z8Y
         AbsfI6kYWaYFlNiXdV9NCihlT6xATtHvFwblc2y3ou+mUexHnhyIrTiRIaAHHrVsRPq2
         Y8nDU8cF7gYLlx8dLscz+hhzfsf4e1IHmtV41soSVLRYR3KZHRPzPy9hiY/xzIm5rVHg
         k3S4YuIqsxMb2bUgDQ3QMWPIUPzK6uhXKwUVb8vyi4GAWVaKZN8zvOtlk6/GZ00MbzhN
         dq8SwpEdUyICR7kclVBpqlPV4/gv/MUIJ/gjHqhQq89RDC/X9vZNIVIzROtJ+Zc9PYIz
         YTWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=l3UHYcPKeBd+OR5S1cLbaep2Sx81Dz0y9bty361aqfc=;
        b=JqtUblr7FYSuTnzrHvnl5/5rtsORa8dnOScbeYVPISH1wwzFIeTDk7Scv6fYim2dYM
         0q++j+5UXKJF2WPpb4GDVG88hkt7PjzOcr2vLxjRKRFvMaCr40tTpSRI5Tok0gTbi2MR
         OUOswAgAyHcKtQOWNQtuzWfq6PYq+riPVQRMRM4bZWc79MGUa5Imug0xmor0pFz3YEH2
         fB7/rRqOJyimGF7sf0BSmp+d/TAVyOhFlq4RlBQL2CjRCmRMqcmXsOwLLM9F+Uqvoczz
         rQSA9Zp+2kAvGcAPh/3grFd7plD7soatq34ii/EUDMXmk89UvqwqJJ5B1/MagZ8W6xQ0
         x4hA==
X-Gm-Message-State: AOAM532ezrYH67aZ1oAsNpJ3GXuIiKY3IFldZR1I6jMMjf4eY4WputFH
        +1iSBCSleCqDAHwL65eqiHVejK5D61smqkTYckNLk9lZOPI5D0d2gt8GYRcoGqsJ+33F4mqvSYJ
        u6UIMI3j6Onmq1lkg8hoW2G1WVcdMrfgLR9Ecocg+eD4/s/jz2d6k5s+lEJaBocPI5UtnPw==
X-Google-Smtp-Source: ABdhPJyu12cZ8EJ+tTNEMmGFJvd52UW2OADoDuw0kPgbI7aRc2bwQVsUM2wYnENqP/ggm00LN0xsSlX8Fu4=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:903:24e:b0:151:9fa5:ebdd with SMTP id
 j14-20020a170903024e00b001519fa5ebddmr8960233plh.84.1646977915088; Thu, 10
 Mar 2022 21:51:55 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:49:40 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-30-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 029/105] KVM: selftests: Rename 'struct vcpu' to 'struct kvm_vcpu'
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
 .../selftests/kvm/include/kvm_util_base.h     | 11 ++++---
 tools/testing/selftests/kvm/lib/kvm_util.c    | 32 +++++++++----------
 .../selftests/kvm/lib/s390x/processor.c       |  2 +-
 .../selftests/kvm/lib/x86_64/processor.c      |  8 ++---
 4 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index a71b532f07b2..bf9fe3b17705 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -16,6 +16,7 @@
 #include <linux/kvm.h>
 #include "linux/rbtree.h"
 
+
 #include <sys/ioctl.h>
 
 #include "sparsebit.h"
@@ -43,7 +44,7 @@ struct userspace_mem_region {
 	struct hlist_node slot_node;
 };
 
-struct vcpu {
+struct kvm_vcpu {
 	struct list_head list;
 	uint32_t id;
 	int fd;
@@ -92,7 +93,7 @@ struct kvm_vm {
 			continue;			\
 		else
 
-struct vcpu *vcpu_get(struct kvm_vm *vm, uint32_t vcpuid);
+struct kvm_vcpu *vcpu_get(struct kvm_vm *vm, uint32_t vcpuid);
 
 /*
  * Virtual Translation Tables Dump
@@ -624,17 +625,17 @@ struct kvm_vm *vm_create_with_vcpus(enum vm_guest_mode mode, uint32_t nr_vcpus,
  * Create a VM with a single vCPU with reasonable defaults and @extra_mem_pages
  * additional pages of guest memory.  Returns the VM and vCPU (via out param).
  */
-struct kvm_vm *__vm_create_with_one_vcpu(struct vcpu **vcpu,
+struct kvm_vm *__vm_create_with_one_vcpu(struct kvm_vcpu **vcpu,
 					 uint64_t extra_mem_pages,
 					 void *guest_code);
 
-static inline struct kvm_vm *vm_create_with_one_vcpu(struct vcpu **vcpu,
+static inline struct kvm_vm *vm_create_with_one_vcpu(struct kvm_vcpu **vcpu,
 						     void *guest_code)
 {
 	return __vm_create_with_one_vcpu(vcpu, 0, guest_code);
 }
 
-struct vcpu *vm_recreate_with_one_vcpu(struct kvm_vm *vm);
+struct kvm_vcpu *vm_recreate_with_one_vcpu(struct kvm_vm *vm);
 
 /*
  * Adds a vCPU with reasonable defaults (e.g. a stack)
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index d164b3962bb7..7ce12a163483 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -365,7 +365,7 @@ struct kvm_vm *vm_create_default(uint32_t vcpuid, uint64_t extra_mem_pages,
 					    (uint32_t []){ vcpuid });
 }
 
-struct kvm_vm *__vm_create_with_one_vcpu(struct vcpu **vcpu,
+struct kvm_vm *__vm_create_with_one_vcpu(struct kvm_vcpu **vcpu,
 					 uint64_t extra_mem_pages,
 					 void *guest_code)
 {
@@ -409,7 +409,7 @@ void kvm_vm_restart(struct kvm_vm *vmp)
 	}
 }
 
-struct vcpu *vm_recreate_with_one_vcpu(struct kvm_vm *vm)
+struct kvm_vcpu *vm_recreate_with_one_vcpu(struct kvm_vm *vm)
 {
 	kvm_vm_restart(vm);
 
@@ -488,23 +488,23 @@ kvm_userspace_memory_region_find(struct kvm_vm *vm, uint64_t start,
 	return &region->region;
 }
 
-static struct vcpu *vcpu_find(struct kvm_vm *vm, uint32_t vcpuid)
+static struct kvm_vcpu *vcpu_find(struct kvm_vm *vm, uint32_t vcpu_id)
 {
-	struct vcpu *vcpu;
+	struct kvm_vcpu *vcpu;
 
 	list_for_each_entry(vcpu, &vm->vcpus, list) {
-		if (vcpu->id == vcpuid)
+		if (vcpu->id == vcpu_id)
 			return vcpu;
 	}
 
 	return NULL;
 }
 
-struct vcpu *vcpu_get(struct kvm_vm *vm, uint32_t vcpuid)
+struct kvm_vcpu *vcpu_get(struct kvm_vm *vm, uint32_t vcpu_id)
 {
-	struct vcpu *vcpu = vcpu_find(vm, vcpuid);
+	struct kvm_vcpu *vcpu = vcpu_find(vm, vcpu_id);
 
-	TEST_ASSERT(vcpu, "vCPU %d does not exist", vcpuid);
+	TEST_ASSERT(vcpu, "vCPU %d does not exist", vcpu_id);
 	return vcpu;
 }
 
@@ -520,7 +520,7 @@ struct vcpu *vcpu_get(struct kvm_vm *vm, uint32_t vcpuid)
  *
  * Removes a vCPU from a VM and frees its resources.
  */
-static void vm_vcpu_rm(struct kvm_vm *vm, struct vcpu *vcpu)
+static void vm_vcpu_rm(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
 {
 	int ret;
 
@@ -544,7 +544,7 @@ static void vm_vcpu_rm(struct kvm_vm *vm, struct vcpu *vcpu)
 
 void kvm_vm_release(struct kvm_vm *vmp)
 {
-	struct vcpu *vcpu, *tmp;
+	struct kvm_vcpu *vcpu, *tmp;
 	int ret;
 
 	list_for_each_entry_safe(vcpu, tmp, &vmp->vcpus, list)
@@ -1073,7 +1073,7 @@ static int vcpu_mmap_sz(void)
  */
 void vm_vcpu_add(struct kvm_vm *vm, uint32_t vcpuid)
 {
-	struct vcpu *vcpu;
+	struct kvm_vcpu *vcpu;
 
 	/* Confirm a vcpu with the specified id doesn't already exist. */
 	TEST_ASSERT(!vcpu_find(vm, vcpuid), "vCPU%d already exists\n", vcpuid);
@@ -1448,7 +1448,7 @@ void vm_create_irqchip(struct kvm_vm *vm)
  */
 struct kvm_run *vcpu_state(struct kvm_vm *vm, uint32_t vcpuid)
 {
-	struct vcpu *vcpu = vcpu_get(vm, vcpuid);
+	struct kvm_vcpu *vcpu = vcpu_get(vm, vcpuid);
 
 	return vcpu->run;
 }
@@ -1489,7 +1489,7 @@ int _vcpu_run(struct kvm_vm *vm, uint32_t vcpuid)
 
 void vcpu_run_complete_io(struct kvm_vm *vm, uint32_t vcpuid)
 {
-	struct vcpu *vcpu = vcpu_get(vm, vcpuid);
+	struct kvm_vcpu *vcpu = vcpu_get(vm, vcpuid);
 	int ret;
 
 	vcpu->run->immediate_exit = 1;
@@ -1533,7 +1533,7 @@ struct kvm_reg_list *vcpu_get_reg_list(struct kvm_vm *vm, uint32_t vcpuid)
 int __vcpu_ioctl(struct kvm_vm *vm, uint32_t vcpuid,
 		 unsigned long cmd, void *arg)
 {
-	struct vcpu *vcpu = vcpu_get(vm, vcpuid);
+	struct kvm_vcpu *vcpu = vcpu_get(vm, vcpuid);
 
 	return ioctl(vcpu->fd, cmd, arg);
 }
@@ -1548,7 +1548,7 @@ void _vcpu_ioctl(struct kvm_vm *vm, uint32_t vcpuid, unsigned long cmd,
 
 void *vcpu_map_dirty_ring(struct kvm_vm *vm, uint32_t vcpuid)
 {
-	struct vcpu *vcpu = vcpu_get(vm, vcpuid);
+	struct kvm_vcpu *vcpu = vcpu_get(vm, vcpuid);
 	uint32_t size = vm->dirty_ring_size;
 
 	TEST_ASSERT(size > 0, "Should enable dirty ring first");
@@ -1765,7 +1765,7 @@ void vm_dump(FILE *stream, struct kvm_vm *vm, uint8_t indent)
 {
 	int ctr;
 	struct userspace_mem_region *region;
-	struct vcpu *vcpu;
+	struct kvm_vcpu *vcpu;
 
 	fprintf(stream, "%*smode: 0x%x\n", indent, "", vm->mode);
 	fprintf(stream, "%*sfd: %i\n", indent, "", vm->fd);
diff --git a/tools/testing/selftests/kvm/lib/s390x/processor.c b/tools/testing/selftests/kvm/lib/s390x/processor.c
index df9d9650d916..aec15ca9d887 100644
--- a/tools/testing/selftests/kvm/lib/s390x/processor.c
+++ b/tools/testing/selftests/kvm/lib/s390x/processor.c
@@ -207,7 +207,7 @@ void vcpu_args_set(struct kvm_vm *vm, uint32_t vcpuid, unsigned int num, ...)
 
 void vcpu_dump(FILE *stream, struct kvm_vm *vm, uint32_t vcpuid, uint8_t indent)
 {
-	struct vcpu *vcpu = vcpu_get(vm, vcpuid);
+	struct kvm_vcpu *vcpu = vcpu_get(vm, vcpuid);
 
 	fprintf(stream, "%*spstate: psw: 0x%.16llx:0x%.16llx\n",
 		indent, "", vcpu->run->psw_mask, vcpu->run->psw_addr);
diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index e9b3f254e8f9..289a73262f8c 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -805,7 +805,7 @@ uint64_t kvm_get_feature_msr(uint64_t msr_index)
  */
 struct kvm_cpuid2 *vcpu_get_cpuid(struct kvm_vm *vm, uint32_t vcpuid)
 {
-	struct vcpu *vcpu = vcpu_get(vm, vcpuid);
+	struct kvm_vcpu *vcpu = vcpu_get(vm, vcpuid);
 	struct kvm_cpuid2 *cpuid;
 	int max_ent;
 	int rc = -1;
@@ -982,7 +982,7 @@ struct kvm_msr_list *kvm_get_msr_index_list(void)
 	return list;
 }
 
-static int vcpu_save_xsave_state(struct kvm_vm *vm, struct vcpu *vcpu,
+static int vcpu_save_xsave_state(struct kvm_vm *vm, struct kvm_vcpu *vcpu,
 				 struct kvm_x86_state *state)
 {
 	int size;
@@ -1000,7 +1000,7 @@ static int vcpu_save_xsave_state(struct kvm_vm *vm, struct vcpu *vcpu,
 
 struct kvm_x86_state *vcpu_save_state(struct kvm_vm *vm, uint32_t vcpuid)
 {
-	struct vcpu *vcpu = vcpu_get(vm, vcpuid);
+	struct kvm_vcpu *vcpu = vcpu_get(vm, vcpuid);
 	struct kvm_msr_list *list;
 	struct kvm_x86_state *state;
 	int nmsrs, r, i;
@@ -1081,7 +1081,7 @@ struct kvm_x86_state *vcpu_save_state(struct kvm_vm *vm, uint32_t vcpuid)
 
 void vcpu_load_state(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_x86_state *state)
 {
-	struct vcpu *vcpu = vcpu_get(vm, vcpuid);
+	struct kvm_vcpu *vcpu = vcpu_get(vm, vcpuid);
 	int r;
 
 	r = ioctl(vcpu->fd, KVM_SET_SREGS, &state->sregs);
-- 
2.35.1.723.g4982287a31-goog


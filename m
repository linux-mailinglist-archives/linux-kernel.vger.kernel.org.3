Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D92384D5AE3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346718AbiCKFyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 00:54:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346604AbiCKFwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:52:43 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DAE8F119D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:51:36 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id u4-20020a63b544000000b0037c62d8b0ecso4220325pgo.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=83ox6MFG0EX4V2yEKmicUksG2rfzlzzM1E5YxwUEA4Q=;
        b=VcjJlw1fpl5emaHSGbqT6XdvxtzWzgDYRmg7UBnEB2LZWC0zekMAsnATxrnTaWYHqR
         icwsuR4u9obW+FzOaw/2vACjE9lvR8fN3TigNUud9OulhcQ/iEnxOV9msDqxyGMz83Py
         bUA6gQIfW6+Pssmj7xO18Z+Rb7yP+rW/+i7SjMuv4LdHZFc+qFgVz3UwJ4yAHiAtq6Go
         QzDiw7j2ccAKpa3+uFG5ruYbtFvu+aE0DRTgx7X6EGLJzmdWphFw/1lFV6sinp1j+sZZ
         otU07GVpPGj+q8mckaWoPgZs4wSOMiJdkQ36vIKTPi/SD0kD9paVvLNqBzB+krK/HhEH
         wKlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=83ox6MFG0EX4V2yEKmicUksG2rfzlzzM1E5YxwUEA4Q=;
        b=zGkcyPHOCJLwZWumAMG71z6Jvs51dEjk/VX9PTV/9z8MMDNSUi+hqTeZ0Kp03aoLaV
         BcCOHS/dBZFeRH3jnUFWEO7NnJ5lTgYOHbeQtBmGMItdDO3hRl1aaHh1MFb7KrM719Dx
         ymdrQ5ZgAndTPtaahPrnZ+mLvhwSPSNVTgj3nKYQYFJJJy0+1h8kiUzU50fSzvLmjCi1
         rJEiz2CK5MxYyRQgJxT5mPdAK4EMjd4cifzMiitzz2TDK7W5fd64+p4JNuTuFfaVkxqV
         Zvaee+Dbj7OARGSvzxejWyWIgEJhpkfMU6LcFNEE3+s8xWVuN/WPIKDkOyqE45DLS2vY
         PGaA==
X-Gm-Message-State: AOAM5320Mda3dkuefjzRE+EbSlzmufk/kwMc3WKlwU9B52n1LS2EV2Dp
        oIbgzQqKC9F14dXtF6cNKK8wHxFJeg/YR/kdIklAc91rRmD4Ew3yU1O/IXiuCTCNCqXU3+37hfv
        5MLk6IEYjKlaJgIeCyRykIl3tCL5MwA/KxfcbPUyvuUdakhTzJShm74Xd7c6QrBdJi7jUMA==
X-Google-Smtp-Source: ABdhPJwvRCEt9XnQw8nnK0Gz0SaI98HD5H9OtcKH8Ll4L4m73bxxj9mq8sj/2r/KnntvPpfabQUj47QoG/E=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90b:4d81:b0:1bf:8ce4:4f51 with SMTP id
 oj1-20020a17090b4d8100b001bf8ce44f51mr461111pjb.0.1646977895395; Thu, 10 Mar
 2022 21:51:35 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:49:29 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-19-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 018/105] KVM: selftests: Get rid of kvm_util_internal.h
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
 .../selftests/kvm/include/kvm_util_base.h     | 99 +++++++++++++++++--
 .../selftests/kvm/lib/aarch64/processor.c     |  1 -
 .../testing/selftests/kvm/lib/aarch64/ucall.c |  1 -
 .../testing/selftests/kvm/lib/aarch64/vgic.c  |  1 -
 tools/testing/selftests/kvm/lib/elf.c         |  1 -
 tools/testing/selftests/kvm/lib/kvm_util.c    |  1 -
 .../selftests/kvm/lib/kvm_util_internal.h     | 94 ------------------
 .../selftests/kvm/lib/riscv/processor.c       |  1 -
 tools/testing/selftests/kvm/lib/riscv/ucall.c |  1 -
 .../selftests/kvm/lib/s390x/processor.c       |  1 -
 .../selftests/kvm/lib/x86_64/processor.c      |  1 -
 tools/testing/selftests/kvm/lib/x86_64/svm.c  |  1 -
 tools/testing/selftests/kvm/lib/x86_64/vmx.c  |  1 -
 .../selftests/kvm/x86_64/sev_migrate_tests.c  |  1 -
 14 files changed, 91 insertions(+), 114 deletions(-)
 delete mode 100644 tools/testing/selftests/kvm/lib/kvm_util_internal.h

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index e8dff9bdab89..d2550c6e82c1 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -9,9 +9,13 @@
 
 #include "test_util.h"
 
-#include "asm/kvm.h"
+#include <linux/compiler.h>
+#include "linux/hashtable.h"
 #include "linux/list.h"
-#include "linux/kvm.h"
+#include <linux/kernel.h>
+#include <linux/kvm.h>
+#include "linux/rbtree.h"
+
 #include <sys/ioctl.h>
 
 #include "sparsebit.h"
@@ -21,15 +25,94 @@
 
 #define NSEC_PER_SEC 1000000000L
 
-/*
- * Callers of kvm_util only have an incomplete/opaque description of the
- * structure kvm_util is using to maintain the state of a VM.
- */
-struct kvm_vm;
-
 typedef uint64_t vm_paddr_t; /* Virtual Machine (Guest) physical address */
 typedef uint64_t vm_vaddr_t; /* Virtual Machine (Guest) virtual address */
 
+struct userspace_mem_region {
+	struct kvm_userspace_memory_region region;
+	struct sparsebit *unused_phy_pages;
+	int fd;
+	off_t offset;
+	void *host_mem;
+	void *host_alias;
+	void *mmap_start;
+	void *mmap_alias;
+	size_t mmap_size;
+	struct rb_node gpa_node;
+	struct rb_node hva_node;
+	struct hlist_node slot_node;
+};
+
+struct vcpu {
+	struct list_head list;
+	uint32_t id;
+	int fd;
+	struct kvm_run *state;
+	struct kvm_dirty_gfn *dirty_gfns;
+	uint32_t fetch_index;
+	uint32_t dirty_gfns_count;
+};
+
+struct userspace_mem_regions {
+	struct rb_root gpa_tree;
+	struct rb_root hva_tree;
+	DECLARE_HASHTABLE(slot_hash, 9);
+};
+
+struct kvm_vm {
+	int mode;
+	unsigned long type;
+	int kvm_fd;
+	int fd;
+	unsigned int pgtable_levels;
+	unsigned int page_size;
+	unsigned int page_shift;
+	unsigned int pa_bits;
+	unsigned int va_bits;
+	uint64_t max_gfn;
+	struct list_head vcpus;
+	struct userspace_mem_regions regions;
+	struct sparsebit *vpages_valid;
+	struct sparsebit *vpages_mapped;
+	bool has_irqchip;
+	bool pgd_created;
+	vm_paddr_t pgd;
+	vm_vaddr_t gdt;
+	vm_vaddr_t tss;
+	vm_vaddr_t idt;
+	vm_vaddr_t handlers;
+	uint32_t dirty_ring_size;
+};
+
+
+#define kvm_for_each_vcpu(vm, i, vcpu)			\
+	for ((i) = 0; (i) <= (vm)->last_vcpu_id; (i)++)	\
+		if (!((vcpu) = vm->vcpus[i]))		\
+			continue;			\
+		else
+
+struct vcpu *vcpu_get(struct kvm_vm *vm, uint32_t vcpuid);
+
+/*
+ * Virtual Translation Tables Dump
+ *
+ * Input Args:
+ *   stream - Output FILE stream
+ *   vm     - Virtual Machine
+ *   indent - Left margin indent amount
+ *
+ * Output Args: None
+ *
+ * Return: None
+ *
+ * Dumps to the FILE stream given by @stream, the contents of all the
+ * virtual translation tables for the VM given by @vm.
+ */
+void virt_dump(FILE *stream, struct kvm_vm *vm, uint8_t indent);
+
+struct userspace_mem_region *
+memslot2region(struct kvm_vm *vm, uint32_t memslot);
+
 /* Minimum allocated guest virtual and physical addresses */
 #define KVM_UTIL_MIN_VADDR		0x2000
 #define KVM_GUEST_PAGE_TABLE_MIN_PADDR	0x180000
diff --git a/tools/testing/selftests/kvm/lib/aarch64/processor.c b/tools/testing/selftests/kvm/lib/aarch64/processor.c
index 06c3dafc82c4..6fa52e141e1b 100644
--- a/tools/testing/selftests/kvm/lib/aarch64/processor.c
+++ b/tools/testing/selftests/kvm/lib/aarch64/processor.c
@@ -10,7 +10,6 @@
 
 #include "guest_modes.h"
 #include "kvm_util.h"
-#include "../kvm_util_internal.h"
 #include "processor.h"
 
 #define DEFAULT_ARM64_GUEST_STACK_VADDR_MIN	0xac0000
diff --git a/tools/testing/selftests/kvm/lib/aarch64/ucall.c b/tools/testing/selftests/kvm/lib/aarch64/ucall.c
index e0b0164e9af8..e14663ab2056 100644
--- a/tools/testing/selftests/kvm/lib/aarch64/ucall.c
+++ b/tools/testing/selftests/kvm/lib/aarch64/ucall.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2018, Red Hat, Inc.
  */
 #include "kvm_util.h"
-#include "../kvm_util_internal.h"
 
 static vm_vaddr_t *ucall_exit_mmio_addr;
 
diff --git a/tools/testing/selftests/kvm/lib/aarch64/vgic.c b/tools/testing/selftests/kvm/lib/aarch64/vgic.c
index b3a0fca0d780..a169e662d6ae 100644
--- a/tools/testing/selftests/kvm/lib/aarch64/vgic.c
+++ b/tools/testing/selftests/kvm/lib/aarch64/vgic.c
@@ -9,7 +9,6 @@
 #include <asm/kvm.h>
 
 #include "kvm_util.h"
-#include "../kvm_util_internal.h"
 #include "vgic.h"
 #include "gic.h"
 #include "gic_v3.h"
diff --git a/tools/testing/selftests/kvm/lib/elf.c b/tools/testing/selftests/kvm/lib/elf.c
index 13e8e3dcf984..9f54c098d9d0 100644
--- a/tools/testing/selftests/kvm/lib/elf.c
+++ b/tools/testing/selftests/kvm/lib/elf.c
@@ -11,7 +11,6 @@
 #include <linux/elf.h>
 
 #include "kvm_util.h"
-#include "kvm_util_internal.h"
 
 static void elfhdr_get(const char *filename, Elf64_Ehdr *hdrp)
 {
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 76f8b924fb31..c6fee457735b 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -8,7 +8,6 @@
 #define _GNU_SOURCE /* for program_invocation_name */
 #include "test_util.h"
 #include "kvm_util.h"
-#include "kvm_util_internal.h"
 #include "processor.h"
 
 #include <assert.h>
diff --git a/tools/testing/selftests/kvm/lib/kvm_util_internal.h b/tools/testing/selftests/kvm/lib/kvm_util_internal.h
deleted file mode 100644
index 544b90df2f80..000000000000
--- a/tools/testing/selftests/kvm/lib/kvm_util_internal.h
+++ /dev/null
@@ -1,94 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * tools/testing/selftests/kvm/lib/kvm_util_internal.h
- *
- * Copyright (C) 2018, Google LLC.
- */
-
-#ifndef SELFTEST_KVM_UTIL_INTERNAL_H
-#define SELFTEST_KVM_UTIL_INTERNAL_H
-
-#include "linux/hashtable.h"
-#include "linux/rbtree.h"
-
-#include "sparsebit.h"
-
-struct userspace_mem_region {
-	struct kvm_userspace_memory_region region;
-	struct sparsebit *unused_phy_pages;
-	int fd;
-	off_t offset;
-	void *host_mem;
-	void *host_alias;
-	void *mmap_start;
-	void *mmap_alias;
-	size_t mmap_size;
-	struct rb_node gpa_node;
-	struct rb_node hva_node;
-	struct hlist_node slot_node;
-};
-
-struct vcpu {
-	struct list_head list;
-	uint32_t id;
-	int fd;
-	struct kvm_run *state;
-	struct kvm_dirty_gfn *dirty_gfns;
-	uint32_t fetch_index;
-	uint32_t dirty_gfns_count;
-};
-
-struct userspace_mem_regions {
-	struct rb_root gpa_tree;
-	struct rb_root hva_tree;
-	DECLARE_HASHTABLE(slot_hash, 9);
-};
-
-struct kvm_vm {
-	int mode;
-	unsigned long type;
-	int kvm_fd;
-	int fd;
-	unsigned int pgtable_levels;
-	unsigned int page_size;
-	unsigned int page_shift;
-	unsigned int pa_bits;
-	unsigned int va_bits;
-	uint64_t max_gfn;
-	struct list_head vcpus;
-	struct userspace_mem_regions regions;
-	struct sparsebit *vpages_valid;
-	struct sparsebit *vpages_mapped;
-	bool has_irqchip;
-	bool pgd_created;
-	vm_paddr_t pgd;
-	vm_vaddr_t gdt;
-	vm_vaddr_t tss;
-	vm_vaddr_t idt;
-	vm_vaddr_t handlers;
-	uint32_t dirty_ring_size;
-};
-
-struct vcpu *vcpu_get(struct kvm_vm *vm, uint32_t vcpuid);
-
-/*
- * Virtual Translation Tables Dump
- *
- * Input Args:
- *   stream - Output FILE stream
- *   vm     - Virtual Machine
- *   indent - Left margin indent amount
- *
- * Output Args: None
- *
- * Return: None
- *
- * Dumps to the FILE stream given by @stream, the contents of all the
- * virtual translation tables for the VM given by @vm.
- */
-void virt_dump(FILE *stream, struct kvm_vm *vm, uint8_t indent);
-
-struct userspace_mem_region *
-memslot2region(struct kvm_vm *vm, uint32_t memslot);
-
-#endif /* SELFTEST_KVM_UTIL_INTERNAL_H */
diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tools/testing/selftests/kvm/lib/riscv/processor.c
index 1a404749094a..f17c7542cc53 100644
--- a/tools/testing/selftests/kvm/lib/riscv/processor.c
+++ b/tools/testing/selftests/kvm/lib/riscv/processor.c
@@ -9,7 +9,6 @@
 #include <assert.h>
 
 #include "kvm_util.h"
-#include "../kvm_util_internal.h"
 #include "processor.h"
 
 #define DEFAULT_RISCV_GUEST_STACK_VADDR_MIN	0xac0000
diff --git a/tools/testing/selftests/kvm/lib/riscv/ucall.c b/tools/testing/selftests/kvm/lib/riscv/ucall.c
index 9e42d8248fa6..c554ed173b38 100644
--- a/tools/testing/selftests/kvm/lib/riscv/ucall.c
+++ b/tools/testing/selftests/kvm/lib/riscv/ucall.c
@@ -8,7 +8,6 @@
 #include <linux/kvm.h>
 
 #include "kvm_util.h"
-#include "../kvm_util_internal.h"
 #include "processor.h"
 
 void ucall_init(struct kvm_vm *vm, void *arg)
diff --git a/tools/testing/selftests/kvm/lib/s390x/processor.c b/tools/testing/selftests/kvm/lib/s390x/processor.c
index 7cc1051c4b71..53c413932f64 100644
--- a/tools/testing/selftests/kvm/lib/s390x/processor.c
+++ b/tools/testing/selftests/kvm/lib/s390x/processor.c
@@ -7,7 +7,6 @@
 
 #include "processor.h"
 #include "kvm_util.h"
-#include "../kvm_util_internal.h"
 
 #define PAGES_PER_REGION 4
 
diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index c47b84449a8a..e9b3f254e8f9 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -7,7 +7,6 @@
 
 #include "test_util.h"
 #include "kvm_util.h"
-#include "../kvm_util_internal.h"
 #include "processor.h"
 
 #ifndef NUM_INTERRUPTS
diff --git a/tools/testing/selftests/kvm/lib/x86_64/svm.c b/tools/testing/selftests/kvm/lib/x86_64/svm.c
index 736ee4a23df6..01a9d831da13 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/svm.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/svm.c
@@ -9,7 +9,6 @@
 
 #include "test_util.h"
 #include "kvm_util.h"
-#include "../kvm_util_internal.h"
 #include "processor.h"
 #include "svm_util.h"
 
diff --git a/tools/testing/selftests/kvm/lib/x86_64/vmx.c b/tools/testing/selftests/kvm/lib/x86_64/vmx.c
index d089d8b850b5..0d42aa821833 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/vmx.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/vmx.c
@@ -7,7 +7,6 @@
 
 #include "test_util.h"
 #include "kvm_util.h"
-#include "../kvm_util_internal.h"
 #include "processor.h"
 #include "vmx.h"
 
diff --git a/tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c b/tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c
index d29cf773d7bf..fb26d0d85fcb 100644
--- a/tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c
+++ b/tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c
@@ -12,7 +12,6 @@
 #include "processor.h"
 #include "svm_util.h"
 #include "kselftest.h"
-#include "../lib/kvm_util_internal.h"
 
 #define SEV_POLICY_ES 0b100
 
-- 
2.35.1.723.g4982287a31-goog


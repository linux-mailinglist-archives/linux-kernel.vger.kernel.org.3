Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 637C04D5ACE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346636AbiCKFxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 00:53:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346585AbiCKFwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:52:36 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415ABF70DE
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:51:30 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2dcd6a5e4b6so60474207b3.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=ttO2mNjkKQTdjqGFyuMzkYKBHRPA69OMuLHgjBQ1wEE=;
        b=dy+iu0Dq95hrIgpN5VkGj8rQbVsZIgij+5nkDsen1/PFHg0cso58WvhnDOCU7p8KVG
         dNnxEOmEgdIlUqe+Q4lpxiPazkL7J10Co0iXIPT2/K2exEDji1cwPSgNDJ6nRl3dx5Q3
         OIhEO8gHIBT/8CESAW+VJz2EwahUZbH3JrfsCtd529IG5Qf+c3oQZ4xW1r1UMXWcXN+h
         d+KPHrZdqYUlNP+m9B4GJEOEI+GWLFcg28OZIyVJqTZa5M+WC4aRI/KOb9ES/7Dl6IU5
         wpqrVwIZYiAjZ6Mbb4i8VwTuZM6fbJ52YTGb9bm1IEQyS5LjJGThg8Y1l9ZoYCQiyGPK
         aW9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=ttO2mNjkKQTdjqGFyuMzkYKBHRPA69OMuLHgjBQ1wEE=;
        b=Sgp4BR/yU3Z5PmDk1tVf9PcrLiFhSOI+hDJX15w4hUtHii7HTebXpCDJbthxlcRv3e
         XxDhJdGuvThFfPMZUX7pfAEYrCfF9phTwNrS3b4AA3SGv+RikAW7NoSVrdqlJ6ESQ7qK
         qCWxqN4F1OCOBY1xdJhS4K2VI7bzNpoSdzLbr0qFDYQWUWXAmULFS15QhMyhSHcLFnzH
         SOl4Uk3U/pQiPCR7HRQ4kbOqeuLaNKgyFy2Q+DJSlmxd3mZCX2+dTpQed7akmbMTKiEu
         511bi/v1KNhgsTgsfd8rH5a4hJFsPK0KM1wdh3Wo9cO96V6wN21Tgr1hQ2oaEzJCNbur
         fACg==
X-Gm-Message-State: AOAM530UqmSI5GL65URqQ4jGra5kTdwIqdE9Ee7OkTFTPAb1kmTHp7iu
        cow5cOe/SyEMK+jiaqRN6fwXDK/QBe0DwLbonr/BJ5DvTOcSJzABTONywQ7yclZ9lom0yyxHgZ6
        JoVb5UbTTrFpJbJ6ndRzKdJaPfuf4NOcDwQ4uPvN16o9uTLsyaeqIgi3/dQPSOY0dzxIhwg==
X-Google-Smtp-Source: ABdhPJyQ8tjtVZOycXT00xd5KlJliWb7UIq69pfawQKGkjwA19rGHGGD79ZQeF7uqLNFc0w9Zz4GyWhTknk=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a25:378e:0:b0:629:2b4c:56c7 with SMTP id
 e136-20020a25378e000000b006292b4c56c7mr6750664yba.134.1646977889381; Thu, 10
 Mar 2022 21:51:29 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:49:25 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-15-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 014/105] KVM: sefltests: Use vm_ioctl() and __vm_ioctl() helpers
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
 .../selftests/kvm/include/kvm_util_base.h     |  59 ++++++++--
 .../selftests/kvm/kvm_binary_stats_test.c     |   6 +-
 tools/testing/selftests/kvm/lib/kvm_util.c    | 111 ++----------------
 .../selftests/kvm/set_memory_region_test.c    |   5 +-
 4 files changed, 65 insertions(+), 116 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index bcffd9f85490..09e84ce50331 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -103,8 +103,6 @@ extern const struct vm_guest_mode_params vm_guest_mode_params[];
 int open_path_or_exit(const char *path, int flags);
 int open_kvm_dev_path_or_exit(void);
 int kvm_check_cap(long cap);
-int vm_check_cap(struct kvm_vm *vm, long cap);
-int vm_enable_cap(struct kvm_vm *vm, struct kvm_enable_cap *cap);
 
 #define __KVM_IOCTL_ERROR(_name, _ret) \
 	"%s failed, rc: %i errno: %i (%s)", (_name), (_ret), errno, strerror(errno)
@@ -125,6 +123,23 @@ void _vcpu_ioctl(struct kvm_vm *vm, uint32_t vcpuid, unsigned long cmd,
 #define vcpu_ioctl(vm, vcpuid, cmd, arg) \
 	_vcpu_ioctl(vm, vcpuid, cmd, #cmd, arg)
 
+/*
+ * Looks up and returns the value corresponding to the capability
+ * (KVM_CAP_*) given by cap.
+ */
+static inline int vm_check_cap(struct kvm_vm *vm, long cap)
+{
+	int ret =  __vm_ioctl(vm, KVM_CHECK_EXTENSION, (void *)cap);
+
+	TEST_ASSERT(ret >= 0, KVM_IOCTL_ERROR(KVM_CHECK_EXTENSION, ret));
+	return ret;
+}
+
+static inline void vm_enable_cap(struct kvm_vm *vm, struct kvm_enable_cap *cap)
+{
+	vm_ioctl(vm, KVM_ENABLE_CAP, cap);
+}
+
 void vm_enable_dirty_ring(struct kvm_vm *vm, uint32_t ring_size);
 const char *vm_guest_mode_string(uint32_t i);
 
@@ -133,18 +148,46 @@ struct kvm_vm *vm_create(uint64_t phy_pages);
 void kvm_vm_free(struct kvm_vm *vmp);
 void kvm_vm_restart(struct kvm_vm *vmp);
 void kvm_vm_release(struct kvm_vm *vmp);
-void kvm_vm_get_dirty_log(struct kvm_vm *vm, int slot, void *log);
-void kvm_vm_clear_dirty_log(struct kvm_vm *vm, int slot, void *log,
-			    uint64_t first_page, uint32_t num_pages);
-uint32_t kvm_vm_reset_dirty_ring(struct kvm_vm *vm);
-
 int kvm_memcmp_hva_gva(void *hva, struct kvm_vm *vm, const vm_vaddr_t gva,
 		       size_t len);
-
 void kvm_vm_elf_load(struct kvm_vm *vm, const char *filename);
 
 void vm_dump(FILE *stream, struct kvm_vm *vm, uint8_t indent);
 
+static inline void kvm_vm_get_dirty_log(struct kvm_vm *vm, int slot, void *log)
+{
+	struct kvm_dirty_log args = { .dirty_bitmap = log, .slot = slot };
+
+	vm_ioctl(vm, KVM_GET_DIRTY_LOG, &args);
+}
+
+static inline void kvm_vm_clear_dirty_log(struct kvm_vm *vm, int slot, void *log,
+					  uint64_t first_page, uint32_t num_pages)
+{
+	struct kvm_clear_dirty_log args = {
+		.dirty_bitmap = log,
+		.slot = slot,
+		.first_page = first_page,
+		.num_pages = num_pages
+	};
+
+	vm_ioctl(vm, KVM_CLEAR_DIRTY_LOG, &args);
+}
+
+static inline uint32_t kvm_vm_reset_dirty_ring(struct kvm_vm *vm)
+{
+	return __vm_ioctl(vm, KVM_RESET_DIRTY_RINGS, NULL);
+}
+
+static inline int vm_get_stats_fd(struct kvm_vm *vm)
+{
+	int fd = __vm_ioctl(vm, KVM_GET_STATS_FD, NULL);
+
+	TEST_ASSERT(fd >= 0, KVM_IOCTL_ERROR(KVM_GET_STATS_FD, fd));
+	return fd;
+}
+
+
 /*
  * VM VCPU Dump
  *
diff --git a/tools/testing/selftests/kvm/kvm_binary_stats_test.c b/tools/testing/selftests/kvm/kvm_binary_stats_test.c
index bab8b49b52da..0a27b0f85009 100644
--- a/tools/testing/selftests/kvm/kvm_binary_stats_test.c
+++ b/tools/testing/selftests/kvm/kvm_binary_stats_test.c
@@ -165,11 +165,7 @@ static void stats_test(int stats_fd)
 
 static void vm_stats_test(struct kvm_vm *vm)
 {
-	int stats_fd;
-
-	/* Get fd for VM stats */
-	stats_fd = vm_get_stats_fd(vm);
-	TEST_ASSERT(stats_fd >= 0, "Get VM stats fd");
+	int stats_fd = vm_get_stats_fd(vm);
 
 	stats_test(stats_fd);
 	close(stats_fd);
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index a37baaddfeaf..974de21eef23 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -85,56 +85,6 @@ int kvm_check_cap(long cap)
 	return ret;
 }
 
-/* VM Check Capability
- *
- * Input Args:
- *   vm - Virtual Machine
- *   cap - Capability
- *
- * Output Args: None
- *
- * Return:
- *   On success, the Value corresponding to the capability (KVM_CAP_*)
- *   specified by the value of cap.  On failure a TEST_ASSERT failure
- *   is produced.
- *
- * Looks up and returns the value corresponding to the capability
- * (KVM_CAP_*) given by cap.
- */
-int vm_check_cap(struct kvm_vm *vm, long cap)
-{
-	int ret;
-
-	ret = ioctl(vm->fd, KVM_CHECK_EXTENSION, cap);
-	TEST_ASSERT(ret >= 0, "KVM_CHECK_EXTENSION VM IOCTL failed,\n"
-		"  rc: %i errno: %i", ret, errno);
-
-	return ret;
-}
-
-/* VM Enable Capability
- *
- * Input Args:
- *   vm - Virtual Machine
- *   cap - Capability
- *
- * Output Args: None
- *
- * Return: On success, 0. On failure a TEST_ASSERT failure is produced.
- *
- * Enables a capability (KVM_CAP_*) on the VM.
- */
-int vm_enable_cap(struct kvm_vm *vm, struct kvm_enable_cap *cap)
-{
-	int ret;
-
-	ret = ioctl(vm->fd, KVM_ENABLE_CAP, cap);
-	TEST_ASSERT(ret == 0, "KVM_ENABLE_CAP IOCTL failed,\n"
-		"  rc: %i errno: %i", ret, errno);
-
-	return ret;
-}
-
 void vm_enable_dirty_ring(struct kvm_vm *vm, uint32_t ring_size)
 {
 	struct kvm_enable_cap cap = { 0 };
@@ -452,36 +402,6 @@ void kvm_vm_restart(struct kvm_vm *vmp)
 	}
 }
 
-void kvm_vm_get_dirty_log(struct kvm_vm *vm, int slot, void *log)
-{
-	struct kvm_dirty_log args = { .dirty_bitmap = log, .slot = slot };
-	int ret;
-
-	ret = ioctl(vm->fd, KVM_GET_DIRTY_LOG, &args);
-	TEST_ASSERT(ret == 0, "%s: KVM_GET_DIRTY_LOG failed: %s",
-		    __func__, strerror(-ret));
-}
-
-void kvm_vm_clear_dirty_log(struct kvm_vm *vm, int slot, void *log,
-			    uint64_t first_page, uint32_t num_pages)
-{
-	struct kvm_clear_dirty_log args = {
-		.dirty_bitmap = log, .slot = slot,
-		.first_page = first_page,
-		.num_pages = num_pages
-	};
-	int ret;
-
-	ret = ioctl(vm->fd, KVM_CLEAR_DIRTY_LOG, &args);
-	TEST_ASSERT(ret == 0, "%s: KVM_CLEAR_DIRTY_LOG failed: %s",
-		    __func__, strerror(-ret));
-}
-
-uint32_t kvm_vm_reset_dirty_ring(struct kvm_vm *vm)
-{
-	return ioctl(vm->fd, KVM_RESET_DIRTY_RINGS);
-}
-
 /*
  * Userspace Memory Region Find
  *
@@ -637,7 +557,7 @@ static void __vm_mem_region_delete(struct kvm_vm *vm,
 	}
 
 	region->region.memory_size = 0;
-	ret = ioctl(vm->fd, KVM_SET_USER_MEMORY_REGION, &region->region);
+	ret = __vm_ioctl(vm, KVM_SET_USER_MEMORY_REGION, &region->region);
 	TEST_ASSERT(ret == 0, "KVM_SET_USER_MEMORY_REGION IOCTL failed, "
 		    "rc: %i errno: %i", ret, errno);
 
@@ -955,7 +875,7 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
 	region->region.guest_phys_addr = guest_paddr;
 	region->region.memory_size = npages * vm->page_size;
 	region->region.userspace_addr = (uintptr_t) region->host_mem;
-	ret = ioctl(vm->fd, KVM_SET_USER_MEMORY_REGION, &region->region);
+	ret = __vm_ioctl(vm, KVM_SET_USER_MEMORY_REGION, &region->region);
 	TEST_ASSERT(ret == 0, "KVM_SET_USER_MEMORY_REGION IOCTL failed,\n"
 		"  rc: %i errno: %i\n"
 		"  slot: %u flags: 0x%x\n"
@@ -1038,7 +958,7 @@ void vm_mem_region_set_flags(struct kvm_vm *vm, uint32_t slot, uint32_t flags)
 
 	region->region.flags = flags;
 
-	ret = ioctl(vm->fd, KVM_SET_USER_MEMORY_REGION, &region->region);
+	ret = __vm_ioctl(vm, KVM_SET_USER_MEMORY_REGION, &region->region);
 
 	TEST_ASSERT(ret == 0, "KVM_SET_USER_MEMORY_REGION IOCTL failed,\n"
 		"  rc: %i errno: %i slot: %u flags: 0x%x",
@@ -1068,7 +988,7 @@ void vm_mem_region_move(struct kvm_vm *vm, uint32_t slot, uint64_t new_gpa)
 
 	region->region.guest_phys_addr = new_gpa;
 
-	ret = ioctl(vm->fd, KVM_SET_USER_MEMORY_REGION, &region->region);
+	ret = __vm_ioctl(vm, KVM_SET_USER_MEMORY_REGION, &region->region);
 
 	TEST_ASSERT(!ret, "KVM_SET_USER_MEMORY_REGION failed\n"
 		    "ret: %i errno: %i slot: %u new_gpa: 0x%lx",
@@ -1152,10 +1072,10 @@ void vm_vcpu_add(struct kvm_vm *vm, uint32_t vcpuid)
 	/* Allocate and initialize new vcpu structure. */
 	vcpu = calloc(1, sizeof(*vcpu));
 	TEST_ASSERT(vcpu != NULL, "Insufficient Memory");
+
 	vcpu->id = vcpuid;
-	vcpu->fd = ioctl(vm->fd, KVM_CREATE_VCPU, vcpuid);
-	TEST_ASSERT(vcpu->fd >= 0, "KVM_CREATE_VCPU failed, rc: %i errno: %i",
-		vcpu->fd, errno);
+	vcpu->fd = __vm_ioctl(vm, KVM_CREATE_VCPU, (void *)(unsigned long)vcpuid);
+	TEST_ASSERT(vcpu->fd >= 0, KVM_IOCTL_ERROR(KVM_CREATE_VCPU, vcpu->fd));
 
 	TEST_ASSERT(vcpu_mmap_sz() >= sizeof(*vcpu->state), "vcpu mmap size "
 		"smaller than expected, vcpu_mmap_sz: %i expected_min: %zi",
@@ -1496,11 +1416,7 @@ void *addr_gpa2alias(struct kvm_vm *vm, vm_paddr_t gpa)
  */
 void vm_create_irqchip(struct kvm_vm *vm)
 {
-	int ret;
-
-	ret = ioctl(vm->fd, KVM_CREATE_IRQCHIP, 0);
-	TEST_ASSERT(ret == 0, "KVM_CREATE_IRQCHIP IOCTL failed, "
-		"rc: %i errno: %i", ret, errno);
+	vm_ioctl(vm, KVM_CREATE_IRQCHIP, NULL);
 
 	vm->has_irqchip = true;
 }
@@ -1721,7 +1637,7 @@ int _kvm_create_device(struct kvm_vm *vm, uint64_t type, bool test, int *fd)
 	create_dev.type = type;
 	create_dev.fd = -1;
 	create_dev.flags = test ? KVM_CREATE_DEVICE_TEST : 0;
-	ret = ioctl(vm_get_fd(vm), KVM_CREATE_DEVICE, &create_dev);
+	ret = __vm_ioctl(vm, KVM_CREATE_DEVICE, &create_dev);
 	*fd = create_dev.fd;
 	return ret;
 }
@@ -1817,7 +1733,7 @@ void kvm_irq_line(struct kvm_vm *vm, uint32_t irq, int level)
 {
 	int ret = _kvm_irq_line(vm, irq, level);
 
-	TEST_ASSERT(ret >= 0, "KVM_IRQ_LINE failed, rc: %i errno: %i", ret, errno);
+	TEST_ASSERT(ret >= 0, KVM_IOCTL_ERROR(KVM_IRQ_LINE, ret));
 }
 
 struct kvm_irq_routing *kvm_gsi_routing_create(void)
@@ -1856,7 +1772,7 @@ int _kvm_gsi_routing_write(struct kvm_vm *vm, struct kvm_irq_routing *routing)
 	int ret;
 
 	assert(routing);
-	ret = ioctl(vm_get_fd(vm), KVM_SET_GSI_ROUTING, routing);
+	ret = __vm_ioctl(vm, KVM_SET_GSI_ROUTING, routing);
 	free(routing);
 
 	return ret;
@@ -2167,8 +2083,3 @@ unsigned int vm_calc_num_guest_pages(enum vm_guest_mode mode, size_t size)
 	n = DIV_ROUND_UP(size, vm_guest_mode_params[mode].page_size);
 	return vm_adjust_num_guest_pages(mode, n);
 }
-
-int vm_get_stats_fd(struct kvm_vm *vm)
-{
-	return ioctl(vm->fd, KVM_GET_STATS_FD, NULL);
-}
diff --git a/tools/testing/selftests/kvm/set_memory_region_test.c b/tools/testing/selftests/kvm/set_memory_region_test.c
index fa4613010091..482ae2ad662c 100644
--- a/tools/testing/selftests/kvm/set_memory_region_test.c
+++ b/tools/testing/selftests/kvm/set_memory_region_test.c
@@ -317,8 +317,7 @@ static void test_zero_memory_regions(void)
 	vm = vm_create(0);
 	vm_vcpu_add(vm, VCPU_ID);
 
-	TEST_ASSERT(!ioctl(vm_get_fd(vm), KVM_SET_NR_MMU_PAGES, 64),
-		    "KVM_SET_NR_MMU_PAGES failed, errno = %d\n", errno);
+	vm_ioctl(vm, KVM_SET_NR_MMU_PAGES, (void *)64ul);
 	vcpu_run(vm, VCPU_ID);
 
 	run = vcpu_state(vm, VCPU_ID);
@@ -340,7 +339,7 @@ static int test_memory_region_add(struct kvm_vm *vm, void *mem, uint32_t slot,
 	region.guest_phys_addr = guest_addr;
 	region.memory_size = size;
 	region.userspace_addr = (uintptr_t) mem;
-	ret = ioctl(vm_get_fd(vm), KVM_SET_USER_MEMORY_REGION, &region);
+	ret = __vm_ioctl(vm, KVM_SET_USER_MEMORY_REGION, &region);
 
 	return ret;
 }
-- 
2.35.1.723.g4982287a31-goog


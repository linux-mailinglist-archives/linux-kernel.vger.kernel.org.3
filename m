Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E15F84E3A20
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 09:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiCVIJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 04:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiCVIJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 04:09:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 19FC35AA66
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 01:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647936491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=44GyAHa6Pj1FMP5IguIZbUGFA3CdvqimJarOV3Ihudw=;
        b=JwkF8IQsO0zWUaFKCMv7TjRTwEBQL5kgsSwjh44mtFhD0ZZSsDmr6SGl5Ca5mdH2bBjLvd
        RmDkoJ+DdOD1wLB0kzm0xU0h4loLjGns46ePJrfPEbRIw1q6u4NJRo5B3RtHXC3sa2Wamz
        nyRfPlzIfeXfdB4oAH92885SKVkNu0A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-316-Wt3p9bdXPUSPujdnsEsqPg-1; Tue, 22 Mar 2022 04:08:07 -0400
X-MC-Unique: Wt3p9bdXPUSPujdnsEsqPg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 61C4E899EC1;
        Tue, 22 Mar 2022 08:08:07 +0000 (UTC)
Received: from gshan.redhat.com (ovpn-12-33.pek2.redhat.com [10.72.12.33])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E80861121324;
        Tue, 22 Mar 2022 08:07:53 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, eauger@redhat.com,
        shannon.zhaosl@gmail.com, maz@kernel.org,
        Jonathan.Cameron@huawei.com, will@kernel.org, pbonzini@redhat.com,
        james.morse@arm.com, mark.rutland@arm.com, drjones@redhat.com,
        vkuznets@redhat.com, shan.gavin@gmail.com
Subject: [PATCH v5 02/22] KVM: arm64: Add SDEI virtualization infrastructure
Date:   Tue, 22 Mar 2022 16:06:50 +0800
Message-Id: <20220322080710.51727-3-gshan@redhat.com>
In-Reply-To: <20220322080710.51727-1-gshan@redhat.com>
References: <20220322080710.51727-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Software Delegated Exception Interface (SDEI) provides a mechanism for
registering and servicing system events. Those system events are high
priority events, which must be serviced immediately. It's going to be
used by Asynchronous Page Fault (APF) to deliver notification from KVM
to guest. It's noted that SDEI is defined by ARM DEN0054C specification.

This introduces SDEI virtualization infrastructure where the SDEI events
are registered and manipulated by the guest through hypercall. The SDEI
event is delivered to one specific vCPU by KVM once it's raised. This
introduces data structures to represent the needed objects to support
the feature, which is highlighted as below. As those objects could be
migrated between VMs, these data structures are partially exposed to
user space.

   * kvm_sdei_exposed_event
     The exposed events are determined and added by VMM through ioctl
     interface. Only the exposed events can be registered from the
     guest.

   * kvm_sdei_registered_event
     The events that have been registered from the guest through the
     SDEI_1_0_FN_SDEI_EVENT_REGISTER hypercall.

   * kvm_sdei_vcpu_event
     The events that have been delivered to the target vCPU.

   * kvm_sdei_vcpu
     Used to save the preempted context when the SDEI event is serviced
     and delivered. After the SDEI event handling is completed, the
     execution is resumed from the preempted context.

   * kvm_sdei_kvm
     Place holder for the exposed and registered events.

The error of SDEI_NOT_SUPPORTED is returned for all SDEI hypercalls for
now. They will be supported in the subsequent patches.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/include/asm/kvm_host.h            |   3 +
 arch/arm64/include/asm/kvm_sdei.h            | 171 +++++++++++++
 arch/arm64/include/uapi/asm/kvm.h            |   1 +
 arch/arm64/include/uapi/asm/kvm_sdei_state.h |  72 ++++++
 arch/arm64/kvm/Makefile                      |   2 +-
 arch/arm64/kvm/arm.c                         |   8 +
 arch/arm64/kvm/hypercalls.c                  |  21 ++
 arch/arm64/kvm/sdei.c                        | 244 +++++++++++++++++++
 include/uapi/linux/arm_sdei.h                |   2 +
 9 files changed, 523 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/include/asm/kvm_sdei.h
 create mode 100644 arch/arm64/include/uapi/asm/kvm_sdei_state.h
 create mode 100644 arch/arm64/kvm/sdei.c

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 031e3a2537fc..5d37e046a458 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -113,6 +113,8 @@ struct kvm_arch {
 	/* Interrupt controller */
 	struct vgic_dist	vgic;
 
+	struct kvm_sdei_kvm *sdei;
+
 	/* Mandated version of PSCI */
 	u32 psci_version;
 
@@ -338,6 +340,7 @@ struct kvm_vcpu_arch {
 	 * Anything that is not used directly from assembly code goes
 	 * here.
 	 */
+	struct kvm_sdei_vcpu *sdei;
 
 	/*
 	 * Guest registers we preserve during guest debugging.
diff --git a/arch/arm64/include/asm/kvm_sdei.h b/arch/arm64/include/asm/kvm_sdei.h
new file mode 100644
index 000000000000..6f58a846d05c
--- /dev/null
+++ b/arch/arm64/include/asm/kvm_sdei.h
@@ -0,0 +1,171 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Definitions of various KVM SDEI events.
+ *
+ * Copyright (C) 2022 Red Hat, Inc.
+ *
+ * Author(s): Gavin Shan <gshan@redhat.com>
+ */
+
+#ifndef __ARM64_KVM_SDEI_H__
+#define __ARM64_KVM_SDEI_H__
+
+#include <uapi/linux/arm_sdei.h>
+#include <uapi/asm/kvm_sdei_state.h>
+#include <linux/bitmap.h>
+#include <linux/list.h>
+#include <linux/spinlock.h>
+
+struct kvm_vcpu;
+
+struct kvm_sdei_exposed_event {
+	struct kvm_sdei_exposed_event_state	state;
+	struct kvm				*kvm;
+	unsigned int				registered_event_count;
+	struct list_head			link;
+};
+
+struct kvm_sdei_registered_event {
+	struct kvm_sdei_registered_event_state	state;
+	struct kvm				*kvm;
+	struct kvm_sdei_exposed_event		*exposed_event;
+	unsigned int				vcpu_event_count;
+	struct list_head			link;
+};
+
+struct kvm_sdei_vcpu_event {
+	struct kvm_sdei_vcpu_event_state	state;
+	struct kvm_vcpu				*vcpu;
+	struct kvm_sdei_registered_event	*registered_event;
+	struct list_head			link;
+};
+
+struct kvm_sdei_kvm {
+	spinlock_t		lock;
+	unsigned int		exposed_event_count;
+	unsigned int		registered_event_count;
+	struct list_head	exposed_events;
+	struct list_head	registered_events;
+};
+
+struct kvm_sdei_vcpu {
+	spinlock_t                      lock;
+	struct kvm_sdei_vcpu_state      state;
+	struct kvm_sdei_vcpu_event      *critical_event;
+	struct kvm_sdei_vcpu_event      *normal_event;
+	unsigned int			critical_event_count;
+	unsigned int			normal_event_count;
+	struct list_head                critical_events;
+	struct list_head                normal_events;
+};
+
+/*
+ * According to SDEI specification (v1.1), the event number spans 32-bits
+ * and the lower 24-bits are used as the (real) event number. I don't
+ * think we can use that much SDEI numbers in one system. So we reserve
+ * two bits from the 24-bits real event number, to indicate its types:
+ * physical or virtual event. One reserved bit is enough for now, but
+ * two bits are reserved for possible extension in future.
+ *
+ * The physical events are owned by firmware while the virtual events
+ * are used by VMM and KVM.
+ */
+#define KVM_SDEI_EVENT_NUM_TYPE_SHIFT	22
+#define KVM_SDEI_EVENT_NUM_TYPE_MASK	(3UL << KVM_SDEI_EVENT_NUM_TYPE_SHIFT)
+#define KVM_SDEI_EVENT_NUM_TYPE_PHYS	0
+#define KVM_SDEI_EVENT_NUM_TYPE_VIRT	1
+
+static inline bool kvm_sdei_is_virtual(unsigned long num)
+{
+	unsigned long type;
+
+	if (num >> 32)
+		return false;
+
+	type = (num & KVM_SDEI_EVENT_NUM_TYPE_MASK) >>
+		KVM_SDEI_EVENT_NUM_TYPE_SHIFT;
+	if (type != KVM_SDEI_EVENT_NUM_TYPE_VIRT)
+		return false;
+
+	return true;
+}
+
+static inline bool kvm_sdei_is_default(unsigned long num)
+{
+	return num == KVM_SDEI_DEFAULT_EVENT;
+}
+
+static inline bool kvm_sdei_is_supported(unsigned long num)
+{
+	return kvm_sdei_is_default(num) || kvm_sdei_is_virtual(num);
+}
+
+static inline bool kvm_sdei_is_shared(unsigned char type)
+{
+	return type == SDEI_EVENT_TYPE_SHARED;
+}
+
+static inline bool kvm_sdei_is_private(unsigned char type)
+{
+	return type == SDEI_EVENT_TYPE_PRIVATE;
+}
+
+static inline bool kvm_sdei_is_critical(unsigned char priority)
+{
+	return priority == SDEI_EVENT_PRIORITY_CRITICAL;
+}
+
+static inline bool kvm_sdei_is_normal(unsigned char priority)
+{
+	return priority == SDEI_EVENT_PRIORITY_NORMAL;
+}
+
+static inline unsigned int
+kvm_sdei_vcpu_index(struct kvm_vcpu *vcpu,
+		    struct kvm_sdei_exposed_event *event)
+{
+	return kvm_sdei_is_private(event->state.type) ? vcpu->vcpu_idx : 0;
+}
+
+/* Accessors for the registered event */
+#define KVM_SDEI_REGISTERED_EVENT_FUNC(field)				\
+static inline bool							\
+kvm_sdei_is_##field(struct kvm_sdei_registered_event *event,		\
+		    unsigned int index)					\
+{									\
+	return !!test_bit(index, (void *)(event->state.field));		\
+}									\
+									\
+static inline bool							\
+kvm_sdei_none_##field(struct kvm_sdei_registered_event *event)		\
+{									\
+	return bitmap_empty((void *)(event->state.field),		\
+			    KVM_SDEI_MAX_VCPUS);			\
+}									\
+									\
+static inline void							\
+kvm_sdei_set_##field(struct kvm_sdei_registered_event *event,		\
+		     unsigned int index)				\
+{									\
+	set_bit(index, (void *)(event->state.field));			\
+}									\
+									\
+static inline void							\
+kvm_sdei_clear_##field(struct kvm_sdei_registered_event *event,		\
+		       unsigned int index)				\
+{									\
+	clear_bit(index, (void *)(event->state.field));			\
+}
+
+KVM_SDEI_REGISTERED_EVENT_FUNC(registered)
+KVM_SDEI_REGISTERED_EVENT_FUNC(enabled)
+KVM_SDEI_REGISTERED_EVENT_FUNC(unregister_pending)
+
+/* APIs */
+void kvm_sdei_init_vm(struct kvm *kvm);
+void kvm_sdei_create_vcpu(struct kvm_vcpu *vcpu);
+int kvm_sdei_hypercall(struct kvm_vcpu *vcpu);
+void kvm_sdei_destroy_vcpu(struct kvm_vcpu *vcpu);
+void kvm_sdei_destroy_vm(struct kvm *kvm);
+
+#endif /* __ARM64_KVM_SDEI_H__ */
diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
index 323e251ed37b..33ee95bc088e 100644
--- a/arch/arm64/include/uapi/asm/kvm.h
+++ b/arch/arm64/include/uapi/asm/kvm.h
@@ -36,6 +36,7 @@
 #include <linux/types.h>
 #include <asm/ptrace.h>
 #include <asm/sve_context.h>
+#include <asm/kvm_sdei_state.h>
 
 #define __KVM_HAVE_GUEST_DEBUG
 #define __KVM_HAVE_IRQ_LINE
diff --git a/arch/arm64/include/uapi/asm/kvm_sdei_state.h b/arch/arm64/include/uapi/asm/kvm_sdei_state.h
new file mode 100644
index 000000000000..b14844230117
--- /dev/null
+++ b/arch/arm64/include/uapi/asm/kvm_sdei_state.h
@@ -0,0 +1,72 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Definitions of various KVM SDEI event states.
+ *
+ * Copyright (C) 2022 Red Hat, Inc.
+ *
+ * Author(s): Gavin Shan <gshan@redhat.com>
+ */
+
+#ifndef _UAPI__ASM_KVM_SDEI_STATE_H
+#define _UAPI__ASM_KVM_SDEI_STATE_H
+
+#ifndef __ASSEMBLY__
+#include <linux/types.h>
+
+/*
+ * The software signaled event is the default one, which is
+ * defined in v1.1 specification.
+ */
+#define KVM_SDEI_INVALID_EVENT	0xFFFFFFFF
+#define KVM_SDEI_DEFAULT_EVENT	0
+
+#define KVM_SDEI_MAX_VCPUS	512	/* Aligned to 64 */
+#define KVM_SDEI_MAX_EVENTS	128
+
+struct kvm_sdei_exposed_event_state {
+	__u64	num;
+
+	__u8	type;
+	__u8	signaled;
+	__u8	priority;
+	__u8	padding[5];
+	__u64	notifier;
+};
+
+struct kvm_sdei_registered_event_state {
+	__u64	num;
+
+	__u8	route_mode;
+	__u8	padding[3];
+	__u64	route_affinity;
+	__u64	ep_address[KVM_SDEI_MAX_VCPUS];
+	__u64	ep_arg[KVM_SDEI_MAX_VCPUS];
+	__u64	registered[KVM_SDEI_MAX_VCPUS/64];
+	__u64	enabled[KVM_SDEI_MAX_VCPUS/64];
+	__u64	unregister_pending[KVM_SDEI_MAX_VCPUS/64];
+};
+
+struct kvm_sdei_vcpu_event_state {
+	__u64	num;
+
+	__u32	event_count;
+	__u32	padding;
+};
+
+struct kvm_sdei_vcpu_regs_state {
+	__u64	regs[18];
+	__u64	pc;
+	__u64	pstate;
+};
+
+struct kvm_sdei_vcpu_state {
+	__u8				masked;
+	__u8				padding[7];
+	__u64				critical_num;
+	__u64				normal_num;
+	struct kvm_sdei_vcpu_regs_state	critical_regs;
+	struct kvm_sdei_vcpu_regs_state	normal_regs;
+};
+
+#endif /* !__ASSEMBLY__ */
+#endif /* _UAPI__ASM_KVM_SDEI_STATE_H */
diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
index 91861fd8b897..a12903a21d1f 100644
--- a/arch/arm64/kvm/Makefile
+++ b/arch/arm64/kvm/Makefile
@@ -14,7 +14,7 @@ kvm-y += arm.o mmu.o mmio.o psci.o hypercalls.o pvtime.o \
 	 inject_fault.o va_layout.o handle_exit.o \
 	 guest.o debug.o reset.o sys_regs.o \
 	 vgic-sys-reg-v3.o fpsimd.o pmu.o pkvm.o \
-	 arch_timer.o trng.o\
+	 arch_timer.o trng.o sdei.o \
 	 vgic/vgic.o vgic/vgic-init.o \
 	 vgic/vgic-irqfd.o vgic/vgic-v2.o \
 	 vgic/vgic-v3.o vgic/vgic-v4.o \
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 4dca6ffd03d4..96fcae5beee4 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -38,6 +38,7 @@
 #include <asm/kvm_asm.h>
 #include <asm/kvm_mmu.h>
 #include <asm/kvm_emulate.h>
+#include <asm/kvm_sdei.h>
 #include <asm/sections.h>
 
 #include <kvm/arm_hypercalls.h>
@@ -152,6 +153,8 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 
 	kvm_vgic_early_init(kvm);
 
+	kvm_sdei_init_vm(kvm);
+
 	/* The maximum number of VCPUs is limited by the host's GIC model */
 	kvm->arch.max_vcpus = kvm_arm_default_max_vcpus();
 
@@ -179,6 +182,8 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
 
 	kvm_vgic_destroy(kvm);
 
+	kvm_sdei_destroy_vm(kvm);
+
 	kvm_destroy_vcpus(kvm);
 
 	kvm_unshare_hyp(kvm, kvm + 1);
@@ -330,6 +335,8 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 
 	kvm_arm_pvtime_vcpu_init(&vcpu->arch);
 
+	kvm_sdei_create_vcpu(vcpu);
+
 	vcpu->arch.hw_mmu = &vcpu->kvm->arch.mmu;
 
 	err = kvm_vgic_vcpu_init(vcpu);
@@ -351,6 +358,7 @@ void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
 	kvm_mmu_free_memory_cache(&vcpu->arch.mmu_page_cache);
 	kvm_timer_vcpu_terminate(vcpu);
 	kvm_pmu_vcpu_destroy(vcpu);
+	kvm_sdei_destroy_vcpu(vcpu);
 
 	kvm_arm_vcpu_destroy(vcpu);
 }
diff --git a/arch/arm64/kvm/hypercalls.c b/arch/arm64/kvm/hypercalls.c
index 202b8c455724..3c20fee72bb4 100644
--- a/arch/arm64/kvm/hypercalls.c
+++ b/arch/arm64/kvm/hypercalls.c
@@ -5,6 +5,7 @@
 #include <linux/kvm_host.h>
 
 #include <asm/kvm_emulate.h>
+#include <asm/kvm_sdei.h>
 
 #include <kvm/arm_hypercalls.h>
 #include <kvm/arm_psci.h>
@@ -151,6 +152,26 @@ int kvm_hvc_call_handler(struct kvm_vcpu *vcpu)
 	case ARM_SMCCC_TRNG_RND32:
 	case ARM_SMCCC_TRNG_RND64:
 		return kvm_trng_call(vcpu);
+	case SDEI_1_0_FN_SDEI_VERSION:
+	case SDEI_1_0_FN_SDEI_EVENT_REGISTER:
+	case SDEI_1_0_FN_SDEI_EVENT_ENABLE:
+	case SDEI_1_0_FN_SDEI_EVENT_DISABLE:
+	case SDEI_1_0_FN_SDEI_EVENT_CONTEXT:
+	case SDEI_1_0_FN_SDEI_EVENT_COMPLETE:
+	case SDEI_1_0_FN_SDEI_EVENT_COMPLETE_AND_RESUME:
+	case SDEI_1_0_FN_SDEI_EVENT_UNREGISTER:
+	case SDEI_1_0_FN_SDEI_EVENT_STATUS:
+	case SDEI_1_0_FN_SDEI_EVENT_GET_INFO:
+	case SDEI_1_0_FN_SDEI_EVENT_ROUTING_SET:
+	case SDEI_1_0_FN_SDEI_PE_MASK:
+	case SDEI_1_0_FN_SDEI_PE_UNMASK:
+	case SDEI_1_0_FN_SDEI_INTERRUPT_BIND:
+	case SDEI_1_0_FN_SDEI_INTERRUPT_RELEASE:
+	case SDEI_1_1_FN_SDEI_EVENT_SIGNAL:
+	case SDEI_1_0_FN_SDEI_PRIVATE_RESET:
+	case SDEI_1_0_FN_SDEI_SHARED_RESET:
+	case SDEI_1_1_FN_SDEI_FEATURES:
+		return kvm_sdei_hypercall(vcpu);
 	default:
 		return kvm_psci_call(vcpu);
 	}
diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
new file mode 100644
index 000000000000..8a9b477b8977
--- /dev/null
+++ b/arch/arm64/kvm/sdei.c
@@ -0,0 +1,244 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SDEI virtualization support.
+ *
+ * Copyright (C) 2022 Red Hat, Inc.
+ *
+ * Author(s): Gavin Shan <gshan@redhat.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/kvm_host.h>
+#include <linux/spinlock.h>
+#include <linux/slab.h>
+#include <kvm/arm_hypercalls.h>
+#include <asm/kvm_sdei.h>
+
+static void remove_all_exposed_events(struct kvm *kvm)
+{
+	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
+	struct kvm_sdei_exposed_event *exposed_event, *tmp;
+
+	list_for_each_entry_safe(exposed_event, tmp,
+				 &ksdei->exposed_events, link) {
+		ksdei->exposed_event_count--;
+		list_del(&exposed_event->link);
+
+		kfree(exposed_event);
+	}
+}
+
+static void remove_one_registered_event(struct kvm *kvm,
+		struct kvm_sdei_registered_event *registered_event)
+{
+	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
+	struct kvm_sdei_exposed_event *exposed_event;
+
+	exposed_event = registered_event->exposed_event;
+	ksdei->registered_event_count--;
+	exposed_event->registered_event_count--;
+
+	list_del(&registered_event->link);
+	kfree(registered_event);
+}
+
+static void remove_all_registered_events(struct kvm *kvm)
+{
+	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
+	struct kvm_sdei_registered_event *registered_event, *tmp;
+
+	list_for_each_entry_safe(registered_event, tmp,
+				 &ksdei->registered_events, link) {
+		remove_one_registered_event(kvm, registered_event);
+	}
+}
+
+static void remove_one_vcpu_event(struct kvm_vcpu *vcpu,
+				  struct kvm_sdei_vcpu_event *vcpu_event)
+{
+	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
+	struct kvm_sdei_exposed_event *exposed_event;
+	struct kvm_sdei_registered_event *registered_event;
+
+	registered_event = vcpu_event->registered_event;
+	exposed_event = registered_event->exposed_event;
+	registered_event->vcpu_event_count--;
+	if (kvm_sdei_is_critical(exposed_event->state.priority))
+		vsdei->critical_event_count--;
+	else
+		vsdei->normal_event_count--;
+
+	list_del(&vcpu_event->link);
+	kfree(vcpu_event);
+}
+
+static bool remove_all_vcpu_events(struct kvm_vcpu *vcpu,
+				   unsigned long num)
+{
+	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
+	struct kvm_sdei_vcpu_event *vcpu_event, *tmp;
+	bool pending = false;
+
+	list_for_each_entry_safe(vcpu_event, tmp,
+				 &vsdei->critical_events, link) {
+		if (!kvm_sdei_is_supported(num)) {
+			remove_one_vcpu_event(vcpu, vcpu_event);
+			continue;
+		}
+
+		if (vcpu_event->state.num != num)
+			continue;
+
+		if (vsdei->critical_event == vcpu_event) {
+			vcpu_event->state.event_count = 1;
+			pending = true;
+		} else {
+			remove_one_vcpu_event(vcpu, vcpu_event);
+		}
+	}
+
+	list_for_each_entry_safe(vcpu_event, tmp,
+				 &vsdei->normal_events, link) {
+		if (!kvm_sdei_is_supported(num)) {
+			remove_one_vcpu_event(vcpu, vcpu_event);
+			continue;
+		}
+
+		if (vcpu_event->state.num != num)
+			continue;
+
+		if (vsdei->normal_event == vcpu_event) {
+			vcpu_event->state.event_count = 1;
+			pending = true;
+		} else {
+			remove_one_vcpu_event(vcpu, vcpu_event);
+		}
+	}
+
+	return pending;
+}
+
+int kvm_sdei_hypercall(struct kvm_vcpu *vcpu)
+{
+	struct kvm *kvm = vcpu->kvm;
+	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
+	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
+	u32 func = smccc_get_function(vcpu);
+	bool has_result = true;
+	unsigned long ret;
+
+	/*
+	 * We don't have return value for COMPLETE or COMPLETE_AND_RESUME
+	 * hypercalls. Otherwise, the restored context will be corrupted.
+	 */
+	if (func == SDEI_1_0_FN_SDEI_EVENT_COMPLETE ||
+	    func == SDEI_1_0_FN_SDEI_EVENT_COMPLETE_AND_RESUME)
+		has_result = false;
+
+	if (!(ksdei && vsdei)) {
+		ret = SDEI_NOT_SUPPORTED;
+		goto out;
+	}
+
+	switch (func) {
+	case SDEI_1_0_FN_SDEI_VERSION:
+	case SDEI_1_0_FN_SDEI_EVENT_REGISTER:
+	case SDEI_1_0_FN_SDEI_EVENT_ENABLE:
+	case SDEI_1_0_FN_SDEI_EVENT_DISABLE:
+	case SDEI_1_0_FN_SDEI_EVENT_CONTEXT:
+	case SDEI_1_0_FN_SDEI_EVENT_COMPLETE:
+	case SDEI_1_0_FN_SDEI_EVENT_COMPLETE_AND_RESUME:
+	case SDEI_1_0_FN_SDEI_EVENT_UNREGISTER:
+	case SDEI_1_0_FN_SDEI_EVENT_STATUS:
+	case SDEI_1_0_FN_SDEI_EVENT_GET_INFO:
+	case SDEI_1_0_FN_SDEI_EVENT_ROUTING_SET:
+	case SDEI_1_0_FN_SDEI_PE_MASK:
+	case SDEI_1_0_FN_SDEI_PE_UNMASK:
+	case SDEI_1_0_FN_SDEI_INTERRUPT_BIND:
+	case SDEI_1_0_FN_SDEI_INTERRUPT_RELEASE:
+	case SDEI_1_1_FN_SDEI_EVENT_SIGNAL:
+	case SDEI_1_0_FN_SDEI_PRIVATE_RESET:
+	case SDEI_1_0_FN_SDEI_SHARED_RESET:
+	case SDEI_1_1_FN_SDEI_FEATURES:
+	default:
+		ret = SDEI_NOT_SUPPORTED;
+	}
+
+out:
+	if (has_result)
+		smccc_set_retval(vcpu, ret, 0, 0, 0);
+
+	return 1;
+}
+
+void kvm_sdei_init_vm(struct kvm *kvm)
+{
+	struct kvm_sdei_kvm *ksdei;
+
+	ksdei = kzalloc(sizeof(*ksdei), GFP_KERNEL_ACCOUNT);
+	if (!ksdei)
+		return;
+
+	spin_lock_init(&ksdei->lock);
+	INIT_LIST_HEAD(&ksdei->exposed_events);
+	INIT_LIST_HEAD(&ksdei->registered_events);
+
+	kvm->arch.sdei = ksdei;
+}
+
+void kvm_sdei_create_vcpu(struct kvm_vcpu *vcpu)
+{
+	struct kvm *kvm = vcpu->kvm;
+	struct kvm_sdei_vcpu *vsdei;
+
+	if (!kvm->arch.sdei)
+		return;
+
+	vsdei = kzalloc(sizeof(*vsdei), GFP_KERNEL_ACCOUNT);
+	if (!vsdei)
+		return;
+
+	spin_lock_init(&vsdei->lock);
+	vsdei->state.masked       = 1;
+	vsdei->state.critical_num = KVM_SDEI_INVALID_EVENT;
+	vsdei->state.normal_num   = KVM_SDEI_INVALID_EVENT;
+	vsdei->critical_event     = NULL;
+	vsdei->normal_event       = NULL;
+	INIT_LIST_HEAD(&vsdei->critical_events);
+	INIT_LIST_HEAD(&vsdei->normal_events);
+
+	vcpu->arch.sdei = vsdei;
+}
+
+void kvm_sdei_destroy_vcpu(struct kvm_vcpu *vcpu)
+{
+	struct kvm *kvm = vcpu->kvm;
+	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
+	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
+
+	if (ksdei && vsdei) {
+		spin_lock(&ksdei->lock);
+		spin_lock(&vsdei->lock);
+		remove_all_vcpu_events(vcpu, KVM_SDEI_INVALID_EVENT);
+		spin_unlock(&vsdei->lock);
+		spin_unlock(&ksdei->lock);
+
+		kfree(vsdei);
+		vcpu->arch.sdei = NULL;
+	}
+}
+
+void kvm_sdei_destroy_vm(struct kvm *kvm)
+{
+	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
+
+	if (ksdei) {
+		spin_lock(&ksdei->lock);
+		remove_all_registered_events(kvm);
+		remove_all_exposed_events(kvm);
+		spin_unlock(&ksdei->lock);
+
+		kfree(ksdei);
+		kvm->arch.sdei = NULL;
+	}
+}
diff --git a/include/uapi/linux/arm_sdei.h b/include/uapi/linux/arm_sdei.h
index af0630ba5437..39bcf6dbbea0 100644
--- a/include/uapi/linux/arm_sdei.h
+++ b/include/uapi/linux/arm_sdei.h
@@ -22,8 +22,10 @@
 #define SDEI_1_0_FN_SDEI_PE_UNMASK			SDEI_1_0_FN(0x0C)
 #define SDEI_1_0_FN_SDEI_INTERRUPT_BIND			SDEI_1_0_FN(0x0D)
 #define SDEI_1_0_FN_SDEI_INTERRUPT_RELEASE		SDEI_1_0_FN(0x0E)
+#define SDEI_1_1_FN_SDEI_EVENT_SIGNAL			SDEI_1_0_FN(0x0F)
 #define SDEI_1_0_FN_SDEI_PRIVATE_RESET			SDEI_1_0_FN(0x11)
 #define SDEI_1_0_FN_SDEI_SHARED_RESET			SDEI_1_0_FN(0x12)
+#define SDEI_1_1_FN_SDEI_FEATURES			SDEI_1_0_FN(0x30)
 
 #define SDEI_VERSION_MAJOR_SHIFT			48
 #define SDEI_VERSION_MAJOR_MASK				0x7fff
-- 
2.23.0


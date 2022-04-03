Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E768F4F0ABC
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 17:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359215AbiDCPl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 11:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359217AbiDCPlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 11:41:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 67C3520F77
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 08:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649000396;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DXV0GJbfQb30VmvopyFXAXgw1DPy3SwG+/PxB8ps2Wg=;
        b=XgOUWtJ/NQEYIvxKJCi+9v6jj2ppdtp4QhVzw/O6jFsWIil+UsTn3Ffb8i8Wd4lkTyF/Fc
        4prkkSeWkY5QqPXX3NWM9dHgs3hQsizkB+E0llF5mIVw8+mC17UTU1wExDOab9Osgu7A2k
        t8eIG0+L7jh6rn3MVLnjTGPUAa2IRPQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-449-kZtmgxU7NaKRm6VusNzn8g-1; Sun, 03 Apr 2022 11:39:53 -0400
X-MC-Unique: kZtmgxU7NaKRm6VusNzn8g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E6B12802803;
        Sun,  3 Apr 2022 15:39:52 +0000 (UTC)
Received: from gshan.redhat.com (ovpn-12-82.pek2.redhat.com [10.72.12.82])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F30F64538D7;
        Sun,  3 Apr 2022 15:39:46 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, eauger@redhat.com, oupton@google.com,
        Jonathan.Cameron@huawei.com, vkuznets@redhat.com, will@kernel.org,
        shannon.zhaosl@gmail.com, james.morse@arm.com,
        mark.rutland@arm.com, maz@kernel.org, pbonzini@redhat.com,
        shan.gavin@gmail.com
Subject: [PATCH v6 03/18] KVM: arm64: Add SDEI virtualization infrastructure
Date:   Sun,  3 Apr 2022 23:38:56 +0800
Message-Id: <20220403153911.12332-4-gshan@redhat.com>
In-Reply-To: <20220403153911.12332-1-gshan@redhat.com>
References: <20220403153911.12332-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Software Delegated Exception Interface (SDEI) provides a mechanism
for registering and servicing system events, as defined by ARM DEN0054C
specification. One of these events will be used by Asynchronous Page
Fault (Async PF) to deliver notifications from host to guest.

The events are classified into shared and private ones according to
their scopes. The shared events are system or VM scoped, but the
private events are CPU or VCPU scoped. The shared events can be
registered, enabled, unregistered and reset through hypercalls
issued from any VCPU. However, the private events are registered,
enabled, unregistered and reset on the calling VCPU through
hypercalls. Besides, the events are also classified into critical
and normal events according their priority. During event delivery
and handling, the normal event can be preempted by another critical
event, but not in reverse way. The critical event is never preempted
by another normal event.

This introduces SDEI virtualization infrastructure for various objects
used in the implementation. Currently, we don't support the shared
event.

  * kvm_sdei_exposed_event
    The event which are defined and exposed by KVM. The event can't
    be registered until it's exposed. Besides, all the information
    in this event can't be changed after it's exposed.

  * kvm_sdei_event
    The events are created based on the exposed events. Their states
    are changed when hypercalls are received or they are delivered
    to guest for handling.

  * kvm_sdei_vcpu_context
    The vcpu context helps to handle events. The interrupted context
    is saved before the event handler is executed, and restored after
    the event handler is to finish.

  * kvm_sdei_vcpu
    Place holder for all objects for one particular VCPU.

The error of SDEI_NOT_SUPPORTED is returned for all hypercalls for now.
They will be supported one by one in the subsequent patches.

Link: https://developer.arm.com/documentation/den0054/latest
Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/include/asm/kvm_host.h |   1 +
 arch/arm64/include/asm/kvm_sdei.h | 148 ++++++++++++++++++++++++++++++
 arch/arm64/kvm/Makefile           |   2 +-
 arch/arm64/kvm/arm.c              |   4 +
 arch/arm64/kvm/hypercalls.c       |   3 +
 arch/arm64/kvm/sdei.c             |  98 ++++++++++++++++++++
 include/uapi/linux/arm_sdei.h     |   4 +
 7 files changed, 259 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/include/asm/kvm_sdei.h
 create mode 100644 arch/arm64/kvm/sdei.c

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index e3b25dc6c367..7644a400c4a8 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -343,6 +343,7 @@ struct kvm_vcpu_arch {
 	 * Anything that is not used directly from assembly code goes
 	 * here.
 	 */
+	struct kvm_sdei_vcpu *sdei;
 
 	/*
 	 * Guest registers we preserve during guest debugging.
diff --git a/arch/arm64/include/asm/kvm_sdei.h b/arch/arm64/include/asm/kvm_sdei.h
new file mode 100644
index 000000000000..2dbfb3ae0a48
--- /dev/null
+++ b/arch/arm64/include/asm/kvm_sdei.h
@@ -0,0 +1,148 @@
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
+#include <linux/arm-smccc.h>
+#include <linux/bits.h>
+#include <linux/spinlock.h>
+
+/*
+ * The event which are defined and exposed by KVM. The event can't
+ * be registered until it's exposed. Besides, all the information
+ * in this event can't be changed after it's exposed.
+ */
+struct kvm_sdei_exposed_event {
+	unsigned int	num;
+	unsigned char	type;
+	unsigned char	signaled;
+	unsigned char	priority;
+};
+
+/*
+ * Currently, only the private events are supported. The events are
+ * created based on the exposed events and their states are changed
+ * when hypercalls are received or they are delivered to guest for
+ * handling.
+ */
+struct kvm_sdei_event {
+	struct kvm_sdei_exposed_event	*exposed_event;
+
+	unsigned char			route_mode;
+	unsigned long			route_affinity;
+	unsigned long			ep_address;
+	unsigned long			ep_arg;
+#define KVM_SDEI_EVENT_STATE_REGISTERED		BIT(0)
+#define KVM_SDEI_EVENT_STATE_ENABLED		BIT(1)
+#define KVM_SDEI_EVENT_STATE_UNREGISTER_PENDING	BIT(2)
+	unsigned long			state;
+	unsigned long			event_count;
+};
+
+/*
+ * The vcpu context helps to handle events. The preempted or interrupted
+ * context is saved before the event handler is executed, and restored
+ * after the event handler is to finish. The event with normal priority
+ * can be preempted by the one with critical priority. So there can be
+ * two contexts on one particular vcpu for the events with normal and
+ * critical priority separately.
+ */
+struct kvm_sdei_vcpu_context {
+	struct kvm_sdei_event	*event;
+	unsigned long		regs[18];
+	unsigned long		pc;
+	unsigned long		pstate;
+};
+
+struct kvm_sdei_vcpu {
+	spinlock_t			lock;
+	struct kvm_sdei_event		*events;
+	unsigned char			masked;
+	unsigned long			critical_event_count;
+	unsigned long			normal_event_count;
+	struct kvm_sdei_vcpu_context	context[SDEI_EVENT_PRIORITY_CRITICAL + 1];
+};
+
+/*
+ * According to SDEI specification (v1.1), the event number spans 32-bits
+ * and the lower 24-bits are used as the (real) event number. I don't
+ * think we can use that much event numbers in one system. So we reserve
+ * two bits from the 24-bits real event number, to indicate its types:
+ * physical or virtual event. One reserved bit is enough for now, but
+ * two bits are reserved for possible extension in future.
+ *
+ * The physical events are owned by firmware while the virtual events
+ * are used by VMM and KVM.
+ */
+#define KVM_SDEI_EVENT_NUM_TYPE_SHIFT	22
+#define KVM_SDEI_EVENT_NUM_TYPE_MASK	(3 << KVM_SDEI_EVENT_NUM_TYPE_SHIFT)
+#define KVM_SDEI_EVENT_NUM_TYPE_PHYS	0
+#define KVM_SDEI_EVENT_NUM_TYPE_VIRT	1
+
+static inline bool kvm_sdei_is_virtual(unsigned int num)
+{
+	unsigned int type;
+
+	type = (num & KVM_SDEI_EVENT_NUM_TYPE_MASK) >>
+	       KVM_SDEI_EVENT_NUM_TYPE_SHIFT;
+	if (type == KVM_SDEI_EVENT_NUM_TYPE_VIRT)
+		return true;
+
+	return false;
+}
+
+static inline bool kvm_sdei_is_sw_signaled(unsigned int num)
+{
+	return num == SDEI_SW_SIGNALED_EVENT;
+}
+
+static inline bool kvm_sdei_is_supported(unsigned int num)
+{
+	return kvm_sdei_is_sw_signaled(num) ||
+	       kvm_sdei_is_virtual(num);
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
+#define KVM_SDEI_REGISTERED_EVENT_FUNC(func, field)			\
+static inline bool kvm_sdei_is_##func(struct kvm_sdei_event *event)	\
+{									\
+	return !!(event->state & KVM_SDEI_EVENT_STATE_##field);		\
+}									\
+									\
+static inline void kvm_sdei_set_##func(struct kvm_sdei_event *event)	\
+{									\
+	event->state |= KVM_SDEI_EVENT_STATE_##field;			\
+}									\
+									\
+static inline void kvm_sdei_clear_##func(struct kvm_sdei_event *event)	\
+{									\
+	event->state &= ~KVM_SDEI_EVENT_STATE_##field;			\
+}
+
+KVM_SDEI_REGISTERED_EVENT_FUNC(registered, REGISTERED)
+KVM_SDEI_REGISTERED_EVENT_FUNC(enabled, ENABLED)
+KVM_SDEI_REGISTERED_EVENT_FUNC(unregister_pending, UNREGISTER_PENDING)
+
+/* APIs */
+int kvm_sdei_call(struct kvm_vcpu *vcpu);
+void kvm_sdei_create_vcpu(struct kvm_vcpu *vcpu);
+void kvm_sdei_destroy_vcpu(struct kvm_vcpu *vcpu);
+
+#endif /* __ARM64_KVM_SDEI_H__ */
diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
index 261644b1a6bb..d6ced92ae3f0 100644
--- a/arch/arm64/kvm/Makefile
+++ b/arch/arm64/kvm/Makefile
@@ -14,7 +14,7 @@ kvm-y += arm.o mmu.o mmio.o psci.o hypercalls.o pvtime.o \
 	 inject_fault.o va_layout.o handle_exit.o \
 	 guest.o debug.o reset.o sys_regs.o \
 	 vgic-sys-reg-v3.o fpsimd.o pmu.o pkvm.o \
-	 arch_timer.o trng.o vmid.o \
+	 arch_timer.o trng.o vmid.o sdei.o \
 	 vgic/vgic.o vgic/vgic-init.o \
 	 vgic/vgic-irqfd.o vgic/vgic-v2.o \
 	 vgic/vgic-v3.o vgic/vgic-v4.o \
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 523bc934fe2f..227c0e390571 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -38,6 +38,7 @@
 #include <asm/kvm_asm.h>
 #include <asm/kvm_mmu.h>
 #include <asm/kvm_emulate.h>
+#include <asm/kvm_sdei.h>
 #include <asm/sections.h>
 
 #include <kvm/arm_hypercalls.h>
@@ -331,6 +332,8 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 
 	kvm_arm_pvtime_vcpu_init(&vcpu->arch);
 
+	kvm_sdei_create_vcpu(vcpu);
+
 	vcpu->arch.hw_mmu = &vcpu->kvm->arch.mmu;
 
 	err = kvm_vgic_vcpu_init(vcpu);
@@ -352,6 +355,7 @@ void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
 	kvm_mmu_free_memory_cache(&vcpu->arch.mmu_page_cache);
 	kvm_timer_vcpu_terminate(vcpu);
 	kvm_pmu_vcpu_destroy(vcpu);
+	kvm_sdei_destroy_vcpu(vcpu);
 
 	kvm_arm_vcpu_destroy(vcpu);
 }
diff --git a/arch/arm64/kvm/hypercalls.c b/arch/arm64/kvm/hypercalls.c
index b659387d8919..6aa027a4cee8 100644
--- a/arch/arm64/kvm/hypercalls.c
+++ b/arch/arm64/kvm/hypercalls.c
@@ -5,6 +5,7 @@
 #include <linux/kvm_host.h>
 
 #include <asm/kvm_emulate.h>
+#include <asm/kvm_sdei.h>
 
 #include <kvm/arm_hypercalls.h>
 #include <kvm/arm_psci.h>
@@ -93,6 +94,8 @@ static int kvm_hvc_standard(struct kvm_vcpu *vcpu, u32 func)
 	case PSCI_1_1_FN_SYSTEM_RESET2:
 	case PSCI_1_1_FN64_SYSTEM_RESET2:
 		return kvm_psci_call(vcpu);
+	case SDEI_1_0_FN_SDEI_VERSION ... SDEI_1_1_FN_SDEI_FEATURES:
+		return kvm_sdei_call(vcpu);
 	}
 
 	smccc_set_retval(vcpu, val, 0, 0, 0);
diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
new file mode 100644
index 000000000000..3507e33ec00e
--- /dev/null
+++ b/arch/arm64/kvm/sdei.c
@@ -0,0 +1,98 @@
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
+#include <linux/slab.h>
+#include <kvm/arm_hypercalls.h>
+#include <asm/kvm_sdei.h>
+
+static struct kvm_sdei_exposed_event exposed_events[] = {
+	{ .num      = SDEI_SW_SIGNALED_EVENT,
+	  .type     = SDEI_EVENT_TYPE_PRIVATE,
+	  .signaled = 1,
+	  .priority = SDEI_EVENT_PRIORITY_NORMAL,
+	},
+};
+
+#define kvm_sdei_for_each_exposed_event(event, idx)	\
+	for (idx = 0, event = &exposed_events[0];	\
+	     idx < ARRAY_SIZE(exposed_events);		\
+	     idx++, event++)
+
+int kvm_sdei_call(struct kvm_vcpu *vcpu)
+{
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
+	if (!vsdei) {
+		ret = SDEI_NOT_SUPPORTED;
+		goto out;
+	}
+
+	switch (func) {
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
+void kvm_sdei_create_vcpu(struct kvm_vcpu *vcpu)
+{
+	struct kvm_sdei_vcpu *vsdei;
+	struct kvm_sdei_exposed_event *exposed_event;
+	struct kvm_sdei_event *events;
+	unsigned int i;
+
+	vsdei = kzalloc(sizeof(*vsdei), GFP_KERNEL_ACCOUNT);
+	if (!vsdei)
+		return;
+
+	events = kcalloc(ARRAY_SIZE(exposed_events), sizeof(*events),
+			 GFP_KERNEL_ACCOUNT);
+	if (!events) {
+		kfree(vsdei);
+		return;
+	}
+
+	kvm_sdei_for_each_exposed_event(exposed_event, i)
+		events[i].exposed_event = exposed_event;
+
+	spin_lock_init(&vsdei->lock);
+	vsdei->events = events;
+	vsdei->masked = 1;
+	vcpu->arch.sdei = vsdei;
+}
+
+void kvm_sdei_destroy_vcpu(struct kvm_vcpu *vcpu)
+{
+	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
+
+	if (!vsdei)
+		return;
+
+	vcpu->arch.sdei = NULL;
+	kfree(vsdei->events);
+	kfree(vsdei);
+}
diff --git a/include/uapi/linux/arm_sdei.h b/include/uapi/linux/arm_sdei.h
index af0630ba5437..572c77c59af6 100644
--- a/include/uapi/linux/arm_sdei.h
+++ b/include/uapi/linux/arm_sdei.h
@@ -22,8 +22,12 @@
 #define SDEI_1_0_FN_SDEI_PE_UNMASK			SDEI_1_0_FN(0x0C)
 #define SDEI_1_0_FN_SDEI_INTERRUPT_BIND			SDEI_1_0_FN(0x0D)
 #define SDEI_1_0_FN_SDEI_INTERRUPT_RELEASE		SDEI_1_0_FN(0x0E)
+#define SDEI_1_1_FN_SDEI_EVENT_SIGNAL			SDEI_1_0_FN(0x0F)
 #define SDEI_1_0_FN_SDEI_PRIVATE_RESET			SDEI_1_0_FN(0x11)
 #define SDEI_1_0_FN_SDEI_SHARED_RESET			SDEI_1_0_FN(0x12)
+#define SDEI_1_1_FN_SDEI_FEATURES			SDEI_1_0_FN(0x30)
+
+#define SDEI_SW_SIGNALED_EVENT	0
 
 #define SDEI_VERSION_MAJOR_SHIFT			48
 #define SDEI_VERSION_MAJOR_MASK				0x7fff
-- 
2.23.0


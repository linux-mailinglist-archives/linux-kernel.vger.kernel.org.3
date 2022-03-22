Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9074E3A4C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 09:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbiCVINH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 04:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbiCVIMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 04:12:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7BF20DF03
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 01:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647936686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fBBhLhLF48pyJ0vNP0OdtcJfMpQ+vVDcYKgHhm2JbtU=;
        b=fMBdRthti3KsY6mSVzah4Z6lSwJVlcf3UiVuZ+9G7Ow/mHlNj4i04yAMEllNDxZ/Ag7YWv
        gNJlc5qM9nqhhuXWIqYtwVcxSINSKPyGl3j3RmXWbZg+No3wfKzxC/eccPYo9TaDN4SJBM
        eM1wsOwxdcb+VbS1/bu9ABKvbA4BN2E=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-392-aspAOXk6Pe6Ssjy2ZTO9gg-1; Tue, 22 Mar 2022 04:11:23 -0400
X-MC-Unique: aspAOXk6Pe6Ssjy2ZTO9gg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B40B63C01C17;
        Tue, 22 Mar 2022 08:11:22 +0000 (UTC)
Received: from gshan.redhat.com (ovpn-12-33.pek2.redhat.com [10.72.12.33])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4212C1121324;
        Tue, 22 Mar 2022 08:10:58 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, eauger@redhat.com,
        shannon.zhaosl@gmail.com, maz@kernel.org,
        Jonathan.Cameron@huawei.com, will@kernel.org, pbonzini@redhat.com,
        james.morse@arm.com, mark.rutland@arm.com, drjones@redhat.com,
        vkuznets@redhat.com, shan.gavin@gmail.com
Subject: [PATCH v5 21/22] KVM: arm64: Add SDEI document
Date:   Tue, 22 Mar 2022 16:07:09 +0800
Message-Id: <20220322080710.51727-22-gshan@redhat.com>
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

This adds one document to explain how virtualized SDEI service is
implemented and supported.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 Documentation/virt/kvm/arm/sdei.rst | 325 ++++++++++++++++++++++++++++
 1 file changed, 325 insertions(+)
 create mode 100644 Documentation/virt/kvm/arm/sdei.rst

diff --git a/Documentation/virt/kvm/arm/sdei.rst b/Documentation/virt/kvm/arm/sdei.rst
new file mode 100644
index 000000000000..61213e4b9aea
--- /dev/null
+++ b/Documentation/virt/kvm/arm/sdei.rst
@@ -0,0 +1,325 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=====================================
+SDEI Virtualization Support for ARM64
+=====================================
+
+Arm specification DEN0054/C defines Software Delegated Exception Interface
+(SDEI). It provides a mechanism for registering and servicing system events
+from system firmware. The interface is offered by a higher exception level
+to a lower exception level, in other words by a secure platform firmware
+to hypervisor or hypervisor to OS or both.
+
+https://developer.arm.com/documentation/den0054/c
+
+KVM/arm64 implements the defined hypercalls in the specification so that
+the system events can be registered and serviced from KVM hypervisor to
+the guest OS.
+
+SDEI Event Management
+=====================
+
+Each SDEI event is associated and identified with a 32-bit number. The
+lower 24-bits is the event number, but other bits are reserved or used
+for vendor defined events. In KVM/arm64 implementation, bit 22 and 23
+are further reserved to identify the events visible to the implementation.
+Value 0x1 should be seen in this field for those KVM/arm64 visible events.
+In the meanwhile, event number 0x0 is also supported since it is used by
+SDEI_EVENT_SIGNAL hypercall.
+
+The SDEI event needs to be exposed through ioctl interface by VMM to
+hypervisor before the guest is able to register it. The exposed event
+is represented by ``struct kvm_sdei_exposed_event``. The registered event
+is represented by ``struct kvm_sdei_registered_event``, whose instances
+are created on SDEI_EVENT_REGISTER hypercall. There is only one registered
+event instance in one particular VM no matter what event type is. The
+registered event can be injected and delivered to one specific vcpu in
+forms of vcpu event. ``struct kvm_sdei_vcpu_event`` describes vcpu events.
+On the particular vcpu, one vcpu event instance can be shared by multiple
+events.
+
+The execution runs into SDEI context when vcpu event is handled. The
+interrupted or preempted context should be saved to vcpu state, which
+is represented by ``struct kvm_sdei_vcpu``. After that, the SDEI event
+handler, which was provided by SDEI_EVENT_REGISTER hypercall is invoked.
+SDEI_EVENT_COMPLETE or SDEI_EVENT_COMPLETE_AND_RESUME hypercall must be
+issued before the SDEI event handler is to complete. When one of these
+two hypercalls is received, the interrupted or preempted context is
+restored from vcpu state for execution.
+
+When migration happens, the status of one particular SDEI event is not
+deterministic. So we need to support migration for the aforementioned
+structures or objects. The information capable of migration in these
+objects are put into separate data structures, which are the corresponding
+state variant in kvm_sdei_state.h. Besides, ioctl command are introduced
+to read and write them on the source and destination VM during migration.
+
+IOCTL Commands
+==============
+
+KVM_ARM_SDEI_COMMAND
+--------------------
+
+:Capability: KVM_CAP_ARM_SDEI
+:Type: vm ioctl, vcpu ioctl
+:Parameters: struct kvm_sdei_cmd
+:Returns: 0 on success, < 0 on error
+
+::
+
+    struct kvm_sdei_cmd {
+        __u32        cmd;
+        union {
+            __u32    version;
+            __u32    count;
+        };
+        union {
+            struct kvm_sdei_exposed_event_state     *exposed_event_state;
+            struct kvm_sdei_registered_event_state  *registered_event_state;
+            struct kvm_sdei_vcpu_event_state        *vcpu_event_state;
+            struct kvm_sdei_vcpu_state              *vcpu_state;
+            __u64                                   num;
+        };
+    };
+
+The SDEI ioctl command is identified by KVM_ARM_SDEI_COMMAND and ``cmd``
+in the argument ``struct kvm_sdei_cmd`` provides further command to be
+executed.
+
+KVM_SDEI_CMD_GET_VERSION
+------------------------
+
+:Type: vm ioctl
+:Parameters: struct kvm_sdei_cmd
+:Returns: 0 on success, < 0 on error
+
+On success, the implementation version is returned in ``version`` of
+``struct kvm_sdei_cmd``. This version is different from that of the
+followed SDEI specification. The implementation version is used to tell
+the coherence extent to the following specification. For example, the
+SDEI interrupt binding event is defined in SDEI v1.1 specification,
+but it is not supported in current implementation.
+
+KVM_SDEI_CMD_GET_EXPOSED_EVENT_COUNT
+------------------------------------
+
+:Type: vm ioctl
+:Parameters: struct kvm_sdei_cmd
+:Returns: 0 on success, < 0 on error
+
+This ioctl command is used prior to KVM_SDEI_CMD_GET_EXPOSED_EVENT, to
+prepare ``exposed_event_state`` of ``struct kvm_sdei_cmd`` for that
+command during migration.
+
+On success, the number of exposed events is returned by ``count``
+of ``struct kvm_sdei_cmd``.
+
+KVM_SDEI_CMD_GET_EXPOSED_EVENT
+------------------------------
+
+:Type: vm ioctl
+:Parameters: struct kvm_sdei_cmd, struct kvm_sdei_exposed_event_state
+:Returns: 0 on success, < 0 on error
+
+::
+
+    struct kvm_sdei_exposed_event_state {
+        __u64   num;
+
+        __u8    type;
+        __u8    signaled;
+        __u8    priority;
+        __u8    padding[5];
+        __u64   notifier;
+    };
+
+This ioctl command is used to retrieve the exposed events on the source
+VM during migration.
+
+The number of exposed events to be retrieved is specified by ``count``
+of ``struct kvm_sdei_cmd``. On success, the retrieved exposed events are
+returned by ``exposed_event_state`` of ``struct kvm_sdei_state``.
+
+KVM_SDEI_CMD_SET_EXPOSED_EVENT
+------------------------------
+
+:Type: vm ioctl
+:Parameters: struct kvm_sdei_cmd, struct kvm_sdei_exposed_event_state
+:Returns: 0 on success, < 0 on error
+
+This ioctl command is used by VMM to expose SDEI events and migrate
+them. The ``notifier`` of ``struct kvm_sdei_exposed_event_state``
+will be modified if the specified exposed event has been existing.
+
+The number of events to be exposed is specified by ``count`` of
+``struct kvm_sdei_cmd``. The information about the exposed events is
+passed by ``exposed_event_state`` of ``struct kvm_sdei_cmd``.
+
+KVM_SDEI_CMD_GET_REGISTERED_EVENT_COUNT
+---------------------------------------
+
+:Type: vm ioctl
+:Parameters: struct kvm_sdei_cmd
+:Returns: 0 on success, < 0 on error
+
+This ioctl command is used prior to KVM_SDEI_CMD_GET_REGISTERED_EVENT,
+to prepare ``registered_event_state`` of ``struct kvm_sdei_cmd`` for
+that command during migration.
+
+On success, the number of registered events is returned by ``count``
+of ``struct kvm_sdei_cmd``.
+
+KVM_SDEI_CMD_GET_REGISTERED_EVENT
+---------------------------------
+
+:Type: vm ioctl
+:Parameters: struct kvm_sdei_cmd, struct kvm_sdei_registered_event_state
+:Returns: 0 on success, < 0 on error
+
+::
+    struct kvm_sdei_registered_event_state {
+        __u64   num;
+
+        __u8    route_mode;
+        __u8    padding[3];
+        __u64   route_affinity;
+        __u64   ep_address[KVM_SDEI_MAX_VCPUS];
+        __u64   ep_arg[KVM_SDEI_MAX_VCPUS];
+        __u64   registered[KVM_SDEI_MAX_VCPUS/64];
+        __u64   enabled[KVM_SDEI_MAX_VCPUS/64];
+        __u64   unregister_pending[KVM_SDEI_MAX_VCPUS/64];
+    };
+
+This ioctl command is used to retrieve the registered events on the
+source VM during migration.
+
+The number of registered events to be retrieved is specified by ``count``
+of ``struct kvm_sdei_cmd``. On success, the retrieved registered events
+are returned by ``registered_event_state`` of ``struct kvm_sdei_state``.
+
+KVM_SDEI_CMD_SET_REGISTERED_EVENT
+---------------------------------
+
+:Type: vm ioctl
+:Parameters: struct kvm_sdei_cmd, struct kvm_sdei_registered_event_state
+:Returns: 0 on success, < 0 on error
+
+This ioctl command is used by VMM to migrate the registered events
+on the destination VM.
+
+The number of events to be registered is specified by ``count`` of
+``struct kvm_sdei_cmd``. The information about the registered events
+is passed by ``registered_event_state`` of ``struct kvm_sdei_cmd``.
+
+KVM_SDEI_CMD_GET_VCPU_EVENT_COUNT
+---------------------------------
+
+:Type: vcpu ioctl
+:Parameters: struct kvm_sdei_cmd
+:Returns: 0 on success, < 0 on error
+
+This ioctl command is used prior to KVM_SDEI_CMD_GET_VCPU_EVENT, to
+prepare ``vcpu_event_state`` of ``struct kvm_sdei_cmd`` for that
+command during migration.
+
+On success, the number of vcpu events is returned by ``count``
+of ``struct kvm_sdei_cmd``.
+
+KVM_SDEI_CMD_GET_VCPU_EVENT
+---------------------------
+
+:Type: vcpu ioctl
+:Parameters: struct kvm_sdei_cmd, struct kvm_sdei_vcpu_event_state
+:Returns: 0 on success, < 0 on error
+
+::
+
+    struct kvm_sdei_vcpu_event_state {
+        __u64   num;
+
+        __u32   event_count;
+        __u32   padding;
+    };
+
+This ioctl command is used to retrieve the vcpu events on the source
+VM during migration.
+
+The number of vcpu events to be retrieved is specified by ``count`` of
+``struct kvm_sdei_cmd``. On success, the retrieved exposed events are
+returned by ``vcpu_event_state`` of ``struct kvm_sdei_state``.
+
+KVM_SDEI_CMD_SET_VCPU_EVENT
+---------------------------
+
+:Type: vcpu ioctl
+:Parameters: struct kvm_sdei_cmd, struct kvm_sdei_vcpu_event_state
+:Returns: 0 on success, < 0 on error
+
+This ioctl command is used by VMM to migrate the vcpu events on the
+destination VM.
+
+The number of vcpu events to be added is specified by ``count`` of
+``struct kvm_sdei_cmd``. The information about the vcpu events is
+passed by ``vcpu_event_state`` of ``struct kvm_sdei_cmd``.
+
+KVM_SDEI_CMD_GET_VCPU_STATE
+---------------------------
+
+:Type: vcpu ioctl
+:Parameters: struct kvm_sdei_cmd, struct kvm_sdei_vcpu_state
+:Returns: 0 on success, < 0 on error
+
+::
+
+    struct kvm_sdei_vcpu_regs_state {
+        __u64   regs[18];
+        __u64   pc;
+        __u64   pstate;
+    };
+
+    struct kvm_sdei_vcpu_state {
+        __u8                            masked;
+        __u8                            padding[7];
+        __u64                           critical_num;
+        __u64                           normal_num;
+        struct kvm_sdei_vcpu_regs_state critical_regs;
+        struct kvm_sdei_vcpu_regs_state normal_regs;
+    };
+
+This ioctl command is used to retrieve the vcpu state on the source VM
+during migration.
+
+On success, the current vcpu state is returned by ``vcpu_state`` of
+``struct kvm_sdei_cmd``.
+
+KVM_SDEI_CMD_SET_VCPU_STATE
+---------------------------
+
+:Type: vcpu ioctl
+:Parameters: struct kvm_sdei_cmd, struct kvm_sdei_vcpu_state
+:Returns: 0 on success, < 0 on error
+
+This ioctl command is used by VMM to migrate the vcpu state on the
+destination VM.
+
+The vcpu state to be configured is passed by ``vcpu_state`` of
+``struct kvm_sdei_cmd``.
+
+KVM_SDEI_CMD_INJECT_EVENT
+-------------------------
+
+:Type: vcpu ioctl
+:Parameters: struct kvm_sdei_cmd, struct kvm_sdei_vcpu_state
+:Returns: 0 on success, < 0 on error
+
+This ioctl command is used by VMM to inject SDEI event to the specified
+vcpu.
+
+The number of the SDEI event to be injected is passed by ``num`` of
+``struct kvm_sdei_cmd``.
+
+Future Work
+===========
+
+1. Support the routing mode and affinity for the shared events.
+2. Support interrupt binding events.
-- 
2.23.0


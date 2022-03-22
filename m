Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D173F4E3A51
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 09:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbiCVIN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 04:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbiCVINZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 04:13:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7E7CD16590
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 01:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647936716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SuoNHRzUPWWhkYa3DBe2wOhzLsIQa6xM5wffndPFSig=;
        b=SVLivOm1kZ/ca3JWgbmfdq1BI2Cb6pqJP55ehsW93fai4E+ELwwwCD+5YFOhWD0hGKQ/AG
        S2nfCeDTQBeOix+1jtpy4D5dhKsP0r0vn9/PWOEH0H6x3gtfvZ1Lnn+BO3P9Q7BBNZJXj6
        zztK07sSH9SIF7Om5mkfcRMmGZHDiIQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-45-OgXkFtI9OKmju0xspCIjXQ-1; Tue, 22 Mar 2022 04:11:53 -0400
X-MC-Unique: OgXkFtI9OKmju0xspCIjXQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0DB32802809;
        Tue, 22 Mar 2022 08:11:53 +0000 (UTC)
Received: from gshan.redhat.com (ovpn-12-33.pek2.redhat.com [10.72.12.33])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 83A221121324;
        Tue, 22 Mar 2022 08:11:23 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, eauger@redhat.com,
        shannon.zhaosl@gmail.com, maz@kernel.org,
        Jonathan.Cameron@huawei.com, will@kernel.org, pbonzini@redhat.com,
        james.morse@arm.com, mark.rutland@arm.com, drjones@redhat.com,
        vkuznets@redhat.com, shan.gavin@gmail.com
Subject: [PATCH v5 22/22] KVM: selftests: Add SDEI test case
Date:   Tue, 22 Mar 2022 16:07:10 +0800
Message-Id: <20220322080710.51727-23-gshan@redhat.com>
In-Reply-To: <20220322080710.51727-1-gshan@redhat.com>
References: <20220322080710.51727-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds SDEI self-test case where the various hypercalls are issued
to default event (0x0). The default event is private, signaled and in
normal priority.

By default, two vCPUs are started and the following ioctl commands
or hypercalls are sent to them in sequence, to simulate how they
are used in VMM and the linux guest:

   kvm_check_cap(KVM_CAP_ARM_SDEI)
   KVM_SDEI_CMD_GET_VERSION
   KVM_SDEI_CMD_SET_EXPOSED_EVENT      (expose event)

   SDEI_1_0_FN_SDEI_VERSION
   SDEI_1_1_FN_SDEI_FEATURES           (SDEI capability probing)
   SDEI_1_0_FN_SDEI_SHARED_RESET       (restart SDEI)
   SDEI_1_0_FN_SDEI_PE_UNMASK          (CPU online)

   SDEI_1_0_FN_SDEI_EVENT_GET_INFO
   SDEI_1_0_FN_SDEI_EVENT_REGISTER     (register event)
   SDEI_1_0_FN_SDEI_EVENT_ENABLE       (enable event)
   SDEI_1_1_FN_SDEI_EVENT_SIGNAL       (event injection)

   SDEI_1_0_FN_SDEI_EVENT_DISABLE      (disable event)
   SDEI_1_0_FN_SDEI_EVENT_UNREGISTER   (unregister event)
   SDEI_1_0_FN_SDEI_PE_MASK            (CPU offline)

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 tools/testing/selftests/kvm/Makefile       |   1 +
 tools/testing/selftests/kvm/aarch64/sdei.c | 525 +++++++++++++++++++++
 2 files changed, 526 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/aarch64/sdei.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 17c3f0749f05..4e4c03cc316b 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -105,6 +105,7 @@ TEST_GEN_PROGS_aarch64 += aarch64/get-reg-list
 TEST_GEN_PROGS_aarch64 += aarch64/psci_cpu_on_test
 TEST_GEN_PROGS_aarch64 += aarch64/vgic_init
 TEST_GEN_PROGS_aarch64 += aarch64/vgic_irq
+TEST_GEN_PROGS_aarch64 += aarch64/sdei
 TEST_GEN_PROGS_aarch64 += demand_paging_test
 TEST_GEN_PROGS_aarch64 += dirty_log_test
 TEST_GEN_PROGS_aarch64 += dirty_log_perf_test
diff --git a/tools/testing/selftests/kvm/aarch64/sdei.c b/tools/testing/selftests/kvm/aarch64/sdei.c
new file mode 100644
index 000000000000..2a7d816ce438
--- /dev/null
+++ b/tools/testing/selftests/kvm/aarch64/sdei.c
@@ -0,0 +1,525 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ARM SDEI test
+ *
+ * Copyright (C) 2022 Red Hat, Inc.
+ *
+ * Author(s): Gavin Shan <gshan@redhat.com>
+ */
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <string.h>
+#include <pthread.h>
+#include <linux/bitmap.h>
+
+#include "kvm_util.h"
+#include "processor.h"
+#include "linux/arm_sdei.h"
+#include "asm/kvm_sdei_state.h"
+
+#define NR_VCPUS	2
+#define SDEI_EVENT_NUM	KVM_SDEI_DEFAULT_EVENT
+
+#define VCPU_COMMAND_IDLE		0
+#define VCPU_COMMAND_EXIT		1
+
+struct vcpu_command {
+	const char	*name;
+	uint64_t	command;
+};
+
+struct sdei_feature {
+	uint16_t	shared_slots;
+	uint16_t	private_slots;
+	uint8_t		relative_mode;
+};
+
+struct sdei_event_info {
+	uint8_t		type;
+	uint8_t		priority;
+	uint8_t		signaled;
+};
+
+struct sdei_event_signal {
+	uint8_t		handled;
+	uint8_t		irq;
+	uint64_t	status;
+	uint64_t	pc;
+	uint64_t	pstate;
+	uint64_t	regs[18];
+};
+
+struct sdei_state {
+	uint64_t	command;
+	uint64_t	num;
+	uint64_t	status;
+	union {
+		uint64_t			version;
+		struct sdei_feature		feature;
+		struct sdei_event_info		info;
+		struct sdei_event_signal	signal;
+	};
+
+	uint8_t		command_completed;
+};
+
+struct vcpu_state {
+	struct kvm_vm		*vm;
+	uint32_t		vcpu_id;
+	pthread_t		thread;
+	struct sdei_state	state;
+};
+
+static struct vcpu_state vcpu_states[NR_VCPUS];
+static struct vcpu_command vcpu_commands[] = {
+	{ "VERSION",          SDEI_1_0_FN_SDEI_VERSION          },
+	{ "FEATURES",         SDEI_1_1_FN_SDEI_FEATURES         },
+	{ "PRIVATE_RESET",    SDEI_1_0_FN_SDEI_PRIVATE_RESET    },
+	{ "SHARED_RESET",     SDEI_1_0_FN_SDEI_SHARED_RESET     },
+	{ "PE_UNMASK",        SDEI_1_0_FN_SDEI_PE_UNMASK        },
+	{ "EVENT_GET_INFO",   SDEI_1_0_FN_SDEI_EVENT_GET_INFO   },
+	{ "EVENT_REGISTER",   SDEI_1_0_FN_SDEI_EVENT_REGISTER   },
+	{ "EVENT_ENABLE",     SDEI_1_0_FN_SDEI_EVENT_ENABLE     },
+	{ "EVENT_SIGNAL",     SDEI_1_1_FN_SDEI_EVENT_SIGNAL     },
+	{ "PE_MASK",          SDEI_1_0_FN_SDEI_PE_MASK          },
+	{ "EVENT_DISABLE",    SDEI_1_0_FN_SDEI_EVENT_DISABLE    },
+	{ "EVENT_UNREGISTER", SDEI_1_0_FN_SDEI_EVENT_UNREGISTER },
+};
+
+static inline int64_t smccc(uint32_t func, uint64_t arg0, uint64_t arg1,
+			    uint64_t arg2, uint64_t arg3, uint64_t arg4)
+{
+	int64_t ret;
+
+	asm volatile (
+		"mov    x0, %1\n"
+		"mov    x1, %2\n"
+		"mov    x2, %3\n"
+		"mov    x3, %4\n"
+		"mov    x4, %5\n"
+		"mov    x5, %6\n"
+		"hvc    #0\n"
+		"mov    %0, x0\n"
+	: "=r" (ret) : "r" (func), "r" (arg0), "r" (arg1),
+	"r" (arg2), "r" (arg3), "r" (arg4) :
+	"x0", "x1", "x2", "x3", "x4", "x5");
+
+	return ret;
+}
+
+static inline bool is_error(int64_t status)
+{
+	if (status == SDEI_NOT_SUPPORTED      ||
+	    status == SDEI_INVALID_PARAMETERS ||
+	    status == SDEI_DENIED             ||
+	    status == SDEI_PENDING            ||
+	    status == SDEI_OUT_OF_RESOURCE)
+		return true;
+
+	return false;
+}
+
+static void guest_irq_handler(struct ex_regs *regs)
+{
+	int vcpu_id = guest_get_vcpuid();
+	struct sdei_state *state = &vcpu_states[vcpu_id].state;
+
+	WRITE_ONCE(state->signal.irq, true);
+}
+
+static void sdei_event_handler(uint64_t num, uint64_t arg,
+			       uint64_t pc, uint64_t pstate)
+{
+	struct sdei_state *state = (struct sdei_state *)arg;
+	uint64_t status;
+
+	status = smccc(SDEI_1_0_FN_SDEI_EVENT_STATUS, num, 0, 0, 0, 0);
+	WRITE_ONCE(state->signal.status, status);
+
+	WRITE_ONCE(state->signal.pc, pc);
+	WRITE_ONCE(state->signal.pstate, pstate);
+
+	status = smccc(SDEI_1_0_FN_SDEI_EVENT_CONTEXT, 0, 0, 0, 0, 0);
+	WRITE_ONCE(state->signal.regs[0], status);
+	status = smccc(SDEI_1_0_FN_SDEI_EVENT_CONTEXT, 1, 0, 0, 0, 0);
+	WRITE_ONCE(state->signal.regs[1], status);
+	status = smccc(SDEI_1_0_FN_SDEI_EVENT_CONTEXT, 2, 0, 0, 0, 0);
+	WRITE_ONCE(state->signal.regs[2], status);
+	status = smccc(SDEI_1_0_FN_SDEI_EVENT_CONTEXT, 3, 0, 0, 0, 0);
+	WRITE_ONCE(state->signal.regs[3], status);
+
+	WRITE_ONCE(state->signal.handled, true);
+	smccc(SDEI_1_0_FN_SDEI_EVENT_COMPLETE_AND_RESUME,
+	      num, 0, 0, 0, 0);
+}
+
+static bool sdei_event_wait(struct sdei_state *state,
+			    uint64_t timeout_in_seconds)
+{
+	uint64_t limit, count = 0;
+
+	limit = (timeout_in_seconds * 1000000) / 10;
+
+	while (1) {
+		if (READ_ONCE(state->signal.handled))
+			return true;
+
+		if (++count >= limit)
+			return false;
+
+		/*
+		 * We issues HVC calls here to ensure the injected
+		 * event can be delivered in time.
+		 */
+		smccc(SDEI_1_0_FN_SDEI_EVENT_GET_INFO,
+		      READ_ONCE(state->num), SDEI_EVENT_INFO_EV_TYPE,
+		      0, 0, 0);
+
+		usleep(10);
+	}
+
+	return false;
+}
+
+static void guest_code(int vcpu_id)
+{
+	struct sdei_state *state;
+	uint64_t command, last_command = -1UL, num, status;
+
+	state = &vcpu_states[vcpu_id].state;
+
+	while (1) {
+		command = READ_ONCE(state->command);
+		if (command == last_command)
+			continue;
+
+		num = READ_ONCE(state->num);
+		switch (command) {
+		case VCPU_COMMAND_IDLE:
+			WRITE_ONCE(state->status, SDEI_SUCCESS);
+			break;
+		case SDEI_1_0_FN_SDEI_VERSION:
+			status = smccc(command, 0, 0, 0, 0, 0);
+			WRITE_ONCE(state->status, status);
+			if (is_error(status))
+				break;
+
+			WRITE_ONCE(state->version, status);
+			break;
+		case SDEI_1_0_FN_SDEI_PRIVATE_RESET:
+		case SDEI_1_0_FN_SDEI_SHARED_RESET:
+		case SDEI_1_0_FN_SDEI_PE_UNMASK:
+		case SDEI_1_0_FN_SDEI_PE_MASK:
+			status = smccc(command, 0, 0, 0, 0, 0);
+			WRITE_ONCE(state->status, status);
+			break;
+		case SDEI_1_1_FN_SDEI_FEATURES:
+			status = smccc(command, 0, 0, 0, 0, 0);
+			WRITE_ONCE(state->status, status);
+			if (is_error(status))
+				break;
+
+			WRITE_ONCE(state->feature.shared_slots,
+				   (status & 0xffff0000) >> 16);
+			WRITE_ONCE(state->feature.private_slots,
+				   (status & 0x0000ffff));
+			status = smccc(command, 1, 0, 0, 0, 0);
+			WRITE_ONCE(state->status, status);
+			if (is_error(status))
+				break;
+
+			WRITE_ONCE(state->feature.relative_mode, status);
+			break;
+		case SDEI_1_0_FN_SDEI_EVENT_GET_INFO:
+			status = smccc(command, num,
+				       SDEI_EVENT_INFO_EV_TYPE, 0, 0, 0);
+			WRITE_ONCE(state->status, status);
+			if (is_error(status))
+				break;
+
+			WRITE_ONCE(state->info.type, status);
+			status = smccc(command, num,
+				       SDEI_EVENT_INFO_EV_PRIORITY, 0, 0, 0);
+			WRITE_ONCE(state->status, status);
+			if (is_error(status))
+				break;
+
+			WRITE_ONCE(state->info.priority, status);
+			status = smccc(command, num,
+				       SDEI_EVENT_INFO_EV_SIGNALED, 0, 0, 0);
+			if (is_error(status))
+				break;
+
+			WRITE_ONCE(state->info.signaled, status);
+			break;
+		case SDEI_1_0_FN_SDEI_EVENT_REGISTER:
+			status = smccc(command, num,
+				       (uint64_t)sdei_event_handler,
+				       (uint64_t)state,
+				       SDEI_EVENT_REGISTER_RM_ANY, 0);
+			WRITE_ONCE(state->status, status);
+			break;
+		case SDEI_1_0_FN_SDEI_EVENT_ENABLE:
+		case SDEI_1_0_FN_SDEI_EVENT_DISABLE:
+		case SDEI_1_0_FN_SDEI_EVENT_UNREGISTER:
+			status = smccc(command, num, 0, 0, 0, 0);
+			WRITE_ONCE(state->status, status);
+			break;
+		case SDEI_1_1_FN_SDEI_EVENT_SIGNAL:
+			status = smccc(command, num, (uint64_t)state, 0, 0, 0);
+			WRITE_ONCE(state->status, status);
+			if (is_error(status))
+				break;
+
+			if (!sdei_event_wait(state, 5))
+				WRITE_ONCE(state->status, SDEI_DENIED);
+
+			break;
+		case VCPU_COMMAND_EXIT:
+			WRITE_ONCE(state->status, SDEI_SUCCESS);
+			GUEST_DONE();
+			break;
+		default:
+			WRITE_ONCE(state->status, SDEI_INVALID_PARAMETERS);
+		}
+
+		last_command = command;
+		WRITE_ONCE(state->command_completed, true);
+	}
+}
+
+static void *vcpu_thread(void *arg)
+{
+	struct vcpu_state *state = arg;
+
+	vcpu_run(state->vm, state->vcpu_id);
+
+	return NULL;
+}
+
+static bool vcpu_wait(struct kvm_vm *vm, int timeout_in_seconds)
+{
+	unsigned long count, limit;
+	int i;
+
+	count = 0;
+	limit = (timeout_in_seconds * 1000000) / 50;
+	while (1) {
+		for (i = 0; i < NR_VCPUS; i++) {
+			sync_global_from_guest(vm, vcpu_states[i].state);
+			if (!vcpu_states[i].state.command_completed)
+				break;
+		}
+
+		if (i >= NR_VCPUS)
+			return true;
+
+		if (++count > limit)
+			return false;
+
+		usleep(50);
+	}
+
+	return false;
+}
+
+static void vcpu_send_command(struct kvm_vm *vm, uint64_t command)
+{
+	int i;
+
+	for (i = 0; i < NR_VCPUS; i++) {
+		memset(&vcpu_states[i].state, 0,
+		       sizeof(vcpu_states[0].state));
+		vcpu_states[i].state.num = SDEI_EVENT_NUM;
+		vcpu_states[i].state.status = SDEI_SUCCESS;
+		vcpu_states[i].state.command = command;
+		vcpu_states[i].state.command_completed = false;
+
+		sync_global_to_guest(vm, vcpu_states[i].state);
+	}
+}
+
+static bool vcpu_check_state(struct kvm_vm *vm)
+{
+	int i, j, ret;
+
+	for (i = 0; i < NR_VCPUS; i++)
+		sync_global_from_guest(vm, vcpu_states[i].state);
+
+	for (i = 0; i < NR_VCPUS; i++) {
+		if (is_error(vcpu_states[i].state.status))
+			return false;
+
+		for (j = 0; j < NR_VCPUS; j++) {
+			ret = memcmp(&vcpu_states[i].state,
+				     &vcpu_states[j].state,
+				     sizeof(vcpu_states[0].state));
+			if (ret)
+				return false;
+		}
+	}
+
+	return true;
+}
+
+static void vcpu_dump_state(int index)
+{
+	struct sdei_state *state = &vcpu_states[0].state;
+
+	pr_info("--- %s\n", vcpu_commands[index].name);
+	switch (state->command) {
+	case SDEI_1_0_FN_SDEI_VERSION:
+		pr_info("    Version:              %ld.%ld (vendor: 0x%lx)\n",
+			SDEI_VERSION_MAJOR(state->version),
+			SDEI_VERSION_MINOR(state->version),
+			SDEI_VERSION_VENDOR(state->version));
+		break;
+	case SDEI_1_1_FN_SDEI_FEATURES:
+		pr_info("    Shared event slots:   %d\n",
+			state->feature.shared_slots);
+		pr_info("    Private event slots:  %d\n",
+			state->feature.private_slots);
+		pr_info("    Relative mode:        %s\n",
+			state->feature.relative_mode ? "Yes" : "No");
+			break;
+	case SDEI_1_0_FN_SDEI_EVENT_GET_INFO:
+		pr_info("    Type:                 %s\n",
+			state->info.type == SDEI_EVENT_TYPE_SHARED ?
+			"Shared" : "Private");
+		pr_info("    Priority:             %s\n",
+			state->info.priority == SDEI_EVENT_PRIORITY_NORMAL ?
+			"Normal" : "Critical");
+		pr_info("    Signaled:             %s\n",
+			state->info.signaled ? "Yes" : "No");
+		break;
+	case SDEI_1_1_FN_SDEI_EVENT_SIGNAL:
+		pr_info("    Handled:              %s\n",
+			state->signal.handled ? "Yes" : "No");
+		pr_info("    IRQ:                  %s\n",
+			state->signal.irq ? "Yes" : "No");
+		pr_info("    Status:               %s-%s-%s\n",
+			state->signal.status & (1 << SDEI_EVENT_STATUS_REGISTERED) ?
+			"Registered" : "x",
+			state->signal.status & (1 << SDEI_EVENT_STATUS_ENABLED) ?
+			"Enabled" : "x",
+			state->signal.status & (1 << SDEI_EVENT_STATUS_RUNNING) ?
+			"Running" : "x");
+		pr_info("    PC/PSTATE:            %016lx %016lx\n",
+			state->signal.pc, state->signal.pstate);
+		pr_info("    Regs:                 %016lx %016lx %016lx %016lx\n",
+			state->signal.regs[0], state->signal.regs[1],
+			state->signal.regs[2], state->signal.regs[3]);
+		break;
+	}
+
+	if (index == ARRAY_SIZE(vcpu_commands))
+		pr_info("\n");
+}
+
+int main(int argc, char **argv)
+{
+	struct kvm_vm *vm;
+	struct kvm_sdei_cmd cmd;
+	struct kvm_sdei_exposed_event_state exposed_event;
+	uint32_t vcpu_ids[NR_VCPUS];
+	int i, ret;
+
+	if (!kvm_check_cap(KVM_CAP_ARM_SDEI)) {
+		pr_info("SDEI not supported\n");
+		return 0;
+	}
+
+	/* Create VM */
+	for (i = 0; i < NR_VCPUS; i++) {
+		vcpu_states[i].vcpu_id = i;
+		vcpu_ids[i] = i;
+	}
+
+	vm = vm_create_default_with_vcpus(NR_VCPUS, 0, 0,
+					  guest_code, vcpu_ids);
+	vm_init_descriptor_tables(vm);
+	vm_install_exception_handler(vm, VECTOR_IRQ_CURRENT,
+				     guest_irq_handler);
+
+	ucall_init(vm, NULL);
+
+	/* Ensure the version is v1.0.0 */
+	cmd.cmd = KVM_SDEI_CMD_GET_VERSION;
+	cmd.version = 0;
+	vm_ioctl(vm, KVM_ARM_SDEI_COMMAND, &cmd);
+	if (cmd.version != 0x10000) {
+		pr_info("v%d.%d.%d doesn't match with v1.0.0\n",
+			(cmd.version & 0xFF0000) >> 16,
+			(cmd.version & 0xFF00) >> 8,
+			(cmd.version & 0xFF));
+		return 0;
+	}
+
+	/* Expose the default SDEI event */
+	exposed_event.num = SDEI_EVENT_NUM;
+	exposed_event.type = SDEI_EVENT_TYPE_PRIVATE;
+	exposed_event.priority = SDEI_EVENT_PRIORITY_NORMAL;
+	exposed_event.signaled = 1;
+	exposed_event.notifier = 0;
+	cmd.cmd = KVM_SDEI_CMD_SET_EXPOSED_EVENT;
+	cmd.count = 1;
+	cmd.exposed_event_state = &exposed_event;
+	vm_ioctl(vm, KVM_ARM_SDEI_COMMAND, &cmd);
+
+	/* Start the vCPUs */
+	vcpu_send_command(vm, VCPU_COMMAND_IDLE);
+	for (i = 0; i < NR_VCPUS; i++) {
+		vcpu_states[i].vm = vm;
+		vcpu_args_set(vm, i, 1, i);
+		vcpu_init_descriptor_tables(vm, i);
+
+		ret = pthread_create(&vcpu_states[i].thread, NULL,
+				     vcpu_thread, &vcpu_states[i]);
+		TEST_ASSERT(!ret, "Failed to create vCPU-%d pthread\n", i);
+	}
+
+	/* Wait the idle command to complete */
+	ret = vcpu_wait(vm, 5);
+	TEST_ASSERT(ret, "Timeout to execute IDLE command\n");
+
+	/* Start the tests */
+	pr_info("\n");
+	pr_info("    NR_VCPUS: %d    SDEI Event: 0x%08x\n\n",
+		NR_VCPUS, SDEI_EVENT_NUM);
+	for (i = 0; i < ARRAY_SIZE(vcpu_commands); i++) {
+		/*
+		 * We depends on SDEI_1_1_FN_SDEI_EVENT_SIGNAL hypercall
+		 * to inject SDEI event. The number of the injected event
+		 * must be zero. So we have to skip the corresponding test
+		 * if the SDEI event number isn't zero.
+		 */
+		if (SDEI_EVENT_NUM != 0x0 &&
+		    vcpu_commands[i].command == SDEI_1_1_FN_SDEI_EVENT_SIGNAL)
+			continue;
+
+		vcpu_send_command(vm, vcpu_commands[i].command);
+		ret = vcpu_wait(vm, 5);
+		if (!ret) {
+			pr_info("%s: Timeout\n", vcpu_commands[i].name);
+			return -1;
+		}
+
+		ret = vcpu_check_state(vm);
+		if (!ret) {
+			pr_info("%s: Fail\n", vcpu_commands[i].name);
+			return -1;
+		}
+
+		vcpu_dump_state(i);
+	}
+
+	/* Terminate the guests */
+	pr_info("\n    Result: OK\n\n");
+	vcpu_send_command(vm, VCPU_COMMAND_EXIT);
+	sleep(1);
+
+	return 0;
+}
-- 
2.23.0


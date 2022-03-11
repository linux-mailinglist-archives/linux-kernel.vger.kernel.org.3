Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A14A4D5B14
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347725AbiCKF73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 00:59:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346624AbiCKFyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:54:09 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524CF9F3B2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:53:04 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id b4-20020a170902e94400b0015309b5c481so3402183pll.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=sHmUP9wjFdrYC4PoZij4qatGMxKFSxmAp5vE/0mTYTw=;
        b=TiX/cIfh64JVKqwYUu7dwo0+Q8vjwPafUxY0/uKUXOrhPEHs9dfDRYhDQCh7OTarh3
         ndpsKk4N3CU6lrFj+rSDfMqRACGDmcZ94WP/Q2Fk7psSBkf075qIAeItsKof2ds8hRq4
         tPnJOvHnesnjOHT7R5HXRSrgszp31LCYkigsktb03nXpkH6NTVBkeh0uKl7QH0A6aE9h
         5N2cowPfc/e16uvzA5nAugVCJr04Lw/cTcusu02TtIciXVygoS/J79v7/LczCC6yyctZ
         0u5ql3jtX/5qVZnlhKTf82CGy7EyqdkN/Af190jdrHM7AOVBHTd7MnEmihWjx9nCncp7
         iViw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=sHmUP9wjFdrYC4PoZij4qatGMxKFSxmAp5vE/0mTYTw=;
        b=JpQtBHXaTpsocOUCCGsNvB3OtyQxHjjKOoUYdQ09FYOQoj4vBYv1vJbFU+rdSqu+aO
         pUWpVVhrh8jZlfDK/5Z1p6VxUa0YtlhBggJYGas7iWRsytuI49/frQfeDIN2LvRaWM7v
         V1hkXnHU+V/x/WZ3klU5PHJBcoDqZtj1EknL2Vq5P9u8aBsml8vwqYzrLm+r9eUeQOrw
         XbG8Ow4a7DgvnGHk9HmEx9frdb2Bql4xyci9myhLw2Tx/py7kT8UhiJQYau0nl4mKnkZ
         EmxaU0xtZ+fnaQXYWMJPfKzlUzumCWq68iLvOv72AtgXucAJGba4WdB//3d8jHf2+ZE3
         Vomw==
X-Gm-Message-State: AOAM530+RAlJWuzYnTlm5/vDbo/c++6KhOrQT0LuZB2KX/mAiMGvqXJP
        yeajpjzj8jU4rsQmZnUF/FEEIe5CIFjJEqBv9ai2wCau6pTdQotTyXoGQGETpTgEuvUF99o7JLT
        CtmQ7Vl/Kq3hZGPYE+IBlZSkZi0tgyrka0P0gJfYS76xz+HLlEKTZBrpmW4tIdrZplw251w==
X-Google-Smtp-Source: ABdhPJzYURgC+6bd2Ckmcvbvfwh6efbnJt01C1icEtAo8Sjzs1KPqSohyr7BSjMNXbPxL9STmfrSBp11L6c=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:902:f789:b0:14e:ebbc:264b with SMTP id
 q9-20020a170902f78900b0014eebbc264bmr8517746pln.169.1646977984320; Thu, 10
 Mar 2022 21:53:04 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:50:21 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-71-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 070/105] KVM: selftests: Convert xen_shinfo_test away from VCPU_ID
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
 .../selftests/kvm/x86_64/xen_shinfo_test.c    | 35 +++++++++----------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c b/tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c
index 865e17146815..228b61630c0f 100644
--- a/tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c
+++ b/tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c
@@ -18,8 +18,6 @@
 
 #include <sys/eventfd.h>
 
-#define VCPU_ID		5
-
 #define SHINFO_REGION_GVA	0xc0000000ULL
 #define SHINFO_REGION_GPA	0xc0000000ULL
 #define SHINFO_REGION_SLOT	10
@@ -39,8 +37,6 @@
 
 #define EVTCHN_VECTOR	0x10
 
-static struct kvm_vm *vm;
-
 #define XEN_HYPERCALL_MSR	0x40000000
 
 #define MIN_STEAL_TIME		50000
@@ -200,6 +196,8 @@ static void handle_alrm(int sig)
 int main(int argc, char *argv[])
 {
 	struct timespec min_ts, max_ts, vm_ts;
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
 	bool verbose;
 
 	verbose = argc > 1 && (!strncmp(argv[1], "-v", 3) ||
@@ -216,8 +214,7 @@ int main(int argc, char *argv[])
 
 	clock_gettime(CLOCK_REALTIME, &min_ts);
 
-	vm = vm_create_default(VCPU_ID, 0, (void *) guest_code);
-	vcpu_set_cpuid(vm, VCPU_ID, kvm_get_supported_cpuid());
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
 
 	/* Map a region for the shared_info page */
 	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS,
@@ -261,13 +258,13 @@ int main(int argc, char *argv[])
 		.type = KVM_XEN_VCPU_ATTR_TYPE_VCPU_INFO,
 		.u.gpa = VCPU_INFO_ADDR,
 	};
-	vcpu_ioctl(vm, VCPU_ID, KVM_XEN_VCPU_SET_ATTR, &vi);
+	vcpu_ioctl(vm, vcpu->id, KVM_XEN_VCPU_SET_ATTR, &vi);
 
 	struct kvm_xen_vcpu_attr pvclock = {
 		.type = KVM_XEN_VCPU_ATTR_TYPE_VCPU_TIME_INFO,
 		.u.gpa = PVTIME_ADDR,
 	};
-	vcpu_ioctl(vm, VCPU_ID, KVM_XEN_VCPU_SET_ATTR, &pvclock);
+	vcpu_ioctl(vm, vcpu->id, KVM_XEN_VCPU_SET_ATTR, &pvclock);
 
 	struct kvm_xen_hvm_attr vec = {
 		.type = KVM_XEN_ATTR_TYPE_UPCALL_VECTOR,
@@ -276,7 +273,7 @@ int main(int argc, char *argv[])
 	vm_ioctl(vm, KVM_XEN_HVM_SET_ATTR, &vec);
 
 	vm_init_descriptor_tables(vm);
-	vcpu_init_descriptor_tables(vm, VCPU_ID);
+	vcpu_init_descriptor_tables(vm, vcpu->id);
 	vm_install_exception_handler(vm, EVTCHN_VECTOR, evtchn_handler);
 
 	if (do_runstate_tests) {
@@ -284,7 +281,7 @@ int main(int argc, char *argv[])
 			.type = KVM_XEN_VCPU_ATTR_TYPE_RUNSTATE_ADDR,
 			.u.gpa = RUNSTATE_ADDR,
 		};
-		vcpu_ioctl(vm, VCPU_ID, KVM_XEN_VCPU_SET_ATTR, &st);
+		vcpu_ioctl(vm, vcpu->id, KVM_XEN_VCPU_SET_ATTR, &st);
 	}
 
 	int irq_fd[2] = { -1, -1 };
@@ -304,13 +301,13 @@ int main(int argc, char *argv[])
 		irq_routes.entries[0].gsi = 32;
 		irq_routes.entries[0].type = KVM_IRQ_ROUTING_XEN_EVTCHN;
 		irq_routes.entries[0].u.xen_evtchn.port = 15;
-		irq_routes.entries[0].u.xen_evtchn.vcpu = VCPU_ID;
+		irq_routes.entries[0].u.xen_evtchn.vcpu = vcpu->id;
 		irq_routes.entries[0].u.xen_evtchn.priority = KVM_IRQ_ROUTING_XEN_EVTCHN_PRIO_2LEVEL;
 
 		irq_routes.entries[1].gsi = 33;
 		irq_routes.entries[1].type = KVM_IRQ_ROUTING_XEN_EVTCHN;
 		irq_routes.entries[1].u.xen_evtchn.port = 66;
-		irq_routes.entries[1].u.xen_evtchn.vcpu = VCPU_ID;
+		irq_routes.entries[1].u.xen_evtchn.vcpu = vcpu->id;
 		irq_routes.entries[1].u.xen_evtchn.priority = KVM_IRQ_ROUTING_XEN_EVTCHN_PRIO_2LEVEL;
 
 		vm_ioctl(vm, KVM_SET_GSI_ROUTING, &irq_routes);
@@ -339,17 +336,17 @@ int main(int argc, char *argv[])
 	bool evtchn_irq_expected = false;
 
 	for (;;) {
-		volatile struct kvm_run *run = vcpu_state(vm, VCPU_ID);
+		volatile struct kvm_run *run = vcpu->run;
 		struct ucall uc;
 
-		vcpu_run(vm, VCPU_ID);
+		vcpu_run(vm, vcpu->id);
 
 		TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
 			    "Got exit_reason other than KVM_EXIT_IO: %u (%s)\n",
 			    run->exit_reason,
 			    exit_reason_str(run->exit_reason));
 
-		switch (get_ucall(vm, VCPU_ID, &uc)) {
+		switch (get_ucall(vm, vcpu->id, &uc)) {
 		case UCALL_ABORT:
 			TEST_FAIL("%s", (const char *)uc.args[0]);
 			/* NOT REACHED */
@@ -378,7 +375,7 @@ int main(int argc, char *argv[])
 					printf("Testing runstate %s\n", runstate_names[uc.args[1]]);
 				rst.type = KVM_XEN_VCPU_ATTR_TYPE_RUNSTATE_CURRENT;
 				rst.u.runstate.state = uc.args[1];
-				vcpu_ioctl(vm, VCPU_ID, KVM_XEN_VCPU_SET_ATTR, &rst);
+				vcpu_ioctl(vm, vcpu->id, KVM_XEN_VCPU_SET_ATTR, &rst);
 				break;
 
 			case 4:
@@ -393,7 +390,7 @@ int main(int argc, char *argv[])
 					0x6b6b - rs->time[RUNSTATE_offline];
 				rst.u.runstate.time_runnable = -rst.u.runstate.time_blocked -
 					rst.u.runstate.time_offline;
-				vcpu_ioctl(vm, VCPU_ID, KVM_XEN_VCPU_SET_ATTR, &rst);
+				vcpu_ioctl(vm, vcpu->id, KVM_XEN_VCPU_SET_ATTR, &rst);
 				break;
 
 			case 5:
@@ -405,7 +402,7 @@ int main(int argc, char *argv[])
 				rst.u.runstate.state_entry_time = 0x6b6b + 0x5a;
 				rst.u.runstate.time_blocked = 0x6b6b;
 				rst.u.runstate.time_offline = 0x5a;
-				vcpu_ioctl(vm, VCPU_ID, KVM_XEN_VCPU_SET_ATTR, &rst);
+				vcpu_ioctl(vm, vcpu->id, KVM_XEN_VCPU_SET_ATTR, &rst);
 				break;
 
 			case 6:
@@ -512,7 +509,7 @@ int main(int argc, char *argv[])
 		struct kvm_xen_vcpu_attr rst = {
 			.type = KVM_XEN_VCPU_ATTR_TYPE_RUNSTATE_DATA,
 		};
-		vcpu_ioctl(vm, VCPU_ID, KVM_XEN_VCPU_GET_ATTR, &rst);
+		vcpu_ioctl(vm, vcpu->id, KVM_XEN_VCPU_GET_ATTR, &rst);
 
 		if (verbose) {
 			printf("Runstate: %s(%d), entry %" PRIu64 " ns\n",
-- 
2.35.1.723.g4982287a31-goog


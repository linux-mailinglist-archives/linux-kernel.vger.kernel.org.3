Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABDF4D5B1E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347880AbiCKGAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 01:00:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346720AbiCKFyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:54:20 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6BBF1AD3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:53:13 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id t184-20020a6281c1000000b004e103c5f726so4614943pfd.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=ASMbPf1pAfd0lY/Kp4YmL7EogyqKjavAbHGYSHJu3g0=;
        b=tDFbJWVphzc2HUPXOZhKG9oM6SVIcjBOfkDj/X0PNvcfaTTW9mMaY5I+q4mOFipEkM
         0IED3CLLyYpfg4icpffFsjeR/Y2ztv0zpjiBXm3vN3Ota+MaIvwsLVOJMBi8lRTKCXEG
         z7GEQY0h2wpeyDrbs7LW9mkxHq2Y7KJvczFKF2NR5VF6vUeLBfx8oPzxER0isxfJ9sAK
         bEkt7NQ8Iydd0HYjNFWr6NGTYF5gMhaCEmoZ/vt40OzUVt6ReAOWjCLyxg4aTG+4lXQo
         TguQEJZhx2tOsx7+cy0i+7Na99c7ymYvhIwY5PZr6RpQb7kgmLL42y949rRURByx2Vm0
         0zZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=ASMbPf1pAfd0lY/Kp4YmL7EogyqKjavAbHGYSHJu3g0=;
        b=zHehxZgAz1e61ZLwAkiUncZHq2phWE3G9AeeTo9KtUsyHSW9idipsqXLu72loDq4cG
         Mfl7DXC9EI8ipxLlnkDqz3AKeFk4RyIzk/rH2UyPcoyYR8jZ+8Eb15O2YWztx1pw/7vK
         f0YTGwHtNuI+fy7Y5wBeSg1/7uy/Y0+GuL12WRnaszlxXH8GElsafn6/SNLg+yeJi1x7
         7/7vKwSCQ+khVY4WG0Z3e9+jlq/JBnJgGWek/i7ufmG+sf1LF5aMWxvo8oZWNkY/LgI6
         W1znqTsp/gwjdJRBHPUOoOHz4RGSiFkw3vhYr1YnXGxMzumY5HR0VCb2p9O6OQk3AAC3
         swoQ==
X-Gm-Message-State: AOAM532x239l+6OcWJXhw3Ey0CasN9pGsxKTjhRKEK3KL1Z36m0pwGVD
        5jde/2Q3CYBkleaaGJ0Aicm8gvP+ylZnbS+vyafUamjXAK72+eoHJeaQ3tnx5al6JLZG7cQEtiy
        lHD4Q2URhRIPoU9u6FK4KmCkjnhS7w9c84iF3iXl58os4GvFdpm0AIwJaEKgYiZcNzQK8MA==
X-Google-Smtp-Source: ABdhPJxCKn8TnczvY8kx1zKXaq7SEtGa16zqKAz+NPIluavhLfCA9OtHWXPblJuwSX+NADWJ9qobZ1C1CAg=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90b:1e10:b0:1bf:6c78:54a9 with SMTP id
 pg16-20020a17090b1e1000b001bf6c7854a9mr461041pjb.1.1646977992898; Thu, 10 Mar
 2022 21:53:12 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:50:26 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-76-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 075/105] KVM: selftests: Convert vgic_irq.c
 include/aarch64/vgic.h lib/aarch64/vgic away from VCPU_ID
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
 .../testing/selftests/kvm/aarch64/vgic_irq.c  | 30 ++++++++++---------
 .../selftests/kvm/include/aarch64/vgic.h      |  6 ++--
 .../testing/selftests/kvm/lib/aarch64/vgic.c  | 10 +++----
 3 files changed, 25 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/kvm/aarch64/vgic_irq.c b/tools/testing/selftests/kvm/aarch64/vgic_irq.c
index e6c7d7f8fbd1..75c2c2d28801 100644
--- a/tools/testing/selftests/kvm/aarch64/vgic_irq.c
+++ b/tools/testing/selftests/kvm/aarch64/vgic_irq.c
@@ -22,7 +22,6 @@
 
 #define GICD_BASE_GPA		0x08000000ULL
 #define GICR_BASE_GPA		0x080A0000ULL
-#define VCPU_ID			0
 
 /*
  * Stores the user specified args; it's passed to the guest and to every test
@@ -586,7 +585,8 @@ static void kvm_set_gsi_routing_irqchip_check(struct kvm_vm *vm,
 }
 
 static void kvm_irq_write_ispendr_check(int gic_fd, uint32_t intid,
-			uint32_t vcpu, bool expect_failure)
+					struct kvm_vcpu *vcpu,
+					bool expect_failure)
 {
 	/*
 	 * Ignore this when expecting failure as invalid intids will lead to
@@ -657,15 +657,16 @@ static void kvm_routing_and_irqfd_check(struct kvm_vm *vm,
 		(tmp) < (uint64_t)(first) + (uint64_t)(num);			\
 		(tmp)++, (i)++)
 
-static void run_guest_cmd(struct kvm_vm *vm, int gic_fd,
-		struct kvm_inject_args *inject_args,
-		struct test_args *test_args)
+static void run_guest_cmd(struct kvm_vcpu *vcpu, int gic_fd,
+			  struct kvm_inject_args *inject_args,
+			  struct test_args *test_args)
 {
 	kvm_inject_cmd cmd = inject_args->cmd;
 	uint32_t intid = inject_args->first_intid;
 	uint32_t num = inject_args->num;
 	int level = inject_args->level;
 	bool expect_failure = inject_args->expect_failure;
+	struct kvm_vm *vm = vcpu->vm;
 	uint64_t tmp;
 	uint32_t i;
 
@@ -703,12 +704,12 @@ static void run_guest_cmd(struct kvm_vm *vm, int gic_fd,
 		break;
 	case KVM_WRITE_ISPENDR:
 		for (i = intid; i < intid + num; i++)
-			kvm_irq_write_ispendr_check(gic_fd, i,
-					VCPU_ID, expect_failure);
+			kvm_irq_write_ispendr_check(gic_fd, i, vcpu,
+						    expect_failure);
 		break;
 	case KVM_WRITE_ISACTIVER:
 		for (i = intid; i < intid + num; i++)
-			kvm_irq_write_isactiver(gic_fd, i, VCPU_ID);
+			kvm_irq_write_isactiver(gic_fd, i, vcpu);
 		break;
 	default:
 		break;
@@ -737,6 +738,7 @@ static void test_vgic(uint32_t nr_irqs, bool level_sensitive, bool eoi_split)
 {
 	struct ucall uc;
 	int gic_fd;
+	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
 	struct kvm_inject_args inject_args;
 
@@ -750,14 +752,14 @@ static void test_vgic(uint32_t nr_irqs, bool level_sensitive, bool eoi_split)
 
 	print_args(&args);
 
-	vm = vm_create_default(VCPU_ID, 0, guest_code);
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
 	ucall_init(vm, NULL);
 
 	vm_init_descriptor_tables(vm);
-	vcpu_init_descriptor_tables(vm, VCPU_ID);
+	vcpu_init_descriptor_tables(vm, vcpu->id);
 
 	/* Setup the guest args page (so it gets the args). */
-	vcpu_args_set(vm, 0, 1, args);
+	vcpu_args_set(vm, vcpu->id, 1, args);
 
 	gic_fd = vgic_v3_setup(vm, 1, nr_irqs,
 			GICD_BASE_GPA, GICR_BASE_GPA);
@@ -766,12 +768,12 @@ static void test_vgic(uint32_t nr_irqs, bool level_sensitive, bool eoi_split)
 		guest_irq_handlers[args.eoi_split][args.level_sensitive]);
 
 	while (1) {
-		vcpu_run(vm, VCPU_ID);
+		vcpu_run(vm, vcpu->id);
 
-		switch (get_ucall(vm, VCPU_ID, &uc)) {
+		switch (get_ucall(vm, vcpu->id, &uc)) {
 		case UCALL_SYNC:
 			kvm_inject_get_call(vm, &uc, &inject_args);
-			run_guest_cmd(vm, gic_fd, &inject_args, &args);
+			run_guest_cmd(vcpu, gic_fd, &inject_args, &args);
 			break;
 		case UCALL_ABORT:
 			TEST_FAIL("%s at %s:%ld\n\tvalues: %#lx, %#lx",
diff --git a/tools/testing/selftests/kvm/include/aarch64/vgic.h b/tools/testing/selftests/kvm/include/aarch64/vgic.h
index 4442081221a0..0ac6f05c63f9 100644
--- a/tools/testing/selftests/kvm/include/aarch64/vgic.h
+++ b/tools/testing/selftests/kvm/include/aarch64/vgic.h
@@ -8,6 +8,8 @@
 
 #include <linux/kvm.h>
 
+#include "kvm_util.h"
+
 #define REDIST_REGION_ATTR_ADDR(count, base, flags, index) \
 	(((uint64_t)(count) << 52) | \
 	((uint64_t)((base) >> 16) << 16) | \
@@ -26,8 +28,8 @@ void kvm_arm_irq_line(struct kvm_vm *vm, uint32_t intid, int level);
 int _kvm_arm_irq_line(struct kvm_vm *vm, uint32_t intid, int level);
 
 /* The vcpu arg only applies to private interrupts. */
-void kvm_irq_write_ispendr(int gic_fd, uint32_t intid, uint32_t vcpu);
-void kvm_irq_write_isactiver(int gic_fd, uint32_t intid, uint32_t vcpu);
+void kvm_irq_write_ispendr(int gic_fd, uint32_t intid, struct kvm_vcpu *vcpu);
+void kvm_irq_write_isactiver(int gic_fd, uint32_t intid, struct kvm_vcpu *vcpu);
 
 #define KVM_IRQCHIP_NUM_PINS	(1020 - 32)
 
diff --git a/tools/testing/selftests/kvm/lib/aarch64/vgic.c b/tools/testing/selftests/kvm/lib/aarch64/vgic.c
index 25e765973f74..4a0ae7426498 100644
--- a/tools/testing/selftests/kvm/lib/aarch64/vgic.c
+++ b/tools/testing/selftests/kvm/lib/aarch64/vgic.c
@@ -127,8 +127,8 @@ void kvm_arm_irq_line(struct kvm_vm *vm, uint32_t intid, int level)
 			ret, errno);
 }
 
-static void vgic_poke_irq(int gic_fd, uint32_t intid,
-		uint32_t vcpu, uint64_t reg_off)
+static void vgic_poke_irq(int gic_fd, uint32_t intid, struct kvm_vcpu *vcpu,
+			  uint64_t reg_off)
 {
 	uint64_t reg = intid / 32;
 	uint64_t index = intid % 32;
@@ -144,7 +144,7 @@ static void vgic_poke_irq(int gic_fd, uint32_t intid,
 
 	if (intid_is_private) {
 		/* TODO: only vcpu 0 implemented for now. */
-		assert(vcpu == 0);
+		assert(vcpu->id == 0);
 		attr += SZ_64K;
 	}
 
@@ -158,12 +158,12 @@ static void vgic_poke_irq(int gic_fd, uint32_t intid,
 	kvm_device_attr_set(gic_fd, group, attr, &val);
 }
 
-void kvm_irq_write_ispendr(int gic_fd, uint32_t intid, uint32_t vcpu)
+void kvm_irq_write_ispendr(int gic_fd, uint32_t intid, struct kvm_vcpu *vcpu)
 {
 	vgic_poke_irq(gic_fd, intid, vcpu, GICD_ISPENDR);
 }
 
-void kvm_irq_write_isactiver(int gic_fd, uint32_t intid, uint32_t vcpu)
+void kvm_irq_write_isactiver(int gic_fd, uint32_t intid, struct kvm_vcpu *vcpu)
 {
 	vgic_poke_irq(gic_fd, intid, vcpu, GICD_ISACTIVER);
 }
-- 
2.35.1.723.g4982287a31-goog


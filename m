Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E37014D5B0D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347581AbiCKF6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 00:58:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346692AbiCKFx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:53:56 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3BA31220
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:52:51 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id u75-20020a63794e000000b003810e49ae0eso377234pgc.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=md9Z2HGwLpUJPLh7hrz8fCfKl27Eqrxt7Q5qmGcaeqM=;
        b=T7ysRkVQy8+4RfPFqNX9XQ2dnPsihGlYKnx4JPa1vkHeIo+fG6Z6wGXmkEIx8lJ/Yl
         /H0nSxJPWBTClEbPFergwARs+GhSwwstsyKg9ngoj54fGpJANyUHPO8vbSgqFYOoMS5F
         xAZKx1YwmtzijePIOVqThUlON3lqTOQmN2r07I2pxM5Fe8appemcOg2CPPu7vv+U1LxH
         sBkXCQJWB3Oo1NY29VsmwmoSxlrkKCiiMc5GUNjbyehi+Q/SuOukOryQTijThKITozZX
         9c7XRXGiWMPwmIKtmch6eTINlB9E6dHhsJXlOAQL9BVtgOVkC380UxC69iSrQ8sByjbG
         JOHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=md9Z2HGwLpUJPLh7hrz8fCfKl27Eqrxt7Q5qmGcaeqM=;
        b=JEgDXUU4dfdKSoeczhwyRRzTWcGUuwoUBa36bv58WJrBPeoRFopTP1PQ+DC0tbugAD
         NwdiMxvS2YQlrXV4HvyrJ602RTU2cex+g3ScpZ4V79QMh1xM2uiaRC2oOq78DiBEex3i
         KSPHap1DzY6FJlfMDxa+2qv0SFMAGDJq6V4Jc7AP1Oa6Wz37kYBVi5L/7cVUpo8edMX1
         VdCTiR3rPzogKMK+mlW9eHS3RhTA1iHui+n5s2HETUgjmF8RHFrgliRTl/1/woPCgYeh
         wAWXVSx+8uxjZaocsJWYEC8KOR/lnbVIsf5XBHf43r6/hjALnw9eXjNr/gMsTwMogeL1
         kIJw==
X-Gm-Message-State: AOAM530ltiEXlftGCCi1A5Kv1m4B6jckUdoYhoHxmeKQrM8P/3NdjsvF
        +e64uyEVG4yvWeugfmFkH0d2Ye/DSwYBTo3YfALxv3kn5DmqtG0cNQHv7E+ZaN1BGrAnJL+9My4
        IBQfjyJwoZiliyy+hSJigCpNltMGjE+kmEIum79xLpmEyNT4sfPB3gEZetGxoECJxlRb8mg==
X-Google-Smtp-Source: ABdhPJyTMACpTql+gyx/pp8gmjenG4VnKafSVZnGtaRAiOzo9dn+wxq9zpGZC1ygQO3wxaBghTBxJLFVQ0c=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:aa7:8b14:0:b0:4f7:83b1:2e0b with SMTP id
 f20-20020aa78b14000000b004f783b12e0bmr4702259pfd.37.1646977970456; Thu, 10
 Mar 2022 21:52:50 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:50:13 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-63-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 062/105] KVM: selftests: Convert debug_regs away from VCPU_ID
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
 .../testing/selftests/kvm/x86_64/debug_regs.c | 53 +++++++++----------
 1 file changed, 25 insertions(+), 28 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/debug_regs.c b/tools/testing/selftests/kvm/x86_64/debug_regs.c
index 5f078db1bcba..b999c9753fc3 100644
--- a/tools/testing/selftests/kvm/x86_64/debug_regs.c
+++ b/tools/testing/selftests/kvm/x86_64/debug_regs.c
@@ -10,8 +10,6 @@
 #include "processor.h"
 #include "apic.h"
 
-#define VCPU_ID 0
-
 #define DR6_BD		(1 << 13)
 #define DR7_GD		(1 << 13)
 
@@ -66,13 +64,11 @@ static void guest_code(void)
 	GUEST_DONE();
 }
 
-#define  CLEAR_DEBUG()  memset(&debug, 0, sizeof(debug))
-#define  APPLY_DEBUG()  vcpu_set_guest_debug(vm, VCPU_ID, &debug)
 #define  CAST_TO_RIP(v)  ((unsigned long long)&(v))
 #define  SET_RIP(v)  do {				\
-		vcpu_regs_get(vm, VCPU_ID, &regs);	\
+		vcpu_regs_get(vm, vcpu->id, &regs);	\
 		regs.rip = (v);				\
-		vcpu_regs_set(vm, VCPU_ID, &regs);	\
+		vcpu_regs_set(vm, vcpu->id, &regs);	\
 	} while (0)
 #define  MOVE_RIP(v)  SET_RIP(regs.rip + (v));
 
@@ -80,6 +76,7 @@ int main(void)
 {
 	struct kvm_guest_debug debug;
 	unsigned long long target_dr6, target_rip;
+	struct kvm_vcpu *vcpu;
 	struct kvm_regs regs;
 	struct kvm_run *run;
 	struct kvm_vm *vm;
@@ -101,14 +98,14 @@ int main(void)
 		return 0;
 	}
 
-	vm = vm_create_default(VCPU_ID, 0, guest_code);
-	run = vcpu_state(vm, VCPU_ID);
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+	run = vcpu->run;
 
 	/* Test software BPs - int3 */
-	CLEAR_DEBUG();
+	memset(&debug, 0, sizeof(debug));
 	debug.control = KVM_GUESTDBG_ENABLE | KVM_GUESTDBG_USE_SW_BP;
-	APPLY_DEBUG();
-	vcpu_run(vm, VCPU_ID);
+	vcpu_set_guest_debug(vm, vcpu->id, &debug);
+	vcpu_run(vm, vcpu->id);
 	TEST_ASSERT(run->exit_reason == KVM_EXIT_DEBUG &&
 		    run->debug.arch.exception == BP_VECTOR &&
 		    run->debug.arch.pc == CAST_TO_RIP(sw_bp),
@@ -119,12 +116,12 @@ int main(void)
 
 	/* Test instruction HW BP over DR[0-3] */
 	for (i = 0; i < 4; i++) {
-		CLEAR_DEBUG();
+		memset(&debug, 0, sizeof(debug));
 		debug.control = KVM_GUESTDBG_ENABLE | KVM_GUESTDBG_USE_HW_BP;
 		debug.arch.debugreg[i] = CAST_TO_RIP(hw_bp);
 		debug.arch.debugreg[7] = 0x400 | (1UL << (2*i+1));
-		APPLY_DEBUG();
-		vcpu_run(vm, VCPU_ID);
+		vcpu_set_guest_debug(vm, vcpu->id, &debug);
+		vcpu_run(vm, vcpu->id);
 		target_dr6 = 0xffff0ff0 | (1UL << i);
 		TEST_ASSERT(run->exit_reason == KVM_EXIT_DEBUG &&
 			    run->debug.arch.exception == DB_VECTOR &&
@@ -141,13 +138,13 @@ int main(void)
 
 	/* Test data access HW BP over DR[0-3] */
 	for (i = 0; i < 4; i++) {
-		CLEAR_DEBUG();
+		memset(&debug, 0, sizeof(debug));
 		debug.control = KVM_GUESTDBG_ENABLE | KVM_GUESTDBG_USE_HW_BP;
 		debug.arch.debugreg[i] = CAST_TO_RIP(guest_value);
 		debug.arch.debugreg[7] = 0x00000400 | (1UL << (2*i+1)) |
 		    (0x000d0000UL << (4*i));
-		APPLY_DEBUG();
-		vcpu_run(vm, VCPU_ID);
+		vcpu_set_guest_debug(vm, vcpu->id, &debug);
+		vcpu_run(vm, vcpu->id);
 		target_dr6 = 0xffff0ff0 | (1UL << i);
 		TEST_ASSERT(run->exit_reason == KVM_EXIT_DEBUG &&
 			    run->debug.arch.exception == DB_VECTOR &&
@@ -167,15 +164,15 @@ int main(void)
 	/* Test single step */
 	target_rip = CAST_TO_RIP(ss_start);
 	target_dr6 = 0xffff4ff0ULL;
-	vcpu_regs_get(vm, VCPU_ID, &regs);
+	vcpu_regs_get(vm, vcpu->id, &regs);
 	for (i = 0; i < (sizeof(ss_size) / sizeof(ss_size[0])); i++) {
 		target_rip += ss_size[i];
-		CLEAR_DEBUG();
+		memset(&debug, 0, sizeof(debug));
 		debug.control = KVM_GUESTDBG_ENABLE | KVM_GUESTDBG_SINGLESTEP |
 				KVM_GUESTDBG_BLOCKIRQ;
 		debug.arch.debugreg[7] = 0x00000400;
-		APPLY_DEBUG();
-		vcpu_run(vm, VCPU_ID);
+		vcpu_set_guest_debug(vm, vcpu->id, &debug);
+		vcpu_run(vm, vcpu->id);
 		TEST_ASSERT(run->exit_reason == KVM_EXIT_DEBUG &&
 			    run->debug.arch.exception == DB_VECTOR &&
 			    run->debug.arch.pc == target_rip &&
@@ -188,11 +185,11 @@ int main(void)
 	}
 
 	/* Finally test global disable */
-	CLEAR_DEBUG();
+	memset(&debug, 0, sizeof(debug));
 	debug.control = KVM_GUESTDBG_ENABLE | KVM_GUESTDBG_USE_HW_BP;
 	debug.arch.debugreg[7] = 0x400 | DR7_GD;
-	APPLY_DEBUG();
-	vcpu_run(vm, VCPU_ID);
+	vcpu_set_guest_debug(vm, vcpu->id, &debug);
+	vcpu_run(vm, vcpu->id);
 	target_dr6 = 0xffff0ff0 | DR6_BD;
 	TEST_ASSERT(run->exit_reason == KVM_EXIT_DEBUG &&
 		    run->debug.arch.exception == DB_VECTOR &&
@@ -205,12 +202,12 @@ int main(void)
 			    target_dr6);
 
 	/* Disable all debug controls, run to the end */
-	CLEAR_DEBUG();
-	APPLY_DEBUG();
+	memset(&debug, 0, sizeof(debug));
+	vcpu_set_guest_debug(vm, vcpu->id, &debug);
 
-	vcpu_run(vm, VCPU_ID);
+	vcpu_run(vm, vcpu->id);
 	TEST_ASSERT(run->exit_reason == KVM_EXIT_IO, "KVM_EXIT_IO");
-	cmd = get_ucall(vm, VCPU_ID, &uc);
+	cmd = get_ucall(vm, vcpu->id, &uc);
 	TEST_ASSERT(cmd == UCALL_DONE, "UCALL_DONE");
 
 	kvm_vm_free(vm);
-- 
2.35.1.723.g4982287a31-goog


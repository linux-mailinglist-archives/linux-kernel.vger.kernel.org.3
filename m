Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B66B04D5B0F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347620AbiCKF7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 00:59:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346669AbiCKFyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:54:00 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426F865C6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:52:54 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id b70-20020a253449000000b0062c16d950c5so6536577yba.9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=BHTniUnZLHzExLKWJC5iuCglVl1tbe9p6eIowKy0GQM=;
        b=pwrwOwn9+tJo509wahAPqMGhQ2rvAbKv6/ghJQdd6I5mQ+Cjy4DKzBktwKWL86+Chk
         FnzXllpNtO/3FK2NDSSwYOhGaUm6ECpT2npxpiwI2GxgHdjfBQwdCYOfTahCA/lt7Mx7
         b656+TF0aYMaisWYv5cRjl49hSw5SxaoCFcvreene5/tsV8CBb7aNojQ7AIssaRBwbBl
         vGqeumBoksGL42JZz81Dq9zaZ8WV/9DSS5cOKsuOsoi03DzCHtmxMx+fGLJvGhSm15A1
         7H4EAtgSObUTA1CJRpvN0cRBNwq5AIJhWI2Ju71QZu2PHXuwUFMkMR/t/oDB3x8eTI8Z
         3lKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=BHTniUnZLHzExLKWJC5iuCglVl1tbe9p6eIowKy0GQM=;
        b=dvebp7PR6tjcNhxQkCVtV19t8IReIA62j2Hv6ajvY5l15ckG05+zcyTD37fVInMD/t
         DFo6mathcmNGmoIN12uptCBxCooKkkO+GLDgivxkOrlQ+BR85sYoN6Z9m9CHu+j6i/SX
         NP1YB8xmq5/yLBDWNHx67UFnJt+d7uKbY2xLP8qImi1XsIPPucDYE/i4kW7ax3lBJQid
         i47+rsUxT83rZPeivLW3gS9LbaN/MXZFmPU8dx+Wl/d4+SLqQ577jqgsXLb/bQKLwKpn
         4iyluHdoeaou5PSN80stkxEZeJ7NScMj1KatfmbHnJvEeBe2MzFt+UA4H4MGCuQVY0Og
         Ym7Q==
X-Gm-Message-State: AOAM531OYNFic0w12X14ocZqwn/vhg321EiWmJ2LKNnMcLv4hxIixMMw
        nXet3oh49C8elGSldGfFBlQhdlWEnImhnJzJWdxIylzaAtQADcj9c/xpWACPHuifnHSr/zdC5tj
        0HuOyq6NG2x6bSbA3cKXefrOCelmdM9SxV7Z9JuMw34yd5SXc3T93TYqz/7yxJ1ESKFYgag==
X-Google-Smtp-Source: ABdhPJydwvYY8q1PnDU3RNwscBmDVt6S5yfy7oMnsJHXIa1RsuR2ODkdAzZ93yT/Rm1125zfUhsdQZowe1E=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a25:b11c:0:b0:62c:16d9:c028 with SMTP id
 g28-20020a25b11c000000b0062c16d9c028mr6971040ybj.288.1646977973807; Thu, 10
 Mar 2022 21:52:53 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:50:15 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-65-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 064/105] KVM: selftests: Convert amx_test away from VCPU_ID
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
 tools/testing/selftests/kvm/x86_64/amx_test.c | 33 +++++++++----------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/amx_test.c b/tools/testing/selftests/kvm/x86_64/amx_test.c
index 89d2423a2ffd..cd5a71f5a7ac 100644
--- a/tools/testing/selftests/kvm/x86_64/amx_test.c
+++ b/tools/testing/selftests/kvm/x86_64/amx_test.c
@@ -25,7 +25,6 @@
 # error This test is 64-bit only
 #endif
 
-#define VCPU_ID				0
 #define X86_FEATURE_XSAVE		(1 << 26)
 #define X86_FEATURE_OSXSAVE		(1 << 27)
 
@@ -320,6 +319,7 @@ int main(int argc, char *argv[])
 	struct kvm_cpuid_entry2 *entry;
 	struct kvm_regs regs1, regs2;
 	bool amx_supported = false;
+	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
 	struct kvm_run *run;
 	struct kvm_x86_state *state;
@@ -332,7 +332,7 @@ int main(int argc, char *argv[])
 	vm_xsave_req_perm(XSTATE_XTILE_DATA_BIT);
 
 	/* Create VM */
-	vm = vm_create_default(VCPU_ID, 0, guest_code);
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
 
 	entry = kvm_get_supported_cpuid_entry(1);
 	if (!(entry->ecx & X86_FEATURE_XSAVE)) {
@@ -351,12 +351,12 @@ int main(int argc, char *argv[])
 		xsave_restore_size = entry->ecx;
 	}
 
-	run = vcpu_state(vm, VCPU_ID);
-	vcpu_regs_get(vm, VCPU_ID, &regs1);
+	run = vcpu->run;
+	vcpu_regs_get(vm, vcpu->id, &regs1);
 
 	/* Register #NM handler */
 	vm_init_descriptor_tables(vm);
-	vcpu_init_descriptor_tables(vm, VCPU_ID);
+	vcpu_init_descriptor_tables(vm, vcpu->id);
 	vm_install_exception_handler(vm, NM_VECTOR, guest_nm_handler);
 
 	/* amx cfg for guest_code */
@@ -370,16 +370,16 @@ int main(int argc, char *argv[])
 	/* xsave data for guest_code */
 	xsavedata = vm_vaddr_alloc_pages(vm, 3);
 	memset(addr_gva2hva(vm, xsavedata), 0, 3 * getpagesize());
-	vcpu_args_set(vm, VCPU_ID, 3, amx_cfg, tiledata, xsavedata);
+	vcpu_args_set(vm, vcpu->id, 3, amx_cfg, tiledata, xsavedata);
 
 	for (stage = 1; ; stage++) {
-		_vcpu_run(vm, VCPU_ID);
+		vcpu_run(vm, vcpu->id);
 		TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
 			    "Stage %d: unexpected exit reason: %u (%s),\n",
 			    stage, run->exit_reason,
 			    exit_reason_str(run->exit_reason));
 
-		switch (get_ucall(vm, VCPU_ID, &uc)) {
+		switch (get_ucall(vm, vcpu->id, &uc)) {
 		case UCALL_ABORT:
 			TEST_FAIL("%s at %s:%ld", (const char *)uc.args[0],
 				  __FILE__, uc.args[1]);
@@ -404,7 +404,7 @@ int main(int argc, char *argv[])
 				 * size subtract 8K amx size.
 				 */
 				amx_offset = xsave_restore_size - NUM_TILES*TILE_SIZE;
-				state = vcpu_save_state(vm, VCPU_ID);
+				state = vcpu_save_state(vm, vcpu->id);
 				void *amx_start = (void *)state->xsave + amx_offset;
 				void *tiles_data = (void *)addr_gva2hva(vm, tiledata);
 				/* Only check TMM0 register, 1 tile */
@@ -425,22 +425,21 @@ int main(int argc, char *argv[])
 			TEST_FAIL("Unknown ucall %lu", uc.cmd);
 		}
 
-		state = vcpu_save_state(vm, VCPU_ID);
+		state = vcpu_save_state(vm, vcpu->id);
 		memset(&regs1, 0, sizeof(regs1));
-		vcpu_regs_get(vm, VCPU_ID, &regs1);
+		vcpu_regs_get(vm, vcpu->id, &regs1);
 
 		kvm_vm_release(vm);
 
 		/* Restore state in a new VM.  */
-		kvm_vm_restart(vm);
-		vm_vcpu_add(vm, VCPU_ID);
-		vcpu_set_cpuid(vm, VCPU_ID, kvm_get_supported_cpuid());
-		vcpu_load_state(vm, VCPU_ID, state);
-		run = vcpu_state(vm, VCPU_ID);
+		vcpu = vm_recreate_with_one_vcpu(vm);
+		vcpu_set_cpuid(vm, vcpu->id, kvm_get_supported_cpuid());
+		vcpu_load_state(vm, vcpu->id, state);
+		run = vcpu->run;
 		kvm_x86_state_cleanup(state);
 
 		memset(&regs2, 0, sizeof(regs2));
-		vcpu_regs_get(vm, VCPU_ID, &regs2);
+		vcpu_regs_get(vm, vcpu->id, &regs2);
 		TEST_ASSERT(!memcmp(&regs1, &regs2, sizeof(regs2)),
 			    "Unexpected register values after vcpu_load_state; rdi: %lx rsi: %lx",
 			    (ulong) regs2.rdi, (ulong) regs2.rsi);
-- 
2.35.1.723.g4982287a31-goog


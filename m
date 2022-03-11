Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1FD24D5AF8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346864AbiCKF4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 00:56:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346582AbiCKFxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:53:23 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF6AED95A
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:52:20 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id w68-20020a62dd47000000b004f6aa5e4824so4618974pff.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=igKDeEiD7Ubl4DfKdnpJFWKIeV0YPSRN96cAhPxa8YI=;
        b=eBofnVJSeVtonunwpBIziTu6BYKajGn/TU9mb3wSHN4IxqeEBbo9xHRQY5+c5M3QLG
         yufYAy0wD/Ky1McsyN20qSSVbJoaOCkDXThAfgKJt0ss93QX8rbgMwg3PtFUnA052vss
         YNJGgbzecg6uFb7pDHpG8yLifDNbcgm+/eZ3H2Kdk0x2aorAB94FLyDlR7JJIw4toXbH
         yyjE1SO+yV7WIJ7OayJRANrIwiuyo4kGqSkFTT87SG8jk1A1yDORmGADv15LrxmYvnVp
         R1njiw7+rCommYYZP9LkyreaLUZ54A8Aaq9AxpRvzzy147GRh3+fW1rIbQTSeyGCIbw3
         n82g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=igKDeEiD7Ubl4DfKdnpJFWKIeV0YPSRN96cAhPxa8YI=;
        b=tpktPOFn3c2sbXoR46kYFKlRFMRCnZEyV7Hayn+ldN5GzyuMk7g6eY5//p5JuU/obp
         TB5s5V2WabTragri5lnCMuNmJiTtx73mW9LQumKANCt2vX77I33hFV3gHXwkexKwiwu6
         2G3TrbPGB2+vMaaCu8Ip7Is/exdy3D+0PWxi4heI1JIYu+754C/PtmI7rB9tgM+f43aF
         CijZUg7fZCrviiiRPbDA2QfcI9y59qAqcNzO3FgnueXhrQ0Kjvh0XKVyHf9/7PbdZUtM
         oiii0Wl+WXUUf1MZoMugnGiEl++Dt2IVvVgCv2Bdbue1GrVpriEHna9Tzh+Hs65HdP42
         tGYA==
X-Gm-Message-State: AOAM530vz5tH2laz3MyV0kaB0xeWPKkgLbhDDTdSt3LpDEI3LzIrYJNZ
        1kjjU41P6hRM4GcP+mPyNNqcsLz9YgJZg7Ea+qyVNLmlFu4t0Qj98Z3uK/yQNBXmX3Mdj1Di1JF
        gnbtMxoqDLhb1pHCYVkZkoQAZKfU4v15GqbYElQK5k8yKcDJpg+Acx7DSZ8Kqa3+FqKkgCQ==
X-Google-Smtp-Source: ABdhPJw1HXAlJIwbOe6tO32nrbqkdey8Y7QaZJMuLUK0YIqaQHIzkQwVvqVc5RhDLhzj6NDNbvl8YfIy/jc=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:902:ef52:b0:151:84fe:bccb with SMTP id
 e18-20020a170902ef5200b0015184febccbmr8900097plx.9.1646977940135; Thu, 10 Mar
 2022 21:52:20 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:49:55 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-45-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 044/105] KVM: selftests: Convert sync_regs_test away from VCPU_ID
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
 .../selftests/kvm/x86_64/sync_regs_test.c     | 52 +++++++++----------
 1 file changed, 25 insertions(+), 27 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/sync_regs_test.c b/tools/testing/selftests/kvm/x86_64/sync_regs_test.c
index fc03a150278d..c971706b49f5 100644
--- a/tools/testing/selftests/kvm/x86_64/sync_regs_test.c
+++ b/tools/testing/selftests/kvm/x86_64/sync_regs_test.c
@@ -20,8 +20,6 @@
 #include "kvm_util.h"
 #include "processor.h"
 
-#define VCPU_ID 5
-
 #define UCALL_PIO_PORT ((uint16_t)0x1000)
 
 struct ucall uc_none = {
@@ -84,6 +82,7 @@ static void compare_vcpu_events(struct kvm_vcpu_events *left,
 
 int main(int argc, char *argv[])
 {
+	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
 	struct kvm_run *run;
 	struct kvm_regs regs;
@@ -104,57 +103,56 @@ int main(int argc, char *argv[])
 		exit(KSFT_SKIP);
 	}
 
-	/* Create VM */
-	vm = vm_create_default(VCPU_ID, 0, guest_code);
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
 
-	run = vcpu_state(vm, VCPU_ID);
+	run = vcpu->run;
 
 	/* Request reading invalid register set from VCPU. */
 	run->kvm_valid_regs = INVALID_SYNC_FIELD;
-	rv = _vcpu_run(vm, VCPU_ID);
+	rv = _vcpu_run(vm, vcpu->id);
 	TEST_ASSERT(rv < 0 && errno == EINVAL,
 		    "Invalid kvm_valid_regs did not cause expected KVM_RUN error: %d\n",
 		    rv);
-	vcpu_state(vm, VCPU_ID)->kvm_valid_regs = 0;
+	run->kvm_valid_regs = 0;
 
 	run->kvm_valid_regs = INVALID_SYNC_FIELD | TEST_SYNC_FIELDS;
-	rv = _vcpu_run(vm, VCPU_ID);
+	rv = _vcpu_run(vm, vcpu->id);
 	TEST_ASSERT(rv < 0 && errno == EINVAL,
 		    "Invalid kvm_valid_regs did not cause expected KVM_RUN error: %d\n",
 		    rv);
-	vcpu_state(vm, VCPU_ID)->kvm_valid_regs = 0;
+	run->kvm_valid_regs = 0;
 
 	/* Request setting invalid register set into VCPU. */
 	run->kvm_dirty_regs = INVALID_SYNC_FIELD;
-	rv = _vcpu_run(vm, VCPU_ID);
+	rv = _vcpu_run(vm, vcpu->id);
 	TEST_ASSERT(rv < 0 && errno == EINVAL,
 		    "Invalid kvm_dirty_regs did not cause expected KVM_RUN error: %d\n",
 		    rv);
-	vcpu_state(vm, VCPU_ID)->kvm_dirty_regs = 0;
+	run->kvm_dirty_regs = 0;
 
 	run->kvm_dirty_regs = INVALID_SYNC_FIELD | TEST_SYNC_FIELDS;
-	rv = _vcpu_run(vm, VCPU_ID);
+	rv = _vcpu_run(vm, vcpu->id);
 	TEST_ASSERT(rv < 0 && errno == EINVAL,
 		    "Invalid kvm_dirty_regs did not cause expected KVM_RUN error: %d\n",
 		    rv);
-	vcpu_state(vm, VCPU_ID)->kvm_dirty_regs = 0;
+	run->kvm_dirty_regs = 0;
 
 	/* Request and verify all valid register sets. */
 	/* TODO: BUILD TIME CHECK: TEST_ASSERT(KVM_SYNC_X86_NUM_FIELDS != 3); */
 	run->kvm_valid_regs = TEST_SYNC_FIELDS;
-	rv = _vcpu_run(vm, VCPU_ID);
+	rv = _vcpu_run(vm, vcpu->id);
 	TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
 		    "Unexpected exit reason: %u (%s),\n",
 		    run->exit_reason,
 		    exit_reason_str(run->exit_reason));
 
-	vcpu_regs_get(vm, VCPU_ID, &regs);
+	vcpu_regs_get(vm, vcpu->id, &regs);
 	compare_regs(&regs, &run->s.regs.regs);
 
-	vcpu_sregs_get(vm, VCPU_ID, &sregs);
+	vcpu_sregs_get(vm, vcpu->id, &sregs);
 	compare_sregs(&sregs, &run->s.regs.sregs);
 
-	vcpu_events_get(vm, VCPU_ID, &events);
+	vcpu_events_get(vm, vcpu->id, &events);
 	compare_vcpu_events(&events, &run->s.regs.events);
 
 	/* Set and verify various register values. */
@@ -164,7 +162,7 @@ int main(int argc, char *argv[])
 
 	run->kvm_valid_regs = TEST_SYNC_FIELDS;
 	run->kvm_dirty_regs = KVM_SYNC_X86_REGS | KVM_SYNC_X86_SREGS;
-	rv = _vcpu_run(vm, VCPU_ID);
+	rv = _vcpu_run(vm, vcpu->id);
 	TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
 		    "Unexpected exit reason: %u (%s),\n",
 		    run->exit_reason,
@@ -176,13 +174,13 @@ int main(int argc, char *argv[])
 		    "apic_base sync regs value incorrect 0x%llx.",
 		    run->s.regs.sregs.apic_base);
 
-	vcpu_regs_get(vm, VCPU_ID, &regs);
+	vcpu_regs_get(vm, vcpu->id, &regs);
 	compare_regs(&regs, &run->s.regs.regs);
 
-	vcpu_sregs_get(vm, VCPU_ID, &sregs);
+	vcpu_sregs_get(vm, vcpu->id, &sregs);
 	compare_sregs(&sregs, &run->s.regs.sregs);
 
-	vcpu_events_get(vm, VCPU_ID, &events);
+	vcpu_events_get(vm, vcpu->id, &events);
 	compare_vcpu_events(&events, &run->s.regs.events);
 
 	/* Clear kvm_dirty_regs bits, verify new s.regs values are
@@ -191,7 +189,7 @@ int main(int argc, char *argv[])
 	run->kvm_valid_regs = TEST_SYNC_FIELDS;
 	run->kvm_dirty_regs = 0;
 	run->s.regs.regs.rbx = 0xDEADBEEF;
-	rv = _vcpu_run(vm, VCPU_ID);
+	rv = _vcpu_run(vm, vcpu->id);
 	TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
 		    "Unexpected exit reason: %u (%s),\n",
 		    run->exit_reason,
@@ -208,8 +206,8 @@ int main(int argc, char *argv[])
 	run->kvm_dirty_regs = 0;
 	run->s.regs.regs.rbx = 0xAAAA;
 	regs.rbx = 0xBAC0;
-	vcpu_regs_set(vm, VCPU_ID, &regs);
-	rv = _vcpu_run(vm, VCPU_ID);
+	vcpu_regs_set(vm, vcpu->id, &regs);
+	rv = _vcpu_run(vm, vcpu->id);
 	TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
 		    "Unexpected exit reason: %u (%s),\n",
 		    run->exit_reason,
@@ -217,7 +215,7 @@ int main(int argc, char *argv[])
 	TEST_ASSERT(run->s.regs.regs.rbx == 0xAAAA,
 		    "rbx sync regs value incorrect 0x%llx.",
 		    run->s.regs.regs.rbx);
-	vcpu_regs_get(vm, VCPU_ID, &regs);
+	vcpu_regs_get(vm, vcpu->id, &regs);
 	TEST_ASSERT(regs.rbx == 0xBAC0 + 1,
 		    "rbx guest value incorrect 0x%llx.",
 		    regs.rbx);
@@ -229,7 +227,7 @@ int main(int argc, char *argv[])
 	run->kvm_valid_regs = 0;
 	run->kvm_dirty_regs = TEST_SYNC_FIELDS;
 	run->s.regs.regs.rbx = 0xBBBB;
-	rv = _vcpu_run(vm, VCPU_ID);
+	rv = _vcpu_run(vm, vcpu->id);
 	TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
 		    "Unexpected exit reason: %u (%s),\n",
 		    run->exit_reason,
@@ -237,7 +235,7 @@ int main(int argc, char *argv[])
 	TEST_ASSERT(run->s.regs.regs.rbx == 0xBBBB,
 		    "rbx sync regs value incorrect 0x%llx.",
 		    run->s.regs.regs.rbx);
-	vcpu_regs_get(vm, VCPU_ID, &regs);
+	vcpu_regs_get(vm, vcpu->id, &regs);
 	TEST_ASSERT(regs.rbx == 0xBBBB + 1,
 		    "rbx guest value incorrect 0x%llx.",
 		    regs.rbx);
-- 
2.35.1.723.g4982287a31-goog


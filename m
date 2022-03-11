Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084A04D5B54
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 07:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242144AbiCKGBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 01:01:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345663AbiCKFzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:55:08 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F873FDFB7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:53:38 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id j9-20020a170903024900b0015195e68490so3987576plh.19
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=aSZw3cVRwIZyv3OvfWBlsLbpqJYb1+qc9avxdMzlJBU=;
        b=AKo44+76eji6YCYGKYs3dEqrNoTpgl2D7pdtuusQ8AGncsdnr2qTq1U9hsrB8ZqNGo
         paywt59Dlcun6hMi1PFHufP2MY+ViGoX4j2nTEf3pW08GARVjmFH/WTXKNcqj4GllfHW
         u9ysiY5+TbhRHwmA3sYx+ceWmmPeXlqEUXdLBh632M9dL7F+EYg+VUbb6N43ABuM2Z4q
         q0XtRlsEC3EaoIBKU3GcNMF9Qb3EBRNOvLDwvgQ4T45r91gp2ipC3lwAkEolWlGhc/XO
         UA5o9a6FbRDRMjs9fV/OJWqPdV9+M8U/rLGprOAPl7cPrXzqXsTAneuwe8chtbMuYevu
         3mzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=aSZw3cVRwIZyv3OvfWBlsLbpqJYb1+qc9avxdMzlJBU=;
        b=ad9qEJdDX/NQN9e585TWPEslB+oJeHdU7//bXrJmheeyalAaBdkgjBAYstWieeG3QK
         WVh0M/esra7wPuXiwcgyyDfeb+Vl3A8oQnzqCCrrMI47pShZtXL87WaqIJXVMB+ZKG6T
         A2daJBYE8hMNxXSoFFMl6Vmk8E++MYGHYYb2Onc286IEeSuasBZylqGHlTWyO8ogjEJ/
         7KJP12euJKT49gEAaWrwr43y1TmVrRh/fbB16apSgM5urGJ0f+u4yBArG1YRCR4jyOs/
         GDqcEMLiW3rovwofCT0CIwADAKkYqnrsOuetnNJo2JD2eNfiM/qrKf+R9Efj3B/M7TDA
         eaNg==
X-Gm-Message-State: AOAM5322Yu55x5AOyHxuzmkUvuQLieHKh45xTbtCfDTNlB6BpLIFNOST
        2XyouDqX6nDfmKZapl3jFMUaS06D5EkiLxx0rjudOjW3KyCGHyBEzsu+nrYDAiWCQPSyw8L7xly
        jElvCMVWKjVSYt7AHwDc7+rK8NBLv0aehx3nASW9TKy4VNIFeZxuSX2rE6ZdhoapBGMeDJg==
X-Google-Smtp-Source: ABdhPJwBlXVWBzKNRqmkAWJr8zwTqftT5bJDqC8Ws/HaXSDB6WzDju7WmQNnjsHoG3z2TuHUKceMohkjsrA=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:23c5:b0:4f7:b50:e5f3 with SMTP id
 g5-20020a056a0023c500b004f70b50e5f3mr8777882pfc.36.1646978017920; Thu, 10 Mar
 2022 21:53:37 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:50:41 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-91-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 090/105] KVM: selftests: Convert sync_regs_test away from VCPU_ID
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
 .../selftests/kvm/s390x/sync_regs_test.c      | 37 +++++++++----------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/kvm/s390x/sync_regs_test.c b/tools/testing/selftests/kvm/s390x/sync_regs_test.c
index caf7b8859a94..bf52cabeaed6 100644
--- a/tools/testing/selftests/kvm/s390x/sync_regs_test.c
+++ b/tools/testing/selftests/kvm/s390x/sync_regs_test.c
@@ -22,8 +22,6 @@
 #include "kvm_util.h"
 #include "diag318_test_handler.h"
 
-#define VCPU_ID 5
-
 static void guest_code(void)
 {
 	/*
@@ -76,6 +74,7 @@ static void compare_sregs(struct kvm_sregs *left, struct kvm_sync_regs *right)
 
 int main(int argc, char *argv[])
 {
+	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
 	struct kvm_run *run;
 	struct kvm_regs regs;
@@ -92,43 +91,43 @@ int main(int argc, char *argv[])
 	}
 
 	/* Create VM */
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
 	run->kvm_valid_regs = TEST_SYNC_FIELDS;
-	rv = _vcpu_run(vm, VCPU_ID);
+	rv = _vcpu_run(vm, vcpu->id);
 	TEST_ASSERT(rv == 0, "vcpu_run failed: %d\n", rv);
 	TEST_ASSERT(run->exit_reason == KVM_EXIT_S390_SIEIC,
 		    "Unexpected exit reason: %u (%s)\n",
@@ -141,10 +140,10 @@ int main(int argc, char *argv[])
 		    run->s390_sieic.icptcode, run->s390_sieic.ipa,
 		    run->s390_sieic.ipb);
 
-	vcpu_regs_get(vm, VCPU_ID, &regs);
+	vcpu_regs_get(vm, vcpu->id, &regs);
 	compare_regs(&regs, &run->s.regs);
 
-	vcpu_sregs_get(vm, VCPU_ID, &sregs);
+	vcpu_sregs_get(vm, vcpu->id, &sregs);
 	compare_sregs(&sregs, &run->s.regs);
 
 	/* Set and verify various register values */
@@ -159,7 +158,7 @@ int main(int argc, char *argv[])
 		run->kvm_dirty_regs |= KVM_SYNC_DIAG318;
 	}
 
-	rv = _vcpu_run(vm, VCPU_ID);
+	rv = _vcpu_run(vm, vcpu->id);
 	TEST_ASSERT(rv == 0, "vcpu_run failed: %d\n", rv);
 	TEST_ASSERT(run->exit_reason == KVM_EXIT_S390_SIEIC,
 		    "Unexpected exit reason: %u (%s)\n",
@@ -175,10 +174,10 @@ int main(int argc, char *argv[])
 		    "diag318 sync regs value incorrect 0x%llx.",
 		    run->s.regs.diag318);
 
-	vcpu_regs_get(vm, VCPU_ID, &regs);
+	vcpu_regs_get(vm, vcpu->id, &regs);
 	compare_regs(&regs, &run->s.regs);
 
-	vcpu_sregs_get(vm, VCPU_ID, &sregs);
+	vcpu_sregs_get(vm, vcpu->id, &sregs);
 	compare_sregs(&sregs, &run->s.regs);
 
 	/* Clear kvm_dirty_regs bits, verify new s.regs values are
@@ -188,7 +187,7 @@ int main(int argc, char *argv[])
 	run->kvm_dirty_regs = 0;
 	run->s.regs.gprs[11] = 0xDEADBEEF;
 	run->s.regs.diag318 = 0x4B1D;
-	rv = _vcpu_run(vm, VCPU_ID);
+	rv = _vcpu_run(vm, vcpu->id);
 	TEST_ASSERT(rv == 0, "vcpu_run failed: %d\n", rv);
 	TEST_ASSERT(run->exit_reason == KVM_EXIT_S390_SIEIC,
 		    "Unexpected exit reason: %u (%s)\n",
-- 
2.35.1.723.g4982287a31-goog


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 829B34D5AFE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346823AbiCKF43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 00:56:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346705AbiCKFxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:53:18 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD28DECB30
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:52:15 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id j1-20020a170903028100b0014b1f9e0068so4004436plr.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=nKY1NzHsWE0nPtq6NzlHkZcJxY2/2SkdN5bv0Qzxtt0=;
        b=MIOSM+P4kYdacEJPzB057gOAFVlDlVwTPFsoMbSV0srTJYPcS3kFivvRUFri5iog9W
         l2PHLtP5L1YerP4vciygSjXp7Ww47pghklZGZLEhmz9mLG58t3BiJfQzT7AbefdceXke
         YVemMe+1QuE5HOBFZBxuk9Uq+0ZlEKFR3TiS/+ROxtS/BjhNJFEqzZYiJ2bAQ5/W0r63
         aeijpbCUtS1Y488VSCdueNkGymwccB7wakWbOvOjJrgcx3vn7kJyP/NgE3rN170BIMjd
         bkHNLko02DxhJAoZdgMoeD92l9b5ISlk37kbnSCsaFsDo75XgeAtC24LMItlj3/EZP07
         hkkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=nKY1NzHsWE0nPtq6NzlHkZcJxY2/2SkdN5bv0Qzxtt0=;
        b=TIDgYfwUdfm/ZUAITKA4TeclLwKj4nU0PQmqTaGC6/0t+8UGKooqSkPC3P6BJC9jar
         NBAHWoVr7Adm6/U2iJnLSv1SWTG2tFO0M8qqbzW7zHZBHvNGgoTnEfm63zcEP7wSPDyj
         XXQNswsxTAJcQ/Gozc7t4nFzWtFmt/CS4dDplMBWSXWQaIJtMggz2zm91ExKn4UE2UGA
         VRQFeMt304ZsmElV8jKzMXYzdhA1sfSTaL5vmYKoGDx5ccx6d2VFAXaRZozZL6DBHo3X
         DUfR5kPXTdJ0wUdCzWvVoB8E5yk+6BankKyX5H+LuOAysgjnOGZd5Qv+F+5/ku8gGez+
         gRzQ==
X-Gm-Message-State: AOAM532XZu4lfQ7Xh8jbsLD4BmQav++0EEXbswkXg7LoEeoKnGcnHuvZ
        rSYowyYUrkK1wODXFtlZnuiDs0sdsEzHKSWOVXcXGmVWq0iq8W6nAAcQ20fQdREWdLk769wQRof
        sWwQPlYSM35Og9Dzsj+82EaxIOKuBto7hZFYYVeH2I8VsuJPqybReqPKlAsfb1Au3XT6rmQ==
X-Google-Smtp-Source: ABdhPJxQEkoH+pyuGe2G9eSTbcti9GGr1+HYCZ09I7QB9VS1hVu+Qitazy19TehG5UTzEoevi8+DBKaiMHQ=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90b:1e4f:b0:1bf:88d1:d97f with SMTP id
 pi15-20020a17090b1e4f00b001bf88d1d97fmr9119461pjb.150.1646977935191; Thu, 10
 Mar 2022 21:52:15 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:49:52 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-42-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 041/105] KVM: selftests: Convert state_test away from VCPU_ID
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
 .../testing/selftests/kvm/x86_64/state_test.c | 29 +++++++++----------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/state_test.c b/tools/testing/selftests/kvm/x86_64/state_test.c
index 41f7faaef2ac..b7869efad22a 100644
--- a/tools/testing/selftests/kvm/x86_64/state_test.c
+++ b/tools/testing/selftests/kvm/x86_64/state_test.c
@@ -20,7 +20,6 @@
 #include "vmx.h"
 #include "svm_util.h"
 
-#define VCPU_ID		5
 #define L2_GUEST_STACK_SIZE 256
 
 void svm_l2_guest_code(void)
@@ -157,6 +156,7 @@ int main(int argc, char *argv[])
 	vm_vaddr_t nested_gva = 0;
 
 	struct kvm_regs regs1, regs2;
+	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
 	struct kvm_run *run;
 	struct kvm_x86_state *state;
@@ -164,10 +164,10 @@ int main(int argc, char *argv[])
 	int stage;
 
 	/* Create VM */
-	vm = vm_create_default(VCPU_ID, 0, guest_code);
-	run = vcpu_state(vm, VCPU_ID);
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+	run = vcpu->run;
 
-	vcpu_regs_get(vm, VCPU_ID, &regs1);
+	vcpu_regs_get(vm, vcpu->id, &regs1);
 
 	if (kvm_check_cap(KVM_CAP_NESTED_STATE)) {
 		if (nested_svm_supported())
@@ -179,16 +179,16 @@ int main(int argc, char *argv[])
 	if (!nested_gva)
 		pr_info("will skip nested state checks\n");
 
-	vcpu_args_set(vm, VCPU_ID, 1, nested_gva);
+	vcpu_args_set(vm, vcpu->id, 1, nested_gva);
 
 	for (stage = 1;; stage++) {
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
@@ -206,22 +206,21 @@ int main(int argc, char *argv[])
 			    uc.args[1] == stage, "Stage %d: Unexpected register values vmexit, got %lx",
 			    stage, (ulong)uc.args[1]);
 
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


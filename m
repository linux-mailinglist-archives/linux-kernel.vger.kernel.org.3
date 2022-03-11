Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D0D4D5B05
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347172AbiCKF6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 00:58:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346648AbiCKFxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:53:51 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72A52192
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:52:40 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id d13-20020a170902b70d00b0015317d9f08bso2688977pls.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=yYOWngW9swEKoLiocViJlPgmRX4RHGJvexYuDT9PE58=;
        b=V1xn4EL2rQjK9VxhDt12y6eHFft5VoAiqFGwVlfh7VrkqaFkdal58HTg+9wBCibVCg
         29oPSxE4bRVMSW7GCvXTeImPeBIErbEeB/7SNeqMP3I72H6l86oiH/2Z3SDKlI6C5KC1
         4Nkz3/T+eUN1Ao7dJRmrgnSp4pJTiNtBQ1kr+FkMRU9y90a0iRAFYD4PYfHR+sly0FoK
         Jb1gAYK/igayAcJod52RCrXBsHYAO+0X3c2Qy3GaOlC6HyvezWPYZqz/YWseHc5FrUY9
         TQS6VqGmPgV27uAnuOb4gwKmbokb47vr5AAnkB3IrYgo3VcPRsTFdd5CPMBiythb06ML
         fO7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=yYOWngW9swEKoLiocViJlPgmRX4RHGJvexYuDT9PE58=;
        b=FQdew/eq+bBUHrHqZYYLkuTM9H+lvbtDPpUEeA3iQycRmdtQwEsbZ/cTWnIAl/Bni3
         q09cjngGIKSOgX55inT28YpYU5CYnVHNLryzeEBJoXDBuagcl7wazWTgLDeeUA0mUM57
         tGGhAw8nHlzW+sCcYyUeVNcP3t132jKI61FAo7WdxA3mBP24XKt0lqRgi55CfYcN5gKB
         AkQRwG3klWgPl6c3if1CWkkWXq1sG9kJjPFOuPO9r32wU8GgpsrHfzAPzb7ExaLfJJe5
         3g9ZTXncowKEPmMCJ08jaKxhU8X1dbGZ1pa1iLzrkksOhNA50tDSE+PoRn8QxpbZEajb
         M6mQ==
X-Gm-Message-State: AOAM532TmXuKMYsgtcv+55PVobm6DrHWX8RXbLSGNEjpS+Z8x/8QaA7I
        xMCJVWcKguGgfPUqdrXSc7MfAeBgM36U8A4KnfnCtpaEr0dOwF5xwFO9u+CgS4C2hbpcgkjc6/E
        D9onTOc+miwD2U7lNm/54ss/f5f14VErc6sYpQ+rZLATVHdigzKliObsgI0Nsz+HfVJISWg==
X-Google-Smtp-Source: ABdhPJxpFuwtvTbry1S7ITod/9XBv2lZURI65ms7NABslXFkXMfuPcV72oNPWXfzXUmgvymFEeKHsOWmZIg=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:2182:b0:4f6:5051:61db with SMTP id
 h2-20020a056a00218200b004f6505161dbmr8744162pfi.40.1646977960092; Thu, 10 Mar
 2022 21:52:40 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:50:07 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-57-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 056/105] KVM: selftests: Convert kvm_clock_test away from VCPU_ID
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
 .../selftests/kvm/x86_64/kvm_clock_test.c     | 23 ++++++++-----------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/kvm_clock_test.c b/tools/testing/selftests/kvm/x86_64/kvm_clock_test.c
index 97731454f3f3..2c1f850c4053 100644
--- a/tools/testing/selftests/kvm/x86_64/kvm_clock_test.c
+++ b/tools/testing/selftests/kvm/x86_64/kvm_clock_test.c
@@ -16,8 +16,6 @@
 #include "kvm_util.h"
 #include "processor.h"
 
-#define VCPU_ID 0
-
 struct test_case {
 	uint64_t kvmclock_base;
 	int64_t realtime_offset;
@@ -105,29 +103,27 @@ static void setup_clock(struct kvm_vm *vm, struct test_case *test_case)
 	vm_ioctl(vm, KVM_SET_CLOCK, &data);
 }
 
-static void enter_guest(struct kvm_vm *vm)
+static void enter_guest(struct kvm_vcpu *vcpu)
 {
 	struct kvm_clock_data start, end;
-	struct kvm_run *run;
+	struct kvm_run *run = vcpu->run;
+	struct kvm_vm *vm = vcpu->vm;
 	struct ucall uc;
-	int i, r;
-
-	run = vcpu_state(vm, VCPU_ID);
+	int i;
 
 	for (i = 0; i < ARRAY_SIZE(test_cases); i++) {
 		setup_clock(vm, &test_cases[i]);
 
 		vm_ioctl(vm, KVM_GET_CLOCK, &start);
 
-		r = _vcpu_run(vm, VCPU_ID);
+		vcpu_run(vcpu->vm, vcpu->id);
 		vm_ioctl(vm, KVM_GET_CLOCK, &end);
 
-		TEST_ASSERT(!r, "vcpu_run failed: %d\n", r);
 		TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
 			    "unexpected exit reason: %u (%s)",
 			    run->exit_reason, exit_reason_str(run->exit_reason));
 
-		switch (get_ucall(vm, VCPU_ID, &uc)) {
+		switch (get_ucall(vcpu->vm, vcpu->id, &uc)) {
 		case UCALL_SYNC:
 			handle_sync(&uc, &start, &end);
 			break;
@@ -178,6 +174,7 @@ static void check_clocksource(void)
 
 int main(void)
 {
+	struct kvm_vcpu *vcpu;
 	vm_vaddr_t pvti_gva;
 	vm_paddr_t pvti_gpa;
 	struct kvm_vm *vm;
@@ -192,12 +189,12 @@ int main(void)
 
 	check_clocksource();
 
-	vm = vm_create_default(VCPU_ID, 0, guest_main);
+	vm = vm_create_with_one_vcpu(&vcpu, guest_main);
 
 	pvti_gva = vm_vaddr_alloc(vm, getpagesize(), 0x10000);
 	pvti_gpa = addr_gva2gpa(vm, pvti_gva);
-	vcpu_args_set(vm, VCPU_ID, 2, pvti_gpa, pvti_gva);
+	vcpu_args_set(vm, vcpu->id, 2, pvti_gpa, pvti_gva);
 
-	enter_guest(vm);
+	enter_guest(vcpu);
 	kvm_vm_free(vm);
 }
-- 
2.35.1.723.g4982287a31-goog


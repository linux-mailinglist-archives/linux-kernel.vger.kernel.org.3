Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4614D5B10
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347634AbiCKF7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 00:59:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346671AbiCKFyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:54:01 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17BE61263C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:52:57 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id x6-20020a1709029a4600b0014efe26b04fso3977626plv.21
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=XUXPD0nWjg99B9sTK5klaYVXSQj8HOXxZq7Zxx2uYqs=;
        b=q44++PDViHATwr4obLahML3WIIoMsZ0p5iHjjr4vMYBMmKZpOhsvKp7eKtflaFuNb0
         oZZxf9x8Jn65vpk6Cc4xuVZl6wGmPIiBGNfEOSrPNmindXXdLEPBB02u4qouQYKBL10E
         Ghreja17ykck+V5TvLCFoHnFj7nMtxv62jLbYDg4INNzM+Qom9sqxtN3hoaVAeej0Ymo
         nKsHzP4vAgbjUgP48ztxbGUtY4AS01Rrc0mSYFDxGFUFEKYwwA2uKeyLJdAvebYvaijM
         XIGQfU65o/LmkX0KxOedss1CgpPCTryt5G/R6UWmLJ+f5ftoaNQ5P8JVeRwo7qlAuw9W
         rodQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=XUXPD0nWjg99B9sTK5klaYVXSQj8HOXxZq7Zxx2uYqs=;
        b=R5h098SvM5URMaGyDjpx0caxJoS/wadx1QyjKZe7a6cfjXjSjibhmeYNDzbxLr6BXO
         8Be3oWCl1UmFN44XwrflMzktecuQf4Q+Ywinr9iE+rcyz4BArgDP9Eb/HIMyTdCbo+BD
         fTeQZ7r6wwWAK61+6hgYJYkTvuYiLqyPvPTPKKdl+tOGryO944GdqQD3p35OUp9SVUKI
         8mags2TPmUDiZGzO8/6jX6xW1itRgWZ6ZNZNa2CoQmrBRxpwm5qmZL1gYj6VNTgAGgv9
         Aa4rDTs2cNoD3Qb86UYbyq2QzBCBePEWnIKK1VtDCJWj4jTWzSJx42ELTSi2LkwxUBGe
         z4jw==
X-Gm-Message-State: AOAM530DvY8XDl7GLu3p7l1roRmF0X8tsJsSQOIfWhTC0n6GFm4QSLH0
        SD6LDuoqrrj4r/2jfP0xr4vTwo/h8CvDhz2XRiaXhPzIXWbkT6t6z96uDIw9R4Br3AzUziqjtTk
        d2IvRJbBT9llgBQ0YVohcKjSR5u3SFmb3TPBu4QuRotIW3/PWXcRvM0LjDCzRRQ2cRturpg==
X-Google-Smtp-Source: ABdhPJyh6KD+oga8p2s5R/j/GBTjxhNXb96cwa2RkrdjggzYtJr4uXfRQ8JH5Z5PYyvECqpCfdyM/17lSCM=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90a:788f:b0:1bd:59c5:748e with SMTP id
 x15-20020a17090a788f00b001bd59c5748emr20071395pjk.158.1646977977332; Thu, 10
 Mar 2022 21:52:57 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:50:17 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-67-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 066/105] KVM: selftests: Convert cpuid_test away from VCPU_ID
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
 .../testing/selftests/kvm/x86_64/cpuid_test.c | 29 +++++++++----------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/cpuid_test.c b/tools/testing/selftests/kvm/x86_64/cpuid_test.c
index 16d2465c5634..76cdd0d10757 100644
--- a/tools/testing/selftests/kvm/x86_64/cpuid_test.c
+++ b/tools/testing/selftests/kvm/x86_64/cpuid_test.c
@@ -12,8 +12,6 @@
 #include "kvm_util.h"
 #include "processor.h"
 
-#define VCPU_ID 0
-
 /* CPUIDs known to differ */
 struct {
 	u32 function;
@@ -118,13 +116,13 @@ static void compare_cpuids(struct kvm_cpuid2 *cpuid1, struct kvm_cpuid2 *cpuid2)
 		check_cpuid(cpuid1, &cpuid2->entries[i]);
 }
 
-static void run_vcpu(struct kvm_vm *vm, uint32_t vcpuid, int stage)
+static void run_vcpu(struct kvm_vcpu *vcpu, int stage)
 {
 	struct ucall uc;
 
-	_vcpu_run(vm, vcpuid);
+	vcpu_run(vcpu->vm, vcpu->id);
 
-	switch (get_ucall(vm, vcpuid, &uc)) {
+	switch (get_ucall(vcpu->vm, vcpu->id, &uc)) {
 	case UCALL_SYNC:
 		TEST_ASSERT(!strcmp((const char *)uc.args[0], "hello") &&
 			    uc.args[1] == stage + 1,
@@ -138,7 +136,7 @@ static void run_vcpu(struct kvm_vm *vm, uint32_t vcpuid, int stage)
 			    __FILE__, uc.args[1], uc.args[2], uc.args[3]);
 	default:
 		TEST_ASSERT(false, "Unexpected exit: %s",
-			    exit_reason_str(vcpu_state(vm, vcpuid)->exit_reason));
+			    exit_reason_str(vcpu->run->exit_reason));
 	}
 }
 
@@ -154,21 +152,21 @@ struct kvm_cpuid2 *vcpu_alloc_cpuid(struct kvm_vm *vm, vm_vaddr_t *p_gva, struct
 	return guest_cpuids;
 }
 
-static void set_cpuid_after_run(struct kvm_vm *vm, struct kvm_cpuid2 *cpuid)
+static void set_cpuid_after_run(struct kvm_vcpu *vcpu, struct kvm_cpuid2 *cpuid)
 {
 	struct kvm_cpuid_entry2 *ent;
 	int rc;
 	u32 eax, ebx, x;
 
 	/* Setting unmodified CPUID is allowed */
-	rc = __vcpu_set_cpuid(vm, VCPU_ID, cpuid);
+	rc = __vcpu_set_cpuid(vcpu->vm, vcpu->id, cpuid);
 	TEST_ASSERT(!rc, "Setting unmodified CPUID after KVM_RUN failed: %d", rc);
 
 	/* Changing CPU features is forbidden */
 	ent = get_cpuid(cpuid, 0x7, 0);
 	ebx = ent->ebx;
 	ent->ebx--;
-	rc = __vcpu_set_cpuid(vm, VCPU_ID, cpuid);
+	rc = __vcpu_set_cpuid(vcpu->vm, vcpu->id, cpuid);
 	TEST_ASSERT(rc, "Changing CPU features should fail");
 	ent->ebx = ebx;
 
@@ -177,7 +175,7 @@ static void set_cpuid_after_run(struct kvm_vm *vm, struct kvm_cpuid2 *cpuid)
 	eax = ent->eax;
 	x = eax & 0xff;
 	ent->eax = (eax & ~0xffu) | (x - 1);
-	rc = __vcpu_set_cpuid(vm, VCPU_ID, cpuid);
+	rc = __vcpu_set_cpuid(vcpu->vm, vcpu->id, cpuid);
 	TEST_ASSERT(rc, "Changing MAXPHYADDR should fail");
 	ent->eax = eax;
 }
@@ -185,25 +183,26 @@ static void set_cpuid_after_run(struct kvm_vm *vm, struct kvm_cpuid2 *cpuid)
 int main(void)
 {
 	struct kvm_cpuid2 *supp_cpuid, *cpuid2;
+	struct kvm_vcpu *vcpu;
 	vm_vaddr_t cpuid_gva;
 	struct kvm_vm *vm;
 	int stage;
 
-	vm = vm_create_default(VCPU_ID, 0, guest_main);
+	vm = vm_create_with_one_vcpu(&vcpu, guest_main);
 
 	supp_cpuid = kvm_get_supported_cpuid();
-	cpuid2 = vcpu_get_cpuid(vm, VCPU_ID);
+	cpuid2 = vcpu_get_cpuid(vm, vcpu->id);
 
 	compare_cpuids(supp_cpuid, cpuid2);
 
 	vcpu_alloc_cpuid(vm, &cpuid_gva, cpuid2);
 
-	vcpu_args_set(vm, VCPU_ID, 1, cpuid_gva);
+	vcpu_args_set(vm, vcpu->id, 1, cpuid_gva);
 
 	for (stage = 0; stage < 3; stage++)
-		run_vcpu(vm, VCPU_ID, stage);
+		run_vcpu(vcpu, stage);
 
-	set_cpuid_after_run(vm, cpuid2);
+	set_cpuid_after_run(vcpu, cpuid2);
 
 	kvm_vm_free(vm);
 }
-- 
2.35.1.723.g4982287a31-goog


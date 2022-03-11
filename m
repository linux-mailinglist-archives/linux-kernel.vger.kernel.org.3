Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 357FB4D5B08
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347440AbiCKF62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 00:58:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346628AbiCKFxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:53:55 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC891A815
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:52:46 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id f21-20020a633815000000b0038105768c61so1017186pga.21
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=7U7G4ALbdiuLS3ZHKyVSI7ZzJ4cEKDAs0AuckoMKbn8=;
        b=LuwwEux2gAAv/ehbXUSCHfeOQ2oNIFRHgMMd5lrdxiXjZkFA8RTpCwg7/Q+woF4ndy
         IKB1tSYRlZLL7ubSrKms5wGSpJ+pK8meHfe0nQuG/FNKTHlOwzErE+A/aG4QlZram2Zx
         Absg0t4M/6TzpWZFU7xJeRN26fOsfvfb3TBwZjGC6s+mlU3e+ZRVwxjoL+zieTgw5PVi
         1QHB6eW+lgeZZt+5vFyRZJR1l+dp1yqQj61RAQ9xskPvkmrgL5ONY/bGuNI55zCVM9kW
         LryQmNYQYIa9qL3NxYoXRXQU1uFNpPO9tKUxrJQ8sHYbiER+rW5bTnAtRQBvgHWrRj0X
         XfRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=7U7G4ALbdiuLS3ZHKyVSI7ZzJ4cEKDAs0AuckoMKbn8=;
        b=CcrnfOA8uGxoZ6knjjVsDVLxcVYNjd8HEbscXL1tKSB31Juyl4+XbtIoFW0wpRWNP1
         BIQIx/TkcJ3ok+8lWg/M3WXEQ336ZVWqfL+/dmVbvHdxiz72vErojPqRifsktRBb3Qwg
         vykJegAZuTRZNb3CMfpm9Qqz1yblHmAuWVzqiQO/WvP1ryE0edg9tNs9avXRQNmnRrJO
         GSS9onSvFUDT7T3m+9G1RlUuG9gIeIXAoSe3vmtoO3zKW5v/W4rJm5NXu5tBbYC/vB2Z
         huIUMANWXjEEHUlYKk05otwOqT/zqJ3BTyqDjkuWhEfAyG7VksInrlYeQL0HSDFuXmMt
         fT4A==
X-Gm-Message-State: AOAM533eEZs6EJF9JQ+lRsZ657MydyNtdiwQ0P2n1g0kCmMdxF02hm7H
        On3SA7447YaO8yIRXCMIxrQKQ7071Qc7TMcvZfFnAaknLerIJ+uZR0qd1IRx2VtPcm79sruR9yb
        Pw2J2fIE6xuMjDiWd17eNe0x614YTdNuAAomLNUHZ7Qz8uc1fOGBahoUu2hl5JwaNkPu2cQ==
X-Google-Smtp-Source: ABdhPJzvoUwYnDlBdw2GhELRmmSWDdTSILCiFAtrzZQA4NYDbxPKoXGXVVcQePmODtuqxCS4eDnRfqZS+7E=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:902:ba8e:b0:151:ed65:fda4 with SMTP id
 k14-20020a170902ba8e00b00151ed65fda4mr8852878pls.127.1646977965338; Thu, 10
 Mar 2022 21:52:45 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:50:10 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-60-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 059/105] KVM: selftests: Convert hyperv_clock away from VCPU_ID
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
 .../selftests/kvm/x86_64/hyperv_clock.c       | 25 +++++++++----------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_clock.c b/tools/testing/selftests/kvm/x86_64/hyperv_clock.c
index e0b2bb1339b1..43584ddc4de0 100644
--- a/tools/testing/selftests/kvm/x86_64/hyperv_clock.c
+++ b/tools/testing/selftests/kvm/x86_64/hyperv_clock.c
@@ -171,22 +171,20 @@ static void guest_main(struct ms_hyperv_tsc_page *tsc_page, vm_paddr_t tsc_page_
 	GUEST_DONE();
 }
 
-#define VCPU_ID 0
-
-static void host_check_tsc_msr_rdtsc(struct kvm_vm *vm)
+static void host_check_tsc_msr_rdtsc(struct kvm_vcpu *vcpu)
 {
 	u64 tsc_freq, r1, r2, t1, t2;
 	s64 delta_ns;
 
-	tsc_freq = vcpu_get_msr(vm, VCPU_ID, HV_X64_MSR_TSC_FREQUENCY);
+	tsc_freq = vcpu_get_msr(vcpu->vm, vcpu->id, HV_X64_MSR_TSC_FREQUENCY);
 	TEST_ASSERT(tsc_freq > 0, "TSC frequency must be nonzero");
 
 	/* First, check MSR-based clocksource */
 	r1 = rdtsc();
-	t1 = vcpu_get_msr(vm, VCPU_ID, HV_X64_MSR_TIME_REF_COUNT);
+	t1 = vcpu_get_msr(vcpu->vm, vcpu->id, HV_X64_MSR_TIME_REF_COUNT);
 	nop_loop();
 	r2 = rdtsc();
-	t2 = vcpu_get_msr(vm, VCPU_ID, HV_X64_MSR_TIME_REF_COUNT);
+	t2 = vcpu_get_msr(vcpu->vm, vcpu->id, HV_X64_MSR_TIME_REF_COUNT);
 
 	TEST_ASSERT(t2 > t1, "Time reference MSR is not monotonic (%ld <= %ld)", t1, t2);
 
@@ -203,33 +201,34 @@ static void host_check_tsc_msr_rdtsc(struct kvm_vm *vm)
 
 int main(void)
 {
+	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
 	struct kvm_run *run;
 	struct ucall uc;
 	vm_vaddr_t tsc_page_gva;
 	int stage;
 
-	vm = vm_create_default(VCPU_ID, 0, guest_main);
-	run = vcpu_state(vm, VCPU_ID);
+	vm = vm_create_with_one_vcpu(&vcpu, guest_main);
+	run = vcpu->run;
 
-	vcpu_set_hv_cpuid(vm, VCPU_ID);
+	vcpu_set_hv_cpuid(vm, vcpu->id);
 
 	tsc_page_gva = vm_vaddr_alloc_page(vm);
 	memset(addr_gva2hva(vm, tsc_page_gva), 0x0, getpagesize());
 	TEST_ASSERT((addr_gva2gpa(vm, tsc_page_gva) & (getpagesize() - 1)) == 0,
 		"TSC page has to be page aligned\n");
-	vcpu_args_set(vm, VCPU_ID, 2, tsc_page_gva, addr_gva2gpa(vm, tsc_page_gva));
+	vcpu_args_set(vm, vcpu->id, 2, tsc_page_gva, addr_gva2gpa(vm, tsc_page_gva));
 
-	host_check_tsc_msr_rdtsc(vm);
+	host_check_tsc_msr_rdtsc(vcpu);
 
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
-- 
2.35.1.723.g4982287a31-goog


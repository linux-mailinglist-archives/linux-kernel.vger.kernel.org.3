Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDB424D5B04
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347081AbiCKF6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 00:58:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346630AbiCKFxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:53:51 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B84C464FD
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:52:39 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id d4-20020a170902f14400b001518350e5c7so4001626plb.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=nJj229TRmV5L/s8dhQs+LqzdZ8PgCyr6F1iJqF+wT7c=;
        b=J/FNluQYD7eQse7hXITl1xID2UmuUj/0awu9XhdtJ4sWtrL0RAyMCwnqD7JAabkMNN
         teIpUMUqMzWChBNHEHg1LmtdM5ygOOoBD4vLZ9UpE7SwVbZfa5as6CEWCznXQejzXVfa
         SH9JDgxVQxQDZEv/4D4+vf/xNhtDi0athdoANfT4s0L5H9eXMbY/7zbu2jQR7etAo1eF
         DIzYAHjQnWyUaJ1FLUEj+Mpmu874wzsPt2KOv+xRB3F5JFIvi3xoCS9fiLTQ+BIu+R1k
         Za/81HX3fwOfBFpY/ZqTQ3gs10wsppltniuzlZ5uBCXajjEcLKYAoSId9paM/9eAhld/
         qkgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=nJj229TRmV5L/s8dhQs+LqzdZ8PgCyr6F1iJqF+wT7c=;
        b=rAl7FG7/GWz8/INU77tvR9gdq/QSLuyvBUI7Y7zAr2AfyUg9K+IcOko49HxU5rvZ0M
         zrPvle0erU6SQiYWSokyHfEKV5BqZXkeOG8HknNi5bxc8zLvgdEbKwTyql2bSkQOle4i
         3XXYcEIcpWR5cbvBqmd/MlOuii2eh+qDfHAr+oGvCpvF7KRNz+ce59/t7XRKlJN056hb
         +oRfIe92Y1i+ix6UP5dKqXauR1RtQ53Jkp2yA1GhgG9TJjaUNbI7WpDWk+c3nx5ldnzf
         evfgJ6+6LxKlqyR22WF7Y/drITopQAg/BzHejnC/p0HBLkCTHyTSjFArCE1cRnRf5kS4
         mYcg==
X-Gm-Message-State: AOAM530aIoK58N0M9kUSwX4zxCl0kt/bWgJQGNjaqqgHd8joz5sSTMdL
        QHNvaTTOUyv9mOsTkbRnRH0FGG4/SNvmxrc5ITB63K36Gz/eeRlx7Hkpx4137tpoQChtQ2F1QAH
        QT9Am1EOqIC6Z8Aslr/3eqzeTgpetwUueMwpVWOY3gHQ5Dc6CqSubYIMmblb8s/cg6+CaEA==
X-Google-Smtp-Source: ABdhPJx5gPw/d/bfoVNtbpOhROhFl4Bk6R5lHqqx80S/bN382ebnmrhAK79o4crBaZTskfN0KU84ZpMThTY=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:902:f643:b0:14d:7b8f:14b3 with SMTP id
 m3-20020a170902f64300b0014d7b8f14b3mr8665364plg.19.1646977958666; Thu, 10 Mar
 2022 21:52:38 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:50:06 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-56-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 055/105] KVM: selftests: Convert tsc_msrs_test away from VCPU_ID
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
 .../selftests/kvm/x86_64/tsc_msrs_test.c      | 35 +++++++++----------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/tsc_msrs_test.c b/tools/testing/selftests/kvm/x86_64/tsc_msrs_test.c
index a426078b16a3..3b7bf660eced 100644
--- a/tools/testing/selftests/kvm/x86_64/tsc_msrs_test.c
+++ b/tools/testing/selftests/kvm/x86_64/tsc_msrs_test.c
@@ -9,14 +9,12 @@
 #include "kvm_util.h"
 #include "processor.h"
 
-#define VCPU_ID 0
-
 #define UNITY                  (1ull << 30)
 #define HOST_ADJUST            (UNITY * 64)
 #define GUEST_STEP             (UNITY * 4)
 #define ROUND(x)               ((x + UNITY / 2) & -UNITY)
 #define rounded_rdmsr(x)       ROUND(rdmsr(x))
-#define rounded_host_rdmsr(x)  ROUND(vcpu_get_msr(vm, 0, x))
+#define rounded_host_rdmsr(x)  ROUND(vcpu_get_msr(vm, vcpu->id, x))
 
 static void guest_code(void)
 {
@@ -66,15 +64,13 @@ static void guest_code(void)
 	GUEST_DONE();
 }
 
-static void run_vcpu(struct kvm_vm *vm, uint32_t vcpuid, int stage)
+static void run_vcpu(struct kvm_vcpu *vcpu, int stage)
 {
 	struct ucall uc;
 
-	vcpu_args_set(vm, vcpuid, 1, vcpuid);
+	vcpu_run(vcpu->vm, vcpu->id);
 
-	vcpu_ioctl(vm, vcpuid, KVM_RUN, NULL);
-
-	switch (get_ucall(vm, vcpuid, &uc)) {
+	switch (get_ucall(vcpu->vm, vcpu->id, &uc)) {
 	case UCALL_SYNC:
 		TEST_ASSERT(!strcmp((const char *)uc.args[0], "hello") &&
 			    uc.args[1] == stage + 1, "Stage %d: Unexpected register values vmexit, got %lx",
@@ -88,29 +84,30 @@ static void run_vcpu(struct kvm_vm *vm, uint32_t vcpuid, int stage)
 			    __FILE__, uc.args[1], uc.args[2], uc.args[3]);
 	default:
 		TEST_ASSERT(false, "Unexpected exit: %s",
-			    exit_reason_str(vcpu_state(vm, vcpuid)->exit_reason));
+			    exit_reason_str(vcpu->run->exit_reason));
 	}
 }
 
 int main(void)
 {
+	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
 	uint64_t val;
 
-	vm = vm_create_default(VCPU_ID, 0, guest_code);
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
 
 	val = 0;
 	ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC), val);
 	ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC_ADJUST), val);
 
 	/* Guest: writes to MSR_IA32_TSC affect both MSRs.  */
-	run_vcpu(vm, VCPU_ID, 1);
+	run_vcpu(vcpu, 1);
 	val = 1ull * GUEST_STEP;
 	ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC), val);
 	ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC_ADJUST), val);
 
 	/* Guest: writes to MSR_IA32_TSC_ADJUST affect both MSRs.  */
-	run_vcpu(vm, VCPU_ID, 2);
+	run_vcpu(vcpu, 2);
 	val = 2ull * GUEST_STEP;
 	ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC), val);
 	ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC_ADJUST), val);
@@ -119,18 +116,18 @@ int main(void)
 	 * Host: writes to MSR_IA32_TSC set the host-side offset
 	 * and therefore do not change MSR_IA32_TSC_ADJUST.
 	 */
-	vcpu_set_msr(vm, 0, MSR_IA32_TSC, HOST_ADJUST + val);
+	vcpu_set_msr(vm, vcpu->id, MSR_IA32_TSC, HOST_ADJUST + val);
 	ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC), HOST_ADJUST + val);
 	ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC_ADJUST), val);
-	run_vcpu(vm, VCPU_ID, 3);
+	run_vcpu(vcpu, 3);
 
 	/* Host: writes to MSR_IA32_TSC_ADJUST do not modify the TSC.  */
-	vcpu_set_msr(vm, 0, MSR_IA32_TSC_ADJUST, UNITY * 123456);
+	vcpu_set_msr(vm, vcpu->id, MSR_IA32_TSC_ADJUST, UNITY * 123456);
 	ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC), HOST_ADJUST + val);
-	ASSERT_EQ(vcpu_get_msr(vm, 0, MSR_IA32_TSC_ADJUST), UNITY * 123456);
+	ASSERT_EQ(vcpu_get_msr(vm, vcpu->id, MSR_IA32_TSC_ADJUST), UNITY * 123456);
 
 	/* Restore previous value.  */
-	vcpu_set_msr(vm, 0, MSR_IA32_TSC_ADJUST, val);
+	vcpu_set_msr(vm, vcpu->id, MSR_IA32_TSC_ADJUST, val);
 	ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC), HOST_ADJUST + val);
 	ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC_ADJUST), val);
 
@@ -138,7 +135,7 @@ int main(void)
 	 * Guest: writes to MSR_IA32_TSC_ADJUST do not destroy the
 	 * host-side offset and affect both MSRs.
 	 */
-	run_vcpu(vm, VCPU_ID, 4);
+	run_vcpu(vcpu, 4);
 	val = 3ull * GUEST_STEP;
 	ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC), HOST_ADJUST + val);
 	ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC_ADJUST), val);
@@ -147,7 +144,7 @@ int main(void)
 	 * Guest: writes to MSR_IA32_TSC affect both MSRs, so the host-side
 	 * offset is now visible in MSR_IA32_TSC_ADJUST.
 	 */
-	run_vcpu(vm, VCPU_ID, 5);
+	run_vcpu(vcpu, 5);
 	val = 4ull * GUEST_STEP;
 	ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC), val);
 	ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC_ADJUST), val - HOST_ADJUST);
-- 
2.35.1.723.g4982287a31-goog


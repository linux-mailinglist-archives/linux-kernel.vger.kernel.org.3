Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A16E4D5B11
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347660AbiCKF7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 00:59:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346675AbiCKFyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:54:01 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17DEB4CD49
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:52:56 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id 9-20020a630509000000b0037c8607d296so4214914pgf.22
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=ps9uAAiwAcVTTH/yb1s5LSlXQ12+IJIbxw2+bvSNcUM=;
        b=oz4L0QnTrNVJLa/7xFrob+aTe6eCQjRBTc3fqhtXYWr2VOUFGT5f3rK+zYSuPzvB3S
         tVeEYA5Dbcx/mbUZD7BueJNjjLadap/nq2vQI/YSBN0RP+Vb3dCDGros7V7S0udvShNq
         Nnvnf43ZBppoTQw3J5HVLmAz0G+ABDQoSpFPolivqN61j2io7uo0dpAi+k+Kn7xN9eUB
         sJDOVI9n5UW09u7wMo3lenO6CBHEMd91CDYHTTUOsLMqWgQTunjpnxc2hgjEj+Nps97x
         phYMyxjvBqLDa/U2rQ3w0+KZiIezbrmwGfQDMTM0h9/tGvZuVdBZ+oiXU3ca//st+yoH
         MjBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=ps9uAAiwAcVTTH/yb1s5LSlXQ12+IJIbxw2+bvSNcUM=;
        b=u1WKtL6kJM+Vl+H4Dkq+q7QV+AE72FubIidxEPAp5alFNTheJy+cQkPLy0xSOo/eOH
         0KOyb0G9CvVxFABRSemyEJfwtWvDo6aL9XJ8lj9uR3wBXPk/ddqqRXUC7C2khYP9WVkp
         fFLho9ttMsLpxklDMFVyQATueOIJeFVJiewn3j2AwzadWpKcHBm8YlZaMfnJa8r8kwg5
         QtUvr2YyQpaOYPS1bdnOMkXlC+AocNIC3EWjzUM5FL1RLBkq2RcCm3GCyEpGzh6kd4P4
         Q6H2iXkw4cgr0lDRSia1IaAbQmtRir2CuyCuN+9bp6I/1m1H5o2BLy/9F6k9d/U8htnQ
         TEag==
X-Gm-Message-State: AOAM530ilZuYclmBUMixKxcv8zswAKjSOF78i6HpQqhLmSaIJ1J8E3CV
        5ulhCl3N/wErt4pfFCAe5tqhUi9vDHKQsmIXfTtzUgpGQj+Oc/STIueFlqIAxgCG+gPMvdaCJH0
        RRJGgzbCJhETxIXLj0vFmknXcFSAlWBaBITei0SwBJoX0Ko4SRSz+fgPhs7Nky3Q7gKBDAQ==
X-Google-Smtp-Source: ABdhPJwSGlZHI+t/zrF/jeaWCb8h9SZnqc1mxWXnNYt+DArsN3L265yB76K4OZd+GRa6bx+5O9kzNVVP32w=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90b:4d81:b0:1bf:8ce4:4f51 with SMTP id
 oj1-20020a17090b4d8100b001bf8ce44f51mr461584pjb.0.1646977975650; Thu, 10 Mar
 2022 21:52:55 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:50:16 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-66-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 065/105] KVM: selftests: Convert cr4_cpuid_sync_test away
 from VCPU_ID
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
 .../selftests/kvm/x86_64/cr4_cpuid_sync_test.c  | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/cr4_cpuid_sync_test.c b/tools/testing/selftests/kvm/x86_64/cr4_cpuid_sync_test.c
index 6f6fd189dda3..d5615cd0b81b 100644
--- a/tools/testing/selftests/kvm/x86_64/cr4_cpuid_sync_test.c
+++ b/tools/testing/selftests/kvm/x86_64/cr4_cpuid_sync_test.c
@@ -21,7 +21,6 @@
 
 #define X86_FEATURE_XSAVE	(1<<26)
 #define X86_FEATURE_OSXSAVE	(1<<27)
-#define VCPU_ID			1
 
 static inline bool cr4_cpuid_is_sync(void)
 {
@@ -63,12 +62,12 @@ static void guest_code(void)
 
 int main(int argc, char *argv[])
 {
+	struct kvm_vcpu *vcpu;
 	struct kvm_run *run;
 	struct kvm_vm *vm;
 	struct kvm_sregs sregs;
 	struct kvm_cpuid_entry2 *entry;
 	struct ucall uc;
-	int rc;
 
 	entry = kvm_get_supported_cpuid_entry(1);
 	if (!(entry->ecx & X86_FEATURE_XSAVE)) {
@@ -79,25 +78,23 @@ int main(int argc, char *argv[])
 	/* Tell stdout not to buffer its content */
 	setbuf(stdout, NULL);
 
-	/* Create VM */
-	vm = vm_create_default(VCPU_ID, 0, guest_code);
-	run = vcpu_state(vm, VCPU_ID);
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+	run = vcpu->run;
 
 	while (1) {
-		rc = _vcpu_run(vm, VCPU_ID);
+		vcpu_run(vm, vcpu->id);
 
-		TEST_ASSERT(rc == 0, "vcpu_run failed: %d\n", rc);
 		TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
 			    "Unexpected exit reason: %u (%s),\n",
 			    run->exit_reason,
 			    exit_reason_str(run->exit_reason));
 
-		switch (get_ucall(vm, VCPU_ID, &uc)) {
+		switch (get_ucall(vm, vcpu->id, &uc)) {
 		case UCALL_SYNC:
 			/* emulate hypervisor clearing CR4.OSXSAVE */
-			vcpu_sregs_get(vm, VCPU_ID, &sregs);
+			vcpu_sregs_get(vm, vcpu->id, &sregs);
 			sregs.cr4 &= ~X86_CR4_OSXSAVE;
-			vcpu_sregs_set(vm, VCPU_ID, &sregs);
+			vcpu_sregs_set(vm, vcpu->id, &sregs);
 			break;
 		case UCALL_ABORT:
 			TEST_FAIL("Guest CR4 bit (OSXSAVE) unsynchronized with CPUID bit.");
-- 
2.35.1.723.g4982287a31-goog


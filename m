Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6704D5B0E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347600AbiCKF67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 00:58:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346325AbiCKFx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:53:58 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4525133365
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:52:53 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id m22-20020a628c16000000b004f6f1b43114so4636155pfd.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=uj7mAABif4Ddq7lKfkCnuKGQskrveL83cSygqcTPo+k=;
        b=Op7LLtBAMNCU0RMvfN41LJyBMaXkfjyfp7KueQVqkA9yPKvSBHftgo7eTx7K9qL7zi
         ON9pQ6eBEbnFVonT/myDasV1FyqI9eLQLLGOATovuFVJkdGZGvx7UpGVoL/XTt27WKrY
         B+qGOuvb5r5Xqa2Vn4RfLrIMiqxJSiqh408Fhmrna6WAEf3cfEL3Lp4RTW1bg4FJSNBB
         yO9sreZ6kDsW70WGWdcXyvHaqhww9XgEcKJA2GlTUsPEnpSk308DdplTOlervi0iXn64
         6AAOxJhB0X8u3M57WkNDsc6kvXbD54H0FNBXNmB/B4puFCZnIJrrwdAJjGyr2AwlAAmC
         Pskg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=uj7mAABif4Ddq7lKfkCnuKGQskrveL83cSygqcTPo+k=;
        b=kfVCqDlVWICUwm0wt/jcQLVlM8UhlH+EhKYH9n3QThjDTLyIoxxdaHgBDAxdU5XtoG
         VVtsdr3OEDTwBjlCxgWbhd8NQTdIqfqAFSSD40cAuJSvAJBMqZA2gSGYJcYUOJ6ylXR3
         v8rsVl1ykhLnsDISNykjw5c3l6PiEiSq16Ubz9jD1aigNeQdFQMwGYMPhaVI4zTzLICs
         G//FlopmOOrqJTniX6/Tmm0Tda4NFcCLzzjjNn6XvPxqhAmCEmU5A4/29npQ+TZCQI0D
         rCP2LC99Oc700iur59iqFb4QRi+SHrVulneANDq716WnV4vOE2NmXx1pNHDKFjlTSSba
         Plqw==
X-Gm-Message-State: AOAM533ur4XiNyBGzHKtMNJ4+zoZNQYIedDbA8ozf0Btyrms3mB+TPIa
        y879s3okPBUoy/m22eRCAHlzQW8GXMB2YBo3mCCkRH0VbmCwC6mx8ITjmvoyh6EFulOpbPkAmBW
        uKsddvmUxEAAMVPctbGvL0tV+UpkTB73Jxnwe9i9lmxZ1FnigJu3YEHKMS+qsJ3wiI3lOwg==
X-Google-Smtp-Source: ABdhPJw3i5YMuAjcXxcAd2ain6eljOWqXL7G8Wtej+7wX9ZVUWL++AAQ8obxNd3wQd/C9r3fNBPXtvetzk8=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90b:4d81:b0:1bf:8ce4:4f51 with SMTP id
 oj1-20020a17090b4d8100b001bf8ce44f51mr461558pjb.0.1646977971971; Thu, 10 Mar
 2022 21:52:51 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:50:14 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-64-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 063/105] KVM: selftests: Add proper helper for advancing
 RIP in debug_regs
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
 .../testing/selftests/kvm/x86_64/debug_regs.c | 25 ++++++++++---------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/debug_regs.c b/tools/testing/selftests/kvm/x86_64/debug_regs.c
index b999c9753fc3..487d0ae3e75f 100644
--- a/tools/testing/selftests/kvm/x86_64/debug_regs.c
+++ b/tools/testing/selftests/kvm/x86_64/debug_regs.c
@@ -65,19 +65,21 @@ static void guest_code(void)
 }
 
 #define  CAST_TO_RIP(v)  ((unsigned long long)&(v))
-#define  SET_RIP(v)  do {				\
-		vcpu_regs_get(vm, vcpu->id, &regs);	\
-		regs.rip = (v);				\
-		vcpu_regs_set(vm, vcpu->id, &regs);	\
-	} while (0)
-#define  MOVE_RIP(v)  SET_RIP(regs.rip + (v));
+
+static void vcpu_skip_insn(struct kvm_vcpu *vcpu, int insn_len)
+{
+	struct kvm_regs regs;
+
+	vcpu_regs_get(vcpu->vm, vcpu->id, &regs);
+	regs.rip += insn_len;
+	vcpu_regs_set(vcpu->vm, vcpu->id, &regs);
+}
 
 int main(void)
 {
 	struct kvm_guest_debug debug;
 	unsigned long long target_dr6, target_rip;
 	struct kvm_vcpu *vcpu;
-	struct kvm_regs regs;
 	struct kvm_run *run;
 	struct kvm_vm *vm;
 	struct ucall uc;
@@ -112,7 +114,7 @@ int main(void)
 		    "INT3: exit %d exception %d rip 0x%llx (should be 0x%llx)",
 		    run->exit_reason, run->debug.arch.exception,
 		    run->debug.arch.pc, CAST_TO_RIP(sw_bp));
-	MOVE_RIP(1);
+	vcpu_skip_insn(vcpu, 1);
 
 	/* Test instruction HW BP over DR[0-3] */
 	for (i = 0; i < 4; i++) {
@@ -134,7 +136,7 @@ int main(void)
 			    run->debug.arch.dr6, target_dr6);
 	}
 	/* Skip "nop" */
-	MOVE_RIP(1);
+	vcpu_skip_insn(vcpu, 1);
 
 	/* Test data access HW BP over DR[0-3] */
 	for (i = 0; i < 4; i++) {
@@ -156,15 +158,14 @@ int main(void)
 			    run->debug.arch.pc, CAST_TO_RIP(write_data),
 			    run->debug.arch.dr6, target_dr6);
 		/* Rollback the 4-bytes "mov" */
-		MOVE_RIP(-7);
+		vcpu_skip_insn(vcpu, -7);
 	}
 	/* Skip the 4-bytes "mov" */
-	MOVE_RIP(7);
+	vcpu_skip_insn(vcpu, 7);
 
 	/* Test single step */
 	target_rip = CAST_TO_RIP(ss_start);
 	target_dr6 = 0xffff4ff0ULL;
-	vcpu_regs_get(vm, vcpu->id, &regs);
 	for (i = 0; i < (sizeof(ss_size) / sizeof(ss_size[0])); i++) {
 		target_rip += ss_size[i];
 		memset(&debug, 0, sizeof(debug));
-- 
2.35.1.723.g4982287a31-goog


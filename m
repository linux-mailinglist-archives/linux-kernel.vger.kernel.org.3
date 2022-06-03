Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC01D53C2DE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 04:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240460AbiFCA5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 20:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240208AbiFCAq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 20:46:56 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9774337A8D
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 17:46:06 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 84-20020a630057000000b003f9caa5bccfso3049786pga.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 17:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=XGQdyzi9kzr/j6zZemYm5PZbPdWatsUhvJos9j9hX5k=;
        b=X9aF4bXelhGzhsJMjQFoZO5KRi1aS4QxUCCyPr7GXBC7aZz9OjmPPYXCSotZRagCU9
         NZN7L3woWFocc/xUlvdnBRBStFfWz3Iu2muzO1driy6F2e81s+2WzlSlqm8kelXFH4oX
         Os92Srumm/l28JDyb6Ex3k8wlbAaKeOLfm6Te+rp9SyszKEX413cy/jaNidFOnxz9HC4
         89x9CdA7INqIWvlki/WAbakjITB5B0Drz5tZrkU0WPFye1aB2JG81x9/5ychKTQsLZND
         Iy/5XFKdaCifYIzeq4V2j5+7w6OUanIPkwea/ciHlndoDO7H488m2GcyNaa4FOtOrni3
         Wk/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=XGQdyzi9kzr/j6zZemYm5PZbPdWatsUhvJos9j9hX5k=;
        b=29nthsA+wSR/bRIvJwyO5dsHn2baayey3VsHydnvv3PqaTe1Ya5Xr6bUYZhZlEdwfB
         M72Lj5z6vca5b80tUXoPiLynZhTGR3u8JxMAykuue7cmQ1Uc/bXQlF6pMZ/bVHgQvKBg
         aCRDHWaczQgkJdt7st5rIeNtWVFrvlUtbDdEnABj67BwdDf4tNemNb2j9puEaeStETBD
         7Ar5Nr3DLA1t21IIsF4fn+GqgVJXDf2gZr77jjIU12tLO8gX+BYLjhgINWVW2lJdKPyS
         Ft8UqyPyKx9hSZIb+VoUJu1WfZpAmwWehI/LMmY+7qwp6CNBkUNoV9/64i+FVo8AGZt/
         MiwQ==
X-Gm-Message-State: AOAM532tTuNXgKbQeu2nX6TzajMh08OQSiYB+vQcPkPuEy08nW9dNlSZ
        nJyHf8yq4bu2tsEDeU3vtS1YVKKk9Xg=
X-Google-Smtp-Source: ABdhPJyCtfTZ7aN5CI76CIku4tCpZzaA9e1CzwTIf5o/S4qmojbkmAo18ZsVsTc+6fcTb23tGw+/okjSQe0=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:902:f815:b0:163:c524:e475 with SMTP id
 ix21-20020a170902f81500b00163c524e475mr7678153plb.37.1654217166264; Thu, 02
 Jun 2022 17:46:06 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  3 Jun 2022 00:42:29 +0000
In-Reply-To: <20220603004331.1523888-1-seanjc@google.com>
Message-Id: <20220603004331.1523888-83-seanjc@google.com>
Mime-Version: 1.0
References: <20220603004331.1523888-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH v2 082/144] KVM: selftests: Add proper helper for advancing
 RIP in debug_regs
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>,
        Oliver Upton <oupton@google.com>, linux-kernel@vger.kernel.org
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

Replace MOVE_RIP+SET_RIP with a proper helper, vcpu_skip_insn(), that is
more descriptive, doesn't subtly access local variables, and provides
type safety.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../testing/selftests/kvm/x86_64/debug_regs.c | 25 ++++++++++---------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/debug_regs.c b/tools/testing/selftests/kvm/x86_64/debug_regs.c
index 182d71c6d13a..3cc25714d703 100644
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
2.36.1.255.ge46751e96f-goog


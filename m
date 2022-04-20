Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F945509251
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 23:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382658AbiDTVtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 17:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234964AbiDTVtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 17:49:12 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C188E2E085
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 14:46:25 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id o188-20020a2541c5000000b0064334935847so2636300yba.16
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 14:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=GgvZp34BK6H0FUXR9EOtBK1V9jyG5177uTq39S22sfQ=;
        b=YLibaJIUGmaDvUVjiLNeo/1HlTfI3zS6LHvsGnOZ7nQlc63ry+7w9kNdZS98Nsg0dI
         UcuRAZtkNAF9gMWQ+7tEnCk9peOHo4HZMgSZOrFmUISzJr6HtkRl9Hc5VqsyLk/Gzkqg
         GaZHzBEkf/e0IzSd1EIp3E3UsHgYiiDnynGn0Vqr4Hzuz9/delgTV+agJj7ICCbs6/Dc
         LDf+9rDXMww0jVi9aLG5NMpwWfYcVTW6WVT8VQBUoyRDgiHtiqLO3fv6vWCtCxFJAyV1
         xH57L111n1Gktk4VQNMV+qWaWEZaWoDAMmh5EdnCzNbAP96SgdXMwIvjMO87ui+g4cpy
         TuJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=GgvZp34BK6H0FUXR9EOtBK1V9jyG5177uTq39S22sfQ=;
        b=mJWXIHXl+BshpSkKKAE3044OXUittZcY6i0Wxo3JJ4mcVXLuZ/Yrpjn4Hz8cEKHhwq
         3HXApJOyPmaEfci59UlV8q3Z6qE/27Vj4oFJjwtMC72NDlR30o/OTEsqdjr/v7LbaC+a
         ZlxssfqRmEWVmww9A5VlE82xcpgx5vNpD3lGUsNl9JTaiUt7IUlR7DVteGGBx/9uNtD/
         CYz1J8OyRda9PVq4ZnbRdgZnzKri2q2+68aAw6ZBfsNg5Zwv4SjdmlwFzujFedZ1Ji8L
         dnaReIt3n08CaXSaQkBymx22Ck1I5j73eNXI73oioWACekqCnk91w1RcOGfjMjdVkbGt
         kIlA==
X-Gm-Message-State: AOAM531ZRrr5rgOt2SDBDBimmZTrcHW+v6esHe0wPo9GDMnt14Mgn1el
        cX1Y3HfCpu2vIDQnPkfWlIA9W8k3FbiyLn8iBA==
X-Google-Smtp-Source: ABdhPJyppryoKr9oaIT1p1DVqRzVQjMH2bfnVLMwG49QsDwJMJtZjut11ZY+ct0kOHIySH/Adr7CF8CWrpG88gIeBg==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:2a20:cec4:8f41:cd6f])
 (user=kaleshsingh job=sendgmr) by 2002:a05:6902:114c:b0:644:cada:4ee7 with
 SMTP id p12-20020a056902114c00b00644cada4ee7mr20521440ybu.217.1650491184989;
 Wed, 20 Apr 2022 14:46:24 -0700 (PDT)
Date:   Wed, 20 Apr 2022 14:42:56 -0700
In-Reply-To: <20220420214317.3303360-1-kaleshsingh@google.com>
Message-Id: <20220420214317.3303360-6-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220420214317.3303360-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
Subject: [PATCH v8 5/6] KVM: arm64: Detect and handle hypervisor stack overflows
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     will@kernel.org, maz@kernel.org, qperret@google.com,
        tabba@google.com, surenb@google.com, kernel-team@android.com,
        Kalesh Singh <kaleshsingh@google.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Walbran <qwandor@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Jones <drjones@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Changbin Du <changbin.du@intel.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hypervisor stacks (for both nVHE Hyp mode and nVHE protected mode)
are aligned such  that any valid stack address has PAGE_SHIFT bit as 1.
This allows us to conveniently check for overflow in the exception entry
without corrupting any GPRs. We won't recover from a stack overflow so
panic the hypervisor.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
Tested-by: Fuad Tabba <tabba@google.com>
Reviewed-by: Fuad Tabba <tabba@google.com>
---

Changes in v8:
  - branch to hyp_panic_bad_stack(), instead of branch and link, per Marc

Changes in v7:
  - Add Fuad's Reviewed-by and Tested-by tags.

Changes in v5:
  - Valid stack addresses now have PAGE_SHIFT bit as 1 instead of 0

Changes in v3:
  - Remove test_sp_overflow macro, per Mark
  - Add asmlinkage attribute for hyp_panic, hyp_panic_bad_stack, per Ard


 arch/arm64/kvm/hyp/nvhe/host.S   | 24 ++++++++++++++++++++++++
 arch/arm64/kvm/hyp/nvhe/switch.c |  7 ++++++-
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/host.S b/arch/arm64/kvm/hyp/nvhe/host.S
index 3d613e721a75..09b5254fb497 100644
--- a/arch/arm64/kvm/hyp/nvhe/host.S
+++ b/arch/arm64/kvm/hyp/nvhe/host.S
@@ -153,6 +153,18 @@ SYM_FUNC_END(__host_hvc)
 
 .macro invalid_host_el2_vect
 	.align 7
+
+	/*
+	 * Test whether the SP has overflowed, without corrupting a GPR.
+	 * nVHE hypervisor stacks are aligned so that the PAGE_SHIFT bit
+	 * of SP should always be 1.
+	 */
+	add	sp, sp, x0			// sp' = sp + x0
+	sub	x0, sp, x0			// x0' = sp' - x0 = (sp + x0) - x0 = sp
+	tbz	x0, #PAGE_SHIFT, .L__hyp_sp_overflow\@
+	sub	x0, sp, x0			// x0'' = sp' - x0' = (sp + x0) - sp = x0
+	sub	sp, sp, x0			// sp'' = sp' - x0 = (sp + x0) - x0 = sp
+
 	/* If a guest is loaded, panic out of it. */
 	stp	x0, x1, [sp, #-16]!
 	get_loaded_vcpu x0, x1
@@ -165,6 +177,18 @@ SYM_FUNC_END(__host_hvc)
 	 * been partially clobbered by __host_enter.
 	 */
 	b	hyp_panic
+
+.L__hyp_sp_overflow\@:
+	/*
+	 * Reset SP to the top of the stack, to allow handling the hyp_panic.
+	 * This corrupts the stack but is ok, since we won't be attempting
+	 * any unwinding here.
+	 */
+	ldr_this_cpu	x0, kvm_init_params + NVHE_INIT_STACK_HYP_VA, x1
+	mov	sp, x0
+
+	b	hyp_panic_bad_stack
+	ASM_BUG()
 .endm
 
 .macro invalid_host_el1_vect
diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
index 6410d21d8695..703a5d3f611b 100644
--- a/arch/arm64/kvm/hyp/nvhe/switch.c
+++ b/arch/arm64/kvm/hyp/nvhe/switch.c
@@ -347,7 +347,7 @@ int __kvm_vcpu_run(struct kvm_vcpu *vcpu)
 	return exit_code;
 }
 
-void __noreturn hyp_panic(void)
+asmlinkage void __noreturn hyp_panic(void)
 {
 	u64 spsr = read_sysreg_el2(SYS_SPSR);
 	u64 elr = read_sysreg_el2(SYS_ELR);
@@ -369,6 +369,11 @@ void __noreturn hyp_panic(void)
 	unreachable();
 }
 
+asmlinkage void __noreturn hyp_panic_bad_stack(void)
+{
+	hyp_panic();
+}
+
 asmlinkage void kvm_unexpected_el2_exception(void)
 {
 	return __kvm_unexpected_el2_exception();
-- 
2.36.0.rc0.470.gd361397f0d-goog


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C43B4C2350
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 06:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiBXFUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 00:20:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiBXFUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 00:20:49 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B16E17F69F
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 21:20:20 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id a19-20020a25ca13000000b0061db44646b3so943722ybg.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 21:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=H4Z1lUqUeabFhmJD3t8xVbX28HOrFIYN1Agzn114BGo=;
        b=LsQ97pcohFsj9RlBvIOR/HjRRTmpxuoxoVutPu6Mz8f8Qc8IiLUdOvgGwYWo6PkPqP
         edGd3S6spZfR1eG7lKcxxDMoY93t5dZyarnvaxqB/e8uaJHBjjHxpPojSAfvmbE5SA+q
         yH5/xwTQQ1ApMBlT4llh7MhcqVVpsUfgYdJ1iKJ6oqJz2HRvD5USeQ38eCXddXx5ogBv
         kE/jZINSl2wgXKpy0cIapbKMmmLn1hDj7jvYWPvUDNUUSNXkYBs9l0teLhdyiRhTAVOk
         Py2ZxE/qmDVu81csLNOLFCwMGUyw/uXDQMhoEajwvjW82rbKO4U8DeRxLYT0WkngZ4FK
         0i+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=H4Z1lUqUeabFhmJD3t8xVbX28HOrFIYN1Agzn114BGo=;
        b=Kk836Pr9nDrMk4CN2Z3UgJrVd2wzbzybrrox53ot+RklZHRUsk4YkYOKFj3MO8BqwM
         7aNR3j0TBZn1OaA2sre/ndUuxU2GIuVW476AvTEibl2yjhjv8YvojVPTBSLLpBjK0DB4
         d9jIbfx4FMaJPH8UCvjSLFmrxzJyeyGKbiE0ZrbMIF1Jro0423n4yhVnFn7hFnXUu21x
         INM+RMKGREgDxb/AFI1Mec880fmUQr0vSjMBJ2DHdgqswB9HN7MIWKEmBiW7w1ML84pA
         UTdjOi0L9zXW1sq1mWLkxS1cS5gGaBXYcSF8dL2u6Bhr2EfzG9VA1YrWj1aUt+nxc3qw
         s+Yg==
X-Gm-Message-State: AOAM530L78e8wAKpBP4x7knh3fix42+atMdVb+q3NtFzQhlA84QnuXb1
        sWHbQ8xO82bIizb+F+jbqnFrPIZ/SMNuKfSlpQ==
X-Google-Smtp-Source: ABdhPJz5Qiz49suSJpWhdDGBZ/Par4c6tTpWzRj6zIuxEJHxtLIJ4WzGG0ZrNy9JUdjCvZK71gx48FILjtMxJXC9CQ==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:415c:9be0:c461:440a])
 (user=kaleshsingh job=sendgmr) by 2002:a25:374d:0:b0:611:a6c1:b948 with SMTP
 id e74-20020a25374d000000b00611a6c1b948mr1007735yba.21.1645680019488; Wed, 23
 Feb 2022 21:20:19 -0800 (PST)
Date:   Wed, 23 Feb 2022 21:13:40 -0800
In-Reply-To: <20220224051439.640768-1-kaleshsingh@google.com>
Message-Id: <20220224051439.640768-6-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220224051439.640768-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed-goog
Subject: [PATCH v3 5/8] KVM: arm64: Detect and handle hypervisor stack overflows
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     will@kernel.org, maz@kernel.org, qperret@google.com,
        tabba@google.com, surenb@google.com, kernel-team@android.com,
        Kalesh Singh <kaleshsingh@google.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>,
        Andrew Walbran <qwandor@google.com>,
        Andrew Scull <ascull@google.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hypervisor stacks (for both nVHE Hyp mode and nVHE protected mode)
are aligned to twice their size (PAGE_SIZE), meaning that any valid stack
address has PAGE_SHIFT bit as 0. This allows us to conveniently check for
overflow in the exception entry without corrupting any GPRs. We won't
recover from a stack overflow so panic the hypervisor.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---

Changes in v3:
  - Remove test_sp_overflow macro, per Mark
  - Add asmlinkage attribute for hyp_panic, hyp_panic_bad_stack, per Ard

 arch/arm64/kvm/hyp/nvhe/host.S   | 24 ++++++++++++++++++++++++
 arch/arm64/kvm/hyp/nvhe/switch.c |  7 ++++++-
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/host.S b/arch/arm64/kvm/hyp/nvhe/host.S
index 3d613e721a75..749961bfa5ba 100644
--- a/arch/arm64/kvm/hyp/nvhe/host.S
+++ b/arch/arm64/kvm/hyp/nvhe/host.S
@@ -153,6 +153,18 @@ SYM_FUNC_END(__host_hvc)
 
 .macro invalid_host_el2_vect
 	.align 7
+
+	/*
+	 * Test whether the SP has overflowed, without corrupting a GPR.
+	 * nVHE hypervisor stacks are aligned so that SP & (1 << PAGE_SHIFT)
+	 * should always be zero.
+	 */
+	add	sp, sp, x0			// sp' = sp + x0
+	sub	x0, sp, x0			// x0' = sp' - x0 = (sp + x0) - x0 = sp
+	tbnz	x0, #PAGE_SHIFT, .L__hyp_sp_overflow\@
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
+	bl	hyp_panic_bad_stack
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
2.35.1.473.g83b2b277ed-goog


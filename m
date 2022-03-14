Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 806DE4D8DBF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 21:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244891AbiCNUGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 16:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244887AbiCNUGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 16:06:23 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB4C3FD84
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 13:05:13 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id g2-20020a5b0242000000b0062892750241so14779682ybp.23
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 13:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=6AJr5ee6eL/k85TbDtFKJ/Olir+hxbCOMzelCH/e6LI=;
        b=DbOLudXnBJV5WO3zhARrfN9GjpNNvscKjdv6Rrb8oyyeDVG6ym1PavfRRn0cQJZ30D
         +dFqE5+GylXb9B4WnXVx3fW2AATv8Ys88byJ+NHvH9967pm3jvonAL9PQ+5KIMYGIyWp
         iahue+tdX54Tb5cmZFWMlyT82Y2P+DzxdagH7gCkcNuWgReaLtuoow7tNlycZEfv41j0
         Z3MuulV5hZJ6TR8aWwWD95mixAsJjU2HvKK721BkNiM0xuUVzaKJz5nHxIYba3/1tyZF
         1ffE2x9gcqNJWFC4HieFmTCSuPIQPSl70MU+91mCcGGQ94la0DsGNiOYSyr1nMfBIRI3
         pk2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=6AJr5ee6eL/k85TbDtFKJ/Olir+hxbCOMzelCH/e6LI=;
        b=dkoCoHdPEARPZvq52IcqAnl2y+nNu9R1CzQu1CmzMQHEeV4KLx/IbKsRWmdJqSwkFS
         B148RTgG+0rGXmNlzMSOOmdDmEA7ifB3o8uiueGJCg+80cxRb25tv+zhMlr6Y9DycJRB
         +/vs9rDXiDFDQELHbAGODtsDGITmDJh2SpSrYE2Z+yFJYBtxf4PBQCRmLyNdJxomhJaf
         xmfFZYkq1952QU5epf3rsNzPE5uDGNHWlcqfKQNYU35OL3NhhRe7G06Jdh+NsW34K1Um
         6tQ8fEiFfirM72ilna1iOQg7+xEKgotEDoFD60eNBZVVXyJn5i+weUXYgmTx6A441ke4
         aZ8g==
X-Gm-Message-State: AOAM5323RAEjqo2XnThcGowRKIhcm/321DpPBnLpPNmcyD72Zg71r83S
        Y2sCMQep/A9BbhKUG9I1GbHVb+/ILayMXcmCFw==
X-Google-Smtp-Source: ABdhPJw1XRCjbhTUYB79h5/vjUMks+3FK7y+nHEPTRAsppIX6ownwysU3XOcH6qXpY0ENzmCluQyvA8Bf+JBhORZGw==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:500a:9ac2:e73e:69e3])
 (user=kaleshsingh job=sendgmr) by 2002:a25:764b:0:b0:628:6e65:1880 with SMTP
 id r72-20020a25764b000000b006286e651880mr19903957ybc.264.1647288312731; Mon,
 14 Mar 2022 13:05:12 -0700 (PDT)
Date:   Mon, 14 Mar 2022 13:01:14 -0700
In-Reply-To: <20220314200148.2695206-1-kaleshsingh@google.com>
Message-Id: <20220314200148.2695206-6-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220314200148.2695206-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [PATCH v6 5/8] KVM: arm64: Detect and handle hypervisor stack overflows
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
are aligned such  that any valid stack address has PAGE_SHIFT bit as 1.
This allows us to conveniently check for overflow in the exception entry
without corrupting any GPRs. We won't recover from a stack overflow so
panic the hypervisor.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---

Changes in v5:
  - Valid stack addresses now have PAGE_SHIFT bit as 1 instead of 0

Changes in v3:
  - Remove test_sp_overflow macro, per Mark
  - Add asmlinkage attribute for hyp_panic, hyp_panic_bad_stack, per Ard


 arch/arm64/kvm/hyp/nvhe/host.S   | 24 ++++++++++++++++++++++++
 arch/arm64/kvm/hyp/nvhe/switch.c |  7 ++++++-
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/host.S b/arch/arm64/kvm/hyp/nvhe/host.S
index 3d613e721a75..be6d844279b1 100644
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
2.35.1.723.g4982287a31-goog


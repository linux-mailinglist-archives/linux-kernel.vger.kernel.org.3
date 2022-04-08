Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01DD84F9DFB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 22:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239375AbiDHUIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 16:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232637AbiDHUI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 16:08:26 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A23350498
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 13:06:21 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id b16-20020a253410000000b006410e827132so1589251yba.23
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 13:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=x93NDMtIcx2idQMr+unDlcAPSW8WF5PhRWgttKX+iKU=;
        b=lkbCS6nMzD5l/NcfUbqdzOcFcXYuIbONUYKihkgTAKdwgS6qEgzrB//n/sVPVjQVBN
         4TuMybTXOq6SdpwsF6dxtvqZOYY7VvHb9RTVpMl14NmmXLDuS9Dy8/EpGpgazblTzo5Z
         iQ+S2yTm9lt6slO4knFUusXLB7ckzd1OY/0OGn5uGk9NNTCRe156PiP5ijiUOlzaZ5hQ
         nyY+d8/52jbYZdGa6mc7lFI2yrIVD7FeRIerU6SyqoC6BJPdBNgLEHi8rjdHRnAaOGfD
         LGxR5ljbg2jbzimVVHo0ksIW0CZd/TUsw3MA82vloWJI8+3bX3PFOJFnr0lYDtKXywhm
         Horg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=x93NDMtIcx2idQMr+unDlcAPSW8WF5PhRWgttKX+iKU=;
        b=XM9JfeXVyR/6mXm9KEHMohUWViG9FWkT9EqlnHTzRntp2kXzmY7A7qL9XPtk5rxD5Q
         xRLjt4dJ/O+UGWsVOYFItrevZk5vFpL4guoCQL1gdhfvpoiUADZeXtGfySZjrSQx7X6C
         sp1xIc+arskw8Cmg3rE6Dbh2RGhZ9RFlY/IpSjRxRw/Uz95TbpOCTtfqe8zmoeaAU5I7
         C9QlBp2ITZCPDtJ0cSsHC0oXQt98AxWm3uql9ikOcOrLP7cU0f3BXB5ufzq8VEMJqjEc
         U+cCQ+XxVxVcd2q9a5FJ0lTt+dLLamdfEDZk3nBdYLN8TZMfejOhiBEG0Io0HK5hrxTZ
         T5MQ==
X-Gm-Message-State: AOAM530+rfbMj55EXcAuyAjNi9VFSa6zn1P6NQy4FDSYz0bNALKwuRsd
        PhhwNpk27D6Zps1T875vsbg6rQwBpSasRgskOQ==
X-Google-Smtp-Source: ABdhPJznbHjSSh4+bEaUognEJWHkByuTOiqR2U6CXPMcOP7Ibq65oUjuo1XwZfsOSWyX8z1IEKsec19wpvjz1Bp34A==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:f0ed:c8a:dab7:ecc2])
 (user=kaleshsingh job=sendgmr) by 2002:a5b:982:0:b0:63e:7d7e:e2f2 with SMTP
 id c2-20020a5b0982000000b0063e7d7ee2f2mr5160129ybq.549.1649448380890; Fri, 08
 Apr 2022 13:06:20 -0700 (PDT)
Date:   Fri,  8 Apr 2022 13:03:28 -0700
In-Reply-To: <20220408200349.1529080-1-kaleshsingh@google.com>
Message-Id: <20220408200349.1529080-6-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220408200349.1529080-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
Subject: [PATCH v7 5/6] KVM: arm64: Detect and handle hypervisor stack overflows
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
        Ard Biesheuvel <ardb@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Andrew Jones <drjones@redhat.com>,
        Changbin Du <changbin.du@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
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
Tested-by: Fuad Tabba <tabba@google.com>
Reviewed-by: Fuad Tabba <tabba@google.com>
---

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
2.35.1.1178.g4f1659d476-goog


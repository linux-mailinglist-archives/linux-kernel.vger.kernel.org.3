Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 189F54B18BC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 23:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345196AbiBJWp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 17:45:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244889AbiBJWpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 17:45:25 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F8D2737
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 14:45:25 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id b64-20020a256743000000b0061e169a5f19so14656527ybc.11
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 14:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=OagLRmMmzyQmGqXHU8QCfKrH7+tgm0iC+teioaMlxY8=;
        b=KZUDFgua6kTwrdY0rgWjsvVP3R/Era680jCgYQwjuK0iUjxXTEGhr1k5AU4ecCZI8w
         lGlhfM50n/PyOfFuEnRyrza/dCfR09l2qnRTramuth4IQ5kSJWx8IHEXrR6WGw+YWDLS
         Fcw37pMtSTu7lmTbNbpjWo/86asLiZ0qeY3n5xM9TuAmWeZiYQybxooNBeFcYXyFXw0+
         nw3MMrt2SnLYQkB9BXZaWEk/9+7BpUqlQ9/jkoMabBFdTAqgmPJRbDiXXuHwXpiKMGkR
         ABy9ETz+4Cv/q3YuBrAzVEL6xo4Z9nyp3TJ9LkgLV7VtKKpMguCHsIaLgm9iv9xO8mkw
         WU8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=OagLRmMmzyQmGqXHU8QCfKrH7+tgm0iC+teioaMlxY8=;
        b=DGjnDUuXWHkHXYTFjPNkxqr3M+uYJorAyNALBL6FQE0wFBHrZmwfQnRvPS+fu1BWK9
         bGBWZuL5NXxmUX7zM+tBHaG1lxmqgk911RrJF2WXQqKWmfeT49HgTYZj5huzdMH2CVHO
         HtFUgCgxNDwH1ueCxy50j969r3OyCV7JNL5uAsUlKr3OTokJc3I+hb09EXBu7EASGhu5
         k4K/QgMU0fYbDRN1S/e4lY2qcfrSLdaqCICpxj0ME3BugNr4yCjdUXUDb/xNSiua1XnT
         OlF4un6dgfTFrS48/7EUr3IbnsfOj/rc1QbJF4ekmMaPG0zFyJ3NDbQI9hX7rXL1DG0D
         Jtsw==
X-Gm-Message-State: AOAM531JjMV3/9p8G077bFAk4TS9zrKeBuQulatvQgU+cVPXoXgCjVzV
        3EOknSxJFmAYzj1o/lhdEE7rCXiyQbodHg7wOQ==
X-Google-Smtp-Source: ABdhPJxzsMWs7cPxHcJVEK0MMmzcLZ3BX26xgEqJ+cjkAM67DycOE9xaVXyG4ooDAIXoCBwYiczs1AVvH+kAit3i8g==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:8f02:232:ad86:2ab2])
 (user=kaleshsingh job=sendgmr) by 2002:a5b:804:: with SMTP id
 x4mr9503248ybp.673.1644533125008; Thu, 10 Feb 2022 14:45:25 -0800 (PST)
Date:   Thu, 10 Feb 2022 14:41:45 -0800
In-Reply-To: <20220210224220.4076151-1-kaleshsingh@google.com>
Message-Id: <20220210224220.4076151-5-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220210224220.4076151-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH 4/7] KVM: arm64: Allocate guard pages near hyp stacks
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     will@kernel.org, maz@kernel.org, qperret@google.com,
        tabba@google.com, surenb@google.com, kernel-team@android.com,
        Kalesh Singh <kaleshsingh@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Andrew Scull <ascull@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu
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

From: Quentin Perret <qperret@google.com>

Allocate unbacked VA space underneath each stack page to ensure stack
overflows get trapped and don't corrupt memory silently.

The stack is aligned to twice its size (PAGE_SIZE), meaning that any
valid stack address has PAGE_SHIFT bit as 0. This allows us to easily
check for overflow in the exception entry without corrupting any GPRs.

Signed-off-by: Quentin Perret <qperret@google.com>
[ Kalesh - Update commit text and comments,
           refactor, add overflow handling ]
Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
 arch/arm64/kvm/hyp/nvhe/host.S   | 16 ++++++++++++++++
 arch/arm64/kvm/hyp/nvhe/setup.c  | 19 ++++++++++++++++++-
 arch/arm64/kvm/hyp/nvhe/switch.c |  5 +++++
 3 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/host.S b/arch/arm64/kvm/hyp/nvhe/host.S
index 3d613e721a75..78e4b612ac06 100644
--- a/arch/arm64/kvm/hyp/nvhe/host.S
+++ b/arch/arm64/kvm/hyp/nvhe/host.S
@@ -153,6 +153,10 @@ SYM_FUNC_END(__host_hvc)
 
 .macro invalid_host_el2_vect
 	.align 7
+
+	/* Test stack overflow without corrupting GPRs */
+	test_sp_overflow PAGE_SHIFT, .L__hyp_sp_overflow\@
+
 	/* If a guest is loaded, panic out of it. */
 	stp	x0, x1, [sp, #-16]!
 	get_loaded_vcpu x0, x1
@@ -165,6 +169,18 @@ SYM_FUNC_END(__host_hvc)
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
diff --git a/arch/arm64/kvm/hyp/nvhe/setup.c b/arch/arm64/kvm/hyp/nvhe/setup.c
index 99e178cf4249..114053dff228 100644
--- a/arch/arm64/kvm/hyp/nvhe/setup.c
+++ b/arch/arm64/kvm/hyp/nvhe/setup.c
@@ -105,7 +105,24 @@ static int recreate_hyp_mappings(phys_addr_t phys, unsigned long size,
 		if (ret)
 			return ret;
 
-		/* Map stack pages in the 'private' VA range */
+		/*
+		 * Allocate 'private' VA range for stack guard pages.
+		 *
+		 * The 'private' VA range grows upward and stacks downwards, so
+		 * allocate the guard page first. But make sure to align the
+		 * stack itself with PAGE_SIZE * 2 granularity to ease overflow
+		 * detection in the entry assembly code.
+		 */
+		do {
+			start = (void *)hyp_alloc_private_va_range(PAGE_SIZE);
+			if (IS_ERR(start))
+				return PTR_ERR(start);
+		} while (IS_ALIGNED((u64) start, PAGE_SIZE * 2));
+
+		/*
+		 * Map stack pages in the 'private' VA range above the allocated
+		 * guard pages.
+		 */
 		end = (void *)__hyp_pa(per_cpu_ptr(&kvm_init_params, i)->stack_hyp_va);
 		start = end - PAGE_SIZE;
 		start = (void *)__pkvm_create_private_mapping((phys_addr_t)start,
diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
index 6410d21d8695..5a2e1ab79913 100644
--- a/arch/arm64/kvm/hyp/nvhe/switch.c
+++ b/arch/arm64/kvm/hyp/nvhe/switch.c
@@ -369,6 +369,11 @@ void __noreturn hyp_panic(void)
 	unreachable();
 }
 
+void __noreturn hyp_panic_bad_stack(void)
+{
+	hyp_panic();
+}
+
 asmlinkage void kvm_unexpected_el2_exception(void)
 {
 	return __kvm_unexpected_el2_exception();
-- 
2.35.1.265.g69c8d7142f-goog


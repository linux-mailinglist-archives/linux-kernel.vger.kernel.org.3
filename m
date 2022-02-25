Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B51C4C3C88
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 04:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237094AbiBYDl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 22:41:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237089AbiBYDl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 22:41:56 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6625C20D534
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 19:41:25 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id r14-20020a5b018e000000b00624f6f97bf4so2020078ybl.12
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 19:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=0x2wn/o2gYOT1QepQCECViMH+fFbe42VFIEzpGyKYPU=;
        b=QkaH0+9lm1XnIrQtwef1MIRtU3vdqUyeYauQ0QclzvBFRyMKXRAZNfP3AZ/75tEW5v
         A/6NnwPNuvAR3YAXjwR9nz9ER16n3AS9LGKJ6T5MVkI0G3eIGG77lex3qyvyySWRAxYP
         EBkLjFYGzLCoUPdTl11vZrKFSCMErH2Qw2+YLlEKzwoydyx3eocXRUhidIJ6uIYL4bnp
         T11wZIEVRrdm112A26FKY6O2yMrUH+5sVdRssrItX8YytwEM/FQe6kwVASO+f2v4ABm7
         zso4UKV+++MlDgyKOHD6e10/RNFllFf5Tpi4cdHh5fA9bCQb81HdtqrF4zV0WiFsrINw
         BVtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=0x2wn/o2gYOT1QepQCECViMH+fFbe42VFIEzpGyKYPU=;
        b=q8sZy8IrDZtTgZO2DLjTR602mpRq+B0YLrFgbEPyV4Fe4mfzaktXwNBEdULhu4U5jb
         /2mcQ9ATz2exDK+qcjLxdRTOEVQtwIkyRMSXAOdqrm30xZe/Lz26UE6laIbZ+hzhld1g
         KuHLeAMHHONG0ANRkEuedfKnQRWE0Gy9yR56V4p/1qshGtGR26D7zqY1P3HBDKonTLC8
         T9R8EAXW1rD9WOpyCjik1WSLrPFpXaTo9yHxIl9MwAHlFZolI1wfddRWxP6FJubLUhHx
         dj8CnU2qUloUPBW91nl5XzlTj/uW9kQ77fKjO05P55F9QXn+QGPt5/P3s6vtgmGJh4e7
         kbKA==
X-Gm-Message-State: AOAM530VdFryn2v4qgI6I/dMr9RxQYdWiuLGlo9xFa7HkD8kNt8xXbUB
        jJocmewLkK2sB+OjPvqvXDQzmEqa5V8gqW2ryg==
X-Google-Smtp-Source: ABdhPJxzcgpZCUdamSFGzYXAXUsCWNCBw73C8lXSgDIh3yMJ8Ub57T3zRTVv6FqPeC0H1pLaruUzeJ4yQJBOn00kXw==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:3a50:90b2:e6a2:9060])
 (user=kaleshsingh job=sendgmr) by 2002:a0d:fb45:0:b0:2d0:d09a:576c with SMTP
 id l66-20020a0dfb45000000b002d0d09a576cmr5778027ywf.447.1645760484556; Thu,
 24 Feb 2022 19:41:24 -0800 (PST)
Date:   Thu, 24 Feb 2022 19:34:48 -0800
In-Reply-To: <20220225033548.1912117-1-kaleshsingh@google.com>
Message-Id: <20220225033548.1912117-4-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220225033548.1912117-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH v4 3/8] KVM: arm64: Add guard pages for KVM nVHE hypervisor stack
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

Maps the stack pages in the flexible private VA range and allocates
guard pages below the stack as unbacked VA space. The stack is aligned
to twice its size to aid overflow detection (implemented in a subsequent
patch in the series).

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---

Changes in v4:
  - Replace IS_ERR_OR_NULL check with IS_ERR check now that
    hyp_alloc_private_va_range() returns an error for null
    pointer, per Fuad
  - Format comments to < 80 cols, per Fuad

Changes in v3:
  - Handle null ptr in IS_ERR_OR_NULL checks, per Mark

 arch/arm64/include/asm/kvm_asm.h |  1 +
 arch/arm64/kvm/arm.c             | 32 +++++++++++++++++++++++++++++---
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index d5b0386ef765..2e277f2ed671 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -169,6 +169,7 @@ struct kvm_nvhe_init_params {
 	unsigned long tcr_el2;
 	unsigned long tpidr_el2;
 	unsigned long stack_hyp_va;
+	unsigned long stack_pa;
 	phys_addr_t pgd_pa;
 	unsigned long hcr_el2;
 	unsigned long vttbr;
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index ecc5958e27fe..0a83c0e7f838 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1541,7 +1541,6 @@ static void cpu_prepare_hyp_mode(int cpu)
 	tcr |= (idmap_t0sz & GENMASK(TCR_TxSZ_WIDTH - 1, 0)) << TCR_T0SZ_OFFSET;
 	params->tcr_el2 = tcr;
 
-	params->stack_hyp_va = kern_hyp_va(per_cpu(kvm_arm_hyp_stack_page, cpu) + PAGE_SIZE);
 	params->pgd_pa = kvm_mmu_get_httbr();
 	if (is_protected_kvm_enabled())
 		params->hcr_el2 = HCR_HOST_NVHE_PROTECTED_FLAGS;
@@ -1990,14 +1989,41 @@ static int init_hyp_mode(void)
 	 * Map the Hyp stack pages
 	 */
 	for_each_possible_cpu(cpu) {
+		struct kvm_nvhe_init_params *params = per_cpu_ptr_nvhe_sym(kvm_init_params, cpu);
 		char *stack_page = (char *)per_cpu(kvm_arm_hyp_stack_page, cpu);
-		err = create_hyp_mappings(stack_page, stack_page + PAGE_SIZE,
-					  PAGE_HYP);
+		unsigned long stack_hyp_va, guard_hyp_va;
 
+		/*
+		 * Private mappings are allocated downwards from io_map_base
+		 * so allocate the stack first then the guard page.
+		 *
+		 * The stack is aligned to twice its size to facilitate overflow
+		 * detection.
+		 */
+		err = __create_hyp_private_mapping(__pa(stack_page), PAGE_SIZE,
+						PAGE_SIZE * 2, &stack_hyp_va, PAGE_HYP);
 		if (err) {
 			kvm_err("Cannot map hyp stack\n");
 			goto out_err;
 		}
+
+		/* Allocate unbacked private VA range for stack guard page */
+		guard_hyp_va = hyp_alloc_private_va_range(PAGE_SIZE, PAGE_SIZE);
+		if (IS_ERR((void *)guard_hyp_va)) {
+			err = PTR_ERR((void *)guard_hyp_va);
+			kvm_err("Cannot allocate hyp stack guard page\n");
+			goto out_err;
+		}
+
+		/*
+		 * Save the stack PA in nvhe_init_params. This will be needed
+		 * to recreate the stack mapping in protected nVHE mode.
+		 * __hyp_pa() won't do the right thing there, since the stack
+		 * has been mapped in the flexible private VA space.
+		 */
+		params->stack_pa = __pa(stack_page) + PAGE_SIZE;
+
+		params->stack_hyp_va = stack_hyp_va + PAGE_SIZE;
 	}
 
 	for_each_possible_cpu(cpu) {
-- 
2.35.1.574.g5d30c73bfb-goog


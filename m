Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06C1F4D06E7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 19:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244843AbiCGSwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 13:52:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236740AbiCGSwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 13:52:16 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603E98B6C9
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 10:51:21 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id b12-20020a056902030c00b0061d720e274aso14263893ybs.20
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 10:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=PouKLLR1qtfDqJBB+NkFAo5RJJpYZHlkNUkobibAveQ=;
        b=aJTRdfEPXajjtz7jpjusbLUwZHazPtaAdcjDseH62JaWa29UuajDbAb71dvJHhmKqT
         qDiEGjeGQ4zUeX1iZ3TO4pqzbbBPJSr65U+uI9jgrHLjrzrHfOacA3jGMrixx0OKeWw/
         RZREPe+YYXjsHh9sKXqWOuy0autI6OXkU0BqTNyuCWB5XU9T49hoGPRmWqE8UgfejZQd
         lcIGj6FSH3p02df0kKhGSZ5izAjpIfMfx0+LzeUc2uxAhgEI3OyQrNk/sYfnaMqBZH8s
         Sy1AAqCHZortJ4WqKOZ77ZdIBVlnzmrr8Fhl/QsWQxE7Bl7ms2oB3fxyn9Va3qqO4cB7
         ukcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=PouKLLR1qtfDqJBB+NkFAo5RJJpYZHlkNUkobibAveQ=;
        b=ZjaUzpMcJsp41t/KB9y6UP+0F6GwZonHENijQW4TgKN/AvaQm0aFWQ1iV4NCoj0SLf
         sqCgwM7759ZavQvpwQnOifEToEdSFyet03QK6qyqy33B8+cBNQvIkZ5QtkEWghYhHro/
         HoEB12AR3A5FLc6TT5opt8uQWKSBsyHwZClqWYMjN1yTeORkiJbzEKniXvcvGZuxnDO+
         DaWvGdXc4WQzeDQcGyaEsqZCZBedJ06H2siuqZqEJ/JWQ2s9sEsZFjhMtRflII0LzRNd
         rmz76NOJvoHOtixwuc2V0Kjk9uZX7hzS3FOtIR1pkhio3f/Ubgf1LGkvDpl/3WdIdHbo
         ZFUQ==
X-Gm-Message-State: AOAM530d3iKbY670kdfdH6WeZOz2v8mouM5KtH0CYi+LpZb5w3Xbjt0k
        S48gRcg5n2W58pbLcVUfrL88N4wKPyaNHfthXQ==
X-Google-Smtp-Source: ABdhPJzwweEi/4c/qw4x+iRcu1VtA4JV/mfDwmW4TcHLmFds7IQbOIZRF8CIqoQFlW80Oc/0DwqmAr/yYYmQ7dz5NQ==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:dd66:1e7d:1858:4587])
 (user=kaleshsingh job=sendgmr) by 2002:a25:8c10:0:b0:61d:b17e:703d with SMTP
 id k16-20020a258c10000000b0061db17e703dmr8988845ybl.154.1646679080527; Mon,
 07 Mar 2022 10:51:20 -0800 (PST)
Date:   Mon,  7 Mar 2022 10:49:01 -0800
In-Reply-To: <20220307184935.1704614-1-kaleshsingh@google.com>
Message-Id: <20220307184935.1704614-4-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220307184935.1704614-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
Subject: [PATCH v5 3/8] KVM: arm64: Add guard pages for KVM nVHE hypervisor stack
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

Map the stack pages in the flexible private VA range and allocate
guard pages below the stack as unbacked VA space. The stack is aligned
so that any valid stack address has PAGE_SHIFT bit as 1 - this is used
for overflow detection (implemented in a subsequent patch in the series).

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---

Changes in v5:
  - Use a single allocation for stack and guard pages to ensure they
    are contiguous, per Marc

Changes in v4:
  - Replace IS_ERR_OR_NULL check with IS_ERR check now that
    hyp_alloc_private_va_range() returns an error for null
    pointer, per Fuad
  - Format comments to < 80 cols, per Fuad

Changes in v3:
  - Handle null ptr in IS_ERR_OR_NULL checks, per Mark


 arch/arm64/include/asm/kvm_asm.h |  1 +
 arch/arm64/include/asm/kvm_mmu.h |  3 +++
 arch/arm64/kvm/arm.c             | 40 +++++++++++++++++++++++++++++---
 arch/arm64/kvm/mmu.c             |  4 ++--
 4 files changed, 43 insertions(+), 5 deletions(-)

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
diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 514cfee76597..fe40cebe2be2 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -116,6 +116,9 @@ alternative_cb_end
 #include <asm/cacheflush.h>
 #include <asm/mmu_context.h>
 
+extern struct kvm_pgtable *hyp_pgtable;
+extern struct mutex kvm_hyp_pgd_mutex;
+
 void kvm_update_va_mask(struct alt_instr *alt,
 			__le32 *origptr, __le32 *updptr, int nr_inst);
 void kvm_compute_layout(void);
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index ecc5958e27fe..cc712e421c5a 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1541,7 +1541,6 @@ static void cpu_prepare_hyp_mode(int cpu)
 	tcr |= (idmap_t0sz & GENMASK(TCR_TxSZ_WIDTH - 1, 0)) << TCR_T0SZ_OFFSET;
 	params->tcr_el2 = tcr;
 
-	params->stack_hyp_va = kern_hyp_va(per_cpu(kvm_arm_hyp_stack_page, cpu) + PAGE_SIZE);
 	params->pgd_pa = kvm_mmu_get_httbr();
 	if (is_protected_kvm_enabled())
 		params->hcr_el2 = HCR_HOST_NVHE_PROTECTED_FLAGS;
@@ -1990,14 +1989,49 @@ static int init_hyp_mode(void)
 	 * Map the Hyp stack pages
 	 */
 	for_each_possible_cpu(cpu) {
+		struct kvm_nvhe_init_params *params = per_cpu_ptr_nvhe_sym(kvm_init_params, cpu);
 		char *stack_page = (char *)per_cpu(kvm_arm_hyp_stack_page, cpu);
-		err = create_hyp_mappings(stack_page, stack_page + PAGE_SIZE,
-					  PAGE_HYP);
+		unsigned long hyp_addr;
 
+		/*
+		 * Allocate a contiguous HYP private VA range for the stack
+		 * and guard page. The allocation is also aligned based on
+		 * the order of its size.
+		 */
+		hyp_addr = hyp_alloc_private_va_range(PAGE_SIZE * 2);
+		if (IS_ERR((void *)hyp_addr)) {
+			err = PTR_ERR((void *)hyp_addr);
+			kvm_err("Cannot allocate hyp stack guard page\n");
+			goto out_err;
+		}
+
+		/*
+		 * Since the stack grows downwards, map the stack to the page
+		 * at the higher address and leave the lower guard page
+		 * unbacked.
+		 *
+		 * Any valid stack address now has the PAGE_SHIFT bit as 1
+		 * and addresses corresponding to the guard page have the
+		 * PAGE_SHIFT bit as 0 - this is used for overflow detection.
+		 */
+		mutex_lock(&kvm_hyp_pgd_mutex);
+		err = kvm_pgtable_hyp_map(hyp_pgtable, hyp_addr + PAGE_SIZE,
+					PAGE_SIZE, __pa(stack_page), PAGE_HYP);
+		mutex_unlock(&kvm_hyp_pgd_mutex);
 		if (err) {
 			kvm_err("Cannot map hyp stack\n");
 			goto out_err;
 		}
+
+		/*
+		 * Save the stack PA in nvhe_init_params. This will be needed
+		 * to recreate the stack mapping in protected nVHE mode.
+		 * __hyp_pa() won't do the right thing there, since the stack
+		 * has been mapped in the flexible private VA space.
+		 */
+		params->stack_pa = __pa(stack_page);
+
+		params->stack_hyp_va = hyp_addr + (2 * PAGE_SIZE);
 	}
 
 	for_each_possible_cpu(cpu) {
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index ccb2847ee2f4..dfdd8c21ed74 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -22,8 +22,8 @@
 
 #include "trace.h"
 
-static struct kvm_pgtable *hyp_pgtable;
-static DEFINE_MUTEX(kvm_hyp_pgd_mutex);
+struct kvm_pgtable *hyp_pgtable;
+DEFINE_MUTEX(kvm_hyp_pgd_mutex);
 
 static unsigned long hyp_idmap_start;
 static unsigned long hyp_idmap_end;
-- 
2.35.1.616.g0bdcbb4464-goog


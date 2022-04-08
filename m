Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C59A4F9DF6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 22:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239399AbiDHUHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 16:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239371AbiDHUHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 16:07:34 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46C3129868
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 13:05:29 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2d2d45c0df7so85385157b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 13:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=29m9VxVlX1cygVbwxroxIUp2tBTU4nq34nZ2FiozReE=;
        b=nUBtx/VHP2Ru1W903kJ1uH9fsTWHYrvlrk43uEvSrOUU8HseqVNL2SYQIi710T8ljb
         aYibGOQhj+PCP3vWdV30uKckypkUslNCAcXRsvrlANH0jurvO8/B6/BwhwRxWCB8Zmmm
         hG+B7YA2puFsn7Vd/oT9bPbN8OnqMwMQ0aynYGDQP+ikL48lOxOXeMSGaoP72HQCdhjU
         LjpmVYxi7G6FNtjwN396olmJs1SlupqJqEiTNHYoGZgI0fOgokkg91s9gjROKaVimFnE
         7Vr/iaDyx1XOLjbTz5XxB0dY02K7Iwrww0o5s99vFzR9KU3MhOlRnqR8CEVZ5XYLfFfH
         Iq9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=29m9VxVlX1cygVbwxroxIUp2tBTU4nq34nZ2FiozReE=;
        b=S1WCS611JKciMD4mY0OLXk3GQixGr3AuISipLr1evn9+vEGw44+QtwrblXOkTXqeVf
         S+6yXLg02fnmSnLUe7O+mQzZl2tt5kBalShe9dddvQ5vXZIOlW73lfn3T2wdxaFSVBkp
         ZG/uaEoK+CLAE7fLU/O3EPrblj6EytKRuOkiVAY6SUCKIuhChIUmKgfckPuBxrzV9lIT
         eJYrStxxdLpK32YYNnfryRZVRloVCKjddL6WyvmUeV+jZ5raIovLJXMmHRbRM697Kv7D
         xM6ZgrAzBs/lDrkLnxno6ynHXOOaID1sVvPZItGmK8ICFrMZNpnqcPbRM2m0T0xFmp7U
         vovw==
X-Gm-Message-State: AOAM5337XcJ+GksOfv3RMKcEUdPHrnQnMlShVIW2Hw3EL7HlhXnPnGdc
        hW11WWofutPlhPdlHJ1L2jRl9/TwH2Vb4PEvnA==
X-Google-Smtp-Source: ABdhPJxPvXyZJz5yABmprIe2Wi2nZxdszLJ8/RPz1xA9zPm4kfJwjfF5pqyZVXur4gF7wDginbdQwTmFbuL9N8LYpg==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:f0ed:c8a:dab7:ecc2])
 (user=kaleshsingh job=sendgmr) by 2002:a25:8551:0:b0:62c:2928:6f06 with SMTP
 id f17-20020a258551000000b0062c29286f06mr15147786ybn.586.1649448328922; Fri,
 08 Apr 2022 13:05:28 -0700 (PDT)
Date:   Fri,  8 Apr 2022 13:03:26 -0700
In-Reply-To: <20220408200349.1529080-1-kaleshsingh@google.com>
Message-Id: <20220408200349.1529080-4-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220408200349.1529080-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
Subject: [PATCH v7 3/6] KVM: arm64: Add guard pages for KVM nVHE hypervisor stack
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     will@kernel.org, maz@kernel.org, qperret@google.com,
        tabba@google.com, surenb@google.com, kernel-team@android.com,
        Kalesh Singh <kaleshsingh@google.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Jones <drjones@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Changbin Du <changbin.du@intel.com>,
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
Tested-by: Fuad Tabba <tabba@google.com>
Reviewed-by: Fuad Tabba <tabba@google.com>
---

Changes in v7:
  - Add Fuad's Reviewed-by and Tested-by tags.

Changes in v6:
  - Update call to hyp_alloc_private_va_range() (return val and params)

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
 arch/arm64/kvm/arm.c             | 39 +++++++++++++++++++++++++++++---
 arch/arm64/kvm/mmu.c             |  4 ++--
 4 files changed, 42 insertions(+), 5 deletions(-)

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
index a50cbb5ba402..b805316c4866 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -117,6 +117,9 @@ alternative_cb_end
 #include <asm/mmu_context.h>
 #include <asm/kvm_host.h>
 
+extern struct kvm_pgtable *hyp_pgtable;
+extern struct mutex kvm_hyp_pgd_mutex;
+
 void kvm_update_va_mask(struct alt_instr *alt,
 			__le32 *origptr, __le32 *updptr, int nr_inst);
 void kvm_compute_layout(void);
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 523bc934fe2f..5687c0175151 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1483,7 +1483,6 @@ static void cpu_prepare_hyp_mode(int cpu)
 	tcr |= (idmap_t0sz & GENMASK(TCR_TxSZ_WIDTH - 1, 0)) << TCR_T0SZ_OFFSET;
 	params->tcr_el2 = tcr;
 
-	params->stack_hyp_va = kern_hyp_va(per_cpu(kvm_arm_hyp_stack_page, cpu) + PAGE_SIZE);
 	params->pgd_pa = kvm_mmu_get_httbr();
 	if (is_protected_kvm_enabled())
 		params->hcr_el2 = HCR_HOST_NVHE_PROTECTED_FLAGS;
@@ -1933,14 +1932,48 @@ static int init_hyp_mode(void)
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
+		err = hyp_alloc_private_va_range(PAGE_SIZE * 2, &hyp_addr);
+		if (err) {
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
index 3d3efea4e991..a54f00bd06cc 100644
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
2.35.1.1178.g4f1659d476-goog


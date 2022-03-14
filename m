Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC104D8DBA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 21:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244878AbiCNUFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 16:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233116AbiCNUFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 16:05:06 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0DEB26CD
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 13:03:55 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2d726bd83a2so141181577b3.20
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 13:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=KBKuM8nQbHEsk5KoB9KDoIyUXnj0iRI96x05Zc5GVwU=;
        b=pSlak9X+zf0pVcMyDGHXsdj/0ZvCoyfAdmZkLL2IoXQ/eoplgnCHVzUHV6625bNCMO
         5W/FfGYImrd/5arptPi/Rh1DZ3oNGT2WHcLtPHwLYae1RG+2+WzzpSLpx2IBnWYENwKv
         olSKeenA96Zm6AESUkoS6AaJro4cv3oA8G58W7nRuRrabP+0XkTX3+FgmM2KLrYrKfxI
         fh3CE8qwaMgsfxjjWdwl2sVShwIJXNUkC9SCrJe9gGVTROtWlcut+zWSPLRbuIgzhnlp
         LaMbeaJkLAlGGeT8FDnOUeP6d721ULqiYxQkoP6I2jelyXGKa7OrDJwlWFpyCLR4N3P3
         sZSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=KBKuM8nQbHEsk5KoB9KDoIyUXnj0iRI96x05Zc5GVwU=;
        b=FfIK1eyFAz3JrJk0ogogjffBPQDPix5xRfOMs/mpguucW55PFEWTTPQ47yuEgjxs+g
         GP02++SJafFwn/aqM8+PR5GIR989qlOwNFQUeZlVf+ws2xxQ02w0QV4aNGKe5uZbaRQr
         l5Ach5eTOmYvGBXD4qZ/RfkMPatQSba2Fq9Kb213I+hiNhDKOmBnD4LGlX6C4i5aX62I
         9fPj3s6NgBi0pwvtqM1czXnGL3yk3S7yjvvGLPN20gQgkM25jVRIHv8uS65drvo5Y1eT
         I7OX+qCHYiBtxNd9OdQ3q8geoeshjHb98jdjguSumboTl1yDubtAbkw7cglKM2cxBve3
         daIg==
X-Gm-Message-State: AOAM530BgVfdIbwiM2h2iEqzg55i63hOAcaMOcxwsf1coYehUcduRfrA
        eO6xdd6Lt5UsZL9zqRruRd72KEQpCFCN2kEQdg==
X-Google-Smtp-Source: ABdhPJy9MIn39nszadJy4TGmciC+Phtwg3irGAJ8Z0MmmzIQBmJ0g8Fd8p3i/9X7ZdC1H/f6r8RSPw1B8z+qXReY+g==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:500a:9ac2:e73e:69e3])
 (user=kaleshsingh job=sendgmr) by 2002:a0d:e244:0:b0:2db:d6a8:14c9 with SMTP
 id l65-20020a0de244000000b002dbd6a814c9mr21314233ywe.402.1647288235164; Mon,
 14 Mar 2022 13:03:55 -0700 (PDT)
Date:   Mon, 14 Mar 2022 13:01:12 -0700
In-Reply-To: <20220314200148.2695206-1-kaleshsingh@google.com>
Message-Id: <20220314200148.2695206-4-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220314200148.2695206-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [PATCH v6 3/8] KVM: arm64: Add guard pages for KVM nVHE hypervisor stack
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
        Stephen Boyd <swboyd@chromium.org>,
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
index 3cc9aa25f510..967a9ea9a47b 100644
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
index 4dca6ffd03d4..72be7e695d8d 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1538,7 +1538,6 @@ static void cpu_prepare_hyp_mode(int cpu)
 	tcr |= (idmap_t0sz & GENMASK(TCR_TxSZ_WIDTH - 1, 0)) << TCR_T0SZ_OFFSET;
 	params->tcr_el2 = tcr;
 
-	params->stack_hyp_va = kern_hyp_va(per_cpu(kvm_arm_hyp_stack_page, cpu) + PAGE_SIZE);
 	params->pgd_pa = kvm_mmu_get_httbr();
 	if (is_protected_kvm_enabled())
 		params->hcr_el2 = HCR_HOST_NVHE_PROTECTED_FLAGS;
@@ -1987,14 +1986,48 @@ static int init_hyp_mode(void)
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
index 7326d683c500..9bfc6d8f3c49 100644
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
2.35.1.723.g4982287a31-goog


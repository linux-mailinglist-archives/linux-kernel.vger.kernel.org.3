Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95AE54C234A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 06:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbiBXFSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 00:18:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiBXFSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 00:18:47 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F631CA30A
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 21:18:18 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2d07ae11462so11752047b3.8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 21:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=WjbUGG0xKbMDb5kZ3phtYyC+0rOONMmeQOjqy/50x/c=;
        b=FHuVkJYODfDfl0B/txzDiDC6eLLacjGAf43dVMqRJLxMGNm+ImeYaDBNJD5gfJcv21
         Z9ohbr5zf1QC8/F1bTBF+ZtWze2p25FmnoYimvvp8tGfx9BVPZudUp/YbHnPxZvAYx55
         BqQBFSvFlWYpbE2iAz3wRpB2MQIzUJu+vUzz+Lh96Jvt7QNRq+kZQU99bHlUuJuxphka
         SBWOmouo+ZUbL8PlVbbewShLA/QY6RIkqnU5TnnahSBctuqAIesOkiMO0fGPQRCh9HHP
         62goySNV+LLta5Vhbshz1OV5YtgqzaIrnFy1jWIOuZFsvFmAUGNSod5QivSRYUMFNxUt
         nAHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=WjbUGG0xKbMDb5kZ3phtYyC+0rOONMmeQOjqy/50x/c=;
        b=vmN/7bQbdYE6aGNj+nM1/T2TuimYFIoML5vi770L1Vj4nixS1lBPnmw2dYiprUlh8d
         /E3Vg6HiIBe9WJK1Ok8AEaX/B/0//LcGhnQvGAxaDNxb+6LcXErXBIB+VOYmgiEIqAUy
         C04UGJf9NrapDnAdPX8KQS5LpfZWpD212DXq7d2dkyDFi1sTLFngIXOiKPZIzftQ0LVY
         0ixWGanPX+MzPxxwM7sGjpkWdhcjPRQqKJuMXO6VNKmvhaE5tajPYy5kbLqW/qzDoEyJ
         eKagyZp9GorsICD0LTKzLiEWLaYXmyAKr4Wi0QYND3N+d/2mGs3FqtTO2Kwy6xVSfoQT
         DN6Q==
X-Gm-Message-State: AOAM530/3gINMHRvx9hhjRP57H6TP1K/W03sxq8kE/4Wbjfr1sq6dLtf
        dfl/5tfZrhzjdq05VJtq5Puhe5y7oGEzyoJTxQ==
X-Google-Smtp-Source: ABdhPJx3WSBr6Ord/trpGYMYJOGDBeI1xnyUZY7Sz4G+U3zbWcId4VvxdhF5xjfG8cDbo/CMBLseJWAynlqRPGyAbg==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:415c:9be0:c461:440a])
 (user=kaleshsingh job=sendgmr) by 2002:a25:ae94:0:b0:624:4253:a8b with SMTP
 id b20-20020a25ae94000000b0062442530a8bmr999641ybj.529.1645679897623; Wed, 23
 Feb 2022 21:18:17 -0800 (PST)
Date:   Wed, 23 Feb 2022 21:13:38 -0800
In-Reply-To: <20220224051439.640768-1-kaleshsingh@google.com>
Message-Id: <20220224051439.640768-4-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220224051439.640768-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed-goog
Subject: [PATCH v3 3/8] KVM: arm64: Add guard pages for KVM nVHE hypervisor stack
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
        Paolo Bonzini <pbonzini@redhat.com>,
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
index ecc5958e27fe..7a23630c4a7f 100644
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
+		if (IS_ERR_OR_NULL((void *)guard_hyp_va)) {
+			err = guard_hyp_va ? PTR_ERR((void *)guard_hyp_va) : -ENOMEM;
+			kvm_err("Cannot allocate hyp stack guard page\n");
+			goto out_err;
+		}
+
+		/*
+		 * Save the stack PA in nvhe_init_params. This will be needed to recreate
+		 * the stack mapping in protected nVHE mode. __hyp_pa() won't do the right
+		 * thing there, since the stack has been mapped in the flexible private
+		 * VA space.
+		 */
+		params->stack_pa = __pa(stack_page) + PAGE_SIZE;
+
+		params->stack_hyp_va = stack_hyp_va + PAGE_SIZE;
 	}
 
 	for_each_possible_cpu(cpu) {
-- 
2.35.1.473.g83b2b277ed-goog


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3383B4D8DBC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 21:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244880AbiCNUFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 16:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233116AbiCNUFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 16:05:44 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2270E26CD
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 13:04:34 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id l19-20020a252513000000b00629235aacb2so14826706ybl.13
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 13:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=wcrKUjLTdB/HMJdpeOMPENhm20Kul5UdkQa5+z1O4C4=;
        b=ly66flbISMQbhQBRlyU0Ey6SFlvMFzMx+MCgdnpmKL7gbVZVnWJLeZ+eBkxab3u2uQ
         /BAPbfsTDdal7NC9tiorOpcTnS1SPCwqZUI5C63IE+zdaccPQGfmYSxoacTwGxFep/2p
         sYVB6HiHODgLOoNDiEG83gzblrNaMgs4O6zNyjkLeAiPKK3DV/bg6YbvMdHsVKlKv7KY
         550C2M5Wqi0qqi2+Rf5QnAcPMwneFdc65JXbl6PhmeS78GfP9FQWcDKMbAEnn8H1+9ZJ
         SCEW87y7rwuaOAGH1aDA7RKYVL+X6hcCfbwXAskLXQyF15WTxFS95qoyIpo7yUBKpcK4
         iU7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=wcrKUjLTdB/HMJdpeOMPENhm20Kul5UdkQa5+z1O4C4=;
        b=Fde8Jh66XTZ0KqGSM6XQYHbtNsnOA+m6zlmWtEslAQHnjaDWmiTt4WqCyLFZb3fx80
         hjeOIPbDaVG71s2qpLUMuEFsaViuxl5P92ikr90ww6A7WhgTNw9pRfxhdqbidpOgufU7
         FeZEpzy2zpdR/c8ZzKSGcPS/0aDmvGsr47jCTI4vyrDtJI4ZnhKmNtTc9tXjyx/HAu+4
         JJRoyQru8/nv+A88kYRgigtfdh7QEA1FtBWOOP9E/IqIRZ6RUgIHEIBeTPCIbkVVwbLS
         lOv4GgDh6sAHGNumw2qllZOnGBId8rtI/VQ3AJfCJMCUdZa/RNIahVcSmP67r4DVP5s5
         tYuA==
X-Gm-Message-State: AOAM532QPXVJqkNa5R5GowqSxkvDtnQMD2oxaU+dXfcrZFQt+nyAo5eb
        zg/tzOrDKMTCwWNXlvDykcRV82PywyvLnBm5/w==
X-Google-Smtp-Source: ABdhPJzCQjLXyp0zrSq0fPr0qCvgIfWkpLUI1kq/oOWycXP2KR703/KzwXb0OI2paMiDufMo2S2nH7jF9T3m4zbQpw==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:500a:9ac2:e73e:69e3])
 (user=kaleshsingh job=sendgmr) by 2002:a81:9c4c:0:b0:2dc:ba4:4ee with SMTP id
 n12-20020a819c4c000000b002dc0ba404eemr20662044ywa.248.1647288273266; Mon, 14
 Mar 2022 13:04:33 -0700 (PDT)
Date:   Mon, 14 Mar 2022 13:01:13 -0700
In-Reply-To: <20220314200148.2695206-1-kaleshsingh@google.com>
Message-Id: <20220314200148.2695206-5-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220314200148.2695206-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [PATCH v6 4/8] KVM: arm64: Add guard pages for pKVM (protected nVHE)
 hypervisor stack
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
        Andrew Scull <ascull@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
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
for overflow detection (implemented in a subsequent patch in the series)

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---

Changes in v6:
  - Update call to pkvm_alloc_private_va_range() (return val and params)

Changes in v5:
  - Use a single allocation for stack and guard pages to ensure they
    are contiguous, per Marc

Changes in v4:
  - Replace IS_ERR_OR_NULL check with IS_ERR check now that
    pkvm_alloc_private_va_range() returns an error for null
    pointer, per Fuad

Changes in v3:
  - Handle null ptr in IS_ERR_OR_NULL checks, per Mark


 arch/arm64/kvm/hyp/nvhe/setup.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/setup.c b/arch/arm64/kvm/hyp/nvhe/setup.c
index 27af337f9fea..e8d4ea2fcfa0 100644
--- a/arch/arm64/kvm/hyp/nvhe/setup.c
+++ b/arch/arm64/kvm/hyp/nvhe/setup.c
@@ -99,17 +99,42 @@ static int recreate_hyp_mappings(phys_addr_t phys, unsigned long size,
 		return ret;
 
 	for (i = 0; i < hyp_nr_cpus; i++) {
+		struct kvm_nvhe_init_params *params = per_cpu_ptr(&kvm_init_params, i);
+		unsigned long hyp_addr;
+
 		start = (void *)kern_hyp_va(per_cpu_base[i]);
 		end = start + PAGE_ALIGN(hyp_percpu_size);
 		ret = pkvm_create_mappings(start, end, PAGE_HYP);
 		if (ret)
 			return ret;
 
-		end = (void *)per_cpu_ptr(&kvm_init_params, i)->stack_hyp_va;
-		start = end - PAGE_SIZE;
-		ret = pkvm_create_mappings(start, end, PAGE_HYP);
+		/*
+		 * Allocate a contiguous HYP private VA range for the stack
+		 * and guard page. The allocation is also aligned based on
+		 * the order of its size.
+		 */
+		ret = pkvm_alloc_private_va_range(PAGE_SIZE * 2, &hyp_addr);
+		if (ret)
+			return ret;
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
+		hyp_spin_lock(&pkvm_pgd_lock);
+		ret = kvm_pgtable_hyp_map(&pkvm_pgtable, hyp_addr + PAGE_SIZE,
+					PAGE_SIZE, params->stack_pa, PAGE_HYP);
+		hyp_spin_unlock(&pkvm_pgd_lock);
 		if (ret)
 			return ret;
+
+		/* Update stack_hyp_va to end of the stack's private VA range */
+		params->stack_hyp_va = hyp_addr + (2 * PAGE_SIZE);
 	}
 
 	/*
-- 
2.35.1.723.g4982287a31-goog


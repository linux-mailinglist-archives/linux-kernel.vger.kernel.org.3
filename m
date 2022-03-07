Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 634604D06EA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 19:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244845AbiCGSwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 13:52:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236740AbiCGSwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 13:52:49 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5974F91AE1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 10:51:54 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2dcfa6bab2aso7992367b3.22
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 10:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=zd+Pz2hCyohdOr/dxmLz4Gh63tEi7O3x6Rne/mgLJEk=;
        b=YGw1K4bIRd5auwTqZymINsBHkIli4RccZzk4Jm4KA6dGEHBvQ2DZkRbLMuzrXmWA6v
         wJCzEQUUIF+eGpEJ8hv6nwf3Lha6QMIKGx1FK5EEn/ZcEJu0zVQ8bzkc4nj40tDoytCH
         VcGZa0Mjq+KpMF/lKcJV/wTFDar81JQFg+kHt+eu+YW4mWeOrYqrAOBqwQQUei3FQjJR
         J+voN8JFvSSvBwwfv+nH5y0mDzZsARC45NKcXqFzEiQsO4ZB/J6CiEd/epZvdg5l2mV2
         02rHt+WO60nCKAbGjCzA/BCJDOeM5MvBBZvDRQ9mekCrplwHhg/USKkd1U8/hGrNXAkY
         FXCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=zd+Pz2hCyohdOr/dxmLz4Gh63tEi7O3x6Rne/mgLJEk=;
        b=RXwGcIG3AOYc+zB3qx9m+hUi196w6A2NBy2a3zQVgOJcvS4zYMOWfBlCqSZWH/RoiX
         ih/LvmohbGdrTJOXfDVb1eQXBXBiA10v1hyICqFAsXOyChm/MaMm0NKzpV/5hJUQ2gjA
         HrooVqb9wM/z6cTGrmSNh1oR24R113Hc+zR6yWHV8MciBadbRH5oVf2pE3XKXnIw5pBj
         NiUh+RlXwm2nzo3uou0+3Uyhu7F4oNVDPw9RZhs7A7orv9+TeLziW42VSZFjP6fAya+R
         nUvu57emAasvHzLNs8Q1VLRC3Pf+2dLoQJtcpK1Et34UergJkxaC9UqhW3xAw+Mqje4E
         zxpA==
X-Gm-Message-State: AOAM532RM0SPkZjN67ISOx5o3ySXf0eD3z+HHn+c3cXVcl8nMrKrNTXc
        s5OlURSn/o9jSqQYykWHH/XRPZapgnPdwfgkTg==
X-Google-Smtp-Source: ABdhPJwlyi6jAHh/rkaohhtiaZqpeV4EIkMP+HMGa+Uf4dvpDuGYBVdyLkTaivMLbQ5TDo5YhM9lzpuhTr29cWEcnA==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:dd66:1e7d:1858:4587])
 (user=kaleshsingh job=sendgmr) by 2002:a5b:f0b:0:b0:624:b2f2:cc91 with SMTP
 id x11-20020a5b0f0b000000b00624b2f2cc91mr9033829ybr.324.1646679113524; Mon,
 07 Mar 2022 10:51:53 -0800 (PST)
Date:   Mon,  7 Mar 2022 10:49:02 -0800
In-Reply-To: <20220307184935.1704614-1-kaleshsingh@google.com>
Message-Id: <20220307184935.1704614-5-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220307184935.1704614-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
Subject: [PATCH v5 4/8] KVM: arm64: Add guard pages for pKVM (protected nVHE)
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
for overflow detection (implemented in a subsequent patch in the series)

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---

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
index 27af337f9fea..4bec3069b234 100644
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
+		hyp_addr = pkvm_alloc_private_va_range(PAGE_SIZE * 2);
+		if (IS_ERR((void *)hyp_addr))
+			return PTR_ERR((void *)hyp_addr);
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
2.35.1.616.g0bdcbb4464-goog


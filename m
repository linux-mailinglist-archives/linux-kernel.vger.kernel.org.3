Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFAB54F9DF9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 22:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239364AbiDHUII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 16:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239371AbiDHUIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 16:08:02 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF34353A99
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 13:05:55 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id t190-20020a25c3c7000000b006410799ab3dso2067616ybf.21
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 13:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=pAGqEnG2raRkXveZrBOcJyHPFm0QVTMkhlJQFJA6T34=;
        b=fkf7yOt+xD7tPoLc32dR2/1ousTpprVrbdor4w8WJ28DKGW7L4u8ZSraUcycc4uKIx
         qIhFw4XjsCzjNrsqJZ7FDiR7kbhNdo9HlrECBWIGZQYEgklkOp6x/7lnhjh2nr7AkBsn
         C9IsV/kKQ4A+DEBXdbfdSnSJyDQG963lgzXVwwu0RFUrvvAINdb93EZG4Rz+364uJ/kC
         ffGjkLkbzJNk2CmRiYuzdfRe8LxLAzd8qX96szw4FY/GsE2/kqQg4DTyfouy123yi6Fo
         3nuCQkMf/4aVhDA2jSGy/I52QR0VqL1WXxHhBpkGiKplOyrniE2sXUjiMpHULw7lt5t0
         KcEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=pAGqEnG2raRkXveZrBOcJyHPFm0QVTMkhlJQFJA6T34=;
        b=x/0lZraI2AMGNwNJVVKGXv1N9s76Eraihw2Dz34XsXWlApiAy7EhzW8S3FgCLgTnXK
         9cOKiNazHFKQza19boo8sladrg8HeOfufvc5tK7/cp/82hz03GwYGGxQY9Ot1n2idBAE
         erKVR+EDYTCMXZJq+zoyE7NVh9+vsJqOGmRUvsCEFfUsaMQX689qdg4PtRmSRKIRJSgB
         DSwCqAsTae6iu/vnwJSxzB92xN4QRJ5nTwrvtlsltcModiTf3noxB/MEk6xkk9E4eK10
         MEecBCrtkSpIdLoUlPhYj6OfeTRsFVvXsLHkYsIXQvEX8FS+UUVtEb0Z2fWrMYixGz/Q
         t9+g==
X-Gm-Message-State: AOAM531ijS3igHlo8rhYq1g+7KhekPZyumGUFE6U3k7qJEEfvsOz5ED6
        SEWsAaXiWOXZA5fA0Bah5BBV/FdT2YguvD6mtQ==
X-Google-Smtp-Source: ABdhPJw+e7eRfTOjt8ij1JblVkRTOiDGCo90TudLPv3hs+v+1VcmuHXfi9c5ryQLjBORNvuZhqGkr3+gBULrWSkxcA==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:f0ed:c8a:dab7:ecc2])
 (user=kaleshsingh job=sendgmr) by 2002:a25:ae1c:0:b0:63d:4d85:acdc with SMTP
 id a28-20020a25ae1c000000b0063d4d85acdcmr15047111ybj.435.1649448355076; Fri,
 08 Apr 2022 13:05:55 -0700 (PDT)
Date:   Fri,  8 Apr 2022 13:03:27 -0700
In-Reply-To: <20220408200349.1529080-1-kaleshsingh@google.com>
Message-Id: <20220408200349.1529080-5-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220408200349.1529080-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
Subject: [PATCH v7 4/6] KVM: arm64: Add guard pages for pKVM (protected nVHE)
 hypervisor stack
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
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Changbin Du <changbin.du@intel.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
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
Tested-by: Fuad Tabba <tabba@google.com>
Reviewed-by: Fuad Tabba <tabba@google.com>
---

Changes in v7:
  - Add Fuad's Reviewed-by and Tested-by tags.

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
2.35.1.1178.g4f1659d476-goog


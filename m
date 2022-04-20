Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1CBE509250
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 23:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382654AbiDTVst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 17:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382646AbiDTVsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 17:48:46 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AEDC2A73D
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 14:45:59 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id i5-20020a258b05000000b006347131d40bso2642424ybl.17
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 14:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=lwg1kG8+1/wNbjGSZ2PbJ4ea1sTg4029wAFJD+g5Qi4=;
        b=MMPu74D6gv8xbJTQoLjt4UXwW+FjK1985Y1rOEoSiYg5gcI/zj6BJ7wbII6XHlcPvT
         59BtqlU6lweX8m7XAawj/sGBvGhUoQEMvEoH66ZzG/M6VpOnudkU8Y4wq1Zazhe8YFeG
         VBU9mzPnHlb1w/OgY5JgQnc6KWd3K7yWmcD2S+RRlARxRVWS1VObFH9mAk/7S3g+3Qsz
         YXIIEl1zXt4sfgfpG3aW5xYWQK63b95pfOWsVjGxqQTDcSjvBn9I7rs+x5x2mcwC3zXD
         Pb2zPc5J59jODCdsDLIkvrDpuJGvOo368pyQKea6bgOY8ieTr7QPh3zxQ3jmVVvSVsku
         YaLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=lwg1kG8+1/wNbjGSZ2PbJ4ea1sTg4029wAFJD+g5Qi4=;
        b=f7+PmG/YgK8vNWW82UPMx4uMZKOwXqaWoiwAhY9AJ1HwGwp5xJYb7gpsBuv4rQW4lC
         iitVdMKN+Wbo25kE1WQ8/GUA50+PF6M/Dz+0KOyp7pcY+Z1rZVetnIYYDiAminzPJ+yn
         PGgIw+wCo3KRgUkgo1pnGz5WWFRz4BCNF7ucjUrzPVGw/4bzZm2q90m33quNimYApu2q
         HNc9Ua8P205+26fi8noJhRBpH5W/daXaEh10rormsbYIFbsLRUecf0mEyEpkqXxdhA/R
         uCyv9hk6nPZ4aQdST9CLcbQF9pOmuqUU/SdQhhfYXuOxGR9OlpbPzA/UTTKq40m/RifT
         uxwg==
X-Gm-Message-State: AOAM532ZANT0zIht6PcA0IgCEC4Bi9cE7uRNf/qoHiqqMBGKjllcmwoV
        Ofpkc+TNLBUfuCFczmd1Nr9VOg2Uce0UQLApLA==
X-Google-Smtp-Source: ABdhPJwPvA9EBgeORhcNpGmqtT4iVpoccjQSHhBaKdbuYg64D0FqAMR8uclEjMkHcXhbagt529YZzXT1QLlZO+fSMw==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:2a20:cec4:8f41:cd6f])
 (user=kaleshsingh job=sendgmr) by 2002:a81:ff06:0:b0:2e6:d7bc:c812 with SMTP
 id k6-20020a81ff06000000b002e6d7bcc812mr22513276ywn.122.1650491158313; Wed,
 20 Apr 2022 14:45:58 -0700 (PDT)
Date:   Wed, 20 Apr 2022 14:42:55 -0700
In-Reply-To: <20220420214317.3303360-1-kaleshsingh@google.com>
Message-Id: <20220420214317.3303360-5-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220420214317.3303360-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
Subject: [PATCH v8 4/6] KVM: arm64: Add guard pages for pKVM (protected nVHE)
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
        Andrew Jones <drjones@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Changbin Du <changbin.du@intel.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=no autolearn_force=no version=3.4.6
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
2.36.0.rc0.470.gd361397f0d-goog


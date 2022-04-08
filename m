Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC854F9DE8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 22:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239336AbiDHUGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 16:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbiDHUGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 16:06:32 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C76E1C8A8F
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 13:04:27 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id p15-20020a25818f000000b0063daf5f7957so7549541ybk.12
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 13:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=vGOzm6wEc5ZJu/z76Pc4OmWnVkDbT1lO/lddjg12IXE=;
        b=rUA6y475P61rM5lqwSb9OqoqNh79eA7sv/HxbLZxdgaSlFH9dShNfu0fq5DzHE503f
         +3zuggND13GYxNUriO9tYaWp4UUfrjqmDXMcALqUPv7QZW3nfS3MwuUaPfx2RvM6p2ht
         OL0IG+mzOtgXulhQkBIIbmfuxSO7QAjjrFmiYmV19FwZbNySvX0ZvnxzD9AAycEcks/F
         zo61SXvyhe3SmzWLuyNcDVr310584XhMjL6tqTL8G8nBGk0dUs8w03sHvp/oRwWPqyVw
         bwDSMtE28u5zx9gVams/JAF3t8OvllyfgbnLAlA8vF9WrZIi7GIFC6KNAkMcOoHV5khT
         tziA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=vGOzm6wEc5ZJu/z76Pc4OmWnVkDbT1lO/lddjg12IXE=;
        b=bkWcmRKStLpJldIas1f83VcYsALppLWbXag3qZ/otyUo2DwmFgfweCaIVZsvcJlFjZ
         URnoKc1i8ZGmo+27XTeAI2mdKwBNbJLuHrsB5jKumpyyJVbfjXElXzLxrTkhOyZELYfe
         Fj7S3OhZ3cDaW5k4Duv1pbFEPSgvFzlvo87+6/obwrPia4/jPAcMpxD2bP/vzptmk4nm
         vZANTImYA2Mm2+ldqj8yu16wNrjRGSaReY/OIeE24EBGek1RVWmFCF6T/vDbXMiSukjk
         4RlMIraVu8E+y7ZIFdy5eauvy+Zk+9EHf2yk/KsrsmCIg/z24sR03Qvz3aD+BJW+PApG
         hybA==
X-Gm-Message-State: AOAM533RYc0jiweyYqVpsj6omBC4liQVOHRgZBbVSij488wcCYQOu0dc
        VgoB4ASsjpFqpgSYOrw6gn0cOdsAlBhXQHHSbw==
X-Google-Smtp-Source: ABdhPJy7bDbcYK9hv0FuHXGFrQmgggKoFAeK499e8yZjtgPh0IStbAziEvqq3t6BQ7easKktwaeWTk1bQ/5sq4tOsQ==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:f0ed:c8a:dab7:ecc2])
 (user=kaleshsingh job=sendgmr) by 2002:a5b:246:0:b0:619:5651:3907 with SMTP
 id g6-20020a5b0246000000b0061956513907mr15443681ybp.190.1649448266782; Fri,
 08 Apr 2022 13:04:26 -0700 (PDT)
Date:   Fri,  8 Apr 2022 13:03:24 -0700
In-Reply-To: <20220408200349.1529080-1-kaleshsingh@google.com>
Message-Id: <20220408200349.1529080-2-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220408200349.1529080-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
Subject: [PATCH v7 1/6] KVM: arm64: Introduce hyp_alloc_private_va_range()
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     will@kernel.org, maz@kernel.org, qperret@google.com,
        tabba@google.com, surenb@google.com, kernel-team@android.com,
        Kalesh Singh <kaleshsingh@google.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
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

hyp_alloc_private_va_range() can be used to reserve private VA ranges
in the nVHE hypervisor. Allocations are aligned based on the order of
the requested size.

This will be used to implement stack guard pages for KVM nVHE hypervisor
(nVHE Hyp mode / not pKVM), in a subsequent patch in the series.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
Tested-by: Fuad Tabba <tabba@google.com>
Reviewed-by: Fuad Tabba <tabba@google.com>
---

Changes in v7:
  - Add Fuad's Reviewed-by and Tested-by tags.

Changes in v6:
  - Update kernel-doc for hyp_alloc_private_va_range()
    and add return description, per Stephen
  - Update hyp_alloc_private_va_range() to return an int error code,
    per Stephen
  - Replace IS_ERR() checks with IS_ERR_VALUE() check, per Stephen
  - Clean up goto, per Stephen

Changes in v5:
  - Align private allocations based on the order of their size, per Marc

Changes in v4:
  - Handle null ptr in hyp_alloc_private_va_range() and replace
    IS_ERR_OR_NULL checks in callers with IS_ERR checks, per Fuad
  - Fix kernel-doc comments format, per Fuad

Changes in v3:
  - Handle null ptr in IS_ERR_OR_NULL checks, per Mark


 arch/arm64/include/asm/kvm_mmu.h |  1 +
 arch/arm64/kvm/mmu.c             | 66 +++++++++++++++++++++-----------
 2 files changed, 45 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 74735a864eee..a50cbb5ba402 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -154,6 +154,7 @@ static __always_inline unsigned long __kern_hyp_va(unsigned long v)
 int kvm_share_hyp(void *from, void *to);
 void kvm_unshare_hyp(void *from, void *to);
 int create_hyp_mappings(void *from, void *to, enum kvm_pgtable_prot prot);
+int hyp_alloc_private_va_range(size_t size, unsigned long *haddr);
 int create_hyp_io_mappings(phys_addr_t phys_addr, size_t size,
 			   void __iomem **kaddr,
 			   void __iomem **haddr);
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 0d19259454d8..3d3efea4e991 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -457,23 +457,22 @@ int create_hyp_mappings(void *from, void *to, enum kvm_pgtable_prot prot)
 	return 0;
 }
 
-static int __create_hyp_private_mapping(phys_addr_t phys_addr, size_t size,
-					unsigned long *haddr,
-					enum kvm_pgtable_prot prot)
+
+/**
+ * hyp_alloc_private_va_range - Allocates a private VA range.
+ * @size:	The size of the VA range to reserve.
+ * @haddr:	The hypervisor virtual start address of the allocation.
+ *
+ * The private virtual address (VA) range is allocated below io_map_base
+ * and aligned based on the order of @size.
+ *
+ * Return: 0 on success or negative error code on failure.
+ */
+int hyp_alloc_private_va_range(size_t size, unsigned long *haddr)
 {
 	unsigned long base;
 	int ret = 0;
 
-	if (!kvm_host_owns_hyp_mappings()) {
-		base = kvm_call_hyp_nvhe(__pkvm_create_private_mapping,
-					 phys_addr, size, prot);
-		if (IS_ERR_OR_NULL((void *)base))
-			return PTR_ERR((void *)base);
-		*haddr = base;
-
-		return 0;
-	}
-
 	mutex_lock(&kvm_hyp_pgd_mutex);
 
 	/*
@@ -484,30 +483,53 @@ static int __create_hyp_private_mapping(phys_addr_t phys_addr, size_t size,
 	 *
 	 * The allocated size is always a multiple of PAGE_SIZE.
 	 */
-	size = PAGE_ALIGN(size + offset_in_page(phys_addr));
-	base = io_map_base - size;
+	base = io_map_base - PAGE_ALIGN(size);
+
+	/* Align the allocation based on the order of its size */
+	base = ALIGN_DOWN(base, PAGE_SIZE << get_order(size));
 
 	/*
 	 * Verify that BIT(VA_BITS - 1) hasn't been flipped by
 	 * allocating the new area, as it would indicate we've
 	 * overflowed the idmap/IO address range.
 	 */
-	if ((base ^ io_map_base) & BIT(VA_BITS - 1))
+	if (!base || (base ^ io_map_base) & BIT(VA_BITS - 1))
 		ret = -ENOMEM;
 	else
-		io_map_base = base;
+		*haddr = io_map_base = base;
 
 	mutex_unlock(&kvm_hyp_pgd_mutex);
 
+	return ret;
+}
+
+static int __create_hyp_private_mapping(phys_addr_t phys_addr, size_t size,
+					unsigned long *haddr,
+					enum kvm_pgtable_prot prot)
+{
+	unsigned long addr;
+	int ret = 0;
+
+	if (!kvm_host_owns_hyp_mappings()) {
+		addr = kvm_call_hyp_nvhe(__pkvm_create_private_mapping,
+					 phys_addr, size, prot);
+		if (IS_ERR_VALUE(addr))
+			return addr;
+		*haddr = addr;
+
+		return 0;
+	}
+
+	size += offset_in_page(phys_addr);
+	ret = hyp_alloc_private_va_range(size, &addr);
 	if (ret)
-		goto out;
+		return ret;
 
-	ret = __create_hyp_mappings(base, size, phys_addr, prot);
+	ret = __create_hyp_mappings(addr, size, phys_addr, prot);
 	if (ret)
-		goto out;
+		return ret;
 
-	*haddr = base + offset_in_page(phys_addr);
-out:
+	*haddr = addr + offset_in_page(phys_addr);
 	return ret;
 }
 
-- 
2.35.1.1178.g4f1659d476-goog


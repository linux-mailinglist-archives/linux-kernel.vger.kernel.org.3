Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EAA04BFF5D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 17:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234381AbiBVQyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 11:54:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbiBVQyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 11:54:17 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D017C38DB0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 08:53:51 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2d07ae11462so146914547b3.8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 08:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=HjTQZhkAd40lRuvS6cRV70Tpnwq9dG8Hrk7s02bufrw=;
        b=l9gvPlFOgpm93Vwqfc4x5Vuvn4H98TzVtnPztFKq1RVJHuCOwjRWnhPGwbxmv2gBju
         qni22+lZAoWeuHyAnrHLkUxmGVg1MGvOPtvysJUTpVnxGE9XNCgdGG3ihOcgDh4Ud0VO
         t81B3SWw8tC8AP32YUnfVl7SNtvpxpe1ER/dZExOrnQ3bwmGSIvoILXJpsKsbYOeEn5X
         eNRw3J9xbd+PwHflrNv9W7603a/Ig+5VqL31ZqaFq/h7ygZQBquGNSxpt5WNmcJEKeuh
         799vMF4hFNUjwmMyaOlRkDXrCuhduGcEePOXQj+fAOq4j8VbFHa6wTIBzVfUzsaX0ujb
         tebQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=HjTQZhkAd40lRuvS6cRV70Tpnwq9dG8Hrk7s02bufrw=;
        b=sDmp9dFDLdaEbcbHl9InkAEhhOi6yRb7QOGP9rnm8jFnRPUmzbGZ4EqLHtt2YA5B3H
         AaOAXxbklt0uq+dPQz1/H4odQlwuhssgIfheLLxRSKRWOBLsziuTPVJcIMLA4Eg/L3dF
         OZ0jiHPXxD4VGqtblYIm7IrdMTnVN3H0zP66iOGlNrF3Amyzcl8sAOvahjFpziRTBW/2
         v0xcreuLo4e+ru5lrWUPPacsri8MMsyf1zrA8+X6nWiLOU9W+fvc4dVaFzXkybz6bXty
         kXSEViPhQWob010nq3Oy0iROvsiroAZUi1sievC6TeLrVve261xJ35/FXq6HB65h0wvg
         6vLQ==
X-Gm-Message-State: AOAM530aM1Dr3E0H6m6oJoECfbwRFna3UenUuSk8sc0EtKpziyWA/iJ2
        JE3hUm0DHM+DZbYm5VWVZ8/ZFmjXrGokwVXGcw==
X-Google-Smtp-Source: ABdhPJxqQdinLFWWaI+jsvW0KvgGVTkFzIldtere0/r0cpO5BgzuX/8Yyc3hdk7P6zZ0tb1mTeOyerwEEGUUJI16nw==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:5db7:1235:b3dd:cfcb])
 (user=kaleshsingh job=sendgmr) by 2002:a25:4dd7:0:b0:621:a740:3988 with SMTP
 id a206-20020a254dd7000000b00621a7403988mr24600128ybb.58.1645548831008; Tue,
 22 Feb 2022 08:53:51 -0800 (PST)
Date:   Tue, 22 Feb 2022 08:51:02 -0800
In-Reply-To: <20220222165212.2005066-1-kaleshsingh@google.com>
Message-Id: <20220222165212.2005066-2-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220222165212.2005066-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed-goog
Subject: [PATCH v2 1/9] KVM: arm64: Introduce hyp_alloc_private_va_range()
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     will@kernel.org, maz@kernel.org, qperret@google.com,
        tabba@google.com, surenb@google.com, kernel-team@android.com,
        Kalesh Singh <kaleshsingh@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Andrew Walbran <qwandor@google.com>,
        Andrew Scull <ascull@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu
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
in the nVHE hypervisor. Also update  __create_hyp_private_mapping()
to allow specifying an alignment for the private VA mapping.

These will be used to implement stack guard pages for KVM nVHE hypervisor
(nVHE Hyp mode / not pKVM), in a subsequent patch in the series.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
 arch/arm64/include/asm/kvm_mmu.h |  4 +++
 arch/arm64/kvm/mmu.c             | 61 +++++++++++++++++++++-----------
 2 files changed, 44 insertions(+), 21 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 81839e9a8a24..0b0c71302b92 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -153,6 +153,10 @@ static __always_inline unsigned long __kern_hyp_va(unsigned long v)
 int kvm_share_hyp(void *from, void *to);
 void kvm_unshare_hyp(void *from, void *to);
 int create_hyp_mappings(void *from, void *to, enum kvm_pgtable_prot prot);
+unsigned long hyp_alloc_private_va_range(size_t size, size_t align);
+int __create_hyp_private_mapping(phys_addr_t phys_addr, size_t size,
+				size_t align, unsigned long *haddr,
+				enum kvm_pgtable_prot prot);
 int create_hyp_io_mappings(phys_addr_t phys_addr, size_t size,
 			   void __iomem **kaddr,
 			   void __iomem **haddr);
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index bc2aba953299..e5abcce44ad0 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -457,22 +457,16 @@ int create_hyp_mappings(void *from, void *to, enum kvm_pgtable_prot prot)
 	return 0;
 }
 
-static int __create_hyp_private_mapping(phys_addr_t phys_addr, size_t size,
-					unsigned long *haddr,
-					enum kvm_pgtable_prot prot)
+
+/*
+ * Allocates a private VA range below io_map_base.
+ *
+ * @size:	The size of the VA range to reserve.
+ * @align:	The required alignment for the allocation.
+ */
+unsigned long hyp_alloc_private_va_range(size_t size, size_t align)
 {
 	unsigned long base;
-	int ret = 0;
-
-	if (!kvm_host_owns_hyp_mappings()) {
-		base = kvm_call_hyp_nvhe(__pkvm_create_private_mapping,
-					 phys_addr, size, prot);
-		if (IS_ERR_OR_NULL((void *)base))
-			return PTR_ERR((void *)base);
-		*haddr = base;
-
-		return 0;
-	}
 
 	mutex_lock(&kvm_hyp_pgd_mutex);
 
@@ -484,8 +478,8 @@ static int __create_hyp_private_mapping(phys_addr_t phys_addr, size_t size,
 	 *
 	 * The allocated size is always a multiple of PAGE_SIZE.
 	 */
-	size = PAGE_ALIGN(size + offset_in_page(phys_addr));
-	base = io_map_base - size;
+	base = io_map_base - PAGE_ALIGN(size);
+	base = ALIGN_DOWN(base, align);
 
 	/*
 	 * Verify that BIT(VA_BITS - 1) hasn't been flipped by
@@ -493,20 +487,45 @@ static int __create_hyp_private_mapping(phys_addr_t phys_addr, size_t size,
 	 * overflowed the idmap/IO address range.
 	 */
 	if ((base ^ io_map_base) & BIT(VA_BITS - 1))
-		ret = -ENOMEM;
+		base = (unsigned long)ERR_PTR(-ENOMEM);
 	else
 		io_map_base = base;
 
 	mutex_unlock(&kvm_hyp_pgd_mutex);
 
+	return base;
+}
+
+int __create_hyp_private_mapping(phys_addr_t phys_addr, size_t size,
+				size_t align, unsigned long *haddr,
+				enum kvm_pgtable_prot prot)
+{
+	unsigned long addr;
+	int ret = 0;
+
+	if (!kvm_host_owns_hyp_mappings()) {
+		addr = kvm_call_hyp_nvhe(__pkvm_create_private_mapping,
+					 phys_addr, size, prot);
+		if (IS_ERR_OR_NULL((void *)addr))
+			return PTR_ERR((void *)addr);
+		*haddr = addr;
+
+		return 0;
+	}
+
+	size += offset_in_page(phys_addr);
+	addr = hyp_alloc_private_va_range(size, align);
+	if (IS_ERR_OR_NULL((void *)addr))
+		return PTR_ERR((void *)addr);
+
 	if (ret)
 		goto out;
 
-	ret = __create_hyp_mappings(base, size, phys_addr, prot);
+	ret = __create_hyp_mappings(addr, size, phys_addr, prot);
 	if (ret)
 		goto out;
 
-	*haddr = base + offset_in_page(phys_addr);
+	*haddr = addr + offset_in_page(phys_addr);
 out:
 	return ret;
 }
@@ -537,7 +556,7 @@ int create_hyp_io_mappings(phys_addr_t phys_addr, size_t size,
 		return 0;
 	}
 
-	ret = __create_hyp_private_mapping(phys_addr, size,
+	ret = __create_hyp_private_mapping(phys_addr, size, PAGE_SIZE,
 					   &addr, PAGE_HYP_DEVICE);
 	if (ret) {
 		iounmap(*kaddr);
@@ -564,7 +583,7 @@ int create_hyp_exec_mappings(phys_addr_t phys_addr, size_t size,
 
 	BUG_ON(is_kernel_in_hyp_mode());
 
-	ret = __create_hyp_private_mapping(phys_addr, size,
+	ret = __create_hyp_private_mapping(phys_addr, size, PAGE_SIZE,
 					   &addr, PAGE_HYP_EXEC);
 	if (ret) {
 		*haddr = NULL;
-- 
2.35.1.473.g83b2b277ed-goog


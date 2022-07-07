Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B138756A641
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 16:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235781AbiGGOyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 10:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235647AbiGGOyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 10:54:18 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C402BDF
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 07:53:26 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id bh13so13022694pgb.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 07:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bTRYDtU3TfXTVrpCPr5XP4YlnFWx4gDO10dXPRwAC1M=;
        b=GEhguqGmoYJFVEvs+NpiG572m3t23Y+2koU02NLQyGj/XG06+PS+vhE7JuItFNi6YE
         Bgjgo28tRERL/w5FPNlvjaDUYMl9Vi2PivirIBPvyP7E0sKGGR6WxCuQBxGdH0A59lnl
         deFndm/BzJ+bTnAoxKU1Y4mZMMSOxT0hYFBOxvPEfU2kkeRdXr8eVmjlc82+cJNVodzU
         VGzMgJdbERaRVx0RsmkHclqql7EP8i/nSPo62UvU9VsRuU0xBHlRuRMzBA69dsXdyIvD
         inuLfhVroHD3XlPh8F/uYWdavda49LDP5Oc7IORLiRKa/7D2YQC4GIDGFMDDpp2uf7U6
         HSdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bTRYDtU3TfXTVrpCPr5XP4YlnFWx4gDO10dXPRwAC1M=;
        b=NRFe7QQxMh/EK6wLWSXAN+D+gUIQS2vCr5oBImw+RS7QCZKw0Rfh+kQUbFEfm+7fTm
         +LV0xAvS0jI4MIXoAxEHmAVN/zmmRt45AY2rd2mNfecBNqNPQbBJfYef77fV/C/PgJO2
         4MB6H8EH5H7X+1lJCugsi0SXC0dQC6KnKscpVDkBW8Sn9zovUSIrXD7LkvcdnlZRL6sR
         PHfM3EFcI44ztSs2fAFUxBwCtlA+IJG2p+0U7aNgJOBNpU6k4Im3jpTstMXdxBZ31BW4
         w/8gBIfFHlXMA5IZeB+qESlF6ktd/Mj1jrwnzatcBSTSqkrdZSHRP4KnuNeqZx+nUf6Y
         PkSA==
X-Gm-Message-State: AJIora9JRmo3yz0rgWq4Tcoeepx1OveO2MN6UN8HdpSE+jQ4dshxGXz7
        hG6KyTDyixmc91tJWf/r8OkXgQ==
X-Google-Smtp-Source: AGRyM1vxS1P61Y+TfG+zKPCn0BRbyCgaJ0HOcQ6NJyACrW+FQDboOYsQOFuiR8cqLU4vvZReT9ZR+Q==
X-Received: by 2002:a17:902:6b8b:b0:14d:66c4:f704 with SMTP id p11-20020a1709026b8b00b0014d66c4f704mr53750005plk.53.1657205605951;
        Thu, 07 Jul 2022 07:53:25 -0700 (PDT)
Received: from anup-ubuntu64-vm.. ([223.226.40.162])
        by smtp.gmail.com with ESMTPSA id b26-20020aa7951a000000b0052535e7c489sm27144231pfp.114.2022.07.07.07.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 07:53:25 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>
Subject: [PATCH 2/5] riscv: Fix missing PAGE_PFN_MASK
Date:   Thu,  7 Jul 2022 20:22:45 +0530
Message-Id: <20220707145248.458771-3-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220707145248.458771-1-apatel@ventanamicro.com>
References: <20220707145248.458771-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Ghiti <alexandre.ghiti@canonical.com>

There are a bunch of functions that use the PFN from a page table entry
that end up with the svpbmt upper-bits because they are missing the newly
introduced PAGE_PFN_MASK which leads to wrong addresses conversions and
then crash: fix this by adding this mask.

Fixes: 100631b48ded ("riscv: Fix accessing pfn bits in PTEs for non-32bit variants")
Signed-off-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
---
 arch/riscv/include/asm/pgtable-64.h | 12 ++++++------
 arch/riscv/include/asm/pgtable.h    |  6 +++---
 arch/riscv/kvm/mmu.c                |  2 +-
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
index 5c2aba5efbd0..dc42375c2357 100644
--- a/arch/riscv/include/asm/pgtable-64.h
+++ b/arch/riscv/include/asm/pgtable-64.h
@@ -175,7 +175,7 @@ static inline pud_t pfn_pud(unsigned long pfn, pgprot_t prot)
 
 static inline unsigned long _pud_pfn(pud_t pud)
 {
-	return pud_val(pud) >> _PAGE_PFN_SHIFT;
+	return __page_val_to_pfn(pud_val(pud));
 }
 
 static inline pmd_t *pud_pgtable(pud_t pud)
@@ -278,13 +278,13 @@ static inline p4d_t pfn_p4d(unsigned long pfn, pgprot_t prot)
 
 static inline unsigned long _p4d_pfn(p4d_t p4d)
 {
-	return p4d_val(p4d) >> _PAGE_PFN_SHIFT;
+	return __page_val_to_pfn(p4d_val(p4d));
 }
 
 static inline pud_t *p4d_pgtable(p4d_t p4d)
 {
 	if (pgtable_l4_enabled)
-		return (pud_t *)pfn_to_virt(p4d_val(p4d) >> _PAGE_PFN_SHIFT);
+		return (pud_t *)pfn_to_virt(__page_val_to_pfn(p4d_val(p4d)));
 
 	return (pud_t *)pud_pgtable((pud_t) { p4d_val(p4d) });
 }
@@ -292,7 +292,7 @@ static inline pud_t *p4d_pgtable(p4d_t p4d)
 
 static inline struct page *p4d_page(p4d_t p4d)
 {
-	return pfn_to_page(p4d_val(p4d) >> _PAGE_PFN_SHIFT);
+	return pfn_to_page(__page_val_to_pfn(p4d_val(p4d)));
 }
 
 #define pud_index(addr) (((addr) >> PUD_SHIFT) & (PTRS_PER_PUD - 1))
@@ -347,7 +347,7 @@ static inline void pgd_clear(pgd_t *pgd)
 static inline p4d_t *pgd_pgtable(pgd_t pgd)
 {
 	if (pgtable_l5_enabled)
-		return (p4d_t *)pfn_to_virt(pgd_val(pgd) >> _PAGE_PFN_SHIFT);
+		return (p4d_t *)pfn_to_virt(__page_val_to_pfn(pgd_val(pgd)));
 
 	return (p4d_t *)p4d_pgtable((p4d_t) { pgd_val(pgd) });
 }
@@ -355,7 +355,7 @@ static inline p4d_t *pgd_pgtable(pgd_t pgd)
 
 static inline struct page *pgd_page(pgd_t pgd)
 {
-	return pfn_to_page(pgd_val(pgd) >> _PAGE_PFN_SHIFT);
+	return pfn_to_page(__page_val_to_pfn(pgd_val(pgd)));
 }
 #define pgd_page(pgd)	pgd_page(pgd)
 
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 1d1be9d9419c..5dbd6610729b 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -261,7 +261,7 @@ static inline pgd_t pfn_pgd(unsigned long pfn, pgprot_t prot)
 
 static inline unsigned long _pgd_pfn(pgd_t pgd)
 {
-	return pgd_val(pgd) >> _PAGE_PFN_SHIFT;
+	return __page_val_to_pfn(pgd_val(pgd));
 }
 
 static inline struct page *pmd_page(pmd_t pmd)
@@ -590,14 +590,14 @@ static inline pmd_t pmd_mkinvalid(pmd_t pmd)
 	return __pmd(pmd_val(pmd) & ~(_PAGE_PRESENT|_PAGE_PROT_NONE));
 }
 
-#define __pmd_to_phys(pmd)  (pmd_val(pmd) >> _PAGE_PFN_SHIFT << PAGE_SHIFT)
+#define __pmd_to_phys(pmd)  (__page_val_to_pfn(pmd_val(pmd)) << PAGE_SHIFT)
 
 static inline unsigned long pmd_pfn(pmd_t pmd)
 {
 	return ((__pmd_to_phys(pmd) & PMD_MASK) >> PAGE_SHIFT);
 }
 
-#define __pud_to_phys(pud)  (pud_val(pud) >> _PAGE_PFN_SHIFT << PAGE_SHIFT)
+#define __pud_to_phys(pud)  (__page_val_to_pfn(pud_val(pud)) << PAGE_SHIFT)
 
 static inline unsigned long pud_pfn(pud_t pud)
 {
diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
index 2965284a490d..b75d4e200064 100644
--- a/arch/riscv/kvm/mmu.c
+++ b/arch/riscv/kvm/mmu.c
@@ -54,7 +54,7 @@ static inline unsigned long gstage_pte_index(gpa_t addr, u32 level)
 
 static inline unsigned long gstage_pte_page_vaddr(pte_t pte)
 {
-	return (unsigned long)pfn_to_virt(pte_val(pte) >> _PAGE_PFN_SHIFT);
+	return (unsigned long)pfn_to_virt(__page_val_to_pfn(pte_val(pte)));
 }
 
 static int gstage_page_size_to_level(unsigned long page_size, u32 *out_level)
-- 
2.34.1


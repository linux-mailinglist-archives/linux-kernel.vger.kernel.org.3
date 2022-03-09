Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD5E4D27DF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 05:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiCIELV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 23:11:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiCIEK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 23:10:59 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBFD212E9FF
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 20:10:01 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id m22so1269167pja.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 20:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H+7HXLBkyAOLpnbUPOmqITaSjFmsP/5pELWsoOHR/vE=;
        b=MfsGJPwWyDMvyL1T59Ih3sOsJ9u2v4j8aGO0XaZ3KIb4388ZkxhUtWz2kSSakAvdvQ
         fja25Gg2Me/TdX8V4mlvBtciwBfjO5nABn/gr+drVXhJhbFGzJJKkVT1vczzyfDhHbhr
         Zba5YFzibH3XBShb6rm9f0LqaZfu4yy0Hzfdv9bgyzFWWKib+WWxxR2g7XkPgl7gPr6O
         arfa2xO3VrRNUq/Ugck6YDY9QM66XUZ68Pv6/QoSRVVd6Rmj1iV4l6xPY4O91v1EPu/+
         t52TYmyxM0hSZHCkubEIF4LgasTDYOKMgMt/KOW/xgQCQCw5OiogWEOlaL9RSDAH/b9+
         rWvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H+7HXLBkyAOLpnbUPOmqITaSjFmsP/5pELWsoOHR/vE=;
        b=73Zdj4lDPt6wtUxC9SbLsWmlL1kxlVshPw2NQGXr7bsqgh1QgUz5dVxQJpg7WMn/R+
         nelrDsalFpg1oLCGAZpB5WO77AWimHG845sCOQlDK0CsJvrZ3y9Wzb9GQ2cDR8dVRCaG
         IcYqqcZUVhOToZXQWinyza5osdnO14aE/uH5BEzu6IPmyE6morNarcwzcMx7Su3sLMA8
         y9zgOqnzsQWsLkvIUeiRpfzvWEXPlKc20E+ot5/qj9tOisCKJDrgyJELEiLsK4Q10TsP
         8ZtBTFwqAlM1SsEDRurcH2IXs8hUAI+PgZopAMtxRWGNcPQivm7cyoJE4SKM9PfHwGbK
         Exig==
X-Gm-Message-State: AOAM531SEZ9R1F4uoZRghPet7qJotuVv2cfiUEGm9TjSYqpRmj9AE9KY
        2/zxQq4eXaTX41pFudEZQnk=
X-Google-Smtp-Source: ABdhPJxQZ3sgwqpjKvQcjt0M3A+/5t6QgTIum9HbB2Tsb3eB/2CY2OrWg3AwGO8ue9+92QN1YdadbA==
X-Received: by 2002:a17:90a:4289:b0:1bc:275b:8986 with SMTP id p9-20020a17090a428900b001bc275b8986mr8247190pjg.153.1646799001284;
        Tue, 08 Mar 2022 20:10:01 -0800 (PST)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id g5-20020a655805000000b003643e405b56sm604343pgr.24.2022.03.08.20.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 20:10:00 -0800 (PST)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>, x86@kernel.org
Subject: [PATCH v3 5/5] mm: avoid unnecessary flush on change_huge_pmd()
Date:   Tue,  8 Mar 2022 20:10:43 -0800
Message-Id: <20220309041043.302261-6-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220309041043.302261-1-namit@vmware.com>
References: <20220309041043.302261-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

Calls to change_protection_range() on THP can trigger, at least on x86,
two TLB flushes for one page: one immediately, when pmdp_invalidate() is
called by change_huge_pmd(), and then another one later (that can be
batched) when change_protection_range() finishes.

The first TLB flush is only necessary to prevent the dirty bit (and with
a lesser importance the access bit) from changing while the PTE is
modified. However, this is not necessary as the x86 CPUs set the
dirty-bit atomically with an additional check that the PTE is (still)
present. One caveat is Intel's Knights Landing that has a bug and does
not do so.

Leverage this behavior to eliminate the unnecessary TLB flush in
change_huge_pmd(). Introduce a new arch specific pmdp_invalidate_ad()
that only invalidates the access and dirty bit from further changes.

Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will@kernel.org>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Nick Piggin <npiggin@gmail.com>
Cc: x86@kernel.org
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/include/asm/pgtable.h |  5 +++++
 arch/x86/mm/pgtable.c          | 10 ++++++++++
 include/linux/pgtable.h        | 20 ++++++++++++++++++++
 mm/huge_memory.c               |  4 ++--
 mm/pgtable-generic.c           |  8 ++++++++
 5 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 62ab07e24aef..23ad34edcc4b 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1173,6 +1173,11 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
 	}
 }
 #endif
+
+#define __HAVE_ARCH_PMDP_INVALIDATE_AD
+extern pmd_t pmdp_invalidate_ad(struct vm_area_struct *vma,
+				unsigned long address, pmd_t *pmdp);
+
 /*
  * Page table pages are page-aligned.  The lower half of the top
  * level is used for userspace and the top half for the kernel.
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 3481b35cb4ec..b2fcb2c749ce 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -608,6 +608,16 @@ int pmdp_clear_flush_young(struct vm_area_struct *vma,
 
 	return young;
 }
+
+pmd_t pmdp_invalidate_ad(struct vm_area_struct *vma, unsigned long address,
+			 pmd_t *pmdp)
+{
+	pmd_t old = pmdp_establish(vma, address, pmdp, pmd_mkinvalid(*pmdp));
+
+	if (cpu_feature_enabled(X86_BUG_PTE_LEAK))
+		flush_pmd_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
+	return old;
+}
 #endif
 
 /**
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index f4f4077b97aa..5826e8e52619 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -570,6 +570,26 @@ extern pmd_t pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
 			    pmd_t *pmdp);
 #endif
 
+#ifndef __HAVE_ARCH_PMDP_INVALIDATE_AD
+
+/*
+ * pmdp_invalidate_ad() invalidates the PMD while changing a transparent
+ * hugepage mapping in the page tables. This function is similar to
+ * pmdp_invalidate(), but should only be used if the access and dirty bits would
+ * not be cleared by the software in the new PMD value. The function ensures
+ * that hardware changes of the access and dirty bits updates would not be lost.
+ *
+ * Doing so can allow in certain architectures to avoid a TLB flush in most
+ * cases. Yet, another TLB flush might be necessary later if the PMD update
+ * itself requires such flush (e.g., if protection was set to be stricter). Yet,
+ * even when a TLB flush is needed because of the update, the caller may be able
+ * to batch these TLB flushing operations, so fewer TLB flush operations are
+ * needed.
+ */
+extern pmd_t pmdp_invalidate_ad(struct vm_area_struct *vma,
+				unsigned long address, pmd_t *pmdp);
+#endif
+
 #ifndef __HAVE_ARCH_PTE_SAME
 static inline int pte_same(pte_t pte_a, pte_t pte_b)
 {
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 51b0f3cb1ba0..691d80edcfd7 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1781,10 +1781,10 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	 * The race makes MADV_DONTNEED miss the huge pmd and don't clear it
 	 * which may break userspace.
 	 *
-	 * pmdp_invalidate() is required to make sure we don't miss
+	 * pmdp_invalidate_ad() is required to make sure we don't miss
 	 * dirty/young flags set by hardware.
 	 */
-	oldpmd = pmdp_invalidate(vma, addr, pmd);
+	oldpmd = pmdp_invalidate_ad(vma, addr, pmd);
 
 	entry = pmd_modify(oldpmd, newprot);
 	if (preserve_write)
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index 6523fda274e5..90ab721a12a8 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -201,6 +201,14 @@ pmd_t pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
 }
 #endif
 
+#ifndef __HAVE_ARCH_PMDP_INVALIDATE_AD
+pmd_t pmdp_invalidate_ad(struct vm_area_struct *vma, unsigned long address,
+			 pmd_t *pmdp)
+{
+	return pmdp_invalidate(vma, address, pmdp);
+}
+#endif
+
 #ifndef pmdp_collapse_flush
 pmd_t pmdp_collapse_flush(struct vm_area_struct *vma, unsigned long address,
 			  pmd_t *pmdp)
-- 
2.25.1


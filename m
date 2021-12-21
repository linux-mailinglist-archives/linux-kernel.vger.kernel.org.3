Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2C6C47C356
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 16:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236761AbhLUPq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 10:46:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236675AbhLUPqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 10:46:55 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17BDC06173F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 07:46:55 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id t11so13222302qtw.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 07:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=8lYwPz/4m3tDnSwW80VP9nsgiF1z9D2++nKEW6hl0KA=;
        b=kO8yGAwFB3DggVZ93fPld7nNchSHxNZW2NmK+E+Zhg/kPc9IUvAJr7Riv6SFkBYvSS
         Ch+8U2tozsmQnKCF1kRrpen+bCce4/fnW/fvR6gpy60FmL+f1PH5MT+LPk9Itli4RXPQ
         mFPsXKYT5fAaH2slrqgjPYEDdMPEcAyYLarVP3uEYLgNajmhicBZUCE/9uOvl3+uK/d+
         tX57f3ADUC538hwUiPUZx3mVZMKQ1pGZPZ3fqhvsetg9pNFsUQ9if3L2RPeoefEVJdju
         WPrj0vvglEUYoiXd5zdxvY1LhKIeTyAJIg2sWzBWRAI+aIxGmqe/Nyl/LLRtmZ0xihpt
         G+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8lYwPz/4m3tDnSwW80VP9nsgiF1z9D2++nKEW6hl0KA=;
        b=OZN5zo+983WcLPVojRn+V85TSn6ACs5094EwvbH6315tmA1xcCJRuDicZIZOU/zCKu
         j9HaEASvdgx5AujCfAeV44jNr7k2Vghw1p6fpNwnHubs7ljfHVQdTC3IQ6EyD7Om0PLe
         EwUtK6i49e3ng9oY9mdVKG1Vf8szTFp2rjCsrkU0r4fc+fOdCmz7CsDon2NV27dH2p1p
         LbtTjKBZGN0LZ7plr1HuOSNfO/u8nHsDjeR0Wn+S8ll37GKMXzWIFmV8LGbiyla2nWV7
         hD97AxcBzy/B3/LPSrAgWQQw5xu5tcC3viqyNn392VMnw2dI3QveTAxoSUhQhVkVtt1P
         Xotg==
X-Gm-Message-State: AOAM532UcTtox/9vl2DNrpB92Dj4RhN5S/vePfnTf+wFDFMyHHhPqp8f
        66D6pKcttDA+iLfr6r+AUhPKGw==
X-Google-Smtp-Source: ABdhPJyeJtPKa7tGYCh0gZkqHjPcdfCZESI0/adSt3JTZTkT3vCpCDexDTbFfki3nLwOQ4rZwOtgMQ==
X-Received: by 2002:ac8:7774:: with SMTP id h20mr2730148qtu.236.1640101614863;
        Tue, 21 Dec 2021 07:46:54 -0800 (PST)
Received: from soleen.c.googlers.com.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id d20sm224588qtg.73.2021.12.21.07.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 07:46:54 -0800 (PST)
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        akpm@linux-foundation.org, rientjes@google.com, pjt@google.com,
        weixugc@google.com, gthelen@google.com, mingo@redhat.com,
        corbet@lwn.net, will@kernel.org, rppt@kernel.org,
        keescook@chromium.org, tglx@linutronix.de, peterz@infradead.org,
        masahiroy@kernel.org, samitolvanen@google.com,
        dave.hansen@linux.intel.com, x86@kernel.org, frederic@kernel.org,
        hpa@zytor.com, aneesh.kumar@linux.ibm.com, jirislaby@kernel.org,
        songmuchun@bytedance.com, qydwhotmail@gmail.com, hughd@google.com
Subject: [PATCH v3 2/4] mm: ptep_clear() page table helper
Date:   Tue, 21 Dec 2021 15:46:48 +0000
Message-Id: <20211221154650.1047963-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
In-Reply-To: <20211221154650.1047963-1-pasha.tatashin@soleen.com>
References: <20211221154650.1047963-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have ptep_get_and_clear() and ptep_get_and_clear_full() helpers to
clear PTE from user page tables, but there is no variant for simple clear
of a present PTE from user page tables without using a low level
pte_clear() which can be either native or para-virtualised.

Add a new ptep_clear() that can be used in common code to clear PTEs from
page table.  We will need this call later in order to add a hook for page
table check.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 Documentation/vm/arch_pgtable_helpers.rst |  6 ++++--
 include/linux/pgtable.h                   |  8 ++++++++
 mm/debug_vm_pgtable.c                     |  2 +-
 mm/khugepaged.c                           | 12 ++----------
 4 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/Documentation/vm/arch_pgtable_helpers.rst b/Documentation/vm/arch_pgtable_helpers.rst
index 552567d863b8..fbe06ec75370 100644
--- a/Documentation/vm/arch_pgtable_helpers.rst
+++ b/Documentation/vm/arch_pgtable_helpers.rst
@@ -66,9 +66,11 @@ PTE Page Table Helpers
 +---------------------------+--------------------------------------------------+
 | pte_mknotpresent          | Invalidates a mapped PTE                         |
 +---------------------------+--------------------------------------------------+
-| ptep_get_and_clear        | Clears a PTE                                     |
+| ptep_clear                | Clears a PTE                                     |
 +---------------------------+--------------------------------------------------+
-| ptep_get_and_clear_full   | Clears a PTE                                     |
+| ptep_get_and_clear        | Clears and returns PTE                           |
++---------------------------+--------------------------------------------------+
+| ptep_get_and_clear_full   | Clears and returns PTE (batched PTE unmap)       |
 +---------------------------+--------------------------------------------------+
 | ptep_test_and_clear_young | Clears young from a PTE                          |
 +---------------------------+--------------------------------------------------+
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index e24d2c992b11..bc8713a76e03 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -258,6 +258,14 @@ static inline int pmdp_clear_flush_young(struct vm_area_struct *vma,
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 #endif
 
+#ifndef __HAVE_ARCH_PTEP_CLEAR
+static inline void ptep_clear(struct mm_struct *mm, unsigned long addr,
+			      pte_t *ptep)
+{
+	pte_clear(mm, addr, ptep);
+}
+#endif
+
 #ifndef __HAVE_ARCH_PTEP_GET_AND_CLEAR
 static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
 				       unsigned long address,
diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index 228e3954b90c..cd48a34c87a4 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -652,7 +652,7 @@ static void __init pte_clear_tests(struct pgtable_debug_args *args)
 	set_pte_at(args->mm, args->vaddr, args->ptep, pte);
 	flush_dcache_page(page);
 	barrier();
-	pte_clear(args->mm, args->vaddr, args->ptep);
+	ptep_clear(args->mm, args->vaddr, args->ptep);
 	pte = ptep_get(args->ptep);
 	WARN_ON(!pte_none(pte));
 }
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index ed0fa6368706..7720189a2da7 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -756,11 +756,7 @@ static void __collapse_huge_page_copy(pte_t *pte, struct page *page,
 				 * ptl mostly unnecessary.
 				 */
 				spin_lock(ptl);
-				/*
-				 * paravirt calls inside pte_clear here are
-				 * superfluous.
-				 */
-				pte_clear(vma->vm_mm, address, _pte);
+				ptep_clear(vma->vm_mm, address, _pte);
 				spin_unlock(ptl);
 			}
 		} else {
@@ -774,11 +770,7 @@ static void __collapse_huge_page_copy(pte_t *pte, struct page *page,
 			 * inside page_remove_rmap().
 			 */
 			spin_lock(ptl);
-			/*
-			 * paravirt calls inside pte_clear here are
-			 * superfluous.
-			 */
-			pte_clear(vma->vm_mm, address, _pte);
+			ptep_clear(vma->vm_mm, address, _pte);
 			page_remove_rmap(src_page, false);
 			spin_unlock(ptl);
 			free_page_and_swap_cache(src_page);
-- 
2.34.1.307.g9b7440fafd-goog


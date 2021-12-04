Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C01DE468708
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 19:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385502AbhLDS1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 13:27:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385437AbhLDS0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 13:26:45 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8DA8C0611F7
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 10:23:19 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id a11so7005309qkh.13
        for <linux-kernel@vger.kernel.org>; Sat, 04 Dec 2021 10:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=n0YxASesL46VAjA2z/ow7KiwVFM+As8nZthIAhuXqxc=;
        b=cZli0N6zOSpC45lUPq9JIwM3qMTdcJqy5cXESpOiwRbnre5M851x2er9c63mkwjv4Q
         uZ6zKOY/dgEq+9jE+eomZ2x8TJ91msWC7d2P1SSOobtxZ5UcJN3O5fzMjx+Le3PrA9wO
         e7uN/tRxynz9BBw95UC15OyqWsqJhGktg1lh7hTozhwb4A0lkxkLSJXZt8k/MQ5eXTgF
         uYQyrBzu5NQPMYVQ+wIH5Tr8SutWuNh+JvU/ijy742A+kPVWvk9N+JDOrqEjIHkS6oIm
         7E2+8K0XR4s3PvG/2abBAbDRK9vYTbjiIqdAGO0OIJfUy8ybBYdSeLEIaZRgIXBYNQiL
         dqxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n0YxASesL46VAjA2z/ow7KiwVFM+As8nZthIAhuXqxc=;
        b=qxdZdIoXcXuL2YLmkxtRuo8MmySgI/X86S0WM/6zVY7Sq26cMMlAw34wOQe0IBaVu/
         bodT52vG6Z7v1Wg4gXqDiZWu3f8wsKjOBbf7Z4H4jduMHRJMBngTsvk5dkis5snVVfY8
         bYxmsDT6YcyGBdbTpa1PhypgiDZLf/UGuhpWWfUEFyIeDLrQTkW0mai33P8T62y8D3xv
         qwq7VDMH//H09hGNNZlRbsCvlsUDUQT4Q+N9VCbvvTtD0ljmHCLBy6OJsvOh1pP8aPyC
         4YLWCWHgZiv0ZzrDd0HReLWrMLk2FOOlqmbpxEIOkdtQp/JwuCOZX2/1xr//xVSFai79
         ENtw==
X-Gm-Message-State: AOAM531I+TMkw82x+RmYx1Yk3jFWbCTgc1Pmi2b1Y31axstCyGu/73Fs
        dB660yrWKzG3M+3qSZW5MKO8Cw==
X-Google-Smtp-Source: ABdhPJxPsFEDpwBIvnp31rmo1LtzlRi+tnB4h7nFDAuMVVnO2bCon47rS34C6Luf9oKpBoZsxJ0Eqg==
X-Received: by 2002:a37:b182:: with SMTP id a124mr24022872qkf.135.1638642198919;
        Sat, 04 Dec 2021 10:23:18 -0800 (PST)
Received: from soleen.c.googlers.com.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id a24sm4394728qtp.95.2021.12.04.10.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 10:23:18 -0800 (PST)
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
        songmuchun@bytedance.com, qydwhotmail@gmail.com
Subject: [PATCH v2 2/4] mm: ptep_clear() page table helper
Date:   Sat,  4 Dec 2021 18:23:12 +0000
Message-Id: <20211204182314.1470076-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
In-Reply-To: <20211204182314.1470076-1-pasha.tatashin@soleen.com>
References: <20211204182314.1470076-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have ptep_get_and_clear() and ptep_get_and_clear_full() helpers to
clear PTE from user page tables, but there is no variant for simple
clear of a present PTE from user page tables without using a low level
pte_clear() which can be either native or para-virtualised.

Add a new ptep_clear() that can be used in common code to clear PTEs
from page table. We will need this call later in order to add a hook
for page table check.

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
index dd807261ed9f..c78242d15406 100644
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
2.34.1.400.ga245620fadb-goog


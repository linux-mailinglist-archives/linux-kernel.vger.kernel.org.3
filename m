Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC2746870A
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 19:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385469AbhLDS1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 13:27:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385461AbhLDS0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 13:26:47 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88ECFC061D60
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 10:23:21 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id i12so6054229qvh.11
        for <linux-kernel@vger.kernel.org>; Sat, 04 Dec 2021 10:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=JjYKEJcTyq7gxxwF/qsfUV8xV15YsFb8MoAiHyojDyw=;
        b=fxFPKGKGmjFVeeQhXbIUZYdRSXvIWE/CzCjUnvZrLiETxDBowMyU/cmr4fjdBfMxoj
         IfE5nyLBXTp10mSWnOmKjr+8PSJqHahFmmhLQrO6bV0tnTKYZaOXITNLJF8UmTUu6i+5
         QTKH/xSpLDBkEHwemKUTiLxwrQKxUxbedRLWGYFeFz9wLJVtCqQebPorPKgigVsj/qzo
         MRUVGDlGzUzfbvxMqGrmPLD3GiwhD3ewCPTtPSDVRFDlaMiyXwFHFcrhlw6BDYDTIqhH
         MqnHoVvmqaL/uFqOIsLIW17hJHEyl36jkrqr6vkJzjrHfuc1chqtRQTCFW8GcD6apMDW
         M2pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JjYKEJcTyq7gxxwF/qsfUV8xV15YsFb8MoAiHyojDyw=;
        b=3/yZqVATbd7NLg8FXHk+Gbg34D9RTntQa0JioO56H+u7QFGeYLXq6UYX3UU4nx3mBZ
         JqleCTwihkp9N2KDLrbZOFFBo8YC2AYMLiObP3NhqnXu1/cWl5nnau/4Gx7KVjwauSn5
         GRCDSDDUzrg+URVuaTgpLp4twI40BfVbx1QdqIzgY4JPLYZduuMdjXVOe0DNd289Hq85
         7D3xrbzyGh5ZhoGmynmDK7ra4kJS8juUKICJ0SL7lHDMMgpDDQgNnFroe9+RiPoqggih
         kH3Y8SJvMjBHnAvLSF6WQdfkk6RjMj6/xPtzYWmzbOTYcRBCSAmy1/E98s9SPQ6mI9F+
         DpVg==
X-Gm-Message-State: AOAM530FdlfwbTaWlW6oUOmOnymKvJrHQNxzAou7Jj/3snjQXEjXbPKs
        Vof+eqn7S0nbaULAI7zrDF/otWy3YuxVHw==
X-Google-Smtp-Source: ABdhPJxIq+kzgXQQCk00YqMBJ4oav+C29EWpXkfE4hU1sZ72bgR5ZiRVt5i/2I3KRZFKaZcjkTvslA==
X-Received: by 2002:ad4:4452:: with SMTP id l18mr26855725qvt.8.1638642200754;
        Sat, 04 Dec 2021 10:23:20 -0800 (PST)
Received: from soleen.c.googlers.com.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id a24sm4394728qtp.95.2021.12.04.10.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 10:23:20 -0800 (PST)
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
Subject: [PATCH v2 4/4] x86: mm: add x86_64 support for page table check
Date:   Sat,  4 Dec 2021 18:23:14 +0000
Message-Id: <20211204182314.1470076-5-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
In-Reply-To: <20211204182314.1470076-1-pasha.tatashin@soleen.com>
References: <20211204182314.1470076-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add page table check hooks into routines that modify user page tables.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 arch/x86/Kconfig               |  1 +
 arch/x86/include/asm/pgtable.h | 29 +++++++++++++++++++++++++++--
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 5e16393d9988..7636ea400a71 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -104,6 +104,7 @@ config X86
 	select ARCH_SUPPORTS_ACPI
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_SUPPORTS_DEBUG_PAGEALLOC
+	select ARCH_SUPPORTS_PAGE_TABLE_CHECK	if X86_64
 	select ARCH_SUPPORTS_NUMA_BALANCING	if X86_64
 	select ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP	if NR_CPUS <= 4096
 	select ARCH_SUPPORTS_LTO_CLANG
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 448cd01eb3ec..ae34614b7e8d 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -26,6 +26,7 @@
 #include <asm/pkru.h>
 #include <asm/fpu/api.h>
 #include <asm-generic/pgtable_uffd.h>
+#include <linux/page_table_check.h>
 
 extern pgd_t early_top_pgt[PTRS_PER_PGD];
 bool __init __early_make_pgtable(unsigned long address, pmdval_t pmd);
@@ -1006,18 +1007,21 @@ static inline pud_t native_local_pudp_get_and_clear(pud_t *pudp)
 static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
 			      pte_t *ptep, pte_t pte)
 {
+	page_table_check_pte_set(mm, addr, ptep, pte);
 	set_pte(ptep, pte);
 }
 
 static inline void set_pmd_at(struct mm_struct *mm, unsigned long addr,
 			      pmd_t *pmdp, pmd_t pmd)
 {
+	page_table_check_pmd_set(mm, addr, pmdp, pmd);
 	set_pmd(pmdp, pmd);
 }
 
 static inline void set_pud_at(struct mm_struct *mm, unsigned long addr,
 			      pud_t *pudp, pud_t pud)
 {
+	page_table_check_pud_set(mm, addr, pudp, pud);
 	native_set_pud(pudp, pud);
 }
 
@@ -1048,6 +1052,7 @@ static inline pte_t ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
 				       pte_t *ptep)
 {
 	pte_t pte = native_ptep_get_and_clear(ptep);
+	page_table_check_pte_clear(mm, addr, pte);
 	return pte;
 }
 
@@ -1063,12 +1068,23 @@ static inline pte_t ptep_get_and_clear_full(struct mm_struct *mm,
 		 * care about updates and native needs no locking
 		 */
 		pte = native_local_ptep_get_and_clear(ptep);
+		page_table_check_pte_clear(mm, addr, pte);
 	} else {
 		pte = ptep_get_and_clear(mm, addr, ptep);
 	}
 	return pte;
 }
 
+#define __HAVE_ARCH_PTEP_CLEAR
+static inline void ptep_clear(struct mm_struct *mm, unsigned long addr,
+			      pte_t *ptep)
+{
+	if (IS_ENABLED(CONFIG_PAGE_TABLE_CHECK))
+		ptep_get_and_clear(mm, addr, ptep);
+	else
+		pte_clear(mm, addr, ptep);
+}
+
 #define __HAVE_ARCH_PTEP_SET_WRPROTECT
 static inline void ptep_set_wrprotect(struct mm_struct *mm,
 				      unsigned long addr, pte_t *ptep)
@@ -1109,14 +1125,22 @@ static inline int pmd_write(pmd_t pmd)
 static inline pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm, unsigned long addr,
 				       pmd_t *pmdp)
 {
-	return native_pmdp_get_and_clear(pmdp);
+	pmd_t pmd = native_pmdp_get_and_clear(pmdp);
+
+	page_table_check_pmd_clear(mm, addr, pmd);
+
+	return pmd;
 }
 
 #define __HAVE_ARCH_PUDP_HUGE_GET_AND_CLEAR
 static inline pud_t pudp_huge_get_and_clear(struct mm_struct *mm,
 					unsigned long addr, pud_t *pudp)
 {
-	return native_pudp_get_and_clear(pudp);
+	pud_t pud = native_pudp_get_and_clear(pudp);
+
+	page_table_check_pud_clear(mm, addr, pud);
+
+	return pud;
 }
 
 #define __HAVE_ARCH_PMDP_SET_WRPROTECT
@@ -1137,6 +1161,7 @@ static inline int pud_write(pud_t pud)
 static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
 		unsigned long address, pmd_t *pmdp, pmd_t pmd)
 {
+	page_table_check_pmd_set(vma->vm_mm, address, pmdp, pmd);
 	if (IS_ENABLED(CONFIG_SMP)) {
 		return xchg(pmdp, pmd);
 	} else {
-- 
2.34.1.400.ga245620fadb-goog


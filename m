Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0BB04A502C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 21:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378885AbiAaUdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 15:33:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378817AbiAaUc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 15:32:57 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5F0C061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 12:32:56 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id w8so13214921qkw.8
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 12:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ztMzOXuGTev/L+fnIZswc+dCNyphqzRLyPQWRmdFkGQ=;
        b=Md6GZ12Jl8JVEpV/uGyYEs0IP3JBRv0zFtP+THkOMK7/Sr8KxQ7O9qiU+8DW/TzpNC
         Akc5nWbdd35Z3AqErZVBsGtXj+3F+SrZ9IIn+7RS6XqDfLQdq3Dv3BQlUtwGX2qweZSb
         /bWB+7PT+wjthvCUUbSwK8+lmPKQXhcFXy0Kp1t0Bcjpw0EXmzL1cGfVIMBR0NfbdUUq
         mIE4DJeLUC7E4uC4wB+mSQbmS5A7bgKJYfLjZd+gYMmrZH8qw3K5rW/ES4bQfgIA3l50
         xTxC9ATLUYebxRDdso0G9dbU2k2bni9mX7X3AV6CzbxsVGhBEI2r4qtyLn0+0ALREg9m
         DU0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ztMzOXuGTev/L+fnIZswc+dCNyphqzRLyPQWRmdFkGQ=;
        b=hZFf2I8mPlSNeHYbfqXW1RL+nzLy1ZDZU0Dtc30VF3miPjiRmkKgFgyadpqBrRzTZn
         lo3tcBF3sEXYOBtFdY/MQE+XBV8J8fpYx+L9NRZIbdh7ZlM8Fi6dqOtoFEg2/FNMX5ro
         fYeJ+QUQGMcaTpAmkkX9dV+SIs454lzqsToz0IqxIFfuPa/YVkDwXYZW+j35+5JdjKpw
         7s3BTtR5NWAWG8ajw4QvJIkrvWMXxd98GgQLQxDVpclvONdCkmKp4YN2RfbG70bbeY+g
         whAjepmOlCexZTrDxtBcQVqPkV1359MNwQZ9QC2OU72U8NFFDKgOJAFJzRYXqJq0aoQg
         HeMg==
X-Gm-Message-State: AOAM532/eD2TyRIjihD6Hg5R3hf/CfDBZWrHLrO0/gJNwbJU7GZWpv04
        Aire0xDpeNsdaY2AxmYE0Xp2wA==
X-Google-Smtp-Source: ABdhPJy7TkmRAP3kG1fRwG+5u3nYXG/B+PDJTVHIT7qNMvRw2rYa1WyDbrqsKB6mPHKWvTMPZpXt/g==
X-Received: by 2002:a05:620a:4151:: with SMTP id k17mr14312024qko.630.1643661176090;
        Mon, 31 Jan 2022 12:32:56 -0800 (PST)
Received: from soleen.c.googlers.com.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id j14sm5349661qko.10.2022.01.31.12.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 12:32:55 -0800 (PST)
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, rientjes@google.com,
        pjt@google.com, weixugc@google.com, gthelen@google.com,
        mingo@redhat.com, will@kernel.org, rppt@kernel.org,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        aneesh.kumar@linux.ibm.com, jirislaby@kernel.org,
        songmuchun@bytedance.com, qydwhotmail@gmail.com, hughd@google.com,
        ziy@nvidia.com, anshuman.khandual@arm.com
Subject: [PATCH v5 2/4] mm/page_table_check: use unsigned long for page counters and cleanup
Date:   Mon, 31 Jan 2022 20:32:47 +0000
Message-Id: <20220131203249.2832273-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
In-Reply-To: <20220131203249.2832273-1-pasha.tatashin@soleen.com>
References: <20220131203249.2832273-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the consistency, use "unsigned long" for all page counters.

Also, reduce code duplication by calling
__page_table_check_*_clear() from __page_table_check_*_set() functions.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Wei Xu <weixugc@google.com>
Acked-by: David Rientjes <rientjes@google.com>
---
 mm/page_table_check.c | 35 +++++++----------------------------
 1 file changed, 7 insertions(+), 28 deletions(-)

diff --git a/mm/page_table_check.c b/mm/page_table_check.c
index 7504e7caa2a1..c61d7ebe13b1 100644
--- a/mm/page_table_check.c
+++ b/mm/page_table_check.c
@@ -86,8 +86,8 @@ static void page_table_check_clear(struct mm_struct *mm, unsigned long addr,
 {
 	struct page_ext *page_ext;
 	struct page *page;
+	unsigned long i;
 	bool anon;
-	int i;
 
 	if (!pfn_valid(pfn))
 		return;
@@ -121,8 +121,8 @@ static void page_table_check_set(struct mm_struct *mm, unsigned long addr,
 {
 	struct page_ext *page_ext;
 	struct page *page;
+	unsigned long i;
 	bool anon;
-	int i;
 
 	if (!pfn_valid(pfn))
 		return;
@@ -152,10 +152,10 @@ static void page_table_check_set(struct mm_struct *mm, unsigned long addr,
 void __page_table_check_zero(struct page *page, unsigned int order)
 {
 	struct page_ext *page_ext = lookup_page_ext(page);
-	int i;
+	unsigned long i;
 
 	BUG_ON(!page_ext);
-	for (i = 0; i < (1 << order); i++) {
+	for (i = 0; i < (1ul << order); i++) {
 		struct page_table_check *ptc = get_page_table_check(page_ext);
 
 		BUG_ON(atomic_read(&ptc->anon_map_count));
@@ -206,17 +206,10 @@ EXPORT_SYMBOL(__page_table_check_pud_clear);
 void __page_table_check_pte_set(struct mm_struct *mm, unsigned long addr,
 				pte_t *ptep, pte_t pte)
 {
-	pte_t old_pte;
-
 	if (&init_mm == mm)
 		return;
 
-	old_pte = *ptep;
-	if (pte_user_accessible_page(old_pte)) {
-		page_table_check_clear(mm, addr, pte_pfn(old_pte),
-				       PAGE_SIZE >> PAGE_SHIFT);
-	}
-
+	__page_table_check_pte_clear(mm, addr, *ptep);
 	if (pte_user_accessible_page(pte)) {
 		page_table_check_set(mm, addr, pte_pfn(pte),
 				     PAGE_SIZE >> PAGE_SHIFT,
@@ -228,17 +221,10 @@ EXPORT_SYMBOL(__page_table_check_pte_set);
 void __page_table_check_pmd_set(struct mm_struct *mm, unsigned long addr,
 				pmd_t *pmdp, pmd_t pmd)
 {
-	pmd_t old_pmd;
-
 	if (&init_mm == mm)
 		return;
 
-	old_pmd = *pmdp;
-	if (pmd_user_accessible_page(old_pmd)) {
-		page_table_check_clear(mm, addr, pmd_pfn(old_pmd),
-				       PMD_PAGE_SIZE >> PAGE_SHIFT);
-	}
-
+	__page_table_check_pmd_clear(mm, addr, *pmdp);
 	if (pmd_user_accessible_page(pmd)) {
 		page_table_check_set(mm, addr, pmd_pfn(pmd),
 				     PMD_PAGE_SIZE >> PAGE_SHIFT,
@@ -250,17 +236,10 @@ EXPORT_SYMBOL(__page_table_check_pmd_set);
 void __page_table_check_pud_set(struct mm_struct *mm, unsigned long addr,
 				pud_t *pudp, pud_t pud)
 {
-	pud_t old_pud;
-
 	if (&init_mm == mm)
 		return;
 
-	old_pud = *pudp;
-	if (pud_user_accessible_page(old_pud)) {
-		page_table_check_clear(mm, addr, pud_pfn(old_pud),
-				       PUD_PAGE_SIZE >> PAGE_SHIFT);
-	}
-
+	__page_table_check_pud_clear(mm, addr, *pudp);
 	if (pud_user_accessible_page(pud)) {
 		page_table_check_set(mm, addr, pud_pfn(pud),
 				     PUD_PAGE_SIZE >> PAGE_SHIFT,
-- 
2.35.0.rc2.247.g8bbb082509-goog


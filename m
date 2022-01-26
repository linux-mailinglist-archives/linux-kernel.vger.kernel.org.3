Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5619C49D1D7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 19:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244224AbiAZSgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 13:36:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbiAZSgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 13:36:42 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A554C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 10:36:42 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id g11so643781qvu.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 10:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=NIQdhozYZQYwJuXanYTpSkQiAWCcpJhyfoG58pHCslA=;
        b=Bo3Fdqy4H5CvO8zl5pomEkR1gp3x8MwUzxy7Z5HKmiSyjdlsmqjAhR00ywO5pAO3x4
         uNdiT3FyK6gp2JqbGiSd/Q2PthIYWdhPSdAn5TOjaihu46l72mfeiNMyhA7dutVKxnFC
         wA+rf72VjD8j3THQUhwX2QykoPzF+4MFSz1Y3IID6oxp2xlAXoMzoIpb0MJF9DKU6SnM
         xOgftlP8LGcFpqOtobCRLgW+R/1Ngani8djbZ77zWs9MEs9OHHcuEOJ5C1cSxMkRCd16
         eGxndmGbnEooWd/kaYhc+on4vEHAeG6wRjeebLrkxHZo73GVcyyxKk2j8j8Ue86rPdzi
         9RKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NIQdhozYZQYwJuXanYTpSkQiAWCcpJhyfoG58pHCslA=;
        b=AEo4IUUy13N0dAwbHY5ktkP3nFEEqzPGOIoj6Bh2oh3V5iwT0FIHZvC+4jVGqGtsGx
         73jR0JLOn1BGzQblgbmTWakTXHUJPf8pxnDg1jwFoIdW09TW3Qm793lyd2y2tJoCq7Ci
         jzFqB7Dtkw5CoiSfc9oAgy5DCPgS7y5pA0Pic+KkUKUSk9KOZyn87iWFf/H+ROLoSR8r
         inM3/X//msqxn7uBIpvxypc3up6pqT7YvZcZXnXDJ0AUnZJ5vrQYQyLKXaABaUONVO3C
         UfSSmgou7vUnXcYVmnv4gkYlr2cm7Qa/TFwMIA/DJLDMEM5CDXC2hPtWU7OtmBU7nXfp
         2z5w==
X-Gm-Message-State: AOAM533ZTcTkJyU/umID6xYk0z+k0mvDSOzTCYtZIzmwFvWM6wfU27ai
        Z37sgIXEGly7ERwfMOD3XwhDMg==
X-Google-Smtp-Source: ABdhPJyuNmP3Wf47MQITz51h0tip2WfX44XPte2EplKCXHLqfSHCHJVpHfQJ5NtwUc2OxyfaeImh2w==
X-Received: by 2002:a05:6214:1874:: with SMTP id eh20mr1050qvb.13.1643222201356;
        Wed, 26 Jan 2022 10:36:41 -0800 (PST)
Received: from soleen.c.googlers.com.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id h9sm26226qkp.75.2022.01.26.10.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 10:36:40 -0800 (PST)
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, rientjes@google.com,
        pjt@google.com, weixugc@google.com, gthelen@google.com,
        mingo@redhat.com, will@kernel.org, rppt@kernel.org,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        aneesh.kumar@linux.ibm.com, jirislaby@kernel.org,
        songmuchun@bytedance.com, qydwhotmail@gmail.com, hughd@google.com,
        ziy@nvidia.com, anshuman.khandual@arm.com
Subject: [PATCH v4 2/4] mm/page_table_check: use unsigned long for page counters and cleanup
Date:   Wed, 26 Jan 2022 18:36:35 +0000
Message-Id: <20220126183637.1840960-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
In-Reply-To: <20220126183637.1840960-1-pasha.tatashin@soleen.com>
References: <20220126183637.1840960-1-pasha.tatashin@soleen.com>
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
2.35.0.rc0.227.g00780c9af4-goog


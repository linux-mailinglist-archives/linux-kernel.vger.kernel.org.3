Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E80F349C372
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 07:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234834AbiAZGFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 01:05:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234685AbiAZGFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 01:05:20 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E80C061747
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 22:05:19 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id c19so26335457qtx.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 22:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=R7V05PwaNjZnBTJ0+d7ZFZvO5dL9q1xRZty8VkA9hmQ=;
        b=bYJUNPpR1cZ5cpCeIRGCfDxZJpYmpPoh66ZJK77ukWwzsfKXMtKjFR0oyDl2PrVsRW
         IjZbI251p7s2yxGbyhaCpLtUYBe6eQ/H9o9djosXMfNCEvGwGBN+R0lcfbPMC5Cksznp
         HzEoAy39YDsLI/M5Ax6D0T9dXeKhcoYrDGg62jHcw+RFE+cRQEohFqYIRggXfbAR09jh
         c2sbLnBREwPZM/oV0w9qlL4dm7bHOUr+bSxvw/pnn/B3Aa/Q5IwY6gYNswVBk4dgWm/4
         tybcJbilgAp6um5hCw1b5mXjM2VS1BA4dZTRuLQV21VwHvpW96HOLQcJFswBr1TlyuL5
         O08Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R7V05PwaNjZnBTJ0+d7ZFZvO5dL9q1xRZty8VkA9hmQ=;
        b=xWltCoQN9CeLcrx7VTr/vftGbbyCYz1AoqDeEyj33Z1QY2WSQz0GPjog7MHPTV5Jn9
         GLLXPQUMg1rC+0fJdqD+ILep55LCY2YR2MwfIP6mg9HQSwcJ4TiKuK+iykHPGluKsUas
         qMBU0qASJkzaMUGsWP+o02Wv+z9HFE6oeCDgEb6YwIdOgvDpC44J1TAATKpcG2y26Gi0
         VMzASSZTW6GQ/vAQ7JwYcKjPCiDos298r6DuMEwjKbOJbpE+RRzPMZpw+JPfoZloQYW7
         Y3ZWcqoW2xgBQaEblIlo7pRy6KdPiSwkGAd+ibmoL43eP8YE21yn/b6jf1pcEp8TA0iN
         0h1w==
X-Gm-Message-State: AOAM5308XwjutAChUAmFKNUtZRZjVOqYvmSiY220YyDYkZRDZrp2Fgwo
        ipdC6GAxCaOkOK4w3tXSotFdXQ==
X-Google-Smtp-Source: ABdhPJyGJu1wLWlwWE4gJcN7imPL+nBoU18Asvh3ix2RWYM+mVME0JOpFCDhcqGNLxudLxhV3f6eqg==
X-Received: by 2002:a05:622a:43:: with SMTP id y3mr19448205qtw.347.1643177119022;
        Tue, 25 Jan 2022 22:05:19 -0800 (PST)
Received: from soleen.c.googlers.com.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id o19sm9856699qta.40.2022.01.25.22.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 22:05:18 -0800 (PST)
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, rientjes@google.com,
        pjt@google.com, weixugc@google.com, gthelen@google.com,
        mingo@redhat.com, will@kernel.org, rppt@kernel.org,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        aneesh.kumar@linux.ibm.com, jirislaby@kernel.org,
        songmuchun@bytedance.com, qydwhotmail@gmail.com, hughd@google.com,
        ziy@nvidia.com, anshuman.khandual@arm.com
Subject: [PATCH v3 2/4] mm/page_table_check: use unsigned long for page counters and cleanup
Date:   Wed, 26 Jan 2022 06:05:12 +0000
Message-Id: <20220126060514.1574935-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
In-Reply-To: <20220126060514.1574935-1-pasha.tatashin@soleen.com>
References: <20220126060514.1574935-1-pasha.tatashin@soleen.com>
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


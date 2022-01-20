Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D568249466D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 05:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358502AbiATEZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 23:25:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358468AbiATEZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 23:25:20 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E46C061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 20:25:20 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id 14so4315411qty.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 20:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=y7IBEFcOTZK1CyuqmdTSoA/WSm/rs2AzBzr4xeRbGk4=;
        b=cP4MRZVN3XS/Hv+4xVejRohrtY7eWhls6EeKtXKO4HEeZoBodcI8sJ3xjHKFm70JUO
         GOILpJJKMku8FMRco38M2XxNrQ3llQ6nlbmn4kLPAuunEYXWUZCP6iupyYGhZoGylgYn
         VVxbLPGmi2UseBBddwmDeApHQ6oG35Z8Cl9i1SxnXv4Ts6hutw3/Bo78JiROOyWn2dOQ
         46AG77KO7iiByksR54vPpIIQYFqIR50aL6Gp+tj/UmoKeVU0Lm1M9ykxCEaNheyPQ5BT
         uv4iuIUZD696lO4zpJJBuZgLzkSwzL1LCMOqQH8s1atbsUTMU8QwZ4FtkGxQxBFhlB3a
         CZew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y7IBEFcOTZK1CyuqmdTSoA/WSm/rs2AzBzr4xeRbGk4=;
        b=j01MDC1ZTSguKObauQzrt1jf2LkY2uh/DCbYQGHAS3nxKesOPomC7dwQJECkPp0N7N
         z+h4eLi0wqqu6U8dtSFCP5Neyv9YFn4T0O6KnbNckYvoOYKVTLWTFOMbZojq2r2LTiB5
         aFZWSBaElgusLUse7JR+vsIqNtwRrlxQ6BTAntujDKMwmP0gZdQg/TcgI6766F1TkhNi
         +7Dr3DojiXXREzhTsG/uvgJpmewGf6acAK+wPwkji1KVG+KJr+3mYDM/MIXVb7iWpC6e
         V+ywOQGGtysOkNMyCX5m+tkgzvXhmFsjDh6MvF1q3xzD02CSNRGas/NYZt4MFwcQJb0l
         sXpA==
X-Gm-Message-State: AOAM533RgDNlPdv2RgaZRv+QLZnFDe6Rd1QGQjaMW4YcOybWVdn05kAN
        P7PxSiyq2XvN1D6AWaPUnjjmUA==
X-Google-Smtp-Source: ABdhPJzXnIXjyCxa1o9CUucEgZlUWjvyPBMb3mux6mDsG/2GD/N9CkUGpolKakTZ0SXWX3g03RR0ZQ==
X-Received: by 2002:ac8:5d94:: with SMTP id d20mr27466383qtx.214.1642652719229;
        Wed, 19 Jan 2022 20:25:19 -0800 (PST)
Received: from soleen.c.googlers.com.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id n22sm927228qka.46.2022.01.19.20.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 20:25:18 -0800 (PST)
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, rientjes@google.com,
        pjt@google.com, weixugc@google.com, gthelen@google.com,
        mingo@redhat.com, will@kernel.org, rppt@kernel.org,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        aneesh.kumar@linux.ibm.com, jirislaby@kernel.org,
        songmuchun@bytedance.com, qydwhotmail@gmail.com, hughd@google.com,
        ziy@nvidia.com, anshuman.khandual@arm.com
Subject: [PATCH 3/3] mm/page_table_check: use unsigned long for page counters
Date:   Thu, 20 Jan 2022 04:25:13 +0000
Message-Id: <20220120042513.1648831-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
In-Reply-To: <20220120042513.1648831-1-pasha.tatashin@soleen.com>
References: <20220120042513.1648831-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the consistency, use "unsigned long" for all page counters.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 mm/page_table_check.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/page_table_check.c b/mm/page_table_check.c
index 2341ac382cd5..22dd285ab8d5 100644
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
@@ -186,10 +186,10 @@ static void pmd_clear_level(struct mm_struct *mm, unsigned long addr,
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
-- 
2.34.1.703.g22d0c6ccf7-goog


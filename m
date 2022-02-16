Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0224B84D3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 10:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbiBPJt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 04:49:57 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:40804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232492AbiBPJtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 04:49:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 681582B4D86
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 01:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645004976;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rxjE8nQUBN11kwzcRplXdSY7IFspDWL4Rd9u3ETZvZU=;
        b=Ir615H0RNSiExfYgbPzQlwbLcyQDK1T2Ef/yh/wVID4o1voW+93/gqpEJiDVtjHIzrYI98
        a5tjEcD3Qszr5dTkFzoxRJgSmXfawvbWeYYADkXaAgV/jBL6BNErKjwUPo9kKqPxcOy67n
        Jrxm/C6UPdZfSZpnnZK6CWlIdUKNSvk=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-617-H7wICrN8P6SCSHgk5fLM7Q-1; Wed, 16 Feb 2022 04:49:35 -0500
X-MC-Unique: H7wICrN8P6SCSHgk5fLM7Q-1
Received: by mail-pf1-f199.google.com with SMTP id y28-20020aa793dc000000b004e160274e3eso1179448pff.18
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 01:49:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rxjE8nQUBN11kwzcRplXdSY7IFspDWL4Rd9u3ETZvZU=;
        b=MhlfvKAfylQPcEwTjxEGlfwNT2p5jTjFgkqhpy3BEqlTpKcAYPWvxdd54ysWKdT1Ne
         YyW4gutPXP/OZPb1gSF/33F4y2rm+RhAMsQ9nUu08w3ON2dJBKrHWx0fHwR2dd/O6UBs
         EiXHw7RypY4wCEBH/v960x4n1R0YIA7tYjjJch0fcvX0RCRonJxfHmW5v0ejKD+c/gnO
         KWYa7CSzequfs+yffTy9eyx/m+ouTHyZsbH5980uBPIa1dkMn8SWSFKwG6wNJHbiTTm/
         hYvG8Ww0JJhyZpxXSdRF/Kankl1EsoBl48Z/0dJByQdy4N4cpUze4NLlGZjqfruE3nRU
         chTw==
X-Gm-Message-State: AOAM531hPVx6Zz5R/QbNv5IIGD7THn4Ac+VS1F9FMBdEJX219QCJuYDd
        bxck2lsDDiwWTjR2Ef8s3mQ4USzaBlucmhUfW5q5LBXy3sAy0EoL0kPRPGNG+QY4ALbqVr/NF7l
        nDL840EhGWZeUgPkGyNbu80WWM5K0Fe4VtA5n0veDeI0JzMKvPT+o2WBGXHRQOSxrR9nmKSYDQA
        ==
X-Received: by 2002:a17:902:7892:b0:14e:c520:e47d with SMTP id q18-20020a170902789200b0014ec520e47dmr1620168pll.105.1645004973437;
        Wed, 16 Feb 2022 01:49:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyU/EfLN18Cu4rotd2bXfEqIGUN8J9OwxkyYql/PYAkRf8rWS5DdGmn2URaeB50VX2oPQZFOw==
X-Received: by 2002:a17:902:7892:b0:14e:c520:e47d with SMTP id q18-20020a170902789200b0014ec520e47dmr1620133pll.105.1645004973050;
        Wed, 16 Feb 2022 01:49:33 -0800 (PST)
Received: from localhost.localdomain ([64.64.123.81])
        by smtp.gmail.com with ESMTPSA id qe7sm11567835pjb.25.2022.02.16.01.49.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 16 Feb 2022 01:49:32 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Yang Shi <shy828301@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>, peterx@redhat.com,
        John Hubbard <jhubbard@nvidia.com>,
        Alistair Popple <apopple@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>
Subject: [PATCH v4 4/4] mm: Rework swap handling of zap_pte_range
Date:   Wed, 16 Feb 2022 17:48:10 +0800
Message-Id: <20220216094810.60572-5-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220216094810.60572-1-peterx@redhat.com>
References: <20220216094810.60572-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean the code up by merging the device private/exclusive swap entry handling
with the rest, then we merge the pte clear operation too.

struct* page is defined in multiple places in the function, move it upward.

free_swap_and_cache() is only useful for !non_swap_entry() case, put it into
the condition.

No functional change intended.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/memory.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index ffa8c7dfe9ad..cade96024349 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1361,6 +1361,8 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 	arch_enter_lazy_mmu_mode();
 	do {
 		pte_t ptent = *pte;
+		struct page *page;
+
 		if (pte_none(ptent))
 			continue;
 
@@ -1368,8 +1370,6 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			break;
 
 		if (pte_present(ptent)) {
-			struct page *page;
-
 			page = vm_normal_page(vma, addr, ptent);
 			if (unlikely(!should_zap_page(details, page)))
 				continue;
@@ -1403,21 +1403,14 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 		entry = pte_to_swp_entry(ptent);
 		if (is_device_private_entry(entry) ||
 		    is_device_exclusive_entry(entry)) {
-			struct page *page = pfn_swap_entry_to_page(entry);
-
+			page = pfn_swap_entry_to_page(entry);
 			if (unlikely(!should_zap_page(details, page)))
 				continue;
-			pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
 			rss[mm_counter(page)]--;
-
 			if (is_device_private_entry(entry))
 				page_remove_rmap(page, false);
-
 			put_page(page);
-			continue;
-		}
-
-		if (!non_swap_entry(entry)) {
+		} else if (!non_swap_entry(entry)) {
 			/*
 			 * If this is a genuine swap entry, then it must be an
 			 * private anon page.  If the caller wants to skip
@@ -1426,9 +1419,9 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			if (!should_zap_cows(details))
 				continue;
 			rss[MM_SWAPENTS]--;
+			if (unlikely(!free_swap_and_cache(entry)))
+				print_bad_pte(vma, addr, ptent, NULL);
 		} else if (is_migration_entry(entry)) {
-			struct page *page;
-
 			page = pfn_swap_entry_to_page(entry);
 			if (!should_zap_page(details, page))
 				continue;
@@ -1441,8 +1434,6 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			/* We should have covered all the swap entry types */
 			WARN_ON_ONCE(1);
 		}
-		if (unlikely(!free_swap_and_cache(entry)))
-			print_bad_pte(vma, addr, ptent, NULL);
 		pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
 	} while (pte++, addr += PAGE_SIZE, addr != end);
 
-- 
2.32.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4B549F2A2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 05:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346131AbiA1Ey4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 23:54:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50776 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346130AbiA1Eyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 23:54:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643345690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rxjE8nQUBN11kwzcRplXdSY7IFspDWL4Rd9u3ETZvZU=;
        b=YO7nBw5xLmY93LEDYURC5Tu8S+JCtCoLoyLkdhOjyx3ri0BbqMy9MYKTgvU/113ooA3a7j
        dzqO9UuWlcXYe1s9eUo/iIpC3FN+acJ5AiwMFtgqhvh7oS2EZmW6760w8fIplT8qjtYpRg
        WKGE+DytE40X+g68pPxXvIZF8CFn51U=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-194-ThQMNl68Mi-vjCdiYHy5FQ-1; Thu, 27 Jan 2022 23:54:46 -0500
X-MC-Unique: ThQMNl68Mi-vjCdiYHy5FQ-1
Received: by mail-wm1-f69.google.com with SMTP id l20-20020a05600c1d1400b0035153bf34c3so2562864wms.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 20:54:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rxjE8nQUBN11kwzcRplXdSY7IFspDWL4Rd9u3ETZvZU=;
        b=ZawArv9dZ0WttI80RFD3g5mCcfWChcSR81uz4sfoNaj32xeFrlds3VSpUhV9Lv8U+X
         ZSCl1LJEH6Jg6/EJRZvlisUI8eHXPElb5nGSME+H/hI9510yqDS4ZDCup9WcSEDASxGv
         QZGax17YAnjbVeyTcadx4UYbrUnzFCd3owtNjYlhk4wd6OX0gnwE8j9Fr/U4OFEtuCmH
         dN4ZB48yH7KBvZbJzmXAymcTY8GM51uJFwMSVy/lIP/L/HauRLTEaPaCz++KID8Nm5Xv
         hDeAQ7PLVeDvCrfpcEltHRjIwaV9RAlrICBfx1Q2TSVg2hYYJxys5cPvGNM3KyJxGfWU
         vBmw==
X-Gm-Message-State: AOAM533jKew3ubNvafvmRWu19mL3oFFfJtkxiqZ2k5KwLO5CFghV0nIz
        Sm+FBvdnOteOMaaAQxAUv5dfwvks2pG6oeL8S6ii4vfCJ9H2NGPRIr/DjZ9BHv7i05vpDqlaCrE
        dF+jU6tohKWjo4HcRpGRH2+Td
X-Received: by 2002:a05:6000:1a89:: with SMTP id f9mr5884820wry.251.1643345685470;
        Thu, 27 Jan 2022 20:54:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzvpMqKTZBmuLjr5YO2EFIJM9G9DWCeuPiKqQMCAYXt0G0OqDw+Xws+L0tBDAR/T/8LmGetKw==
X-Received: by 2002:a05:6000:1a89:: with SMTP id f9mr5884805wry.251.1643345685283;
        Thu, 27 Jan 2022 20:54:45 -0800 (PST)
Received: from localhost.localdomain ([64.64.123.9])
        by smtp.gmail.com with ESMTPSA id i13sm814014wrf.3.2022.01.27.20.54.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 27 Jan 2022 20:54:45 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     peterx@redhat.com, Alistair Popple <apopple@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: [PATCH v3 4/4] mm: Rework swap handling of zap_pte_range
Date:   Fri, 28 Jan 2022 12:54:12 +0800
Message-Id: <20220128045412.18695-5-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220128045412.18695-1-peterx@redhat.com>
References: <20220128045412.18695-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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


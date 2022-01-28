Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7CDD49F2A0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 05:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346110AbiA1Eyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 23:54:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:54532 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346117AbiA1Eyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 23:54:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643345677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X4WXHh7pV56dMHSpF/O5K7LVTClsvKIQ79sBisfSRRA=;
        b=i77TYSfjBOLuBN4uUTRu2JUpJ8vizn3/zzMfbLJDrgDnS6p88pgRKKmQ5Odwxp6oqiOHd7
        YxUeiDj6e4RRGsf9vVgI4Ty2/4OQEjDR7m/GeJUAoLfOO6y4xXKr/8JZETevPycFx5iiGR
        hOGzR6LU+3JvCLIRH/+DVw2sc6OzHTo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-339-Qxdr3tMyNoqy4XvnRmZgNw-1; Thu, 27 Jan 2022 23:54:35 -0500
X-MC-Unique: Qxdr3tMyNoqy4XvnRmZgNw-1
Received: by mail-wr1-f71.google.com with SMTP id z1-20020adfbbc1000000b001df54394cebso950626wrg.20
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 20:54:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X4WXHh7pV56dMHSpF/O5K7LVTClsvKIQ79sBisfSRRA=;
        b=cCmoZktTlOzYSzkvrzCE1i6ZV431k3bSTmp9E2zZhKVs930VQW6w+asJA+Xd5N28F4
         AIAdfRIqYiadIbsQhvwAX4wBezIdo/+yA/iX222NNs9ZZ+QhqeD0LLqyw8l30tXCkWdC
         EBrOk4vQqCddkN6rivBrI19fOmmSCvJ/CsR7r4u8pRb53eYQ+6DmYOAesEEUVNYzpqD8
         F+1/27XVCA8ti9u2C+ycnUuJ7soXtnpiIusJfzPFmR7ZN4wH+bfMASDdOz3dAcDESY1G
         R158yiBP6a0sIW1fg9Hgb4tJjldqS7pXnuRpLigkzqPAx+qxMCurwL3vBLeXllncMx5P
         Lu6w==
X-Gm-Message-State: AOAM530/Qf45/FprWtauxxDAhC88QR6hl5M4/F0XMdgFAJELCxuLVFjU
        OLoJTzu+eV7bb1FSTa3PCg47XFFSg7U2Dc74wiErjDtKcvGN8ZaiES3M4mPTDpzBG3+ZC46JHRU
        TNZhT9ob6kkPAzX6UJcF+ISWS
X-Received: by 2002:a1c:a90d:: with SMTP id s13mr5787849wme.32.1643345674572;
        Thu, 27 Jan 2022 20:54:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzUZOPum7MMLETcw25d/iBx+n7SScJ596aZWjbvcjraz7IAo8lenVlYxR/jtIOkJT4M5mmwpg==
X-Received: by 2002:a1c:a90d:: with SMTP id s13mr5787840wme.32.1643345674342;
        Thu, 27 Jan 2022 20:54:34 -0800 (PST)
Received: from localhost.localdomain ([64.64.123.9])
        by smtp.gmail.com with ESMTPSA id i13sm814014wrf.3.2022.01.27.20.54.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 27 Jan 2022 20:54:34 -0800 (PST)
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
Subject: [PATCH v3 2/4] mm: Rename zap_skip_check_mapping() to should_zap_page()
Date:   Fri, 28 Jan 2022 12:54:10 +0800
Message-Id: <20220128045412.18695-3-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220128045412.18695-1-peterx@redhat.com>
References: <20220128045412.18695-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous name is against the natural way people think.  Invert the meaning
and also the return value.  No functional change intended.

Suggested-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/memory.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 4bfeaca7cbc7..14d8428ff4db 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1326,20 +1326,19 @@ static inline bool should_zap_cows(struct zap_details *details)
 
 /*
  * We set details->zap_mapping when we want to unmap shared but keep private
- * pages. Return true if skip zapping this page, false otherwise.
+ * pages. Return true if we should zap this page, false otherwise.
  */
-static inline bool
-zap_skip_check_mapping(struct zap_details *details, struct page *page)
+static inline bool should_zap_page(struct zap_details *details, struct page *page)
 {
 	/* If we can make a decision without *page.. */
 	if (should_zap_cows(details))
-		return false;
+		return true;
 
 	/* E.g. zero page */
 	if (!page)
-		return false;
+		return true;
 
-	return details->zap_mapping != page_rmapping(page);
+	return details->zap_mapping == page_rmapping(page);
 }
 
 static unsigned long zap_pte_range(struct mmu_gather *tlb,
@@ -1374,7 +1373,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			struct page *page;
 
 			page = vm_normal_page(vma, addr, ptent);
-			if (unlikely(zap_skip_check_mapping(details, page)))
+			if (unlikely(!should_zap_page(details, page)))
 				continue;
 			ptent = ptep_get_and_clear_full(mm, addr, pte,
 							tlb->fullmm);
@@ -1408,7 +1407,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 		    is_device_exclusive_entry(entry)) {
 			struct page *page = pfn_swap_entry_to_page(entry);
 
-			if (unlikely(zap_skip_check_mapping(details, page)))
+			if (unlikely(!should_zap_page(details, page)))
 				continue;
 			pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
 			rss[mm_counter(page)]--;
@@ -1433,7 +1432,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			struct page *page;
 
 			page = pfn_swap_entry_to_page(entry);
-			if (zap_skip_check_mapping(details, page))
+			if (!should_zap_page(details, page))
 				continue;
 			rss[mm_counter(page)]--;
 		} else if (is_hwpoison_entry(entry)) {
-- 
2.32.0


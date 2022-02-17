Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 941AD4B98C1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 07:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234836AbiBQGI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 01:08:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234796AbiBQGIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 01:08:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 97D04C7D49
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 22:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645078088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GodqcRh1SHgqGa/hH7oS86cAqo3cWdJIC+9/AWlAQQI=;
        b=TaxuKaAqllgT1XfTfFg+JEr/+CA+4G1Lb5L3HdquzPNUoF9+yxaMIyKzeC/XsQLuWvlmc+
        VQctkbr3jyYrZb0FvFRnIFJimWh0EOr+egDS8xeD9sLfizyTKMsCNTgdU91XXNo2XD1rE+
        k83zseY/JWxdYIpuqcIwj6VQKGil5nw=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-192-1_SDuT1LOg6ggc15A_vpKA-1; Thu, 17 Feb 2022 01:08:07 -0500
X-MC-Unique: 1_SDuT1LOg6ggc15A_vpKA-1
Received: by mail-pl1-f197.google.com with SMTP id v20-20020a1709028d9400b0014ca63d0f10so2110776plo.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 22:08:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GodqcRh1SHgqGa/hH7oS86cAqo3cWdJIC+9/AWlAQQI=;
        b=ZnX+Odl3kJjDwdWV7BMgsoX2QIyIhnfZKh/CTOjEW27+Z08uC3yRUpfJ+JGW4TBBwW
         aATINwwUJATSZWxN9W02uZYcfhy+kL/rTlb6GgLmso/lCtTLQLK6kDxyIUpgMAc+4MPj
         Uw9L8BQo+22O3ryjnywldW6uZrOBI88ODlgDwUBtqIuZnEIwNp5SouRiiOOnRMIWAHwe
         OAazsPKxs2zEKLb7D8TysQLfzoZTJKlD0m0BZZ0Z607zqviIg78wudkOCkb9jBaazRut
         zbcHBHAz6X2qpcoonz89uHy/XxzwXkAMJSUBo1WVCQyMiu4idg4YCGLJcl62M79Hy3Bu
         LAkQ==
X-Gm-Message-State: AOAM530361IKyx8rIWSauCdZ5H/TDQwRHCZht7CLR5CM58D9TRUrFLOv
        uvfx44D+YpXAi+VawM7QQd9V/zkutZGfbN4YE4gz7z7/YXFVkzjepxLP6DoCb/r/skZDTcoInv8
        Uh5Ev6sYw8CFX8m63vdP1KiYg
X-Received: by 2002:a17:902:be0a:b0:14d:5db0:7a14 with SMTP id r10-20020a170902be0a00b0014d5db07a14mr1368615pls.155.1645078085889;
        Wed, 16 Feb 2022 22:08:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwxmgTyql91syHq0iBmulNuYN38si4IUsKVfqHWUowF2A+HcKnj8DOPPRsO38J/B724ZyqK7Q==
X-Received: by 2002:a17:902:be0a:b0:14d:5db0:7a14 with SMTP id r10-20020a170902be0a00b0014d5db07a14mr1368590pls.155.1645078085600;
        Wed, 16 Feb 2022 22:08:05 -0800 (PST)
Received: from localhost.localdomain ([94.177.118.126])
        by smtp.gmail.com with ESMTPSA id j8sm224230pjc.11.2022.02.16.22.08.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 16 Feb 2022 22:08:05 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Alistair Popple <apopple@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>, peterx@redhat.com,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: [PATCH v5 2/4] mm: Rename zap_skip_check_mapping() to should_zap_page()
Date:   Thu, 17 Feb 2022 14:07:44 +0800
Message-Id: <20220217060746.71256-3-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220217060746.71256-1-peterx@redhat.com>
References: <20220217060746.71256-1-peterx@redhat.com>
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

The previous name is against the natural way people think.  Invert the
meaning and also the return value.  No functional change intended.

Suggested-by: David Hildenbrand <david@redhat.com>
Suggested-by: Hugh Dickins <hughd@google.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/memory.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 533da5d6c32c..3728632ea993 100644
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
 
 	/* E.g. the caller passes NULL for the case of a zero page */
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
@@ -1429,7 +1428,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			struct page *page;
 
 			page = pfn_swap_entry_to_page(entry);
-			if (zap_skip_check_mapping(details, page))
+			if (!should_zap_page(details, page))
 				continue;
 			rss[mm_counter(page)]--;
 		} else if (is_hwpoison_entry(entry)) {
-- 
2.32.0


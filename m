Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB654B98CC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 07:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234882AbiBQGIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 01:08:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234859AbiBQGId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 01:08:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5D457C7D49
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 22:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645078098;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7Iw+/fHKv6eLf6uybneXrBCZa8a9WBXNMPZFyFhXGnU=;
        b=aj62FZAwnNoQM7MT1S59Cu1sOXe9PJSCKkSa8DToRtUAwFKxl9E/H08yd7qbCjmWtoQU3k
        dWGLcu5F6JIlIKWSmeE/rAiE0gtW1qFx/0v5MdMruyA4dEoCvPKuMrtf2kp51HRUZwTW9f
        EyFaZVjTxNqdB73mlRIS195yZXAvyKM=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-97-0i0WF9IRNh-o2wmz3Xw2FQ-1; Thu, 17 Feb 2022 01:08:17 -0500
X-MC-Unique: 0i0WF9IRNh-o2wmz3Xw2FQ-1
Received: by mail-pg1-f198.google.com with SMTP id 27-20020a63135b000000b0036285f54b6aso2454416pgt.19
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 22:08:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7Iw+/fHKv6eLf6uybneXrBCZa8a9WBXNMPZFyFhXGnU=;
        b=iuhVDMAzkJRt7FHL3cKFhwJU8kPejt7TT1wMiXuQ7tzien8Kxl4iYD1TwPAhWFzKLR
         vMsBgnDSlvevLxxkyGV9GlTzG6EE9BIohrnqJ+QO0TCmlflJeem/MOvJP86QaEe5Fm/h
         dFoHnzPNANUbIIqphT6Sn/1VtzqbSWCNAJljOD6mBDQ+AOwZLUdEJpoBUsf+ShOoUP9+
         nBjfdcDdDSTrigz8zSdchm1nR8NdaDFvg6oXEQTdpHXdi+eMmSd28eIBrC3BwPzkanM7
         LMAd439OeT6+aSu5vxrUJ2H/2ViPy7DYoU2MiWjtwWm5l6G5HdExzJ5wYvxaETbOzyyM
         u3nA==
X-Gm-Message-State: AOAM532JFJPP3+FAQ2idN5EVc4YT8hJAnWnobDaDp3fO8BuBHCt4Nlhr
        rYWUJCwFdjkSL/+MrfIAhBkP/N+UfLMK9rCUV3sI0Jf1mdmUeW0ufWdRmHmSY48McaSFUXtC5oi
        2cH4n47MgTYOARlJsFvfbg3wL
X-Received: by 2002:a05:6a00:8c5:b0:4c7:f9a5:ebc6 with SMTP id s5-20020a056a0008c500b004c7f9a5ebc6mr1690177pfu.34.1645078096100;
        Wed, 16 Feb 2022 22:08:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzJq01ZMuxcXHBVvWHdhve6h2WPzO7RXn4GgLcncsq4yBWdeLBav4ZSIjD78cJP8QrYAxhIEQ==
X-Received: by 2002:a05:6a00:8c5:b0:4c7:f9a5:ebc6 with SMTP id s5-20020a056a0008c500b004c7f9a5ebc6mr1690157pfu.34.1645078095837;
        Wed, 16 Feb 2022 22:08:15 -0800 (PST)
Received: from localhost.localdomain ([94.177.118.126])
        by smtp.gmail.com with ESMTPSA id j8sm224230pjc.11.2022.02.16.22.08.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 16 Feb 2022 22:08:15 -0800 (PST)
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
Subject: [PATCH v5 4/4] mm: Rework swap handling of zap_pte_range
Date:   Thu, 17 Feb 2022 14:07:46 +0800
Message-Id: <20220217060746.71256-5-peterx@redhat.com>
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

Clean the code up by merging the device private/exclusive swap entry
handling with the rest, then we merge the pte clear operation too.

struct* page is defined in multiple places in the function, move it upward.

free_swap_and_cache() is only useful for !non_swap_entry() case, put it
into the condition.

No functional change intended.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/memory.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index c2defe8a1472..6aa51ee2a307 100644
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
@@ -1403,28 +1403,21 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
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
 			/* Genuine swap entry, hence a private anon page */
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
@@ -1436,8 +1429,6 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			/* We should have covered all the swap entry types */
 			WARN_ON_ONCE(1);
 		}
-		if (unlikely(!free_swap_and_cache(entry)))
-			print_bad_pte(vma, addr, ptent, NULL);
 		pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
 	} while (pte++, addr += PAGE_SIZE, addr != end);
 
-- 
2.32.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3548D4B84DB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 10:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbiBPJtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 04:49:20 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:37052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232421AbiBPJtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 04:49:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DE4EF2B406E
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 01:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645004945;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=trYMhQgsw7O8qP2aA5tHFBOoRzKbhngS39UuP85axlI=;
        b=AWOERnF+lk+S9qxCiNrcm0nwbaXY/NfT2G+8u+CNHqlq0G0SzvJHF9Sf+fFhyJkXO/ZHNT
        SVMKPZP4s59uNWOcTkOh9zyQlnLKBXwwyyP76G4ZS33ygMHo4FjxtZ6yNBl74YGBORGTYB
        t9/vSSl5kAX1dQH4ehrxt4EbKtbNlwk=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-418-ZLy2-bLmNyCcLR92Gyxfyg-1; Wed, 16 Feb 2022 04:49:04 -0500
X-MC-Unique: ZLy2-bLmNyCcLR92Gyxfyg-1
Received: by mail-pf1-f200.google.com with SMTP id i7-20020a626d07000000b004e07b61362bso1201948pfc.6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 01:49:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=trYMhQgsw7O8qP2aA5tHFBOoRzKbhngS39UuP85axlI=;
        b=B/ylR6eYYVuO85Da6W3EAVBHTjaW/bHFbs7MbysMGm3oKj0KPEmmV8YrHQqDv+URHc
         5dVQvLC5oq12AfrNERo+CIvk88JO+wflQwk7tDleL7XOjjthELGPMNKmsN/y73x5HTVK
         GTXK0ZpOLSVULYYYE44ERCPU0FHAondoBJkhLZMLC5DU5xuBLde88kwD0mJhx1tQSvcH
         LCn7QutUvqWoj7xdRWav7pKriOje6J3tUVJNmKNPNCpts4JpNdn9Lh/cndW+Js4GrwlX
         fkNIql1ul+OzsTJhCHffADuObuEj9UY+HqvAOwE4diSuwZu3mIx3nEKmrjcR46a0fkCo
         T//Q==
X-Gm-Message-State: AOAM531+p/JqO9TAIaM9inUYkLc45+7UqcCwn0ZrXv2o+Op9Ch1ugJbM
        7UJSAvFkL5rLPzbefwj+1aY73AvUeG0s0ywN2x87FpBmqv0QhQ/yJo1L59ILigujDCMavRjXeNK
        wss1zKV2pZvBitTJcGSTaS+TvwYvhtlB3pubcV0b+myoeLxz/b8iVAma+ogm6EC5ppeSB3slGyw
        ==
X-Received: by 2002:a17:903:228a:b0:14d:aa04:2278 with SMTP id b10-20020a170903228a00b0014daa042278mr1850399plh.58.1645004943551;
        Wed, 16 Feb 2022 01:49:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwp9Rn/eyC2VMT306FaqLkb/8rUoQRaxAT2awvvDCzl/7i40J6BsqMQKml7qFHRkaY20DhzAA==
X-Received: by 2002:a17:903:228a:b0:14d:aa04:2278 with SMTP id b10-20020a170903228a00b0014daa042278mr1850363plh.58.1645004943140;
        Wed, 16 Feb 2022 01:49:03 -0800 (PST)
Received: from localhost.localdomain ([64.64.123.81])
        by smtp.gmail.com with ESMTPSA id qe7sm11567835pjb.25.2022.02.16.01.48.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 16 Feb 2022 01:49:02 -0800 (PST)
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
Subject: [PATCH v4 2/4] mm: Rename zap_skip_check_mapping() to should_zap_page()
Date:   Wed, 16 Feb 2022 17:48:08 +0800
Message-Id: <20220216094810.60572-3-peterx@redhat.com>
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

The previous name is against the natural way people think.  Invert the meaning
and also the return value.  No functional change intended.

Suggested-by: David Hildenbrand <david@redhat.com>
Suggested-by: Hugh Dickins <hughd@google.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
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


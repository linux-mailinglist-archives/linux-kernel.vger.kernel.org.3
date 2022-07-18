Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C3B578B08
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 21:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236219AbiGRTh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 15:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236182AbiGRThQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 15:37:16 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88CE2F67A
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 12:37:12 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id h132so11502194pgc.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 12:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VCDxDoUSCrnTZdtdcyuvlf+NNtVJJIcoOQ0MDquBzAY=;
        b=WpzOa1eCI6gKdwOYRlP/7uAcBkP9V49tEy6TRy1l2Khiu+GZnm10Q5jyVbyYM1tYJ0
         r1e+kLptD6I/s6ViDo6K3ZWQxtQqTivN9316p9KbowhoCjz6+CLLmK18EEI8JLQoLMTw
         6hJP+pqwUio5gv5yYp+Q5f9oq+Nlk4vL7U3Nr2uzyliGndyYJu/aty4nLWwUOlzgE7f3
         XKi59Yz5xUZS3IH7VwQS7RSyx2mkvafbnQ3f/hs9aloww2hNMJj8gDsL4ymdSB9RE3Xb
         MzJM2PoJh3hUc1G7Ka+jmv39doe16fxqrhkTV1xozTVG+hkSSQ0CDqVkr23SSAAypVrA
         ptew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VCDxDoUSCrnTZdtdcyuvlf+NNtVJJIcoOQ0MDquBzAY=;
        b=2HKMR4ElqOQVT3oOxcbjcvJAxl9zqQda4XT7P3wFPyG1Us3oEMYoGBjNidaC0zdht7
         wiCVr2mE7ZDD4Qn/q1rgzbKyZ01B/r+n/xcQf8TssMMhVGBhAbofKpMiw4DQ+XHB223z
         hnTwkyaUql9glXPW8tidWEC1buZ/hqZqsMLHrz+al92h82D76Scv12gNGENnaS0IeHuj
         LjlaqCGRvO6ecG2Hp6iTNN/cdU1a6u9OHibZ+RBurpD7t9BLlfYtL3qL3ng/600psw8j
         bIpuVWdSwdwXcK9mVcHqaug4DsNZKUk6ZYZqljb0qDSrXUIVjPapaKWuESj3n+86Trbn
         xeJA==
X-Gm-Message-State: AJIora8JFC6CZzNkiKkvdElfhm1uyUQJXL4i9C+jdHLrcbfS8sLtgi6z
        6NTtZLQN6B27Sth2lOiK4NA=
X-Google-Smtp-Source: AGRyM1vGJivctvX5ZkdLIJ4O9MXoDMilDP3XL2pp+bNJOG2Zy6lN3VLUtfwzhoCDKo97VJCK/R1iTA==
X-Received: by 2002:a63:fc48:0:b0:40d:ad0a:a868 with SMTP id r8-20020a63fc48000000b0040dad0aa868mr25533373pgk.204.1658173031839;
        Mon, 18 Jul 2022 12:37:11 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id q6-20020a170902a3c600b0016bc4a6ce28sm9907887plb.98.2022.07.18.12.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 12:37:11 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>
Subject: [RFC PATCH 06/14] mm/rmap: avoid flushing on page_vma_mkclean_one() when possible
Date:   Mon, 18 Jul 2022 05:02:04 -0700
Message-Id: <20220718120212.3180-7-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220718120212.3180-1-namit@vmware.com>
References: <20220718120212.3180-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

x86 is capable to avoid TLB flush on clean writable entries.
page_vma_mkclean_one() does not take advantage of this behavior. Adapt
it.

Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will@kernel.org>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Nick Piggin <npiggin@gmail.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 mm/rmap.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 83172ee0ea35..23997c387858 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -961,17 +961,25 @@ static int page_vma_mkclean_one(struct page_vma_mapped_walk *pvmw)
 
 		address = pvmw->address;
 		if (pvmw->pte) {
-			pte_t entry;
+			pte_t entry, oldpte;
 			pte_t *pte = pvmw->pte;
 
 			if (!pte_dirty(*pte) && !pte_write(*pte))
 				continue;
 
 			flush_cache_page(vma, address, pte_pfn(*pte));
-			entry = ptep_clear_flush(vma, address, pte);
-			entry = pte_wrprotect(entry);
+			oldpte = ptep_modify_prot_start(pvmw->vma, address,
+							pte);
+
+			entry = pte_wrprotect(oldpte);
 			entry = pte_mkclean(entry);
-			set_pte_at(vma->vm_mm, address, pte, entry);
+
+			if (pte_needs_flush(oldpte, entry) ||
+			    mm_tlb_flush_pending(vma->vm_mm))
+				flush_tlb_page(vma, address);
+
+			ptep_modify_prot_commit(vma, address, pte, oldpte,
+						entry);
 			ret = 1;
 		} else {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-- 
2.25.1


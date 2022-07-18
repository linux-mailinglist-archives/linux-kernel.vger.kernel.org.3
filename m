Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48731578B02
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 21:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236193AbiGRThT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 15:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236157AbiGRThK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 15:37:10 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658082CCB9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 12:37:09 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id a15so12753123pjs.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 12:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZFfNYrVG625GOSA+id1AogN2HiBF2G/dud76HkUGe+4=;
        b=DuOhKFmRzGfZbq1nE2NE6Kc5a1/zJpTjh2RvqjQrCWls/7Qhm59F3Q5qnZAqPiZzON
         HTPLLExPZor3+WUD0GCeFJpaZ9HYJzT2HyRhOUdXKPSxPoB6NcCCp6BaC0PUnMozc1Yt
         7yR/B8zLzmfdp4wBCIwoubwwq+IB152Z6aXNEBRtKOMqAeRb0Yg89EaxtZKRLj96Zhk2
         zoX+JoTOX8z/qePogfLcdbultYnUpTJzA0NIOrLiUF3n+b/B8dbqeFNxtjocuKqlEg9I
         gVwTOuaGbUDx39ekLwLxOUStg09K/QpEk4bRVNpBu1NY3eLXRtkHF8N04DDoJYpcUW4c
         qdtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZFfNYrVG625GOSA+id1AogN2HiBF2G/dud76HkUGe+4=;
        b=Nti7WPuVxm8TeHVNyBgzYwmxLHmfDCvVoDS3GKG8ndpeF/h5J9GGDhTlsBwhvWcl85
         HlYg11vGOjswxZA07Gqe9fYdaSJYx7R/4qtEJ9VMd8sojEyIqVXhHm+XUyzNoSgoeqP5
         xED4uYiRkcuCK6Pb6aXDy1GQPhMTAntVQNVv08+moqU9BYv9fsmjxOjnN4kX4EWHHUuV
         epoNUUmty2zy0NrUJXSPDy1dhSohlXRMnUx8Eqb3g2Siol8BD/N3O2nM317ZUu/7N4pe
         HTVMTpi29SwIJzn7dd8b6+sfJcbJUY8t9Ceq+IyWjv4QDuUpWgKQa52TSOMSlQP9kXTl
         klpA==
X-Gm-Message-State: AJIora/a0d0q8OR+O44L/M8CFk59oTDSHFn2w9dgtwyJod46sQX01FNk
        8yilkL9xY3r6u91jd01gi0s=
X-Google-Smtp-Source: AGRyM1vEHCEomLrXWGc5eN5sitXXmIDRxEROcYfVCHE3CQXw0PbDpM+yh+ClwMd2ENoAaXz/XYUQHw==
X-Received: by 2002:a17:90a:9f8d:b0:1f0:253e:3ecf with SMTP id o13-20020a17090a9f8d00b001f0253e3ecfmr41557002pjp.33.1658173028683;
        Mon, 18 Jul 2022 12:37:08 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id q6-20020a170902a3c600b0016bc4a6ce28sm9907887plb.98.2022.07.18.12.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 12:37:08 -0700 (PDT)
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
Subject: [RFC PATCH 04/14] mm/mprotect: preserve write with MM_CP_TRY_CHANGE_WRITABLE
Date:   Mon, 18 Jul 2022 05:02:02 -0700
Message-Id: <20220718120212.3180-5-namit@vmware.com>
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

When MM_CP_TRY_CHANGE_WRITABLE is used, change_pte_range() tries to set
PTEs as writable.

Yet, writable PTEs might still become read-only, due to various
limitations of the logic that determines whether a PTE can become
writable (see can_change_pte_writable()). Anyhow, it is much easier to
keep the writable bit set when MM_CP_TRY_CHANGE_WRITABLE is used than to
first clear it and then figure out whether it can be set again.

Preserve the write-bit when MM_CP_TRY_CHANGE_WRITABLE is used, similarly
to the way it is done with NUMA.

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
 mm/mprotect.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index da5b9bf8204f..92bfb17dcb8a 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -84,6 +84,7 @@ static unsigned long change_pte_range(struct mmu_gather *tlb,
 	bool uffd_wp = cp_flags & MM_CP_UFFD_WP;
 	bool uffd_wp_resolve = cp_flags & MM_CP_UFFD_WP_RESOLVE;
 	bool will_need = cp_flags & MM_CP_WILL_NEED;
+	bool try_change_writable = cp_flags & MM_CP_TRY_CHANGE_WRITABLE;
 
 	tlb_change_page_size(tlb, PAGE_SIZE);
 
@@ -114,7 +115,8 @@ static unsigned long change_pte_range(struct mmu_gather *tlb,
 		oldpte = *pte;
 		if (pte_present(oldpte)) {
 			pte_t ptent;
-			bool preserve_write = prot_numa && pte_write(oldpte);
+			bool preserve_write = (prot_numa || try_change_writable) &&
+					       pte_write(oldpte);
 
 			/*
 			 * Avoid trapping faults against the zero or KSM
@@ -190,8 +192,7 @@ static unsigned long change_pte_range(struct mmu_gather *tlb,
 			 * example, if a PTE is already dirty and no other
 			 * COW or special handling is required.
 			 */
-			if ((cp_flags & MM_CP_TRY_CHANGE_WRITABLE) &&
-			    !pte_write(ptent) &&
+			if (try_change_writable && !pte_write(ptent) &&
 			    can_change_pte_writable(vma, addr, ptent)) {
 				ptent = pte_mkwrite(ptent);
 				if (will_need)
-- 
2.25.1


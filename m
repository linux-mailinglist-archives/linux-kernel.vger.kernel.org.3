Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE454D0C2F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 00:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343951AbiCGXo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 18:44:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243825AbiCGXoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 18:44:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E156ADE93
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 15:43:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 451A8611BD
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 23:43:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62D90C340E9;
        Mon,  7 Mar 2022 23:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1646696607;
        bh=K+xM2GYxG+Lby5uXP6tawrxb1rgWkjnt9Wizwmuhnv0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nD0MAVoJBfgAsY2ADPp/+vQL+L/fwENBHD3KiA5kTcTB8Txh9Ff6CJ7CVy8HGM04O
         2aeTOjSgrkwybDFVMmXX+WTp1pv83XQfbwNDLeTOARSHgexEqSqCz7u/ro92chBKWh
         4Svlb+OkVq8Dlfs29jPS3fj1L7jpqmeS+dQKKJ84=
Date:   Mon, 7 Mar 2022 15:43:26 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Yang Shi <shy828301@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] mm: thp: don't have to lock page anymore when splitting
 PMD
Message-Id: <20220307154326.6494f7fca7def491a23e5df1@linux-foundation.org>
In-Reply-To: <84a6c9c1-d18f-6955-2666-0a2d7bce6094@redhat.com>
References: <20220303222014.517033-1-shy828301@gmail.com>
        <CADFyXm6W9CVkO4XPYep-tHg55c8m8NES783kcVYrdjSMbzYoDA@mail.gmail.com>
        <CAHbLzkriyBy2HqjssurLSnhoyuUzpJRZjMPNx34MTgxeO0dddg@mail.gmail.com>
        <13ad4ba1-2a88-9459-3995-70af36aba33e@redhat.com>
        <20220306180718.6d4e6233130b94fdad98df88@linux-foundation.org>
        <84a6c9c1-d18f-6955-2666-0a2d7bce6094@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Mar 2022 09:24:58 +0100 David Hildenbrand <david@redhat.com> wrote:

> On 07.03.22 03:07, Andrew Morton wrote:
> > On Fri, 4 Mar 2022 19:50:08 +0100 David Hildenbrand <david@redhat.com> wrote:
> > 
> >> @Andrew, the last mail I received was
> >>
> >> + mm-huge_memory-remove-stale-locking-logic-from-__split_huge_pmd.patch
> >> added to -mm tree
> >>
> >> The patch shows up in mmotm as
> >>
> >> #[merged]mm-huge_memory-remove-stale-locking-logic-from-__split_huge_pmd.patch
> >>
> >> ... which shouldn't be true.
> > 
> > I guess I mislabelled the reason for dropping it.  Should have been to-be-updated, 
> > due to https://lkml.kernel.org/r/CAHbLzkpbnQyHRckoRtbZoaLvANu92MY4kEsbKudaQ8MDUA3nVg@mail.gmail.com
> > 
> 
> Let me clarify.
> 
> 1. I sent [1] (9 patches)
> 
> 2. You queued the 9 patches
> 
> E.g., in "mmotm 2022-02-15-20-22 uploaded"
> 
> * mm-optimize-do_wp_page-for-exclusive-pages-in-the-swapcache.patch
> * mm-optimize-do_wp_page-for-fresh-pages-in-local-lru-pagevecs.patch
> * mm-slightly-clarify-ksm-logic-in-do_swap_page.patch
> * mm-streamline-cow-logic-in-do_swap_page.patch
> * mm-huge_memory-streamline-cow-logic-in-do_huge_pmd_wp_page.patch
> * mm-khugepaged-remove-reuse_swap_page-usage.patch
> * mm-swapfile-remove-stale-reuse_swap_page.patch
> * mm-huge_memory-remove-stale-page_trans_huge_mapcount.patch
> * mm-huge_memory-remove-stale-locking-logic-from-__split_huge_pmd.patch
> 
> 3. The last patch in the series was dropped. What remains are 8 patches.
> 
> E.g., in "mmotm 2022-02-24-22-38 uploaded"
> 
> * mm-optimize-do_wp_page-for-exclusive-pages-in-the-swapcache.patch
> * mm-optimize-do_wp_page-for-fresh-pages-in-local-lru-pagevecs.patch
> * mm-slightly-clarify-ksm-logic-in-do_swap_page.patch
> * mm-streamline-cow-logic-in-do_swap_page.patch
> * mm-huge_memory-streamline-cow-logic-in-do_huge_pmd_wp_page.patch
> * mm-khugepaged-remove-reuse_swap_page-usage.patch
> * mm-swapfile-remove-stale-reuse_swap_page.patch
> * mm-huge_memory-remove-stale-page_trans_huge_mapcount.patch
> 
> 4. Yang Shi sent his patch (the one we're replying to)
> 
> 5. You picked his patch and dropped it again due to [2]
> 
> 
> I'm wondering why 3 happened and why
> https://www.ozlabs.org/~akpm/mmotm/series contains:
> 
> 
> mm-optimize-do_wp_page-for-exclusive-pages-in-the-swapcache.patch
> mm-optimize-do_wp_page-for-fresh-pages-in-local-lru-pagevecs.patch
> mm-slightly-clarify-ksm-logic-in-do_swap_page.patch
> mm-streamline-cow-logic-in-do_swap_page.patch
> mm-huge_memory-streamline-cow-logic-in-do_huge_pmd_wp_page.patch
> mm-khugepaged-remove-reuse_swap_page-usage.patch
> mm-swapfile-remove-stale-reuse_swap_page.patch
> mm-huge_memory-remove-stale-page_trans_huge_mapcount.patch
> ...
> #[merged]mm-huge_memory-remove-stale-locking-logic-from-__split_huge_pmd.patch

OK, thanks.  I guess it was me seeing 100% rejects when merging onto
the folio changes then incorrectly deciding the patch was now in
linux-next via some other tree.

I restored it and fixed things up.  Please check.


--- a/mm/huge_memory.c~mm-huge_memory-remove-stale-locking-logic-from-__split_huge_pmd
+++ a/mm/huge_memory.c
@@ -2133,8 +2133,6 @@ void __split_huge_pmd(struct vm_area_str
 {
 	spinlock_t *ptl;
 	struct mmu_notifier_range range;
-	bool do_unlock_folio = false;
-	pmd_t _pmd;
 
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, vma->vm_mm,
 				address & HPAGE_PMD_MASK,
@@ -2153,42 +2151,14 @@ void __split_huge_pmd(struct vm_area_str
 			goto out;
 	}
 
-repeat:
 	if (pmd_trans_huge(*pmd)) {
-		if (!folio) {
+		if (!folio)
 			folio = page_folio(pmd_page(*pmd));
-			/*
-			 * An anonymous page must be locked, to ensure that a
-			 * concurrent reuse_swap_page() sees stable mapcount;
-			 * but reuse_swap_page() is not used on shmem or file,
-			 * and page lock must not be taken when zap_pmd_range()
-			 * calls __split_huge_pmd() while i_mmap_lock is held.
-			 */
-			if (folio_test_anon(folio)) {
-				if (unlikely(!folio_trylock(folio))) {
-					folio_get(folio);
-					_pmd = *pmd;
-					spin_unlock(ptl);
-					folio_lock(folio);
-					spin_lock(ptl);
-					if (unlikely(!pmd_same(*pmd, _pmd))) {
-						folio_unlock(folio);
-						folio_put(folio);
-						folio = NULL;
-						goto repeat;
-					}
-					folio_put(folio);
-				}
-				do_unlock_folio = true;
-			}
-		}
 	} else if (!(pmd_devmap(*pmd) || is_pmd_migration_entry(*pmd)))
 		goto out;
 	__split_huge_pmd_locked(vma, pmd, range.start, freeze);
 out:
 	spin_unlock(ptl);
-	if (do_unlock_folio)
-		folio_unlock(folio);
 	/*
 	 * No need to double call mmu_notifier->invalidate_range() callback.
 	 * They are 3 cases to consider inside __split_huge_pmd_locked():
_


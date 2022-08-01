Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD795863C1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 07:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239478AbiHAFdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 01:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiHAFdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 01:33:44 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4899FE3
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 22:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659332023; x=1690868023;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=6D3wr+/VNs174wNAHGv2JVNTAzL/t7bNU9UZbvU6p4o=;
  b=ILBnLpx0fyDzNfpsBVybEkTxEqfcmHntfjsB/Kt0TZTNzKpUnV5GZYhn
   XEvz0rcARaZ41H7z2b5jiiAl2Hytao0ZYA8nOtov65gneyLktnJVC1gwE
   PRGyc1R+7t+P7CLf+ia3YXw5doQxHUFILZVHQQCFJjo/cpYct4G4jT+Hs
   1SEKt/JyIcBUJfTAQH119x+NJvaZUfnPDZwrKGnE9j/C1aH75EOg/sW4B
   DrNV7a/iC+aMLCVyJXwDnnDY9UIrMa12RZIeaA/xOJhc78vRrC91sJKZ6
   c/On3nDQ/fZcjDONEvtHrCgXz94Vkyu0mRW4sdHUX/f1ccknrrnP6BfxN
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10425"; a="350774130"
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="350774130"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2022 22:33:43 -0700
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="577656386"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2022 22:33:40 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Nadav Amit <nadav.amit@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andi Kleen <andi.kleen@intel.com>
Subject: Re: [PATCH RFC 0/4] mm: Remember young bit for migration entries
References: <20220729014041.21292-1-peterx@redhat.com>
Date:   Mon, 01 Aug 2022 13:33:28 +0800
In-Reply-To: <20220729014041.21292-1-peterx@redhat.com> (Peter Xu's message of
        "Thu, 28 Jul 2022 21:40:37 -0400")
Message-ID: <87pmhkjzo7.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Xu <peterx@redhat.com> writes:

> [Marking as RFC; only x86 is supported for now, plan to add a few more
>  archs when there's a formal version]
>
> Problem
> =======
>
> When migrate a page, right now we always mark the migrated page as old.
> The reason could be that we don't really know whether the page is hot or
> cold, so we could have taken it a default negative assuming that's safer.
>
> However that could lead to at least two problems:
>
>   (1) We lost the real hot/cold information while we could have persisted.
>       That information shouldn't change even if the backing page is changed
>       after the migration,
>
>   (2) There can be always extra overhead on the immediate next access to
>       any migrated page, because hardware MMU needs cycles to set the young
>       bit again (as long as the MMU supports).
>
> Many of the recent upstream works showed that (2) is not something trivial
> and actually very measurable.  In my test case, reading 1G chunk of memory
> - jumping in page size intervals - could take 99ms just because of the
> extra setting on the young bit on a generic x86_64 system, comparing to 4ms
> if young set.
>
> This issue is originally reported by Andrea Arcangeli.
>
> Solution
> ========
>
> To solve this problem, this patchset tries to remember the young bit in the
> migration entries and carry it over when recovering the ptes.
>
> We have the chance to do so because in many systems the swap offset is not
> really fully used.  Migration entries use swp offset to store PFN only,
> while the PFN is normally not as large as swp offset and normally smaller.
> It means we do have some free bits in swp offset that we can use to store
> things like young, and that's how this series tried to approach this
> problem.
>
> One tricky thing here is even though we're embedding the information into
> swap entry which seems to be a very generic data structure, the number of
> bits that are free is still arch dependent.  Not only because the size of
> swp_entry_t differs, but also due to the different layouts of swap ptes on
> different archs.

If my understanding were correct, max_swapfile_size() provides a
mechanism to identify the available bits with swp_entry_t and swap PTE
considered.  We may take advantage of that?

And according to commit 377eeaa8e11f ("x86/speculation/l1tf: Limit swap
file size to MAX_PA/2"), the highest bit of swap offset needs to be 0 if
L1TF mitigation is enabled.

Cced Andi for confirmation.

Best Regards,
Huang, Ying

> Here, this series requires specific arch to define an extra macro called
> __ARCH_SWP_OFFSET_BITS represents the size of swp offset.  With this
> information, the swap logic can know whether there's extra bits to use,
> then it'll remember the young bits when possible.  By default, it'll keep
> the old behavior of keeping all migrated pages cold.
>
> Tests
> =====
>
> After the patchset applied, the immediate read access test [1] of above 1G
> chunk after migration can shrink from 99ms to 4ms.  The test is done by
> moving 1G pages from node 0->1->0 then read it in page size jumps.
>
> Currently __ARCH_SWP_OFFSET_BITS is only defined on x86 for this series and
> only tested on x86_64 with Intel(R) Xeon(R) CPU E5-2630 v4 @ 2.20GHz.
>
> Patch Layout
> ============
>
> Patch 1:  Add swp_offset_pfn() and apply to all pfn swap entries, we should
>           also stop treating swp_offset() as PFN anymore because it can
>           contain more information starting from next patch.
> Patch 2:  The core patch to remember young bit in swap offsets.
> Patch 3:  A cleanup for x86 32 bits pgtable.h.
> Patch 4:  Define __ARCH_SWP_OFFSET_BITS on x86, enable young bit for migration
>
> Please review, thanks.
>
> [1] https://github.com/xzpeter/clibs/blob/master/misc/swap-young.c
>
> Peter Xu (4):
>   mm/swap: Add swp_offset_pfn() to fetch PFN from swap entry
>   mm: Remember young bit for page migrations
>   mm/x86: Use SWP_TYPE_BITS in 3-level swap macros
>   mm/x86: Define __ARCH_SWP_OFFSET_BITS
>
>  arch/arm64/mm/hugetlbpage.c           |  2 +-
>  arch/x86/include/asm/pgtable-2level.h |  6 ++
>  arch/x86/include/asm/pgtable-3level.h | 15 +++--
>  arch/x86/include/asm/pgtable_64.h     |  5 ++
>  include/linux/swapops.h               | 85 +++++++++++++++++++++++++--
>  mm/hmm.c                              |  2 +-
>  mm/huge_memory.c                      | 10 +++-
>  mm/memory-failure.c                   |  2 +-
>  mm/migrate.c                          |  4 +-
>  mm/migrate_device.c                   |  2 +
>  mm/page_vma_mapped.c                  |  6 +-
>  mm/rmap.c                             |  3 +-
>  12 files changed, 122 insertions(+), 20 deletions(-)

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6098158E467
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 03:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiHJBRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 21:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiHJBRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 21:17:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D32A606A4;
        Tue,  9 Aug 2022 18:17:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD0B161233;
        Wed, 10 Aug 2022 01:17:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09280C433D7;
        Wed, 10 Aug 2022 01:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1660094263;
        bh=kLAFyrpdrl8QdNdjD7r3oy6bGtZvjGcHF8LMVdgzi6g=;
        h=Date:From:To:Cc:Subject:From;
        b=RHKKtGkMx0G/oNfkv3eQ6tyCYu3amobQfOBC/CwgtQrSicHVhU48mFnhnAYW5kf3x
         6xWd82pTqiQArk1ZqUkXDXFFBr7HaNNRKiXQ7NFdp3zwdjLWpWH8FhnvYMjzyUTnbL
         8/C2y/qW/EOsf1/A7QnXDUhaVOGzo26U3Wg78kh8=
Date:   Tue, 9 Aug 2022 18:17:42 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mm@kvack.org, mm-commits@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] remaining MM updates for 5.20-r1
Message-Id: <20220809181742.30eb3ee4071d2b8bb81bc959@linux-foundation.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Three patch series - two that perform cleanups and one feature.


The following changes since commit c8a684e2e110376c58f0bfa30fb3855d1e319670:

  Merge tag 'leds-5.20-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/pavel/linux-leds (2022-08-08 11:36:21 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-stable-2022-08-09

for you to fetch changes up to a9e9c93966afdaae74a6a7533552391646b93f2c:

  Documentation/mm: add details about kmap_local_page() and preemption (2022-08-08 18:06:46 -0700)

----------------------------------------------------------------
- hugetlb_vmemmap cleanups from Muchun Song

- hardware poisoning support for 1GB hugepages, from Naoya Horiguchi

- highmem documentation fixups from Fabio De Francesco

----------------------------------------------------------------
Fabio M. De Francesco (7):
      highmem: remove unneeded spaces in kmap_local_page() kdocs
      highmem: specify that kmap_local_page() is callable from interrupts
      Documentation/mm: don't kmap*() pages which can't come from HIGHMEM
      Documentation/mm: avoid invalid use of addresses from kmap_local_page()
      Documentation/mm: rrefer kmap_local_page() and avoid kmap()
      highmem: delete a sentence from kmap_local_page() kdocs
      Documentation/mm: add details about kmap_local_page() and preemption

Muchun Song (8):
      mm: hugetlb_vmemmap: delete hugetlb_optimize_vmemmap_enabled()
      mm: hugetlb_vmemmap: optimize vmemmap_optimize_mode handling
      mm: hugetlb_vmemmap: introduce the name HVO
      mm: hugetlb_vmemmap: move vmemmap code related to HugeTLB to hugetlb_vmemmap.c
      mm: hugetlb_vmemmap: replace early_param() with core_param()
      mm: hugetlb_vmemmap: improve hugetlb_vmemmap code readability
      mm: hugetlb_vmemmap: move code comments to vmemmap_dedup.rst
      mm: hugetlb_vmemmap: use PTRS_PER_PTE instead of PMD_SIZE / PAGE_SIZE

Naoya Horiguchi (8):
      mm/hugetlb: check gigantic_page_runtime_supported() in return_unused_surplus_pages()
      mm/hugetlb: make pud_huge() and follow_huge_pud() aware of non-present pud entry
      mm, hwpoison, hugetlb: support saving mechanism of raw error pages
      mm, hwpoison: make unpoison aware of raw error info in hwpoisoned hugepage
      mm, hwpoison: set PG_hwpoison for busy hugetlb pages
      mm, hwpoison: make __page_handle_poison returns int
      mm, hwpoison: skip raw hwpoison page in freeing 1GB hugepage
      mm, hwpoison: enable memory error handling on 1GB hugepage

 Documentation/admin-guide/kernel-parameters.txt |   7 +-
 Documentation/admin-guide/mm/hugetlbpage.rst    |   4 +-
 Documentation/admin-guide/mm/memory-hotplug.rst |   4 +-
 Documentation/admin-guide/sysctl/vm.rst         |   3 +-
 Documentation/mm/highmem.rst                    |  31 +-
 Documentation/mm/vmemmap_dedup.rst              |  72 ++-
 arch/arm64/mm/flush.c                           |  13 +-
 arch/x86/mm/hugetlbpage.c                       |   8 +-
 fs/Kconfig                                      |  12 +-
 include/linux/highmem.h                         |   7 +-
 include/linux/hugetlb.h                         |  24 +-
 include/linux/mm.h                              |   9 +-
 include/linux/page-flags.h                      |  32 +-
 include/linux/swapops.h                         |   9 +
 include/linux/sysctl.h                          |   4 +
 include/ras/ras_event.h                         |   1 -
 mm/hugetlb.c                                    |  73 ++-
 mm/hugetlb_vmemmap.c                            | 589 ++++++++++++++++++------
 mm/hugetlb_vmemmap.h                            |  45 +-
 mm/memory-failure.c                             | 179 +++++--
 mm/sparse-vmemmap.c                             | 399 ----------------
 21 files changed, 823 insertions(+), 702 deletions(-)


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C45054F99C9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 17:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237751AbiDHPq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 11:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbiDHPq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 11:46:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534C7A7767
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 08:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=XVrmVkxbZFeUzPkrlxP1pQ2QZfiyERI64e73B6PlUOc=; b=sWAqtlNPk3PGf03p3TMbmgC1xH
        bsKSGgaw1sxTQA9mevK0NXrgXDAaZK4olcHFJxwof3Ny+xuM2dQMb8FtC+fMyrUy3fZjQmLmMKiwv
        QhvuhAi/MH6IP2E6db8RaR/kIGimmb255F3dQKEgNeAEQe7GjlJQuXAbM7bZeWQBtomWO4xvpWgyo
        G79hDb1DDJVR5rzEixPIMpjr22wIcvI+KtQe/iqblOVG93ejdjcS07WrDmrk0DTTF1/iCU1xRPlUD
        woKvDCsrxpEOmmur9R68BSXOzWtkhx9zcYvErvepoy3flXA3aB4b44VQ4KEAZ9GultFZ9mEuj1QfE
        2ZvVc8HQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ncqn2-009war-Vp; Fri, 08 Apr 2022 15:44:49 +0000
Date:   Fri, 8 Apr 2022 16:44:48 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Folio fixes for 5.18-rc1
Message-ID: <YlBYcG5bm03dhqHI@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fewer bug reports than I was expecting from enabling large folios.
One that doesn't show up on x86 but does on arm64, one that shows up
with hugetlbfs memory failure testing and one that shows up with page
migration, which it turns out I wasn't testing because my last NUMA
machine died.  Need to set up a qemu fake NUMA machine so I don't skip
testing that in future.

The following changes since commit 3e732ebf7316ac83e8562db7e64cc68aec390a18:

  Merge tag 'for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost (2022-04-05 10:40:52 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/willy/pagecache.git tags/folio-5.18e

for you to fetch changes up to 98ea02597b9967c0817d29fee2f96d21b9e59ca5:

  mm/rmap: Fix handling of hugetlbfs pages in page_vma_mapped_walk (2022-04-07 10:11:20 -0400)

----------------------------------------------------------------
Three folio-related fixes for 5.18:

 - Remove the migration code's assumptions about large pages being PMD sized

 - Don't call pmd_page() on a non-leaf PMD

 - Fix handling of hugetlbfs pages in page_vma_mapped_walk

----------------------------------------------------------------
Matthew Wilcox (Oracle) (5):
      mm/huge_memory: Avoid calling pmd_page() on a non-leaf PMD
      mm/migrate: Use a folio in alloc_migration_target()
      mm/migrate: Use a folio in migrate_misplaced_transhuge_page()
      mm: Add vma_alloc_folio()
      mm/mempolicy: Use vma_alloc_folio() in new_page()

zhenwei pi (1):
      mm/rmap: Fix handling of hugetlbfs pages in page_vma_mapped_walk

 include/linux/gfp.h  |  8 ++++--
 mm/huge_memory.c     | 11 ++++----
 mm/mempolicy.c       | 38 ++++++++++++++++---------
 mm/migrate.c         | 80 +++++++++++++++++-----------------------------------
 mm/page_vma_mapped.c |  6 ++--
 5 files changed, 64 insertions(+), 79 deletions(-)


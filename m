Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10D5536697
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 19:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354315AbiE0RaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 13:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354324AbiE0RaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 13:30:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B0578905;
        Fri, 27 May 2022 10:30:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64E9461DD4;
        Fri, 27 May 2022 17:30:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A42ACC385A9;
        Fri, 27 May 2022 17:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1653672615;
        bh=DRbdVK7ebjAFaviXvuPpdxj4DfolmqNryDBytbwEKgc=;
        h=Date:From:To:Cc:Subject:From;
        b=n15PVRxHeWxwHcvVnGMRW5PrQdfWh0ogIEEZEbE5i0a2izv2KnqPJkcNqeakZi45t
         srJE0rqhqU8hvLIdjPzxyqQetexMXNN/0u/sOiBqg8ji5m1KMRnGODdCe9T7+cNLd2
         aTzHx6QsTsGtltG5wNb4GmdgiBn2Uhs+Ko8Dv8qI=
Date:   Fri, 27 May 2022 10:30:14 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        mm-commits@vger.kernel.org
Subject: [GIT PULL] additional MM updates for 5.19-rc1
Message-Id: <20220527103014.517818624f9f6d4f0ba0b523@linux-foundation.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Pretty much the final flush here.  Mel's "Drain remote per-cpu
directly" series might be stabilized later in the merge window.

There's a merge conflict in init/Kconfig.  We resolved that by removing
the VM_EVENT_COUNTERS..MMAP_ALLOW_UNINITIALIZED entries.

And another in lib/Kconfig.debug.  Similarly resolved by removing the
DEBUG_SLAB..SLUB_STATS entries.



I'll shortly be resurrecting Liam's maple-tree patchset for additional
stabilization and a view to merge that up for 5.20.  And shortly after
that I'll bring in Yu Zhau's multigen LRU work to get that some
linux-next testing and hopefully reviewer provocation.



The following changes since commit f403f22f8ccb12860b2b62fec3173c6ccd45938b:

  mm: kfence: use PAGE_ALIGNED helper (2022-05-25 10:47:49 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-stable-2022=
-05-27

for you to fetch changes up to fa020a2b87d24016723fff4a4237deb612478a32:

  mm/shmem.c: suppress shift warning (2022-05-27 09:33:47 -0700)

----------------------------------------------------------------
Two followon fixes for the post-5.19 series "Use pageblock_order for cma
and alloc_contig_range alignment", from Zi Yan.

A series of z3fold cleanups and fixes from Miaohe Lin.

Some memcg selftests work from Michal Koutn=FD <mkoutny@suse.com>

Some swap fixes and cleanups from Miaohe Lin.

Several individual minor fixups.

----------------------------------------------------------------
Andrew Morton (1):
      mm/shmem.c: suppress shift warning

Kefeng Wang (1):
      mm: kasan: fix input of vmalloc_to_page()

Miaohe Lin (14):
      mm/z3fold: fix sheduling while atomic
      mm/z3fold: fix possible null pointer dereferencing
      mm/z3fold: remove buggy use of stale list for allocation
      mm/z3fold: throw warning on failure of trylock_page in z3fold_alloc
      revert "mm/z3fold.c: allow __GFP_HIGHMEM in z3fold_alloc"
      mm/z3fold: put z3fold page back into unbuddied list when reclaim or m=
igration fails
      mm/z3fold: always clear PAGE_CLAIMED under z3fold page lock
      mm/z3fold: fix z3fold_reclaim_page races with z3fold_free
      mm/z3fold: fix z3fold_page_migrate races with z3fold_map
      mm/swapfile: unuse_pte can map random data if swap read fails
      mm/swapfile: fix lost swap bits in unuse_pte()
      mm/madvise: free hwpoison and swapin error entry in madvise_free_pte_=
range
      mm/shmem: fix infinite loop when swap in shmem error at swapoff time
      mm: filter out swapin error entry in shmem mapping

Michal Koutn=FD (5):
      selftests: memcg: fix compilation
      selftests: memcg: expect no low events in unprotected sibling
      selftests: memcg: adjust expected reclaim values of protected cgroups
      selftests: memcg: remove protection from top level memcg
      selftests: memcg: factor out common parts of memory.{low,min} tests

Minchan Kim (1):
      mm: fix is_pinnable_page against a cma page

Vlastimil Babka (1):
      mm: Kconfig: reorganize misplaced mm options

Zi Yan (2):
      mm: page-isolation: skip isolated pageblock in start_isolate_page_ran=
ge()
      mm: split free page with properly free memory accounting and without =
race

 MAINTAINERS                                       |   1 +
 include/linux/mm.h                                |   9 +-
 include/linux/swap.h                              |   7 +-
 include/linux/swapops.h                           |  10 +
 init/Kconfig                                      |  53 -----
 lib/Kconfig.debug                                 |  34 ---
 mm/Kconfig                                        |  56 +++++
 mm/Kconfig.debug                                  |  31 +++
 mm/internal.h                                     |   4 +-
 mm/kasan/report.c                                 |   2 +-
 mm/madvise.c                                      |  18 +-
 mm/memory.c                                       |   5 +-
 mm/page_alloc.c                                   |  32 ++-
 mm/page_isolation.c                               |  36 +++-
 mm/shmem.c                                        |  41 +++-
 mm/swap_state.c                                   |   3 +
 mm/swapfile.c                                     |  21 +-
 mm/z3fold.c                                       |  97 ++++-----
 tools/testing/selftests/cgroup/memcg_protection.m |  89 ++++++++
 tools/testing/selftests/cgroup/test_memcontrol.c  | 247 ++++++------------=
----
 20 files changed, 434 insertions(+), 362 deletions(-)
 create mode 100644 tools/testing/selftests/cgroup/memcg_protection.m


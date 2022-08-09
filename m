Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBD758E248
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 00:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbiHIWBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 18:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiHIWBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 18:01:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B4018E08
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 15:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660082464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=2Y05UawN7N/AGIQ2Hdz9OrZ5faEMa1jRZA1Sh+qd1pw=;
        b=eAbP0VioU2vJ8HmjKitJe17A/SqwK/IoiQLHjhBgWipaH/iv6DG9xL4AhliAFNx2jour6M
        O6AufH+k+qbpYiLp14vd27vIahNbW69MalOPhsBPOglwnFAsDLlKU7vFu+ZEPidiMo1OQi
        wSyTlr7v6F8bsS6nShnfMOimYuGZNrk=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-240-VIwMs2SQOcKN7VyyuzXtcQ-1; Tue, 09 Aug 2022 18:01:03 -0400
X-MC-Unique: VIwMs2SQOcKN7VyyuzXtcQ-1
Received: by mail-qk1-f199.google.com with SMTP id bp14-20020a05620a458e00b006b959ef9d51so4891852qkb.12
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 15:01:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=2Y05UawN7N/AGIQ2Hdz9OrZ5faEMa1jRZA1Sh+qd1pw=;
        b=EIQqzGOvCIDpJoBeRGuiCgOJigLnjXjnKs7fLwZxtqfmNM7LzCJqkmVZIlNaGyyP0D
         V7j/ncaL2ItJCUyiptY844MFYfMeRIyOXzsLFQmw2WxHNJybsMGXuL1RFj9Y1Z0hhnOt
         k91L7Q5HRiNWjKvLe7eumqviFeor0UYly6wnTcwEvBqKuokG7jfnavaqiE2FsyDLEzNs
         2LkWQdYsSOB2ywQ8cu7f5l6C+fA/rAAoIC7CySB37JBZeuPN0ym4kilrhfbWgWHUAk0p
         ajOqjE/P7BlZdRx86PGiHbsoHRV6TdSA0l3heu/+D2waX0wXuC0MANmFitSUKZdvlIkf
         g7NA==
X-Gm-Message-State: ACgBeo3JZoUCqBUPXnBeKfiAeGg0EoJTkRXq6lzt/CMzf34Q8Q24aDGp
        uTlkSLtKCAv+Nk5mLVUSoKnHZEdJrDfgfYHp1XsmsTa0Mo63Bn2L06bsHKYIbKdTaiPh12EdyXP
        I75pSo3KUu8gbsEskX+qI10xU
X-Received: by 2002:a05:620a:2b8b:b0:6b9:43ca:4a6 with SMTP id dz11-20020a05620a2b8b00b006b943ca04a6mr9354362qkb.346.1660082463328;
        Tue, 09 Aug 2022 15:01:03 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7sp5xe6cpJkByfw2vmK3F81PdNa3RHkuG6pyvhf2+9jfQmNT/KF3UoFptTnCY9sWk3mgI8Yw==
X-Received: by 2002:a05:620a:2b8b:b0:6b9:43ca:4a6 with SMTP id dz11-20020a05620a2b8b00b006b943ca04a6mr9354332qkb.346.1660082463063;
        Tue, 09 Aug 2022 15:01:03 -0700 (PDT)
Received: from localhost.localdomain (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id b16-20020a05622a021000b0031eddc83560sm10563383qtx.90.2022.08.09.15.01.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 09 Aug 2022 15:01:02 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     peterx@redhat.com, Minchan Kim <minchan@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Huang Ying <ying.huang@intel.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: [PATCH v3 0/7] mm: Remember a/d bits for migration entries
Date:   Tue,  9 Aug 2022 18:00:53 -0400
Message-Id: <20220809220100.20033-1-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3:
- Rebased to akpm/mm-unstable
- Use BIT() [Nadav]
- One more patch to add comment for "ifdef"s [Nadav]
- Added one ascii table for migration swp offset layout [David]
- Move comment to be above "if"s [Ying]
- Separate the dirty bit carry-over of pmd split to separate patch [Ying]
- Added two patches to cache both max_swapfile_size and
  migration_entry_supports_ad() at the end

rfc: https://lore.kernel.org/all/20220729014041.21292-1-peterx@redhat.com
v1:  https://lore.kernel.org/all/20220803012159.36551-1-peterx@redhat.com
v2:  https://lore.kernel.org/all/20220804203952.53665-1-peterx@redhat.com

Problem
=======

When migrate a page, right now we always mark the migrated page as old &
clean.

However that could lead to at least two problems:

  (1) We lost the real hot/cold information while we could have persisted.
      That information shouldn't change even if the backing page is changed
      after the migration,

  (2) There can be always extra overhead on the immediate next access to
      any migrated page, because hardware MMU needs cycles to set the young
      bit again for reads, and dirty bits for write, as long as the
      hardware MMU supports these bits.

Many of the recent upstream works showed that (2) is not something trivial
and actually very measurable.  In my test case, reading 1G chunk of memory
- jumping in page size intervals - could take 99ms just because of the
extra setting on the young bit on a generic x86_64 system, comparing to 4ms
if young set.

This issue is originally reported by Andrea Arcangeli.

Solution
========

To solve this problem, this patchset tries to remember the young/dirty bits
in the migration entries and carry them over when recovering the ptes.

We have the chance to do so because in many systems the swap offset is not
really fully used.  Migration entries use swp offset to store PFN only,
while the PFN is normally not as large as swp offset and normally smaller.
It means we do have some free bits in swp offset that we can use to store
things like A/D bits, and that's how this series tried to approach this
problem.

max_swapfile_size() is used here to detect per-arch offset length in swp
entries.  We'll automatically remember the A/D bits when we find that we
have enough swp offset field to keep both the PFN and the extra bits.

Since max_swapfile_size() can be slow, the last two patches cache the
results for it and also swap_migration_ad_supported as a whole.

Tests
=====

After the patchset applied, the immediate read access test [1] of above 1G
chunk after migration can shrink from 99ms to 4ms.  The test is done by
moving 1G pages from node 0->1->0 then read it in page size jumps.  The
test is with Intel(R) Xeon(R) CPU E5-2630 v4 @ 2.20GHz.

Similar effect can also be measured when writting the memory the 1st time
after migration.

After applying the patchset, both initial immediate read/write after page
migrated will perform similarly like before migration happened.

Patch Layout
============

Patch 1-2:  Cleanups from either previous versions or on swapops.h macros.

Patch 3-4:  Prepare for the introduction of migration A/D bits

Patch 5:    The core patch to remember young/dirty bit in swap offsets.

Patch 6-7:  Cache relevant fields to make migration_entry_supports_ad() fast.

Please review, thanks.

[1] https://github.com/xzpeter/clibs/blob/master/misc/swap-young.c

Peter Xu (7):
  mm/x86: Use SWP_TYPE_BITS in 3-level swap macros
  mm/swap: Comment all the ifdef in swapops.h
  mm/swap: Add swp_offset_pfn() to fetch PFN from swap entry
  mm/thp: Carry over dirty bit when thp splits on pmd
  mm: Remember young/dirty bit for page migrations
  mm/swap: Cache maximum swapfile size when init swap
  mm/swap: Cache swap migration A/D bits support

 arch/arm64/mm/hugetlbpage.c           |   2 +-
 arch/x86/include/asm/pgtable-3level.h |   8 +-
 arch/x86/mm/init.c                    |   2 +-
 include/linux/swapfile.h              |   1 +
 include/linux/swapops.h               | 145 +++++++++++++++++++++++---
 mm/hmm.c                              |   2 +-
 mm/huge_memory.c                      |  24 ++++-
 mm/memory-failure.c                   |   2 +-
 mm/migrate.c                          |   6 +-
 mm/migrate_device.c                   |   4 +
 mm/page_vma_mapped.c                  |   6 +-
 mm/rmap.c                             |   5 +-
 mm/swapfile.c                         |  18 +++-
 13 files changed, 194 insertions(+), 31 deletions(-)

-- 
2.32.0


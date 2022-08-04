Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D76758A226
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 22:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237361AbiHDUkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 16:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234385AbiHDUj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 16:39:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B93553F338
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 13:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659645596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=1MZEhXGPLmxxGTFBXqyHNwWW8pRxmnJfI3yJxThqftE=;
        b=VKoHC3QDF2S4Ofh00H22/7ig6I89npoQx+VSoU+uUVv3bFam9SpGXeW4srk30PzgStAnng
        gmRH6RBE0qIv/SMgVN/yoxruj3RBIDsm2sTNbPT+0cWanpsmlutMF25ntHVt3wRv6f3e2B
        raiIZziiLJ19luowXrw+ZMDySwfdUts=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-588--pd5cCpSNR263WM02kwddw-1; Thu, 04 Aug 2022 16:39:55 -0400
X-MC-Unique: -pd5cCpSNR263WM02kwddw-1
Received: by mail-qt1-f199.google.com with SMTP id u12-20020a05622a010c00b0031ef5b46dc0so562034qtw.16
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 13:39:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=1MZEhXGPLmxxGTFBXqyHNwWW8pRxmnJfI3yJxThqftE=;
        b=xAhH7ABy4u0n/j23ggFKpwffShUSoubHqfZcWbOLUBusBELotwuV/JiDrvp0//ixrm
         apupKynX2yxYHM0QmHtq/RwfD3w0DnRRwwKkyvFWadp3cmD3jvKXeuNnqs81NqqRzRF8
         X6HZm3WtMdfH7yic0zy/lgusUcFk7YV+by2yvRU1PyiO6sO0FUxWpvRaT/FAS2NDEoS/
         Ump8eEozq5lJrQaQ7q5DHY8P6mAk/59SIp4eZsCzCBA9qken0Ipy8NK+LhMEGynHnmYP
         xMDuneJEq4i207fgo/WzWzwjLzjsLE1zstnhxcGCDqwLy4CgeFKwBN4WaFgAdwERcrD9
         nBtw==
X-Gm-Message-State: ACgBeo39t2HpY3gm4f2rCAU9yPgeQ2LUJ9UUiIxpCz4p+Z4V4BeYd6jr
        d2mx00Tx5Nrfrb5Kd+hiPRoVt1zDjXQtNE8LxkvlsvAB1TSpXTP8P32x2vN37GvNQe7jTnIuOPK
        nwpXOEkAriKmh/rxrgcJj4ExI
X-Received: by 2002:a05:620a:2804:b0:6b8:5f52:c66b with SMTP id f4-20020a05620a280400b006b85f52c66bmr2827355qkp.8.1659645595166;
        Thu, 04 Aug 2022 13:39:55 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5Y2IDkecy+Qrvyscm6Uko/4DMUWbSh00qHIiYTLsn9oAJI5FraJkHOL5ve0uc5Uyqsjq1+QQ==
X-Received: by 2002:a05:620a:2804:b0:6b8:5f52:c66b with SMTP id f4-20020a05620a280400b006b85f52c66bmr2827342qkp.8.1659645594876;
        Thu, 04 Aug 2022 13:39:54 -0700 (PDT)
Received: from localhost.localdomain (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id k19-20020ae9f113000000b006b5e50057basm1395266qkg.95.2022.08.04.13.39.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 04 Aug 2022 13:39:54 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Huang Ying <ying.huang@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Nadav Amit <nadav.amit@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Andi Kleen <andi.kleen@intel.com>, peterx@redhat.com,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: [PATCH v2 0/2] mm: Remember a/d bits for migration entries
Date:   Thu,  4 Aug 2022 16:39:50 -0400
Message-Id: <20220804203952.53665-1-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2:
- Fix build for !CONFIG_SWAP [syzbot]
- Carry over dirty bit too [Nadav]

rfc: https://lore.kernel.org/all/20220729014041.21292-1-peterx@redhat.com
v1:  https://lore.kernel.org/all/20220803012159.36551-1-peterx@redhat.com

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

This series is majorly solving the bit lost issue only for the migration
procedure.  Besides that, a few topics to mention related to this series:

  (1) Page Idle Tracking

  Before this series, idle tracking can cause false negative if an accessed
  page got migrated, since after migration the young bit will get lost.
  After this series, it'll be better in that after migration young bit will
  be persisted, so it'll be able to be detected correctly by page idle
  logic when walking the pgtable.

  However there's still nothing done when page idle reset was carried out
  during migration procedure in progress, but that should be a separate
  topic to be addressed (e.g. to teach rmap pgtable walk code to be able to
  walk with both present ptes and migration ptes).

  (2) MADV_COLD/MADV_FREE

  This series doesn't teach madvise() code to recognize the new entries
  with reasons.

  Currently MADV_COLD is not handled for migration entries containing A
  bit.  Logically A bit should be dropped when colding a page, but here the
  more important thing is probably LRU operations which is still missing.
  It may justify that it is not a major scenario for COLD on migration
  entries.

  Similar thing applies to MADV_FREE: logically we should consider dropping
  migration entries as a whole if it is found.  In all cases, this series
  didn't cover any of the cases above assuming they'll be either kept as-is
  or be addressed in separate patchset.

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

Patch 1:  Add swp_offset_pfn() and apply to all pfn swap entries, we should
          also stop treating swp_offset() as PFN anymore because it can
          contain more information starting from next patch.
Patch 2:  The core patch to remember young/dirty bit in swap offsets.

Please review, thanks.

[1] https://github.com/xzpeter/clibs/blob/master/misc/swap-young.c

Peter Xu (2):
  mm/swap: Add swp_offset_pfn() to fetch PFN from swap entry
  mm: Remember young/dirty bit for page migrations

 arch/arm64/mm/hugetlbpage.c |   2 +-
 include/linux/swapops.h     | 126 ++++++++++++++++++++++++++++++++++--
 mm/hmm.c                    |   2 +-
 mm/huge_memory.c            |  26 +++++++-
 mm/memory-failure.c         |   2 +-
 mm/migrate.c                |   6 +-
 mm/migrate_device.c         |   4 ++
 mm/page_vma_mapped.c        |   6 +-
 mm/rmap.c                   |   5 +-
 9 files changed, 163 insertions(+), 16 deletions(-)

-- 
2.32.0


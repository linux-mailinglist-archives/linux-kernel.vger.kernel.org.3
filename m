Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F33590495
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 18:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239085AbiHKQmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 12:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239146AbiHKQkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 12:40:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EBEB9A5C43
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 09:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660234415;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=o5K8D5nZ/uY08WZ/7Zkfk1bCipsWkKVnCE+5nhtZSvY=;
        b=CPhRda2xUGIy33ZprExOIXGw/mFa5+85TNIi9QvaYEeebSxujdFPE88HQ9Ep2BhE4XAUMO
        8hLp3V1xchcf9vE7Uft015EmYJHmBqUoUKhf8zWGZDg0uv9RWt/za6Pg96kr0lHo/b7ctE
        wCsC8nchrEp2ljGGCNCVp/Y455ElR2I=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-593-5oZoINwIPVSPqLMKsF0n7Q-1; Thu, 11 Aug 2022 12:13:34 -0400
X-MC-Unique: 5oZoINwIPVSPqLMKsF0n7Q-1
Received: by mail-io1-f70.google.com with SMTP id g22-20020a056602249600b0067caba4f24bso9925196ioe.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 09:13:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=o5K8D5nZ/uY08WZ/7Zkfk1bCipsWkKVnCE+5nhtZSvY=;
        b=Ds3WsiD+lkGfXHKRp+IVVjxmPuQj0peeSg5L25u1JVj4whx5J2dFbOqpko2suyS46l
         K38L5rKAfv+W/cQNizT+zXOBUlWWYrvXocfzUk9qDrwa48dRsgzThqyanhHLibigLOLH
         +oatIw1X13anycjPSfQGZdQG5BoJg6L0jvWC/CmGj47KpbW8c+jqMYf4+0L6yvRZMw2o
         iIyZAYp/qv2RQrQcQDX3UMA0/n9O0qnIOlxE82Pg+t2qbfNodaC8EG/rAe+RgW/C124l
         FPkdkhohIeU+ztxeXiMv/m6QPr40LRro0QjTUedyavNW0XKQ3WfEoZ4x0iJSSnN+FOAg
         3big==
X-Gm-Message-State: ACgBeo0EM5r54YPww6JEopbrgQQRgPxAZub9FbaAKyJVN57Q/Y/Bf9Uj
        cNpw8/Wk3G2ecuWSqMTM+TMJzClEN6uCOATtUOVUJPuKC2giJV4kTklAp+lmDIav4NZlfwenkte
        7PoqDUWQuixM0iVyV34Dpz4tU
X-Received: by 2002:a5d:914e:0:b0:67c:f003:935c with SMTP id y14-20020a5d914e000000b0067cf003935cmr12738ioq.99.1660234413964;
        Thu, 11 Aug 2022 09:13:33 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6nZjgVTgupJDvURG32D4tSR9ojNEnVSF1IVXHqscfzZtFeLR56o20PGY+08G0eNBqPR0FmwA==
X-Received: by 2002:a5d:914e:0:b0:67c:f003:935c with SMTP id y14-20020a5d914e000000b0067cf003935cmr12721ioq.99.1660234413686;
        Thu, 11 Aug 2022 09:13:33 -0700 (PDT)
Received: from localhost.localdomain (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id t1-20020a92ca81000000b002dd1c3c5c46sm3415429ilo.73.2022.08.11.09.13.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 11 Aug 2022 09:13:33 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Alistair Popple <apopple@nvidia.com>, peterx@redhat.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Huang Ying <ying.huang@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v4 0/7] mm: Remember a/d bits for migration entries
Date:   Thu, 11 Aug 2022 12:13:24 -0400
Message-Id: <20220811161331.37055-1-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v4:
- Added r-bs for Ying
- Some cosmetic changes here and there [Ying]
- Fix smaps to only dump PFN for pfn swap entries for both pte/pmd [Ying]
- Remove max_swapfile_size(), export swapfile_maximum_size variable [Ying]
- In migrate_vma_collect_pmd() only read A/D if pte_present()

rfc: https://lore.kernel.org/all/20220729014041.21292-1-peterx@redhat.com
v1:  https://lore.kernel.org/all/20220803012159.36551-1-peterx@redhat.com
v2:  https://lore.kernel.org/all/20220804203952.53665-1-peterx@redhat.com
v3:  https://lore.kernel.org/all/20220809220100.20033-1-peterx@redhat.com

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

Known Issues / TODOs
====================

We still haven't taught madvise() to recognize the new A/D bits in
migration entries, namely MADV_COLD/MADV_FREE.  E.g. when MADV_COLD upon a
migration entry.  It's not clear yet on whether we should clear the A bit,
or we should just drop the entry directly.

We didn't teach idle page tracking on the new migration entries, because
it'll need larger rework on the tree on rmap pgtable walk.  However it
should make it already better because before this patchset page will be old
page after migration, so the series will fix potential false negative of
idle page tracking when pages were migrated before observing.

The other thing is migration A/D bits will not start to working for private
device swap entries.  The code is there for completeness but since private
device swap entries do not yet have fields to store A/D bits, even if we'll
persistent A/D across present pte switching to migration entry, we'll lose
it again when the migration entry converted to private device swap entry.

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
 fs/proc/task_mmu.c                    |  20 +++-
 include/linux/swapfile.h              |   5 +-
 include/linux/swapops.h               | 145 +++++++++++++++++++++++---
 mm/hmm.c                              |   2 +-
 mm/huge_memory.c                      |  27 ++++-
 mm/memory-failure.c                   |   2 +-
 mm/migrate.c                          |   6 +-
 mm/migrate_device.c                   |   6 ++
 mm/page_vma_mapped.c                  |   6 +-
 mm/rmap.c                             |   5 +-
 mm/swapfile.c                         |  15 ++-
 14 files changed, 214 insertions(+), 37 deletions(-)

-- 
2.32.0


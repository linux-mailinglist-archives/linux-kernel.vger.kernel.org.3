Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19CD858495F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 03:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233671AbiG2Bku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 21:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233613AbiG2Bkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 21:40:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1D5EC1C12B
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 18:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659058845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=YhoWXCGcYHtMETdYFmNXJciqsK6lpwzX/oxTkeK81lg=;
        b=ab6p5yxQLq6nMf31cTGWy8kmFwrVOeoIjrpQEhppXgVS40SKNv2KTsc39O1aH0D72GuWHc
        eMzWszdwRJAsLTcBu2c/45dQt9xBNNBfHgU9RJYlElXpq9CKIiwu3aTwg971m8rPQjud/4
        7pzZSqPqZ9VH8AaL2Uc4pwZndG2hFn8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-278-Ki9L22w4PKWMa1KoGA5TMw-1; Thu, 28 Jul 2022 21:40:44 -0400
X-MC-Unique: Ki9L22w4PKWMa1KoGA5TMw-1
Received: by mail-qk1-f200.google.com with SMTP id v13-20020a05620a0f0d00b006b5f0ec742eso2623691qkl.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 18:40:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YhoWXCGcYHtMETdYFmNXJciqsK6lpwzX/oxTkeK81lg=;
        b=oEodgaBrsX2Fx3D6hFSMxMt6nFc6eAQZdq1OyzNUYArjsBY5mqy6nGRsGnEWozYyhv
         pMkGXks4mznWLEZxO/r32CnMqLWZBXCikuTwMemTyMO/eq1NjJGt0UY6RF7G/jWEy5Eq
         mlYRBX+wDwstE9Ghe54aJnkdlKgUDSbNDS2aaHN3INkLvlxCVgZ1PaPiJ0V+P9p/rS4n
         mWzrW7TTd7A/QM2rlk4UKzBy44kA5d+ZenWm+7neTMx+3aKmiCAe7VV9yBBaOF6SF+aS
         lJCioiGrLJ2bmS6SATinXrvK5m7vTiaidt3om7G5u9VJxQscHQS9inXhDZMIaXySFXK9
         rr2Q==
X-Gm-Message-State: AJIora8RKc0otaWMRx3nRNDaShsgtxHRhhBiG0qoRSpialYog0uhoOPM
        Ew7mbxDfTLVouPqmKR9XGSPV0Sy3fOYi6Rd4KeEwKmAdfAAeSv7a4srMzv9vCGPizIGmc7m6zBe
        KLgRhzuvwxZjObXEbOmiu66sS
X-Received: by 2002:ac8:5753:0:b0:31e:eb8e:6c5b with SMTP id 19-20020ac85753000000b0031eeb8e6c5bmr1562678qtx.630.1659058843489;
        Thu, 28 Jul 2022 18:40:43 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sisuiIowjvve1UXIMx1jFjzxHrHqZwm4h1E+tG7ztTiMUWChTU59F22LS70qME7O9B4M8GqQ==
X-Received: by 2002:ac8:5753:0:b0:31e:eb8e:6c5b with SMTP id 19-20020ac85753000000b0031eeb8e6c5bmr1562671qtx.630.1659058843257;
        Thu, 28 Jul 2022 18:40:43 -0700 (PDT)
Received: from localhost.localdomain (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id u9-20020a05620a454900b006b259b5dd12sm1584531qkp.53.2022.07.28.18.40.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 28 Jul 2022 18:40:42 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Huang Ying <ying.huang@intel.com>, peterx@redhat.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Nadav Amit <nadav.amit@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH RFC 0/4] mm: Remember young bit for migration entries
Date:   Thu, 28 Jul 2022 21:40:37 -0400
Message-Id: <20220729014041.21292-1-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Marking as RFC; only x86 is supported for now, plan to add a few more
 archs when there's a formal version]

Problem
=======

When migrate a page, right now we always mark the migrated page as old.
The reason could be that we don't really know whether the page is hot or
cold, so we could have taken it a default negative assuming that's safer.

However that could lead to at least two problems:

  (1) We lost the real hot/cold information while we could have persisted.
      That information shouldn't change even if the backing page is changed
      after the migration,

  (2) There can be always extra overhead on the immediate next access to
      any migrated page, because hardware MMU needs cycles to set the young
      bit again (as long as the MMU supports).

Many of the recent upstream works showed that (2) is not something trivial
and actually very measurable.  In my test case, reading 1G chunk of memory
- jumping in page size intervals - could take 99ms just because of the
extra setting on the young bit on a generic x86_64 system, comparing to 4ms
if young set.

This issue is originally reported by Andrea Arcangeli.

Solution
========

To solve this problem, this patchset tries to remember the young bit in the
migration entries and carry it over when recovering the ptes.

We have the chance to do so because in many systems the swap offset is not
really fully used.  Migration entries use swp offset to store PFN only,
while the PFN is normally not as large as swp offset and normally smaller.
It means we do have some free bits in swp offset that we can use to store
things like young, and that's how this series tried to approach this
problem.

One tricky thing here is even though we're embedding the information into
swap entry which seems to be a very generic data structure, the number of
bits that are free is still arch dependent.  Not only because the size of
swp_entry_t differs, but also due to the different layouts of swap ptes on
different archs.

Here, this series requires specific arch to define an extra macro called
__ARCH_SWP_OFFSET_BITS represents the size of swp offset.  With this
information, the swap logic can know whether there's extra bits to use,
then it'll remember the young bits when possible.  By default, it'll keep
the old behavior of keeping all migrated pages cold.

Tests
=====

After the patchset applied, the immediate read access test [1] of above 1G
chunk after migration can shrink from 99ms to 4ms.  The test is done by
moving 1G pages from node 0->1->0 then read it in page size jumps.

Currently __ARCH_SWP_OFFSET_BITS is only defined on x86 for this series and
only tested on x86_64 with Intel(R) Xeon(R) CPU E5-2630 v4 @ 2.20GHz.

Patch Layout
============

Patch 1:  Add swp_offset_pfn() and apply to all pfn swap entries, we should
          also stop treating swp_offset() as PFN anymore because it can
          contain more information starting from next patch.
Patch 2:  The core patch to remember young bit in swap offsets.
Patch 3:  A cleanup for x86 32 bits pgtable.h.
Patch 4:  Define __ARCH_SWP_OFFSET_BITS on x86, enable young bit for migration

Please review, thanks.

[1] https://github.com/xzpeter/clibs/blob/master/misc/swap-young.c

Peter Xu (4):
  mm/swap: Add swp_offset_pfn() to fetch PFN from swap entry
  mm: Remember young bit for page migrations
  mm/x86: Use SWP_TYPE_BITS in 3-level swap macros
  mm/x86: Define __ARCH_SWP_OFFSET_BITS

 arch/arm64/mm/hugetlbpage.c           |  2 +-
 arch/x86/include/asm/pgtable-2level.h |  6 ++
 arch/x86/include/asm/pgtable-3level.h | 15 +++--
 arch/x86/include/asm/pgtable_64.h     |  5 ++
 include/linux/swapops.h               | 85 +++++++++++++++++++++++++--
 mm/hmm.c                              |  2 +-
 mm/huge_memory.c                      | 10 +++-
 mm/memory-failure.c                   |  2 +-
 mm/migrate.c                          |  4 +-
 mm/migrate_device.c                   |  2 +
 mm/page_vma_mapped.c                  |  6 +-
 mm/rmap.c                             |  3 +-
 12 files changed, 122 insertions(+), 20 deletions(-)

-- 
2.32.0


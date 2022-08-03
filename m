Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D195A588558
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 03:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234902AbiHCBWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 21:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233075AbiHCBWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 21:22:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EF523550B2
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 18:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659489724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=eRfVsx2J8bSWaoY/W9Xo3vXxtbJlknv2N+vt75Xmtjo=;
        b=iEy4X4+exaPAU4W1ZVM4ETBnVl5oNT50HJyOsAkD/ltXA5UVi7ba9NwQF32Lmm4XyGZ8+4
        9c9wEHb7NecUjisYzjeg3rMt2PC/b74o4Lviq1KIeDYI4w5FesJqiKR0wddbHZx0+UPXDY
        2CHD8chDoIulIWMTVZsNTK6mvibbllM=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-456-dFjnMSGUMOa8sai-Z-EC1Q-1; Tue, 02 Aug 2022 21:22:03 -0400
X-MC-Unique: dFjnMSGUMOa8sai-Z-EC1Q-1
Received: by mail-qk1-f197.google.com with SMTP id m8-20020a05620a24c800b006b5d8eb23efso12772393qkn.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 18:22:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eRfVsx2J8bSWaoY/W9Xo3vXxtbJlknv2N+vt75Xmtjo=;
        b=N5D0faXhPh58rQXEbqQeeHNztFe6Xy3XdMsUbDUeGrUYy5zJcko6dMnm7ykt1KLQsU
         K8jZsjVTsnRrwJ5T6kL9L9CrQB5hGkYhUiZstOgW0UjNx03R9F315xIx3U5uNgu92TVZ
         vRgpJwzrS0HL1pVIEaj6fGl+IaYLc2bFua1VhdQNPFwFTM0RLlRE9VeeiAGeT6yS/g6M
         1cA2qcHmf9B8khR8zP4xWylrEgmp+gIJFsPPEBCMmLYBQcm29JjwMf5+zydz1wHDmEVB
         lBzoGjl8gsw/Ye1Lu10ppuFRWL6JN+7QTkUzT+1S/xaTskDP2WQ3BA3lTEHYgfK6vQLu
         VUnw==
X-Gm-Message-State: ACgBeo3zN5yp4pqFdbY5OIvqi+bRi+UXurdLkFsq0aHJSHmZuJ7efC8H
        rI1km6vXnsnypJUyKvDUUrDB5WjjXxHKpmCGO2SeCcvRmHdHivI6AixWfSXX4FEQwreoJ90Y/qj
        Yqy5SMwryPJ9Vkpa/bt5KYxoOj1Faooip1m3tYnG9233kk6a/mIXeUoV9nthvy5oAMYiO+q8bCw
        ==
X-Received: by 2002:ad4:4b30:0:b0:476:f037:8a2 with SMTP id s16-20020ad44b30000000b00476f03708a2mr3602057qvw.2.1659489722139;
        Tue, 02 Aug 2022 18:22:02 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5+ooUzYb3QOMUHiraBGk10183ECWADOXu+fEo4pH9ZjvPmFfzGi/YyA273l8lJmBRTRc+4KQ==
X-Received: by 2002:ad4:4b30:0:b0:476:f037:8a2 with SMTP id s16-20020ad44b30000000b00476f03708a2mr3602031qvw.2.1659489721757;
        Tue, 02 Aug 2022 18:22:01 -0700 (PDT)
Received: from localhost.localdomain (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id s16-20020a05622a1a9000b0031ecce4077fsm10188675qtc.31.2022.08.02.18.22.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 02 Aug 2022 18:22:01 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Huang Ying <ying.huang@intel.com>, peterx@redhat.com,
        Nadav Amit <nadav.amit@gmail.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 0/2] mm: Remember young bit for migration entries
Date:   Tue,  2 Aug 2022 21:21:57 -0400
Message-Id: <20220803012159.36551-1-peterx@redhat.com>
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

rfc->v1:
- Fix build for arch/um where MAX_PHYSMEM_BITS not defined [syzbot]
- Add VM_BUG_ON() in swp_offset_pfn() to check swap entry type [Ying]
- Use max_swapfile_size() to detect swp offset size [Ying]
- Posted patch 3 separately, dropped patch 4

rfc: https://lore.kernel.org/all/20220729014041.21292-1-peterx@redhat.com/

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

max_swapfile_size() is used here to detect per-arch offset length in swp
entries.  We'll automatically remember the young bit when we find that we
have enough swp offset field to keep both the PFN and the young bit for a
migration entry.

Tests
=====

After the patchset applied, the immediate read access test [1] of above 1G
chunk after migration can shrink from 99ms to 4ms.  The test is done by
moving 1G pages from node 0->1->0 then read it in page size jumps.  The
test is with Intel(R) Xeon(R) CPU E5-2630 v4 @ 2.20GHz.

Patch Layout
============

Patch 1:  Add swp_offset_pfn() and apply to all pfn swap entries, we should
          also stop treating swp_offset() as PFN anymore because it can
          contain more information starting from next patch.
Patch 2:  The core patch to remember young bit in swap offsets.

Please review, thanks.

[1] https://github.com/xzpeter/clibs/blob/master/misc/swap-young.c

Peter Xu (2):
  mm/swap: Add swp_offset_pfn() to fetch PFN from swap entry
  mm: Remember young bit for page migrations

 arch/arm64/mm/hugetlbpage.c |  2 +-
 include/linux/swapops.h     | 84 ++++++++++++++++++++++++++++++++++---
 mm/hmm.c                    |  2 +-
 mm/huge_memory.c            | 10 ++++-
 mm/memory-failure.c         |  2 +-
 mm/migrate.c                |  4 +-
 mm/migrate_device.c         |  2 +
 mm/page_vma_mapped.c        |  6 +--
 mm/rmap.c                   |  3 +-
 9 files changed, 99 insertions(+), 16 deletions(-)

-- 
2.32.0


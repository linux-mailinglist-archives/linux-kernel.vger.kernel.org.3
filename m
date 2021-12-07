Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F21C46B13B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 04:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbhLGDLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 22:11:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29109 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229448AbhLGDLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 22:11:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638846487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=H9S2/O5n9sFNQVCy6iy787K7V7yDbDOd3kuEDjU+4nM=;
        b=KwG6n/LXolWOhxuW/51+Jy2EKqHVSbqHncrl3mqorTB383fnT7UDP27i2mJCH51AWCfW+B
        J/FPE3BCvl1oW71M89qkrOCUKBvpaSEI2eOVjw/ydW30ExdX4xfBH/xtdIVj5nm1BmXtyD
        38InEnUjnYkzxKjnvjvIpm+1qbPnRE0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-12-PSSynTjTOE6uyDzN9CLxsQ-1; Mon, 06 Dec 2021 22:08:04 -0500
X-MC-Unique: PSSynTjTOE6uyDzN9CLxsQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 07ABA1804739;
        Tue,  7 Dec 2021 03:08:02 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-87.pek2.redhat.com [10.72.12.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D2D7F19C59;
        Tue,  7 Dec 2021 03:07:54 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, hch@lst.de,
        robin.murphy@arm.com, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, vbabka@suse.cz,
        m.szyprowski@samsung.com, John.p.donnelly@oracle.com,
        kexec@lists.infradead.org, Baoquan He <bhe@redhat.com>
Subject: [PATCH RESEND v2 0/5] Avoid requesting page from DMA zone when no managed pages
Date:   Tue,  7 Dec 2021 11:07:45 +0800
Message-Id: <20211207030750.30824-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

***Problem observed:
On x86_64, when crash is triggered and entering into kdump kernel, page
allocation failure can always be seen.

 ---------------------------------
 DMA: preallocated 128 KiB GFP_KERNEL pool for atomic allocations
 swapper/0: page allocation failure: order:5, mode:0xcc1(GFP_KERNEL|GFP_DMA), nodemask=(null),cpuset=/,mems_allowed=0
 CPU: 0 PID: 1 Comm: swapper/0 
 Call Trace:
  dump_stack+0x7f/0xa1
  warn_alloc.cold+0x72/0xd6
  ......
  __alloc_pages+0x24d/0x2c0
  ......
  dma_atomic_pool_init+0xdb/0x176
  do_one_initcall+0x67/0x320
  ? rcu_read_lock_sched_held+0x3f/0x80
  kernel_init_freeable+0x290/0x2dc
  ? rest_init+0x24f/0x24f
  kernel_init+0xa/0x111
  ret_from_fork+0x22/0x30
 Mem-Info:
 ------------------------------------

***Root cause:
In the current kernel, it assumes that DMA zone must have managed pages
and try to request pages if CONFIG_ZONE_DMA is enabled. While this is not
always true. E.g in kdump kernel of x86_64, only low 1M is presented and
locked down at very early stage of boot, so that this low 1M won't be
added into buddy allocator to become managed pages of DMA zone. This
exception will always cause page allocation failure if page is requested
from DMA zone.

***Investigation:
This failure happens since below commit merged into linus's tree.
  1a6a9044b967 x86/setup: Remove CONFIG_X86_RESERVE_LOW and reservelow= options
  23721c8e92f7 x86/crash: Remove crash_reserve_low_1M()
  f1d4d47c5851 x86/setup: Always reserve the first 1M of RAM
  7c321eb2b843 x86/kdump: Remove the backup region handling
  6f599d84231f x86/kdump: Always reserve the low 1M when the crashkernel option is specified

Before them, on x86_64, the low 640K area will be reused by kdump kernel.
So in kdump kernel, the content of low 640K area is copied into a backup
region for dumping before jumping into kdump. Then except of those firmware
reserved region in [0, 640K], the left area will be added into buddy
allocator to become available managed pages of DMA zone.

However, after above commits applied, in kdump kernel of x86_64, the low
1M is reserved by memblock, but not released to buddy allocator. So any
later page allocation requested from DMA zone will fail. 

This low 1M lock down is needed because AMD SME encrypts memory making
the old backup region mechanims impossible when switching into kdump
kernel. And Intel engineer mentioned their TDX (Trusted domain extensions)
which is under development in kernel also needs lock down the low 1M.
So we can't simply revert above commits to fix the page allocation
failure from DMA zone as someone suggested.

***Solution:
Currently, only DMA atomic pool and dma-kmalloc will initialize and
request page allocation with GFP_DMA during bootup. So only initialize
them when DMA zone has available managed pages, otherwise just skip the
initialization. From testing and code, this doesn't matter. In kdump
kernel of x86_64, the page allocation failure disappear.

***Further thinking
On x86_64, it consistently takes [0, 16M] into ZONE_DMA, and (16M, 4G]
into ZONE_DMA32 by default. The zone DMA covering low 16M is used to
take care of antique ISA devices. In fact, on 64bit system, it rarely
need ZONE_DMA (which is low 16M) to support almost extinct ISA devices. 
However, some components treat DMA as a generic concept, e.g
kmalloc-dma, slab allocator initializes it for later any DMA related
buffer allocation, but not limited to ISA DMA. 

On arm64, even though both CONFIG_ZONE_DMA and CONFIG_ZONE_DMA32 
are enabled, it makes ZONE_DMA covers the low 4G area, and ZONE_DMA32
empty. Unless on specific platforms (e.g. 30-bit on Raspberry Pi 4),
then zone DMA covers the 1st 1G area, zone DMA32 covers the rest of
the 32-bit addressable memory. 

I am wondering if we can also change the size of DMA and DMA32 ZONE as
dynamically adjusted, just as arm64 is doing? On x86_64, we can make
zone DMA covers the 32-bit addressable memory, and empty zone DMA32 by
default. Once ISA_DMA_API is enabled, we go back to make zone DMA covers
low 16M area, zone DMA32 covers the rest of 32-bit addressable memory.
(I am not familiar with ISA_DMA_API, will it require 24-bit addressable
memory when enabled?)

Change history:

v2 post:
https://lore.kernel.org/all/20210810094835.13402-1-bhe@redhat.com/T/#u

v1 post:
https://lore.kernel.org/all/20210624052010.5676-1-bhe@redhat.com/T/#u

v2->v2 RESEND:
 John pinged to push the repost of this patchset. So fix one typo of
 suject of patch 3/5; Fix a building error caused by mix declaration in
 patch 5/5. Both of them are found by John from his testing.

v1->v2:
 Change to check if managed DMA zone exists. If DMA zone has managed
 pages, go further to request page from DMA zone to initialize. Otherwise,
 just skip to initialize stuffs which need pages from DMA zone.

Baoquan He (5):
  docs: kernel-parameters: Update to reflect the current default size of
    atomic pool
  dma-pool: allow user to disable atomic pool
  mm_zone: add function to check if managed dma zone exists
  dma/pool: create dma atomic pool only if dma zone has managed pages
  mm/slub: do not create dma-kmalloc if no managed pages in DMA zone

 .../admin-guide/kernel-parameters.txt         |  5 ++++-
 include/linux/mmzone.h                        | 21 +++++++++++++++++++
 kernel/dma/pool.c                             | 11 ++++++----
 mm/page_alloc.c                               | 11 ++++++++++
 mm/slab_common.c                              |  9 ++++++++
 5 files changed, 52 insertions(+), 5 deletions(-)

-- 
2.17.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087A559CCD7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 02:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238924AbiHWAH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 20:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238912AbiHWAHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 20:07:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2381457218;
        Mon, 22 Aug 2022 17:07:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ADDFC61373;
        Tue, 23 Aug 2022 00:07:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7DD9C4314B;
        Tue, 23 Aug 2022 00:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1661213242;
        bh=fwlwWdu1Htluif+hgrxaqiDSgoz7569n+dARiej9tYs=;
        h=Date:From:To:Cc:Subject:From;
        b=L4RaAGcb8aD1Pkj+M3YXmJLWil1qXAXoGVhGvfMd4zYfAfmUXFArxZbw0Dtn1gYK9
         KBAYyC9FyZHl8y2im45NZ4meZ0bLFXgKtH2QoxRPmMgn9ERzldOKguuUYZBqB9+48G
         dSMx0Mg/M2E+EfQm80T7NV1g6ki4SVvqqetgfeuw=
Date:   Mon, 22 Aug 2022 17:07:21 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mm@kvack.org, mm-commits@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] hotfixes for 6.0-rc3
Message-Id: <20220822170721.1e32635aaedb6f4c53933390@linux-foundation.org>
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

Linus, please pull this batch of hotfixes.

The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2022-08-22

for you to fetch changes up to 9c80e79906b4ca440d09e7f116609262bb747909:

  kprobes: don't call disarm_kprobe() for disabled kprobes (2022-08-20 15:17:46 -0700)

----------------------------------------------------------------
Thirteen fixes, almost all for MM.  Seven of these are cc:stable and the
remainder fix up the changes which went into this -rc cycle.

----------------------------------------------------------------
Dan Carpenter (1):
      get_maintainer: add Alan to .get_maintainer.ignore

David Hildenbrand (3):
      mm/gup: fix FOLL_FORCE COW security issue and remove FOLL_COW
      mm/hugetlb: fix hugetlb not supporting softdirty tracking
      mm/hugetlb: support write-faults in shared mappings

Hao Lee (1):
      mm: add DEVICE_ZONE to FOR_ALL_ZONES

Hugh Dickins (3):
      mm/shmem: fix chattr fsflags support in tmpfs
      mm/shmem: tmpfs fallocate use file_modified()
      mm/shmem: shmem_replace_page() remember NR_SHMEM

Jiri Slaby (1):
      Revert "zram: remove double compression logic"

Kuniyuki Iwashima (1):
      kprobes: don't call disarm_kprobe() for disabled kprobes

Peter Xu (2):
      mm/smaps: don't access young/dirty bit if pte unpresent
      mm/uffd: reset write protection when unregister with wp-mode

Randy Dunlap (1):
      kernel/sys_ni: add compat entry for fadvise64_64

 .get_maintainer.ignore        |  2 ++
 drivers/block/zram/zram_drv.c | 42 +++++++++++++++++++-------
 drivers/block/zram/zram_drv.h |  1 +
 fs/proc/task_mmu.c            |  7 +++--
 fs/userfaultfd.c              |  4 +++
 include/linux/mm.h            |  1 -
 include/linux/shmem_fs.h      | 13 +++------
 include/linux/userfaultfd_k.h |  2 ++
 include/linux/vm_event_item.h | 15 +++++++---
 kernel/kprobes.c              |  9 +++---
 kernel/sys_ni.c               |  1 +
 mm/gup.c                      | 68 +++++++++++++++++++++++++++++--------------
 mm/huge_memory.c              | 64 +++++++++++++++++++++++++++-------------
 mm/hugetlb.c                  | 26 ++++++++++++-----
 mm/mmap.c                     |  7 +++--
 mm/shmem.c                    | 59 ++++++++++++++++++++++---------------
 mm/userfaultfd.c              | 29 +++++++++++-------
 mm/vmstat.c                   |  9 +++++-
 18 files changed, 240 insertions(+), 119 deletions(-)


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75B05532A1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 14:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350864AbiFUM5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 08:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiFUM5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 08:57:41 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365331836F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 05:57:40 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id s185so7310885pgs.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 05:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zBbBzk5qNVWvdANVbcpsxhRISEYlb3XpSAVuXts7Xh4=;
        b=6MoJL7uhwVZV1hnFe7vkgxTK88ZUcybzyABVvpzKz95L1WzNjJHhh8UeaZQwTFlIB9
         gjQDQllwWuHYWUzGW1XlH+MA1mw1JFDKyaFWyy5qoWTXxL2NENkl0g04VVD3HnE3Lh7C
         JjEC+a25WrPJtQtXRG1Q4lquerDcPkaFMEF4ECPFdhTaAJGBjqL7iGxS6p5lH5gnu679
         VU6t95ibSvKGXommF2zRro/qr/SIJ+frLgB7BLGSARKV1swHUXGnQkzmi38oD+gDyaLl
         arZkpqbNvbX+/lr1icurCA3SpGJq0w6vIatDK2YKUNlBisrRy9CVW+jCGI4ouFIoSb5Y
         18fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zBbBzk5qNVWvdANVbcpsxhRISEYlb3XpSAVuXts7Xh4=;
        b=ysDgi+s/7ZWwdAitA1Tt6kHxl+tyt3veLwSC6zBtUZHR68uQsfJUts7iFNxalrGf8v
         v9Y1y056i7IiE9ECutF9NjyZpNoVcKLskJJEIWobhHBLK3soVsudkdfxdsJdHCfvXhZQ
         I4qToG5jW84P+FZGd4LRzjljKKsDyYE2IG7hqK2UG3Q2p6KSSyM+e6GA7GjnRbgKs/8L
         Q38hSGLdfSLW+vpasUdZl99V8EMGjNsnyqxdKy3GogHQbSTqBwGG+FIl9nBlBHN73y+I
         yDrYG9vplwKSqLG1MsLMsEAAe21o4UM4jmbPznsEN5lgBHQmLN/ca/+HC5qk+H9N1h3q
         LxZA==
X-Gm-Message-State: AJIora8/h8yHGWObgUSqEFLDDskLpnrhta6w+77WSP2h0YASnJ5e12jP
        CUajZxCNgRTIQBQMlxMjVBhPLQ==
X-Google-Smtp-Source: AGRyM1tOKOkj3OXQi+e852TokjNeUtxVSDvQrx0/P6r55jkGP0XYhd0cU59yqlMBaqINI3zmgaXk3g==
X-Received: by 2002:a05:6a00:24c1:b0:518:c52f:f5 with SMTP id d1-20020a056a0024c100b00518c52f00f5mr30351831pfv.15.1655816259702;
        Tue, 21 Jun 2022 05:57:39 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id e3-20020a170903240300b0015ea3a491a1sm10643134plo.191.2022.06.21.05.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 05:57:39 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     akpm@linux-foundation.org, hannes@cmpxchg.org, longman@redhat.com,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com
Cc:     cgroups@vger.kernel.org, duanxiongchun@bytedance.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v6 00/11] Use obj_cgroup APIs to charge the LRU pages
Date:   Tue, 21 Jun 2022 20:56:47 +0800
Message-Id: <20220621125658.64935-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This version is rebased on mm-unstable. Hopefully, Andrew can get this series
into mm-unstable which will help to determine whether there is a problem or
degradation. I am also doing some benchmark tests in parallel.

Since the following patchsets applied. All the kernel memory are charged
with the new APIs of obj_cgroup.

	commit f2fe7b09a52b ("mm: memcg/slab: charge individual slab objects instead of pages")
	commit b4e0b68fbd9d ("mm: memcontrol: use obj_cgroup APIs to charge kmem pages")

But user memory allocations (LRU pages) pinning memcgs for a long time -
it exists at a larger scale and is causing recurring problems in the real
world: page cache doesn't get reclaimed for a long time, or is used by the
second, third, fourth, ... instance of the same job that was restarted into
a new cgroup every time. Unreclaimable dying cgroups pile up, waste memory,
and make page reclaim very inefficient.

We can convert LRU pages and most other raw memcg pins to the objcg direction
to fix this problem, and then the LRU pages will not pin the memcgs.

This patchset aims to make the LRU pages to drop the reference to memory
cgroup by using the APIs of obj_cgroup. Finally, we can see that the number
of the dying cgroups will not increase if we run the following test script.

```bash
#!/bin/bash

dd if=/dev/zero of=temp bs=4096 count=1
cat /proc/cgroups | grep memory

for i in {0..2000}
do
	mkdir /sys/fs/cgroup/memory/test$i
	echo $$ > /sys/fs/cgroup/memory/test$i/cgroup.procs
	cat temp >> log
	echo $$ > /sys/fs/cgroup/memory/cgroup.procs
	rmdir /sys/fs/cgroup/memory/test$i
done

cat /proc/cgroups | grep memory

rm -f temp log
```

v5: https://lore.kernel.org/all/20220530074919.46352-1-songmuchun@bytedance.com/
v4: https://lore.kernel.org/all/20220524060551.80037-1-songmuchun@bytedance.com/
v3: https://lore.kernel.org/all/20220216115132.52602-1-songmuchun@bytedance.com/
v2: https://lore.kernel.org/all/20210916134748.67712-1-songmuchun@bytedance.com/
v1: https://lore.kernel.org/all/20210814052519.86679-1-songmuchun@bytedance.com/
RFC v4: https://lore.kernel.org/all/20210527093336.14895-1-songmuchun@bytedance.com/
RFC v3: https://lore.kernel.org/all/20210421070059.69361-1-songmuchun@bytedance.com/
RFC v2: https://lore.kernel.org/all/20210409122959.82264-1-songmuchun@bytedance.com/
RFC v1: https://lore.kernel.org/all/20210330101531.82752-1-songmuchun@bytedance.com/

v6:
 - Collect Acked-by and Reviewed-by from Roman and Michal Koutný. Thanks.
 - Rebase to mm-unstable.

v5:
 - Lots of improvements from Johannes, Roman and Waiman.
 - Fix lockdep warning reported by kernel test robot.
 - Add two new patches to do code cleanup.
 - Collect Acked-by and Reviewed-by from Johannes and Roman.
 - I didn't replace local_irq_disable/enable() to local_lock/unlock_irq() since
   local_lock/unlock_irq() takes an parameter, it needs more thinking to transform
   it to local_lock.  It could be an improvement in the future.

v4:
 - Resend and rebased on v5.18.

v3:
 - Removed the Acked-by tags from Roman since this version is based on
   the folio relevant.

v2:
 - Rename obj_cgroup_release_kmem() to obj_cgroup_release_bytes() and the
   dependencies of CONFIG_MEMCG_KMEM (suggested by Roman, Thanks).
 - Rebase to linux 5.15-rc1.
 - Add a new pacth to cleanup mem_cgroup_kmem_disabled().

v1:
 - Drop RFC tag.
 - Rebase to linux next-20210811.

RFC v4:
 - Collect Acked-by from Roman.
 - Rebase to linux next-20210525.
 - Rename obj_cgroup_release_uncharge() to obj_cgroup_release_kmem().
 - Change the patch 1 title to "prepare objcg API for non-kmem usage".
 - Convert reparent_ops_head to an array in patch 8.

Thanks for Roman's review and suggestions.

RFC v3:
 - Drop the code cleanup and simplification patches. Gather those patches
   into a separate series[1].
 - Rework patch #1 suggested by Johannes.

RFC v2:
 - Collect Acked-by tags by Johannes. Thanks.
 - Rework lruvec_holds_page_lru_lock() suggested by Johannes. Thanks.
 - Fix move_pages_to_lru().

Muchun Song (11):
  mm: memcontrol: remove dead code and comments
  mm: rename unlock_page_lruvec{_irq, _irqrestore} to
    lruvec_unlock{_irq, _irqrestore}
  mm: memcontrol: prepare objcg API for non-kmem usage
  mm: memcontrol: make lruvec lock safe when LRU pages are reparented
  mm: vmscan: rework move_pages_to_lru()
  mm: thp: make split queue lock safe when LRU pages are reparented
  mm: memcontrol: make all the callers of {folio,page}_memcg() safe
  mm: memcontrol: introduce memcg_reparent_ops
  mm: memcontrol: use obj_cgroup APIs to charge the LRU pages
  mm: lru: add VM_WARN_ON_ONCE_FOLIO to lru maintenance function
  mm: lru: use lruvec lock to serialize memcg changes

 fs/buffer.c                      |   4 +-
 fs/fs-writeback.c                |  23 +-
 include/linux/memcontrol.h       | 218 +++++++++------
 include/linux/mm_inline.h        |   6 +
 include/trace/events/writeback.h |   5 +
 mm/compaction.c                  |  39 ++-
 mm/huge_memory.c                 | 153 ++++++++--
 mm/memcontrol.c                  | 584 +++++++++++++++++++++++++++------------
 mm/migrate.c                     |   4 +
 mm/mlock.c                       |   2 +-
 mm/page_io.c                     |   5 +-
 mm/swap.c                        |  49 ++--
 mm/vmscan.c                      |  66 ++---
 13 files changed, 776 insertions(+), 382 deletions(-)


base-commit: 882be1ed6b1b5073fc88552181b99bd2b9c0031f
-- 
2.11.0


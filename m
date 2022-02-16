Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E484B871D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 12:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbiBPLwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 06:52:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiBPLwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 06:52:14 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E741A138C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 03:52:02 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id v8-20020a17090a634800b001bb78857ccdso3883590pjs.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 03:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CENAotC9++gW6qD61WH1ONLXIeGp0Z7XqnA0TJjC8Mc=;
        b=5xEyHubE//f28p4H857xOzYkCySvKTayQNwg94bllFL5lgalDUUn4SKi3K0vfyXgaT
         KhxDD/GFmeYvsu9zYMQCLFpNG8AbKoOaY7qTE4TqGQAE0HalRo5w3N6KBWdWumzmlbM+
         QYD5JaeHDwhCneBZdCgTJGVL10A1viCb/FiqJWVIUBXfpzkgO1AL8otLDwgViO/hcK+6
         dvR0lOV4s8loH6hEX3Ivp8FBc36CcVMnf4OI4tCm9dNgZP8UQpz88JQucE4eXhCVQb1N
         MCDyzGj8S28kdkQdTEvG+9BXMyBiFR+Ny+krQ9UlizP0JKOR3kdD4MbSW64sBQLzRe8p
         E6UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CENAotC9++gW6qD61WH1ONLXIeGp0Z7XqnA0TJjC8Mc=;
        b=hiPWDuUVHfODfLqdWcSTY2qAlzEYv/xB/oqiJbRmyO90/7C0qrQKyLSK0mV1f4K/dE
         OPMIYRm93vqfSkCFOONssSGg8PTM1j3NyENZ8j22fBoFotV5tHEHunu6Hh/DjFjgHafH
         eRl4En7ZNbyzb1JbKW/6IbS1/Xc0LEJpJDI+h9XQjUpryAZfowBSq6U2eXeIlQvNXUAZ
         qNV4GDkiTM+LD+Jyu8H2uDz+T3Pd2lpO+FptyVgXCFwWd3W5x50Pqd+fUFnAA0tuxwuP
         1MU0f58lchAFR3V7k9GGQfsIc68nyRdN7ShwBtCf+cBXlBNb8DC+5+7IqFpdoxN7T1cS
         DjMA==
X-Gm-Message-State: AOAM530P2KrfEOF2AAGtsw/FoL1tNf/0TwJdpNzfiwML/RkcKD//fETd
        vJbb9YmHDCx9/kWDsZsP1C531A==
X-Google-Smtp-Source: ABdhPJwZ562RCzCcStH4WLaYvBO0fGe2Y9PyX9ayV0ruOpVFCnLtl93MYeo4SLzavHnaa2xKTe3UWw==
X-Received: by 2002:a17:90b:1a90:b0:1b9:20f9:9c91 with SMTP id ng16-20020a17090b1a9000b001b920f99c91mr1303343pjb.70.1645012321490;
        Wed, 16 Feb 2022 03:52:01 -0800 (PST)
Received: from FVFYT0MHHV2J.tiktokcdn.com ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id m16sm14790221pfc.156.2022.02.16.03.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 03:52:01 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        bsingharora@gmail.com, shy828301@gmail.com, alexs@kernel.org,
        smuchun@gmail.com, zhengqi.arch@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 00/12] Use obj_cgroup APIs to charge the LRU pages
Date:   Wed, 16 Feb 2022 19:51:20 +0800
Message-Id: <20220216115132.52602-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This version is rebased over linux 5.17-rc4.

Since the following patchsets applied. All the kernel memory are charged
with the new APIs of obj_cgroup.

	[v17,00/19] The new cgroup slab memory controller [1]
	[v5,0/7] Use obj_cgroup APIs to charge kmem pages [2]

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

[1] https://lore.kernel.org/linux-mm/20200623015846.1141975-1-guro@fb.com/
[2] https://lore.kernel.org/linux-mm/20210319163821.20704-1-songmuchun@bytedance.com/

v2: https://lore.kernel.org/all/20210916134748.67712-1-songmuchun@bytedance.com/
v1: https://lore.kernel.org/all/20210814052519.86679-1-songmuchun@bytedance.com/
RFC v4: https://lore.kernel.org/all/20210527093336.14895-1-songmuchun@bytedance.com/
RFC v3: https://lore.kernel.org/all/20210421070059.69361-1-songmuchun@bytedance.com/
RFC v2: https://lore.kernel.org/all/20210409122959.82264-1-songmuchun@bytedance.com/
RFC v1: https://lore.kernel.org/all/20210330101531.82752-1-songmuchun@bytedance.com/

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

Muchun Song (12):
  mm: memcontrol: prepare objcg API for non-kmem usage
  mm: memcontrol: introduce compact_folio_lruvec_lock_irqsave
  mm: memcontrol: make lruvec lock safe when LRU pages are reparented
  mm: vmscan: rework move_pages_to_lru()
  mm: thp: introduce folio_split_queue_lock{_irqsave}()
  mm: thp: make split queue lock safe when LRU pages are reparented
  mm: memcontrol: make all the callers of {folio,page}_memcg() safe
  mm: memcontrol: introduce memcg_reparent_ops
  mm: memcontrol: use obj_cgroup APIs to charge the LRU pages
  mm: memcontrol: rename {un}lock_page_memcg() to {un}lock_page_objcg()
  mm: lru: add VM_BUG_ON_FOLIO to lru maintenance function
  mm: lru: use lruvec lock to serialize memcg changes

 Documentation/admin-guide/cgroup-v1/memory.rst |   2 +-
 fs/buffer.c                                    |  12 +-
 fs/fs-writeback.c                              |  23 +-
 include/linux/memcontrol.h                     | 192 +++++----
 include/linux/mm.h                             |   1 +
 include/linux/mm_inline.h                      |  15 +-
 include/trace/events/writeback.h               |   5 +
 mm/compaction.c                                |  39 +-
 mm/filemap.c                                   |   2 +-
 mm/huge_memory.c                               | 166 ++++++--
 mm/memcontrol.c                                | 559 ++++++++++++++++++-------
 mm/migrate.c                                   |   4 +
 mm/page-writeback.c                            |   6 +-
 mm/page_io.c                                   |   5 +-
 mm/rmap.c                                      |  14 +-
 mm/swap.c                                      |  49 +--
 mm/vmscan.c                                    |  57 ++-
 17 files changed, 795 insertions(+), 356 deletions(-)

-- 
2.11.0


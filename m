Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7DBA532323
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 08:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234962AbiEXG1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 02:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234915AbiEXG1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 02:27:11 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8147A70930
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 23:27:09 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id c22so15553025pgu.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 23:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ND4Wm9nToFOkSC+HCQqYbGct8fIpn1B51prLBRQfkMk=;
        b=oNg5WAyRm2i9JIYRZEomX+IDEPBBrkEi20tO3tXOeGZ3NY2K4J++6op0FTruyXRsHp
         Tn2A6AhiGpYzdNXhTJncn7lBvLxYyeAMag4bJkedvOxuOJGPIoXVC4z4bHfIY4JTbSmb
         8I1/XyDu3R+NrM6yUfnTGvCuQJhG82Np7tSzAXRr7DNmwZoYczB73UpFS3KenplKbdkZ
         RTKx0VVw2KEriD5cvTi1bzlywFqRDb0TfsghojTN1RVUa2erY+1OSHZDjj45T0uoPXc4
         EeGTOaA+GVNLKRMsDMJ7yiTvX0+4l6ZwgaOQwGgefi/2FUZ8Loi0hMh6bCHq2gtNHTeW
         f12g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ND4Wm9nToFOkSC+HCQqYbGct8fIpn1B51prLBRQfkMk=;
        b=xntEhLST2yzPIaMPfNfkE4hm58RaYgfMA/Jp8sUeQtGJq/VXhfejC1AEALSXzrBw4X
         3nqbLAz5VXJehhTmPFE5MRz+PL6kv7bpdXcLvvvbo0w1kc0DjHBsrbdqNKLidbmHMW4n
         OGzVlBZ90bMvcGopAIslneMF/xmjgRtXQyFGwKpfFtrGCacc12LPTtDuDZSRoF53AAOr
         9A9dC6046vCQsrvrAQ0hIUzrvLzX15B5olpN+heBiuL/or0ZBEWDhY391QmhedMP1Vee
         24qqDgyWW3ZFYbIHUmIP8WoiRTpqgf6dwlEmW00XK5n9Z+1vbCdy6+wvfIv7y24U7BcM
         ulXA==
X-Gm-Message-State: AOAM531d7PAfqC5D/mXrRqL4sUqko0cvQ5wpekZlyV2Jc8bu32um+sUN
        CwVTtIuq1ALpst2Wqlasme5+Vw==
X-Google-Smtp-Source: ABdhPJwUCmag/6VD9SDJbs2ZEysCf53XGTtLBQbtPouBXrnO6grNU092F3BjVpB4ZnnvzGd5wzOpvA==
X-Received: by 2002:a05:6a00:a0e:b0:4fd:fa6e:95fc with SMTP id p14-20020a056a000a0e00b004fdfa6e95fcmr27336024pfh.17.1653373629021;
        Mon, 23 May 2022 23:27:09 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([2408:8207:18da:2310:f940:af17:c2f5:8656])
        by smtp.gmail.com with ESMTPSA id h5-20020a170902f54500b0016168e90f2dsm6254455plf.219.2022.05.23.23.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 23:27:08 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
        shakeelb@google.com
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        longman@redhat.com, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v4 00/11] Use obj_cgroup APIs to charge the LRU pages
Date:   Tue, 24 May 2022 14:05:40 +0800
Message-Id: <20220524060551.80037-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This version is rebased on v5.18.

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

v3: https://lore.kernel.org/all/20220216115132.52602-1-songmuchun@bytedance.com/
v2: https://lore.kernel.org/all/20210916134748.67712-1-songmuchun@bytedance.com/
v1: https://lore.kernel.org/all/20210814052519.86679-1-songmuchun@bytedance.com/
RFC v4: https://lore.kernel.org/all/20210527093336.14895-1-songmuchun@bytedance.com/
RFC v3: https://lore.kernel.org/all/20210421070059.69361-1-songmuchun@bytedance.com/
RFC v2: https://lore.kernel.org/all/20210409122959.82264-1-songmuchun@bytedance.com/
RFC v1: https://lore.kernel.org/all/20210330101531.82752-1-songmuchun@bytedance.com/

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
  mm: memcontrol: prepare objcg API for non-kmem usage
  mm: memcontrol: introduce compact_folio_lruvec_lock_irqsave
  mm: memcontrol: make lruvec lock safe when LRU pages are reparented
  mm: vmscan: rework move_pages_to_lru()
  mm: thp: introduce folio_split_queue_lock{_irqsave}()
  mm: thp: make split queue lock safe when LRU pages are reparented
  mm: memcontrol: make all the callers of {folio,page}_memcg() safe
  mm: memcontrol: introduce memcg_reparent_ops
  mm: memcontrol: use obj_cgroup APIs to charge the LRU pages
  mm: lru: add VM_BUG_ON_FOLIO to lru maintenance function
  mm: lru: use lruvec lock to serialize memcg changes

 fs/buffer.c                      |   4 +-
 fs/fs-writeback.c                |  23 +-
 include/linux/memcontrol.h       | 198 ++++++++------
 include/linux/mm_inline.h        |   6 +
 include/trace/events/writeback.h |   5 +
 mm/compaction.c                  |  39 ++-
 mm/huge_memory.c                 | 157 ++++++++++--
 mm/memcontrol.c                  | 542 ++++++++++++++++++++++++++++-----------
 mm/migrate.c                     |   4 +
 mm/page_io.c                     |   5 +-
 mm/swap.c                        |  49 ++--
 mm/vmscan.c                      |  57 ++--
 12 files changed, 756 insertions(+), 333 deletions(-)


base-commit: 4b0986a3613c92f4ec1bdc7f60ec66fea135991f
-- 
2.11.0


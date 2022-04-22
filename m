Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA1750C156
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 00:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbiDVV4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 17:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbiDVV4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 17:56:20 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758252A6FF8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 13:38:53 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1650659217;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=PhU4HOQqzOZE/WYZCWken1EipdzrKdUbbMhouk5UBtc=;
        b=Cr2pawcReEaBJbEpTYPhxvbePL8uB4vwtMiKAcJ7QZ9VbLQb/Fj/zOf5B8woJz+Kmhehvx
        SpYM6RhU5QazWE7RrhUSyXcBnUmFdDpxqWCPhbwgiMT5GllyGFIDwq/3+adNnBbhn+uU8o
        aoDGE8arlEaNvdnbDaFRYQ7cuQDcS44=
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     Dave Chinner <dchinner@redhat.com>, linux-kernel@vger.kernel.org,
        Yang Shi <shy828301@gmail.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH v2 0/7] mm: introduce shrinker debugfs interface
Date:   Fri, 22 Apr 2022 13:26:37 -0700
Message-Id: <20220422202644.799732-1-roman.gushchin@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are 50+ different shrinkers in the kernel, many with their own bells and
whistles. Under the memory pressure the kernel applies some pressure on each of
them in the order of which they were created/registered in the system. Some
of them can contain only few objects, some can be quite large. Some can be
effective at reclaiming memory, some not.

The only existing debugging mechanism is a couple of tracepoints in
do_shrink_slab(): mm_shrink_slab_start and mm_shrink_slab_end. They aren't
covering everything though: shrinkers which report 0 objects will never show up,
there is no support for memcg-aware shrinkers. Shrinkers are identified by their
scan function, which is not always enough (e.g. hard to guess which super
block's shrinker it is having only "super_cache_scan"). They are a passive
mechanism: there is no way to call into counting and scanning of an individual
shrinker and profile it.

To provide a better visibility and debug options for memory shrinkers
this patchset introduces a /sys/kernel/debug/shrinker interface, to some extent
similar to /sys/kernel/slab.

For each shrinker registered in the system a directory is created. The directory
contains "count" and "scan" files, which allow to trigger count_objects()
and scan_objects() callbacks. For memcg-aware and numa-aware shrinkers
count_memcg, scan_memcg, count_node, scan_node, count_memcg_node
and scan_memcg_node are additionally provided. They allow to get per-memcg
and/or per-node object count and shrink only a specific memcg/node.

To make debugging more pleasant, the patchset also names all shrinkers,
so that debugfs entries can have more meaningful names.

Usage examples:

1) List registered shrinkers:
  $ cd /sys/kernel/debug/shrinker/
  $ ls
    dqcache-16          sb-cgroup2-30    sb-hugetlbfs-33  sb-proc-41       sb-selinuxfs-22  sb-tmpfs-40    sb-zsmalloc-19
    kfree_rcu-0         sb-configfs-23   sb-iomem-12      sb-proc-44       sb-sockfs-8      sb-tmpfs-42    shadow-18
    sb-aio-20           sb-dax-11        sb-mqueue-21     sb-proc-45       sb-sysfs-26      sb-tmpfs-43    thp_deferred_split-10
    sb-anon_inodefs-15  sb-debugfs-7     sb-nsfs-4        sb-proc-47       sb-tmpfs-1       sb-tmpfs-46    thp_zero-9
    sb-bdev-3           sb-devpts-28     sb-pipefs-14     sb-pstore-31     sb-tmpfs-27      sb-tmpfs-49    xfs_buf-37
    sb-bpf-32           sb-devtmpfs-5    sb-proc-25       sb-rootfs-2      sb-tmpfs-29      sb-tracefs-13  xfs_inodegc-38
    sb-btrfs-24         sb-hugetlbfs-17  sb-proc-39       sb-securityfs-6  sb-tmpfs-35      sb-xfs-36      zspool-34

2) Get information about a specific shrinker:
  $ cd sb-btrfs-24/
  $ ls
    count  count_memcg  count_memcg_node  count_node  scan  scan_memcg  scan_memcg_node  scan_node

3) Count objects on the system/root cgroup level
  $ cat count
    212

4) Count objects on the system/root cgroup level per numa node (on a 2-node machine)
  $ cat count_node
    209 3

5) Count objects for each memcg (output format: cgroup inode, count)
  $ cat count_memcg
    1 212
    20 96
    53 817
    2297 2
    218 13
    581 30
    911 124
    <CUT>

6) Same but with a per-node output
  $ cat count_memcg_node
    1 209 3
    20 96 0
    53 810 7
    2297 2 0
    218 13 0
    581 30 0
    911 124 0
    <CUT>

7) Scan system/root shrinker
  $ cat count
    212
  $ echo 100 > scan
  $ cat scan
    97
  $ cat count
    115

8) Scan individual memcg
  $ echo "1868 500" > scan_memcg
  $ cat scan_memcg
    193

9) Scan individual node
  $ echo "1 200" > scan_node
  $ cat scan_node
    2

10) Scan individual memcg and node
  $ echo "1868 0 500" > scan_memcg_node
  $ cat scan_memcg_node
    435


v1:
  1) switched to debugfs, suggested by Mike, Andrew, Greg and others
  2) switched to seq_file API for output, no PAGE_SIZE limit anymore, by Andrew
  3) switched to down_read_killable(), suggested by Hillf
  4) dropped stateful filtering and "freed" returning, by Kent
  5) added docs, by Andrew

rfc:
  https://lwn.net/Articles/891542/


Roman Gushchin (7):
  mm: introduce debugfs interface for kernel memory shrinkers
  mm: memcontrol: introduce mem_cgroup_ino() and
    mem_cgroup_get_from_ino()
  mm: introduce memcg interfaces for shrinker debugfs
  mm: introduce numa interfaces for shrinker debugfs
  mm: provide shrinkers with names
  docs: document shrinker debugfs
  tools: add memcg_shrinker.py

 Documentation/admin-guide/mm/index.rst        |   1 +
 .../admin-guide/mm/shrinker_debugfs.rst       |  90 +++
 arch/x86/kvm/mmu/mmu.c                        |   2 +-
 drivers/android/binder_alloc.c                |   2 +-
 drivers/gpu/drm/i915/gem/i915_gem_shrinker.c  |   3 +-
 drivers/gpu/drm/msm/msm_gem_shrinker.c        |   2 +-
 .../gpu/drm/panfrost/panfrost_gem_shrinker.c  |   2 +-
 drivers/gpu/drm/ttm/ttm_pool.c                |   2 +-
 drivers/md/bcache/btree.c                     |   2 +-
 drivers/md/dm-bufio.c                         |   2 +-
 drivers/md/dm-zoned-metadata.c                |   2 +-
 drivers/md/raid5.c                            |   2 +-
 drivers/misc/vmw_balloon.c                    |   2 +-
 drivers/virtio/virtio_balloon.c               |   2 +-
 drivers/xen/xenbus/xenbus_probe_backend.c     |   2 +-
 fs/erofs/utils.c                              |   2 +-
 fs/ext4/extents_status.c                      |   3 +-
 fs/f2fs/super.c                               |   2 +-
 fs/gfs2/glock.c                               |   2 +-
 fs/gfs2/main.c                                |   2 +-
 fs/jbd2/journal.c                             |   2 +-
 fs/mbcache.c                                  |   2 +-
 fs/nfs/nfs42xattr.c                           |   7 +-
 fs/nfs/super.c                                |   2 +-
 fs/nfsd/filecache.c                           |   2 +-
 fs/nfsd/nfscache.c                            |   2 +-
 fs/quota/dquot.c                              |   2 +-
 fs/super.c                                    |   2 +-
 fs/ubifs/super.c                              |   2 +-
 fs/xfs/xfs_buf.c                              |   2 +-
 fs/xfs/xfs_icache.c                           |   2 +-
 fs/xfs/xfs_qm.c                               |   2 +-
 include/linux/memcontrol.h                    |   9 +
 include/linux/shrinker.h                      |  24 +-
 kernel/rcu/tree.c                             |   2 +-
 lib/Kconfig.debug                             |   9 +
 mm/Makefile                                   |   1 +
 mm/huge_memory.c                              |   4 +-
 mm/memcontrol.c                               |  23 +
 mm/shrinker_debug.c                           | 511 ++++++++++++++++++
 mm/vmscan.c                                   |  66 ++-
 mm/workingset.c                               |   2 +-
 mm/zsmalloc.c                                 |   2 +-
 net/sunrpc/auth.c                             |   2 +-
 tools/cgroup/memcg_shrinker.py                |  70 +++
 45 files changed, 836 insertions(+), 47 deletions(-)
 create mode 100644 Documentation/admin-guide/mm/shrinker_debugfs.rst
 create mode 100644 mm/shrinker_debug.c
 create mode 100755 tools/cgroup/memcg_shrinker.py

-- 
2.35.1


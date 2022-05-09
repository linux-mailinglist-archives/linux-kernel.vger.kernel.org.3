Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6503A5204A6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 20:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240243AbiEISm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 14:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240179AbiEISm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 14:42:26 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4123326084C
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 11:38:29 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1652121507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=wg7X+hDIQAnxZ2mBq8fPCOHY2m0N1zsR1d7bRCthk1o=;
        b=hhyxycifCkKzEFBEZ0ROTDSR94ZTAErkyneO1P5lkvPzD/OcFVlaht5ix+9lK53TKsSTDf
        TpIM/rq/Rc0SwbHQ6xGzba9e6sTgccp9TX0BP1+4UDMBBjtzmwdOWwgGNeucfkhLpOCENb
        wO1y9YFIJSPuLshp3Op8nj9AATOzo5Y=
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     Dave Chinner <dchinner@redhat.com>, linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH v3 0/6] mm: introduce shrinker debugfs interface
Date:   Mon,  9 May 2022 11:38:14 -0700
Message-Id: <20220509183820.573666-1-roman.gushchin@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
block's shrinker it is having only "super_cache_scan").

To provide a better visibility and debug options for memory shrinkers
this patchset introduces a /sys/kernel/debug/shrinker interface, to some extent
similar to /sys/kernel/slab.

For each shrinker registered in the system a directory is created.
As now, the directory will contain only a "scan" file, which allows to get
the number of managed objects for each memory cgroup (for memcg-aware shrinkers)
and each numa node (for numa-aware shrinkers on a numa machine). Other
interfaces might be added in the future.

To make debugging more pleasant, the patchset also names all shrinkers,
so that debugfs entries can have meaningful names.


v3:
  1) separated the "scan" part into a separate patch, by Dave
  2) merged *_memcg, *_node and *_memcg_node interfaces, by Dave
  3) shrinkers naming enhancements, by Christophe and Dave
  4) added signal_pending() check, by Hillf
  5) enabled by default, by Dave

v2:
  1) switched to debugfs, suggested by Mike, Andrew, Greg and others
  2) switched to seq_file API for output, no PAGE_SIZE limit anymore, by Andrew
  3) switched to down_read_killable(), suggested by Hillf
  4) dropped stateful filtering and "freed" returning, by Kent
  5) added docs, by Andrew
  6) added memcg_shrinker.py tool

rfc:
  https://lwn.net/Articles/891542/


Roman Gushchin (6):
  mm: memcontrol: introduce mem_cgroup_ino() and
    mem_cgroup_get_from_ino()
  mm: shrinkers: introduce debugfs interface for memory shrinkers
  mm: shrinkers: provide shrinkers with names
  mm: docs: document shrinker debugfs
  tools: add memcg_shrinker.py
  mm: shrinkers: add scan interface for shrinker debugfs

 Documentation/admin-guide/mm/index.rst        |   1 +
 .../admin-guide/mm/shrinker_debugfs.rst       | 131 ++++++++
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
 fs/btrfs/super.c                              |   2 +
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
 fs/super.c                                    |   6 +-
 fs/ubifs/super.c                              |   2 +-
 fs/xfs/xfs_buf.c                              |   2 +-
 fs/xfs/xfs_icache.c                           |   2 +-
 fs/xfs/xfs_qm.c                               |   2 +-
 include/linux/memcontrol.h                    |  21 ++
 include/linux/shrinker.h                      |  31 +-
 kernel/rcu/tree.c                             |   2 +-
 lib/Kconfig.debug                             |   9 +
 mm/Makefile                                   |   1 +
 mm/huge_memory.c                              |   4 +-
 mm/memcontrol.c                               |  23 ++
 mm/shrinker_debug.c                           | 285 ++++++++++++++++++
 mm/vmscan.c                                   |  64 +++-
 mm/workingset.c                               |   2 +-
 mm/zsmalloc.c                                 |   2 +-
 net/sunrpc/auth.c                             |   2 +-
 tools/cgroup/memcg_shrinker.py                |  71 +++++
 46 files changed, 675 insertions(+), 47 deletions(-)
 create mode 100644 Documentation/admin-guide/mm/shrinker_debugfs.rst
 create mode 100644 mm/shrinker_debug.c
 create mode 100755 tools/cgroup/memcg_shrinker.py

-- 
2.35.3


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D345092A1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 00:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352412AbiDTW1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 18:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237210AbiDTW1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 18:27:51 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D551CE0E3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 15:25:01 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id md4so3228250pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 15:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JRcRlCd9RiNTUqEl9kVbDHnf9xkaeLdlSy3c0c8ylHs=;
        b=UB+O/7MEqTTDR26Ez8XW6k5RcNsNLIQMmMqqPPuMq0JRybkGDpUQ+f67/JsxBplhRX
         BwtSu6sx81sS2DFe9mgkY6aR/9UUeszDvneeqMPIEKMW6mb9S2Ex5niXETuOXUvJgvaA
         sDKbF5MAY8x/K2UDqMYU93cX0R0ClfljrpbvfcpGRebLGVmhdY/zmcZjYf/7JKKdK71S
         29llC89lwXFjUAruOtk2vqEgm6MEe1+c5CC4f07fnPfWTwUr37sdvaskcnjVFjJ+/eE1
         ynGvkc2GPkruIaRntrWLvyfdHBIBel08dEAl+1n9lgG/eFBhMGPUkxAYOptpjlCk7jkn
         cYWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JRcRlCd9RiNTUqEl9kVbDHnf9xkaeLdlSy3c0c8ylHs=;
        b=m7roahlfqzg/7YDLvsrAlHjB9NxoP9xLD8uiMj76v5+vRKSbiyFima0+uRYqdK75un
         afVTfhD6t32XAmPp911RqJHa6gGpiyUk03IflQq56xfM5ILiIvLF1ilQNYxv8iTjMTXV
         qvUk8zTH1L9saRo2foxXYxewpM4ed409ghIkDu86Px5C+AJZtixtB22ua+PldBNugdnY
         SKM4Dkjih/2NBmxcMhgBPrU+JvQxyHMUWNm9g6Cb/T3c+0DNroj93rgUBdnBx9BUD3u6
         MqUtFVRRMZSVWnxlDvZ0nRLAh88UiNkvdKINM74SJj3oLdnMX77kYmzFhDgGd8LjgcMN
         o+1Q==
X-Gm-Message-State: AOAM5305KcKWZy+EzCuS/yhfGmnAKzufd8tyfssYto6K/SX/gPR6JOmQ
        GJwIH+7SutRjtQoiiloIIEefuI6aysQb+/ikPYc=
X-Google-Smtp-Source: ABdhPJxeSu6eRtEZFscc4WUt0n2Lj60D1PFrXJoRlFkXjdXtajHze0b4etmLXm7TpUiVkNizblidmuPwzzLuj/2sD2g=
X-Received: by 2002:a17:90b:4b10:b0:1d2:c235:6c8e with SMTP id
 lx16-20020a17090b4b1000b001d2c2356c8emr6759167pjb.21.1650493501340; Wed, 20
 Apr 2022 15:25:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220416002756.4087977-1-roman.gushchin@linux.dev>
In-Reply-To: <20220416002756.4087977-1-roman.gushchin@linux.dev>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 20 Apr 2022 15:24:49 -0700
Message-ID: <CAHbLzkrOS12pi8WEXyUgYEQ4gy0S9iVrEeBp-2Ypyn=1bthZRA@mail.gmail.com>
Subject: Re: [PATCH rfc 0/5] mm: introduce shrinker sysfs interface
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <dchinner@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2022 at 5:28 PM Roman Gushchin <roman.gushchin@linux.dev> wrote:
>
> There are 50+ different shrinkers in the kernel, many with their own bells and
> whistles. Under the memory pressure the kernel applies some pressure on each of
> them in the order of which they were created/registered in the system. Some
> of them can contain only few objects, some can be quite large. Some can be
> effective at reclaiming memory, some not.
>
> The only existing debugging mechanism is a couple of tracepoints in
> do_shrink_slab(): mm_shrink_slab_start and mm_shrink_slab_end. They aren't
> covering everything though: shrinkers which report 0 objects will never show up,
> there is no support for memcg-aware shrinkers. Shrinkers are identified by their
> scan function, which is not always enough (e.g. hard to guess which super
> block's shrinker it is having only "super_cache_scan"). They are a passive
> mechanism: there is no way to call into counting and scanning of an individual
> shrinker and profile it.
>
> To provide a better visibility and debug options for memory shrinkers
> this patchset introduces a /sys/kernel/shrinker interface, to some extent
> similar to /sys/kernel/slab.
>
> For each shrinker registered in the system a folder is created. The folder
> contains "count" and "scan" files, which allow to trigger count_objects()
> and scan_objects() callbacks. For memcg-aware and numa-aware shrinkers
> count_memcg, scan_memcg, count_node, scan_node, count_memcg_node
> and scan_memcg_node are additionally provided. They allow to get per-memcg
> and/or per-node object count and shrink only a specific memcg/node.
>
> To make debugging more pleasant, the patchset also names all shrinkers,
> so that sysfs entries can have more meaningful names.
>
> Usage examples:

Thanks, Roman. A follow-up question, why do we have to implement this
in kernel if we just count the objects? It seems userspace tools could
achieve it too, for example, drgn :-). Actually I did write a drgn
script for debugging a problem a few months ago, which iterates
specific memcg's lru_list to count the objects by their state.

>
> 1) List registered shrinkers:
>   $ cd /sys/kernel/shrinker/
>   $ ls
>     dqcache-16          sb-cgroup2-30    sb-hugetlbfs-33  sb-proc-41       sb-selinuxfs-22  sb-tmpfs-40    sb-zsmalloc-19
>     kfree_rcu-0         sb-configfs-23   sb-iomem-12      sb-proc-44       sb-sockfs-8      sb-tmpfs-42    shadow-18
>     sb-aio-20           sb-dax-11        sb-mqueue-21     sb-proc-45       sb-sysfs-26      sb-tmpfs-43    thp_deferred_split-10
>     sb-anon_inodefs-15  sb-debugfs-7     sb-nsfs-4        sb-proc-47       sb-tmpfs-1       sb-tmpfs-46    thp_zero-9
>     sb-bdev-3           sb-devpts-28     sb-pipefs-14     sb-pstore-31     sb-tmpfs-27      sb-tmpfs-49    xfs_buf-37
>     sb-bpf-32           sb-devtmpfs-5    sb-proc-25       sb-rootfs-2      sb-tmpfs-29      sb-tracefs-13  xfs_inodegc-38
>     sb-btrfs-24         sb-hugetlbfs-17  sb-proc-39       sb-securityfs-6  sb-tmpfs-35      sb-xfs-36      zspool-34
>
> 2) Get information about a specific shrinker:
>   $ cd sb-btrfs-24/
>   $ ls
>     count  count_memcg  count_memcg_node  count_node  scan  scan_memcg  scan_memcg_node  scan_node
>
> 3) Count objects on the system/root cgroup level
>   $ cat count
>     212
>
> 4) Count objects on the system/root cgroup level per numa node (on a 2-node machine)
>   $ cat count_node
>     209 3
>
> 5) Count objects for each memcg (output format: cgroup inode, count)
>   $ cat count_memcg
>     1 212
>     20 96
>     53 817
>     2297 2
>     218 13
>     581 30
>     911 124
>     <CUT>
>
> 6) Same but with a per-node output
>   $ cat count_memcg_node
>     1 209 3
>     20 96 0
>     53 810 7
>     2297 2 0
>     218 13 0
>     581 30 0
>     911 124 0
>     <CUT>
>
> 7) Don't display cgroups with less than 500 attached objects
>   $ echo 500 > count_memcg
>   $ cat count_memcg
>     53 817
>     1868 886
>     2396 799
>     2462 861
>
> 8) Don't display cgroups with less than 500 attached objects (sum over all nodes)
>   $ echo "500" > count_memcg_node
>   $ cat count_memcg_node
>     53 810 7
>     1868 886 0
>     2396 799 0
>     2462 861 0
>
> 9) Scan system/root shrinker
>   $ cat count
>     212
>   $ echo 100 > scan
>   $ cat scan
>     97
>   $ cat count
>     115
>
> 10) Scan individual memcg
>   $ echo "1868 500" > scan_memcg
>   $ cat scan_memcg
>     193
>
> 11) Scan individual node
>   $ echo "1 200" > scan_node
>   $ cat scan_node
>     2
>
> 12) Scan individual memcg and node
>   $ echo "1868 0 500" > scan_memcg_node
>   $ cat scan_memcg_node
>     435
>
> If the output doesn't fit into a single page, "...\n" is printed at the end of
> output.
>
>
> Roman Gushchin (5):
>   mm: introduce sysfs interface for debugging kernel shrinker
>   mm: memcontrol: introduce mem_cgroup_ino() and
>     mem_cgroup_get_from_ino()
>   mm: introduce memcg interfaces for shrinker sysfs
>   mm: introduce numa interfaces for shrinker sysfs
>   mm: provide shrinkers with names
>
>  arch/x86/kvm/mmu/mmu.c                        |   2 +-
>  drivers/android/binder_alloc.c                |   2 +-
>  drivers/gpu/drm/i915/gem/i915_gem_shrinker.c  |   3 +-
>  drivers/gpu/drm/msm/msm_gem_shrinker.c        |   2 +-
>  .../gpu/drm/panfrost/panfrost_gem_shrinker.c  |   2 +-
>  drivers/gpu/drm/ttm/ttm_pool.c                |   2 +-
>  drivers/md/bcache/btree.c                     |   2 +-
>  drivers/md/dm-bufio.c                         |   2 +-
>  drivers/md/dm-zoned-metadata.c                |   2 +-
>  drivers/md/raid5.c                            |   2 +-
>  drivers/misc/vmw_balloon.c                    |   2 +-
>  drivers/virtio/virtio_balloon.c               |   2 +-
>  drivers/xen/xenbus/xenbus_probe_backend.c     |   2 +-
>  fs/erofs/utils.c                              |   2 +-
>  fs/ext4/extents_status.c                      |   3 +-
>  fs/f2fs/super.c                               |   2 +-
>  fs/gfs2/glock.c                               |   2 +-
>  fs/gfs2/main.c                                |   2 +-
>  fs/jbd2/journal.c                             |   2 +-
>  fs/mbcache.c                                  |   2 +-
>  fs/nfs/nfs42xattr.c                           |   7 +-
>  fs/nfs/super.c                                |   2 +-
>  fs/nfsd/filecache.c                           |   2 +-
>  fs/nfsd/nfscache.c                            |   2 +-
>  fs/quota/dquot.c                              |   2 +-
>  fs/super.c                                    |   2 +-
>  fs/ubifs/super.c                              |   2 +-
>  fs/xfs/xfs_buf.c                              |   2 +-
>  fs/xfs/xfs_icache.c                           |   2 +-
>  fs/xfs/xfs_qm.c                               |   2 +-
>  include/linux/memcontrol.h                    |   9 +
>  include/linux/shrinker.h                      |  25 +-
>  kernel/rcu/tree.c                             |   2 +-
>  lib/Kconfig.debug                             |   9 +
>  mm/Makefile                                   |   1 +
>  mm/huge_memory.c                              |   4 +-
>  mm/memcontrol.c                               |  23 +
>  mm/shrinker_debug.c                           | 792 ++++++++++++++++++
>  mm/vmscan.c                                   |  66 +-
>  mm/workingset.c                               |   2 +-
>  mm/zsmalloc.c                                 |   2 +-
>  net/sunrpc/auth.c                             |   2 +-
>  42 files changed, 957 insertions(+), 47 deletions(-)
>  create mode 100644 mm/shrinker_debug.c
>
> --
> 2.35.1
>

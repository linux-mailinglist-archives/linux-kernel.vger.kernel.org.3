Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43FB34E3805
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 05:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236509AbiCVElF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 00:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236445AbiCVElC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 00:41:02 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65454756E
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 21:39:33 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id l128so2685519vsc.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 21:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qzc7xhnDWFDyGEZ9XczoWDDRN1//lp5rWNOk/MNR6Qc=;
        b=oj6Fa/oNOKoiISVs1Ikr/rzuXcz69rLctJa+06Hz/ntpa/w1ijb8EX+sQ8tWoC4k9s
         BaNT3TlaWgceZHzKDzKDwoXsU1JdT4F5R8X1mxFOVKXEj7/rMGtKypk3SKhl1xdeGCMq
         4FWXRY+oJdTUQp8oKXMigBUkVCxGHuzOF7bhiB7ltNHGtDlSKq7QhWZn3EjIdrD3nyOy
         ShiML/kIoLgen2R8zUVAc32UyR7d9Xt8x1BCFR/m5o2cUWjzULCBmqem78CbKQdz6n95
         JLRqHGJtOrybTEwtoKVJ0kFwYTxXeA2KXBKbXFlTmkdaGXKKe3CBxFG4Qn1EaSFy0CfZ
         E4zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qzc7xhnDWFDyGEZ9XczoWDDRN1//lp5rWNOk/MNR6Qc=;
        b=WvyLx+btpnPwZgbGLfqT7s7cJHjmB0nPC1qwBkcxDLzyn7yVhoEb47p0bJgyzTK9GV
         ERN9SkZjJihMKk0s0xkyZBehTLrvPcLAd3QfKWC0KQbYc3fwYmkHzxIoT3RElXeWxgUX
         VQQKi6ZugqDWp6sXTPABbo7OowJIcaSE1wT0EW5BeHnBvjIpQ2PqZJnbCCSM1s0I6HUX
         gHsKrZJ6NBcbBpcT0Pc6m+RRSuL+L755iXPrFNfJGEBBLN0MQRPcZ3WfOsvNHaZwvmZR
         ehOC9ff55Oc650e9x7d+cc+oT3qfU5Ywo+yEtOGl96j84REroC3181hY/qvY5qFYBrP7
         WqkA==
X-Gm-Message-State: AOAM533zUOZzy5gUoZCJ07GLJV9SqMIzNKWlOiM96PoCMQ/1vZBIVAJ/
        3Aim14CNRx7rS/eGQ+jLVeF7P1G1pShxu66ilHkOeg==
X-Google-Smtp-Source: ABdhPJxefLANlaq+qPI8GTvOzY0DYXscT+QrMjjT+L1xVXhF0FUVv+/fBcCrd2jQ68TGtCC08s8uJkG+6HgUJ8u8x6A=
X-Received: by 2002:a05:6102:5cc:b0:320:9bd2:3823 with SMTP id
 v12-20020a05610205cc00b003209bd23823mr8796701vsf.81.1647923972368; Mon, 21
 Mar 2022 21:39:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220309021230.721028-1-yuzhao@google.com> <20220309021230.721028-7-yuzhao@google.com>
 <87a6dj793j.fsf@linux.ibm.com>
In-Reply-To: <87a6dj793j.fsf@linux.ibm.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Mon, 21 Mar 2022 22:39:21 -0600
Message-ID: <CAOUHufYfpiGdLSdffvzDqaD5oYFG99oDJ2xgQd2Ph77OFR5NAA@mail.gmail.com>
Subject: Re: [PATCH v9 06/14] mm: multi-gen LRU: minimal implementation
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Kernel Page Reclaim v2 <page-reclaim@google.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Donald Carr <d@chaos-reins.com>,
        =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>,
        Vaibhav Jain <vaibhav@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 7:01 AM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> Yu Zhao <yuzhao@google.com> writes:
>
> > To avoid confusion, the terms "promotion" and "demotion" will be
> > applied to the multi-gen LRU, as a new convention; the terms
> > "activation" and "deactivation" will be applied to the active/inactive
> > LRU, as usual.
> >
> > The aging produces young generations. Given an lruvec, it increments
> > max_seq when max_seq-min_seq+1 approaches MIN_NR_GENS. The aging
> > promotes hot pages to the youngest generation when it finds them
> > accessed through page tables; the demotion of cold pages happens
> > consequently when it increments max_seq. The aging has the complexity
> > O(nr_hot_pages), since it is only interested in hot pages. Promotion
> > in the aging path does not require any LRU list operations, only the
> > updates of the gen counter and lrugen->nr_pages[]; demotion, unless as
> > the result of the increment of max_seq, requires LRU list operations,
> > e.g., lru_deactivate_fn().
> >
> > The eviction consumes old generations. Given an lruvec, it increments
> > min_seq when the lists indexed by min_seq%MAX_NR_GENS become empty. A
> > feedback loop modeled after the PID controller monitors refaults over
> > anon and file types and decides which type to evict when both types
> > are available from the same generation.
> >
> > Each generation is divided into multiple tiers. Tiers represent
> > different ranges of numbers of accesses through file descriptors. A
> > page accessed N times through file descriptors is in tier
> > order_base_2(N). Tiers do not have dedicated lrugen->lists[], only
> > bits in folio->flags. In contrast to moving across generations, which
> > requires the LRU lock, moving across tiers only involves operations on
> > folio->flags. The feedback loop also monitors refaults over all tiers
> > and decides when to protect pages in which tiers (N>1), using the
> > first tier (N=0,1) as a baseline. The first tier contains single-use
> > unmapped clean pages, which are most likely the best choices. The
> > eviction moves a page to the next generation, i.e., min_seq+1, if the
> > feedback loop decides so. This approach has the following advantages:
> > 1. It removes the cost of activation in the buffered access path by
> >    inferring whether pages accessed multiple times through file
> >    descriptors are statistically hot and thus worth protecting in the
> >    eviction path.
> > 2. It takes pages accessed through page tables into account and avoids
> >    overprotecting pages accessed multiple times through file
> >    descriptors. (Pages accessed through page tables are in the first
> >    tier, since N=0.)
> > 3. More tiers provide better protection for pages accessed more than
> >    twice through file descriptors, when under heavy buffered I/O
> >    workloads.
> >
> > Server benchmark results:
> >   Single workload:
> >     fio (buffered I/O): +[47, 49]%
> >                 IOPS         BW
> >       5.17-rc2: 2242k        8759MiB/s
> >       patch1-5: 3321k        12.7GiB/s
> >
> >   Single workload:
> >     memcached (anon): +[101, 105]%
> >                 Ops/sec      KB/sec
> >       5.17-rc2: 476771.79    18544.31
> >       patch1-5: 972526.07    37826.95
> >
> >   Configurations:
> >     CPU: two Xeon 6154
> >     Mem: total 256G
> >
> >     Node 1 was only used as a ram disk to reduce the variance in the
> >     results.
> >
> >     patch drivers/block/brd.c <<EOF
> >     99,100c99,100
> >     <         gfp_flags = GFP_NOIO | __GFP_ZERO | __GFP_HIGHMEM;
> >     <         page = alloc_page(gfp_flags);
> >     ---
> >     >         gfp_flags = GFP_NOIO | __GFP_ZERO | __GFP_HIGHMEM | __GFP_THISNODE;
> >     >         page = alloc_pages_node(1, gfp_flags, 0);
> >     EOF
> >
> >     cat >>/etc/systemd/system.conf <<EOF
> >     CPUAffinity=numa
> >     NUMAPolicy=bind
> >     NUMAMask=0
> >     EOF
> >
> >     cat >>/etc/memcached.conf <<EOF
> >     -m 184320
> >     -s /var/run/memcached/memcached.sock
> >     -a 0766
> >     -t 36
> >     -B binary
> >     EOF
> >
> >     cat fio.sh
> >     modprobe brd rd_nr=1 rd_size=113246208
> >     mkfs.ext4 /dev/ram0
> >     mount -t ext4 /dev/ram0 /mnt
> >
> >     mkdir /sys/fs/cgroup/user.slice/test
> >     echo 38654705664 >/sys/fs/cgroup/user.slice/test/memory.max
> >     echo $$ >/sys/fs/cgroup/user.slice/test/cgroup.procs
> >     fio -name=mglru --numjobs=72 --directory=/mnt --size=1408m \
> >       --buffered=1 --ioengine=io_uring --iodepth=128 \
> >       --iodepth_batch_submit=32 --iodepth_batch_complete=32 \
> >       --rw=randread --random_distribution=random --norandommap \
> >       --time_based --ramp_time=10m --runtime=5m --group_reporting
> >
> >     cat memcached.sh
> >     modprobe brd rd_nr=1 rd_size=113246208
> >     swapoff -a
> >     mkswap /dev/ram0
> >     swapon /dev/ram0
> >
> >     memtier_benchmark -S /var/run/memcached/memcached.sock \
> >       -P memcache_binary -n allkeys --key-minimum=1 \
> >       --key-maximum=65000000 --key-pattern=P:P -c 1 -t 36 \
> >       --ratio 1:0 --pipeline 8 -d 2000
> >
> >     memtier_benchmark -S /var/run/memcached/memcached.sock \
> >       -P memcache_binary -n allkeys --key-minimum=1 \
> >       --key-maximum=65000000 --key-pattern=R:R -c 1 -t 36 \
> >       --ratio 0:1 --pipeline 8 --randomize --distinct-client-seed
> >
> > Client benchmark results:
> >   kswapd profiles:
> >     5.17-rc2
> >       38.05%  page_vma_mapped_walk
> >       20.86%  lzo1x_1_do_compress (real work)
> >        6.16%  do_raw_spin_lock
> >        4.61%  _raw_spin_unlock_irq
> >        2.20%  vma_interval_tree_iter_next
> >        2.19%  vma_interval_tree_subtree_search
> >        2.15%  page_referenced_one
> >        1.93%  anon_vma_interval_tree_iter_first
> >        1.65%  ptep_clear_flush
> >        1.00%  __zram_bvec_write
> >
> >     patch1-5
> >       39.73%  lzo1x_1_do_compress (real work)
> >       14.96%  page_vma_mapped_walk
> >        6.97%  _raw_spin_unlock_irq
> >        3.07%  do_raw_spin_lock
> >        2.53%  anon_vma_interval_tree_iter_first
> >        2.04%  ptep_clear_flush
> >        1.82%  __zram_bvec_write
> >        1.76%  __anon_vma_interval_tree_subtree_search
> >        1.57%  memmove
> >        1.45%  free_unref_page_list
> >
> >   Configurations:
> >     CPU: single Snapdragon 7c
> >     Mem: total 4G
> >
> >     Chrome OS MemoryPressure [1]
> >
> > [1] https://chromium.googlesource.com/chromiumos/platform/tast-tests/
> >
>
> In shrink_active_list we do preferential treatment of VM_EXEC pages.
> Do we do similar thing with MGLRU? if not why is that not needed?

No, because MGLRU has a different set of assumptions than the
active/inactive LRU does [1]. It provides mmapped pages with equal
opportunities, and the tradeoff was discussed here [2].

Note that even with this preferential treatment of executable pages,
plus other heuristics added since then, executable pages are still
underprotected for at least desktop workloads [3]. And I can confirm
the problem reported is genuine -- we recently accidentally removed
our private patch that works around the problem for the last 12 years,
and observed immediate consequences on a small portion of devices not
using MGLRU [4].

[1] https://lore.kernel.org/linux-mm/20220309021230.721028-15-yuzhao@google.com/
[2] https://lore.kernel.org/linux-mm/20220208081902.3550911-5-yuzhao@google.com/
[3] https://lore.kernel.org/linux-mm/2dc51fc8-f14e-17ed-a8c6-0ec70423bf54@valdikss.org.ru/
[4] https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/3429559

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 882CE4AD300
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 09:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349063AbiBHITd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 03:19:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343666AbiBHIT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 03:19:28 -0500
Received: from mail-io1-xd49.google.com (mail-io1-xd49.google.com [IPv6:2607:f8b0:4864:20::d49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853C7C0401F6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 00:19:27 -0800 (PST)
Received: by mail-io1-xd49.google.com with SMTP id g16-20020a05660203d000b005f7b3b0642eso10865833iov.16
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 00:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=CtSEcwwHnFIi4ZeyTyvxpEAgxW/JhSRSL0Dk6q/C1m4=;
        b=nHxc5M/BKlu2xNwc3dEj94/nTSmwuUbGMp2gKTTlBqdd5VKBwo+Ezpw0SZEr9PuwOY
         3ADoj9qDMD2q+i32fRp55g3Rqg2bRQtXK80VOXAK6/+5k2QGu7NPYWIyXNAF0yJ0lF6L
         hT/Sk8gxycUbomS0lOdgx/Eg+OoWva/E2nfQBqlghy658jbNu4/LqZfbsUo/3Rtn4vUu
         n7bUsJmeQzIA72z19MnIhDegklwwYnpSMX7LTflS+ZnuEvKml1yXNeuxPv3PSs11cbd2
         xAURk+W3F+5k1YrfU6merjtzHYhuel3uoTFSd9DPQhUVNprDpn7c1DdeQnUNG3T+2tFH
         19yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=CtSEcwwHnFIi4ZeyTyvxpEAgxW/JhSRSL0Dk6q/C1m4=;
        b=BmG2/6oMj+sZqPd+qXgJh4mvJxcoA697mCe2b8Z9MSd/ySUr4Ql2nU5zbzwJY/wMmP
         IAxW4JQof9PPNrWKqG6Dq7Hvo8Ssd3KxETMM0WXNTvIBI/xto4dmS9MAkDHjUbFRWe+8
         Zh4HxQu7gyevvNbOyBkN30mNxBycmnfhXn+qiroZOKG8QSyiGghFlTnhbISvEY8ciQyf
         N+2/rWFCi0D5F8diCm1+COhfUElO8g0FD618+G+BRoDHvyQO590PCxbLrKGykLuSFygG
         krL85BPc3BJh5UgOLF0SJZM8MLU+T5DCISEGCQMyTfywr+Or8HUrPzOUUyDsC0UeHNrR
         PyQA==
X-Gm-Message-State: AOAM532f1VoroZN1nlMMNKD58xalcbGKTRQAQyncz6HOM4BXTsmN4xG6
        soRiiSZWPvTz00PBWjJi1G7Xt7i+/6w=
X-Google-Smtp-Source: ABdhPJxu+5NU4t2KarfhxBSYpIP9Abr9gYxZEgT9m4UKtdOuteaDKhwjFTcY0nZqkbr4/Q2LROD98odB/iA=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:5f31:19c3:21f5:7300])
 (user=yuzhao job=sendgmr) by 2002:a05:6e02:12e6:: with SMTP id
 l6mr1692122iln.251.1644308366542; Tue, 08 Feb 2022 00:19:26 -0800 (PST)
Date:   Tue,  8 Feb 2022 01:18:50 -0700
Message-Id: <20220208081902.3550911-1-yuzhao@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH v7 00/12] Multigenerational LRU Framework
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Barry Song <21cnbao@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Larabel <Michael@michaellarabel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        page-reclaim@google.com, x86@kernel.org,
        Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

What's new
==========
1) Addressed all the comments received on the mailing list and in the
   meeting with the stakeholders (will note on individual patches).
2) Measured the performance improvements for each patch between 5-8
   (reported in the commit messages).

TLDR
====
The current page reclaim is too expensive in terms of CPU usage and it
often makes poor choices about what to evict. This patchset offers an
alternative solution that is performant, versatile and straightforward.

Patchset overview
=================
The design and implementation overview was moved to patch 12 so that
people can finish reading this cover letter.

1. mm: x86, arm64: add arch_has_hw_pte_young()
2. mm: x86: add CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG
Using hardware optimizations when trying to clear the accessed bit in
many PTEs.

3. mm/vmscan.c: refactor shrink_node()
A minor refactor.

4. mm: multigenerational LRU: groundwork
Adding the basic data structure and the functions that insert/remove
pages to/from the multigenerational LRU (MGLRU) lists.

5. mm: multigenerational LRU: minimal implementation
A minimal (functional) implementation without any optimizations.

6. mm: multigenerational LRU: exploit locality in rmap
Improving the efficiency when using the rmap.

7. mm: multigenerational LRU: support page table walks
Adding the (optional) page table scanning.

8. mm: multigenerational LRU: optimize multiple memcgs
Optimizing the overall performance for multiple memcgs running mixed
types of workloads.

9. mm: multigenerational LRU: runtime switch
Adding a runtime switch to enable or disable MGLRU.

10. mm: multigenerational LRU: thrashing prevention
11. mm: multigenerational LRU: debugfs interface
Providing userspace with additional features like thrashing prevention,
working set estimation and proactive reclaim.

12. mm: multigenerational LRU: documentation
Adding a design doc and an admin guide.

Benchmark results
=================
Independent lab results
-----------------------
Based on the popularity of searches [01] and the memory usage in
Google's public cloud, the most popular open-source memory-hungry
applications, in alphabetical order, are:
      Apache Cassandra      Memcached
      Apache Hadoop         MongoDB
      Apache Spark          PostgreSQL
      MariaDB (MySQL)       Redis

An independent lab evaluated MGLRU with the most widely used benchmark
suites for the above applications. They posted 960 data points along
with kernel metrics and perf profiles collected over more than 500
hours of total benchmark time. Their final reports show that, with 95%
confidence intervals (CIs), the above applications all performed
significantly better for at least part of their benchmark matrices.

On 5.14:
1. Apache Spark [02] took 95% CIs [9.28, 11.19]% and [12.20, 14.93]%
   less wall time to sort three billion random integers, respectively,
   under the medium- and the high-concurrency conditions, when
   overcommitting memory. There were no statistically significant
   changes in wall time for the rest of the benchmark matrix.
2. MariaDB [03] achieved 95% CIs [5.24, 10.71]% and [20.22, 25.97]%
   more transactions per minute (TPM), respectively, under the medium-
   and the high-concurrency conditions, when overcommitting memory.
   There were no statistically significant changes in TPM for the rest
   of the benchmark matrix.
3. Memcached [04] achieved 95% CIs [23.54, 32.25]%, [20.76, 41.61]%
   and [21.59, 30.02]% more operations per second (OPS), respectively,
   for sequential access, random access and Gaussian (distribution)
   access, when THP=always; 95% CIs [13.85, 15.97]% and
   [23.94, 29.92]% more OPS, respectively, for random access and
   Gaussian access, when THP=never. There were no statistically
   significant changes in OPS for the rest of the benchmark matrix.
4. MongoDB [05] achieved 95% CIs [2.23, 3.44]%, [6.97, 9.73]% and
   [2.16, 3.55]% more operations per second (OPS), respectively, for
   exponential (distribution) access, random access and Zipfian
   (distribution) access, when underutilizing memory; 95% CIs
   [8.83, 10.03]%, [21.12, 23.14]% and [5.53, 6.46]% more OPS,
   respectively, for exponential access, random access and Zipfian
   access, when overcommitting memory.

On 5.15:
5. Apache Cassandra [06] achieved 95% CIs [1.06, 4.10]%, [1.94, 5.43]%
   and [4.11, 7.50]% more operations per second (OPS), respectively,
   for exponential (distribution) access, random access and Zipfian
   (distribution) access, when swap was off; 95% CIs [0.50, 2.60]%,
   [6.51, 8.77]% and [3.29, 6.75]% more OPS, respectively, for
   exponential access, random access and Zipfian access, when swap was
   on.
6. Apache Hadoop [07] took 95% CIs [5.31, 9.69]% and [2.02, 7.86]%
   less average wall time to finish twelve parallel TeraSort jobs,
   respectively, under the medium- and the high-concurrency
   conditions, when swap was on. There were no statistically
   significant changes in average wall time for the rest of the
   benchmark matrix.
7. PostgreSQL [08] achieved 95% CI [1.75, 6.42]% more transactions per
   minute (TPM) under the high-concurrency condition, when swap was
   off; 95% CIs [12.82, 18.69]% and [22.70, 46.86]% more TPM,
   respectively, under the medium- and the high-concurrency
   conditions, when swap was on. There were no statistically
   significant changes in TPM for the rest of the benchmark matrix.
8. Redis [09] achieved 95% CIs [0.58, 5.94]%, [6.55, 14.58]% and
   [11.47, 19.36]% more total operations per second (OPS),
   respectively, for sequential access, random access and Gaussian
   (distribution) access, when THP=always; 95% CIs [1.27, 3.54]%,
   [10.11, 14.81]% and [8.75, 13.64]% more total OPS, respectively,
   for sequential access, random access and Gaussian access, when
   THP=never.

Our lab results
---------------
To supplement the above results, we ran the following benchmark suites
on 5.16-rc7 and found no regressions [10]. (These synthetic benchmarks
are popular among MM developers, but we prefer large-scale A/B
experiments to validate improvements.)
      fs_fio_bench_hdd_mq      pft
      fs_lmbench               pgsql-hammerdb
      fs_parallelio            redis
      fs_postmark              stream
      hackbench                sysbenchthread
      kernbench                tpcc_spark
      memcached                unixbench
      multichase               vm-scalability
      mutilate                 will-it-scale
      nginx

[01] https://trends.google.com
[02] https://lore.kernel.org/lkml/20211102002002.92051-1-bot@edi.works/
[03] https://lore.kernel.org/lkml/20211009054315.47073-1-bot@edi.works/
[04] https://lore.kernel.org/lkml/20211021194103.65648-1-bot@edi.works/
[05] https://lore.kernel.org/lkml/20211109021346.50266-1-bot@edi.works/
[06] https://lore.kernel.org/lkml/20211202062806.80365-1-bot@edi.works/
[07] https://lore.kernel.org/lkml/20211209072416.33606-1-bot@edi.works/
[08] https://lore.kernel.org/lkml/20211218071041.24077-1-bot@edi.works/
[09] https://lore.kernel.org/lkml/20211122053248.57311-1-bot@edi.works/
[10] https://lore.kernel.org/lkml/20220104202247.2903702-1-yuzhao@google.com/

Read-world applications
=======================
Third-party testimonials
------------------------
Konstantin wrote [11]:
   I have Archlinux with 8G RAM + zswap + swap. While developing, I
   have lots of apps opened such as multiple LSP-servers for different
   langs, chats, two browsers, etc... Usually, my system gets quickly
   to a point of SWAP-storms, where I have to kill LSP-servers,
   restart browsers to free memory, etc, otherwise the system lags
   heavily and is barely usable.
   
   1.5 day ago I migrated from 5.11.15 kernel to 5.12 + the LRU
   patchset, and I started up by opening lots of apps to create memory
   pressure, and worked for a day like this. Till now I had *not a
   single SWAP-storm*, and mind you I got 3.4G in SWAP. I was never
   getting to the point of 3G in SWAP before without a single
   SWAP-storm.

An anonymous user wrote [12]:
   Using that v5 for some time and confirm that difference under heavy
   load and memory pressure is significant.

Shuang wrote [13]:
   With the MGLRU, fio achieved 95% CIs [38.95, 40.26]%, [4.12, 6.64]%
   and [9.26, 10.36]% higher throughput, respectively, for random
   access, Zipfian (distribution) access and Gaussian (distribution)
   access, when the average number of jobs per CPU is 1; 95% CIs
   [42.32, 49.15]%, [9.44, 9.89]% and [20.99, 22.86]% higher throughput,
   respectively, for random access, Zipfian access and Gaussian access,
   when the average number of jobs per CPU is 2.

Daniel wrote [14]:
   With memcached allocating ~100GB of byte-addressable Optante,
   performance improvement in terms of throughput (measured as queries
   per second) was about 10% for a series of workloads.

Large-scale deployments
-----------------------
The downstream kernels that have been using MGLRU include:
1. Android ARCVM [15]
2. Arch Linux Zen [16]
3. Chrome OS [17]
4. Liquorix [18]
5. post-factum [19]
6. XanMod [20]

We've rolled out MGLRU to tens of millions of Chrome OS users and
about a million Android users. Google's fleetwide profiling [21] shows
an overall 40% decrease in kswapd CPU usage, in addition to
improvements in other UX metrics, e.g., an 85% decrease in the number
of low-memory kills at the 75th percentile and an 18% decrease in
rendering latency at the 50th percentile.

[11] https://lore.kernel.org/lkml/140226722f2032c86301fbd326d91baefe3d7d23.camel@yandex.ru/
[12] https://phoronix.com/forums/forum/software/general-linux-open-source/1301258-mglru-is-a-very-enticing-enhancement-for-linux-in-2022?p=1301275#post1301275
[13] https://lore.kernel.org/lkml/20220105024423.26409-1-szhai2@cs.rochester.edu/
[14] https://lore.kernel.org/linux-mm/CA+4-3vksGvKd18FgRinxhqHetBS1hQekJE2gwco8Ja-bJWKtFw@mail.gmail.com/
[15] https://chromium.googlesource.com/chromiumos/third_party/kernel
[16] https://archlinux.org
[17] https://chromium.org
[18] https://liquorix.net
[19] https://gitlab.com/post-factum/pf-kernel
[20] https://xanmod.org
[21] https://research.google/pubs/pub44271/

Summery
=======
The facts are:
1. The independent lab results and the real-world applications
   indicate substantial improvements; there are no known regressions.
2. Thrashing prevention, working set estimation and proactive reclaim
   work out of the box; there are no equivalent solutions.
3. There is a lot of new code; nobody has demonstrated smaller changes
   with similar effects.

Our options, accordingly, are:
1. Given the amount of evidence, the reported improvements will likely
   materialize for a wide range of workloads.
2. Gauging the interest from the past discussions [22][23][24], the
   new features will likely be put to use for both personal computers
   and data centers.
3. Based on Google's track record, the new code will likely be well
   maintained in the long term. It'd be more difficult if not
   impossible to achieve similar effects on top of the existing
   design.

[22] https://lore.kernel.org/lkml/20201005081313.732745-1-andrea.righi@canonical.com/
[23] https://lore.kernel.org/lkml/20210716081449.22187-1-sj38.park@gmail.com/
[24] https://lore.kernel.org/lkml/20211130201652.2218636d@mail.inbox.lv/

Yu Zhao (12):
  mm: x86, arm64: add arch_has_hw_pte_young()
  mm: x86: add CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG
  mm/vmscan.c: refactor shrink_node()
  mm: multigenerational LRU: groundwork
  mm: multigenerational LRU: minimal implementation
  mm: multigenerational LRU: exploit locality in rmap
  mm: multigenerational LRU: support page table walks
  mm: multigenerational LRU: optimize multiple memcgs
  mm: multigenerational LRU: runtime switch
  mm: multigenerational LRU: thrashing prevention
  mm: multigenerational LRU: debugfs interface
  mm: multigenerational LRU: documentation

 Documentation/admin-guide/mm/index.rst        |    1 +
 Documentation/admin-guide/mm/multigen_lru.rst |  121 +
 Documentation/vm/index.rst                    |    1 +
 Documentation/vm/multigen_lru.rst             |  152 +
 arch/Kconfig                                  |    9 +
 arch/arm64/include/asm/pgtable.h              |   14 +-
 arch/x86/Kconfig                              |    1 +
 arch/x86/include/asm/pgtable.h                |    9 +-
 arch/x86/mm/pgtable.c                         |    5 +-
 fs/exec.c                                     |    2 +
 fs/fuse/dev.c                                 |    3 +-
 include/linux/cgroup.h                        |   15 +-
 include/linux/memcontrol.h                    |   36 +
 include/linux/mm.h                            |    8 +
 include/linux/mm_inline.h                     |  214 ++
 include/linux/mm_types.h                      |   78 +
 include/linux/mmzone.h                        |  182 ++
 include/linux/nodemask.h                      |    1 +
 include/linux/page-flags-layout.h             |   19 +-
 include/linux/page-flags.h                    |    4 +-
 include/linux/pgtable.h                       |   17 +-
 include/linux/sched.h                         |    4 +
 include/linux/swap.h                          |    5 +
 kernel/bounds.c                               |    3 +
 kernel/cgroup/cgroup-internal.h               |    1 -
 kernel/exit.c                                 |    1 +
 kernel/fork.c                                 |    9 +
 kernel/sched/core.c                           |    1 +
 mm/Kconfig                                    |   50 +
 mm/huge_memory.c                              |    3 +-
 mm/memcontrol.c                               |   27 +
 mm/memory.c                                   |   39 +-
 mm/mm_init.c                                  |    6 +-
 mm/page_alloc.c                               |    1 +
 mm/rmap.c                                     |    7 +
 mm/swap.c                                     |   55 +-
 mm/vmscan.c                                   | 2831 ++++++++++++++++-
 mm/workingset.c                               |  119 +-
 38 files changed, 3908 insertions(+), 146 deletions(-)
 create mode 100644 Documentation/admin-guide/mm/multigen_lru.rst
 create mode 100644 Documentation/vm/multigen_lru.rst

-- 
2.35.0.263.gb82422642f-goog


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 592E348CD5C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 22:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbiALVD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 16:03:28 -0500
Received: from vulcan.natalenko.name ([104.207.131.136]:39044 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiALVDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 16:03:22 -0500
X-Greylist: delayed 377 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Jan 2022 16:03:21 EST
Received: from spock.localnet (unknown [83.148.33.151])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id AAB2CD592BD;
        Wed, 12 Jan 2022 21:57:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1642021021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bET0J58tyLUlwob/ClleCAGdXtg36nj9Hhq9kt5P2Vc=;
        b=ajS2yWqTBoNlJ4r6v9/d1IfCgUpgpi5CxFoN5whwkctZqObUHchvnkpx+YKOi8Fy/bBU/E
        pSX8gUMpVydNjLE7QMDeoTynPDqGa/x13iNq+EYXbmCAHHwDo3loQogrfzeCmNXI7X22kT
        HEZMNJoIkn65UVT6TDX7WfHaEhr98TA=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
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
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        page-reclaim@google.com, x86@kernel.org,
        Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH v6 0/9] Multigenerational LRU Framework
Date:   Wed, 12 Jan 2022 21:56:58 +0100
Message-ID: <11900935.O9o76ZdvQC@natalenko.name>
In-Reply-To: <20220104202227.2903605-1-yuzhao@google.com>
References: <20220104202227.2903605-1-yuzhao@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

On =FAter=FD 4. ledna 2022 21:22:19 CET Yu Zhao wrote:
> TLDR
> =3D=3D=3D=3D
> The current page reclaim is too expensive in terms of CPU usage and it
> often makes poor choices about what to evict. This patchset offers an
> alternative solution that is performant, versatile and
> straightforward.
>=20
> Design objectives
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> The design objectives are:
> 1. Better representation of access recency
> 2. Try to profit from spatial locality
> 3. Clear fast path making obvious choices
> 4. Simple self-correcting heuristics
>=20
> The representation of access recency is at the core of all LRU
> approximations. The multigenerational LRU (MGLRU) divides pages into
> multiple lists (generations), each having bounded access recency (a
> time interval). Generations establish a common frame of reference and
> help make better choices, e.g., between different memcgs on a computer
> or different computers in a data center (for cluster job scheduling).
>=20
> Exploiting spatial locality improves the efficiency when gathering the
> accessed bit. A rmap walk targets a single page and doesn't try to
> profit from discovering an accessed PTE. A page table walk can sweep
> all hotspots in an address space, but its search space can be too
> large to make a profit. The key is to optimize both methods and use
> them in combination. (PMU is another option for further exploration.)
>=20
> Fast path reduces code complexity and runtime overhead. Unmapped pages
> don't require TLB flushes; clean pages don't require writeback. These
> facts are only helpful when other conditions, e.g., access recency,
> are similar. With generations as a common frame of reference,
> additional factors stand out. But obvious choices might not be good
> choices; thus self-correction is required (the next objective).
>=20
> The benefits of simple self-correcting heuristics are self-evident.
> Again with generations as a common frame of reference, this becomes
> attainable. Specifically, pages in the same generation are categorized
> based on additional factors, and a closed-loop control statistically
> compares the refault percentages across all categories and throttles
> the eviction of those that have higher percentages.
>=20
> Patchset overview
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 1. mm: x86, arm64: add arch_has_hw_pte_young()
> 2. mm: x86: add CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG
> Materializing hardware optimizations when trying to clear the accessed
> bit in many PTEs. If hardware automatically sets the accessed bit in
> PTEs, there is no need to worry about bursty page faults (emulating
> the accessed bit). If it also sets the accessed bit in non-leaf PMD
> entries, there is no need to search the PTE table pointed to by a PMD
> entry that doesn't have the accessed bit set.
>=20
> 3. mm/vmscan.c: refactor shrink_node()
> A minor refactor.
>=20
> 4. mm: multigenerational lru: groundwork
> Adding the basic data structure and the functions to initialize it and
> insert/remove pages.
>=20
> 5. mm: multigenerational lru: mm_struct list
> An infra keeps track of mm_struct's for page table walkers and
> provides them with optimizations, i.e., switch_mm() tracking and Bloom
> filters.
>=20
> 6. mm: multigenerational lru: aging
> 7. mm: multigenerational lru: eviction
> "The page reclaim" is a producer/consumer model. "The aging" produces
> cold pages, whereas "the eviction " consumes them. Cold pages flow
> through generations. The aging uses the mm_struct list infra to sweep
> dense hotspots in page tables. During a page table walk, the aging
> clears the accessed bit and tags accessed pages with the youngest
> generation number. The eviction sorts those pages when it encounters
> them. For pages in the oldest generation, eviction walks the rmap to
> check the accessed bit one more time before evicting them. During an
> rmap walk, the eviction feeds dense hotspots back to the aging. Dense
> hotspots flow through the Bloom filters. For pages not mapped in page
> tables, the eviction uses the PID controller to statistically
> determine whether they have higher refaults. If so, the eviction
> throttles their eviction by moving them to the next generation (the
> second oldest).
>=20
> 8. mm: multigenerational lru: user interface
> The knobs to turn on/off MGLRU and provide the userspace with
> thrashing prevention, working set estimation (the aging) and proactive
> reclaim (the eviction).
>=20
> 9. mm: multigenerational lru: Kconfig
> The Kconfig options.
>=20
> Benchmark results
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Independent lab results
> -----------------------
> Based on the popularity of searches [01] and the memory usage in
> Google's public cloud, the most popular open-source memory-hungry
> applications, in alphabetical order, are:
>       Apache Cassandra      Memcached
>       Apache Hadoop         MongoDB
>       Apache Spark          PostgreSQL
>       MariaDB (MySQL)       Redis
>=20
> An independent lab evaluated MGLRU with the most widely used benchmark
> suites for the above applications. They posted 960 data points along
> with kernel metrics and perf profiles collected over more than 500
> hours of total benchmark time. Their final reports show that, with 95%
> confidence intervals (CIs), the above applications all performed
> significantly better for at least part of their benchmark matrices.
>=20
> On 5.14:
> 1. Apache Spark [02] took 95% CIs [9.28, 11.19]% and [12.20, 14.93]%
>    less wall time to sort three billion random integers, respectively,
>    under the medium- and the high-concurrency conditions, when
>    overcommitting memory. There were no statistically significant
>    changes in wall time for the rest of the benchmark matrix.
> 2. MariaDB [03] achieved 95% CIs [5.24, 10.71]% and [20.22, 25.97]%
>    more transactions per minute (TPM), respectively, under the medium-
>    and the high-concurrency conditions, when overcommitting memory.
>    There were no statistically significant changes in TPM for the rest
>    of the benchmark matrix.
> 3. Memcached [04] achieved 95% CIs [23.54, 32.25]%, [20.76, 41.61]%
>    and [21.59, 30.02]% more operations per second (OPS), respectively,
>    for sequential access, random access and Gaussian (distribution)
>    access, when THP=3Dalways; 95% CIs [13.85, 15.97]% and
>    [23.94, 29.92]% more OPS, respectively, for random access and
>    Gaussian access, when THP=3Dnever. There were no statistically
>    significant changes in OPS for the rest of the benchmark matrix.
> 4. MongoDB [05] achieved 95% CIs [2.23, 3.44]%, [6.97, 9.73]% and
>    [2.16, 3.55]% more operations per second (OPS), respectively, for
>    exponential (distribution) access, random access and Zipfian
>    (distribution) access, when underutilizing memory; 95% CIs
>    [8.83, 10.03]%, [21.12, 23.14]% and [5.53, 6.46]% more OPS,
>    respectively, for exponential access, random access and Zipfian
>    access, when overcommitting memory.
>=20
> On 5.15:
> 5. Apache Cassandra [06] achieved 95% CIs [1.06, 4.10]%, [1.94, 5.43]%
>    and [4.11, 7.50]% more operations per second (OPS), respectively,
>    for exponential (distribution) access, random access and Zipfian
>    (distribution) access, when swap was off; 95% CIs [0.50, 2.60]%,
>    [6.51, 8.77]% and [3.29, 6.75]% more OPS, respectively, for
>    exponential access, random access and Zipfian access, when swap was
>    on.
> 6. Apache Hadoop [07] took 95% CIs [5.31, 9.69]% and [2.02, 7.86]%
>    less average wall time to finish twelve parallel TeraSort jobs,
>    respectively, under the medium- and the high-concurrency
>    conditions, when swap was on. There were no statistically
>    significant changes in average wall time for the rest of the
>    benchmark matrix.
> 7. PostgreSQL [08] achieved 95% CI [1.75, 6.42]% more transactions per
>    minute (TPM) under the high-concurrency condition, when swap was
>    off; 95% CIs [12.82, 18.69]% and [22.70, 46.86]% more TPM,
>    respectively, under the medium- and the high-concurrency
>    conditions, when swap was on. There were no statistically
>    significant changes in TPM for the rest of the benchmark matrix.
> 8. Redis [09] achieved 95% CIs [0.58, 5.94]%, [6.55, 14.58]% and
>    [11.47, 19.36]% more total operations per second (OPS),
>    respectively, for sequential access, random access and Gaussian
>    (distribution) access, when THP=3Dalways; 95% CIs [1.27, 3.54]%,
>    [10.11, 14.81]% and [8.75, 13.64]% more total OPS, respectively,
>    for sequential access, random access and Gaussian access, when
>    THP=3Dnever.
>=20
> Our lab results
> ---------------
> To supplement the above results, we ran the following benchmark suites
> on 5.16-rc7 and found no regressions [10]. (These synthetic benchmarks
> are popular among MM developers, but we prefer large-scale A/B
> experiments to validate improvements.)
>       fs_fio_bench_hdd_mq      pft
>       fs_lmbench               pgsql-hammerdb
>       fs_parallelio            redis
>       fs_postmark              stream
>       hackbench                sysbenchthread
>       kernbench                tpcc_spark
>       memcached                unixbench
>       multichase               vm-scalability
>       mutilate                 will-it-scale
>       nginx
>=20
> [01] https://trends.google.com
> [02] https://lore.kernel.org/linux-mm/20211102002002.92051-1-bot@edi.work=
s/
> [03] https://lore.kernel.org/linux-mm/20211009054315.47073-1-bot@edi.work=
s/
> [04] https://lore.kernel.org/linux-mm/20211021194103.65648-1-bot@edi.work=
s/
> [05] https://lore.kernel.org/linux-mm/20211109021346.50266-1-bot@edi.work=
s/
> [06] https://lore.kernel.org/linux-mm/20211202062806.80365-1-bot@edi.work=
s/
> [07] https://lore.kernel.org/linux-mm/20211209072416.33606-1-bot@edi.work=
s/
> [08] https://lore.kernel.org/linux-mm/20211218071041.24077-1-bot@edi.work=
s/
> [09] https://lore.kernel.org/linux-mm/20211122053248.57311-1-bot@edi.work=
s/
> [10] https://lore.kernel.org/linux-mm/20220104202247.2903702-1-yuzhao@goo=
gle.com/
>=20
> Read-world applications
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Third-party testimonials
> ------------------------
> Konstantin wrote [11]:
>    I have Archlinux with 8G RAM + zswap + swap. While developing, I
>    have lots of apps opened such as multiple LSP-servers for different
>    langs, chats, two browsers, etc... Usually, my system gets quickly
>    to a point of SWAP-storms, where I have to kill LSP-servers,
>    restart browsers to free memory, etc, otherwise the system lags
>    heavily and is barely usable.
>   =20
>    1.5 day ago I migrated from 5.11.15 kernel to 5.12 + the LRU
>    patchset, and I started up by opening lots of apps to create memory
>    pressure, and worked for a day like this. Till now I had *not a
>    single SWAP-storm*, and mind you I got 3.4G in SWAP. I was never
>    getting to the point of 3G in SWAP before without a single
>    SWAP-storm.
>=20
> The Arch Linux Zen kernel [12] has been using MGLRU since 5.12. Many
> of its users reported their positive experiences to me, e.g., Shivodit
> wrote:
>    I've tried the latest Zen kernel (5.14.13-zen1-1-zen in the
>    archlinux testing repos), everything's been smooth so far. I also
>    decided to copy a large volume of files to check performance under
>    I/O load, and everything went smoothly - no stuttering was present,
>    everything was responsive.
>=20
> Large-scale deployments
> -----------------------
> We've rolled out MGLRU to tens of millions of Chrome OS users and
> about a million Android users. Google's fleetwide profiling [13] shows
> an overall 40% decrease in kswapd CPU usage, in addition to
> improvements in other UX metrics, e.g., an 85% decrease in the number
> of low-memory kills at the 75th percentile and an 18% decrease in
> rendering latency at the 50th percentile.
>=20
> [11] https://lore.kernel.org/linux-mm/140226722f2032c86301fbd326d91baefe3=
d7d23.camel@yandex.ru/
> [12] https://github.com/zen-kernel/zen-kernel/
> [13] https://research.google/pubs/pub44271/
>=20
> Summery
> =3D=3D=3D=3D=3D=3D=3D
> The facts are:
> 1. The independent lab results and the real-world applications
>    indicate substantial improvements; there are no known regressions.
> 2. Thrashing prevention, working set estimation and proactive reclaim
>    work out of the box; there are no equivalent solutions.
> 3. There is a lot of new code; nobody has demonstrated smaller changes
>    with similar effects.
>=20
> Our options, accordingly, are:
> 1. Given the amount of evidence, the reported improvements will likely
>    materialize for a wide range of workloads.
> 2. Gauging the interest from the past discussions [14][15][16], the
>    new features will likely be put to use for both personal computers
>    and data centers.
> 3. Based on Google's track record, the new code will likely be well
>    maintained in the long term. It'd be more difficult if not
>    impossible to achieve similar effects on top of the existing
>    design.
>=20
> [14] https://lore.kernel.org/lkml/20201005081313.732745-1-andrea.righi@ca=
nonical.com/
> [15] https://lore.kernel.org/lkml/20210716081449.22187-1-sj38.park@gmail.=
com/
> [16] https://lore.kernel.org/lkml/20211130201652.2218636d@mail.inbox.lv/
>=20
> Yu Zhao (9):
>   mm: x86, arm64: add arch_has_hw_pte_young()
>   mm: x86: add CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG
>   mm/vmscan.c: refactor shrink_node()
>   mm: multigenerational lru: groundwork
>   mm: multigenerational lru: mm_struct list
>   mm: multigenerational lru: aging
>   mm: multigenerational lru: eviction
>   mm: multigenerational lru: user interface
>   mm: multigenerational lru: Kconfig
>=20
>  Documentation/vm/index.rst          |    1 +
>  Documentation/vm/multigen_lru.rst   |   80 +
>  arch/Kconfig                        |    9 +
>  arch/arm64/include/asm/cpufeature.h |    5 +
>  arch/arm64/include/asm/pgtable.h    |   13 +-
>  arch/arm64/kernel/cpufeature.c      |   19 +
>  arch/arm64/tools/cpucaps            |    1 +
>  arch/x86/Kconfig                    |    1 +
>  arch/x86/include/asm/pgtable.h      |    9 +-
>  arch/x86/mm/pgtable.c               |    5 +-
>  fs/exec.c                           |    2 +
>  fs/fuse/dev.c                       |    3 +-
>  include/linux/cgroup.h              |   15 +-
>  include/linux/memcontrol.h          |   11 +
>  include/linux/mm.h                  |   42 +
>  include/linux/mm_inline.h           |  204 ++
>  include/linux/mm_types.h            |   78 +
>  include/linux/mmzone.h              |  175 ++
>  include/linux/nodemask.h            |    1 +
>  include/linux/oom.h                 |   16 +
>  include/linux/page-flags-layout.h   |   19 +-
>  include/linux/page-flags.h          |    4 +-
>  include/linux/pgtable.h             |   17 +-
>  include/linux/sched.h               |    4 +
>  include/linux/swap.h                |    4 +
>  kernel/bounds.c                     |    3 +
>  kernel/cgroup/cgroup-internal.h     |    1 -
>  kernel/exit.c                       |    1 +
>  kernel/fork.c                       |    9 +
>  kernel/sched/core.c                 |    1 +
>  mm/Kconfig                          |   48 +
>  mm/huge_memory.c                    |    3 +-
>  mm/memcontrol.c                     |   26 +
>  mm/memory.c                         |   21 +-
>  mm/mm_init.c                        |    6 +-
>  mm/oom_kill.c                       |    4 +-
>  mm/page_alloc.c                     |    1 +
>  mm/rmap.c                           |    7 +
>  mm/swap.c                           |   51 +-
>  mm/vmscan.c                         | 2691 ++++++++++++++++++++++++++-
>  mm/workingset.c                     |  119 +-
>  41 files changed, 3591 insertions(+), 139 deletions(-)
>  create mode 100644 Documentation/vm/multigen_lru.rst

=46or the series:

Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>

I run this (and one of the previous spins) on nine machines (physical, virt=
ual, workstations, servers) for quite some time with no hassle.

Thanks for your job, and please keep me in Cc once you post new spins. I'm =
more than happy to deploy those across the fleet.

=2D-=20
Oleksandr Natalenko (post-factum)



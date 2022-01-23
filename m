Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53A8249700B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 06:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235590AbiAWFnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 00:43:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiAWFnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 00:43:20 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D93C06173B;
        Sat, 22 Jan 2022 21:43:19 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id s5so12015792ejx.2;
        Sat, 22 Jan 2022 21:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AMDhKW3ApHJL/q2r9OoS50UHP/i8+q92jOgGPkHjrNs=;
        b=Y7O7bKAqHJiChLVFx6jilcPoh3XrvmsywFg1VhFP8xe2lrP0ObHR28GzOEZhzS4JQx
         pRnXsiRKcHpVH/YcTMdM4YxkKwXOKOzJhKCtKOXIwJLCsuNf9ooXUGBOyh8RWVvDAGCv
         XAAg8VITzY1VKFkFILNtYcIpdvx0a5z4b1sW0Ta+JgO7t84bHJnP/2mfxQuwTPme2wKW
         ZVu06cCzDzBmJ4BQ6mp9e30mNCTo8T+sq2WiScuNl3WSPJ3BFEKfltWdRrgwkElh2Kq1
         x9o7jmvPo1VNu9Nk/9jbrOZStotjLdDD34jYuYAzionPEPq6W8WgtuY0t2MjbkXKgEn3
         4KgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AMDhKW3ApHJL/q2r9OoS50UHP/i8+q92jOgGPkHjrNs=;
        b=iVQy6cRsZJzO5dIvmmAbRi8+JqMDMIhCm3Fwe3PsH1NMMlOGM2Qg78HAgmtuUUsMgj
         Wq/7r3fCAdcVzzslWcPGQQxA9Evh8DuhsENNatbtPpOOT7fO5qcWhoaeQguYFfUx1WRd
         A5hoqBLFEXOjFvbUL7bwfE3GUPU464sRgLZyvRfNgWRurHtqv8z+rWovx0HWIXgAcbpD
         bWeTMTPbFtfb6LA9jPKI9wVErPLcE0uDlFGcQmJVDfEK54Ptg43pidHGl/XGByyt2SmF
         alv3+cc8rHl4cLsSttPeu4QdCY3HIGcrg/OMicQPBMPnMDbmXxOw0cRNLCgHOv1c/Xtd
         P1TQ==
X-Gm-Message-State: AOAM532KGJTN9gu0dIaU23uir+rdXThGAbJq2ZLWehVvz1Ndzp/mC3hf
        U1BGyFmBERyTp1OrVK2lN8FsyljtJgaqKorPdiGTyICPJ1o=
X-Google-Smtp-Source: ABdhPJx1k0OBC0idLKykwHEkoDF03/+G5sK9HJ59UHZHcIRx7Tb4ZuMp6lXMTeHDFDJJDNR10R9xzpePOAN8wxemKEk=
X-Received: by 2002:a17:906:90c3:: with SMTP id v3mr8395360ejw.170.1642916598098;
 Sat, 22 Jan 2022 21:43:18 -0800 (PST)
MIME-Version: 1.0
References: <20220104202227.2903605-1-yuzhao@google.com>
In-Reply-To: <20220104202227.2903605-1-yuzhao@google.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Sun, 23 Jan 2022 18:43:06 +1300
Message-ID: <CAGsJ_4zULJ5vPwn73Z5Bap3eRkAX+Yv24c-n41+zC7fN8xG60g@mail.gmail.com>
Subject: Re: [PATCH v6 0/9] Multigenerational LRU Framework
To:     Yu Zhao <yuzhao@google.com>
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
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, page-reclaim@google.com,
        x86 <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 5, 2022 at 7:17 PM Yu Zhao <yuzhao@google.com> wrote:
>
> TLDR
> ====
> The current page reclaim is too expensive in terms of CPU usage and it
> often makes poor choices about what to evict. This patchset offers an
> alternative solution that is performant, versatile and
> straightforward.
>
> Design objectives
> =================
> The design objectives are:
> 1. Better representation of access recency
> 2. Try to profit from spatial locality
> 3. Clear fast path making obvious choices
> 4. Simple self-correcting heuristics
>
> The representation of access recency is at the core of all LRU
> approximations. The multigenerational LRU (MGLRU) divides pages into
> multiple lists (generations), each having bounded access recency (a
> time interval). Generations establish a common frame of reference and
> help make better choices, e.g., between different memcgs on a computer
> or different computers in a data center (for cluster job scheduling).
>
> Exploiting spatial locality improves the efficiency when gathering the
> accessed bit. A rmap walk targets a single page and doesn't try to
> profit from discovering an accessed PTE. A page table walk can sweep
> all hotspots in an address space, but its search space can be too
> large to make a profit. The key is to optimize both methods and use
> them in combination. (PMU is another option for further exploration.)
>
> Fast path reduces code complexity and runtime overhead. Unmapped pages
> don't require TLB flushes; clean pages don't require writeback. These
> facts are only helpful when other conditions, e.g., access recency,
> are similar. With generations as a common frame of reference,
> additional factors stand out. But obvious choices might not be good
> choices; thus self-correction is required (the next objective).
>
> The benefits of simple self-correcting heuristics are self-evident.
> Again with generations as a common frame of reference, this becomes
> attainable. Specifically, pages in the same generation are categorized
> based on additional factors, and a closed-loop control statistically
> compares the refault percentages across all categories and throttles
> the eviction of those that have higher percentages.
>
> Patchset overview
> =================
> 1. mm: x86, arm64: add arch_has_hw_pte_young()
> 2. mm: x86: add CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG
> Materializing hardware optimizations when trying to clear the accessed
> bit in many PTEs. If hardware automatically sets the accessed bit in
> PTEs, there is no need to worry about bursty page faults (emulating
> the accessed bit). If it also sets the accessed bit in non-leaf PMD
> entries, there is no need to search the PTE table pointed to by a PMD
> entry that doesn't have the accessed bit set.
>
> 3. mm/vmscan.c: refactor shrink_node()
> A minor refactor.
>
> 4. mm: multigenerational lru: groundwork
> Adding the basic data structure and the functions to initialize it and
> insert/remove pages.
>
> 5. mm: multigenerational lru: mm_struct list
> An infra keeps track of mm_struct's for page table walkers and
> provides them with optimizations, i.e., switch_mm() tracking and Bloom
> filters.
>
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
>
> 8. mm: multigenerational lru: user interface
> The knobs to turn on/off MGLRU and provide the userspace with
> thrashing prevention, working set estimation (the aging) and proactive
> reclaim (the eviction).
>
> 9. mm: multigenerational lru: Kconfig
> The Kconfig options.
>
> Benchmark results
> =================
> Independent lab results
> -----------------------
> Based on the popularity of searches [01] and the memory usage in
> Google's public cloud, the most popular open-source memory-hungry
> applications, in alphabetical order, are:
>       Apache Cassandra      Memcached
>       Apache Hadoop         MongoDB
>       Apache Spark          PostgreSQL
>       MariaDB (MySQL)       Redis
>
> An independent lab evaluated MGLRU with the most widely used benchmark
> suites for the above applications. They posted 960 data points along
> with kernel metrics and perf profiles collected over more than 500
> hours of total benchmark time. Their final reports show that, with 95%
> confidence intervals (CIs), the above applications all performed
> significantly better for at least part of their benchmark matrices.
>
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
>    access, when THP=always; 95% CIs [13.85, 15.97]% and
>    [23.94, 29.92]% more OPS, respectively, for random access and
>    Gaussian access, when THP=never. There were no statistically
>    significant changes in OPS for the rest of the benchmark matrix.
> 4. MongoDB [05] achieved 95% CIs [2.23, 3.44]%, [6.97, 9.73]% and
>    [2.16, 3.55]% more operations per second (OPS), respectively, for
>    exponential (distribution) access, random access and Zipfian
>    (distribution) access, when underutilizing memory; 95% CIs
>    [8.83, 10.03]%, [21.12, 23.14]% and [5.53, 6.46]% more OPS,
>    respectively, for exponential access, random access and Zipfian
>    access, when overcommitting memory.
>
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
>    (distribution) access, when THP=always; 95% CIs [1.27, 3.54]%,
>    [10.11, 14.81]% and [8.75, 13.64]% more total OPS, respectively,
>    for sequential access, random access and Gaussian access, when
>    THP=never.
>
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
>
> [01] https://trends.google.com
> [02] https://lore.kernel.org/linux-mm/20211102002002.92051-1-bot@edi.works/
> [03] https://lore.kernel.org/linux-mm/20211009054315.47073-1-bot@edi.works/
> [04] https://lore.kernel.org/linux-mm/20211021194103.65648-1-bot@edi.works/
> [05] https://lore.kernel.org/linux-mm/20211109021346.50266-1-bot@edi.works/
> [06] https://lore.kernel.org/linux-mm/20211202062806.80365-1-bot@edi.works/
> [07] https://lore.kernel.org/linux-mm/20211209072416.33606-1-bot@edi.works/
> [08] https://lore.kernel.org/linux-mm/20211218071041.24077-1-bot@edi.works/
> [09] https://lore.kernel.org/linux-mm/20211122053248.57311-1-bot@edi.works/
> [10] https://lore.kernel.org/linux-mm/20220104202247.2903702-1-yuzhao@google.com/
>
> Read-world applications
> =======================
> Third-party testimonials
> ------------------------
> Konstantin wrote [11]:
>    I have Archlinux with 8G RAM + zswap + swap. While developing, I
>    have lots of apps opened such as multiple LSP-servers for different
>    langs, chats, two browsers, etc... Usually, my system gets quickly
>    to a point of SWAP-storms, where I have to kill LSP-servers,
>    restart browsers to free memory, etc, otherwise the system lags
>    heavily and is barely usable.
>
>    1.5 day ago I migrated from 5.11.15 kernel to 5.12 + the LRU
>    patchset, and I started up by opening lots of apps to create memory
>    pressure, and worked for a day like this. Till now I had *not a
>    single SWAP-storm*, and mind you I got 3.4G in SWAP. I was never
>    getting to the point of 3G in SWAP before without a single
>    SWAP-storm.
>
> The Arch Linux Zen kernel [12] has been using MGLRU since 5.12. Many
> of its users reported their positive experiences to me, e.g., Shivodit
> wrote:
>    I've tried the latest Zen kernel (5.14.13-zen1-1-zen in the
>    archlinux testing repos), everything's been smooth so far. I also
>    decided to copy a large volume of files to check performance under
>    I/O load, and everything went smoothly - no stuttering was present,
>    everything was responsive.
>
> Large-scale deployments
> -----------------------
> We've rolled out MGLRU to tens of millions of Chrome OS users and
> about a million Android users. Google's fleetwide profiling [13] shows
> an overall 40% decrease in kswapd CPU usage, in addition to

Hi Yu,

Was the overall 40% decrease of kswap CPU usgae seen on x86 or arm64?
And I am curious how much we are taking advantage of NONLEAF_PMD_YOUNG.
Does it help a lot in decreasing the cpu usage? If so, this might be
a good proof that arm64 also needs this hardware feature?
In short, I am curious how much the improvement in this patchset depends
on the hardware ability of NONLEAF_PMD_YOUNG.

> improvements in other UX metrics, e.g., an 85% decrease in the number
> of low-memory kills at the 75th percentile and an 18% decrease in
> rendering latency at the 50th percentile.
>
> [11] https://lore.kernel.org/linux-mm/140226722f2032c86301fbd326d91baefe3d7d23.camel@yandex.ru/
> [12] https://github.com/zen-kernel/zen-kernel/
> [13] https://research.google/pubs/pub44271/
>

Thanks
Barry

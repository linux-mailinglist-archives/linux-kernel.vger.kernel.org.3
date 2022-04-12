Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA6C4FCC68
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 04:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245573AbiDLCTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 22:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245082AbiDLCTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 22:19:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF4133A32;
        Mon, 11 Apr 2022 19:16:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 97F4DB819D2;
        Tue, 12 Apr 2022 02:16:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D21BAC385A9;
        Tue, 12 Apr 2022 02:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1649729802;
        bh=j4nDoclra0JFAEUEIETf2SOfl1pwCRYwYtXUA65m3do=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oeAfw7siviRDmVDt+CA9seaEgrcPHd5qlHUmfk9VnBVk47APBRHhjxO0OMo21sIaJ
         zuQjBTyziAce8qom+u83ZtbVc3qH7NZGwlcQbXEp4ELFWnLGmqdd/oLJt4P43TflOo
         8rUyTrqxAV5g7oxzjvj77l0MBEUw37Yy/R+H4DUk=
Date:   Mon, 11 Apr 2022 19:16:39 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Stephen Rothwell <sfr@rothwell.id.au>, linux-mm@kvack.org,
        Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Barry Song <21cnbao@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, page-reclaim@google.com,
        x86@kernel.org, Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Donald Carr <d@chaos-reins.com>,
        =?ISO-8859-1?Q? "Holger_Hoffst=E4tte" ?= 
        <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>,
        Vaibhav Jain <vaibhav@linux.ibm.com>
Subject: Re: [PATCH v10 13/14] mm: multi-gen LRU: admin guide
Message-Id: <20220411191639.52c62959489a6c27cb7d251e@linux-foundation.org>
In-Reply-To: <20220407031525.2368067-14-yuzhao@google.com>
References: <20220407031525.2368067-1-yuzhao@google.com>
        <20220407031525.2368067-14-yuzhao@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  6 Apr 2022 21:15:25 -0600 Yu Zhao <yuzhao@google.com> wrote:

> Add an admin guide.
> 
>
> ...
>
> --- /dev/null
> +++ b/Documentation/admin-guide/mm/multigen_lru.rst
> @@ -0,0 +1,152 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=============
> +Multi-Gen LRU
> +=============
> +The multi-gen LRU is an alternative LRU implementation that optimizes
> +page reclaim and improves performance under memory pressure. Page
> +reclaim decides the kernel's caching policy and ability to overcommit
> +memory. It directly impacts the kswapd CPU usage and RAM efficiency.
> +
> +Quick start
> +===========
> +Build the kernel with the following configurations.
> +
> +* ``CONFIG_LRU_GEN=y``
> +* ``CONFIG_LRU_GEN_ENABLED=y``
> +
> +All set!
> +
> +Runtime options
> +===============
> +``/sys/kernel/mm/lru_gen/`` contains stable ABIs described in the
> +following subsections.
> +
> +Kill switch
> +-----------
> +``enable`` accepts different values to enable or disable the following

It's actually called "enabled".  And I suggest that the file name be
included right there in the title.  ie.

"enabled": Kill Switch
======================

> +components. Its default value depends on ``CONFIG_LRU_GEN_ENABLED``.
> +All the components should be enabled unless some of them have
> +unforeseen side effects. Writing to ``enable`` has no effect when a
> +component is not supported by the hardware, and valid values will be
> +accepted even when the main switch is off.
> +
> +====== ===============================================================
> +Values Components
> +====== ===============================================================
> +0x0001 The main switch for the multi-gen LRU.
> +0x0002 Clearing the accessed bit in leaf page table entries in large
> +       batches, when MMU sets it (e.g., on x86). This behavior can
> +       theoretically worsen lock contention (mmap_lock). If it is
> +       disabled, the multi-gen LRU will suffer a minor performance
> +       degradation.
> +0x0004 Clearing the accessed bit in non-leaf page table entries as
> +       well, when MMU sets it (e.g., on x86). This behavior was not
> +       verified on x86 varieties other than Intel and AMD. If it is
> +       disabled, the multi-gen LRU will suffer a negligible
> +       performance degradation.
> +[yYnN] Apply to all the components above.
> +====== ===============================================================
> +
> +E.g.,
> +::
> +
> +    echo y >/sys/kernel/mm/lru_gen/enabled
> +    cat /sys/kernel/mm/lru_gen/enabled
> +    0x0007
> +    echo 5 >/sys/kernel/mm/lru_gen/enabled
> +    cat /sys/kernel/mm/lru_gen/enabled
> +    0x0005
> +
> +Thrashing prevention
> +--------------------
> +Personal computers are more sensitive to thrashing because it can
> +cause janks (lags when rendering UI) and negatively impact user
> +experience. The multi-gen LRU offers thrashing prevention to the
> +majority of laptop and desktop users who do not have ``oomd``.
> +
> +Users can write ``N`` to ``min_ttl_ms`` to prevent the working set of
> +``N`` milliseconds from getting evicted. The OOM killer is triggered
> +if this working set cannot be kept in memory. In other words, this
> +option works as an adjustable pressure relief valve, and when open, it
> +terminates applications that are hopefully not being used.
> +
> +Based on the average human detectable lag (~100ms), ``N=1000`` usually
> +eliminates intolerable janks due to thrashing. Larger values like
> +``N=3000`` make janks less noticeable at the risk of premature OOM
> +kills.

This is a quite useful user guide.

> +The default value ``0`` means disabled.
> +
> +Experimental features
> +=====================
> +``/sys/kernel/debug/lru_gen`` accepts commands described in the
> +following subsections. Multiple command lines are supported, so does
> +concatenation with delimiters ``,`` and ``;``.
> +
> +``/sys/kernel/debug/lru_gen_full`` provides additional stats for
> +debugging. ``CONFIG_LRU_GEN_STATS=y`` keeps historical stats from
> +evicted generations in this file.
> +
> +Working set estimation
> +----------------------
> +Working set estimation measures how much memory an application
> +requires in a given time interval, and it is usually done with little
> +impact on the performance of the application. E.g., data centers want
> +to optimize job scheduling (bin packing) to improve memory
> +utilizations. When a new job comes in, the job scheduler needs to find
> +out whether each server it manages can allocate a certain amount of
> +memory for this new job before it can pick a candidate. To do so, this
> +job scheduler needs to estimate the working sets of the existing jobs.

These various sysfs interfaces are a big deal.  Because they are so
hard to change once released.

So I think it would be good to present them to reviewers in a more
detailed fashion.  In the changelog for the patch which adds the
interface, provide full sample output and a description of all the
fields which are shown.

> +When it is read, ``lru_gen`` returns a histogram of numbers of pages
> +accessed over different time intervals for each memcg and node.
> +``MAX_NR_GENS`` decides the number of bins for each histogram.
> +::
> +
> +    memcg  memcg_id  memcg_path
> +       node  node_id
> +           min_gen_nr  age_in_ms  nr_anon_pages  nr_file_pages
> +           ...
> +           max_gen_nr  age_in_ms  nr_anon_pages  nr_file_pages
> +
> +Each generation contains an estimated number of pages that have been
> +accessed within ``age_in_ms`` non-cumulatively. E.g., ``min_gen_nr``
> +contains the coldest pages and ``max_gen_nr`` contains the hottest
> +pages, since ``age_in_ms`` of the former is the largest and that of
> +the latter is the smallest.
> +
> +Users can write ``+ memcg_id node_id max_gen_nr
> +[can_swap[full_scan]]`` to ``lru_gen`` to create a new generation
> +``max_gen_nr+1``. ``can_swap`` defaults to the swap setting and, if it
> +is set to ``1``, it forces the scan of anon pages when swap is off.
> +``full_scan`` defaults to ``1`` and, if it is set to ``0``, it reduces
> +the overhead as well as the coverage when scanning page tables.
> +
> +A typical use case is that a job scheduler writes to ``lru_gen`` at a
> +certain time interval to create new generations, and it ranks the
> +servers it manages based on the sizes of their cold memory defined by
> +this time interval.

Are you really confident that this interface will be in this same exact
form 10 years from now?  That we will never have cause to change,
extend or remove it?

If "no" then perhaps we shouldn't add it.

btw, what is this "job scheduler" of which you speak?  Is there an open
source implementation upon which we hope the world will converge?

> +Proactive reclaim
> +-----------------
> +Proactive reclaim induces memory reclaim when there is no memory
> +pressure and usually targets cold memory only. E.g., when a new job
> +comes in, the job scheduler wants to proactively reclaim memory on the
> +server it has selected to improve the chance of successfully landing
> +this new job.
> +
> +Users can write ``- memcg_id node_id min_gen_nr [swappiness
> +[nr_to_reclaim]]`` to ``lru_gen`` to evict generations less than or
> +equal to ``min_gen_nr``. Note that ``min_gen_nr`` should be less than
> +``max_gen_nr-1`` as ``max_gen_nr`` and ``max_gen_nr-1`` are not fully
> +aged and therefore cannot be evicted. ``swappiness`` overrides the
> +default value in ``/proc/sys/vm/swappiness``. ``nr_to_reclaim`` limits
> +the number of pages to evict.
> +
> +A typical use case is that a job scheduler writes to ``lru_gen``
> +before it tries to land a new job on a server, and if it fails to
> +materialize the cold memory without impacting the existing jobs on
> +this server, it retries on the next server according to the ranking
> +result obtained from the working set estimation step described
> +earlier.

It sounds to me that these interfaces were developed in response to
ongoing development and use of a particular job scheduler.

This is a very good thing, but has thought been given to the potential
needs of other job schedulers?


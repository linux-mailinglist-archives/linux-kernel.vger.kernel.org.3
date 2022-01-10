Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C361489651
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 11:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243899AbiAJK1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 05:27:38 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:58122 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239431AbiAJK1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 05:27:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 52D64B815C5;
        Mon, 10 Jan 2022 10:27:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 541D5C36AED;
        Mon, 10 Jan 2022 10:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641810452;
        bh=4V2mYGkQ8sFMZ8Ms+z7I9NjIX4+82SQALjd6W6fYZts=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cHNKEyB9tcUPrzemQRBHz069uyhkjAFVYPdksL3Anc/mYN7WJchOI+ps98TOPFfTp
         BVksVUHULFtCoiuMbkUlIPsrvCKOQHVdVLRUNm32BSJ8CTBOZY8FZC07NWH80V9IGW
         fi3V35AW0eCY9RPwDdYXR8NPJBbUG4rrW7JfgL5l16rSK5qfwBoeXSYNyqaQQj9C/p
         3cr510HKsdhck4g5Mwk7xzffUsX/IE67SovZmZJFMBWGYfzjkuYEND0OlsFzsQorid
         WAT1qIKdFL+Mt6A62D/tDfJLHzqCaJbJ6CxdsNLI1IiMVaR+po0GJh1N/Tgo8tgO2G
         xvJJZ0PzFLrqA==
Date:   Mon, 10 Jan 2022 12:27:19 +0200
From:   Mike Rapoport <rppt@kernel.org>
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
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        page-reclaim@google.com, x86@kernel.org,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>
Subject: Re: [PATCH v6 8/9] mm: multigenerational lru: user interface
Message-ID: <YdwKB3SfF7hkB9Xv@kernel.org>
References: <20220104202227.2903605-1-yuzhao@google.com>
 <20220104202227.2903605-9-yuzhao@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220104202227.2903605-9-yuzhao@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jan 04, 2022 at 01:22:27PM -0700, Yu Zhao wrote:
> Add /sys/kernel/mm/lru_gen/enabled as a runtime kill switch.
> 
> Add /sys/kernel/mm/lru_gen/min_ttl_ms for thrashing prevention.
> Compared with the size-based approach, e.g., [1], this time-based
> approach has the following advantages:
> 1) It's easier to configure because it's agnostic to applications and
>    memory sizes.
> 2) It's more reliable because it's directly wired to the OOM killer.
> 
> Add /sys/kernel/debug/lru_gen for working set estimation and proactive
> reclaim. Compared with the page table-based approach and the PFN-based
> approach, e.g., mm/damon/[vp]addr.c, this lruvec-based approach has
> the following advantages:
> 1) It offers better choices because it's aware of memcgs, NUMA nodes,
>    shared mappings and unmapped page cache.
> 2) It's more scalable because it's O(nr_hot_evictable_pages), whereas
>    the PFN-based approach is O(nr_total_pages).
> 
> Add /sys/kernel/debug/lru_gen_full for debugging.
> 
> [1] https://lore.kernel.org/lkml/20211130201652.2218636d@mail.inbox.lv/
> 
> Signed-off-by: Yu Zhao <yuzhao@google.com>
> Tested-by: Konstantin Kharlamov <Hi-Angel@yandex.ru>
> ---
>  Documentation/vm/index.rst        |   1 +
>  Documentation/vm/multigen_lru.rst |  62 +++++

The description of user visible interfaces should go to
Documentation/admin-guide/mm

Documentation/vm/multigen_lru.rst should have contained design description
and the implementation details and it would be great to actually have such
document.

>  include/linux/nodemask.h          |   1 +
>  mm/vmscan.c                       | 415 ++++++++++++++++++++++++++++++
>  4 files changed, 479 insertions(+)
>  create mode 100644 Documentation/vm/multigen_lru.rst
> 
> diff --git a/Documentation/vm/index.rst b/Documentation/vm/index.rst
> index 6f5ffef4b716..f25e755b4ff4 100644
> --- a/Documentation/vm/index.rst
> +++ b/Documentation/vm/index.rst
> @@ -38,3 +38,4 @@ algorithms.  If you are looking for advice on simply allocating memory, see the
>     unevictable-lru
>     z3fold
>     zsmalloc
> +   multigen_lru
> diff --git a/Documentation/vm/multigen_lru.rst b/Documentation/vm/multigen_lru.rst
> new file mode 100644
> index 000000000000..6f9e0181348b
> --- /dev/null
> +++ b/Documentation/vm/multigen_lru.rst
> @@ -0,0 +1,62 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=====================
> +Multigenerational LRU
> +=====================
> +
> +Quick start
> +===========
> +Runtime configurations
> +----------------------
> +:Required: Write ``1`` to ``/sys/kernel/mm/lru_gen/enable`` if the
> + feature wasn't enabled by default.

Required for what? This sentence seem to lack context. Maybe add an
overview what is Multigenerational LRU so that users will have an idea what
these knobs control.

> +
> +Recipes
> +=======

Some more context here will be also helpful.

> +Personal computers
> +------------------
> +:Thrashing prevention: Write ``N`` to
> + ``/sys/kernel/mm/lru_gen/min_ttl_ms`` to prevent the working set of
> + ``N`` milliseconds from getting evicted. The OOM killer is invoked if
> + this working set can't be kept in memory. Based on the average human
> + detectable lag (~100ms), ``N=1000`` usually eliminates intolerable
> + lags due to thrashing. Larger values like ``N=3000`` make lags less
> + noticeable at the cost of more OOM kills.
> +
> +Data centers
> +------------
> +:Debugfs interface: ``/sys/kernel/debug/lru_gen`` has the following
> + format:
> + ::
> +
> +   memcg  memcg_id  memcg_path
> +     node  node_id
> +       min_gen  birth_time  anon_size  file_size
> +       ...
> +       max_gen  birth_time  anon_size  file_size
> +
> + ``min_gen`` is the oldest generation number and ``max_gen`` is the
> + youngest generation number. ``birth_time`` is in milliseconds.
> + ``anon_size`` and ``file_size`` are in pages.

And what does oldest and youngest generations mean from the user
perspective?

> +
> + This file also accepts commands in the following subsections.
> + Multiple command lines are supported, so does concatenation with
> + delimiters ``,`` and ``;``.
> +
> + ``/sys/kernel/debug/lru_gen_full`` contains additional stats for
> + debugging.
> +
> +:Working set estimation: Write ``+ memcg_id node_id max_gen
> + [can_swap [full_scan]]`` to ``/sys/kernel/debug/lru_gen`` to trigger
> + the aging. It scans PTEs for accessed pages and promotes them to the
> + youngest generation ``max_gen``. Then it creates a new generation
> + ``max_gen+1``. Set ``can_swap`` to 1 to scan for accessed anon pages
> + when swap is off. Set ``full_scan`` to 0 to reduce the overhead as
> + well as the coverage when scanning PTEs.
> +
> +:Proactive reclaim: Write ``- memcg_id node_id min_gen [swappiness
> + [nr_to_reclaim]]`` to ``/sys/kernel/debug/lru_gen`` to trigger the
> + eviction. It evicts generations less than or equal to ``min_gen``.
> + ``min_gen`` should be less than ``max_gen-1`` as ``max_gen`` and
> + ``max_gen-1`` aren't fully aged and therefore can't be evicted. Use
> + ``nr_to_reclaim`` to limit the number of pages to evict.

...

-- 
Sincerely yours,
Mike.

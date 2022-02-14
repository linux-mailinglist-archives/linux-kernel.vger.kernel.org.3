Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D234B4CFF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349690AbiBNLCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 06:02:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349450AbiBNLCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:02:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C6295A2F;
        Mon, 14 Feb 2022 02:29:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0BD4D61269;
        Mon, 14 Feb 2022 10:29:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4899C340F0;
        Mon, 14 Feb 2022 10:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644834554;
        bh=Yjpd9or3InM7O72Ha8qqhYu1AMkoWAkyJcyqk3l1uP4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SxSbArKoO6QRWCpB0gREzXBLyJR4iT+F7EzfyQBAGNysz5fYvadx8h2FFUXiHcCJ8
         OB0kC6nMrABepvcSdNnTyM862zaSF/W1p4BR3wT4S62Ff4EjYcND77yB11FmK7xMki
         TIuljUCm4+kzy6Z2y1zWg5hiVEVWZhYmSzcyG62WDnMuuwXA9RuNa5t3vJOxIugXA1
         90m0ly8lpfLhOWOSg8CZiWk1qgR3H6Fw5x3ZFEO2KVCxUb4/Tu8EdzDul1LAhSYfFb
         f1rt5ZXAiIKJsVxilDUMkv24PF4XPKq5S3IZcIJao/EJcKZqw+AKndJGOk9tXpEWWb
         1No+JyQqXdijQ==
Date:   Mon, 14 Feb 2022 12:28:56 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
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
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        page-reclaim@google.com, x86@kernel.org,
        Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Donald Carr <d@chaos-reins.com>,
        Holger =?iso-8859-1?Q?Hoffst=E4tte?= 
        <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>
Subject: Re: [PATCH v7 12/12] mm: multigenerational LRU: documentation
Message-ID: <Ygou6Gq79XY3mFK7@kernel.org>
References: <20220208081902.3550911-1-yuzhao@google.com>
 <20220208081902.3550911-13-yuzhao@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220208081902.3550911-13-yuzhao@google.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Feb 08, 2022 at 01:19:02AM -0700, Yu Zhao wrote:
> Add a design doc and an admin guide.
> 
> Signed-off-by: Yu Zhao <yuzhao@google.com>
> Acked-by: Brian Geffon <bgeffon@google.com>
> Acked-by: Jan Alexander Steffens (heftig) <heftig@archlinux.org>
> Acked-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> Acked-by: Steven Barrett <steven@liquorix.net>
> Acked-by: Suleiman Souhlal <suleiman@google.com>
> Tested-by: Daniel Byrne <djbyrne@mtu.edu>
> Tested-by: Donald Carr <d@chaos-reins.com>
> Tested-by: Holger Hoffstätte <holger@applied-asynchrony.com>
> Tested-by: Konstantin Kharlamov <Hi-Angel@yandex.ru>
> Tested-by: Shuang Zhai <szhai2@cs.rochester.edu>
> Tested-by: Sofia Trinh <sofia.trinh@edi.works>
> ---
>  Documentation/admin-guide/mm/index.rst        |   1 +
>  Documentation/admin-guide/mm/multigen_lru.rst | 121 ++++++++++++++
>  Documentation/vm/index.rst                    |   1 +
>  Documentation/vm/multigen_lru.rst             | 152 ++++++++++++++++++

Please consider splitting this patch into Documentation/admin-guide and
Documentation/vm parts.

For now I only had time to review the admin-guide part.

>  4 files changed, 275 insertions(+)
>  create mode 100644 Documentation/admin-guide/mm/multigen_lru.rst
>  create mode 100644 Documentation/vm/multigen_lru.rst
> 
> diff --git a/Documentation/admin-guide/mm/index.rst b/Documentation/admin-guide/mm/index.rst
> index c21b5823f126..2cf5bae62036 100644
> --- a/Documentation/admin-guide/mm/index.rst
> +++ b/Documentation/admin-guide/mm/index.rst
> @@ -32,6 +32,7 @@ the Linux memory management.
>     idle_page_tracking
>     ksm
>     memory-hotplug
> +   multigen_lru
>     nommu-mmap
>     numa_memory_policy
>     numaperf
> diff --git a/Documentation/admin-guide/mm/multigen_lru.rst b/Documentation/admin-guide/mm/multigen_lru.rst
> new file mode 100644
> index 000000000000..16a543c8b886
> --- /dev/null
> +++ b/Documentation/admin-guide/mm/multigen_lru.rst
> @@ -0,0 +1,121 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=====================
> +Multigenerational LRU
> +=====================
+
> +Quick start
> +===========

There is no explanation why one would want to use multigenerational LRU
until the next section.

I think there should be an overview that explains why users would want to
enable multigenerational LRU. 

> +Build configurations
> +--------------------
> +:Required: Set ``CONFIG_LRU_GEN=y``.

Maybe 

	Set ``CONFIG_LRU_GEN=y`` to build kernel with multigenerational LRU

> +
> +:Optional: Set ``CONFIG_LRU_GEN_ENABLED=y`` to enable the
> + multigenerational LRU by default.
> +
> +Runtime configurations
> +----------------------
> +:Required: Write ``y`` to ``/sys/kernel/mm/lru_gen/enable`` if
> + ``CONFIG_LRU_GEN_ENABLED=n``.
> +
> +This file accepts different values to enabled or disabled the
> +following features:

Maybe

  After multigenerational LRU is enabled, this file accepts different
  values to enable or disable the following feaures:

> +====== ========
> +Values Features
> +====== ========
> +0x0001 the multigenerational LRU

The multigenerational LRU what?

What will happen if I write 0x2 to this file?
Please consider splitting "enable" and "features" attributes.

> +0x0002 clear the accessed bit in leaf page table entries **in large
> +       batches**, when MMU sets it (e.g., on x86)

Is extra markup really needed here...

> +0x0004 clear the accessed bit in non-leaf page table entries **as
> +       well**, when MMU sets it (e.g., on x86)

... and here?

As for the descriptions, what is the user-visible effect of these features?
How different modes of clearing the access bit are reflected in, say, GUI
responsiveness, database TPS, or probability of OOM?

> +[yYnN] apply to all the features above
> +====== ========
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
> +Most users should enable or disable all the features unless some of
> +them have unforeseen side effects.
> +
> +Recipes
> +=======
> +Personal computers
> +------------------
> +Personal computers are more sensitive to thrashing because it can
> +cause janks (lags when rendering UI) and negatively impact user
> +experience. The multigenerational LRU offers thrashing prevention to
> +the majority of laptop and desktop users who don't have oomd.

I'd expect something like this paragraph in overview.

> +
> +:Thrashing prevention: Write ``N`` to
> + ``/sys/kernel/mm/lru_gen/min_ttl_ms`` to prevent the working set of
> + ``N`` milliseconds from getting evicted. The OOM killer is triggered
> + if this working set can't be kept in memory. Based on the average
> + human detectable lag (~100ms), ``N=1000`` usually eliminates
> + intolerable janks due to thrashing. Larger values like ``N=3000``
> + make janks less noticeable at the risk of premature OOM kills.

> +
> +Data centers
> +------------
> +Data centers want to optimize job scheduling (bin packing) to improve
> +memory utilizations. Job schedulers need to estimate whether a server
> +can allocate a certain amount of memory for a new job, and this step
> +is known as working set estimation, which doesn't impact the existing
> +jobs running on this server. They also want to attempt freeing some
> +cold memory from the existing jobs, and this step is known as proactive
> +reclaim, which improves the chance of landing a new job successfully.

This paragraph also fits overview.

> +
> +:Optional: Increase ``CONFIG_NR_LRU_GENS`` to support more generations
> + for working set estimation and proactive reclaim.

Please add a note that this is build time option.

> +
> +:Debugfs interface: ``/sys/kernel/debug/lru_gen`` has the following

Is debugfs interface relevant only for datacenters? 

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

It's unclear what is birth_time reference point. Is it milliseconds from
the system start or it is measured some other way?

> + ``anon_size`` and ``file_size`` are in pages. The youngest generation
> + represents the group of the MRU pages and the oldest generation
> + represents the group of the LRU pages. For working set estimation, a

Please spell out MRU and LRU fully.

> + job scheduler writes to this file at a certain time interval to
> + create new generations, and it ranks available servers based on the
> + sizes of their cold memory defined by this time interval. For
> + proactive reclaim, a job scheduler writes to this file before it
> + tries to land a new job, and if it fails to materialize the cold
> + memory without impacting the existing jobs, it retries on the next
> + server according to the ranking result.

Is this knob only relevant for a job scheduler? Or it can be used in other
use-cases as well?

> +
> + This file accepts commands in the following subsections. Multiple

                              ^ described

> + command lines are supported, so does concatenation with delimiters
> + ``,`` and ``;``.
> +
> + ``/sys/kernel/debug/lru_gen_full`` contains additional stats for
> + debugging.
> +
> +:Working set estimation: Write ``+ memcg_id node_id max_gen
> + [can_swap [full_scan]]`` to ``/sys/kernel/debug/lru_gen`` to invoke
> + the aging. It scans PTEs for hot pages and promotes them to the
> + youngest generation ``max_gen``. Then it creates a new generation
> + ``max_gen+1``. Set ``can_swap`` to ``1`` to scan for hot anon pages
> + when swap is off. Set ``full_scan`` to ``0`` to reduce the overhead
> + as well as the coverage when scanning PTEs.
> +
> +:Proactive reclaim: Write ``- memcg_id node_id min_gen [swappiness
> + [nr_to_reclaim]]`` to ``/sys/kernel/debug/lru_gen`` to invoke the
> + eviction. It evicts generations less than or equal to ``min_gen``.
> + ``min_gen`` should be less than ``max_gen-1`` as ``max_gen`` and
> + ``max_gen-1`` aren't fully aged and therefore can't be evicted. Use
> + ``nr_to_reclaim`` to limit the number of pages to evict.

I feel that /sys/kernel/debug/lru_gen is too overloaded.

> diff --git a/Documentation/vm/index.rst b/Documentation/vm/index.rst
> index 44365c4574a3..b48434300226 100644
> --- a/Documentation/vm/index.rst
> +++ b/Documentation/vm/index.rst
> @@ -25,6 +25,7 @@ algorithms.  If you are looking for advice on simply allocating memory, see the
>     ksm
>     memory-model
>     mmu_notifier
> +   multigen_lru
>     numa
>     overcommit-accounting
>     page_migration

-- 
Sincerely yours,
Mike.

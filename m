Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987784D46FF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 13:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242033AbiCJMbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 07:31:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235393AbiCJMbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 07:31:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC0F85657;
        Thu, 10 Mar 2022 04:30:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1431DB825E3;
        Thu, 10 Mar 2022 12:30:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67109C340E8;
        Thu, 10 Mar 2022 12:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646915404;
        bh=BMfXhQNWNRn/yzUdJMcXXLf95J2UZ0eeQUTcFVksuU4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rH1gIViIL+0z6FLcRyuMSAPplogfcfHI8e9WG3jGPGYP8vp5BHWM46PMxPBbCXL1u
         Nmj4h1U7waVPSPohwN+6fybEM9u4Zk46+H+hVX6lvlVv7BtX4xPEA41htyBcL8+j+i
         JFZ2iZVegBrcv0rV6MI74QT1leuTdNW9x1B99LNt8P55agpqROOjHpkw+XFKw9tcXe
         jKEpWV9DHq9Z28pfvVRv5OLnq3Ve0wh5RR/JA5qQLGiB+ygSmUB9vKyzr4vTEh0pUG
         XTI4lPqHRX7R29TNH5SeuzesbaO1lVcKjX96/kB+j6bzgMHbdmpdD3D1zRhpWNoni6
         tg4W5b9t9yMqA==
Date:   Thu, 10 Mar 2022 14:29:48 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
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
        Sofia Trinh <sofia.trinh@edi.works>,
        Vaibhav Jain <vaibhav@linux.ibm.com>
Subject: Re: [PATCH v9 13/14] mm: multi-gen LRU: admin guide
Message-ID: <YinvPMIP4oEwCo6T@kernel.org>
References: <20220309021230.721028-1-yuzhao@google.com>
 <20220309021230.721028-14-yuzhao@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220309021230.721028-14-yuzhao@google.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Mar 08, 2022 at 07:12:30PM -0700, Yu Zhao wrote:
> Add an admin guide.
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
> Tested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> ---
>  Documentation/admin-guide/mm/index.rst        |   1 +
>  Documentation/admin-guide/mm/multigen_lru.rst | 146 ++++++++++++++++++
>  mm/Kconfig                                    |   3 +-
>  3 files changed, 149 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/admin-guide/mm/multigen_lru.rst
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
> index 000000000000..4ea6a801dc56
> --- /dev/null
> +++ b/Documentation/admin-guide/mm/multigen_lru.rst
> @@ -0,0 +1,146 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=============
> +Multi-Gen LRU
> +=============

I'm still missing an opening paragraph the explains what is Multi-gen LRU
and why users would want it.

Something like 

  Multi-gen LRU is an efficient mechanism for page reclamation.

More details are of course welcome :)


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
> +``enable`` accepts different values to enable or disabled the

                                                   ^ disable

> +following components. The default value of this file depends on
> +``CONFIG_LRU_GEN_ENABLED``. All the components should be enabled
> +unless some of them have unforeseen side effects. Writing to
> +``enable`` has no effect when a component is not supported by the
> +hardware, and valid values will be accepted even when the main switch
> +is off.
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

What is the default value of min_ttl_ms?

> +
> +Experimental features
> +=====================

-- 
Sincerely yours,
Mike.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 824B94B17B2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 22:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344696AbiBJViL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 16:38:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240037AbiBJViK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 16:38:10 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED2BB80;
        Thu, 10 Feb 2022 13:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yiMGkSWaUlInyUsSv6Ymz5MFl5rNEExeyed6yGoVqQo=; b=UIBM663WVp45nBpTuklKQYIaOO
        qIqrGLpntoMuj+w0Zjrsb/3bZRZJHEEBxo01/e5j3RYuA16k+JKr4fXCfwg+B99MF5J+1bLJ+Jxsb
        3k8e1hjG5sxhZ9+FHYVTUSLLfp6CtesC8oHLlIKQvubiwHmjfQp10vYPT10He77uRiHG23oMbvVaT
        hbtgH4yrj9vzhechikN/jUpAujlWHmSBPuF4DwpgNoDDB+kk0W8w+9iAabVzgoCun/4jStR/hmaq+
        FafNBU3pb8iFAL7unJt95dvc82gwXZa10B2otIddSZzFA2j7wS3Y6c4RwzGAGaj0raGgYGzcSGNPG
        hk7iEN6w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nIH81-009n2P-Of; Thu, 10 Feb 2022 21:37:25 +0000
Date:   Thu, 10 Feb 2022 21:37:25 +0000
From:   Matthew Wilcox <willy@infradead.org>
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
        Michael Larabel <Michael@michaellarabel.com>,
        Mike Rapoport <rppt@kernel.org>,
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
Subject: Re: [PATCH v7 04/12] mm: multigenerational LRU: groundwork
Message-ID: <YgWFlYi5jGENGD4G@casper.infradead.org>
References: <20220208081902.3550911-1-yuzhao@google.com>
 <20220208081902.3550911-5-yuzhao@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208081902.3550911-5-yuzhao@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 01:18:54AM -0700, Yu Zhao wrote:
> Evictable pages are divided into multiple generations for each lruvec.
> The youngest generation number is stored in lrugen->max_seq for both
> anon and file types as they're aged on an equal footing. The oldest
> generation numbers are stored in lrugen->min_seq[] separately for anon
> and file types as clean file pages can be evicted regardless of swap
> constraints. These three variables are monotonically increasing.
> 
> Generation numbers are truncated into order_base_2(MAX_NR_GENS+1) bits
> in order to fit into the gen counter in folio->flags. Each truncated
> generation number is an index to lrugen->lists[]. The sliding window
> technique is used to track at least MIN_NR_GENS and at most
> MAX_NR_GENS generations. The gen counter stores (seq%MAX_NR_GENS)+1
> while a page is on one of lrugen->lists[]. Otherwise it stores 0.
> 
> There are two conceptually independent processes (as in the
> manufacturing process): "the aging", which produces young generations,
> and "the eviction", which consumes old generations. They form a
> closed-loop system, i.e., "the page reclaim". Both processes can be
> invoked from userspace for the purposes of working set estimation and
> proactive reclaim. These features are required to optimize job
> scheduling (bin packing) in data centers. The variable size of the
> sliding window is designed for such use cases [1][2].
> 
> To avoid confusions, the terms "hot" and "cold" will be applied to the
> multigenerational LRU, as a new convention; the terms "active" and
> "inactive" will be applied to the active/inactive LRU, as usual.

[...]

> +++ b/include/linux/page-flags-layout.h
> @@ -26,6 +26,14 @@
>  
>  #define ZONES_WIDTH		ZONES_SHIFT
>  
> +#ifdef CONFIG_LRU_GEN
> +/* LRU_GEN_WIDTH is generated from order_base_2(CONFIG_NR_LRU_GENS + 1). */
> +#define LRU_REFS_WIDTH		(CONFIG_TIERS_PER_GEN - 2)
> +#else
> +#define LRU_GEN_WIDTH		0
> +#define LRU_REFS_WIDTH		0
> +#endif /* CONFIG_LRU_GEN */

I'm concerned about the number of bits being used in page->flags.
It seems to me that we already have six bits in use to aid us in choosing
which pages to reclaim: referenced, lru, active, workingset, reclaim,
unevictable.

What I was hoping to see from this patch set was reuse of those bits.
That would give us 32 queues in total.  Some would be special (eg pages
cannot migrate out of the unevictable queue), but it seems to me that you
effectively have 4 queues for active and 4 queues for inactive at this
point (unless I misunderstood that).  I think we need special numbers
for: Not on the LRU and Unevictable, but that still leaves us with 30
generations to split between active & inactive.

But maybe we still need some of those bits?  Perhaps it's not OK to say
that queue id 0 is !LRU, queue 1 is unevictable, queue #2 is workingset,
queues 3-7 are active, queues 8-15 are various degrees of inactive.
I'm assuming that it's not sensible to have a page that's marked as both
"reclaim" and "workingset", but perhaps it is.

Anyway, I don't understand this area well enough.  I was just hoping
for some simplification.

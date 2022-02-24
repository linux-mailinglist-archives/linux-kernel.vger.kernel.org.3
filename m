Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC0634C21C5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 03:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbiBXCZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 21:25:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiBXCZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 21:25:17 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F052B22EDC8;
        Wed, 23 Feb 2022 18:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645669489; x=1677205489;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=fjSEafBb8ES86rUzsH60Lncm24g7M9CE/uM19ybBuVk=;
  b=D5kqjrQMcyRQp7ovkBK7UBZ02i6B7vkoyQvI9ZV0ycNWVQEYXOFabKvS
   ZQ5u+7tD+L/OTipiN+7aZMDKtDEKSEFbZ9dzglBrn4lNaIi4asiycsTHi
   j1Kxnphm3pjmxUw43LMPi5Gx/7LE+Tk/GTZogpCoFpfQEuWzDeSfbv86/
   IK1LXUiS4bpk+ER9W0smh9xp9ddAFM6II511xlT14ylbpSxuipqiXFV97
   IcgyImXEu+rHdSiLqaubo4mLlfqQst/UPdH71uTh9UnKchdXffDD3sbPk
   qJz8/jOTN7Ndx9LO882Pp1MnmHujLANtJnuELjQXHTnvlBpSmyFr/hUlj
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="235628028"
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="235628028"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 16:59:21 -0800
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="508666398"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.11])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 16:59:12 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
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
        Mike Rapoport <rppt@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
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
        Holger =?utf-8?Q?Hoffst=C3=A4tte?= 
        <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>
Subject: Re: [PATCH v7 05/12] mm: multigenerational LRU: minimal implementation
References: <20220208081902.3550911-1-yuzhao@google.com>
        <20220208081902.3550911-6-yuzhao@google.com>
        <87bkyy56nv.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <CAOUHufbekcu09DyEZAkJNRq_1qKaf_xibXQNeAVK=rsGBn9Z4Q@mail.gmail.com>
Date:   Thu, 24 Feb 2022 08:59:10 +0800
In-Reply-To: <CAOUHufbekcu09DyEZAkJNRq_1qKaf_xibXQNeAVK=rsGBn9Z4Q@mail.gmail.com>
        (Yu Zhao's message of "Wed, 23 Feb 2022 02:36:13 -0700")
Message-ID: <87y2213wrl.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yu Zhao <yuzhao@google.com> writes:

> On Wed, Feb 23, 2022 at 1:28 AM Huang, Ying <ying.huang@intel.com> wrote:
>>
>> Hi, Yu,
>>
>> Yu Zhao <yuzhao@google.com> writes:
>>
>> > To avoid confusions, the terms "promotion" and "demotion" will be
>> > applied to the multigenerational LRU, as a new convention; the terms
>> > "activation" and "deactivation" will be applied to the active/inactive
>> > LRU, as usual.
>>
>> In the memory tiering related commits and patchset, for example as follows,
>>
>> commit 668e4147d8850df32ca41e28f52c146025ca45c6
>> Author: Yang Shi <yang.shi@linux.alibaba.com>
>> Date:   Thu Sep 2 14:59:19 2021 -0700
>>
>>     mm/vmscan: add page demotion counter
>>
>> https://lore.kernel.org/linux-mm/20220221084529.1052339-1-ying.huang@intel.com/
>>
>> "demote" and "promote" is used for migrating pages between different
>> types of memory.  Is it better for us to avoid overloading these words
>> too much to avoid the possible confusion?
>
> Given that LRU and migration are usually different contexts, I think
> we'd be fine, unless we want a third pair of terms.

This is true before memory tiering is introduced.  In systems with
multiple types memory (called memory tiering), LRU is used to identify
pages to be migrated to the slow memory node.  Please take a look at
can_demote(), which is called in shrink_page_list().

>> > +static int get_swappiness(struct mem_cgroup *memcg)
>> > +{
>> > +     return mem_cgroup_get_nr_swap_pages(memcg) >= MIN_LRU_BATCH ?
>> > +            mem_cgroup_swappiness(memcg) : 0;
>> > +}
>>
>> After we introduced demotion support in Linux kernel.  The anonymous
>> pages in the fast memory node could be demoted to the slow memory node
>> via the page reclaiming mechanism as in the following commit.  Can you
>> consider that too?
>
> Sure. How do I check whether there is still space on the slow node?

You can always check the watermark of the slow node.  But now, we
actually don't check that (as in demote_page_list()), instead we will
wake up kswapd of the slow node.  The intended behavior is something
like,

  DRAM -> PMEM -> disk

Best Regards,
Huang, Ying

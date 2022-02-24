Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B72E94C2267
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 04:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiBXDce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 22:32:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiBXDcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 22:32:33 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EFC5159E9E;
        Wed, 23 Feb 2022 19:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645673524; x=1677209524;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=F5EcjioZj5uSNCtFNgSr/dmqOCTfAJkkvl7RheW7RxQ=;
  b=ZbfB+SpWbOfrLpiNV6UTegH01duh7Uy5UMje+FMAcDn5evbGnKQ6r8lW
   7atgbnsteDGQOPFx5YyBr5suz/aTQbpz8FfjXtSCRtyqGb/x5d2lxEFL0
   lnon8llpaKLwPCSUTb2IH0ZZglGZKqfOMFmNGjhNyWDZsIDWu0xZ5xK32
   MDMXJv4vZy7n+wLqm/k5uKywna16jaw+es4HmZP3imGqt+NckTI+TFTL2
   rp35OYKdRmmjTByc93ZMubO7/Hl8UuG/ioF8yQ9ljCkFTl+fMKUdxXDJL
   THZPyjPVtBw/CQNnZlqsMuT72ZhCTFRA1XOSJ400vW0dJl091Bfu+2oCt
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="276765559"
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="276765559"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 19:32:04 -0800
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="707298780"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.11])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 19:31:55 -0800
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
        <87y2213wrl.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <CAOUHufY8dRimricP=pvvgg8mEagb369nE8MVe6tnnLXQuKyAEA@mail.gmail.com>
Date:   Thu, 24 Feb 2022 11:31:53 +0800
In-Reply-To: <CAOUHufY8dRimricP=pvvgg8mEagb369nE8MVe6tnnLXQuKyAEA@mail.gmail.com>
        (Yu Zhao's message of "Wed, 23 Feb 2022 18:34:33 -0700")
Message-ID: <87h78p3pp2.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yu Zhao <yuzhao@google.com> writes:

> On Wed, Feb 23, 2022 at 5:59 PM Huang, Ying <ying.huang@intel.com> wrote:
>>
>> Yu Zhao <yuzhao@google.com> writes:
>>
>> > On Wed, Feb 23, 2022 at 1:28 AM Huang, Ying <ying.huang@intel.com> wrote:
>> >>
>> >> Hi, Yu,
>> >>
>> >> Yu Zhao <yuzhao@google.com> writes:
>> >>
>> >> > To avoid confusions, the terms "promotion" and "demotion" will be
>> >> > applied to the multigenerational LRU, as a new convention; the terms
>> >> > "activation" and "deactivation" will be applied to the active/inactive
>> >> > LRU, as usual.
>> >>
>> >> In the memory tiering related commits and patchset, for example as follows,
>> >>
>> >> commit 668e4147d8850df32ca41e28f52c146025ca45c6
>> >> Author: Yang Shi <yang.shi@linux.alibaba.com>
>> >> Date:   Thu Sep 2 14:59:19 2021 -0700
>> >>
>> >>     mm/vmscan: add page demotion counter
>> >>
>> >> https://lore.kernel.org/linux-mm/20220221084529.1052339-1-ying.huang@intel.com/
>> >>
>> >> "demote" and "promote" is used for migrating pages between different
>> >> types of memory.  Is it better for us to avoid overloading these words
>> >> too much to avoid the possible confusion?
>> >
>> > Given that LRU and migration are usually different contexts, I think
>> > we'd be fine, unless we want a third pair of terms.
>>
>> This is true before memory tiering is introduced.  In systems with
>> multiple types memory (called memory tiering), LRU is used to identify
>> pages to be migrated to the slow memory node.  Please take a look at
>> can_demote(), which is called in shrink_page_list().
>
> This sounds clearly two contexts to me. Promotion/demotion (move
> between generations) while pages are on LRU; or promotion/demotion
> (migration between nodes) after pages are taken off LRU.
>
> Note that promotion/demotion are not used in function names. They are
> used to describe how MGLRU works, in comparison with the
> active/inactive LRU. Memory tiering is not within this context.

Because we have used pgdemote_* in /proc/vmstat, "demotion_enabled" in
/sys/kernel/mm/numa, and will use pgpromote_* in /proc/vmstat.  It seems
better to avoid to use promote/demote directly for MGLRU in ABI.  A
possible solution is to use "mglru" and "promote/demote" together (such
as "mglru_promote_*" when it is needed?

>> >> > +static int get_swappiness(struct mem_cgroup *memcg)
>> >> > +{
>> >> > +     return mem_cgroup_get_nr_swap_pages(memcg) >= MIN_LRU_BATCH ?
>> >> > +            mem_cgroup_swappiness(memcg) : 0;
>> >> > +}
>> >>
>> >> After we introduced demotion support in Linux kernel.  The anonymous
>> >> pages in the fast memory node could be demoted to the slow memory node
>> >> via the page reclaiming mechanism as in the following commit.  Can you
>> >> consider that too?
>> >
>> > Sure. How do I check whether there is still space on the slow node?
>>
>> You can always check the watermark of the slow node.  But now, we
>> actually don't check that (as in demote_page_list()), instead we will
>> wake up kswapd of the slow node.  The intended behavior is something
>> like,
>>
>>   DRAM -> PMEM -> disk
>
> I'll look into this later -- for now, it's a low priority because
> there isn't much demand. I'll bump it up if anybody is interested in
> giving it a try. Meanwhile, please feel free to cook up something if
> you are interested.

When we introduce a new feature, we shouldn't break an existing one.
That is, not introducing regression.  I think that it is a rule?

If my understanding were correct, MGLRU will ignore to scan anonymous
page list even if there's demotion target for the node.  This breaks the
demotion feature in the upstream kernel.  Right?

It's a new feature to check whether there is still space on the slow
node.  We can look at that later.

Best Regards,
Huang, Ying

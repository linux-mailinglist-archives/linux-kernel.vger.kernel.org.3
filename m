Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9224D91A5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 01:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244827AbiCOAfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 20:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232791AbiCOAfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 20:35:40 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B683B007;
        Mon, 14 Mar 2022 17:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647304469; x=1678840469;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=XQ4rcun35JKs85E4Y+M1ZfvI2sKujSfLpEMpVPq0Spg=;
  b=aUfArf4ExONjHTuOpnwJmMt/sjV3rZxcWoJ8VDdK7lJElFeLTb3AoFtZ
   nX7xfLEXmAMUiccQPJLgc0tQbB860neL69pplOv0ayHGXXwBhdmLVd0zi
   xIH4//QAMysJImOP5wQuFO+CQckvyP68QjqHTaCV6negiUIRah7MDXAv2
   Uze1IznHlw5/KnCCMf6V86pwMQfB7FdbC/DUoCDJEWiO8hSR3ESfcvwYh
   XctdJQNsB5JlOeuJ7hQl33UUf5dLWzJ8XUpIk2mNQsUlFtVsgsgA9CgAt
   /UjXKqy2t0R67APRYN1F3cm716QdmqLiN7InQQbn4l9dX0igrm4hFiHOC
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="342607366"
X-IronPort-AV: E=Sophos;i="5.90,181,1643702400"; 
   d="scan'208";a="342607366"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 17:34:29 -0700
X-IronPort-AV: E=Sophos;i="5.90,181,1643702400"; 
   d="scan'208";a="713957692"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 17:34:20 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Yu Zhao <yuzhao@google.com>
Cc:     kernel@lists.fedoraproject.org, kernel-team@lists.ubuntu.com,
        Andrew Morton <akpm@linux-foundation.org>,
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
        Sofia Trinh <sofia.trinh@edi.works>,
        Vaibhav Jain <vaibhav@linux.ibm.com>
Subject: Re: [PATCH v9 05/14] mm: multi-gen LRU: groundwork
References: <20220309021230.721028-1-yuzhao@google.com>
        <20220309021230.721028-6-yuzhao@google.com>
        <875yoh552i.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <CAOUHufYPSesiePfxaV=y9Vne5cb+Y_vQtJyQ1NiO1CFus=8WOA@mail.gmail.com>
Date:   Tue, 15 Mar 2022 08:34:18 +0800
In-Reply-To: <CAOUHufYPSesiePfxaV=y9Vne5cb+Y_vQtJyQ1NiO1CFus=8WOA@mail.gmail.com>
        (Yu Zhao's message of "Mon, 14 Mar 2022 03:30:31 -0600")
Message-ID: <87mths3vg5.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yu Zhao <yuzhao@google.com> writes:

> On Mon, Mar 14, 2022 at 2:09 AM Huang, Ying <ying.huang@intel.com> wrote:
>>
>> Hi, Yu,
>>
>> Yu Zhao <yuzhao@google.com> writes:
>> > diff --git a/mm/Kconfig b/mm/Kconfig
>> > index 3326ee3903f3..747ab1690bcf 100644
>> > --- a/mm/Kconfig
>> > +++ b/mm/Kconfig
>> > @@ -892,6 +892,16 @@ config ANON_VMA_NAME
>> >         area from being merged with adjacent virtual memory areas due to the
>> >         difference in their name.
>> >
>> > +# the multi-gen LRU {
>> > +config LRU_GEN
>> > +     bool "Multi-Gen LRU"
>> > +     depends on MMU
>> > +     # the following options can use up the spare bits in page flags
>> > +     depends on !MAXSMP && (64BIT || !SPARSEMEM || SPARSEMEM_VMEMMAP)
>>
>> LRU_GEN depends on !MAXSMP.  So, What is the maximum NR_CPUS supported
>> by LRU_GEN?
>
> LRU_GEN doesn't really care about NR_CPUS. IOW, it doesn't impose a
> max number. The dependency is with NODES_SHIFT selected by MAXSMP:
>     default "10" if MAXSMP
> This combined with LAST_CPUPID_SHIFT can exhaust the spare bits in page flags.

From the following code snippets from page-flags-layout.h,
LAST_CPUPID_SHIFT is related to NR_CPUS instead of NODES_SHIFT.

#define LAST__PID_SHIFT 8
#define LAST__PID_MASK  ((1 << LAST__PID_SHIFT)-1)

#define LAST__CPU_SHIFT NR_CPUS_BITS
#define LAST__CPU_MASK  ((1 << LAST__CPU_SHIFT)-1)

#define LAST_CPUPID_SHIFT (LAST__PID_SHIFT+LAST__CPU_SHIFT)

Best Regards,
Huang, Ying

[snip]

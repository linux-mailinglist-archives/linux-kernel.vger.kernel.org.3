Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1768B4C0E3B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 09:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238963AbiBWI21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 03:28:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237992AbiBWI20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 03:28:26 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7404D49CA2;
        Wed, 23 Feb 2022 00:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645604879; x=1677140879;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=DE24H48zq69B43+tGDlcfZq6lBNFuEgFAiGCr9dtF4A=;
  b=RblFJDy0jQ6AxYCZZGu1qNSzEWX5pqT0QZm7cWnAcKDIW2RGQNMPZDxp
   LdtVxRzzYtfmtVq76hjtZeWAV2aru6NEv2lsZZr8s9sPQgRfM/slkSP/U
   lLiQeRodaAeNcE0bSPLLTaevsrdg61bj2vlcYNy44RKu4zEoedkwYGk3V
   U+4uFKiQzxyvwZ62wu+mjm/TH9y1ylTleCeHf3byQTvaDdVN8kkXkscFB
   v4B4lbp0UglD3UL/FQzukLp0JCcWxozj/3sN9lSSfvDqJtd4GJ9HbQ196
   t9UQZFtU+OjVu5Zy0iXWC3SCAwGBlLiwrsCfI2lzNsRclpFsTEIdtm5Jq
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="232534538"
X-IronPort-AV: E=Sophos;i="5.88,390,1635231600"; 
   d="scan'208";a="232534538"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 00:27:59 -0800
X-IronPort-AV: E=Sophos;i="5.88,390,1635231600"; 
   d="scan'208";a="505832311"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.11])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 00:27:50 -0800
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
        =?utf-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>
Subject: Re: [PATCH v7 05/12] mm: multigenerational LRU: minimal implementation
References: <20220208081902.3550911-1-yuzhao@google.com>
        <20220208081902.3550911-6-yuzhao@google.com>
Date:   Wed, 23 Feb 2022 16:27:48 +0800
In-Reply-To: <20220208081902.3550911-6-yuzhao@google.com> (Yu Zhao's message
        of "Tue, 8 Feb 2022 01:18:55 -0700")
Message-ID: <87bkyy56nv.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yu,

Yu Zhao <yuzhao@google.com> writes:

> To avoid confusions, the terms "promotion" and "demotion" will be
> applied to the multigenerational LRU, as a new convention; the terms
> "activation" and "deactivation" will be applied to the active/inactive
> LRU, as usual.

In the memory tiering related commits and patchset, for example as follows,

commit 668e4147d8850df32ca41e28f52c146025ca45c6
Author: Yang Shi <yang.shi@linux.alibaba.com>
Date:   Thu Sep 2 14:59:19 2021 -0700

    mm/vmscan: add page demotion counter

https://lore.kernel.org/linux-mm/20220221084529.1052339-1-ying.huang@intel.com/

"demote" and "promote" is used for migrating pages between different
types of memory.  Is it better for us to avoid overloading these words
too much to avoid the possible confusion?

> +static int get_swappiness(struct mem_cgroup *memcg)
> +{
> +	return mem_cgroup_get_nr_swap_pages(memcg) >= MIN_LRU_BATCH ?
> +	       mem_cgroup_swappiness(memcg) : 0;
> +}

After we introduced demotion support in Linux kernel.  The anonymous
pages in the fast memory node could be demoted to the slow memory node
via the page reclaiming mechanism as in the following commit.  Can you
consider that too?

commit a2a36488a61cefe3129295c6e75b3987b9d7fd13
Author: Keith Busch <kbusch@kernel.org>
Date:   Thu Sep 2 14:59:26 2021 -0700

    mm/vmscan: Consider anonymous pages without swap
    
    Reclaim anonymous pages if a migration path is available now that demotion
    provides a non-swap recourse for reclaiming anon pages.
    
    Note that this check is subtly different from the can_age_anon_pages()
    checks.  This mechanism checks whether a specific page in a specific
    context can actually be reclaimed, given current swap space and cgroup
    limits.
    
    can_age_anon_pages() is a much simpler and more preliminary check which
    just says whether there is a possibility of future reclaim.


Best Regards,
Huang, Ying

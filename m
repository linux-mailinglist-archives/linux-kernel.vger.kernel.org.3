Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABBEA4FCC58
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 04:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245034AbiDLCTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 22:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244844AbiDLCSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 22:18:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C4733A1B;
        Mon, 11 Apr 2022 19:16:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6FA236168C;
        Tue, 12 Apr 2022 02:16:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B932C385A3;
        Tue, 12 Apr 2022 02:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1649729791;
        bh=hxuKFNGBeqS7vQiUwSPiIBI/AqNtviIZC+add1y1ko8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mopX5Sy7AFPqL3cDVB4gG3iNilwP9Ot+R6JYewM4MOcsc6K2vGgX3GoToffvY9nwC
         LhzNDzD+Zczh3PgOiZj3/YGSl79ke2DibNlXBhvqkDKYGNN5fiUsbbTuRyc9Geqq1U
         thiQiWMkVd6JWhndwJJT4g769mJp5YGtwyCk+dAY=
Date:   Mon, 11 Apr 2022 19:16:27 -0700
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
Subject: Re: [PATCH v10 10/14] mm: multi-gen LRU: kill switch
Message-Id: <20220411191627.629f21de83cd0a520ef4a142@linux-foundation.org>
In-Reply-To: <20220407031525.2368067-11-yuzhao@google.com>
References: <20220407031525.2368067-1-yuzhao@google.com>
        <20220407031525.2368067-11-yuzhao@google.com>
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

On Wed,  6 Apr 2022 21:15:22 -0600 Yu Zhao <yuzhao@google.com> wrote:

> Add /sys/kernel/mm/lru_gen/enabled as a kill switch. Components that
> can be disabled include:
>   0x0001: the multi-gen LRU core
>   0x0002: walking page table, when arch_has_hw_pte_young() returns
>           true
>   0x0004: clearing the accessed bit in non-leaf PMD entries, when
>           CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG=y
>   [yYnN]: apply to all the components above
> E.g.,
>   echo y >/sys/kernel/mm/lru_gen/enabled
>   cat /sys/kernel/mm/lru_gen/enabled
>   0x0007
>   echo 5 >/sys/kernel/mm/lru_gen/enabled
>   cat /sys/kernel/mm/lru_gen/enabled
>   0x0005

I'm shocked that this actually works.  How does it work?  Existing
pages & folios are drained over time or synchrnously?  Supporting
structures remain allocated, available for reenablement?

Why is it thought necessary to have this?  Is it expected to be
permanent?

> NB: the page table walks happen on the scale of seconds under heavy
> memory pressure, in which case the mmap_lock contention is a lesser
> concern, compared with the LRU lock contention and the I/O congestion.
> So far the only well-known case of the mmap_lock contention happens on
> Android, due to Scudo [1] which allocates several thousand VMAs for
> merely a few hundred MBs. The SPF and the Maple Tree also have
> provided their own assessments [2][3]. However, if walking page tables
> does worsen the mmap_lock contention, the kill switch can be used to
> disable it. In this case the multi-gen LRU will suffer a minor
> performance degradation, as shown previously.
> 
> Clearing the accessed bit in non-leaf PMD entries can also be
> disabled, since this behavior was not tested on x86 varieties other
> than Intel and AMD.
> 
> ...
>
> --- a/include/linux/cgroup.h
> +++ b/include/linux/cgroup.h
> @@ -432,6 +432,18 @@ static inline void cgroup_put(struct cgroup *cgrp)
>  	css_put(&cgrp->self);
>  }
>  
> +extern struct mutex cgroup_mutex;
> +
> +static inline void cgroup_lock(void)
> +{
> +	mutex_lock(&cgroup_mutex);
> +}
> +
> +static inline void cgroup_unlock(void)
> +{
> +	mutex_unlock(&cgroup_mutex);
> +}

It's a tad rude to export mutex_lock like this without (apparently)
informing its owner (Tejun).

And if we're going to wrap its operations via helper fuctions then

- presumably all cgroup_mutex operations should be wrapped and

- exiting open-coded operations on this mutex should be converted.

>
> ...
>
> +static bool drain_evictable(struct lruvec *lruvec)
> +{
> +	int gen, type, zone;
> +	int remaining = MAX_LRU_BATCH;
> +
> +	for_each_gen_type_zone(gen, type, zone) {
> +		struct list_head *head = &lruvec->lrugen.lists[gen][type][zone];
> +
> +		while (!list_empty(head)) {
> +			bool success;
> +			struct folio *folio = lru_to_folio(head);
> +
> +			VM_BUG_ON_FOLIO(folio_test_unevictable(folio), folio);
> +			VM_BUG_ON_FOLIO(folio_test_active(folio), folio);
> +			VM_BUG_ON_FOLIO(folio_is_file_lru(folio) != type, folio);
> +			VM_BUG_ON_FOLIO(folio_zonenum(folio) != zone, folio);

So many new BUG_ONs to upset Linus :(

> +			success = lru_gen_del_folio(lruvec, folio, false);
> +			VM_BUG_ON(!success);
> +			lruvec_add_folio(lruvec, folio);
> +
> +			if (!--remaining)
> +				return false;
> +		}
> +	}
> +
> +	return true;
> +}
> +
>
> ...
>
> +static ssize_t store_enable(struct kobject *kobj, struct kobj_attribute *attr,
> +			    const char *buf, size_t len)
> +{
> +	int i;
> +	unsigned int caps;
> +
> +	if (tolower(*buf) == 'n')
> +		caps = 0;
> +	else if (tolower(*buf) == 'y')
> +		caps = -1;
> +	else if (kstrtouint(buf, 0, &caps))
> +		return -EINVAL;

See kstrtobool()

> +	for (i = 0; i < NR_LRU_GEN_CAPS; i++) {
> +		bool enable = caps & BIT(i);
> +
> +		if (i == LRU_GEN_CORE)
> +			lru_gen_change_state(enable);
> +		else if (enable)
> +			static_branch_enable(&lru_gen_caps[i]);
> +		else
> +			static_branch_disable(&lru_gen_caps[i]);
> +	}
> +
> +	return len;
> +}
>
> ...
>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF5255B4FD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jun 2022 03:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbiF0BaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 21:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiF0BaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 21:30:10 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59A7FFC
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 18:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656293409; x=1687829409;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=NC1jSM8WJJ7D2/nqvABDxS9NRL70yG7/V6OFOiiC/dI=;
  b=RAweZUweAsoxhllSpuzgQbVEP7gvUJzlXRFkT5xNk7Nr3ZfbKRhbYRpo
   un6rxKsCG40bDIlYUdubIsJXFESsUWmWoG4k9b4Ds3FKeZLGLy+r5avRx
   fh6bpbJWRik/URqhyH3zdmuqsQI0el5TqBVgEC+98W2SmoQLvhgOlwZKL
   VFBZKAmHlm6QXLAd/8vsUsUYWFAh855LoR+InMwZyObS2QM8Yda/KpDO7
   TEgHlObNbCA5nlNBcMf+D8p3uA8hwauv3bQ6NuuqYyFZy110az3GYEO8C
   Aa4ihdlC4nSHyUATmH3fBc4JXxM74mD7gVDp5ID0nQBquETbprmYGYMDz
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10390"; a="345332147"
X-IronPort-AV: E=Sophos;i="5.92,225,1650956400"; 
   d="scan'208";a="345332147"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2022 18:30:09 -0700
X-IronPort-AV: E=Sophos;i="5.92,225,1650956400"; 
   d="scan'208";a="835973672"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2022 18:30:07 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     <akpm@linux-foundation.org>, <david@redhat.com>,
        <songmuchun@bytedance.com>, <quic_qiancai@quicinc.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] mm/swapfile: fix possible data races of inuse_pages
References: <20220625093346.48894-1-linmiaohe@huawei.com>
        <20220625093346.48894-2-linmiaohe@huawei.com>
Date:   Mon, 27 Jun 2022 09:29:50 +0800
In-Reply-To: <20220625093346.48894-2-linmiaohe@huawei.com> (Miaohe Lin's
        message of "Sat, 25 Jun 2022 17:33:45 +0800")
Message-ID: <874k0699m9.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miaohe Lin <linmiaohe@huawei.com> writes:

> si->inuse_pages could still be accessed concurrently now. The plain reads
> outside si->lock critical section, i.e. swap_show and si_swapinfo, which
> results in data races. READ_ONCE and WRITE_ONCE is used to fix such data
> races. Note these data races should be ok because they're just used for
> showing swap info.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

Thanks!

Best Regards,
Huang, Ying

> ---
>  mm/swapfile.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index edc3420d30e7..5c8681a3f1d9 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -695,7 +695,7 @@ static void swap_range_alloc(struct swap_info_struct *si, unsigned long offset,
>  		si->lowest_bit += nr_entries;
>  	if (end == si->highest_bit)
>  		WRITE_ONCE(si->highest_bit, si->highest_bit - nr_entries);
> -	si->inuse_pages += nr_entries;
> +	WRITE_ONCE(si->inuse_pages, si->inuse_pages + nr_entries);
>  	if (si->inuse_pages == si->pages) {
>  		si->lowest_bit = si->max;
>  		si->highest_bit = 0;
> @@ -732,7 +732,7 @@ static void swap_range_free(struct swap_info_struct *si, unsigned long offset,
>  			add_to_avail_list(si);
>  	}
>  	atomic_long_add(nr_entries, &nr_swap_pages);
> -	si->inuse_pages -= nr_entries;
> +	WRITE_ONCE(si->inuse_pages, si->inuse_pages - nr_entries);
>  	if (si->flags & SWP_BLKDEV)
>  		swap_slot_free_notify =
>  			si->bdev->bd_disk->fops->swap_slot_free_notify;
> @@ -2641,7 +2641,7 @@ static int swap_show(struct seq_file *swap, void *v)
>  	}
>  
>  	bytes = si->pages << (PAGE_SHIFT - 10);
> -	inuse = si->inuse_pages << (PAGE_SHIFT - 10);
> +	inuse = READ_ONCE(si->inuse_pages) << (PAGE_SHIFT - 10);
>  
>  	file = si->swap_file;
>  	len = seq_file_path(swap, file, " \t\n\\");
> @@ -3260,7 +3260,7 @@ void si_swapinfo(struct sysinfo *val)
>  		struct swap_info_struct *si = swap_info[type];
>  
>  		if ((si->flags & SWP_USED) && !(si->flags & SWP_WRITEOK))
> -			nr_to_be_unused += si->inuse_pages;
> +			nr_to_be_unused += READ_ONCE(si->inuse_pages);
>  	}
>  	val->freeswap = atomic_long_read(&nr_swap_pages) + nr_to_be_unused;
>  	val->totalswap = total_swap_pages + nr_to_be_unused;

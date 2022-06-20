Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E77E5511ED
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 09:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239630AbiFTHzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 03:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236311AbiFTHzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 03:55:08 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88FE5E0E4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 00:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655711707; x=1687247707;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=BUrlbNZSKUvYRK40167TMJIvTUurjES69a62ziV+rhY=;
  b=PqkIKp8wBepmwqO4OM05JDNgnt1w1QywxtuLdYSTRefNmyJAvuKnkOng
   x1QncA6yl/EznKUneRcP/m2YdWNc4ZiihR4UyXKGmonHvbUr2AYDJ1B2i
   +g+H3SjtEppluIi94XZQ9du1k38CuWUf9vO+wUFpqNu6P2Ly4A1TaNqVr
   J52ZtJy+KF56qwWijYOikubmxVgsGuGmzV8SkGWUMdiRLFso8nOnk/CeP
   G1L2ZHnUL36cphzkindLHymKY2W0uQnIgkODjH74Acf3JJfpZSrKNIYNM
   q650yotQUqvjL3u+Nxa3WPH152I5iWqAOdCPdJfwJnj9MpHez+nJFsNAV
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="280888333"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="280888333"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 00:55:01 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="654559721"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 00:54:59 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     <akpm@linux-foundation.org>, <david@redhat.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] mm/swapfile: fix possible data races of inuse_pages
References: <20220608144031.829-1-linmiaohe@huawei.com>
        <20220608144031.829-3-linmiaohe@huawei.com>
Date:   Mon, 20 Jun 2022 15:54:55 +0800
In-Reply-To: <20220608144031.829-3-linmiaohe@huawei.com> (Miaohe Lin's message
        of "Wed, 8 Jun 2022 22:40:30 +0800")
Message-ID: <87edzjrcq8.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
> results in data races. But these should be ok because they're just used
> for showing swap info.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/swapfile.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index d2bead7b8b70..3fa26f6971e9 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -2646,7 +2646,7 @@ static int swap_show(struct seq_file *swap, void *v)
>  	}
>  
>  	bytes = si->pages << (PAGE_SHIFT - 10);
> -	inuse = si->inuse_pages << (PAGE_SHIFT - 10);
> +	inuse = READ_ONCE(si->inuse_pages) << (PAGE_SHIFT - 10);
>  
>  	file = si->swap_file;
>  	len = seq_file_path(swap, file, " \t\n\\");
> @@ -3265,7 +3265,7 @@ void si_swapinfo(struct sysinfo *val)
>  		struct swap_info_struct *si = swap_info[type];
>  
>  		if ((si->flags & SWP_USED) && !(si->flags & SWP_WRITEOK))
> -			nr_to_be_unused += si->inuse_pages;
> +			nr_to_be_unused += READ_ONCE(si->inuse_pages);
>  	}
>  	val->freeswap = atomic_long_read(&nr_swap_pages) + nr_to_be_unused;
>  	val->totalswap = total_swap_pages + nr_to_be_unused;

READ_ONCE() should be paired with WRITE_ONCE().  So, change the writer
side too?

Best Regards,
Huang, Ying

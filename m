Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEFF54CF0C9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 06:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235232AbiCGFCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 00:02:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiCGFCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 00:02:31 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B941D0F8
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 21:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646629297; x=1678165297;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=NFKgQZkdrQx8p8nN/Isk9HvHRlX5csN9smzrhWRrW1E=;
  b=PBUg1Lf5POqM4nOjWwTeXqfKB+tb9PNqCzOrDFFY42YhBdBYcmOrFdYP
   Ne4qtkjwWUYq8oc5L++Kf6l37KH66aEcASzgbsbCa7xesDfhFBoEfwqYR
   FmBmkI0vzSRL68lvNFofkRGSOzk6DagO19VcruJQJP/zTrNGPGs/F/xjD
   ZphBGm8cK/bacmOq6fkiRoQqCIjy4VEhaJasxQfme8u2eryzciixG2Nv0
   bO72ctSMXx3FhH79ho8ZO+aI0961TW/yneQ1jTotW2cI8tWQTMhSbSVJ3
   QWg+mXA31qys/MOY32lIqkwafTF/lkWnAOhjnzKueDXbf6LRvICTpat2s
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10278"; a="234253576"
X-IronPort-AV: E=Sophos;i="5.90,160,1643702400"; 
   d="scan'208";a="234253576"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2022 21:01:37 -0800
X-IronPort-AV: E=Sophos;i="5.90,160,1643702400"; 
   d="scan'208";a="552994919"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2022 21:01:32 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>,
        <shy828301@gmail.com>, <willy@infradead.org>, <ziy@nvidia.com>,
        <minchan@kernel.org>, <apopple@nvidia.com>,
        <ave.hansen@linux.intel.com>, <o451686892@gmail.com>,
        <almasrymina@google.com>, <jhubbard@nvidia.com>,
        <rcampbell@nvidia.com>, <peterx@redhat.com>,
        <naoya.horiguchi@nec.com>, <mhocko@suse.com>, <riel@redhat.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 12/16] mm/migration: fix potential page refcounts leak
 in migrate_pages
References: <20220304093409.25829-1-linmiaohe@huawei.com>
        <20220304093409.25829-13-linmiaohe@huawei.com>
Date:   Mon, 07 Mar 2022 13:01:30 +0800
In-Reply-To: <20220304093409.25829-13-linmiaohe@huawei.com> (Miaohe Lin's
        message of "Fri, 4 Mar 2022 17:34:05 +0800")
Message-ID: <87r17e5pat.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miaohe Lin <linmiaohe@huawei.com> writes:

> In -ENOMEM case, there might be some subpages of fail-to-migrate THPs
> left in thp_split_pages list. We should move them back to migration
> list so that they could be put back to the right list by the caller
> otherwise the page refcnt will be leaked here. Also adjust nr_failed
> and nr_thp_failed accordingly to make vm events account more accurate.
>
> Fixes: b5bade978e9b ("mm: migrate: fix the return value of migrate_pages()")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/migrate.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index e0db06927f02..6c2dfed2ddb8 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1422,6 +1422,15 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>  				}
>  
>  				nr_failed_pages += nr_subpages;
> +				/*
> +				 * There might be some subpages of fail-to-migrate THPs
> +				 * left in thp_split_pages list. Move them back to migration
> +				 * list so that they could be put back to the right list by
> +				 * the caller otherwise the page refcnt will be leaked.
> +				 */
> +				list_splice_init(&thp_split_pages, from);
> +				nr_failed += retry;

It appears that we don't need to change nr_failed, because we don't use
it for this situation.  Otherwise looks good to me.

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

Best Regards,
Huang, Ying

> +				nr_thp_failed += thp_retry;
>  				goto out;
>  			case -EAGAIN:
>  				if (is_thp)

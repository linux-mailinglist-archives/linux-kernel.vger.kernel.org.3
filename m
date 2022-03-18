Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50CC14DD510
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 08:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232931AbiCRHJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 03:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbiCRHJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 03:09:22 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD0322287
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 00:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647587284; x=1679123284;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3+ru1OtoV1JaDhmrBMAF64b5LEXwd/7ge8uP0B7ptPs=;
  b=D6l0A4EQsJuxiZfH0sm/8tCS8E+Fz0E5c0AXj25TPHyWOfbO8JD/0UCe
   LcaToQ0fTKxSptoVTybauy7GIok2S5CXEc+2PX7x0UfzHo/3fiwYkaD+e
   UiBqaPYHu0uzv5ZsoAA67QuXf9vhDhhlsAf28kTtIHLmAZBzIGNRnT8NM
   vFqCpCiHkRkjzLtwalCKthppKnyJUYzcr/QgXUGnM96REDXPQnM3ssb2f
   ooDLnlH5Mnq2ALULq3THtwpS1Rpl9RApZR8Gtii5CDKgDwSh8+xHm52E7
   QRapKhXZ4nHP6+9n1VT7C4Imrw/Cg9djIf1hqIiCCH0y/M/CbrMnQEgF9
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="257025115"
X-IronPort-AV: E=Sophos;i="5.90,191,1643702400"; 
   d="scan'208";a="257025115"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 00:08:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,191,1643702400"; 
   d="scan'208";a="541712979"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.138])
  by orsmga007.jf.intel.com with ESMTP; 18 Mar 2022 00:08:01 -0700
Date:   Fri, 18 Mar 2022 15:08:00 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     ziy@nvidia.com, baolin.wang@linux.alibaba.com,
        ying.huang@intel.com, songmuchun@bytedance.com, apopple@nvidia.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/11] mm/migration: fix potential page refcounts leak
 in migrate_pages
Message-ID: <20220318070800.GB436@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> In -ENOMEM case, there might be some subpages of fail-to-migrate THPs
> left in thp_split_pages list. We should move them back to migration
> list so that they could be put back to the right list by the caller
> otherwise the page refcnt will be leaked here. Also adjust nr_failed
> and nr_thp_failed accordingly to make vm events account more accurate.
 
We just met a real world case for this when checking a malloc-oom
issue and our fix is similar with yours :).

So I think you can remove the 'potential' from the patch subject.
Feel free to add

Tested-by: Feng Tang <feng.tang@intel.com>
Reviewed-by: Feng Tang <feng.tang@intel.com>

Thanks,
Feng

> Fixes: b5bade978e9b ("mm: migrate: fix the return value of migrate_pages()")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  mm/migrate.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 63a87ef0996f..97dfd1f4870d 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1438,6 +1438,14 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
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
> +				nr_thp_failed += thp_retry;
>  				goto out;
>  			case -EAGAIN:
>  				if (is_thp)
> -- 
> 2.23.0

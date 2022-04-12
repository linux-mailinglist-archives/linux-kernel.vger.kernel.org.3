Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 135F44FCBAE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 03:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbiDLBMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 21:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348455AbiDLA7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 20:59:21 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121DA36E21
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 17:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649724758; x=1681260758;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xfxJtTXIuRttIzRBDb+X6akqcsjXQHvcov6CBWoB9aU=;
  b=kbElOvLGHE9ltBd9uZIwrwjpmlYmtezXbsHsBrKidgQI7HhS6VgVFgr7
   NXwcevHM4Ck8vhPRt9yHWAvljgxL0N6W7dR3bOWptbtwPGZ9KlSVYs4yL
   x7URbeGk4zTjcV+db3hq6Wn1rbjp66aEhHG649oE9hjT5o5TYpMpntvbL
   y7z1FhnYUSlpHjMMZe68yXwVtaxBUxqvrHaU2ZBrsK5QEyeDGRKtExjtP
   th1Wd1AARj40ByWk0np13SyKaCq8NP7h36ozCvZ9F8czwGkZif9qdY5QM
   2Hr4S0AIX2/l9OYZgyPxrSzalacGh8vfRcphSZcCnxx7HmgvRd4TpCHVs
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="287260789"
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="287260789"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 17:52:35 -0700
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="572492458"
Received: from joliu-mobl2.ccr.corp.intel.com ([10.254.214.243])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 17:52:33 -0700
Message-ID: <8a4a0426c81f13d70d2c82b7adbc957e3e953bf3.camel@intel.com>
Subject: Re: [PATCH v2 2/9] mm/vmscan: remove unneeded can_split_huge_page
 check
From:   "ying.huang@intel.com" <ying.huang@intel.com>
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     songmuchun@bytedance.com, hch@infradead.org, willy@infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Tue, 12 Apr 2022 08:52:30 +0800
In-Reply-To: <20220409093500.10329-3-linmiaohe@huawei.com>
References: <20220409093500.10329-1-linmiaohe@huawei.com>
         <20220409093500.10329-3-linmiaohe@huawei.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-04-09 at 17:34 +0800, Miaohe Lin wrote:
> We don't need to check can_split_folio() because folio_maybe_dma_pinned()
> is checked before. It will avoid the long term pinned pages to be swapped
> out. And we can live with short term pinned pages. Without can_split_folio
> checking we can simplify the code. Also activate_locked can be changed to
> keep_locked as it's just short term pinning.
> 
> Suggested-by: Huang, Ying <ying.huang@intel.com>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Look good to me.  Thanks!

Reviewed-by: Huang, Ying <ying.huang@intel.com>

Best Regards,
Huang, Ying

> ---
>  mm/vmscan.c | 22 ++++++++--------------
>  1 file changed, 8 insertions(+), 14 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 4a76be47bed1..01f5db75a507 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1711,20 +1711,14 @@ static unsigned int shrink_page_list(struct list_head *page_list,
>  					goto keep_locked;
>  				if (folio_maybe_dma_pinned(folio))
>  					goto keep_locked;
> -				if (PageTransHuge(page)) {
> -					/* cannot split THP, skip it */
> -					if (!can_split_folio(folio, NULL))
> -						goto activate_locked;
> -					/*
> -					 * Split pages without a PMD map right
> -					 * away. Chances are some or all of the
> -					 * tail pages can be freed without IO.
> -					 */
> -					if (!folio_entire_mapcount(folio) &&
> -					    split_folio_to_list(folio,
> -								page_list))
> -						goto activate_locked;
> -				}
> +				/*
> +				 * Split pages without a PMD map right
> +				 * away. Chances are some or all of the
> +				 * tail pages can be freed without IO.
> +				 */
> +				if (PageTransHuge(page) && !folio_entire_mapcount(folio) &&
> +				    split_folio_to_list(folio, page_list))
> +					goto keep_locked;
>  				if (!add_to_swap(page)) {
>  					if (!PageTransHuge(page))
>  						goto activate_locked_split;



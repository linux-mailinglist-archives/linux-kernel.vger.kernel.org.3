Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3F0C4ED5E4
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 10:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233056AbiCaIlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 04:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233114AbiCaIky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 04:40:54 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE16C45068
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 01:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648715945; x=1680251945;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=okgG1CeaQqY3k2zImv4eBaeOfSp405YpDe0u7e4t9vs=;
  b=OXp2CAiMngdMI5VXi4Qgrg0SJL6OdaIkNRdooWUdAv54zScGgT7FxTtq
   Z95DPU28AHC+h3pp6pws38UgrnzPm/gDIEe1k66tFBUSA2dyBbYyDfj8a
   VAymqk1BZzbSnogO29GyXHTBsPGjo197whYWycVwTgHEYRM4dPgrIpQYX
   STSorkFRaFSW+U7cFP4bn8oxXGuoTsJlJ0x59Rr2U+HPQK0F8JblbHLk8
   FGIE+xM3fSGFCBpMZG+TbAG4Grg0nwQVFgz4Bn1EvYFFTFZZPFwhB5P8G
   /19WipsuSHLxkWXq7iExAtydG5DLYSa49Y4XISD0JaFX0nB5HBxbCwyTf
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="284675069"
X-IronPort-AV: E=Sophos;i="5.90,224,1643702400"; 
   d="scan'208";a="284675069"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 01:38:56 -0700
X-IronPort-AV: E=Sophos;i="5.90,224,1643702400"; 
   d="scan'208";a="547226473"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 01:38:54 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/8] mm/vmscan: remove unneeded can_split_huge_page check
References: <20220329132619.18689-1-linmiaohe@huawei.com>
        <20220329132619.18689-3-linmiaohe@huawei.com>
Date:   Thu, 31 Mar 2022 16:38:52 +0800
In-Reply-To: <20220329132619.18689-3-linmiaohe@huawei.com> (Miaohe Lin's
        message of "Tue, 29 Mar 2022 21:26:13 +0800")
Message-ID: <877d8abjoj.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

Miaohe Lin <linmiaohe@huawei.com> writes:

> can_split_huge_page is introduced via commit b8f593cd0896 ("mm, THP, swap:
> check whether THP can be split firstly") to avoid deleting the THP from
> the swap cache and freeing the swap cluster when the THP cannot be split.
> But since commit bd4c82c22c36 ("mm, THP, swap: delay splitting THP after
> swapped out"), splitting THP is delayed until THP is swapped out. There's
> no need to delete the THP from the swap cache and free the swap cluster
> anymore. Thus we can remove this unneeded can_split_huge_page check now to
> simplify the code logic.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/vmscan.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 7c1a9713bfc9..09b452c4d256 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1691,9 +1691,6 @@ static unsigned int shrink_page_list(struct list_head *page_list,
>  				if (folio_maybe_dma_pinned(folio))
>  					goto keep_locked;
>  				if (PageTransHuge(page)) {
> -					/* cannot split THP, skip it */
> -					if (!can_split_folio(folio, NULL))
> -						goto activate_locked;
>  					/*
>  					 * Split pages without a PMD map right
>  					 * away. Chances are some or all of the

I'm OK with the change itself.  But THP still needs to be split after
being swapped out.  The reason we don't need to check can_split_folio()
is that folio_maybe_dma_pinned() is checked before.  Which will avoid
the long term pinned pages to be swapped out.  And we can live with
short term pinned pages.  Without can_split_folio() checking we can
simplify the code as follows,

	/*
	 * Split pages without a PMD map right
	 * away. Chances are some or all of the
	 * tail pages can be freed without IO.
	 */
	if (PageTransHuge(page) && !compound_mapcount(page) &&
            split_huge_page_to_list(page, page_list))
		goto keep_locked;
                                                                
activate_locked can be changed to keep_locked too, because it's just
short term pinning.

Best Regards,
Huang, Ying

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 894CA4EE6A5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 05:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244469AbiDADWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 23:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233661AbiDADWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 23:22:22 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68111C7F07
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 20:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648783233; x=1680319233;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=VljMUx3NAvi5ubUt1jFKfnEjFTq1/S47IQjBpwpMFsw=;
  b=P/tVIFULyh8SHuuPzcHQh5tbwTgIUU0Qk1CoMMcWe7DWMjOMx/+5CA/N
   i4ppg6V5oxxSqH4WDrG1B/Elv+fcmO2zbbg4VdOZCtTAKcZYDdvFkWrA5
   EG8WDxd2KvvFGsCQF+5tSyp6u6QetywJXfOdbOqTCnTvbPv/96BhtH6Ev
   3o9rCpDu/SAkK5UPPN6+47B/nKtJwHQtD+yOfLeoKzsWY36FWq3MtP8df
   OkgHqdBr0eizwoAg3poMBy+3EYjml22ZiJVlcgWjPVOK8bt2sAi8p2O4e
   GLxSM8F04PNIOyGfBdE7ebzseFSvM+Fv8qOkZIQY5xu6nbfTIekpD57M4
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10303"; a="323204238"
X-IronPort-AV: E=Sophos;i="5.90,226,1643702400"; 
   d="scan'208";a="323204238"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 20:20:33 -0700
X-IronPort-AV: E=Sophos;i="5.90,226,1643702400"; 
   d="scan'208";a="567081540"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 20:20:31 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Konstantin Khlebnikov <khlebnikov@openvz.org>,
        Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: Re: [PATCH 5/8] mm/vmscan: use helper folio_is_file_lru()
References: <20220329132619.18689-1-linmiaohe@huawei.com>
        <20220329132619.18689-6-linmiaohe@huawei.com>
Date:   Fri, 01 Apr 2022 11:20:29 +0800
In-Reply-To: <20220329132619.18689-6-linmiaohe@huawei.com> (Miaohe Lin's
        message of "Tue, 29 Mar 2022 21:26:16 +0800")
Message-ID: <87y20pa3r6.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miaohe Lin <linmiaohe@huawei.com> writes:

> Use helper folio_is_file_lru() to check whether folio is file lru. Minor
> readability improvement.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/vmscan.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index ebd8ffb63673..31e95d627448 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1411,14 +1411,14 @@ static enum page_references folio_check_references(struct folio *folio,
>  		/*
>  		 * Activate file-backed executable folios after first usage.
>  		 */
> -		if ((vm_flags & VM_EXEC) && !folio_test_swapbacked(folio))
> +		if ((vm_flags & VM_EXEC) && folio_is_file_lru(folio))

I think that this should be converted to

		if ((vm_flags & VM_EXEC)))

We should activate swap-backed executable folios (e.g. tmpfs) after
first usage too.

Best Regards,
Huang, Ying

>  			return PAGEREF_ACTIVATE;
>  
>  		return PAGEREF_KEEP;
>  	}
>  
>  	/* Reclaim if clean, defer dirty folios to writeback */
> -	if (referenced_folio && !folio_test_swapbacked(folio))
> +	if (referenced_folio && folio_is_file_lru(folio))
>  		return PAGEREF_RECLAIM_CLEAN;
>  
>  	return PAGEREF_RECLAIM;

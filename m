Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8319E5838A6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 08:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbiG1GSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 02:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233627AbiG1GSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 02:18:13 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF1C5A8A6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 23:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658989092; x=1690525092;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=Rwc/qniW/RO2BA+uBG6gExEBv7Fj2QLZKI7Go3cAQKw=;
  b=YprFm7tOiPLpXgNZF9vJTalX1mJ/++5b7CpOdy5Hl7zyCBVsjvRFHMsi
   SB3KfTraPTNkfsZB4x2tKXrtNGj6Xt0xSvISKljhRQzIFE/KDidRmpX7m
   +8/LGarnY3VZMMorSkvUlI3fg8DpT3eoTdCs5ZEJ1p5iUzeZzzQP16Gxn
   /+l7mHPDMO1za4oG1PIJKV98Zx8967AOv5GlJwsPpZGNskHWH2r+uQeF2
   DOQohVvpED0qThIxxDs5N1AyO5o+BwOJMwaGshL41GAX9HyxsrbxhbAqD
   ginp9MlVijeP5fXtn7tVC86wXX5hGPVwnxGB5LHOx4FXXVJ79qxoaIJW3
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10421"; a="289627817"
X-IronPort-AV: E=Sophos;i="5.93,196,1654585200"; 
   d="scan'208";a="289627817"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 23:18:12 -0700
X-IronPort-AV: E=Sophos;i="5.93,196,1654585200"; 
   d="scan'208";a="576311730"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 23:18:10 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     <akpm@linux-foundation.org>, <ziy@nvidia.com>,
        <shy828301@gmail.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: migrate: Do not retry 10 times for the subpages of
 fail-to-migrate THP
References: <1658405108-100658-1-git-send-email-baolin.wang@linux.alibaba.com>
Date:   Thu, 28 Jul 2022 14:16:35 +0800
In-Reply-To: <1658405108-100658-1-git-send-email-baolin.wang@linux.alibaba.com>
        (Baolin Wang's message of "Thu, 21 Jul 2022 20:05:08 +0800")
Message-ID: <875yjhoj7g.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Baolin,

Baolin Wang <baolin.wang@linux.alibaba.com> writes:

> If THP is failed to migrate due to -ENOSYS or -ENOMEM case, the THP will
> be split, and the subpages of fail-to-migrate THP will be tried to migrate
> again, so we should not account the retry counter in the second loop, since
> we already accounted 'nr_thp_failed' in the first loop.
>
> Moreover we also do not need retry 10 times for -EAGAIN case for the subpages
> of fail-to-migrate THP in the second loop, since we already regarded the
> THP as migration failure, and save some migration time (for the worst case,
> will try 512 * 10 times) according to previous discussion [1].
>
> [1] https://lore.kernel.org/linux-mm/87r13a7n04.fsf@yhuang6-desk2.ccr.corp.intel.com/
>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

I have tested this patch, and it works as expected.

Tested-by: "Huang, Ying" <ying.huang@intel.com>

> ---
> Note, this patch is based on the patch set [1] from Huang Ying.
> [1] https://lore.kernel.org/linux-mm/20220711084948.274787-1-ying.huang@intel.com/

Please this patch is based on my patchset that hasn't been merged.  I
can add it as the last patch of my migrate_pages failure path fixing
patchset if you don't object.

Best Regards,
Huang, Ying

> ---
>  mm/migrate.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 8429206..e36a084 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1507,7 +1507,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>  			case -EAGAIN:
>  				if (is_thp)
>  					thp_retry++;
> -				else
> +				else if (!no_subpage_counting)
>  					retry++;
>  				nr_retry_pages += nr_subpages;
>  				break;
> @@ -1533,8 +1533,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>  			}
>  		}
>  	}
> -	if (!no_subpage_counting)
> -		nr_failed += retry;
> +	nr_failed += retry;
>  	nr_thp_failed += thp_retry;
>  	nr_failed_pages += nr_retry_pages;
>  	/*

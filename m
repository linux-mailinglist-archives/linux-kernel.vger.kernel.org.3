Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 098BB4FCBB4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 03:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347293AbiDLBNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 21:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351246AbiDLBBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 21:01:14 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DB91C108
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 17:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649725056; x=1681261056;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Aud1C1bU0YFrT2OMMryfkkUmardBCvVa+5tOlJ4O+fg=;
  b=O0FPf9QmgoRLJ+iTyaD4FZ5QHmlY+QozS0yCRAPl8CnxeVnP2e+LY+lc
   9hxI+1C6bJVkvEBTs47suMB4onVIVwQP5JZDVm9owuGFMb9sVywEFwQBj
   pLM9PRYa0tOViu4cBLkXvtlCX6KuFdBOasIaqHGches1KyteUKpyPsASg
   nCaMviq6+bPPwrt8WKYGTZzWryvMGBjdVb+2VpawcykFjSYdh50LO3eZa
   J5utRIE83s/v3KdTKf2fyH+fHHyQULMjoRbmCRkVS3U2BsGRAopgUH4xG
   CvrxoDZ6AMGRKIjdbwjn83WQ+HQzxTxcsZ/DrzNgEYbZWwSVuVFEyZCQP
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="244132534"
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="244132534"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 17:57:36 -0700
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="572493910"
Received: from joliu-mobl2.ccr.corp.intel.com ([10.254.214.243])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 17:57:34 -0700
Message-ID: <512fce32b8967ebc49f6fc074db408c117b510f7.camel@intel.com>
Subject: Re: [PATCH v2 4/9] mm/vmscan: save a bit of stack space in
 shrink_lruvec
From:   "ying.huang@intel.com" <ying.huang@intel.com>
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     songmuchun@bytedance.com, hch@infradead.org, willy@infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Tue, 12 Apr 2022 08:57:31 +0800
In-Reply-To: <20220409093500.10329-5-linmiaohe@huawei.com>
References: <20220409093500.10329-1-linmiaohe@huawei.com>
         <20220409093500.10329-5-linmiaohe@huawei.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-04-09 at 17:34 +0800, Miaohe Lin wrote:
> LRU_UNEVICTABLE is not taken into account when shrink lruvec. So we can
> save a bit of stack space by shrinking the array size of nr and targets
> to NR_LRU_LISTS - 1. No functional change intended.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/vmscan.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 59b96320f481..0e5818970998 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2881,8 +2881,9 @@ static bool can_age_anon_pages(struct pglist_data *pgdat,
>  
> 
>  static void shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
>  {
> -	unsigned long nr[NR_LRU_LISTS];
> -	unsigned long targets[NR_LRU_LISTS];
> +	/* LRU_UNEVICTABLE is not taken into account. */
> +	unsigned long nr[NR_LRU_LISTS - 1];
> +	unsigned long targets[NR_LRU_LISTS - 1];
>  	unsigned long nr_to_scan;
>  	enum lru_list lru;
>  	unsigned long nr_reclaimed = 0;

As Christoph pointed out, this is hacky without much benefit.  Please
drop this patch.

Best Regards,
Huang, Ying


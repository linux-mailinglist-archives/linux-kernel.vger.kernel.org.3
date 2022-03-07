Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12574CEF4A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 03:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234656AbiCGCEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 21:04:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbiCGCEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 21:04:11 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1889403C5
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 18:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646618597; x=1678154597;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=gqHtffotMITavlLD4voRnfx+PSyUPRZrq9IzbMQ+N1U=;
  b=kGl2Ryvdn4CXMgr6GRk06UoMabXRSpaWjLO8ZvYEpmNmjZgWs8FKGmBN
   fu/5v547LcUeQLGjLKDqmPZArRKEn7K39Eszy+458Zrmb3pfZpymR81YX
   dqVBElGZoVa5w2zQpmD1IOZ2BB6eFv2yUBG3CleQF6E6TkHPdq01AkMtv
   b3UZQpHj/lWL9UoOyXTM8HzUWiLFrvp6ikCTkwOSz9AGWSqXcwiXril5q
   UvBs0SBVv/hnsI6spZaXGJ1//BbD6DjN2ZtIuwQyEALW1u4S/db/gz+He
   OC91UYHkJQGBeWRV2Emj2ODQrj89tFjbEam9XdPmjYEbRDCZ59Cr0G0Vg
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10278"; a="314994763"
X-IronPort-AV: E=Sophos;i="5.90,160,1643702400"; 
   d="scan'208";a="314994763"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2022 18:03:17 -0800
X-IronPort-AV: E=Sophos;i="5.90,160,1643702400"; 
   d="scan'208";a="643066097"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2022 18:03:12 -0800
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
Subject: Re: [PATCH 02/16] mm/migration: remove unneeded out label
References: <20220304093409.25829-1-linmiaohe@huawei.com>
        <20220304093409.25829-3-linmiaohe@huawei.com>
Date:   Mon, 07 Mar 2022 10:03:09 +0800
In-Reply-To: <20220304093409.25829-3-linmiaohe@huawei.com> (Miaohe Lin's
        message of "Fri, 4 Mar 2022 17:33:55 +0800")
Message-ID: <877d967c4i.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miaohe Lin <linmiaohe@huawei.com> writes:

> We can do prep_transhuge_page when newpage is not NULL. Thus we can remove
> out label to simplify the code.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/migrate.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 50bc62d85eaf..bc1867a5706c 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2025,12 +2025,9 @@ static struct page *alloc_misplaced_dst_page_thp(struct page *page,
>  
>  	newpage = alloc_pages_node(nid, (GFP_TRANSHUGE_LIGHT | __GFP_THISNODE),
>  				   HPAGE_PMD_ORDER);
> -	if (!newpage)
> -		goto out;
> +	if (newpage)
> +		prep_transhuge_page(newpage);
>  
> -	prep_transhuge_page(newpage);
> -
> -out:
>  	return newpage;
>  }

I don't think this change is necessary.  The original code is simple and
follows the common practice for error processing.  The new code is OK,
but it's unnecessary to change.

Best Regards,
Huang, Ying

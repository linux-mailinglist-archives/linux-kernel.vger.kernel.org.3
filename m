Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 607A24FCBEA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 03:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245308AbiDLBiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 21:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbiDLBix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 21:38:53 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA7121244
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 18:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649727397; x=1681263397;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pQGXf75WjtOKpwGRrA2vxPYLcX3Vjo5dFDxMSXaxBfk=;
  b=fnwxDjtKWDNq2RjzO9vmcUp5tQ9sXU1yh9kKHgG0JtkjepMoy+W+4KgW
   FfdQuRSYkmXy831PAyDCgLvmKza2geMHW5dnJ0bYnPh8wtN9OI6zbO3Ng
   SPF9VoSQjvw23WvOepxPUqP6fRY9GIICqWlAUuaLF4jgQSabKt2h0tN7E
   wdKb2p9ykioHvBRX5DtXAa8rTfq6Q+Ajn/h7uainCnSXQDBeSr4VYELCJ
   ZbxOlXtrqogb7ajtJermsDoTQHfLacd1zT5NmksUpm9BSS1tQm7NbTM6t
   1wY8/d9IZZUZEAohTbakyTxiYL7ohwY1jSz8T+N06/rcMNpagygGUdbrP
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="261100757"
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="261100757"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 18:36:37 -0700
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="572503695"
Received: from joliu-mobl2.ccr.corp.intel.com ([10.254.214.243])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 18:36:34 -0700
Message-ID: <d628e99c1e3b1786a84e6e7a449c1b662c19b7aa.camel@intel.com>
Subject: Re: [PATCH v2 7/9] mm/vmscan: take min_slab_pages into account when
 try to call shrink_node
From:   "ying.huang@intel.com" <ying.huang@intel.com>
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org,
        Christoph Hellwig <hch@infradead.org>
Cc:     songmuchun@bytedance.com, hch@infradead.org, willy@infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>
Date:   Tue, 12 Apr 2022 09:36:31 +0800
In-Reply-To: <20220409093500.10329-8-linmiaohe@huawei.com>
References: <20220409093500.10329-1-linmiaohe@huawei.com>
         <20220409093500.10329-8-linmiaohe@huawei.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-04-09 at 17:34 +0800, Miaohe Lin wrote:
> Since commit 6b4f7799c6a5 ("mm: vmscan: invoke slab shrinkers from
> shrink_zone()"), slab reclaim and lru page reclaim are done together
> in the shrink_node. So we should take min_slab_pages into account
> when try to call shrink_node.
> 

Looks reasonable to me, copying Johannes.

Hi, Christoph,

Should we check min_unmapped_pages and min_slab_pages in shrink_node()
to avoid reclaim LRU when necessary and vice versa?  This may be done
via another 2 scan_control flags.

Best Regards,
Huang, Ying

> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/vmscan.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 53f1d0755b34..ba83d8f3e53e 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -4714,7 +4714,8 @@ static int __node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned in
>  	noreclaim_flag = memalloc_noreclaim_save();
>  	set_task_reclaim_state(p, &sc.reclaim_state);
>  
> 
> 
> 
> -	if (node_pagecache_reclaimable(pgdat) > pgdat->min_unmapped_pages) {
> +	if (node_pagecache_reclaimable(pgdat) > pgdat->min_unmapped_pages ||
> +	    node_page_state_pages(pgdat, NR_SLAB_RECLAIMABLE_B) > pgdat->min_slab_pages) {
>  		/*
>  		 * Free memory by calling shrink node with increasing
>  		 * priorities until we have enough memory freed.



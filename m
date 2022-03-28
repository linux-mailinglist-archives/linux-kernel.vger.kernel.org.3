Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60E444E8EBD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 09:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238750AbiC1HNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 03:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiC1HNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 03:13:14 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C243D52B1E
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 00:11:33 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KRkNM0qqXzfZRZ;
        Mon, 28 Mar 2022 15:09:55 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 28 Mar 2022 15:11:31 +0800
Subject: Re: [PATCH 1/2] mm/vmscan: reclaim only affects managed_zones
To:     Wei Yang <richard.weiyang@gmail.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <ying.huang@intel.com>, <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220327024101.10378-1-richard.weiyang@gmail.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <2028e2ed-7084-2ba0-faaf-dd71249c8334@huawei.com>
Date:   Mon, 28 Mar 2022 15:11:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220327024101.10378-1-richard.weiyang@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/27 10:41, Wei Yang wrote:
> As mentioned in commit 6aa303defb74 ("mm, vmscan: only allocate and
> reclaim from zones with pages managed by the buddy allocator") , reclaim
> only affects managed_zones.
> 
> Let's adjust the code and comment accordingly.
> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>

Looks good to me. Thanks.

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

> ---
>  mm/vmscan.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 7ad54b770bb1..89745cf34386 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1031,7 +1031,7 @@ static bool skip_throttle_noprogress(pg_data_t *pgdat)
>  	for (i = 0; i < MAX_NR_ZONES; i++) {
>  		struct zone *zone = pgdat->node_zones + i;
>  
> -		if (!populated_zone(zone))
> +		if (!managed_zone(zone))
>  			continue;
>  
>  		reclaimable += zone_reclaimable_pages(zone);
> @@ -3912,7 +3912,7 @@ static bool pgdat_balanced(pg_data_t *pgdat, int order, int highest_zoneidx)
>  	}
>  
>  	/*
> -	 * If a node has no populated zone within highest_zoneidx, it does not
> +	 * If a node has no managed zone within highest_zoneidx, it does not
>  	 * need balancing by definition. This can happen if a zone-restricted
>  	 * allocation tries to wake a remote kswapd.
>  	 */
> 


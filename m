Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC5374F6189
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 16:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234623AbiDFOTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 10:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235620AbiDFOS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 10:18:57 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08341A3945
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 19:38:05 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KY7tX03bwzgYLw;
        Wed,  6 Apr 2022 10:36:20 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 6 Apr 2022 10:38:03 +0800
Subject: Re: [PATCH] mm/slab: remove some unused functions
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     <roman.gushchin@linux.dev>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <cl@linux.com>,
        <penberg@kernel.org>, <rientjes@google.com>,
        <iamjoonsoo.kim@lge.com>, <akpm@linux-foundation.org>
References: <20220322091421.25285-1-linmiaohe@huawei.com>
 <b7871192-8c93-e478-e93f-be9e4150dd1f@suse.cz>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <3fc79634-da36-88c5-0e5d-10be704f9fb5@huawei.com>
Date:   Wed, 6 Apr 2022 10:38:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <b7871192-8c93-e478-e93f-be9e4150dd1f@suse.cz>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/4 20:49, Vlastimil Babka wrote:
> On 3/22/22 10:14, Miaohe Lin wrote:
>> alternate_node_alloc and ____cache_alloc_node are always called when
>> CONFIG_NUMA. So we can remove the unused !CONFIG_NUMA variant. Also
>> forward declaration for alternate_node_alloc is unnecessary. Remove
>> it too.
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
> 
> Adding to the slab tree, thanks.
> 
> Included also this move of declaration closer to its users:

Many thanks for doing this. :)

> 
> diff --git a/mm/slab.c b/mm/slab.c
> index 4ea12ddaa7db..90b16c7ae01a 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -626,8 +626,6 @@ static inline gfp_t gfp_exact_node(gfp_t flags)
>  
>  #else  /* CONFIG_NUMA */
>  
> -static void *____cache_alloc_node(struct kmem_cache *, gfp_t, int);
> -
>  static struct alien_cache *__alloc_alien_cache(int node, int entries,
>                                                 int batch, gfp_t gfp)
>  {
> @@ -3043,6 +3041,8 @@ static inline void *____cache_alloc(struct kmem_cache *cachep, gfp_t flags)
>  }
>  
>  #ifdef CONFIG_NUMA
> +static void *____cache_alloc_node(struct kmem_cache *, gfp_t, int);
> +
>  /*
>   * Try allocating on another node if PFA_SPREAD_SLAB is a mempolicy is set.
>   *
> 
> .
> 


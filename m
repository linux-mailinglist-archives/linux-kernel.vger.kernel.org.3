Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F998597B03
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 03:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242570AbiHRB0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 21:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233625AbiHRB0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 21:26:03 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6C1A0611
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 18:26:02 -0700 (PDT)
Received: from canpemm500006.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4M7Rvz5X3FzlWD6;
        Thu, 18 Aug 2022 09:22:55 +0800 (CST)
Received: from [10.67.110.83] (10.67.110.83) by canpemm500006.china.huawei.com
 (7.192.105.130) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 18 Aug
 2022 09:26:00 +0800
Subject: Re: [PATCH] arm:cache-l2x0: Fix resource leak in the l2x0_of_init()
 failed branch
To:     <linux-kernel@vger.kernel.org>, <linux@armlinux.org.uk>,
        <arnd@arndb.de>, <olof@lixom.net>, <21cnbao@gmail.com>,
        <grant.likely@secretlab.ca>, <santosh.shilimkar@ti.com>,
        <m.szyprowski@samsung.com>, <tony@atomide.com>,
        <t.figa@samsung.com>, <linux-arm-kernel@lists.infradead.org>
CC:     <wangle6@huawei.com>
References: <20211108040510.14494-1-nixiaoming@huawei.com>
From:   Xiaoming Ni <nixiaoming@huawei.com>
Message-ID: <efd37eb7-cfec-f974-19f1-e90cc7d7c268@huawei.com>
Date:   Thu, 18 Aug 2022 09:25:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0.1
MIME-Version: 1.0
In-Reply-To: <20211108040510.14494-1-nixiaoming@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.83]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500006.china.huawei.com (7.192.105.130)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping

On 2021/11/8 12:05, Xiaoming Ni wrote:
> During the code review, some problems were found in the function l2x0_of_init().
> 1. Do not call Of_put_node() after calling of_find_match_node().
> 2. When __l2c_init() is called for identification, l2x0_base is not released.
> 
> Invoking Of_put_node() and iounmap() is added to solve this problem.
> 
> Fixes: 8c369264b6de3 ("ARM: 7009/1: l2x0: Add OF based initialization")
> Fixes: 91c2ebb90b189 ("ARM: 7114/1: cache-l2x0: add resume entry for l2 in secure mode")
> Fixes: 6b49241ac2525 ("ARM: 8259/1: l2c: Refactor the driver to use commit-like interface")
> Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
> ---
>   arch/arm/mm/cache-l2x0.c | 17 ++++++++++++++---
>   1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
> index 43d91bfd2360..105bf7575cdf 100644
> --- a/arch/arm/mm/cache-l2x0.c
> +++ b/arch/arm/mm/cache-l2x0.c
> @@ -1766,17 +1766,22 @@ int __init l2x0_of_init(u32 aux_val, u32 aux_mask)
>   	u32 cache_id, old_aux;
>   	u32 cache_level = 2;
>   	bool nosync = false;
> +	int ret;
>   
>   	np = of_find_matching_node(NULL, l2x0_ids);
>   	if (!np)
>   		return -ENODEV;
>   
> -	if (of_address_to_resource(np, 0, &res))
> +	if (of_address_to_resource(np, 0, &res)) {
> +		of_put_node(np);
>   		return -ENODEV;
> +	}
>   
>   	l2x0_base = ioremap(res.start, resource_size(&res));
> -	if (!l2x0_base)
> +	if (!l2x0_base) {
> +		of_put_node(np);
>   		return -ENOMEM;
> +	}
>   
>   	l2x0_saved_regs.phy_base = res.start;
>   
> @@ -1820,6 +1825,12 @@ int __init l2x0_of_init(u32 aux_val, u32 aux_mask)
>   	else
>   		cache_id = readl_relaxed(l2x0_base + L2X0_CACHE_ID);
>   
> -	return __l2c_init(data, aux_val, aux_mask, cache_id, nosync);
> +	ret = _l2c_init(data, aux_val, aux_mask, cache_id, nosync);
> +	if (ret != 0) {
> +		iounmap(l2x0_base);
> +		l2x0_base = NULL;
> +	}
> +	of_put_node(np);
> +	return ret;
>   }
>   #endif
> 


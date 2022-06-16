Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF5A54D995
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 07:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349658AbiFPFM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 01:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiFPFM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 01:12:26 -0400
Received: from smtp.smtpout.orange.fr (smtp03.smtpout.orange.fr [80.12.242.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98595AED9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 22:12:24 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id 1hnpoMOui26JC1hnpo2ksk; Thu, 16 Jun 2022 07:12:23 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Thu, 16 Jun 2022 07:12:23 +0200
X-ME-IP: 90.11.190.129
Message-ID: <a5f6f76d-efc1-b421-7623-ad46996f5b94@wanadoo.fr>
Date:   Thu, 16 Jun 2022 07:12:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] drivers: soc: sifive: Add missing of_node_put() in
 sifive_l2_cache.c
Content-Language: fr
To:     Liang He <windhl@126.com>, palmer@dabbelt.com,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220615122315.3965435-1-windhl@126.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220615122315.3965435-1-windhl@126.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 15/06/2022 à 14:23, Liang He a écrit :
> In sifive_l2_init(), of_find_matching_node() will return a node pointer
> with refcount incremented. We should use of_node_put() in each fail path
> or when it is not used anymore.
> 
> Signed-off-by: Liang He <windhl@126.com>
> ---
>   drivers/soc/sifive/sifive_l2_cache.c | 29 ++++++++++++++++++++++------
>   1 file changed, 23 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/soc/sifive/sifive_l2_cache.c b/drivers/soc/sifive/sifive_l2_cache.c
> index 59640a1d0b28..2b9c9522ef21 100644
> --- a/drivers/soc/sifive/sifive_l2_cache.c
> +++ b/drivers/soc/sifive/sifive_l2_cache.c
> @@ -198,29 +198,41 @@ static int __init sifive_l2_init(void)
>   	struct resource res;
>   	int i, rc, intr_num;
>   

Hi,
this empty line is not needed.

> +	int ret;
> +
>   	np = of_find_matching_node(NULL, sifive_l2_ids);
>   	if (!np)
>   		return -ENODEV;
>   
>   	if (of_address_to_resource(np, 0, &res))
> -		return -ENODEV;
> +	{

this should be at the end of the previous line.

> +		ret = -ENODEV;
> +		goto out_put;
> +	}
>   
>   	l2_base = ioremap(res.start, resource_size(&res));
>   	if (!l2_base)
> -		return -ENOMEM;
> +	{
>

Same here.

  +		ret = -ENOMEM;
> +		goto out_put;
> +	}
>   
>   	intr_num = of_property_count_u32_elems(np, "interrupts");
> -	if (!intr_num) {
> +	if (!intr_num) {		
>   		pr_err("L2CACHE: no interrupts property\n");
> -		return -ENODEV;
> +		ret = -ENODEV

Missing ";" as reported by the bot.

> +		goto out_put;
>   	}
>   
>   	for (i = 0; i < intr_num; i++) {
>   		g_irq[i] = irq_of_parse_and_map(np, i);
>   		rc = request_irq(g_irq[i], l2_int_handler, 0, "l2_ecc", NULL);
> +		
>   		if (rc) {
> +			

Why a new empty line here?

>   			pr_err("L2CACHE: Could not request IRQ %d\n", g_irq[i]);
> -			return rc;
> +			ret = rc;
> +			goto out_put;
>   		}
>   	}
>   
> @@ -232,6 +244,11 @@ static int __init sifive_l2_init(void)
>   #ifdef CONFIG_DEBUG_FS
>   	setup_sifive_debug();
>   #endif
> -	return 0;
> +	ret = 0;
> +	
> +	

No need for 2 empty lines here.


There are also some trailing white spaces on some lines.

"./scripts/checkpatch <name_of_the_patch>" catches some of these tiny 
issues. Using --strict catches even more of these issues.

You should also always at least compile test your patches, even if they 
look obvious,

CJ


> +out_put:
> +	of_node_put(np);
> +	return ret;
>   }
>   device_initcall(sifive_l2_init);


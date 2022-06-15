Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42E954C64E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 12:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242129AbiFOKfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 06:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236849AbiFOKfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 06:35:37 -0400
Received: from mail.bugwerft.de (mail.bugwerft.de [46.23.86.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CCD384EF77
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 03:35:36 -0700 (PDT)
Received: from [10.10.0.82] (unknown [194.162.236.226])
        by mail.bugwerft.de (Postfix) with ESMTPSA id B34E6282FB6;
        Wed, 15 Jun 2022 10:35:05 +0000 (UTC)
Message-ID: <2ab4dcea-b365-cb1c-7ab4-67c9e39df83b@zonque.org>
Date:   Wed, 15 Jun 2022 12:35:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] [Re-PATCH] arch: arm: mach-pxa: Add missing of_node_put
 in irq.c
Content-Language: en-US
To:     heliang <windhl@126.com>, haojian.zhuang@gmail.com,
        robert.jarzmik@free.fr, linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220615103332.3963303-1-windhl@126.com>
From:   Daniel Mack <daniel@zonque.org>
In-Reply-To: <20220615103332.3963303-1-windhl@126.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/22 12:33, heliang wrote:
> In pxa_dt_irq_init(), of_find_matching_node() will return a node
> pointer with refcount incremented. We should use of_node_put in
> fail path or when it is not used anymore. This goto-label patch
> style is advised by Daniel.
> 
> Signed-off-by: heliang <windhl@126.com>

Thanks for your patch!

Acked-by: Daniel Mack <daniel@zonque.org>

> ---
>  arch/arm/mach-pxa/irq.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-pxa/irq.c b/arch/arm/mach-pxa/irq.c
> index 96f33ef1d9ea..338356b9f37c 100644
> --- a/arch/arm/mach-pxa/irq.c
> +++ b/arch/arm/mach-pxa/irq.c
> @@ -247,13 +247,13 @@ void __init pxa_dt_irq_init(int (*fn)(struct irq_data *, unsigned int))
>  				   &pxa_internal_irq_nr);
>  	if (ret) {
>  		pr_err("Not found marvell,intc-nr-irqs property\n");
> -		return;
> +		goto out_put;
>  	}
>  
>  	ret = of_address_to_resource(node, 0, &res);
>  	if (ret < 0) {
>  		pr_err("No registers defined for node\n");
> -		return;
> +		goto out_put;
>  	}
>  	pxa_irq_base = io_p2v(res.start);
>  
> @@ -263,9 +263,12 @@ void __init pxa_dt_irq_init(int (*fn)(struct irq_data *, unsigned int))
>  	ret = irq_alloc_descs(-1, 0, pxa_internal_irq_nr, 0);
>  	if (ret < 0) {
>  		pr_err("Failed to allocate IRQ numbers\n");
> -		return;
> +		goto out_put;
>  	}
>  
>  	pxa_init_irq_common(node, pxa_internal_irq_nr, fn);
> +	
> +out_put:
> +	of_node_put(node);	
>  }
>  #endif /* CONFIG_OF */


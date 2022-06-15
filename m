Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64EDA54C538
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 11:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240043AbiFOJ6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 05:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbiFOJ55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 05:57:57 -0400
X-Greylist: delayed 460 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 15 Jun 2022 02:57:55 PDT
Received: from mail.bugwerft.de (mail.bugwerft.de [46.23.86.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8AE9713D15
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 02:57:53 -0700 (PDT)
Received: from [10.10.0.82] (unknown [194.162.236.226])
        by mail.bugwerft.de (Postfix) with ESMTPSA id 82BA7282FB6;
        Wed, 15 Jun 2022 09:49:41 +0000 (UTC)
Message-ID: <2dbaed8b-1a19-6bed-5b5b-bebff4b0648e@zonque.org>
Date:   Wed, 15 Jun 2022 11:49:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] arch: arm: mach-pxa: Add missing of_node_put in irq.c
Content-Language: en-US
To:     heliang <windhl@126.com>, haojian.zhuang@gmail.com,
        robert.jarzmik@free.fr, linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220615091240.3961831-1-windhl@126.com>
From:   Daniel Mack <daniel@zonque.org>
In-Reply-To: <20220615091240.3961831-1-windhl@126.com>
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

Hi,

On 6/15/22 11:12, heliang wrote:
> In pxa_dt_irq_init(), of_find_matching_node() will return a node
> pointer with refcount incremented. We should use of_node_put in
> fail path or when it is not used anymore.
> 
> Signed-off-by: heliang <windhl@126.com>
> ---
>  arch/arm/mach-pxa/irq.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/mach-pxa/irq.c b/arch/arm/mach-pxa/irq.c
> index 96f33ef1d9ea..a81e9ffb77af 100644
> --- a/arch/arm/mach-pxa/irq.c
> +++ b/arch/arm/mach-pxa/irq.c
> @@ -246,12 +246,14 @@ void __init pxa_dt_irq_init(int (*fn)(struct irq_data *, unsigned int))
>  	ret = of_property_read_u32(node, "marvell,intc-nr-irqs",
>  				   &pxa_internal_irq_nr);
>  	if (ret) {
> +		of_node_put(node);
>  		pr_err("Not found marvell,intc-nr-irqs property\n");
>  		return;

How about jumping to a label here instead of a plain "return"?

>  	}
>  
>  	ret = of_address_to_resource(node, 0, &res);
>  	if (ret < 0) {
> +		of_node_put(node);
>  		pr_err("No registers defined for node\n");
>  		return;

Same here.

>  	}
> @@ -262,10 +264,12 @@ void __init pxa_dt_irq_init(int (*fn)(struct irq_data *, unsigned int))
>  
>  	ret = irq_alloc_descs(-1, 0, pxa_internal_irq_nr, 0);
>  	if (ret < 0) {
> +		of_node_put(node);
>  		pr_err("Failed to allocate IRQ numbers\n");
>  		return;

And here.

>  	}
>  
>  	pxa_init_irq_common(node, pxa_internal_irq_nr, fn);

Jump target would go here.

> +	of_node_put(node);
>  }
>  #endif /* CONFIG_OF */


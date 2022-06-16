Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E805254E9B0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 20:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378083AbiFPSyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 14:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378075AbiFPSyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 14:54:35 -0400
Received: from smtp.smtpout.orange.fr (smtp09.smtpout.orange.fr [80.12.242.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56FE54180
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 11:54:33 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id 1udRoksXxV0xU1udRoKAnN; Thu, 16 Jun 2022 20:54:32 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Thu, 16 Jun 2022 20:54:32 +0200
X-ME-IP: 90.11.190.129
Message-ID: <bc6eaf7e-ff88-9b82-eae7-7e6902c33a10@wanadoo.fr>
Date:   Thu, 16 Jun 2022 20:54:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] arch: powerpc: platforms: 85xx: Add missing
 of_node_put in sgy_cts1000.c
Content-Language: fr
To:     Liang He <windhl@126.com>, oss@buserror.net, mpe@ellerman.id.au,
        paulus@samba.org, christophe.leroy@csgroup.eu,
        nixiaoming@huawei.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20220616151901.3989078-1-windhl@126.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220616151901.3989078-1-windhl@126.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 16/06/2022 à 17:19, Liang He a écrit :
> In gpio_halt_probe(), of_find_matching_node() will return a node pointer with
> refcount incremented. We should use of_node_put() in each fail path or when it
> is not used anymore.
> 
> Signed-off-by: Liang He <windhl@126.com>
> ---
>   changelog:
> 
>   v2: use goto-label patch style advised by Christophe.
>   v1: add of_node_put() before each exit.
> 
>   arch/powerpc/platforms/85xx/sgy_cts1000.c | 27 +++++++++++++++--------
>   1 file changed, 18 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/85xx/sgy_cts1000.c b/arch/powerpc/platforms/85xx/sgy_cts1000.c
> index 98ae64075193..e280f963d88c 100644
> --- a/arch/powerpc/platforms/85xx/sgy_cts1000.c
> +++ b/arch/powerpc/platforms/85xx/sgy_cts1000.c
> @@ -73,6 +73,7 @@ static int gpio_halt_probe(struct platform_device *pdev)
>   	struct device_node *node = pdev->dev.of_node;
>   	int gpio, err, irq;
>   	int trigger;
> +	int ret;
>   
>   	if (!node)
>   		return -ENODEV;
> @@ -84,20 +85,24 @@ static int gpio_halt_probe(struct platform_device *pdev)
>   
>   	/* Technically we could just read the first one, but punish
>   	 * DT writers for invalid form. */
> -	if (of_gpio_count(halt_node) != 1)
> -		return -EINVAL;
> +	if (of_gpio_count(halt_node) != 1) {
> +		ret = -EINVAL;
> +		goto err_put;
> +	}
>   
>   	/* Get the gpio number relative to the dynamic base. */
>   	gpio = of_get_gpio_flags(halt_node, 0, &flags);
> -	if (!gpio_is_valid(gpio))
> -		return -EINVAL;
> +	if (!gpio_is_valid(gpio)) {
> +		ret = -EINVAL;
> +		gotot err_put;
> +	}
>   
>   	err = gpio_request(gpio, "gpio-halt");
>   	if (err) {
>   		printk(KERN_ERR "gpio-halt: error requesting GPIO %d.\n",
>   		       gpio);
> -		halt_node = NULL;
> -		return err;
> +		ret = err;
> +		goto err_put;
>   	}
>   
>   	trigger = (flags == OF_GPIO_ACTIVE_LOW);
> @@ -112,8 +117,8 @@ static int gpio_halt_probe(struct platform_device *pdev)
>   		printk(KERN_ERR "gpio-halt: error requesting IRQ %d for "
>   		       "GPIO %d.\n", irq, gpio);
>   		gpio_free(gpio);
> -		halt_node = NULL;
> -		return err;
> +		ret = err;
> +		goto err_put;
>   	}
>   
>   	/* Register our halt function */
> @@ -122,8 +127,12 @@ static int gpio_halt_probe(struct platform_device *pdev)
>   
>   	printk(KERN_INFO "gpio-halt: registered GPIO %d (%d trigger, %d"
>   	       " irq).\n", gpio, trigger, irq);
> +	ret = 0;
>   
> -	return 0;
> +err_put:
> +	of_node_put(halt_node);
> +	halt_node = NULL;

Hi,
so now we set 'halt_node' to NULL even in the normal case.
This is really spurious.

Look at gpio_halt_cb(), but I think that this is just wrong and badly 
breaks this driver.

CJ


> +	return ret;
>   }
>   
>   static int gpio_halt_remove(struct platform_device *pdev)


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8DE592AD4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 10:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241416AbiHOHiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 03:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232631AbiHOHiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 03:38:17 -0400
Received: from smtp.smtpout.orange.fr (smtp09.smtpout.orange.fr [80.12.242.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6725DDF7B
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 00:38:15 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id NUfsoyReCtUbyNUfsoBx0o; Mon, 15 Aug 2022 09:38:13 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 15 Aug 2022 09:38:13 +0200
X-ME-IP: 90.11.190.129
Message-ID: <271c00a5-fb5d-ff9e-3c4d-ec2732b991ba@wanadoo.fr>
Date:   Mon, 15 Aug 2022 09:38:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 1/1] gpio: mpfs: add polarfire soc gpio support
Content-Language: fr
To:     lewis.hanly@microchip.com, linux-gpio@vger.kernel.org,
        linux-riscv@lists.infradead.org, linus.walleij@linaro.org,
        brgl@bgdev.pl, linux-kernel@vger.kernel.org, palmer@dabbelt.com,
        maz@kernel.org
Cc:     conor.dooley@microchip.com, daire.mcnamara@microchip.com
References: <20220815070606.1298421-1-lewis.hanly@microchip.com>
 <20220815070606.1298421-2-lewis.hanly@microchip.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220815070606.1298421-2-lewis.hanly@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 15/08/2022 à 09:06, lewis.hanly@microchip.com a écrit :
> From: Lewis Hanly <lewis.hanly@microchip.com>
> 
> Add a driver to support the Polarfire SoC gpio controller
> 
> Signed-off-by: Lewis Hanly <lewis.hanly@microchip.com>
> ---
>   drivers/gpio/Kconfig     |   7 +
>   drivers/gpio/Makefile    |   1 +
>   drivers/gpio/gpio-mpfs.c | 318 +++++++++++++++++++++++++++++++++++++++
>   3 files changed, 326 insertions(+)
>   create mode 100644 drivers/gpio/gpio-mpfs.c
> 

> +static int mpfs_gpio_probe(struct platform_device *pdev)
> +{
> +	struct clk *clk;
> +	struct device *dev = &pdev->dev;
> +	struct device_node *node = pdev->dev.of_node;
> +	struct mpfs_gpio_chip *mpfs_gpio;
> +	struct gpio_irq_chip *girq;
> +	int i, ret, ngpios, nirqs;
> +
> +	mpfs_gpio = devm_kzalloc(dev, sizeof(*mpfs_gpio), GFP_KERNEL);
> +	if (!mpfs_gpio)
> +		return -ENOMEM;
> +
> +	mpfs_gpio->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(mpfs_gpio->base))
> +		return dev_err_probe(dev, PTR_ERR(mpfs_gpio->clk), "input clock not found.\n");

PTR_ERR(mpfs_gpio->base)?
"input clock not found" also looks odd after a 
devm_platform_ioremap_resource() call.

> +
> +	clk = devm_clk_get(dev, NULL);
> +	if (IS_ERR(clk))
> +		return dev_err_probe(dev, PTR_ERR(clk), "devm_clk_get failed\n");
> +

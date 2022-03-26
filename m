Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9E54E800F
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 09:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbiCZInR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 04:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiCZInQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 04:43:16 -0400
Received: from mxout03.lancloud.ru (mxout03.lancloud.ru [45.84.86.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC21DB6E7D;
        Sat, 26 Mar 2022 01:41:35 -0700 (PDT)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout03.lancloud.ru DA04E20A8247
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH v1 5/5] pinctrl: armada-37xx: Replace custom code by
 gpiochip_count() call
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Fabien Dessenne <fabien.dessenne@foss.st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
CC:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        "Martin Blumenstingl" <martin.blumenstingl@googlemail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
References: <20220325200338.54270-1-andriy.shevchenko@linux.intel.com>
 <20220325200338.54270-5-andriy.shevchenko@linux.intel.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <3415996d-e8b5-2416-fb66-e65779a9b507@omp.ru>
Date:   Sat, 26 Mar 2022 11:41:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220325200338.54270-5-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 3/25/22 11:03 PM, Andy Shevchenko wrote:

> Since we have generic function to count GPIO controller nodes
> under given device, there is no need to open code it. Replace
> custom code by gpiochip_count() call.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/pinctrl/mvebu/pinctrl-armada-37xx.c | 24 +++++++++------------
>  1 file changed, 10 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
> index 08cad14042e2..ba94125f6566 100644
> --- a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
> +++ b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
> @@ -728,22 +728,18 @@ static int armada_37xx_irqchip_register(struct platform_device *pdev,
>  	struct gpio_irq_chip *girq = &gc->irq;
>  	struct device *dev = &pdev->dev;
>  	struct device_node *np;
> -	int ret = -ENODEV, i, nr_irq_parent;
> +	unsigned int nr_child_nodes, i;
> +	int ret;
>  
>  	/* Check if we have at least one gpio-controller child node */
> -	for_each_child_of_node(dev->of_node, np) {
> -		if (of_property_read_bool(np, "gpio-controller")) {
> -			ret = 0;
> -			break;
> -		}
> -	}
> -	if (ret)
> -		return dev_err_probe(dev, ret, "no gpio-controller child node\n");
> +	nr_child_nodes = gpiochip_count(dev);
> +	if (!nr_child_nodes)
> +		return dev_err_probe(dev, -ENODEV, "no gpio-controller child node\n");
>  
> -	nr_irq_parent = of_irq_count(np);
>  	spin_lock_init(&info->irq_lock);
>  
> -	if (!nr_irq_parent) {
> +	nr_child_nodes = of_irq_count(np);

   Mhm, 'np' is no longer assigned to at this point...

> +	if (!nr_child_nodes) {
>  		dev_err(dev, "invalid or no IRQ\n");
>  		return 0;
>  	}
[...]

MBR, Sergey

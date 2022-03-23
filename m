Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 835D94E49E5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 01:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240842AbiCWAG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 20:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiCWAGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 20:06:24 -0400
Received: from gateway24.websitewelcome.com (gateway24.websitewelcome.com [192.185.51.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DAD85DE77
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 17:04:55 -0700 (PDT)
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 84CD05D113
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 19:04:54 -0500 (CDT)
Received: from 162-215-252-75.unifiedlayer.com ([208.91.199.152])
        by cmsmtp with SMTP
        id WoUgnFB2wHnotWoUgnIP9W; Tue, 22 Mar 2022 19:04:54 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:Subject:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=9qinQlsidghVtceQvZk5+L7j2X96kkQsiTPjZ9J4fcM=; b=IWO9tUoOpc7Z5gIPbS6ezytqOs
        4XCl8BtLmQHx/kksQGGQxk41pi91aZCOzDs9Q6kkVhAQX0UQwMEoQOLmXAf4iTDqkQKmo/Xh16R7f
        BliKmD3DMno9dIe2v+y998HTAEg4uzs3djJoqRYsirTAK3ZpuLdaq3CELNxlawOU48I+hAWfIXMEd
        uZfG+tiBppuXm6wcnCiP80aPkJBui0BSQ9Xrh5CUjZ7FjoPxrkKyqOnLg7E1/xTfw8wwVypnxcjGk
        hkB+fgXhgHAJuYqHXdbznGKWDrqhqgtyO7Zoza0NAIndPTvUUzDmai3jfpkTElsHT8OSyDVARNzpR
        fcocgXgA==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:54408)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@roeck-us.net>)
        id 1nWoUg-002pNL-2q; Wed, 23 Mar 2022 00:04:54 +0000
Message-ID: <8b41a486-92af-2f2d-ba05-205650a90ee2@roeck-us.net>
Date:   Tue, 22 Mar 2022 17:04:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Tobias Waldekranz <tobias@waldekranz.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220322222911.519238-1-tobias@waldekranz.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] watchdog: gpio_wdt: Support GPO lines with the toggle
 algorithm
In-Reply-To: <20220322222911.519238-1-tobias@waldekranz.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1nWoUg-002pNL-2q
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net [108.223.40.66]:54408
X-Source-Auth: linux@roeck-us.net
X-Email-Count: 1
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/22 15:29, Tobias Waldekranz wrote:
> Support using GPO lines (i.e. GPIOs that are output-only) with
> gpio_wdt using the "toggle" algorithm.
> 
> Since its inception, gpio_wdt has configured its GPIO line as an input
> when using the "toggle" algorithm, even though it is used as an output
> when kicking. This needlessly barred hardware with output-only pins
> from using the driver.
> 
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
> ---
> 
> Hi,
> 
> This patch has been in our downstream tree for a long time. We need it
> because our kick GPIO can't be used as an input.
> 
> What I really can't figure out is why the driver would request the pin
> as in input, when it's always going to end up being used as an output
> anyway.
> 
> So I thought I'd send it upstream in the hopes of either getting it
> merged, or an explanation as to why it is needed.
> 

I _think_ the assumption / idea was that "toggle" implies that the output
is connected to a pull-up resistor and that the pin either floats or is
pulled down to ground, causing the signal to toggle. I don't know if/how
that works in practice, though.

Guenter

>   drivers/watchdog/gpio_wdt.c | 13 +++++--------
>   1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/watchdog/gpio_wdt.c b/drivers/watchdog/gpio_wdt.c
> index 0923201ce874..f7686688e0e2 100644
> --- a/drivers/watchdog/gpio_wdt.c
> +++ b/drivers/watchdog/gpio_wdt.c
> @@ -108,7 +108,6 @@ static int gpio_wdt_probe(struct platform_device *pdev)
>   	struct device *dev = &pdev->dev;
>   	struct device_node *np = dev->of_node;
>   	struct gpio_wdt_priv *priv;
> -	enum gpiod_flags gflags;
>   	unsigned int hw_margin;
>   	const char *algo;
>   	int ret;
> @@ -122,17 +121,15 @@ static int gpio_wdt_probe(struct platform_device *pdev)
>   	ret = of_property_read_string(np, "hw_algo", &algo);
>   	if (ret)
>   		return ret;
> -	if (!strcmp(algo, "toggle")) {
> +
> +	if (!strcmp(algo, "toggle"))
>   		priv->hw_algo = HW_ALGO_TOGGLE;
> -		gflags = GPIOD_IN;
> -	} else if (!strcmp(algo, "level")) {
> +	else if (!strcmp(algo, "level"))
>   		priv->hw_algo = HW_ALGO_LEVEL;
> -		gflags = GPIOD_OUT_LOW;
> -	} else {
> +	else
>   		return -EINVAL;
> -	}
>   
> -	priv->gpiod = devm_gpiod_get(dev, NULL, gflags);
> +	priv->gpiod = devm_gpiod_get(dev, NULL, GPIOD_OUT_LOW);
>   	if (IS_ERR(priv->gpiod))
>   		return PTR_ERR(priv->gpiod);
>   


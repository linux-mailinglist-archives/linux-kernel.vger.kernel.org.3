Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5274F9CA9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 20:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238682AbiDHS0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 14:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238672AbiDHSZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 14:25:36 -0400
Received: from smtp.smtpout.orange.fr (smtp10.smtpout.orange.fr [80.12.242.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFF038FEFE
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 11:23:28 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.180.246])
        by smtp.orange.fr with ESMTPA
        id ctGUnWKJjD97rctGVn6qy3; Fri, 08 Apr 2022 20:23:26 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Fri, 08 Apr 2022 20:23:26 +0200
X-ME-IP: 86.243.180.246
Message-ID: <d08f3202-54f1-4c5a-01bd-70816a917b50@wanadoo.fr>
Date:   Fri, 8 Apr 2022 20:23:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v5 2/2] leds: ktd2692: Make aux-gpios optional
Content-Language: en-GB
To:     Markuss Broks <markuss.broks@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org
References: <20220408175929.281453-1-markuss.broks@gmail.com>
 <20220408175929.281453-3-markuss.broks@gmail.com>
From:   Marion & Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220408175929.281453-3-markuss.broks@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 08/04/2022 à 19:59, Markuss Broks a écrit :
> Make the AUX pin optional, since it isn't a core part of functionality,
> and the device is designed to be operational with only one CTRL pin.
>
> Also pick up maintenance for the LED driver and the yaml bindings.
>
> Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
> ---
>   MAINTAINERS                       | 6 ++++++
>   drivers/leds/flash/leds-ktd2692.c | 4 ++--
>   2 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2db49ea7ae55..8ef5667a1d98 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10479,6 +10479,12 @@ S:	Maintained
>   F:	Documentation/devicetree/bindings/leds/backlight/kinetic,ktd253.yaml
>   F:	drivers/video/backlight/ktd253-backlight.c
>   
> +KTD2692 FLASH LED DRIVER
> +M:	Markuss Broks <markuss.broks@gmail.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/leds/backlight/kinetic,ktd2692.yaml
> +F:	drivers/leds/flash/leds-ktd2692.yaml
> +
>   KTEST
>   M:	Steven Rostedt <rostedt@goodmis.org>
>   M:	John Hawley <warthog9@eaglescrag.net>
> diff --git a/drivers/leds/flash/leds-ktd2692.c b/drivers/leds/flash/leds-ktd2692.c
> index f341da1503a4..fc9c2e441caa 100644
> --- a/drivers/leds/flash/leds-ktd2692.c
> +++ b/drivers/leds/flash/leds-ktd2692.c
> @@ -284,8 +284,8 @@ static int ktd2692_parse_dt(struct ktd2692_context *led, struct device *dev,
>   		return ret;
>   	}
>   
> -	led->aux_gpio = devm_gpiod_get(dev, "aux", GPIOD_ASIS);
> -	ret = PTR_ERR_OR_ZERO(led->aux_gpio);
> +	led->aux_gpio = devm_gpiod_get_optional(dev, "aux", GPIOD_ASIS);
> +	ret = PTR_ERR(led->aux_gpio);
>   	if (ret) {
>   		dev_err(dev, "cannot get aux-gpios %d\n", ret);
>   		return ret;

Hi,

Sorry if I was unclear. What I was meaning is below.

This v5 is just wrong. If 'led->aux_gpio' is a valid pointer, then 
'PTR_ERR(led->aux_gpio)' will be non-0 and you will bail-out with a 
pointless error value.

PTR_ERR(x) is a valid error value if IS_ERR(x) is true. Otherwise it is 
just 'x' casted as a long. So if 'x' is valid, it can be anything.


What I had in mind was more something like:

@@ -284,10 +284,9 @@ static int ktd2692_parse_dt(struct ktd2692_context *led, struct device *dev,
  		return ret;
  	}
  
-	led->aux_gpio = devm_gpiod_get(dev, "aux", GPIOD_ASIS);
-	ret = PTR_ERR_OR_ZERO(led->aux_gpio);
-	if (ret) {
-		dev_err(dev, "cannot get aux-gpios %d\n", ret);
+	led->aux_gpio = devm_gpiod_get_optional(dev, "aux", GPIOD_ASIS);
+	if (IS_ERR(led->aux_gpio)) {
+		ret = PTR_ERR(led->aux_gpio);
+		dev_err(dev, "cannot get aux-gpios: %d\n", ret);
  		return ret;
  	}
  


I guess that using PTR_ERR_OR_ZERO() is an option (like in the original 
code) but personally I find it less readable (but it is just a matter of 
taste)

CJ


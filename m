Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD914F9B2C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 18:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234773AbiDHRAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 13:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234593AbiDHRAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 13:00:08 -0400
Received: from smtp.smtpout.orange.fr (smtp09.smtpout.orange.fr [80.12.242.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B658343301
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 09:58:01 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.180.246])
        by smtp.orange.fr with ESMTPA
        id crvlnGf4Gs0FRcrvlnrZPt; Fri, 08 Apr 2022 18:57:59 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Fri, 08 Apr 2022 18:57:59 +0200
X-ME-IP: 86.243.180.246
Message-ID: <f0f934b8-2e97-2b9a-76de-e1cb217fc58c@wanadoo.fr>
Date:   Fri, 8 Apr 2022 18:57:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 2/2] leds: ktd2692: Make aux-gpios optional
Content-Language: fr
To:     Markuss Broks <markuss.broks@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org
References: <20220408163330.200898-1-markuss.broks@gmail.com>
 <20220408163330.200898-3-markuss.broks@gmail.com>
From:   Marion & Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220408163330.200898-3-markuss.broks@gmail.com>
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


Le 08/04/2022 à 18:33, Markuss Broks a écrit :
> Make the AUX pin optional, since it isn't a core part of functionality,
> and the device is designed to be operational with only one CTRL pin.
>
> Also pick up maintenance for the LED driver and the yaml bindings.
>
> Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
> ---
>   MAINTAINERS                       | 6 ++++++
>   drivers/leds/flash/leds-ktd2692.c | 7 +++----
>   2 files changed, 9 insertions(+), 4 deletions(-)
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
> index f341da1503a4..26edf41dfa7d 100644
> --- a/drivers/leds/flash/leds-ktd2692.c
> +++ b/drivers/leds/flash/leds-ktd2692.c
> @@ -284,10 +284,9 @@ static int ktd2692_parse_dt(struct ktd2692_context *led, struct device *dev,
>   		return ret;
>   	}
>   
> -	led->aux_gpio = devm_gpiod_get(dev, "aux", GPIOD_ASIS);
> -	ret = PTR_ERR_OR_ZERO(led->aux_gpio);
> -	if (ret) {
> -		dev_err(dev, "cannot get aux-gpios %d\n", ret);
> +	led->aux_gpio = devm_gpiod_get_optional(dev, "aux", GPIOD_ASIS);
> +	if (IS_ERR(led->aux_gpio)) {
> +		dev_err(dev, "cannot get aux-gpios: %d\n", ret);
>   		return ret;

Hi,

'ret' is known to be 0 at this point.
maybe adding:
    ret = PTR_ERR(led->aux_gpio);

?

CJ

>   	}
>   

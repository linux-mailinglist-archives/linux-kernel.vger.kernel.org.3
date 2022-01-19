Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0316A493F28
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 18:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356372AbiASRhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 12:37:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352552AbiASRho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 12:37:44 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D9FC061574;
        Wed, 19 Jan 2022 09:37:43 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 0DB601C000B;
        Wed, 19 Jan 2022 17:37:40 +0000 (UTC)
Date:   Wed, 19 Jan 2022 18:37:40 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: pcf2127: add error message if writing to CLKOUT
 register fails
Message-ID: <YehMZC4vduvSH5HA@piout.net>
References: <20220119172740.1856302-1-hugo@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220119172740.1856302-1-hugo@hugovil.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/01/2022 12:27:39-0500, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> If writing to CLKOUT register fails, the probe operation will be aborted
> without a meaningful error message.
> 

The current trend is to remove debug messages, please do not add more :)

> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> ---
>  drivers/rtc/rtc-pcf2127.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
> index 3d1f57e54372..823abe2a7147 100644
> --- a/drivers/rtc/rtc-pcf2127.c
> +++ b/drivers/rtc/rtc-pcf2127.c
> @@ -717,8 +717,10 @@ static int pcf2127_probe(struct device *dev, struct regmap *regmap,
>  	if (!(val & PCF2127_BIT_CLKOUT_OTPR)) {
>  		ret = regmap_set_bits(pcf2127->regmap, PCF2127_REG_CLKOUT,
>  				      PCF2127_BIT_CLKOUT_OTPR);
> -		if (ret < 0)
> +		if (ret < 0) {
> +			dev_err(dev, "writing to CLKOUT register failed\n");
>  			return ret;
> +		}
>  
>  		msleep(100);
>  	}
> -- 
> 2.30.2
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

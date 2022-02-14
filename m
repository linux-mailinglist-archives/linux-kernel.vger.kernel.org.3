Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B584B54E8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 16:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355930AbiBNPgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 10:36:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350750AbiBNPgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 10:36:13 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A504AE3C;
        Mon, 14 Feb 2022 07:36:04 -0800 (PST)
Received: (Authenticated sender: gregory.clement@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id E74B61BF206;
        Mon, 14 Feb 2022 15:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1644852963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wZaVsNZfL1Y9JFue2k1wM/baHSjDOG975omNd7JZ0b8=;
        b=aqQuBbvuyYLqCNZtSOtTuL3CX+GcC3c1knhe2FBkGI27DstNgcmIo8dkzUj/I2g4J8TYyF
        EhbnU/edAwqFoVwmDRxyHAECs2UI4JIpwRIBIRaU/UeZD9p/osq9HR9WlAb03yBwTuZM2b
        w1tvyXusl4cS7GwmsD0ueu6zvHf1OLII2BSkzggnWkFOmV7YZECIm0zYRwfumU51KdgTS+
        NnmMuX9PDCkZBoGIjmXxUU1K2IiL4oZ4VFt0wOP7pGqJOP8oOq3I6gOLHbE0Ei7nhNgR00
        3LwTisFaYjlmxha4VWUbVHCjnOm0FeGnUBZzBFBUpOXmMFvASN+ABniCj/HzNg==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>, andrew@lunn.ch,
        robh+dt@kernel.org, wim@linux-watchdog.org, linux@roeck-us.net
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: Re: [PATCH 2/2] watchdog: orion_wdt: support pretimeout on Armada-XP
In-Reply-To: <20220211003257.2037332-3-chris.packham@alliedtelesis.co.nz>
References: <20220211003257.2037332-1-chris.packham@alliedtelesis.co.nz>
 <20220211003257.2037332-3-chris.packham@alliedtelesis.co.nz>
Date:   Mon, 14 Feb 2022 16:36:01 +0100
Message-ID: <87r185jw9q.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Packham <chris.packham@alliedtelesis.co.nz> writes:

> Commit e07a4c79ca75 ("watchdog: orion_wdt: use timer1 as a pretimeout")
> added support for a pretimeout on Armada-38x variants. Because the
> Armada-XP variants use armada370_start/armada370_stop (due to missing an
> explicit RSTOUT mask bit for the watchdog). Add the required pretimeout
> support to armada370_start/armada370_stop for Armada-XP.
>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Reviewed-by: Gregory CLEMENT <gregory.clement@bootlin.com>

Thanks,

Gregory

> ---
>  drivers/watchdog/orion_wdt.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
> index 127eefc9161d..e25e6bf4647f 100644
> --- a/drivers/watchdog/orion_wdt.c
> +++ b/drivers/watchdog/orion_wdt.c
> @@ -238,8 +238,10 @@ static int armada370_start(struct watchdog_device *wdt_dev)
>  	atomic_io_modify(dev->reg + TIMER_A370_STATUS, WDT_A370_EXPIRED, 0);
>  
>  	/* Enable watchdog timer */
> -	atomic_io_modify(dev->reg + TIMER_CTRL, dev->data->wdt_enable_bit,
> -						dev->data->wdt_enable_bit);
> +	reg = dev->data->wdt_enable_bit;
> +	if (dev->wdt.info->options & WDIOF_PRETIMEOUT)
> +		reg |= TIMER1_ENABLE_BIT;
> +	atomic_io_modify(dev->reg + TIMER_CTRL, reg, reg);
>  
>  	/* Enable reset on watchdog */
>  	reg = readl(dev->rstout);
> @@ -312,7 +314,7 @@ static int armada375_stop(struct watchdog_device *wdt_dev)
>  static int armada370_stop(struct watchdog_device *wdt_dev)
>  {
>  	struct orion_watchdog *dev = watchdog_get_drvdata(wdt_dev);
> -	u32 reg;
> +	u32 reg, mask;
>  
>  	/* Disable reset on watchdog */
>  	reg = readl(dev->rstout);
> @@ -320,7 +322,10 @@ static int armada370_stop(struct watchdog_device *wdt_dev)
>  	writel(reg, dev->rstout);
>  
>  	/* Disable watchdog timer */
> -	atomic_io_modify(dev->reg + TIMER_CTRL, dev->data->wdt_enable_bit, 0);
> +	mask = dev->data->wdt_enable_bit;
> +	if (wdt_dev->info->options & WDIOF_PRETIMEOUT)
> +		mask |= TIMER1_ENABLE_BIT;
> +	atomic_io_modify(dev->reg + TIMER_CTRL, mask, 0);
>  
>  	return 0;
>  }
> -- 
> 2.35.1
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com

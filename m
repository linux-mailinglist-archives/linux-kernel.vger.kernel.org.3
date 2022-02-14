Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E7A4B5573
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 16:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356050AbiBNP50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 10:57:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbiBNP5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 10:57:23 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4350488A4;
        Mon, 14 Feb 2022 07:57:15 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id s6-20020a0568301e0600b0059ea5472c98so11851861otr.11;
        Mon, 14 Feb 2022 07:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uZNWbRMtuksjwc81DX+Fw9WpJ0JU037g2Zhi2MTrlPs=;
        b=Gx4zfhMnWxjxMuzz7x+8v7Yc8bYKfiWNfP8peCcAuULiijqukaLPDruLwU+6pe+Wd/
         CsSvb2/VgB73mQqUTvwNL4wMj8MqHHo7bZhYV4w1vw4p9SdwUPcAkAu57QGU2tBoIX2V
         v+LRmgsD+4vJNk6gLrvUG1OKtuIi42v3pBdz8fvBR4bDx8t6Cg9/Ccu+veLqookmUWut
         fpvAOeAVsPcs3234WhzS1abWoqlc6jLjx3cw8zkE/tzR0iHSWdnn67Mg1rC0JNRzZ7I1
         /+5T8Pe1TaWkKpc7R32ZY3X/aMvDT2ZBWUElBkncThc5dhT7GFyApxCaVplYzsioaBAy
         HNbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=uZNWbRMtuksjwc81DX+Fw9WpJ0JU037g2Zhi2MTrlPs=;
        b=D912eKzCmC87Wtl0+HoxUv/fo0/+CtEsJe2qY1pwBAgUTgiEloQO6ovAMIL+belF/V
         1/Q8KnxQq/ddyoX3rr5mbrGku0TOGk89DO7h3QwghuRM4rqbWQjCiujorV2TlHXy+e6k
         avBh1tSJ2pQEluDB23wXbxqhA/jzBaLeEvHKiw347QU9ynyr/XQA9xSOhb+Rfun4Uxpg
         bfLhLh6g2XJJXYc6tAIpalGY2eTIusWzCuwTWmHr03kayO6H6DZ2tuVEq4YraFwiYboM
         5GNnMB3aFgAEZd3IPLiie896GtZaSY3jbrHcufJYGt8PGx8fg58zJsfVsaxfXVudMPRZ
         x8bA==
X-Gm-Message-State: AOAM532AGCNLgmBkeDPcXwJCDeTNrEbmMj3B6xmfGo6rnYskeoeTqfRD
        UKKelj7HiokMTmyK5O3WYDs=
X-Google-Smtp-Source: ABdhPJwP1G7aCfnH8seOnIkYH+ZJDcWocmRx+VDleeZSoFJAfprDEzzxaLWD5+w/+0EpYf4DDjIu8g==
X-Received: by 2002:a9d:6086:: with SMTP id m6mr160226otj.284.1644854235199;
        Mon, 14 Feb 2022 07:57:15 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g10sm12515699otn.65.2022.02.14.07.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 07:57:14 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 14 Feb 2022 07:57:13 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     andrew@lunn.ch, gregory.clement@bootlin.com, robh+dt@kernel.org,
        wim@linux-watchdog.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 2/2] watchdog: orion_wdt: support pretimeout on Armada-XP
Message-ID: <20220214155713.GA275186@roeck-us.net>
References: <20220211003257.2037332-1-chris.packham@alliedtelesis.co.nz>
 <20220211003257.2037332-3-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211003257.2037332-3-chris.packham@alliedtelesis.co.nz>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2022 at 01:32:57PM +1300, Chris Packham wrote:
> Commit e07a4c79ca75 ("watchdog: orion_wdt: use timer1 as a pretimeout")
> added support for a pretimeout on Armada-38x variants. Because the
> Armada-XP variants use armada370_start/armada370_stop (due to missing an
> explicit RSTOUT mask bit for the watchdog). Add the required pretimeout
> support to armada370_start/armada370_stop for Armada-XP.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> Reviewed-by: Gregory CLEMENT <gregory.clement@bootlin.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

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

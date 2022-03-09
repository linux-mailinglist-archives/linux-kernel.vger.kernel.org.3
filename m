Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 018194D3C0D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 22:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234999AbiCIVav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 16:30:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbiCIVar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 16:30:47 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF3D11C7E9;
        Wed,  9 Mar 2022 13:29:47 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 6D2F2FF807;
        Wed,  9 Mar 2022 21:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646861385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lJQsblOAULUh3lzCEKVioDO1y36yllC+TMOirGIPqsM=;
        b=Kh4WQzVD8kiAEnhp2u5nFIvcRz3yVabyHhGLWYW3aox1Nxle3w868CCsFhkCZMN9EhCPDk
        XuS+5Xnb+3ryvP6Qc8SahoTblB0P9vEIT40VI6wm4TddUYu5NWnXpBh6iYCXv2fSLYjpaW
        dmV2LRv8I7NRnT5GOOXWbw6Wfw3wtRWHQJNJgf8ImB0o5H6UH/kL2mHjgV+G+vuH21C/lD
        VgVW5MvbW38d991B7jEJNdKBosalgoGC2OcREaDAVozkw+bSA3biqU5h/D7oAeZPpYiqnV
        2d7cDPMjySYrvi9sCxj30mqMtwEBYTk2xkYw7e469puIAQcfBhrzj24nugWIWQ==
Date:   Wed, 9 Mar 2022 22:29:43 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Hanna Hawa <hhhawa@amazon.com>
Cc:     a.zummo@towertech.it, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, dwmw@amazon.co.uk, benh@amazon.com,
        eduval@amazon.com, ronenk@amazon.com, talel@amazon.com,
        jonnyc@amazon.com, hanochu@amazon.com, farbere@amazon.com
Subject: Re: [RFC PATCH 1/1] rtc: bq32k: update years calculation according
 century bit
Message-ID: <YikcR25H8x1ambO9@piout.net>
References: <20220207070156.19373-1-hhhawa@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207070156.19373-1-hhhawa@amazon.com>
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_OTHER_BAD_TLD,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 07/02/2022 09:01:56+0200, Hanna Hawa wrote:
> tm_year filed hold the number of years since 1900, in case the century
> was changed the driver will return invalid year, as it will not
> increment the years field by 200.
> 
> This change update the years calculation in bq32k_rtc_read_time() and
> bq32k_rtc_write_time(). By increasing the years by 100 always, and only
> if the century enable bit (BQ32K_CENT_EN) is set and century bit
> (BQ32K_CENT) is cleared will increase again by 100 to represent the next
> century.
> 

I'm not sure I get the issue, currently, the driver considers that
BQ32K_CENT not set is 19YY and BQ32K_CENT set is 20YY and what is done
seems fine to me. Can you elaborate on what you are trying to fix?

> Signed-off-by: Hanna Hawa <hhhawa@amazon.com>
> ---
>  drivers/rtc/rtc-bq32k.c | 29 +++++++++++++++++++++++------
>  1 file changed, 23 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-bq32k.c b/drivers/rtc/rtc-bq32k.c
> index 2235c968842d..09795dd2728b 100644
> --- a/drivers/rtc/rtc-bq32k.c
> +++ b/drivers/rtc/rtc-bq32k.c
> @@ -108,8 +108,20 @@ static int bq32k_rtc_read_time(struct device *dev, struct rtc_time *tm)
>  	tm->tm_mday = bcd2bin(regs.date);
>  	tm->tm_wday = bcd2bin(regs.day) - 1;
>  	tm->tm_mon = bcd2bin(regs.month) - 1;
> -	tm->tm_year = bcd2bin(regs.years) +
> -				((regs.cent_hours & BQ32K_CENT) ? 100 : 0);
> +	/*
> +	 * tm_year is number of years since 1900. Need to increase the years by
> +	 * 100 always assuming we are on 20YY and not 19YY.
> +	 */
> +	tm->tm_year = bcd2bin(regs.years) + 100;
> +
> +	/*
> +	 * If the century enable bit (BQ32K_CENT_EN) is set, and century bit
> +	 * (BQ32K_CENT) is cleared, that means we are on the next century, which
> +	 * required to increase by 100.
> +	 */
> +	if ((regs.cent_hours & BQ32K_CENT_EN) &&
> +	    !(regs.cent_hours & BQ32K_CENT))
> +		tm->tm_year += 100;
>  
>  	return 0;
>  }
> @@ -117,6 +129,7 @@ static int bq32k_rtc_read_time(struct device *dev, struct rtc_time *tm)
>  static int bq32k_rtc_set_time(struct device *dev, struct rtc_time *tm)
>  {
>  	struct bq32k_regs regs;
> +	int year;
>  
>  	regs.seconds = bin2bcd(tm->tm_sec);
>  	regs.minutes = bin2bcd(tm->tm_min);
> @@ -125,11 +138,15 @@ static int bq32k_rtc_set_time(struct device *dev, struct rtc_time *tm)
>  	regs.date = bin2bcd(tm->tm_mday);
>  	regs.month = bin2bcd(tm->tm_mon + 1);
>  
> -	if (tm->tm_year >= 100) {
> +	/* Assume we are on 20YY and not 19YY */
> +	year = tm->tm_year - 100;
> +
> +	if (year < 100) {
>  		regs.cent_hours |= BQ32K_CENT;
> -		regs.years = bin2bcd(tm->tm_year - 100);
> -	} else
> -		regs.years = bin2bcd(tm->tm_year);
> +		regs.years = bin2bcd(year);
> +	} else {
> +		regs.years = bin2bcd(year - 100);
> +	}
>  
>  	return bq32k_write(dev, &regs, 0, sizeof(regs));
>  }
> -- 
> 2.17.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

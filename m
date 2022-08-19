Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 047E0599B50
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 13:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348639AbiHSLo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 07:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347719AbiHSLoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 07:44:54 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07706C2763;
        Fri, 19 Aug 2022 04:44:52 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id w138so1478167pfc.10;
        Fri, 19 Aug 2022 04:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=UCWqtLC1yYug912P/xJZXTJO6IcyX8bpF1RM7XJlaA4=;
        b=LBXZTKaoBUH+ULwwdTRqW7STUr819eXN+/NMdPNxP+5tEbdZ6FxlaikH6UCkpr72XN
         dXX0LxEt5egGP1IXKhQc84rS+ZgQHD+ve58/pw7tsfdQwf0BAozP+jWQjvfG8QvE8oDK
         +wkS0I1D4u//cpAXd06OVcrRleAS0TXi2042Fgmmx5oF71mncxDjNy/8Ff7oSzrDvrx5
         liSSJQAn80C4GdCiNuBYVVzjSpIf5af5RoueihAyt/AHUJbBltK7D5HEKBIBBMCb5mwk
         RjKZE/7nNP/3xb9sQ+vz778brQVkboSN5YVQAd12n40WZMxnvOSvIdqq6FHzsyLvM3hh
         2duw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=UCWqtLC1yYug912P/xJZXTJO6IcyX8bpF1RM7XJlaA4=;
        b=lABxLsCES1j6MkX4vZFiDw9gxC/M+np2c6Slace2etii78bBXgVxav19EvThaAJ70f
         Qt5DsV/596rrwUCZXdQ2rsDH7oEBAhNM3VeYHfEUdmy7Tf61uY9LLYwnIYlMnuWTAd/n
         MdrYVB63zKOwUFmHBQja3P5NHfZcwuo2uH3fzrgJq5V7AWMxyJBSiXu7b7h7yM1UcQQH
         ofLKo/Xphj3uZ5dVoS12HMuIFCGwP23awmwkEHyxQP+ehA0PaS9HbwCxUbfX4N4rsTg/
         tP58wwJRI6eilu4Y8plag3QG2RPxD3d6bVsnpvWFcpgzme58CdrvW4QlCCqYObwdkviG
         N7Ww==
X-Gm-Message-State: ACgBeo0MgHKkQu5UYUyt+X4TPw0j1UoYwLZDyHZyyf/qAAwge3cnJ097
        8oLRvFZqWT5HxDf1lqSuVlwkQwTd3U8=
X-Google-Smtp-Source: AA6agR7CbiVFbWALuy4dvNt5DjW422IoGaxOs/+ufjJr9mtOmCjJQ90/G+ZsrjghuJAhrL0WMIqN0A==
X-Received: by 2002:a65:6d1a:0:b0:3fb:2109:7b87 with SMTP id bf26-20020a656d1a000000b003fb21097b87mr5869447pgb.127.1660909491496;
        Fri, 19 Aug 2022 04:44:51 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q62-20020a17090a1b4400b001f4cc17b451sm5030849pjq.5.2022.08.19.04.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 04:44:50 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 19 Aug 2022 04:44:49 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Cc:     wim@linux-watchdog.org, joel@jms.id.au, andrew@aj.id.au,
        BMC-SW@aspeedtech.com, linux-watchdog@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, Bonnie_Lo@wiwynn.com
Subject: Re: [PATCH] watchdog: aspeed_wdt: Reorder output signal register
 configuration
Message-ID: <20220819114449.GF3106213@roeck-us.net>
References: <20220819094905.1962513-1-chin-ting_kuo@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819094905.1962513-1-chin-ting_kuo@aspeedtech.com>
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

On Fri, Aug 19, 2022 at 05:49:05PM +0800, Chin-Ting Kuo wrote:
> If the output driving type is push-pull mode, the output
> polarity should be selected in advance. Otherwise, an unexpected
> value will be output at the moment of changing to push-pull mode.
> Thus, output polarity, WDT18[31], must be configured before
> changing driving type, WDT18[30].
> 
> Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/aspeed_wdt.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
> index 436571b6fc79..a03e4ff812a2 100644
> --- a/drivers/watchdog/aspeed_wdt.c
> +++ b/drivers/watchdog/aspeed_wdt.c
> @@ -325,18 +325,18 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
>  		u32 reg = readl(wdt->base + WDT_RESET_WIDTH);
>  
>  		reg &= config->ext_pulse_width_mask;
> -		if (of_property_read_bool(np, "aspeed,ext-push-pull"))
> -			reg |= WDT_PUSH_PULL_MAGIC;
> +		if (of_property_read_bool(np, "aspeed,ext-active-high"))
> +			reg |= WDT_ACTIVE_HIGH_MAGIC;
>  		else
> -			reg |= WDT_OPEN_DRAIN_MAGIC;
> +			reg |= WDT_ACTIVE_LOW_MAGIC;
>  
>  		writel(reg, wdt->base + WDT_RESET_WIDTH);
>  
>  		reg &= config->ext_pulse_width_mask;
> -		if (of_property_read_bool(np, "aspeed,ext-active-high"))
> -			reg |= WDT_ACTIVE_HIGH_MAGIC;
> +		if (of_property_read_bool(np, "aspeed,ext-push-pull"))
> +			reg |= WDT_PUSH_PULL_MAGIC;
>  		else
> -			reg |= WDT_ACTIVE_LOW_MAGIC;
> +			reg |= WDT_OPEN_DRAIN_MAGIC;
>  
>  		writel(reg, wdt->base + WDT_RESET_WIDTH);
>  	}
> -- 
> 2.25.1
> 

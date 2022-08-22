Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 967F359C164
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 16:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235462AbiHVOJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 10:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235630AbiHVOJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 10:09:49 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0782132EF0;
        Mon, 22 Aug 2022 07:09:49 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id d71so9453881pgc.13;
        Mon, 22 Aug 2022 07:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=QqKZtUuDZr8epml/4TWu2DuBoI/5UNTO8X2q916obAU=;
        b=RFoT9WZkCeKGDhrABTAwR/oNnBYpdK2+cncWYnOdJnK1BQ6gBfsj+PrxwkpBsRmxUA
         XQ/7mIG1bHOZvaMxGWMJ3A3YSOyx07lYsjKQUESuWk3H0Rib3+IwdbgF0+JE/d5KDykW
         7ZEoFBwMBpgv7wFPOrujo/qfQ8bV75XDbX/V+F46kCXTMoD6ChzecfXJ7pEoAL7Yle61
         QfVUNT/K1x5f3X5OAi2llahBZ7Q4+cRR9qDzgF5xRfo42vie93P2eatLG6fnzAAPubTh
         woH56+IzmXZu40h3tAV/CfprHSOjjcpnofiHIyN+2S7+MMxNkDUZ2SfO+qPuaxD9X9Wk
         FA+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=QqKZtUuDZr8epml/4TWu2DuBoI/5UNTO8X2q916obAU=;
        b=5kqRfFDvlaB8YIRqAFU+Q5dVezZexdBt/+ksnYIHlJWcNta8VvDdWfV4NP+gAFxPLx
         zo8vd/G+KVPJQU/3xD3gJ8/HM45V8Y31xPVRMSDA1Gp8CiE5f8f4rTxgtsJBjWTm9BLk
         zyaSwte3iUMYCpGV4Yz84A8pnobbTzKxrbZXzefodICXE2IcbbYeiv0j58mzd2rPUjsS
         5HG4qq07D2GC8W182hzUHo8Xxf4Ngfj9fjFystGUVqnhcXgoEMRxX205tgAVd3vsOTc2
         VeB59EeI/RGD0HHLB1R4TYvzjrYc2zr1X0B0cXd0+8D9ludciobIbPq9IBEAbq2hJtK5
         sPKQ==
X-Gm-Message-State: ACgBeo2CnSZsKSVnaisCjR3dWF0XpU473Y3ruI0Vf05kZVfoxECF8kZn
        7O8pMQoePYQZOJj3d/jXhYaPiXQRCwU=
X-Google-Smtp-Source: AA6agR4oDS5asvwrF+m/y9egx7Oi3BAvt54PEa8m6FAll71+1WXqQx4MVFGkxoOC7L9W+sgoHQWp/Q==
X-Received: by 2002:a65:6cc7:0:b0:42a:4d40:8dc1 with SMTP id g7-20020a656cc7000000b0042a4d408dc1mr12257889pgw.321.1661177388433;
        Mon, 22 Aug 2022 07:09:48 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z12-20020aa79e4c000000b00535e950aa28sm7941944pfq.131.2022.08.22.07.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 07:09:47 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 22 Aug 2022 07:09:46 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc:     wim@linux-watchdog.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com, kernel@pengutronix.de,
        linux-imx@nxp.com, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] watchdog: imx7ulp_wdt: Fix RCS timeout issue
Message-ID: <20220822140946.GC4087281@roeck-us.net>
References: <20220816043643.26569-1-alice.guo@oss.nxp.com>
 <20220816043643.26569-5-alice.guo@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816043643.26569-5-alice.guo@oss.nxp.com>
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

On Tue, Aug 16, 2022 at 12:36:40PM +0800, Alice Guo (OSS) wrote:
> From: Ye Li <ye.li@nxp.com>
> 
> According to measure on i.MX7ULP and i.MX8ULP, the RCS done needs
> about 3400us and 6700us respectively. So current 20us timeout is
> not enough. When reconfiguring is on-going, unlock and configure CS
> will lead to unknown result.
> 
> Increase the wait timeout value to 10ms and check the return value
> of RCS wait to fix the issue
> 

You'll have to find a better solution. An active (non-sleep) wait of
10 ms is unacceptable.

Guenter

> Signed-off-by: Ye Li <ye.li@nxp.com>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> Reviewed-by: Jacky Bai <ping.bai@nxp.com>
> Acked-by: Jason Liu <jason.hui.liu@nxp.com>
> ---
>  drivers/watchdog/imx7ulp_wdt.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/watchdog/imx7ulp_wdt.c b/drivers/watchdog/imx7ulp_wdt.c
> index a0f6b8cea78f..12715c248688 100644
> --- a/drivers/watchdog/imx7ulp_wdt.c
> +++ b/drivers/watchdog/imx7ulp_wdt.c
> @@ -39,7 +39,7 @@
>  #define DEFAULT_TIMEOUT	60
>  #define MAX_TIMEOUT	128
>  #define WDOG_CLOCK_RATE	1000
> -#define WDOG_WAIT_TIMEOUT	20
> +#define WDOG_WAIT_TIMEOUT	10000
>  
>  static bool nowayout = WATCHDOG_NOWAYOUT;
>  module_param(nowayout, bool, 0000);
> @@ -80,7 +80,7 @@ static int imx7ulp_wdt_enable(struct watchdog_device *wdog, bool enable)
>  		writel(val | WDOG_CS_EN, wdt->base + WDOG_CS);
>  	else
>  		writel(val & ~WDOG_CS_EN, wdt->base + WDOG_CS);
> -	imx7ulp_wdt_wait(wdt->base, WDOG_CS_RCS);
> +	ret = imx7ulp_wdt_wait(wdt->base, WDOG_CS_RCS);
>  
>  enable_out:
>  	local_irq_enable();
> @@ -127,7 +127,9 @@ static int imx7ulp_wdt_set_timeout(struct watchdog_device *wdog,
>  	if (ret)
>  		goto timeout_out;
>  	writel(val, wdt->base + WDOG_TOVAL);
> -	imx7ulp_wdt_wait(wdt->base, WDOG_CS_RCS);
> +	ret = imx7ulp_wdt_wait(wdt->base, WDOG_CS_RCS);
> +	if (ret)
> +		goto timeout_out;
>  
>  	wdog->timeout = timeout;
>  
> -- 
> 2.17.1
> 

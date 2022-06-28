Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2198B55EEF4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 22:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbiF1UNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 16:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiF1UL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 16:11:57 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DCA73B3C2;
        Tue, 28 Jun 2022 13:03:26 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d5so12002576plo.12;
        Tue, 28 Jun 2022 13:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=99fhhNvuvIbHAOoiSzGURisNVQReiX0ThP8Z5TEm4ms=;
        b=VU+A5eJzI2U7m+mJYjyw7lpgRmpeTDwnTj4pLDu1aXawQqGrSR10KRTxvBoOHwXyf3
         hW7JB4AhctcUtnswoLUq33aOUKlup2EgpV7bkEsq6IY1XdkvIBFgk+wG3pZn5M0ppHAG
         6O9EZk9OROAb6ImOpgE8ImJwCf5FinYQuRq8zO6u6YCpRfXFZf4ErMS0JZqhxwN2VIdK
         DCnmABcS/oT/8oXpggRZXNKAOIb92I9iOSFLTfN5bHf9aqXRQ1kX9K3UmuD9M5/Amcpm
         vLm7jIsfC1aDb9sJ+B+XRd4FE9Qr+qhzIlgwmtwB+bjgc5s9TOfFyheyTqhr2VGci74d
         4Ngw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=99fhhNvuvIbHAOoiSzGURisNVQReiX0ThP8Z5TEm4ms=;
        b=XtIUDozdWPoHZrNaITce4O1MK/N2ckGFgCLfAfB3eiFupIh5JXfOVuLHKuIxuNhn7G
         AkJj/vm5c3X+CN4Z+7Wg0ZF2JqtTgNp6p3pndk0zBdvDgnnpfmQ4BQG9tKb/DVCcbhY8
         LCS0A2nERWjxu7QoGo9QOalViU5j4M1Rc/VfwRSUCh6mXCq3PNtc0OJjdq2u8pjbg+2W
         GvNmmuYqVcpWvwX3iQ+9luu4ZKZ7kacc7xgiE7uMZWsoRlUHUWvYE6PGPiYIBm7W5h5Y
         5Z+VdB8weMnK4bwmZT1wsDi2RPmqdyNHRMMsAbhrAtkqOXyoj+l8OEhdzZ6PqgA2TrcO
         S7jA==
X-Gm-Message-State: AJIora8BjosLS2Cbr2cys+EM5ezcv4s2wGtSsqFLdQoWIuONCwfD9/BB
        CMHq/RwdHi9g0poWF70fazM=
X-Google-Smtp-Source: AGRyM1utJi2f0eWDb12GVb8yGIc2maVMddBIJD0klZ6MqKdwimi2DcqR9ljs1+MZ4t0cPjcx1cJsQA==
X-Received: by 2002:a17:902:e889:b0:16a:6c64:aa50 with SMTP id w9-20020a170902e88900b0016a6c64aa50mr6481514plg.142.1656446606014;
        Tue, 28 Jun 2022 13:03:26 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t13-20020a17090340cd00b00166496ba268sm9604612pld.285.2022.06.28.13.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 13:03:25 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 28 Jun 2022 13:03:24 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 5/8] watchdog: sama5d4_wdt: Remove #ifdef guards for PM
 related functions
Message-ID: <20220628200324.GE3633970@roeck-us.net>
References: <20220628193449.160585-1-paul@crapouillou.net>
 <20220628193449.160585-6-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628193449.160585-6-paul@crapouillou.net>
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

On Tue, Jun 28, 2022 at 08:34:46PM +0100, Paul Cercueil wrote:
> Use the new LATE_SYSTEM_SLEEP_PM_OPS() and pm_sleep_ptr() macros to
> handle the .suspend/.resume callbacks.
> 
> These macros allow the suspend and resume functions to be automatically
> dropped by the compiler when CONFIG_SUSPEND is disabled, without having
> to use #ifdef guards. Not using #ifdef guards means that the code is
> always compiled independently of any Kconfig option, and thanks to that
> bugs and regressions are easier to catch.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Claudiu Beznea <claudiu.beznea@microchip.com>
> Cc: linux-arm-kernel@lists.infradead.org

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/sama5d4_wdt.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/watchdog/sama5d4_wdt.c b/drivers/watchdog/sama5d4_wdt.c
> index ec20ad4e534f..aeee934ca51b 100644
> --- a/drivers/watchdog/sama5d4_wdt.c
> +++ b/drivers/watchdog/sama5d4_wdt.c
> @@ -339,7 +339,6 @@ static const struct of_device_id sama5d4_wdt_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, sama5d4_wdt_of_match);
>  
> -#ifdef CONFIG_PM_SLEEP
>  static int sama5d4_wdt_suspend_late(struct device *dev)
>  {
>  	struct sama5d4_wdt *wdt = dev_get_drvdata(dev);
> @@ -366,18 +365,17 @@ static int sama5d4_wdt_resume_early(struct device *dev)
>  
>  	return 0;
>  }
> -#endif
>  
>  static const struct dev_pm_ops sama5d4_wdt_pm_ops = {
> -	SET_LATE_SYSTEM_SLEEP_PM_OPS(sama5d4_wdt_suspend_late,
> -			sama5d4_wdt_resume_early)
> +	LATE_SYSTEM_SLEEP_PM_OPS(sama5d4_wdt_suspend_late,
> +				 sama5d4_wdt_resume_early)
>  };
>  
>  static struct platform_driver sama5d4_wdt_driver = {
>  	.probe		= sama5d4_wdt_probe,
>  	.driver		= {
>  		.name	= "sama5d4_wdt",
> -		.pm	= &sama5d4_wdt_pm_ops,
> +		.pm	= pm_sleep_ptr(&sama5d4_wdt_pm_ops),
>  		.of_match_table = sama5d4_wdt_of_match,
>  	}
>  };
> -- 
> 2.35.1
> 

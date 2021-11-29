Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 011C54620C6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 20:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237495AbhK2Tp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 14:45:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235999AbhK2Tnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 14:43:53 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B2CC061D5F;
        Mon, 29 Nov 2021 08:04:17 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id i5-20020a05683033e500b0057a369ac614so4700733otu.10;
        Mon, 29 Nov 2021 08:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Cv5LVXTTCR1HmOZGb736k7WjrkVKH15RJ/Gmegp4BAU=;
        b=gx5BleuEv5p/J6ypZnNqJfuQ7KmBz/NQOVe3Jzw/0LVocKisnut1f4yjvivQu9lztj
         Y86M+X+LjoRRBY3mULjX0Mz07HWb5WNRnAjqNgvn4j4O+QVgOQrQuVfo4ym3wwE1qfgk
         ZE57Dr+JZr4stnN+oofrVYSOHmkeekVBfVLdXKH0hofiH4OH18ZGgm5TWaUkX/qEY+Ng
         zUlx0zRgdaKXc41BRPmHLli67ff1omj3rub6Ec6/D72LxDgq60DF355Ey4N+SMeRcZpN
         FLUet+gkfKRfL5ITtrF3Xd8bI0vHB0ieLwuin7vObSTLiALbgZ5629eZDz0vJfg/9RIG
         2Y9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Cv5LVXTTCR1HmOZGb736k7WjrkVKH15RJ/Gmegp4BAU=;
        b=ic1Z4OdLHe8ePpolMrZUiruk6UEWnm2uy7WWr+S9x0gOiv8gnhRpjW7t5BIbiakiKM
         Osh5xbE5+GIPQdxATz/7Ek2qyEsmK6mzTi/Q954YydTK820LglYF5n7lssXQ3KiLvXbh
         7UwudICtnXsWNYUg3HZkhfAD8gI7XLGEmZrUPmxxNkOgtpSeJXu7MHFCyNkkxaKp8V9h
         3gEAxGDTu9QRlqtZ2bs7tWpgwfGtVCL0Mf72rUztfoC3G2GSZRXjHD7SYUprvuP0z9bB
         UCWph8eJBZ3FgZxu9w53x/qU7bSg3FyiaQBH8j+gcPrsbZ40REUOOEf0N5eDROHIZAkX
         zYEg==
X-Gm-Message-State: AOAM530pZ4kVXlS5WGb2rwH97O4mtqzI4MjZS0FyENVvt4+kHF0K4Q2h
        ovCn/tZBm3CxCFsWE6a2Afo=
X-Google-Smtp-Source: ABdhPJwb5t+pEea2I1w63lGWBXhTN+t6qjFcNXBQy5xShKmNkM0Fmeg28O6OHOZck/x3aKAgROlI7w==
X-Received: by 2002:a05:6830:13cc:: with SMTP id e12mr45512351otq.377.1638201856548;
        Mon, 29 Nov 2021 08:04:16 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s2sm2704156otr.69.2021.11.29.08.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 08:04:15 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 29 Nov 2021 08:04:14 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        devicetree@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        Chiwoong Byun <woong.byun@samsung.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v4 8/9] watchdog: max77620: add comment to clarify
 set_timeout procedure
Message-ID: <20211129160414.GA3014810@roeck-us.net>
References: <20211120155707.4019487-1-luca@lucaceresoli.net>
 <20211120155707.4019487-9-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211120155707.4019487-9-luca@lucaceresoli.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 20, 2021 at 04:57:06PM +0100, Luca Ceresoli wrote:
> Clarify why we need to ping the watchdog before changing the timeout by
> quoting the MAX77714 datasheet.
> 

Unless I am missing something, this adds confusion instead of clarifying
anything, and it is misleading. The added comment in the code makes it
sound like clearing the watchdog timer is only needed for MAX77614.
However, the code was in place for MAX77620, suggesting that it was needed
for that chip as well and is not MAX77614 specific.

Please either drop this patch or rephrase it to clarify that it applies
to both chips.

Guenter

> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> ---
> 
> This patch is new in v4. It adds a clarification comment to the max77620
> driver taken from v3 patch 7.
> ---
>  drivers/watchdog/max77620_wdt.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/watchdog/max77620_wdt.c b/drivers/watchdog/max77620_wdt.c
> index 06b48295fab6..f082a4ea2c03 100644
> --- a/drivers/watchdog/max77620_wdt.c
> +++ b/drivers/watchdog/max77620_wdt.c
> @@ -132,6 +132,11 @@ static int max77620_wdt_set_timeout(struct watchdog_device *wdt_dev,
>  		break;
>  	}
>  
> +	/*
> +	 * "If the value of TWD needs to be changed, clear the system
> +	 * watchdog timer first [...], then change the value of TWD."
> +	 * (MAX77714 datasheet)
> +	 */
>  	ret = regmap_update_bits(wdt->rmap, wdt->drv_data->reg_cnfg_glbl3,
>  				 wdt->drv_data->wdtc_mask, 0x1);
>  	if (ret < 0)

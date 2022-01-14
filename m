Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2686B48EBC1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 15:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238033AbiANOgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 09:36:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233926AbiANOgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 09:36:04 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5D0C061574;
        Fri, 14 Jan 2022 06:36:03 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id w188so12389718oib.7;
        Fri, 14 Jan 2022 06:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lD1Jt5HPXkkJLqLAECNA5LcmSI3wdXLzJYaLp3IBqKE=;
        b=DhViUY9Z0mT9rsuJto9tllmgMtiy1HosH8oeA3M1/0PZ89p7v7nhZDFp0UHHeXHdf0
         TucO4pLCWCAng/aXDyLKNL+REJYGoH1Wpc5sYhlJDsGEyQNDpUg2tNfJGk9tjNtM0XV3
         EIti+2dShywaR4VqNxVkp3/a1eApnsKRaFluBLXyGnWLcmWMccKMIOgPD0XDeuGq4jQR
         NOfon0xLmUs0BfnYylg8u+4KUdJYAKEJOpbw+v+meSu5CSRb18yfu+JiH1qXNbXnGoUz
         g1Cf3SiAN2Akh83YcBtnC1T7Ke1HDTq0MztdWfhC62mT8I9XbD4t4UCV6OUl71rbPVUo
         8FIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lD1Jt5HPXkkJLqLAECNA5LcmSI3wdXLzJYaLp3IBqKE=;
        b=hUsncOlYpFyirqa1xvpJO3RazmqsJbUMwtOQBIKgWxex5BhNQsaHh9xsKJDZP4dmRd
         ZXaL0p5gccOwh7iNXSozlbb151FzI5qiZawSygd5E7Vjf0k++THQ3BQH46k8uUj3WdXL
         +EAmHpk5tAPU1qP4mUy59bMWkqp/yycYdyumUKDHJb8DdgwEhhdTtAO+aZKPxRvmTcow
         9Z2gSsrkGeIKXOr4ceGN2+It7BNWODVePT70scbv+fkPcmhMljwY5xqhp+3ftP7YNFmZ
         IRKnhfv6hJAQ2Uj6daUFkoq3Nb9IbQ1Ms9/fG6+vzm/+xd6yMsn/nuSDkdZx3GerDa3/
         0PDw==
X-Gm-Message-State: AOAM531Id1X0ivFiGgMj+f/jAoJDELwrRNHv0ek62fnURe0vJGT/jBGk
        wf2oZgEy8JTmRJ46kGLHLUo5gUPukcA=
X-Google-Smtp-Source: ABdhPJxppYZYgjqq3e+BsBvQ1kr8/VEfzj/laCRWiZfcUvHcPYan7+c/SinPBRfZvGrzUeS7rFADug==
X-Received: by 2002:aca:1204:: with SMTP id 4mr3967201ois.85.1642170962978;
        Fri, 14 Jan 2022 06:36:02 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q38sm1430873oiw.27.2022.01.14.06.36.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jan 2022 06:36:01 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH 2/2] watchdog: mtk_wdt: mt7986: Add toprgu reset
 controller support
To:     Sam Shih <sam.shih@mediatek.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Ryder Lee <ryder.lee@kernel.org>, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org
Cc:     John Crispin <john@phrozen.org>
References: <20220105100456.7126-1-sam.shih@mediatek.com>
 <20220105100456.7126-3-sam.shih@mediatek.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <8e6ed2b7-b4e7-733a-579f-e1536f68ea2f@roeck-us.net>
Date:   Fri, 14 Jan 2022 06:35:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220105100456.7126-3-sam.shih@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/5/22 2:04 AM, Sam Shih wrote:
> Besides watchdog, the mt7986 toprgu module also provides software reset
> functionality for various peripheral subsystems
> (eg, ethernet, pcie, and connectivity)
> 
> Signed-off-by: Sam Shih <sam.shih@mediatek.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/mtk_wdt.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
> index 543cf38bd04e..c6437fe1f4c0 100644
> --- a/drivers/watchdog/mtk_wdt.c
> +++ b/drivers/watchdog/mtk_wdt.c
> @@ -10,6 +10,7 @@
>    */
>   
>   #include <dt-bindings/reset/mt2712-resets.h>
> +#include <dt-bindings/reset/mt7986-resets.h>
>   #include <dt-bindings/reset/mt8183-resets.h>
>   #include <dt-bindings/reset/mt8192-resets.h>
>   #include <dt-bindings/reset/mt8195-resets.h>
> @@ -76,6 +77,10 @@ static const struct mtk_wdt_data mt2712_data = {
>   	.toprgu_sw_rst_num = MT2712_TOPRGU_SW_RST_NUM,
>   };
>   
> +static const struct mtk_wdt_data mt7986_data = {
> +	.toprgu_sw_rst_num = MT7986_TOPRGU_SW_RST_NUM,
> +};
> +
>   static const struct mtk_wdt_data mt8183_data = {
>   	.toprgu_sw_rst_num = MT8183_TOPRGU_SW_RST_NUM,
>   };
> @@ -418,6 +423,7 @@ static int mtk_wdt_resume(struct device *dev)
>   static const struct of_device_id mtk_wdt_dt_ids[] = {
>   	{ .compatible = "mediatek,mt2712-wdt", .data = &mt2712_data },
>   	{ .compatible = "mediatek,mt6589-wdt" },
> +	{ .compatible = "mediatek,mt7986-wdt", .data = &mt7986_data },
>   	{ .compatible = "mediatek,mt8183-wdt", .data = &mt8183_data },
>   	{ .compatible = "mediatek,mt8192-wdt", .data = &mt8192_data },
>   	{ .compatible = "mediatek,mt8195-wdt", .data = &mt8195_data },
> 


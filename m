Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB4D48EA34
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 13:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241155AbiANM44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 07:56:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235107AbiANM4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 07:56:55 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED37AC061574;
        Fri, 14 Jan 2022 04:56:54 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id e9so15514385wra.2;
        Fri, 14 Jan 2022 04:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=6+XPkUMm8vPCVvtG6187AZZdz7kVpOT0XAljAcndVfk=;
        b=Eqg+rdI5PROleZ3u1XK+eavtOp/BrisKa7wo005r7keuzmuHSUz6liVg6QTxaYkyqo
         Yp4BFeYRkA5LXxdICXYIVXKhQ6qR3vCF8K7e1xaDLsIGO8FM4N7296gUrFz2MRYfjy3w
         +oi/Z5QgaTrlwoIBWlOBtM0ayzGUITrPdRM7l156eQ5JIr41gRk7TpbMjSQJCSgP544f
         EZoDekBitnOjoth4pPa4nNcSskD7/k2tgkYzs4hicXjavrrxbMRmSp2+r3r/fvid3luk
         71c31olVXKfqCrm/zZNckMgotH0QuAeziowJyW79BD0J2YeJD8GbzlGoQ3sSokHJCywi
         /ubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6+XPkUMm8vPCVvtG6187AZZdz7kVpOT0XAljAcndVfk=;
        b=ANcuorFdySsFLi1MBnOSMSNCb3GI+GOVnZbRCu+GNvQ3dNSQPwIaUQuS5hMX2d+9rl
         8iRDsbWB63g+lmwpcKM0bHSaaDb9GoCKkubTJc5vxFqUUQMxh5E3pdlmgGm5cxOaFIBo
         JjcvjmKjTYEc6oF/GCR+cADuIpVZnkgddoH9iQbIRvId34ENxlP9Kaq3WTO6aaGBh38e
         qh0K0ztYMkmbX6voQCzxhllaawkQm4Bs6moXxempGDmUvX6RqtjP0wBvEueznl1yUpTQ
         9rQV7Y2rIF/ZbQ87V2i8k30f00F+aHrkcD92FyHTkv96Jyeos6jbCOghXoGMhADxcBvi
         HISA==
X-Gm-Message-State: AOAM5304PUxvgEP2AOm/00pgjrpwGv+53Y5k3U2xs6lErBv5wJzgfVA7
        hh/0lfUhCg55qoeiqXatn7H/yOcUXXo=
X-Google-Smtp-Source: ABdhPJyKccl9MD30RAV7WANDNOdgbomQjWho6NuISKT5xLydQxgrnwNACK6FKuKi1T+gqMjy4w8E8g==
X-Received: by 2002:adf:eed1:: with SMTP id a17mr8236811wrp.306.1642165013521;
        Fri, 14 Jan 2022 04:56:53 -0800 (PST)
Received: from [192.168.0.22] ([37.223.145.74])
        by smtp.gmail.com with ESMTPSA id b14sm6170924wri.112.2022.01.14.04.56.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jan 2022 04:56:52 -0800 (PST)
Message-ID: <6719557c-b5a3-e6f4-3046-b53e5c229cf8@gmail.com>
Date:   Fri, 14 Jan 2022 13:56:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 2/2] watchdog: mtk_wdt: mt7986: Add toprgu reset
 controller support
Content-Language: en-US
To:     Sam Shih <sam.shih@mediatek.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Ryder Lee <ryder.lee@kernel.org>, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org
Cc:     John Crispin <john@phrozen.org>
References: <20220105100456.7126-1-sam.shih@mediatek.com>
 <20220105100456.7126-3-sam.shih@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220105100456.7126-3-sam.shih@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/01/2022 11:04, Sam Shih wrote:
> Besides watchdog, the mt7986 toprgu module also provides software reset
> functionality for various peripheral subsystems
> (eg, ethernet, pcie, and connectivity)
> 
> Signed-off-by: Sam Shih <sam.shih@mediatek.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

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

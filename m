Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53D9C4D4D68
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 16:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237496AbiCJP0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 10:26:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232844AbiCJP0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 10:26:10 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C7615697B;
        Thu, 10 Mar 2022 07:25:08 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 6B0911F45A2A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1646925907;
        bh=G44TKaXJ2702MH14xQ2xJ5CzDZDhej3DrvU8W8AmQpM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=SXhuKhFEp8Pn5kLpJ9uE75VypUMiWbTDJVSbQOK8PeLRuwMErkdO4jbich+dzPauC
         qCJWCscyap4JMwtArGtY5HzKtdvHxmWP7UbBPZXUPeHdFbn2BmwfQ33I7MwQG8brbd
         fYowneCd2ko50BtGZSUUzuRyJ/wegpIExSkuV6lgm16tPDRBenjMZEc9g8r/MZCpiT
         JZBtRYcs3DiM/nITjUjJB6X2evoUXrnf21ef/sN5ap4/j6gW50i8UJIkGflgdbeBHL
         docIDtmUfdlSE6vs5URQcIca6NSmP9Jcr8vaydjsb9YA3GvDJgCzFyl9ueHgXddWqI
         r4s8PlBH5D3EQ==
Message-ID: <ead686bc-06ae-c572-999a-af22c183550f@collabora.com>
Date:   Thu, 10 Mar 2022 16:25:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 1/5] ASoC: mediatek: mt8195: add reset controller
Content-Language: en-US
To:     Trevor Wu <trevor.wu@mediatek.com>, broonie@kernel.org,
        tiwai@suse.com, robh+dt@kernel.org, matthias.bgg@gmail.com
Cc:     alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, aaronyu@google.com,
        yc.hung@mediatek.com
References: <20220308072435.22460-1-trevor.wu@mediatek.com>
 <20220308072435.22460-2-trevor.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220308072435.22460-2-trevor.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 08/03/22 08:24, Trevor Wu ha scritto:
> Audio hardware is possibly used in the firmware stage, so resetting audio
> hardware before regcache records default register values is required.
> 
> Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   sound/soc/mediatek/mt8195/mt8195-afe-pcm.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c b/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c
> index 550636500949..72b2c6d629b9 100644
> --- a/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c
> +++ b/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c
> @@ -16,6 +16,7 @@
>   #include <linux/of_platform.h>
>   #include <linux/of_reserved_mem.h>
>   #include <linux/pm_runtime.h>
> +#include <linux/reset.h>
>   #include "mt8195-afe-common.h"
>   #include "mt8195-afe-clk.h"
>   #include "mt8195-reg.h"
> @@ -3056,6 +3057,7 @@ static int mt8195_afe_pcm_dev_probe(struct platform_device *pdev)
>   	struct mtk_base_afe *afe;
>   	struct mt8195_afe_private *afe_priv;
>   	struct device *dev = &pdev->dev;
> +	struct reset_control *rstc;
>   	int i, irq_id, ret;
>   	struct snd_soc_component *component;
>   
> @@ -3092,6 +3094,20 @@ static int mt8195_afe_pcm_dev_probe(struct platform_device *pdev)
>   		return ret;
>   	}
>   
> +	/* reset controller to reset audio regs before regmap cache */
> +	rstc = devm_reset_control_get_exclusive(dev, "audiosys");
> +	if (IS_ERR(rstc)) {
> +		ret = PTR_ERR(rstc);
> +		dev_err(dev, "could not get audiosys reset:%d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = reset_control_reset(rstc);
> +	if (ret) {
> +		dev_err(dev, "failed to trigger audio reset:%d\n", ret);
> +		return ret;
> +	}
> +
>   	spin_lock_init(&afe_priv->afe_ctrl_lock);
>   
>   	mutex_init(&afe->irq_alloc_lock);




Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7ACB467C85
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 18:27:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353352AbhLCRbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 12:31:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245736AbhLCRbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 12:31:19 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0A5C061751
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 09:27:55 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: adalessandro)
        with ESMTPSA id 4A5D91F4720D
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1638552473; bh=8Y+iTkVHyi32eqm4oXU8j9X1/e9/2blhp6mQO86NhsQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=dczRrUIFV0X3JMENblom3SEwA21rK1PBf2KayH+Hq+xJ0bystYFOWnWeyvPVndsAi
         6/dIDUlBcWDMIMI+5jzpXX1XaOWs5SPkiWJluTwRDnJi9jlOph/3VMlk4LiRDJ2mQN
         yl+1hrqB/qghiBMX6JFLa63AQaXQU0nYO1hV4+flQnqp7Ervku9uCjwh6HUxiEhUzd
         xbiHd8hhbiG/a3Em1ORyyBMzSRtS6fUcGg32tKRPGjeWLWUzh10We0W5vFJrrON3wi
         ryjtbH/tIPX0BLk+93P5ZpZKaoVjYtr5hwXr2OVhlv2eEgAQXRRAfHdKKfQ2TfHV0v
         a/1iVjkqvOj9Q==
Subject: Re: [RFC patch 5/5] ASoC: fsl-asoc-card: Support
 fsl,imx-audio-tlv320aic31xx codec
To:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc:     Xiubo.Lee@gmail.com, bkylerussell@gmail.com, broonie@kernel.org,
        festevam@gmail.com, kuninori.morimoto.gx@renesas.com,
        lgirdwood@gmail.com, michael@amarulasolutions.com,
        nicoleotsuka@gmail.com, perex@perex.cz, shengjiu.wang@gmail.com,
        tiwai@suse.com
References: <20211119153248.419802-1-ariel.dalessandro@collabora.com>
 <20211119153248.419802-6-ariel.dalessandro@collabora.com>
From:   Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Message-ID: <4a3672e1-7c62-7a2a-cd9f-045cf476c1b0@collabora.com>
Date:   Fri, 3 Dec 2021 14:27:46 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211119153248.419802-6-ariel.dalessandro@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/19/21 12:32 PM, Ariel D'Alessandro wrote:
> Add entry for fsl,imx-audio-tlv320aic31xx audio codec. This codec is
> configured to use BCLK as clock input.
> 
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
> ---
>  sound/soc/fsl/fsl-asoc-card.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
> index 6e6494f9f399..90cbed496f98 100644
> --- a/sound/soc/fsl/fsl-asoc-card.c
> +++ b/sound/soc/fsl/fsl-asoc-card.c
> @@ -26,6 +26,7 @@
>  #include "../codecs/wm8962.h"
>  #include "../codecs/wm8960.h"
>  #include "../codecs/wm8994.h"
> +#include "../codecs/tlv320aic31xx.h"
>  
>  #define CS427x_SYSCLK_MCLK 0
>  
> @@ -629,6 +630,16 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
>  	} else if (of_device_is_compatible(np, "fsl,imx-audio-tlv320aic32x4")) {
>  		codec_dai_name = "tlv320aic32x4-hifi";
>  		priv->dai_fmt |= SND_SOC_DAIFMT_CBP_CFP;
> +	} else if (of_device_is_compatible(np, "fsl,imx-audio-tlv320aic31xx")) {
> +		codec_dai_name = "tlv320dac31xx-hifi";
> +		priv->dai_fmt |= SND_SOC_DAIFMT_CBS_CFS;
> +		priv->dai_link[1].dpcm_capture = 0;
> +		priv->dai_link[2].dpcm_capture = 0;
> +		priv->cpu_priv.sysclk_dir[TX] = SND_SOC_CLOCK_OUT;
> +		priv->cpu_priv.sysclk_dir[RX] = SND_SOC_CLOCK_OUT;
> +		priv->codec_priv.mclk_id = AIC31XX_PLL_CLKIN_BCLK;
> +		priv->card.dapm_routes = audio_map_tx;
> +		priv->card.num_dapm_routes = ARRAY_SIZE(audio_map_tx);
>  	} else if (of_device_is_compatible(np, "fsl,imx-audio-wm8962")) {
>  		codec_dai_name = "wm8962";
>  		priv->codec_priv.mclk_id = WM8962_SYSCLK_MCLK;
> @@ -888,6 +899,7 @@ static const struct of_device_id fsl_asoc_card_dt_ids[] = {
>  	{ .compatible = "fsl,imx-audio-cs42888", },
>  	{ .compatible = "fsl,imx-audio-cs427x", },
>  	{ .compatible = "fsl,imx-audio-tlv320aic32x4", },
> +	{ .compatible = "fsl,imx-audio-tlv320aic31xx", },
>  	{ .compatible = "fsl,imx-audio-sgtl5000", },
>  	{ .compatible = "fsl,imx-audio-wm8962", },
>  	{ .compatible = "fsl,imx-audio-wm8960", },

The following config is missing and must be added.

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 8e05d092790e..14a06d9418a7 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -312,6 +312,7 @@ config SND_SOC_FSL_ASOC_CARD
        select SND_SOC_FSL_SAI
        select SND_SOC_FSL_SSI
+       select SND_SOC_TLV320AIC31XX
        select SND_SOC_WM8994
        select MFD_WM8994
        help

Regards,
Ariel

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 036DD49096C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 14:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234993AbiAQNV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 08:21:59 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:52976 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235867AbiAQNV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 08:21:56 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: adalessandro)
        with ESMTPSA id 769371F439D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1642425715;
        bh=HHl+tcKsaJd/EjkC5QH/VuLb6CdI2cBHcVNYB/vWclg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S2P6fFa0uw/eluYfvxcMao8Xr5PP7TpK1pfsxPrAUf3ehEYZiQoYze2gVB8kqSLEo
         kMZyAWiIlC2cPYo0oajrpH9Ov0TwYPmuqCKJ2Ba2vbydO9FcPZ5hzsta6xFpOXt9lG
         MRwCOBzxRkBFczXOvpLP2FBWSTQEdUBCpz9hdrC2pA4MFo0/hlKA4mGE+99C8tEM5C
         dcKWzFBjHFVWrtbqjFK0wzff9JwnD/cbNSusMIZTba0iJ5mIe+sZHS+bM+DsptZkPZ
         n8C+pE2afJl4GksgRZhH0Bt11eokqmPVvwDXYl96kRgtsJkC5Bvlm7YIHzbnQQtJqp
         ovtVMKtWpRflw==
From:   Ariel D'Alessandro <ariel.dalessandro@collabora.com>
To:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc:     Xiubo.Lee@gmail.com, ariel.dalessandro@collabora.com,
        bcousson@baylibre.com, broonie@kernel.org, festevam@gmail.com,
        kuninori.morimoto.gx@renesas.com, lgirdwood@gmail.com,
        michael@amarulasolutions.com, nicoleotsuka@gmail.com,
        perex@perex.cz, robh+dt@kernel.org, shengjiu.wang@gmail.com,
        tiwai@suse.com, tony@atomide.com
Subject: [PATCH v2 5/5] ASoC: fsl-asoc-card: Remove BCLK default value for tlv320aic31xx card
Date:   Mon, 17 Jan 2022 10:21:09 -0300
Message-Id: <20220117132109.283365-6-ariel.dalessandro@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220117132109.283365-1-ariel.dalessandro@collabora.com>
References: <20220117132109.283365-1-ariel.dalessandro@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that fsl-asoc-card support setting mclk-id through the device-tree
mclk-id property, let's remove the default BCLK configuration for this
card.

Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
---
 sound/soc/fsl/fsl-asoc-card.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index 156d3c669274..370bc790c6ba 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -637,7 +637,6 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 		priv->dai_link[2].dpcm_capture = 0;
 		priv->cpu_priv.sysclk_dir[TX] = SND_SOC_CLOCK_OUT;
 		priv->cpu_priv.sysclk_dir[RX] = SND_SOC_CLOCK_OUT;
-		priv->codec_priv.mclk_id = AIC31XX_PLL_CLKIN_BCLK;
 		priv->card.dapm_routes = audio_map_tx;
 		priv->card.num_dapm_routes = ARRAY_SIZE(audio_map_tx);
 	} else if (of_device_is_compatible(np, "fsl,imx-audio-wm8962")) {
-- 
2.34.1


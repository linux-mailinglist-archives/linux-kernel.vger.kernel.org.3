Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B28F25B0660
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 16:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbiIGOWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 10:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiIGOWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 10:22:23 -0400
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427097694D;
        Wed,  7 Sep 2022 07:22:13 -0700 (PDT)
Received: from booty.fritz.box (unknown [77.244.183.192])
        (Authenticated sender: luca.ceresoli@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id E8775200007;
        Wed,  7 Sep 2022 14:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1662560531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hkh90Imkp9wad8yz7UhVbHvGQ7u2lRuqcdvVsAUHVf8=;
        b=AhbVgluwrJrNd+ZcBjQHaMqV4FSxpzqM601IbJNxKfAAmIIxy0f7OssfjbEkcOVea1pjUp
        x9+sKrwzlELO7L2QhPqkQUch8GB+iaLgzb2anM0ZWHYKcZvvlVXl0BswKpbCHHdAdRVZKj
        eeJSIh3wpoQSYe2zUOJ5pFiPxRzziImWfq/Lrmp7q250f4fjQ27YcAQXNEc9NV1YTQHgSc
        znSI++2sdpd3VvbPLBGfzGoLHHPPZaL74RMmlCHFlqzVg0cGQvYu9PoBu+eC03ViSVvMWp
        RgL1VH4yIBqgkvwHlTxzGMgOkA2GqBen4Y6L8q2ls4dMgJM98UA+78b/DHmvxw==
From:   luca.ceresoli@bootlin.com
To:     alsa-devel@alsa-project.org, linux-rockchip@lists.infradead.org
Cc:     Luca Ceresoli <luca.ceresoli@bootlin.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 5/8] ASoC: rockchip: i2s-tdm: Fix clk_id usage in .set_sysclk()
Date:   Wed,  7 Sep 2022 16:21:21 +0200
Message-Id: <20220907142124.2532620-6-luca.ceresoli@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220907142124.2532620-1-luca.ceresoli@bootlin.com>
References: <20220907142124.2532620-1-luca.ceresoli@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luca Ceresoli <luca.ceresoli@bootlin.com>

There are two problems with the second parameter of
rockchip_i2s_tdm_set_sysclk():

 1. The second argument to a .set_sysclk() op is a clk_id, not a stream
    index, so it is incorrect to compare it with SNDRV_PCM_STREAM_PLAYBACK.

    Technically this code works correctly anyway because
    SNDRV_PCM_STREAM_PLAYBACK is defined as 0, which is also the clk_id for
    the mclk_tx as enforced by the device tree bindings. So this is a
    formal error, not triggering incorrect behaviour.

 2. The else branch will consider any nonzero value as "rx", while only
    value 1 should be allowed for the mclk_rx clock. This does trigger
    incorrect behaviour if passing clk_id not equal to 0 or 1.

Fix problem 1 by adding a new enum for the clock indexes as enforced in
device tree and replace accordingly:

 * stream -> clk_id
 * SNDRV_PCM_STREAM_PLAYBACK -> CLK_MCLK_TX (value 0)

Fix problem 2 by adding an 'else if' and returning error if clk_id is not 0
or 1.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 sound/soc/rockchip/rockchip_i2s_tdm.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_i2s_tdm.c b/sound/soc/rockchip/rockchip_i2s_tdm.c
index 2550bd2a5e78..4aa80fedb996 100644
--- a/sound/soc/rockchip/rockchip_i2s_tdm.c
+++ b/sound/soc/rockchip/rockchip_i2s_tdm.c
@@ -34,6 +34,9 @@
 #define TRCM_TX 1
 #define TRCM_RX 2
 
+/* Clock indexes as enforced by the DT bindings */
+enum { CLK_IDX_MCLK_TX, CLK_IDX_MCLK_RX };
+
 struct txrx_config {
 	u32 addr;
 	u32 reg;
@@ -969,7 +972,7 @@ static int rockchip_i2s_tdm_trigger(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static int rockchip_i2s_tdm_set_sysclk(struct snd_soc_dai *cpu_dai, int stream,
+static int rockchip_i2s_tdm_set_sysclk(struct snd_soc_dai *cpu_dai, int clk_id,
 				       unsigned int freq, int dir)
 {
 	struct rk_i2s_tdm_dev *i2s_tdm = to_info(cpu_dai);
@@ -978,15 +981,18 @@ static int rockchip_i2s_tdm_set_sysclk(struct snd_soc_dai *cpu_dai, int stream,
 	if (i2s_tdm->clk_trcm) {
 		i2s_tdm->mclk_tx_freq = freq;
 		i2s_tdm->mclk_rx_freq = freq;
+
+		dev_dbg(i2s_tdm->dev, "mclk freq: %u", freq);
 	} else {
-		if (stream == SNDRV_PCM_STREAM_PLAYBACK)
+		if (clk_id == CLK_IDX_MCLK_TX)
 			i2s_tdm->mclk_tx_freq = freq;
-		else
+		else if (clk_id == CLK_IDX_MCLK_RX)
 			i2s_tdm->mclk_rx_freq = freq;
-	}
+		else
+			return -ENOTSUPP;
 
-	dev_dbg(i2s_tdm->dev, "The target mclk_%s freq is: %d\n",
-		stream ? "rx" : "tx", freq);
+		dev_dbg(i2s_tdm->dev, "mclk[%d] freq: %u", clk_id, freq);
+	}
 
 	return 0;
 }
-- 
2.34.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 337945539E5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 20:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233733AbiFUS6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 14:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352977AbiFUS6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 14:58:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D036369
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 11:58:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90D5F616F6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 18:57:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6DBCC3411C;
        Tue, 21 Jun 2022 18:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655837879;
        bh=2xsWIxZWNcmnA/fSbyReBOaWSpwo1zz6UKyS8jFCJ1c=;
        h=From:To:Cc:Subject:Date:From;
        b=jHnzKEj5GGG2YK/PcG1gY5A27p4dUbt/IiTwOJaasEvKaNn86EQBy3nSIAVAiGnep
         lMyJYjHaPsCnhs7XJsaSNDhESynN7qiQt62+GVNfrsRuSdVQgjvyb75PqR+Papyd9q
         eMga+hXbSgaoN8RV1C+Ij/1CZ1lZme4ECzxW3n8H9Et3qOw8xDdGijdu307QXXXios
         uqA2yo4W0ymBA8YoRYDujz3RdFQAAaXgi1kz6kUXrCaYdo89mjIxLgtXk9JeVBYZ3a
         eNWj/ihwpkYKGlZkGPMO/NW6K7QcYqdJIUdKw4FvZGLdYufncLfvp6JVWZtRpdSmHP
         5yXlNmZXd9DGw==
Received: by wens.tw (Postfix, from userid 1000)
        id 83D575F9C4; Wed, 22 Jun 2022 02:57:55 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Judy Hsiao <judyhsiao@chromium.org>
Subject: [PATCH] ASoC: rockchip: i2s: Fix crash on missing pinctrl
Date:   Wed, 22 Jun 2022 02:57:47 +0800
Message-Id: <20220621185747.2782-1-wens@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

Commit 44f362c2cc6d ("ASoC: rockchip: i2s: switch BCLK to GPIO") added
pinctrl lookups, but did not skip the lookup if there was no pinctrl
device tied to the I2S controller. As a result, the lookup was done
on an invalid pointer in such cases, causing a kernel panic.

Only do the subsequent pinctrl state lookups and switch if a pinctrl
device was found.

i2s_pinctrl_select_bclk_{on,off} already guard against missing pinctrl
device or pinctrl state, so those two functions aren't touched.

Fixes: 44f362c2cc6d ("ASoC: rockchip: i2s: switch BCLK to GPIO")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

This is based on next-20220621, which just saw the inclusion of the
commit this patch fixes.

This issue was found and tested on ROC-RK3328-CC. Tried to test on
RK3399, but that has some other DRM driver related crash.

 sound/soc/rockchip/rockchip_i2s.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index be051e48b97b..9fa8ffd712ea 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -808,24 +808,23 @@ static int rockchip_i2s_probe(struct platform_device *pdev)
 
 	i2s->bclk_ratio = 64;
 	i2s->pinctrl = devm_pinctrl_get(&pdev->dev);
-	if (IS_ERR(i2s->pinctrl))
+	if (IS_ERR(i2s->pinctrl)) {
 		dev_err(&pdev->dev, "failed to find i2s pinctrl\n");
+	} else {
+		i2s->bclk_on = pinctrl_lookup_state(i2s->pinctrl, "bclk_on");
+		if (IS_ERR_OR_NULL(i2s->bclk_on))
+			dev_err(&pdev->dev, "failed to find i2s default state\n");
+		else
+			dev_dbg(&pdev->dev, "find i2s bclk state\n");
 
-	i2s->bclk_on = pinctrl_lookup_state(i2s->pinctrl,
-				   "bclk_on");
-	if (IS_ERR_OR_NULL(i2s->bclk_on))
-		dev_err(&pdev->dev, "failed to find i2s default state\n");
-	else
-		dev_dbg(&pdev->dev, "find i2s bclk state\n");
-
-	i2s->bclk_off = pinctrl_lookup_state(i2s->pinctrl,
-				  "bclk_off");
-	if (IS_ERR_OR_NULL(i2s->bclk_off))
-		dev_err(&pdev->dev, "failed to find i2s gpio state\n");
-	else
-		dev_dbg(&pdev->dev, "find i2s bclk_off state\n");
+		i2s->bclk_off = pinctrl_lookup_state(i2s->pinctrl, "bclk_off");
+		if (IS_ERR_OR_NULL(i2s->bclk_off))
+			dev_err(&pdev->dev, "failed to find i2s gpio state\n");
+		else
+			dev_dbg(&pdev->dev, "find i2s bclk_off state\n");
 
-	i2s_pinctrl_select_bclk_off(i2s);
+		i2s_pinctrl_select_bclk_off(i2s);
+	}
 
 	i2s->playback_dma_data.addr = res->start + I2S_TXDR;
 	i2s->playback_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
-- 
2.34.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B870C58BCE7
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 22:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbiHGU1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 16:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbiHGU1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 16:27:17 -0400
Received: from smtp.smtpout.orange.fr (smtp-22.smtpout.orange.fr [80.12.242.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F5564DD
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 13:27:17 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id KmrhoPxI5iBgAKmrhouJDR; Sun, 07 Aug 2022 22:27:15 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 07 Aug 2022 22:27:15 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Harsha Priya <harshapriya.n@intel.com>,
        "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>,
        Naveen M <naveen.m@intel.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Brent Lu <brent.lu@intel.com>, alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: Intel: kbl_rt5663_rt5514_max98927: Simplify clk_get() usage
Date:   Sun,  7 Aug 2022 22:27:12 +0200
Message-Id: <b1b46138f2ce94431d7edd9becc3699159d3992c.1659904023.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If clk_get() returns -ENOENT, there is no need to defer the driver, -ENOENT
will be returned the same for each retries.
So, return the error code directly instead of -EPROBE_DEFER.

Remove this special case and use dev_err_probe() to simplify code. It will
also be less verbose if the clk is really deferred.

Fixes: 47cbea216281 ("ASoC: Intel: eve: Enable mclk and ssp sclk early")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This is based on my understanding of clk_get().
Review with care.

Not sure the Fixes tag is needed. The patch does not fix anything.
If devm_clk_get() returns -ENOENT, it will just loop several time until
the framework gives up.
If it returns -EPROBE_DEFER, this case is already handled by the
"return ret;"

So this patch should be a no-op, just a clean-up.
---
 .../intel/boards/kbl_rt5663_rt5514_max98927.c | 31 ++++---------------
 1 file changed, 6 insertions(+), 25 deletions(-)

diff --git a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
index 2c79fca57b19..e23001ca2d04 100644
--- a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
+++ b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
@@ -798,7 +798,6 @@ static int kabylake_audio_probe(struct platform_device *pdev)
 {
 	struct kbl_codec_private *ctx;
 	struct snd_soc_acpi_mach *mach;
-	int ret;
 
 	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
@@ -815,32 +814,14 @@ static int kabylake_audio_probe(struct platform_device *pdev)
 			&constraints_dmic_2ch : &constraints_dmic_channels;
 
 	ctx->mclk = devm_clk_get(&pdev->dev, "ssp1_mclk");
-	if (IS_ERR(ctx->mclk)) {
-		ret = PTR_ERR(ctx->mclk);
-		if (ret == -ENOENT) {
-			dev_info(&pdev->dev,
-				"Failed to get ssp1_mclk, defer probe\n");
-			return -EPROBE_DEFER;
-		}
-
-		dev_err(&pdev->dev, "Failed to get ssp1_mclk with err:%d\n",
-								ret);
-		return ret;
-	}
+	if (IS_ERR(ctx->mclk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(ctx->mclk),
+				     "Failed to get ssp1_mclk\n");
 
 	ctx->sclk = devm_clk_get(&pdev->dev, "ssp1_sclk");
-	if (IS_ERR(ctx->sclk)) {
-		ret = PTR_ERR(ctx->sclk);
-		if (ret == -ENOENT) {
-			dev_info(&pdev->dev,
-				"Failed to get ssp1_sclk, defer probe\n");
-			return -EPROBE_DEFER;
-		}
-
-		dev_err(&pdev->dev, "Failed to get ssp1_sclk with err:%d\n",
-								ret);
-		return ret;
-	}
+	if (IS_ERR(ctx->sclk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(ctx->sclk),
+				     "Failed to get ssp1_sclk\n");
 
 	return devm_snd_soc_register_card(&pdev->dev, &kabylake_audio_card);
 }
-- 
2.34.1


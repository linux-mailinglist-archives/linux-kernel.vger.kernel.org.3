Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2CD4D7A7B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 06:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236130AbiCNFs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 01:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiCNFs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 01:48:26 -0400
Received: from smtpbg156.qq.com (smtpbg156.qq.com [15.184.82.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465F73FBF5
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 22:47:15 -0700 (PDT)
X-QQ-mid: bizesmtp67t1647236789tdocdkcc
Received: from localhost.localdomain ( [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 14 Mar 2022 13:46:24 +0800 (CST)
X-QQ-SSF: 0140000000200070E000B00A0000000
X-QQ-FEAT: UldK9Jsj7VMaphog27S4lw8S9PU+rNC28DUg751c7z6NeXGelP3fAJx6SMVLa
        l20Xt/iZS2Bdt+ynmnbguGsw+2WSBXglsIc3mBtubwdLLamJGGnqKIy1ACfHGxyYWhgQiE4
        ftWYOQ+ldrZpFHYP65yZgPk48WWeX9EzqpEVUIgKyJWmW+tPQt4y7QJj0PyFafPrJ4kV7FN
        KEYzH332IPtsEuODzKYDF/dq2zWvcU1207Y1kwTyKOhNUBeT3ROo/FZUxUwwNwVARnezjok
        oew/bMle8pepnV5L2HS5dMgZcE2rZC41HNALNQkfKsQ3T8P+FuNC2a0BmYrRTRNmZJjdMFr
        2M/M2M8OPDU5FDr+JkxNPE9mbui6tl+ZN3HmM/Q
X-QQ-GoodBg: 2
From:   Zhen Ni <nizhen@uniontech.com>
To:     broonie@kernel.org, tiwai@suse.com, perex@perex.cz
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Zhen Ni <nizhen@uniontech.com>
Subject: [PATCH v2] ASoC: Intel: boards: Use temporary variable for struct device
Date:   Mon, 14 Mar 2022 13:46:21 +0800
Message-Id: <20220314054621.14694-1-nizhen@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign7
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use temporary variable for struct device to make code neater.

Signed-off-by: Zhen Ni <nizhen@uniontech.com>
---
 sound/soc/intel/boards/cht_bsw_max98090_ti.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/sound/soc/intel/boards/cht_bsw_max98090_ti.c b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
index b3d7a0725ef2..183edd0fd446 100644
--- a/sound/soc/intel/boards/cht_bsw_max98090_ti.c
+++ b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
@@ -538,7 +538,7 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 	const char *platform_name;
 	bool sof_parent;
 
-	drv = devm_kzalloc(&pdev->dev, sizeof(*drv), GFP_KERNEL);
+	drv = devm_kzalloc(dev, sizeof(*drv), GFP_KERNEL);
 	if (!drv)
 		return -ENOMEM;
 
@@ -559,8 +559,8 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 	}
 
 	/* override platform name, if required */
-	snd_soc_card_cht.dev = &pdev->dev;
-	mach = pdev->dev.platform_data;
+	snd_soc_card_cht.dev = dev;
+	mach = dev->platform_data;
 	platform_name = mach->mach_params.platform;
 
 	ret_val = snd_soc_fixup_dai_links_platform_name(&snd_soc_card_cht,
@@ -576,9 +576,9 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 	else
 		mclk_name = "pmc_plt_clk_3";
 
-	drv->mclk = devm_clk_get(&pdev->dev, mclk_name);
+	drv->mclk = devm_clk_get(dev, mclk_name);
 	if (IS_ERR(drv->mclk)) {
-		dev_err(&pdev->dev,
+		dev_err(dev,
 			"Failed to get MCLK from %s: %ld\n",
 			mclk_name, PTR_ERR(drv->mclk));
 		return PTR_ERR(drv->mclk);
@@ -594,12 +594,12 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 	if (drv->quirks & QUIRK_PMC_PLT_CLK_0) {
 		ret_val = clk_prepare_enable(drv->mclk);
 		if (ret_val < 0) {
-			dev_err(&pdev->dev, "MCLK enable error: %d\n", ret_val);
+			dev_err(dev, "MCLK enable error: %d\n", ret_val);
 			return ret_val;
 		}
 	}
 
-	sof_parent = snd_soc_acpi_sof_parent(&pdev->dev);
+	sof_parent = snd_soc_acpi_sof_parent(dev);
 
 	/* set card and driver name */
 	if (sof_parent) {
@@ -614,9 +614,9 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 	if (sof_parent)
 		dev->driver->pm = &snd_soc_pm_ops;
 
-	ret_val = devm_snd_soc_register_card(&pdev->dev, &snd_soc_card_cht);
+	ret_val = devm_snd_soc_register_card(dev, &snd_soc_card_cht);
 	if (ret_val) {
-		dev_err(&pdev->dev,
+		dev_err(dev,
 			"snd_soc_register_card failed %d\n", ret_val);
 		return ret_val;
 	}
-- 
2.20.1




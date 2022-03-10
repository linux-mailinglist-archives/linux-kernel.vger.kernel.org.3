Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106634D4166
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 07:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235433AbiCJGz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 01:55:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiCJGzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 01:55:25 -0500
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE7EF955C
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 22:54:17 -0800 (PST)
X-QQ-mid: bizesmtp66t1646895241t8l07b1o
Received: from localhost.localdomain ( [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 10 Mar 2022 14:53:56 +0800 (CST)
X-QQ-SSF: 0140000000000070D000B00A0000000
X-QQ-FEAT: k0yT7W7BRd0uDTHO9kj1Uf7jIM45xR2rYfRdY3qR4coREosYKAz9qXrIghk1q
        B5TJCvuA2BCm0VQbcwpY0x4J+bmuc0LasytVBfsMKhzqFw+YEATCIZjnvqe47lQSD45wlct
        B92aQCj+9Ru5dpzYNNCRkBBHu244CiE1SHNcb43MA39oIQhTyu/BprZaknI4sR/YSIuQZsO
        hUxY59eP0hM/O5tdOhYlq6x0ND65I/zXusCkrnYWvBTOFeApIvR0vQDvwj0dNdbKXAtS0D+
        C1MKj+MLWh+N0WOUkn963kC/yjrEKw0iaXdvs39Za4/3EnpMgMW4twMWtKpO5uOIQEK1KOd
        zyKSzqxQ20jnHoQE3vJbh2thpk92g==
X-QQ-GoodBg: 2
From:   Zhen Ni <nizhen@uniontech.com>
To:     broonie@kernel.org, tiwai@suse.com, perex@perex.cz
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Zhen Ni <nizhen@uniontech.com>
Subject: [PATCH] ASoC: Intel: boards: Use temporary variable for struct device
Date:   Thu, 10 Mar 2022 14:53:54 +0800
Message-Id: <20220310065354.14493-1-nizhen@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign7
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
index 1bc21434c9de..d9f4206e1f96 100644
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
 
 	/* override plaform name, if required */
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




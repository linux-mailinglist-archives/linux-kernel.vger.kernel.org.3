Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 695724F0839
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 08:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355363AbiDCHAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 03:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355322AbiDCHA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 03:00:29 -0400
Received: from smtp.smtpout.orange.fr (smtp03.smtpout.orange.fr [80.12.242.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6ABD2648
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 23:58:33 -0700 (PDT)
Received: from pop-os.home ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id auBxnonYqN7CcauBynMxii; Sun, 03 Apr 2022 08:58:31 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 03 Apr 2022 08:58:31 +0200
X-ME-IP: 90.126.236.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        alsa-devel@alsa-project.org
Subject: [PATCH v2] ASoC: codecs: Fix an error handling path in (rx|tx|va)_macro_probe()
Date:   Sun,  3 Apr 2022 08:58:27 +0200
Message-Id: <5b5a015a9b1dc8011c6a4053fa49da1f2531e47c.1648969065.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,
        RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After a successful lpass_macro_pds_init() call, lpass_macro_pds_exit() must
be called.

Add the missing call in the error handling path of the probe function and
use it.

Fixes: 9e3d83c52844 ("ASoC: codecs: Add power domains support in digital macro codecs")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Maybe some lpass_macro_pds_init() calls could be moved in order to simplify
some error handling paths. This would avoid the
s/return/ret = <error>; goto err;/ introduced in this patch.
However I'm always reluctant to shuffle code because it sometimes introduce
some subtle bugs. So I've left it as-is.
Let me know the right direction.
---
 sound/soc/codecs/lpass-rx-macro.c | 14 ++++++++++----
 sound/soc/codecs/lpass-tx-macro.c | 14 ++++++++++----
 sound/soc/codecs/lpass-va-macro.c |  8 ++++++--
 3 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/lpass-rx-macro.c b/sound/soc/codecs/lpass-rx-macro.c
index 6884ae505e33..3143f9cd7277 100644
--- a/sound/soc/codecs/lpass-rx-macro.c
+++ b/sound/soc/codecs/lpass-rx-macro.c
@@ -3566,12 +3566,16 @@ static int rx_macro_probe(struct platform_device *pdev)
 		return PTR_ERR(rx->pds);
 
 	base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(base))
-		return PTR_ERR(base);
+	if (IS_ERR(base)) {
+		ret = PTR_ERR(base);
+		goto err;
+	}
 
 	rx->regmap = devm_regmap_init_mmio(dev, base, &rx_regmap_config);
-	if (IS_ERR(rx->regmap))
-		return PTR_ERR(rx->regmap);
+	if (IS_ERR(rx->regmap)) {
+		ret = PTR_ERR(rx->regmap);
+		goto err;
+	}
 
 	dev_set_drvdata(dev, rx);
 
@@ -3632,6 +3636,8 @@ static int rx_macro_probe(struct platform_device *pdev)
 err_dcodec:
 	clk_disable_unprepare(rx->macro);
 err:
+	lpass_macro_pds_exit(rx->pds);
+
 	return ret;
 }
 
diff --git a/sound/soc/codecs/lpass-tx-macro.c b/sound/soc/codecs/lpass-tx-macro.c
index 714a411d5337..55503ba480bb 100644
--- a/sound/soc/codecs/lpass-tx-macro.c
+++ b/sound/soc/codecs/lpass-tx-macro.c
@@ -1828,8 +1828,10 @@ static int tx_macro_probe(struct platform_device *pdev)
 		return PTR_ERR(tx->pds);
 
 	base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(base))
-		return PTR_ERR(base);
+	if (IS_ERR(base)) {
+		ret = PTR_ERR(base);
+		goto err;
+	}
 
 	/* Update defaults for lpass sc7280 */
 	if (of_device_is_compatible(np, "qcom,sc7280-lpass-tx-macro")) {
@@ -1846,8 +1848,10 @@ static int tx_macro_probe(struct platform_device *pdev)
 	}
 
 	tx->regmap = devm_regmap_init_mmio(dev, base, &tx_regmap_config);
-	if (IS_ERR(tx->regmap))
-		return PTR_ERR(tx->regmap);
+	if (IS_ERR(tx->regmap)) {
+		ret = PTR_ERR(tx->regmap);
+		goto err;
+	}
 
 	dev_set_drvdata(dev, tx);
 
@@ -1907,6 +1911,8 @@ static int tx_macro_probe(struct platform_device *pdev)
 err_dcodec:
 	clk_disable_unprepare(tx->macro);
 err:
+	lpass_macro_pds_exit(tx->pds);
+
 	return ret;
 }
 
diff --git a/sound/soc/codecs/lpass-va-macro.c b/sound/soc/codecs/lpass-va-macro.c
index f3cb596058e0..d18b56e60433 100644
--- a/sound/soc/codecs/lpass-va-macro.c
+++ b/sound/soc/codecs/lpass-va-macro.c
@@ -1434,8 +1434,10 @@ static int va_macro_probe(struct platform_device *pdev)
 		va->dmic_clk_div = VA_MACRO_CLK_DIV_2;
 	} else {
 		ret = va_macro_validate_dmic_sample_rate(sample_rate, va);
-		if (!ret)
-			return -EINVAL;
+		if (!ret) {
+			ret = -EINVAL;
+			goto err;
+		}
 	}
 
 	base = devm_platform_ioremap_resource(pdev, 0);
@@ -1492,6 +1494,8 @@ static int va_macro_probe(struct platform_device *pdev)
 err_dcodec:
 	clk_disable_unprepare(va->macro);
 err:
+	lpass_macro_pds_exit(va->pds);
+
 	return ret;
 }
 
-- 
2.32.0


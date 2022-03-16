Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5954DA93E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 05:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243380AbiCPEUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 00:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237958AbiCPEUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 00:20:44 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B9C850B10
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 21:19:30 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id m22so1227024pja.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 21:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=h/SuuPKRw7w24vf7OzPoNR8TbkFgl2CQUOn+EDnO+xw=;
        b=b+dYa58/Y/mBWqhfqAC4Zm+qdz/l4wkArDE84Y2K6IoBDXbcG6AJmZ8jg1sZyu0VVr
         ko8Ki77J4O2Aday6J1xofFrZtoZpGa9ZARleXA9cPsPok4UQ/uQMrkvtaLkIIfGYww6h
         9aAAO0BTukW5rtXtmkDS0EA/7qlZpQvEenW6B+7ah0Aa2iJ8qL5JJm4ZFculslZoZ/rA
         Q8jvTc/V0K3jcD18IIoslXo3QNTbKVgR/zzS9lqvJ62hveC8g5c/lTndF2PX1w2rjijz
         Qzfh2pWIYzpD5lBDPscWIxJMBTpw5tnilqBGHX6M5IHkYrnsuxBiwiFZ5pvyzB2Xsh2i
         W81w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=h/SuuPKRw7w24vf7OzPoNR8TbkFgl2CQUOn+EDnO+xw=;
        b=tC2SfQvvH+I9F55sejdLPQkvYRanwm5yk6BM58IbVHCNKJZT4ehAxK8RZ8Dxpj1uiP
         oCyTckt4YqhqguasQzpZnkM7EcH7tz4vc6Q7yW1xUkkMGoPa+wSBZ3Sw8P3RwK7Zfqsy
         Q5YkUL+l1tVgWJwk/MnMOC7LKyYhyxaTFsmICMWHf8wimlLN5w9aeW2i/2dEXKt7lNO2
         EwChdpYTZ7GHAocnC2aqpkqStGDkek0tYbkqdPWQ8Ctnoby8YfgKj8ZctLltYq61u3F4
         TPFCwsQteG7/MJfDOXIQRw3mhldZMN/Xw7CA73i65T1Ti4zI+xIZ7K9jQibIaRW4cKkT
         3h2Q==
X-Gm-Message-State: AOAM53090HxWH5A7FKCWRsdm3afpHC+Geww/NNACN6IuRpTU00xLQSUe
        SUJgy9iBOkI7v008BLkxOAk=
X-Google-Smtp-Source: ABdhPJzDSyxdyR405aaXQ572+WpSnGuXpBx5bgw+mkMJqEpnBrS0Kp8BwXkoGY24sqOoP+f9qNP86w==
X-Received: by 2002:a17:902:e949:b0:14b:1f32:e926 with SMTP id b9-20020a170902e94900b0014b1f32e926mr31673690pll.170.1647404370056;
        Tue, 15 Mar 2022 21:19:30 -0700 (PDT)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id 2-20020a17090a034200b001bfc572d018sm722839pjf.48.2022.03.15.21.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 21:19:29 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] ASoC: msm8916-wcd-analog: Fix error handling in pm8916_wcd_analog_spmi_probe
Date:   Wed, 16 Mar 2022 04:19:24 +0000
Message-Id: <20220316041924.17560-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the error handling path, the clk_prepare_enable() function
call should be balanced by a corresponding 'clk_disable_unprepare()'
call , as already done in the remove function.

Fixes: de66b3455023 ("ASoC: codecs: msm8916-wcd-analog: add MBHC support")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 sound/soc/codecs/msm8916-wcd-analog.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/msm8916-wcd-analog.c b/sound/soc/codecs/msm8916-wcd-analog.c
index 485cda46dbb9..e52a559c52d6 100644
--- a/sound/soc/codecs/msm8916-wcd-analog.c
+++ b/sound/soc/codecs/msm8916-wcd-analog.c
@@ -1222,8 +1222,10 @@ static int pm8916_wcd_analog_spmi_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq_byname(pdev, "mbhc_switch_int");
-	if (irq < 0)
-		return irq;
+	if (irq < 0) {
+		ret = irq;
+		goto err_disable_clk;
+	}
 
 	ret = devm_request_threaded_irq(dev, irq, NULL,
 			       pm8916_mbhc_switch_irq_handler,
@@ -1235,8 +1237,10 @@ static int pm8916_wcd_analog_spmi_probe(struct platform_device *pdev)
 
 	if (priv->mbhc_btn_enabled) {
 		irq = platform_get_irq_byname(pdev, "mbhc_but_press_det");
-		if (irq < 0)
-			return irq;
+		if (irq < 0) {
+			ret = irq;
+			goto err_disable_clk;
+		}
 
 		ret = devm_request_threaded_irq(dev, irq, NULL,
 				       mbhc_btn_press_irq_handler,
@@ -1247,8 +1251,10 @@ static int pm8916_wcd_analog_spmi_probe(struct platform_device *pdev)
 			dev_err(dev, "cannot request mbhc button press irq\n");
 
 		irq = platform_get_irq_byname(pdev, "mbhc_but_rel_det");
-		if (irq < 0)
-			return irq;
+		if (irq < 0) {
+			ret = irq;
+			goto err_disable_clk;
+		}
 
 		ret = devm_request_threaded_irq(dev, irq, NULL,
 				       mbhc_btn_release_irq_handler,
@@ -1265,6 +1271,10 @@ static int pm8916_wcd_analog_spmi_probe(struct platform_device *pdev)
 	return devm_snd_soc_register_component(dev, &pm8916_wcd_analog,
 				      pm8916_wcd_analog_dai,
 				      ARRAY_SIZE(pm8916_wcd_analog_dai));
+
+err_disable_clk:
+	clk_disable_unprepare(priv->mclk);
+	return ret;
 }
 
 static int pm8916_wcd_analog_spmi_remove(struct platform_device *pdev)
-- 
2.17.1


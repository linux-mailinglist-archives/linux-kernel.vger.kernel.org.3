Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A43704CF3E2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 09:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232890AbiCGIqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 03:46:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiCGIqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 03:46:22 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4715762A19
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 00:45:29 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id mr24-20020a17090b239800b001bf0a375440so10598745pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 00:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=UnOTdbP36uQdWVvv2vJzAekSb/8o0Oe+p5E2vt+S+ug=;
        b=T4NVnNiGS1Muf3VR2in4zLSK86XJVDGHoEhJhvCUEBQ+3tcPvmrHZUpGvRdlsjtcs4
         U50wcXlRgK+zhrWV4Wrq7XTvZzb4ISOwQ8GfCw9hBFWbMhrW/Y7VgTyvNsV5s1mX/4F0
         PteXB58we6VQrZz/q/4fA4WHXnzyDUYTObtckFHPN7mJSn38eeBSU4xrpIkXPHrT0GV2
         oBB+NXcHG99GIGXSUo+aaDBjkOKwar1nIUmQQ3w85UlQNLGbp02jdmZ/DPoh3YegGzJt
         7qAvtXrpxJ9VoYFidxl64YYlwOxIGuxDp8vp0NKP9xuTzd83QKaS11o4RUcdxNumWZ99
         tSFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UnOTdbP36uQdWVvv2vJzAekSb/8o0Oe+p5E2vt+S+ug=;
        b=uIyCvczFt64Xg5nQwzVm3t/x5S8OSpASaYvcqdEXDYvOoLFJr2TNk0G5g+URkDtyCe
         31OHrusAp2fBWLCTWXBzdn9bfMJKM/8HN3zlGwfOGQ5r22Zvae/stvPwl1FZKnjhnWRw
         eEbXImsZnWLUQ4qmD1f0yJny/EFq/CBnE+VKnI/6Xi09XzJZmLAo/afUMOG/1geVIqhf
         f8Qw7ywf7uMEcRIGhrFBPpSmQtCHJunfMBFiDUYYlzY2z7scUELRR3W03K0FAarlwK+e
         4iukKOuHgIZRdKA4yAhUjBrpbzkrhClHC3eLkfBVmFsQw3Cg9Fw+xPVn9tW3zM61R3us
         sfeQ==
X-Gm-Message-State: AOAM530iZzBltH1YO7kd/lt4xVQRL1ojt6WQRNyZ/Qhzf5svDBm0uMo2
        0+FbIpZbXUspsQpYOriA6N8=
X-Google-Smtp-Source: ABdhPJxr0p4VCR38LEhMY2qMANg8ktrD0H+xhr3U1pYrZh5H3mjPOrE5RdurcbcW+/wY8D7+31RCXA==
X-Received: by 2002:a17:90b:4b4a:b0:1bf:83d:6805 with SMTP id mi10-20020a17090b4b4a00b001bf083d6805mr24461078pjb.174.1646642728807;
        Mon, 07 Mar 2022 00:45:28 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id a133-20020a621a8b000000b004f6a79008ddsm12541851pfa.45.2022.03.07.00.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 00:45:28 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] ASoC: msm8916-wcd-digital: Fix missing clk_disable_unprepare() in msm8916_wcd_digital_probe
Date:   Mon,  7 Mar 2022 08:45:22 +0000
Message-Id: <20220307084523.28687-1-linmq006@gmail.com>
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

Fix the missing clk_disable_unprepare() before return
from msm8916_wcd_digital_probe in the error handling case.

Fixes: 150db8c5afa1 ("ASoC: codecs: Add msm8916-wcd digital codec")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 sound/soc/codecs/msm8916-wcd-digital.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/msm8916-wcd-digital.c b/sound/soc/codecs/msm8916-wcd-digital.c
index fcc10c8bc625..9ad7fc0baf07 100644
--- a/sound/soc/codecs/msm8916-wcd-digital.c
+++ b/sound/soc/codecs/msm8916-wcd-digital.c
@@ -1201,7 +1201,7 @@ static int msm8916_wcd_digital_probe(struct platform_device *pdev)
 	ret = clk_prepare_enable(priv->mclk);
 	if (ret < 0) {
 		dev_err(dev, "failed to enable mclk %d\n", ret);
-		return ret;
+		goto err_clk;
 	}
 
 	dev_set_drvdata(dev, priv);
@@ -1209,6 +1209,9 @@ static int msm8916_wcd_digital_probe(struct platform_device *pdev)
 	return devm_snd_soc_register_component(dev, &msm8916_wcd_digital,
 				      msm8916_wcd_digital_dai,
 				      ARRAY_SIZE(msm8916_wcd_digital_dai));
+err_clk:
+	clk_disable_unprepare(priv->ahbclk);
+	return ret;
 }
 
 static int msm8916_wcd_digital_remove(struct platform_device *pdev)
-- 
2.17.1


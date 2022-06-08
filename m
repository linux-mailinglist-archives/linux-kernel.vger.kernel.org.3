Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97650542ABA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 11:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234186AbiFHJGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 05:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234331AbiFHJEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 05:04:05 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4BE2BCC81;
        Wed,  8 Jun 2022 01:23:41 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id d14so483179eda.12;
        Wed, 08 Jun 2022 01:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gfVSp3scFj4P4guPC4wruDfDMf9c2cvAElZfIMx3LEY=;
        b=OJ/tH0klk5aBgBXi38k8hIN16orCQvOAI0upfkhUCVxdcz26LvKxPv3BvzUAKAf2oX
         2LL+TozngPMHrT0yJt7T6njY2izvfu6/wjXSnPiagbggsgq6MQyDlr6xYS+HrkXybkZr
         CH8zUUg4VSKdy1rWsZgCFIMxtFqpH6cFJnR17zLdgT1EYI0Ybg9qtyBG8qFWhqEixAhb
         RxhrsH5V26q+WxfV+z8ido1iu9i/dwnB6T/0oYU635S5uLIr4jbqmicDGG2Tscrq4Fzh
         VpjrJM5ugTBF092XAD/UX+J7X3pvzlmSLaapqMrliD7sIYyO7accRXtbR+3VO1ouLPxz
         N8aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gfVSp3scFj4P4guPC4wruDfDMf9c2cvAElZfIMx3LEY=;
        b=b9tcGLRJjMuY33LO+nBVil3o0UjZ/2H1Jz+UjS2b80/Q+mSfE7NH13LFuJVWGKxCyo
         D3iblWgMENzUZCvGjZzI6VBqaMQE/c7YMQF5EBD4TQg35QZ5kW2iogVVdNyfZ1svLET+
         YOX/ZlOg0uUtvyPym0RvsvncR6BWJs2ZaDhRZFcJ7/ZZdgGYWaXFsUte8zFIY//s6Bw9
         jIBzwEtXN2I3kyOvg5OOl/W9eryj1X8QV/SnJJPZVWD5+g9J3MmIW+1EYLtCOq5W3hVv
         7E1vkWNskT+RgKz5dpWdXPYfcDCjTV5yKeZ3ipTQx1l69kgEwQBaSatIV/bqfWUh+nN3
         r0gw==
X-Gm-Message-State: AOAM532YIv/C5gnc/D6xvOQnHXLN5sXhizm3NSO22+7cU0vW536n9eP/
        gLRs8oUMzcym5l3F3hn+478=
X-Google-Smtp-Source: ABdhPJxjJ1Ux3SAC4HGYqyivoD6H+CP/FNb5tKHoOonTD8XxJzdvFsTeNrf7nmvzlFISsKOZAnSCUg==
X-Received: by 2002:a05:6402:3899:b0:42d:d79e:acef with SMTP id fd25-20020a056402389900b0042dd79eacefmr37664268edb.12.1654676619754;
        Wed, 08 Jun 2022 01:23:39 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id o5-20020aa7c7c5000000b0042ad421574esm11965179eds.33.2022.06.08.01.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 01:23:39 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] ASoC: mediatek: mt8186: Fix a handful of spelling mistakes
Date:   Wed,  8 Jun 2022 09:23:38 +0100
Message-Id: <20220608082338.2083456-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are several spelling mistakes in dev_err messages. Fix them.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 sound/soc/mediatek/mt8186/mt8186-afe-gpio.c | 8 ++++----
 sound/soc/mediatek/mt8186/mt8186-dai-adda.c | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/mediatek/mt8186/mt8186-afe-gpio.c b/sound/soc/mediatek/mt8186/mt8186-afe-gpio.c
index 5ba28095b7da..255ffba637d3 100644
--- a/sound/soc/mediatek/mt8186/mt8186-afe-gpio.c
+++ b/sound/soc/mediatek/mt8186/mt8186-afe-gpio.c
@@ -137,25 +137,25 @@ static int mt8186_afe_gpio_adda_dl(struct device *dev, bool enable)
 	if (enable) {
 		ret = mt8186_afe_gpio_select(dev, MT8186_AFE_GPIO_CLK_MOSI_ON);
 		if (ret) {
-			dev_err(dev, "%s(), MOSI CLK ON slect fail!\n", __func__);
+			dev_err(dev, "%s(), MOSI CLK ON select fail!\n", __func__);
 			return ret;
 		}
 
 		ret = mt8186_afe_gpio_select(dev, MT8186_AFE_GPIO_DAT_MOSI_ON);
 		if (ret) {
-			dev_err(dev, "%s(), MOSI DAT ON slect fail!\n", __func__);
+			dev_err(dev, "%s(), MOSI DAT ON select fail!\n", __func__);
 			return ret;
 		}
 	} else {
 		ret = mt8186_afe_gpio_select(dev, MT8186_AFE_GPIO_DAT_MOSI_OFF);
 		if (ret) {
-			dev_err(dev, "%s(), MOSI DAT OFF slect fail!\n", __func__);
+			dev_err(dev, "%s(), MOSI DAT OFF select fail!\n", __func__);
 			return ret;
 		}
 
 		ret = mt8186_afe_gpio_select(dev, MT8186_AFE_GPIO_CLK_MOSI_OFF);
 		if (ret) {
-			dev_err(dev, "%s(), MOSI CLK ON slect fail!\n", __func__);
+			dev_err(dev, "%s(), MOSI CLK ON select fail!\n", __func__);
 			return ret;
 		}
 	}
diff --git a/sound/soc/mediatek/mt8186/mt8186-dai-adda.c b/sound/soc/mediatek/mt8186/mt8186-dai-adda.c
index c66861fd197d..db71b032770d 100644
--- a/sound/soc/mediatek/mt8186/mt8186-dai-adda.c
+++ b/sound/soc/mediatek/mt8186/mt8186-dai-adda.c
@@ -341,7 +341,7 @@ static int mtk_adda_mtkaif_cfg_event(struct snd_soc_dapm_widget *w,
 				if (afe_priv->mtkaif_chosen_phase[0] < 0 ||
 				    afe_priv->mtkaif_chosen_phase[1] < 0) {
 					dev_err(afe->dev,
-						"%s(), skip dealy setting mtkaif_chosen_phase[0/1]:%d/%d\n",
+						"%s(), skip delay setting mtkaif_chosen_phase[0/1]:%d/%d\n",
 						__func__,
 						afe_priv->mtkaif_chosen_phase[0],
 						afe_priv->mtkaif_chosen_phase[1]);
-- 
2.35.3


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C13D3522CB1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 08:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242360AbiEKG6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 02:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233352AbiEKG6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 02:58:17 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F81D994FA
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 23:58:15 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id l11-20020a17090a49cb00b001d923a9ca99so1255420pjm.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 23:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K6wA7u9nlH2LdboqPtaGVfPJPki2AKRQH5484bIHWMg=;
        b=pgjJK2J39T3beCax1II7a6Dqfmdllwbq+uAase9DTEpHkBGCFCCvVu8HbOEwWKI9T0
         /pih1l6aBpvIl9mSeaXn6BOyuf0MdTOFcY+6lMQf4IMdGYEGbkWgReR5kHEX7G2x9PN/
         qeU/D5dc0FTYlZCoBy87ORI12sLce4/ykfmoeKovnUp0pNWv8y5tZA3DL4prCrdrV7Ts
         n8bXfTG4Hbs4qw8+LlUw1N4qmDjpFNIzKoazkMlomEYbDDFlklO7LH+mb1jrY09jh6ey
         UGfDlNBYejMGhVfof1VA1t/YDu/cgnD2E57oQDnyAfhRzqYYykMJRkAjwOe78YX4hoUM
         ojxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K6wA7u9nlH2LdboqPtaGVfPJPki2AKRQH5484bIHWMg=;
        b=5Bw1eB+WPIO7etBlolHuvsLDy7rEismjJ8mHyDpOUK5gPO5dl0c6pHS+QsNzJKk5eE
         pylcTOG7SgJAog3/FULhxWjnWiMJrgxsTBTQDFu/EmA7c+SkUiFL+4CEDlCxXbaocJnW
         cXzEO9ypto6rRhUXEKILxnGNPFpmi39zL+49sAVb/unC5LTpeonxBjT44wEV9c92OU+g
         KZMkcZzql0Qo3CZ4mFZBUVeJ7sD77ciY1Xih6AfzARR4EdB//Ba7vUa7Nk4X5yGfhqPI
         Cj1G1ScAnXUBqivIKKeGOsDAKfy/plfX1UBR3SMTDg7D3y3bOP3/QNzxKv0ukxngyEwY
         RCYg==
X-Gm-Message-State: AOAM531XfJsodaOR/NX1+jMLmVnDyvQF8aer9xHRJrSgnacNZINxNfhJ
        Ur+iaMb0h7PjI9O5JS8uPcUScL5jQaAHfquCEYs=
X-Google-Smtp-Source: ABdhPJycTqz9MfSxmTeQC3NNqRXwnBmg1ggt7GaNqU7Xvy/Afslm0yAQen3gRZ0c3GVtCC7vQ2id5Q==
X-Received: by 2002:a17:902:c2cf:b0:15f:1396:f54e with SMTP id c15-20020a170902c2cf00b0015f1396f54emr12870792pla.161.1652252294808;
        Tue, 10 May 2022 23:58:14 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id u18-20020a62ed12000000b0050dc76281a3sm766115pfh.125.2022.05.10.23.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 23:58:14 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Richard Zhao <richard.zhao@linaro.org>,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] ASoC: fsl: Fix refcount leak in imx_sgtl5000_probe
Date:   Wed, 11 May 2022 10:58:03 +0400
Message-Id: <20220511065803.3957-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_find_i2c_device_by_node() takes a reference,
In error paths, we should call put_device() to drop
the reference to aviod refount leak.

Fixes: 81e8e4926167 ("ASoC: fsl: add sgtl5000 clock support for imx-sgtl5000")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 sound/soc/fsl/imx-sgtl5000.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/sound/soc/fsl/imx-sgtl5000.c b/sound/soc/fsl/imx-sgtl5000.c
index 8daced42d55e..580a0d963f0e 100644
--- a/sound/soc/fsl/imx-sgtl5000.c
+++ b/sound/soc/fsl/imx-sgtl5000.c
@@ -120,19 +120,19 @@ static int imx_sgtl5000_probe(struct platform_device *pdev)
 	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
 	if (!data) {
 		ret = -ENOMEM;
-		goto fail;
+		goto put_device;
 	}
 
 	comp = devm_kzalloc(&pdev->dev, 3 * sizeof(*comp), GFP_KERNEL);
 	if (!comp) {
 		ret = -ENOMEM;
-		goto fail;
+		goto put_device;
 	}
 
 	data->codec_clk = clk_get(&codec_dev->dev, NULL);
 	if (IS_ERR(data->codec_clk)) {
 		ret = PTR_ERR(data->codec_clk);
-		goto fail;
+		goto put_device;
 	}
 
 	data->clk_frequency = clk_get_rate(data->codec_clk);
@@ -158,10 +158,10 @@ static int imx_sgtl5000_probe(struct platform_device *pdev)
 	data->card.dev = &pdev->dev;
 	ret = snd_soc_of_parse_card_name(&data->card, "model");
 	if (ret)
-		goto fail;
+		goto put_device;
 	ret = snd_soc_of_parse_audio_routing(&data->card, "audio-routing");
 	if (ret)
-		goto fail;
+		goto put_device;
 	data->card.num_links = 1;
 	data->card.owner = THIS_MODULE;
 	data->card.dai_link = &data->dai;
@@ -174,7 +174,7 @@ static int imx_sgtl5000_probe(struct platform_device *pdev)
 	ret = devm_snd_soc_register_card(&pdev->dev, &data->card);
 	if (ret) {
 		dev_err_probe(&pdev->dev, ret, "snd_soc_register_card failed\n");
-		goto fail;
+		goto put_device;
 	}
 
 	of_node_put(ssi_np);
@@ -182,6 +182,8 @@ static int imx_sgtl5000_probe(struct platform_device *pdev)
 
 	return 0;
 
+put_device:
+	put_device(&codec_dev->dev);
 fail:
 	if (data && !IS_ERR(data->codec_clk))
 		clk_put(data->codec_clk);
-- 
2.25.1


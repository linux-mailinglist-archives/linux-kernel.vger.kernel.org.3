Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D82D5693FD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 23:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234521AbiGFVMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 17:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234474AbiGFVMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 17:12:43 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0893A5FD3;
        Wed,  6 Jul 2022 14:12:42 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id y4so7435182edc.4;
        Wed, 06 Jul 2022 14:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KTTKYV8d4X6LUcp6wXzH0WT3BXkDsllwJZTXbqSmykQ=;
        b=R1bLn1X4PkihjzuE2uP75+eHLVZo2WXW1pFTzT2PqlznkGgRYaS1K/+Yh9x0Qm/nqV
         p6NLLc9Znui4245+E6usa817XsEYc557TEo9/1LXkKqafISR5mBTxvp2x3mZpEVFiwQp
         V6A/eR25hbRUDopT9XgLpzFaXMYCZP2ZAZ7V0ljAbdt9J3SzuTzMWXhFiBD6vs1YadsR
         FPpKK1mzey2CHqBFtUb0KP4aiJwe/x4zOmEctCccmyBL7M8367TxrUXgNE/VOFx90OR6
         uFudHjmOREFiWz/iUYzHd72WDE/T/dR6Gbt+PRm5mRFPG4oEPXG3BEt+hbZZUY+zECii
         ZTTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KTTKYV8d4X6LUcp6wXzH0WT3BXkDsllwJZTXbqSmykQ=;
        b=PLXj49RnbevZVDo6HxIhersbIv0O5kCvWuCmZTZtHs1BKLC471zO5j+IjLqvukFcrx
         d3MNSDGDPDPDgOkDhy3EzfOgi+Flyg+5UjcafYpAAO4yOoNUXOeomIVYrJBbVptMMeDg
         TIrw1NT+PCmBu4mWpVrrFRx50OnKjP0LYgV37aObq4ad4SKqUmiwAEIfYjXAF9H9gvhT
         TFrHVVNXUJ5OIDJR3deI8EV24r/CJerWw7oBcG8n/kXMMiBanzlQ5KDuipaJ/8ZUeEza
         N+kmhNF7yGyyVpvnP5qWyfLfnXyvFsVjKsuh+Jm2G7vuLfEwEOZB7dqiBrtXmNmz3u9W
         qMQw==
X-Gm-Message-State: AJIora/EG8aM4VXQzKDGg1Riy/XUsqPMKEkcR5IeRcCXNALvbpET1CUj
        HvaFIlFsDn+eL8HCyJJjwpe25XI253c=
X-Google-Smtp-Source: AGRyM1uBRFBoE3bP3pt0o5jp3L85/DNosrc9hL7YrPp7PRYgApGHyCFwxFsWRBsshbHio/+XTSxeRA==
X-Received: by 2002:a05:6402:1518:b0:43a:103f:eaab with SMTP id f24-20020a056402151800b0043a103feaabmr30996636edw.280.1657141960593;
        Wed, 06 Jul 2022 14:12:40 -0700 (PDT)
Received: from localhost (92.40.202.8.threembb.co.uk. [92.40.202.8])
        by smtp.gmail.com with ESMTPSA id u17-20020a056402111100b0043a6e807febsm6569925edv.46.2022.07.06.14.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 14:12:40 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     linux-mips@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/11] ASoC: jz4740-i2s: Refactor DMA channel setup
Date:   Wed,  6 Jul 2022 22:13:21 +0100
Message-Id: <20220706211330.120198-3-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220706211330.120198-1-aidanmacdonald.0x0@gmail.com>
References: <20220706211330.120198-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's simpler to set up the playback and capture DMA settings
at driver probe time instead of during DAI probing.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 sound/soc/jz4740/jz4740-i2s.c | 23 +++++------------------
 1 file changed, 5 insertions(+), 18 deletions(-)

diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s.c
index 298ff0a83931..ecd8df70d39c 100644
--- a/sound/soc/jz4740/jz4740-i2s.c
+++ b/sound/soc/jz4740/jz4740-i2s.c
@@ -95,7 +95,6 @@ struct i2s_soc_info {
 struct jz4740_i2s {
 	struct resource *mem;
 	void __iomem *base;
-	dma_addr_t phys_base;
 
 	struct clk *clk_aic;
 	struct clk *clk_i2s;
@@ -370,21 +369,6 @@ static int jz4740_i2s_resume(struct snd_soc_component *component)
 	return 0;
 }
 
-static void jz4740_i2s_init_pcm_config(struct jz4740_i2s *i2s)
-{
-	struct snd_dmaengine_dai_dma_data *dma_data;
-
-	/* Playback */
-	dma_data = &i2s->playback_dma_data;
-	dma_data->maxburst = 16;
-	dma_data->addr = i2s->phys_base + JZ_REG_AIC_FIFO;
-
-	/* Capture */
-	dma_data = &i2s->capture_dma_data;
-	dma_data->maxburst = 16;
-	dma_data->addr = i2s->phys_base + JZ_REG_AIC_FIFO;
-}
-
 static int jz4740_i2s_dai_probe(struct snd_soc_dai *dai)
 {
 	struct jz4740_i2s *i2s = snd_soc_dai_get_drvdata(dai);
@@ -395,7 +379,6 @@ static int jz4740_i2s_dai_probe(struct snd_soc_dai *dai)
 	if (ret)
 		return ret;
 
-	jz4740_i2s_init_pcm_config(i2s);
 	snd_soc_dai_init_dma_data(dai, &i2s->playback_dma_data,
 		&i2s->capture_dma_data);
 
@@ -529,7 +512,11 @@ static int jz4740_i2s_dev_probe(struct platform_device *pdev)
 	if (IS_ERR(i2s->base))
 		return PTR_ERR(i2s->base);
 
-	i2s->phys_base = mem->start;
+	i2s->playback_dma_data.maxburst = 16;
+	i2s->playback_dma_data.addr = mem->start + JZ_REG_AIC_FIFO;
+
+	i2s->capture_dma_data.maxburst = 16;
+	i2s->capture_dma_data.addr = mem->start + JZ_REG_AIC_FIFO;
 
 	i2s->clk_aic = devm_clk_get(dev, "aic");
 	if (IS_ERR(i2s->clk_aic))
-- 
2.35.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD84F5150DD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 18:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379224AbiD2QcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 12:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379157AbiD2Qbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 12:31:31 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4FADA6D1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:28:12 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id u3so11472681wrg.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W02ZGFHvTom682Vt/5ZDBm82Dshs+9c52rgnIE8M/O8=;
        b=XANGuqMnAHvHiKxlYHEKFPuaiVPTE22M7raSntk/487XA8yR4hgkBL8kCeU3KQkstq
         JnMqjrwNmDYznJaCM13O7a3E4LgCNfyDBhhzD27RcoDGw+nyxUKSH0LwBpbX8cncKQgg
         Re0k8v9CnTFJZRjsF++Re+/7Hu9jkOl9hW5/CUylx/m1nS+xu1IwCCz6Irxqo0K8Ur+R
         7UZxrotimTvRRmv4QO3VKrkbjGFK1SbX+hAUNXetihoKahDZHwW8SAN4YKUKmg7CuyFE
         7bIGY/ipUgHhA0DwZfUqMI6Il5YmwByATXeaOUHicXShPjU9Ax7vIBaI0jsprgpIjVRu
         WfyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W02ZGFHvTom682Vt/5ZDBm82Dshs+9c52rgnIE8M/O8=;
        b=XpCzyZdNIJDm3wxZesaIXGQj2OSWH0jgeLqskbeRxnYi7TRiwhEEVNqqqK3n+OO9A1
         +EJ4TetDzrz4SGH7RL1ysMSVNnDXf8Rd+w30SxPHaOv/J8gaizkPL3+y/ZLlcgCsjfvn
         b8UJvwqOSabQ/StL8GiRdWmvE+Is3+u61z69AVa9+QhSnEmpGMIdBUtr9QpW2XJdnisz
         VhBkjPa/73isoSJN5bixEqWtQryhu8J4B6qrDfIqMND/HBddg7fGaod9Vbfeor2nKrnw
         2wzNB1YoiPzHMwr5mcgNMqXVzZLlXzPP5Zs8bOZUAg1B/FvTy0IZHRM1y6Ay53YJEP2w
         zmrA==
X-Gm-Message-State: AOAM533AbX6O5AWpu3Oh4XC69CVzhiZgGOGBfo0bBdzmbeypTkL0ni57
        aeCVt3rLqU3w0LxdfMygdJBDtg==
X-Google-Smtp-Source: ABdhPJx6cG4LFft8r/HYJhXkugfjWRYIZi1nmOwr9vzkYV5Lr1Q2AjffwMup6mfbL7ZAMDIjVH67/w==
X-Received: by 2002:a5d:598e:0:b0:20a:e85a:9b27 with SMTP id n14-20020a5d598e000000b0020ae85a9b27mr15299338wri.656.1651249691126;
        Fri, 29 Apr 2022 09:28:11 -0700 (PDT)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id b5-20020adff905000000b0020a8781be70sm2781801wrr.12.2022.04.29.09.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 09:28:10 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Sean Anderson <sean.anderson@seco.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 15/16] nvmem: sfp: Use regmap
Date:   Fri, 29 Apr 2022 17:27:00 +0100
Message-Id: <20220429162701.2222-16-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220429162701.2222-1-srinivas.kandagatla@linaro.org>
References: <20220429162701.2222-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Anderson <sean.anderson@seco.com>

This converts the SFP driver to use regmap. This will allow easily
supporting devices with different endians. We disallow byte-level
access, as regmap_bulk_read doesn't support it (and it's unclear what
the correct result would be when we have an endianness difference).

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/Kconfig          |  1 +
 drivers/nvmem/layerscape-sfp.c | 30 ++++++++++++++++++++++--------
 2 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 6283e09cc1e9..967d0084800e 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -304,6 +304,7 @@ config NVMEM_LAYERSCAPE_SFP
 	tristate "Layerscape SFP (Security Fuse Processor) support"
 	depends on ARCH_LAYERSCAPE || COMPILE_TEST
 	depends on HAS_IOMEM
+	select REGMAP_MMIO
 	help
 	  This driver provides support to read the eFuses on Freescale
 	  Layerscape SoC's. For example, the vendor provides a per part
diff --git a/drivers/nvmem/layerscape-sfp.c b/drivers/nvmem/layerscape-sfp.c
index e591c1511e33..59083f048921 100644
--- a/drivers/nvmem/layerscape-sfp.c
+++ b/drivers/nvmem/layerscape-sfp.c
@@ -13,15 +13,17 @@
 #include <linux/nvmem-provider.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
+#include <linux/regmap.h>
 
 #define LAYERSCAPE_SFP_OTP_OFFSET	0x0200
 
 struct layerscape_sfp_priv {
-	void __iomem *base;
+	struct regmap *regmap;
 };
 
 struct layerscape_sfp_data {
 	int size;
+	enum regmap_endian endian;
 };
 
 static int layerscape_sfp_read(void *context, unsigned int offset, void *val,
@@ -29,15 +31,16 @@ static int layerscape_sfp_read(void *context, unsigned int offset, void *val,
 {
 	struct layerscape_sfp_priv *priv = context;
 
-	memcpy_fromio(val, priv->base + LAYERSCAPE_SFP_OTP_OFFSET + offset,
-		      bytes);
-
-	return 0;
+	return regmap_bulk_read(priv->regmap,
+				LAYERSCAPE_SFP_OTP_OFFSET + offset, val,
+				bytes / 4);
 }
 
 static struct nvmem_config layerscape_sfp_nvmem_config = {
 	.name = "fsl-sfp",
 	.reg_read = layerscape_sfp_read,
+	.word_size = 4,
+	.stride = 4,
 };
 
 static int layerscape_sfp_probe(struct platform_device *pdev)
@@ -45,16 +48,26 @@ static int layerscape_sfp_probe(struct platform_device *pdev)
 	const struct layerscape_sfp_data *data;
 	struct layerscape_sfp_priv *priv;
 	struct nvmem_device *nvmem;
+	struct regmap_config config = { 0 };
+	void __iomem *base;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
-	priv->base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(priv->base))
-		return PTR_ERR(priv->base);
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
 
 	data = device_get_match_data(&pdev->dev);
+	config.reg_bits = 32;
+	config.reg_stride = 4;
+	config.val_bits = 32;
+	config.val_format_endian = data->endian;
+	config.max_register = LAYERSCAPE_SFP_OTP_OFFSET + data->size - 4;
+	priv->regmap = devm_regmap_init_mmio(&pdev->dev, base, &config);
+	if (IS_ERR(priv->regmap))
+		return PTR_ERR(priv->regmap);
 
 	layerscape_sfp_nvmem_config.size = data->size;
 	layerscape_sfp_nvmem_config.dev = &pdev->dev;
@@ -67,6 +80,7 @@ static int layerscape_sfp_probe(struct platform_device *pdev)
 
 static const struct layerscape_sfp_data ls1028a_data = {
 	.size = 0x88,
+	.endian = REGMAP_ENDIAN_LITTLE,
 };
 
 static const struct of_device_id layerscape_sfp_dt_ids[] = {
-- 
2.21.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A5E4C4D11
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 18:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbiBYR7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 12:59:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbiBYR7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 12:59:19 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB311BBF5C
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 09:58:46 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id d14-20020a05600c34ce00b0037bf4d14dc7so2153314wmq.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 09:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4aleIewlwKJ1poVk10Jw8E3A1niTjHR1aIKsYOteRaE=;
        b=PfUwWn5+6UEKSBSJSnsKTXOfu7BCeNBeueveB86gaDf3xbEpm69XTzGBRnofGXBwre
         HfMbIx+KQkntMerVVbNP1xCc/nbhMA3wF8NJaWh/ijDRx+nfAThKRJSckHaPHHO9u1hf
         gRUVQ2i8dIZowl0zS/lW5/5A6Evr51RJAWJFywF5oqFV3xlmdkZgjjq8YL0PRmjlhq31
         dapWDAtrhqjNiTDB1DHVqtwuXYNcZHfF9h4TsNImsLDwaLgorOk+hSsC5iTWdxMRBYFR
         plpaja9XzoR1ydBgfDhzUTO3qWxdnhkvANPh9vdS2YiTHUjfnxRKHgMdeNNB357R1VhZ
         wQ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4aleIewlwKJ1poVk10Jw8E3A1niTjHR1aIKsYOteRaE=;
        b=u4ru1X8Kug8RtMCAeFJs2agzk9yJCjtfq6uY7bNZjG++s2dcrxKTx3uxwdUNif/8By
         rVVzbp7quQ4GIFBfDGUDYj0XSu9z73v+x/1fionjQwObEXNMTM/U1vea+Corj9I0oBhX
         Pwz9xXRSzYPNaI4fA9hOMzXH7X2t3tWWT5ZogqGq0gTJ4s5sQtCDBtsLADkXS9IedA2k
         0C5EF8CQZRJMR6VzqCy7fHJcrvetRrrF+Ya5pgvWUE53LH2tQUKwxZCYW7U5DFcnw8Ad
         Zzh0vuaHxHRYuJrWcoWuUPcnraV2ZXT/5L8ACmcSVUF8wNF3KkM0DGdr5wp9r/cHtwbi
         9OQA==
X-Gm-Message-State: AOAM532nvFjWQsWG78gqnAQNmzd1MZR4cEg9rMkUEGisacA17bUd8/L0
        t1ItsBcg3cglYk0rWux3S6M0Qw==
X-Google-Smtp-Source: ABdhPJwED8ZFQcWOXXVX/CYMkODNcBl04QDeIURlCgk/IzGxCDkxnhvhyZQhp//vtJjoPUq6aGUOxg==
X-Received: by 2002:a05:600c:4182:b0:381:42:ac91 with SMTP id p2-20020a05600c418200b003810042ac91mr3710003wmh.116.1645811924887;
        Fri, 25 Feb 2022 09:58:44 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id t8-20020a05600c2f8800b00381428ad88dsm74172wmn.15.2022.02.25.09.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 09:58:44 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/4] nvmem: brcm_nvram: parse NVRAM content into NVMEM cells
Date:   Fri, 25 Feb 2022 17:58:20 +0000
Message-Id: <20220225175822.8293-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220225175822.8293-1-srinivas.kandagatla@linaro.org>
References: <20220225175822.8293-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

NVRAM consist of header and NUL separated key-value pairs. Parse it and
create NVMEM cell for every key-value entry.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/brcm_nvram.c | 90 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/drivers/nvmem/brcm_nvram.c b/drivers/nvmem/brcm_nvram.c
index bd2ecaaf4585..439f00b9eef6 100644
--- a/drivers/nvmem/brcm_nvram.c
+++ b/drivers/nvmem/brcm_nvram.c
@@ -6,12 +6,26 @@
 #include <linux/io.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/nvmem-consumer.h>
 #include <linux/nvmem-provider.h>
 #include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#define NVRAM_MAGIC			"FLSH"
 
 struct brcm_nvram {
 	struct device *dev;
 	void __iomem *base;
+	struct nvmem_cell_info *cells;
+	int ncells;
+};
+
+struct brcm_nvram_header {
+	char magic[4];
+	__le32 len;
+	__le32 crc_ver_init;	/* 0:7 crc, 8:15 ver, 16:31 sdram_init */
+	__le32 config_refresh;	/* 0:15 sdram_config, 16:31 sdram_refresh */
+	__le32 config_ncdl;	/* ncdl values for memc */
 };
 
 static int brcm_nvram_read(void *context, unsigned int offset, void *val,
@@ -26,6 +40,75 @@ static int brcm_nvram_read(void *context, unsigned int offset, void *val,
 	return 0;
 }
 
+static int brcm_nvram_add_cells(struct brcm_nvram *priv, uint8_t *data,
+				size_t len)
+{
+	struct device *dev = priv->dev;
+	char *var, *value, *eq;
+	int idx;
+
+	priv->ncells = 0;
+	for (var = data + sizeof(struct brcm_nvram_header);
+	     var < (char *)data + len && *var;
+	     var += strlen(var) + 1) {
+		priv->ncells++;
+	}
+
+	priv->cells = devm_kcalloc(dev, priv->ncells, sizeof(*priv->cells), GFP_KERNEL);
+	if (!priv->cells)
+		return -ENOMEM;
+
+	for (var = data + sizeof(struct brcm_nvram_header), idx = 0;
+	     var < (char *)data + len && *var;
+	     var = value + strlen(value) + 1, idx++) {
+		eq = strchr(var, '=');
+		if (!eq)
+			break;
+		*eq = '\0';
+		value = eq + 1;
+
+		priv->cells[idx].name = devm_kstrdup(dev, var, GFP_KERNEL);
+		if (!priv->cells[idx].name)
+			return -ENOMEM;
+		priv->cells[idx].offset = value - (char *)data;
+		priv->cells[idx].bytes = strlen(value);
+	}
+
+	return 0;
+}
+
+static int brcm_nvram_parse(struct brcm_nvram *priv)
+{
+	struct device *dev = priv->dev;
+	struct brcm_nvram_header header;
+	uint8_t *data;
+	size_t len;
+	int err;
+
+	memcpy_fromio(&header, priv->base, sizeof(header));
+
+	if (memcmp(header.magic, NVRAM_MAGIC, 4)) {
+		dev_err(dev, "Invalid NVRAM magic\n");
+		return -EINVAL;
+	}
+
+	len = le32_to_cpu(header.len);
+
+	data = kcalloc(1, len, GFP_KERNEL);
+	memcpy_fromio(data, priv->base, len);
+	data[len - 1] = '\0';
+
+	err = brcm_nvram_add_cells(priv, data, len);
+	if (err) {
+		dev_err(dev, "Failed to add cells: %d\n", err);
+		return err;
+	}
+
+	kfree(data);
+
+	return 0;
+}
+
 static int brcm_nvram_probe(struct platform_device *pdev)
 {
 	struct nvmem_config config = {
@@ -35,6 +118,7 @@ static int brcm_nvram_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct resource *res;
 	struct brcm_nvram *priv;
+	int err;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -46,7 +130,13 @@ static int brcm_nvram_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
 
+	err = brcm_nvram_parse(priv);
+	if (err)
+		return err;
+
 	config.dev = dev;
+	config.cells = priv->cells;
+	config.ncells = priv->ncells;
 	config.priv = priv;
 	config.size = resource_size(res);
 
-- 
2.21.0


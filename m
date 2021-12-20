Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E35F747B316
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 19:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240539AbhLTSpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 13:45:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238498AbhLTSov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 13:44:51 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 984F3C061574;
        Mon, 20 Dec 2021 10:44:50 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id i31so8510672lfv.10;
        Mon, 20 Dec 2021 10:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xwyysmftigZMwkoovGWOrS2OfXQlj0gb0VWFGJp3JU4=;
        b=hZ8zj/bBjjSey4EYsj3XFfYiBIUSf0CqjE5ISBdpyXkZbuhlSnYLUvWV/mFredrusP
         Qw2tD8fVwgdjayiDgm96oFjW44SWAQktSiykvysyXac6CD/Y7CCmleIMklnUez2LbnlT
         jhr3BMWfZRE8tuVAKYEu/PHc5CnXEzbGXlH3k2M3+W28JRQfrPO8GyO7CE9VPvgh+d5Y
         I0DCy2q+1ZhV5JMpgxGMdHEWY5f7bci8HR3DH6vIs2JoDY7LyWwGjr/oLQMpOOS45IG3
         Cy3LWV5aefRRsUJRnNXFgM3AL7f8AkHCte50ho8+m0i1G/E8uWbWcgqhxjOgFOKHL5p7
         LdiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xwyysmftigZMwkoovGWOrS2OfXQlj0gb0VWFGJp3JU4=;
        b=vCuzws1eadkW3QOfbK8tqmA1r22s62FUBBgYx/yCh3hfeZ+KW+Rf1huVC/hI4k3xvR
         syhXISwMD9KrLMNiQRcj9CHckLg5hM0i6nYWfguRhO1dvqTPf3UMBEaCfPbgexcUyNrZ
         /f+2pWtgv1mlrypRsmqZ3csR+juEqiI2PHV2oetUu11VI2GggfDqvmkUYUi1fUmNeiq8
         c2hJTYWJC+Ara4Co7nua/AAErhm38NYCZ3PQ3uUMWHDtMBSaberxSzK8MUEbPg3Ywi5/
         VMaQir+MnFHn4mRu7T2Ku6JtlKgf0LRRj20xagmrWFkuQFgEr6W8gX4pvPxB2iNLPd1V
         rOOw==
X-Gm-Message-State: AOAM531RMe/TzEBRidVUufs4nfyXyBj81MCn5Ry5kxcL5GlrZw0EX/Jp
        b9uEgOT2BBQ04nhAntiEAYo=
X-Google-Smtp-Source: ABdhPJwojmRFO1iheIXySReLnzodnXqWsLojzZvsltPx3OXB5x/gudm31I2UoMy6mAZDOczZSfFvbg==
X-Received: by 2002:a05:6512:1054:: with SMTP id c20mr2434248lfb.247.1640025888947;
        Mon, 20 Dec 2021 10:44:48 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id k32sm222870lfv.196.2021.12.20.10.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 10:44:48 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V2] nvmem: brcm_nvram: parse NVRAM content into NVMEM cells
Date:   Mon, 20 Dec 2021 19:44:44 +0100
Message-Id: <20211220184444.6693-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211220184226.6485-1-zajec5@gmail.com>
References: <20211220184226.6485-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

NVRAM consist of header and NUL separated key-value pairs. Parse it and
create NVMEM cell for every key-value entry.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
V2: Drop dev_info() calls I used for debugging
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
2.31.1


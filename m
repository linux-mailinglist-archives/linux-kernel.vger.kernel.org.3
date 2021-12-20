Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1844047B30C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 19:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240515AbhLTSmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 13:42:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240502AbhLTSml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 13:42:41 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBA7C061574;
        Mon, 20 Dec 2021 10:42:40 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id cf39so23739615lfb.8;
        Mon, 20 Dec 2021 10:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/B6DvIqPMwlSVR6jVcqcmHQyA/k1m4TC+f89S6pXSVg=;
        b=M205RQy7JwG8A5YBZYhvvTYxxsMlsX7puP2isVqnUuSrXgQSLkVJe55lz566iIcYxd
         kk1+Y+QyjmM1ZSUB75X+GOIMjJGYn6GuNpn8dEH7EPAhix00XT8QuxKdAEyARshiIp9l
         8C1hT3KMI9k/ofqdoEpVAiUoeIHOJs8YSOin39gaw88TLjghmJTHTiOUhsQ67+jDp/zz
         t641xe+BaXAz/9Vf9W1LjQXpO9mcOoAJ3eodh7sPM/awqNO5fKMuKeDNu02DQaeExqQG
         JOjCqGn2QbeiY2SnPMGusgbINGXbJouae9/CGH+bRK57Rm14cFKPl1EqPJEjUQLNWy2c
         HeBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/B6DvIqPMwlSVR6jVcqcmHQyA/k1m4TC+f89S6pXSVg=;
        b=R0Rc6r+hy4ogBAvE+2ooef8MgNoMUyW0Z3sckYuqpJ4JTQtPNOkeqm/O177Iyv+hNn
         IBOjF6/Tn2jSI2NVdhRqdLquzYzjvrbOjWrrT2TtQPkw5C/js9Ein52mtSxTcn0Xcxwb
         2VDUwPQnIxybgAwwOEOuQ3TJktKufOC/NoFpt30rKCRbOXjOmS1xt1pAAnY6U2ACNqmb
         OM0RDsqQ7SFqwAywAtCvLnpKFdL4/y9YbF2F0I8wgUYVGHCM7hHAP++j6IVxe+Ts2Td0
         uAk9r+iO/st7VOnDD7NrUTZuIKFcZEtSAbtAuIbhBY6SmU5Isi3oV43L9dCX+/AsAShc
         oQuA==
X-Gm-Message-State: AOAM533eMFqbUHe8AGO3ZhMniBACPcqzu/yLwiOXxU4N7FH0OGOZSUl3
        CAHY30y/eGGBjbzkZMU3swk=
X-Google-Smtp-Source: ABdhPJxrO0tXLkd6P533o5FnLjfiM6+dBkruUiqDKwbuhxKPifPAWiWVn3hrHme2uLXhyhPYUFbXgA==
X-Received: by 2002:a05:6512:3995:: with SMTP id j21mr990465lfu.360.1640025758797;
        Mon, 20 Dec 2021 10:42:38 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id s10sm239682lfr.45.2021.12.20.10.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 10:42:38 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH] nvmem: brcm_nvram: parse NVRAM content into NVMEM cells
Date:   Mon, 20 Dec 2021 19:42:25 +0100
Message-Id: <20211220184226.6485-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.31.1
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
 drivers/nvmem/brcm_nvram.c | 93 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/drivers/nvmem/brcm_nvram.c b/drivers/nvmem/brcm_nvram.c
index bd2ecaaf4585..01ad96c52809 100644
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
@@ -26,6 +40,78 @@ static int brcm_nvram_read(void *context, unsigned int offset, void *val,
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
+	dev_info(dev, "ncells:%d", priv->ncells);
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
+		dev_info(dev, "%s: %s", var, value);
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
@@ -35,6 +121,7 @@ static int brcm_nvram_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct resource *res;
 	struct brcm_nvram *priv;
+	int err;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -46,7 +133,13 @@ static int brcm_nvram_probe(struct platform_device *pdev)
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


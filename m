Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26D24C1EA4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 23:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244342AbiBWWfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 17:35:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243645AbiBWWfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 17:35:38 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2C21B7B8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 14:35:09 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id l13so228710wrt.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 14:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lnzACGL84E5PU1+kaxCWrF1bw5ZldjRsYu9n9bKWfUY=;
        b=Ehymhi8IrmCzG1BSXubioskCKUTlWgCkcWLdVreGImIogJyFyXkoPzH+vTvfypVyZG
         Nlc4gQ9/d4C0GwTuCK7L4aT7/KxZtOy9VWF3R+4nW8v9cg5ip5wht0U0KJpaV312LrIZ
         j5nWIeiqkWVSmF2LJGJVQ000eG/pVzwcAEZX0XVh/Zpvgt2488R+TFKZP+jM3KKotDH7
         GOW6ESjG38AYWrH/FH0n9pKh9rJqcurRdHw/dht+0l+Y276vGwULyoMMfXmmsg4FkVbD
         sfxhl9OK6Imy/yy2D6NTdp1Exe8Sg4w4DuehyaXKNCPC6m9+SV6nN9sFCTqc0yFOPUD2
         5L/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lnzACGL84E5PU1+kaxCWrF1bw5ZldjRsYu9n9bKWfUY=;
        b=ZAI/k2m18Lcuc3UgMGk/pfJcJad/Ato+aQqW2eZD8IYPF1PTezQi7lHpq+Iatyo9er
         UDHi17oM+os/fTUrmJXS6h4nZy7Y/0QLBMJkXBf6et307ENYTB82HT5n8tnK4NSeR6a/
         PdW3lSeVbytPH+6xLhbCMprqxtpIXWERcHaSeTpkALMyp+4kD68Rzo2PoKwz6XEcRFRF
         YRxmUqfgsEVhy08CXjFW2pXv7CdbrEKTkOUK6fl2vxLvhdleg7nJyKUsAo7bVIHCB7Zt
         zb0lVpZAq/gRVZCQ8xWb90k2YYVE/mwC2NFxHGBD+PeSgOWWrwS1kgnPpig5Ft93YhmG
         L7ew==
X-Gm-Message-State: AOAM530t1y2KS88UAmljXPmfx9hh99muWTmtrNX6WoV7jLhasH2KDsEa
        yXrnMCpSm/Gsr2VhV900qwZzWIKlRLwpJQ==
X-Google-Smtp-Source: ABdhPJy0v+RGKBsFc0njCkuWEdxMxFY6hbVU1qQ/W7ln/jyShbqbct9HIsEuPB4YqNjPhSYju2Hl2A==
X-Received: by 2002:a5d:6546:0:b0:1e6:5b59:4eab with SMTP id z6-20020a5d6546000000b001e65b594eabmr1236235wrv.143.1645655708431;
        Wed, 23 Feb 2022 14:35:08 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id c9sm729435wrn.51.2022.02.23.14.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 14:35:07 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Vincent Shih <vincent.sunplus@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/3] nvmem: Add driver for OCOTP in Sunplus SP7021
Date:   Wed, 23 Feb 2022 22:35:01 +0000
Message-Id: <20220223223502.29454-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220223223502.29454-1-srinivas.kandagatla@linaro.org>
References: <20220223223502.29454-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
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

From: Vincent Shih <vincent.sunplus@gmail.com>

Add driver for OCOTP in Sunplus SP7021

Signed-off-by: Vincent Shih <vincent.sunplus@gmail.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 MAINTAINERS                   |   5 +
 drivers/nvmem/Kconfig         |  12 ++
 drivers/nvmem/Makefile        |   2 +
 drivers/nvmem/sunplus-ocotp.c | 228 ++++++++++++++++++++++++++++++++++
 4 files changed, 247 insertions(+)
 create mode 100644 drivers/nvmem/sunplus-ocotp.c

diff --git a/MAINTAINERS b/MAINTAINERS
index ea3e6c914384..534772dfc3ef 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18491,6 +18491,11 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/rtc/sunplus,sp7021-rtc.yaml
 F:	drivers/rtc/rtc-sunplus.c
 
+SUNPLUS OCOTP DRIVER
+M:	Vincent Shih <vincent.sunplus@gmail.com>
+S:	Maintained
+F:	drivers/nvmem/sunplus-ocotp.c
+
 SUPERH
 M:	Yoshinori Sato <ysato@users.sourceforge.jp>
 M:	Rich Felker <dalias@libc.org>
diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 4063ea15f7d2..555aa77a574d 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -312,4 +312,16 @@ config NVMEM_LAYERSCAPE_SFP
 	  This driver can also be built as a module. If so, the module
 	  will be called layerscape-sfp.
 
+config NVMEM_SUNPLUS_OCOTP
+	tristate "Sunplus SoC OTP support"
+	depends on SOC_SP7021 || COMPILE_TEST
+	depends on HAS_IOMEM
+	help
+	  This is a driver for the On-chip OTP controller (OCOTP) available
+	  on Sunplus SoCs. It provides access to 128 bytes of one-time
+	  programmable eFuse.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called nvmem-sunplus-ocotp.
+
 endif
diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index d4e1052d2b95..891958e29d25 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -63,3 +63,5 @@ obj-$(CONFIG_NVMEM_BRCM_NVRAM)	+= nvmem_brcm_nvram.o
 nvmem_brcm_nvram-y		:= brcm_nvram.o
 obj-$(CONFIG_NVMEM_LAYERSCAPE_SFP)	+= nvmem-layerscape-sfp.o
 nvmem-layerscape-sfp-y		:= layerscape-sfp.o
+obj-$(CONFIG_NVMEM_SUNPLUS_OCOTP)	+= nvmem_sunplus_ocotp.o
+nvmem_sunplus_ocotp-y		:= sunplus-ocotp.o
diff --git a/drivers/nvmem/sunplus-ocotp.c b/drivers/nvmem/sunplus-ocotp.c
new file mode 100644
index 000000000000..2dc59c22eb55
--- /dev/null
+++ b/drivers/nvmem/sunplus-ocotp.c
@@ -0,0 +1,228 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * The OCOTP driver for Sunplus	SP7021
+ *
+ * Copyright (C) 2019 Sunplus Technology Inc., All rights reserved.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/nvmem-provider.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+
+/*
+ * OTP memory
+ * Each bank contains 4 words (32 bits).
+ * Bank 0 starts at offset 0 from the base.
+ */
+
+#define OTP_WORDS_PER_BANK		4
+#define OTP_WORD_SIZE			sizeof(u32)
+#define OTP_BIT_ADDR_OF_BANK		(8 * OTP_WORD_SIZE * OTP_WORDS_PER_BANK)
+#define QAC628_OTP_NUM_BANKS		8
+#define QAC628_OTP_SIZE			(QAC628_OTP_NUM_BANKS * OTP_WORDS_PER_BANK * OTP_WORD_SIZE)
+#define OTP_READ_TIMEOUT_US		200000
+
+/* HB_GPIO */
+#define ADDRESS_8_DATA			0x20
+
+/* OTP_RX */
+#define OTP_CONTROL_2			0x48
+#define OTP_RD_PERIOD			GENMASK(15, 8)
+#define OTP_RD_PERIOD_MASK		~GENMASK(15, 8)
+#define CPU_CLOCK			FIELD_PREP(OTP_RD_PERIOD, 30)
+#define SEL_BAK_KEY2			BIT(5)
+#define SEL_BAK_KEY2_MASK		~BIT(5)
+#define SW_TRIM_EN			BIT(4)
+#define SW_TRIM_EN_MASK			~BIT(4)
+#define SEL_BAK_KEY			BIT(3)
+#define SEL_BAK_KEY_MASK		~BIT(3)
+#define OTP_READ			BIT(2)
+#define OTP_LOAD_SECURE_DATA		BIT(1)
+#define OTP_LOAD_SECURE_DATA_MASK	~BIT(1)
+#define OTP_DO_CRC			BIT(0)
+#define OTP_DO_CRC_MASK			~BIT(0)
+#define OTP_STATUS			0x4c
+#define OTP_READ_DONE			BIT(4)
+#define OTP_READ_DONE_MASK		~BIT(4)
+#define OTP_LOAD_SECURE_DONE_MASK	~BIT(2)
+#define OTP_READ_ADDRESS		0x50
+
+enum base_type {
+	HB_GPIO,
+	OTPRX,
+	BASEMAX,
+};
+
+struct sp_ocotp_priv {
+	struct device *dev;
+	void __iomem *base[BASEMAX];
+	struct clk *clk;
+};
+
+struct sp_ocotp_data {
+	int size;
+};
+
+const struct sp_ocotp_data  sp_otp_v0 = {
+	.size = QAC628_OTP_SIZE,
+};
+
+static int sp_otp_read_real(struct sp_ocotp_priv *otp, int addr, char *value)
+{
+	unsigned int addr_data;
+	unsigned int byte_shift;
+	unsigned int status;
+	int ret;
+
+	addr_data = addr % (OTP_WORD_SIZE * OTP_WORDS_PER_BANK);
+	addr_data = addr_data / OTP_WORD_SIZE;
+
+	byte_shift = addr % (OTP_WORD_SIZE * OTP_WORDS_PER_BANK);
+	byte_shift = byte_shift % OTP_WORD_SIZE;
+
+	addr = addr / (OTP_WORD_SIZE * OTP_WORDS_PER_BANK);
+	addr = addr * OTP_BIT_ADDR_OF_BANK;
+
+	writel(readl(otp->base[OTPRX] + OTP_STATUS) & OTP_READ_DONE_MASK &
+	       OTP_LOAD_SECURE_DONE_MASK, otp->base[OTPRX] + OTP_STATUS);
+	writel(addr, otp->base[OTPRX] + OTP_READ_ADDRESS);
+	writel(readl(otp->base[OTPRX] + OTP_CONTROL_2) | OTP_READ,
+	       otp->base[OTPRX] + OTP_CONTROL_2);
+	writel(readl(otp->base[OTPRX] + OTP_CONTROL_2) & SEL_BAK_KEY2_MASK & SW_TRIM_EN_MASK
+	       & SEL_BAK_KEY_MASK & OTP_LOAD_SECURE_DATA_MASK & OTP_DO_CRC_MASK,
+	       otp->base[OTPRX] + OTP_CONTROL_2);
+	writel((readl(otp->base[OTPRX] + OTP_CONTROL_2) & OTP_RD_PERIOD_MASK) | CPU_CLOCK,
+	       otp->base[OTPRX] + OTP_CONTROL_2);
+
+	ret = readl_poll_timeout(otp->base[OTPRX] + OTP_STATUS, status,
+				 status & OTP_READ_DONE, 10, OTP_READ_TIMEOUT_US);
+
+	if (ret < 0)
+		return ret;
+
+	*value = (readl(otp->base[HB_GPIO] + ADDRESS_8_DATA + addr_data * OTP_WORD_SIZE)
+		  >> (8 * byte_shift)) & 0xff;
+
+	return ret;
+}
+
+static int sp_ocotp_read(void *priv, unsigned int offset, void *value, size_t bytes)
+{
+	struct sp_ocotp_priv *otp = priv;
+	unsigned int addr;
+	char *buf = value;
+	char val[4];
+	int ret;
+
+	ret = clk_enable(otp->clk);
+	if (ret)
+		return ret;
+
+	*buf = 0;
+	for (addr = offset; addr < (offset + bytes); addr++) {
+		ret = sp_otp_read_real(otp, addr, val);
+		if (ret < 0) {
+			dev_err(otp->dev, "OTP read fail:%d at %d", ret, addr);
+			goto disable_clk;
+		}
+
+		*buf++ = *val;
+	}
+
+disable_clk:
+	clk_disable(otp->clk);
+
+	return ret;
+}
+
+static struct nvmem_config sp_ocotp_nvmem_config = {
+	.name = "sp-ocotp",
+	.read_only = true,
+	.word_size = 1,
+	.size = QAC628_OTP_SIZE,
+	.stride = 1,
+	.reg_read = sp_ocotp_read,
+	.owner = THIS_MODULE,
+};
+
+static int sp_ocotp_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct nvmem_device *nvmem;
+	struct sp_ocotp_priv *otp;
+	struct resource *res;
+	int ret;
+
+	otp = devm_kzalloc(dev, sizeof(*otp), GFP_KERNEL);
+	if (!otp)
+		return -ENOMEM;
+
+	otp->dev = dev;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "hb_gpio");
+	otp->base[HB_GPIO] = devm_ioremap_resource(dev, res);
+	if (IS_ERR(otp->base[HB_GPIO]))
+		return PTR_ERR(otp->base[HB_GPIO]);
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "otprx");
+	otp->base[OTPRX] = devm_ioremap_resource(dev, res);
+	if (IS_ERR(otp->base[OTPRX]))
+		return PTR_ERR(otp->base[OTPRX]);
+
+	otp->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(otp->clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(otp->clk),
+						"devm_clk_get fail\n");
+
+	ret = clk_prepare(otp->clk);
+	if (ret < 0) {
+		dev_err(dev, "failed to prepare clk: %d\n", ret);
+		return ret;
+	}
+
+	sp_ocotp_nvmem_config.priv = otp;
+	sp_ocotp_nvmem_config.dev = dev;
+
+	nvmem = devm_nvmem_register(dev, &sp_ocotp_nvmem_config);
+	if (IS_ERR(nvmem))
+		return dev_err_probe(&pdev->dev, PTR_ERR(nvmem),
+						"register nvmem device fail\n");
+
+	platform_set_drvdata(pdev, nvmem);
+
+	dev_dbg(dev, "banks:%d x wpb:%d x wsize:%d = %d",
+		(int)QAC628_OTP_NUM_BANKS, (int)OTP_WORDS_PER_BANK,
+		(int)OTP_WORD_SIZE, (int)QAC628_OTP_SIZE);
+
+	dev_info(dev, "by Sunplus (C) 2020");
+
+	return 0;
+}
+
+static const struct of_device_id sp_ocotp_dt_ids[] = {
+	{ .compatible = "sunplus,sp7021-ocotp", .data = &sp_otp_v0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, sp_ocotp_dt_ids);
+
+static struct platform_driver sp_otp_driver = {
+	.probe     = sp_ocotp_probe,
+	.driver    = {
+		.name           = "sunplus,sp7021-ocotp",
+		.of_match_table = sp_ocotp_dt_ids,
+	}
+};
+module_platform_driver(sp_otp_driver);
+
+MODULE_AUTHOR("Vincent Shih <vincent.sunplus@gmail.com>");
+MODULE_DESCRIPTION("Sunplus On-Chip OTP driver");
+MODULE_LICENSE("GPL");
+
-- 
2.21.0


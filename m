Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF4E446B672
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 09:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233346AbhLGI50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 03:57:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbhLGI5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 03:57:25 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B98FC061746;
        Tue,  7 Dec 2021 00:53:55 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id t83so13991566qke.8;
        Tue, 07 Dec 2021 00:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5Rm0Cigtnqbl8OEBwyyZ1YJwF3WPOP5vy/ftEyKPYVo=;
        b=MWgCt4SdAMH24XHDB5hVXIq9obRwl3hA+/T1QYlbRFNlMit6o/6AFoIVZZOsTrNUKq
         4n6S6UujvOgmIaKiYmOq8wCVaK1nPjM65An3GU3UWQvRCj5aJpbHG7EmG91zZeztP4og
         cJFbsS/0PpBKlxTSS9MJCXJ0Bfv1gnxJ5A7r/Za2z4nS8bLm86kblG/M/xMYQDaJIXNS
         RD19Q5jU7lJtlFxH0uUYbEMZWYiWYqZ1xEQuVtSvemNeWkc+5utPRap+lLM5muSkRyBW
         OMJqXo8IZDCNQ77pUPH+GJPUr1GbBJKuFcWw1GzHZtLO+5RYxfDb0g7CKPmxE5uyWwwm
         Q0xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5Rm0Cigtnqbl8OEBwyyZ1YJwF3WPOP5vy/ftEyKPYVo=;
        b=NL7IWp7DarvPJwT9O5r+gBYyWOO/aLNAPQhvkOrEdHlqLwJPb2AoJpVuhFgbyi7ByU
         07ZVKYDjA5msv5FxjhbCjS61eLc+/T64IMiUIIcb8tmB5AjCTy3IEpxYyCD99bIFRWFD
         r7cSHeBNWaUUd/DdBCY1QqiQl1AvvB+J0EzvdB4uv/DtPA1/T2YIijZYg04oaHTbYAhz
         I5sG7TDl27H0HgZjsP/gzG+3V6HZQyIweCZNO10KCJ3h8wUK2crNGBi9fPS3jdv8ihRI
         Mmp2rk95otIIbh1dqq5/7kQ4DAC37I0zoa3POpxyKbz0XtBf5u8H6edcg375DoADj9x5
         idUg==
X-Gm-Message-State: AOAM530bMrCBSgSTi7ARYSUxqr70kpcnq23Bxq5T9qUYdPgxkHARK//5
        aQuieod29r5jsNVLcmfUi/Q6CFWKvKc=
X-Google-Smtp-Source: ABdhPJxm6/8I/y7pKoNYfOZNE3oPWqn//NyjDKPZu12iivIWPnFtgS3yLxqVtjTx51sr7g2o3XDXPQ==
X-Received: by 2002:a37:ec2:: with SMTP id 185mr38374050qko.690.1638867234217;
        Tue, 07 Dec 2021 00:53:54 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id bp38sm7797797qkb.66.2021.12.07.00.53.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Dec 2021 00:53:53 -0800 (PST)
From:   Vincent Shih <vincent.sunplus@gmail.com>
To:     srinivas.kandagatla@linaro.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        wells.lu@sunplus.com
Cc:     Vincent Shih <vincent.sunplus@gmail.com>
Subject: [PATCH v2 1/2] nvmem: Add driver for OCOTP in Sunplus SP7021
Date:   Tue,  7 Dec 2021 16:53:52 +0800
Message-Id: <1638867233-8383-2-git-send-email-vincent.sunplus@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1638867233-8383-1-git-send-email-vincent.sunplus@gmail.com>
References: <1638867233-8383-1-git-send-email-vincent.sunplus@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add driver for OCOTP in Sunplus SP7021

Signed-off-by: Vincent Shih <vincent.sunplus@gmail.com>
---
Changes in v2:
 - Merge sunplus-ocotp.h and sunplus-ocotp0.c to sunplus-ocotp.c
 - Clean up codes.

 MAINTAINERS                   |   5 +
 drivers/nvmem/Kconfig         |  12 ++
 drivers/nvmem/Makefile        |   2 +
 drivers/nvmem/sunplus-ocotp.c | 268 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 287 insertions(+)
 create mode 100644 drivers/nvmem/sunplus-ocotp.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 80eebc1..0e6593a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17947,6 +17947,11 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/dlink/sundance.c
 
+SUNPLUS OCOTP DRIVER
+M:	Vincent Shih <vincent.sunplus@gmail.com>
+S:	Maintained
+F:	drivers/nvmem/sunplus-ocotp.c
+
 SUPERH
 M:	Yoshinori Sato <ysato@users.sourceforge.jp>
 M:	Rich Felker <dalias@libc.org>
diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index da41461..fb053d6 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -300,4 +300,16 @@ config NVMEM_BRCM_NVRAM
 	  This driver provides support for Broadcom's NVRAM that can be accessed
 	  using I/O mapping.
 
+config NVMEM_SUNPLUS_OCOTP
+	tristate "Sunplus SoC OTP support"
+	depends on SOC_SP7021
+	depends on HAS_IOMEM
+	help
+	  This is a driver for the On-chip OTP controller (OCOTP) available
+	  on Sunplus SoCs. It provids access to 128 bytes of one-time
+	  programmable eFuse.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called nvmem-sunplus-ocotp.
+
 endif
diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index dcbbde3..0f14cd9 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -61,3 +61,5 @@ obj-$(CONFIG_NVMEM_RMEM) 	+= nvmem-rmem.o
 nvmem-rmem-y			:= rmem.o
 obj-$(CONFIG_NVMEM_BRCM_NVRAM)	+= nvmem_brcm_nvram.o
 nvmem_brcm_nvram-y		:= brcm_nvram.o
+obj-$(CONFIG_NVMEM_SUNPLUS_OCOTP)	+= nvmem_sunplus_ocotp.o
+nvmem_sunplus_ocotp-y		:= sunplus-ocotp.o
diff --git a/drivers/nvmem/sunplus-ocotp.c b/drivers/nvmem/sunplus-ocotp.c
new file mode 100644
index 0000000..2997b29
--- /dev/null
+++ b/drivers/nvmem/sunplus-ocotp.c
@@ -0,0 +1,268 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * The OCOTP driver for Sunplus	SP7021
+ *
+ * Copyright (C) 2019 Sunplus Technology Inc., All rights reseerved.
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/io.h>
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
+#define QAC628_OTP_NUM_BANKS            8
+#define QAC628_OTP_SIZE                 (QAC628_OTP_NUM_BANKS * OTP_WORDS_PER_BANK * OTP_WORD_SIZE)
+#define OTP_READ_TIMEOUT                20000
+
+/* HB_GPIO */
+#define ADDRESS_8_DATA			0x20
+
+/* OTP_RX */
+#define OTP_CONTROL_2			0x48
+#define OTP_RD_PERIOD			GENMASK(15, 8)
+#define OTP_RD_PERIOD_MASK		~GENMASK(15, 8)
+#define ONE_CPU_CLOCK			0x1
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
+struct sp_otp_data_t {
+	struct device *dev;
+	void __iomem *base[BASEMAX];
+	struct clk *clk;
+	struct nvmem_config *config;
+};
+
+struct sp_otp_vX_t {
+	int size;
+};
+
+const struct sp_otp_vX_t  sp_otp_v0 = {
+	.size = QAC628_OTP_SIZE,
+};
+
+static int sp_otp_wait(void __iomem *reg_base)
+{
+	int timeout = OTP_READ_TIMEOUT;
+	unsigned int status;
+
+	do {
+		usleep_range(10);
+		if (timeout-- == 0)
+			return -ETIMEDOUT;
+
+		status = readl(reg_base + OTP_STATUS);
+	} while ((status & OTP_READ_DONE) != OTP_READ_DONE);
+
+	return 0;
+}
+
+static int sp_otp_read_real(struct sp_otp_data_t *otp, int addr, char *value)
+{
+	unsigned int addr_data;
+	unsigned int byte_shift;
+	int ret = 0;
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
+		     OTP_LOAD_SECURE_DONE_MASK, otp->base[OTPRX] + OTP_STATUS);
+	writel(addr, otp->base[OTPRX] + OTP_READ_ADDRESS);
+	writel(readl(otp->base[OTPRX] + OTP_CONTROL_2) | OTP_READ,
+	       otp->base[OTPRX] + OTP_CONTROL_2);
+	writel(readl(otp->base[OTPRX] + OTP_CONTROL_2) & SEL_BAK_KEY2_MASK & SW_TRIM_EN_MASK
+	       & SEL_BAK_KEY_MASK & OTP_LOAD_SECURE_DATA_MASK & OTP_DO_CRC_MASK,
+	       otp->base[OTPRX] + OTP_CONTROL_2);
+	writel((readl(otp->base[OTPRX] + OTP_CONTROL_2) & OTP_RD_PERIOD_MASK) |
+	       ((ONE_CPU_CLOCK * 0x1e) << 8), otp->base[OTPRX] + OTP_CONTROL_2);
+
+	ret = sp_otp_wait(otp->base[OTPRX]);
+	if (ret < 0)
+		return ret;
+
+	*value = (readl(otp->base[HB_GPIO] + ADDRESS_8_DATA + addr_data * OTP_WORD_SIZE)
+			>> (8 * byte_shift)) & 0xFF;
+
+	return ret;
+}
+
+static int sp_ocotp_read(void *priv, unsigned int offset, void *value, size_t bytes)
+{
+	struct sp_otp_data_t *otp = priv;
+	unsigned int addr;
+	char *buf = value;
+	char val[4];
+	int ret;
+
+	dev_dbg(otp->dev, "OTP read %u bytes at %u", bytes, offset);
+
+	if (offset >= QAC628_OTP_SIZE || bytes == 0 || ((offset + bytes) > QAC628_OTP_SIZE))
+		return -EINVAL;
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
+	dev_dbg(otp->dev, "OTP read complete");
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
+	const struct of_device_id *match;
+	const struct sp_otp_vX_t *sp_otp_vX;
+	struct device *dev = &pdev->dev;
+	struct nvmem_device *nvmem;
+	struct sp_otp_data_t *otp;
+	struct resource *res;
+	int ret;
+
+	match = of_match_device(dev->driver->of_match_table, dev);
+	if (match && match->data)
+		sp_otp_vX = match->data;
+	else
+		dev_err(dev, "OTP vX does not match");
+
+	otp = devm_kzalloc(dev, sizeof(*otp), GFP_KERNEL);
+	if (!otp)
+		return -ENOMEM;
+
+	otp->dev = dev;
+	otp->config = &sp_ocotp_nvmem_config;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "hb_gpio");
+	otp->base[HB_GPIO] = devm_ioremap_resource(dev, res);
+	if (IS_ERR(otp->base[HB_GPIO]))
+		return dev_err_probe(&pdev->dev, PTR_ERR(otp->base[HB_GPIO]),
+						"hb_gpio devm_ioremap_resource fail\n");
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "otprx");
+	otp->base[OTPRX] = devm_ioremap_resource(dev, res);
+	if (IS_ERR(otp->base[OTPRX]))
+		return dev_err_probe(&pdev->dev, PTR_ERR(otp->base[OTPRX]),
+						"otprx devm_ioremap_resource fail\n");
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
+		QAC628_OTP_NUM_BANKS, OTP_WORDS_PER_BANK,
+		OTP_WORD_SIZE, QAC628_OTP_SIZE);
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
+
+static int __init sp_otp0_drv_new(void)
+{
+	return platform_driver_register(&sp_otp_driver);
+}
+subsys_initcall(sp_otp0_drv_new);
+
+static void __exit sp_otp0_drv_del(void)
+{
+	platform_driver_unregister(&sp_otp_driver);
+}
+module_exit(sp_otp0_drv_del);
+
+MODULE_AUTHOR("Vincent Shih <vincent.sunplus@gmail.com>");
+MODULE_DESCRIPTION("Sunplus On-Chip OTP driver");
+MODULE_LICENSE("GPL v2");
+
-- 
2.7.4


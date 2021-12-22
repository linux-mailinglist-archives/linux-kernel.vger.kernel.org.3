Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C65A47CEE4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 10:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243765AbhLVJMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 04:12:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbhLVJMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 04:12:24 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E972C061574;
        Wed, 22 Dec 2021 01:12:24 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id gj24so1784602pjb.0;
        Wed, 22 Dec 2021 01:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/3KHX90uiBIaxlauNVvUNe093hkusbQgvKOBf+D0/+4=;
        b=E46RUwpqWfZos8jIL+Hp4lJtajiyxx4qu3wZKBj8o4Cav4tU9TW6a1uy6eRuV0/SVz
         9lkQtkX7XT+hkPhws4AjRiJfTCt6KBfxcdil4rbtJgBQq2ndYTVdGXoPdYRHGmH3mkGU
         BrsGnktoO/nzUVYHL0PZtzdWv4LGzc7DhyNmZUPZ24CGVdQD7EH4usV94QbECMvDM3LS
         7BV28IPTZUIf472Dfa73DtDtPmYbmdUG1h6XkI9ahZTVMQ/C4pXspsHtE0etRS2ZRXsz
         WCYRi24fw6DH+f4uPYHyFE57fRCv2u1NKTRT25FbDVz5ZismvR5pqVVJnH/0WoaHR/i0
         SqGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/3KHX90uiBIaxlauNVvUNe093hkusbQgvKOBf+D0/+4=;
        b=1rGEyfacb+/xbYNiwZr19v+mhqJk0kno7kJJGf9RnZG/Sc/85nT4cZi63Bp4x9TAy/
         ScuPHH0HUbR++Ct1m50nI+liEnD1ItFnLvibJEbi25ov3fbcT1ZhvP8C7Qu57rPJzxvD
         jwMjKE24NJCAhBU5ScwowyrAXDYvQKcTjSUbMXXziv6zicHDuPkMIPT0rz5KMdcdt9o2
         3VGbpqj0dIe/dzdB+FmrfhQGTR663oB/KLgwPzNMOAi9LoNCUj0XrkKTiGJBZGfAQbIq
         GdrHWMrQLaMoPX6HWK7ruvqFTneHMxJN29FTGcRT8ZRlokNOEvMcZCEUhp8q1DgI3ZuB
         FeMw==
X-Gm-Message-State: AOAM530vkstHovyQwySnmUd+OZlbp0vhMwNV4PGf/dG5sEzl8AjXB6f6
        m6Tw+gcuuzGngN9Edq58S8I=
X-Google-Smtp-Source: ABdhPJwohXUZ5JAJhcHxw4KorL05JYYvIsXTPiIZLy4sF4Xa3IIlZcdIxxMjQBe/xiTlijmayBVdEw==
X-Received: by 2002:a17:90b:1651:: with SMTP id il17mr325008pjb.10.1640164343891;
        Wed, 22 Dec 2021 01:12:23 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id y65sm1470011pgd.79.2021.12.22.01.12.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Dec 2021 01:12:23 -0800 (PST)
From:   Vincent Shih <vincent.sunplus@gmail.com>
To:     srinivas.kandagatla@linaro.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        wells.lu@sunplus.com, vincent.shih@sunplus.com
Cc:     Vincent Shih <vincent.sunplus@gmail.com>
Subject: [PATCH v4 1/2] nvmem: Add driver for OCOTP in Sunplus SP7021
Date:   Wed, 22 Dec 2021 17:12:25 +0800
Message-Id: <1640164346-26818-2-git-send-email-vincent.sunplus@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1640164346-26818-1-git-send-email-vincent.sunplus@gmail.com>
References: <1640164346-26818-1-git-send-email-vincent.sunplus@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add driver for OCOTP in Sunplus SP7021

Signed-off-by: Vincent Shih <vincent.sunplus@gmail.com>
---
Changes in v3:
 - Addressed the comments by Mr. Srinivas Kandagatla.
 
 MAINTAINERS                   |   5 +
 drivers/nvmem/Kconfig         |  12 +++
 drivers/nvmem/Makefile        |   2 +
 drivers/nvmem/sunplus-ocotp.c | 228 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 247 insertions(+)
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
index da41461..4559950 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -300,4 +300,16 @@ config NVMEM_BRCM_NVRAM
 	  This driver provides support for Broadcom's NVRAM that can be accessed
 	  using I/O mapping.
 
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
index 0000000..2dc59c2
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
2.7.4


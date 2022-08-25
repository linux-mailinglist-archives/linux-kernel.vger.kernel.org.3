Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6E45A1A70
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 22:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbiHYUhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 16:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243788AbiHYUg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 16:36:57 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20646B6D5E;
        Thu, 25 Aug 2022 13:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661459816; x=1692995816;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Rd858KI4HkpwyttkfK/WKThQiT4+o6bSIe1Pb9TRYHE=;
  b=RBjrRLGY+w/Xvuuph/4xETpNF1Az9kAFp7sTPu5GzVkpv9BgvWUlM+jK
   1zRnp9nhL6nmjuOJk7bHsHM5tBqCPDtm6GvnBcPMT57orGL5h6XM2DZnJ
   VVJINhIjclDECBplMrto1BCudRLgFC+JT2swnF977QoWXBPdJkBsfGzqv
   uhR7eaoSqeV/5K49aNpRaSP+EWRAa+DS3TN6WXd/2pUbr9LvU5hOc/btc
   rji9H4JbPeEHFt53bq4kxdHvs5rImZdNXuD9gZnFIYV5rmz2fZ9MTOaeK
   sIV/Nnc5693MWyUxgULJG3H81RBgTVUwxuasPe2mhlewGy2KM9tyheZDQ
   g==;
X-IronPort-AV: E=Sophos;i="5.93,264,1654585200"; 
   d="scan'208";a="110790096"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Aug 2022 13:36:55 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 25 Aug 2022 13:36:54 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Thu, 25 Aug 2022 13:36:52 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <srinivas.kandagatla@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <UNGLinuxDriver@microchip.com>,
        "Horatiu Vultur" <horatiu.vultur@microchip.com>
Subject: [PATCH v2 2/2] nvmem: lan9662-otp: add support.
Date:   Thu, 25 Aug 2022 22:40:41 +0200
Message-ID: <20220825204041.1485731-3-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220825204041.1485731-1-horatiu.vultur@microchip.com>
References: <20220825204041.1485731-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for OTP controller available on LAN9662. The OTPC controls
the access to a non-volatile memory. The size of the memory is 8KB.
The OTPC can access the memory based on an offset.
Implement both the read and the write functionality.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/nvmem/Kconfig        |   8 ++
 drivers/nvmem/Makefile       |   2 +
 drivers/nvmem/lan9662-otpc.c | 249 +++++++++++++++++++++++++++++++++++
 3 files changed, 259 insertions(+)
 create mode 100644 drivers/nvmem/lan9662-otpc.c

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 967d0084800e..c9929ec35a39 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -84,6 +84,14 @@ config NVMEM_LPC18XX_OTP
 	  To compile this driver as a module, choose M here: the module
 	  will be called nvmem_lpc18xx_otp.
 
+config NVMEM_LAN9662_OTPC
+	tristate "Microchip LAN9662 OTP controller support"
+	depends on SOC_LAN966 || COMPILE_TEST
+	depends on HAS_IOMEM
+	help
+	  This driver enables the OTP controller available on Microchip LAN9662
+	  SoCs. It controlls the access to the OTP memory connected to it.
+
 config NVMEM_MXS_OCOTP
 	tristate "Freescale MXS On-Chip OTP Memory Support"
 	depends on ARCH_MXS || COMPILE_TEST
diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index 00e136a0a123..e1baface2c53 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -21,6 +21,8 @@ obj-$(CONFIG_NVMEM_LPC18XX_EEPROM)	+= nvmem_lpc18xx_eeprom.o
 nvmem_lpc18xx_eeprom-y	:= lpc18xx_eeprom.o
 obj-$(CONFIG_NVMEM_LPC18XX_OTP)	+= nvmem_lpc18xx_otp.o
 nvmem_lpc18xx_otp-y		:= lpc18xx_otp.o
+obj-$(CONFIG_NVMEM_LAN9662_OTPC)	+= nvmem-lan9662-otpc.o
+nvmem-lan9662-otpc-y		:= lan9662-otpc.o
 obj-$(CONFIG_NVMEM_MXS_OCOTP)	+= nvmem-mxs-ocotp.o
 nvmem-mxs-ocotp-y		:= mxs-ocotp.o
 obj-$(CONFIG_NVMEM_NINTENDO_OTP)	+= nvmem-nintendo-otp.o
diff --git a/drivers/nvmem/lan9662-otpc.c b/drivers/nvmem/lan9662-otpc.c
new file mode 100644
index 000000000000..302a5bae04dc
--- /dev/null
+++ b/drivers/nvmem/lan9662-otpc.c
@@ -0,0 +1,249 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/nvmem-provider.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+
+#define OTP_OTP_PWR_DN(t)			(t + 0x00)
+#define OTP_OTP_PWR_DN_OTP_PWRDN_N		BIT(0)
+#define OTP_OTP_ADDR_HI(t)			(t + 0x04)
+#define OTP_OTP_ADDR_LO(t)			(t + 0x08)
+#define OTP_OTP_PRGM_DATA(t)			(t + 0x10)
+#define OTP_OTP_PRGM_MODE(t)			(t + 0x14)
+#define OTP_OTP_PRGM_MODE_OTP_PGM_MODE_BYTE	BIT(0)
+#define OTP_OTP_RD_DATA(t)			(t + 0x18)
+#define OTP_OTP_FUNC_CMD(t)			(t + 0x20)
+#define OTP_OTP_FUNC_CMD_OTP_PROGRAM		BIT(1)
+#define OTP_OTP_FUNC_CMD_OTP_READ		BIT(0)
+#define OTP_OTP_CMD_GO(t)			(t + 0x28)
+#define OTP_OTP_CMD_GO_OTP_GO			BIT(0)
+#define OTP_OTP_PASS_FAIL(t)			(t + 0x2c)
+#define OTP_OTP_PASS_FAIL_OTP_READ_PROHIBITED	BIT(3)
+#define OTP_OTP_PASS_FAIL_OTP_WRITE_PROHIBITED	BIT(2)
+#define OTP_OTP_PASS_FAIL_OTP_FAIL		BIT(0)
+#define OTP_OTP_STATUS(t)			(t + 0x30)
+#define OTP_OTP_STATUS_OTP_CPUMPEN		BIT(1)
+#define OTP_OTP_STATUS_OTP_BUSY			BIT(0)
+
+#define OTP_MEM_SIZE 8192
+#define OTP_SLEEP_US 10
+#define OTP_TIMEOUT_US 500000
+
+struct lan9662_otp {
+	struct device *dev;
+	void __iomem *base;
+};
+
+static inline void lan9662_writel(void __iomem *addr, u32 val)
+{
+	writel(val, addr);
+}
+
+static inline u32 lan9662_readl(void __iomem *addr)
+{
+	return readl(addr);
+}
+
+static inline void lan9662_clrbits(void __iomem *addr, u32 clear)
+{
+	writel(readl(addr) & ~clear, addr);
+}
+
+static inline void lan9662_setbits(void __iomem *addr, u32 set)
+{
+	writel(readl(addr) | set, addr);
+}
+
+static bool lan9662_otp_wait_flag_clear(void __iomem *reg, u32 flag)
+{
+	u32 val;
+
+	return readl_poll_timeout(reg, val, !(val & flag),
+				  OTP_SLEEP_US, OTP_TIMEOUT_US);
+}
+
+static int lan9662_otp_power(struct lan9662_otp *otp, bool up)
+{
+	if (up) {
+		lan9662_clrbits(OTP_OTP_PWR_DN(otp->base),
+				OTP_OTP_PWR_DN_OTP_PWRDN_N);
+		if (lan9662_otp_wait_flag_clear(OTP_OTP_STATUS(otp->base),
+						OTP_OTP_STATUS_OTP_CPUMPEN))
+			return -ETIMEDOUT;
+	} else {
+		lan9662_setbits(OTP_OTP_PWR_DN(otp->base),
+				OTP_OTP_PWR_DN_OTP_PWRDN_N);
+	}
+
+	return 0;
+}
+
+static int lan9662_otp_execute(struct lan9662_otp *otp)
+{
+	if (lan9662_otp_wait_flag_clear(OTP_OTP_CMD_GO(otp->base),
+					OTP_OTP_CMD_GO_OTP_GO))
+		return -ETIMEDOUT;
+
+	if (lan9662_otp_wait_flag_clear(OTP_OTP_STATUS(otp->base),
+					OTP_OTP_STATUS_OTP_BUSY))
+		return -ETIMEDOUT;
+
+	return 0;
+}
+
+static void lan9662_otp_set_address(struct lan9662_otp *otp, u32 offset)
+{
+	WARN_ON(offset >= OTP_MEM_SIZE);
+
+	lan9662_writel(OTP_OTP_ADDR_HI(otp->base), 0xff & (offset >> 8));
+	lan9662_writel(OTP_OTP_ADDR_LO(otp->base), 0xff & offset);
+}
+
+static int lan9662_otp_read_byte(struct lan9662_otp *otp, u32 offset, u8 *dst)
+{
+	u32 pass;
+	int rc;
+
+	lan9662_otp_set_address(otp, offset);
+	lan9662_writel(OTP_OTP_FUNC_CMD(otp->base),
+		       OTP_OTP_FUNC_CMD_OTP_READ);
+	lan9662_writel(OTP_OTP_CMD_GO(otp->base),
+		       OTP_OTP_CMD_GO_OTP_GO);
+	rc = lan9662_otp_execute(otp);
+	if (!rc) {
+		pass = lan9662_readl(OTP_OTP_PASS_FAIL(otp->base));
+		if (pass & OTP_OTP_PASS_FAIL_OTP_READ_PROHIBITED)
+			return -EACCES;
+		*dst = (u8) lan9662_readl(OTP_OTP_RD_DATA(otp->base));
+	}
+	return rc;
+}
+
+static int lan9662_otp_write_byte(struct lan9662_otp *otp, u32 offset, u8 data)
+{
+	u32 pass;
+	int rc;
+
+	lan9662_otp_set_address(otp, offset);
+	lan9662_writel(OTP_OTP_PRGM_MODE(otp->base),
+		       OTP_OTP_PRGM_MODE_OTP_PGM_MODE_BYTE);
+	lan9662_writel(OTP_OTP_PRGM_DATA(otp->base), data);
+	lan9662_writel(OTP_OTP_FUNC_CMD(otp->base),
+		       OTP_OTP_FUNC_CMD_OTP_PROGRAM);
+	lan9662_writel(OTP_OTP_CMD_GO(otp->base), OTP_OTP_CMD_GO_OTP_GO);
+
+	rc = lan9662_otp_execute(otp);
+	if (!rc) {
+		pass = lan9662_readl(OTP_OTP_PASS_FAIL(otp->base));
+		if (pass & OTP_OTP_PASS_FAIL_OTP_WRITE_PROHIBITED)
+			return -EACCES;
+		if (pass & OTP_OTP_PASS_FAIL_OTP_FAIL)
+			return -EIO;
+	}
+	return rc;
+}
+
+static int lan9662_otp_read(void *context, unsigned int offset,
+			    void *_val, size_t bytes)
+{
+	struct lan9662_otp *otp = context;
+	u8 *val = _val;
+	uint8_t data;
+	int i, rc = 0;
+
+	lan9662_otp_power(otp, true);
+	for (i = 0; i < bytes; i++) {
+		rc = lan9662_otp_read_byte(otp, offset + i, &data);
+		if (rc < 0)
+			break;
+		*val++ = data;
+	}
+	lan9662_otp_power(otp, false);
+
+	return rc;
+}
+
+static int lan9662_otp_write(void *context, unsigned int offset,
+			     void *_val, size_t bytes)
+{
+	struct lan9662_otp *otp = context;
+	u8 *val = _val;
+	u8 data, newdata;
+	int i, rc = 0;
+
+	lan9662_otp_power(otp, true);
+	for (i = 0; i < bytes; i++) {
+		/* Skip zero bytes */
+		if (val[i]) {
+			rc = lan9662_otp_read_byte(otp, offset + i, &data);
+			if (rc < 0)
+				break;
+
+			newdata = data | val[i];
+			if (newdata == data)
+				continue;
+
+			rc = lan9662_otp_write_byte(otp, offset + i,
+						      newdata);
+			if (rc < 0)
+				break;
+		}
+	}
+	lan9662_otp_power(otp, false);
+
+	return rc;
+}
+
+static struct nvmem_config otp_config = {
+	.name = "lan9662-otp",
+	.stride = 1,
+	.word_size = 1,
+	.reg_read = lan9662_otp_read,
+	.reg_write = lan9662_otp_write,
+	.size = OTP_MEM_SIZE,
+};
+
+static int lan9662_otp_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct nvmem_device *nvmem;
+	struct lan9662_otp *otp;
+
+	otp = devm_kzalloc(&pdev->dev, sizeof(*otp), GFP_KERNEL);
+	if (!otp)
+		return -ENOMEM;
+
+	otp->dev = dev;
+	otp->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(otp->base))
+		return PTR_ERR(otp->base);
+
+	otp_config.priv = otp;
+	otp_config.dev = dev;
+
+	nvmem = devm_nvmem_register(dev, &otp_config);
+
+	return PTR_ERR_OR_ZERO(nvmem);
+}
+
+static const struct of_device_id lan9662_otp_match[] = {
+	{ .compatible = "microchip,lan9662-otp", },
+	{ .compatible = "microchip,lan9668-otp", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, lan9662_otp_match);
+
+static struct platform_driver lan9662_otp_driver = {
+	.probe = lan9662_otp_probe,
+	.driver = {
+		.name = "lan9662-otp",
+		.of_match_table = lan9662_otp_match,
+	},
+};
+module_platform_driver(lan9662_otp_driver);
+
+MODULE_AUTHOR("Horatiu Vultur <horatiu.vultur@microchip.com>");
+MODULE_DESCRIPTION("lan9662 OTP driver");
+MODULE_LICENSE("GPL");
-- 
2.33.0


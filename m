Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10621598923
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 18:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344531AbiHRQkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 12:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343873AbiHRQkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 12:40:04 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA7AA5C78;
        Thu, 18 Aug 2022 09:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660840803; x=1692376803;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BOJbFo1Gr+Ldmxe1zxnVJOr9OyTPhCEPiNydRDP3kHQ=;
  b=kmPGSotoZDb7pfGX2COveZ++u9LzaRIlsuc/KEEmc7DpNyZ+9R7Mr5xv
   wDsINPo724qIOzoipUayqJ53u5AwojaOETj9WtN2B1xTDnHU81WlT2Zd8
   lkkhg7tKUe0wxkEJbyRCSsjLt7rKdmrptr5sX24VKIpBdNpGZWsqNeJ1o
   AWGhcg+RA1EPgV900r7ccIYqUMSa7YQz8qbIseCFxRXvvfCOM4fGE+nwL
   QpesDX/nssOcZWNlRUInb97IQv2HuCYSZ2DczEN8AKqDLsF8deFLXr8kd
   i6QSZKaCxIOoiSy3ccz9N6RUk5prur4IRVUOHmiBo3I+tH+6YbPDgDZiP
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="176812620"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Aug 2022 09:40:00 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 18 Aug 2022 09:39:59 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Thu, 18 Aug 2022 09:39:58 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <srinivas.kandagatla@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH 2/2] nvmem: lan966x-otpc: add support
Date:   Thu, 18 Aug 2022 18:44:05 +0200
Message-ID: <20220818164405.1953698-3-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220818164405.1953698-1-horatiu.vultur@microchip.com>
References: <20220818164405.1953698-1-horatiu.vultur@microchip.com>
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

Add support for OTP controller available on LAN966X. The OTPC controls
the access to a non-volatile memory. The size of the memory is 8KB.
The OTPC can access the memory based on an offset.
Implement both the read and the write functionality.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/nvmem/Kconfig        |   8 ++
 drivers/nvmem/Makefile       |   2 +
 drivers/nvmem/lan966x-otpc.c | 248 +++++++++++++++++++++++++++++++++++
 3 files changed, 258 insertions(+)
 create mode 100644 drivers/nvmem/lan966x-otpc.c

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index bab8a29c9861..7252c090a2ff 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -84,6 +84,14 @@ config NVMEM_LPC18XX_OTP
 	  To compile this driver as a module, choose M here: the module
 	  will be called nvmem_lpc18xx_otp.
 
+config NVMEM_LAN966X_OTPC
+	tristate "Microchip LAN966X OTP controller support"
+	depends on SOC_LAN966 || COMPILE_TEST
+	depends on HAS_IOMEM
+	help
+	  This driver enable the OTP controller available on Microchip LAN966X
+	  SoCs. It controlls the access to the OTP memory connected to it.
+
 config NVMEM_MXS_OCOTP
 	tristate "Freescale MXS On-Chip OTP Memory Support"
 	depends on ARCH_MXS || COMPILE_TEST
diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index 399f9972d45b..c3471b4fb738 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -21,6 +21,8 @@ obj-$(CONFIG_NVMEM_LPC18XX_EEPROM)	+= nvmem_lpc18xx_eeprom.o
 nvmem_lpc18xx_eeprom-y	:= lpc18xx_eeprom.o
 obj-$(CONFIG_NVMEM_LPC18XX_OTP)	+= nvmem_lpc18xx_otp.o
 nvmem_lpc18xx_otp-y		:= lpc18xx_otp.o
+obj-$(CONFIG_NVMEM_LAN966X_OTPC)	+= nvmem-lan966x-otpc.o
+nvmem-lan966x-otpc-y		:= lan966x-otpc.o
 obj-$(CONFIG_NVMEM_MXS_OCOTP)	+= nvmem-mxs-ocotp.o
 nvmem-mxs-ocotp-y		:= mxs-ocotp.o
 obj-$(CONFIG_NVMEM_NINTENDO_OTP)	+= nvmem-nintendo-otp.o
diff --git a/drivers/nvmem/lan966x-otpc.c b/drivers/nvmem/lan966x-otpc.c
new file mode 100644
index 000000000000..d9b1721c0699
--- /dev/null
+++ b/drivers/nvmem/lan966x-otpc.c
@@ -0,0 +1,248 @@
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
+struct lan966x_otp {
+	struct device *dev;
+	void __iomem *base;
+};
+
+static inline void lan966x_writel(void __iomem *addr, u32 val)
+{
+	writel(val, addr);
+}
+
+static inline u32 lan966x_readl(void __iomem *addr)
+{
+	return readl(addr);
+}
+
+static inline void lan966x_clrbits(void __iomem *addr, u32 clear)
+{
+	writel(readl(addr) & ~clear, addr);
+}
+
+static inline void lan966x_setbits(void __iomem *addr, u32 set)
+{
+	writel(readl(addr) | set, addr);
+}
+
+static bool lan966x_otp_wait_flag_clear(void __iomem *reg, u32 flag)
+{
+	u32 val;
+
+	return readl_poll_timeout(reg, val, !(val & flag),
+				  OTP_SLEEP_US, OTP_TIMEOUT_US);
+}
+
+static int lan966x_otp_power(struct lan966x_otp *otp, bool up)
+{
+	if (up) {
+		lan966x_clrbits(OTP_OTP_PWR_DN(otp->base),
+				OTP_OTP_PWR_DN_OTP_PWRDN_N);
+		if (lan966x_otp_wait_flag_clear(OTP_OTP_STATUS(otp->base),
+						OTP_OTP_STATUS_OTP_CPUMPEN))
+			return -ETIMEDOUT;
+	} else {
+		lan966x_setbits(OTP_OTP_PWR_DN(otp->base),
+				OTP_OTP_PWR_DN_OTP_PWRDN_N);
+	}
+
+	return 0;
+}
+
+static int lan966x_otp_execute(struct lan966x_otp *otp)
+{
+	if (lan966x_otp_wait_flag_clear(OTP_OTP_CMD_GO(otp->base),
+					OTP_OTP_CMD_GO_OTP_GO))
+		return -ETIMEDOUT;
+
+	if (lan966x_otp_wait_flag_clear(OTP_OTP_STATUS(otp->base),
+					OTP_OTP_STATUS_OTP_BUSY))
+		return -ETIMEDOUT;
+
+	return 0;
+}
+
+static void lan966x_otp_set_address(struct lan966x_otp *otp, u32 offset)
+{
+	WARN_ON(offset >= OTP_MEM_SIZE);
+
+	lan966x_writel(OTP_OTP_ADDR_HI(otp->base), 0xff & (offset >> 8));
+	lan966x_writel(OTP_OTP_ADDR_LO(otp->base), 0xff & offset);
+}
+
+static int lan966x_otp_read_byte(struct lan966x_otp *otp, u32 offset, u8 *dst)
+{
+	u32 pass;
+	int rc;
+
+	lan966x_otp_set_address(otp, offset);
+	lan966x_writel(OTP_OTP_FUNC_CMD(otp->base),
+		       OTP_OTP_FUNC_CMD_OTP_READ);
+	lan966x_writel(OTP_OTP_CMD_GO(otp->base),
+		       OTP_OTP_CMD_GO_OTP_GO);
+	rc = lan966x_otp_execute(otp);
+	if (!rc) {
+		pass = lan966x_readl(OTP_OTP_PASS_FAIL(otp->base));
+		if (pass & OTP_OTP_PASS_FAIL_OTP_READ_PROHIBITED)
+			return -EACCES;
+		*dst = (u8) lan966x_readl(OTP_OTP_RD_DATA(otp->base));
+	}
+	return rc;
+}
+
+static int lan966x_otp_write_byte(struct lan966x_otp *otp, u32 offset, u8 data)
+{
+	u32 pass;
+	int rc;
+
+	lan966x_otp_set_address(otp, offset);
+	lan966x_writel(OTP_OTP_PRGM_MODE(otp->base),
+		       OTP_OTP_PRGM_MODE_OTP_PGM_MODE_BYTE);
+	lan966x_writel(OTP_OTP_PRGM_DATA(otp->base), data);
+	lan966x_writel(OTP_OTP_FUNC_CMD(otp->base),
+		       OTP_OTP_FUNC_CMD_OTP_PROGRAM);
+	lan966x_writel(OTP_OTP_CMD_GO(otp->base), OTP_OTP_CMD_GO_OTP_GO);
+
+	rc = lan966x_otp_execute(otp);
+	if (!rc) {
+		pass = lan966x_readl(OTP_OTP_PASS_FAIL(otp->base));
+		if (pass & OTP_OTP_PASS_FAIL_OTP_WRITE_PROHIBITED)
+			return -EACCES;
+		if (pass & OTP_OTP_PASS_FAIL_OTP_FAIL)
+			return -EIO;
+	}
+	return rc;
+}
+
+static int lan966x_otp_read(void *context, unsigned int offset,
+			    void *_val, size_t bytes)
+{
+	struct lan966x_otp *otp = context;
+	u8 *val = _val;
+	uint8_t data;
+	int i, rc = 0;
+
+	lan966x_otp_power(otp, true);
+	for (i = 0; i < bytes; i++) {
+		rc = lan966x_otp_read_byte(otp, offset + i, &data);
+		if (rc < 0)
+			break;
+		*val++ = data;
+	}
+	lan966x_otp_power(otp, false);
+
+	return rc;
+}
+
+static int lan966x_otp_write(void *context, unsigned int offset,
+			     void *_val, size_t bytes)
+{
+	struct lan966x_otp *otp = context;
+	u8 *val = _val;
+	u8 data, newdata;
+	int i, rc = 0;
+
+	lan966x_otp_power(otp, true);
+	for (i = 0; i < bytes; i++) {
+		/* Skip zero bytes */
+		if (val[i]) {
+			rc = lan966x_otp_read_byte(otp, offset + i, &data);
+			if (rc < 0)
+				break;
+
+			newdata = data | val[i];
+			if (newdata == data)
+				continue;
+
+			rc = lan966x_otp_write_byte(otp, offset + i,
+						      newdata);
+			if (rc < 0)
+				break;
+		}
+	}
+	lan966x_otp_power(otp, false);
+
+	return rc;
+}
+
+static struct nvmem_config otp_config = {
+	.name = "lan966x-otp",
+	.stride = 1,
+	.word_size = 1,
+	.reg_read = lan966x_otp_read,
+	.reg_write = lan966x_otp_write,
+	.size = OTP_MEM_SIZE,
+};
+
+static int lan966x_otp_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct nvmem_device *nvmem;
+	struct lan966x_otp *otp;
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
+static const struct of_device_id lan966x_otp_match[] = {
+	{ .compatible = "microchip,lan966x-otp", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, lan966x_otp_match);
+
+static struct platform_driver lan966x_otp_driver = {
+	.probe = lan966x_otp_probe,
+	.driver = {
+		.name = "lan966x-otp",
+		.of_match_table = lan966x_otp_match,
+	},
+};
+module_platform_driver(lan966x_otp_driver);
+
+MODULE_AUTHOR("Horatiu Vultur <horatiu.vultur@microchip.com>");
+MODULE_DESCRIPTION("Lan966x OTP driver");
+MODULE_LICENSE("GPL");
-- 
2.33.0


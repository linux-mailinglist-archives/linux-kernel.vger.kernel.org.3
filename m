Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB9A4BD393
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 03:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343498AbiBUCPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 21:15:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245756AbiBUCPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 21:15:11 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D4D3207C;
        Sun, 20 Feb 2022 18:14:48 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id i10so11714457plr.2;
        Sun, 20 Feb 2022 18:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=6AzNizfsx+LtGMw+yopQz+Isc0bIkR81XctoNgYWxX4=;
        b=gB0QQOUBdl/EQMokLnGdgsbZGUrzMKQR0PwkTGUbuAGCum3AKpgKnNoVBL3WrlgPv1
         h4rGFzqzFbwt/I9Ck3dOA+tnXwfTkoBs8A/ci5Jg1yfnOZ5jeubQPQVQ9PYx5oB7Ug3x
         +l5GHwQHOQfcyMldxD3EMDgQWMS3KThJlEzo3F+FSGd3Ev0uQ5nuENW5UQ/xE1W0DATx
         fkpeYjGh7hSZmjLOmN7OnngZ3lGFUS1EPCsmZMNLVO3uzobHEp1K3gSxWDXSU88txJVE
         UQyTk0npcpRDK0Em4nMyRT9DqUBn0NUNI7u5dyuBWP8g52eAPWOVRCGxIWtSVLhCye4J
         Dh1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=6AzNizfsx+LtGMw+yopQz+Isc0bIkR81XctoNgYWxX4=;
        b=j2wWBgN6pUFYbSRqNaMuAcUIWaxlzuIPXmOIjZ2zRJ8BZgog1qE8QJVIJEoxfTPmJf
         ADROXnlrwRt2+xNeWe/w17I60jQxIh0w8R3R2BmUL0x+XNpKL01knNB3QbfEVYpnOQKK
         DLnmVZ94pJgHUozRVM+/z6gJS2uCpuANe2HiiosxAyVAcDiU8juOCR2zYSG3Ly5nyETI
         NWgKd1i90VXgICUiIkZYQDDp6uD3y0k8ZuEjUUuF9akZ0g0k3MGMZF54GHZCtwVGvIbg
         lFvU7KOmd0rAQoSbVHCXpN1tV6NrdYXDjzGD4YmKDXafLXAXkYN0f3FJeSVese4L7v9p
         uRhA==
X-Gm-Message-State: AOAM533pNZNou0vnsZVc6GrMD2M3nCSaizz4CltkkrfKzPMRva3DP9RM
        UVptCF9TmkDAtc9N9xFNIQU=
X-Google-Smtp-Source: ABdhPJygyqIVlHgzMZ6nE511kwA/XgnLTjPqAfP1pqDnoGxD22PV4sS7o5c/0TS+sdDws5UeFyj3iA==
X-Received: by 2002:a17:902:9348:b0:14f:c715:2a94 with SMTP id g8-20020a170902934800b0014fc7152a94mr1086393plp.66.1645409688289;
        Sun, 20 Feb 2022 18:14:48 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id s48sm10022908pfw.111.2022.02.20.18.14.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Feb 2022 18:14:47 -0800 (PST)
From:   Tony Huang <tonyhuang.sunplus@gmail.com>
To:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, derek.kiernan@xilinx.com,
        dragan.cvetic@xilinx.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, wells.lu@sunplus.com,
        tony.huang@sunplus.com
Cc:     Tony Huang <tonyhuang.sunplus@gmail.com>
Subject: [PATCH v9 2/2] misc: Add iop driver for Sunplus SP7021
Date:   Mon, 21 Feb 2022 10:14:55 +0800
Message-Id: <20f858dfe999816cb05dfde5f89db48f3416358e.1645407997.git.tonyhuang.sunplus@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1645407997.git.tonyhuang.sunplus@gmail.com>
References: <cover.1645407997.git.tonyhuang.sunplus@gmail.com>
In-Reply-To: <cover.1645407997.git.tonyhuang.sunplus@gmail.com>
References: <cover.1645407997.git.tonyhuang.sunplus@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IOP(8051) embedded inside SP7021 which is used as
Processor for I/O control, monitor RTC interrupt and
cooperation with CPU & PMC in power management purpose.
The IOP core is DQ8051, so also named IOP8051,
it supports dedicated JTAG debug pins which share with SP7021.
In standby mode operation, the power spec reach 400uA.

Signed-off-by: Tony Huang <tonyhuang.sunplus@gmail.com>
---
Changes in v9:
 - Remove custom attributes sysfs.

 MAINTAINERS                |   1 +
 drivers/misc/Kconfig       |  20 +++
 drivers/misc/Makefile      |   1 +
 drivers/misc/sunplus_iop.c | 420 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 442 insertions(+)
 create mode 100644 drivers/misc/sunplus_iop.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 6f336c9..11ecefa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18246,6 +18246,7 @@ SUNPLUS IOP DRIVER
 M:	Tony Huang <tonyhuang.sunplus@gmail.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/misc/sunplu-iop.yaml
+F:	drivers/misc/sunplus_iop.c
 
 SUPERH
 M:	Yoshinori Sato <ysato@users.sourceforge.jp>
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 0f5a49f..c1d790e 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -470,6 +470,26 @@ config HISI_HIKEY_USB
 	  switching between the dual-role USB-C port and the USB-A host ports
 	  using only one USB controller.
 
+config SUNPLUS_IOP
+	tristate "Sunplus IOP support"
+	default ARCH_SUNPLUS
+	help
+	  Sunplus I/O processor (8051) driver.
+	  Processor for I/O control, monitor RTC interrupt
+	  and cooperation with CPU&PMC in power management.
+
+	  The IOP core is DQ8051, so also named IOP8051.
+	  Need Install DQ8051, The DQ8051 bin file generated by keil C.
+	  We will provide users with 8051 normal and standby source code.
+	  Path: https://sunplus.atlassian.net/wiki/spaces/doc/pages/610172933/
+	  How+to+use+I+O+processor+8051+of+SP7021#5.-Write-C-or-assembly-source-files-for-IOP
+	  Users can follow the operation steps to generate normal.bin and standby.bin.
+	  Path: https://sunplus.atlassian.net/wiki/spaces/doc/pages/466190338/26.+IOP8051
+	  26.5?How To Create 8051 bin file
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called sunplus_iop.
+
 source "drivers/misc/c2port/Kconfig"
 source "drivers/misc/eeprom/Kconfig"
 source "drivers/misc/cb710/Kconfig"
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index a086197..eafeab6 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -52,6 +52,7 @@ obj-$(CONFIG_DW_XDATA_PCIE)	+= dw-xdata-pcie.o
 obj-$(CONFIG_PCI_ENDPOINT_TEST)	+= pci_endpoint_test.o
 obj-$(CONFIG_OCXL)		+= ocxl/
 obj-$(CONFIG_BCM_VK)		+= bcm-vk/
+obj-$(CONFIG_SUNPLUS_IOP)	+= sunplus_iop.o
 obj-y				+= cardreader/
 obj-$(CONFIG_PVPANIC)   	+= pvpanic/
 obj-$(CONFIG_HABANA_AI)		+= habanalabs/
diff --git a/drivers/misc/sunplus_iop.c b/drivers/misc/sunplus_iop.c
new file mode 100644
index 0000000..c1180c1
--- /dev/null
+++ b/drivers/misc/sunplus_iop.c
@@ -0,0 +1,420 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * The IOP driver for Sunplus SP7021
+ *
+ * Copyright (C) 2021 Sunplus Technology Inc.
+ *
+ * All Rights Reserved.
+ */
+#include <linux/delay.h>
+#include <linux/dma-mapping.h>
+#include <linux/firmware.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/miscdevice.h>
+#include <linux/of_platform.h>
+#include <linux/of_address.h>
+#include <linux/of_gpio.h>
+
+enum IOP_Status_e {
+	IOP_SUCCESS,		/* successful */
+	IOP_ERR_IOP_BUSY,	/* IOP is busy */
+};
+
+/* moon0 register offset */
+#define IOP_CLKEN0	0x04
+#define IOP_RESET0	0x54
+
+/* IOP register offset */
+#define IOP_CONTROL	0x00
+#define IOP_DATA0	0x20
+#define IOP_DATA1	0x24
+#define IOP_DATA2	0x28
+#define IOP_DATA3	0x2c
+#define IOP_DATA4	0x30
+#define IOP_DATA5	0x34
+#define IOP_DATA6	0x38
+#define IOP_DATA7	0x3c
+#define IOP_DATA8	0x40
+#define IOP_DATA9	0x44
+#define IOP_DATA10	0x48
+#define IOP_DATA11	0x4c
+#define IOP_BASE_ADR_L	0x50
+#define IOP_BASE_ADR_H	0x54
+
+/* PMC register offset */
+#define IOP_PMC_TIMER		0x00
+#define IOP_PMC_CTRL		0x04
+#define IOP_XTAL27M_PASSWORD_I	0x08
+#define IOP_XTAL27M_PASSWORD_II	0x0c
+#define IOP_XTAL32K_PASSWORD_I	0x10
+#define IOP_XTAL32K_PASSWORD_II	0x14
+#define IOP_CLK27M_PASSWORD_I	0x18
+#define IOP_CLK27M_PASSWORD_II	0x1c
+#define IOP_PMC_TIMER2		0x20
+
+#define NORMAL_CODE_MAX_SIZE 0X1000	/* Max size of normal.bin that can be received */
+#define STANDBY_CODE_MAX_SIZE 0x4000	/* Max size of standby.bin that can be received */
+struct sp_iop {
+	struct miscdevice dev;
+	struct mutex write_lock;	/* avoid parallel access */
+	void __iomem *iop_regs;
+	void __iomem *pmc_regs;
+	void __iomem *moon0_regs;
+	int irq;
+	int gpio_wakeup;
+	unsigned char iop_normal_code[NORMAL_CODE_MAX_SIZE];
+	unsigned char iop_standby_code[STANDBY_CODE_MAX_SIZE];
+	resource_size_t iop_mem_start;
+	resource_size_t iop_mem_size;
+	unsigned char bin_code_mode;
+};
+
+static void sp_iop_normal_mode(struct sp_iop *iop)
+{
+	void __iomem *iop_kernel_base;
+	unsigned int reg;
+
+	iop_kernel_base = ioremap(iop->iop_mem_start, NORMAL_CODE_MAX_SIZE);
+	memset(iop_kernel_base, 0, NORMAL_CODE_MAX_SIZE);
+	memcpy(iop_kernel_base, iop->iop_normal_code, NORMAL_CODE_MAX_SIZE);
+
+	writel(0x00100010, iop->moon0_regs + IOP_CLKEN0);
+
+	reg = readl(iop->iop_regs + IOP_CONTROL);
+	reg |= 0x01;
+	writel(reg, iop->iop_regs + IOP_CONTROL);
+
+	reg = readl(iop->iop_regs + IOP_CONTROL);
+	reg &= ~(0x8000);
+	writel(reg, iop->iop_regs + IOP_CONTROL);
+
+	reg = readl(iop->iop_regs + IOP_CONTROL);
+	reg |= 0x0200;// disable watchdog event reset IOP
+	writel(reg, iop->iop_regs + IOP_CONTROL);
+
+	reg = (iop->iop_mem_start & 0xFFFF);
+	writel(reg, iop->iop_regs + IOP_BASE_ADR_L);
+	reg	= (iop->iop_mem_start >> 16);
+	writel(reg, iop->iop_regs + IOP_BASE_ADR_H);
+
+	reg = readl(iop->iop_regs + IOP_CONTROL);
+	reg &= ~(0x01);
+	writel(reg, iop->iop_regs + IOP_CONTROL);
+	iop->bin_code_mode = 0;
+}
+
+static void sp_iop_standby_mode(struct sp_iop *iop)
+{
+	void __iomem *iop_kernel_base;
+	unsigned long reg;
+
+	iop_kernel_base = ioremap(iop->iop_mem_start, STANDBY_CODE_MAX_SIZE);
+	memset(iop_kernel_base, 0, STANDBY_CODE_MAX_SIZE);
+	memcpy(iop_kernel_base, iop->iop_standby_code, STANDBY_CODE_MAX_SIZE);
+
+	writel(0x00100010, iop->moon0_regs + IOP_CLKEN0);
+
+	reg = readl(iop->iop_regs + IOP_CONTROL);
+	reg |= 0x01;
+	writel(reg, iop->iop_regs + IOP_CONTROL);
+
+	reg = readl(iop->iop_regs + IOP_CONTROL);
+	reg &= ~(0x8000);
+	writel(reg, iop->iop_regs + IOP_CONTROL);
+
+	reg = readl(iop->iop_regs + IOP_CONTROL);
+	reg |= 0x0200;// disable watchdog event reset IOP
+	writel(reg, iop->iop_regs + IOP_CONTROL);
+
+	reg = (iop->iop_mem_start & 0xFFFF);
+	writel(reg, iop->iop_regs + IOP_BASE_ADR_L);
+	reg = (iop->iop_mem_start >> 16);
+	writel(reg, iop->iop_regs + IOP_BASE_ADR_H);
+
+	reg = readl(iop->iop_regs + IOP_CONTROL);
+	reg &= ~(0x01);
+	writel(reg, iop->iop_regs + IOP_CONTROL);
+	iop->bin_code_mode = 1;
+}
+
+/* 8051 informs linux kerenl. 8051 has been switched to standby.bin code. */
+#define IOP_READY	0x0004
+#define RISC_READY	0x0008
+
+/* System linux kernel tells 8051 which  gpio pin to wake-up through. */
+#define WAKEUP_PIN	0xFE02
+
+/* System linux kernel tells 8051 to execute S1 or S3 mode. */
+#define S1	0x5331
+#define S3	0x5333
+
+static int sp_iop_s3mode(struct device *dev, struct sp_iop *iop)
+{
+	unsigned int reg;
+	int ret, value;
+
+	/* PMC set */
+	writel(0x00010001, iop->pmc_regs + IOP_PMC_TIMER);
+	reg = readl(iop->pmc_regs + IOP_PMC_CTRL);
+	/* disable system reset PMC, enalbe power down IOP Domain, enable gating clock 27Mhz */
+	reg |= 0x23;
+	writel(reg, iop->pmc_regs + IOP_PMC_CTRL);
+
+	writel(0x55aa00ff, iop->pmc_regs + IOP_XTAL27M_PASSWORD_I);
+	writel(0x00ff55aa, iop->pmc_regs + IOP_XTAL27M_PASSWORD_II);
+	writel(0xaa00ff55, iop->pmc_regs + IOP_XTAL32K_PASSWORD_I);
+	writel(0xff55aa00, iop->pmc_regs + IOP_XTAL32K_PASSWORD_II);
+	writel(0xaaff0055, iop->pmc_regs + IOP_CLK27M_PASSWORD_I);
+	writel(0x5500aaff, iop->pmc_regs + IOP_CLK27M_PASSWORD_II);
+	writel(0x01000100, iop->pmc_regs + IOP_PMC_TIMER2);
+
+	/* IOP Hardware IP reset */
+	reg = readl(iop->moon0_regs + IOP_RESET0);
+	reg |= 0x10;
+	writel(reg, (iop->moon0_regs + IOP_RESET0));
+	reg &= ~(0x10);
+	writel(reg, (iop->moon0_regs + IOP_RESET0));
+
+	writel(0x00ff0085, (iop->moon0_regs + 32 * 4 * 1 + 4 * 1));
+
+	reg = readl(iop->moon0_regs + 32 * 4 * 1 + 4 * 2);
+	reg |= 0x08000800;
+	writel(reg, (iop->moon0_regs + 32 * 4 * 1 + 4 * 2));
+
+	writel(WAKEUP_PIN, iop->iop_regs + IOP_DATA0);
+	writel(iop->gpio_wakeup, iop->iop_regs + IOP_DATA1);
+
+	ret = readl_poll_timeout(iop->iop_regs + IOP_DATA2, value,
+				 (value & IOP_READY) == IOP_READY, 1000, 10000);
+	if (ret) {
+		dev_err(dev, "timed out\n");
+		return ret;
+	}
+
+	reg = RISC_READY;
+	writel(reg, iop->iop_regs + IOP_DATA2);
+	reg = 0x0000;
+	writel(reg, iop->iop_regs + IOP_DATA5);
+	reg = 0x0060;
+	writel(reg, iop->iop_regs + IOP_DATA6);
+
+	ret = readl_poll_timeout(iop->iop_regs + IOP_DATA7, value,
+				 value == 0xaaaa, 1000, 10000);
+	if (ret) {
+		dev_err(dev, "timed out\n");
+		return ret;
+	}
+
+	/* 8051 bin file call Ultra low function. */
+	writel(0xdd, iop->iop_regs + IOP_DATA1);
+	/*
+	 * When the execution is here, the system linux kernel
+	 * is about to be powered off
+	 * The purpose of mdelay(10): Do not let the system linux
+	 * kernel continue to run other programs.
+	 */
+	mdelay(10);
+	return 0;
+}
+
+static int sp_iop_s1mode(struct device *dev, struct sp_iop *iop)
+{
+	int ret, value;
+
+	ret = readl_poll_timeout(iop->iop_regs + IOP_DATA2, value,
+				 (value & IOP_READY) == IOP_READY, 1000, 10000);
+	if (ret) {
+		dev_err(dev, "timed out\n");
+		return ret;
+	}
+
+	writel(RISC_READY, iop->iop_regs + IOP_DATA2);
+	writel(0x0000, iop->iop_regs + IOP_DATA5);
+	writel(0x0060, iop->iop_regs + IOP_DATA6);
+
+	ret = readl_poll_timeout(iop->iop_regs + IOP_DATA7, value,
+				 value == 0xaaaa, 1000, 10000);
+	if (ret) {
+		dev_err(dev, "timed out\n");
+		return ret;
+	}
+
+	/* 8051 bin file call S1_mode function. */
+	writel(0xee, iop->iop_regs + IOP_DATA1);
+	/*
+	 * When the execution is here, the system linux kernel
+	 * is about to be powered off
+	 * The purpose of mdelay(10): Do not let the system linux
+	 * kernel continue to run other programs.
+	 */
+	mdelay(10);
+	return 0;
+}
+
+static int  sp_iop_get_normal_code(struct device *dev, struct sp_iop *iop)
+{
+	const struct firmware *fw;
+	static const char file[] = "normal.bin";
+	unsigned int err, i;
+
+	err = request_firmware(&fw, file, dev);
+	if (err) {
+		dev_err(dev, "get bin file error\n");
+		return err;
+	}
+
+	for (i = 0; i < NORMAL_CODE_MAX_SIZE; i++) {
+		char temp;
+
+		temp = fw->data[i];
+		iop->iop_normal_code[i] = temp;
+	}
+	release_firmware(fw);
+	return err;
+}
+
+static int  sp_iop_get_standby_code(struct device *dev, struct sp_iop *iop)
+{
+	const struct firmware *fw;
+	static const char file[] = "standby.bin";
+	unsigned int err, i;
+
+	err = request_firmware(&fw, file, dev);
+	if (err) {
+		dev_err(dev, "get bin file error\n");
+		return err;
+	}
+
+	for (i = 0; i < STANDBY_CODE_MAX_SIZE; i++) {
+		char temp;
+
+		temp = fw->data[i];
+		iop->iop_standby_code[i] = temp;
+	}
+	release_firmware(fw);
+	return err;
+}
+
+static int sp_iop_get_resources(struct platform_device *pdev, struct sp_iop *p_sp_iop_info)
+{
+	struct resource *r;
+
+	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "iop");
+	p_sp_iop_info->iop_regs = devm_ioremap_resource(&pdev->dev, r);
+	if (IS_ERR(p_sp_iop_info->iop_regs)) {
+		dev_err(&pdev->dev, "ioremap fail\n");
+		return PTR_ERR(p_sp_iop_info->iop_regs);
+	}
+
+	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "iop_pmc");
+	p_sp_iop_info->pmc_regs = devm_ioremap_resource(&pdev->dev, r);
+	if (IS_ERR(p_sp_iop_info->pmc_regs)) {
+		dev_err(&pdev->dev, "ioremap fail\n");
+		return PTR_ERR(p_sp_iop_info->pmc_regs);
+	}
+
+	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "moon0");
+	p_sp_iop_info->moon0_regs = devm_ioremap_resource(&pdev->dev, r);
+	if (IS_ERR(p_sp_iop_info->moon0_regs)) {
+		dev_err(&pdev->dev, "ioremap fail\n");
+		return PTR_ERR(p_sp_iop_info->moon0_regs);
+	}
+	return IOP_SUCCESS;
+}
+
+static int sp_iop_platform_driver_probe(struct platform_device *pdev)
+{
+	int ret = -ENXIO;
+	int rc;
+	struct sp_iop *iop;
+	struct device_node *memnp;
+	struct resource mem_res;
+
+	iop = devm_kzalloc(&pdev->dev, sizeof(struct sp_iop), GFP_KERNEL);
+	if (!iop) {
+		ret	= -ENOMEM;
+		goto fail_kmalloc;
+	}
+	/* init */
+	mutex_init(&iop->write_lock);
+	ret = sp_iop_get_resources(pdev, iop);
+
+	// Get reserve address
+	memnp = of_parse_phandle(pdev->dev.of_node, "memory-region", 0);
+	if (!memnp) {
+		dev_err(&pdev->dev, "no memory-region node\n");
+		return -EINVAL;
+	}
+
+	rc = of_address_to_resource(memnp, 0, &mem_res);
+	of_node_put(memnp);
+	if (rc) {
+		dev_err(&pdev->dev, "failed to translate memory-region to a resource\n");
+		return -EINVAL;
+	}
+
+	iop->iop_mem_start = mem_res.start;
+	iop->iop_mem_size = resource_size(&mem_res);
+
+	ret = sp_iop_get_normal_code(&pdev->dev, iop);
+	if (ret != 0) {
+		dev_err(&pdev->dev, "get normal code err=%d\n", ret);
+		return ret;
+	}
+
+	ret = sp_iop_get_standby_code(&pdev->dev, iop);
+	if (ret != 0) {
+		dev_err(&pdev->dev, "get standby code err=%d\n", ret);
+		return ret;
+	}
+
+	sp_iop_normal_mode(iop);
+	platform_set_drvdata(pdev, iop);
+	iop->gpio_wakeup = of_get_named_gpio(pdev->dev.of_node, "iop-wakeup", 0);
+	return 0;
+
+fail_kmalloc:
+	return ret;
+}
+
+static void sp_iop_platform_driver_shutdown(struct platform_device *pdev)
+{
+	struct sp_iop *iop = platform_get_drvdata(pdev);
+	unsigned int ret, value;
+
+	value = readl(iop->iop_regs + IOP_DATA11);
+	sp_iop_standby_mode(iop);
+
+	ret = readl_poll_timeout(iop->iop_regs + IOP_DATA0, value,
+				 value == 0x2222, 1000, 100000);
+	if (ret)
+		dev_warn(&pdev->dev, "timed out\n");
+
+	if (value == S1)
+		sp_iop_s1mode(&pdev->dev, iop);
+	else
+		sp_iop_s3mode(&pdev->dev, iop);
+}
+
+static const struct of_device_id sp_iop_of_match[] = {
+	{ .compatible = "sunplus,sp7021-iop" },
+	{ /* sentinel */ },
+};
+
+MODULE_DEVICE_TABLE(of, sp_iop_of_match);
+
+static struct platform_driver sp_iop_platform_driver = {
+	.probe		= sp_iop_platform_driver_probe,
+	.shutdown	= sp_iop_platform_driver_shutdown,
+	.driver = {
+		.name	= "sunplus,sp7021-iop",
+		.of_match_table = sp_iop_of_match,
+	}
+};
+
+module_platform_driver(sp_iop_platform_driver);
+
+MODULE_AUTHOR("Tony Huang <tonyhuang.sunplus@gmail.com>");
+MODULE_DESCRIPTION("Sunplus IOP Driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4


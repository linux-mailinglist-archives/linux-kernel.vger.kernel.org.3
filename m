Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8699946E4BB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 09:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235484AbhLIJBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 04:01:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbhLIJBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 04:01:46 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BB6C061746;
        Thu,  9 Dec 2021 00:58:13 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id x131so4770218pfc.12;
        Thu, 09 Dec 2021 00:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=JDMokaVTYTVwlqCsIdJNDsu02GWjiO4qpEPRBz/Krgw=;
        b=LcTBZ3B+JlfbDgnxndESKzB5GBme6XqEP5GZ7WGviSlw3eR0h+qrAsakZNtrJXhfq1
         ULr6m7T0RUFbncx3H82Fl/z0KL8zGVk9XrHn1L1IQVbXlLSeB6jaqbOTngjO3eUUmENp
         15K+SdbxVUmZ6Fv5yeidnFnLSVLqa0KZO4bi5XNch7X6OZCwSR36b/F30jAe8F2GFkan
         yDOkTQowb4YNKM/DPrYfLhHVUr2wyIQizoZORhwVDsOJDCHuHJgVm++otaPpTXusZT5u
         /QuCQO8XWNZpDscwFexmNtCWnhIgOnYFejMw6ZDDKPQj0tk6nNSyyk+AJJBShYpF78us
         f4yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=JDMokaVTYTVwlqCsIdJNDsu02GWjiO4qpEPRBz/Krgw=;
        b=AuLM0FKv24R5G5LKf7TyRBPE/0C78o3ykfYlKb9QYYKDjHutxMYWipBLU/LeRdTlFz
         7t/LnJlTGw4e7IoWuGDkK5SY7R6a64AUMt9cN9MWwIW+8BqkCTxwCkhtdp1F5T1xNmK1
         eiSAAH8pDf6yUDU707/UTiFCchSvc997SO1vaC/rqiXSGs/wxEF50VYim8a0GTwymETC
         AHKIx2zB8Jmh4Eu/oSZPgk7uY7keZ6cOZg77kxkkrWHWzqpl8jE1xqEI3n08CM8/MmlX
         T/Bpx4oG1fLmacdll7SxWWcc5Q1VJzzehf2LmBwDZcdveM93omSEclXor1uRok9Mjxfg
         8Yrw==
X-Gm-Message-State: AOAM531kJr38+nRf16zp0z+qEWT8Kg7hAHCmJxmFdMpyY8DzvrND0p2s
        ZdYBz9oeZXI0e5cTdCSpjcc=
X-Google-Smtp-Source: ABdhPJzyeCsxnUMeXraAM5OttbwD8fA6M7FYUhMClHOH1R+Q8G9pjRD1jLxyXN+2XFWb1YKHn+3fJw==
X-Received: by 2002:a65:58cc:: with SMTP id e12mr30542117pgu.59.1639040292532;
        Thu, 09 Dec 2021 00:58:12 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id n15sm5008881pgs.59.2021.12.09.00.58.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Dec 2021 00:58:12 -0800 (PST)
From:   Tony Huang <tonyhuang.sunplus@gmail.com>
To:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, derek.kiernan@xilinx.com,
        dragan.cvetic@xilinx.com, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     wells.lu@sunplus.com, tony.huang@sunplus.com,
        Tony Huang <tonyhuang.sunplus@gmail.com>
Subject: [PATCH v3 2/2] misc: Add iop driver for Sunplus SP7021
Date:   Thu,  9 Dec 2021 16:58:09 +0800
Message-Id: <bc15d5e8d7a5ec96582799fe513de4ace6fd4b8b.1639039163.git.tonyhuang.sunplus@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1639039163.git.tonyhuang.sunplus@gmail.com>
References: <cover.1639039163.git.tonyhuang.sunplus@gmail.com>
In-Reply-To: <cover.1639039163.git.tonyhuang.sunplus@gmail.com>
References: <cover.1639039163.git.tonyhuang.sunplus@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IOP (IO Processor) embedded inside SP7021 which is used as
Processor for I/O control, RTC wake-up and cooperation with
CPU & PMC in power management purpose.
The IOP core is DQ8051, so also named IOP8051,
it supports dedicated JTAG debug pins which share with SP7021.
In standby mode operation, the power spec reach 400uA.

Signed-off-by: Tony Huang <tonyhuang.sunplus@gmail.com>
---
Changes in v3:
 - Addressed comments from Arnd Bergmann.
 - Addressed comments from Greg KH.
 - Addressed comments from kernel test robot.

 MAINTAINERS                |   1 +
 drivers/misc/Kconfig       |  12 ++
 drivers/misc/Makefile      |   1 +
 drivers/misc/sunplus_iop.c | 395 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 409 insertions(+)
 create mode 100644 drivers/misc/sunplus_iop.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 071b5e6..a763088 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17949,6 +17949,7 @@ SUNPLUS IOP DRIVER
 M:	Tony Huang <tonyhuang.sunplus@gmail.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/misc/sunplu-iop.yaml
+F:	drivers/misc/sunplus_iop.c
 
 SUPERH
 M:	Yoshinori Sato <ysato@users.sourceforge.jp>
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 0f5a49f..f19533b 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -470,6 +470,18 @@ config HISI_HIKEY_USB
 	  switching between the dual-role USB-C port and the USB-A host ports
 	  using only one USB controller.
 
+config SUNPLUS_IOP
+	tristate "Sunplus IOP support"
+	default ARCH_SUNPLUS
+	help
+	  Sunplus I/O processor (8051) driver.
+	  Processor for I/O control, RTC wake-up proceduce management,
+	  and cooperation with CPU&PMC in power management.
+	  Need Install DQ8051, The DQ8051 bin file generated by keil C.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called ad525x_dpot.
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
index 0000000..92ec0e9
--- /dev/null
+++ b/drivers/misc/sunplus_iop.c
@@ -0,0 +1,395 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/module.h>
+#include <linux/miscdevice.h>
+#include <linux/of_platform.h>
+#include <linux/firmware.h>
+#include <linux/dma-mapping.h>
+#include <linux/of_address.h>
+#include <linux/delay.h>
+
+enum IOP_Status_e {
+	IOP_SUCCESS,                /* successful */
+	IOP_ERR_IOP_BUSY,           /* IOP is busy */
+};
+
+struct regs_moon0 {
+	u32 stamp;         /* 00 */
+	u32 clken[10];     /* 01~10 */
+	u32 gclken[10];    /* 11~20 */
+	u32 reset[10];     /* 21~30 */
+	u32 sfg_cfg_mode;  /* 31 */
+};
+
+struct regs_iop {
+	u32 iop_control;/* 00 */
+	u32 iop_reg1;/* 01 */
+	u32 iop_bp;/* 02 */
+	u32 iop_regsel;/* 03 */
+	u32 iop_regout;/* 04 */
+	u32 iop_reg5;/* 05 */
+	u32 iop_resume_pcl;/* 06 */
+	u32 iop_resume_pch;/* 07 */
+	u32 iop_data0;/* 08 */
+	u32 iop_data1;/* 09 */
+	u32 iop_data2;/* 10 */
+	u32 iop_data3;/* 11 */
+	u32 iop_data4;/* 12 */
+	u32 iop_data5;/* 13 */
+	u32 iop_data6;/* 14 */
+	u32 iop_data7;/* 15 */
+	u32 iop_data8;/* 16 */
+	u32 iop_data9;/* 17 */
+	u32 iop_data10;/* 18 */
+	u32 iop_data11;/* 19 */
+	u32 iop_base_adr_l;/* 20 */
+	u32 iop_base_adr_h;/* 21 */
+	u32 Memory_bridge_control;/* 22 */
+	u32 iop_regmap_adr_l;/* 23 */
+	u32 iop_regmap_adr_h;/* 24 */
+	u32 iop_direct_adr;/* 25*/
+	u32 reserved[6];/* 26~31 */
+};
+
+struct regs_iop_pmc {
+	u32 PMC_TIMER;/* 00 */
+	u32 PMC_CTRL;/* 01 */
+	u32 XTAL27M_PASSWORD_I;/* 02 */
+	u32 XTAL27M_PASSWORD_II;/* 03 */
+	u32 XTAL32K_PASSWORD_I;/* 04 */
+	u32 XTAL32K_PASSWORD_II;/* 05 */
+	u32 CLK27M_PASSWORD_I;/* 06 */
+	u32 CLK27M_PASSWORD_II;/* 07 */
+	u32 PMC_TIMER2;/* 08 */
+	u32 reserved[23];/* 9~31 */
+};
+
+#define NORMAL_CODE_MAX_SIZE 0X1000
+#define STANDBY_CODE_MAX_SIZE 0x4000
+struct sp_iop {
+	struct miscdevice dev;			// iop device
+	struct mutex write_lock;
+	void __iomem *iop_regs;
+	void __iomem *pmc_regs;
+	void __iomem *moon0_regs;
+	int irq;
+	unsigned char iop_normal_code[NORMAL_CODE_MAX_SIZE];
+	unsigned char iop_standby_code[STANDBY_CODE_MAX_SIZE];
+	resource_size_t iop_mem_start;
+	resource_size_t iop_mem_size;
+};
+
+static void sp_iop_normal_mode(struct sp_iop *iop)
+{
+	struct regs_iop *p_iop_reg = (struct regs_iop *)iop->iop_regs;
+	struct regs_moon0 *p_moon0_reg = (struct regs_moon0 *)iop->moon0_regs;
+	void __iomem *iop_kernel_base;
+	unsigned int reg;
+
+	iop_kernel_base = ioremap(iop->iop_mem_start, NORMAL_CODE_MAX_SIZE);
+	memset(iop_kernel_base, 0, NORMAL_CODE_MAX_SIZE);
+	memcpy(iop_kernel_base, iop->iop_normal_code, NORMAL_CODE_MAX_SIZE);
+
+	writel(0x00100010, &p_moon0_reg->clken[0]);
+
+	reg = readl(&p_iop_reg->iop_control);
+	reg |= 0x01;
+	writel(reg, &p_iop_reg->iop_control);
+
+	reg = readl(&p_iop_reg->iop_control);
+	reg &= ~(0x8000);
+	writel(reg, &p_iop_reg->iop_control);
+
+	reg = readl(&p_iop_reg->iop_control);
+	reg |= 0x0200;//disable watchdog event reset IOP
+	writel(reg, &p_iop_reg->iop_control);
+
+	reg = (iop->iop_mem_start & 0xFFFF);
+	writel(reg, &p_iop_reg->iop_base_adr_l);
+	reg	= (iop->iop_mem_start >> 16);
+	writel(reg, &p_iop_reg->iop_base_adr_h);
+
+	reg = readl(&p_iop_reg->iop_control);
+	reg &= ~(0x01);
+	writel(reg, &p_iop_reg->iop_control);
+}
+
+static void sp_iop_standby_mode(struct sp_iop *iop)
+{
+	struct regs_iop *p_iop_reg = (struct regs_iop *)iop->iop_regs;
+	struct regs_moon0 *p_moon0_reg = (struct regs_moon0 *)iop->moon0_regs;
+	void __iomem *iop_kernel_base;
+	unsigned long reg;
+
+	iop_kernel_base = ioremap(iop->iop_mem_start, STANDBY_CODE_MAX_SIZE);
+	memset(iop_kernel_base, 0, STANDBY_CODE_MAX_SIZE);
+	memcpy(iop_kernel_base, iop->iop_standby_code, STANDBY_CODE_MAX_SIZE);
+
+	writel(0x00100010, &p_moon0_reg->clken[0]);
+
+	reg = readl(&p_iop_reg->iop_control);
+	reg |= 0x01;
+	writel(reg, &p_iop_reg->iop_control);
+
+	reg = readl(&p_iop_reg->iop_control);
+	reg &= ~(0x8000);
+	writel(reg, &p_iop_reg->iop_control);
+
+	reg = readl(&p_iop_reg->iop_control);
+	reg |= 0x0200;//disable watchdog event reset IOP
+	writel(reg, &p_iop_reg->iop_control);
+
+	reg = (iop->iop_mem_start & 0xFFFF);
+	writel(reg, &p_iop_reg->iop_base_adr_l);
+	reg = (iop->iop_mem_start >> 16);
+	writel(reg, &p_iop_reg->iop_base_adr_h);
+
+	reg = readl(&p_iop_reg->iop_control);
+	reg &= ~(0x01);
+	writel(reg, &p_iop_reg->iop_control);
+}
+
+#define IOP_READY	0x4
+#define RISC_READY	0x8
+static void sp_iop_shutdown(struct sp_iop *iop)
+{
+	struct regs_iop *p_iop_reg = (struct regs_iop *)iop->iop_regs;
+	struct regs_moon0 *p_moon0_reg = (struct regs_moon0 *)iop->moon0_regs;
+	struct regs_iop_pmc *p_iop_pmc_reg = (struct regs_iop_pmc *)iop->pmc_regs;
+	unsigned int reg;
+
+	writel(0x00100010, &p_moon0_reg->clken[0]);
+
+	reg = readl(&p_iop_reg->iop_control);
+	reg &= ~(0x8000);
+	writel(reg, &p_iop_reg->iop_control);
+
+	reg = readl(&p_iop_reg->iop_control);
+	reg |= 0x1;
+	writel(reg, &p_iop_reg->iop_control);
+
+	//PMC set
+	writel(0x00010001, &p_iop_pmc_reg->PMC_TIMER);
+	reg = readl(&p_iop_pmc_reg->PMC_CTRL);
+	reg |= 0x23;// disable system reset PMC, enalbe power down 27M, enable gating 27M
+	writel(reg, &p_iop_pmc_reg->PMC_CTRL);
+
+	writel(0x55aa00ff, &p_iop_pmc_reg->XTAL27M_PASSWORD_I);
+	writel(0x00ff55aa, &p_iop_pmc_reg->XTAL27M_PASSWORD_II);
+	writel(0xaa00ff55, &p_iop_pmc_reg->XTAL32K_PASSWORD_I);
+	writel(0xff55aa00, &p_iop_pmc_reg->XTAL32K_PASSWORD_II);
+	writel(0xaaff0055, &p_iop_pmc_reg->CLK27M_PASSWORD_I);
+	writel(0x5500aaff, &p_iop_pmc_reg->CLK27M_PASSWORD_II);
+	writel(0x01000100, &p_iop_pmc_reg->PMC_TIMER2);
+
+	//IOP Hardware IP reset
+	reg = readl(&p_moon0_reg->reset[0]);
+	reg |= 0x10;
+	writel(reg, (&p_moon0_reg->reset[0]));
+	reg &= ~(0x10);
+	writel(reg, (&p_moon0_reg->reset[0]));
+
+	writel(0x00ff0085, (iop->moon0_regs + 32*4*1 + 4*1));
+
+	reg = readl(iop->moon0_regs + 32*4*1 + 4*2);
+	reg |= 0x08000800;
+	writel(reg, (iop->moon0_regs + 32*4*1 + 4*2));
+
+	reg = readl(&p_iop_reg->iop_control);
+	reg |= 0x0200;//disable watchdog event reset IOP
+	writel(reg, &p_iop_reg->iop_control);
+
+	reg = (iop->iop_mem_start & 0xFFFF);
+	writel(reg, &p_iop_reg->iop_base_adr_l);
+	reg = (iop->iop_mem_start >> 16);
+	writel(reg, &p_iop_reg->iop_base_adr_h);
+
+	reg = readl(&p_iop_reg->iop_control);
+	reg &= ~(0x01);
+	writel(reg, &p_iop_reg->iop_control);
+	while ((p_iop_reg->iop_data2&IOP_READY) != IOP_READY)
+		;
+
+	writel(RISC_READY, &p_iop_reg->iop_data2);
+	writel(0x00, &p_iop_reg->iop_data5);
+	writel(0x60, &p_iop_reg->iop_data6);
+	while (1) {
+		if (p_iop_reg->iop_data7 == 0xaaaa)
+			break;
+	}
+
+	writel(0xdd, &p_iop_reg->iop_data1);//8051 bin file call Ultra low function.
+	mdelay(10);
+}
+
+static int  sp_iop_get_normal_code(struct device *dev, struct sp_iop *iop)
+{
+	const struct firmware *fw;
+	static const char file[] = "normal.bin";
+	unsigned int err, i;
+
+	dev_info(dev, "normal code\n");
+	err = request_firmware(&fw, file, dev);
+	if (err) {
+		dev_info(dev, "get bin file error\n");
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
+	dev_info(dev, "standby code\n");
+	err = request_firmware(&fw, file, dev);
+	if (err) {
+		dev_info(dev, "get bin file error\n");
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
+static int sp_iop_get_resources(struct platform_device *pdev,
+	struct sp_iop *pstSpIOPInfo)
+{
+	struct resource *r;
+
+	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "iop");
+	pstSpIOPInfo->iop_regs = devm_ioremap_resource(&pdev->dev, r);
+	if (IS_ERR(pstSpIOPInfo->iop_regs)) {
+		dev_err(&pdev->dev, "ioremap fail\n");
+		return PTR_ERR(pstSpIOPInfo->iop_regs);
+	}
+
+	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "iop_pmc");
+	pstSpIOPInfo->pmc_regs = devm_ioremap_resource(&pdev->dev, r);
+	if (IS_ERR(pstSpIOPInfo->pmc_regs)) {
+		dev_err(&pdev->dev, "ioremap fail\n");
+		return PTR_ERR(pstSpIOPInfo->pmc_regs);
+	}
+
+	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "moon0");
+	pstSpIOPInfo->moon0_regs = devm_ioremap_resource(&pdev->dev, r);
+	if (IS_ERR(pstSpIOPInfo->moon0_regs)) {
+		dev_err(&pdev->dev, "ioremap fail\n");
+		return PTR_ERR(pstSpIOPInfo->moon0_regs);
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
+	if (iop == NULL) {
+		ret	= -ENOMEM;
+		goto fail_kmalloc;
+	}
+	/* init */
+	mutex_init(&iop->write_lock);
+	/* register device */
+	iop->dev.name  = "sp_iop";
+	iop->dev.minor = MISC_DYNAMIC_MINOR;
+	ret = misc_register(&iop->dev);
+	if (ret != 0) {
+		dev_err(&pdev->dev, "sp_iop device register fail\n");
+		goto fail_regdev;
+	}
+
+	ret = sp_iop_get_resources(pdev, iop);
+
+	//Get reserve address
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
+	return 0;
+
+fail_regdev:
+	mutex_destroy(&iop->write_lock);
+fail_kmalloc:
+	return ret;
+
+
+}
+
+static void sp_iop_platform_driver_shutdown(struct platform_device *pdev)
+{
+	struct sp_iop *iop = platform_get_drvdata(pdev);
+
+	sp_iop_standby_mode(iop);
+	sp_iop_shutdown(iop);
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
+		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(sp_iop_of_match),
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


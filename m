Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C71CA4670E3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 04:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378406AbhLCDwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 22:52:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378370AbhLCDwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 22:52:42 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC97C06174A;
        Thu,  2 Dec 2021 19:49:18 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id z6so1186968plk.6;
        Thu, 02 Dec 2021 19:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Z1vZ1oN4igE0FhgyVYA4eN06H9A+ehVYHEXfRlQOIOA=;
        b=evc7EdEcHuck5c4A81l2S/V0nrbsfjvMUFXrQcf4C+4dLW78Trsn6eULT3/9uo0xeA
         ITngCBt9phaXRZ6gtXV30s6DOI37iP1hEf0dPOsKhlGZ4abr6VxRFwOf9/s8kLLqawEC
         KY2hi3PA8JRlV8Jl+ecy/yRelczXBwLEEqNmvK4K/9YkHEnslu9GHIXeAsEoqZuSv1x+
         M4bmjh+zIIoagW78S3dagOvM3KRtkcF7yB7fSGkDcoJmkdP1kZJmtc+5ETmpB1Hstx1u
         KHtml3AZM3gOA+XuxQo8s/k/7jTPoyXIgI8mdtcOX0foLkcxBzy4ZhSvlG62/n13gYKO
         MJhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Z1vZ1oN4igE0FhgyVYA4eN06H9A+ehVYHEXfRlQOIOA=;
        b=mzgSZ/N04iJ/QYPq/fxY006Z2WmeW+9B6RUCw2ocIqdIFhWh2cJd8F1OiGT/P7GqUh
         1hJJbSCALJs+gjaxKvzz4RT/Y1azFFejKJxfGi5bVyCXrs8b1Eub3pZe/GJVdDAp8u66
         A0vaSs2mUHD67CQg78Gf3l88bPF5+MZ2AGaGpiZPEWecth5QyzchtX4wPRazEB8ffSHV
         Qj+lXBNU+piJOgwD+3RsdhPQ/RsI5S7fh3s48jG7k6JWQIUkYvdAYnO3KLFJUzCVhNdW
         pf0iK+G+gpJmfClv0ZOgFTqZRmVSI2rBgpUUm7enqImuBYKSPHT0IDJEa1cHGPL/SXai
         l43w==
X-Gm-Message-State: AOAM530I+Vi2VbucNnqBR7XlFToXg8d8TXnyhcigj7cFSoywNMr1/Q9r
        zN3gIBsoMf1IZm0qZ3HMRAnziDEKssY=
X-Google-Smtp-Source: ABdhPJxzh2ivQD4fljboh8CxwlC7sJa7kzGg+7fs5A2rg3XzrypDuRHLVYxknjnXbGh8TPXMUc+1bw==
X-Received: by 2002:a17:902:e548:b0:141:f4ae:d2bd with SMTP id n8-20020a170902e54800b00141f4aed2bdmr20167792plf.41.1638503357913;
        Thu, 02 Dec 2021 19:49:17 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id oj11sm4022039pjb.46.2021.12.02.19.49.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Dec 2021 19:49:17 -0800 (PST)
From:   Tony Huang <tonyhuang.sunplus@gmail.com>
To:     derek.kiernan@xilinx.com, dragan.cvetic@xilinx.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Cc:     wells.lu@sunplus.com, tony.huang@sunplus.com,
        Tony Huang <tonyhuang.sunplus@gmail.com>
Subject: [PATCH v2 2/2] misc: Add iop driver for Sunplus SP7021
Date:   Fri,  3 Dec 2021 11:48:45 +0800
Message-Id: <9bb79f74ff1b08a5f9a1f6707b3b41484506468a.1638499659.git.tonyhuang.sunplus@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1638499659.git.tonyhuang.sunplus@gmail.com>
References: <cover.1638499659.git.tonyhuang.sunplus@gmail.com>
In-Reply-To: <cover.1638499659.git.tonyhuang.sunplus@gmail.com>
References: <cover.1638499659.git.tonyhuang.sunplus@gmail.com>
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
Changes in v2:
 - Addressed comments from Arnd Bergmann.
 - Addressed comments from Greg KH.
 - Addressed comments from kernel test robot.

 MAINTAINERS                    |   1 +
 drivers/misc/Kconfig           |   1 +
 drivers/misc/Makefile          |   1 +
 drivers/misc/iop/Kconfig       |  13 ++
 drivers/misc/iop/Makefile      |   6 +
 drivers/misc/iop/sunplus_iop.c | 518 +++++++++++++++++++++++++++++++++++++++++
 drivers/misc/iop/sunplus_iop.h |  64 +++++
 7 files changed, 604 insertions(+)
 create mode 100644 drivers/misc/iop/Kconfig
 create mode 100644 drivers/misc/iop/Makefile
 create mode 100644 drivers/misc/iop/sunplus_iop.c
 create mode 100644 drivers/misc/iop/sunplus_iop.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 071b5e6..f14aa19 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17949,6 +17949,7 @@ SUNPLUS IOP DRIVER
 M:	Tony Huang <tonyhuang.sunplus@gmail.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/misc/sunplu-iop.yaml
+F:	drivers/misc/iop
 
 SUPERH
 M:	Yoshinori Sato <ysato@users.sourceforge.jp>
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 0f5a49f..8fbd9a6 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -481,6 +481,7 @@ source "drivers/misc/vmw_vmci/Kconfig"
 source "drivers/misc/genwqe/Kconfig"
 source "drivers/misc/echo/Kconfig"
 source "drivers/misc/cxl/Kconfig"
+source "drivers/misc/iop/Kconfig"
 source "drivers/misc/ocxl/Kconfig"
 source "drivers/misc/bcm-vk/Kconfig"
 source "drivers/misc/cardreader/Kconfig"
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index a086197..5ab7fb0 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -52,6 +52,7 @@ obj-$(CONFIG_DW_XDATA_PCIE)	+= dw-xdata-pcie.o
 obj-$(CONFIG_PCI_ENDPOINT_TEST)	+= pci_endpoint_test.o
 obj-$(CONFIG_OCXL)		+= ocxl/
 obj-$(CONFIG_BCM_VK)		+= bcm-vk/
+obj-$(CONFIG_SUNPLUS_IOP)	+= iop/
 obj-y				+= cardreader/
 obj-$(CONFIG_PVPANIC)   	+= pvpanic/
 obj-$(CONFIG_HABANA_AI)		+= habanalabs/
diff --git a/drivers/misc/iop/Kconfig b/drivers/misc/iop/Kconfig
new file mode 100644
index 0000000..3afda5c
--- /dev/null
+++ b/drivers/misc/iop/Kconfig
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# IOP configuration
+#
+
+config SUNPLUS_IOP
+	tristate "Sunplus IOP support"
+	default ARCH_SUNPLUS
+	help
+	  Sunplus I/O processor (8051) driver.
+	  Processor for I/O control, RTC wake-up proceduce management,
+	  and cooperation with CPU&PMC in power management.
+	  Need Install DQ8051, The DQ8051 bin file generated by keil C.
\ No newline at end of file
diff --git a/drivers/misc/iop/Makefile b/drivers/misc/iop/Makefile
new file mode 100644
index 0000000..e44b021
--- /dev/null
+++ b/drivers/misc/iop/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Makefile for the IOP module drivers.
+#
+
+obj-$(CONFIG_SUNPLUS_IOP) += sunplus_iop.o
diff --git a/drivers/misc/iop/sunplus_iop.c b/drivers/misc/iop/sunplus_iop.c
new file mode 100644
index 0000000..bb8d0da
--- /dev/null
+++ b/drivers/misc/iop/sunplus_iop.c
@@ -0,0 +1,518 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/module.h>
+#include <linux/miscdevice.h>
+#include <linux/of_platform.h>
+#include <linux/firmware.h>
+#include <linux/dma-mapping.h>
+#include <linux/of_address.h>
+#include <linux/delay.h>
+#include "sunplus_iop.h"
+
+#define NORMAL_CODE_MAX_SIZE 0X1000
+#define STANDBY_CODE_MAX_SIZE 0x4000
+unsigned char iop_normal_code[NORMAL_CODE_MAX_SIZE];
+unsigned char iop_standby_code[STANDBY_CODE_MAX_SIZE];
+/* ---------------------------------------------------------------------------------------------- */
+resource_size_t SP_IOP_RESERVE_BASE;
+resource_size_t SP_IOP_RESERVE_SIZE;
+/* ---------------------------------------------------------------------------------------------- */
+struct sp_iop {
+	struct miscdevice dev;			// iop device
+	struct mutex write_lock;
+	void __iomem *iop_regs;
+	void __iomem *pmc_regs;
+	void __iomem *moon0_regs;
+	int irq;
+};
+/*****************************************************************
+ *						  G L O B A L	 D A T A
+ ******************************************************************/
+static struct sp_iop *iop;
+
+void iop_normal_mode(void)
+{
+	struct regs_iop *p_iop_reg = (struct regs_iop *)iop->iop_regs;
+	struct regs_moon0 *p_moon0_reg = (struct regs_moon0 *)iop->moon0_regs;
+	void __iomem *iop_kernel_base;
+	unsigned int reg;
+
+	iop_kernel_base = ioremap(SP_IOP_RESERVE_BASE, NORMAL_CODE_MAX_SIZE);
+	memset(iop_kernel_base, 0, NORMAL_CODE_MAX_SIZE);
+	memcpy(iop_kernel_base, iop_normal_code, NORMAL_CODE_MAX_SIZE);
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
+	reg = (SP_IOP_RESERVE_BASE & 0xFFFF);
+	writel(reg, &p_iop_reg->iop_base_adr_l);
+	reg	= (SP_IOP_RESERVE_BASE >> 16);
+	writel(reg, &p_iop_reg->iop_base_adr_h);
+
+	reg = readl(&p_iop_reg->iop_control);
+	reg &= ~(0x01);
+	writel(reg, &p_iop_reg->iop_control);
+}
+
+void iop_standby_mode(void)
+{
+	struct regs_iop *p_iop_reg = (struct regs_iop *)iop->iop_regs;
+	struct regs_moon0 *p_moon0_reg = (struct regs_moon0 *)iop->moon0_regs;
+	void __iomem *iop_kernel_base;
+	unsigned long reg;
+
+	iop_kernel_base = ioremap(SP_IOP_RESERVE_BASE, STANDBY_CODE_MAX_SIZE);
+	memset(iop_kernel_base, 0, STANDBY_CODE_MAX_SIZE);
+	memcpy(iop_kernel_base, iop_standby_code, STANDBY_CODE_MAX_SIZE);
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
+	reg = (SP_IOP_RESERVE_BASE & 0xFFFF);
+	writel(reg, &p_iop_reg->iop_base_adr_l);
+	reg = (SP_IOP_RESERVE_BASE >> 16);
+	writel(reg, &p_iop_reg->iop_base_adr_h);
+
+	reg = readl(&p_iop_reg->iop_control);
+	reg &= ~(0x01);
+	writel(reg, &p_iop_reg->iop_control);
+}
+
+void get_iop_data(struct device *dev)
+{
+	struct regs_iop *p_iop_reg = (struct regs_iop *)iop->iop_regs;
+	unsigned short value_0, value_1, value_2, value_3, value_4, value_5;
+	unsigned short value_6, value_7, value_8, value_9, value_10, value_11;
+
+	value_0 = readl(&p_iop_reg->iop_data0);
+	value_1 = readl(&p_iop_reg->iop_data1);
+	value_2 = readl(&p_iop_reg->iop_data2);
+	value_3 = readl(&p_iop_reg->iop_data3);
+	value_4 = readl(&p_iop_reg->iop_data4);
+	value_5 = readl(&p_iop_reg->iop_data5);
+	value_6 = readl(&p_iop_reg->iop_data6);
+	value_7 = readl(&p_iop_reg->iop_data7);
+	value_8 = readl(&p_iop_reg->iop_data8);
+	value_9 = readl(&p_iop_reg->iop_data9);
+	value_10 = readl(&p_iop_reg->iop_data10);
+	value_11 = readl(&p_iop_reg->iop_data11);
+	dev_info(dev, "%s(%d) iop_data0=%x iop_data1=%x iop_data2=%x iop_data3=%x\n",
+		__func__, __LINE__, value_0, value_1, value_2, value_3);
+	dev_info(dev, "%s(%d) iop_data4=%x iop_data5=%x iop_data6=%x iop_data7=%x\n",
+		__func__, __LINE__, value_4, value_5, value_6, value_7);
+	dev_info(dev, "%s(%d) iop_data8=%x iop_data9=%x iop_data10=%x iop_data11=%x\n",
+		__func__, __LINE__, value_8, value_9, value_10, value_11);
+}
+
+#define IOP_READY	0x4
+#define RISC_READY	0x8
+void iop_suspend(void)
+{
+	struct regs_iop *p_iop_reg = (struct regs_iop *)iop->iop_regs;
+	struct regs_moon0 *p_moon0_reg = (struct regs_moon0 *)iop->moon0_regs;
+	struct regs_iop_pmc *p_iop_pmc_reg = (struct regs_iop_pmc *)iop->pmc_regs;
+	unsigned long reg;
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
+	reg = (SP_IOP_RESERVE_BASE & 0xFFFF);
+	writel(reg, &p_iop_reg->iop_base_adr_l);
+	reg = (SP_IOP_RESERVE_BASE >> 16);
+	writel(reg, &p_iop_reg->iop_base_adr_h);
+
+	reg = readl(&p_iop_reg->iop_control);
+	reg &= ~(0x01);
+	writel(reg, &p_iop_reg->iop_control);
+
+	while ((p_iop_reg->iop_data2&IOP_READY) != IOP_READY)
+		;
+
+	reg = readl(&p_iop_reg->iop_data2);
+	reg |= RISC_READY;
+	writel(reg, &p_iop_reg->iop_control);
+
+	writel(0x00, &p_iop_reg->iop_data5);
+	writel(0x60, &p_iop_reg->iop_data6);
+
+	while (1) {
+		if (p_iop_reg->iop_data7 == 0xaaaa)
+			break;
+	}
+
+	writel(0xdd, &p_iop_reg->iop_data1);//8051 bin file call Ultra low function.
+}
+
+void iop_shutdown(void)
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
+	reg = (SP_IOP_RESERVE_BASE & 0xFFFF);
+	writel(reg, &p_iop_reg->iop_base_adr_l);
+	reg = (SP_IOP_RESERVE_BASE >> 16);
+	writel(reg, &p_iop_reg->iop_base_adr_h);
+
+	reg = readl(&p_iop_reg->iop_control);
+	reg &= ~(0x01);
+	writel(reg, &p_iop_reg->iop_control);
+
+	while ((p_iop_reg->iop_data2&IOP_READY) != IOP_READY)
+		;
+
+	writel(RISC_READY, &p_iop_reg->iop_data2);
+	writel(0x00, &p_iop_reg->iop_data5);
+	writel(0x60, &p_iop_reg->iop_data6);
+
+	while (1) {
+		if (p_iop_reg->iop_data7 == 0xaaaa)
+			break;
+	}
+
+	writel(0xdd, &p_iop_reg->iop_data1);//8051 bin file call Ultra low function.
+	mdelay(10);
+}
+
+void iop_s1mode(void)
+{
+	struct regs_iop *p_iop_reg = (struct regs_iop *)iop->iop_regs;
+
+	while ((p_iop_reg->iop_data2&IOP_READY) != IOP_READY)
+		;
+
+	writel(RISC_READY, &p_iop_reg->iop_data2);
+	writel(0x00, &p_iop_reg->iop_data5);
+	writel(0x60, &p_iop_reg->iop_data6);
+
+	while (1) {
+		if (p_iop_reg->iop_data7 == 0xaaaa)
+			break;
+	}
+
+	writel(0xee, &p_iop_reg->iop_data1);//8051 bin file call S1_mode function.
+}
+
+static int  get_normal_code(struct device *dev)
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
+		iop_normal_code[i] = temp;
+	}
+	release_firmware(fw);
+	return err;
+}
+
+static int  get_standby_code(struct device *dev)
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
+		iop_standby_code[i] = temp;
+	}
+	release_firmware(fw);
+	return err;
+}
+
+static int sp_iop_open(struct inode *inode, struct file *pfile)
+{
+	return 0;
+}
+
+static ssize_t sp_iop_read(struct file *pfile, char __user *ubuf,
+			size_t length, loff_t *offset)
+{
+	return 0;
+}
+
+static ssize_t sp_iop_write(struct file *pfile, const char __user *ubuf,
+	size_t length, loff_t *offset)
+{
+	return 0;
+}
+
+static int sp_iop_release(struct inode *inode, struct file *pfile)
+{
+	//dev_dbg(iop->dev, "Sunplus IOP module release\n");
+	return 0;
+}
+
+static const struct file_operations sp_iop_fops = {
+	.owner			= THIS_MODULE,
+	.open			= sp_iop_open,
+	.read			= sp_iop_read,
+	.write			= sp_iop_write,
+	.release		= sp_iop_release,
+};
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
+	iop->dev.fops  = &sp_iop_fops;
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
+	SP_IOP_RESERVE_BASE = mem_res.start;
+	SP_IOP_RESERVE_SIZE = resource_size(&mem_res);
+
+	ret = get_normal_code(&pdev->dev);
+	if (ret != 0) {
+		dev_err(&pdev->dev, "get normal code err=%d\n", ret);
+		return ret;
+	}
+
+	ret = get_standby_code(&pdev->dev);
+	if (ret != 0) {
+		dev_err(&pdev->dev, "get standby code err=%d\n", ret);
+		return ret;
+	}
+
+	iop_normal_mode();
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
+static int sp_iop_platform_driver_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static int sp_iop_platform_driver_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	return 0;
+}
+
+static void sp_iop_platform_driver_shutdown(struct platform_device *pdev)
+{
+
+}
+
+void sp_iop_platform_driver_poweroff(void)
+{
+	iop_standby_mode();
+	iop_shutdown();
+}
+
+static int sp_iop_platform_driver_resume(struct platform_device *pdev)
+{
+	return 0;
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
+	.remove		= sp_iop_platform_driver_remove,
+	.suspend	= sp_iop_platform_driver_suspend,
+	.shutdown	= sp_iop_platform_driver_shutdown,
+	.resume		= sp_iop_platform_driver_resume,
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
diff --git a/drivers/misc/iop/sunplus_iop.h b/drivers/misc/iop/sunplus_iop.h
new file mode 100644
index 0000000..fcbfd26
--- /dev/null
+++ b/drivers/misc/iop/sunplus_iop.h
@@ -0,0 +1,64 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later*/
+
+#ifndef __SP_IOP_H__
+#define __SP_IOP_H__
+#include <mach/io_map.h>
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
+void sp_iop_platform_driver_poweroff(void);
+#endif /* __SP_IOP_H__ */
-- 
2.7.4


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC564ADCFA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 16:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381128AbiBHPji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 10:39:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235375AbiBHPjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 10:39:37 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3825BC061576;
        Tue,  8 Feb 2022 07:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644334776; x=1675870776;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YbdERDJc5UB1zLLc2+g4eFef/7Js64HsYIopjEnSOIA=;
  b=mS0T4BLcFqyspo+Jte1Bhv5M5GllMdwzhgm1BxL2i3hsXfJGKCYNTD+c
   j1S+OYE4zEF1ViuUQTgzlQj+ryTRblTfbQR2xQ2XWTzoIguW4BdVU+6/S
   PNGQH8LbDgK8rIc0vB34DRs/KrbKxf+sNP8ukkloSQdiYiMCCQjNQQ7wV
   +w50HDpaWbZZpo2QMSuuF00PxHj0SZEGsMwnOFPIiYhEy4s+DndwOM2/l
   BbQ9pJao0iATsog/WN15KRWTxBxznBA8MPXEp0ig+hgc0DhDL0uFeMvax
   ULUku802dhSYxVOEkC091YBpiYTrupovRIFrKgkFTHFcjpZLyCX6Jt06A
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="273502669"
X-IronPort-AV: E=Sophos;i="5.88,353,1635231600"; 
   d="scan'208";a="273502669"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 07:39:35 -0800
X-IronPort-AV: E=Sophos;i="5.88,353,1635231600"; 
   d="scan'208";a="621936407"
Received: from mgorzkow-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.139.232])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 07:39:28 -0800
From:   Iwona Winiarska <iwona.winiarska@intel.com>
To:     linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Borislav Petkov <bp@alien8.de>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Zev Weiss <zweiss@equinix.com>,
        David Muller <d.mueller@elsoft.ch>,
        Dave Hansen <dave.hansen@intel.com>,
        Billy Tsai <billy_tsai@aspeedtech.com>,
        Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>,
        Iwona Winiarska <iwona.winiarska@intel.com>
Subject: [PATCH v8 05/13] peci: Add peci-aspeed controller driver
Date:   Tue,  8 Feb 2022 16:36:31 +0100
Message-Id: <20220208153639.255278-6-iwona.winiarska@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220208153639.255278-1-iwona.winiarska@intel.com>
References: <20220208153639.255278-1-iwona.winiarska@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>

ASPEED AST24xx/AST25xx/AST26xx SoCs support the PECI electrical
interface (a.k.a PECI wire) that provides a communication channel with
Intel processors.
This driver allows BMC to discover devices connected to it and
communicate with them using PECI protocol.

Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Co-developed-by: Iwona Winiarska <iwona.winiarska@intel.com>
Signed-off-by: Iwona Winiarska <iwona.winiarska@intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Joel Stanley <joel@jms.id.au>
---
 MAINTAINERS                           |   8 +
 drivers/peci/Kconfig                  |   6 +
 drivers/peci/Makefile                 |   3 +
 drivers/peci/controller/Kconfig       |  18 +
 drivers/peci/controller/Makefile      |   3 +
 drivers/peci/controller/peci-aspeed.c | 599 ++++++++++++++++++++++++++
 6 files changed, 637 insertions(+)
 create mode 100644 drivers/peci/controller/Kconfig
 create mode 100644 drivers/peci/controller/Makefile
 create mode 100644 drivers/peci/controller/peci-aspeed.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 9dde5ea5576e..a63b106a09fb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2986,6 +2986,14 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/net/asix,ax88796c.yaml
 F:	drivers/net/ethernet/asix/ax88796c_*
 
+ASPEED PECI CONTROLLER
+M:	Iwona Winiarska <iwona.winiarska@intel.com>
+L:	linux-aspeed@lists.ozlabs.org (moderated for non-subscribers)
+L:	openbmc@lists.ozlabs.org (moderated for non-subscribers)
+S:	Supported
+F:	Documentation/devicetree/bindings/peci/peci-aspeed.yaml
+F:	drivers/peci/controller/peci-aspeed.c
+
 ASPEED PINCTRL DRIVERS
 M:	Andrew Jeffery <andrew@aj.id.au>
 L:	linux-aspeed@lists.ozlabs.org (moderated for non-subscribers)
diff --git a/drivers/peci/Kconfig b/drivers/peci/Kconfig
index 71a4ad81225a..99279df97a78 100644
--- a/drivers/peci/Kconfig
+++ b/drivers/peci/Kconfig
@@ -13,3 +13,9 @@ menuconfig PECI
 
 	  This support is also available as a module. If so, the module
 	  will be called peci.
+
+if PECI
+
+source "drivers/peci/controller/Kconfig"
+
+endif # PECI
diff --git a/drivers/peci/Makefile b/drivers/peci/Makefile
index e789a354e842..926d8df15cbd 100644
--- a/drivers/peci/Makefile
+++ b/drivers/peci/Makefile
@@ -3,3 +3,6 @@
 # Core functionality
 peci-y := core.o
 obj-$(CONFIG_PECI) += peci.o
+
+# Hardware specific bus drivers
+obj-y += controller/
diff --git a/drivers/peci/controller/Kconfig b/drivers/peci/controller/Kconfig
new file mode 100644
index 000000000000..2fc5e2abb74a
--- /dev/null
+++ b/drivers/peci/controller/Kconfig
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config PECI_ASPEED
+	tristate "ASPEED PECI support"
+	depends on ARCH_ASPEED || COMPILE_TEST
+	depends on OF
+	depends on HAS_IOMEM
+	depends on COMMON_CLK
+	help
+	  This option enables PECI controller driver for ASPEED AST2400,
+	  AST2500 and AST2600 SoCs. It allows BMC to discover devices
+	  connected to it, and communicate with them using PECI protocol.
+
+	  Say Y here if your system runs on ASPEED SoC and you are using it
+	  as BMC for Intel platform.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called peci-aspeed.
diff --git a/drivers/peci/controller/Makefile b/drivers/peci/controller/Makefile
new file mode 100644
index 000000000000..022c28ef1bf0
--- /dev/null
+++ b/drivers/peci/controller/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-$(CONFIG_PECI_ASPEED)	+= peci-aspeed.o
diff --git a/drivers/peci/controller/peci-aspeed.c b/drivers/peci/controller/peci-aspeed.c
new file mode 100644
index 000000000000..1925ddc13f00
--- /dev/null
+++ b/drivers/peci/controller/peci-aspeed.c
@@ -0,0 +1,599 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (c) 2012-2017 ASPEED Technology Inc.
+// Copyright (c) 2018-2021 Intel Corporation
+
+#include <asm/unaligned.h>
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/clkdev.h>
+#include <linux/clk-provider.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/jiffies.h>
+#include <linux/math.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/peci.h>
+#include <linux/platform_device.h>
+#include <linux/reset.h>
+
+/* ASPEED PECI Registers */
+/* Control Register */
+#define ASPEED_PECI_CTRL			0x00
+#define   ASPEED_PECI_CTRL_SAMPLING_MASK	GENMASK(19, 16)
+#define   ASPEED_PECI_CTRL_RD_MODE_MASK		GENMASK(13, 12)
+#define     ASPEED_PECI_CTRL_RD_MODE_DBG	BIT(13)
+#define     ASPEED_PECI_CTRL_RD_MODE_COUNT	BIT(12)
+#define   ASPEED_PECI_CTRL_CLK_SRC_HCLK		BIT(11)
+#define   ASPEED_PECI_CTRL_CLK_DIV_MASK		GENMASK(10, 8)
+#define   ASPEED_PECI_CTRL_INVERT_OUT		BIT(7)
+#define   ASPEED_PECI_CTRL_INVERT_IN		BIT(6)
+#define   ASPEED_PECI_CTRL_BUS_CONTENTION_EN	BIT(5)
+#define   ASPEED_PECI_CTRL_PECI_EN		BIT(4)
+#define   ASPEED_PECI_CTRL_PECI_CLK_EN		BIT(0)
+
+/* Timing Negotiation Register */
+#define ASPEED_PECI_TIMING_NEGOTIATION		0x04
+#define   ASPEED_PECI_T_NEGO_MSG_MASK		GENMASK(15, 8)
+#define   ASPEED_PECI_T_NEGO_ADDR_MASK		GENMASK(7, 0)
+
+/* Command Register */
+#define ASPEED_PECI_CMD				0x08
+#define   ASPEED_PECI_CMD_PIN_MONITORING	BIT(31)
+#define   ASPEED_PECI_CMD_STS_MASK		GENMASK(27, 24)
+#define     ASPEED_PECI_CMD_STS_ADDR_T_NEGO	0x3
+#define   ASPEED_PECI_CMD_IDLE_MASK		\
+	  (ASPEED_PECI_CMD_STS_MASK | ASPEED_PECI_CMD_PIN_MONITORING)
+#define   ASPEED_PECI_CMD_FIRE			BIT(0)
+
+/* Read/Write Length Register */
+#define ASPEED_PECI_RW_LENGTH			0x0c
+#define   ASPEED_PECI_AW_FCS_EN			BIT(31)
+#define   ASPEED_PECI_RD_LEN_MASK		GENMASK(23, 16)
+#define   ASPEED_PECI_WR_LEN_MASK		GENMASK(15, 8)
+#define   ASPEED_PECI_TARGET_ADDR_MASK		GENMASK(7, 0)
+
+/* Expected FCS Data Register */
+#define ASPEED_PECI_EXPECTED_FCS		0x10
+#define   ASPEED_PECI_EXPECTED_RD_FCS_MASK	GENMASK(23, 16)
+#define   ASPEED_PECI_EXPECTED_AW_FCS_AUTO_MASK	GENMASK(15, 8)
+#define   ASPEED_PECI_EXPECTED_WR_FCS_MASK	GENMASK(7, 0)
+
+/* Captured FCS Data Register */
+#define ASPEED_PECI_CAPTURED_FCS		0x14
+#define   ASPEED_PECI_CAPTURED_RD_FCS_MASK	GENMASK(23, 16)
+#define   ASPEED_PECI_CAPTURED_WR_FCS_MASK	GENMASK(7, 0)
+
+/* Interrupt Register */
+#define ASPEED_PECI_INT_CTRL			0x18
+#define   ASPEED_PECI_TIMING_NEGO_SEL_MASK	GENMASK(31, 30)
+#define     ASPEED_PECI_1ST_BIT_OF_ADDR_NEGO	0
+#define     ASPEED_PECI_2ND_BIT_OF_ADDR_NEGO	1
+#define     ASPEED_PECI_MESSAGE_NEGO		2
+#define   ASPEED_PECI_INT_MASK			GENMASK(4, 0)
+#define     ASPEED_PECI_INT_BUS_TIMEOUT		BIT(4)
+#define     ASPEED_PECI_INT_BUS_CONTENTION	BIT(3)
+#define     ASPEED_PECI_INT_WR_FCS_BAD		BIT(2)
+#define     ASPEED_PECI_INT_WR_FCS_ABORT	BIT(1)
+#define     ASPEED_PECI_INT_CMD_DONE		BIT(0)
+
+/* Interrupt Status Register */
+#define ASPEED_PECI_INT_STS			0x1c
+#define   ASPEED_PECI_INT_TIMING_RESULT_MASK	GENMASK(29, 16)
+	  /* bits[4..0]: Same bit fields in the 'Interrupt Register' */
+
+/* Rx/Tx Data Buffer Registers */
+#define ASPEED_PECI_WR_DATA0			0x20
+#define ASPEED_PECI_WR_DATA1			0x24
+#define ASPEED_PECI_WR_DATA2			0x28
+#define ASPEED_PECI_WR_DATA3			0x2c
+#define ASPEED_PECI_RD_DATA0			0x30
+#define ASPEED_PECI_RD_DATA1			0x34
+#define ASPEED_PECI_RD_DATA2			0x38
+#define ASPEED_PECI_RD_DATA3			0x3c
+#define ASPEED_PECI_WR_DATA4			0x40
+#define ASPEED_PECI_WR_DATA5			0x44
+#define ASPEED_PECI_WR_DATA6			0x48
+#define ASPEED_PECI_WR_DATA7			0x4c
+#define ASPEED_PECI_RD_DATA4			0x50
+#define ASPEED_PECI_RD_DATA5			0x54
+#define ASPEED_PECI_RD_DATA6			0x58
+#define ASPEED_PECI_RD_DATA7			0x5c
+#define   ASPEED_PECI_DATA_BUF_SIZE_MAX		32
+
+/* Timing Negotiation */
+#define ASPEED_PECI_CLK_FREQUENCY_MIN		2000
+#define ASPEED_PECI_CLK_FREQUENCY_DEFAULT	1000000
+#define ASPEED_PECI_CLK_FREQUENCY_MAX		2000000
+#define ASPEED_PECI_RD_SAMPLING_POINT_DEFAULT	8
+/* Timeout */
+#define ASPEED_PECI_IDLE_CHECK_TIMEOUT_US	(50 * USEC_PER_MSEC)
+#define ASPEED_PECI_IDLE_CHECK_INTERVAL_US	(10 * USEC_PER_MSEC)
+#define ASPEED_PECI_CMD_TIMEOUT_MS_DEFAULT	1000
+#define ASPEED_PECI_CMD_TIMEOUT_MS_MAX		1000
+
+#define ASPEED_PECI_CLK_DIV1(msg_timing) (4 * (msg_timing) + 1)
+#define ASPEED_PECI_CLK_DIV2(clk_div_exp) BIT(clk_div_exp)
+#define ASPEED_PECI_CLK_DIV(msg_timing, clk_div_exp) \
+	(4 * ASPEED_PECI_CLK_DIV1(msg_timing) * ASPEED_PECI_CLK_DIV2(clk_div_exp))
+
+struct aspeed_peci {
+	struct peci_controller *controller;
+	struct device *dev;
+	void __iomem *base;
+	struct reset_control *rst;
+	int irq;
+	spinlock_t lock; /* to sync completion status handling */
+	struct completion xfer_complete;
+	struct clk *clk;
+	u32 clk_frequency;
+	u32 status;
+	u32 cmd_timeout_ms;
+};
+
+struct clk_aspeed_peci {
+	struct clk_hw hw;
+	struct aspeed_peci *aspeed_peci;
+};
+
+static void aspeed_peci_controller_enable(struct aspeed_peci *priv)
+{
+	u32 val = readl(priv->base + ASPEED_PECI_CTRL);
+
+	val |= ASPEED_PECI_CTRL_PECI_CLK_EN;
+	val |= ASPEED_PECI_CTRL_PECI_EN;
+
+	writel(val, priv->base + ASPEED_PECI_CTRL);
+}
+
+static void aspeed_peci_init_regs(struct aspeed_peci *priv)
+{
+	u32 val;
+
+	/* Clear interrupts */
+	writel(ASPEED_PECI_INT_MASK, priv->base + ASPEED_PECI_INT_STS);
+
+	/* Set timing negotiation mode and enable interrupts */
+	val = FIELD_PREP(ASPEED_PECI_TIMING_NEGO_SEL_MASK, ASPEED_PECI_1ST_BIT_OF_ADDR_NEGO);
+	val |= ASPEED_PECI_INT_MASK;
+	writel(val, priv->base + ASPEED_PECI_INT_CTRL);
+
+	val = FIELD_PREP(ASPEED_PECI_CTRL_SAMPLING_MASK, ASPEED_PECI_RD_SAMPLING_POINT_DEFAULT);
+	writel(val, priv->base + ASPEED_PECI_CTRL);
+}
+
+static int aspeed_peci_check_idle(struct aspeed_peci *priv)
+{
+	u32 cmd_sts = readl(priv->base + ASPEED_PECI_CMD);
+	int ret;
+
+	/*
+	 * Under normal circumstances, we expect to be idle here.
+	 * In case there were any errors/timeouts that led to the situation
+	 * where the hardware is not in idle state - we need to reset and
+	 * reinitialize it to avoid potential controller hang.
+	 */
+	if (FIELD_GET(ASPEED_PECI_CMD_STS_MASK, cmd_sts)) {
+		ret = reset_control_assert(priv->rst);
+		if (ret) {
+			dev_err(priv->dev, "cannot assert reset control\n");
+			return ret;
+		}
+
+		ret = reset_control_deassert(priv->rst);
+		if (ret) {
+			dev_err(priv->dev, "cannot deassert reset control\n");
+			return ret;
+		}
+
+		aspeed_peci_init_regs(priv);
+
+		ret = clk_set_rate(priv->clk, priv->clk_frequency);
+		if (ret < 0) {
+			dev_err(priv->dev, "cannot set clock frequency\n");
+			return ret;
+		}
+
+		aspeed_peci_controller_enable(priv);
+	}
+
+	return readl_poll_timeout(priv->base + ASPEED_PECI_CMD,
+				  cmd_sts,
+				  !(cmd_sts & ASPEED_PECI_CMD_IDLE_MASK),
+				  ASPEED_PECI_IDLE_CHECK_INTERVAL_US,
+				  ASPEED_PECI_IDLE_CHECK_TIMEOUT_US);
+}
+
+static int aspeed_peci_xfer(struct peci_controller *controller,
+			    u8 addr, struct peci_request *req)
+{
+	struct aspeed_peci *priv = dev_get_drvdata(controller->dev.parent);
+	unsigned long timeout = msecs_to_jiffies(priv->cmd_timeout_ms);
+	u32 peci_head;
+	int ret, i;
+
+	if (req->tx.len > ASPEED_PECI_DATA_BUF_SIZE_MAX ||
+	    req->rx.len > ASPEED_PECI_DATA_BUF_SIZE_MAX)
+		return -EINVAL;
+
+	/* Check command sts and bus idle state */
+	ret = aspeed_peci_check_idle(priv);
+	if (ret)
+		return ret; /* -ETIMEDOUT */
+
+	spin_lock_irq(&priv->lock);
+	reinit_completion(&priv->xfer_complete);
+
+	peci_head = FIELD_PREP(ASPEED_PECI_TARGET_ADDR_MASK, addr) |
+		    FIELD_PREP(ASPEED_PECI_WR_LEN_MASK, req->tx.len) |
+		    FIELD_PREP(ASPEED_PECI_RD_LEN_MASK, req->rx.len);
+
+	writel(peci_head, priv->base + ASPEED_PECI_RW_LENGTH);
+
+	for (i = 0; i < req->tx.len; i += 4) {
+		u32 reg = (i < 16 ? ASPEED_PECI_WR_DATA0 : ASPEED_PECI_WR_DATA4) + i % 16;
+
+		writel(get_unaligned_le32(&req->tx.buf[i]), priv->base + reg);
+	}
+
+#if IS_ENABLED(CONFIG_DYNAMIC_DEBUG)
+	dev_dbg(priv->dev, "HEAD : %#08x\n", peci_head);
+	print_hex_dump_bytes("TX : ", DUMP_PREFIX_NONE, req->tx.buf, req->tx.len);
+#endif
+
+	priv->status = 0;
+	writel(ASPEED_PECI_CMD_FIRE, priv->base + ASPEED_PECI_CMD);
+	spin_unlock_irq(&priv->lock);
+
+	ret = wait_for_completion_interruptible_timeout(&priv->xfer_complete, timeout);
+	if (ret < 0)
+		return ret;
+
+	if (ret == 0) {
+		dev_dbg(priv->dev, "timeout waiting for a response\n");
+		return -ETIMEDOUT;
+	}
+
+	spin_lock_irq(&priv->lock);
+
+	if (priv->status != ASPEED_PECI_INT_CMD_DONE) {
+		spin_unlock_irq(&priv->lock);
+		dev_dbg(priv->dev, "no valid response, status: %#02x\n", priv->status);
+		return -EIO;
+	}
+
+	spin_unlock_irq(&priv->lock);
+
+	/*
+	 * We need to use dword reads for register access, make sure that the
+	 * buffer size is multiple of 4-bytes.
+	 */
+	BUILD_BUG_ON(PECI_REQUEST_MAX_BUF_SIZE % 4);
+
+	for (i = 0; i < req->rx.len; i += 4) {
+		u32 reg = (i < 16 ? ASPEED_PECI_RD_DATA0 : ASPEED_PECI_RD_DATA4) + i % 16;
+		u32 rx_data = readl(priv->base + reg);
+
+		put_unaligned_le32(rx_data, &req->rx.buf[i]);
+	}
+
+#if IS_ENABLED(CONFIG_DYNAMIC_DEBUG)
+	print_hex_dump_bytes("RX : ", DUMP_PREFIX_NONE, req->rx.buf, req->rx.len);
+#endif
+	return 0;
+}
+
+static irqreturn_t aspeed_peci_irq_handler(int irq, void *arg)
+{
+	struct aspeed_peci *priv = arg;
+	u32 status;
+
+	spin_lock(&priv->lock);
+	status = readl(priv->base + ASPEED_PECI_INT_STS);
+	writel(status, priv->base + ASPEED_PECI_INT_STS);
+	priv->status |= (status & ASPEED_PECI_INT_MASK);
+
+	/*
+	 * All commands should be ended up with a ASPEED_PECI_INT_CMD_DONE bit
+	 * set even in an error case.
+	 */
+	if (status & ASPEED_PECI_INT_CMD_DONE)
+		complete(&priv->xfer_complete);
+
+	writel(0, priv->base + ASPEED_PECI_CMD);
+
+	spin_unlock(&priv->lock);
+
+	return IRQ_HANDLED;
+}
+
+static void clk_aspeed_peci_find_div_values(unsigned long rate, int *msg_timing, int *clk_div_exp)
+{
+	unsigned long best_diff = ~0ul, diff;
+	int msg_timing_temp, clk_div_exp_temp, i, j;
+
+	for (i = 1; i <= 255; i++)
+		for (j = 0; j < 8; j++) {
+			diff = abs(rate - ASPEED_PECI_CLK_DIV1(i) * ASPEED_PECI_CLK_DIV2(j));
+			if (diff < best_diff) {
+				msg_timing_temp = i;
+				clk_div_exp_temp = j;
+				best_diff = diff;
+			}
+		}
+
+	*msg_timing = msg_timing_temp;
+	*clk_div_exp = clk_div_exp_temp;
+}
+
+static int clk_aspeed_peci_get_div(unsigned long rate, const unsigned long *prate)
+{
+	unsigned long this_rate = *prate / (4 * rate);
+	int msg_timing, clk_div_exp;
+
+	clk_aspeed_peci_find_div_values(this_rate, &msg_timing, &clk_div_exp);
+
+	return ASPEED_PECI_CLK_DIV(msg_timing, clk_div_exp);
+}
+
+static int clk_aspeed_peci_set_rate(struct clk_hw *hw, unsigned long rate,
+				    unsigned long prate)
+{
+	struct clk_aspeed_peci *peci_clk = container_of(hw, struct clk_aspeed_peci, hw);
+	struct aspeed_peci *aspeed_peci = peci_clk->aspeed_peci;
+	unsigned long this_rate = prate / (4 * rate);
+	int clk_div_exp, msg_timing;
+	u32 val;
+
+	clk_aspeed_peci_find_div_values(this_rate, &msg_timing, &clk_div_exp);
+
+	val = readl(aspeed_peci->base + ASPEED_PECI_CTRL);
+	val |= FIELD_PREP(ASPEED_PECI_CTRL_CLK_DIV_MASK, clk_div_exp);
+	writel(val, aspeed_peci->base + ASPEED_PECI_CTRL);
+
+	val = FIELD_PREP(ASPEED_PECI_T_NEGO_MSG_MASK, msg_timing);
+	val |= FIELD_PREP(ASPEED_PECI_T_NEGO_ADDR_MASK, msg_timing);
+	writel(val, aspeed_peci->base + ASPEED_PECI_TIMING_NEGOTIATION);
+
+	return 0;
+}
+
+static long clk_aspeed_peci_round_rate(struct clk_hw *hw, unsigned long rate,
+				       unsigned long *prate)
+{
+	int div = clk_aspeed_peci_get_div(rate, prate);
+
+	return DIV_ROUND_UP_ULL(*prate, div);
+}
+
+static unsigned long clk_aspeed_peci_recalc_rate(struct clk_hw *hw, unsigned long prate)
+{
+	struct clk_aspeed_peci *peci_clk = container_of(hw, struct clk_aspeed_peci, hw);
+	struct aspeed_peci *aspeed_peci = peci_clk->aspeed_peci;
+	int div, msg_timing, addr_timing, clk_div_exp;
+	u32 reg;
+
+	reg = readl(aspeed_peci->base + ASPEED_PECI_TIMING_NEGOTIATION);
+	msg_timing = FIELD_GET(ASPEED_PECI_T_NEGO_MSG_MASK, reg);
+	addr_timing = FIELD_GET(ASPEED_PECI_T_NEGO_ADDR_MASK, reg);
+
+	if (msg_timing != addr_timing)
+		return 0;
+
+	reg = readl(aspeed_peci->base + ASPEED_PECI_CTRL);
+	clk_div_exp = FIELD_GET(ASPEED_PECI_CTRL_CLK_DIV_MASK, reg);
+
+	div = ASPEED_PECI_CLK_DIV(msg_timing, clk_div_exp);
+
+	return DIV_ROUND_UP_ULL(prate, div);
+}
+
+static const struct clk_ops clk_aspeed_peci_ops = {
+	.set_rate = clk_aspeed_peci_set_rate,
+	.round_rate = clk_aspeed_peci_round_rate,
+	.recalc_rate = clk_aspeed_peci_recalc_rate,
+};
+
+/*
+ * PECI HW contains a clock divider which is a combination of:
+ *  div0: 4 (fixed divider)
+ *  div1: x + 1
+ *  div2: 1 << y
+ * In other words, out_clk = in_clk / (div0 * div1 * div2)
+ * The resulting frequency is used by PECI Controller to drive the PECI bus to
+ * negotiate optimal transfer rate.
+ */
+static struct clk *devm_aspeed_peci_register_clk_div(struct device *dev, struct clk *parent,
+						     struct aspeed_peci *priv)
+{
+	struct clk_aspeed_peci *peci_clk;
+	struct clk_init_data init;
+	const char *parent_name;
+	char name[32];
+	int ret;
+
+	snprintf(name, sizeof(name), "%s_div", dev_name(dev));
+
+	parent_name = __clk_get_name(parent);
+
+	init.ops = &clk_aspeed_peci_ops;
+	init.name = name;
+	init.parent_names = (const char* []) { parent_name };
+	init.num_parents = 1;
+	init.flags = 0;
+
+	peci_clk = devm_kzalloc(dev, sizeof(struct clk_aspeed_peci), GFP_KERNEL);
+	if (!peci_clk)
+		return ERR_PTR(-ENOMEM);
+
+	peci_clk->hw.init = &init;
+	peci_clk->aspeed_peci = priv;
+
+	ret = devm_clk_hw_register(dev, &peci_clk->hw);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return peci_clk->hw.clk;
+}
+
+static void aspeed_peci_property_sanitize(struct device *dev, const char *propname,
+					  u32 min, u32 max, u32 default_val, u32 *propval)
+{
+	u32 val;
+	int ret;
+
+	ret = device_property_read_u32(dev, propname, &val);
+	if (ret) {
+		val = default_val;
+	} else if (val > max || val < min) {
+		dev_warn(dev, "invalid %s: %u, falling back to: %u\n",
+			 propname, val, default_val);
+
+		val = default_val;
+	}
+
+	*propval = val;
+}
+
+static void aspeed_peci_property_setup(struct aspeed_peci *priv)
+{
+	aspeed_peci_property_sanitize(priv->dev, "clock-frequency",
+				      ASPEED_PECI_CLK_FREQUENCY_MIN, ASPEED_PECI_CLK_FREQUENCY_MAX,
+				      ASPEED_PECI_CLK_FREQUENCY_DEFAULT, &priv->clk_frequency);
+	aspeed_peci_property_sanitize(priv->dev, "cmd-timeout-ms",
+				      1, ASPEED_PECI_CMD_TIMEOUT_MS_MAX,
+				      ASPEED_PECI_CMD_TIMEOUT_MS_DEFAULT, &priv->cmd_timeout_ms);
+}
+
+static struct peci_controller_ops aspeed_ops = {
+	.xfer = aspeed_peci_xfer,
+};
+
+static void aspeed_peci_reset_control_release(void *data)
+{
+	reset_control_assert(data);
+}
+
+static int devm_aspeed_peci_reset_control_deassert(struct device *dev, struct reset_control *rst)
+{
+	int ret;
+
+	ret = reset_control_deassert(rst);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(dev, aspeed_peci_reset_control_release, rst);
+}
+
+static void aspeed_peci_clk_release(void *data)
+{
+	clk_disable_unprepare(data);
+}
+
+static int devm_aspeed_peci_clk_enable(struct device *dev, struct clk *clk)
+{
+	int ret;
+
+	ret = clk_prepare_enable(clk);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(dev, aspeed_peci_clk_release, clk);
+}
+
+static int aspeed_peci_probe(struct platform_device *pdev)
+{
+	struct peci_controller *controller;
+	struct aspeed_peci *priv;
+	struct clk *ref_clk;
+	int ret;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = &pdev->dev;
+	dev_set_drvdata(priv->dev, priv);
+
+	priv->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	priv->irq = platform_get_irq(pdev, 0);
+	if (!priv->irq)
+		return priv->irq;
+
+	ret = devm_request_irq(&pdev->dev, priv->irq, aspeed_peci_irq_handler,
+			       0, "peci-aspeed", priv);
+	if (ret)
+		return ret;
+
+	init_completion(&priv->xfer_complete);
+	spin_lock_init(&priv->lock);
+
+	priv->rst = devm_reset_control_get(&pdev->dev, NULL);
+	if (IS_ERR(priv->rst))
+		return dev_err_probe(priv->dev, PTR_ERR(priv->rst),
+				     "failed to get reset control\n");
+
+	ret = devm_aspeed_peci_reset_control_deassert(priv->dev, priv->rst);
+	if (ret)
+		return dev_err_probe(priv->dev, ret, "cannot deassert reset control\n");
+
+	aspeed_peci_property_setup(priv);
+
+	aspeed_peci_init_regs(priv);
+
+	ref_clk = devm_clk_get(priv->dev, NULL);
+	if (IS_ERR(ref_clk))
+		return dev_err_probe(priv->dev, PTR_ERR(ref_clk), "failed to get ref clock\n");
+
+	priv->clk = devm_aspeed_peci_register_clk_div(priv->dev, ref_clk, priv);
+	if (IS_ERR(priv->clk))
+		return dev_err_probe(priv->dev, PTR_ERR(priv->clk), "cannot register clock\n");
+
+	ret = clk_set_rate(priv->clk, priv->clk_frequency);
+	if (ret < 0)
+		return dev_err_probe(priv->dev, ret, "cannot set clock frequency\n");
+
+	ret = devm_aspeed_peci_clk_enable(priv->dev, priv->clk);
+	if (ret)
+		return dev_err_probe(priv->dev, ret, "failed to enable clock\n");
+
+	aspeed_peci_controller_enable(priv);
+
+	controller = devm_peci_controller_add(priv->dev, &aspeed_ops);
+	if (IS_ERR(controller))
+		return dev_err_probe(priv->dev, PTR_ERR(controller),
+				     "failed to add aspeed peci controller\n");
+
+	priv->controller = controller;
+
+	return 0;
+}
+
+static const struct of_device_id aspeed_peci_of_table[] = {
+	{ .compatible = "aspeed,ast2400-peci", },
+	{ .compatible = "aspeed,ast2500-peci", },
+	{ .compatible = "aspeed,ast2600-peci", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, aspeed_peci_of_table);
+
+static struct platform_driver aspeed_peci_driver = {
+	.probe  = aspeed_peci_probe,
+	.driver = {
+		.name           = "peci-aspeed",
+		.of_match_table = aspeed_peci_of_table,
+	},
+};
+module_platform_driver(aspeed_peci_driver);
+
+MODULE_AUTHOR("Ryan Chen <ryan_chen@aspeedtech.com>");
+MODULE_AUTHOR("Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>");
+MODULE_DESCRIPTION("ASPEED PECI driver");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(PECI);
-- 
2.34.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C7A53F36F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 03:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbiFGBlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 21:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbiFGBld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 21:41:33 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ACB15AA62
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 18:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654566091; x=1686102091;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tkdB3t5TUgomYbZdCLgUQ5wx3hmqP7HEid2GOUqhJtI=;
  b=h0olXQLYXoQeBij3HaIJLl7bxUZZWNzb3L42us68JSUmw1NjGB0un6La
   8fdAoowUBPBW+BlTFFEmKGjzqtObh90tsp6vncHawk1thrJHsKr5Hobc9
   3kxK6Gl5YS4LKQdsbgKGu3v2Gpiaubwn74NQY+/F84Wx81zI9g4koLOGp
   K/el7HZzZ65735wcthvyC3dFgZuV4yioTtPcl3TCbYYTOFdjMM7pBUW6d
   zFnfq6fPYXwEHlkHLogQypCjkHcjjhtFbX6O+WRNNJhzNmEOhfehvzXwA
   qR3ClVRmWU3Z4aaROc7ugwzl4eN/KMQj0vVoQvQ/QHdyG0BEkw605xeNt
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="337882444"
X-IronPort-AV: E=Sophos;i="5.91,282,1647327600"; 
   d="scan'208";a="337882444"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 18:41:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,282,1647327600"; 
   d="scan'208";a="669761914"
Received: from unknown (HELO localhost.localdomain.sh.intel.com) ([10.238.175.107])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Jun 2022 18:41:28 -0700
From:   Tianfei Zhang <tianfei.zhang@intel.com>
To:     broonie@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     hao.wu@intel.com, trix@redhat.com, yilun.xu@intel.com,
        russell.h.weight@intel.com,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Tianfei Zhang <tianfei.zhang@intel.com>
Subject: [PATCH v1] regmap: add generic indirect regmap support
Date:   Mon,  6 Jun 2022 21:37:55 -0400
Message-Id: <20220607013755.594554-1-tianfei.zhang@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Gerlach <matthew.gerlach@linux.intel.com>

This patch adds support for regmap APIs that are intended to be used by
the drivers of some devices which support generic indirect register access,
for example PMCI (Platform Management Control Interface) device, HSSI
(High Speed Serial Interface) device in FPGA.

Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
---
 drivers/base/regmap/Kconfig                   |   3 +
 drivers/base/regmap/Makefile                  |   1 +
 .../base/regmap/regmap-indirect-register.c    | 133 ++++++++++++++++++
 include/linux/regmap.h                        |  12 ++
 4 files changed, 149 insertions(+)
 create mode 100644 drivers/base/regmap/regmap-indirect-register.c

diff --git a/drivers/base/regmap/Kconfig b/drivers/base/regmap/Kconfig
index 159bac6c5046..4ea590604f8d 100644
--- a/drivers/base/regmap/Kconfig
+++ b/drivers/base/regmap/Kconfig
@@ -65,3 +65,6 @@ config REGMAP_I3C
 config REGMAP_SPI_AVMM
 	tristate
 	depends on SPI
+
+config REGMAP_INDIRECT_REGISTER
+	tristate
diff --git a/drivers/base/regmap/Makefile b/drivers/base/regmap/Makefile
index 11facb32a027..504a32b79d8c 100644
--- a/drivers/base/regmap/Makefile
+++ b/drivers/base/regmap/Makefile
@@ -20,3 +20,4 @@ obj-$(CONFIG_REGMAP_SCCB) += regmap-sccb.o
 obj-$(CONFIG_REGMAP_I3C) += regmap-i3c.o
 obj-$(CONFIG_REGMAP_SPI_AVMM) += regmap-spi-avmm.o
 obj-$(CONFIG_REGMAP_MDIO) += regmap-mdio.o
+obj-$(CONFIG_REGMAP_INDIRECT_REGISTER) += regmap-indirect-register.o
diff --git a/drivers/base/regmap/regmap-indirect-register.c b/drivers/base/regmap/regmap-indirect-register.c
new file mode 100644
index 000000000000..0b748e48bd87
--- /dev/null
+++ b/drivers/base/regmap/regmap-indirect-register.c
@@ -0,0 +1,133 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Indirect Register Access.
+//
+// Copyright (C) 2022 Intel Corporation, Inc.
+
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+
+#define INDIRECT_CMD_OFF	0x0
+#define INDIRECT_CMD_RD	BIT(0)
+#define INDIRECT_CMD_WR	BIT(1)
+#define INDIRECT_CMD_ACK	BIT(2)
+
+#define INDIRECT_ADDR_OFF	0x4
+#define INDIRECT_RD_OFF	0x8
+#define INDIRECT_WR_OFF	0xc
+
+#define INDIRECT_INT_US	1
+#define INDIRECT_TIMEOUT_US	10000
+
+struct indirect_ctx {
+	void __iomem *base;
+	struct device *dev;
+};
+
+static int indirect_bus_clr_cmd(struct indirect_ctx *ctx)
+{
+	unsigned int cmd;
+	int ret;
+
+	writel(0, ctx->base + INDIRECT_CMD_OFF);
+	ret = readl_poll_timeout((ctx->base + INDIRECT_CMD_OFF), cmd,
+				 (!cmd), INDIRECT_INT_US, INDIRECT_TIMEOUT_US);
+	if (ret)
+		dev_err(ctx->dev, "%s timed out on clearing cmd 0x%xn", __func__, cmd);
+
+	return ret;
+}
+
+static int indirect_bus_reg_read(void *context, unsigned int reg,
+				 unsigned int *val)
+{
+	struct indirect_ctx *ctx = context;
+	unsigned int cmd;
+	int ret;
+
+	cmd = readl(ctx->base + INDIRECT_CMD_OFF);
+	if (cmd)
+		dev_warn(ctx->dev, "%s non-zero cmd 0x%x\n", __func__, cmd);
+
+	writel(reg, ctx->base + INDIRECT_ADDR_OFF);
+	writel(INDIRECT_CMD_RD, ctx->base + INDIRECT_CMD_OFF);
+	ret = readl_poll_timeout((ctx->base + INDIRECT_CMD_OFF), cmd,
+				 (cmd & INDIRECT_CMD_ACK), INDIRECT_INT_US,
+				 INDIRECT_TIMEOUT_US);
+	if (ret) {
+		dev_err(ctx->dev, "%s timed out on reg 0x%x cmd 0x%x\n", __func__, reg, cmd);
+		goto out;
+	}
+
+	*val = readl(ctx->base + INDIRECT_RD_OFF);
+
+	if (indirect_bus_clr_cmd(ctx))
+		ret = -ETIMEDOUT;
+
+out:
+	return ret;
+}
+
+static int indirect_bus_reg_write(void *context, unsigned int reg,
+				  unsigned int val)
+{
+	struct indirect_ctx *ctx = context;
+	unsigned int cmd;
+	int ret;
+
+	cmd = readl(ctx->base + INDIRECT_CMD_OFF);
+	if (cmd)
+		dev_warn(ctx->dev, "%s non-zero cmd 0x%x\n", __func__, cmd);
+
+	writel(val, ctx->base + INDIRECT_WR_OFF);
+	writel(reg, ctx->base + INDIRECT_ADDR_OFF);
+	writel(INDIRECT_CMD_WR, ctx->base + INDIRECT_CMD_OFF);
+	ret = readl_poll_timeout((ctx->base + INDIRECT_CMD_OFF), cmd,
+				 (cmd & INDIRECT_CMD_ACK), INDIRECT_INT_US,
+				 INDIRECT_TIMEOUT_US);
+	if (ret) {
+		dev_err(ctx->dev, "%s timed out on reg 0x%x cmd 0x%x\n", __func__, reg, cmd);
+		goto out;
+	}
+
+	if (indirect_bus_clr_cmd(ctx))
+		ret = -ETIMEDOUT;
+
+out:
+	return ret;
+}
+
+static const struct regmap_bus indirect_bus = {
+	.reg_write = indirect_bus_reg_write,
+	.reg_read =  indirect_bus_reg_read,
+};
+
+/**
+ * devm_regmap_init_indirect_register - create a regmap for indirect register access
+ * @dev: device creating the regmap
+ * @base: __iomem point to base of memory with mailbox
+ * @cfg: regmap_config describing interface
+ *
+ * Return: 0 on success, negative error code otherwise.
+ */
+struct regmap *devm_regmap_init_indirect_register(struct device *dev,
+						  void __iomem *base,
+						  struct regmap_config *cfg)
+{
+	struct indirect_ctx *ctx;
+
+	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return NULL;
+
+	ctx->base = base;
+	ctx->dev = dev;
+
+	return devm_regmap_init(dev, &indirect_bus, ctx, cfg);
+}
+EXPORT_SYMBOL_GPL(devm_regmap_init_indirect_register);
+
+MODULE_DESCRIPTION("Indirect Register Access");
+MODULE_AUTHOR("Intel Corporation");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index de81a94d7b30..72eb38883e88 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -670,6 +670,18 @@ struct regmap *__devm_regmap_init_spi_avmm(struct spi_device *spi,
 					   const struct regmap_config *config,
 					   struct lock_class_key *lock_key,
 					   const char *lock_name);
+/**
+ * devm_regmap_init_indirect_register - create a regmap for indirect register access
+ * @dev: device creating the regmap
+ * @base: __iomem point to base of memory with mailbox
+ * @cfg: regmap_config describing interface
+ *
+ * Return: 0 on success, negative error code otherwise.
+ */
+struct regmap *devm_regmap_init_indirect_register(struct device *dev,
+						  void __iomem *base,
+						  struct regmap_config *cfg);
+
 /*
  * Wrapper for regmap_init macros to include a unique lockdep key and name
  * for each call. No-op if CONFIG_LOCKDEP is not set.
-- 
2.26.2


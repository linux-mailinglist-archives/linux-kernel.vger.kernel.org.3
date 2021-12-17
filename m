Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 560BA47979F
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 00:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbhLQXr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 18:47:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbhLQXr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 18:47:27 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60FEC061574;
        Fri, 17 Dec 2021 15:47:26 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id d38so7888286lfv.0;
        Fri, 17 Dec 2021 15:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QlFNM4FD2HgKx84+rRYvJilJof1j2UVdcH/nqDBWIEM=;
        b=oh5bH4c4rjxf+HVJES4j+6EmqHScMRHf4bEF7TOOSUghm5QV6dCT4+Ovo1WLDx4y3J
         W+BB0kYESaeq/lPyCYZX5DMu2p4wl7sUC0vRPNaF7pa/f4wh6szGct4phCWDxFZZ6m9x
         gVcCd3x7NAcpZ4zhYizfo5OLqWkiSAZup4fstbsFmbLE8aQ+dRA7mGV8vbVs0CCElxHc
         E6fBZGq8jMP/NjgSbdnTV/UyKlZKsCzHdtTQmGmNBZCZe/LfTLiZfPovDPnz8hHTIS1J
         M+VM7bp32Oc/vY7hfhVUhlXRElwYGC7v6kh7tojW4awfVz8WrzXCnN2x3lEpOvsmtRMG
         ZDtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QlFNM4FD2HgKx84+rRYvJilJof1j2UVdcH/nqDBWIEM=;
        b=Be0kqSV8hf9pfwJ+O3XycU0D9H7CViDfth1n4lIS4LxFoM7GF5NaKBtSdAArbrdseC
         VqL6CINcMhvrNed6lMJ5gJ7oT5aqW8F/eSXHbfLedcmXQ+ANjxjyaly0qEQeIFnH6NRx
         eHiIrdNAcdIvHjEEZkPBg7CaFzs3WX551A6rcdlW1zmqVYlHj/xFudmVXy8asfGTM8Mt
         BlFzZ7zyEJAY7gCw1Y6rWa/r8Y3P5RMagfE3cTvdv9iqECjcKPFIQrT9BdruGfX6baGd
         FPpg/yGFTDfRu2zlb4ehuD0t/edCgZHzRDoubqkUKPD9vIxhtYzikXtZ5EfWDxmulmyY
         aHYw==
X-Gm-Message-State: AOAM532VnKzJCRToq8T0wIppf1F6jTHuuarbsWzfmKyG72++o6v1oJdH
        0lBsD1WhiMblPOoNzx21dwUJWuPxa0w=
X-Google-Smtp-Source: ABdhPJwfJ5wxVQ9tSaeK9fONzc9Pgzsz0z8hEymbnVIirA+yF8TuSPEijNhKulo8kw3rtLQPfPXPLQ==
X-Received: by 2002:ac2:4311:: with SMTP id l17mr4782770lfh.538.1639784845020;
        Fri, 17 Dec 2021 15:47:25 -0800 (PST)
Received: from localhost.localdomain (94-29-63-156.dynamic.spd-mgts.ru. [94.29.63.156])
        by smtp.gmail.com with ESMTPSA id u25sm1547766lfc.72.2021.12.17.15.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 15:47:24 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v1] memory: tegra30-emc: Print additional memory info
Date:   Sat, 18 Dec 2021 02:47:11 +0300
Message-Id: <20211217234711.8353-1-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Print out memory type and LPDDR2 configuration on Tegra30, making it
similar to the memory info printed by the Tegra20 memory driver. This
info is useful for debugging purposes.

Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # T30 ASUS TF201 LPDDR2
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/Kconfig       |   1 +
 drivers/memory/tegra/tegra30-emc.c | 131 ++++++++++++++++++++++++++---
 2 files changed, 122 insertions(+), 10 deletions(-)

diff --git a/drivers/memory/tegra/Kconfig b/drivers/memory/tegra/Kconfig
index 7951764b4efe..3fe83d7c2bf8 100644
--- a/drivers/memory/tegra/Kconfig
+++ b/drivers/memory/tegra/Kconfig
@@ -28,6 +28,7 @@ config TEGRA30_EMC
 	default y
 	depends on ARCH_TEGRA_3x_SOC || COMPILE_TEST
 	select PM_OPP
+	select DDR
 	help
 	  This driver is for the External Memory Controller (EMC) found on
 	  Tegra30 chips. The EMC controls the external DRAM on the board.
diff --git a/drivers/memory/tegra/tegra30-emc.c b/drivers/memory/tegra/tegra30-emc.c
index 80f98d717e13..4c0432704f46 100644
--- a/drivers/memory/tegra/tegra30-emc.c
+++ b/drivers/memory/tegra/tegra30-emc.c
@@ -9,6 +9,7 @@
  * Copyright (C) 2019 GRATE-DRIVER project
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/clk/tegra.h>
 #include <linux/debugfs.h>
@@ -31,11 +32,15 @@
 #include <soc/tegra/common.h>
 #include <soc/tegra/fuse.h>
 
+#include "../jedec_ddr.h"
+#include "../of_memory.h"
+
 #include "mc.h"
 
 #define EMC_INTSTATUS				0x000
 #define EMC_INTMASK				0x004
 #define EMC_DBG					0x008
+#define EMC_ADR_CFG				0x010
 #define EMC_CFG					0x00c
 #define EMC_REFCTRL				0x020
 #define EMC_TIMING_CONTROL			0x028
@@ -81,6 +86,7 @@
 #define EMC_EMRS				0x0d0
 #define EMC_SELF_REF				0x0e0
 #define EMC_MRW					0x0e8
+#define EMC_MRR					0x0ec
 #define EMC_XM2DQSPADCTRL3			0x0f8
 #define EMC_FBIO_SPARE				0x100
 #define EMC_FBIO_CFG5				0x104
@@ -208,6 +214,13 @@
 
 #define EMC_REFRESH_OVERFLOW_INT		BIT(3)
 #define EMC_CLKCHANGE_COMPLETE_INT		BIT(4)
+#define EMC_MRR_DIVLD_INT			BIT(5)
+
+#define EMC_MRR_DEV_SELECTN			GENMASK(31, 30)
+#define EMC_MRR_MRR_MA				GENMASK(23, 16)
+#define EMC_MRR_MRR_DATA			GENMASK(15, 0)
+
+#define EMC_ADR_CFG_EMEM_NUMDEV			BIT(0)
 
 enum emc_dram_type {
 	DRAM_TYPE_DDR3,
@@ -378,6 +391,8 @@ struct tegra_emc {
 
 	/* protect shared rate-change code path */
 	struct mutex rate_lock;
+
+	bool mrr_error;
 };
 
 static int emc_seq_update_timing(struct tegra_emc *emc)
@@ -1008,12 +1023,18 @@ static int emc_load_timings_from_dt(struct tegra_emc *emc,
 	return 0;
 }
 
-static struct device_node *emc_find_node_by_ram_code(struct device *dev)
+static struct device_node *emc_find_node_by_ram_code(struct tegra_emc *emc)
 {
+	struct device *dev = emc->dev;
 	struct device_node *np;
 	u32 value, ram_code;
 	int err;
 
+	if (emc->mrr_error) {
+		dev_warn(dev, "memory timings skipped due to MRR error\n");
+		return NULL;
+	}
+
 	if (of_get_child_count(dev->of_node) == 0) {
 		dev_info_once(dev, "device-tree doesn't have memory timings\n");
 		return NULL;
@@ -1035,11 +1056,73 @@ static struct device_node *emc_find_node_by_ram_code(struct device *dev)
 	return NULL;
 }
 
+static int emc_read_lpddr_mode_register(struct tegra_emc *emc,
+					unsigned int emem_dev,
+					unsigned int register_addr,
+					unsigned int *register_data)
+{
+	u32 memory_dev = emem_dev + 1;
+	u32 val, mr_mask = 0xff;
+	int err;
+
+	/* clear data-valid interrupt status */
+	writel_relaxed(EMC_MRR_DIVLD_INT, emc->regs + EMC_INTSTATUS);
+
+	/* issue mode register read request */
+	val  = FIELD_PREP(EMC_MRR_DEV_SELECTN, memory_dev);
+	val |= FIELD_PREP(EMC_MRR_MRR_MA, register_addr);
+
+	writel_relaxed(val, emc->regs + EMC_MRR);
+
+	/* wait for the LPDDR2 data-valid interrupt */
+	err = readl_relaxed_poll_timeout_atomic(emc->regs + EMC_INTSTATUS, val,
+						val & EMC_MRR_DIVLD_INT,
+						1, 100);
+	if (err) {
+		dev_err(emc->dev, "mode register %u read failed: %d\n",
+			register_addr, err);
+		emc->mrr_error = true;
+		return err;
+	}
+
+	/* read out mode register data */
+	val = readl_relaxed(emc->regs + EMC_MRR);
+	*register_data = FIELD_GET(EMC_MRR_MRR_DATA, val) & mr_mask;
+
+	return 0;
+}
+
+static void emc_read_lpddr_sdram_info(struct tegra_emc *emc,
+				      unsigned int emem_dev)
+{
+	union lpddr2_basic_config4 basic_conf4;
+	unsigned int manufacturer_id;
+	unsigned int revision_id1;
+	unsigned int revision_id2;
+
+	/* these registers are standard for all LPDDR JEDEC memory chips */
+	emc_read_lpddr_mode_register(emc, emem_dev, 5, &manufacturer_id);
+	emc_read_lpddr_mode_register(emc, emem_dev, 6, &revision_id1);
+	emc_read_lpddr_mode_register(emc, emem_dev, 7, &revision_id2);
+	emc_read_lpddr_mode_register(emc, emem_dev, 8, &basic_conf4.value);
+
+	dev_info(emc->dev, "SDRAM[dev%u]: manufacturer: 0x%x (%s) rev1: 0x%x rev2: 0x%x prefetch: S%u density: %uMbit iowidth: %ubit\n",
+		 emem_dev, manufacturer_id,
+		 lpddr2_jedec_manufacturer(manufacturer_id),
+		 revision_id1, revision_id2,
+		 4 >> basic_conf4.arch_type,
+		 64 << basic_conf4.density,
+		 32 >> basic_conf4.io_width);
+}
+
 static int emc_setup_hw(struct tegra_emc *emc)
 {
+	u32 fbio_cfg5, emc_cfg, emc_dbg, emc_adr_cfg;
 	u32 intmask = EMC_REFRESH_OVERFLOW_INT;
-	u32 fbio_cfg5, emc_cfg, emc_dbg;
+	static bool print_sdram_info_once;
 	enum emc_dram_type dram_type;
+	const char *dram_type_str;
+	unsigned int emem_numdev;
 
 	fbio_cfg5 = readl_relaxed(emc->regs + EMC_FBIO_CFG5);
 	dram_type = fbio_cfg5 & EMC_FBIO_CFG5_DRAM_TYPE_MASK;
@@ -1076,6 +1159,34 @@ static int emc_setup_hw(struct tegra_emc *emc)
 	emc_dbg &= ~EMC_DBG_FORCE_UPDATE;
 	writel_relaxed(emc_dbg, emc->regs + EMC_DBG);
 
+	switch (dram_type) {
+	case DRAM_TYPE_DDR1:
+		dram_type_str = "DDR1";
+		break;
+	case DRAM_TYPE_LPDDR2:
+		dram_type_str = "LPDDR2";
+		break;
+	case DRAM_TYPE_DDR2:
+		dram_type_str = "DDR2";
+		break;
+	case DRAM_TYPE_DDR3:
+		dram_type_str = "DDR3";
+		break;
+	}
+
+	emc_adr_cfg = readl_relaxed(emc->regs + EMC_ADR_CFG);
+	emem_numdev = FIELD_GET(EMC_ADR_CFG_EMEM_NUMDEV, emc_adr_cfg) + 1;
+
+	dev_info_once(emc->dev, "%u %s %s attached\n", emem_numdev,
+		      dram_type_str, emem_numdev == 2 ? "devices" : "device");
+
+	if (dram_type == DRAM_TYPE_LPDDR2 && !print_sdram_info_once) {
+		while (emem_numdev--)
+			emc_read_lpddr_sdram_info(emc, emem_numdev);
+
+		print_sdram_info_once = true;
+	}
+
 	return 0;
 }
 
@@ -1538,14 +1649,6 @@ static int tegra_emc_probe(struct platform_device *pdev)
 	emc->clk_nb.notifier_call = emc_clk_change_notify;
 	emc->dev = &pdev->dev;
 
-	np = emc_find_node_by_ram_code(&pdev->dev);
-	if (np) {
-		err = emc_load_timings_from_dt(emc, np);
-		of_node_put(np);
-		if (err)
-			return err;
-	}
-
 	emc->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(emc->regs))
 		return PTR_ERR(emc->regs);
@@ -1554,6 +1657,14 @@ static int tegra_emc_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
+	np = emc_find_node_by_ram_code(emc);
+	if (np) {
+		err = emc_load_timings_from_dt(emc, np);
+		of_node_put(np);
+		if (err)
+			return err;
+	}
+
 	err = platform_get_irq(pdev, 0);
 	if (err < 0)
 		return err;
-- 
2.33.1


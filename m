Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB484F5E11
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 14:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbiDFMfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 08:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233241AbiDFMdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 08:33:01 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE9F140DF3;
        Wed,  6 Apr 2022 01:30:08 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id t4so1635524pgc.1;
        Wed, 06 Apr 2022 01:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=TPHeU7lvr2HVWMKexSfImYqFSzOlYDpcxSsq3Jg3NUo=;
        b=aw8pUr2UgrHXPnWwOVu0NUvZzomwr++JrW9V4xFtH9I9Mt1t7prQT7T8Dhtydg2j51
         tHll+A5UHxcHmngH/Fen0MVoO19gdvDlKjZOE1aKWC4ogYa7h7al5v5420q+lsDwBaet
         tNW8+BxquGoywzQoVFs4PxoVUUxuWdq+8Y5BrE7HVzzAGHKWaHiFad5HQKUayA81p7PE
         QREB0sShcXl3BWvLp1aTyExv52vQp7hWapm/I508bwK3+zxgg04j4tkv1smvNwp1aA5q
         8c+f1LTPlH83ePkTbXtRYiU5DfHBnUkzdT0i0sOuNXM0LNGqN0o4Eqe7uLoUI+Y++oDp
         Br3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=TPHeU7lvr2HVWMKexSfImYqFSzOlYDpcxSsq3Jg3NUo=;
        b=dFiZ4O4nHoaDnYCsvHqO7snlGn75nyO2ze443VMnVtoon0HMJ2a35/BAJ/0M6lR+yD
         3s2aLWnUOpEOwVlDiOqqp1Fq6PLkDspTPE3xYzmBHBaMSEwTlLcPPZPE69ulXCMsLqs6
         kOq6hfCeQICJMkXn2+KaUrkM1aVN6kltPnxJH/2+HFQC2wO26rrb/0QS2mEm4sqm87d3
         2pqzVxBv2eBhCjWIqiCd8kFUwXVVVpcQSC5TwlBGt/7S0aRsaujyF/mSUXvgAHp2Iq4/
         Moqj+VPsob1fw2hRisFkAm/cedzUBgmYbH3L6ODOmPw/fJOCm3vKNo5VDw9AInSgxvhx
         6Igw==
X-Gm-Message-State: AOAM530vlrBeVq1jvbxnxluUBLA6VBQkS1CiL+s/tmN58t4MQMslejYW
        07w8AC/BRBVLu3tccy90YUY=
X-Google-Smtp-Source: ABdhPJy3lx1kGMhjhToH3NT4Jcxs4xEocNUASeoQxghTCAPKFp2e9TKTplRAKYgi9ErUTmXY5yHw+w==
X-Received: by 2002:a05:6a02:283:b0:342:703e:1434 with SMTP id bk3-20020a056a02028300b00342703e1434mr6137713pgb.74.1649233807491;
        Wed, 06 Apr 2022 01:30:07 -0700 (PDT)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id r8-20020a17090a0ac800b001c9e35d3a3asm4904977pje.24.2022.04.06.01.30.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Apr 2022 01:30:07 -0700 (PDT)
From:   Tony Huang <tonyhuang.sunplus@gmail.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, p.zabel@pengutronix.de,
        krzysztof.kozlowski@linaro.org
Cc:     wells.lu@sunplus.com, lh.Kuo@sunplus.com, tony.huang@sunplus.com,
        Tony Huang <tonyhuang.sunplus@gmail.com>
Subject: [PATCH v6 2/2] mmc: Add mmc driver for Sunplus SP7021
Date:   Wed,  6 Apr 2022 16:29:49 +0800
Message-Id: <e99f3027590b5ab3938c2e2d8713bf6284a810b2.1649229258.git.tonyhuang.sunplus@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1649229258.git.tonyhuang.sunplus@gmail.com>
References: <cover.1649229258.git.tonyhuang.sunplus@gmail.com>
In-Reply-To: <cover.1649229258.git.tonyhuang.sunplus@gmail.com>
References: <cover.1649229258.git.tonyhuang.sunplus@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use SYSTEM_SLEEP_PM_OPS instead of SET_SYSTEM_SLEEP_PM_OPS.
Use RUNTIME_PM_OPS instead of SET_RUNTIME_PM_OPS. Remove #ifdef check.
Fixed mutex lock and unlock imbalance issue.

Signed-off-by: Tony Huang <tonyhuang.sunplus@gmail.com>
---
Changes in v5:
 - Addressed comments from Krzysztof.
 - Remove the relevant sdcard code.
 - Submit the emmc code only.

Changes in v6:
 - Addressed comments from Arnd.
 - Use SYSTEM_SLEEP_PM_OPS instead of SET_SYSTEM_SLEEP_PM_OPS.
 - Use RUNTIME_PM_OPS instead of SET_RUNTIME_PM_OPS.
 - Remove #ifdef check.
 - Fixed mutex lock and unlock imbalance issue.
 
 MAINTAINERS                    |    1 +
 drivers/mmc/host/Kconfig       |    9 +
 drivers/mmc/host/Makefile      |    1 +
 drivers/mmc/host/sunplus-mmc.c | 1200 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 1211 insertions(+)
 create mode 100644 drivers/mmc/host/sunplus-mmc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 75746ec..88c315a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18247,6 +18247,7 @@ M:	Tony Huang <tonyhuang.sunplus@gmail.com>
 M:	Li-hao Kuo <lhjeff911@gmail.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/mmc/sunplus,mmc.yaml
+F:	drivers/mmc/host/sunplus-mmc.c
 
 SUPERH
 M:	Yoshinori Sato <ysato@users.sourceforge.jp>
diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 5af8494..0d34a4b 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -14,6 +14,15 @@ config MMC_DEBUG
 	  added host drivers please don't invent their private macro for
 	  debugging.
 
+config MMC_SUNPLUS
+	tristate "Sunplus SP7021 MMC Controller"
+	depends on ARCH_SUNPLUS || COMPILE_TEST
+	help
+	  If you say yes here, you will get support for eMMC host interface
+	  on Sunplus SoCs.
+
+	  If unsure, say N
+
 config MMC_ARMMMCI
 	tristate "ARM AMBA Multimedia Card Interface support"
 	depends on ARM_AMBA
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index ea36d37..72c67d5 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -97,6 +97,7 @@ obj-$(CONFIG_MMC_SDHCI_MICROCHIP_PIC32)	+= sdhci-pic32.o
 obj-$(CONFIG_MMC_SDHCI_BRCMSTB)		+= sdhci-brcmstb.o
 obj-$(CONFIG_MMC_SDHCI_OMAP)		+= sdhci-omap.o
 obj-$(CONFIG_MMC_SDHCI_SPRD)		+= sdhci-sprd.o
+obj-$(CONFIG_MMC_SUNPLUS)		+= sunplus-mmc.o
 obj-$(CONFIG_MMC_CQHCI)			+= cqhci.o
 cqhci-y					+= cqhci-core.o
 cqhci-$(CONFIG_MMC_CRYPTO)		+= cqhci-crypto.o
diff --git a/drivers/mmc/host/sunplus-mmc.c b/drivers/mmc/host/sunplus-mmc.c
new file mode 100644
index 0000000..e9bd762
--- /dev/null
+++ b/drivers/mmc/host/sunplus-mmc.c
@@ -0,0 +1,1200 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Sunplus Inc.
+ * Author: Tony Huang <tonyhuang.sunplus@gmail.com>
+ * Author: Li-hao Kuo <lhjeff911@gmail.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/dma-mapping.h>
+#include <linux/interrupt.h>
+#include <linux/mmc/core.h>
+#include <linux/mmc/host.h>
+#include <linux/mmc/mmc.h>
+#include <linux/mmc/sdio.h>
+#include <linux/mmc/slot-gpio.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pm.h>
+#include <linux/pm_runtime.h>
+#include <linux/reset.h>
+
+#define SPMMC_MIN_CLK			400000
+#define SPMMC_MAX_CLK			52000000
+#define SPMMC_MAX_BLK_COUNT		65536
+#define SPMMC_MAX_TUNABLE_DLY	7
+
+#define SPMMC_CARD_MEDIATYPE_SRCDST_REG 0x0000
+#define SPMMC_MEDIA_TYPE		GENMASK(2, 0)
+#define SPMMC_DMA_SOURCE		GENMASK(6, 4)
+#define SPMMC_DMA_DESTINATION		GENMASK(10, 8)
+#define SPMMC_MEDIA_NONE	0
+#define SPMMC_MEDIA_SD		6
+#define SPMMC_MEDIA_MS		7
+
+#define SPMMC_SDRAM_SECTOR_0_SIZE_REG	0x0008
+#define SPMMC_DMA_BASE_ADDR_REG		0x000C
+#define SPMMC_HW_DMA_CTRL_REG		0x0010
+#define SPMMC_HW_DMA_RST	BIT(9)
+#define SPMMC_DMAIDLE		BIT(10)
+
+#define SPMMC_MAX_DMA_MEMORY_SECTORS	8
+
+#define SPMMC_SDRAM_SECTOR_1_ADDR_REG 0x0018
+
+#define SPMMC_SD_INT_REG	0x0088
+#define SPMMC_SDINT_SDCMPEN	BIT(0)
+#define SPMMC_SDINT_SDCMP	BIT(1)
+#define SPMMC_SDINT_SDCMPCLR	BIT(2)
+#define SPMMC_SDINT_SDIOEN	BIT(3)
+#define SPMMC_SDINT_SDIO	BIT(4)
+#define SPMMC_SDINT_SDIOCLR	BIT(5)
+
+#define SPMMC_SD_PAGE_NUM_REG	0x008C
+
+#define SPMMC_SD_CONFIG0_REG	0x0090
+#define SPMMC_SD_PIO_MODE	BIT(0)
+#define SPMMC_SD_DDR_MODE	BIT(1)
+#define SPMMC_SD_LEN_MODE	BIT(2)
+#define SPMMC_SD_TRANS_MODE	GENMASK(5, 4)
+#define SPMMC_SD_AUTO_RESPONSE	BIT(6)
+#define SPMMC_SD_CMD_DUMMY	BIT(7)
+#define SPMMC_SD_RSP_CHK_EN	BIT(8)
+#define SPMMC_SDIO_MODE		BIT(9)
+#define SPMMC_SD_MMC_MODE	BIT(10)
+#define SPMMC_SD_DATA_WD	BIT(11)
+#define SPMMC_RX4_EN		BIT(14)
+#define SPMMC_SD_RSP_TYPE	BIT(15)
+#define SPMMC_MMC8_EN		BIT(18)
+#define SPMMC_CLOCK_DIVISION	GENMASK(31, 20)
+
+#define SPMMC_SDIO_CTRL_REG		0x0094
+#define SPMMC_INT_MULTI_TRIG		BIT(6)
+
+#define SPMMC_SD_RST_REG		0x0098
+#define SPMMC_SD_CTRL_REG		0x009C
+#define SPMMC_NEW_COMMAND_TRIGGER	BIT(0)
+#define SPMMC_DUMMY_CLOCK_TRIGGER	BIT(1)
+
+#define SPMMC_SD_STATUS_REG						0x00A0
+#define SPMMC_SDSTATUS_DUMMY_READY				BIT(0)
+#define SPMMC_SDSTATUS_RSP_BUF_FULL				BIT(1)
+#define SPMMC_SDSTATUS_TX_DATA_BUF_EMPTY		BIT(2)
+#define SPMMC_SDSTATUS_RX_DATA_BUF_FULL			BIT(3)
+#define SPMMC_SDSTATUS_CMD_PIN_STATUS			BIT(4)
+#define SPMMC_SDSTATUS_DAT0_PIN_STATUS			BIT(5)
+#define SPMMC_SDSTATUS_RSP_TIMEOUT				BIT(6)
+#define SPMMC_SDSTATUS_CARD_CRC_CHECK_TIMEOUT	BIT(7)
+#define SPMMC_SDSTATUS_STB_TIMEOUT				BIT(8)
+#define SPMMC_SDSTATUS_RSP_CRC7_ERROR			BIT(9)
+#define SPMMC_SDSTATUS_CRC_TOKEN_CHECK_ERROR	BIT(10)
+#define SPMMC_SDSTATUS_RDATA_CRC16_ERROR		BIT(11)
+#define SPMMC_SDSTATUS_SUSPEND_STATE_READY		BIT(12)
+#define SPMMC_SDSTATUS_BUSY_CYCLE				BIT(13)
+#define SPMMC_SDSTATUS_DAT1_PIN_STATUS			BIT(14)
+#define SPMMC_SDSTATUS_SD_SENSE_STATUS			BIT(15)
+#define SPMMC_SDSTATUS_BOOT_ACK_TIMEOUT			BIT(16)
+#define SPMMC_SDSTATUS_BOOT_DATA_TIMEOUT		BIT(17)
+#define SPMMC_SDSTATUS_BOOT_ACK_ERROR			BIT(18)
+
+#define SPMMC_SD_STATE_REG		0x00A4
+#define SPMMC_CRCTOKEN_CHECK_RESULT	GENMASK(6, 4)
+#define SPMMC_SDSTATE_ERROR		BIT(13)
+#define SPMMC_SDSTATE_FINISH	BIT(14)
+
+#define SPMMC_SD_HW_STATE_REG		0x00A8
+#define SPMMC_SD_BLOCKSIZE_REG		0x00AC
+
+#define SPMMC_SD_CONFIG1_REG		0x00B0
+#define SPMMC_TX_DUMMY_NUM		GENMASK(8, 0)
+#define SPMMC_SD_HIGH_SPEED_EN		BIT(31)
+
+#define SPMMC_SD_TIMING_CONFIG0_REG 0x00B4
+#define SPMMC_SD_CLOCK_DELAY	GENMASK(2, 0)
+#define SPMMC_SD_WRITE_DATA_DELAY	GENMASK(6, 4)
+#define SPMMC_SD_WRITE_COMMAND_DELAY	GENMASK(10, 8)
+#define SPMMC_SD_READ_RESPONSE_DELAY	GENMASK(14, 12)
+#define SPMMC_SD_READ_DATA_DELAY	GENMASK(18, 16)
+#define SPMMC_SD_READ_CRC_DELAY	GENMASK(22, 20)
+
+#define SPMMC_SD_PIODATATX_REG		0x00BC
+#define SPMMC_SD_PIODATARX_REG		0x00C0
+#define SPMMC_SD_CMDBUF0_3_REG		0x00C4
+#define SPMMC_SD_CMDBUF4_REG		0x00C8
+#define SPMMC_SD_RSPBUF0_3_REG		0x00CC
+#define SPMMC_SD_RSPBUF4_5_REG		0x00D0
+
+#define SPMMC_MAX_RETRIES (8 * 8)
+
+struct spmmc_tuning_info {
+	int enable_tuning;
+	int need_tuning;
+	int retried; /* how many times has been retried */
+	u32 rd_crc_dly:3;
+	u32 rd_dat_dly:3;
+	u32 rd_rsp_dly:3;
+	u32 wr_cmd_dly:3;
+	u32 wr_dat_dly:3;
+	u32 clk_dly:3;
+};
+
+static const u8 tuning_blk_pattern_4bit[] = {
+	0xff, 0x0f, 0xff, 0x00, 0xff, 0xcc, 0xc3, 0xcc,
+	0xc3, 0x3c, 0xcc, 0xff, 0xfe, 0xff, 0xfe, 0xef,
+	0xff, 0xdf, 0xff, 0xdd, 0xff, 0xfb, 0xff, 0xfb,
+	0xbf, 0xff, 0x7f, 0xff, 0x77, 0xf7, 0xbd, 0xef,
+	0xff, 0xf0, 0xff, 0xf0, 0x0f, 0xfc, 0xcc, 0x3c,
+	0xcc, 0x33, 0xcc, 0xcf, 0xff, 0xef, 0xff, 0xee,
+	0xff, 0xfd, 0xff, 0xfd, 0xdf, 0xff, 0xbf, 0xff,
+	0xbb, 0xff, 0xf7, 0xff, 0xf7, 0x7f, 0x7b, 0xde,
+};
+
+static const u8 tuning_blk_pattern_8bit[] = {
+	0xff, 0xff, 0x00, 0xff, 0xff, 0xff, 0x00, 0x00,
+	0xff, 0xff, 0xcc, 0xcc, 0xcc, 0x33, 0xcc, 0xcc,
+	0xcc, 0x33, 0x33, 0xcc, 0xcc, 0xcc, 0xff, 0xff,
+	0xff, 0xee, 0xff, 0xff, 0xff, 0xee, 0xee, 0xff,
+	0xff, 0xff, 0xdd, 0xff, 0xff, 0xff, 0xdd, 0xdd,
+	0xff, 0xff, 0xff, 0xbb, 0xff, 0xff, 0xff, 0xbb,
+	0xbb, 0xff, 0xff, 0xff, 0x77, 0xff, 0xff, 0xff,
+	0x77, 0x77, 0xff, 0x77, 0xbb, 0xdd, 0xee, 0xff,
+	0xff, 0xff, 0xff, 0x00, 0xff, 0xff, 0xff, 0x00,
+	0x00, 0xff, 0xff, 0xcc, 0xcc, 0xcc, 0x33, 0xcc,
+	0xcc, 0xcc, 0x33, 0x33, 0xcc, 0xcc, 0xcc, 0xff,
+	0xff, 0xff, 0xee, 0xff, 0xff, 0xff, 0xee, 0xee,
+	0xff, 0xff, 0xff, 0xdd, 0xff, 0xff, 0xff, 0xdd,
+	0xdd, 0xff, 0xff, 0xff, 0xbb, 0xff, 0xff, 0xff,
+	0xbb, 0xbb, 0xff, 0xff, 0xff, 0x77, 0xff, 0xff,
+	0xff, 0x77, 0x77, 0xff, 0x77, 0xbb, 0xdd, 0xee,
+};
+
+enum {
+	SPMMC_DMA_MODE = 0,
+	SPMMC_PIO_MODE = 1,
+};
+
+struct spmmc_host {
+	void __iomem *base;
+	struct clk *clk;
+	struct reset_control *rstc;
+	spinlock_t lock; /* Prevent races with irq handler */
+	struct mutex mrq_lock; /* protect spmmc_set_ios() context and spmmc_request() */
+	/* tasklet used to handle error then finish the request */
+	struct tasklet_struct tsklet_finish_req;
+	struct mmc_host *mmc;
+	struct mmc_request *mrq; /* current mrq */
+	int irq;
+	int use_int; /* should raise irq when done? */
+	int power_state; /* current power state: off/up/on */
+	int ddr_enabled;
+	int signal_voltage;
+	int dmapio_mode;
+	/*
+	 * for purpose of reducing context switch, only when transfer data that
+	 * length is greater than `dma_int_threshold' should use interrupt
+	 */
+	int dma_int_threshold;
+	struct sg_mapping_iter sg_miter; /* for pio mode to access sglist */
+	int dma_use_int; /* should raise irq when dma done */
+	struct spmmc_tuning_info tuning_info;
+};
+
+/*
+ * wait for transaction done, return -1 if error.
+ */
+static inline int spmmc_wait_finish(struct spmmc_host *host)
+{
+	/* Wait for transaction finish */
+	unsigned long timeout = jiffies + msecs_to_jiffies(5000);
+
+	while (!time_after(jiffies, timeout)) {
+		if (readl(host->base + SPMMC_SD_STATE_REG) & SPMMC_SDSTATE_FINISH)
+			return 0;
+		if (readl(host->base + SPMMC_SD_STATE_REG) & SPMMC_SDSTATE_ERROR)
+			return -EIO;
+	}
+
+	return -ETIMEDOUT;
+}
+
+static inline int spmmc_wait_sdstatus(struct spmmc_host *host, unsigned int status_bit)
+{
+	unsigned long timeout = jiffies + msecs_to_jiffies(5000);
+
+	while (!time_after(jiffies, timeout)) {
+		if (readl(host->base + SPMMC_SD_STATUS_REG) & status_bit)
+			return 0;
+		if (readl(host->base + SPMMC_SD_STATE_REG) & SPMMC_SDSTATE_ERROR)
+			return -EIO;
+	}
+
+	return -ETIMEDOUT;
+}
+
+#define spmmc_wait_rspbuf_full(host) spmmc_wait_sdstatus(host, SPMMC_SDSTATUS_RSP_BUF_FULL)
+#define spmmc_wait_rxbuf_full(host) spmmc_wait_sdstatus(host, SPMMC_SDSTATUS_RX_DATA_BUF_FULL)
+#define spmmc_wait_txbuf_empty(host) spmmc_wait_sdstatus(host, SPMMC_SDSTATUS_TX_DATA_BUF_EMPTY)
+
+static void spmmc_get_rsp(struct spmmc_host *host, struct mmc_command *cmd)
+{
+	u32 value0_3, value4_5;
+
+	if (unlikely(!(cmd->flags & MMC_RSP_PRESENT)))
+		return;
+	if (unlikely(cmd->flags & MMC_RSP_136)) {
+		if (spmmc_wait_rspbuf_full(host))
+			return;
+		value0_3 = readl(host->base + SPMMC_SD_RSPBUF0_3_REG);
+		value4_5 = readl(host->base + SPMMC_SD_RSPBUF4_5_REG) & 0xffff;
+		cmd->resp[0] = (value0_3 << 8) | (value4_5 >> 8);
+		cmd->resp[1] = value4_5 << 24;
+		value0_3 = readl(host->base + SPMMC_SD_RSPBUF0_3_REG);
+		value4_5 = readl(host->base + SPMMC_SD_RSPBUF4_5_REG) & 0xffff;
+		cmd->resp[1] |= value0_3 >> 8;
+		cmd->resp[2] = value0_3 << 24;
+		cmd->resp[2] |= value4_5 << 8;
+		value0_3 = readl(host->base + SPMMC_SD_RSPBUF0_3_REG);
+		value4_5 = readl(host->base + SPMMC_SD_RSPBUF4_5_REG) & 0xffff;
+		cmd->resp[2] |= value0_3 >> 24;
+		cmd->resp[3] = value0_3 << 8;
+		cmd->resp[3] |= value4_5 >> 8;
+	} else {
+		if (spmmc_wait_rspbuf_full(host))
+			return;
+		value0_3 = readl(host->base + SPMMC_SD_RSPBUF0_3_REG);
+		value4_5 = readl(host->base + SPMMC_SD_RSPBUF4_5_REG) & 0xffff;
+		cmd->resp[0] = (value0_3 << 8) | (value4_5 >> 8);
+		cmd->resp[1] = value4_5 << 24;
+	}
+}
+
+static void spmmc_set_bus_clk(struct spmmc_host *host, int clk)
+{
+	unsigned int clkdiv;
+	int f_min = host->mmc->f_min;
+	int f_max = host->mmc->f_max;
+	u32 value = readl(host->base + SPMMC_SD_CONFIG0_REG);
+
+	if (clk < f_min)
+		clk = f_min;
+	if (clk > f_max)
+		clk = f_max;
+
+	clkdiv = (clk_get_rate(host->clk) + clk) / clk - 1;
+	if (clkdiv > 0xfff)
+		clkdiv = 0xfff;
+
+	value |= FIELD_PREP(SPMMC_CLOCK_DIVISION, clkdiv);
+	writel(value, host->base + SPMMC_SD_CONFIG0_REG);
+
+	/*
+	 * In order to reduce the frequency of context switch,
+	 * if it is high speed or upper, we do not use interrupt
+	 * when send a command that without data transferring.
+	 */
+	if (clk > 25000000)
+		host->use_int = 0;
+	else
+		host->use_int = 1;
+}
+
+static void spmmc_set_bus_timing(struct spmmc_host *host, unsigned int timing)
+{
+	u32 value = readl(host->base + SPMMC_SD_CONFIG1_REG);
+	int clkdiv = FIELD_GET(SPMMC_CLOCK_DIVISION, readl(host->base + SPMMC_SD_CONFIG0_REG));
+	int delay = clkdiv / 2 < 7 ? clkdiv / 2 : 7;
+	int hs_en = 1;
+	char *timing_name;
+
+	host->ddr_enabled = 0;
+	switch (timing) {
+	case MMC_TIMING_LEGACY:
+		hs_en = 0;
+		timing_name = "legacy";
+		break;
+	case MMC_TIMING_MMC_HS:
+		timing_name = "mmc high-speed";
+		break;
+	case MMC_TIMING_SD_HS:
+		timing_name = "sd high-speed";
+		break;
+	case MMC_TIMING_UHS_SDR50:
+		timing_name = "sd uhs SDR50";
+		break;
+	case MMC_TIMING_UHS_SDR104:
+		timing_name = "sd uhs SDR104";
+		break;
+	case MMC_TIMING_UHS_DDR50:
+		host->ddr_enabled = 1;
+		timing_name = "sd uhs DDR50";
+		break;
+	case MMC_TIMING_MMC_DDR52:
+		host->ddr_enabled = 1;
+		timing_name = "mmc DDR52";
+		break;
+	case MMC_TIMING_MMC_HS200:
+		timing_name = "mmc HS200";
+		break;
+	default:
+		timing_name = "invalid";
+		hs_en = 0;
+		break;
+	}
+
+	if (hs_en) {
+		value |= SPMMC_SD_HIGH_SPEED_EN; /* sd_high_speed_en */
+		writel(value, host->base + SPMMC_SD_CONFIG1_REG);
+		value = readl(host->base + SPMMC_SD_TIMING_CONFIG0_REG);
+		value |= FIELD_PREP(SPMMC_SD_WRITE_DATA_DELAY, delay); /* sd_wr_dat_dly_sel */
+		value |= FIELD_PREP(SPMMC_SD_WRITE_COMMAND_DELAY, delay); /* sd_wr_cmd_dly_sel */
+		writel(value, host->base + SPMMC_SD_TIMING_CONFIG0_REG);
+	} else {
+		value &= ~SPMMC_SD_HIGH_SPEED_EN;
+		writel(value, host->base + SPMMC_SD_CONFIG1_REG);
+	}
+	if (host->ddr_enabled) {
+		value = readl(host->base + SPMMC_SD_CONFIG0_REG);
+		value |= SPMMC_SD_DDR_MODE; /* sdddrmode */
+		writel(value, host->base + SPMMC_SD_CONFIG0_REG);
+	} else {
+		value = readl(host->base + SPMMC_SD_CONFIG0_REG);
+		value &= ~SPMMC_SD_DDR_MODE;
+		writel(value, host->base + SPMMC_SD_CONFIG0_REG);
+	}
+}
+
+static void spmmc_set_bus_width(struct spmmc_host *host, int width)
+{
+	u32 value = readl(host->base + SPMMC_SD_CONFIG0_REG);
+
+	switch (width) {
+	case MMC_BUS_WIDTH_8:
+		value &= ~SPMMC_SD_DATA_WD;
+		value |= SPMMC_MMC8_EN;
+		break;
+	case MMC_BUS_WIDTH_4:
+		value |= SPMMC_SD_DATA_WD;
+		value &= ~SPMMC_MMC8_EN;
+		break;
+	default:
+		value &= ~SPMMC_SD_DATA_WD;
+		value &= ~SPMMC_MMC8_EN;
+		break;
+	};
+	writel(value, host->base + SPMMC_SD_CONFIG0_REG);
+}
+
+/*
+ * select the working mode of controller: sd/sdio/emmc
+ */
+static void spmmc_select_mode(struct spmmc_host *host)
+{
+	u32 value = readl(host->base + SPMMC_SD_CONFIG0_REG);
+
+	value |= SPMMC_SD_MMC_MODE;
+	value &= ~SPMMC_SDIO_MODE;
+	writel(value, host->base + SPMMC_SD_CONFIG0_REG);
+}
+
+static void spmmc_sw_reset(struct spmmc_host *host)
+{
+	u32 value;
+
+	/*
+	 * Must reset dma operation first, or it will
+	 * be stuck on sd_state == 0x1c00 because of
+	 * a controller software reset bug
+	 */
+	value = readl(host->base + SPMMC_HW_DMA_CTRL_REG);
+	value |= SPMMC_DMAIDLE;
+	writel(value, host->base + SPMMC_HW_DMA_CTRL_REG);
+	value &= ~SPMMC_DMAIDLE;
+	writel(value, host->base + SPMMC_HW_DMA_CTRL_REG);
+	value = readl(host->base + SPMMC_HW_DMA_CTRL_REG);
+	value |= SPMMC_HW_DMA_RST;
+	writel(value, host->base + SPMMC_HW_DMA_CTRL_REG);
+	writel(0x7, host->base + SPMMC_SD_RST_REG);
+	while (readl(host->base + SPMMC_SD_HW_STATE_REG) & BIT(6))
+		;
+}
+
+static void spmmc_prepare_cmd(struct spmmc_host *host, struct mmc_command *cmd)
+{
+	u32 value;
+
+	/* add start bit, according to spec, command format */
+	value = ((cmd->opcode | 0x40) << 24) | (cmd->arg >> 8);
+	writel(value, host->base + SPMMC_SD_CMDBUF0_3_REG);
+	writeb(cmd->arg & 0xff, host->base + SPMMC_SD_CMDBUF4_REG);
+
+	/* disable interrupt if needed */
+	value = readl(host->base + SPMMC_SD_INT_REG);
+	value |= SPMMC_SDINT_SDCMPCLR; /* sd_cmp_clr */
+	if (likely(!host->use_int || cmd->flags & MMC_RSP_136))
+		value &= ~SPMMC_SDINT_SDCMPEN; /* sdcmpen */
+	else
+		value |= SPMMC_SDINT_SDCMPEN;
+
+	writel(value, host->base + SPMMC_SD_INT_REG);
+
+	value = readl(host->base + SPMMC_SD_CONFIG0_REG);
+	value &= ~SPMMC_SD_TRANS_MODE; /* sd_trans_mode */
+	value |= SPMMC_SD_CMD_DUMMY; /* sdcmddummy */
+	if (likely(cmd->flags & MMC_RSP_PRESENT)) {
+		value |= SPMMC_SD_AUTO_RESPONSE; /* sdautorsp */
+	} else {
+		value &= ~SPMMC_SD_AUTO_RESPONSE;
+		writel(value, host->base + SPMMC_SD_CONFIG0_REG);
+
+		return;
+	}
+	/*
+	 * Currently, host is not capable of checking R2's CRC7,
+	 * thus, enable crc7 check only for 48 bit response commands
+	 */
+	if (likely(cmd->flags & MMC_RSP_CRC && !(cmd->flags & MMC_RSP_136)))
+		value |= SPMMC_SD_RSP_CHK_EN; /* sdrspchk_en */
+	else
+		value &= ~SPMMC_SD_RSP_CHK_EN;
+
+	if (unlikely(cmd->flags & MMC_RSP_136))
+		value |= SPMMC_SD_RSP_TYPE; /* sdrsptype */
+	else
+		value &= ~SPMMC_SD_RSP_TYPE;
+	writel(value, host->base + SPMMC_SD_CONFIG0_REG);
+}
+
+static void spmmc_prepare_data(struct spmmc_host *host, struct mmc_data *data)
+{
+	u32 value, srcdst;
+
+	writel(data->blocks - 1, host->base + SPMMC_SD_PAGE_NUM_REG);
+	writel(data->blksz - 1, host->base + SPMMC_SD_BLOCKSIZE_REG);
+	value = readl(host->base + SPMMC_SD_CONFIG0_REG);
+	if (data->flags & MMC_DATA_READ) {
+		value |= FIELD_PREP(SPMMC_SD_TRANS_MODE, 2); /* sd_trans_mode */
+		value &= ~SPMMC_SD_AUTO_RESPONSE; /* sdautorsp */
+		value &= ~SPMMC_SD_CMD_DUMMY; /* sdcmddummy */
+		srcdst = readl(host->base + SPMMC_CARD_MEDIATYPE_SRCDST_REG);
+		srcdst |= FIELD_PREP(SPMMC_DMA_SOURCE, 0x2);
+		srcdst |= FIELD_PREP(SPMMC_DMA_DESTINATION, 0x1);
+		writel(srcdst, host->base + SPMMC_CARD_MEDIATYPE_SRCDST_REG);
+	} else {
+		value |= FIELD_PREP(SPMMC_SD_TRANS_MODE, 1);
+		srcdst = readl(host->base + SPMMC_CARD_MEDIATYPE_SRCDST_REG);
+		srcdst |= FIELD_PREP(SPMMC_DMA_SOURCE, 0x1);
+		srcdst |= FIELD_PREP(SPMMC_DMA_DESTINATION, 0x2);
+		writel(srcdst, host->base + SPMMC_CARD_MEDIATYPE_SRCDST_REG);
+	}
+
+	value |= SPMMC_SD_LEN_MODE;
+	if (likely(host->dmapio_mode == SPMMC_DMA_MODE)) {
+		struct scatterlist *sg;
+		dma_addr_t dma_addr;
+		unsigned int dma_size;
+		u32 *reg_addr;
+		int dma_direction = data->flags & MMC_DATA_READ ? DMA_FROM_DEVICE : DMA_TO_DEVICE;
+		int i, count = 1;
+
+		count = dma_map_sg(host->mmc->parent, data->sg, data->sg_len, dma_direction);
+		if (unlikely(!count || count > SPMMC_MAX_DMA_MEMORY_SECTORS)) {
+			data->error = -EINVAL;
+
+			return;
+		}
+		for_each_sg(data->sg, sg, count, i) {
+			dma_addr = sg_dma_address(sg);
+			dma_size = sg_dma_len(sg) / data->blksz - 1;
+			if (i == 0) {
+				writel(dma_addr, host->base + SPMMC_DMA_BASE_ADDR_REG);
+				writel(dma_size, host->base + SPMMC_SDRAM_SECTOR_0_SIZE_REG);
+			} else {
+				reg_addr = host->base + SPMMC_SDRAM_SECTOR_1_ADDR_REG + (i - 1) * 2;
+				writel(dma_addr, reg_addr);
+				writel(dma_size, reg_addr + 1);
+			}
+		}
+		value &= ~SPMMC_SD_PIO_MODE; /* sdpiomode */
+		writel(value, host->base + SPMMC_SD_CONFIG0_REG);
+		/* enable interrupt if needed */
+		if (!host->use_int && data->blksz * data->blocks > host->dma_int_threshold) {
+			host->dma_use_int = 1;
+			value = readl(host->base + SPMMC_SD_INT_REG);
+			value |= SPMMC_SDINT_SDCMPEN; /* sdcmpen */
+			writel(value, host->base + SPMMC_SD_INT_REG);
+		}
+	} else {
+		value |= SPMMC_SD_PIO_MODE;
+		value |= SPMMC_RX4_EN; /* rx4_en */
+		writel(value, host->base + SPMMC_SD_CONFIG0_REG);
+	}
+}
+
+static inline void spmmc_trigger_transaction(struct spmmc_host *host)
+{
+	u32 value = readl(host->base + SPMMC_SD_CTRL_REG);
+
+	value |= SPMMC_NEW_COMMAND_TRIGGER; /* trigger transaction */
+	writel(value, host->base + SPMMC_SD_CTRL_REG);
+}
+
+static void spmmc_send_stop_cmd(struct spmmc_host *host)
+{
+	struct mmc_command stop = {};
+	u32 value;
+
+	stop.opcode = MMC_STOP_TRANSMISSION;
+	stop.arg = 0;
+	stop.flags = MMC_RSP_R1B;
+	spmmc_prepare_cmd(host, &stop);
+	value = readl(host->base + SPMMC_SD_INT_REG);
+	value &= ~SPMMC_SDINT_SDCMPEN;
+	value |= FIELD_PREP(SPMMC_SDINT_SDCMPEN, 0); /* sdcmpen */
+	writel(value, host->base + SPMMC_SD_INT_REG);
+	spmmc_trigger_transaction(host);
+	spmmc_wait_finish(host);
+}
+
+/*
+ * check if error occurred during transaction.
+ * @host -  host
+ * @mrq - the mrq
+ * @return 0 if no error otherwise the error number.
+ */
+static int spmmc_check_error(struct spmmc_host *host, struct mmc_request *mrq)
+{
+	int ret = 0;
+	struct mmc_command *cmd = mrq->cmd;
+	struct mmc_data *data = mrq->data;
+
+	u32 value = readl(host->base + SPMMC_SD_STATE_REG);
+	u32 crc_token = FIELD_GET(SPMMC_CRCTOKEN_CHECK_RESULT, value);
+
+	if (unlikely(value & SPMMC_SDSTATE_ERROR)) {
+		u32 timing_cfg0 = 0;
+
+		value = readl(host->base + SPMMC_SD_STATUS_REG);
+
+		if (host->tuning_info.enable_tuning) {
+			timing_cfg0 = readl(host->base + SPMMC_SD_TIMING_CONFIG0_REG);
+			host->tuning_info.rd_crc_dly = FIELD_GET(SPMMC_SD_READ_CRC_DELAY,
+								 timing_cfg0);
+			host->tuning_info.rd_dat_dly = FIELD_GET(SPMMC_SD_READ_DATA_DELAY,
+								 timing_cfg0);
+			host->tuning_info.rd_rsp_dly = FIELD_GET(SPMMC_SD_READ_RESPONSE_DELAY,
+								 timing_cfg0);
+			host->tuning_info.wr_cmd_dly = FIELD_GET(SPMMC_SD_WRITE_COMMAND_DELAY,
+								 timing_cfg0);
+			host->tuning_info.wr_dat_dly = FIELD_GET(SPMMC_SD_WRITE_DATA_DELAY,
+								 timing_cfg0);
+		}
+
+		if (value & SPMMC_SDSTATUS_RSP_TIMEOUT) {
+			ret = -ETIMEDOUT;
+			host->tuning_info.wr_cmd_dly++;
+		} else if (value & SPMMC_SDSTATUS_RSP_CRC7_ERROR) {
+			ret = -EILSEQ;
+			host->tuning_info.rd_rsp_dly++;
+		} else if (data) {
+			if ((value & SPMMC_SDSTATUS_STB_TIMEOUT)) {
+				ret = -ETIMEDOUT;
+				host->tuning_info.rd_dat_dly++;
+			} else if (value & SPMMC_SDSTATUS_RDATA_CRC16_ERROR) {
+				ret = -EILSEQ;
+				host->tuning_info.rd_dat_dly++;
+			} else if (value & SPMMC_SDSTATUS_CARD_CRC_CHECK_TIMEOUT) {
+				ret = -ETIMEDOUT;
+				host->tuning_info.rd_crc_dly++;
+			} else if (value & SPMMC_SDSTATUS_CRC_TOKEN_CHECK_ERROR) {
+				ret = -EILSEQ;
+				if (crc_token == 0x5)
+					host->tuning_info.wr_dat_dly++;
+				else
+					host->tuning_info.rd_crc_dly++;
+			}
+		}
+		cmd->error = ret;
+		if (data) {
+			data->error = ret;
+			data->bytes_xfered = 0;
+		}
+		if (!host->tuning_info.need_tuning && host->tuning_info.enable_tuning)
+			cmd->retries = SPMMC_MAX_RETRIES; /* retry it */
+		spmmc_sw_reset(host);
+		usleep_range(5000, 5250);
+
+		if (host->tuning_info.enable_tuning) {
+			timing_cfg0 |= FIELD_PREP(SPMMC_SD_READ_CRC_DELAY,
+						       host->tuning_info.rd_crc_dly);
+			timing_cfg0 |= FIELD_PREP(SPMMC_SD_READ_DATA_DELAY,
+						       host->tuning_info.rd_dat_dly);
+			timing_cfg0 |= FIELD_PREP(SPMMC_SD_READ_RESPONSE_DELAY,
+						       host->tuning_info.rd_rsp_dly);
+			timing_cfg0 |= FIELD_PREP(SPMMC_SD_WRITE_COMMAND_DELAY,
+						       host->tuning_info.wr_cmd_dly);
+			timing_cfg0 |= FIELD_PREP(SPMMC_SD_WRITE_DATA_DELAY,
+						       host->tuning_info.wr_dat_dly);
+			writel(timing_cfg0, host->base + SPMMC_SD_TIMING_CONFIG0_REG);
+		}
+	} else if (data) {
+		data->error = 0;
+		data->bytes_xfered = data->blocks * data->blksz;
+	}
+	host->tuning_info.need_tuning = ret;
+    /* controller will not send cmd 12 automatically if error occurred */
+	if (cmd->opcode == MMC_READ_MULTIPLE_BLOCK ||
+	    cmd->opcode == MMC_WRITE_MULTIPLE_BLOCK) {
+		spmmc_send_stop_cmd(host);
+		spmmc_sw_reset(host);
+	}
+
+	return ret;
+}
+
+/*
+ * the strategy is:
+ * 1. if several continuous delays are acceptable, we choose a middle one;
+ * 2. otherwise, we choose the first one.
+ */
+static inline int __find_best_delay(u8 candidate_dly)
+{
+	int f, w, value;
+
+	if (!candidate_dly)
+		return 0;
+	f = ffs(candidate_dly) - 1;
+	w = hweight8(candidate_dly);
+	value = ((1 << w) - 1) << f;
+	if (0xff == (value & ~candidate_dly))
+		return (f + w / 2);
+	else
+		return (f);
+}
+
+static inline __maybe_unused void spmmc_txdummy(struct spmmc_host *host, int count)
+{
+	u32 value;
+
+	count &= 0x1ff;
+	value = readl(host->base + SPMMC_SD_CONFIG1_REG);
+	value |= FIELD_PREP(SPMMC_TX_DUMMY_NUM, count);
+	writel(value, host->base + SPMMC_SD_CONFIG1_REG);
+	value = readl(host->base + SPMMC_SD_CTRL_REG);
+	value |= SPMMC_DUMMY_CLOCK_TRIGGER; /* trigger tx dummy */
+	writel(value, host->base + SPMMC_SD_CTRL_REG);
+}
+
+static void spmmc_xfer_data_pio(struct spmmc_host *host, struct mmc_data *data)
+{
+	u32 *buf; /* tx/rx 4 bytes one time in pio mode */
+	int data_left = data->blocks * data->blksz;
+	int consumed, remain;
+
+	struct sg_mapping_iter *sg_miter = &host->sg_miter;
+	unsigned int flags = 0;
+
+	if (data->flags & MMC_DATA_WRITE)
+		flags |= SG_MITER_FROM_SG;
+	else
+		flags |= SG_MITER_TO_SG;
+	sg_miter_start(&host->sg_miter, data->sg, data->sg_len, flags);
+	while (data_left > 0) {
+		consumed = 0;
+		if (!sg_miter_next(sg_miter))
+			break;
+		buf = sg_miter->addr;
+		remain = sg_miter->length;
+		do {
+			if (data->flags & MMC_DATA_WRITE) {
+				if (spmmc_wait_txbuf_empty(host))
+					goto done;
+				writel(*buf, host->base + SPMMC_SD_PIODATATX_REG);
+			} else {
+				if (spmmc_wait_rxbuf_full(host))
+					goto done;
+				*buf = readl(host->base + SPMMC_SD_PIODATARX_REG);
+			}
+			buf++;
+			consumed += 4;
+			remain -= 4;
+		} while (remain);
+		sg_miter->consumed = consumed;
+		data_left -= consumed;
+	}
+done:
+	sg_miter_stop(sg_miter);
+}
+
+static void spmmc_controller_init(struct spmmc_host *host)
+{
+	u32 value;
+	int ret = reset_control_assert(host->rstc);
+
+	if (!ret) {
+		usleep_range(1000, 1250);
+		ret = reset_control_deassert(host->rstc);
+	}
+
+	value = readl(host->base + SPMMC_CARD_MEDIATYPE_SRCDST_REG);
+	value |= FIELD_PREP(SPMMC_MEDIA_TYPE, SPMMC_MEDIA_SD);
+	writel(value, host->base + SPMMC_CARD_MEDIATYPE_SRCDST_REG);
+	host->signal_voltage = MMC_SIGNAL_VOLTAGE_330;
+}
+
+static void spmmc_set_power_mode(struct spmmc_host *host, struct mmc_ios *ios)
+{
+	if (host->power_state == ios->power_mode)
+		return;
+
+	switch (ios->power_mode) {
+		/* power off->up->on */
+	case MMC_POWER_ON:
+		spmmc_controller_init(host);
+		pm_runtime_get_sync(host->mmc->parent);
+		break;
+	case MMC_POWER_UP:
+		break;
+	case MMC_POWER_OFF:
+		pm_runtime_put(host->mmc->parent);
+		break;
+	}
+	host->power_state = ios->power_mode;
+}
+
+/*
+ * 1. unmap scatterlist if needed;
+ * 2. get response & check error conditions;
+ * 3. unlock host->mrq_lock
+ * 4. notify mmc layer the request is done
+ */
+static void spmmc_finish_request(struct spmmc_host *host, struct mmc_request *mrq)
+{
+	struct mmc_command *cmd;
+	struct mmc_data *data;
+
+	if (!mrq)
+		return;
+
+	cmd = mrq->cmd;
+	data = mrq->data;
+
+	if (data && SPMMC_DMA_MODE == host->dmapio_mode) {
+		int dma_direction = data->flags & MMC_DATA_READ ? DMA_FROM_DEVICE : DMA_TO_DEVICE;
+
+		dma_unmap_sg(host->mmc->parent, data->sg, data->sg_len, dma_direction);
+		host->dma_use_int = 0;
+	}
+	spmmc_get_rsp(host, cmd);
+	spmmc_check_error(host, mrq);
+	host->mrq = NULL;
+	mmc_request_done(host->mmc, mrq);
+}
+
+/* Interrupt Service Routine */
+irqreturn_t spmmc_irq(int irq, void *dev_id)
+{
+	struct spmmc_host *host = dev_id;
+	u32 value = readl(host->base + SPMMC_SD_INT_REG);
+
+	spin_lock(&host->lock);
+	if ((value & SPMMC_SDINT_SDCMP) && (value & SPMMC_SDINT_SDCMPEN)) {
+		value &= ~SPMMC_SDINT_SDCMPEN; /* disable sdcmp */
+		value |= SPMMC_SDINT_SDCMPCLR; /* sd_cmp_clr */
+		writel(value, host->base + SPMMC_SD_INT_REG);
+		/*
+		 * if error occurred, we my need send cmd 12 to stop data transaction,
+		 * which is time consuming, so make use of tasklet to handle this.
+		 */
+		if (unlikely(readl(host->base + SPMMC_SD_STATE_REG) & SPMMC_SDSTATE_ERROR))
+			tasklet_schedule(&host->tsklet_finish_req);
+		else
+			spmmc_finish_request(host, host->mrq);
+	}
+	if (value & SPMMC_SDINT_SDIO &&
+	    (value & SPMMC_SDINT_SDIOEN)) {
+		mmc_signal_sdio_irq(host->mmc);
+	}
+	spin_unlock(&host->lock);
+
+	return IRQ_HANDLED;
+}
+
+static void spmmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
+{
+	struct spmmc_host *host = mmc_priv(mmc);
+	struct mmc_data *data;
+	struct mmc_command *cmd;
+
+	mutex_lock(&host->mrq_lock);
+	host->mrq = mrq;
+	data = mrq->data;
+	cmd = mrq->cmd;
+
+	spmmc_prepare_cmd(host, cmd);
+	/* we need manually read response R2. */
+	if (unlikely(cmd->flags & MMC_RSP_136)) {
+		spmmc_trigger_transaction(host);
+		spmmc_get_rsp(host, cmd);
+		spmmc_wait_finish(host);
+		spmmc_check_error(host, mrq);
+		host->mrq = NULL;
+		mmc_request_done(host->mmc, mrq);
+	} else {
+		if (data)
+			spmmc_prepare_data(host, data);
+
+		if (unlikely(host->dmapio_mode == SPMMC_PIO_MODE && data)) {
+			u32 value;
+			/* pio data transfer do not use interrupt */
+			value = readl(host->base + SPMMC_SD_INT_REG);
+			value &= ~SPMMC_SDINT_SDCMPEN; /* sdcmpen */
+			writel(value, host->base + SPMMC_SD_INT_REG);
+			spmmc_trigger_transaction(host);
+			spmmc_xfer_data_pio(host, data);
+			spmmc_wait_finish(host);
+			spmmc_finish_request(host, mrq);
+		} else {
+			if (!(host->use_int || host->dma_use_int)) {
+				spmmc_trigger_transaction(host);
+				spmmc_wait_finish(host);
+				spmmc_finish_request(host, mrq);
+			} else {
+				spmmc_trigger_transaction(host);
+			}
+		}
+	}
+	mutex_unlock(&host->mrq_lock);
+}
+
+static void spmmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	struct spmmc_host *host = (struct spmmc_host *)mmc_priv(mmc);
+
+	mutex_lock(&host->mrq_lock);
+	spmmc_set_power_mode(host, ios);
+	spmmc_set_bus_clk(host, ios->clock);
+	spmmc_set_bus_timing(host, ios->timing);
+	spmmc_set_bus_width(host, ios->bus_width);
+	/* ensure mode is correct, because we might have hw reset the controller */
+	spmmc_select_mode(host);
+	mutex_unlock(&host->mrq_lock);
+}
+
+/*
+ * Return values for the get_cd callback should be:
+ *   0 for a absent card
+ *   1 for a present card
+ *   -ENOSYS when not supported (equal to NULL callback)
+ *   or a negative errno value when something bad happened
+ */
+int spmmc_get_cd(struct mmc_host *mmc)
+{
+	int ret = 0;
+
+	if (mmc_can_gpio_cd(mmc))
+		ret = mmc_gpio_get_cd(mmc);
+
+	if (ret < 0)
+		ret = 0;
+
+	return ret;
+}
+
+static int spmmc_execute_tuning(struct mmc_host *mmc, u32 opcode)
+{
+	struct spmmc_host *host = mmc_priv(mmc);
+	const u8 *blk_pattern;
+	u8 *blk_test;
+	int blksz;
+	u8 smpl_dly = 0, candidate_dly = 0;
+	u32 value;
+
+	if (mmc->ios.bus_width == MMC_BUS_WIDTH_8) {
+		blk_pattern = tuning_blk_pattern_8bit;
+		blksz = sizeof(tuning_blk_pattern_8bit);
+	} else if (mmc->ios.bus_width == MMC_BUS_WIDTH_4) {
+		blk_pattern = tuning_blk_pattern_4bit;
+		blksz = sizeof(tuning_blk_pattern_4bit);
+	} else {
+		return -EINVAL;
+	}
+
+	blk_test = kmalloc(blksz, GFP_KERNEL);
+	if (!blk_test)
+		return -ENOMEM;
+
+	host->tuning_info.enable_tuning = 0;
+	do {
+		struct mmc_request mrq = {NULL};
+		struct mmc_command cmd = {0};
+		struct mmc_command stop = {0};
+		struct mmc_data data = {0};
+		struct scatterlist sg;
+
+		cmd.opcode = opcode;
+		cmd.arg = 0;
+		cmd.flags = MMC_RSP_R1 | MMC_CMD_ADTC;
+
+		stop.opcode = MMC_STOP_TRANSMISSION;
+		stop.arg = 0;
+		stop.flags = MMC_RSP_R1B | MMC_CMD_AC;
+
+		data.blksz = blksz;
+		data.blocks = 1;
+		data.flags = MMC_DATA_READ;
+		data.sg = &sg;
+		data.sg_len = 1;
+
+		sg_init_one(&sg, blk_test, blksz);
+		mrq.cmd = &cmd;
+		mrq.stop = &stop;
+		mrq.data = &data;
+		host->mrq = &mrq;
+
+		value = readl(host->base + SPMMC_SD_TIMING_CONFIG0_REG);
+		value |= FIELD_PREP(SPMMC_SD_READ_RESPONSE_DELAY, smpl_dly);
+		value |= FIELD_PREP(SPMMC_SD_READ_DATA_DELAY, smpl_dly);
+		value |= FIELD_PREP(SPMMC_SD_READ_CRC_DELAY, smpl_dly);
+		writel(value, host->base + SPMMC_SD_TIMING_CONFIG0_REG);
+
+		mmc_wait_for_req(mmc, &mrq);
+		if (!cmd.error && !data.error) {
+			if (!memcmp(blk_pattern, blk_test, blksz))
+				candidate_dly |= (1 << smpl_dly);
+		}
+	} while (smpl_dly++ <= SPMMC_MAX_TUNABLE_DLY);
+	host->tuning_info.enable_tuning = 1;
+
+	if (candidate_dly) {
+		smpl_dly = __find_best_delay(candidate_dly);
+		value = readl(host->base + SPMMC_SD_TIMING_CONFIG0_REG);
+		value |= FIELD_PREP(SPMMC_SD_READ_RESPONSE_DELAY, smpl_dly);
+		value |= FIELD_PREP(SPMMC_SD_READ_DATA_DELAY, smpl_dly);
+		value |= FIELD_PREP(SPMMC_SD_READ_CRC_DELAY, smpl_dly);
+		writel(value, host->base + SPMMC_SD_TIMING_CONFIG0_REG);
+		return 0;
+	}
+
+	return -EIO;
+}
+
+static void spmmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
+{
+	struct spmmc_host *host = mmc_priv(mmc);
+	u32 value = readl(host->base + SPMMC_SD_INT_REG);
+
+	value &= ~SPMMC_SDINT_SDIOCLR;
+	value |= FIELD_PREP(SPMMC_SDINT_SDIOCLR, 1); /* sdio_int_clr */
+	if (enable)
+		value |= SPMMC_SDINT_SDIOEN;
+	else
+		value &= ~SPMMC_SDINT_SDIOEN;
+	writel(value, host->base + SPMMC_SD_INT_REG);
+}
+
+static const struct mmc_host_ops spmmc_ops = {
+	.request = spmmc_request,
+	.set_ios = spmmc_set_ios,
+	.get_cd = spmmc_get_cd,
+	.execute_tuning = spmmc_execute_tuning,
+	.enable_sdio_irq = spmmc_enable_sdio_irq,
+};
+
+static void tsklet_func_finish_req(unsigned long data)
+{
+	struct spmmc_host *host = (struct spmmc_host *)data;
+
+	spin_lock(&host->lock);
+	spmmc_finish_request(host, host->mrq);
+	spin_unlock(&host->lock);
+}
+
+static int spmmc_drv_probe(struct platform_device *pdev)
+{
+	struct mmc_host *mmc;
+	struct resource *res;
+	struct spmmc_host *host;
+	unsigned int mode;
+	int ret = 0;
+
+	mmc = mmc_alloc_host(sizeof(*host), &pdev->dev);
+	if (!mmc) {
+		ret = -ENOMEM;
+		goto probe_free_host;
+	}
+
+	host = mmc_priv(mmc);
+	host->mmc = mmc;
+	host->power_state = MMC_POWER_OFF;
+	host->dma_int_threshold = 1024;
+	host->dmapio_mode = SPMMC_DMA_MODE;
+
+	host->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
+	if (IS_ERR(host->base))
+		return PTR_ERR(host->base);
+
+	host->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(host->clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(host->clk), "clk get fail\n");
+
+	host->rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
+	if (IS_ERR(host->rstc))
+		return dev_err_probe(&pdev->dev, PTR_ERR(host->rstc), "rst get fail\n");
+
+	host->irq = platform_get_irq(pdev, 0);
+	if (host->irq <= 0)
+		return host->irq;
+
+	ret = devm_request_irq(&pdev->dev, host->irq, spmmc_irq, IRQF_SHARED,
+			       dev_name(&pdev->dev), host);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(host->clk);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "failed to enable clk\n");
+
+	ret = mmc_of_parse(mmc);
+	if (ret)
+		goto probe_free_host;
+
+	spin_lock_init(&host->lock);
+	mutex_init(&host->mrq_lock);
+	tasklet_init(&host->tsklet_finish_req, tsklet_func_finish_req, (unsigned long)host);
+	mmc->ops = &spmmc_ops;
+	mmc->f_min = SPMMC_MIN_CLK;
+	if (mmc->f_max > SPMMC_MAX_CLK)
+		mmc->f_max = SPMMC_MAX_CLK;
+
+	mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
+	mmc->max_seg_size = SPMMC_MAX_BLK_COUNT * 512;
+	/* Host controller supports up to "SPMMC_MAX_DMA_MEMORY_SECTORS"*/
+	/* a.k.a. max scattered memory segments per request*/
+	mmc->max_segs = SPMMC_MAX_DMA_MEMORY_SECTORS;
+	mmc->max_req_size = SPMMC_MAX_BLK_COUNT * 512;
+	/* Limited by the max value of dma_size & data_length, set it to 512 bytes for now */
+	mmc->max_blk_size = 512;
+	mmc->max_blk_count = SPMMC_MAX_BLK_COUNT; /* Limited by sd_page_num */
+
+	dev_set_drvdata(&pdev->dev, host);
+	spmmc_controller_init(host);
+	mode = (int)of_device_get_match_data(&pdev->dev);
+	spmmc_select_mode(host);
+	mmc_add_host(mmc);
+	host->tuning_info.enable_tuning = 1;
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
+	return ret;
+
+probe_free_host:
+	if (mmc)
+		mmc_free_host(mmc);
+
+	return ret;
+}
+
+static int spmmc_drv_remove(struct platform_device *dev)
+{
+	struct spmmc_host *host = platform_get_drvdata(dev);
+
+	mmc_remove_host(host->mmc);
+	clk_disable(host->clk);
+	clk_unprepare(host->clk);
+	pm_runtime_disable(&dev->dev);
+	platform_set_drvdata(dev, NULL);
+	mmc_free_host(host->mmc);
+
+	return 0;
+}
+
+static int spmmc_drv_suspend(struct platform_device *dev, pm_message_t state)
+{
+	struct spmmc_host *host;
+
+	host = platform_get_drvdata(dev);
+	mutex_lock(&host->mrq_lock); /* Make sure that no one is holding the controller */
+	mutex_unlock(&host->mrq_lock);
+	clk_disable(host->clk);
+
+	return 0;
+}
+
+static int spmmc_drv_resume(struct platform_device *dev)
+{
+	struct spmmc_host *host;
+
+	host = platform_get_drvdata(dev);
+
+	return clk_enable(host->clk);
+}
+
+static int spmmc_pm_suspend(struct device *dev)
+{
+	pm_runtime_force_suspend(dev);
+
+	return 0;
+}
+
+static int spmmc_pm_resume(struct device *dev)
+{
+	pm_runtime_force_resume(dev);
+
+	return 0;
+}
+
+static int spmmc_pm_runtime_suspend(struct device *dev)
+{
+	struct spmmc_host *host;
+
+	host = dev_get_drvdata(dev);
+	clk_disable(host->clk);
+
+	return 0;
+}
+
+static int spmmc_pm_runtime_resume(struct device *dev)
+{
+	struct spmmc_host *host;
+
+	host = dev_get_drvdata(dev);
+
+	return clk_enable(host->clk);
+}
+
+static const struct dev_pm_ops spmmc_pm_ops = {
+	SYSTEM_SLEEP_PM_OPS(spmmc_pm_suspend, spmmc_pm_resume)
+	RUNTIME_PM_OPS(spmmc_pm_runtime_suspend, spmmc_pm_runtime_resume, NULL)
+};
+
+static const struct of_device_id spmmc_of_table[] = {
+	{
+		.compatible = "sunplus,sp7021-mmc",
+	},
+	{/* sentinel */}
+};
+MODULE_DEVICE_TABLE(of, spmmc_of_table);
+
+static struct platform_driver spmmc_driver = {
+	.probe = spmmc_drv_probe,
+	.remove = spmmc_drv_remove,
+	.suspend = spmmc_drv_suspend,
+	.resume = spmmc_drv_resume,
+	.driver = {
+		.name = "spmmc",
+#ifdef CONFIG_PM
+		.pm = &spmmc_pm_ops,
+#endif
+		.of_match_table = spmmc_of_table,
+	},
+};
+module_platform_driver(spmmc_driver);
+
+MODULE_AUTHOR("Tony Huang <tonyhuang.sunplus@gmail.com>");
+MODULE_AUTHOR("Li-hao Kuo <lhjeff911@gmail.com>");
+MODULE_DESCRIPTION("Sunplus MMC controller driver");
+MODULE_LICENSE("GPL");
-- 
2.7.4


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2478F4DE50D
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 02:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241782AbiCSBvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 21:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241771AbiCSBvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 21:51:23 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376DA220B2E;
        Fri, 18 Mar 2022 18:50:00 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id k6so1276860plg.12;
        Fri, 18 Mar 2022 18:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=akY/TVrjnhZTFaXn0FLoao9oWXd5Yl4BsvkRBN9BeJE=;
        b=cy6pjDjxkN+IlpWuET4PLWc1jM+Gsq4AW+KUsfBMpx1XQBi6b8EXepCTp1wn1e5tBX
         qQF/Ze5kfREaQvcR16VhS7/FKb/vD0Plr2LsvuDpAHQkYWlsTHmfdvJWdcPLrzf8GJVB
         rFxd2IQ2U7c1TSYRFv0P4kWV/wN/9MzUunpwPpw7QgU/KZ0+U1PlmaVkEsT9IF/5v5P7
         AZ/oLWBx7XqPgl1U12a3juWaCVOXxH0ks+gU111hHX+/35cmw53KegKAqWQC/Idqb03t
         WOZAOxGwqf+PdYasDECMTdLn7mN33uR7YaYQSp3Eiy4EG7L1T8wYDdIrHjDB4JmuzP9x
         EQOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=akY/TVrjnhZTFaXn0FLoao9oWXd5Yl4BsvkRBN9BeJE=;
        b=Hml5VJCTAS9hyedaLdhBttxlnNeVpEnwk4jZ093w5ackwOem8V1c+L6Mp62S41lDmc
         eduKplCCNYWdG+EuAmMbJ60Fb7nXmaKBPLeG0TezqmdRaOTeowZ6FxBXpYKqcIeZQFT8
         iBlvlnn6QSOZAhxMRCUTd1r6Rtz0CRz8yCybor67k+jjR/37fXY2dai3/0IQ+qAkV1vf
         VX5jzsfv2L9tWu5QM6HU4rbTmOTA30iCafPUjnJUZcov5r0k1yDgL3QiT4YsChNhtMgK
         Jfye10FTV6zgUfjjd/GtgbUuBKt1jhwc5Vy/ktIUaKxjpGmuxD7bGsoB702AMTsQtK9A
         92Lw==
X-Gm-Message-State: AOAM532+dMuDX/QeRrVyj1Ac/dAFA7X6qPYJ4OO6Vn/39GMm5q6RQlXh
        YsZfNPnWFu1c8zzbLcjZzeU=
X-Google-Smtp-Source: ABdhPJxCMkYL1YsNK/ukkt3A1sBXKpHD5vjkl1p4D0/VFl62p0qbXHXnA7BSZkMuSVHNDZ/T+EqB/A==
X-Received: by 2002:a17:90b:4a8d:b0:1bf:a379:938c with SMTP id lp13-20020a17090b4a8d00b001bfa379938cmr25054164pjb.129.1647654599205;
        Fri, 18 Mar 2022 18:49:59 -0700 (PDT)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id h13-20020a056a00230d00b004f427ffd485sm11738659pfh.143.2022.03.18.18.49.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Mar 2022 18:49:58 -0700 (PDT)
From:   Tony Huang <tonyhuang.sunplus@gmail.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, lhjeff911@gmail.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, p.zabel@pengutronix.de
Cc:     wells.lu@sunplus.com, tony.huang@sunplus.com,
        Tony Huang <tonyhuang.sunplus@gmail.com>
Subject: [PATCH v4 2/2] mmc: Add mmc driver for Sunplus SP7021
Date:   Sat, 19 Mar 2022 09:50:12 +0800
Message-Id: <f954fb1c0d1c4950b71a8fc360c78edcca9954de.1647652688.git.tonyhuang.sunplus@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1647652688.git.tonyhuang.sunplus@gmail.com>
References: <cover.1647652688.git.tonyhuang.sunplus@gmail.com>
In-Reply-To: <cover.1647652688.git.tonyhuang.sunplus@gmail.com>
References: <cover.1647652688.git.tonyhuang.sunplus@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add mmc driver for Sunplus SP7021

Signed-off-by: Tony Huang <tonyhuang.sunplus@gmail.com>
---
Changes in v4:
 - combine sdcard and eMMC into one driver.

 MAINTAINERS                    |    1 +
 drivers/mmc/host/Kconfig       |    9 +
 drivers/mmc/host/Makefile      |    1 +
 drivers/mmc/host/sunplus_mmc.c | 2195 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 2206 insertions(+)
 create mode 100644 drivers/mmc/host/sunplus_mmc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 2d91431..451adba 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18247,6 +18247,7 @@ M:	Tony Huang <tonyhuang.sunplus@gmail.com>
 M:  Li-hao Kuo <lhjeff911@gmail.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/mmc/sunplu,mmc.yaml
+F:	drivers/mmc/host/sunplus_mmc.c
 
 SUPERH
 M:	Yoshinori Sato <ysato@users.sourceforge.jp>
diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 5af8494..285daa1 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -14,6 +14,15 @@ config MMC_DEBUG
 	  added host drivers please don't invent their private macro for
 	  debugging.
 
+config MMC_SUNPLUS
+	tristate "Sunplus SP7021 MMC Controller"
+	depends on ARCH_SUNPLUS
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
index ea36d37..e6958e7 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -97,6 +97,7 @@ obj-$(CONFIG_MMC_SDHCI_MICROCHIP_PIC32)	+= sdhci-pic32.o
 obj-$(CONFIG_MMC_SDHCI_BRCMSTB)		+= sdhci-brcmstb.o
 obj-$(CONFIG_MMC_SDHCI_OMAP)		+= sdhci-omap.o
 obj-$(CONFIG_MMC_SDHCI_SPRD)		+= sdhci-sprd.o
+obj-$(CONFIG_MMC_SUNPLUS)		+= sunplus_mmc.o
 obj-$(CONFIG_MMC_CQHCI)			+= cqhci.o
 cqhci-y					+= cqhci-core.o
 cqhci-$(CONFIG_MMC_CRYPTO)		+= cqhci-crypto.o
diff --git a/drivers/mmc/host/sunplus_mmc.c b/drivers/mmc/host/sunplus_mmc.c
new file mode 100644
index 0000000..a3cb408
--- /dev/null
+++ b/drivers/mmc/host/sunplus_mmc.c
@@ -0,0 +1,2195 @@
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
+#define SPMMC_MODE_SD			0
+#define SPMMC_MODE_EMMC			1
+#define SPMMC_MODE_SDIO			2
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
+struct spmmc_tuning_info {
+	int enable_tuning;
+	int need_tuning;
+#define SPMMC_MAX_RETRIES (8 * 8)
+	int retried; /* how many times has been retried */
+	u32 rd_crc_dly:3;
+	u32 rd_dat_dly:3;
+	u32 rd_rsp_dly:3;
+	u32 wr_cmd_dly:3;
+	u32 wr_dat_dly:3;
+	u32 clk_dly:3;
+};
+
+struct spmmc_compatible {
+	u8 mode;
+	u32 min_clk;
+	u32 max_clk;
+	u32 max_blk_count;
+	u32 max_dma_memory_sectors;
+	u32 blk_size;
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
+/* Produces a mask of set bits covering a range of a 32-bit value */
+static inline u32 bitfield_mask(u32 shift, u32 width)
+{
+	return ((1 << width) - 1) << shift;
+}
+
+#define SPSDC_MIN_CLK			400000
+#define SPSDC_MAX_CLK			52000000
+#define SPSDC_50M_CLK			50000000
+#define SPSDC_MAX_BLK_COUNT		65536
+
+#define SPSD2_MEDIA_TYPE_REG		0x0000
+#define SPSDC_MEDIA_MASK		GENMASK(2, 0)
+#define SPSDC_MEDIA_NONE		0
+#define SPSDC_MEDIA_SD			6
+#define SPSDC_MEDIA_MS			7
+
+#define SPSD2_SDRAM_SECTOR_SIZE_REG	0x0010
+#define SPSDC_MAX_DMA_MEMORY_SECTORS	8
+
+#define SPSD2_SDRAM_SECTOR_ADDR_REG	0x001C
+#define SPSD2_SD_INT_REG		0x00B0
+#define SPSDC_SDINT_SDCMPEN		BIT(0)
+#define SPSDC_SDINT_SDCMP		BIT(1)
+#define SPSDC_SDINT_SDCMP_CLR		BIT(2)
+#define SPSDC_SDINT_SDIOEN		BIT(4)
+#define SPSDC_SDINT_SDIO		BIT(5)
+#define SPSDC_SDINT_SDIO_CLR		BIT(6)
+
+#define SPSD2_SD_PAGE_NUM_REG		0x00B4
+#define SPSD2_SD_CONF0_REG		0x00B8
+#define SPSDC_CONF0_SDPIO_MODE		BIT(0)
+#define SPSDC_CONF0_SDLEN_MODE		BIT(2)
+#define SPSDC_CONF0_TRANS_MODE		GENMASK(5, 4)
+#define SPSDC_TRANS_CMD_MODE		0
+#define SPSDC_TRANS_WR_MODE		1
+#define SPSDC_TRANS_RD_MODE		2
+#define SPSDC_CONF0_AUTORSP		BIT(6)
+#define SPSDC_CONF0_CMDDUMMY		BIT(7)
+#define SPSDC_CONF0_RSPCHK		BIT(8)
+
+#define SPSD2_SDIO_CTRL_REG		0x00BC
+#define SPSDC_SDIO_CTRL_MULTI_TRIG	BIT(6)
+
+#define SPSD2_SD_RST_REG		0x00C0
+#define SPSDC_RST_ALL			0x07
+
+#define SPSD2_SD_CONF_REG		0x00C4
+#define SPSDC_CONF_CLK_DIV		GENMASK(11, 0)
+#define SPSDC_CONF_4BIT_MODE		BIT(12)
+#define SPSDC_CONF_SDRSP_TYPE		BIT(13)
+#define SPSDC_CONF_SD_MODE		BIT(16)
+#define SPSDC_CONF_MMC8BIT		BIT(18)
+#define SPSDC_CONF_SDIO_MODE		BIT(20)
+
+#define SPSD2_SD_CTRL_REG		0x00C8
+#define SPSDC_CTRL_CMD_TRIG		BIT(0)
+#define SPSDC_CTRL_TXDUMMY_TRIG		BIT(1)
+
+#define SPSD2_SD_STATUS_REG		0x00CC
+#define SPSDC_STS_DUMMY_RDY		BIT(0)
+#define SPSDC_STS_RSP_BUF_FULL		BIT(1)
+#define SPSDC_STS_TX_BUF_EMP		BIT(2)
+#define SPSDC_STS_RX_BUF_FULL		BIT(3)
+#define SPSDC_STS_CMD_PIN_STS		BIT(4)
+#define SPSDC_STS_DAT0_PIN_STS		BIT(5)
+#define SPSDC_STS_RSP_TIMEOUT		BIT(6)
+#define SPSDC_STS_CARD_CRC_TIMEOUT	BIT(7)
+#define SPSDC_STS_STB_TIMEOUT		BIT(8)
+#define SPSDC_STS_RSP_CRC7_ERR		BIT(9)
+#define SPSDC_STS_CRC_TOKEN_ERR		BIT(10)
+#define SPSDC_STS_RDATA_CRC16_ERR	BIT(11)
+#define SPSDC_STS_SUSPEND_STATE_RDY	BIT(12)
+#define SPSDC_STS_BUSY_CYCLE		BIT(13)
+
+#define SPSD2_SD_STATE_REG		0x00D0
+#define SPSDC_STATE_IDLE		(0x0)
+#define SPSDC_STATE_TXDUMMY		(0x1)
+#define SPSDC_STATE_TXCMD		(0x2)
+#define SPSDC_STATE_RXRSP		(0x3)
+#define SPSDC_STATE_TXDATA		(0x4)
+#define SPSDC_STATE_RXCRC		(0x5)
+#define SPSDC_STATE_RXDATA		(0x6)
+#define SPSDC_STATE_MASK		(0x7)
+#define SPSDC_STATE_ERROR		BIT(13)
+#define SPSDC_STATE_FINISH		BIT(14)
+
+#define SPSD2_BLOCKSIZE_REG		0x00D4
+#define SPSD2_SD_TIMING_CONF0_REG	0x00DC
+#define SPSDC_TIMING_CONF0_HS_EN	BIT(11)
+#define SPSDC_TIMING_CONF0_WRTD		GENMASK(14, 12)
+
+#define SPSD2_SD_TIMING_CONF1_REG	0x00E0
+#define SPSDC_TIMING_CONF1_RDTD		GENMASK(15, 13)
+
+#define SPSD2_SD_PIO_TX_REG		0x00E4
+#define SPSD2_SD_PIO_RX_REG		0x00E8
+#define SPSD2_SD_CMD_BUF0_REG		0x00EC
+#define SPSD2_SD_CMD_BUF1_REG		0x00F0
+#define SPSD2_SD_CMD_BUF2_REG		0x00F4
+#define SPSD2_SD_CMD_BUF3_REG		0x00F8
+#define SPSD2_SD_CMD_BUF4_REG		0x00FC
+#define SPSD2_SD_RSP_BUF0_3_REG		0x0100
+#define SPSD2_SD_RSP_BUF4_5_REG		0x0104
+#define SPSD2_DMA_SRCDST_REG		0x0204
+#define SPSD2_DMA_SIZE_REG		0x0208
+#define SPSD2_DMA_STOP_RST_REG		0x020c
+#define SPSD2_DMA_CTRL_REG		0x0210
+#define SPSD2_DMA_BASE_ADDR0_REG	0x0214
+#define SPSD2_DMA_BASE_ADDR16_REG	0x0218
+
+struct spsdc_tuning_info {
+	int need_tuning;
+#define SPSDC_MAX_RETRIES (8 * 8)
+	int retried; /* how many times has been retried */
+	u32 wr_dly:3;
+	u32 rd_dly:3;
+	u32 clk_dly:3;
+};
+
+enum {
+	SPSDC_DMA_MODE = 0,
+	SPSDC_PIO_MODE = 1,
+};
+
+enum SPSDC_MODE {
+	SPSDC_MODE_SD = 0,
+	SPSDC_MODE_SDIO = 1,
+};
+
+struct spmmc_host {
+	void __iomem *base;
+	struct clk *clk;
+	struct reset_control *rstc;
+	int mode; /* SD/SDIO/eMMC */
+	spinlock_t lock; /* controller lock */
+	struct mutex mrq_lock;
+	/* tasklet used to handle error then finish the request */
+	struct tasklet_struct tsklet_finish_req;
+	struct mmc_host *mmc;
+	struct mmc_request *mrq; /* current mrq */
+
+	int irq;
+	int use_int; /* should raise irq when done? */
+	int power_state; /* current power state: off/up/on */
+	int ddr_enabled;
+	int signal_voltage;
+#define SPMMC_DMA_MODE 0
+#define SPMMC_PIO_MODE 1
+	int dmapio_mode;
+	/* for purpose of reducing context switch, only when transfer data that*/
+	/* length is greater than `dma_int_threshold' should use interrupt */
+	int dma_int_threshold;
+	struct sg_mapping_iter sg_miter; /* for pio mode to access sglist */
+	int dma_use_int; /* should raise irq when dma done */
+	struct spmmc_tuning_info emmc_tuning_info;
+	struct spsdc_tuning_info sd_tuning_info;
+	int restore_4bit_sdio_bus;
+	const struct spmmc_compatible *dev_comp;
+};
+
+struct spsdc_host {
+	void __iomem *base;
+	struct clk *clk;
+	struct reset_control *rstc;
+	spinlock_t lock; /* controller lock */
+	struct mmc_host *mmc;
+	/* protects data accesses */
+	struct mutex mrq_lock;
+	struct mmc_request *mrq; /* current mrq */
+	struct sg_mapping_iter sg_miter; /* for pio mode to access sglist */
+	struct spsdc_tuning_info tuning_info;
+	/* tasklet used to handle error then finish the request */
+	struct tasklet_struct tsklet_finish_req;
+	int irq;
+	int mode; /* SD/SDIO*/
+	int use_int; /* should raise irq when done */
+	int power_state; /* current power state: off/up/on */
+	int dmapio_mode;
+	int dma_use_int; /* should raise irq when dma done */
+	int dma_int_threshold;
+	int restore_4bit_sdio_bus;
+};
+
+static const struct spmmc_compatible emmc = {
+	.mode = SPMMC_MODE_EMMC,
+	.min_clk = SPMMC_MIN_CLK,
+	.max_clk = SPMMC_MAX_CLK,
+	.max_blk_count = SPMMC_MAX_BLK_COUNT,
+	.max_dma_memory_sectors = SPMMC_MAX_DMA_MEMORY_SECTORS,
+	.blk_size = 512,
+};
+
+static const struct spmmc_compatible sd = {
+	.mode = SPMMC_MODE_SD,
+	.min_clk = SPSDC_MIN_CLK,
+	.max_clk = SPSDC_MAX_CLK,
+	.max_blk_count = SPSDC_MAX_BLK_COUNT,
+	.max_dma_memory_sectors = SPSDC_MAX_DMA_MEMORY_SECTORS,
+	.blk_size = 512,
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
+		value &= ~SPMMC_SD_HIGH_SPEED_EN;
+		value |= FIELD_PREP(SPMMC_SD_HIGH_SPEED_EN, 1); /* sd_high_speed_en */
+		writel(value, host->base + SPMMC_SD_CONFIG1_REG);
+		value = readl(host->base + SPMMC_SD_TIMING_CONFIG0_REG);
+		value &= ~SPMMC_SD_WRITE_DATA_DELAY;
+		value |= FIELD_PREP(SPMMC_SD_WRITE_DATA_DELAY, delay); /* sd_wr_dat_dly_sel */
+		value &= ~SPMMC_SD_WRITE_COMMAND_DELAY;
+		value |= FIELD_PREP(SPMMC_SD_WRITE_COMMAND_DELAY, delay); /* sd_wr_cmd_dly_sel */
+		writel(value, host->base + SPMMC_SD_TIMING_CONFIG0_REG);
+	} else {
+		value &= ~SPMMC_SD_HIGH_SPEED_EN;
+		value |= FIELD_PREP(SPMMC_SD_HIGH_SPEED_EN, 0);
+		writel(value, host->base + SPMMC_SD_CONFIG1_REG);
+	}
+	if (host->ddr_enabled) {
+		value = readl(host->base + SPMMC_SD_CONFIG0_REG);
+		value &= ~SPMMC_SD_DDR_MODE;
+		value |= FIELD_PREP(SPMMC_SD_DDR_MODE, 1); /* sdddrmode */
+		writel(value, host->base + SPMMC_SD_CONFIG0_REG);
+	} else {
+		value = readl(host->base + SPMMC_SD_CONFIG0_REG);
+		value &= ~SPMMC_SD_DDR_MODE;
+		value |= FIELD_PREP(SPMMC_SD_DDR_MODE, 0);
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
+		value |= FIELD_PREP(SPMMC_SD_DATA_WD, 0);
+		value &= ~SPMMC_MMC8_EN;
+		value |= FIELD_PREP(SPMMC_MMC8_EN, 1);
+		break;
+	case MMC_BUS_WIDTH_4:
+		value &= ~SPMMC_SD_DATA_WD;
+		value |= FIELD_PREP(SPMMC_SD_DATA_WD, 1);
+		value &= ~SPMMC_MMC8_EN;
+		value |= FIELD_PREP(SPMMC_MMC8_EN, 0);
+		break;
+	default:
+		value &= ~SPMMC_SD_DATA_WD;
+		value |= FIELD_PREP(SPMMC_SD_DATA_WD, 0);
+		value &= ~SPMMC_MMC8_EN;
+		value |= FIELD_PREP(SPMMC_MMC8_EN, 0);
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
+	value &= ~SPMMC_SD_MMC_MODE;
+	value |= FIELD_PREP(SPMMC_SD_MMC_MODE, 1);
+	value &= ~SPMMC_SDIO_MODE;
+	value |= FIELD_PREP(SPMMC_SDIO_MODE, 0);
+	writel(value, host->base + SPMMC_SD_CONFIG0_REG);
+}
+
+static void spmmc_sw_reset(struct spmmc_host *host)
+{
+	u32 value;
+
+	/* Must reset dma operation first, or it will*/
+	/* be stuck on sd_state == 0x1c00 because of*/
+	/* a controller software reset bug */
+	value = readl(host->base + SPMMC_HW_DMA_CTRL_REG);
+	value &= ~SPMMC_DMAIDLE;
+	value |= FIELD_PREP(SPMMC_DMAIDLE, 1);
+	writel(value, host->base + SPMMC_HW_DMA_CTRL_REG);
+	value &= ~SPMMC_DMAIDLE;
+	value |= FIELD_PREP(SPMMC_DMAIDLE, 0);
+	writel(value, host->base + SPMMC_HW_DMA_CTRL_REG);
+	value = readl(host->base + SPMMC_HW_DMA_CTRL_REG);
+	value &= ~SPMMC_HW_DMA_RST;
+	value |= FIELD_PREP(SPMMC_HW_DMA_RST, 1);
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
+	value &= ~SPMMC_SDINT_SDCMPCLR;
+	value |= FIELD_PREP(SPMMC_SDINT_SDCMPCLR, 1); /* sd_cmp_clr */
+	if (likely(!host->use_int || cmd->flags & MMC_RSP_136)) {
+		value &= ~SPMMC_SDINT_SDCMPEN;
+		value |= FIELD_PREP(SPMMC_SDINT_SDCMPEN, 0); /* sdcmpen */
+	} else {
+		value &= ~SPMMC_SDINT_SDCMPEN;
+		value |= FIELD_PREP(SPMMC_SDINT_SDCMPEN, 1);
+	}
+	writel(value, host->base + SPMMC_SD_INT_REG);
+
+	value = readl(host->base + SPMMC_SD_CONFIG0_REG);
+	value &= ~SPMMC_SD_TRANS_MODE;
+	value |= FIELD_PREP(SPMMC_SD_TRANS_MODE, 0); /* sd_trans_mode */
+	value &= ~SPMMC_SD_CMD_DUMMY;
+	value |= FIELD_PREP(SPMMC_SD_CMD_DUMMY, 1); /* sdcmddummy */
+	if (likely(cmd->flags & MMC_RSP_PRESENT)) {
+		value &= ~SPMMC_SD_AUTO_RESPONSE;
+		value |= FIELD_PREP(SPMMC_SD_AUTO_RESPONSE, 1); /* sdautorsp */
+	} else {
+		value &= ~SPMMC_SD_AUTO_RESPONSE;
+		value |= FIELD_PREP(SPMMC_SD_AUTO_RESPONSE, 0);
+		writel(value, host->base + SPMMC_SD_CONFIG0_REG);
+
+		return;
+	}
+	/*
+	 * Currently, host is not capable of checking R2's CRC7,
+	 * thus, enable crc7 check only for 48 bit response commands
+	 */
+	if (likely(cmd->flags & MMC_RSP_CRC && !(cmd->flags & MMC_RSP_136))) {
+		value &= ~SPMMC_SD_RSP_CHK_EN;
+		value |= FIELD_PREP(SPMMC_SD_RSP_CHK_EN, 1); /* sdrspchk_en */
+	} else {
+		value &= ~SPMMC_SD_RSP_CHK_EN;
+		value |= FIELD_PREP(SPMMC_SD_RSP_CHK_EN, 0);
+	}
+
+	if (unlikely(cmd->flags & MMC_RSP_136)) {
+		value &= ~SPMMC_SD_RSP_TYPE;
+		value |= FIELD_PREP(SPMMC_SD_RSP_TYPE, 1); /* sdrsptype */
+	} else {
+		value &= ~SPMMC_SD_RSP_TYPE;
+		value |= FIELD_PREP(SPMMC_SD_RSP_TYPE, 0);
+	}
+	writel(value, host->base + SPMMC_SD_CONFIG0_REG);
+}
+
+static void spmmc_prepare_data(struct spmmc_host *host, struct mmc_data *data)
+{
+	u32 value, srcdst;
+	//struct mmc_command *cmd = data->mrq->cmd;
+
+	writel(data->blocks - 1, host->base + SPMMC_SD_PAGE_NUM_REG);
+	writel(data->blksz - 1, host->base + SPMMC_SD_BLOCKSIZE_REG);
+	value = readl(host->base + SPMMC_SD_CONFIG0_REG);
+	if (data->flags & MMC_DATA_READ) {
+		value &= ~SPMMC_SD_TRANS_MODE;
+		value |= FIELD_PREP(SPMMC_SD_TRANS_MODE, 2); /* sd_trans_mode */
+		value &= ~SPMMC_SD_AUTO_RESPONSE;
+		value |= FIELD_PREP(SPMMC_SD_AUTO_RESPONSE, 0); /* sdautorsp */
+		value &= ~SPMMC_SD_CMD_DUMMY;
+		value |= FIELD_PREP(SPMMC_SD_CMD_DUMMY, 0); /* sdcmddummy */
+		srcdst = readl(host->base + SPMMC_CARD_MEDIATYPE_SRCDST_REG);
+		srcdst &= ~SPMMC_DMA_SOURCE;
+		srcdst |= FIELD_PREP(SPMMC_DMA_SOURCE, 0x2);
+		srcdst &= ~SPMMC_DMA_DESTINATION;
+		srcdst |= FIELD_PREP(SPMMC_DMA_DESTINATION, 0x1);
+		writel(srcdst, host->base + SPMMC_CARD_MEDIATYPE_SRCDST_REG);
+	} else {
+		value &= ~SPMMC_SD_TRANS_MODE;
+		value |= FIELD_PREP(SPMMC_SD_TRANS_MODE, 1);
+		srcdst = readl(host->base + SPMMC_CARD_MEDIATYPE_SRCDST_REG);
+		srcdst &= ~SPMMC_DMA_SOURCE;
+		srcdst |= FIELD_PREP(SPMMC_DMA_SOURCE, 0x1);
+		srcdst &= ~SPMMC_DMA_DESTINATION;
+		srcdst |= FIELD_PREP(SPMMC_DMA_DESTINATION, 0x2);
+		writel(srcdst, host->base + SPMMC_CARD_MEDIATYPE_SRCDST_REG);
+	}
+	value &= ~SPMMC_SD_LEN_MODE;
+	value |= FIELD_PREP(SPMMC_SD_LEN_MODE, 1);
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
+		value &= ~SPMMC_SD_PIO_MODE;
+		value |= FIELD_PREP(SPMMC_SD_PIO_MODE, 0); /* sdpiomode */
+		writel(value, host->base + SPMMC_SD_CONFIG0_REG);
+		/* enable interrupt if needed */
+		if (!host->use_int && data->blksz * data->blocks > host->dma_int_threshold) {
+			host->dma_use_int = 1;
+			value = readl(host->base + SPMMC_SD_INT_REG);
+			value &= ~SPMMC_SDINT_SDCMPEN;
+			value |= FIELD_PREP(SPMMC_SDINT_SDCMPEN, 1); /* sdcmpen */
+			writel(value, host->base + SPMMC_SD_INT_REG);
+		}
+	} else {
+		value &= ~SPMMC_SD_PIO_MODE;
+		value |= FIELD_PREP(SPMMC_SD_PIO_MODE, 1);
+		value &= ~SPMMC_RX4_EN;
+		value |= FIELD_PREP(SPMMC_RX4_EN, 1); /* rx4_en */
+		writel(value, host->base + SPMMC_SD_CONFIG0_REG);
+	}
+}
+
+static inline void spmmc_trigger_transaction(struct spmmc_host *host)
+{
+	u32 value = readl(host->base + SPMMC_SD_CTRL_REG);
+
+	value &= ~SPMMC_NEW_COMMAND_TRIGGER;
+	value |= FIELD_PREP(SPMMC_NEW_COMMAND_TRIGGER, 1); /* trigger transaction */
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
+		if (host->emmc_tuning_info.enable_tuning) {
+			timing_cfg0 = readl(host->base + SPMMC_SD_TIMING_CONFIG0_REG);
+			host->emmc_tuning_info.rd_crc_dly = FIELD_GET(SPMMC_SD_READ_CRC_DELAY,
+								      timing_cfg0);
+			host->emmc_tuning_info.rd_dat_dly = FIELD_GET(SPMMC_SD_READ_DATA_DELAY,
+								      timing_cfg0);
+			host->emmc_tuning_info.rd_rsp_dly = FIELD_GET(SPMMC_SD_READ_RESPONSE_DELAY,
+								      timing_cfg0);
+			host->emmc_tuning_info.wr_cmd_dly = FIELD_GET(SPMMC_SD_WRITE_COMMAND_DELAY,
+								      timing_cfg0);
+			host->emmc_tuning_info.wr_dat_dly = FIELD_GET(SPMMC_SD_WRITE_DATA_DELAY,
+								      timing_cfg0);
+		}
+
+		if (value & SPMMC_SDSTATUS_RSP_TIMEOUT) {
+			ret = -ETIMEDOUT;
+			host->emmc_tuning_info.wr_cmd_dly++;
+		} else if (value & SPMMC_SDSTATUS_RSP_CRC7_ERROR) {
+			ret = -EILSEQ;
+			host->emmc_tuning_info.rd_rsp_dly++;
+		} else if (data) {
+			if ((value & SPMMC_SDSTATUS_STB_TIMEOUT)) {
+				ret = -ETIMEDOUT;
+				host->emmc_tuning_info.rd_dat_dly++;
+			} else if (value & SPMMC_SDSTATUS_RDATA_CRC16_ERROR) {
+				ret = -EILSEQ;
+				host->emmc_tuning_info.rd_dat_dly++;
+			} else if (value & SPMMC_SDSTATUS_CARD_CRC_CHECK_TIMEOUT) {
+				ret = -ETIMEDOUT;
+				host->emmc_tuning_info.rd_crc_dly++;
+			} else if (value & SPMMC_SDSTATUS_CRC_TOKEN_CHECK_ERROR) {
+				ret = -EILSEQ;
+				if (crc_token == 0x5)
+					host->emmc_tuning_info.wr_dat_dly++;
+				else
+					host->emmc_tuning_info.rd_crc_dly++;
+			}
+		}
+		cmd->error = ret;
+		if (data) {
+			data->error = ret;
+			data->bytes_xfered = 0;
+		}
+		if (!host->emmc_tuning_info.need_tuning && host->emmc_tuning_info.enable_tuning)
+			cmd->retries = SPMMC_MAX_RETRIES; /* retry it */
+		spmmc_sw_reset(host);
+		mdelay(5);
+
+		if (host->emmc_tuning_info.enable_tuning) {
+			timing_cfg0 |= FIELD_PREP(SPMMC_SD_READ_CRC_DELAY,
+						       host->emmc_tuning_info.rd_crc_dly);
+			timing_cfg0 |= FIELD_PREP(SPMMC_SD_READ_DATA_DELAY,
+						       host->emmc_tuning_info.rd_dat_dly);
+			timing_cfg0 |= FIELD_PREP(SPMMC_SD_READ_RESPONSE_DELAY,
+						       host->emmc_tuning_info.rd_rsp_dly);
+			timing_cfg0 |= FIELD_PREP(SPMMC_SD_WRITE_COMMAND_DELAY,
+						       host->emmc_tuning_info.wr_cmd_dly);
+			timing_cfg0 |= FIELD_PREP(SPMMC_SD_WRITE_DATA_DELAY,
+						       host->emmc_tuning_info.wr_dat_dly);
+			writel(timing_cfg0, host->base + SPMMC_SD_TIMING_CONFIG0_REG);
+		}
+	} else if (data) {
+		data->error = 0;
+		data->bytes_xfered = data->blocks * data->blksz;
+	}
+	host->emmc_tuning_info.need_tuning = ret;
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
+	int f, w;
+
+	if (!candidate_dly)
+		return 0;
+	f = ffs(candidate_dly) - 1;
+	w = hweight8(candidate_dly);
+	if (0xff == (bitfield_mask(f, w) & ~candidate_dly))
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
+	value &= ~SPMMC_TX_DUMMY_NUM;
+	value |= FIELD_PREP(SPMMC_TX_DUMMY_NUM, count);
+	writel(value, host->base + SPMMC_SD_CONFIG1_REG);
+	value = readl(host->base + SPMMC_SD_CTRL_REG);
+	value &= ~SPMMC_DUMMY_CLOCK_TRIGGER;
+	value |= FIELD_PREP(SPMMC_DUMMY_CLOCK_TRIGGER, 1); /* trigger tx dummy */
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
+		mdelay(1);
+		ret = reset_control_deassert(host->rstc);
+	}
+
+	value = readl(host->base + SPMMC_CARD_MEDIATYPE_SRCDST_REG);
+	value &= ~SPMMC_MEDIA_TYPE;
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
+	mutex_unlock(&host->mrq_lock);
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
+		value &= ~SPMMC_SDINT_SDCMPEN;
+		value |= FIELD_PREP(SPMMC_SDINT_SDCMPEN, 0); /* disable sdcmp */
+		value &= ~SPMMC_SDINT_SDCMPCLR;
+		value |= FIELD_PREP(SPMMC_SDINT_SDCMPCLR, 1); /* sd_cmp_clr */
+		writel(value, host->base + SPMMC_SD_INT_REG);
+		/* if error occurred, we my need send cmd 12 to stop data transaction,*/
+		/* which is time consuming, so make use of tasklet to handle this.*/
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
+	int ret;
+
+	ret = mutex_lock_interruptible(&host->mrq_lock);
+	if (ret)
+		return;
+
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
+		mutex_unlock(&host->mrq_lock);
+		mmc_request_done(host->mmc, mrq);
+	} else {
+		if (data)
+			spmmc_prepare_data(host, data);
+
+		if (unlikely(host->dmapio_mode == SPMMC_PIO_MODE && data)) {
+			u32 value;
+			/* pio data transfer do not use interrupt */
+			value = readl(host->base + SPMMC_SD_INT_REG);
+			value &= ~SPMMC_SDINT_SDCMPEN;
+			value |= FIELD_PREP(SPMMC_SDINT_SDCMPEN, 0); /* sdcmpen */
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
+/**
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
+	host->emmc_tuning_info.enable_tuning = 0;
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
+		value &= ~SPMMC_SD_READ_RESPONSE_DELAY;
+		value |= FIELD_PREP(SPMMC_SD_READ_RESPONSE_DELAY, smpl_dly);
+		value &= ~SPMMC_SD_READ_DATA_DELAY;
+		value |= FIELD_PREP(SPMMC_SD_READ_DATA_DELAY, smpl_dly);
+		value &= ~SPMMC_SD_READ_CRC_DELAY;
+		value |= FIELD_PREP(SPMMC_SD_READ_CRC_DELAY, smpl_dly);
+		writel(value, host->base + SPMMC_SD_TIMING_CONFIG0_REG);
+
+		mmc_wait_for_req(mmc, &mrq);
+		if (!cmd.error && !data.error) {
+			if (!memcmp(blk_pattern, blk_test, blksz))
+				candidate_dly |= (1 << smpl_dly);
+		}
+	} while (smpl_dly++ <= SPMMC_MAX_TUNABLE_DLY);
+	host->emmc_tuning_info.enable_tuning = 1;
+
+	if (candidate_dly) {
+		smpl_dly = __find_best_delay(candidate_dly);
+		value = readl(host->base + SPMMC_SD_TIMING_CONFIG0_REG);
+		value &= ~SPMMC_SD_READ_RESPONSE_DELAY;
+		value |= FIELD_PREP(SPMMC_SD_READ_RESPONSE_DELAY, smpl_dly);
+		value &= ~SPMMC_SD_READ_DATA_DELAY;
+		value |= FIELD_PREP(SPMMC_SD_READ_DATA_DELAY, smpl_dly);
+		value &= ~SPMMC_SD_READ_CRC_DELAY;
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
+	if (enable) {
+		value &= ~SPMMC_SDINT_SDIOEN;
+		value |= FIELD_PREP(SPMMC_SDINT_SDIOEN, 1);
+	} else {
+		value &= ~SPMMC_SDINT_SDIOEN;
+		value |= FIELD_PREP(SPMMC_SDINT_SDIOEN, 0);
+	}
+	writel(value, host->base + SPMMC_SD_INT_REG);
+}
+
+static inline int spsdc_wait_finish(struct spmmc_host *host)
+{
+	/* Wait for transaction finish */
+	unsigned long timeout = jiffies + msecs_to_jiffies(5000);
+
+	while (!time_after(jiffies, timeout)) {
+		if (readl(host->base + SPSD2_SD_STATE_REG) & SPSDC_STATE_FINISH)
+			return 0;
+		if (readl(host->base + SPSD2_SD_STATE_REG) & SPSDC_STATE_ERROR)
+			return -EIO;
+	}
+
+	return -ETIMEDOUT;
+}
+
+static inline int spsdc_wait_sdstatus(struct spmmc_host *host, unsigned int status_bit)
+{
+	unsigned long timeout = jiffies + msecs_to_jiffies(5000);
+
+	while (!time_after(jiffies, timeout)) {
+		if (readl(host->base + SPSD2_SD_STATUS_REG) & status_bit)
+			return 0;
+		if (readl(host->base + SPSD2_SD_STATE_REG) & SPSDC_STATE_ERROR)
+			return -EIO;
+	}
+
+	return -ETIMEDOUT;
+}
+
+#define spsdc_wait_rspbuf_full(host) spsdc_wait_sdstatus(host, SPSDC_STS_RSP_BUF_FULL)
+#define spsdc_wait_rxbuf_full(host) spsdc_wait_sdstatus(host, SPSDC_STS_RX_BUF_FULL)
+#define spsdc_wait_txbuf_empty(host) spsdc_wait_sdstatus(host, SPSDC_STS_TX_BUF_EMP)
+
+static void spsdc_get_rsp(struct spmmc_host *host, struct mmc_command *cmd)
+{
+	u32 value0_3, value4_5;
+
+	if (unlikely(!(cmd->flags & MMC_RSP_PRESENT)))
+		return;
+	if (unlikely(cmd->flags & MMC_RSP_136)) {
+		if (spsdc_wait_rspbuf_full(host))
+			return;
+		value0_3 = readl(host->base + SPSD2_SD_RSP_BUF0_3_REG);
+		value4_5 = readl(host->base + SPSD2_SD_RSP_BUF4_5_REG) & 0xffff;
+		cmd->resp[0] = (value0_3 << 8) | (value4_5 >> 8);
+		cmd->resp[1] = value4_5 << 24;
+		if (spsdc_wait_rspbuf_full(host))
+			return;
+		value0_3 = readl(host->base + SPSD2_SD_RSP_BUF0_3_REG);
+		value4_5 = readl(host->base + SPSD2_SD_RSP_BUF4_5_REG) & 0xffff;
+		cmd->resp[1] |= value0_3 >> 8;
+		cmd->resp[2] = value0_3 << 24;
+		cmd->resp[2] |= value4_5 << 8;
+		if (spsdc_wait_rspbuf_full(host))
+			return;
+		value0_3 = readl(host->base + SPSD2_SD_RSP_BUF0_3_REG);
+		value4_5 = readl(host->base + SPSD2_SD_RSP_BUF4_5_REG) & 0xffff;
+		cmd->resp[2] |= value0_3 >> 24;
+		cmd->resp[3] = value0_3 << 8;
+		cmd->resp[3] |= value4_5 >> 8;
+	} else {
+		if (spsdc_wait_rspbuf_full(host))
+			return;
+		value0_3 = readl(host->base + SPSD2_SD_RSP_BUF0_3_REG);
+		value4_5 = readl(host->base + SPSD2_SD_RSP_BUF4_5_REG) & 0xffff;
+		cmd->resp[0] = (value0_3 << 8) | (value4_5 >> 8);
+		cmd->resp[1] = value4_5 << 24;
+	}
+}
+
+static void spsdc_set_bus_clk(struct spmmc_host *host, int clk)
+{
+	unsigned int clkdiv;
+	int f_min = host->mmc->f_min;
+	int f_max = host->mmc->f_max;
+	u32 value = readl(host->base + SPSD2_SD_CONF_REG);
+
+	if (clk < f_min)
+		clk = f_min;
+	if (clk > f_max)
+		clk = f_max;
+
+	// SD 2.0 only max set to 50Mhz CLK
+	if (clk >= SPSDC_50M_CLK)
+		clk = f_max;
+
+	clkdiv = (clk_get_rate(host->clk) + clk) / clk - 1;
+	if (clkdiv > 0xfff)
+		clkdiv = 0xfff;
+
+	value &= ~SPSDC_CONF_CLK_DIV;
+	value |= FIELD_PREP(SPSDC_CONF_CLK_DIV, clkdiv);
+	writel(value, host->base + SPSD2_SD_CONF_REG);
+	/*
+	 *In order to reduce the frequency of context switch,
+	 * if it is high speed or upper, we do not use interrupt
+	 * when send a command that without data.
+	 */
+	if (clk > 25000000)
+		host->use_int = 0;
+	else
+		host->use_int = 1;
+}
+
+static void spsdc_set_bus_timing(struct spmmc_host *host, unsigned int timing)
+{
+	u32 value = readl(host->base + SPSD2_SD_TIMING_CONF0_REG);
+	int clkdiv = FIELD_GET(SPSDC_CONF_CLK_DIV, readl(host->base + SPSD2_SD_CONF_REG));
+	int delay = (clkdiv / 2 < 7) ? clkdiv / 2 : 7;
+
+	switch (timing) {
+	case MMC_TIMING_LEGACY:
+		value &= ~SPSDC_TIMING_CONF0_HS_EN;
+		break;
+	case MMC_TIMING_SD_HS:
+	case MMC_TIMING_MMC_HS:
+		value |= SPSDC_TIMING_CONF0_HS_EN |
+			FIELD_PREP(SPSDC_TIMING_CONF0_WRTD, delay);
+		break;
+	}
+	writel(value, host->base + SPSD2_SD_TIMING_CONF0_REG);
+}
+
+static void spsdc_set_bus_width(struct spmmc_host *host, int width)
+{
+	u32 value = readl(host->base + SPSD2_SD_CONF_REG);
+
+	switch (width) {
+	case MMC_BUS_WIDTH_8:
+		value &= ~SPSDC_CONF_4BIT_MODE;
+		value |= SPSDC_CONF_MMC8BIT;
+		break;
+	case MMC_BUS_WIDTH_4:
+		value |= SPSDC_CONF_4BIT_MODE;
+		value &= ~SPSDC_CONF_MMC8BIT;
+		break;
+	default:
+		value &= ~SPSDC_CONF_4BIT_MODE;
+		value &= ~SPSDC_CONF_MMC8BIT;
+		break;
+	};
+	writel(value, host->base + SPSD2_SD_CONF_REG);
+}
+
+/*
+ * select the working mode of controller: sd/sdio/emmc
+ */
+static void spsdc_select_mode(struct spmmc_host *host)
+{
+	u32 value = readl(host->base + SPSD2_SD_CONF_REG);
+
+	/*
+	 *set `sdmmcmode', as it will sample data at fall edge
+	 * of SD bus clock if `sdmmcmode' is not set when
+	 * `sd_high_speed_en' is not set, which is not compliant
+	 * with SD specification
+	 */
+	value |= SPSDC_CONF_SD_MODE;
+	switch (host->dev_comp->mode) {
+	case SPMMC_MODE_SDIO:
+		value |= SPSDC_CONF_SDIO_MODE;
+		writel(value, host->base + SPSD2_SD_CONF_REG);
+		value = readl(host->base + SPSD2_SDIO_CTRL_REG);
+		value |= SPSDC_SDIO_CTRL_MULTI_TRIG;
+		writel(value, host->base + SPSD2_SDIO_CTRL_REG);
+		break;
+	case SPMMC_MODE_SD:
+	default:
+		value &= ~SPSDC_CONF_SDIO_MODE;
+		host->mode = SPSDC_MODE_SD;
+		writel(value, host->base + SPSD2_SD_CONF_REG);
+		break;
+	}
+}
+
+static void spsdc_sw_reset(struct spmmc_host *host)
+{
+	writel(SPSDC_RST_ALL, host->base + SPSD2_SD_RST_REG);
+	writel(0x6, host->base + SPSD2_DMA_STOP_RST_REG);
+	while (readl(host->base + SPSD2_DMA_STOP_RST_REG) & BIT(2))
+		;
+	/* reset dma operation */
+	writel(0x0, host->base + SPSD2_DMA_CTRL_REG);
+	writel(0x1, host->base + SPSD2_DMA_CTRL_REG);
+	writel(0x0, host->base + SPSD2_DMA_CTRL_REG);
+}
+
+static void spsdc_prepare_cmd(struct spmmc_host *host, struct mmc_command *cmd)
+{
+	u32 value;
+
+	writeb((cmd->opcode | 0x40), host->base + SPSD2_SD_CMD_BUF0_REG);
+	writeb(((cmd->arg >> 24) & 0xff), host->base + SPSD2_SD_CMD_BUF1_REG);
+	writeb(((cmd->arg >> 16) & 0xff), host->base + SPSD2_SD_CMD_BUF2_REG);
+	writeb(((cmd->arg >> 8) & 0xff), host->base + SPSD2_SD_CMD_BUF3_REG);
+	writeb(((cmd->arg >> 0) & 0xff), host->base + SPSD2_SD_CMD_BUF4_REG);
+	/* disable interrupt if needed */
+	value = readl(host->base + SPSD2_SD_INT_REG);
+	value |= SPSDC_SDINT_SDCMP_CLR;
+	if (likely(!host->use_int || cmd->flags & MMC_RSP_136))
+		value &= ~SPSDC_SDINT_SDCMPEN;
+	else
+		value |= SPSDC_SDINT_SDCMPEN;
+	writel(value, host->base + SPSD2_SD_INT_REG);
+
+	value = readl(host->base + SPSD2_SD_CONF0_REG);
+	value &= ~SPSDC_CONF0_TRANS_MODE; /* sd_trans_mode = 0 cmd mode */
+	value |= SPSDC_CONF0_CMDDUMMY;
+	if (likely(cmd->flags & MMC_RSP_PRESENT)) {
+		value |= SPSDC_CONF0_AUTORSP;
+	} else {
+		value &= ~SPSDC_CONF0_AUTORSP;
+		writel(value, host->base + SPSD2_SD_CONF0_REG);
+
+		return;
+	}
+	/*
+	 * Currently, host is not capable of checking R2's CRC7,
+	 * thus, enable crc7 check only for 48 bit response commands
+	 */
+	if (likely(cmd->flags & MMC_RSP_CRC && !(cmd->flags & MMC_RSP_136)))
+		value |= SPSDC_CONF0_RSPCHK;
+	else
+		value &= ~SPSDC_CONF0_RSPCHK;
+
+	writel(value, host->base + SPSD2_SD_CONF0_REG);
+	value = readl(host->base + SPSD2_SD_CONF_REG);
+	if (unlikely(cmd->flags & MMC_RSP_136))
+		value |= SPSDC_CONF_SDRSP_TYPE;
+	else
+		value &= ~SPSDC_CONF_SDRSP_TYPE;
+	writel(value, host->base + SPSD2_SD_CONF_REG);
+}
+
+static void spsdc_prepare_data(struct spmmc_host *host, struct mmc_data *data)
+{
+	u32 value;
+
+	writel(data->blocks - 1, host->base + SPSD2_SD_PAGE_NUM_REG);
+	writel(data->blksz - 1, host->base + SPSD2_BLOCKSIZE_REG);
+	value = readl(host->base + SPSD2_SD_CONF0_REG);
+	value &= ~SPSDC_CONF0_TRANS_MODE;
+	if (data->flags & MMC_DATA_READ) {
+		value &= ~(SPSDC_CONF0_AUTORSP | SPSDC_CONF0_CMDDUMMY);
+		value |= FIELD_PREP(SPSDC_CONF0_TRANS_MODE, SPSDC_TRANS_RD_MODE);
+		writel(0x12, host->base + SPSD2_DMA_SRCDST_REG);
+	} else {
+		value |= FIELD_PREP(SPSDC_CONF0_TRANS_MODE, SPSDC_TRANS_WR_MODE);
+		writel(0x21, host->base + SPSD2_DMA_SRCDST_REG);
+	}
+	/*
+	 *to prevent of the responses of CMD18/25 being by CMD12's,
+	 * send CMD12 by ourself instead of by controller automatically
+	 *
+	 *	#if 0
+	 *	if ((cmd->opcode == MMC_READ_MULTIPLE_BLOCK)
+	 *	 || (cmd->opcode == MMC_WRITE_MULTIPLE_BLOCK))
+	 *		value = bitfield_replace(value, 2, 1, 0); //sd_len_mode
+	 *	else
+	 *		value = bitfield_replace(value, 2, 1, 1);
+	 *	#endif
+	 */
+	value |= SPSDC_CONF0_SDLEN_MODE;
+	if (likely(host->dmapio_mode == SPSDC_DMA_MODE)) {
+		struct scatterlist *sg;
+		dma_addr_t dma_addr;
+		unsigned int dma_size;
+		void __iomem *reg_addr;
+		int dma_direction = data->flags & MMC_DATA_READ ? DMA_FROM_DEVICE : DMA_TO_DEVICE;
+		int i, count = dma_map_sg(host->mmc->parent, data->sg, data->sg_len, dma_direction);
+
+		if (unlikely(!count || count > SPSDC_MAX_DMA_MEMORY_SECTORS)) {
+			data->error = -EINVAL;
+
+			return;
+		}
+		for_each_sg(data->sg, sg, count, i) {
+			dma_addr = sg_dma_address(sg);
+			/* dma_size = sg_dma_len(sg) / 512 - 1; */
+			dma_size = sg_dma_len(sg) / data->blksz - 1;
+			if (i == 0) {
+				writel(dma_addr, host->base + SPSD2_DMA_BASE_ADDR0_REG);
+				writel(dma_addr >> 16, host->base + SPSD2_DMA_BASE_ADDR16_REG);
+				writel(dma_size, host->base + SPSD2_SDRAM_SECTOR_SIZE_REG);
+			} else {
+				reg_addr = host->base + (SPSD2_SDRAM_SECTOR_ADDR_REG + (i - 1) * 8);
+				writel(dma_addr, reg_addr);
+				writel(dma_size, reg_addr + 4);
+			}
+		}
+		value &= ~SPSDC_CONF0_SDPIO_MODE;
+		writel(value, host->base + SPSD2_SD_CONF0_REG);
+		writel(data->blksz - 1, host->base + SPSD2_DMA_SIZE_REG);
+		/* enable interrupt if needed */
+		if (!host->use_int && data->blksz * data->blocks > host->dma_int_threshold) {
+			host->dma_use_int = 1;
+			value = readl(host->base + SPSD2_SD_INT_REG);
+			value |= SPSDC_SDINT_SDCMPEN;
+			writel(value, host->base + SPSD2_SD_INT_REG);
+		}
+	} else {
+		value |= SPSDC_CONF0_SDPIO_MODE;
+		writel(value, host->base + SPSD2_SD_CONF0_REG);
+	}
+}
+
+static inline void spsdc_trigger_transaction(struct spmmc_host *host)
+{
+	u32 value = readl(host->base + SPSD2_SD_CTRL_REG);
+
+	value |= SPSDC_CTRL_CMD_TRIG;
+	writel(value, host->base + SPSD2_SD_CTRL_REG);
+}
+
+static int spsdc_send_stop_cmd(struct spmmc_host *host, struct mmc_command *stop)
+{
+	u32 value;
+
+	spsdc_prepare_cmd(host, stop);
+	value = readl(host->base + SPSD2_SD_INT_REG);
+	value &= ~SPSDC_SDINT_SDCMPEN;
+	writel(value, host->base + SPSD2_SD_INT_REG);
+	spsdc_trigger_transaction(host);
+	if (spsdc_wait_finish(host)) {
+		value = readl(host->base + SPSD2_SD_STATUS_REG);
+		if (value & SPSDC_STS_RSP_CRC7_ERR)
+			stop->error = -EILSEQ;
+		else
+			stop->error = -ETIMEDOUT;
+
+		return -1;
+	}
+	spsdc_get_rsp(host, stop);
+
+	return 0;
+}
+
+static int __switch_sdio_bus_width(struct spmmc_host *host, int width)
+{
+	struct mmc_command cmd = {0};
+	int ret = 0;
+	u32 value;
+	u8 ctrl;
+
+	cmd.opcode = SD_IO_RW_DIRECT;
+	cmd.arg |= SDIO_CCCR_IF << 9;
+	cmd.flags = MMC_RSP_R5;
+	spsdc_prepare_cmd(host, &cmd);
+	value = readl(host->base + SPSD2_SD_INT_REG);
+	value &= ~SPSDC_SDINT_SDCMPEN;
+	writel(value, host->base + SPSD2_SD_INT_REG);
+	spsdc_trigger_transaction(host);
+	ret = spsdc_wait_finish(host);
+	if (ret) {
+		spsdc_sw_reset(host);
+
+		return ret;
+	}
+	spsdc_get_rsp(host, &cmd);
+	ctrl = cmd.resp[0] & 0xff;
+
+	ctrl &= ~SDIO_BUS_WIDTH_MASK;
+	if (width == MMC_BUS_WIDTH_4) {
+		/* set to 4-bit bus width */
+		ctrl |= SDIO_BUS_WIDTH_4BIT;
+	}
+
+	cmd.arg |= 0x80000000;
+	cmd.arg |= ctrl;
+	spsdc_prepare_cmd(host, &cmd);
+	value = readl(host->base + SPSD2_SD_INT_REG);
+	value |= ~SPSDC_SDINT_SDCMPEN;
+	writel(value, host->base + SPSD2_SD_INT_REG);
+	spsdc_trigger_transaction(host);
+	ret = spsdc_wait_finish(host);
+	if (ret) {
+		spsdc_sw_reset(host);
+
+		return ret;
+	}
+	spsdc_get_rsp(host, &cmd);
+	spsdc_set_bus_width(host, width);
+
+	return ret;
+}
+
+/*
+ * check if error during transaction.
+ * @host -  host
+ * @mrq - the mrq
+ * @return 0 if no error otherwise the error number.
+ */
+static int spsdc_check_error(struct spmmc_host *host, struct mmc_request *mrq)
+{
+	struct mmc_command *cmd = mrq->cmd;
+	struct mmc_data *data = mrq->data;
+	int ret = 0;
+	u32 value = readl(host->base + SPSD2_SD_STATE_REG);
+
+	if (unlikely(value & SPSDC_STATE_ERROR)) {
+		u32 timing_cfg0, timing_cfg1;
+
+		value = readl(host->base + SPSD2_SD_STATUS_REG);
+		timing_cfg0 = readl(host->base + SPSD2_SD_TIMING_CONF0_REG);
+		host->sd_tuning_info.wr_dly = FIELD_GET(SPSDC_TIMING_CONF0_WRTD, timing_cfg0);
+		timing_cfg1 = readl(host->base + SPSD2_SD_TIMING_CONF1_REG);
+		host->sd_tuning_info.rd_dly = FIELD_GET(SPSDC_TIMING_CONF1_RDTD, timing_cfg1);
+		if (value & SPSDC_STS_RSP_TIMEOUT) {
+			ret = -ETIMEDOUT;
+			host->sd_tuning_info.wr_dly++;
+		} else if (value & SPSDC_STS_RSP_CRC7_ERR) {
+			ret = -EILSEQ;
+			host->sd_tuning_info.rd_dly++;
+		}
+		if (data) {
+			if ((value & SPSDC_STS_STB_TIMEOUT) ||
+			    (value & SPSDC_STS_CARD_CRC_TIMEOUT)) {
+				ret = -ETIMEDOUT;
+				host->sd_tuning_info.rd_dly++;
+			} else if (value & SPSDC_STS_CRC_TOKEN_ERR) {
+				ret = -EILSEQ;
+				host->sd_tuning_info.wr_dly++;
+			} else if (value & SPSDC_STS_RDATA_CRC16_ERR) {
+				ret = -EILSEQ;
+				host->sd_tuning_info.rd_dly++;
+			}
+			data->error = ret;
+			data->bytes_xfered = 0;
+		}
+		cmd->error = ret;
+		if (!host->sd_tuning_info.need_tuning)
+			cmd->retries = SPSDC_MAX_RETRIES; /* retry it */
+		spsdc_sw_reset(host);
+		timing_cfg0 |= FIELD_PREP(SPSDC_TIMING_CONF0_WRTD, host->sd_tuning_info.wr_dly);
+		writel(timing_cfg0, host->base + SPSD2_SD_TIMING_CONF0_REG);
+		timing_cfg1 |= FIELD_PREP(SPSDC_TIMING_CONF1_RDTD, host->sd_tuning_info.rd_dly);
+		writel(timing_cfg1, host->base + SPSD2_SD_TIMING_CONF1_REG);
+
+	} else if (data) {
+		data->bytes_xfered = data->blocks * data->blksz;
+	}
+	host->sd_tuning_info.need_tuning = ret;
+
+	return ret;
+}
+
+static inline __maybe_unused void spsdc_txdummy(struct spmmc_host *host)
+{
+	u32 value = readl(host->base + SPSD2_SD_CTRL_REG);
+
+	value |= SPSDC_CTRL_TXDUMMY_TRIG;
+	writel(value, host->base + SPSD2_SD_CTRL_REG);
+}
+
+static void spsdc_xfer_data_pio(struct spmmc_host *host, struct mmc_data *data)
+{
+	int data_left = data->blocks * data->blksz;
+	int consumed, remain;
+	struct sg_mapping_iter *sg_miter = &host->sg_miter;
+	unsigned int flags = 0;
+	u16 *buf; /* tx/rx 2 bytes one time in pio mode */
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
+				if (spsdc_wait_txbuf_empty(host))
+					goto done;
+				writel(*buf, host->base + SPSD2_SD_PIO_TX_REG);
+			} else {
+				if (spsdc_wait_rxbuf_full(host))
+					goto done;
+				*buf = readl(host->base + SPSD2_SD_PIO_RX_REG);
+			}
+			buf++;
+			consumed += 2;
+			remain -= 2;
+		} while (remain);
+		sg_miter->consumed = consumed;
+		data_left -= consumed;
+	}
+done:
+	sg_miter_stop(sg_miter);
+}
+
+static void spsdc_controller_init(struct spmmc_host *host)
+{
+	u32 value;
+	int ret = reset_control_assert(host->rstc);
+
+	if (!ret) {
+		usleep_range(1000, 1250);
+		ret = reset_control_deassert(host->rstc);
+	}
+	value = readl(host->base + SPSD2_MEDIA_TYPE_REG);
+	value &= ~SPSDC_MEDIA_MASK;
+	value |= FIELD_PREP(SPSDC_MEDIA_MASK, SPSDC_MEDIA_SD);
+	writel(value, host->base + SPSD2_MEDIA_TYPE_REG);
+}
+
+static void spsdc_set_power_mode(struct spmmc_host *host, struct mmc_ios *ios)
+{
+	if (host->power_state == ios->power_mode)
+		return;
+
+	switch (ios->power_mode) {
+		/* power off->up->on */
+	case MMC_POWER_ON:
+		spsdc_controller_init(host);
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
+static void spsdc_finish_request(struct spmmc_host *host, struct mmc_request *mrq)
+{
+	struct mmc_command *cmd;
+	struct mmc_data *data;
+
+	if (!mrq)
+		return;
+
+	cmd = mrq->cmd;
+	data = mrq->data;
+	if (data && SPSDC_DMA_MODE == host->dmapio_mode) {
+		int dma_direction = data->flags & MMC_DATA_READ ? DMA_FROM_DEVICE : DMA_TO_DEVICE;
+
+		dma_unmap_sg(host->mmc->parent, data->sg, data->sg_len, dma_direction);
+		host->dma_use_int = 0;
+	}
+	spsdc_get_rsp(host, cmd);
+	spsdc_check_error(host, mrq);
+	if (mrq->stop) {
+		if (spsdc_send_stop_cmd(host, mrq->stop))
+			spsdc_sw_reset(host);
+	}
+	host->mrq = NULL;
+
+	if (host->restore_4bit_sdio_bus) {
+		__switch_sdio_bus_width(host, MMC_BUS_WIDTH_4);
+		host->restore_4bit_sdio_bus = 0;
+	}
+	mutex_unlock(&host->mrq_lock);
+	mmc_request_done(host->mmc, mrq);
+}
+
+/* Interrupt Service Routine */
+static irqreturn_t spsdc_irq(int irq, void *dev_id)
+{
+	struct spmmc_host *host = dev_id;
+	u32 value = readl(host->base + SPSD2_SD_INT_REG);
+
+	spin_lock(&host->lock);
+	if ((value & SPSDC_SDINT_SDCMP) && (value & SPSDC_SDINT_SDCMPEN)) {
+		value &= ~SPSDC_SDINT_SDCMP;
+		value |= SPSDC_SDINT_SDCMP_CLR;
+		writel(value, host->base + SPSD2_SD_INT_REG);
+		/*
+		 * we may need send stop command to stop data transaction,
+		 * which is time consuming, so make use of tasklet to handle this.
+		 */
+		if (host->mrq && host->mrq->stop)
+			tasklet_schedule(&host->tsklet_finish_req);
+		else
+			spsdc_finish_request(host, host->mrq);
+	}
+	if ((value & SPSDC_SDINT_SDIO) && (value & SPSDC_SDINT_SDIOEN))
+		mmc_signal_sdio_irq(host->mmc);
+	spin_unlock(&host->lock);
+
+	return IRQ_HANDLED;
+}
+
+static void spsdc_request(struct mmc_host *mmc, struct mmc_request *mrq)
+{
+	struct spmmc_host *host = mmc_priv(mmc);
+	struct mmc_command *cmd;
+	struct mmc_data *data;
+	int bus_width = mmc->ios.bus_width;
+	int ret;
+
+	ret = mutex_lock_interruptible(&host->mrq_lock);
+	if (ret)
+		return;
+
+	host->mrq = mrq;
+	data = mrq->data;
+	cmd = mrq->cmd;
+	if (cmd->opcode == SD_IO_RW_EXTENDED && bus_width == MMC_BUS_WIDTH_4 &&
+	    data->blocks * data->blksz <= 4) {
+		if (__switch_sdio_bus_width(host, MMC_BUS_WIDTH_1)) {
+			cmd->error = -1;
+			host->mrq = NULL;
+			mutex_unlock(&host->mrq_lock);
+			mmc_request_done(host->mmc, mrq);
+			return;
+		}
+		host->restore_4bit_sdio_bus = 1;
+	}
+
+	spsdc_prepare_cmd(host, cmd);
+	/* we need manually read response R2. */
+	if (unlikely(cmd->flags & MMC_RSP_136)) {
+		spsdc_trigger_transaction(host);
+		spsdc_get_rsp(host, cmd);
+		spsdc_wait_finish(host);
+		spsdc_check_error(host, mrq);
+		host->mrq = NULL;
+		mutex_unlock(&host->mrq_lock);
+		mmc_request_done(host->mmc, mrq);
+	} else {
+		if (data)
+			spsdc_prepare_data(host, data);
+		if ((host->dmapio_mode && data) ==  SPSDC_PIO_MODE) {
+			u32 value;
+			/* pio data transfer do not use interrupt */
+			value = readl(host->base + SPSD2_SD_INT_REG);
+			value &= ~SPSDC_SDINT_SDCMPEN;
+			writel(value, host->base + SPSD2_SD_INT_REG);
+			spsdc_trigger_transaction(host);
+			spsdc_xfer_data_pio(host, data);
+			spsdc_wait_finish(host);
+			spsdc_finish_request(host, mrq);
+		} else {
+			if (!(host->use_int || host->dma_use_int)) {
+				spsdc_trigger_transaction(host);
+				spsdc_wait_finish(host);
+				spsdc_finish_request(host, mrq);
+			} else {
+				spsdc_trigger_transaction(host);
+			}
+		}
+	}
+}
+
+static void spsdc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	struct spmmc_host *host = (struct spmmc_host *)mmc_priv(mmc);
+
+	mutex_lock(&host->mrq_lock);
+	spsdc_set_power_mode(host, ios);
+	spsdc_set_bus_clk(host, ios->clock);
+	spsdc_set_bus_timing(host, ios->timing);
+	spsdc_set_bus_width(host, ios->bus_width);
+	/* ensure mode is correct, because we might have hw reset the controller */
+	spsdc_select_mode(host);
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
+static int spsdc_get_cd(struct mmc_host *mmc)
+{
+	int ret = 0;
+
+	if (mmc_can_gpio_cd(mmc))
+		ret = mmc_gpio_get_cd(mmc);
+	if (ret < 0)
+		ret = 0;
+
+	return ret;
+}
+
+static void spsdc_enable_sdio_irq(struct mmc_host *mmc, int enable)
+{
+	struct spmmc_host *host = mmc_priv(mmc);
+	u32 value = readl(host->base + SPSD2_SD_INT_REG);
+
+	value |= SPSDC_SDINT_SDIO_CLR;
+	if (enable)
+		value |= SPSDC_SDINT_SDIOEN;
+	else
+		value &= ~SPSDC_SDINT_SDIOEN;
+	writel(value, host->base + SPSD2_SD_INT_REG);
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
+static const struct mmc_host_ops spsdc_ops = {
+	.request = spsdc_request,
+	.set_ios = spsdc_set_ios,
+	.get_cd = spsdc_get_cd,
+	.enable_sdio_irq = spsdc_enable_sdio_irq,
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
+static void spsdc_disable_unprepare(void *data)
+{
+	clk_disable_unprepare(data);
+}
+
+static void spsdc_reset_control_assert(void *data)
+{
+	reset_control_assert(data);
+}
+
+static const struct of_device_id spmmc_of_table[] = {
+	{
+		.compatible = "sunplus,mmc-v2",
+		.data = &emmc,
+	},
+	{	.compatible = "sunplus,mmc-v1",
+		.data = &sd,
+	},
+	{/* sentinel */}
+};
+MODULE_DEVICE_TABLE(of, spmmc_of_table);
+
+static int spmmc_drv_probe(struct platform_device *pdev)
+{
+	struct mmc_host *mmc;
+	struct resource *res;
+	struct spmmc_host *host;
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
+	host->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
+	if (IS_ERR(host->base))
+		return PTR_ERR(host->base);
+
+	host->irq = platform_get_irq(pdev, 0);
+	if (host->irq <= 0)
+		return host->irq;
+
+	host->dev_comp = of_device_get_match_data(&pdev->dev);
+	if (host->dev_comp->mode == SPMMC_MODE_EMMC) {
+		ret = devm_request_irq(&pdev->dev, host->irq, spmmc_irq, IRQF_SHARED,
+				       dev_name(&pdev->dev), host);
+	} else {
+		ret = devm_request_irq(&pdev->dev, host->irq, spsdc_irq, IRQF_SHARED,
+				       dev_name(&pdev->dev), host);
+	}
+	if (ret)
+		return ret;
+
+	host->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(host->clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(host->clk), "clk get fail\n");
+
+	host->rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
+	if (IS_ERR(host->rstc))
+		return dev_err_probe(&pdev->dev, PTR_ERR(host->rstc), "rst get fail\n");
+
+	ret = clk_prepare_enable(host->clk);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "failed to enable clk\n");
+
+	host->dev_comp = of_device_get_match_data(&pdev->dev);
+	if (host->dev_comp->mode == SPMMC_MODE_SD || host->dev_comp->mode == SPMMC_MODE_SDIO) {
+		ret = devm_add_action_or_reset(&pdev->dev, spsdc_disable_unprepare, host->clk);
+		if (ret)
+			return ret;
+
+		ret = reset_control_deassert(host->rstc);
+		if (ret)
+			return dev_err_probe(&pdev->dev, ret, "failed to deassert reset\n");
+
+		ret = devm_add_action_or_reset(&pdev->dev, spsdc_reset_control_assert, host->rstc);
+		if (ret)
+			return ret;
+	}
+
+	ret = mmc_of_parse(mmc);
+	if (ret)
+		goto probe_free_host;
+
+	spin_lock_init(&host->lock);
+	mutex_init(&host->mrq_lock);
+	tasklet_init(&host->tsklet_finish_req, tsklet_func_finish_req, (unsigned long)host);
+	if (host->dev_comp->mode == SPMMC_MODE_EMMC)
+		mmc->ops = &spmmc_ops;
+	else
+		mmc->ops = &spsdc_ops;
+	mmc->f_min = host->dev_comp->min_clk;
+	if (mmc->f_max > host->dev_comp->max_clk)
+		mmc->f_max = host->dev_comp->max_clk;
+	mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
+	mmc->max_seg_size = host->dev_comp->max_blk_count * 512;
+	mmc->max_segs = host->dev_comp->max_dma_memory_sectors;
+	mmc->max_req_size = host->dev_comp->max_blk_count * 512;
+	/* Limited by the max value of dma_size & data_length, set it to 512 bytes for now */
+	mmc->max_blk_size = 512;
+	mmc->max_blk_count = host->dev_comp->max_blk_count; /* Limited by sd_page_num */
+
+	dev_set_drvdata(&pdev->dev, host);
+	spmmc_controller_init(host);
+	if (host->dev_comp->mode == SPMMC_MODE_EMMC)
+		spmmc_select_mode(host);
+	else
+		spsdc_select_mode(host);
+	mmc_add_host(mmc);
+	if (host->dev_comp->mode == SPMMC_MODE_EMMC)
+		host->emmc_tuning_info.enable_tuning = 1;
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
+#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
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
+#endif /* ifdef CONFIG_PM_SLEEP */
+
+#ifdef CONFIG_PM_RUNTIME
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
+#endif /* ifdef CONFIG_PM_RUNTIME */
+
+static const struct dev_pm_ops spmmc_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(spmmc_pm_suspend, spmmc_pm_resume)
+#ifdef CONFIG_PM_RUNTIME
+	SET_RUNTIME_PM_OPS(spmmc_pm_runtime_suspend, spmmc_pm_runtime_resume, NULL)
+#endif
+};
+#endif /* ifdef CONFIG_PM */
+
+static struct platform_driver spmmc_driver = {
+	.probe = spmmc_drv_probe,
+	.remove = spmmc_drv_remove,
+	.suspend = spmmc_drv_suspend,
+	.resume = spmmc_drv_resume,
+	.driver = {
+		.name = "spmmc",
+		.owner = THIS_MODULE,
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


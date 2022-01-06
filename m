Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E19448691A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 18:48:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242375AbiAFRsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 12:48:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242372AbiAFRsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 12:48:16 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7429BC061245;
        Thu,  6 Jan 2022 09:48:15 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id y17so3013307qtx.9;
        Thu, 06 Jan 2022 09:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3+gEd6diJjv0ts0t5S9IH5jv4RaDam3rlLSQTANpbOA=;
        b=HRYCl9V9iVllKkqYKG6CEJEv8esRgJlc8b/P4ETB0gFkj4TixB8L7HqzznGX97jn6Z
         UGcJlegS7QaMONq3IIZ5p0ALNoM7Q3eNQ18wukP63Q2vJ+B2ls9O7v9nBoiUFrVFUu7R
         PO7fgLrVV//re02rRIxGOdW5yDupyIakZOYyrsQT7Kb92Nvc4g8znv6HIaruH5Otoq06
         MZyIHfgKqsf0oNFdO5R03VeRGXJMzeTbw/qQ3hCgV3rDLelh0PytIrywmcx4GHRo31TK
         TUEyLlQ/tLaq4JHjczEpObKmuN/UFIMlV2lEQE7+7WlymKYZ01SFa5j5PSyrTIoWN0Fx
         ptLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3+gEd6diJjv0ts0t5S9IH5jv4RaDam3rlLSQTANpbOA=;
        b=YSaSljNtUhvV9Wb6IHxnB1Qqjl6ETmr2raAd1NSfyQYOWgJrBJ4cOdbQB+2rOis6ds
         XBN//LdkAo4lkRYi8wAIqmY10W1mc4jyDn2QvYtV5obCCC5s+KUTSWNN1jbEasnmdMGS
         FpQz0Bf9NYeKY3J+v8BiPtcYvGl5cZCw8O1rxiGbZhDWFuQj+gnuD8Bi1nc4eGOWTREt
         I/5WlcCo/VtLO0K8T21LThxGCmXZ2uWfEX9rqHq+JlQrBBaVyytxixS+1+iNmVs9ApjD
         9B5v7+7FnYbyG7uqACqq5jy7Z6CK2BL/tLPFgRi75sk5fRAqtAWCsCF4pTQ0peygyL7s
         tdqw==
X-Gm-Message-State: AOAM531L0gxJOkQGylJ5RXLkSFoOZOh0cwP7f+MSD/S9syi6qrET04G7
        Aafh3F/MeuZiHd8aGxZ0aIc8CUYXTuXFDw==
X-Google-Smtp-Source: ABdhPJySrXQfdZR07tXx5FUNd33PIS/u/tqN/Oy8TSh4D5SPMq/65/Q3NXY/0NBlCaUrxb10LZd1Xg==
X-Received: by 2002:a05:622a:10e:: with SMTP id u14mr52738921qtw.493.1641491294243;
        Thu, 06 Jan 2022 09:48:14 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id u19sm1709227qke.1.2022.01.06.09.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 09:48:13 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        kgugala@antmicro.com, mholenko@antmicro.com, krakoczy@antmicro.com,
        mdudek@internships.antmicro.com, paulus@ozlabs.org, joel@jms.id.au,
        shorne@gmail.com, geert@linux-m68k.org,
        david.abdurachmanov@sifive.com, florent@enjoy-digital.fr,
        rdunlap@infradead.org, andy.shevchenko@gmail.com
Subject: [PATCH v6 3/3] mmc: Add driver for LiteX's LiteSDCard interface
Date:   Thu,  6 Jan 2022 12:48:03 -0500
Message-Id: <20220106174803.1773876-4-gsomlo@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220106174803.1773876-1-gsomlo@gmail.com>
References: <20220106174803.1773876-1-gsomlo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LiteX (https://github.com/enjoy-digital/litex) is a SoC framework
that targets FPGAs. LiteSDCard is a small footprint, configurable
SDCard core commonly used in LiteX designs.

The driver was first written in May 2020 and has been maintained
cooperatively by the LiteX community. Thanks to all contributors!

Co-developed-by: Kamil Rakoczy <krakoczy@antmicro.com>
Signed-off-by: Kamil Rakoczy <krakoczy@antmicro.com>
Co-developed-by: Maciej Dudek <mdudek@internships.antmicro.com>
Signed-off-by: Maciej Dudek <mdudek@internships.antmicro.com>
Co-developed-by: Paul Mackerras <paulus@ozlabs.org>
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
Cc: Mateusz Holenko <mholenko@antmicro.com>
Cc: Karol Gugala <kgugala@antmicro.com>
Cc: Joel Stanley <joel@jms.id.au>
Cc: Stafford Horne <shorne@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: David Abdurachmanov <david.abdurachmanov@sifive.com>
Cc: Florent Kermarrec <florent@enjoy-digital.fr>
Reviewed-by: Joel Stanley <joel@jms.id.au>
---

New in v6:
  - fix handling of deferred probe vs. platform_get_irq_optional()
  - don't #ifdef dma_set_mask_and_coherent(), since it automatically
    does the right thing on both 32- and 64-bit DMA capable arches
  - remove MMC_CAP2_FULL_PWR_CYCLE, add MMC_CAP2_NO_MMC to list of
    hardcoded capabilities during litex_mmc_probe()
  - hardcode mmc->ocr_avail to the full 2.7-3.6V range allowed by the
    SDCard spec (the LiteSDCard device doesn't accept software
    configuration)

>New in v5:
>  - shorter #define constant names (cosmetic, make them less unwieldy)
>  - picked up reviewed-by Joel
>
>>New in v4:
>>  - struct litex_mmc_host fields re-ordered so that `pahole` reports
>>    no holes on either 32- or 64-bit builds
>>  - litex_mmc_set_bus_width() now encapsulates check for
>>    host->is_bus_width_set
>>  - litex_mmc_request() - factor out dma data setup into separate
>>    helper function: litex_mmc_do_dma()
>>
>>> New in v3:
>>>   - fixed function signature (no line split), and naming (litex_mmc_*)
>>>   - more informative MODULE_AUTHOR() entries
>>>     - also added matching "Copyright" entries in file header
>>>   - fixed description and dependencies in Kconfig
>>>   - removed magic constants
>>>   - removed litex_map_status(), have sdcard_wait_done() return *real*
>>>     error codes directly instead.
>>>   - streamlined litex_mmc_reponse_len()
>>>   - call litex_mmc_set_bus_width() only once, and ensure it returns
>>>     correct error code(s)
>>>   - use readx_poll_timeout() -- more concise -- instead of
>>>     read_poll_timeout()
>>>   - use dev_err() in litex_mmc_send_cmd() (instead of pr_err())
>>>   - litex_mmc_setclk() will update host->clock before returning
>>>   - separate irq initialization into its own function,
>>>     litex_mmc_irq_init()
>>>   - document rationale for f_min, f_max
>>>   - use dmam_alloc_coherent(), which simplifies cleanup significantly
>>>   - bump dma_set_mask_and_coherent() to 64-bits on suitable
>>>     architectures
>>>   - clock source picked up from dedicated DT clock reference property
>>>   - remove gpio card-detect logic (needs testing and a dt binding
>>>     example before being eligible for upstream inclusion)
>>>   - large `if (data) { ... }` block in litex_mmc_request() left as-is,
>>>     there are too many variables shared with the rest of the parent
>>>     function body to easily separate (e.g., `len`, `transfer`, `direct`).
>>>     If this is indeed a blocker, I can take another shot at refactoring
>>>     it in a future revision!

 drivers/mmc/host/Kconfig     |   9 +
 drivers/mmc/host/Makefile    |   1 +
 drivers/mmc/host/litex_mmc.c | 659 +++++++++++++++++++++++++++++++++++
 3 files changed, 669 insertions(+)
 create mode 100644 drivers/mmc/host/litex_mmc.c

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 5af8494c31b5..c1b66d06d1c9 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -1093,3 +1093,12 @@ config MMC_OWL
 
 config MMC_SDHCI_EXTERNAL_DMA
 	bool
+
+config MMC_LITEX
+	tristate "LiteX MMC Host Controller support"
+	depends on OF
+	depends on PPC_MICROWATT || LITEX || COMPILE_TEST
+	help
+	  This selects support for the MMC Host Controller found in LiteX SoCs.
+
+	  If unsure, say N.
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index ea36d379bd3c..4e4ceb32c4b4 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -101,6 +101,7 @@ obj-$(CONFIG_MMC_CQHCI)			+= cqhci.o
 cqhci-y					+= cqhci-core.o
 cqhci-$(CONFIG_MMC_CRYPTO)		+= cqhci-crypto.o
 obj-$(CONFIG_MMC_HSQ)			+= mmc_hsq.o
+obj-$(CONFIG_MMC_LITEX)			+= litex_mmc.o
 
 ifeq ($(CONFIG_CB710_DEBUG),y)
 	CFLAGS-cb710-mmc	+= -DDEBUG
diff --git a/drivers/mmc/host/litex_mmc.c b/drivers/mmc/host/litex_mmc.c
new file mode 100644
index 000000000000..cbed97ca70d0
--- /dev/null
+++ b/drivers/mmc/host/litex_mmc.c
@@ -0,0 +1,659 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * LiteX LiteSDCard driver
+ *
+ * Copyright (C) 2019-2020 Antmicro <contact@antmicro.com>
+ * Copyright (C) 2019-2020 Kamil Rakoczy <krakoczy@antmicro.com>
+ * Copyright (C) 2019-2020 Maciej Dudek <mdudek@internships.antmicro.com>
+ * Copyright (C) 2020 Paul Mackerras <paulus@ozlabs.org>
+ * Copyright (C) 2020-2021 Gabriel Somlo <gsomlo@gmail.com>
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/litex.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+#include <linux/interrupt.h>
+#include <linux/iopoll.h>
+#include <linux/mmc/sd.h>
+#include <linux/mmc/mmc.h>
+#include <linux/mmc/host.h>
+#include <linux/delay.h>
+#include <linux/dma-mapping.h>
+
+#define LITEX_PHY_CARDDETECT  0x00
+#define LITEX_PHY_CLOCKERDIV  0x04
+#define LITEX_PHY_INITIALIZE  0x08
+#define LITEX_PHY_WRITESTATUS 0x0C
+#define LITEX_CORE_CMDARG     0x00
+#define LITEX_CORE_CMDCMD     0x04
+#define LITEX_CORE_CMDSND     0x08
+#define LITEX_CORE_CMDRSP     0x0C
+#define LITEX_CORE_CMDEVT     0x1C
+#define LITEX_CORE_DATAEVT    0x20
+#define LITEX_CORE_BLKLEN     0x24
+#define LITEX_CORE_BLKCNT     0x28
+#define LITEX_BLK2MEM_BASE    0x00
+#define LITEX_BLK2MEM_LEN     0x08
+#define LITEX_BLK2MEM_ENA     0x0C
+#define LITEX_BLK2MEM_DONE    0x10
+#define LITEX_BLK2MEM_LOOP    0x14
+#define LITEX_MEM2BLK_BASE    0x00
+#define LITEX_MEM2BLK_LEN     0x08
+#define LITEX_MEM2BLK_ENA     0x0C
+#define LITEX_MEM2BLK_DONE    0x10
+#define LITEX_MEM2BLK_LOOP    0x14
+#define LITEX_MEM2BLK         0x18
+#define LITEX_IRQ_STATUS      0x00
+#define LITEX_IRQ_PENDING     0x04
+#define LITEX_IRQ_ENABLE      0x08
+
+#define SD_CTL_DATA_XFER_NONE  0
+#define SD_CTL_DATA_XFER_READ  1
+#define SD_CTL_DATA_XFER_WRITE 2
+
+#define SD_CTL_RESP_NONE       0
+#define SD_CTL_RESP_SHORT      1
+#define SD_CTL_RESP_LONG       2
+#define SD_CTL_RESP_SHORT_BUSY 3
+
+#define SD_BIT_DONE    BIT(0)
+#define SD_BIT_WR_ERR  BIT(1)
+#define SD_BIT_TIMEOUT BIT(2)
+#define SD_BIT_CRC_ERR BIT(3)
+
+#define SD_SLEEP_US       5
+#define SD_TIMEOUT_US 20000
+
+#define SDIRQ_CARD_DETECT    1
+#define SDIRQ_SD_TO_MEM_DONE 2
+#define SDIRQ_MEM_TO_SD_DONE 4
+#define SDIRQ_CMD_DONE       8
+
+#define LITEX_MMC_OCR (MMC_VDD_27_28 | MMC_VDD_28_29 | MMC_VDD_29_30 | \
+		       MMC_VDD_30_31 | MMC_VDD_31_32 | MMC_VDD_32_33 | \
+		       MMC_VDD_33_34 | MMC_VDD_34_35 | MMC_VDD_35_36)
+
+struct litex_mmc_host {
+	struct mmc_host *mmc;
+	struct platform_device *dev;
+
+	void __iomem *sdphy;
+	void __iomem *sdcore;
+	void __iomem *sdreader;
+	void __iomem *sdwriter;
+	void __iomem *sdirq;
+
+	void *buffer;
+	size_t buf_size;
+	dma_addr_t dma;
+
+	struct completion cmd_done;
+	int irq;
+
+	unsigned int ref_clk;
+	unsigned int sd_clk;
+
+	u32 resp[4];
+	u16 rca;
+
+	bool is_bus_width_set;
+	bool app_cmd;
+};
+
+static int litex_mmc_sdcard_wait_done(void __iomem *reg)
+{
+	u8 evt;
+	int ret;
+
+	ret = readx_poll_timeout(litex_read8, reg, evt, (evt & SD_BIT_DONE),
+				 SD_SLEEP_US, SD_TIMEOUT_US);
+	if (ret || (evt & SD_BIT_TIMEOUT))
+		return -ETIMEDOUT;
+	if (evt == SD_BIT_DONE)
+		return 0;
+	if (evt & SD_BIT_WR_ERR)
+		return -EIO;
+	if (evt & SD_BIT_CRC_ERR)
+		return -EILSEQ;
+	pr_err("%s: unknown error evt=%x\n", __func__, evt);
+	return -EINVAL;
+}
+
+static int litex_mmc_send_cmd(struct litex_mmc_host *host,
+			      u8 cmd, u32 arg, u8 response_len, u8 transfer)
+{
+	struct device *dev = mmc_dev(host->mmc);
+	void __iomem *reg;
+	int ret;
+	u8 evt;
+
+	litex_write32(host->sdcore + LITEX_CORE_CMDARG, arg);
+	litex_write32(host->sdcore + LITEX_CORE_CMDCMD,
+		      cmd << 8 | transfer << 5 | response_len);
+	litex_write8(host->sdcore + LITEX_CORE_CMDSND, 1);
+
+	/* Wait for an interrupt if we have an interrupt and either there is
+	 * data to be transferred, or if the card can report busy via DAT0.
+	 */
+	if (host->irq > 0 &&
+	    (transfer != SD_CTL_DATA_XFER_NONE ||
+	     response_len == SD_CTL_RESP_SHORT_BUSY)) {
+		reinit_completion(&host->cmd_done);
+		litex_write32(host->sdirq + LITEX_IRQ_ENABLE,
+			      SDIRQ_CMD_DONE | SDIRQ_CARD_DETECT);
+		wait_for_completion(&host->cmd_done);
+	}
+
+	ret = litex_mmc_sdcard_wait_done(host->sdcore + LITEX_CORE_CMDEVT);
+	if (ret) {
+		dev_err(dev, "Command (cmd %d) error, status %d\n", cmd, ret);
+		return ret;
+	}
+
+	if (response_len != SD_CTL_RESP_NONE) {
+		int i;
+
+		reg = host->sdcore + LITEX_CORE_CMDRSP;
+		for (i = 0; i < 4; i++) {
+			host->resp[i] = litex_read32(reg);
+			reg += sizeof(u32);
+		}
+	}
+
+	if (!host->app_cmd && cmd == SD_SEND_RELATIVE_ADDR)
+		host->rca = (host->resp[3] >> 16) & 0xffff;
+
+	host->app_cmd = (cmd == MMC_APP_CMD);
+
+	if (transfer == SD_CTL_DATA_XFER_NONE)
+		return ret; /* OK from prior litex_mmc_sdcard_wait_done() */
+
+	ret = litex_mmc_sdcard_wait_done(host->sdcore + LITEX_CORE_DATAEVT);
+	if (ret) {
+		dev_err(dev, "Data xfer (cmd %d) error, status %d\n", cmd, ret);
+		return ret;
+	}
+
+	/* wait for completion of (read or write) DMA transfer */
+	reg = (transfer == SD_CTL_DATA_XFER_READ) ?
+		host->sdreader + LITEX_BLK2MEM_DONE :
+		host->sdwriter + LITEX_MEM2BLK_DONE;
+	ret = readx_poll_timeout(litex_read8, reg, evt, (evt & SD_BIT_DONE),
+				 SD_SLEEP_US, SD_TIMEOUT_US);
+	if (ret)
+		dev_err(dev, "DMA timeout (cmd %d)\n", cmd);
+
+	return ret;
+}
+
+static int litex_mmc_send_app_cmd(struct litex_mmc_host *host)
+{
+	return litex_mmc_send_cmd(host, MMC_APP_CMD, host->rca << 16,
+				  SD_CTL_RESP_SHORT, SD_CTL_DATA_XFER_NONE);
+}
+
+static int litex_mmc_send_set_bus_w_cmd(struct litex_mmc_host *host, u32 width)
+{
+	return litex_mmc_send_cmd(host, SD_APP_SET_BUS_WIDTH, width,
+				  SD_CTL_RESP_SHORT, SD_CTL_DATA_XFER_NONE);
+}
+
+static int litex_mmc_set_bus_width(struct litex_mmc_host *host)
+{
+	bool app_cmd_sent;
+	int ret;
+
+	if (host->is_bus_width_set)
+		return 0;
+
+	/* ensure 'app_cmd' precedes 'app_set_bus_width_cmd' */
+	app_cmd_sent = host->app_cmd; /* was preceding command app_cmd? */
+	if (!app_cmd_sent) {
+		ret = litex_mmc_send_app_cmd(host);
+		if (ret)
+			return ret;
+	}
+
+	/* litesdcard only supports 4-bit bus width */
+	ret = litex_mmc_send_set_bus_w_cmd(host, MMC_BUS_WIDTH_4);
+	if (ret)
+		return ret;
+
+	/* re-send 'app_cmd' if necessary */
+	if (app_cmd_sent) {
+		ret = litex_mmc_send_app_cmd(host);
+		if (ret)
+			return ret;
+	}
+
+	host->is_bus_width_set = true;
+
+	return 0;
+}
+
+static int litex_mmc_get_cd(struct mmc_host *mmc)
+{
+	struct litex_mmc_host *host = mmc_priv(mmc);
+	int ret;
+
+	if (!mmc_card_is_removable(mmc))
+		return 1;
+
+	ret = !litex_read8(host->sdphy + LITEX_PHY_CARDDETECT);
+
+	/* ensure bus width will be set (again) upon card (re)insertion */
+	if (ret == 0)
+		host->is_bus_width_set = false;
+
+	return ret;
+}
+
+static irqreturn_t litex_mmc_interrupt(int irq, void *arg)
+{
+	struct mmc_host *mmc = arg;
+	struct litex_mmc_host *host = mmc_priv(mmc);
+	u32 pending = litex_read32(host->sdirq + LITEX_IRQ_PENDING);
+
+	/* Check for card change interrupt */
+	if (pending & SDIRQ_CARD_DETECT) {
+		litex_write32(host->sdirq + LITEX_IRQ_PENDING,
+			      SDIRQ_CARD_DETECT);
+		mmc_detect_change(mmc, msecs_to_jiffies(10));
+	}
+
+	/* Check for command completed */
+	if (pending & SDIRQ_CMD_DONE) {
+		/* Disable it so it doesn't keep interrupting */
+		litex_write32(host->sdirq + LITEX_IRQ_ENABLE,
+			      SDIRQ_CARD_DETECT);
+		complete(&host->cmd_done);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static u32 litex_mmc_response_len(struct mmc_command *cmd)
+{
+	if (cmd->flags & MMC_RSP_136)
+		return SD_CTL_RESP_LONG;
+	if (!(cmd->flags & MMC_RSP_PRESENT))
+		return SD_CTL_RESP_NONE;
+	if (cmd->flags & MMC_RSP_BUSY)
+		return SD_CTL_RESP_SHORT_BUSY;
+	return SD_CTL_RESP_SHORT;
+}
+
+static void litex_mmc_do_dma(struct litex_mmc_host *host, struct mmc_data *data,
+			     unsigned int *len, bool *direct, u8 *transfer)
+{
+	struct device *dev = mmc_dev(host->mmc);
+	dma_addr_t dma;
+	int sg_count;
+
+	/* Try to DMA directly to/from the data buffer.
+	 * We can do that if the buffer can be mapped for DMA
+	 * in one contiguous chunk.
+	 */
+	dma = host->dma;
+	*len = data->blksz * data->blocks;
+	sg_count = dma_map_sg(dev, data->sg, data->sg_len,
+			      mmc_get_dma_dir(data));
+	if (sg_count == 1) {
+		dma = sg_dma_address(data->sg);
+		*len = sg_dma_len(data->sg);
+		*direct = true;
+	} else if (*len > host->buf_size)
+		*len = host->buf_size;
+
+	if (data->flags & MMC_DATA_READ) {
+		litex_write8(host->sdreader + LITEX_BLK2MEM_ENA, 0);
+		litex_write64(host->sdreader + LITEX_BLK2MEM_BASE, dma);
+		litex_write32(host->sdreader + LITEX_BLK2MEM_LEN, *len);
+		litex_write8(host->sdreader + LITEX_BLK2MEM_ENA, 1);
+		*transfer = SD_CTL_DATA_XFER_READ;
+	} else if (data->flags & MMC_DATA_WRITE) {
+		if (!*direct)
+			sg_copy_to_buffer(data->sg, data->sg_len,
+					  host->buffer, *len);
+		litex_write8(host->sdwriter + LITEX_MEM2BLK_ENA, 0);
+		litex_write64(host->sdwriter + LITEX_MEM2BLK_BASE, dma);
+		litex_write32(host->sdwriter + LITEX_MEM2BLK_LEN, *len);
+		litex_write8(host->sdwriter + LITEX_MEM2BLK_ENA, 1);
+		*transfer = SD_CTL_DATA_XFER_WRITE;
+	} else {
+		dev_warn(dev, "Data present w/o read or write flag.\n");
+		/* Continue: set cmd status, mark req done */
+	}
+
+	litex_write16(host->sdcore + LITEX_CORE_BLKLEN, data->blksz);
+	litex_write32(host->sdcore + LITEX_CORE_BLKCNT, data->blocks);
+}
+
+static void litex_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
+{
+	struct litex_mmc_host *host = mmc_priv(mmc);
+	struct device *dev = mmc_dev(mmc);
+	struct mmc_command *cmd = mrq->cmd;
+	struct mmc_command *sbc = mrq->sbc;
+	struct mmc_data *data = mrq->data;
+	struct mmc_command *stop = mrq->stop;
+	unsigned int retries = cmd->retries;
+	unsigned int len = 0;
+	bool direct = false;
+	u32 response_len = litex_mmc_response_len(cmd);
+	u8 transfer = SD_CTL_DATA_XFER_NONE;
+
+	/* First check that the card is still there */
+	if (!litex_mmc_get_cd(mmc)) {
+		cmd->error = -ENOMEDIUM;
+		mmc_request_done(mmc, mrq);
+		return;
+	}
+
+	/* Send set-block-count command if needed */
+	if (sbc) {
+		sbc->error = litex_mmc_send_cmd(host, sbc->opcode, sbc->arg,
+						litex_mmc_response_len(sbc),
+						SD_CTL_DATA_XFER_NONE);
+		if (sbc->error) {
+			host->is_bus_width_set = false;
+			mmc_request_done(mmc, mrq);
+			return;
+		}
+	}
+
+	if (data) {
+		/* LiteSDCard only supports 4-bit bus width; therefore, we MUST
+		 * inject a SET_BUS_WIDTH (acmd6) before the very first data
+		 * transfer, earlier than when the mmc subsystem would normally
+		 * get around to it!
+		 */
+		cmd->error = litex_mmc_set_bus_width(host);
+		if (cmd->error) {
+			dev_err(dev, "Can't set bus width!\n");
+			mmc_request_done(mmc, mrq);
+			return;
+		}
+
+		litex_mmc_do_dma(host, data, &len, &direct, &transfer);
+	}
+
+	do {
+		cmd->error = litex_mmc_send_cmd(host, cmd->opcode, cmd->arg,
+						response_len, transfer);
+	} while (cmd->error && retries-- > 0);
+
+	if (cmd->error) {
+		/* card may be gone; don't assume bus width is still set */
+		host->is_bus_width_set = false;
+	}
+
+	if (response_len == SD_CTL_RESP_SHORT) {
+		/* pull short response fields from appropriate host registers */
+		cmd->resp[0] = host->resp[3];
+		cmd->resp[1] = host->resp[2] & 0xFF;
+	} else if (response_len == SD_CTL_RESP_LONG) {
+		cmd->resp[0] = host->resp[0];
+		cmd->resp[1] = host->resp[1];
+		cmd->resp[2] = host->resp[2];
+		cmd->resp[3] = host->resp[3];
+	}
+
+	/* Send stop-transmission command if required */
+	if (stop && (cmd->error || !sbc)) {
+		stop->error = litex_mmc_send_cmd(host, stop->opcode, stop->arg,
+						 litex_mmc_response_len(stop),
+						 SD_CTL_DATA_XFER_NONE);
+		if (stop->error)
+			host->is_bus_width_set = false;
+	}
+
+	if (data) {
+		dma_unmap_sg(dev, data->sg, data->sg_len,
+			     mmc_get_dma_dir(data));
+	}
+
+	if (!cmd->error && transfer != SD_CTL_DATA_XFER_NONE) {
+		data->bytes_xfered = min(len, mmc->max_req_size);
+		if (transfer == SD_CTL_DATA_XFER_READ && !direct) {
+			sg_copy_from_buffer(data->sg, sg_nents(data->sg),
+					    host->buffer, data->bytes_xfered);
+		}
+	}
+
+	mmc_request_done(mmc, mrq);
+}
+
+static void litex_mmc_setclk(struct litex_mmc_host *host, unsigned int freq)
+{
+	struct device *dev = mmc_dev(host->mmc);
+	u32 div;
+
+	div = freq ? host->ref_clk / freq : 256U;
+	div = roundup_pow_of_two(div);
+	div = min(max(div, 2U), 256U);
+	dev_dbg(dev, "sd_clk_freq=%d: set to %d via div=%d\n",
+		freq, host->ref_clk / div, div);
+	litex_write16(host->sdphy + LITEX_PHY_CLOCKERDIV, div);
+	host->sd_clk = freq;
+}
+
+static void litex_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	struct litex_mmc_host *host = mmc_priv(mmc);
+
+	/* NOTE: Ignore any ios->bus_width updates; they occur right after
+	 * the mmc core sends its own acmd6 bus-width change notification,
+	 * which is redundant since we snoop on the command flow and inject
+	 * an early acmd6 before the first data transfer command is sent!
+	 */
+
+	/* update sd_clk */
+	if (ios->clock != host->sd_clk)
+		litex_mmc_setclk(host, ios->clock);
+}
+
+static const struct mmc_host_ops litex_mmc_ops = {
+	.get_cd = litex_mmc_get_cd,
+	.request = litex_mmc_request,
+	.set_ios = litex_mmc_set_ios,
+};
+
+static int litex_mmc_irq_init(struct litex_mmc_host *host)
+{
+	struct device *dev = mmc_dev(host->mmc);
+	int ret;
+
+	ret = platform_get_irq_optional(host->dev, 0);
+	if (ret == -ENXIO || ret == 0) {
+		dev_warn(dev, "Failed to get IRQ, using polling\n");
+		goto use_polling;
+	}
+	if (ret < 0)
+		return ret; /* e.g., deferred probe */
+	host->irq = ret;
+
+	host->sdirq = devm_platform_ioremap_resource_byname(host->dev, "irq");
+	if (IS_ERR(host->sdirq))
+		return PTR_ERR(host->sdirq);
+
+	ret = request_irq(host->irq, litex_mmc_interrupt, 0,
+			  "litex-mmc", host->mmc);
+	if (ret < 0) {
+		dev_warn(dev, "IRQ request error %d, using polling\n", ret);
+		goto use_polling;
+	}
+
+	/* clear & enable card-change interrupts */
+	litex_write32(host->sdirq + LITEX_IRQ_PENDING, SDIRQ_CARD_DETECT);
+	litex_write32(host->sdirq + LITEX_IRQ_ENABLE, SDIRQ_CARD_DETECT);
+
+	return 0;
+
+use_polling:
+	host->mmc->caps |= MMC_CAP_NEEDS_POLL;
+	host->irq = 0;
+	return 0;
+}
+
+static int litex_mmc_probe(struct platform_device *pdev)
+{
+	struct litex_mmc_host *host;
+	struct mmc_host *mmc;
+	struct clk *clk;
+	int ret;
+
+	mmc = mmc_alloc_host(sizeof(struct litex_mmc_host), &pdev->dev);
+	/* NOTE: defaults to max_[req,seg]_size=PAGE_SIZE, max_blk_size=512,
+	 * and max_blk_count accordingly set to 8;
+	 * If for some reason we need to modify max_blk_count, we must also
+	 * re-calculate `max_[req,seg]_size = max_blk_size * max_blk_count;`
+	 */
+	if (!mmc)
+		return -ENOMEM;
+
+	host = mmc_priv(mmc);
+	host->mmc = mmc;
+	host->dev = pdev;
+
+	/* initialize clock source */
+	clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(clk)) {
+		ret = dev_err_probe(&pdev->dev,
+				    PTR_ERR(clk), "can't get clock\n");
+		goto err;
+	}
+	host->ref_clk = clk_get_rate(clk);
+	host->sd_clk = 0;
+
+	/* LiteSDCard only supports 4-bit bus width; therefore, we MUST inject
+	 * a SET_BUS_WIDTH (acmd6) before the very first data transfer, earlier
+	 * than when the mmc subsystem would normally get around to it!
+	 */
+	host->is_bus_width_set = false;
+	host->app_cmd = false;
+
+	/* LiteSDCard can support 64-bit DMA addressing */
+	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
+	if (ret)
+		goto err;
+
+	host->buf_size = mmc->max_req_size * 2;
+	host->buffer = dmam_alloc_coherent(&pdev->dev, host->buf_size,
+					   &host->dma, GFP_DMA);
+	if (host->buffer == NULL) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	host->sdphy = devm_platform_ioremap_resource_byname(pdev, "phy");
+	if (IS_ERR(host->sdphy)) {
+		ret = PTR_ERR(host->sdphy);
+		goto err;
+	}
+
+	host->sdcore = devm_platform_ioremap_resource_byname(pdev, "core");
+	if (IS_ERR(host->sdcore)) {
+		ret = PTR_ERR(host->sdcore);
+		goto err;
+	}
+
+	host->sdreader = devm_platform_ioremap_resource_byname(pdev, "reader");
+	if (IS_ERR(host->sdreader)) {
+		ret = PTR_ERR(host->sdreader);
+		goto err;
+	}
+
+	host->sdwriter = devm_platform_ioremap_resource_byname(pdev, "writer");
+	if (IS_ERR(host->sdwriter)) {
+		ret = PTR_ERR(host->sdwriter);
+		goto err;
+	}
+
+	/* ensure DMA bus masters are disabled */
+	litex_write8(host->sdreader + LITEX_BLK2MEM_ENA, 0);
+	litex_write8(host->sdwriter + LITEX_MEM2BLK_ENA, 0);
+
+	init_completion(&host->cmd_done);
+	ret = litex_mmc_irq_init(host);
+	if (ret)
+		goto err;
+
+	/* allow full generic 2.7-3.6V range; no software tuning available */
+	mmc->ocr_avail = LITEX_MMC_OCR;
+
+	mmc->ops = &litex_mmc_ops;
+
+	/* set default sd_clk frequency range based on empirical observations
+	 * of LiteSDCard gateware behavior on typical SDCard media
+	 */
+	mmc->f_min = 12.5e6;
+	mmc->f_max = 50e6;
+
+	ret = mmc_of_parse(mmc);
+	if (ret)
+		goto err;
+
+	/* force 4-bit bus_width (only width supported by hardware) */
+	mmc->caps &= ~MMC_CAP_8_BIT_DATA;
+	mmc->caps |= MMC_CAP_4_BIT_DATA;
+
+	/* set default capabilities */
+	mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY |
+		     MMC_CAP_DRIVER_TYPE_D |
+		     MMC_CAP_CMD23;
+	mmc->caps2 |= MMC_CAP2_NO_WRITE_PROTECT |
+		      MMC_CAP2_NO_SDIO |
+		      MMC_CAP2_NO_MMC;
+
+	platform_set_drvdata(pdev, host);
+
+	ret = mmc_add_host(mmc);
+	if (ret < 0)
+		goto err;
+
+	return 0;
+
+err:
+	mmc_free_host(mmc);
+	return ret;
+}
+
+static int litex_mmc_remove(struct platform_device *pdev)
+{
+	struct litex_mmc_host *host = dev_get_drvdata(&pdev->dev);
+
+	if (host->irq > 0)
+		free_irq(host->irq, host->mmc);
+	mmc_remove_host(host->mmc);
+	mmc_free_host(host->mmc);
+
+	return 0;
+}
+
+static const struct of_device_id litex_match[] = {
+	{ .compatible = "litex,mmc" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, litex_match);
+
+static struct platform_driver litex_mmc_driver = {
+	.probe = litex_mmc_probe,
+	.remove = litex_mmc_remove,
+	.driver = {
+		.name = "litex-mmc",
+		.of_match_table = of_match_ptr(litex_match),
+	},
+};
+module_platform_driver(litex_mmc_driver);
+
+MODULE_DESCRIPTION("LiteX SDCard driver");
+MODULE_AUTHOR("Antmicro <contact@antmicro.com>");
+MODULE_AUTHOR("Kamil Rakoczy <krakoczy@antmicro.com>");
+MODULE_AUTHOR("Maciej Dudek <mdudek@internships.antmicro.com>");
+MODULE_AUTHOR("Paul Mackerras <paulus@ozlabs.org>");
+MODULE_AUTHOR("Gabriel Somlo <gsomlo@gmail.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.31.1


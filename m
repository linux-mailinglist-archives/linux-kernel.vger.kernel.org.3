Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB78B591888
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 06:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234518AbiHMEJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 00:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiHMEJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 00:09:46 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4628F97D50;
        Fri, 12 Aug 2022 21:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660363785; x=1691899785;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YtnxD0BBwfe5HOnm9g9khCNeUtirSIklccPuLDL3HPI=;
  b=fEBKa8rsncW5kP/2qke+mOh59N1mX0q3XPOaSFvDPl2GoXTem3rIln9U
   mftLMuw2Msyxfr1nXSLdjhhJkkOsohgM8avAX+kaaWVRcNcNc6Glf3LaR
   qTT+eUJaEONEfFNEW83Z96PyFSzHGjxGFqUjkjRUv2gnRQ7iG+QwTYKQT
   eYWTky8WN3oGqtD2lCtZ1EJjqOlLk2vcGP2buF9RjDM9OLR1trAVQJG4h
   4n9cjKOGVwjsmM2O9gNi8WlJ+fHmKenG//IsogbfdEz4gIV+Xic7ZMLpS
   8lJhQSXgrTo7IgJ0y70tC9Qrm7x3zRs481F+67t/MLdzmSZGxN3eabH2d
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="378015768"
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="378015768"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 21:09:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="782153066"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.116])
  by orsmga005.jf.intel.com with ESMTP; 12 Aug 2022 21:09:42 -0700
From:   niravkumar.l.rabara@intel.com
To:     Mark Brown <broonie@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        niravkumar.l.rabara@intel.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] spi: cadence-quadspi: Disable irqs during indirect reads
Date:   Sat, 13 Aug 2022 12:09:28 +0800
Message-Id: <20220813040928.1353077-1-niravkumar.l.rabara@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>

On architecture where reading the SRAM is slower than the pace at
controller fills it, with interrupt enabled while reading from
SRAM FIFO causes unwanted interrupt storm to CPU.

The inner "bytes to read" loop never exits and waits for the completion
so it is enough to only enable the watermark interrupt when we
are out of bytes to read, which only happens when we start the
transfer (waiting for the FIFO to fill up initially) if the SRAM
is slow.

So only using read watermark interrupt, as the current implementation
doesn't utilize the SRAM full and indirect complete read interrupt.
And disable all the read interrupts while reading from SRAM.

Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
---
 drivers/spi/spi-cadence-quadspi.c | 32 ++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 72b1a5a2298c..75a3cdb84fba 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -39,6 +39,7 @@
 #define CQSPI_DISABLE_DAC_MODE		BIT(1)
 #define CQSPI_SUPPORT_EXTERNAL_DMA	BIT(2)
 #define CQSPI_NO_SUPPORT_WR_COMPLETION	BIT(3)
+#define CQSPI_SLOW_SRAM		BIT(4)
 
 /* Capabilities */
 #define CQSPI_SUPPORTS_OCTAL		BIT(0)
@@ -87,6 +88,7 @@ struct cqspi_st {
 	bool			use_dma_read;
 	u32			pd_dev_id;
 	bool			wr_completion;
+	bool			slow_sram;
 };
 
 struct cqspi_driver_platdata {
@@ -333,7 +335,10 @@ static irqreturn_t cqspi_irq_handler(int this_irq, void *dev)
 		}
 	}
 
-	irq_status &= CQSPI_IRQ_MASK_RD | CQSPI_IRQ_MASK_WR;
+	else if (!cqspi->slow_sram)
+		irq_status &= CQSPI_IRQ_MASK_RD | CQSPI_IRQ_MASK_WR;
+	else
+		irq_status &= CQSPI_REG_IRQ_WATERMARK | CQSPI_IRQ_MASK_WR;
 
 	if (irq_status)
 		complete(&cqspi->transfer_complete);
@@ -673,7 +678,18 @@ static int cqspi_indirect_read_execute(struct cqspi_flash_pdata *f_pdata,
 	/* Clear all interrupts. */
 	writel(CQSPI_IRQ_STATUS_MASK, reg_base + CQSPI_REG_IRQSTATUS);
 
-	writel(CQSPI_IRQ_MASK_RD, reg_base + CQSPI_REG_IRQMASK);
+	/*
+	 * On SoCFPGA platform reading the SRAM is slow due to
+	 * hardware limitation and causing read interrupt storm to CPU,
+	 * so enabling only watermark interrupt to disable all read
+	 * interrupts later as we want to run "bytes to read" loop with
+	 * all the read interrupts disabled for max performance.
+	 */
+
+	if (!cqspi->slow_sram)
+		writel(CQSPI_IRQ_MASK_RD, reg_base + CQSPI_REG_IRQMASK);
+	else
+		writel(CQSPI_REG_IRQ_WATERMARK, reg_base + CQSPI_REG_IRQMASK);
 
 	reinit_completion(&cqspi->transfer_complete);
 	writel(CQSPI_REG_INDIRECTRD_START_MASK,
@@ -684,6 +700,13 @@ static int cqspi_indirect_read_execute(struct cqspi_flash_pdata *f_pdata,
 						 msecs_to_jiffies(CQSPI_READ_TIMEOUT_MS)))
 			ret = -ETIMEDOUT;
 
+		/*
+		 * Disable all read interrupts until
+		 * we are out of "bytes to read"
+		 */
+		if (cqspi->slow_sram)
+			writel(0x0, reg_base + CQSPI_REG_IRQMASK);
+
 		bytes_to_read = cqspi_get_rd_sram_level(cqspi);
 
 		if (ret && bytes_to_read == 0) {
@@ -715,8 +738,11 @@ static int cqspi_indirect_read_execute(struct cqspi_flash_pdata *f_pdata,
 			bytes_to_read = cqspi_get_rd_sram_level(cqspi);
 		}
 
-		if (remaining > 0)
+		if (remaining > 0) {
 			reinit_completion(&cqspi->transfer_complete);
+			if (cqspi->slow_sram)
+				writel(CQSPI_REG_IRQ_WATERMARK, reg_base + CQSPI_REG_IRQMASK);
+		}
 	}
 
 	/* Check indirect done status */
-- 
2.25.1


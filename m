Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D28D5918D0
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 06:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236872AbiHME0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 00:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbiHME0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 00:26:23 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535D518B14;
        Fri, 12 Aug 2022 21:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660364782; x=1691900782;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nuSF/DPyH4hEc+MssLIdGaOyti4gnu6kxnq2sOYunFY=;
  b=KwqBpIKSP/r3j+xxKaw61Sl4n4tcgMAbVL0HmJ9OOar8CTTtvjxLmeZW
   6yJuh2VRiTw7a7Scp7nUsHfiN1V2FxWxWDs3YGOYIUgaO+j6AX48rESAn
   Rv+4GpDwhIYWIlEk1jJTXHHLTj0QvK7mGxJHfjYe9ZbCrmob3jleNvA0Y
   5pAUOrVXqY8UC+mz2BHbWeSV17ixrtaAAW25MoqGCmPzkyObqVj2CDg/D
   ie5JPlx0v0Aa8Vmt7Vs1yD0iGZI34pJfDRFMr3ZAPhsKR/dQBZ7pL9mJm
   MPstXm4bn2pXPFDzoXFIJY69/HC1c16JPFCOIms7X9MxarhiBVJ+GNgmI
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="355734730"
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="355734730"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 21:26:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="782156433"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.116])
  by orsmga005.jf.intel.com with ESMTP; 12 Aug 2022 21:26:20 -0700
From:   niravkumar.l.rabara@intel.com
To:     Mark Brown <broonie@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        niravkumar.l.rabara@intel.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] spi: cadence-quadspi: Disable irqs during indirect reads
Date:   Sat, 13 Aug 2022 12:26:16 +0800
Message-Id: <20220813042616.1372110-1-niravkumar.l.rabara@intel.com>
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
 drivers/spi/spi-cadence-quadspi.c | 38 +++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 72b1a5a2298c..e12ab5b43f34 100644
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
@@ -1667,6 +1693,8 @@ static int cqspi_probe(struct platform_device *pdev)
 			cqspi->use_dma_read = true;
 		if (ddata->quirks & CQSPI_NO_SUPPORT_WR_COMPLETION)
 			cqspi->wr_completion = false;
+		if (ddata->quirks & CQSPI_SLOW_SRAM)
+			cqspi->slow_sram = true;
 
 		if (of_device_is_compatible(pdev->dev.of_node,
 					    "xlnx,versal-ospi-1.0"))
@@ -1779,7 +1807,9 @@ static const struct cqspi_driver_platdata intel_lgm_qspi = {
 };
 
 static const struct cqspi_driver_platdata socfpga_qspi = {
-	.quirks = CQSPI_DISABLE_DAC_MODE | CQSPI_NO_SUPPORT_WR_COMPLETION,
+	.quirks = CQSPI_DISABLE_DAC_MODE
+			| CQSPI_NO_SUPPORT_WR_COMPLETION
+			| CQSPI_SLOW_SRAM,
 };
 
 static const struct cqspi_driver_platdata versal_ospi = {
-- 
2.25.1


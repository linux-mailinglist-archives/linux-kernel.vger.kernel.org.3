Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81C915918D3
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 06:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237356AbiHME1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 00:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbiHME1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 00:27:43 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D38218B14;
        Fri, 12 Aug 2022 21:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660364862; x=1691900862;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nuSF/DPyH4hEc+MssLIdGaOyti4gnu6kxnq2sOYunFY=;
  b=eP5QAKlicvVBYSpkTjuFbvLDL3r9IPAUQzPZY+uuf2IqENPuI/jsVshB
   rJqxMHrRehcfadCQO1e0e054R9llDVuL/Kqw5TIvaA+uxCNRjc6qAfx4E
   l7R4HjHc/rN8FXBioBhZAL/3dEkVtiQF8KWoCTCdqgVKDFjiUUPI7+53v
   3BKEW2o5dSEX3exPqgxY9ZPZBt0KLf4/HuMtmieth8yPLnUyXKJGTPm/f
   VRzay9vX1dYRI5ZcXElLQbLdwOuDtbCH9AuUAbyLUTAU4XQfH/Ga5SqAg
   UwKTyk8DDsJ+0mlErfzowqaMGG+QcJAKl32L4nmIZddeR0bHY0IuczZ/v
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="317703189"
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="317703189"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 21:27:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="732433386"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.116])
  by orsmga004.jf.intel.com with ESMTP; 12 Aug 2022 21:27:40 -0700
From:   niravkumar.l.rabara@intel.com
To:     niravkumar.l.rabara@intel.com
Cc:     broonie@kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, p.zabel@pengutronix.de
Subject: [PATCH v2] spi: cadence-quadspi: Disable irqs during indirect reads
Date:   Sat, 13 Aug 2022 12:27:36 +0800
Message-Id: <20220813042736.1372180-1-niravkumar.l.rabara@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220813040928.1353077-1-niravkumar.l.rabara@intel.com>
References: <20220813040928.1353077-1-niravkumar.l.rabara@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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


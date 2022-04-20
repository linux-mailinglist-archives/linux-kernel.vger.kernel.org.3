Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6528508C9B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 17:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353970AbiDTQAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 12:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242908AbiDTQAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 12:00:02 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4833E2A24C;
        Wed, 20 Apr 2022 08:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1650470235; x=1682006235;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=b5buSbS/Y6YBWpO3y41GUfU3t//7M1BjS48dP9Par3w=;
  b=QH3YmD+Ir6Xr0a32moDtpzICUFCA9LpT6TJWnu/9tzvQMsDBWAvvW8Ah
   KQuGonp0ie2WFvpQ6SFAYe9QdMRPGPew4oRuSGklEuBMzWfu5V3aI71FM
   hDIOGrBLke4KcXDr1I7XkdUDk60jwAImD54yh8fY0X3JKfsYbVfnxbTA5
   W3sb3j9nPoMpCH8plrSQ8uVd1kmNWWGpdgplEiukuQ52+SazRnUwEqXg/
   bmOrWMRj8ucQKSti8BVArLhpI9gISvC1OEVx5z3gJbOIml6Q+p4S/n74s
   q9qSnVJ/Tvtba2WjzxvkN4tgKFAtflMVlZdMVewfx7A58FOhXWR7LQe4M
   g==;
X-IronPort-AV: E=Sophos;i="5.90,276,1643670000"; 
   d="scan'208";a="23392890"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 20 Apr 2022 17:57:13 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 20 Apr 2022 17:57:13 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 20 Apr 2022 17:57:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1650470233; x=1682006233;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=b5buSbS/Y6YBWpO3y41GUfU3t//7M1BjS48dP9Par3w=;
  b=KAz8L97BaMoM7aKwZN655b9AdwPXyIn9pG5nRQyjwzRlVezjZeK4BcOz
   pUTteTko2Ai1JjDJeYNnOdJoKmu04Cl21bBzhish+tzD/25B+Zr8QzP51
   9JFuxhbc9JHjCKY5YIX2t8tDZvo+XBNZ+1gAXreqvqhSqMyH9pCgfIJnG
   k9W0JCvflZBp1bRFhm8chJ9/EO4HNfsvgfnCKSWxELEsj3PKICKXxmBLO
   lDI2fP06jxlDigi9AXJoulOzGzj1r7FuVj2zvpw816r2Q5mrj562Lgkz9
   6YaWDjkJaiWpOgGi6M2pFanKL1M7oTcZDcLQ0WOOeQmi/s0enEUjKM2fe
   g==;
X-IronPort-AV: E=Sophos;i="5.90,276,1643670000"; 
   d="scan'208";a="23392889"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 20 Apr 2022 17:57:13 +0200
Received: from localhost.localdomain (SCHIFFERM-M2.tq-net.de [10.121.49.14])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 08F26280070;
        Wed, 20 Apr 2022 17:57:13 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Pratyush Yadav <p.yadav@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH v2 1/2] spi: cadence-quadspi: drop cqspi_set_protocol()
Date:   Wed, 20 Apr 2022 17:56:15 +0200
Message-Id: <20220420155616.281730-1-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As suggested, this removes the whole cqspi_set_protocol() function, as it
is not actually needed:

- Checks for unsupported operations are already handled by supports_op(),
  removing the need to distinguish DTR and non-DTR modes in the buswidth
  setup
- supports_op() ensures that the DTR flags match for all relevant parts of
  an operation, so op->cmd.dtr can be used instead of copying the flag to
  the cqspi_flash_pdata
- The logic in cqspi_set_protocol() is moved to cqspi_calc_rdreg() and
  cqspi_write_setup() (with a helper macro CQSPI_OP_WIDTH())

The helper macro checks nbytes instead of buswidth for 0, for consistency
with supports_op() etc.

Suggested-by: Pratyush Yadav <p.yadav@ti.com>
Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---

v2: remove cqspi_set_protocol() instead of simplifying it


 drivers/spi/spi-cadence-quadspi.c | 130 +++++++-----------------------
 1 file changed, 27 insertions(+), 103 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 19686fb47bb3..8c12c6dd58ae 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -43,6 +43,8 @@
 /* Capabilities */
 #define CQSPI_SUPPORTS_OCTAL		BIT(0)
 
+#define CQSPI_OP_WIDTH(part) ((part).nbytes ? ilog2((part).buswidth) : 0)
+
 struct cqspi_st;
 
 struct cqspi_flash_pdata {
@@ -53,10 +55,6 @@ struct cqspi_flash_pdata {
 	u32		tsd2d_ns;
 	u32		tchsh_ns;
 	u32		tslch_ns;
-	u8		inst_width;
-	u8		addr_width;
-	u8		data_width;
-	bool		dtr;
 	u8		cs;
 };
 
@@ -343,18 +341,18 @@ static irqreturn_t cqspi_irq_handler(int this_irq, void *dev)
 	return IRQ_HANDLED;
 }
 
-static unsigned int cqspi_calc_rdreg(struct cqspi_flash_pdata *f_pdata)
+static unsigned int cqspi_calc_rdreg(const struct spi_mem_op *op)
 {
 	u32 rdreg = 0;
 
-	rdreg |= f_pdata->inst_width << CQSPI_REG_RD_INSTR_TYPE_INSTR_LSB;
-	rdreg |= f_pdata->addr_width << CQSPI_REG_RD_INSTR_TYPE_ADDR_LSB;
-	rdreg |= f_pdata->data_width << CQSPI_REG_RD_INSTR_TYPE_DATA_LSB;
+	rdreg |= CQSPI_OP_WIDTH(op->cmd) << CQSPI_REG_RD_INSTR_TYPE_INSTR_LSB;
+	rdreg |= CQSPI_OP_WIDTH(op->addr) << CQSPI_REG_RD_INSTR_TYPE_ADDR_LSB;
+	rdreg |= CQSPI_OP_WIDTH(op->data) << CQSPI_REG_RD_INSTR_TYPE_DATA_LSB;
 
 	return rdreg;
 }
 
-static unsigned int cqspi_calc_dummy(const struct spi_mem_op *op, bool dtr)
+static unsigned int cqspi_calc_dummy(const struct spi_mem_op *op)
 {
 	unsigned int dummy_clk;
 
@@ -362,66 +360,12 @@ static unsigned int cqspi_calc_dummy(const struct spi_mem_op *op, bool dtr)
 		return 0;
 
 	dummy_clk = op->dummy.nbytes * (8 / op->dummy.buswidth);
-	if (dtr)
+	if (op->cmd.dtr)
 		dummy_clk /= 2;
 
 	return dummy_clk;
 }
 
-static int cqspi_set_protocol(struct cqspi_flash_pdata *f_pdata,
-			      const struct spi_mem_op *op)
-{
-	/*
-	 * For an op to be DTR, cmd phase along with every other non-empty
-	 * phase should have dtr field set to 1. If an op phase has zero
-	 * nbytes, ignore its dtr field; otherwise, check its dtr field.
-	 */
-	f_pdata->dtr = op->cmd.dtr &&
-		       (!op->addr.nbytes || op->addr.dtr) &&
-		       (!op->data.nbytes || op->data.dtr);
-
-	f_pdata->inst_width = 0;
-	if (op->cmd.buswidth)
-		f_pdata->inst_width = ilog2(op->cmd.buswidth);
-
-	f_pdata->addr_width = 0;
-	if (op->addr.buswidth)
-		f_pdata->addr_width = ilog2(op->addr.buswidth);
-
-	f_pdata->data_width = 0;
-	if (op->data.buswidth)
-		f_pdata->data_width = ilog2(op->data.buswidth);
-
-	/* Right now we only support 8-8-8 DTR mode. */
-	if (f_pdata->dtr) {
-		switch (op->cmd.buswidth) {
-		case 0:
-		case 8:
-			break;
-		default:
-			return -EINVAL;
-		}
-
-		switch (op->addr.buswidth) {
-		case 0:
-		case 8:
-			break;
-		default:
-			return -EINVAL;
-		}
-
-		switch (op->data.buswidth) {
-		case 0:
-		case 8:
-			break;
-		default:
-			return -EINVAL;
-		}
-	}
-
-	return 0;
-}
-
 static int cqspi_wait_idle(struct cqspi_st *cqspi)
 {
 	const unsigned int poll_idle_retry = 3;
@@ -503,8 +447,7 @@ static int cqspi_setup_opcode_ext(struct cqspi_flash_pdata *f_pdata,
 }
 
 static int cqspi_enable_dtr(struct cqspi_flash_pdata *f_pdata,
-			    const struct spi_mem_op *op, unsigned int shift,
-			    bool enable)
+			    const struct spi_mem_op *op, unsigned int shift)
 {
 	struct cqspi_st *cqspi = f_pdata->cqspi;
 	void __iomem *reg_base = cqspi->iobase;
@@ -517,7 +460,7 @@ static int cqspi_enable_dtr(struct cqspi_flash_pdata *f_pdata,
 	 * We enable dual byte opcode here. The callers have to set up the
 	 * extension opcode based on which type of operation it is.
 	 */
-	if (enable) {
+	if (op->cmd.dtr) {
 		reg |= CQSPI_REG_CONFIG_DTR_PROTO;
 		reg |= CQSPI_REG_CONFIG_DUAL_OPCODE;
 
@@ -549,12 +492,7 @@ static int cqspi_command_read(struct cqspi_flash_pdata *f_pdata,
 	size_t read_len;
 	int status;
 
-	status = cqspi_set_protocol(f_pdata, op);
-	if (status)
-		return status;
-
-	status = cqspi_enable_dtr(f_pdata, op, CQSPI_REG_OP_EXT_STIG_LSB,
-				  f_pdata->dtr);
+	status = cqspi_enable_dtr(f_pdata, op, CQSPI_REG_OP_EXT_STIG_LSB);
 	if (status)
 		return status;
 
@@ -565,17 +503,17 @@ static int cqspi_command_read(struct cqspi_flash_pdata *f_pdata,
 		return -EINVAL;
 	}
 
-	if (f_pdata->dtr)
+	if (op->cmd.dtr)
 		opcode = op->cmd.opcode >> 8;
 	else
 		opcode = op->cmd.opcode;
 
 	reg = opcode << CQSPI_REG_CMDCTRL_OPCODE_LSB;
 
-	rdreg = cqspi_calc_rdreg(f_pdata);
+	rdreg = cqspi_calc_rdreg(op);
 	writel(rdreg, reg_base + CQSPI_REG_RD_INSTR);
 
-	dummy_clk = cqspi_calc_dummy(op, f_pdata->dtr);
+	dummy_clk = cqspi_calc_dummy(op);
 	if (dummy_clk > CQSPI_DUMMY_CLKS_MAX)
 		return -EOPNOTSUPP;
 
@@ -622,12 +560,7 @@ static int cqspi_command_write(struct cqspi_flash_pdata *f_pdata,
 	size_t write_len;
 	int ret;
 
-	ret = cqspi_set_protocol(f_pdata, op);
-	if (ret)
-		return ret;
-
-	ret = cqspi_enable_dtr(f_pdata, op, CQSPI_REG_OP_EXT_STIG_LSB,
-			       f_pdata->dtr);
+	ret = cqspi_enable_dtr(f_pdata, op, CQSPI_REG_OP_EXT_STIG_LSB);
 	if (ret)
 		return ret;
 
@@ -638,10 +571,10 @@ static int cqspi_command_write(struct cqspi_flash_pdata *f_pdata,
 		return -EINVAL;
 	}
 
-	reg = cqspi_calc_rdreg(f_pdata);
+	reg = cqspi_calc_rdreg(op);
 	writel(reg, reg_base + CQSPI_REG_RD_INSTR);
 
-	if (f_pdata->dtr)
+	if (op->cmd.dtr)
 		opcode = op->cmd.opcode >> 8;
 	else
 		opcode = op->cmd.opcode;
@@ -688,21 +621,20 @@ static int cqspi_read_setup(struct cqspi_flash_pdata *f_pdata,
 	int ret;
 	u8 opcode;
 
-	ret = cqspi_enable_dtr(f_pdata, op, CQSPI_REG_OP_EXT_READ_LSB,
-			       f_pdata->dtr);
+	ret = cqspi_enable_dtr(f_pdata, op, CQSPI_REG_OP_EXT_READ_LSB);
 	if (ret)
 		return ret;
 
-	if (f_pdata->dtr)
+	if (op->cmd.dtr)
 		opcode = op->cmd.opcode >> 8;
 	else
 		opcode = op->cmd.opcode;
 
 	reg = opcode << CQSPI_REG_RD_INSTR_OPCODE_LSB;
-	reg |= cqspi_calc_rdreg(f_pdata);
+	reg |= cqspi_calc_rdreg(op);
 
 	/* Setup dummy clock cycles */
-	dummy_clk = cqspi_calc_dummy(op, f_pdata->dtr);
+	dummy_clk = cqspi_calc_dummy(op);
 
 	if (dummy_clk > CQSPI_DUMMY_CLKS_MAX)
 		return -EOPNOTSUPP;
@@ -947,22 +879,21 @@ static int cqspi_write_setup(struct cqspi_flash_pdata *f_pdata,
 	void __iomem *reg_base = cqspi->iobase;
 	u8 opcode;
 
-	ret = cqspi_enable_dtr(f_pdata, op, CQSPI_REG_OP_EXT_WRITE_LSB,
-			       f_pdata->dtr);
+	ret = cqspi_enable_dtr(f_pdata, op, CQSPI_REG_OP_EXT_WRITE_LSB);
 	if (ret)
 		return ret;
 
-	if (f_pdata->dtr)
+	if (op->cmd.dtr)
 		opcode = op->cmd.opcode >> 8;
 	else
 		opcode = op->cmd.opcode;
 
 	/* Set opcode. */
 	reg = opcode << CQSPI_REG_WR_INSTR_OPCODE_LSB;
-	reg |= f_pdata->data_width << CQSPI_REG_WR_INSTR_TYPE_DATA_LSB;
-	reg |= f_pdata->addr_width << CQSPI_REG_WR_INSTR_TYPE_ADDR_LSB;
+	reg |= CQSPI_OP_WIDTH(op->data) << CQSPI_REG_WR_INSTR_TYPE_DATA_LSB;
+	reg |= CQSPI_OP_WIDTH(op->addr) << CQSPI_REG_WR_INSTR_TYPE_ADDR_LSB;
 	writel(reg, reg_base + CQSPI_REG_WR_INSTR);
-	reg = cqspi_calc_rdreg(f_pdata);
+	reg = cqspi_calc_rdreg(op);
 	writel(reg, reg_base + CQSPI_REG_RD_INSTR);
 
 	/*
@@ -1244,10 +1175,6 @@ static ssize_t cqspi_write(struct cqspi_flash_pdata *f_pdata,
 	const u_char *buf = op->data.buf.out;
 	int ret;
 
-	ret = cqspi_set_protocol(f_pdata, op);
-	if (ret)
-		return ret;
-
 	ret = cqspi_write_setup(f_pdata, op);
 	if (ret)
 		return ret;
@@ -1260,7 +1187,7 @@ static ssize_t cqspi_write(struct cqspi_flash_pdata *f_pdata,
 	 * mode. So, we can not use direct mode when in DTR mode for writing
 	 * data.
 	 */
-	if (!f_pdata->dtr && cqspi->use_direct_mode &&
+	if (!op->cmd.dtr && cqspi->use_direct_mode &&
 	    ((to + len) <= cqspi->ahb_size)) {
 		memcpy_toio(cqspi->ahb_base + to, buf, len);
 		return cqspi_wait_idle(cqspi);
@@ -1348,9 +1275,6 @@ static ssize_t cqspi_read(struct cqspi_flash_pdata *f_pdata,
 	int ret;
 
 	ddata = of_device_get_match_data(dev);
-	ret = cqspi_set_protocol(f_pdata, op);
-	if (ret)
-		return ret;
 
 	ret = cqspi_read_setup(f_pdata, op);
 	if (ret)
-- 
2.25.1


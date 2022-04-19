Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 911AF50671E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 10:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350106AbiDSIt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 04:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240442AbiDSIty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 04:49:54 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2132D22B0D;
        Tue, 19 Apr 2022 01:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1650358032; x=1681894032;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lfyGlOwBn9Oqk37H4rCgm5uXFJD2It20JCnLmPhZ6qc=;
  b=nKUze+PQ/ooAXXn2udk4YcGVo3KvxcEdHO6u74CcAUCoiFoeE5QH+Ngz
   6ICMtfLqpmpr3qf7KZ9d9halBXPrtvTOp1iRegOdcsjqtQBjHk0ZEVr5h
   nRXpJRZH15vy5oYL+q6pA/Ok8hqgqfggk9jksYygUUgKUCxxvepKVWhsb
   tmnvsCktu522tfeNU9d67kjPYFGkZ7e3OV3q/MP47hRkoos2SPzHhT1M9
   lyE+ORp4Uf1WkM7G20cAFoRJc0Y8XXukYPvGJpgUtGuX2OCbpeLa0Pw3c
   xN5svtCE+sVo3N4DHprQSnqdr3L3yDFnmL5Q7MqeARGbrgc3jD1j3kTCR
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,272,1643670000"; 
   d="scan'208";a="23351059"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 19 Apr 2022 10:47:08 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Tue, 19 Apr 2022 10:47:08 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Tue, 19 Apr 2022 10:47:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1650358028; x=1681894028;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lfyGlOwBn9Oqk37H4rCgm5uXFJD2It20JCnLmPhZ6qc=;
  b=RlbZYs6HbEw/+0ju8CZhkYtUstSpLJf9etbQRRkb5MkyHLqGTXty7gGs
   AWMIaG5Oqa2iCru62idW4JbbQdvphu7ckJXNLp+7sc+c1RXR2Q8dDONTh
   OsPAWcxsy+TQ5LQmK0xwmL5v9K3bAMxhdjch8hzgYz1U7lVVbnoTH7/QQ
   ge0S1dM1LC4mlYz9DH238Rb3Uxd7ZpXkaj6Pa0Pk16Hahk9eEDgRhI5fT
   Ep0mJeqCytzu3uz3EC5UqS8rgT0Ovt2vNR7Fzkk0Fluf4CE6KdFH5VB33
   4wVFKQLdjNo91TuR3g3ydOUJp06klAZ676OxwomCv7LMgwU6+EXKfoHHG
   A==;
X-IronPort-AV: E=Sophos;i="5.90,272,1643670000"; 
   d="scan'208";a="23351045"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 19 Apr 2022 10:47:02 +0200
Received: from localhost.localdomain (SCHIFFERM-M2.tq-net.de [10.121.49.14])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id CE4CF280070;
        Tue, 19 Apr 2022 10:46:57 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Pratyush Yadav <p.yadav@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH 1/2] spi: cadence-quadspi: further simplify cqspi_set_protocol()
Date:   Tue, 19 Apr 2022 10:46:39 +0200
Message-Id: <20220419084640.191299-1-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Remove checks for unsupported modes that are already handled by
  supports_op(). This allows to change the function to return void.
- Distinguishing DTR and non-DTR modes is not necessary for the setup of
  the bus widths
- Only cmd DTR flag needs to be checked, supports_op() already checks
  that the DTR flags of all relevant parts of the op match
- Check nbytes instead of buswidth for 0, for consistency with
  supports_op() etc.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 drivers/spi/spi-cadence-quadspi.c | 73 +++++--------------------------
 1 file changed, 10 insertions(+), 63 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 19686fb47bb3..96d14f3847b5 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -368,58 +368,13 @@ static unsigned int cqspi_calc_dummy(const struct spi_mem_op *op, bool dtr)
 	return dummy_clk;
 }
 
-static int cqspi_set_protocol(struct cqspi_flash_pdata *f_pdata,
-			      const struct spi_mem_op *op)
+static void cqspi_set_protocol(struct cqspi_flash_pdata *f_pdata,
+			       const struct spi_mem_op *op)
 {
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
+	f_pdata->inst_width = op->cmd.nbytes ? ilog2(op->cmd.buswidth) : 0;
+	f_pdata->addr_width = op->addr.nbytes ? ilog2(op->addr.buswidth) : 0;
+	f_pdata->data_width = op->data.nbytes ? ilog2(op->data.buswidth) : 0;
+	f_pdata->dtr = op->cmd.dtr;
 }
 
 static int cqspi_wait_idle(struct cqspi_st *cqspi)
@@ -549,9 +504,7 @@ static int cqspi_command_read(struct cqspi_flash_pdata *f_pdata,
 	size_t read_len;
 	int status;
 
-	status = cqspi_set_protocol(f_pdata, op);
-	if (status)
-		return status;
+	cqspi_set_protocol(f_pdata, op);
 
 	status = cqspi_enable_dtr(f_pdata, op, CQSPI_REG_OP_EXT_STIG_LSB,
 				  f_pdata->dtr);
@@ -622,9 +575,7 @@ static int cqspi_command_write(struct cqspi_flash_pdata *f_pdata,
 	size_t write_len;
 	int ret;
 
-	ret = cqspi_set_protocol(f_pdata, op);
-	if (ret)
-		return ret;
+	cqspi_set_protocol(f_pdata, op);
 
 	ret = cqspi_enable_dtr(f_pdata, op, CQSPI_REG_OP_EXT_STIG_LSB,
 			       f_pdata->dtr);
@@ -1244,9 +1195,7 @@ static ssize_t cqspi_write(struct cqspi_flash_pdata *f_pdata,
 	const u_char *buf = op->data.buf.out;
 	int ret;
 
-	ret = cqspi_set_protocol(f_pdata, op);
-	if (ret)
-		return ret;
+	cqspi_set_protocol(f_pdata, op);
 
 	ret = cqspi_write_setup(f_pdata, op);
 	if (ret)
@@ -1348,9 +1297,7 @@ static ssize_t cqspi_read(struct cqspi_flash_pdata *f_pdata,
 	int ret;
 
 	ddata = of_device_get_match_data(dev);
-	ret = cqspi_set_protocol(f_pdata, op);
-	if (ret)
-		return ret;
+	cqspi_set_protocol(f_pdata, op);
 
 	ret = cqspi_read_setup(f_pdata, op);
 	if (ret)
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 214AF4ED83A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 13:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234932AbiCaLKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 07:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234928AbiCaLKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 07:10:40 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526711CFE3;
        Thu, 31 Mar 2022 04:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1648724932; x=1680260932;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=02Kh2G2tw1qOTPyK+LDa8jdNbMtL/fx3qG1NfJSeKik=;
  b=C+MSWkbDRQIFHYsHi8HHf7bWZ/W2J+R/cZCGJ1udCzC5P3D+gduqlzcl
   rhs0ExPfmz/Kn2D7R7T8diu556l4AadhI7TJNzCcnS0iHudKPhQjoDAu2
   ZbVdo2yj/Lbdo70Mam/nRJA482EjBAGfvFkfZCarUXSFvtN15vMau2C8/
   488g/cvNtQCAiuFHaaTwecZupsO9oxVnt5/ehY2UofGqWi0LV+WkO9082
   EdrITuD49/zIH35mmGsoIUdMtdkEF8zGkl951gG/0Fad1ewalOSwu4PiU
   KphoPxzCgQ+laM6HEkFsYp4tafGj8bYSUHeQyvxWpS5PjOlB7o6VsJaLA
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,225,1643670000"; 
   d="scan'208";a="23014419"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 31 Mar 2022 13:08:49 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Thu, 31 Mar 2022 13:08:49 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Thu, 31 Mar 2022 13:08:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1648724929; x=1680260929;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=02Kh2G2tw1qOTPyK+LDa8jdNbMtL/fx3qG1NfJSeKik=;
  b=fmGDfhDW0ykWnC7EMETyE0ONjdB22ZxXonzMJubQHsqbMHpk/5+KGEjs
   ias1KCg4lel6V2JyEFjjBQo8zp6J2d6un/gCav8QR3thg0wszxYikDcit
   ikBSk2liQSWDtfqfX7C+gHycepq0aigDXduiGPGxv13LMl/lpsEZjSUCA
   2mi+QnzG77wBXsU0aDsUn+ULyJX2RwJeepBgf22tvjtoBNaKlY9R5ktK3
   qpFEBL4PtM2/W7OVFNL52QmUXQvoBYQYIW2Ulm9PrXICwCc5vzoNffHkt
   0ip+ZITy+AW3/CsllFW6MH3zkw833S4oS6iWaDVrZCsXy50gS7dqpQLsL
   A==;
X-IronPort-AV: E=Sophos;i="5.90,225,1643670000"; 
   d="scan'208";a="23014418"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 31 Mar 2022 13:08:49 +0200
Received: from localhost.localdomain (SCHIFFERM-M2.tq-net.de [10.121.49.14])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 0D494280065;
        Thu, 31 Mar 2022 13:08:49 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH] spi: cadence-quadspi: fix protocol setup for non-1-1-X operations
Date:   Thu, 31 Mar 2022 13:08:19 +0200
Message-Id: <20220331110819.133392-1-matthias.schiffer@ew.tq-group.com>
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

cqspi_set_protocol() only set the data width, but ignored the command
and address width (except for 8-8-8 DTR ops), leading to corruption of
all transfers using 1-X-X or X-X-X ops. Fix by setting the other two
widths as well.

While we're at it, simplify the code a bit by replacing the
CQSPI_INST_TYPE_* constants with ilog2().

Tested on a TI AM64x with a Macronix MX25U51245G QSPI flash with 1-4-4
read and write operations.

Fixes: a314f6367787 ("mtd: spi-nor: Convert cadence-quadspi to use spi-mem framework")
Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 drivers/spi/spi-cadence-quadspi.c | 46 ++++++++-----------------------
 1 file changed, 12 insertions(+), 34 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index b0c9f62ccefb..616ada891974 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -19,6 +19,7 @@
 #include <linux/iopoll.h>
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
+#include <linux/log2.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/of.h>
@@ -102,12 +103,6 @@ struct cqspi_driver_platdata {
 #define CQSPI_TIMEOUT_MS			500
 #define CQSPI_READ_TIMEOUT_MS			10
 
-/* Instruction type */
-#define CQSPI_INST_TYPE_SINGLE			0
-#define CQSPI_INST_TYPE_DUAL			1
-#define CQSPI_INST_TYPE_QUAD			2
-#define CQSPI_INST_TYPE_OCTAL			3
-
 #define CQSPI_DUMMY_CLKS_PER_BYTE		8
 #define CQSPI_DUMMY_BYTES_MAX			4
 #define CQSPI_DUMMY_CLKS_MAX			31
@@ -376,10 +371,6 @@ static unsigned int cqspi_calc_dummy(const struct spi_mem_op *op, bool dtr)
 static int cqspi_set_protocol(struct cqspi_flash_pdata *f_pdata,
 			      const struct spi_mem_op *op)
 {
-	f_pdata->inst_width = CQSPI_INST_TYPE_SINGLE;
-	f_pdata->addr_width = CQSPI_INST_TYPE_SINGLE;
-	f_pdata->data_width = CQSPI_INST_TYPE_SINGLE;
-
 	/*
 	 * For an op to be DTR, cmd phase along with every other non-empty
 	 * phase should have dtr field set to 1. If an op phase has zero
@@ -389,32 +380,23 @@ static int cqspi_set_protocol(struct cqspi_flash_pdata *f_pdata,
 		       (!op->addr.nbytes || op->addr.dtr) &&
 		       (!op->data.nbytes || op->data.dtr);
 
-	switch (op->data.buswidth) {
-	case 0:
-		break;
-	case 1:
-		f_pdata->data_width = CQSPI_INST_TYPE_SINGLE;
-		break;
-	case 2:
-		f_pdata->data_width = CQSPI_INST_TYPE_DUAL;
-		break;
-	case 4:
-		f_pdata->data_width = CQSPI_INST_TYPE_QUAD;
-		break;
-	case 8:
-		f_pdata->data_width = CQSPI_INST_TYPE_OCTAL;
-		break;
-	default:
-		return -EINVAL;
-	}
+	f_pdata->inst_width = 0;
+	if (op->cmd.buswidth)
+		f_pdata->inst_width = ilog2(op->cmd.buswidth);
+
+	f_pdata->addr_width = 0;
+	if (op->addr.buswidth)
+		f_pdata->addr_width = ilog2(op->addr.buswidth);
+
+	f_pdata->data_width = 0;
+	if (op->data.buswidth)
+		f_pdata->data_width = ilog2(op->data.buswidth);
 
 	/* Right now we only support 8-8-8 DTR mode. */
 	if (f_pdata->dtr) {
 		switch (op->cmd.buswidth) {
 		case 0:
-			break;
 		case 8:
-			f_pdata->inst_width = CQSPI_INST_TYPE_OCTAL;
 			break;
 		default:
 			return -EINVAL;
@@ -422,9 +404,7 @@ static int cqspi_set_protocol(struct cqspi_flash_pdata *f_pdata,
 
 		switch (op->addr.buswidth) {
 		case 0:
-			break;
 		case 8:
-			f_pdata->addr_width = CQSPI_INST_TYPE_OCTAL;
 			break;
 		default:
 			return -EINVAL;
@@ -432,9 +412,7 @@ static int cqspi_set_protocol(struct cqspi_flash_pdata *f_pdata,
 
 		switch (op->data.buswidth) {
 		case 0:
-			break;
 		case 8:
-			f_pdata->data_width = CQSPI_INST_TYPE_OCTAL;
 			break;
 		default:
 			return -EINVAL;
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC9914FBC88
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 14:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346248AbiDKM4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 08:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346237AbiDKM4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 08:56:05 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82AC338AD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 05:53:50 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:b509:6862:2557:437a])
        by laurent.telenet-ops.be with bizsmtp
        id HQto270031G7NMJ01Qtoiv; Mon, 11 Apr 2022 14:53:49 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1ndtYB-000ARL-DF; Mon, 11 Apr 2022 14:53:47 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1ndtYA-009JGV-J1; Mon, 11 Apr 2022 14:53:46 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Duc Nguyen <duc.nguyen.ub@renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>,
        linux-renesas-soc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v4] memory: renesas-rpc-if: Fix HF/OSPI data transfer in Manual Mode
Date:   Mon, 11 Apr 2022 14:53:45 +0200
Message-Id: <cde9bfacf704c81865f57b15d1b48a4793da4286.1649681476.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HyperFlash devices fail to probe:

    rpc-if-hyperflash rpc-if-hyperflash: probing of hyperbus device failed

In HyperFlash or Octal-SPI Flash mode, the Transfer Data Enable bits
(SPIDE) in the Manual Mode Enable Setting Register (SMENR) are derived
from half of the transfer size, cfr. the rpcif_bits_set() helper
function.  However, rpcif_reg_{read,write}() does not take the bus size
into account, and does not double all Manual Mode Data Register access
sizes when communicating with a HyperFlash or Octal-SPI Flash device.

Fix this, and avoid the back-and-forth conversion between transfer size
and Transfer Data Enable bits, by explicitly storing the transfer size
in struct rpcif, and using that value to determine access size in
rpcif_reg_{read,write}().

Enforce that the "high" Manual Mode Read/Write Data Registers
(SM[RW]DR1) are only used for 8-byte data accesses.
While at it, forbid writing to the Manual Mode Read Data Registers,
as they are read-only.

Fixes: fff53a551db50f5e ("memory: renesas-rpc-if: Correct QSPI data transfer in Manual mode")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com> [QSPI]
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
v4:
  - Add Reviewed-by, Tested-by,

v3:
  - Add Tested-by,
  - Update comments to match changed code,
  - Add explicit {read,write}l() for the 4/8 byte case, to increase
    readability,
  - Remove redundant break statements,
  - Tested HyperFlash on more boards and SoCs.

v2:
  - Use rpc->xfer_size instead of SPIDE register reads and
    rpc->bus_size.
      Note: Alternatively, rpcif_manual_xfer() could bypass regmap and
      use {read,write}[bwl]() directly, cfr. commit 0d37f69cacb33435
      ("memory: renesas-rpc-if: Correct QSPI data transfer in Manual
      mode") in the BSP.
  - HF dirmap reads are confirmed to work on R-Car M3-W,
  - Drop RFC.
---
 drivers/memory/renesas-rpc-if.c | 60 +++++++++++++++++++++++++--------
 include/memory/renesas-rpc-if.h |  1 +
 2 files changed, 47 insertions(+), 14 deletions(-)

diff --git a/drivers/memory/renesas-rpc-if.c b/drivers/memory/renesas-rpc-if.c
index 2e545f473cc68fb3..019a0822bde0e413 100644
--- a/drivers/memory/renesas-rpc-if.c
+++ b/drivers/memory/renesas-rpc-if.c
@@ -164,25 +164,39 @@ static const struct regmap_access_table rpcif_volatile_table = {
 
 
 /*
- * Custom accessor functions to ensure SMRDR0 and SMWDR0 are always accessed
- * with proper width. Requires SMENR_SPIDE to be correctly set before!
+ * Custom accessor functions to ensure SM[RW]DR[01] are always accessed with
+ * proper width.  Requires rpcif.xfer_size to be correctly set before!
  */
 static int rpcif_reg_read(void *context, unsigned int reg, unsigned int *val)
 {
 	struct rpcif *rpc = context;
 
-	if (reg == RPCIF_SMRDR0 || reg == RPCIF_SMWDR0) {
-		u32 spide = readl(rpc->base + RPCIF_SMENR) & RPCIF_SMENR_SPIDE(0xF);
-
-		if (spide == 0x8) {
+	switch (reg) {
+	case RPCIF_SMRDR0:
+	case RPCIF_SMWDR0:
+		switch (rpc->xfer_size) {
+		case 1:
 			*val = readb(rpc->base + reg);
 			return 0;
-		} else if (spide == 0xC) {
+
+		case 2:
 			*val = readw(rpc->base + reg);
 			return 0;
-		} else if (spide != 0xF) {
+
+		case 4:
+		case 8:
+			*val = readl(rpc->base + reg);
+			return 0;
+
+		default:
 			return -EILSEQ;
 		}
+
+	case RPCIF_SMRDR1:
+	case RPCIF_SMWDR1:
+		if (rpc->xfer_size != 8)
+			return -EILSEQ;
+		break;
 	}
 
 	*val = readl(rpc->base + reg);
@@ -193,18 +207,34 @@ static int rpcif_reg_write(void *context, unsigned int reg, unsigned int val)
 {
 	struct rpcif *rpc = context;
 
-	if (reg == RPCIF_SMRDR0 || reg == RPCIF_SMWDR0) {
-		u32 spide = readl(rpc->base + RPCIF_SMENR) & RPCIF_SMENR_SPIDE(0xF);
-
-		if (spide == 0x8) {
+	switch (reg) {
+	case RPCIF_SMWDR0:
+		switch (rpc->xfer_size) {
+		case 1:
 			writeb(val, rpc->base + reg);
 			return 0;
-		} else if (spide == 0xC) {
+
+		case 2:
 			writew(val, rpc->base + reg);
 			return 0;
-		} else if (spide != 0xF) {
+
+		case 4:
+		case 8:
+			writel(val, rpc->base + reg);
+			return 0;
+
+		default:
 			return -EILSEQ;
 		}
+
+	case RPCIF_SMWDR1:
+		if (rpc->xfer_size != 8)
+			return -EILSEQ;
+		break;
+
+	case RPCIF_SMRDR0:
+	case RPCIF_SMRDR1:
+		return -EPERM;
 	}
 
 	writel(val, rpc->base + reg);
@@ -469,6 +499,7 @@ int rpcif_manual_xfer(struct rpcif *rpc)
 
 			smenr |= RPCIF_SMENR_SPIDE(rpcif_bits_set(rpc, nbytes));
 			regmap_write(rpc->regmap, RPCIF_SMENR, smenr);
+			rpc->xfer_size = nbytes;
 
 			memcpy(data, rpc->buffer + pos, nbytes);
 			if (nbytes == 8) {
@@ -533,6 +564,7 @@ int rpcif_manual_xfer(struct rpcif *rpc)
 			regmap_write(rpc->regmap, RPCIF_SMENR, smenr);
 			regmap_write(rpc->regmap, RPCIF_SMCR,
 				     rpc->smcr | RPCIF_SMCR_SPIE);
+			rpc->xfer_size = nbytes;
 			ret = wait_msg_xfer_end(rpc);
 			if (ret)
 				goto err_out;
diff --git a/include/memory/renesas-rpc-if.h b/include/memory/renesas-rpc-if.h
index 7c93f5177532f187..9c0ad64b8d292d49 100644
--- a/include/memory/renesas-rpc-if.h
+++ b/include/memory/renesas-rpc-if.h
@@ -72,6 +72,7 @@ struct rpcif {
 	enum rpcif_type type;
 	enum rpcif_data_dir dir;
 	u8 bus_size;
+	u8 xfer_size;
 	void *buffer;
 	u32 xferlen;
 	u32 smcr;
-- 
2.25.1


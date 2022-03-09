Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 668564D30E2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 15:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233478AbiCIOSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 09:18:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233463AbiCIOSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 09:18:14 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA68158D98
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 06:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646835437; x=1678371437;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t2LKPixQNCEbNxRbIvjtc/abLj2E3NE0mNcxvQXI5FU=;
  b=m7P7iKIgk0ePZKSe6WssmZn9NBHL3Mmvy1tUHjSPfcabKrS4FjQVJitx
   pn+pzdTV2ZHel7RmT3XLO4agC9Zd2YcGQidclUR+B1VR4IJ1GxwEIuS6T
   Mea0BPBnh+4+dL5old2pgc/+iBXBgeMI+ikxQRvdJmtPBeIkTRt+S5Rmk
   /RZ2vxNllbUiZvIsdmnoz9u7qJ2O4q1Kab5GRlranBA9iMfcMdxBqXzgp
   GvkXCDQA7rJeJqURaNPoMa+pha2AnD69Y4H/dzjZMaliaDzY+J3SBdDnO
   hTGulIX/PBnAq6Yb8OKsURago5859SgYfNk2YeSrow8Z9QSIEH4cs/Y6v
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,167,1643698800"; 
   d="scan'208";a="155809696"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Mar 2022 07:17:16 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 9 Mar 2022 07:17:15 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 9 Mar 2022 07:17:13 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <p.yadav@ti.com>, <michael@walle.cc>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>
Subject: [PATCH 3/5] mtd: spi-nor: Favor the BFPT-parsed set_4byte_addr_mode method
Date:   Wed, 9 Mar 2022 16:17:00 +0200
Message-ID: <20220309141702.173879-4-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220309141702.173879-1-tudor.ambarus@microchip.com>
References: <20220309141702.173879-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

JESD216 SFDP defines in the BFPT standard methods to enter and exit the
4-Byte Address Mode. The flash parameters and settings that are retrieved
from SFDP have higher precedence than the static initialized ones, because
they should be more accurate and less error prone than those initialized
statically. Favor the BFPT-parsed set_4byte_addr_mode method and use the
generic core methods where possible.
This patch may introduce regressions in case BFPT contains wrong data. The
fix is to introduce a post_bfpt() fixup hook and update the wrong BFPT
data.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/core.c      |  7 ++++++-
 drivers/mtd/spi-nor/macronix.c  | 10 ++++++++--
 drivers/mtd/spi-nor/micron-st.c |  9 ++++++---
 3 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 91d3754baa59..5de46a786cc5 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2418,6 +2418,8 @@ static void spi_nor_init_fixup_flags(struct spi_nor *nor)
  */
 static void spi_nor_late_init_params(struct spi_nor *nor)
 {
+	struct spi_nor_flash_parameter *params = nor->params;
+
 	if (nor->manufacturer && nor->manufacturer->fixups &&
 	    nor->manufacturer->fixups->late_init)
 		nor->manufacturer->fixups->late_init(nor);
@@ -2425,6 +2427,10 @@ static void spi_nor_late_init_params(struct spi_nor *nor)
 	if (nor->info->fixups && nor->info->fixups->late_init)
 		nor->info->fixups->late_init(nor);
 
+	/* Default method kept for backward compatibility. */
+	if (!params->set_4byte_addr_mode)
+		params->set_4byte_addr_mode = spi_nor_set_4byte_addr_mode_brwr;
+
 	spi_nor_init_flags(nor);
 	spi_nor_init_fixup_flags(nor);
 
@@ -2492,7 +2498,6 @@ static void spi_nor_init_default_params(struct spi_nor *nor)
 	struct device_node *np = spi_nor_get_flash_node(nor);
 
 	params->quad_enable = spi_nor_sr2_bit1_quad_enable;
-	params->set_4byte_addr_mode = spi_nor_set_4byte_addr_mode_brwr;
 	params->otp.org = &info->otp_org;
 
 	/* Default to 16-bit Write Status (01h) Command */
diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
index 85e8655d362c..c267cbcc7f1d 100644
--- a/drivers/mtd/spi-nor/macronix.c
+++ b/drivers/mtd/spi-nor/macronix.c
@@ -105,12 +105,18 @@ static const struct flash_info macronix_nor_parts[] = {
 static void macronix_nor_default_init(struct spi_nor *nor)
 {
 	nor->params->quad_enable = spi_nor_sr1_bit6_quad_enable;
-	nor->params->set_4byte_addr_mode =
-		spi_nor_set_4byte_addr_mode_en4b_ex4b;
+}
+
+static void macronix_nor_late_init(struct spi_nor *nor)
+{
+	if (!nor->params->set_4byte_addr_mode)
+		nor->params->set_4byte_addr_mode =
+			spi_nor_set_4byte_addr_mode_en4b_ex4b;
 }
 
 static const struct spi_nor_fixups macronix_nor_fixups = {
 	.default_init = macronix_nor_default_init,
+	.late_init = macronix_nor_late_init,
 };
 
 const struct spi_nor_manufacturer spi_nor_macronix = {
diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
index 4baa9dce04f9..a23d2774f166 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -410,14 +410,17 @@ static void micron_st_nor_default_init(struct spi_nor *nor)
 	nor->flags |= SNOR_F_HAS_LOCK;
 	nor->flags &= ~SNOR_F_HAS_16BIT_SR;
 	nor->params->quad_enable = NULL;
-	nor->params->set_4byte_addr_mode =
-		spi_nor_set_4byte_addr_mode_wren_en4b_ex4b;
 }
 
 static void micron_st_nor_late_init(struct spi_nor *nor)
 {
+	struct spi_nor_flash_parameter *params = nor->params;
+
 	if (nor->info->mfr_flags & USE_FSR)
-		nor->params->ready = micron_st_nor_ready;
+		params->ready = micron_st_nor_ready;
+	if (!params->set_4byte_addr_mode)
+		params->set_4byte_addr_mode =
+			spi_nor_set_4byte_addr_mode_wren_en4b_ex4b;
 }
 
 static const struct spi_nor_fixups micron_st_nor_fixups = {
-- 
2.25.1


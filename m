Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 342254BE830
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345768AbiBUI4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 03:56:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345688AbiBUIyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 03:54:13 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536A9237CB
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 00:53:05 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 9A2DF223F7;
        Mon, 21 Feb 2022 09:53:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1645433583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3/u4sjnC/34qrxl+MCwopuiBE7XtG8O9XdqS2xxLCBk=;
        b=eQCGCQio/27yOIq1twcO5+XaAJcqG3xDVMBT+epStxAekqDL1RZtqd7TbzujExXh0+Sh1s
        uInte14cKkD9q8r4fJ5l3/HUdZDgtk18XD8Cgs+8+KfX0/tX4CORbsWgu5LFeesXlFbdu2
        ara0pnmfKJfbofegU/If1tTIybv1Zto=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        yaliang.wang@windriver.com, Michael Walle <michael@walle.cc>
Subject: [PATCH v3 30/32] mtd: spi-nor: spansion: rename vendor specific functions and defines
Date:   Mon, 21 Feb 2022 09:52:34 +0100
Message-Id: <20220221085236.1452024-31-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220221085236.1452024-1-michael@walle.cc>
References: <20220221085236.1452024-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the generic spi_nor prefix for all the spansion functions.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/mtd/spi-nor/spansion.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
index 33ebecbcc3c7..b5bc33dab5ed 100644
--- a/drivers/mtd/spi-nor/spansion.c
+++ b/drivers/mtd/spi-nor/spansion.c
@@ -309,10 +309,10 @@ static const struct flash_info spansion_nor_parts[] = {
 };
 
 /**
- * spi_nor_clear_sr() - Clear the Status Register.
+ * spansion_nor_clear_sr() - Clear the Status Register.
  * @nor:	pointer to 'struct spi_nor'.
  */
-static void spi_nor_clear_sr(struct spi_nor *nor)
+static void spansion_nor_clear_sr(struct spi_nor *nor)
 {
 	int ret;
 
@@ -336,13 +336,13 @@ static void spi_nor_clear_sr(struct spi_nor *nor)
 }
 
 /**
- * spi_nor_sr_ready_and_clear() - Query the Status Register to see if the flash
- * is ready for new commands and clear it.
+ * spansion_nor_sr_ready_and_clear() - Query the Status Register to see if the
+ * flash is ready for new commands and clear it.
  * @nor:	pointer to 'struct spi_nor'.
  *
  * Return: 1 if ready, 0 if not ready, -errno on errors.
  */
-static int spi_nor_sr_ready_and_clear(struct spi_nor *nor)
+static int spansion_nor_sr_ready_and_clear(struct spi_nor *nor)
 {
 	int ret;
 
@@ -356,7 +356,7 @@ static int spi_nor_sr_ready_and_clear(struct spi_nor *nor)
 		else
 			dev_err(nor->dev, "Programming Error occurred\n");
 
-		spi_nor_clear_sr(nor);
+		spansion_nor_clear_sr(nor);
 
 		/*
 		 * WEL bit remains set to one when an erase or page program
@@ -384,7 +384,7 @@ static void spansion_nor_late_init(struct spi_nor *nor)
 	}
 
 	if (nor->info->mfr_flags & USE_CLSR)
-		nor->params->ready = spi_nor_sr_ready_and_clear;
+		nor->params->ready = spansion_nor_sr_ready_and_clear;
 }
 
 static const struct spi_nor_fixups spansion_nor_fixups = {
-- 
2.30.2


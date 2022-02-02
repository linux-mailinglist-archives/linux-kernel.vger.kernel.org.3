Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 390B24A741B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 15:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345260AbiBBO7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 09:59:21 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:39231 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345270AbiBBO7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 09:59:05 -0500
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id A1C2B2244E;
        Wed,  2 Feb 2022 15:59:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1643813944;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U5OZFdf8BUM0At6XcKxiTxaCJx1UapxDC3xB60RQ8F0=;
        b=bD/fYvpUj4FGyMs4buDfPGCIY0eAqj72xNrHBCK2/ercit0jk+ITiOj6ZInjZacrzA1Ehu
        DtMymW7NgQ7anvs42rn/xHqGH3elvDxw0Kj3J3SrZ/s2lz8pCW3MTeWKCJYDXRvEI4e5bt
        tUD3rgUhrt6QH6Lk37qo5J59Lg1zpk4=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v1 10/14] mtd: spi-nor: micron-st: rename vendor specific functions and defines
Date:   Wed,  2 Feb 2022 15:58:49 +0100
Message-Id: <20220202145853.4187726-11-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220202145853.4187726-1-michael@walle.cc>
References: <20220202145853.4187726-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the generic spi_nor prefix for all the micron-st functions.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/mtd/spi-nor/micron-st.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
index ca368b48bcb0..988ecbffdc36 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -308,7 +308,7 @@ static int micron_st_set_4byte_addr_mode(struct spi_nor *nor, bool enable)
 }
 
 /**
- * spi_nor_read_fsr() - Read the Flag Status Register.
+ * micron_st_read_fsr() - Read the Flag Status Register.
  * @nor:	pointer to 'struct spi_nor'
  * @fsr:	pointer to a DMA-able buffer where the value of the
  *              Flag Status Register will be written. Should be at least 2
@@ -316,7 +316,7 @@ static int micron_st_set_4byte_addr_mode(struct spi_nor *nor, bool enable)
  *
  * Return: 0 on success, -errno otherwise.
  */
-static int spi_nor_read_fsr(struct spi_nor *nor, u8 *fsr)
+static int micron_st_read_fsr(struct spi_nor *nor, u8 *fsr)
 {
 	int ret;
 
@@ -352,10 +352,10 @@ static int spi_nor_read_fsr(struct spi_nor *nor, u8 *fsr)
 }
 
 /**
- * spi_nor_clear_fsr() - Clear the Flag Status Register.
+ * micron_st_clear_fsr() - Clear the Flag Status Register.
  * @nor:	pointer to 'struct spi_nor'.
  */
-static void spi_nor_clear_fsr(struct spi_nor *nor)
+static void micron_st_clear_fsr(struct spi_nor *nor)
 {
 	int ret;
 
@@ -379,13 +379,13 @@ static void spi_nor_clear_fsr(struct spi_nor *nor)
 }
 
 /**
- * spi_nor_fsr_ready() - Query the Flag Status Register to see if the flash is
+ * micron_st_fsr_ready() - Query the Flag Status Register to see if the flash is
  * ready for new commands.
  * @nor:	pointer to 'struct spi_nor'.
  *
  * Return: 1 if ready, 0 if not ready, -errno on errors.
  */
-static int spi_nor_fsr_ready(struct spi_nor *nor)
+static int micron_st_fsr_ready(struct spi_nor *nor)
 {
 	int sr_ready, ret;
 
@@ -393,7 +393,7 @@ static int spi_nor_fsr_ready(struct spi_nor *nor)
 	if (sr_ready < 0)
 		return sr_ready;
 
-	ret = spi_nor_read_fsr(nor, nor->bouncebuf);
+	ret = micron_st_read_fsr(nor, nor->bouncebuf);
 	if (ret)
 		return ret;
 
@@ -407,7 +407,7 @@ static int spi_nor_fsr_ready(struct spi_nor *nor)
 			dev_err(nor->dev,
 			"Attempted to modify a protected sector.\n");
 
-		spi_nor_clear_fsr(nor);
+		micron_st_clear_fsr(nor);
 
 		/*
 		 * WEL bit remains set to one when an erase or page program
@@ -433,7 +433,7 @@ static void micron_st_default_init(struct spi_nor *nor)
 	nor->params->set_4byte_addr_mode = micron_st_set_4byte_addr_mode;
 
 	if (nor->info->mfr_flags & USE_FSR)
-		nor->params->ready = spi_nor_fsr_ready;
+		nor->params->ready = micron_st_fsr_ready;
 }
 
 static const struct spi_nor_fixups micron_st_fixups = {
-- 
2.30.2


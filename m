Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA2174C148E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 14:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241209AbiBWNqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 08:46:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241095AbiBWNow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 08:44:52 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6178BAD100
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 05:44:17 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id CC3C0223F6;
        Wed, 23 Feb 2022 14:44:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1645623855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=35/TrCmEc5UMzhIA1WiLFawNYfLWm/HAT5pOPDWhA7g=;
        b=oGhvUGdgRR6POL7pFSOWL899Vqs1yn00SDOSXcW5ESSlWSeYArrNCo/BKV29iGWF8Zi03i
        nQNiUvM4bO97oSswQQc7xnQw2XY+NS78D7banYY01NyLWQ3k+IT90wS5SiURY11revl1iP
        Mw6fCfWGsKqUqEvxE35LGOoYxfYCUCs=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        yaliang.wang@windriver.com, Michael Walle <michael@walle.cc>
Subject: [PATCH v5 26/32] mtd: spi-nor: micron-st: rename vendor specific functions and defines
Date:   Wed, 23 Feb 2022 14:43:52 +0100
Message-Id: <20220223134358.1914798-27-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220223134358.1914798-1-michael@walle.cc>
References: <20220223134358.1914798-1-michael@walle.cc>
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

Drop the generic spi_nor prefix for all the micron-st functions.

Signed-off-by: Michael Walle <michael@walle.cc>
Tested-by: Pratyush Yadav <p.yadav@ti.com> # on mt35xu512aba, s28hs512t
---
 drivers/mtd/spi-nor/micron-st.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
index 1a7227594bf0..8a20475ce77a 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -309,7 +309,7 @@ static int micron_st_nor_set_4byte_addr_mode(struct spi_nor *nor, bool enable)
 }
 
 /**
- * spi_nor_read_fsr() - Read the Flag Status Register.
+ * micron_st_nor_read_fsr() - Read the Flag Status Register.
  * @nor:	pointer to 'struct spi_nor'
  * @fsr:	pointer to a DMA-able buffer where the value of the
  *              Flag Status Register will be written. Should be at least 2
@@ -317,7 +317,7 @@ static int micron_st_nor_set_4byte_addr_mode(struct spi_nor *nor, bool enable)
  *
  * Return: 0 on success, -errno otherwise.
  */
-static int spi_nor_read_fsr(struct spi_nor *nor, u8 *fsr)
+static int micron_st_nor_read_fsr(struct spi_nor *nor, u8 *fsr)
 {
 	int ret;
 
@@ -353,10 +353,10 @@ static int spi_nor_read_fsr(struct spi_nor *nor, u8 *fsr)
 }
 
 /**
- * spi_nor_clear_fsr() - Clear the Flag Status Register.
+ * micron_st_nor_clear_fsr() - Clear the Flag Status Register.
  * @nor:	pointer to 'struct spi_nor'.
  */
-static void spi_nor_clear_fsr(struct spi_nor *nor)
+static void micron_st_nor_clear_fsr(struct spi_nor *nor)
 {
 	int ret;
 
@@ -380,14 +380,14 @@ static void spi_nor_clear_fsr(struct spi_nor *nor)
 }
 
 /**
- * spi_nor_fsr_ready() - Query the Status Register as well as the Flag Status
+ * micron_st_nor_ready() - Query the Status Register as well as the Flag Status
  * Register to see if the flash is ready for new commands. If there are any
  * errors in the FSR clear them.
  * @nor:	pointer to 'struct spi_nor'.
  *
  * Return: 1 if ready, 0 if not ready, -errno on errors.
  */
-static int spi_nor_fsr_ready(struct spi_nor *nor)
+static int micron_st_nor_ready(struct spi_nor *nor)
 {
 	int sr_ready, ret;
 
@@ -395,7 +395,7 @@ static int spi_nor_fsr_ready(struct spi_nor *nor)
 	if (sr_ready < 0)
 		return sr_ready;
 
-	ret = spi_nor_read_fsr(nor, nor->bouncebuf);
+	ret = micron_st_nor_read_fsr(nor, nor->bouncebuf);
 	if (ret)
 		return ret;
 
@@ -409,7 +409,7 @@ static int spi_nor_fsr_ready(struct spi_nor *nor)
 			dev_err(nor->dev,
 				"Attempted to modify a protected sector.\n");
 
-		spi_nor_clear_fsr(nor);
+		micron_st_nor_clear_fsr(nor);
 
 		/*
 		 * WEL bit remains set to one when an erase or page program
@@ -438,7 +438,7 @@ static void micron_st_nor_default_init(struct spi_nor *nor)
 static void micron_st_nor_late_init(struct spi_nor *nor)
 {
 	if (nor->info->mfr_flags & USE_FSR)
-		nor->params->ready = spi_nor_fsr_ready;
+		nor->params->ready = micron_st_nor_ready;
 }
 
 static const struct spi_nor_fixups micron_st_nor_fixups = {
-- 
2.30.2


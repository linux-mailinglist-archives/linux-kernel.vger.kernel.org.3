Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E119A4BB851
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 12:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234872AbiBRLil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 06:38:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234618AbiBRLgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 06:36:46 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67BF02B3541
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 03:36:26 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id C7977223F6;
        Fri, 18 Feb 2022 12:36:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1645184183;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xdcZIpvWBK1SBtBZMLbCaAdxmBv2TOoluOo5rcRL+5U=;
        b=FO8FboQqslYP8X3SyHJNWUYRaDNirmrkkFSgU7B5kIwUmqb8/dXGL/yKrCrYb6a8X6WVwm
        Q6u0I/hUOXPqtf8A+pfu1iFLFOIXy3YresEGkpL7nibp5Mwpxiq+hUUozwebgmSP47xADV
        J3/SAiyyA3DU0lN+E37CH/NrYBKkqvw=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        yaliang.wang@windriver.com, Michael Walle <michael@walle.cc>
Subject: [PATCH v2 30/32] mtd: spi-nor: spansion: rename vendor specific functions and defines
Date:   Fri, 18 Feb 2022 12:36:05 +0100
Message-Id: <20220218113607.1360020-31-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220218113607.1360020-1-michael@walle.cc>
References: <20220218113607.1360020-1-michael@walle.cc>
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
index 061357790dde..ea695db5a4c4 100644
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87AC04A741C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 15:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345445AbiBBO7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 09:59:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345303AbiBBO7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 09:59:06 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9633AC061714
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 06:59:06 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 64EC922441;
        Wed,  2 Feb 2022 15:59:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1643813944;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AX9pymXLzKsGtsuax1oHvt5m9WkCF5LD1CjdM1Z5nko=;
        b=ovdzsz/f8FaU92fqcDM09aVytUUUYN4xJoOBK6zhbPPOWkBCgcdBYzCXRXh2/GiXJVeqB4
        3NjKg5CyzHhdjMrwyUNphwQT7yInJuSb19LWWY7hQ3FXQSQBUxdzrsQrE0/GOQzmIAM4sR
        25GJJ1XVFA4a6+CBlpmx57a0c4ol6QE=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v1 09/14] mtd: spi-nor: micron-st: fix micron_st prefix
Date:   Wed,  2 Feb 2022 15:58:48 +0100
Message-Id: <20220202145853.4187726-10-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220202145853.4187726-1-michael@walle.cc>
References: <20220202145853.4187726-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The usual prefix is micron_st, so use that instead of st_micron.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/mtd/spi-nor/micron-st.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
index 33531c101ccb..ca368b48bcb0 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -284,7 +284,7 @@ static const struct flash_info st_parts[] = {
 };
 
 /**
- * st_micron_set_4byte_addr_mode() - Set 4-byte address mode for ST and Micron
+ * micron_st_set_4byte_addr_mode() - Set 4-byte address mode for ST and Micron
  * flashes.
  * @nor:	pointer to 'struct spi_nor'.
  * @enable:	true to enter the 4-byte address mode, false to exit the 4-byte
@@ -292,7 +292,7 @@ static const struct flash_info st_parts[] = {
  *
  * Return: 0 on success, -errno otherwise.
  */
-static int st_micron_set_4byte_addr_mode(struct spi_nor *nor, bool enable)
+static int micron_st_set_4byte_addr_mode(struct spi_nor *nor, bool enable)
 {
 	int ret;
 
@@ -430,7 +430,7 @@ static void micron_st_default_init(struct spi_nor *nor)
 	nor->flags |= SNOR_F_HAS_LOCK;
 	nor->flags &= ~SNOR_F_HAS_16BIT_SR;
 	nor->params->quad_enable = NULL;
-	nor->params->set_4byte_addr_mode = st_micron_set_4byte_addr_mode;
+	nor->params->set_4byte_addr_mode = micron_st_set_4byte_addr_mode;
 
 	if (nor->info->mfr_flags & USE_FSR)
 		nor->params->ready = spi_nor_fsr_ready;
-- 
2.30.2


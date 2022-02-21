Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 790C44BE816
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345452AbiBUIzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 03:55:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345691AbiBUIxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 03:53:33 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501BF1038
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 00:52:57 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 76FFC223EF;
        Mon, 21 Feb 2022 09:52:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1645433575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4TFVPiTLlGkWwn1EsOaghV7Oi+R3fkCvcWUJOwT6tkU=;
        b=VjmYOKWhLpoy2wjoXDyRtSbUiXIrRePnkYOHLqzoCxmLdsb6S0VB8/aUk3ibE+Gr85ueuY
        DnV51s9DIi8p8N4DrsQvfaKdMioEEi22b0DK24MoyeHJe2a09ZZYMcjA3qm2LZpRgafe0k
        SLchXvRFroOdn7m6uEIPrFEcIA7fDXE=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        yaliang.wang@windriver.com, Michael Walle <michael@walle.cc>
Subject: [PATCH v3 14/32] mtd: spi-nor: winbond: unify function names
Date:   Mon, 21 Feb 2022 09:52:18 +0100
Message-Id: <20220221085236.1452024-15-michael@walle.cc>
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

To avoid name clashes unify all the function and static object names and
use one of the following prefixes which should be sufficiently unique:
 - <vendor>_nor_
 - <flash_family>_nor_
 - <flash_part>_

There are no functional changes.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/mtd/spi-nor/winbond.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
index 3d91888882e4..1e8fb571680b 100644
--- a/drivers/mtd/spi-nor/winbond.c
+++ b/drivers/mtd/spi-nor/winbond.c
@@ -32,7 +32,7 @@ static const struct spi_nor_fixups w25q256_fixups = {
 	.post_bfpt = w25q256_post_bfpt_fixups,
 };
 
-static const struct flash_info winbond_parts[] = {
+static const struct flash_info winbond_nor_parts[] = {
 	/* Winbond -- w25x "blocks" are 64K, "sectors" are 4KiB */
 	{ "w25x05", INFO(0xef3010, 0, 64 * 1024,  1)
 		NO_SFDP_FLAGS(SECT_4K) },
@@ -131,14 +131,15 @@ static const struct flash_info winbond_parts[] = {
 };
 
 /**
- * winbond_set_4byte_addr_mode() - Set 4-byte address mode for Winbond flashes.
+ * winbond_nor_set_4byte_addr_mode() - Set 4-byte address mode for Winbond
+ * flashes.
  * @nor:	pointer to 'struct spi_nor'.
  * @enable:	true to enter the 4-byte address mode, false to exit the 4-byte
  *		address mode.
  *
  * Return: 0 on success, -errno otherwise.
  */
-static int winbond_set_4byte_addr_mode(struct spi_nor *nor, bool enable)
+static int winbond_nor_set_4byte_addr_mode(struct spi_nor *nor, bool enable)
 {
 	int ret;
 
@@ -162,7 +163,7 @@ static int winbond_set_4byte_addr_mode(struct spi_nor *nor, bool enable)
 	return spi_nor_write_disable(nor);
 }
 
-static const struct spi_nor_otp_ops winbond_otp_ops = {
+static const struct spi_nor_otp_ops winbond_nor_otp_ops = {
 	.read = spi_nor_otp_read_secr,
 	.write = spi_nor_otp_write_secr,
 	.erase = spi_nor_otp_erase_secr,
@@ -170,25 +171,25 @@ static const struct spi_nor_otp_ops winbond_otp_ops = {
 	.is_locked = spi_nor_otp_is_locked_sr2,
 };
 
-static void winbond_default_init(struct spi_nor *nor)
+static void winbond_nor_default_init(struct spi_nor *nor)
 {
-	nor->params->set_4byte_addr_mode = winbond_set_4byte_addr_mode;
+	nor->params->set_4byte_addr_mode = winbond_nor_set_4byte_addr_mode;
 }
 
-static void winbond_late_init(struct spi_nor *nor)
+static void winbond_nor_late_init(struct spi_nor *nor)
 {
 	if (nor->params->otp.org->n_regions)
-		nor->params->otp.ops = &winbond_otp_ops;
+		nor->params->otp.ops = &winbond_nor_otp_ops;
 }
 
-static const struct spi_nor_fixups winbond_fixups = {
-	.default_init = winbond_default_init,
-	.late_init = winbond_late_init,
+static const struct spi_nor_fixups winbond_nor_fixups = {
+	.default_init = winbond_nor_default_init,
+	.late_init = winbond_nor_late_init,
 };
 
 const struct spi_nor_manufacturer spi_nor_winbond = {
 	.name = "winbond",
-	.parts = winbond_parts,
-	.nparts = ARRAY_SIZE(winbond_parts),
-	.fixups = &winbond_fixups,
+	.parts = winbond_nor_parts,
+	.nparts = ARRAY_SIZE(winbond_nor_parts),
+	.fixups = &winbond_nor_fixups,
 };
-- 
2.30.2


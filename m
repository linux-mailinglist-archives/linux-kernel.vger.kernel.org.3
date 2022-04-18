Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AECBB504F5E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 13:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233799AbiDRL3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 07:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233110AbiDRL3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 07:29:36 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF8217E30
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 04:26:58 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 8991222175;
        Mon, 18 Apr 2022 13:26:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1650281216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=tE+hOTJnGcUnUgDRWuGXseGh2QeCZJYtJ5niXhv0ouQ=;
        b=GF9v5mT7HOMfLibWpcdhP6WrqTplK8OVbJRvsIJ/nnpTuOUGq8x69BF/EaEDgl4O17rx+b
        ImTG/lqzpyCLDe/9ZVq7Jb6FfGJZ8Zu1H0P+35/70znI4gjGlP1s9ELuxGymMJe9D3xfTR
        FcjJOSII2QYQOHsVspSE74HDz/WIZgU=
From:   Michael Walle <michael@walle.cc>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Michael Walle <michael@walle.cc>
Subject: [PATCH] mtd: spi-nor: move SECT_4K_PMC special handling
Date:   Mon, 18 Apr 2022 13:26:50 +0200
Message-Id: <20220418112650.2791459-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
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

The SECT_4K_PMC flag will set a device specific opcode for the 4k sector
erase. Instead of handling it in the core, we can move it to a
late_init(). In that late init, loop over all erase types, look for the
4k size and replace the opcode.

Signed-off-by: Michael Walle <michael@walle.cc>
---
Please have a closer look here. This is only compile time tested. Also
I didn't see much reason to reorder the flags.

 drivers/mtd/spi-nor/core.c |  7 +------
 drivers/mtd/spi-nor/core.h |  2 --
 drivers/mtd/spi-nor/issi.c | 23 +++++++++++++++++++++--
 3 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 848836535cdd..fd41ab9a8746 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2364,12 +2364,7 @@ static void spi_nor_no_sfdp_init_params(struct spi_nor *nor)
 	 */
 	erase_mask = 0;
 	i = 0;
-	if (no_sfdp_flags & SECT_4K_PMC) {
-		erase_mask |= BIT(i);
-		spi_nor_set_erase_type(&map->erase_type[i], 4096u,
-				       SPINOR_OP_BE_4K_PMC);
-		i++;
-	} else if (no_sfdp_flags & SECT_4K) {
+	if (no_sfdp_flags & SECT_4K) {
 		erase_mask |= BIT(i);
 		spi_nor_set_erase_type(&map->erase_type[i], 4096u,
 				       SPINOR_OP_BE_4K);
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 14bf28473cf3..e355457a8555 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -352,7 +352,6 @@ struct spi_nor_fixups {
  *                  flags are used together with the SPI_NOR_SKIP_SFDP flag.
  *   SPI_NOR_SKIP_SFDP:       skip parsing of SFDP tables.
  *   SECT_4K:                 SPINOR_OP_BE_4K works uniformly.
- *   SECT_4K_PMC:             SPINOR_OP_BE_4K_PMC works uniformly.
  *   SPI_NOR_DUAL_READ:       flash supports Dual Read.
  *   SPI_NOR_QUAD_READ:       flash supports Quad Read.
  *   SPI_NOR_OCTAL_READ:      flash supports Octal Read.
@@ -400,7 +399,6 @@ struct flash_info {
 	u8 no_sfdp_flags;
 #define SPI_NOR_SKIP_SFDP		BIT(0)
 #define SECT_4K				BIT(1)
-#define SECT_4K_PMC			BIT(2)
 #define SPI_NOR_DUAL_READ		BIT(3)
 #define SPI_NOR_QUAD_READ		BIT(4)
 #define SPI_NOR_OCTAL_READ		BIT(5)
diff --git a/drivers/mtd/spi-nor/issi.c b/drivers/mtd/spi-nor/issi.c
index c012bc2486e1..3c7d51d2b050 100644
--- a/drivers/mtd/spi-nor/issi.c
+++ b/drivers/mtd/spi-nor/issi.c
@@ -29,6 +29,21 @@ static const struct spi_nor_fixups is25lp256_fixups = {
 	.post_bfpt = is25lp256_post_bfpt_fixups,
 };
 
+static void pm25lv_nor_late_init(struct spi_nor *nor)
+{
+	struct spi_nor_erase_map *map = &nor->params->erase_map;
+	int i;
+
+	/* The PM25LV series has a different 4k sector erase opcode */
+	for (i = 0; i < SNOR_ERASE_TYPE_MAX; i++)
+		if (map->erase_type[i].size == 4096)
+			map->erase_type[i].opcode = SPINOR_OP_BE_4K_PMC;
+}
+
+static const struct spi_nor_fixups pm25lv_nor_fixups = {
+	.late_init = pm25lv_nor_late_init,
+};
+
 static const struct flash_info issi_nor_parts[] = {
 	/* ISSI */
 	{ "is25cd512",  INFO(0x7f9d20, 0, 32 * 1024,   2)
@@ -62,9 +77,13 @@ static const struct flash_info issi_nor_parts[] = {
 
 	/* PMC */
 	{ "pm25lv512",   INFO(0,        0, 32 * 1024,    2)
-		NO_SFDP_FLAGS(SECT_4K_PMC) },
+		NO_SFDP_FLAGS(SECT_4K)
+		.fixups = &pm25lv_nor_fixups
+	},
 	{ "pm25lv010",   INFO(0,        0, 32 * 1024,    4)
-		NO_SFDP_FLAGS(SECT_4K_PMC) },
+		NO_SFDP_FLAGS(SECT_4K)
+		.fixups = &pm25lv_nor_fixups
+	},
 	{ "pm25lq032",   INFO(0x7f9d46, 0, 64 * 1024,   64)
 		NO_SFDP_FLAGS(SECT_4K) },
 };
-- 
2.30.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2C9C4BE04E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345953AbiBUIzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 03:55:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345633AbiBUIxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 03:53:23 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4512F1A3B5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 00:52:54 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 4E850223E9;
        Mon, 21 Feb 2022 09:52:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1645433572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=azbyCn7H63CLfj7AEiVLfqfkqDigt6V0iDcOpCpZu90=;
        b=oiChbbiJvJXftHzTRNKSFG1UHrZR2m0zarw+YsG2KnGtbFaoFmbuqD7FhU6dZtwGEYH7vA
        vPxJuP73jXu4dvoBJTc+TaMFOYnp4qHDtT4JuCRJQ52OxihxxePOeZ2ZnuKAZH8dyKgg14
        AvBTAPeG0OugMwBo01TeeYyGr7nyPdc=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        yaliang.wang@windriver.com, Michael Walle <michael@walle.cc>
Subject: [PATCH v3 09/32] mtd: spi-nor: issi: unify function names
Date:   Mon, 21 Feb 2022 09:52:13 +0100
Message-Id: <20220221085236.1452024-10-michael@walle.cc>
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
 drivers/mtd/spi-nor/issi.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/spi-nor/issi.c b/drivers/mtd/spi-nor/issi.c
index 23629b919ade..c012bc2486e1 100644
--- a/drivers/mtd/spi-nor/issi.c
+++ b/drivers/mtd/spi-nor/issi.c
@@ -29,7 +29,7 @@ static const struct spi_nor_fixups is25lp256_fixups = {
 	.post_bfpt = is25lp256_post_bfpt_fixups,
 };
 
-static const struct flash_info issi_parts[] = {
+static const struct flash_info issi_nor_parts[] = {
 	/* ISSI */
 	{ "is25cd512",  INFO(0x7f9d20, 0, 32 * 1024,   2)
 		NO_SFDP_FLAGS(SECT_4K) },
@@ -69,18 +69,18 @@ static const struct flash_info issi_parts[] = {
 		NO_SFDP_FLAGS(SECT_4K) },
 };
 
-static void issi_default_init(struct spi_nor *nor)
+static void issi_nor_default_init(struct spi_nor *nor)
 {
 	nor->params->quad_enable = spi_nor_sr1_bit6_quad_enable;
 }
 
 static const struct spi_nor_fixups issi_fixups = {
-	.default_init = issi_default_init,
+	.default_init = issi_nor_default_init,
 };
 
 const struct spi_nor_manufacturer spi_nor_issi = {
 	.name = "issi",
-	.parts = issi_parts,
-	.nparts = ARRAY_SIZE(issi_parts),
+	.parts = issi_nor_parts,
+	.nparts = ARRAY_SIZE(issi_nor_parts),
 	.fixups = &issi_fixups,
 };
-- 
2.30.2


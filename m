Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B47AA526340
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 15:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381553AbiEMNiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 09:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381352AbiEMNfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 09:35:33 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D92C615F
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 06:35:30 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id ABD222224D;
        Fri, 13 May 2022 15:35:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1652448928;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xavI/gAisc47AB04Lxd4coGNq76/GR9N74Rm+AMG6uI=;
        b=kV8Y0Jw3EDQL4i0NJHEfAhJ6F0g6bKhBayKgmBQbhkRYWqUV4GlnZm/c8aLAPLdcgiqASR
        jB9UiWS2jzfGWRVwAQbsciLbjfFAWZDf3zNygvuEogdP7bBYgQR2ZGhJwDOvhfRGQjEWQn
        Bxjdq579wN/jjTOL8dfZlo92oVv+MAg=
From:   Michael Walle <michael@walle.cc>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: [PATCH 3/6] mtd: spi-nor: remember full JEDEC flash ID
Date:   Fri, 13 May 2022 15:35:17 +0200
Message-Id: <20220513133520.3945820-4-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220513133520.3945820-1-michael@walle.cc>
References: <20220513133520.3945820-1-michael@walle.cc>
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

At the moment, we print the JEDEC ID that is stored in our database. The
generic flash support won't have such an entry in our database. To find
out the JEDEC ID later we will have to cache it. There is also another
advantage: If the flash is found in the database, the ID could be
truncated because the ID of the entry is used which can be shorter. Some
flashes still holds valuable information in the bytes after the JEDEC ID
and come in handy during debugging of when coping with INFO6() entries.
These are not accessible for now.

Save a copy of the ID bytes after reading and display it via debugfs.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/mtd/spi-nor/core.c    | 5 +++++
 drivers/mtd/spi-nor/debugfs.c | 2 +-
 include/linux/mtd/spi-nor.h   | 3 +++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index ce5d69317d46..65cd8e668579 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -1664,6 +1664,11 @@ static const struct flash_info *spi_nor_detect(struct spi_nor *nor)
 		return ERR_PTR(ret);
 	}
 
+	/* Cache the complete flash ID. */
+	nor->id = devm_kmemdup(nor->dev, id, SPI_NOR_MAX_ID_LEN, GFP_KERNEL);
+	if (!nor->id)
+		return ERR_PTR(-ENOMEM);
+
 	info = spi_nor_match_id(nor, id);
 	if (!info) {
 		dev_err(nor->dev, "unrecognized JEDEC id bytes: %*ph\n",
diff --git a/drivers/mtd/spi-nor/debugfs.c b/drivers/mtd/spi-nor/debugfs.c
index eaf84f7a0676..23d51e7ba0a7 100644
--- a/drivers/mtd/spi-nor/debugfs.c
+++ b/drivers/mtd/spi-nor/debugfs.c
@@ -81,7 +81,7 @@ static int spi_nor_params_show(struct seq_file *s, void *data)
 	int i;
 
 	seq_printf(s, "name\t\t%s\n", info->name);
-	seq_printf(s, "id\t\t%*ph\n", info->id_len, info->id);
+	seq_printf(s, "id\t\t%*ph\n", SPI_NOR_MAX_ID_LEN, nor->id);
 	string_get_size(params->size, 1, STRING_UNITS_2, buf, sizeof(buf));
 	seq_printf(s, "size\t\t%s\n", buf);
 	seq_printf(s, "write size\t%u\n", params->writesize);
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 1ede4c89805a..4dd6cd7389ca 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -349,6 +349,8 @@ struct spi_nor_flash_parameter;
  * @bouncebuf:		bounce buffer used when the buffer passed by the MTD
  *                      layer is not DMA-able
  * @bouncebuf_size:	size of the bounce buffer
+ * @id:			The flash's ID bytes. Always contains
+ *			SPI_NOR_MAX_ID_LEN bytes.
  * @info:		SPI NOR part JEDEC MFR ID and other info
  * @manufacturer:	SPI NOR manufacturer
  * @addr_width:		number of address bytes
@@ -379,6 +381,7 @@ struct spi_nor {
 	struct spi_mem		*spimem;
 	u8			*bouncebuf;
 	size_t			bouncebuf_size;
+	u8			*id;
 	const struct flash_info	*info;
 	const struct spi_nor_manufacturer *manufacturer;
 	u8			addr_width;
-- 
2.30.2


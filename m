Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5D458F428
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 00:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233480AbiHJWHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 18:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233200AbiHJWHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 18:07:13 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E59683F3C
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 15:07:11 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 1A7382224E;
        Thu, 11 Aug 2022 00:07:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1660169229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uos5wFE9l5TNcF0CpsE0RvCrDFSCsDt4ePVcmJm7B3E=;
        b=Dz3MjLS96nYUJuqYuqS7+zXmH56Xj4kQDQ0EwTvCN9keEqeC+kovPxNAxACJIkQQm/A3pq
        0v+r5qV3ZBO12M5xgH5uiweOWAz8SnQ+XtCoNywLAxgU5pYto0IgCz2P8TV/tjjq7ofwFI
        /z9lj2FtLYjmk7vfextXcoksqKdVnXI=
From:   Michael Walle <michael@walle.cc>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Michael Walle <michael@walle.cc>,
        Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [PATCH v2 3/7] mtd: spi-nor: remember full JEDEC flash ID
Date:   Thu, 11 Aug 2022 00:06:50 +0200
Message-Id: <20220810220654.1297699-4-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220810220654.1297699-1-michael@walle.cc>
References: <20220810220654.1297699-1-michael@walle.cc>
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
Reviewed-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
---
 drivers/mtd/spi-nor/core.c    | 5 +++++
 drivers/mtd/spi-nor/debugfs.c | 2 +-
 include/linux/mtd/spi-nor.h   | 3 +++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index f2c64006f8d7..f1d01c7dacce 100644
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
index df76cb5de3f9..ff895f6758ea 100644
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
index 42218a1164f6..25765556223a 100644
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
  * @addr_nbytes:	number of address bytes
@@ -379,6 +381,7 @@ struct spi_nor {
 	struct spi_mem		*spimem;
 	u8			*bouncebuf;
 	size_t			bouncebuf_size;
+	u8			*id;
 	const struct flash_info	*info;
 	const struct spi_nor_manufacturer *manufacturer;
 	u8			addr_nbytes;
-- 
2.30.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 193FE5755C0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 21:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239941AbiGNTUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 15:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232237AbiGNTT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 15:19:59 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2970C2C647;
        Thu, 14 Jul 2022 12:19:58 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C4D9234D34;
        Thu, 14 Jul 2022 19:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1657826396; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=J1TVAvphNmTpAWW61VUw6mw/9ks964p5lRoXg8fT5pQ=;
        b=yaCt/W2pKkPFnDaETQRiTHkJCEF9k9sdkjq5JwaHQnawjSKoiYi4DI8vi/+Uw5d+Sul19z
        37o2WGZVI43rBZhYukzagHSaK4SmQbA7jQM9qetajPGOmDZ520FSpw9IloUNbGKlSSf9kP
        bRh46ZyDYQTdv+Zp8n1jh86KwnMJjmE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1657826396;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=J1TVAvphNmTpAWW61VUw6mw/9ks964p5lRoXg8fT5pQ=;
        b=wngWGUvhjqDObMv9OkYHJzzRhkbc88uRRchYKwwT861i6KWlF4AscZVrctIi5rsYr2VauG
        Qs7ENmMlzAFzaQBw==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        by relay2.suse.de (Postfix) with ESMTP id 80F252C141;
        Thu, 14 Jul 2022 19:19:55 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     linux-sunxi@lists.linux.dev
Cc:     Michal Suchanek <msuchanek@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: [PATCH 1/2] mtd: spi-nor: When a flash memory is missing do not report an error
Date:   Thu, 14 Jul 2022 21:19:47 +0200
Message-Id: <701967b0c418db333c66b48d225df60aa9d03ead.1657826188.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.35.3
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

It is normal that devices are designed with multiple types of storage,
and only some types of storage are present.

The kernel can handle this situation gracefully for many types of
storage devices such as mmc or ata but it reports and error when spi
flash is not present.

Only print a notice that the storage device is missing when no response
to the identify command is received.

Consider reply buffers with all bits set to the same value no response.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 drivers/mtd/spi-nor/core.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 502967c76c5f..6bab540171a4 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -1652,6 +1652,24 @@ static const struct flash_info *spi_nor_match_id(struct spi_nor *nor,
 	return NULL;
 }
 
+static const bool buffer_uniform(const u8 *buffer, size_t length)
+{
+	bool all0;
+	size_t i;
+
+	for (all0 = true, i = 0; i < length; i++)
+		if (buffer[i] != 0) {
+			all0 = false;
+			break;
+		}
+	if (all0)
+		return true;
+	for (i = 0; i < length; i++)
+		if (buffer[i] != 0xff)
+			return false;
+	return true;
+}
+
 static const struct flash_info *spi_nor_detect(struct spi_nor *nor)
 {
 	const struct flash_info *info;
@@ -1666,8 +1684,11 @@ static const struct flash_info *spi_nor_detect(struct spi_nor *nor)
 
 	info = spi_nor_match_id(nor, id);
 	if (!info) {
-		dev_err(nor->dev, "unrecognized JEDEC id bytes: %*ph\n",
-			SPI_NOR_MAX_ID_LEN, id);
+		if (buffer_uniform(id, SPI_NOR_MAX_ID_LEN))
+			dev_info(nor->dev, "No flash memory detected.\n");
+		else
+			dev_err(nor->dev, "unrecognized JEDEC id bytes: %*ph\n",
+				SPI_NOR_MAX_ID_LEN, id);
 		return ERR_PTR(-ENODEV);
 	}
 	return info;
-- 
2.35.3


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87C2C4950A6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 15:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356646AbiATO5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 09:57:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232592AbiATO5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 09:57:24 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D3CC061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 06:57:24 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id BD504223ED;
        Thu, 20 Jan 2022 15:57:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1642690642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=KAK/CCTkkR4GNYWL05YGfvNU4qKumSuEfF/D9f/mP8g=;
        b=Er84q2/JwFi4hKoWf+lXNJQdDGmiNYw0QuFNNMeiOsGtdGTFtuiQA+O0eXCm/IwZI/W3Gk
        BH1AP06XJzFoPZv0Q6H9/4ArrcZeBZkui5k3HeV29ezZquat80GKFEoOVkVovWa4QB+pI/
        0kdmALz8j70b50C2Okm2qRe21dbCrFs=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH] mtd: spi-nor: winbond: fix the name of W25Q16JV-IM/-JM
Date:   Thu, 20 Jan 2022 15:57:17 +0100
Message-Id: <20220120145717.3027624-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't include the package encoding in the name. Thus, just use
w25q15jvm as the name for this flash.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/mtd/spi-nor/winbond.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
index 93b537f4f0cb..3d91888882e4 100644
--- a/drivers/mtd/spi-nor/winbond.c
+++ b/drivers/mtd/spi-nor/winbond.c
@@ -52,7 +52,7 @@ static const struct flash_info winbond_parts[] = {
 			      SPI_NOR_QUAD_READ) },
 	{ "w25x32", INFO(0xef3016, 0, 64 * 1024,  64)
 		NO_SFDP_FLAGS(SECT_4K) },
-	{ "w25q16jv-im/jm", INFO(0xef7015, 0, 64 * 1024,  32)
+	{ "w25q16jvm", INFO(0xef7015, 0, 64 * 1024,  32)
 		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
 			      SPI_NOR_QUAD_READ) },
-- 
2.30.2


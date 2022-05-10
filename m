Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 976E3521CB0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 16:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344448AbiEJOps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 10:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242769AbiEJOof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 10:44:35 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA24F1B12D3
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 07:02:40 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 12D552224D;
        Tue, 10 May 2022 16:02:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1652191358;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sNpsQrS7bRHbkVhDDh7veJc42zC8dW1iNbM2RveywWU=;
        b=vjM2lIFstx/0lCKopKyQAx10ui00/X/78QfkIkAKIb1weg+It1Ublv4YwmPQ1dGgteRJAr
        FxUR4WJ8unAZRa2tDF1ogwYRHLRG9z/MhrDBYpFTEwxH2rUUQSohB7mJQBAbBXn8Eker9h
        bwcGHYueM0byx/2oUnYvn/E4yL8L1ig=
From:   Michael Walle <michael@walle.cc>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Michael Walle <michael@walle.cc>
Subject: [PATCH 1/2] mtd: spi-nor: introduce SNOR_ID3()
Date:   Tue, 10 May 2022 16:02:31 +0200
Message-Id: <20220510140232.3519184-2-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220510140232.3519184-1-michael@walle.cc>
References: <20220510140232.3519184-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Up until now, flashes were defined by specifying the JEDEC ID, the
sector size and the number of sectors. This can be read by parsing the
SFDP, we don't have to specify it. Thus provide a new macro SNOR_ID3()
which just takes the JEDEC ID and implicitly set .parse_sfdp = true. All
new flashes which have SFDP should use this macro.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/mtd/spi-nor/core.c | 7 +++++--
 drivers/mtd/spi-nor/core.h | 9 +++++++++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 402b37cdbcea..29329ed0a934 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2104,8 +2104,11 @@ static int spi_nor_select_pp(struct spi_nor *nor,
  * spi_nor_select_uniform_erase() - select optimum uniform erase type
  * @map:		the erase map of the SPI NOR
  * @wanted_size:	the erase type size to search for. Contains the value of
- *			info->sector_size or of the "small sector" size in case
- *			CONFIG_MTD_SPI_NOR_USE_4K_SECTORS is defined.
+ *			info->sector_size, the "small sector" size in case
+ *			CONFIG_MTD_SPI_NOR_USE_4K_SECTORS is defined or 0 if
+ *			there is no information about the sector size. The
+ *			latter is the case if the flash parameters are parsed
+ *			solely by SFDP.
  *
  * Once the optimum uniform sector erase command is found, disable all the
  * other.
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 61886868cd02..fab3038c4f4a 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -563,6 +563,15 @@ struct flash_info {
 			.n_regions = (_n_regions),			\
 		},
 
+#define SNOR_ID3(_jedec_id)						\
+		.id = {							\
+			((_jedec_id) >> 16) & 0xff,			\
+			((_jedec_id) >> 8) & 0xff,			\
+			(_jedec_id) & 0xff,				\
+			},						\
+		.id_len = 3,						\
+		.parse_sfdp = true,					\
+
 #define PARSE_SFDP							\
 	.parse_sfdp = true,						\
 
-- 
2.30.2


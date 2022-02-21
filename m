Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 008C44BE88B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346117AbiBUIzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 03:55:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345763AbiBUIxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 03:53:51 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E592F2181E
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 00:52:59 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 1F82F223E9;
        Mon, 21 Feb 2022 09:52:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1645433578;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F1qkSskWvLmQEwC2wGrqzOG2oXtmYsBZ+OhFkXYPiXE=;
        b=hHPFfZ0EOSAkywDyaOJS6rgoFPXHhnmboaTJY6aTw1sx6m7zN2amzzh9djSoJ87wsr+j1a
        OaiU5IGHCdBCWcnlJqY42gatbUg6YG4Uij1D09w2f4ywfOv8QG94ExJTs/RNo4QRNjql2K
        aPSd8uH+ywIRIjWePrTOOsNNOgIsQ9E=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        yaliang.wang@windriver.com, Michael Walle <michael@walle.cc>
Subject: [PATCH v3 20/32] mtd: spi-nor: guard _page_size parameter in S3AN_INFO()
Date:   Mon, 21 Feb 2022 09:52:24 +0100
Message-Id: <20220221085236.1452024-21-michael@walle.cc>
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

The _page_size marco parameter was missing parentheses around it. Add
them.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/mtd/spi-nor/core.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 446218b0e017..3c37b46d60d5 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -469,9 +469,9 @@ struct flash_info {
 			(_jedec_id) & 0xff				\
 			},						\
 		.id_len = 3,						\
-		.sector_size = (8*_page_size),				\
+		.sector_size = (8 * (_page_size)),			\
 		.n_sectors = (_n_sectors),				\
-		.page_size = _page_size,				\
+		.page_size = (_page_size),				\
 		.addr_width = 3,					\
 		.flags = SPI_NOR_NO_FR | SPI_NOR_XSR_RDY,
 
-- 
2.30.2


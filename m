Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 399474BDDB2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345871AbiBUIyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 03:54:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345629AbiBUIxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 03:53:19 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167B6193E7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 00:52:51 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id ED9EB223F0;
        Mon, 21 Feb 2022 09:52:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1645433569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hmo81Sb3vYtqKwqBd4CJg7BRHgMci0G5Rym0Baoee0U=;
        b=Cj4+KySZw3sulmGqPSfPjhZ0OLoSBRtGuq7rUQmGN65ntKdWtFCmARaS6GEtfSgjuF81kq
        wSRhf60y5iR0QpTi1+wINTCdsb8n7RGiZ2yRIrMp+rTj/CRBqyrqwVpQG4FVrga95n9Kdb
        ZIPw+WBYfZ9u5yy+XE1zEmKFpP+PlMo=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        yaliang.wang@windriver.com, Michael Walle <michael@walle.cc>
Subject: [PATCH v3 04/32] mtd: spi-nor: esmt: unify function names
Date:   Mon, 21 Feb 2022 09:52:08 +0100
Message-Id: <20220221085236.1452024-5-michael@walle.cc>
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
 drivers/mtd/spi-nor/esmt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/spi-nor/esmt.c b/drivers/mtd/spi-nor/esmt.c
index ace1da221566..79e2408f4998 100644
--- a/drivers/mtd/spi-nor/esmt.c
+++ b/drivers/mtd/spi-nor/esmt.c
@@ -8,7 +8,7 @@
 
 #include "core.h"
 
-static const struct flash_info esmt_parts[] = {
+static const struct flash_info esmt_nor_parts[] = {
 	/* ESMT */
 	{ "f25l32pa", INFO(0x8c2016, 0, 64 * 1024, 64)
 		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE)
@@ -23,6 +23,6 @@ static const struct flash_info esmt_parts[] = {
 
 const struct spi_nor_manufacturer spi_nor_esmt = {
 	.name = "esmt",
-	.parts = esmt_parts,
-	.nparts = ARRAY_SIZE(esmt_parts),
+	.parts = esmt_nor_parts,
+	.nparts = ARRAY_SIZE(esmt_nor_parts),
 };
-- 
2.30.2


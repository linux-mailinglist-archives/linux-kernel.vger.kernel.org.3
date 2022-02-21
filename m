Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C65AA4BE00A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345656AbiBUIyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 03:54:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345666AbiBUIxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 03:53:19 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E63F192BF
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 00:52:50 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 5A158223EF;
        Mon, 21 Feb 2022 09:52:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1645433568;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VH1+ZLr+3aCUvAokLgGLfn7yiFo+DMUkRJCzELQD4KI=;
        b=lVepYD2hN6+0fXlu1bOQtYz8k+hho0ZV/dG71P+3iKg13cx7ISawHj2qB+CRyqL4L4l368
        XELQWyGgpv9W/7uHR+DPDU1do33ioKxChBw87T8TQo1AOW5nK68cMUgHgLYS0QddbNWpU2
        nHSUUNF4pWnFnRY8JRsKediKUqpMmRM=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        yaliang.wang@windriver.com, Michael Walle <michael@walle.cc>
Subject: [PATCH v3 03/32] mtd: spi-nor: eon: unify function names
Date:   Mon, 21 Feb 2022 09:52:07 +0100
Message-Id: <20220221085236.1452024-4-michael@walle.cc>
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
 drivers/mtd/spi-nor/eon.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/spi-nor/eon.c b/drivers/mtd/spi-nor/eon.c
index 4f3ee6331f37..8c1c57530281 100644
--- a/drivers/mtd/spi-nor/eon.c
+++ b/drivers/mtd/spi-nor/eon.c
@@ -8,7 +8,7 @@
 
 #include "core.h"
 
-static const struct flash_info eon_parts[] = {
+static const struct flash_info eon_nor_parts[] = {
 	/* EON -- en25xxx */
 	{ "en25f32",    INFO(0x1c3116, 0, 64 * 1024,   64)
 		NO_SFDP_FLAGS(SECT_4K) },
@@ -32,6 +32,6 @@ static const struct flash_info eon_parts[] = {
 
 const struct spi_nor_manufacturer spi_nor_eon = {
 	.name = "eon",
-	.parts = eon_parts,
-	.nparts = ARRAY_SIZE(eon_parts),
+	.parts = eon_nor_parts,
+	.nparts = ARRAY_SIZE(eon_nor_parts),
 };
-- 
2.30.2


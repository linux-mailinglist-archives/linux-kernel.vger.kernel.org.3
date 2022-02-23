Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1684C147D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 14:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241057AbiBWNop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 08:44:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236640AbiBWNoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 08:44:34 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3897EAC078
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 05:44:07 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 31862223ED;
        Wed, 23 Feb 2022 14:44:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1645623845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6KySmYB6O5LVk/V3X9X0DNWVLALSZlfHUWvYbZ+/N7A=;
        b=HRQgNsUQjs9wRioxW1AcZuNZ9MT6OWzyAWcgSNqzow14P0pccrHZKCS6XIlgLp6Dxbpafp
        4qZS6mQUAM9K+g9iaSnP6msLV0HruykWfNLHlKSLgXkW486vHnvTHvcoHDd+Q3FmpiKsTa
        JGUOLxcSaNzqgWOyOE8Xin29xK6S74A=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        yaliang.wang@windriver.com, Michael Walle <michael@walle.cc>
Subject: [PATCH v5 02/32] mtd: spi-nor: catalyst: unify function names
Date:   Wed, 23 Feb 2022 14:43:28 +0100
Message-Id: <20220223134358.1914798-3-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220223134358.1914798-1-michael@walle.cc>
References: <20220223134358.1914798-1-michael@walle.cc>
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
Acked-by: Pratyush Yadav <p.yadav@ti.com>
---
 drivers/mtd/spi-nor/catalyst.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/spi-nor/catalyst.c b/drivers/mtd/spi-nor/catalyst.c
index ae4d67e01bb3..6d310815fb12 100644
--- a/drivers/mtd/spi-nor/catalyst.c
+++ b/drivers/mtd/spi-nor/catalyst.c
@@ -8,7 +8,7 @@
 
 #include "core.h"
 
-static const struct flash_info catalyst_parts[] = {
+static const struct flash_info catalyst_nor_parts[] = {
 	/* Catalyst / On Semiconductor -- non-JEDEC */
 	{ "cat25c11", CAT25_INFO(16, 8, 16, 1) },
 	{ "cat25c03", CAT25_INFO(32, 8, 16, 2) },
@@ -19,6 +19,6 @@ static const struct flash_info catalyst_parts[] = {
 
 const struct spi_nor_manufacturer spi_nor_catalyst = {
 	.name = "catalyst",
-	.parts = catalyst_parts,
-	.nparts = ARRAY_SIZE(catalyst_parts),
+	.parts = catalyst_nor_parts,
+	.nparts = ARRAY_SIZE(catalyst_nor_parts),
 };
-- 
2.30.2


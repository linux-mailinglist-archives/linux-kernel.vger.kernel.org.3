Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794EF4BB832
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 12:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234638AbiBRLgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 06:36:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234559AbiBRLgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 06:36:37 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25802B0B38
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 03:36:16 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 096EC223F0;
        Fri, 18 Feb 2022 12:36:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1645184175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UD6+0Z6yibRsOdt8zn1BhQmKZUwO1fab/PtnzMpVPlk=;
        b=qlEhJUbrs65qllmKyx6mDETOJaPX+DBHXUK++Ig6cSbTKlWgbs3J4QhYou+sPHMdijHgWN
        syNvrjECpgE7frCMOR45mCrOFnYf/WqUTzjKhJMquzgFKAXhfw/Cgd2SKg9v432Qm/NWyu
        bsTBiQsawtEa3xp59T/URB4XjA0dkDg=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        yaliang.wang@windriver.com, Michael Walle <michael@walle.cc>
Subject: [PATCH v2 02/32] mtd: spi-nor: catalyst: unify function names
Date:   Fri, 18 Feb 2022 12:35:37 +0100
Message-Id: <20220218113607.1360020-3-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220218113607.1360020-1-michael@walle.cc>
References: <20220218113607.1360020-1-michael@walle.cc>
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
 - <flash_family>_
 - <flash_part>_

There are no functional changes.

Signed-off-by: Michael Walle <michael@walle.cc>
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


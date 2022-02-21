Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65AA54BE439
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236628AbiBUI4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 03:56:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345885AbiBUIyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 03:54:06 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD7822BD4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 00:53:01 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 902DA22450;
        Mon, 21 Feb 2022 09:52:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1645433579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+etW7jzC7OWPI2fMPjfRTOpJ5DdDj/wXEqI0+Wud4xs=;
        b=kKyyeJQF2J/aZZqPZqqVMIO0Gph8odo4hir+1jPjYi2gQKZsrJkHRwWoQj8a6v6Oj4ANeU
        ostalxierQIOiwkatAE6kJlH8cnx1jfdWy7R957SX2Ii/fylziKLDGpcMr62uwhvxE2K0d
        bS5PEuXdGZRy3WXzRmwQZrvHL2uX3FM=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        yaliang.wang@windriver.com, Michael Walle <michael@walle.cc>
Subject: [PATCH v3 23/32] mtd: spi-nor: xilinx: correct the debug message
Date:   Mon, 21 Feb 2022 09:52:27 +0100
Message-Id: <20220221085236.1452024-24-michael@walle.cc>
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

XRDSR is a combination of xilinx and the RDSR opcode, but the register
is just the status register. Correct the debug message.

Signed-off-by: Michael Walle <michael@walle.cc>
Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Reviewed-by: Pratyush Yadav <p.yadav@ti.com>
---
 drivers/mtd/spi-nor/xilinx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/xilinx.c b/drivers/mtd/spi-nor/xilinx.c
index ffd5579d45cb..9459ac2609dc 100644
--- a/drivers/mtd/spi-nor/xilinx.c
+++ b/drivers/mtd/spi-nor/xilinx.c
@@ -87,7 +87,7 @@ static int xilinx_nor_read_sr(struct spi_nor *nor, u8 *sr)
 	}
 
 	if (ret)
-		dev_dbg(nor->dev, "error %d reading XRDSR\n", ret);
+		dev_dbg(nor->dev, "error %d reading SR\n", ret);
 
 	return ret;
 }
-- 
2.30.2


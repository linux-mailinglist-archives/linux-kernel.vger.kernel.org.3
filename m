Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 481B54C1495
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 14:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234824AbiBWNqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 08:46:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241099AbiBWNox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 08:44:53 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B901AD115
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 05:44:19 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 7957E22481;
        Wed, 23 Feb 2022 14:44:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1645623857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=acuMMmcA9VmQZOASvU5gU9zXugIenhc8Io0FNHjds/g=;
        b=paHkoDs/LU+X1CypVRs/Xr2CBe9Nchjuoqk/jB4dgSJ2oQTpEGFVeN82iQ/prsK2Ye7bdR
        IewnijdV27Tlu7/0fSYTcjxdRFsOB1x0YUIidGJlu7k3mcdYrTWH3yhrOclmPZ0TLJ9Oaw
        vLitYBad6NqYWRfIo6QqzwPFBJXNlaI=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        yaliang.wang@windriver.com, Michael Walle <michael@walle.cc>
Subject: [PATCH v5 31/32] mtd: spi-nor: slightly change code style in spi_nor_sr_ready()
Date:   Wed, 23 Feb 2022 14:43:57 +0100
Message-Id: <20220223134358.1914798-32-michael@walle.cc>
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

Now that there is almost no special case code left in
spi_nor_sr_ready(), the return check looks odd. Move the function call
closer to the return code checking.

Signed-off-by: Michael Walle <michael@walle.cc>
Reviewed-by: Pratyush Yadav <p.yadav@ti.com>
---
 drivers/mtd/spi-nor/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index f5a2f37d140e..9014008e60b3 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -563,8 +563,9 @@ int spi_nor_write_ear(struct spi_nor *nor, u8 ear)
  */
 int spi_nor_sr_ready(struct spi_nor *nor)
 {
-	int ret = spi_nor_read_sr(nor, nor->bouncebuf);
+	int ret;
 
+	ret = spi_nor_read_sr(nor, nor->bouncebuf);
 	if (ret)
 		return ret;
 
-- 
2.30.2


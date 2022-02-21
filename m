Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24D554BE829
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357557AbiBUMMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 07:12:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357335AbiBUMIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 07:08:55 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400A9201AB
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 04:08:32 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 5A9A8223F6;
        Mon, 21 Feb 2022 13:08:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1645445310;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3zsnrIhLoM0lShucyLsd9YgNoCMcFbg27IxCcc/idRc=;
        b=Hefqen4x6zIfPjTbqB3a1XsbApVYtZBxP9QmWGdmeOVg/jFjcS0StKeTVjclXhmJt6vyuT
        CV1/vvymuRNEVWQbiOvNARdlyGzIr8wJkKgi5xFdt9D5P8cUVTqDk9XgKFf/nO/Y7t92Fw
        LvVMvMUCP6ie21+sWcRditPsTl9o+Y4=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        yaliang.wang@windriver.com, Michael Walle <michael@walle.cc>
Subject: [PATCH v4 27/32] mtd: spi-nor: spansion: slightly rework control flow in late_init()
Date:   Mon, 21 Feb 2022 13:08:04 +0100
Message-Id: <20220221120809.1531502-28-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220221120809.1531502-1-michael@walle.cc>
References: <20220221120809.1531502-1-michael@walle.cc>
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

Don't return early when the flash is smaller than or equal to 16MiB. We
need to be able to register hooks for all sizes of flashes. This also has
the benefit that it increases the readability of the code because the
action, i.e. registering the fixups, is connected to the condition, i.e.
flashes larger than 16MiB.

Signed-off-by: Michael Walle <michael@walle.cc>
Reviewed-by: Pratyush Yadav <p.yadav@ti.com>
---
 drivers/mtd/spi-nor/spansion.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
index 5affa8ae43a7..1a0e7214d9e5 100644
--- a/drivers/mtd/spi-nor/spansion.c
+++ b/drivers/mtd/spi-nor/spansion.c
@@ -296,13 +296,12 @@ static const struct flash_info spansion_nor_parts[] = {
 
 static void spansion_nor_late_init(struct spi_nor *nor)
 {
-	if (nor->params->size <= SZ_16M)
-		return;
-
-	nor->flags |= SNOR_F_4B_OPCODES;
-	/* No small sector erase for 4-byte command set */
-	nor->erase_opcode = SPINOR_OP_SE;
-	nor->mtd.erasesize = nor->info->sector_size;
+	if (nor->params->size > SZ_16M) {
+		nor->flags |= SNOR_F_4B_OPCODES;
+		/* No small sector erase for 4-byte command set */
+		nor->erase_opcode = SPINOR_OP_SE;
+		nor->mtd.erasesize = nor->info->sector_size;
+	}
 }
 
 static const struct spi_nor_fixups spansion_nor_fixups = {
-- 
2.30.2


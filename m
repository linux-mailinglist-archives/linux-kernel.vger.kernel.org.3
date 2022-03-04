Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3034CDCF7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 19:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241845AbiCDSwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 13:52:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236781AbiCDSwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 13:52:39 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA491C1ECC
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 10:51:51 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 1D1E722175;
        Fri,  4 Mar 2022 19:51:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1646419909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=U/LuT+rONVQX6VgKjgRIoVDXdEdfsqzHnymPhpyq4D4=;
        b=p0ydG4ZHJrTNCFyMchvneiY8zMwWkmVxx/Crv8uDPltk8wA868yjn3+C+ogMxsPWIqyZlX
        3WGQ5xnDiiHt6H6+nYQVbXNm6V6n/J9FEb8/fnnusNo32FOXZdXZF8SH/aWKi4MJLQeFi3
        oou8fMQmz8o7w/t8FNtIYMTAGlzP2sc=
From:   Michael Walle <michael@walle.cc>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        heiko.thiery@gmail.com, Michael Walle <michael@walle.cc>
Subject: [PATCH v1] mtd: spi-nor: unset quad_enable if SFDP doesn't specify it
Date:   Fri,  4 Mar 2022 19:51:37 +0100
Message-Id: <20220304185137.3376011-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
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

While the first version of JESD216 specify the opcode for 4 bit I/O
accesses, it lacks information on how to actually enable this mode.

For now, the one set in spi_nor_init_default_params() will be used.
But this one is likely wrong for some flashes, in particular the
Macronix MX25L12835F. Thus we need to clear the enable method when
parsing the SFDP. Flashes with such an SFDP revision will have to use a
flash (and SFDP revision) specific fixup.

This might break quad I/O for some flashes which relied on the
spi_nor_sr2_bit1_quad_enable() that was formerly set. If your bisect
turns up this commit, you'll probably have to set the proper
quad_enable method in a post_bfpt() fixup for your flash.

Signed-off-by: Michael Walle <michael@walle.cc>
Tested-by: Heiko Thiery <heiko.thiery@gmail.com>
---
changes since RFC:
 - reworded commit message
 - added comment about post_bfpt hook

Tudor, I'm not sure what you meant with
  Maybe you can update the commit message and explain why would some
  flashes fail to enable quad mode, similar to what I did.

It doesn't work because the wrong method is chosen? ;)

 drivers/mtd/spi-nor/sfdp.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
index a5211543d30d..6bba9b601846 100644
--- a/drivers/mtd/spi-nor/sfdp.c
+++ b/drivers/mtd/spi-nor/sfdp.c
@@ -549,6 +549,16 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
 	map->uniform_erase_type = map->uniform_region.offset &
 				  SNOR_ERASE_TYPE_MASK;
 
+	/*
+	 * The first JESD216 revision doesn't specify a method to enable
+	 * quad mode. spi_nor_init_default_params() will set a legacy
+	 * default method to enable quad mode. We have to disable it
+	 * again.
+	 * Flashes with this JESD216 revision need to set the quad_enable
+	 * method in their post_bfpt() fixup if they want to use quad I/O.
+	 */
+	params->quad_enable = NULL;
+
 	/* Stop here if not JESD216 rev A or later. */
 	if (bfpt_header->length == BFPT_DWORD_MAX_JESD216)
 		return spi_nor_post_bfpt_fixups(nor, bfpt_header, &bfpt);
@@ -562,7 +572,6 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
 	/* Quad Enable Requirements. */
 	switch (bfpt.dwords[BFPT_DWORD(15)] & BFPT_DWORD15_QER_MASK) {
 	case BFPT_DWORD15_QER_NONE:
-		params->quad_enable = NULL;
 		break;
 
 	case BFPT_DWORD15_QER_SR2_BIT1_BUGGY:
-- 
2.30.2


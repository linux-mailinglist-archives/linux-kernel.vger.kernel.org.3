Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2324C8BFA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 13:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234844AbiCAMuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 07:50:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232414AbiCAMud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 07:50:33 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B60D90CD2
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 04:49:50 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 0A72022239;
        Tue,  1 Mar 2022 13:49:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1646138988;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=xGLD83FZXcedIiF55wiRZhjCh00S3oJ3SNfvYTSltI8=;
        b=QWngFlGmTYR4NOLSGfz7X7tFe78tSLLQUp46Et2Wxvp2TdMumWIZbR7dh7U0gyF/m9V9Wv
        OcwWm8MxqpGNVsRXoqBTChpZzzic0bX2tp9b86/CaEq/pHei2VJQlkPF5ItoHLc1DJHGDa
        8twyCVLr7p7/DiSGO2xyB1oLOvb6y5I=
From:   Michael Walle <michael@walle.cc>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        heiko.thiery@gmail.com, Michael Walle <michael@walle.cc>
Subject: [PATCH RFC] mtd: spi-nor: unset quad_enable if SFDP doesn't specify it
Date:   Tue,  1 Mar 2022 13:49:35 +0100
Message-Id: <20220301124935.2893622-1-michael@walle.cc>
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

For flashes which use the first JESD216 revision, we don't know
which enable method for quad mode we can use. The default one in
spi_nor_init_default_params() is wrong for at least the Macronix
MX25L12835F, thus clear the enable method. Flashes with such an
SFDP revision will have to use a flash (and SFDP revision)
specific fixup.

Signed-off-by: Michael Walle <michael@walle.cc>
---
Please note, completely, untested. Heiko, could you test this without
having the second series from Tudor applied? Then you should have at
least a working flash without quad mode.

 drivers/mtd/spi-nor/sfdp.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
index a5211543d30d..c23e85274ff2 100644
--- a/drivers/mtd/spi-nor/sfdp.c
+++ b/drivers/mtd/spi-nor/sfdp.c
@@ -549,6 +549,14 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
 	map->uniform_erase_type = map->uniform_region.offset &
 				  SNOR_ERASE_TYPE_MASK;
 
+	/*
+	 * The first JESD216 revision doesn't specify a method to enable
+	 * quad mode. spi_nor_init_default_params() will set a legacy
+	 * default method to enable quad mode. We have to disable it
+	 * again.
+	 */
+	params->quad_enable = NULL;
+
 	/* Stop here if not JESD216 rev A or later. */
 	if (bfpt_header->length == BFPT_DWORD_MAX_JESD216)
 		return spi_nor_post_bfpt_fixups(nor, bfpt_header, &bfpt);
@@ -562,7 +570,6 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
 	/* Quad Enable Requirements. */
 	switch (bfpt.dwords[BFPT_DWORD(15)] & BFPT_DWORD15_QER_MASK) {
 	case BFPT_DWORD15_QER_NONE:
-		params->quad_enable = NULL;
 		break;
 
 	case BFPT_DWORD15_QER_SR2_BIT1_BUGGY:
-- 
2.30.2


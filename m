Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E72521CA9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 16:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243865AbiEJOpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 10:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344328AbiEJOof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 10:44:35 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9ADA1A9AD3
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 07:02:40 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id A508A2224E;
        Tue, 10 May 2022 16:02:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1652191358;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9UxwEeiTcfaMCwqN6AHf331eQEYKir5m9q3Wiknlh7g=;
        b=DLK/b1X0WBV/9/SUW5c51jrTJcl+roD5zc7RhR80MPB3F43Gu3risbFBai/wRH9Wwzi45Q
        i66GtB2SzbVxbB0lIzNLMaL6GoCr6IfcaKV4SgaaV/R3/y1mD+KLFAiz9F31o3vWWU30w4
        cuHW2bffJ8Zb1QjTQXPLsJaAI80P8Lc=
From:   Michael Walle <michael@walle.cc>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Michael Walle <michael@walle.cc>
Subject: [PATCH 2/2] mtd: spi-nor: winbond: use SNOR_ID3() for w25q512nwm
Date:   Tue, 10 May 2022 16:02:32 +0200
Message-Id: <20220510140232.3519184-3-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220510140232.3519184-1-michael@walle.cc>
References: <20220510140232.3519184-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new SNOR_ID3() so we don't have to specify the number of sectors
as we are reading that property from the SFDP anyways.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/mtd/spi-nor/winbond.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
index 08f9b5abf4d2..12b38f6776f4 100644
--- a/drivers/mtd/spi-nor/winbond.c
+++ b/drivers/mtd/spi-nor/winbond.c
@@ -134,8 +134,7 @@ static const struct flash_info winbond_nor_parts[] = {
 	{ "w25m512jv", INFO(0xef7119, 0, 64 * 1024, 1024)
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_QUAD_READ |
 			      SPI_NOR_DUAL_READ) },
-	{ "w25q512nwm", INFO(0xef8020, 0, 64 * 1024, 1024)
-		PARSE_SFDP
+	{ "w25q512nwm", SNOR_ID3(0xef8020)
 		OTP_INFO(256, 3, 0x1000, 0x1000) },
 	{ "w25q512jvq", INFO(0xef4020, 0, 64 * 1024, 1024)
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
-- 
2.30.2


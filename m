Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 414D35133B3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 14:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346269AbiD1McH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 08:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346251AbiD1McE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 08:32:04 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C88AF1D3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 05:28:50 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 23F8322238;
        Thu, 28 Apr 2022 14:28:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1651148928;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=fLcOFqNhslXVtpzm0Sz5tnRKagmiAXJdwHt8alYGz5A=;
        b=DMQz895hBHKKokU938aT6iEe6tjwoDZXqOKzBALGmHDVRznaKDqMzlwix1IjzDBs5a4ytP
        fDqbGAjgQFtXFEtroYy/tvr52QiBz3H57/O5KStNrr21oMqNxDDnbGqdr4yEZYw3QaGJHu
        t7ZNPqz7NP4lQhbpyzr9vYeb2JkD6O4=
From:   Michael Walle <michael@walle.cc>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v2 1/2] mtd: spi-nor: export spi_nor_hwcaps_pp2cmd()
Date:   Thu, 28 Apr 2022 14:28:39 +0200
Message-Id: <20220428122840.1496876-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function will also be used by the debugfs module.

Signed-off-by: Michael Walle <michael@walle.cc>
---
changes since rfc (v1):
 - none

 drivers/mtd/spi-nor/core.c | 2 +-
 drivers/mtd/spi-nor/core.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index d2b624b2c4cd..dd2ead5ebe9f 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -1880,7 +1880,7 @@ int spi_nor_hwcaps_read2cmd(u32 hwcaps)
 				  ARRAY_SIZE(hwcaps_read2cmd));
 }
 
-static int spi_nor_hwcaps_pp2cmd(u32 hwcaps)
+int spi_nor_hwcaps_pp2cmd(u32 hwcaps)
 {
 	static const int hwcaps_pp2cmd[][2] = {
 		{ SNOR_HWCAPS_PP,		SNOR_CMD_PP },
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index d677a2053903..74fc32067a32 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -669,6 +669,7 @@ int spi_nor_otp_lock_sr2(struct spi_nor *nor, unsigned int region);
 int spi_nor_otp_is_locked_sr2(struct spi_nor *nor, unsigned int region);
 
 int spi_nor_hwcaps_read2cmd(u32 hwcaps);
+int spi_nor_hwcaps_pp2cmd(u32 hwcaps);
 u8 spi_nor_convert_3to4_read(u8 opcode);
 void spi_nor_set_read_settings(struct spi_nor_read_command *read,
 			       u8 num_mode_clocks,
-- 
2.30.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C6551FEBF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 15:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236517AbiEINyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 09:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236507AbiEINyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 09:54:02 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3904266E3D
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 06:50:06 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:8886:2b92:63eb:2922])
        by laurent.telenet-ops.be with bizsmtp
        id Udq42700Z0moLbn01dq4qc; Mon, 09 May 2022 15:50:05 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1no3m0-003XnN-BL; Mon, 09 May 2022 15:50:04 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1no3lz-003NJ8-QS; Mon, 09 May 2022 15:50:03 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chuanhong Guo <gch981213@gmail.com>
Cc:     linux-mtd@lists.infradead.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] mtd: nand: MTD_NAND_ECC_MEDIATEK should depend on ARCH_MEDIATEK
Date:   Mon,  9 May 2022 15:50:02 +0200
Message-Id: <bb9568e825d4bc7506870b03836baa91bcc4b725.1652104136.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MediaTek Hardware ECC Engine is only present on MediaTek MT27xx and
MT76xx SoCs.  The driver for this engine is a dependency for the
MediaTek NAND controller (MTD_NAND_MTK) and the MediaTek SPI NAND Flash
Interface (SPI_MTK_SNFI) drivers, both of which already depend on
ARCH_MEDIATEK.

Hence add a dependency on ARCH_MEDIATEK to the Hardware ECC Engine
driver, too, to prevent asking the user about this driver when
configuring a kernel without MediaTek SoC support.

Fixes: 4fd62f15afa0d0da ("mtd: nand: make mtk_ecc.c a separated module")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/mtd/nand/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index 2f3e02ab72ede6fa..5b0c2c95f10cb8ca 100644
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -56,6 +56,7 @@ config MTD_NAND_ECC_MXIC
 config MTD_NAND_ECC_MEDIATEK
 	tristate "Mediatek hardware ECC engine"
 	depends on HAS_IOMEM
+	depends on ARCH_MEDIATEK || COMPILE_TEST
 	select MTD_NAND_ECC
 	help
 	  This enables support for the hardware ECC engine from Mediatek.
-- 
2.25.1


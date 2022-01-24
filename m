Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEA23497918
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 08:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235771AbiAXHFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 02:05:08 -0500
Received: from [58.34.33.2] ([58.34.33.2]:26524 "EHLO MAIL-SVR"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S229776AbiAXHFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 02:05:06 -0500
X-Greylist: delayed 3724 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 Jan 2022 02:05:05 EST
Received: from ubuntu.localdomain (Unknown [192.168.110.22])
        by MAIL-SVR with ESMTPA
        ; Mon, 24 Jan 2022 14:02:03 +0800
From:   Ley Foon Tan <leyfoon.tan@linux.starfivetech.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>
Cc:     Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ley Foon Tan <lftan.linux@gmail.com>
Subject: [PATCH] mtd: spi-nor: macronix: Add support for mx66u1g45g
Date:   Mon, 24 Jan 2022 14:02:25 +0800
Message-Id: <20220124060225.149007-1-leyfoon.tan@linux.starfivetech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Macronix mx66u1g45g [1] is a 1.8V, 1Gbit (128MB) flash device that
supports x1, x2, or x4 operation.

The mx66u1g45g is the smaller sibling of the mx66u2g45g that is
already supported.

Tested on StarFive Dubhe hardware on FPGA.
Validated by erase and read back, write and read back.

[1] https://www.macronix.com/Lists/Datasheet/Attachments/7877/MX66U1G45G,%201.8V,%201Gb,%20v1.4.pdf

Signed-off-by: Ley Foon Tan <leyfoon.tan@linux.starfivetech.com>
---
 drivers/mtd/spi-nor/macronix.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
index 97dba1ae7fb1..79ee808c5442 100644
--- a/drivers/mtd/spi-nor/macronix.c
+++ b/drivers/mtd/spi-nor/macronix.c
@@ -97,6 +97,9 @@ static const struct flash_info macronix_parts[] = {
 			      SPI_NOR_QUAD_READ) },
 	{ "mx66l1g55g",  INFO(0xc2261b, 0, 64 * 1024, 2048)
 		NO_SFDP_FLAGS(SPI_NOR_QUAD_READ) },
+	{ "mx66u1g45g",  INFO(0xc2253b, 0, 64 * 1024, 2048)
+		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
+		FIXUP_FLAGS(SPI_NOR_4B_OPCODES) },
 	{ "mx66u2g45g",	 INFO(0xc2253c, 0, 64 * 1024, 4096)
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
 		FIXUP_FLAGS(SPI_NOR_4B_OPCODES) },
-- 
2.25.1



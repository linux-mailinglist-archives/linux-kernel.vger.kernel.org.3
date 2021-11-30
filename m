Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51409463BAC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 17:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243640AbhK3Q1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 11:27:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239752AbhK3Q1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 11:27:16 -0500
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115E4C061748
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 08:23:56 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed10:8920:40aa:e125:4a65])
        by michel.telenet-ops.be with bizsmtp
        id QgPo2600v173Tg306gPoqr; Tue, 30 Nov 2021 17:23:54 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1ms5v2-001YvT-9R; Tue, 30 Nov 2021 17:23:48 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1ms5v1-00GlJG-RE; Tue, 30 Nov 2021 17:23:47 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     Michael Walle <michael@walle.cc>, Pratyush Yadav <p.yadav@ti.com>,
        linux-mtd@lists.infradead.org, linux-block@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC -nxt] mtd_blkdevs: Set GENHD_FL_NO_PART
Date:   Tue, 30 Nov 2021 17:23:46 +0100
Message-Id: <c26dfdf9ce56e92d23530a09db386b283e62845d.1638289204.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When DT declares the partitions of an spi-nor device using
"fixed-partitions", the individual mtdblockN partitions are now scanned
for partitition tables, which should not happen.

Fix this by setting the GENHD_FL_NO_PART flag in the MTD block layer
interface.

Fixes: 1ebe2e5f9d68e94c ("block: remove GENHD_FL_EXT_DEVT")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Seen with e.g. arch/arm/boot/dts/r8a7791-koelsch.dts.
I only noticed because I have debug code to measure QSPI performance,
which informed me about 8 x 512 bytes being read from each partition
detected.

RFC as I'm not sure this is correct in all cases.
I did verify that in the absence of "fixed-partitions", the spi-nor
device is not scanned for partitions before and after commit
1ebe2e5f9d68e94c.
---
 drivers/mtd/mtd_blkdevs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
index 113f86df76038575..95c84faa794d22c6 100644
--- a/drivers/mtd/mtd_blkdevs.c
+++ b/drivers/mtd/mtd_blkdevs.c
@@ -345,6 +345,7 @@ int add_mtd_blktrans_dev(struct mtd_blktrans_dev *new)
 	gd->first_minor = (new->devnum) << tr->part_bits;
 	gd->minors = 1 << tr->part_bits;
 	gd->fops = &mtd_block_ops;
+	gd->flags |= GENHD_FL_NO_PART;
 
 	if (tr->part_bits)
 		if (new->devnum < 26)
-- 
2.25.1


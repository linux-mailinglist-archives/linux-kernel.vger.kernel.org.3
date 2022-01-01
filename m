Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6F84826F0
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 08:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbiAAHoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jan 2022 02:44:24 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:41922 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbiAAHoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jan 2022 02:44:21 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2017i6IB103902;
        Sat, 1 Jan 2022 01:44:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1641023046;
        bh=hsTbhvozs1BNRSIPW4iIPsBoLECSYX0lY7ljDAlqnV4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=YLulw8v5l9xMwns6j/wiEZvkRU3GWZjqW6kzr6mUcNbHRmBl5QDivD80ITxpTN+o7
         byFEtmvbItuxQ1Xm40/ay8SMXFFTvpH05MYNjAIObaXUicdzc5amwoPZT1jv/e9wh0
         sDbJiGSHZU+Yv5svSNkdLEBzyVUCBgUDAI9ACk/I=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2017i6kF040630
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 1 Jan 2022 01:44:06 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Sat, 1
 Jan 2022 01:44:06 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Sat, 1 Jan 2022 01:44:06 -0600
Received: from LT5CD112GSQZ.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2017gpwh033162;
        Sat, 1 Jan 2022 01:44:01 -0600
From:   Apurva Nandan <a-nandan@ti.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Apurva Nandan <a-nandan@ti.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Daniel Palmer <daniel@0x0f.com>,
        Alexander Lobakin <alobakin@pm.me>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
CC:     <p.yadav@ti.com>
Subject: [PATCH v3 12/17] mtd: spinand: Add mtd_suspend() to disable Octal DTR mode at suspend
Date:   Sat, 1 Jan 2022 13:12:45 +0530
Message-ID: <20220101074250.14443-13-a-nandan@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220101074250.14443-1-a-nandan@ti.com>
References: <20220101074250.14443-1-a-nandan@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The flash might or might not have gone a power-down during sleep.
Hence, its SPI IO mode is unpredictable for the core at the time of
resume. To ensure proper reinitialization during resume, disable the
Octal DTR SPI IO mode and bring the flash to 1S-1S-1S mode when
performing suspend using mtd_suspend().

Signed-off-by: Apurva Nandan <a-nandan@ti.com>
---
 drivers/mtd/nand/spi/core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 2fd08085db6f..9d1c72634e5a 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1307,6 +1307,16 @@ static void spinand_mtd_resume(struct mtd_info *mtd)
 	spinand_ecc_enable(spinand, false);
 }
 
+static int spinand_mtd_suspend(struct mtd_info *mtd)
+{
+	struct spinand_device *spinand = mtd_to_spinand(mtd);
+
+	if (spinand->ctrl_ops->protocol == SPINAND_8D_8D_8D)
+		return spinand_init_octal_dtr_disable(spinand);
+
+	return 0;
+}
+
 static int spinand_init(struct spinand_device *spinand)
 {
 	struct device *dev = &spinand->spimem->spi->dev;
@@ -1381,6 +1391,7 @@ static int spinand_init(struct spinand_device *spinand)
 	mtd->_erase = spinand_mtd_erase;
 	mtd->_max_bad_blocks = nanddev_mtd_max_bad_blocks;
 	mtd->_resume = spinand_mtd_resume;
+	mtd->_suspend = spinand_mtd_suspend;
 
 	if (nand->ecc.engine) {
 		ret = mtd_ooblayout_count_freebytes(mtd);
-- 
2.25.1


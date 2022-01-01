Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E910C4826F8
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 08:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbiAAHop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jan 2022 02:44:45 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:49364 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232170AbiAAHoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jan 2022 02:44:44 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2017iN9C066473;
        Sat, 1 Jan 2022 01:44:23 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1641023064;
        bh=2W+ZEwsjEYSO5fmf1B2nM8J2QKPmJ+hSGNrBvEL/lZs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=pHDWZqsdgMh1aZWIvPdQAuPltOPp39fsQDbc1PK2uiv7SkSQmBuQ51rW9GCQjqBIw
         pUNBWLJ/bbZp4Jw7XzWujWGN1pPNf0lJj9Evq0rsBWCOWFrPY6BbWRGdyOkc45tkIR
         micv12ireba371ZjduLttFZElAKjFaVk2nbwK9xI=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2017iNCr091059
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 1 Jan 2022 01:44:23 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Sat, 1
 Jan 2022 01:44:23 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Sat, 1 Jan 2022 01:44:23 -0600
Received: from LT5CD112GSQZ.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2017gpwk033162;
        Sat, 1 Jan 2022 01:44:18 -0600
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
Subject: [PATCH v3 15/17] mtd: spianand: winbond: Add change_mode() manufacturer_ops
Date:   Sat, 1 Jan 2022 13:12:48 +0530
Message-ID: <20220101074250.14443-16-a-nandan@ti.com>
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

Add implementation of change_mode() for Winbond's manufacturer_ops,
that executes octal_dtr_enable() and octal_dtr_disable() according
to requested protocol.

Datasheet: https://www.winbond.com/export/sites/winbond/datasheet/W35N01JW_Datasheet_Brief.pdf

Signed-off-by: Apurva Nandan <a-nandan@ti.com>
---
 drivers/mtd/nand/spi/winbond.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
index c7478faf6cee..d8eccb40c80f 100644
--- a/drivers/mtd/nand/spi/winbond.c
+++ b/drivers/mtd/nand/spi/winbond.c
@@ -242,8 +242,33 @@ static int winbond_spinand_octal_dtr_disable(struct spinand_device *spinand)
 	return 0;
 }
 
+static int winbond_change_spi_mode(struct spinand_device *spinand,
+				   const enum spinand_protocol protocol)
+{
+	if (spinand->protocol == protocol)
+		return 0;
+
+	switch (spinand->protocol) {
+	case SPINAND_1S_1S_1S:
+		if (protocol == SPINAND_8D_8D_8D)
+			return winbond_spinand_octal_dtr_enable(spinand);
+		break;
+
+	case SPINAND_8D_8D_8D:
+		if (protocol == SPINAND_1S_1S_1S)
+			return winbond_spinand_octal_dtr_disable(spinand);
+		break;
+
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return -EOPNOTSUPP;
+}
+
 static const struct spinand_manufacturer_ops winbond_spinand_manuf_ops = {
 	.init = winbond_spinand_init,
+	.change_mode = winbond_change_spi_mode,
 };
 
 const struct spinand_manufacturer winbond_spinand_manufacturer = {
-- 
2.25.1


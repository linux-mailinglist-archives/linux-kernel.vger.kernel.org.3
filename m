Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28D554826E4
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 08:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbiAAHnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jan 2022 02:43:55 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:57972 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbiAAHnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jan 2022 02:43:51 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2017hVC3034603;
        Sat, 1 Jan 2022 01:43:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1641023011;
        bh=FKKP0j8nLF7bwIKE0OAadkGS3YKubzzWBFNbHKdj/FY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=vORrHIzKQoGmLfmWD0BKdQZJFeZDIpRN+lP71d1IsuNPEiH66LC8TE0iMUljNv04p
         iEhPRo8DaoAnsvTTAtgfwC2VTIC7P1fAH2a37d62AppwcsJvFPAX9KiKG38uPVtJft
         vE1LADpDRAkQGJuO6/OVNGSWwqZBxi4bLvNUhA6o=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2017hVsE081421
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 1 Jan 2022 01:43:31 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Sat, 1
 Jan 2022 01:43:31 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Sat, 1 Jan 2022 01:43:31 -0600
Received: from LT5CD112GSQZ.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2017gpwb033162;
        Sat, 1 Jan 2022 01:43:26 -0600
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
Subject: [PATCH v3 06/17] mtd: spinand: Define default ctrl_ops in the core
Date:   Sat, 1 Jan 2022 13:12:39 +0530
Message-ID: <20220101074250.14443-7-a-nandan@ti.com>
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

Add default ctrl_ops in the core, which can be used when the op
templates are commonly used ones. Till now, the core had used only
fixed ctrl operations, so the default 'ctrl_ops' is just these ops
macros initialized with default arguments. The default protocol is
1S_1S_1S.

Signed-off-by: Apurva Nandan <a-nandan@ti.com>
---
 drivers/mtd/nand/spi/core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 481516c9db79..4a75eb06bb52 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -904,6 +904,16 @@ static const struct spinand_manufacturer *spinand_manufacturers[] = {
 	&winbond_spinand_manufacturer,
 };
 
+static const struct spinand_ctrl_ops spinand_default_ctrl_ops =
+			SPINAND_CTRL_OPS(SPINAND_1S_1S_1S,
+					 SPINAND_RESET_OP,
+					 SPINAND_GET_FEATURE_OP(0, NULL),
+					 SPINAND_SET_FEATURE_OP(0, NULL),
+					 SPINAND_WR_EN_DIS_OP(true),
+					 SPINAND_BLK_ERASE_OP(0),
+					 SPINAND_PAGE_READ_OP(0),
+					 SPINAND_PROG_EXEC_OP(0));
+
 static int spinand_manufacturer_match(struct spinand_device *spinand,
 				      enum spinand_readid_method rdid_method)
 {
@@ -1156,6 +1166,8 @@ static void spinand_mtd_resume(struct mtd_info *mtd)
 	int ret;
 
 	spinand->protocol = SPINAND_1S_1S_1S;
+	spinand->ctrl_ops = &spinand_default_ctrl_ops;
+
 	ret = spinand_reset_op(spinand);
 	if (ret)
 		return;
@@ -1183,6 +1195,8 @@ static int spinand_init(struct spinand_device *spinand)
 		return -ENOMEM;
 
 	spinand->protocol = SPINAND_1S_1S_1S;
+	spinand->ctrl_ops = &spinand_default_ctrl_ops;
+
 	ret = spinand_detect(spinand);
 	if (ret)
 		goto err_free_bufs;
-- 
2.25.1


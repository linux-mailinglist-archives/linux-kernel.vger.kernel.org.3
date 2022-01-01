Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0389F4826EA
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 08:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbiAAHoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jan 2022 02:44:10 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:41884 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbiAAHoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jan 2022 02:44:07 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2017hmuc103853;
        Sat, 1 Jan 2022 01:43:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1641023028;
        bh=WTH3svtm8n6MIEwZAu3h7/fylQLPQKhJoycJnq2zHnQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=HX0KOYi9O3sXiFcz52RqBowlLZAnNQDNKbaYG4pm6k3zlmJnuNbDTBNtH+Zwy/pca
         C0NqCyyOtTCBV+rrE3zv5qeZIl6rxxea384r7Tl/QMLhrxuwzpInhotWXGuiWFyDjH
         RBRHl96SCnDn9MrKlCvEY5AxbJ8A3Jzm10nbxR/w=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2017hm50127530
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 1 Jan 2022 01:43:48 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Sat, 1
 Jan 2022 01:43:48 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Sat, 1 Jan 2022 01:43:48 -0600
Received: from LT5CD112GSQZ.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2017gpwe033162;
        Sat, 1 Jan 2022 01:43:42 -0600
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
Subject: [PATCH v3 09/17] mtd: spinand: Add change_mode() in manufacturer_ops
Date:   Sat, 1 Jan 2022 13:12:42 +0530
Message-ID: <20220101074250.14443-10-a-nandan@ti.com>
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

Introduce change_mode() manufacturer_op to let the vendor provide the
implementation of switching of SPI IO modes.

The method to switch to different SPI IO mode may vary across
manufacturers. For example, for Winbond, Octal DTR is enabled by
writing values to the volatile configuration register. So, let the
manufacturer's code have their own implementation for switching to
any given SPI IO mode. Manufacturer's code need to take care, if
the requested protocol change is allowed/needed and how to apply
it.

Signed-off-by: Apurva Nandan <a-nandan@ti.com>
---
 include/linux/mtd/spinand.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 5dae0649f2fb..ad924271a248 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -298,6 +298,7 @@ struct spinand_devid {
 /**
  * struct manufacurer_ops - SPI NAND manufacturer specific operations
  * @init: initialize a SPI NAND device
+ * @change_mode: switch the SPI NAND flash to a specific SPI protocol
  * @cleanup: cleanup a SPI NAND device
  *
  * Each SPI NAND manufacturer driver should implement this interface so that
@@ -305,6 +306,8 @@ struct spinand_devid {
  */
 struct spinand_manufacturer_ops {
 	int (*init)(struct spinand_device *spinand);
+	int (*change_mode)(struct spinand_device *spinand,
+			   const enum spinand_protocol protocol);
 	void (*cleanup)(struct spinand_device *spinand);
 };
 
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28C4248650F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 14:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239423AbiAFNQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 08:16:24 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:22896 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239412AbiAFNQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 08:16:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1641474983; x=1673010983;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BXPzbPZ/ssF/48ZYAhIwqGMu3Se1bRG4usRlYmMMhRg=;
  b=xQCnnkfihKfTLiVkUdpB5FpYVhT1i4CI31RBbmGIQXsAwNdxY//v7rBH
   R8z8ljBIUzko07l4KZp80CM70YyA6rkoy9N7/QGOsdeLD4HVt4NGGpDEj
   etLCITi5aFXdVX7PrqAQLs4lSIkWaBm/G8KQ2blMw0laGaO9/nPJH3ai1
   QVDTHeMqxPPOZhVQ9YpBrpJgWCh9BAO+lpqmNj3qqFO+2eweZUq2Ysdqs
   i0FnfWdktMADMKwj66nYbNMYXQ8+io2GbnE5MzwEv0f5jl5XHxXqv++iq
   napqUBPM7osySaQH/RzF2MBUCcdA41+10evJK1Uo7i1m3NmS2vbz0trGo
   g==;
IronPort-SDR: zo+Z4pvVkCG8YGhrKky4RA9DFgsIEvjH0c7Mtuu0ls5+9fXtcY343jHhwjabI/2S1jsXyy99U/
 /PwRDB6PtrWJSxy79+4OoNF27k1OhwyhkxRrqtFKnmiUlMGeUgk/fHsoAJO4rXbbw5zIStrroN
 /7CwbteL5cJqT4nmCVaGAEwv8aAIJ+s1AoOZN132xwUgyT9nZNGImpt776A7NV+HlvhRo6be62
 8HfWU1JfRDlRLOeR0gMXvNUZYCS5Cao9SewKtpUtgvO7eGEvbZEZEtgqiujKxXx5U+n+g9SBvJ
 gZHYfeTE4hFuUtMVxOhq9PZw
X-IronPort-AV: E=Sophos;i="5.88,267,1635231600"; 
   d="scan'208";a="148757598"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Jan 2022 06:16:23 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 6 Jan 2022 06:16:22 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 6 Jan 2022 06:16:20 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <miquel.raynal@bootlin.com>
CC:     <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH 2/2] mtd: rawnand: Rework of_get_nand_bus_width()
Date:   Thu, 6 Jan 2022 15:16:10 +0200
Message-ID: <20220106131610.225661-2-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220106131610.225661-1-tudor.ambarus@microchip.com>
References: <20220106131610.225661-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_get_nand_bus_width() had a wrong behavior because:
1/ it ignored the -ENODATA and -EOVERFLOW return values of
   of_property_read_u32(). "nand-bus-width" without value was tolerated
   while it shouldn't have been according to the devicetree bindings.
2/ returned -EIO when the nand-bus-width was neither 8 nor 16, when it
   should have returned -EINVAL instead.
3/ returned the 8 or 16 bus-width integer, but it was never used it its
   caller. A simply return 0 on success is enough.
Rework of_get_nand_bus_width() and address all the above. The execution
is now stopped in case of errors.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/nand/raw/nand_base.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index b8e7f1aae032..54153d7aa671 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -5271,20 +5271,24 @@ static void of_get_nand_ecc_legacy_user_config(struct nand_chip *chip)
 		user_conf->placement = of_get_rawnand_ecc_placement_legacy(dn);
 }
 
-static int of_get_nand_bus_width(struct device_node *np)
+static int of_get_nand_bus_width(struct nand_chip *chip)
 {
+	struct device_node *dn = nand_get_flash_node(chip);
 	u32 val;
+	int ret;
 
-	if (of_property_read_u32(np, "nand-bus-width", &val))
-		return 8;
+	ret = of_property_read_u32(dn, "nand-bus-width", &val);
+	if (ret == -EINVAL)
+		/* Buswidth defaults to 8 if the property does not exist .*/
+		return 0;
+	else if (ret)
+		return ret;
 
-	switch (val) {
-	case 8:
-	case 16:
-		return val;
-	default:
-		return -EIO;
-	}
+	if (val == 16)
+		chip->options |= NAND_BUSWIDTH_16;
+	else if (val != 8)
+		return -EINVAL;
+	return 0;
 }
 
 static int of_get_nand_secure_regions(struct nand_chip *chip)
@@ -5360,12 +5364,14 @@ static int rawnand_dt_init(struct nand_chip *chip)
 {
 	struct nand_device *nand = mtd_to_nanddev(nand_to_mtd(chip));
 	struct device_node *dn = nand_get_flash_node(chip);
+	int ret;
 
 	if (!dn)
 		return 0;
 
-	if (of_get_nand_bus_width(dn) == 16)
-		chip->options |= NAND_BUSWIDTH_16;
+	ret = of_get_nand_bus_width(chip);
+	if (ret)
+		return ret;
 
 	if (of_property_read_bool(dn, "nand-is-boot-medium"))
 		chip->options |= NAND_IS_BOOT_MEDIUM;
-- 
2.25.1


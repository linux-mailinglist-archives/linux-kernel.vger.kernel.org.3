Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AEDF478B55
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 13:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236261AbhLQM0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 07:26:46 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:31965 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236248AbhLQM0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 07:26:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639744005; x=1671280005;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V5ZR6s8MB7+mpb2lz2QxEhkfyBBpZFRy1C+27uyk7k4=;
  b=D3YG/RLFXjetWuexsd0Gj84KrYt7yusDD4B9GwNEUQkESkiAnuvHBY2s
   376e62O8aAaHuK9C7Tsmt28p+2mm+wwHClHD3HGsP3r5SeKsXOHjnr4OV
   CmaXIj7UKiOYH09xUbVMrAGFkhMRWvh/dbosYb5sxCiEND+y1ewLFyBxk
   PaLjqMRtx2Ny0eFgGHwJFk1UBVlEO+1wllVFQJaGCO9OkRNhasFdCB1SF
   AGxowSnFZrHPertUIQ6HuZlYcOXM/6NbHnOokdFDGzl2LDBtPQdsBaDOH
   OlUtcgSvGBx1bDhcK93mMVN+Nv/LziupMB+Hylid6+skNjE0iA+WisTj6
   g==;
IronPort-SDR: vrusUyFqdmu3lle/KGNTDzL8oeCzklp9GWQ4094UuC0+YBvFSLNeYyRXrWKbo9WmtUkBoZ8s/K
 9NWUSLvP33Eku8rSvuwVRc+0xY6U/FZhi1mwD1nQIx+AXhANtKQB4XefFF4brFsMSqK024PKii
 tNOCtXgYWfNtTUSk9ob/8umQsaqcD+NrtaZVGTCbKnMMnMAq/p1ORToDXJOOzC/eKRGfVOIgIk
 BFN/bdoN/tZPFLSZDun5uAX37sR2l+XtoU92jKYukrUQl/8g1lt4M2JlL6mE77hrd0m1iwiSOI
 EXO6hgHsxQIGC1e6qq9bP53R
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="140126600"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Dec 2021 05:26:44 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 17 Dec 2021 05:26:44 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 17 Dec 2021 05:26:41 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <zhuohao@chromium.org>, <p.yadav@ti.com>, <michael@walle.cc>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>
Subject: [PATCH 1/2] mtd: spi-nor: Remove debugfs entries that duplicate sysfs entries
Date:   Fri, 17 Dec 2021 14:26:35 +0200
Message-ID: <20211217122636.474976-2-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211217122636.474976-1-tudor.ambarus@microchip.com>
References: <20211217122636.474976-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SPI NOR sysfs defines partname and jedec_id device attributes, which
duplicate the information from debugfs. Since the sysfs directory
structure and the attributes in each directory define an ABI between the
kernel and user space, thus it can never be removed, remove the debugfs
entries so that we don't duplicate the information.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/core.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 2e21d5ac0e2d..435bd17af0b4 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -3126,16 +3126,6 @@ static const struct flash_info *spi_nor_match_id(struct spi_nor *nor,
 	return NULL;
 }
 
-static void spi_nor_debugfs_init(struct spi_nor *nor,
-				 const struct flash_info *info)
-{
-	struct mtd_info *mtd = &nor->mtd;
-
-	mtd->dbg.partname = info->name;
-	mtd->dbg.partid = devm_kasprintf(nor->dev, GFP_KERNEL, "spi-nor:%*phN",
-					 info->id_len, info->id);
-}
-
 static const struct flash_info *spi_nor_get_flash_info(struct spi_nor *nor,
 						       const char *name)
 {
@@ -3243,8 +3233,6 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
 
 	nor->info = info;
 
-	spi_nor_debugfs_init(nor, info);
-
 	mutex_init(&nor->lock);
 
 	/* Init flash parameters based on flash_info struct and SFDP */
-- 
2.25.1


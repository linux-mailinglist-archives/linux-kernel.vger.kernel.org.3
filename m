Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5895085FE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 12:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352239AbiDTKhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 06:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236192AbiDTKhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 06:37:18 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8742F3FBD3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 03:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1650450873; x=1681986873;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hN+YFo8V3ZD60FPQlCtrm9OPlHU487xjyJBhUnbJURs=;
  b=yCc9qRRHaoQmB3rIDq8OQc0HpyUGA17VhchJOUDLNDN4RQdodRrgOaGP
   zcdBo8pLjvdE+5JKfocX1NF+VleGauJmPhKzQouEf+x8Zx5Y0Hi7a9XBS
   UwoklU1CiN9ejAGQdmBVNscJoacaFdpJTO7eRB51t1WL63ljhDT91X/u+
   oG8sCLE6MtZWOGSzfNzgT56pFvlk7Nd7G5hu0AXBEvAMah628kSMeQmKq
   YKDrNEV2lACCQQqRC1SQoyDL1xD7GvVkkBA1sXDpgAWUcriercLw5tH8C
   qYSY1/KXEgVsG+zu4Zn3gvbGFmicm/kg1JAMKrYxquelfrw5Cp2k1qmRt
   g==;
X-IronPort-AV: E=Sophos;i="5.90,275,1643698800"; 
   d="scan'208";a="153206876"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Apr 2022 03:34:32 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 20 Apr 2022 03:34:30 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 20 Apr 2022 03:34:28 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <p.yadav@ti.com>, <michael@walle.cc>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <Takahiro.Kuwano@infineon.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH v4 00/11] mtd: spi-nor: Rework Octal DTR methods
Date:   Wed, 20 Apr 2022 13:34:16 +0300
Message-ID: <20220420103427.47867-1-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v4:
- s/spi_nor_read_reg/spi_nor_read_any_reg and
s/spi_nor_write_reg/spi_nor_write_any_volatile_reg to comply with Micron
and Cypress's naming scheme. Update documentation description on
spi_nor_write_any_volatile_reg.
- 2 new patches, the last ones, where I remove status polling on write
volatile registers
- collect R-bs
v3:
- queue patch: "mtd: spi-nor: Introduce templates for SPI NOR operations"
from
https://lore.kernel.org/lkml/20220304093011.198173-1-tudor.ambarus@microchip.com/
The dependency chain between patches was too long and hard to follow.

- Rework patch "mtd: spi-nor: core: Use auto-detection only once"
according to Pratyush's and Michael's suggestions
- Remove dev_dbg messge from spi_nor_read_id() method and let the callers
use their own message (detection, octal dtr enable/disable)
- detailed version changes in each patch
 
v2:
- Fix bug on octal dtr disable, s/nor->reg_proto/SNOR_PROTO_1_1_1,
because after disable the nor->proto is not yet updated
- update function/macros names to comply with Michael's rename series.

Tudor Ambarus (11):
  mtd: spi-nor: Rename method, s/spi_nor_match_id/spi_nor_match_name
  mtd: spi-nor: Introduce spi_nor_match_id()
  mtd: spi-nor: core: Use auto-detection only once
  mtd: spi-nor: core: Introduce method for RDID op
  mtd: spi-nor: manufacturers: Use spi_nor_read_id() core method
  mtd: spi-nor: core: Add helpers to read/write any register
  mtd: spi-nor: micron-st: Rework spi_nor_micron_octal_dtr_enable()
  mtd: spi-nor: spansion: Rework spi_nor_cypress_octal_dtr_enable()
  mtd: spi-nor: Introduce templates for SPI NOR operations
  mtd: spi-nor: spansion: Remove status polling on volatile registers
    write
  mtd: spi-nor: micron-st: Remove status polling on volatile registers
    write

 drivers/mtd/spi-nor/core.c      | 254 ++++++++++++++++----------------
 drivers/mtd/spi-nor/core.h      | 115 +++++++++++++++
 drivers/mtd/spi-nor/micron-st.c | 139 ++++++++---------
 drivers/mtd/spi-nor/spansion.c  | 159 ++++++++++----------
 drivers/mtd/spi-nor/xilinx.c    |  12 +-
 5 files changed, 404 insertions(+), 275 deletions(-)

-- 
2.25.1


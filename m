Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4FA84FB707
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 11:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237746AbiDKJM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 05:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343754AbiDKJMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 05:12:52 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3663418E26
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 02:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1649668240; x=1681204240;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zIRYPCBuYDuGaaJFVQUJJswCne5BuSs6kiWW7gKe1Wk=;
  b=ny8cfY/vGdaGZOt27sZnmV+hkkgu+Bl1OhrmksE0svonZHUYv+XfwyDT
   8mtef8t949G7rgcEb865LQb0UI29RWH1QR17vlNzADufvYa4LAbMcI0pu
   sDDy8gRvUmD7LkcDnMmrqmNpR8hdb3Zb204Fpds/guHEO1az5lJZee3m7
   0lGarrTyqUrITSVcYnJrSlIbBtDTMu6taR0iPI3ajhDJUNhaWBWv/FE1p
   LmSW16FUtG6u73u33IL66OwenOp9AV4pm47QwYo4/mB1bTCFnWsZDET1z
   FcHXpXMNTIZXWuda9YvzUc5wuVLdkkk9edwXw/JJ85uuti+jrjaDIqErB
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,251,1643698800"; 
   d="scan'208";a="152208105"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Apr 2022 02:10:39 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 11 Apr 2022 02:10:37 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 11 Apr 2022 02:10:35 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <p.yadav@ti.com>, <michael@walle.cc>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <nicolas.ferre@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH v3 0/9] mtd: spi-nor: Rework Octal DTR methods
Date:   Mon, 11 Apr 2022 12:10:24 +0300
Message-ID: <20220411091033.98754-1-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3:
- queue patch: "mtd: spi-nor: Introduce templates for SPI NOR operations"
from
https://lore.kernel.org/lkml/20220304093011.198173-1-tudor.ambarus@microchip.com/
The dependancy chain between patches was too long and hard to follow.

- Rework patch "mtd: spi-nor: core: Use auto-detection only once"
according to Pratyush's and Michael's suggestions
- Remove dev_dbg messge from spi_nor_read_id() method and let the callers
use their own message (detection, octal dtr enable/disable)
- detailed version changes in each patch
 
v2:
- Fix bug on octal dtr disable, s/nor->reg_proto/SNOR_PROTO_1_1_1,
because after disable the nor->proto is not yet updated
- update function/macros names to comply with Michael's rename series.

Tudor Ambarus (9):
  mtd: spi-nor: Rename method, s/spi_nor_match_id/spi_nor_match_name
  mtd: spi-nor: Introduce spi_nor_match_id()
  mtd: spi-nor: core: Use auto-detection only once
  mtd: spi-nor: core: Introduce method for RDID op
  mtd: spi-nor: manufacturers: Use spi_nor_read_id() core method
  mtd: spi-nor: core: Add helpers to read/write any register
  mtd: spi-nor: micron-st: Rework spi_nor_micron_octal_dtr_enable()
  mtd: spi-nor: spansion: Rework spi_nor_cypress_octal_dtr_enable()
  mtd: spi-nor: Introduce templates for SPI NOR operations

 drivers/mtd/spi-nor/core.c      | 249 ++++++++++++++++----------------
 drivers/mtd/spi-nor/core.h      | 115 +++++++++++++++
 drivers/mtd/spi-nor/micron-st.c | 142 +++++++++---------
 drivers/mtd/spi-nor/spansion.c  | 161 +++++++++++----------
 drivers/mtd/spi-nor/xilinx.c    |  12 +-
 5 files changed, 405 insertions(+), 274 deletions(-)

-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85DC54FBC87
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 14:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243800AbiDKM4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 08:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346239AbiDKM4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 08:56:08 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86AB139146
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 05:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1649681631; x=1681217631;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SiCUePDrJ89bzUhfoZ5GqmHxOEBBtleH5I9gXwug5RY=;
  b=oW6cpVHASuPfoYcUGD9r01JE+fHd3fADroL0xAsA4ErjMvm0hssoHSr7
   Ch/I7OEYovaa9g7LWaCNzeFDXeAKw3+kjRaa+q+hBeRVtl4wy1W/4FdIW
   +2iHchMBaWsoOrWUHzI+u3uleDNBfRzaCetynoO82kgZ4tidf7sGEpmqU
   TAqDRz0xB8nzMsQEII6PYfTiO9ShMIIKSQcsGyrg5VbBa/6HJat0B1Vq0
   rO3clpVZGK8Il4bcc/y8x6sp3yJM9rjBSjvzFAvJtH5A/13ekjUFVCyiw
   EMF1bPa1NhKP4twUFi1/qnNtl8IQgo8VCTwbPBKeHgIrF0cmDvXa1BA6x
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,251,1643698800"; 
   d="scan'208";a="160069405"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Apr 2022 05:53:50 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 11 Apr 2022 05:53:50 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 11 Apr 2022 05:53:48 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <p.yadav@ti.com>, <michael@walle.cc>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <nicolas.ferre@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH v3 0/3] mtd: spi-nor: Parse BFPT to determine the 4-Byte Address Mode
Date:   Mon, 11 Apr 2022 15:53:43 +0300
Message-ID: <20220411125346.118274-1-tudor.ambarus@microchip.com>
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

Depends on:
https://lore.kernel.org/lkml/20220411091033.98754-1-tudor.ambarus@microchip.com/

Get the 4-Byte Address mode method from BFPT and favor it in the detriment
of the "default" set_4byte_addr_mode method or the methods set by vendors.
This may introduce some regressions if flashes have wrong BFPT data. The
fix is to introduce post_bfpt() hooks and fix where needed. We should let
the core/sfdp do the params initialization, and do vendor specific updates
just where needed.

v3:
- Move the newly introduced BFPT definitions in sfdp.h, as they may be used by
manufacturer drivers to handle flash ID collisions.
- Drop "mtd: spi-nor: sfdp: Keep SFDP definitions private" patch for the same
reason as above
- Collect R-b tags

v2: Drop quad enable patch

Tudor Ambarus (3):
  mtd: spi-nor: Parse BFPT to determine the 4-Byte Address Mode methods
  mtd: spi-nor: Update name and description of the set_4byte_addr_mode
    BFPT methods
  mtd: spi-nor: Favor the BFPT-parsed set_4byte_addr_mode method

 drivers/mtd/spi-nor/core.c      |  70 ++------------------
 drivers/mtd/spi-nor/core.h      |   1 -
 drivers/mtd/spi-nor/macronix.c  |   9 ++-
 drivers/mtd/spi-nor/micron-st.c |  32 ++-------
 drivers/mtd/spi-nor/sfdp.c      | 113 ++++++++++++++++++++++++++++++++
 drivers/mtd/spi-nor/sfdp.h      |  30 +++++++++
 drivers/mtd/spi-nor/winbond.c   |  18 +++--
 7 files changed, 174 insertions(+), 99 deletions(-)
-- 
2.25.1


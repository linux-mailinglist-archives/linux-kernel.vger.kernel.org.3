Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFFEC4D312B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 15:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233607AbiCIOnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 09:43:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233362AbiCIOnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 09:43:19 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C8117DBBF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 06:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646836941; x=1678372941;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VXzSaYAq968hpLq9pjQu4f3W0hi/lLLCGhCMIFyMafw=;
  b=C3BkaDaNMpF6mjSQYrTebGcK6t2IL67vsOdrGU9HoRhxsaeDFrI0h5oA
   jgGEElDq73VIAy66bcQ59OpjxQUX0NfngrOh7849/jN+qKFU24PGfU9uQ
   4n5GUrZdFIrFASiRJOyza85IlbBhBfENhfF3N2jex50dxnR2v40kLWtgA
   OW2/9jbMfxT+bKAJlhz/DP/S9Gvd9KBhxMtze5/sqQWUavRE3tm2iNOj4
   j2l7+4BAP0U9wow1FVSo6jvfpJx9BSGuuXwgLqFYa7i8Gq617un2kH4Yu
   nEtqcUllRB7OYrKgIkOanG53S+kbv+8s9mlyhZtOxtluxgd4LVqnSSK4A
   A==;
X-IronPort-AV: E=Sophos;i="5.90,167,1643698800"; 
   d="scan'208";a="148622984"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Mar 2022 07:42:20 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 9 Mar 2022 07:42:19 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 9 Mar 2022 07:42:17 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <p.yadav@ti.com>, <michael@walle.cc>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <nicolas.ferre@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH v2 0/4] mtd: spi-nor: Parse BFPT to determine the 4-Byte Address Mode
Date:   Wed, 9 Mar 2022 16:42:11 +0200
Message-ID: <20220309144215.179449-1-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Get the 4-Byte Address mode method from BFPT and favor it in the detriment
of the "default" set_4byte_addr_mode method or the methods set by vendors.
This may introduce some regressions if flashes have wrong BFPT data. The
fix is to introduce post_bfpt() hooks and fix where needed. We should let
the core/sfdp do the params initialization, and do vendor specific updates
just where needed.

This patch set depends on:
https://lore.kernel.org/lkml/20220304093011.198173-1-tudor.ambarus@microchip.com/
which depends on:
https://lore.kernel.org/lkml/20220228111712.111737-1-tudor.ambarus@microchip.com/

You can find a branch containing the entire chain at:
git@github.com:ambarus/linux-0day.git spi-nor/next-bfpt-4byte-addr

v2: drop quad enable patch

Tudor Ambarus (4):
  mtd: spi-nor: Parse BFPT to determine the 4-Byte Address Mode methods
  mtd: spi-nor: Update name and description of the set_4byte_addr_mode
    BFPT methods
  mtd: spi-nor: Favor the BFPT-parsed set_4byte_addr_mode method
  mtd: spi-nor: sfdp: Keep SFDP definitions private

 drivers/mtd/spi-nor/core.c      |  70 +----------
 drivers/mtd/spi-nor/core.h      |   1 -
 drivers/mtd/spi-nor/macronix.c  |   9 +-
 drivers/mtd/spi-nor/micron-st.c |  32 +----
 drivers/mtd/spi-nor/sfdp.c      | 199 ++++++++++++++++++++++++++++++++
 drivers/mtd/spi-nor/sfdp.h      |  57 +--------
 drivers/mtd/spi-nor/winbond.c   |  18 +--
 7 files changed, 234 insertions(+), 152 deletions(-)

-- 
2.25.1


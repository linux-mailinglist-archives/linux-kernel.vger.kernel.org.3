Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AEF14D30E0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 15:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233455AbiCIOSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 09:18:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233316AbiCIOSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 09:18:10 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDEFBD5DEE
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 06:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646835430; x=1678371430;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ip4hiPToVyVYmBzzKbqrn6/4sK/sQ+uNG9WRKRgypNY=;
  b=XbEEJVRP6ifC6TEXYli+YL/iJGTHzCTJYzeyaze7tmYMpP5sZSjfu4O/
   fXk2F7uHI5fKOSg9ZsH17WrpLaLQjsUvxwceGuVT7cEdPQ7dYddHgomHq
   hRt3YjUQdkBsMoWg0V7EmYDXEsn8EuhzesulLeZQe2DwmXa0Mg3BIvI5l
   VTUT5blda4nMmFc/5exx9Obz605s/b0hTFj//zIm+FSn/7dSmLygMGpO2
   FPfI+t7y8anEca2C+40MpXavFloxE0mDKBca2Wrep6d8qvWlNCktRzKS+
   X+0WiH+VgUQmsW3BHvIwrQMfbT8hFZInFkR2iv6a030NRQVP/moSU8R21
   g==;
X-IronPort-AV: E=Sophos;i="5.90,167,1643698800"; 
   d="scan'208";a="148620095"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Mar 2022 07:17:09 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 9 Mar 2022 07:17:07 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 9 Mar 2022 07:17:05 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <p.yadav@ti.com>, <michael@walle.cc>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>
Subject: [PATCH 0/5] mtd: spi-nor: Parse BFPT to determine the 4-Byte Address Mode
Date:   Wed, 9 Mar 2022 16:16:57 +0200
Message-ID: <20220309141702.173879-1-tudor.ambarus@microchip.com>
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

Tudor Ambarus (5):
  mtd: spi-nor: Parse BFPT to determine the 4-Byte Address Mode methods
  mtd: spi-nor: Update name and description of the set_4byte_addr_mode
    BFPT methods
  mtd: spi-nor: Favor the BFPT-parsed set_4byte_addr_mode method
  mtd: spi-nor Favor the BFPT-parsed Quad Enable method
  mtd: spi-nor: sfdp: Keep SFDP definitions private

 drivers/mtd/spi-nor/core.c      |  73 ++----------
 drivers/mtd/spi-nor/core.h      |   1 -
 drivers/mtd/spi-nor/issi.c      |   4 +-
 drivers/mtd/spi-nor/macronix.c  |  13 ++-
 drivers/mtd/spi-nor/micron-st.c |  32 +----
 drivers/mtd/spi-nor/sfdp.c      | 199 ++++++++++++++++++++++++++++++++
 drivers/mtd/spi-nor/sfdp.h      |  57 +--------
 drivers/mtd/spi-nor/winbond.c   |  18 +--
 8 files changed, 239 insertions(+), 158 deletions(-)

-- 
2.25.1


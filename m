Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B49984C6A00
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 12:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbiB1LSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 06:18:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234423AbiB1LR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 06:17:58 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3EABF2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 03:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646047038; x=1677583038;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=t73JCsD7PZHwhkuYI4yML7PDv9mGaY4kWadlsL2q9n8=;
  b=DyYFqk/h50/u9V0/8uJs5f+UoAy6scdrcwFapbOqrPhW1ZWMPnTTbDUS
   AMD7QT5H8FNMpVET1J+AS/JcqR+nnENLLj+U0HuxG6t64jdbeHlfQ9XAD
   jEgNYTJhEsuXp6+5RHSFTPybHkf7PfNEI0jFI0czu+yyYjnp6P6nN6bN5
   6SdG5Ave5x9daOUuyI6EHbeVBwOJfHwqYpL4p1arCABBd2lbmNK0QxrMI
   gVh4g/NU/zlBmGcOVEslAefwD8jkUTCsDprIl80uo+DxpAF0MVXcVC4c0
   DLAwnadIXvvJbCKeyHrkuTwWaQrQMSErGv51TSSU/Reuzvct0za1iDeAq
   g==;
X-IronPort-AV: E=Sophos;i="5.90,142,1643698800"; 
   d="scan'208";a="155099335"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Feb 2022 04:17:17 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 28 Feb 2022 04:17:17 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 28 Feb 2022 04:17:14 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <p.yadav@ti.com>, <michael@walle.cc>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <nicolas.ferre@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH v2 0/8] mtd: spi-nor: Rework Octal DTR methods
Date:   Mon, 28 Feb 2022 13:17:04 +0200
Message-ID: <20220228111712.111737-1-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a combination of:
https://lore.kernel.org/lkml/20220209133656.374903-1-tudor.ambarus@microchip.com/
https://lore.kernel.org/lkml/20220210023334.408926-1-tudor.ambarus@microchip.com/

Macronix patches will be handled in a further series.

v2:
- Fix bug on octal dtr disable, s/nor->reg_proto/SNOR_PROTO_1_1_1,
because after disable the nor->proto is not yet updated
- update function/macros names to comply with Michael's rename series.

Tudor Ambarus (8):
  mtd: spi-nor: Rename method, s/spi_nor_match_id/spi_nor_match_name
  mtd: spi-nor: Introduce spi_nor_match_id()
  mtd: spi-nor: core: Use auto-detection only once
  mtd: spi-nor: core: Introduce method for RDID op
  mtd: spi-nor: manufacturers: Use spi_nor_read_id() core method
  mtd: spi-nor: core: Add helpers to read/write any register
  mtd: spi-nor: micron-st: Rework spi_nor_micron_octal_dtr_enable()
  mtd: spi-nor: spansion: Rework spi_nor_cypress_octal_dtr_enable()

 drivers/mtd/spi-nor/core.c      | 153 ++++++++++++++++++++++----------
 drivers/mtd/spi-nor/core.h      |  13 +++
 drivers/mtd/spi-nor/micron-st.c | 112 ++++++++++++-----------
 drivers/mtd/spi-nor/spansion.c  | 131 ++++++++++++++-------------
 4 files changed, 241 insertions(+), 168 deletions(-)

-- 
2.25.1


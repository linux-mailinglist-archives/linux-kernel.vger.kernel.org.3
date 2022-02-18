Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 114304BBBA6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 16:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236611AbiBRPBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 10:01:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236753AbiBRPAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 10:00:24 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564FDE3886;
        Fri, 18 Feb 2022 06:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1645196348; x=1676732348;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oPl3hd9ujCsquNcCi9as7ggff9q2Exrkg2DKeD9fC0s=;
  b=neLiYy2Ylbctla9wT6H0P9dAW8toyICV3SCUy2SZnzNJsm/MqzaSvQun
   NIJK6FgeI1Bz4iD325oQytbVGqbV4cnP+MKHyWCvNE4WU/FhDHWEoXddz
   MK8x/ea3srLm6XJEqC3L74RbqjyXlJPBPEXh8+cOBDcBG/Bmzwc39wBJv
   FIX4aFMk8PnTcircSNNdXD1M+nlWpVVwIvqWmnLw3bsyqOKYfDbFUeC4x
   o90sjBqg4ipkcJxs6D3d0ded13/H8i80y9WhHi0UImmT786zYN2cfE9iw
   Cw7/nVOCJvYRgcT88+WxGePo1SAQdti2erfi4+7fFsZLmbDJif8aaRATO
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="162788983"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Feb 2022 07:59:05 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 18 Feb 2022 07:59:05 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 18 Feb 2022 07:59:01 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <p.yadav@ti.com>, <michael@walle.cc>, <broonie@kernel.org>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <nicolas.ferre@microchip.com>,
        <zhengxunli@mxic.com.tw>, <jaimeliao@mxic.com.tw>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH 0/4] spi-mem: Allow specifying the byte order in DTR mode
Date:   Fri, 18 Feb 2022 16:58:56 +0200
Message-ID: <20220218145900.1440045-1-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are NOR flashes (Macronix) that swap the bytes on a 16-bit boundary
when configured in DTR mode. The byte order of 16-bit words is swapped
when read or written in Double Transfer Rate (DTR) mode compared to
Single Transfer Rate (STR) mode. If one writes D0 D1 D2 D3 bytes using
1-1-1 mode, and uses 8D-8D-8D SPI mode for reading, it will read back
D1 D0 D3 D2. Swapping the bytes may introduce some endianness problems.
It can affect the boot sequence if the entire boot sequence is not handled
in either 8D-8D-8D mode or 1-1-1 mode. Fortunately there are controllers
that can swap back the bytes at runtime, fixing the endiannesses. Provide
a way for the upper layers to specify the byte order in DTR mode.

Tested with atmel-quadspi and mx66lm1g45g.

Tudor Ambarus (4):
  spi: spi-mem: Allow specifying the byte order in DTR mode
  mtd: spi-nor: core: Allow specifying the byte order in DTR mode
  mtd: spi-nor: sfdp: Get the 8D-8D-8D byte order from BFPT
  mtd: spi-nor: core: Introduce SPI_NOR_DTR_BSWAP16 no_sfdp_flag

 drivers/mtd/spi-nor/core.c  | 36 +++++++++++++++++++++++++++++-------
 drivers/mtd/spi-nor/core.h  |  6 +++++-
 drivers/mtd/spi-nor/sfdp.c  |  3 +++
 drivers/mtd/spi-nor/sfdp.h  |  1 +
 include/linux/mtd/spi-nor.h | 17 +++++++++++++++++
 include/linux/spi/spi-mem.h |  3 +++
 6 files changed, 58 insertions(+), 8 deletions(-)

-- 
2.25.1


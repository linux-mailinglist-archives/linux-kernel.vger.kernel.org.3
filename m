Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 396254D5CEC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 09:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346779AbiCKIDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 03:03:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233866AbiCKIC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 03:02:59 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2931B757A;
        Fri, 11 Mar 2022 00:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646985715; x=1678521715;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AzZqXsvGH16lWupXaADkIIwRJDwU6rAZUXxnYSi/l0A=;
  b=oAmoB/ZlZlKNZkJ5lHRKMi+5CjAqNSTH4HRC0uTE8rQk/kZAuV2ijTFg
   78HSCFaift/+2wI5bZ1bvtvrmswQt47X5yHpZ/GPABVBBwa98Oq8hYo++
   g2lSHsa3iO0QHhWS6FmWGhPgX7MF8OTFHdLTNSw7jNqG9cWXYRAH0jCjX
   wYq1ozCF/jOLym0sN1pK+u0b4OHtU/MzoKJTWA7S2PMnzT+nBJq4MfCZh
   Y2e9Sc4PfURgnfvAF85WZJ6HyCp9V/2xWmeWl5oBQPupwxJKN/R2XvIHo
   qC8c//H2lAaxVDOYUnMEYjnHZdaL6EgaH/WUX1NYpCIdGXtStMcZy3dN/
   A==;
X-IronPort-AV: E=Sophos;i="5.90,173,1643698800"; 
   d="scan'208";a="148864908"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Mar 2022 01:01:54 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 11 Mar 2022 01:01:53 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 11 Mar 2022 01:01:50 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <p.yadav@ti.com>, <michael@walle.cc>, <broonie@kernel.org>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <nicolas.ferre@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH v2 0/6] spi-mem: Allow specifying the byte order in DTR mode
Date:   Fri, 11 Mar 2022 10:01:41 +0200
Message-ID: <20220311080147.453483-1-tudor.ambarus@microchip.com>
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

There are NOR flashes (Macronix) that swap the bytes on a 16-bit boundary
when configured in Octal DTR mode. The byte order of 16-bit words is
swapped when read or written in Octal Double Transfer Rate (DTR) mode
compared to Single Transfer Rate (STR) modes. If one writes D0 D1 D2 D3
bytes using 1-1-1 mode, and uses 8D-8D-8D SPI mode for reading, it will
read back D1 D0 D3 D2. Swapping the bytes is a bad design decision because
it may introduce some endianness problems. It can affect the boot sequence
if the entire boot sequence is not handled in either 8D-8D-8D mode or 1-1-1
mode. So we must swap the bytes back to have the same byte order as in STR
modes. Fortunately there are controllers that can swap the bytes back at
runtime, addressing the flash's endiannesses requirements.
If the controllers are not capable of swapping the bytes, the protocol is
downgraded via spi_nor_spimem_adjust_hwcaps(). When available, the swapping
of the bytes is always done regardless if it's a data or register access,
so that we comply with the JESD216 requirements: "Byte order of 16-bit
words is swapped when read in 8D-8D-8D mode compared to 1-1-1".

Tested with atmel-quadspi driver, both in 8D-8D-8D mode and 1-1-1 mode
(via the protocol downgrade).

This patch set depends on the SPI MEM changes from linux-mtd/mtd/next and
also on some SPI NOR patches that are waiting for R-b tags. You can find
a branch if you want to test it at:

To github.com:ambarus/linux-0day.git
 * [new branch]                spi-nor/next-mx-byte-swap-v2 -> spi-nor/next-mx-byte-swap-v2

v2:
- all: s/bswap16/swab16 to comply with linux naming scheme
- SPI MEM: add dtr_swab16 cap to spi_controller_mem_caps and update
  spi_mem_default_supports_op() to check for it.
- SPI NOR: do not encode swab16 info in the SPI NOR protocol, use a helper
  instead
- SPI NOR: downgrade the SPI NOR protocol in case the SPI Controller does
  not support swab16
- add SPI_NOR_SOFT_RESET and support for mx66lm1g45g

Tudor Ambarus (6):
  spi: spi-mem: Allow specifying the byte order in DTR mode
  mtd: spi-nor: core: Allow specifying the byte order in DTR mode
  mtd: spi-nor: sfdp: Get the 8D-8D-8D byte order from BFPT
  mtd: spi-nor: core: Introduce SPI_NOR_DTR_BSWAP16 no_sfdp_flag
  mtd: spi-nor: core: Introduce SPI_NOR_SOFT_RESET flash_info fixup_flag
  mtd: spi-nor: macronix: Add support for mx66lm1g45g

 drivers/mtd/spi-nor/core.c     |  16 +++-
 drivers/mtd/spi-nor/core.h     |  10 ++-
 drivers/mtd/spi-nor/macronix.c | 130 +++++++++++++++++++++++++++++++++
 drivers/mtd/spi-nor/sfdp.c     |   4 +
 drivers/spi/spi-mem.c          |   4 +
 include/linux/spi/spi-mem.h    |   6 ++
 6 files changed, 168 insertions(+), 2 deletions(-)

-- 
2.25.1


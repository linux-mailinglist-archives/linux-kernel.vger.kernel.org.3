Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E597058C373
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 08:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234871AbiHHGql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 02:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiHHGqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 02:46:38 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D55101CA;
        Sun,  7 Aug 2022 23:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1659941197; x=1691477197;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FVcZt3g9dN4KqEcK66vr9WuH6JLgWK2Sx/SymlRoM10=;
  b=S8wf+ZWhwXbdfeXFY7ii1Ndj488nhbIdjSIxmyjusVqvkWNXuvL2Z4y1
   FAaJvk+R8p+Y/SdgGtvQzIJRSYh9JCr34XHHxhbBIxqu8F2/zms14D9Ry
   byjDc4+6gM56YXWi5Ojbsnbq7FQX/kelUiuP1UG/D9UC1zqlhKUbKLtVe
   6EfnDT/9EAxYzO62m7X5rlupgbO1Fq+Ypy1oYR5MHFxBThL8zRghf2QkU
   jT2cDWuigOuC1HdijIlV2oQ768Sce38CZh8IJYWiSaGnt6cC/OYfYTImj
   MbI6gRkDzh9wO434pokoGQcs1QVC4WnEIt+c74DmpgtkQt6PFauuruqen
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,221,1654585200"; 
   d="scan'208";a="107987859"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Aug 2022 23:46:34 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Sun, 7 Aug 2022 23:46:31 -0700
Received: from microchip-OptiPlex-5040.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.28 via Frontend Transport; Sun, 7 Aug 2022 23:46:28 -0700
From:   Naga Sureshkumar Relli <nagasuresh.relli@microchip.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor.dooley@microchip.com>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <Valentina.FernandezAlanis@microchip.com>,
        Naga Sureshkumar Relli <nagasuresh.relli@microchip.com>
Subject: [PATCH v4 0/4] Add support for Microchip QSPI controller
Date:   Mon, 8 Aug 2022 12:15:59 +0530
Message-ID: <20220808064603.1174906-1-nagasuresh.relli@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables the Microchip's FPGA QSPI and Polarfire SoC QSPI
controller support.

Tested spi-nand (W25N01GV) and spi-nor (MT25QL256A) on Microchip's
ICICLE kit. tested using both FPGA QSPI and Polarfie SoC QSPI.

changes in v4
-------------
1. Removed microchip,mpfs-qspi compatible from the driver
2. Changed platform_get_irq() return value check from <=0 to <0
3. Fixed dt_binding_check warning by installing latest yamllint

changes in v3
------------
1. Added dev_err_probe() at places like probe failures
2. Split the dt-bindings one for adding coreqspi compatible
   and other one to add coreqspi as fallback to mpfs-qspi.

changes in v2
------------
1. Replaced spi_alloc_master() with devm_spi_alloc_master()
2. Used dev_err_probe() when devm_spi_alloc_master() fails.
3. Added shared IRQ flag in the interrupt registration.
4. Updated the dt_bindings so that there is a differentiation
   between FPGA QSPI IP core and hard QSPI IP core.

Naga Sureshkumar Relli (4):
  spi: dt-binding: document microchip coreQSPI
  spi: dt-binding: add coreqspi as a fallback for mpfs-qspi
  spi: microchip-core-qspi: Add support for microchip fpga qspi
    controllers
  MAINTAINERS: add qspi to Polarfire SoC entry

 .../bindings/spi/microchip,mpfs-spi.yaml      |  15 +-
 MAINTAINERS                                   |   1 +
 drivers/spi/Kconfig                           |   9 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-microchip-core-qspi.c         | 600 ++++++++++++++++++
 5 files changed, 622 insertions(+), 4 deletions(-)
 create mode 100644 drivers/spi/spi-microchip-core-qspi.c

-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 586DD587770
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 09:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234782AbiHBHGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 03:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232817AbiHBHGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 03:06:04 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636D9B1E1;
        Tue,  2 Aug 2022 00:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1659423962; x=1690959962;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4uKslXInd/LYsZkf3rMu4R9j6IPobKre4A/4EBr2oP4=;
  b=WNkiDPnLjTkIyJX5nfX/S7QOHWZYF2bq2NuhVlqBUT1tp/UQG8XU4T8W
   gDuMmiA9cFJrBO3nImB7M0SmZJ2qNssDhZ7WLkEoEjbnvySBKmTuHzfbL
   oJkjsTCa9ww0L1tqJuLo7N/fi7sjJjMujPFVyYhNLBFGedXoC3g1scA2U
   XOetq25LCVYFVAIDgYcdo2HMpygkNscew/RiJLMQJXGCRV5WMlnS0DtmB
   WEzS5zCXpwHd44LyxYJjGON3hhaAd9TTguxF1nOZ/WVRkvN+s1HrhxEkU
   VwU+WpakpYDDUDMNJzb2WrzJEPbhrt/cqyeXQgdECFNctqm/BpvNclhsm
   g==;
X-IronPort-AV: E=Sophos;i="5.93,210,1654585200"; 
   d="scan'208";a="174531286"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Aug 2022 00:06:02 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 2 Aug 2022 00:06:00 -0700
Received: from microchip-OptiPlex-5040.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.28 via Frontend Transport; Tue, 2 Aug 2022 00:05:57 -0700
From:   Naga Sureshkumar Relli <nagasuresh.relli@microchip.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor.dooley@microchip.com>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Naga Sureshkumar Relli <nagasuresh.relli@microchip.com>
Subject: [PATCH v2 0/3] Add support for Microchip QSPI controller
Date:   Tue, 2 Aug 2022 12:35:15 +0530
Message-ID: <20220802070518.855951-1-nagasuresh.relli@microchip.com>
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

This patch enables the Microchip's FPGA QSPI and Polarfire SoC QSPI
controller support.

Tested spi-nand (W25N01GV) and spi-nor (MT25QL256A) on Microchip's
ICICLE kit. tested using both FPGA QSPI and Polarfie SoC QSPI.

changes in v2
------------
1. Replaced spi_alloc_master() with devm_spi_alloc_master()
2. Used dev_err_probe() when devm_spi_alloc_master() fails.
3. Added shared IRQ flag in the interrupt registration.
4. Updated the dt_bindings so that there is a differentiation
   between FPGA QSPI IP core and hard QSPI IP core.
5. Updated the MAINTAINERS file.

Naga Sureshkumar Relli (3):
  spi: dt-binding: add Microchip CoreQSPI compatible
  spi: microchip-core-qspi: Add support for microchip fpga qspi
    controllers
  MAINTAINERS: add qspi to Polarfire SoC entry

 .../bindings/spi/microchip,mpfs-spi.yaml      |  12 +-
 MAINTAINERS                                   |   1 +
 drivers/spi/Kconfig                           |   9 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-microchip-core-qspi.c         | 609 ++++++++++++++++++
 5 files changed, 629 insertions(+), 3 deletions(-)
 create mode 100644 drivers/spi/spi-microchip-core-qspi.c

-- 
2.25.1


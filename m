Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4B85866F9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 11:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbiHAJnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 05:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbiHAJnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 05:43:02 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894DB3718F;
        Mon,  1 Aug 2022 02:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1659346981; x=1690882981;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=45nnWKhIy5I2t3QQIGYOl1EJ3hjjvGwnuv1MlEvAF8U=;
  b=DcZMzCxG7WP5z2ThtWeAF0LrpQwNgqk13SA3/QRr9TuTRemoa/aws+Yq
   yaG+n0MJCuqxMxpXYb4oGO3y2Za5DWf1K5R3VTxllkKEcf42XuDtoO+7M
   OylqI/cu9lrrnV2Fc5ZWvodsKGj7lHyp/Kw2vQBaxZP6aEZjE7EZSlmO0
   kK/xgPYsLJh+rq/bKoSidd+2Fl6qrSn1SK/gmCSrpafSG2bXrxEeCBCxt
   thQ6P4l5GnaJpUDeQXEthqK8KBsmSmdOOdgPr2XX0CEdDqtbKUknIpSyx
   nr+6XrxqapiUOlKR+lqQCSf8G9Te5sa0xR6fkZAIZ4Yoah55E1MLUdO/s
   w==;
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="106988939"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Aug 2022 02:43:00 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 1 Aug 2022 02:43:00 -0700
Received: from microchip-OptiPlex-5040.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.28 via Frontend Transport; Mon, 1 Aug 2022 02:42:57 -0700
From:   Naga Sureshkumar Relli <nagasuresh.relli@microchip.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor.dooley@microchip.com>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Naga Sureshkumar Relli <nagasuresh.relli@microchip.com>
Subject: [PATCH 0/2] Add support for Microchip QSPI controller
Date:   Mon, 1 Aug 2022 15:12:53 +0530
Message-ID: <20220801094255.664548-1-nagasuresh.relli@microchip.com>
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

Naga Sureshkumar Relli (2):
  spi: dt-binding: add Microchip CoreQSPI compatible
  spi: microchip-core-qspi: Add support for microchip fpga qspi
    controllers

 .../bindings/spi/microchip,mpfs-spi.yaml      |  10 +-
 drivers/spi/Kconfig                           |   9 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-microchip-core-qspi.c         | 604 ++++++++++++++++++
 4 files changed, 621 insertions(+), 3 deletions(-)
 create mode 100644 drivers/spi/spi-microchip-core-qspi.c

-- 
2.25.1


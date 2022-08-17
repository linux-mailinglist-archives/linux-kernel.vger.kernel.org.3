Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7D78596AC4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 10:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbiHQIDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 04:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiHQIDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 04:03:08 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C96A2;
        Wed, 17 Aug 2022 01:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660723385; x=1692259385;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NR972ITJen90HoEiRrQftltI+Alot7Bl1nWm8R7vdcY=;
  b=MOmavYttQXBm6nzUqCKn+kjIs3u15PQXCMxTzaik4XY5D3dWOD/kjAVU
   PEiSYUao7fXohZJ1tFJe+QWU5mFKyswizWU675ulGXXi3Ao+KNyyOax/T
   RNzwKLpya70SQEIxdkHr83tn3zzvoHe2IreJ/xNZNZm/yI6/AXMo4q43s
   9zjLLgC04GntVIVsKNqA7dFO4fGd82UUYDkGVFSen6lVylrID8uGN9gTq
   dHvFmYGRjVFwWClMnqJfEzHDI/q105eQXS9M3/Sy5RBYtrSou+lTQPwec
   lPysQ0TKK5E+rNaHztOy2uiF/c9pkbR8tDjporQp00dXsYFLL2nB39eQ+
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="109399450"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Aug 2022 01:03:03 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 17 Aug 2022 01:03:03 -0700
Received: from ROB-ULT-M68701.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Wed, 17 Aug 2022 01:02:58 -0700
From:   Sergiu Moga <sergiu.moga@microchip.com>
To:     <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
        <radu_nicolae.pirea@upb.ro>, <richard.genoud@gmail.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <admin@hifiphile.com>, <kavyasree.kotagiri@microchip.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        Sergiu Moga <sergiu.moga@microchip.com>
Subject: [PATCH 0/5] Make atmel serial driver aware of GCLK
Date:   Wed, 17 Aug 2022 10:55:13 +0300
Message-ID: <20220817075517.49575-1-sergiu.moga@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches introduces the GCLK as a potential clock source for
the baudrate generator of UART on sama5d2 SoCs. Unlike the serial mode of
the USART offered by FLEXCOM, the UART does not provide a fractional part
that can be added to the clock divisor to obtain a more accurate result,
which greatly decreases the flexibility available for producing a higher
variety of baudrates. Now, with the last patch of the series, the driver
will check for a GCLK in the DT. If provided, whenever `atmel_set_termios`
is called, unless there is a fractional part, the driver will compare the
error rate between the desired baudrate and the actual baudrate obtained
through each of the available clock sources and will choose the clock source
with the lowest error rate. While at it, convert the DT binding
for UART/USART to json-schema, update the FLEXCOM binding to reference the
new UART/USART binding and differentiate between the SPI of USART and the
SPI of FLEXCOM.

The first three patches of this patch series depend on this patch series
converting atmel-flexcom bindings to json-schema:
https://lore.kernel.org/all/20220708115619.254073-1-kavyasree.kotagiri@microchip.com/

Sergiu Moga (5):
  dt-bindings: mfd: atmel,sama5d2-flexcom: Add SPI child node ref
    binding
  dt-bindings: mfd: atmel,at91-usart: convert to json-schema
  dt-bindings: mfd: atmel,sama5d2-flexcom: Add USART child node ref
    binding
  clk: at91: sama5d2: Add Generic Clocks for UART/USART
  tty: serial: atmel: Make the driver aware of the existence of GCLK

 .../bindings/mfd/atmel,at91-usart.yaml        | 190 ++++++++++++++++++
 .../bindings/mfd/atmel,sama5d2-flexcom.yaml   |  18 +-
 .../devicetree/bindings/mfd/atmel-usart.txt   |  98 ---------
 drivers/clk/at91/sama5d2.c                    |  10 +
 drivers/tty/serial/atmel_serial.c             |  52 ++++-
 drivers/tty/serial/atmel_serial.h             |   1 +
 6 files changed, 264 insertions(+), 105 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/atmel,at91-usart.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-usart.txt

-- 
2.25.1


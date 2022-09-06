Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D265AEDF0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 16:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242105AbiIFOfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 10:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242216AbiIFOdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 10:33:37 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6F3979F8;
        Tue,  6 Sep 2022 06:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662472722; x=1694008722;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=U3MsuWSa5/ANNU0IferkV6aMPYqhSk2HZNq+UUntvlc=;
  b=O4PXirVtKbrY/NDlWq8qXGiWXowvzMJ90nTmR7Eq+Z4c8G3eRj74y6WW
   M/MaVcAkS5qzvMgejz3vHPj+u8nrSQhp6brEBFdDbq/JjWeFbWlqmQuBT
   J+oGjtwXzKMI5dTBqkLwwJyKkIoNo4yC77z1Jzf8Hm5RQ4IgCaVDZxeUj
   BQ9osRnbd1qlY/EneyNPkrhb8R3wdNQLNA53A+WEEeO6yZjGruzI5O6c/
   0Cxvw0gvM9v2v2FdZuNSjXN0lQazVY9JWtsYgoQdaB4+H5gHWKDrQl99t
   6GFLaQCIcOFsZbNgZixABXxBu2rnPqkZs0YCPzokWmLY9OSAHIPKXdGGZ
   g==;
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="189613793"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Sep 2022 06:56:33 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 6 Sep 2022 06:56:33 -0700
Received: from ROB-ULT-M68701.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Tue, 6 Sep 2022 06:56:28 -0700
From:   Sergiu Moga <sergiu.moga@microchip.com>
To:     <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
        <richard.genoud@gmail.com>, <radu_nicolae.pirea@upb.ro>,
        <gregkh@linuxfoundation.org>, <broonie@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <jirislaby@kernel.org>, <admin@hifiphile.com>,
        <sergiu.moga@microchip.com>, <kavyasree.kotagiri@microchip.com>,
        <tudor.ambarus@microchip.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-clk@vger.kernel.org>
Subject: [PATCH v2 00/13] Make atmel serial driver aware of GCLK
Date:   Tue, 6 Sep 2022 16:54:59 +0300
Message-ID: <20220906135511.144725-1-sergiu.moga@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
new UART/USART binding (while differentiating between the SPI of USART and the
SPI of FLEXCOM) and do some small DT related fixups.

The DT bindings related patches of this patch series depend on this patch
series converting atmel-flexcom bindings to json-schema:
https://lore.kernel.org/all/20220708115619.254073-1-kavyasree.kotagiri@microchip.com/

v1 -> v2:
- [PATCH 3] dt-bindings: mfd: atmel,sama5d2-flexcom: Add SPI child node ref
    binding:
	- use full schema paths

- [PATCH 5] dt-bindings: serial: atmel,at91-usart: convert to json-schema
	- only do what the commit says, split the addition of other compatibles
	(PATCH 6) and properties (PATCH 13) in other patches
	- remove unnecessary "|"'s
	- mention header in `atmel,usart-mode`'s description
	- place `if:` under `allOf:`
	- respect order of spi0's DT properties: compatible, then reg then the
	reset of properties

- two new baudrate clock source related patches:
  [PATCH 9] tty: serial: atmel: Add definition for GCLK as baudrate source clock
			+
  [PATCH 10] tty: serial: atmel: Define BRSRCCK bitmask of UART IP's Mode
    Register:
	- v1's bitfield definition of GCLK was wrong, so add two more patches:
		- one for the definition of GCLK of USART IP's
		- one for the definition of BRSRCCK bitmask and its bitfields
		for UART IP's

- a new cleanup related patch that introduces a new struct atmel_uart_port field:
  [PATCH 11] tty: serial: atmel: Only divide Clock Divisor if the IP is USART:
  	- this ensures a division by 8 which is unnecessary and unappliable to
	UART IP's is only done for USART IP's

- four new patches regarding DT fixes and a SPI binding update that I came
upon:
  [PATCH 1] spi: dt-bindings: atmel,at91rm9200-spi: Add DMA related properties
  [PATCH 2] ARM: dts: at91: sama7g5: Swap rx and tx for spi11
  [PATCH 4] ARM: dts: at91: sam9x60ek: Add DBGU compatibles to uart1
  [PATCH 6] dt-bindings: serial: atmel,at91-usart: Highlight SAM9X60 incremental

- [PATCH 12] tty: serial: atmel: Make the driver aware of the existence of GCLK
	- take into account the different placement of the baudrate clock source
	into the IP's Mode Register (USART vs UART)
	- don't check for atmel_port->gclk != NULL
	- use clk_round_rate instead of clk_set_rate + clk_get_rate
	- remove clk_disable_unprepare from the end of the probe method

Sergiu Moga (13):
  spi: dt-bindings: atmel,at91rm9200-spi: Add DMA related properties
  ARM: dts: at91: sama7g5: Swap rx and tx for spi11
  dt-bindings: mfd: atmel,sama5d2-flexcom: Add SPI child node ref
    binding
  ARM: dts: at91: sam9x60ek: Add DBGU compatibles to uart1
  dt-bindings: serial: atmel,at91-usart: convert to json-schema
  dt-bindings: serial: atmel,at91-usart: Add SAM9260 compatibles to
    SAM9x60
  dt-bindings: mfd: atmel,sama5d2-flexcom: Add USART child node ref
    binding
  tty: serial: atmel: Define GCLK as USART baudrate source clock
  tty: serial: atmel: Define BRSRCCK bitmask of UART IP's Mode Register
  tty: serial: atmel: Only divide Clock Divisor if the IP is USART
  clk: at91: sama5d2: Add Generic Clocks for UART/USART
  tty: serial: atmel: Make the driver aware of the existence of GCLK
  dt-bindings: serial: atmel,at91-usart: Add gclk as a possible USART
    clock

 .../bindings/mfd/atmel,sama5d2-flexcom.yaml   |  19 +-
 .../devicetree/bindings/mfd/atmel-usart.txt   |  98 ---------
 .../bindings/serial/atmel,at91-usart.yaml     | 191 ++++++++++++++++++
 .../bindings/spi/atmel,at91rm9200-spi.yaml    |  10 +
 arch/arm/boot/dts/at91-sam9x60ek.dts          |   2 +-
 arch/arm/boot/dts/sama7g5.dtsi                |   6 +-
 drivers/clk/at91/sama5d2.c                    |  10 +
 drivers/tty/serial/atmel_serial.c             |  65 +++++-
 drivers/tty/serial/atmel_serial.h             |   4 +
 9 files changed, 295 insertions(+), 110 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-usart.txt
 create mode 100644 Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml

-- 
2.25.1


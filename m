Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0214F8FFE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 09:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiDHIA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 04:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiDHIAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 04:00:19 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F89101F19;
        Fri,  8 Apr 2022 00:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1649404697; x=1680940697;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=v504pYW7RgErfmFZFhfV70JFK6RAZySTiXItBSHRxb0=;
  b=a8ABy6Kr0gpNWlqwEwUgqvFeK3Ompr3aEQkGhxv4Ktja+OUkscNN5mqV
   BDI2Ew6aQCZge2Lvoewxpt+WUltv02IZqBVoA/7FkrnbD279oGyQNkgf9
   BbbDBrQ/+mWmUEbSIiexI3AsC/RSdBj9McDr2Av3n/b+eZIzYWTLsWmQU
   1Bd1hUb66wZ+YBRSodqGJbAtJ+Fz4XcdME43c/Nrj571pzlWhYJbCtUn4
   QNRagUGXusJY8fa6sro/nUm6AJ1Bq1TgIhIlLB+15St9C6QvgmMj2qTYz
   Fix3srJDVZaPHcfHLwLqyxsUfPYedGZipfy6bZH411WM/XW+2O1Y2IeDO
   g==;
X-IronPort-AV: E=Sophos;i="5.90,244,1643698800"; 
   d="scan'208";a="159403630"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Apr 2022 00:58:16 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 8 Apr 2022 00:58:15 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 8 Apr 2022 00:58:12 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <robh+dt@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <p.zabel@pengutronix.de>,
        <linux@armlinux.org.uk>, <sre@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <cristian.birsan@microchip.com>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 00/10] power: reset: at91-reset: add support for sama7g5
Date:   Fri, 8 Apr 2022 11:00:21 +0300
Message-ID: <20220408080031.2527232-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The series adds reset controller support for SAMA7G5 SoCs. Compared with
previous version the reset controller embedded on SAMA7G5 is able to
reset individual on SoC devices (e.g. USB PHY controllers).

Among with this I took the change and converted reset controller
bindings to YAML (patch 2/8) and adapt reset controller nodes in
device tree files to comply with DT specifications (patch 1/8).

Thank you,
Claudiu Beznea

Changes in v3:
- use spin_lock_irqsave()/spin_unlock_irqrestore() and lock only
  on update path
- collected tags

Changes in v2:
- added patches 5/10 and 10/10
- in patch 2/10 use my microchip email address
- in patch 4/10 added "SAMA7G5_" in front of macros to cope with file
  naming and used (GPL-2.0-only OR BSD-2-Clause)
- in patch 6/10 documented the structure's members
- in patch 7/10:
	- protect access to reset->dev_base with spin lock
	- check for valid values of reset_spec->args[0] in
	  at91_reset_of_xlate()
	- s/if (IS_ERR(reset->rstc_base))/if (IS_ERR(reset->dev_base))
	- include dt-bindings/reset/sama7g5-reset.h
	- document new added structure's members
- collected tags

Claudiu Beznea (10):
  ARM: dts: at91: use generic name for reset controller
  dt-bindings: reset: convert Atmel/Microchip reset controller to YAML
  dt-bindings: reset: atmel,at91sam9260-reset: add sama7g5 bindings
  dt-bindings: reset: add sama7g5 definitions
  power: reset: at91-reset: document structures and enums
  power: reset: at91-reset: add at91_reset_data
  power: reset: at91-reset: add reset_controller_dev support
  power: reset: at91-reset: add support for SAMA7G5
  ARM: dts: at91: sama7g5: add reset-controller node
  ARM: configs: sama7: enable CONFIG_RESET_CONTROLLER

 .../devicetree/bindings/arm/atmel-sysregs.txt |  15 --
 .../reset/atmel,at91sam9260-reset.yaml        |  68 +++++++
 arch/arm/boot/dts/at91sam9260.dtsi            |   2 +-
 arch/arm/boot/dts/at91sam9261.dtsi            |   2 +-
 arch/arm/boot/dts/at91sam9263.dtsi            |   2 +-
 arch/arm/boot/dts/at91sam9g45.dtsi            |   2 +-
 arch/arm/boot/dts/at91sam9n12.dtsi            |   2 +-
 arch/arm/boot/dts/at91sam9rl.dtsi             |   2 +-
 arch/arm/boot/dts/at91sam9x5.dtsi             |   2 +-
 arch/arm/boot/dts/sam9x60.dtsi                |   2 +-
 arch/arm/boot/dts/sama5d2.dtsi                |   2 +-
 arch/arm/boot/dts/sama5d3.dtsi                |   2 +-
 arch/arm/boot/dts/sama5d4.dtsi                |   2 +-
 arch/arm/boot/dts/sama7g5.dtsi                |   7 +
 arch/arm/configs/sama7_defconfig              |   1 +
 drivers/power/reset/at91-reset.c              | 173 ++++++++++++++++--
 include/dt-bindings/reset/sama7g5-reset.h     |  10 +
 17 files changed, 257 insertions(+), 39 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/reset/atmel,at91sam9260-reset.yaml
 create mode 100644 include/dt-bindings/reset/sama7g5-reset.h

-- 
2.32.0


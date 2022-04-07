Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D74F64F771D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 09:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241579AbiDGHRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 03:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241565AbiDGHRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 03:17:08 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626D1104A68;
        Thu,  7 Apr 2022 00:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1649315700; x=1680851700;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JFNdfXCHSj+IjF1+ul+hY9+EU5wlsLMmYaMwq0mn3GY=;
  b=T/Pk5UFEtr0/i4qKuOljkLZFSY9ziaDun85G29jl7+He/uKVnn2NcXj0
   +WVM1fErul27Ji2kvhp98C9ZIhAxSCcHu5TlmaT31tXI0+PMTm8+YNld8
   S5St8bI7grvIFuNSGsos+SfbaQCpR2j5PBlUA8B4MOii32tYi96z71nis
   jl6BMeQByrPoVQKc6G4VCx8mhkQwMDiBpDvhDHSGeMn2gqV4IE2EbeylW
   RPdq/TARJ4gDE+zJbgJpu+h2bzAkCjwOq9cyBYN/m3K4Lbx5bMyBMfDU0
   PRwgnqs9wiuO0o+yv43Xlg1BtU47Wq7XIswSKzZopRgk9OkEBH9AiQBCN
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,241,1643698800"; 
   d="scan'208";a="159247017"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Apr 2022 00:14:59 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 7 Apr 2022 00:14:58 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 7 Apr 2022 00:14:55 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <robh+dt@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <p.zabel@pengutronix.de>,
        <linux@armlinux.org.uk>, <sre@kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 00/10] power: reset: at91-reset: add support for sama7g5
Date:   Thu, 7 Apr 2022 10:16:58 +0300
Message-ID: <20220407071708.3848812-1-claudiu.beznea@microchip.com>
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
 drivers/power/reset/at91-reset.c              | 174 ++++++++++++++++--
 include/dt-bindings/reset/sama7g5-reset.h     |  10 +
 17 files changed, 258 insertions(+), 39 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/reset/atmel,at91sam9260-reset.yaml
 create mode 100644 include/dt-bindings/reset/sama7g5-reset.h

-- 
2.32.0


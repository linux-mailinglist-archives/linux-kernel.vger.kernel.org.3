Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E505F5461E0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 11:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347901AbiFJJYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 05:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349567AbiFJJYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 05:24:02 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE31313A4;
        Fri, 10 Jun 2022 02:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1654852936; x=1686388936;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5aas3JDyd+r0RGlKzY7C5hd/x9F/tr7ozec8/31OfSg=;
  b=x6Lsk5M9aT6u4p0n8hoeKYXbxdDMAzAOknA6InUT56Pqzj7ufJQsm3oc
   7fmjZDvNcoTbiL4BJrlNlrbKvtzdjWlisr5PgFZTx9RpqOiJ7WJENSPfO
   z9TyRoGhgc6JitiEFrzcxDdEUYeKLsEo7nGkKB2K18cZNBBM+BurPewTO
   uBtf0WT+oUY2iOtWNQWZDhHt9embUzGIUxp+2zj/GMUpTXrUtj9x+Om9z
   nLHFe7wzKsiuXXNBrdOGcyQospL/GW/9RHbQYbO3RlYD/f9z40YmxIKot
   Sqsep/qTReoYA7avOWXLYFLTwL2tDFeHe4PjEV0a2qyX754sMBmV8RX5t
   A==;
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="162767360"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Jun 2022 02:22:15 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 10 Jun 2022 02:22:15 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 10 Jun 2022 02:22:11 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <p.zabel@pengutronix.de>, <sre@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v5 0/9] power: reset: at91-reset: add support for sama7g5
Date:   Fri, 10 Jun 2022 12:24:05 +0300
Message-ID: <20220610092414.1816571-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
bindings to YAML (patch 2/9) and adapt reset controller nodes in
device tree files to comply with DT specifications (patch 1/9).

Thank you,
Claudiu Beznea

Changes in v5:
- in patch 6/9 added device_reset_min_id, device_reset_max_id to
  struct at91_reset_data; these will be used in at91_reset_of_xlate()
  (patch 7/9) allowing expansion of device reset code for future
  devices; with this member of type const struct at91_reset_data *
  has been added to struct at91_reset and at91_rcdev_init() gets
  now only 2 arguments.
- in patch 8/9 use filled .device_reset_min_id, .device_reset_max_id
- in patch 6/9 use device_get_match_data()
- collected tags

Changes in v4:
- removed patch 10/10 from v3 as it has been taken though at91 tree

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

Claudiu Beznea (9):
  ARM: dts: at91: use generic name for reset controller
  dt-bindings: reset: convert Atmel/Microchip reset controller to YAML
  dt-bindings: reset: atmel,at91sam9260-reset: add sama7g5 bindings
  dt-bindings: reset: add sama7g5 definitions
  power: reset: at91-reset: document structures and enums
  power: reset: at91-reset: add at91_reset_data
  power: reset: at91-reset: add reset_controller_dev support
  power: reset: at91-reset: add support for SAMA7G5
  ARM: dts: at91: sama7g5: add reset-controller node

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
 drivers/power/reset/at91-reset.c              | 184 ++++++++++++++++--
 include/dt-bindings/reset/sama7g5-reset.h     |  10 +
 16 files changed, 265 insertions(+), 41 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/reset/atmel,at91sam9260-reset.yaml
 create mode 100644 include/dt-bindings/reset/sama7g5-reset.h

-- 
2.34.1


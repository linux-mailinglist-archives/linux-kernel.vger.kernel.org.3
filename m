Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A583E4CBFA2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 15:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233950AbiCCONM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 09:13:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbiCCONK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 09:13:10 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA71A18CC0E;
        Thu,  3 Mar 2022 06:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646316745; x=1677852745;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OmW3wFitWOZ9d4nCwITn7KMkbSxKvXR3UNgpfKrtjjc=;
  b=aTwDrlzxpfkpMTYgCZ0fE5V6N7yUUAFrc5DQVyIpmY1AWDBr8EOWB7/X
   K/48BORewPNTp2n9Et5yZp2YVX4/UToz57nBTV+e3aOfa1nvY2vGPeZeF
   5ZK/QxfVWceO8kM9vzXDAL5n2LllkkAErPVRNFCIruF5vJNfu6pgLOEE2
   8ndO3dxWW4o2xat+elbD3lEaZ6eIUKNoCx/Ku7+UFlR1CKXwApm0+LXRT
   puou0US0e/GWf8ncCqxR/sGskRH93hLXA9A/uJkFypqrP3KB7QL8tsQbG
   EuHOZJBTLxxm+raPhRveJY2CrF1pEhAG0BlTwZePPQvUYhmYIpWr5MIYS
   g==;
X-IronPort-AV: E=Sophos;i="5.90,151,1643698800"; 
   d="scan'208";a="147960138"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Mar 2022 07:12:24 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 3 Mar 2022 07:12:23 -0700
Received: from ROB-ULT-M68701.amer.actel.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 3 Mar 2022 07:12:18 -0700
From:   Sergiu Moga <sergiu.moga@microchip.com>
To:     <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski@canonical.com>,
        <nicolas.ferre@microchip.com>, <claudiu.beznea@microchip.com>
CC:     <linux-rtc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Sergiu Moga <sergiu.moga@microchip.com>
Subject: [PATCH v2 0/5] dt-bindings: rtc: convert at91sam9 bindings to
Date:   Thu, 3 Mar 2022 16:06:21 +0200
Message-ID: <20220303140626.38129-1-sergiu.moga@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series addresses the conversion of the RTC binding for
Atmel/Microchip SoCs to Device Tree Schema format. It also changes
the node names from some of the "dtsi" files from "rtt" to the more
generic "rtc", while moving some of the specific properties from the
"dts" files to the "dtsi" files as well as adding this required property to
the "dtsi" files that were missing it.

Changes since v1:
- Add the "start-year" property as suggested by Alexandre Belloni
- Fix the errors generated from not using the more generic "rtc" node
name for the example of the binding, as suggested by Krzysztof Kozlowski
- Replace the "uint32-array" type of the "atmel,rtt-rtc-time-reg"
  property with "syscon", as suggested by Krzysztof Kozlowski
- Move the "atmel,rtt-rtc-time-reg" property from some of the
Atmel/Microchip board files to the SoC files
- Add the "atmel,rtt-rtc-time-reg" required property to the
Atmel/Microchip SoC files that were missing it
- Use the more generic "rtc" node name inside the Atmel/Microchip SoC
files that were using "rtt" instead
- Add SAMA7G5 compatible strings list to the DT binding


Sergiu Moga (5):
  ARM: dts: at91: Move rtt node properties from "dts" file to "dtsi"
    file
  ARM: dts: at91: Add the required `atmel,rtt-rtc-time-reg` property
  ARM: dts: at91: Use the generic "rtc" node name for the rtt IPs
  dt-bindings: rtc: convert at91sam9 bindings to json-schema
  dt-bindings: rtc: at91: Add SAMA7G5 compatible strings list

 .../bindings/rtc/atmel,at91sam9-rtc.txt       | 25 -------
 .../bindings/rtc/atmel,at91sam9-rtc.yaml      | 65 +++++++++++++++++++
 arch/arm/boot/dts/at91-sam9x60ek.dts          |  5 --
 arch/arm/boot/dts/at91-sama7g5ek.dts          |  4 --
 arch/arm/boot/dts/at91sam9260.dtsi            |  1 +
 arch/arm/boot/dts/at91sam9260ek.dts           |  1 -
 arch/arm/boot/dts/at91sam9261.dtsi            |  1 +
 arch/arm/boot/dts/at91sam9263.dtsi            |  2 +
 arch/arm/boot/dts/at91sam9g45.dtsi            |  1 +
 arch/arm/boot/dts/at91sam9m10g45ek.dts        |  1 -
 arch/arm/boot/dts/at91sam9rl.dtsi             |  1 +
 arch/arm/boot/dts/sam9x60.dtsi                |  3 +-
 arch/arm/boot/dts/sama7g5.dtsi                |  3 +-
 13 files changed, 75 insertions(+), 38 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.yaml

-- 
2.25.1


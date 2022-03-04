Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B41184CD8C2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 17:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236821AbiCDQNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 11:13:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240704AbiCDQM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 11:12:59 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24261C944C;
        Fri,  4 Mar 2022 08:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646410332; x=1677946332;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ov1LE0FbKUUWwG2ayc5X90cLOPMgm/y4g1mec+lzQCU=;
  b=dmhzkt4b59d8e9GrG2tsXJxKirNM48hxj9joU7AK5ekMnNNqSSUBQ93o
   jH45dc4S9RK9Pja+ZWCZvQv28fvVt6RMWNQRKrYHULIEcyd2CR0oRXT2s
   48NTabX3W/0pBi0H4FKyxebSLC09RgE1VfkJVScWLSCk87utn6V2Pp/I5
   nyNEALsCUc1qhUlOwMimm/QktG6d505s1ONRjebaZD9eqaNXppzv+SEvG
   9sJNLfqEZeEan2OmUG8jjf4jED+oYzeFa7AX6nK/VbVok+rjwoJZ8MCxZ
   PNOSz5PlcasgutLwaqyA1zjVqf4iouk9vNCflCW7wQ4GeGLekUs5SXbIa
   g==;
X-IronPort-AV: E=Sophos;i="5.90,155,1643698800"; 
   d="scan'208";a="87851530"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Mar 2022 09:12:10 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 4 Mar 2022 09:12:09 -0700
Received: from ROB-ULT-M68701.amer.actel.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 4 Mar 2022 09:12:05 -0700
From:   Sergiu Moga <sergiu.moga@microchip.com>
To:     <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski@canonical.com>,
        <nicolas.ferre@microchip.com>, <claudiu.beznea@microchip.com>
CC:     <linux-rtc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Sergiu Moga <sergiu.moga@microchip.com>
Subject: [PATCH v4 0/4] dt-bindings: rtc: convert at91sam9 bindings to
Date:   Fri, 4 Mar 2022 18:11:55 +0200
Message-ID: <20220304161159.147784-1-sergiu.moga@microchip.com>
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
generic "rtc", while adding the `atmel,rtt-rtc-time-reg` required
property to the board files that were missing it.

Changes since v3:
- Removed unnecessary additional `rtc` node from
  `arch/arm/boot/dts/at91sam9263ek.dts`.
- Squashed commit related to the conversion of the binding to
  json-schema with the commit related to the usage of macros
  for the IRQ type of the binding's example.

Sergiu Moga (4):
  ARM: dts: at91: Add the required `atmel,rtt-rtc-time-reg` property
  ARM: dts: at91: Use the generic "rtc" node name for the rtt IPs
  dt-bindings: rtc: convert at91sam9 bindings to json-schema
  dt-bindings: rtc: at91: Add SAMA7G5 compatible strings list

 .../bindings/rtc/atmel,at91sam9-rtc.txt       | 25 -------
 .../bindings/rtc/atmel,at91sam9-rtc.yaml      | 69 +++++++++++++++++++
 arch/arm/boot/dts/at91sam9261ek.dts           |  4 ++
 arch/arm/boot/dts/at91sam9263ek.dts           |  4 ++
 arch/arm/boot/dts/at91sam9rlek.dts            |  4 ++
 arch/arm/boot/dts/sam9x60.dtsi                |  2 +-
 arch/arm/boot/dts/sama7g5.dtsi                |  2 +-
 7 files changed, 83 insertions(+), 27 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.yaml

-- 
2.25.1


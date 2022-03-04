Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73AFC4CD662
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 15:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239832AbiCDO3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 09:29:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239792AbiCDO3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 09:29:46 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ABBE1B60B4;
        Fri,  4 Mar 2022 06:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646404138; x=1677940138;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=H/iynhIkpEfv9ZlpWMFfCVlJ4/W9smECL8yrvx7yXlc=;
  b=O8JwIQEbXGhE2qiQx0/1sEH8T4yei0r6BkYzeV6G26ST1pQeqEN0cyt5
   iiESw6IdH5Ce6mEPaX/8LJ8HlDdZHGPF4cW0V78oq8KCWTZiTyJFooTAs
   /f46ub+ugNXrpsawMkUQd6wdPXBhOdIIHl+JWKeEFzWRIs12GYsWfUUc6
   bqwzarqJXbwma2cOpN63HqRaU+o0FzAzuMD9id9j52nkHbyabvuTNqnja
   cga4Cq2tHheSgt1WDCHncbJf3QrgoNt/JHCBNvwEebBBQsTSMbv95UTtC
   3/OgkV10vbF0rCaWHGLlQJ2xsiICdds/9CnFEcN/kAZyGMPUE+fTI79GC
   g==;
X-IronPort-AV: E=Sophos;i="5.90,155,1643698800"; 
   d="scan'208";a="150868593"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Mar 2022 07:28:57 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 4 Mar 2022 07:28:57 -0700
Received: from ROB-ULT-M68701.amer.actel.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 4 Mar 2022 07:28:54 -0700
From:   Sergiu Moga <sergiu.moga@microchip.com>
To:     <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski@canonical.com>,
        <nicolas.ferre@microchip.com>, <claudiu.beznea@microchip.com>
CC:     <linux-rtc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Sergiu Moga <sergiu.moga@microchip.com>
Subject: [PATCH v3 0/5] dt-bindings: rtc: convert at91sam9 bindings to
Date:   Fri, 4 Mar 2022 16:27:41 +0200
Message-ID: <20220304142746.121947-1-sergiu.moga@microchip.com>
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

Changes since v2:
- Removed patch that would move the `atmel,rtt-rtc-time-reg` property
from the board file to the SoC file.
- Modified the patch that adds the `atmel,rtt-rtc-time-reg` property
to add it in the board file instead of the SoC file.
- Replaced `start-year` and `additionalProperties` from the DT binding
with `unevaluatedProperties`.
- Modified the `atmel,rtt-rtc-time-reg` property described in the DT
binding to use items with description.
- Used macro for the IRQ type of the example node's interrupt property
of the DT binding.

Sergiu Moga (5):
  ARM: dts: at91: Add the required `atmel,rtt-rtc-time-reg` property
  ARM: dts: at91: Use the generic "rtc" node name for the rtt IPs
  dt-bindings: rtc: convert at91sam9 bindings to json-schema
  dt-bindings: rtc: at91: Use macros for the IRQ type
  dt-bindings: rtc: at91: Add SAMA7G5 compatible strings list

 .../bindings/rtc/atmel,at91sam9-rtc.txt       | 25 -------
 .../bindings/rtc/atmel,at91sam9-rtc.yaml      | 69 +++++++++++++++++++
 arch/arm/boot/dts/at91sam9261ek.dts           |  4 ++
 arch/arm/boot/dts/at91sam9263ek.dts           |  8 +++
 arch/arm/boot/dts/at91sam9rlek.dts            |  4 ++
 arch/arm/boot/dts/sam9x60.dtsi                |  2 +-
 arch/arm/boot/dts/sama7g5.dtsi                |  2 +-
 7 files changed, 87 insertions(+), 27 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.yaml

-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F29304D01C0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 15:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243366AbiCGOuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 09:50:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232588AbiCGOuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 09:50:00 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482B27E09A;
        Mon,  7 Mar 2022 06:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646664543; x=1678200543;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4aWIRFI8XlQrJ3FoHqdftAf5Mm43XBh+8uTq/2kna44=;
  b=t+WPUhpvHdAYKJTwgsiPiCJotrpLfwhyXg/Sr6Zx+92bjakii4o/uqLV
   5aHe6B/6XPqNUzhHLdAGSa41FiEXxDeOle7G7qxyWp1EJNmo09aH8Qyqj
   AAOcW99kO85kevHiHa2xDcLVTnHV88S/JjOEUwDghHQ9PcdyN2S/VuUtT
   vg4Fkd0zi8f0wjhiaMD+gWHWgADnyL4hRGEPsHFLr+f64q10I+4xBKPQY
   O2MFO6zbBY3DeNPI+dttRacx15r3AfhwyT4E3bnygFz46UF7crAd/dTOH
   B3JKvKwwo1keLm1GpB795Se9WauCcZOxfpaaSOvUUMaXvuXjKVgicfd35
   A==;
X-IronPort-AV: E=Sophos;i="5.90,162,1643698800"; 
   d="scan'208";a="148334220"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Mar 2022 07:49:02 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 7 Mar 2022 07:49:01 -0700
Received: from ROB-ULT-M68701.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 7 Mar 2022 07:48:57 -0700
From:   Sergiu Moga <sergiu.moga@microchip.com>
To:     <claudiu.beznea@microchip.com>, <thierry.reding@gmail.com>,
        <u.kleine-koenig@pengutronix.de>, <lee.jones@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski@canonical.com>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Sergiu Moga <sergiu.moga@microchip.com>
Subject: [PATCH v2 0/2] dt-bindings: pwm: convert atmel pwm to json-schema
Date:   Mon, 7 Mar 2022 16:46:50 +0200
Message-ID: <20220307144652.162706-1-sergiu.moga@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series addresses the conversion of the Atmel PWM DT
binding to the DT Schema format and adds the SAMA7G5 compatible to
the respective converted binding.

Changes since v1:
- Name the file `atmel,at91sam-pwm.yaml` instead of `atmel-pwm.yaml`
- Removed unnecessary descriptions of the `reg` and `#pwm-cells`
properties
- Remove unnecessary `pwmleds` node
- Remove `#pwm-cells` property from the list of required properties
- Add `allOf` including `pwm.yaml`
- Rename title from `Atmel PWM Controller` to `Atmel/Microchip PWM
  controller`

Sergiu Moga (2):
  dt-bindings: pwm: convert atmel pwm to json-schema
  dt-bindings: pwm: at91: Add SAMA7G5 compatible strings list

 .../bindings/pwm/atmel,at91sam-pwm.yaml       | 47 +++++++++++++++++++
 .../devicetree/bindings/pwm/atmel-pwm.txt     | 35 --------------
 2 files changed, 47 insertions(+), 35 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/atmel,at91sam-pwm.yaml
 delete mode 100644 Documentation/devicetree/bindings/pwm/atmel-pwm.txt

-- 
2.25.1


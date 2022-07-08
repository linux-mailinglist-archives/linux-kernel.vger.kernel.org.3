Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24E556B901
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 13:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238117AbiGHL5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 07:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237909AbiGHL5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 07:57:02 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33DB9A6B2;
        Fri,  8 Jul 2022 04:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657281422; x=1688817422;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ta57q+0ptWGytEDpLrQro8nAHU6O7/jtI1SRgtlncZE=;
  b=aPMmoyGDhYmjCtoLt65tmWertfqZVqkMqxo1mkwr/lnzGDIAg6x9bbe0
   91TR1Jtgi2zYgm/BrDQiQojVvBidh3C4f4mxw3519nWKH/jT0Qc3m8/Kh
   K/gw7eeV0V76GbI7x4j7E9WPNJn1R8vk7ASFpRmty7CK5QcscKq51qlq3
   3Xf6y8URiQ9S27x/dkhASmWZdTP5ccNEHiVqiFDebzXWIaCJcmVWyk/F2
   Vc09Q8btgnXlw92wQlJ9qOdpWcrrQf1SQCHHN8h1SnjZJl/jtSedS6L3P
   uF540mq1Zhr6p0Nhpy8hSd9PGlxo6PX0dXysOi6JVH/+pBBqUwpryoMUl
   w==;
X-IronPort-AV: E=Sophos;i="5.92,255,1650956400"; 
   d="scan'208";a="171312653"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Jul 2022 04:57:01 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 8 Jul 2022 04:57:00 -0700
Received: from kavya.microchip.com (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 8 Jul 2022 04:56:56 -0700
From:   Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@microchip.com>, <UNGLinuxDriver@microchip.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Kavyasree.Kotagiri@microchip.com>
Subject: [PATCH v8 0/3] Add support for lan966x flexcom chip-select configuration
Date:   Fri, 8 Jul 2022 09:56:16 -0200
Message-ID: <20220708115619.254073-1-kavyasree.kotagiri@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series converts atmel-flexcom bindings into json-schema format.
Adds support for lan966x flexcom chip-select configurations and its
DT bindings.

v7 -> v8:
 - Added back patternProperties for child nodes.
 - Changed compatible string to microchip,lan9668-flexcom.

v6 -> v7:
 - Change filename to atmel,sama5d2-flexcom.yaml
 - Add #address-cells, #size-cells to flexcom node - Fixed warnings.

v5 -> v6:
 - Removed spi node from example as suggested by Rob and
   also pattern properties(spi dt-bindings conversion to yaml patch is under review).
   https://patchwork.kernel.org/project/linux-arm-kernel/patch/20220629125804.137099-1-sergiu.moga@microchip.com/
   Once this is accepted, I will add back spi example through new patch.

v4 -> v5:
 - Fix indentations of DT example.
 - Fix dt-schema errors - removed minItems, maxItems for allOf:if:then
   "reg" property as it is not required.

v3 -> v4:
 - Fix dtschema errors.
 - Add a condition to flexcom chip-selects configuration as chip-select
   lines are optional.

v2 -> v3:
 - changed IRQ flag in dt-bindings example.
 - added reg property specific to lan66x which is missed in v2.
 - used goto label for clk_disable in error cases.

v1 -> v2:
 - minor fix in title of dt-bindings.
 - Modified new dt properties usage in atmel,flexcom.yaml.
 - Used GENMASK and macros for maximum allowed values.
 - Use u32 values for flexcom chipselects instead of strings.
 - disable clock in case of errors.

Kavyasree Kotagiri (3):
  dt-bindings: mfd: Convert atmel-flexcom to json-schema
  dt-bindings: mfd: atmel,sama5d2-flexcom: Add new compatible string for
    lan966x
  mfd: atmel-flexcom: Add support for lan966x flexcom chip-select
    configuration

 .../bindings/mfd/atmel,sama5d2-flexcom.yaml   | 155 ++++++++++++++++++
 .../devicetree/bindings/mfd/atmel-flexcom.txt |  63 -------
 drivers/mfd/atmel-flexcom.c                   |  94 ++++++++++-
 3 files changed, 248 insertions(+), 64 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-flexcom.txt

-- 
2.25.1


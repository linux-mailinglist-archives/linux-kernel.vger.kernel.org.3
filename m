Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2BF15B218F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 17:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbiIHPHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 11:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbiIHPHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 11:07:13 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E724E7F86;
        Thu,  8 Sep 2022 08:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662649633; x=1694185633;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iuAjyc1ugtmuoCOqD949Mhnzk0rdZNDHFNljvvP0vFY=;
  b=vGl6dF+7dYYfI7ln4h7qhjbhKppETPzsQVoi0up2Kxr7oSjyd93aVQQU
   HhpkLioBahMzkbX+HNfW5+3UlpaEAygRI3qr+4LiIXPYMbRuGMHJXIVvi
   cSLB/j+axKHph0ZELfNbBguMJdOSFvZV++x6Qus9NXTTUlsVlbB9qI1KE
   80YKtlggbsG+MW2IY9JVnljyIyOPA3uxm0YPSZfzZlujNoFFVX9+eMZfh
   yg+PSH4TiyhV+HtDo2vRqCbSPEO0eZLUcBnbtWG98yRSfy00S3c+h3dEj
   V0QjsmCs3U9V2RJ53L8qR6Ck4IFz/4OwR2YZOmEC0vqKfLvGi1WGtyYNu
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="189991970"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Sep 2022 08:07:13 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 8 Sep 2022 08:07:09 -0700
Received: from kavya.microchip.com (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Thu, 8 Sep 2022 08:07:06 -0700
From:   Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
To:     <lee@kernel.org>
CC:     <nicolas.ferre@microchip.com>, <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <claudiu.beznea@microchip.com>
Subject: [RESEND PATCH v9 0/3] Add support for lan966x flexcom chip-select configuration
Date:   Thu, 8 Sep 2022 13:06:55 -0200
Message-ID: <20220908150658.1839520-1-kavyasree.kotagiri@microchip.com>
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

This patch series converts atmel-flexcom bindings into json-schema format.
Adds support for lan966x flexcom chip-select configurations and its
DT bindings.

v8 -> v9:
 - generated patches on linux-next v6.0.0-rc4 to resend.
 - Changed reference provided for spi bindings to atmel,at91rm9200-spi.yaml

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

 .../bindings/mfd/atmel,sama5d2-flexcom.yaml   | 154 ++++++++++++++++++
 .../devicetree/bindings/mfd/atmel-flexcom.txt |  63 -------
 drivers/mfd/atmel-flexcom.c                   |  94 ++++++++++-
 3 files changed, 247 insertions(+), 64 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-flexcom.txt

-- 
2.25.1


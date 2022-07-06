Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B14AE56865B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 13:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbiGFLGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 07:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232251AbiGFLGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 07:06:50 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CAE125E8B;
        Wed,  6 Jul 2022 04:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657105609; x=1688641609;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=E/xgLBqlL5pUK//Q/Ei1S6DfX76PrFSnnVUmmUe+oVY=;
  b=yjrDrYlKgFSAvhy1G6LBnIAZ2Cya1Uoh0G9PK6phkWL2Nu9tB727XDU5
   UTSK/FLg8zyaW6RqY+FwzOAMDAKVtS1gJH1vR8lrrPgpHiZ05t/6G/E1c
   dZcSXR5dldLyA89vnn1NNuE9BwqIj6qAM+bCkTPsDRhSterAbV8Y8rk9y
   uGe4/NqgEUML9aHcORYQWbArAqQ2Xpph/TSzIntoOUqELm6uMvm+SVrDk
   Wj9/2BZczPuhi8DwJxkNoRLxk9OLw7dnZLMvQQ28UmYm/gRZuacaNaM93
   rlMnk8bplC3FEYS6kM6s/c53A1fvei6T9a5tWgkqihw2UuwXgE5cp2UTi
   g==;
X-IronPort-AV: E=Sophos;i="5.92,249,1650956400"; 
   d="scan'208";a="170981999"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Jul 2022 04:06:42 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 6 Jul 2022 04:06:41 -0700
Received: from kavya.microchip.com (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Wed, 6 Jul 2022 04:06:37 -0700
From:   Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@microchip.com>, <UNGLinuxDriver@microchip.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Kavyasree.Kotagiri@microchip.com>
Subject: [PATCH v7 0/3] Add support for lan966x flexcom chip-select configuration
Date:   Wed, 6 Jul 2022 09:06:16 -0200
Message-ID: <20220706110619.71729-1-kavyasree.kotagiri@microchip.com>
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

 .../bindings/mfd/atmel,sama5d2-flexcom.yaml   | 137 ++++++++++++++++++
 .../devicetree/bindings/mfd/atmel-flexcom.txt |  63 --------
 drivers/mfd/atmel-flexcom.c                   |  94 +++++++++++-
 3 files changed, 230 insertions(+), 64 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-flexcom.txt

-- 
2.25.1


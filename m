Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5B76551FD3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 17:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239739AbiFTPHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 11:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242397AbiFTPH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 11:07:29 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0C22CDE4;
        Mon, 20 Jun 2022 07:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1655736401; x=1687272401;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=QLXZMwBa9pAOxf17J7fvF6iMR0JrstukPT7xjcVRc2o=;
  b=LC5qUElUnNyp1Ic2BRgAeH8i1czKPovIdE36vwVqTkRvpkyWY8GBOZFv
   RWuEX/++3lLE0uovTm55yZ8DluiKISmUml0bMMWZ5bllF3M+CH7QBBKif
   u837D5DlLBTwNyaSF5cgLnP/HoRPQEwnxn4VCNFGDgFAMPbr7LnZCm3nI
   aOu/JW5dHW/DHiJ9KfneVfvilXTnUquezuGW7ozvzXVjqYdn/0+/efTGu
   /YLQ5K+FIzW2ky+aRzayuJ+1RZnv/lqQbHKbw3F2PxQcqIK0PbNDHrQWS
   /HWQ183VUgFnTOpkKE45m5alYODLOnrN1wi7eq4hfvB2nfaPFIWWkobcH
   w==;
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; 
   d="scan'208";a="178690469"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Jun 2022 07:46:41 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 20 Jun 2022 07:46:40 -0700
Received: from kavya-HP-Compaq-6000-Pro-SFF-PC.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 20 Jun 2022 07:46:36 -0700
From:   Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>, <robh+dt@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <Claudiu.Beznea@microchip.com>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <UNGLinuxDriver@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 0/3] Add support for lan966x flexcom chip-select configuration
Date:   Mon, 20 Jun 2022 20:16:31 +0530
Message-ID: <20220620144634.25464-1-kavyasree.kotagiri@microchip.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
  dt-bindings: mfd: atmel,flexcom: Convert to json-schema
  dt-bindings: mfd: atmel,flexcom: Add new compatible string for lan966x
  mfd: atmel-flexcom: Add support for lan966x flexcom chip-select
    configuration

 .../bindings/mfd/atmel,flexcom.yaml           | 180 ++++++++++++++++++
 .../devicetree/bindings/mfd/atmel-flexcom.txt |  63 ------
 drivers/mfd/atmel-flexcom.c                   |  94 ++++++++-
 3 files changed, 273 insertions(+), 64 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-flexcom.txt

-- 
2.17.1


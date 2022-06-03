Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1C2253C9EB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 14:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244291AbiFCMSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 08:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiFCMSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 08:18:52 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B152657A;
        Fri,  3 Jun 2022 05:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1654258730; x=1685794730;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=wrd0K7H7EDw2u231wSTn5H0sgS1pwEg6W7Sr5G5fhbk=;
  b=ur8e1/dUEszWcZ2niqF5gDzffSpCxtVhJ0K6YzYyd2XvkV3usP8oR8yv
   7UbNn5Jp9QxdNfaWHlxttayhaTsdM4D9B1tzZ5BB918i/f7fv0JQg8ezs
   kUQ77egfEwh9/YnE3RALl8T/CYLqqxPKIVLtmOHeF1MaM/aTcFhOpbGN1
   0AUXaV1bCEVi3KpW5mJYLV/d3r2ydB2VBwGc5ftVrX9y6FoiHc940Ztw/
   Q5xI2bGIL4HvSTiHhtqigCc13mSDvBvk5PMY3HBr909Uepsf5cbJlQdOf
   WwoIHyZzP1XILVhsFdXYY2wuT57kbHQ0fYL1FHcfQ+UoO3Iq3YmcuhAsF
   w==;
X-IronPort-AV: E=Sophos;i="5.91,274,1647327600"; 
   d="scan'208";a="98453537"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Jun 2022 05:18:49 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 3 Jun 2022 05:18:49 -0700
Received: from kavya-HP-Compaq-6000-Pro-SFF-PC.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 3 Jun 2022 05:18:45 -0700
From:   Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@microchip.com>, <UNGLinuxDriver@microchip.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Kavyasree.Kotagiri@microchip.com>
Subject: [PATCH 0/3] Add support for lan966x flexcom chip-select configuration
Date:   Fri, 3 Jun 2022 17:47:59 +0530
Message-ID: <20220603121802.30320-1-kavyasree.kotagiri@microchip.com>
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

Kavyasree Kotagiri (3):
  dt-bindings: mfd: atmel,flexcom: Convert to json-schema
  dt-bindings: mfd: atmel,flexcom: Add new compatible string for lan966x
  mfd: atmel-flexcom: Add support for lan966x flexcom chip-select
    configuration

 .../bindings/mfd/atmel,flexcom.yaml           | 116 ++++++++++++++++++
 .../devicetree/bindings/mfd/atmel-flexcom.txt |  63 ----------
 drivers/mfd/atmel-flexcom.c                   |  86 ++++++++++++-
 3 files changed, 200 insertions(+), 65 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-flexcom.txt

-- 
2.17.1


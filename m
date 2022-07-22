Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E90B57E220
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 15:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234223AbiGVNPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 09:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiGVNPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 09:15:08 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C499F;
        Fri, 22 Jul 2022 06:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658495705; x=1690031705;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MMtFLVJCVURsH50ncvaBwx10bJP26mdv9/GtQkv07yo=;
  b=Ps+CzcerKXLDGzBo+L6cNlDtnGH6l5xNkNBEWrku5lNcNZRopM32b8c+
   mUCfD0lQeYYf5ibqgKgOuZmg2JHXius5Xf9s1amVUiuMx1haI/iIZxDXl
   iwItA+kLpHMGRVmqdEi29E8HKJum/8FoAR5lDjKFM4x11yciurNis/ZhA
   AReR/F/yh3FY1vjDi764gy9YVnRh9GlrXBpv3gLZADWKYiVHFMPiBSwQt
   hkvQA/VqtI/owG4vNVmdCbKcw7Ra6Go8K2ex9YkEXOswI2j/B/vTYNypY
   7b/hUrKPMCL4FFvItlFL9bdPTBBunuDzORBMGa3yQSDLpDLmATxyXRSxx
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,185,1654585200"; 
   d="scan'208";a="165969827"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Jul 2022 06:15:04 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 22 Jul 2022 06:15:02 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.28 via Frontend Transport; Fri, 22 Jul 2022 06:14:59 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@microchip.com>, <arnd@arndb.de>, <olof@lixom.net>,
        <soc@kernel.org>, <UNGLinuxDriver@microchip.com>,
        <maxime.chevallier@bootlin.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH v2 0/2] ARM: add support for pcb8309
Date:   Fri, 22 Jul 2022 15:18:34 +0200
Message-ID: <20220722131836.2377720-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pcb8309 and the documentation for it.
It features a LAN9662 SoC with 2 internal copper ports and two SFP cages.

v1->v2:
- remove unneeded properties from i2c102,i2c103,i2c4 nodes.
- set status property to be the last prorty of the nodes.
- fix typo in commit message.

Horatiu Vultur (2):
  dt-bindings: arm: at91: add lan966 pcb8309 board
  ARM: dts: lan966x: add support for pcb8309

 .../devicetree/bindings/arm/atmel-at91.yaml   |   6 +-
 arch/arm/boot/dts/Makefile                    |   3 +-
 arch/arm/boot/dts/lan966x-pcb8309.dts         | 184 ++++++++++++++++++
 3 files changed, 190 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/boot/dts/lan966x-pcb8309.dts

-- 
2.33.0


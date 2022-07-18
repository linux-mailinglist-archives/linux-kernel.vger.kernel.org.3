Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94737578CB1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 23:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234781AbiGRV01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 17:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233216AbiGRV0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 17:26:22 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B76329818;
        Mon, 18 Jul 2022 14:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658179582; x=1689715582;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y70GGaW6BDagLax0/EWabZmkNJ5Tl6nypTS5nqiDkeQ=;
  b=QKVC0KyPk+Gasw6Os4+5vEtOOH+fXGExcK9PKR6+zHIvQxOH5KR28Lwn
   BYNmU2So6u2sm5REBhAt05cfGdQbAW6t8HKRyP76aZfZ7dTDLbKRA/1PT
   5+oAGxp60nkl1v0n990fZDn9f+IWwkdR6yjn29QjjCWBr3J2EEniwFt8W
   avsrpNihMH1ZszKpF7JEcRI3jv0mrY4fQEepg5r1jDPFYfwforUNIiHsu
   QpZXJdOmgpjmgHBYMx1FvoFSg/0q6UI2Shv2Bl74vS8rj040CjYABu1YA
   PkPPmV2qeQyxDzg/XP4i9ibtltxVTcBHmUFVYH4BajFEF2xmaquK14oNH
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,282,1650956400"; 
   d="scan'208";a="168397642"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Jul 2022 14:26:20 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 18 Jul 2022 14:26:11 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 18 Jul 2022 14:26:09 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <claudiu.beznea@microchip.com>, <nicolas.ferre@microchip.com>,
        <UNGLinuxDriver@microchip.com>, <maxime.chevallier@bootlin.com>,
        "Horatiu Vultur" <horatiu.vultur@microchip.com>
Subject: [PATCH 2/3] ARM: dts: lan966x: Disable can0 on pcb8291
Date:   Mon, 18 Jul 2022 23:29:20 +0200
Message-ID: <20220718212921.1506984-3-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220718212921.1506984-1-horatiu.vultur@microchip.com>
References: <20220718212921.1506984-1-horatiu.vultur@microchip.com>
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

On pcb8291, can0 and the network driver share some of the GPIOs so only
1 device can be active. Therefore disable can0 as we want to enable the
network driver.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 arch/arm/boot/dts/lan966x-pcb8291.dts | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/arm/boot/dts/lan966x-pcb8291.dts b/arch/arm/boot/dts/lan966x-pcb8291.dts
index 02fbf7371a8d..2cb532aa33f0 100644
--- a/arch/arm/boot/dts/lan966x-pcb8291.dts
+++ b/arch/arm/boot/dts/lan966x-pcb8291.dts
@@ -30,18 +30,6 @@ fc3_b_pins: fc3-b-pins {
 		pins = "GPIO_52", "GPIO_53";
 		function = "fc3_b";
 	};
-
-	can0_b_pins:  can0-b-pins {
-		/* RX, TX */
-		pins = "GPIO_35", "GPIO_36";
-		function = "can0_b";
-	};
-};
-
-&can0 {
-	pinctrl-0 = <&can0_b_pins>;
-	pinctrl-names = "default";
-	status = "okay";
 };
 
 &flx3 {
-- 
2.33.0


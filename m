Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01E7E57A80D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 22:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240087AbiGSUIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 16:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236214AbiGSUIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 16:08:36 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901E127164;
        Tue, 19 Jul 2022 13:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658261315; x=1689797315;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KkRggwRSYjtJlZ7x4TNs2Imt5awOZ5Jigpm8UEZYnDE=;
  b=NAlnXpH+w39u/CQn5Yu8NaMM7iXnunkxDca5b6eiEJzJ8K0aRHSPJpo3
   VVlfBH9isuplP2sxyJDOUaqR6+Qpzhkd5B/HdZ0eJMiK7sqm/JUOzX35I
   rgvJSSw5taV1EFlBFzVlbCUzziWd5gS0rTCsFp5A0pB7AUvABQveIM0eS
   2lIpp4ZumNZwbHl08I/Cm4HCtRjCJQMO1jheLI9BzeFplHRCJN9Tfxbsb
   FtXL12IFVlzXBdOKKvzocjrfbNQ1P1cq0Ppgwsduk1+SClpK8VYE4v703
   XnbALJ3Y23IYP7Ko7KRYKoBorT3JICYrP0NFUF3+cgt7r/xXXHm08pnE/
   g==;
X-IronPort-AV: E=Sophos;i="5.92,285,1650956400"; 
   d="scan'208";a="105217570"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Jul 2022 13:08:35 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 19 Jul 2022 13:08:34 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 19 Jul 2022 13:08:32 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <claudiu.beznea@microchip.com>, <nicolas.ferre@microchip.com>,
        <UNGLinuxDriver@microchip.com>, <maxime.chevallier@bootlin.com>,
        "Horatiu Vultur" <horatiu.vultur@microchip.com>
Subject: [PATCH v2 2/3] ARM: dts: lan966x: Disable can0 on pcb8291
Date:   Tue, 19 Jul 2022 22:11:57 +0200
Message-ID: <20220719201158.1696168-3-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220719201158.1696168-1-horatiu.vultur@microchip.com>
References: <20220719201158.1696168-1-horatiu.vultur@microchip.com>
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
 arch/arm/boot/dts/lan966x-pcb8291.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/lan966x-pcb8291.dts b/arch/arm/boot/dts/lan966x-pcb8291.dts
index 02fbf7371a8d..ab80558de259 100644
--- a/arch/arm/boot/dts/lan966x-pcb8291.dts
+++ b/arch/arm/boot/dts/lan966x-pcb8291.dts
@@ -41,7 +41,7 @@ can0_b_pins:  can0-b-pins {
 &can0 {
 	pinctrl-0 = <&can0_b_pins>;
 	pinctrl-names = "default";
-	status = "okay";
+	status = "disabled"; /* Conflict with switch */
 };
 
 &flx3 {
-- 
2.33.0


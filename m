Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBEA5B1542
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 09:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbiIHHBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 03:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiIHHBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 03:01:40 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73EDA98368;
        Thu,  8 Sep 2022 00:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662620498; x=1694156498;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rx3VgOsaulT5mMDT3vfE0KD1nxBcFnkb6sIlQqeZcfA=;
  b=ETLBXLOxtQx7EM2AEfLLIuKC0gT3vnkjq/g77n5bPmSINHtdScwVcbbC
   +jCIgOYW2KaQ3r8fTT5l93YgIFWLsF2eu6wZLwUmpqXgtONcJ3IcnrrTU
   f0YgdBIbKYohD5A7RuqTLSIcojiAsfExEtFCOO5E+kGEOHSwrklLh3gtO
   /S3xIXS6PHFjSAodlTf+NoPzzCPW+y9epMSjwedOex5H5AqBlZ0tEuFBp
   ndRHy+nGvUfLDzVdyv+39IRlECgLwAqUrwrCEWRgA9aqOl7VQYHta+E6v
   fdPCLJ2cLayXfKHJay9I0mtDyZsIerwX4/X7Ca3pYywPN25IDvwe3219u
   g==;
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="179644063"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Sep 2022 00:01:38 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 8 Sep 2022 00:01:31 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Thu, 8 Sep 2022 00:01:29 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <claudiu.beznea@microchip.com>, <nicolas.ferre@microchip.com>,
        <UNGLinuxDriver@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH] ARM: dts: lan966x: disable aes
Date:   Thu, 8 Sep 2022 09:04:51 +0200
Message-ID: <20220908070451.3730608-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
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

Disable AES node on lan966x pcb8290, pcb891 and pcb8309 because these
boards have lan966x that uses secure OS which reserves the AES block.
Therefore it can't be exposed to non-secure world.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 arch/arm/boot/dts/lan966x-pcb8290.dts | 4 ++++
 arch/arm/boot/dts/lan966x-pcb8291.dts | 4 ++++
 arch/arm/boot/dts/lan966x-pcb8309.dts | 4 ++++
 3 files changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/lan966x-pcb8290.dts b/arch/arm/boot/dts/lan966x-pcb8290.dts
index 8a304210653a..2ed53da914ac 100644
--- a/arch/arm/boot/dts/lan966x-pcb8290.dts
+++ b/arch/arm/boot/dts/lan966x-pcb8290.dts
@@ -27,6 +27,10 @@ phy_external_reset: phy_external_reset {
 	};
 };
 
+&aes {
+	status = "disabled"; /* Reserved by secure OS */
+};
+
 &gpio {
 	miim_a_pins: mdio-pins {
 		/* MDC, MDIO */
diff --git a/arch/arm/boot/dts/lan966x-pcb8291.dts b/arch/arm/boot/dts/lan966x-pcb8291.dts
index 289a31649422..f4f054cdf2a8 100644
--- a/arch/arm/boot/dts/lan966x-pcb8291.dts
+++ b/arch/arm/boot/dts/lan966x-pcb8291.dts
@@ -53,6 +53,10 @@ led-s1-green {
 	};
 };
 
+&aes {
+	status = "disabled"; /* Reserved by secure OS */
+};
+
 &gpio {
 	fc3_b_pins: fc3-b-pins {
 		/* RX, TX */
diff --git a/arch/arm/boot/dts/lan966x-pcb8309.dts b/arch/arm/boot/dts/lan966x-pcb8309.dts
index cfd7c8933703..c436cd20d4b4 100644
--- a/arch/arm/boot/dts/lan966x-pcb8309.dts
+++ b/arch/arm/boot/dts/lan966x-pcb8309.dts
@@ -97,6 +97,10 @@ sfp3: sfp3 {
 	};
 };
 
+&aes {
+	status = "disabled"; /* Reserved by secure OS */
+};
+
 &flx3 {
 	atmel,flexcom-mode = <ATMEL_FLEXCOM_MODE_USART>;
 	status = "okay";
-- 
2.33.0


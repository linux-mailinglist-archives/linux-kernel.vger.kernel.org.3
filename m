Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EAC248DA12
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 15:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235810AbiAMOsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 09:48:23 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:31616 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235842AbiAMOsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 09:48:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1642085298; x=1673621298;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e/cwdosIfY/Ui806k1VNdWFJdNXS6zlz9aSSIH3faKE=;
  b=GLIh9KgRuduoXDG5kSXfyQacrvAO6XI0UVXb37MArRQIxK+bbYdIckIO
   f1kkq+8otZ5hkkzSVL+jtLRKFK3f3aokXOPrKdv9C36UwOLiNhuxNebqa
   xP/aLOfV2N6aJWILDoUwi2O9zF1ptn97rFPOv0aUonnWD+OMSpLnw8Ant
   GHtWLXZl8eTcLRJNuGJfFHVqsbXu/1lvtO/czarPhMtJ7a+S6yzYQL4fj
   zNFlQI9QGzFnCmVUj6O9JMP3/sYReeN5OAbn41cLsgDHyjRUYHoP5gw3+
   rtT1Qyz+5ecrVF7MwcV/LmUUtCwNLTX1Dt2SNS4aYSaO3EtIa7lFYFSl9
   w==;
IronPort-SDR: 47nOygoVvRVtF5FQl/YUZhdAz+JeUn+1Tlh7BvNuUto9F4AOlwiUM+KrJQaoBfqa4+77IyFnyC
 /t4vuFslxy25BY0cLcxlyln5wiCXwZWNahaIIKr0eFLjKsSNfim+tlSda4BdsZIwI/a7BJg+C7
 Va4CorZvCgUgu/ziugvXJJJW4C7/siVs6DUMjVlcexUAxq3oQH6gYSnWPWiT0GnzYqnxvtWMqX
 psjIe8qUN+lAsH9vN1QsCfrFXEBwM/07PPFhBuw9C9bmGAPgE/LLG+VnwFiYojOmL5bpQ+v96h
 FRXGKPoG97pl7EbpDm565hWb
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="158557547"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jan 2022 07:48:17 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 13 Jan 2022 07:48:17 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 13 Jan 2022 07:48:14 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>, <sboyd@kernel.org>,
        <mturquette@baylibre.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 07/10] ARM: dts: at91: sama7g5ek: set regulator voltages for standby state
Date:   Thu, 13 Jan 2022 16:48:57 +0200
Message-ID: <20220113144900.906370-8-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220113144900.906370-1-claudiu.beznea@microchip.com>
References: <20220113144900.906370-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set regulator voltages for standby state to avoid wrong behavior of
system while in standby. The CPU voltage has been chosen as being the
one corresponding to OPP=600MHz. Next commit will set the 600MHz OPP
as the suspend OPP.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/boot/dts/at91-sama7g5ek.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama7g5ek.dts b/arch/arm/boot/dts/at91-sama7g5ek.dts
index 50f0fc3064cc..e48da0a053ec 100644
--- a/arch/arm/boot/dts/at91-sama7g5ek.dts
+++ b/arch/arm/boot/dts/at91-sama7g5ek.dts
@@ -185,6 +185,7 @@ vdd_3v3: VDD_IO {
 
 					regulator-state-standby {
 						regulator-on-in-suspend;
+						regulator-suspend-microvolt = <3300000>;
 						regulator-mode = <4>;
 					};
 
@@ -225,6 +226,7 @@ vddcore: VDD_CORE {
 
 					regulator-state-standby {
 						regulator-on-in-suspend;
+						regulator-suspend-voltage = <1150000>;
 						regulator-mode = <4>;
 					};
 
@@ -245,6 +247,7 @@ vddcpu: VDD_OTHER {
 
 					regulator-state-standby {
 						regulator-on-in-suspend;
+						regulator-suspend-voltage = <1050000>;
 						regulator-mode = <4>;
 					};
 
@@ -261,6 +264,7 @@ vldo1: LDO1 {
 					regulator-always-on;
 
 					regulator-state-standby {
+						regulator-suspend-voltage = <1800000>;
 						regulator-on-in-suspend;
 					};
 
@@ -275,6 +279,7 @@ vldo2: LDO2 {
 					regulator-max-microvolt = <3700000>;
 
 					regulator-state-standby {
+						regulator-suspend-voltage = <1800000>;
 						regulator-on-in-suspend;
 					};
 
-- 
2.32.0


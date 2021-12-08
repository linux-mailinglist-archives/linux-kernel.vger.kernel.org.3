Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B04F646D11D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 11:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbhLHKhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 05:37:20 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:39136 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231731AbhLHKhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 05:37:15 -0500
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1B89pLPd009148;
        Wed, 8 Dec 2021 11:33:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=GYxfSXf9w2NFMXCcNiHGT9pdbGEG14Y73aVi9O0OxeE=;
 b=hY8fbsDBOl4Iw05EG5pauOT8JyP923N05oSoyYtjPo4/IFQsYh9i4QfchGwRdkReP2wb
 eI55cXor4qc+hUVraf98ieLpok0jXcOvuVxYQnTI1WR68l95m6XQcIKGQs09GWqrX/Se
 JGCBYx+C3DvLjUESL6HEqTle5LrgUXteFdNBcBxnzI61q6wBpGa2XOsaH8W6VPPz1aD7
 dzb157XIqJgPzue8D2vR2SxtZRbum0iHFS7bnae1L68n2KfxXETzfSErusZzVoNd1YLr
 YvfbTkZokTP7Wa6P/PBFfWJGTT1s0qsj+cAzq79WU6epetXeprgkmSTwNQd8VcHl1Vjm cg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ct9xm4emc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Dec 2021 11:33:26 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B64D510002A;
        Wed,  8 Dec 2021 11:33:25 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id ADAFA23153B;
        Wed,  8 Dec 2021 11:33:25 +0100 (CET)
Received: from localhost (10.75.127.50) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Wed, 8 Dec 2021 11:33:25
 +0100
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To:     <alexandre.torgue@foss.st.com>, <robh+dt@kernel.org>
CC:     <olivier.moysan@foss.st.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <fabrice.gasnier@foss.st.com>
Subject: [PATCH 2/2] ARM: dts: stm32: remove timer5 duplicate unit-address on stm32f4 series
Date:   Wed, 8 Dec 2021 11:33:16 +0100
Message-ID: <1638959596-6656-3-git-send-email-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1638959596-6656-1-git-send-email-fabrice.gasnier@foss.st.com>
References: <1638959596-6656-1-git-send-email-fabrice.gasnier@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-08_03,2021-12-08_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the following warnings seen when building with W=1.
Warning (unique_unit_address): /soc/timer@40000c00: duplicate unit-address
(also used in node /soc/timers@40000c00)
This approach is based on some discussions[1], to restructure the dtsi
and dts files.

Timer5 is enabled by default on stm32f4 series, to act as clockevent. In
order to get rid of the W=1 warning, and be compliant with dt-schemas
(e.g. dtbs_check):
- In stm32f429.dtsi:
  . Keep the more complete timers5 description
  . Remove the most simple timer5 node that is duplicate
- In each board:
  . adopt "st,stm32-timer" compatible for timers5, also add the interrupt
  . use /delete-property/ and /delete-node/ so the it matches the
    clockevent bindings

Note: all this is done in one shot (e.g. not split) to keep clockevent
functionality.

[1] https://lore.kernel.org/linux-arm-kernel/Yaf4jiZIp8+ndaXs@robh.at.kernel.org/

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 arch/arm/boot/dts/stm32429i-eval.dts  | 12 ++++++++++++
 arch/arm/boot/dts/stm32f429-disco.dts | 12 ++++++++++++
 arch/arm/boot/dts/stm32f429.dtsi      |  7 -------
 arch/arm/boot/dts/stm32f469-disco.dts | 12 ++++++++++++
 4 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/stm32429i-eval.dts b/arch/arm/boot/dts/stm32429i-eval.dts
index cb46326..0d98aca 100644
--- a/arch/arm/boot/dts/stm32429i-eval.dts
+++ b/arch/arm/boot/dts/stm32429i-eval.dts
@@ -308,6 +308,18 @@
 	};
 };
 
+&timers5 {
+	/* Override timer5 to act as clockevent */
+	compatible = "st,stm32-timer";
+	interrupts = <50>;
+	status = "okay";
+	/delete-property/#address-cells;
+	/delete-property/#size-cells;
+	/delete-property/clock-names;
+	/delete-node/pwm;
+	/delete-node/timer@4;
+};
+
 &usart1 {
 	pinctrl-0 = <&usart1_pins_a>;
 	pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/stm32f429-disco.dts b/arch/arm/boot/dts/stm32f429-disco.dts
index 075ac57..06a7091 100644
--- a/arch/arm/boot/dts/stm32f429-disco.dts
+++ b/arch/arm/boot/dts/stm32f429-disco.dts
@@ -205,6 +205,18 @@
 	};
 };
 
+&timers5 {
+	/* Override timer5 to act as clockevent */
+	compatible = "st,stm32-timer";
+	interrupts = <50>;
+	status = "okay";
+	/delete-property/#address-cells;
+	/delete-property/#size-cells;
+	/delete-property/clock-names;
+	/delete-node/pwm;
+	/delete-node/timer@4;
+};
+
 &usart1 {
 	pinctrl-0 = <&usart1_pins_a>;
 	pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index f21b322..1723346 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -159,13 +159,6 @@
 			};
 		};
 
-		timer5: timer@40000c00 {
-			compatible = "st,stm32-timer";
-			reg = <0x40000c00 0x400>;
-			interrupts = <50>;
-			clocks = <&rcc 0 STM32F4_APB1_CLOCK(TIM5)>;
-		};
-
 		timers5: timers@40000c00 {
 			#address-cells = <1>;
 			#size-cells = <0>;
diff --git a/arch/arm/boot/dts/stm32f469-disco.dts b/arch/arm/boot/dts/stm32f469-disco.dts
index 30905ce6..cac3a67 100644
--- a/arch/arm/boot/dts/stm32f469-disco.dts
+++ b/arch/arm/boot/dts/stm32f469-disco.dts
@@ -224,6 +224,18 @@
 	bus-width = <4>;
 };
 
+&timers5 {
+	/* Override timer5 to act as clockevent */
+	compatible = "st,stm32-timer";
+	interrupts = <50>;
+	status = "okay";
+	/delete-property/#address-cells;
+	/delete-property/#size-cells;
+	/delete-property/clock-names;
+	/delete-node/pwm;
+	/delete-node/timer@4;
+};
+
 &usart3 {
 	pinctrl-0 = <&usart3_pins_a>;
 	pinctrl-names = "default";
-- 
2.7.4


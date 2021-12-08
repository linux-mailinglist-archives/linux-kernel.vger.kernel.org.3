Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 902DC46D11C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 11:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbhLHKhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 05:37:17 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:39130 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231649AbhLHKhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 05:37:14 -0500
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1B89r4ks009074;
        Wed, 8 Dec 2021 11:33:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=H3TcVOyVa6tibmHw7zCu0Y8pMukbPefxkaSsOCbZmpw=;
 b=8Iez6TpdmsUygDK0uzLMGx6/IgZzaRjfJWm5RvxouQmwQPSnwLdbfoWDZZL2lbJqaL68
 UAKdcGdR1Zt58BDiuwwr2rYSbDq+9vtst68SQKOmYgnMvooxRYjzWC0sQ3IaiO7lr+qh
 gM0I9BDL9Z9TfH/ed5RsBuiTUfu7KEY1IUK2zl1ET4B5/qkRch/H/tqkY5MRCGv9utDQ
 ci0bNrGB80RPjlbr6sG6tgs8TqaV8qWgKyWCgKsa6odSE+icma/y1Km58Iqx0MKKU/ER
 te9TDnAmRZUzE5tmUvktnPrcqmeseXwlWfH3K2dnx9qHw7jvOyanaQFV1yVF3MYD8XKO dg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ct9xm4ema-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Dec 2021 11:33:25 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8E9FE100034;
        Wed,  8 Dec 2021 11:33:24 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 86B2523153B;
        Wed,  8 Dec 2021 11:33:24 +0100 (CET)
Received: from localhost (10.75.127.50) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Wed, 8 Dec 2021 11:33:24
 +0100
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To:     <alexandre.torgue@foss.st.com>, <robh+dt@kernel.org>
CC:     <olivier.moysan@foss.st.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <fabrice.gasnier@foss.st.com>
Subject: [PATCH 1/2] ARM: dts: stm32: remove some timer duplicate unit-address on stm32f4 series
Date:   Wed, 8 Dec 2021 11:33:15 +0100
Message-ID: <1638959596-6656-2-git-send-email-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1638959596-6656-1-git-send-email-fabrice.gasnier@foss.st.com>
References: <1638959596-6656-1-git-send-email-fabrice.gasnier@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-08_03,2021-12-08_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several unused "timer" are duplicate nodes of "timers" nodes.
There are two dt-schemas:
- timer/st,stm32-timer.yaml: A timer is needed on STM32F4 series, on all
  boards, to act as clockevent.
- mfd/st,stm32-timers.yaml: Timers can be used for other purpose.

By default, timer5 is left enabled to be used as clockevent. Remove all
other timer clockevent nodes that are currently unused and duplicated.

This removes several messages: Warning (unique_unit_address): /soc/timer@..
duplicate unit-address (also used in node /soc/timers@...)

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 arch/arm/boot/dts/stm32f429.dtsi | 40 ----------------------------------------
 1 file changed, 40 deletions(-)

diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index 8748d58..f21b322 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -93,14 +93,6 @@
 			};
 		};
 
-		timer2: timer@40000000 {
-			compatible = "st,stm32-timer";
-			reg = <0x40000000 0x400>;
-			interrupts = <28>;
-			clocks = <&rcc 0 STM32F4_APB1_CLOCK(TIM2)>;
-			status = "disabled";
-		};
-
 		timers2: timers@40000000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -123,14 +115,6 @@
 			};
 		};
 
-		timer3: timer@40000400 {
-			compatible = "st,stm32-timer";
-			reg = <0x40000400 0x400>;
-			interrupts = <29>;
-			clocks = <&rcc 0 STM32F4_APB1_CLOCK(TIM3)>;
-			status = "disabled";
-		};
-
 		timers3: timers@40000400 {
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -153,14 +137,6 @@
 			};
 		};
 
-		timer4: timer@40000800 {
-			compatible = "st,stm32-timer";
-			reg = <0x40000800 0x400>;
-			interrupts = <30>;
-			clocks = <&rcc 0 STM32F4_APB1_CLOCK(TIM4)>;
-			status = "disabled";
-		};
-
 		timers4: timers@40000800 {
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -212,14 +188,6 @@
 			};
 		};
 
-		timer6: timer@40001000 {
-			compatible = "st,stm32-timer";
-			reg = <0x40001000 0x400>;
-			interrupts = <54>;
-			clocks = <&rcc 0 STM32F4_APB1_CLOCK(TIM6)>;
-			status = "disabled";
-		};
-
 		timers6: timers@40001000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -236,14 +204,6 @@
 			};
 		};
 
-		timer7: timer@40001400 {
-			compatible = "st,stm32-timer";
-			reg = <0x40001400 0x400>;
-			interrupts = <55>;
-			clocks = <&rcc 0 STM32F4_APB1_CLOCK(TIM7)>;
-			status = "disabled";
-		};
-
 		timers7: timers@40001400 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
2.7.4


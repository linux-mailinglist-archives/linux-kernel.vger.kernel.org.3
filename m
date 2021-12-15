Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B65CE47571E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 11:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241893AbhLOK7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 05:59:32 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:58548 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S241841AbhLOK7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 05:59:14 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BFApqsw009716;
        Wed, 15 Dec 2021 11:58:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=j3ZAzLhBf1EAY2batIvV+2YWdz8loTLk56MME0Z1fhE=;
 b=MC8gqmtlYbJFBLtJXVHIP7KljPAF9xs0KlKc1aC2jmQGVba6TWuqAtptjiTDn6zLTFNC
 rKE/yrRINbqKlCs6iTXb+bL3rL17QbV8H/IjIRS0B4kkNyHbJK5Rrn0NjujUTSCkCU01
 YL31i5kl5K9avKUwsFqgC4TXTPPJrzhUuqP0ClhGXgOog8tr+21LIKmP9Vq9go++uXgx
 TIuB3Ar9vUsLIxGEKysqoPMNEaGeacOyPTmXwWBvSEfhlWYWsMj5hZtadECBDzCU8qds
 t/5v3LTy5dzvcyxokrG61KxTRg7zoA6Gvv0LAvV5wEA0+zKs7+Zz12Z7QUcYHhfh3rSo CQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3cyasn9w6q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Dec 2021 11:58:55 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4AA7F10002A;
        Wed, 15 Dec 2021 11:58:55 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 42552235F6C;
        Wed, 15 Dec 2021 11:58:55 +0100 (CET)
Received: from localhost (10.75.127.50) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Wed, 15 Dec 2021 11:58:54
 +0100
From:   Alexandre Torgue <alexandre.torgue@foss.st.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>, <alexandre.torgue@foss.st.com>
Subject: [PATCH v2 5/5] ARM: dts: stm32: Enable EXTI on stm32mp13
Date:   Wed, 15 Dec 2021 11:58:47 +0100
Message-ID: <20211215105847.2328-6-alexandre.torgue@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211215105847.2328-1-alexandre.torgue@foss.st.com>
References: <20211215105847.2328-1-alexandre.torgue@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-15_08,2021-12-14_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable EXTI hardware peripheral for STM32MP13 SoC and define EXTI/GIC
mapping.

Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>

diff --git a/arch/arm/boot/dts/stm32mp131.dtsi b/arch/arm/boot/dts/stm32mp131.dtsi
index 86126dc0d898..5bd384295619 100644
--- a/arch/arm/boot/dts/stm32mp131.dtsi
+++ b/arch/arm/boot/dts/stm32mp131.dtsi
@@ -4,6 +4,7 @@
  * Author: Alexandre Torgue <alexandre.torgue@foss.st.com> for STMicroelectronics.
  */
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/interrupt-controller/stm32-exti.h>
 
 / {
 	#address-cells = <1>;
@@ -115,6 +116,52 @@
 			status = "disabled";
 		};
 
+		exti: interrupt-controller@5000d000 {
+			compatible = "st,stm32mp13-exti", "syscon";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			reg = <0x5000d000 0x400>;
+			st,exti-mapping = <0 6 STM32_EXTI_TYPE_CONFIGURABLE>,
+					  <1 7 STM32_EXTI_TYPE_CONFIGURABLE>,
+					  <2 8 STM32_EXTI_TYPE_CONFIGURABLE>,
+					  <3 9 STM32_EXTI_TYPE_CONFIGURABLE>,
+					  <4 10 STM32_EXTI_TYPE_CONFIGURABLE>,
+					  <5 24 STM32_EXTI_TYPE_CONFIGURABLE>,
+					  <6 65 STM32_EXTI_TYPE_CONFIGURABLE>,
+					  <7 66 STM32_EXTI_TYPE_CONFIGURABLE>,
+					  <8 67 STM32_EXTI_TYPE_CONFIGURABLE>,
+					  <9 68 STM32_EXTI_TYPE_CONFIGURABLE>,
+					  <10 41 STM32_EXTI_TYPE_CONFIGURABLE>,
+					  <11 43 STM32_EXTI_TYPE_CONFIGURABLE>,
+					  <12 77 STM32_EXTI_TYPE_CONFIGURABLE>,
+					  <13 78 STM32_EXTI_TYPE_CONFIGURABLE>,
+					  <14 106 STM32_EXTI_TYPE_CONFIGURABLE>,
+					  <15 109 STM32_EXTI_TYPE_CONFIGURABLE>,
+					  <16 1 STM32_EXTI_TYPE_CONFIGURABLE>,
+					  <19 3 STM32_EXTI_TYPE_DIRECT>,
+					  <21 32 STM32_EXTI_TYPE_DIRECT>,
+					  <22 34 STM32_EXTI_TYPE_DIRECT>,
+					  <23 73 STM32_EXTI_TYPE_DIRECT>,
+					  <24 93 STM32_EXTI_TYPE_DIRECT>,
+					  <25 114 STM32_EXTI_TYPE_DIRECT>,
+					  <26 38 STM32_EXTI_TYPE_DIRECT>,
+					  <27 39 STM32_EXTI_TYPE_DIRECT>,
+					  <28 40 STM32_EXTI_TYPE_DIRECT>,
+					  <29 72 STM32_EXTI_TYPE_DIRECT>,
+					  <30 53 STM32_EXTI_TYPE_DIRECT>,
+					  <31 54 STM32_EXTI_TYPE_DIRECT>,
+					  <32 83 STM32_EXTI_TYPE_DIRECT>,
+					  <33 84 STM32_EXTI_TYPE_DIRECT>,
+					  <44 96 STM32_EXTI_TYPE_DIRECT>,
+					  <47 92 STM32_EXTI_TYPE_DIRECT>,
+					  <48 116 STM32_EXTI_TYPE_DIRECT>,
+					  <50 117 STM32_EXTI_TYPE_DIRECT>,
+					  <52 118 STM32_EXTI_TYPE_DIRECT>,
+					  <53 119 STM32_EXTI_TYPE_DIRECT>,
+					  <68 63 STM32_EXTI_TYPE_DIRECT>,
+					  <70 98 STM32_EXTI_TYPE_DIRECT>;
+		};
+
 		syscfg: syscon@50020000 {
 			compatible = "st,stm32mp157-syscfg", "syscon";
 			reg = <0x50020000 0x400>;
-- 
2.17.1


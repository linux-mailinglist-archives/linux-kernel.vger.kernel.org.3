Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0392446D403
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 14:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234061AbhLHNJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 08:09:35 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:46234 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234046AbhLHNJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 08:09:34 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1B8AiVdf015791;
        Wed, 8 Dec 2021 14:05:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=cw1DiUl+cmSeVn5VJkuxtdZdJC0tAEkYjpjF2pN7R2c=;
 b=WH+qJuNoHiEYfEWmqlbKY8C8Okpt9iirf2QFRqeUXgehx6QYgEbB50qVlvaX1sBW0dO8
 CvKg1K4Uohavkt4rajlXi3FfMCe57DZpwPUSQskfIubB+iHidcOMOUzhwfgNrVc3bBvq
 gtUTDkcEsQMZITYQCgfJTlA0GZSVM7SEbdKmSuuxHaQWZe/i/nyJq9PQ3dRhG41aUgUX
 uFoiJ3Q2Ly4JfQfqqUXjwduVoqzkikcM77THH7aJfjc7J1rseVBS9thf/ncbA4iB3a9e
 h1TuXxoAZr0q25P2B/e2PMxzo1LuhJmMT15f6OlLGREsU1kedlWA3sQXcugFE07dVJXd /w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ctmsrjse3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Dec 2021 14:05:54 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 75D6E100034;
        Wed,  8 Dec 2021 14:05:54 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6E7832A4D60;
        Wed,  8 Dec 2021 14:05:54 +0100 (CET)
Received: from localhost (10.75.127.44) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Wed, 8 Dec 2021 14:05:54
 +0100
From:   Alexandre Torgue <alexandre.torgue@foss.st.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>, <alexandre.torgue@foss.st.com>
Subject: [PATCH 3/3] ARM: dts: stm32: Enable EXTI on stm32mp13
Date:   Wed, 8 Dec 2021 14:04:56 +0100
Message-ID: <20211208130456.4002-4-alexandre.torgue@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211208130456.4002-1-alexandre.torgue@foss.st.com>
References: <20211208130456.4002-1-alexandre.torgue@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-08_04,2021-12-08_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As EXTI/GIC mapping has changed between STM32MP15 and STM32MP13, a
a new compatible is needed to choose mp13 mapping table in stm32-exti
driver.

Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>

diff --git a/arch/arm/boot/dts/stm32mp131.dtsi b/arch/arm/boot/dts/stm32mp131.dtsi
index 86126dc0d898..c249dbe64354 100644
--- a/arch/arm/boot/dts/stm32mp131.dtsi
+++ b/arch/arm/boot/dts/stm32mp131.dtsi
@@ -115,6 +115,13 @@
 			status = "disabled";
 		};
 
+		exti: interrupt-controller@5000d000 {
+			compatible = "st,stm32mp13-exti", "syscon";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			reg = <0x5000d000 0x400>;
+		};
+
 		syscfg: syscon@50020000 {
 			compatible = "st,stm32mp157-syscfg", "syscon";
 			reg = <0x50020000 0x400>;
-- 
2.17.1


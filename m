Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1CCA4A899C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 18:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352649AbiBCROB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 12:14:01 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:38614 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234879AbiBCRNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 12:13:45 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 213FMOIw012501;
        Thu, 3 Feb 2022 18:11:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=UTkprxisJWsqd23FUufeD5FoNRrfxXnwczcHgcSW+4I=;
 b=NbtYLmYqiFHhJhnTV6WuuZsuVF9cSnPqjMVd8PfzbxXdLwMWZQi3eYrOy1bKYxz4kCZU
 pcWzcjiCuLgJmuS12mdb3TVfg61qvFNSOKuWC2Du3x+rJliL/XdSCwEGK5EVjEKkqQfH
 mmQzdKrLO72GLFuKR+M/67zzPSDmX/qtUGnX2eGS9v5NRRZlQW1EXJzFH9AIXtv/nLa0
 OrwAzFZx54p7bu+tGZYzLmTId+9CS/t1MnMS8hOxT8hZcC0gyuOFhkFSa82heSAQTsOA
 t1OVllts2SUtsRTvxLvw7XbFQuAq18gqo3UtShUaemnQV7cF5rLruc06imebxPod/1Yp hA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3e0c4fjdb5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Feb 2022 18:11:20 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E457910002A;
        Thu,  3 Feb 2022 18:11:18 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D9CEF22F7A5;
        Thu,  3 Feb 2022 18:11:18 +0100 (CET)
Received: from localhost (10.75.127.46) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Thu, 3 Feb 2022 18:11:18
 +0100
From:   Erwan Le Ray <erwan.leray@foss.st.com>
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Erwan Le Ray <erwan.leray@foss.st.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Marek Vasut <marex@denx.de>,
        Marcin Sloniewski <marcin.sloniewski@gmail.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 01/16] ARM: dts: stm32: add DMA configuration to UART nodes on stm32mp151
Date:   Thu, 3 Feb 2022 18:10:59 +0100
Message-ID: <20220203171114.10888-2-erwan.leray@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220203171114.10888-1-erwan.leray@foss.st.com>
References: <20220203171114.10888-1-erwan.leray@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-03_06,2022-02-03_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DMA configuration in stm32mp15x uart nodes by selecting dma direct
mode and alternate REQ/ACK dma protocol for uart.

DMA direct mode allows to bypass DMA FIFO. Each DMA request immediately
initiates a transfer from/to the memory. This allows USART to get data
transferred, even when the transfer ends before the DMA FIFO completion.

Default REQ/ACK DMA protocol consists in maintaining ACK signal up to the
removal of REQuest and the transfer completion.
In case of alternative REQ/ACK protocol, ACK de-assertion does not wait the
removal of the REQuest, but only the transfer completion.
Due to a possible DMA stream lock when transferring data to/from STM32
USART/UART, select this alternative protocol in STM32 USART/UART nodes.

Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
Signed-off-by: Erwan Le Ray <erwan.leray@foss.st.com>

diff --git a/arch/arm/boot/dts/stm32mp151.dtsi b/arch/arm/boot/dts/stm32mp151.dtsi
index 1cfc2f011e70..e86006ae137b 100644
--- a/arch/arm/boot/dts/stm32mp151.dtsi
+++ b/arch/arm/boot/dts/stm32mp151.dtsi
@@ -455,6 +455,9 @@
 			interrupts-extended = <&exti 27 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&rcc USART2_K>;
 			wakeup-source;
+			dmas = <&dmamux1 43 0x400 0x15>,
+			       <&dmamux1 44 0x400 0x11>;
+			dma-names = "rx", "tx";
 			status = "disabled";
 		};
 
@@ -464,6 +467,9 @@
 			interrupts-extended = <&exti 28 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&rcc USART3_K>;
 			wakeup-source;
+			dmas = <&dmamux1 45 0x400 0x15>,
+			       <&dmamux1 46 0x400 0x11>;
+			dma-names = "rx", "tx";
 			status = "disabled";
 		};
 
@@ -473,6 +479,9 @@
 			interrupts-extended = <&exti 30 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&rcc UART4_K>;
 			wakeup-source;
+			dmas = <&dmamux1 63 0x400 0x15>,
+			       <&dmamux1 64 0x400 0x11>;
+			dma-names = "rx", "tx";
 			status = "disabled";
 		};
 
@@ -482,6 +491,9 @@
 			interrupts-extended = <&exti 31 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&rcc UART5_K>;
 			wakeup-source;
+			dmas = <&dmamux1 65 0x400 0x15>,
+			       <&dmamux1 66 0x400 0x11>;
+			dma-names = "rx", "tx";
 			status = "disabled";
 		};
 
@@ -588,6 +600,9 @@
 			interrupts-extended = <&exti 32 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&rcc UART7_K>;
 			wakeup-source;
+			dmas = <&dmamux1 79 0x400 0x15>,
+			       <&dmamux1 80 0x400 0x11>;
+			dma-names = "rx", "tx";
 			status = "disabled";
 		};
 
@@ -597,6 +612,9 @@
 			interrupts-extended = <&exti 33 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&rcc UART8_K>;
 			wakeup-source;
+			dmas = <&dmamux1 81 0x400 0x15>,
+			       <&dmamux1 82 0x400 0x11>;
+			dma-names = "rx", "tx";
 			status = "disabled";
 		};
 
@@ -678,6 +696,9 @@
 			interrupts-extended = <&exti 29 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&rcc USART6_K>;
 			wakeup-source;
+			dmas = <&dmamux1 71 0x400 0x15>,
+			       <&dmamux1 72 0x400 0x11>;
+			dma-names = "rx", "tx";
 			status = "disabled";
 		};
 
-- 
2.17.1


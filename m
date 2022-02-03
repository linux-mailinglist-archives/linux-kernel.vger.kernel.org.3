Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77D0B4A89A5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 18:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234241AbiBCROs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 12:14:48 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:38764 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345638AbiBCROm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 12:14:42 -0500
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 213CnO8A018984;
        Thu, 3 Feb 2022 18:12:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=2sZLxyCD5lAto7vxWxhclkGBHF7PAF6c6sys6XINk7M=;
 b=7RVOrKvgKwfpVqN7YAB7SGeccdB7EgDPm/UsXkfuFbQUCnPXDojqBp14lTDmI3fw1nu9
 EiYN82S9s0H42dI5x9bPvXjDkMFY/VQKpU7zMHnnxqPjeCeB4y/Stp/dYstWS5FZyE3K
 QQEh0yWLD0QHqT1WTYyS4lBX0nanWzMBV/moV5lr66T5v5/armXF8VSFs91WUYAg2Y/U
 NgM3vs2baXwSIh0dR2TwYAN//YM2SsV2rM9AV3WJv4YStzevFJqtQguCyGHmKUi5Dr0y
 E2Q9i6ZZsERRoYz7WS4Zndj6WT4uohmiSXUNrmDdJlWA0201VIARveN7MnZwqiTE/f+t HA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3dyrujqp6v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Feb 2022 18:12:22 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2E769100038;
        Thu,  3 Feb 2022 18:12:22 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2676722F7A5;
        Thu,  3 Feb 2022 18:12:22 +0100 (CET)
Received: from localhost (10.75.127.45) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Thu, 3 Feb 2022 18:12:21
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
Subject: [PATCH 07/16] ARM: dts: stm32: keep uart nodes behavior on stm32mp1-microdev2.0-of7
Date:   Thu, 3 Feb 2022 18:11:05 +0100
Message-ID: <20220203171114.10888-8-erwan.leray@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220203171114.10888-1-erwan.leray@foss.st.com>
References: <20220203171114.10888-1-erwan.leray@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-03_06,2022-02-03_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DMA configuration is added to uart nodes in stm32mp15x device tree.
Delete uart4 DMA property in stm32mp1-microdev2.0-of7 board device tree
to keep console in irq mode, as DMA support for console has been
removed from the driver by commit e359b4411c28 ("serial: stm32: fix
threaded interrupt handling").
Delete also uart8 DMA property to keep current behavior.

Signed-off-by: Erwan Le Ray <erwan.leray@foss.st.com>

diff --git a/arch/arm/boot/dts/stm32mp157a-microgea-stm32mp1-microdev2.0-of7.dts b/arch/arm/boot/dts/stm32mp157a-microgea-stm32mp1-microdev2.0-of7.dts
index 5670b23812a2..fae656edd820 100644
--- a/arch/arm/boot/dts/stm32mp157a-microgea-stm32mp1-microdev2.0-of7.dts
+++ b/arch/arm/boot/dts/stm32mp157a-microgea-stm32mp1-microdev2.0-of7.dts
@@ -143,6 +143,8 @@
 	pinctrl-0 = <&uart4_pins_a>;
 	pinctrl-1 = <&uart4_sleep_pins_a>;
 	pinctrl-2 = <&uart4_idle_pins_a>;
+	/delete-property/dmas;
+	/delete-property/dma-names;
 	status = "okay";
 };
 
@@ -150,5 +152,7 @@
 &uart8 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart8_pins_a>;
+	/delete-property/dmas;
+	/delete-property/dma-names;
 	status = "okay";
 };
-- 
2.17.1


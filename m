Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3984A89A7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 18:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352669AbiBCROx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 12:14:53 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:38774 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243494AbiBCROm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 12:14:42 -0500
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 213CYRm3018990;
        Thu, 3 Feb 2022 18:12:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=1oYTCCYWoMZcyKG0EAf770Af5ZIA1F2dlhPaExYlozA=;
 b=woZ3fy8EeOZYChjKO8j8/upNa40LKvydMYyGTZXn1t20P6w2q7fuPMqcj9YuoQPfXlVc
 MRD/fsXkVYJNUEeMQOcSpruFrn1gc478j2uYTIwZAzrqS3G0zynSy7263ZOUBt4RASsc
 0IB+0d4Jz1Az8y+V8aP9Iucjf6XabitK7HUS+ABJ/tLyf2mMtVSRdgmFieM74DnKwTs6
 IQKExeM31CamKua7zye6okFSBwYAXlA+AC7ZTKlcJLi/I+/AS+OYHxLS148vt2ZdYSF6
 tvj4UjSIg9GTlCIqbiaCslO94r+0ugnsrlEHgZHgaExx0eu+re1Nfx9vGixiWG9nPjJa CQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3dyrujqp6u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Feb 2022 18:12:22 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 95780100034;
        Thu,  3 Feb 2022 18:12:21 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8CF8122F7A5;
        Thu,  3 Feb 2022 18:12:21 +0100 (CET)
Received: from localhost (10.75.127.44) by SFHDAG2NODE2.st.com (10.75.127.5)
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
Subject: [PATCH 06/16] ARM: dts: stm32: keep uart4 behavior on stm32mp157a-iot-box
Date:   Thu, 3 Feb 2022 18:11:04 +0100
Message-ID: <20220203171114.10888-7-erwan.leray@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220203171114.10888-1-erwan.leray@foss.st.com>
References: <20220203171114.10888-1-erwan.leray@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-03_06,2022-02-03_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DMA configuration is added to uart nodes in stm32mp15x device tree.
Delete uart4 DMA property in stm32mp157a-iot-box board device tree to
keep console in irq mode, as DMA support for console has been removed
from the driver by commit e359b4411c28 ("serial: stm32: fix threaded
interrupt handling").

Signed-off-by: Erwan Le Ray <erwan.leray@foss.st.com>

diff --git a/arch/arm/boot/dts/stm32mp157a-iot-box.dts b/arch/arm/boot/dts/stm32mp157a-iot-box.dts
index 70f394b4d3c0..6a5a4af25bd9 100644
--- a/arch/arm/boot/dts/stm32mp157a-iot-box.dts
+++ b/arch/arm/boot/dts/stm32mp157a-iot-box.dts
@@ -58,6 +58,8 @@
 	/delete-property/st,hw-flow-ctrl;
 	cts-gpios = <&gpioa 15 GPIO_ACTIVE_LOW>;
 	rts-gpios = <&gpiob 0 GPIO_ACTIVE_LOW>;
+	/delete-property/dmas;
+	/delete-property/dma-names;
 	status = "okay";
 
 	bluetooth {
-- 
2.17.1


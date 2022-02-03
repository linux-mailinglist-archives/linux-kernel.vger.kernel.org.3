Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0364A89B2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 18:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238294AbiBCRQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 12:16:07 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:41856 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1352784AbiBCRPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 12:15:38 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 213Bqnrw011979;
        Thu, 3 Feb 2022 18:13:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=cKk2cA2cmuKql7YjYE5zBV0uRlabMNQq+kXwcKiX/RM=;
 b=gBKyyK059I9uncSngLUv/+M25a1wHYalgUUWdRY5ckFx8oo6eqH4arvwLN/tbQJxTjYn
 pvPgAEpZpHj+smNiaBA6T4Ne1Y345sYLjVH+TatO0LWr5eQHGPjRTMgEoFHQ3AvgV0ug
 l4f7MnhA9zhMECCgZTX8009+mgMW8tBmz2z5+YAd7m7wolDfTIGTRTyUMLpjNUYY2fez
 95b+zuTs3nvqsXswrZM02nK6wwFR1aA3B7U9Iml05F2Hg30ZD1bXqlGD0nFuk9P8fIUv
 LPV4Rr6kSPks3nMqotP93a1cr6l6Ge5nQkgf9fdDUQjL/bFUXiVr2nDoR7kVnoX0KM+j 6Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3e0ejj9gdp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Feb 2022 18:13:24 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 57E85100038;
        Thu,  3 Feb 2022 18:13:24 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5133322F7AA;
        Thu,  3 Feb 2022 18:13:24 +0100 (CET)
Received: from localhost (10.75.127.44) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Thu, 3 Feb 2022 18:13:24
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
Subject: [PATCH 11/16] ARM: dts: stm32: keep uart4 behavior on stm32mp157c-odyssey
Date:   Thu, 3 Feb 2022 18:11:09 +0100
Message-ID: <20220203171114.10888-12-erwan.leray@foss.st.com>
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
Delete uart4 DMA property in stm32mp157c-odyssey board device tree to
keep console in irq mode, as DMA support for console has been removed
from the driver by commit e359b4411c28 ("serial: stm32: fix threaded
interrupt handling").

Signed-off-by: Erwan Le Ray <erwan.leray@foss.st.com>

diff --git a/arch/arm/boot/dts/stm32mp157c-odyssey.dts b/arch/arm/boot/dts/stm32mp157c-odyssey.dts
index 554f5d3bcdc3..ed66d25b8bf3 100644
--- a/arch/arm/boot/dts/stm32mp157c-odyssey.dts
+++ b/arch/arm/boot/dts/stm32mp157c-odyssey.dts
@@ -81,6 +81,8 @@
 &uart4 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart4_pins_a>;
+	/delete-property/dmas;
+	/delete-property/dma-names;
 	status = "okay";
 };
 
-- 
2.17.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 520474BE7A5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359175AbiBUNil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 08:38:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359150AbiBUNik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 08:38:40 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C933413E25;
        Mon, 21 Feb 2022 05:38:16 -0800 (PST)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21LD6WOQ003366;
        Mon, 21 Feb 2022 14:37:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=fWbIJ2B/E72lu792e8+JaLbz6RiW90m0aC/YdCAClyo=;
 b=yVeuEuSggNj6d8YzockA3ZhWpMhNo8m8JAnMPyBBA1tiCaCCjzQvMwpfjUtD194TDKI3
 aEBA0G+xbPPPIMsnWKkdR0QYP0H/Fq8j2cMff06Qo7iuaAcmSgg8wemrxwwbOyMSPVZd
 qcr4Qr8/IqWv1QU18Vv+yT+GsG5IpwltrWV9+y24XP2dBm3EMGznxTJzQTcozhIqierd
 9NVbamIL+CdHaL2TFPE70LCg8ScFnYajvyoAQhW3RbuaN5gTQwj7AkRejEKoXw+m+s1b
 pLba38/WCKWN9k0dFGT65AZAUWURj0131ZmfCck8sewyab0fEfXiLohIc8SRkB2JgkoQ 3g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ebsceverb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Feb 2022 14:37:55 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E48C2100034;
        Mon, 21 Feb 2022 14:37:54 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id DC187229A82;
        Mon, 21 Feb 2022 14:37:54 +0100 (CET)
Received: from localhost (10.75.127.51) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Mon, 21 Feb 2022 14:37:54
 +0100
From:   Alexandre Torgue <alexandre.torgue@foss.st.com>
To:     <arnd@arndb.de>, <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, Marek Vasut <marex@denx.de>,
        <jagan@amarulasolutions.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Marcin Sloniewski <marcin.sloniewski@gmail.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH 1/2] ARM: dts: stm32: Correct masks for GIC PPI interrupts on stm32mp13
Date:   Mon, 21 Feb 2022 14:37:49 +0100
Message-ID: <20220221133750.20297-2-alexandre.torgue@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220221133750.20297-1-alexandre.torgue@foss.st.com>
References: <20220221133750.20297-1-alexandre.torgue@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-21_07,2022-02-21_01,2021-12-02_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using GIC_CPU_MASK_SIMPLE(x), x should reflect the number of CPUs.
STM32MP13 is a single core A7.

Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>

diff --git a/arch/arm/boot/dts/stm32mp131.dtsi b/arch/arm/boot/dts/stm32mp131.dtsi
index 262de4eeb4ed..1708c79b5254 100644
--- a/arch/arm/boot/dts/stm32mp131.dtsi
+++ b/arch/arm/boot/dts/stm32mp131.dtsi
@@ -92,10 +92,10 @@
 
 	timer {
 		compatible = "arm,armv7-timer";
-		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>;
 		interrupt-parent = <&intc>;
 		always-on;
 	};
-- 
2.17.1


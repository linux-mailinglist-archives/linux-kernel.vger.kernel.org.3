Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77DA14A7298
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 15:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344755AbiBBOCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 09:02:37 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:56948 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232898AbiBBOCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 09:02:35 -0500
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 212B1GIr021509;
        Wed, 2 Feb 2022 15:00:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=5xPAtt4WoXmVjU27ytajC8iOdQFtviDt5xlwMWBzRwg=;
 b=ZIZjLG5BlqJ7+5kP1mNaP7lnF6ZevBGpJdkeMcHJ//Q7O3iSy/LIjEi9LjUl0+e8p/Uo
 LGZwf+/Pswz4Cffvxe6BFbRCYrZT6IGBKZRbVeUjtDVhG3bz9Z4sBdJ/8KgeEGPGIZoo
 FA6pUS2IJ9i4WKn4XyxzBH1vgzkID4i7pFsZgBWvsVL7pOZsqWpWS6R15HD4AEZgU63+
 mZ3v25cu8UbOQvi4gqnFW4nfLAYXbH8/vAIS6vO6SZ6IGTT/wONaj1KcctA3UWzO3AQc
 R+Am695bKN2mM/zz8MXgCRrOkNmVk5pd2cRtKHdEEygJferAus97KAEwhu974kr2HPwL 8w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3dy1xm6hq1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Feb 2022 15:00:10 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id AE08110002A;
        Wed,  2 Feb 2022 15:00:09 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9CFD121F0D0;
        Wed,  2 Feb 2022 15:00:09 +0100 (CET)
Received: from localhost (10.75.127.49) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Wed, 2 Feb 2022 15:00:08
 +0100
From:   Alexandre Torgue <alexandre.torgue@foss.st.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>, <alexandre.torgue@foss.st.com>
Subject: [PATCH v3 0/3] Add STM32MP13 EXTI support
Date:   Wed, 2 Feb 2022 15:00:02 +0100
Message-ID: <20220202140005.860-1-alexandre.torgue@foss.st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-02_06,2022-02-01_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enhance stm32-exti driver to support STM32MP13 SoC. This SoC uses the same
hardware version than STM32MP15. Only EXTI line mapping is changed and
following EXTI lines are supported: GPIO, RTC, I2C[1-5], UxART[1-8],
USBH_EHCI, USBH_OHCI, USB_OTG, LPTIM[1-5], ETH[1-2].

Changes since v2:
- back on first proposition and keep EXTI/GIC mapping inside driver.

Changes since v1:
- add possibility to define EXTI/GIC mapping in devicetree
- define STM32MP13 EXTI/GIC mapping in devicetree.

regards
Alex

Alexandre Torgue (3):
  dt-bindings: interrupt-controller: stm32-exti: document
    st,stm32mp13-exti
  irqchip/stm32-exti: add STM32MP13 support
  ARM: dts: stm32: Enable EXTI on stm32mp13

 .../interrupt-controller/st,stm32-exti.yaml   |  1 +
 arch/arm/boot/dts/stm32mp131.dtsi             |  7 +++
 drivers/irqchip/irq-stm32-exti.c              | 50 +++++++++++++++++++
 3 files changed, 58 insertions(+)

-- 
2.17.1


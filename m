Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22FA346D401
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 14:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234035AbhLHNJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 08:09:25 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:41162 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234015AbhLHNJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 08:09:23 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1B89suIU020237;
        Wed, 8 Dec 2021 14:05:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=YruwVjLhOuyRwp87HtHoBSfI756j7x4WprXuWb8kmQU=;
 b=ULNIpxXU26WqGpYwneKnj2WsdbtDWMOK+z/UR44DMk6spe0WYDyWEuw6LFiU/M79TE4s
 Z0zHnN6BfMLvTcbgyirlrDNAdX5o2wg63MPS05e8D2wrAc8+QQ8OH9xs6CkEJ7YUziOB
 PF8JnSbutOCP/rfo65VW29DEsQbs+LaeJ5gRg8gxWg6rY/cWnbo9TISFsWdV5Un9AWFI
 mzZ/AKvo3dFIaxS8bTmwsDC44Dq6BSS60GmJYvR3TKGC7SWkMQGmq3+0NVBc4XFmWrOB
 2+EjLb5sr9fLyJRPs0YgTgZuYRhRs0XxctR7ZpRfmD4n5VsWsXcNtHvgmwPD93nFniaA gA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3cttga922r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Dec 2021 14:05:32 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8D6F810002A;
        Wed,  8 Dec 2021 14:05:31 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8242B24DE9D;
        Wed,  8 Dec 2021 14:05:31 +0100 (CET)
Received: from localhost (10.75.127.47) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Wed, 8 Dec 2021 14:05:31
 +0100
From:   Alexandre Torgue <alexandre.torgue@foss.st.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>, <alexandre.torgue@foss.st.com>
Subject: [PATCH 0/3] Add STM32MP13 EXTI support
Date:   Wed, 8 Dec 2021 14:04:53 +0100
Message-ID: <20211208130456.4002-1-alexandre.torgue@foss.st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-08_04,2021-12-08_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enhance stm32-exti driver to support STM32MP13 SoC. This SoC uses the same
hardware version than STM32MP15. Only EXTI line mapping is changed and
following EXTI lines are supported: GPIO, RTC, I2C[1-5], UxART[1-8],
USBH_EHCI, USBH_OHCI, USB_OTG, LPTIM[1-5], ETH[1-2].

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


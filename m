Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9381E475715
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 11:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241853AbhLOK7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 05:59:14 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:50974 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241814AbhLOK7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 05:59:13 -0500
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BF9DkDl015351;
        Wed, 15 Dec 2021 11:58:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=iAvi2v3+PvPRmJ+PWGHzFsnMGLc/ZedxkP2Ebwxd13Y=;
 b=Bu4guHmxENB3eZAFoEle8uceQDU8Q74UYolxK9CDwIa8cw7g3X5xG6a9KJ9dzgjSeOpw
 oGjkwyruvcYO6lb/cEAcM8m9lgft//wtyXP1cUWc8eMhrEYXHJTbZtChYkFSwD0MlL5c
 9TNz0iG4HcBviQk0JF97AEUhPhhGABRB4pmp7B3AdWkCxiG3n2J0bFctkKrznxl4Uth0
 2flSs3WrPMttapiktrcirwi41hzBLCtrjXjzZzmNt1CXDQcIr3otAF5v8wZTPv/G9At2
 NjOQe6sZk7Smo4RaOq2C1fn6HGm0a8CpVG04loH/6XIFT5yfleEiXGCHKBkCN1v1Fru0 CA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3cxrthy012-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Dec 2021 11:58:53 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5862110002A;
        Wed, 15 Dec 2021 11:58:52 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4EA56235F6C;
        Wed, 15 Dec 2021 11:58:52 +0100 (CET)
Received: from localhost (10.75.127.50) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Wed, 15 Dec 2021 11:58:51
 +0100
From:   Alexandre Torgue <alexandre.torgue@foss.st.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>, <alexandre.torgue@foss.st.com>
Subject: [PATCH v2 0/5] Add STM32MP13 EXTI support
Date:   Wed, 15 Dec 2021 11:58:42 +0100
Message-ID: <20211215105847.2328-1-alexandre.torgue@foss.st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-15_08,2021-12-14_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enhance stm32-exti driver to support STM32MP13 SoC. This SoC uses the same
hardware version than STM32MP15. Only EXTI line mapping is changed and
following EXTI lines are supported: GPIO, RTC, I2C[1-5], UxART[1-8],
USBH_EHCI, USBH_OHCI, USB_OTG, LPTIM[1-5], ETH[1-2].

This series adds also the possibility to define EXTI GIC mapping through
devicetree.

Changes since v1:
- add possibility to define EXTI/GIC mapping in devicetree
- define STM32MP13 EXTI/GIC mapping in devicetree.


regards
Alex

Alexandre Torgue (5):
  dt-bindings: interrupt-controller: Update STM32 EXTI interrupt
    controller
  irqchip/stm32: use device tree to define EXTI-GIC mapping
  dt-bindings: interrupt-controller: stm32-exti: document
    st,stm32mp13-exti
  irqchip/stm32-exti: add STM32MP13 support
  ARM: dts: stm32: Enable EXTI on stm32mp13

 .../interrupt-controller/st,stm32-exti.yaml   | 12 +++
 arch/arm/boot/dts/stm32mp131.dtsi             | 47 ++++++++++
 drivers/irqchip/irq-stm32-exti.c              | 87 ++++++++++++++++---
 .../interrupt-controller/stm32-exti.h         | 10 +++
 4 files changed, 145 insertions(+), 11 deletions(-)
 create mode 100644 include/dt-bindings/interrupt-controller/stm32-exti.h

-- 
2.17.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC124A899B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 18:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352618AbiBCRN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 12:13:57 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:40708 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234749AbiBCRNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 12:13:45 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 213BqhKf011945;
        Thu, 3 Feb 2022 18:11:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=+3SMJdk/i10Ni8hFboTXLiEzVYQL+60qZcJKfQoAgCc=;
 b=EnZLGX/kzXO4QKhpFjpHI3Iw1HpOvVvYldfcPtrue7M0Aojs5VIkzoKbM6ilqPkofdBs
 IE4wkKIuFBUnIlWNNab9qDPyGQJVLBeRTuej+szjAC9559TUvn9qc7KRXjzsrYIc6zHh
 tOWvEKcdlTaZPKibX3zCyToGUnvdjnN1Bjwx9nyf8vi7epGlyk7PZag4nRd4VPKmSzuC
 C22nfLg1/eeJILL+mPUaMN/LMxU7een2KIEqzWdfGCwPWPy8vmvfyhPHudqIvbjmbtDR
 F6rbZyWX04c3axqA1U6C+LOhtDEt9vB9CpgZS9Foz9JLyG7MIdp/BQSV1SyCUOe9nO7L xw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3e0ejj9g4t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Feb 2022 18:11:20 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7FD2F100034;
        Thu,  3 Feb 2022 18:11:18 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6441F22F7A3;
        Thu,  3 Feb 2022 18:11:18 +0100 (CET)
Received: from localhost (10.75.127.47) by SFHDAG2NODE2.st.com (10.75.127.5)
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
Subject: [PATCH 00/16] STM32 configure UART nodes for DMA
Date:   Thu, 3 Feb 2022 18:10:58 +0100
Message-ID: <20220203171114.10888-1-erwan.leray@foss.st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-03_06,2022-02-03_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DMA configuration to UART nodes in stm32mp15x (SOC level) and
remove it at board level to keep current PIO behavior when needed.
For stm32-ed1 and stm32-dkx boards, UART4 (console) and UART7
(no HW flow control pin available) are kept in PIO mode, while USART3
is now configured in DMA mode.
UART4 (console UART) has to be kept in irq mode, as DMA support for
console has been removed from the driver by commit e359b4411c28 
("serial: stm32: fix threaded interrupt handling"). 

For other stm32mp15x-based boards, current configuration is kept for
all UART instances.

Erwan Le Ray (16):
  ARM: dts: stm32: add DMA configuration to UART nodes on stm32mp151
  ARM: dts: stm32: keep uart4 behavior on stm32mp157c-ed1
  ARM: dts: stm32: keep uart4 and uart7 behavior on stm32mp15xx-dkx
  ARM: dts: stm32: keep uart4 behavior on icore-stm32mp1-ctouch2
  ARM: dts: stm32: keep uart4 behavior on icore-stm32mp1-edimm2.2
  ARM: dts: stm32: keep uart4 behavior on stm32mp157a-iot-box
  ARM: dts: stm32: keep uart nodes behavior on stm32mp1-microdev2.0-of7
  ARM: dts: stm32: keep uart nodes behavior on stm32mp1-microdev2.0
  ARM: dts: stm32: keep uart nodes behavior on stm32mp157a-stinger96
  ARM: dts: stm32: keep uart4 behavior on stm32mp157c-lxa-mc1
  ARM: dts: stm32: keep uart4 behavior on stm32mp157c-odyssey
  ARM: dts: stm32: keep uart nodes behavior on stm32mp15xx-dhcom-drc02
  ARM: dts: stm32: keep uart nodes behavior on stm32mp15xx-dhcom-pdk2
  ARM: dts: stm32: keep uart nodes behavior on stm32mp15xx-dhcom-picoitx
  ARM: dts: stm32: keep uart4 behavior on stm32mp15xx-dhcom-som
  ARM: dts: stm32: keep uart nodes behavior on
    stm32mp15xx-dhcor-avenger96

 arch/arm/boot/dts/stm32mp151.dtsi             | 21 +++++++++++++++++++
 .../stm32mp157a-icore-stm32mp1-ctouch2.dts    |  2 ++
 .../stm32mp157a-icore-stm32mp1-edimm2.2.dts   |  2 ++
 arch/arm/boot/dts/stm32mp157a-iot-box.dts     |  2 ++
 ...157a-microgea-stm32mp1-microdev2.0-of7.dts |  4 ++++
 ...32mp157a-microgea-stm32mp1-microdev2.0.dts |  4 ++++
 arch/arm/boot/dts/stm32mp157a-stinger96.dtsi  |  6 ++++++
 arch/arm/boot/dts/stm32mp157c-ed1.dts         |  2 ++
 arch/arm/boot/dts/stm32mp157c-lxa-mc1.dts     |  2 ++
 arch/arm/boot/dts/stm32mp157c-odyssey.dts     |  2 ++
 .../arm/boot/dts/stm32mp15xx-dhcom-drc02.dtsi |  4 ++++
 arch/arm/boot/dts/stm32mp15xx-dhcom-pdk2.dtsi |  4 ++++
 .../boot/dts/stm32mp15xx-dhcom-picoitx.dtsi   |  4 ++++
 arch/arm/boot/dts/stm32mp15xx-dhcom-som.dtsi  |  2 ++
 .../boot/dts/stm32mp15xx-dhcor-avenger96.dtsi |  6 ++++++
 arch/arm/boot/dts/stm32mp15xx-dkx.dtsi        |  4 ++++
 16 files changed, 71 insertions(+)

-- 
2.17.1


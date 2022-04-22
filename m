Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9AF50BB60
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 17:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449247AbiDVPNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 11:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449276AbiDVPNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 11:13:14 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043C45C643;
        Fri, 22 Apr 2022 08:10:20 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23MEwj20006781;
        Fri, 22 Apr 2022 17:09:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=qntsBUku//AI5Nch4VT1ASqySX8P0QSy2neo7hBxy8E=;
 b=2SFSZCYzEbtJLWELwSD2KXAiey89kwJ7f/ow7heOep5g4+8hq2FdZIGB/xiGp4E2qNLQ
 6DL6NGAE9fBx6b4CBc62m12fLJPA3AgQYuefu47JPQqqlbxXAnEEN6PRUWrxhPmoszHD
 hEHbKVmNnQWceM6xMF0c9QFWiwEr9C988urHmOW7NDJ8aLDjaLhOdsYEywvNdnZTzfi0
 RPQIE197lV89c9FiwO5Fcg7S4fi9UXVsxQBc+ULbKQoiAHrYM5WPvU6iuJlUslwWkx6L
 itQnx8V4+jurSxdxBnavmSd1SpN3FFpRhg4RZwq3fY/zYoXtBLQW/CxqDsDJuW31ZLN6 vQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ffpqh9mcc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Apr 2022 17:09:55 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C4DEF10002A;
        Fri, 22 Apr 2022 17:09:54 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id ABAA6233C62;
        Fri, 22 Apr 2022 17:09:54 +0200 (CEST)
Received: from localhost (10.75.127.49) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Fri, 22 Apr
 2022 17:09:54 +0200
From:   Alexandre Torgue <alexandre.torgue@foss.st.com>
To:     <arnd@arndb.de>, <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>, <soc@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, Marek Vasut <marex@denx.de>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        <etienne.carriere@st.com>
Subject: [PATCH 0/8] Add SCMI version of ST boards
Date:   Fri, 22 Apr 2022 17:09:44 +0200
Message-ID: <20220422150952.20587-1-alexandre.torgue@foss.st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-22_04,2022-04-22_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The aim of this series is to add OPTEE and SCMI support for STM32 boards in
order to enable secure services for clocks and resets. New boards have been added
to enable this support in order to not break boot of current STM32 boards users. 

This series targets only boards provided by ST which are:
-STM32MP157A-DK1
-STM32MP157C-DK2
-STM32MP157C-ED1
-STM32MP157C-EV1

Some modifications in bindings files (yaml and .h) was needed and OPTEE/TEE
configs are now enabled by default for ARCH_STM32 architecture.

Note that patch [1] "dt-bindings: rcc: Add optional external ethernet RX clock
properties" done by Marek has been already merged in Rob tree.

Thanks
Alex

Alexandre Torgue (7):
  dt-bindings: clock: stm32mp1: describes clocks if
    "st,stm32mp1-rcc-secure"
  dt-bindings: clock: stm32mp15: rename CK_SCMI define
  dt-bindings: reset: stm32mp15: rename RST_SCMI define
  ARM: stm32: select OPTEE on MPU family
  ARM: dts: stm32: enable optee firmware and SCMI support on STM32MP15
  dt-bindings: arm: stm32: Add SCMI version of STM32 boards
    (DK1/DK2/ED1/EV1)
  ARM: dts: stm32: Add SCMI version of STM32 boards (DK1/DK2/ED1/EV1)

Marek Vasut (1):
  dt-bindings: rcc: Add optional external ethernet RX clock properties

 .../devicetree/bindings/arm/stm32/stm32.yaml  |  17 +++
 .../bindings/clock/st,stm32mp1-rcc.yaml       |  34 ++++++
 arch/arm/boot/dts/Makefile                    |   4 +
 arch/arm/boot/dts/stm32mp151.dtsi             |  41 +++++++
 arch/arm/boot/dts/stm32mp157a-dk1-scmi.dts    |  86 +++++++++++++++
 arch/arm/boot/dts/stm32mp157c-dk2-scmi.dts    |  95 +++++++++++++++++
 arch/arm/boot/dts/stm32mp157c-ed1-scmi.dts    |  91 ++++++++++++++++
 arch/arm/boot/dts/stm32mp157c-ev1-scmi.dts    | 100 ++++++++++++++++++
 arch/arm/mach-stm32/Kconfig                   |   2 +
 include/dt-bindings/clock/stm32mp1-clks.h     |  46 ++++----
 include/dt-bindings/reset/stm32mp1-resets.h   |  24 ++---
 11 files changed, 503 insertions(+), 37 deletions(-)
 create mode 100644 arch/arm/boot/dts/stm32mp157a-dk1-scmi.dts
 create mode 100644 arch/arm/boot/dts/stm32mp157c-dk2-scmi.dts
 create mode 100644 arch/arm/boot/dts/stm32mp157c-ed1-scmi.dts
 create mode 100644 arch/arm/boot/dts/stm32mp157c-ev1-scmi.dts

-- 
2.17.1


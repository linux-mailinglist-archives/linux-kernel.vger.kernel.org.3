Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A58B4DB009
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 13:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355899AbiCPMrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 08:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355866AbiCPMre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 08:47:34 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67456548D;
        Wed, 16 Mar 2022 05:46:20 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22GAA4Yv013540;
        Wed, 16 Mar 2022 13:46:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=xQ0LY62N9ucJsRtmmS7ed7yZVgwJC7hBULDEdrXmsp4=;
 b=G4WdUUHjUULb5wZFHpgXbt+9XrzcIJGjvHqHnwzTy2OYZm4wBWHgOPosiBoGiR/A4EwU
 i2PITWsjEAiXSXozHLkKLunwDQ78rhPamMfdh/eU6hgUHUhQVYmkjhrLEa7AZ9YHWyJF
 G/TKfojRwbwnrPLZp6kOggJlY4/9dryVtg0dd7wYghiwi8ncRdTneh+x6jCq9OLsQzRK
 TxVVco+Aj6SOu8Qb7kv7EIUmgSbB6Tjd8SJWi3XWyHOMuvZVRs4Lo0yg2QjFnWN/Dfbe
 GS3J6w4IWazcy+PU68kjXw2NGvg+aMNvtzlqWEPo0gs4258x7W+YWtso03H8Wm/9MBPo kw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3et63hdhen-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Mar 2022 13:46:02 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CA00310002A;
        Wed, 16 Mar 2022 13:45:57 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B3729226FB3;
        Wed, 16 Mar 2022 13:45:57 +0100 (CET)
Received: from localhost (10.75.127.47) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Wed, 16 Mar 2022 13:45:57
 +0100
From:   <gabriel.fernandez@foss.st.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Gabriel Fernandez <gabriel.fernandez@foss.st.com>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 00/13] Introduction of STM32MP13 RCC driver (Reset Clock Controller)
Date:   Wed, 16 Mar 2022 13:45:40 +0100
Message-ID: <20220316124553.6818-1-gabriel.fernandez@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-16_04,2022-03-15_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>

v3:
  - cosmetic change from Stephen Boyd
  - rename some functions in clk-stm32-core
  - add missing static for variables or functions

v2:
  - Resend because patch 9,10,12,13 has not been sent
  - add Reviewed by Krzysztof Kozlowski for patch 1

Gabriel Fernandez (13):
  dt-bindings: rcc: stm32: add new compatible for STM32MP13 SoC
  clk: stm32: Introduce STM32MP13 RCC drivers (Reset Clock Controller)
  clk: stm32mp13: add stm32_mux clock management
  clk: stm32mp13: add stm32_gate management
  clk: stm32mp13: add stm32 divider clock
  clk: stm32mp13: add composite clock
  clk: stm32mp13: manage secured clocks
  clk: stm32mp13: add all STM32MP13 peripheral clocks
  clk: stm32mp13: add all STM32MP13 kernel clocks
  clk: stm32mp13: add multi mux function
  clk: stm32mp13: add safe mux management
  ARM: dts: stm32: enable optee firmware and SCMI support on STM32MP13
  ARM: dts: stm32: add RCC on STM32MP13x SoC family

 .../bindings/clock/st,stm32mp1-rcc.yaml       |    2 +
 arch/arm/boot/dts/stm32mp131.dtsi             |  128 +-
 arch/arm/boot/dts/stm32mp133.dtsi             |    4 +-
 arch/arm/boot/dts/stm32mp13xf.dtsi            |    3 +-
 drivers/clk/Kconfig                           |    5 +
 drivers/clk/Makefile                          |    1 +
 drivers/clk/stm32/Makefile                    |    1 +
 drivers/clk/stm32/clk-stm32-core.c            |  695 +++++++
 drivers/clk/stm32/clk-stm32-core.h            |  188 ++
 drivers/clk/stm32/clk-stm32mp13.c             | 1620 +++++++++++++++
 drivers/clk/stm32/reset-stm32.c               |  122 ++
 drivers/clk/stm32/reset-stm32.h               |    8 +
 drivers/clk/stm32/stm32mp13_rcc.h             | 1748 +++++++++++++++++
 include/dt-bindings/clock/stm32mp13-clks.h    |  229 +++
 include/dt-bindings/reset/stm32mp13-resets.h  |  100 +
 15 files changed, 4794 insertions(+), 60 deletions(-)
 create mode 100644 drivers/clk/stm32/Makefile
 create mode 100644 drivers/clk/stm32/clk-stm32-core.c
 create mode 100644 drivers/clk/stm32/clk-stm32-core.h
 create mode 100644 drivers/clk/stm32/clk-stm32mp13.c
 create mode 100644 drivers/clk/stm32/reset-stm32.c
 create mode 100644 drivers/clk/stm32/reset-stm32.h
 create mode 100644 drivers/clk/stm32/stm32mp13_rcc.h
 create mode 100644 include/dt-bindings/clock/stm32mp13-clks.h
 create mode 100644 include/dt-bindings/reset/stm32mp13-resets.h

-- 
2.25.1


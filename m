Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC394C30E9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 17:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbiBXQD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 11:03:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbiBXQD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 11:03:28 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED54E1A2723;
        Thu, 24 Feb 2022 08:02:46 -0800 (PST)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21OFqe5i018312;
        Thu, 24 Feb 2022 17:02:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=E3Ow4hgvVJpm2Kg+yAxOov+dlrfQEYMV60wWkQBS5mA=;
 b=3711kNGZWOI/RcIHIa8Xx7RLHwn9QjBdBqpyj96jiCg5L+6csAnTGluvAmZvC+eGTSke
 yHK9YuLKh+irI0c9KM1mFRUB78X2moTXt9V05vVcdrUSkAQMmG0oeFlvymUcJIxriTVL
 POC3vVa0eQHN0kHtCWir9itseeFXT/4x/qQE9d2DeflU0ffeKF7/SEP+/IZWu1kGRxbk
 U1rKhqmAnYKARGxBY5dywWhdoKTctmCWU+voCcxP298pSW0f4TiLW4uRWExZuxl+3B3z
 VpXd4Gl0vr+m9oi16UeS2plw1pXbiY3Lx1m+UpWvV+4puOZ+77SXa/TKgsIRjmBS3Qf9 XQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ee7tka6v8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Feb 2022 17:02:10 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5579F10002A;
        Thu, 24 Feb 2022 17:02:09 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2D0E622A6FC;
        Thu, 24 Feb 2022 17:02:09 +0100 (CET)
Received: from localhost (10.75.127.50) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Thu, 24 Feb 2022 17:02:08
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
Subject: [PATCH 00/13] Introduction of STM32MP13 RCC driver (Reset Clock Controller)
Date:   Thu, 24 Feb 2022 17:01:28 +0100
Message-ID: <20220224160141.455881-1-gabriel.fernandez@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-02-24_03,2022-02-24_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>

This patchset introduce the reset and clock driver of STM32MP13 SoC.
It uses a clk-stm32-core module to manage stm32 gate, mux and divider
for STM32MP13 and for new future STMP32 SoC.

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
 drivers/clk/stm32/clk-stm32-core.c            |  707 +++++++
 drivers/clk/stm32/clk-stm32-core.h            |  239 +++
 drivers/clk/stm32/clk-stm32mp13.c             | 1580 +++++++++++++++
 drivers/clk/stm32/reset-stm32.c               |  122 ++
 drivers/clk/stm32/reset-stm32.h               |    8 +
 drivers/clk/stm32/stm32mp13_rcc.h             | 1748 +++++++++++++++++
 include/dt-bindings/clock/stm32mp13-clks.h    |  229 +++
 include/dt-bindings/reset/stm32mp13-resets.h  |  100 +
 15 files changed, 4817 insertions(+), 60 deletions(-)
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


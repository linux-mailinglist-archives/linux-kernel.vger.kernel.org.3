Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7465504DCF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 10:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237265AbiDRIaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 04:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237238AbiDRIa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 04:30:26 -0400
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 12692193CF;
        Mon, 18 Apr 2022 01:27:46 -0700 (PDT)
Received: from NTHCCAS04.nuvoton.com (NTHCCAS04.nuvoton.com [10.1.8.29])
        by maillog.nuvoton.com (Postfix) with ESMTP id 22BEC1C811C7;
        Mon, 18 Apr 2022 16:27:44 +0800 (CST)
Received: from NTHCML01B.nuvoton.com (10.1.8.178) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 18
 Apr 2022 16:27:43 +0800
Received: from NTHCCAS04.nuvoton.com (10.1.8.29) by NTHCML01B.nuvoton.com
 (10.1.8.178) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2176.2; Mon, 18 Apr
 2022 16:27:43 +0800
Received: from localhost.localdomain (172.19.1.47) by NTHCCAS04.nuvoton.com
 (10.1.12.25) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Mon, 18 Apr 2022 16:27:43 +0800
From:   Jacky Huang <ychuang3@nuvoton.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <ychuang570808@gmail.com>
CC:     <robh+dt@kernel.org>, <sboyd@kernel.org>, <krzk+dt@kernel.org>,
        <arnd@arndb.de>, <olof@lixom.net>, <will@kernel.org>,
        <soc@kernel.org>, <cfli0@nuvoton.com>,
        Jacky Huang <ychuang3@nuvoton.com>
Subject: [PATCH v3 0/5] Add initial support for MA35D1 SoC
Date:   Mon, 18 Apr 2022 16:27:33 +0800
Message-ID: <20220418082738.11301-1-ychuang3@nuvoton.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds initial support for Nuvoton MA35D1 SoC,
include initial dts and clock controller binding.

v3:
  - added patch 4/5 and 5/5
  - introduce CONFIG_ARCH_NUVOTON option
  - add initial bindings for Nuvoton Platform boards
  - fixed coding style problem of nuvoton,ma35d1-clk.h
  - added CAPLL to clock-controller node
  - modify the chosen node of ma35d1-evb.dts
  - modify clock yaml "clk-pll-mode" to "nuvoton,clk-pll-mode"

v2:
  - fixed dt_binding_check failed of nuvoton,ma35d1-clk.yaml

Jacky Huang (5):
  dt-bindings: clock: add binding for MA35D1 clock controller
  dt-bindings: clock: Document MA35D1 clock controller bindings
  arm64: dts: nuvoton: Add initial support for MA35D1
  arm64: Kconfig: nuvoton: Introduce CONFIG_ARCH_NUVOTON
  dt-bindings: arm: Add initial bindings for Nuvoton Platform

 .../devicetree/bindings/arm/nuvoton.yaml      |  27 ++
 .../bindings/clock/nuvoton,ma35d1-clk.yaml    |  63 +++++
 arch/arm64/Kconfig.platforms                  |  10 +
 arch/arm64/boot/dts/Makefile                  |   1 +
 arch/arm64/boot/dts/nuvoton/Makefile          |   2 +
 arch/arm64/boot/dts/nuvoton/ma35d1-evb.dts    |  24 ++
 arch/arm64/boot/dts/nuvoton/ma35d1.dtsi       | 111 ++++++++
 .../dt-bindings/clock/nuvoton,ma35d1-clk.h    | 260 ++++++++++++++++++
 8 files changed, 498 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/nuvoton.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.yaml
 create mode 100644 arch/arm64/boot/dts/nuvoton/Makefile
 create mode 100644 arch/arm64/boot/dts/nuvoton/ma35d1-evb.dts
 create mode 100644 arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
 create mode 100644 include/dt-bindings/clock/nuvoton,ma35d1-clk.h

-- 
2.17.1


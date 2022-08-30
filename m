Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4F95A6325
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 14:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiH3MVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 08:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbiH3MVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 08:21:13 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B649923FC;
        Tue, 30 Aug 2022 05:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661862072; x=1693398072;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lMLf1aqqIFgOxzgozsPwTfQbYVnam9wTvijjocKUJKs=;
  b=PsqMugXBnjeDc0XXu0Whal/XX9pXxum4Alf4FyTeHsHp7lvGvqkX+Ae+
   lqka/tlnF5INw0ujzZJANWqxpX38SSiZ6osOt4wTKdal9BA3qmDkzXqJr
   EheyETa6e5aSjPOAK78GzPb1HaAFvX/96Z6mTQPTawui0jbSMvtSWQtQE
   nSYuBJ3q6ERUUkB9CdJgysQSQM0kJA3bDB3Z6E/snO+HlTZY2TgQMlV84
   zmsasnJwgZyweqG5sX510Oh/myfIKo90NBjylUM80OZDiUo727dR8VcmG
   MoNGMU38R544HATaVuLMNSeSUGFOoRSjG+I0AWwEVhcBWTVozvU7JFT70
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="111374795"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Aug 2022 05:21:11 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 30 Aug 2022 05:21:08 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Tue, 30 Aug 2022 05:21:06 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Hugh Breslin <hugh.breslin@microchip.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: [PATCH v3 0/5] Add PolarFire SoC Fabric Clock Conditioning Circuitry Support
Date:   Tue, 30 Aug 2022 13:20:19 +0100
Message-ID: <20220830122023.2204485-1-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey all,

PolarFire SoC has 4 clock source blocks, each with 2 PLLs and 2 DLLs,
in the corners of the FPGA fabric. Add bindings, a driver supporting
the PLLs and the requisite changes to the devicetrees for PolarFire
SoC based boards. These clocks were already in use, but which clock
specifically was chosen was decided by the synthesis tool. In our
end-of-September release of our FPGA reference design, constraints will
be added to force the synthesis tool to pick the "north west" CCC,
making it possible to read the configuration from the CCC's registers.

There are no maintainers changes in this series, but they are required
due to the binding rename. I am waiting for some changes queued in the
soc tree before rebasing on a later -rc before including that patch.

The dts patch conflicts with some other dts patches I have submitted,
so I will take the final patch myself once the rest of this is
applied.

Thanks,
Conor.

Changes since v3:
- return devm_of_clk_add_hw_provider() directly in probe
- add a `hw_data.num = num_clks` that got lost along the way somewhere
- mark all output clocks as CLK_DIVIDER_ONE_BASED

Changes since v2:
- Removed the unintentionaly leftover clock-output-names
- Dropped the riscv/microchip dt-binding update. I am moving it to
  another series so that another series for the dts, which is likely to
  be applied first would not depend on this series.

Changes since v1:
- Stopped using the dt node name to generate the clk name. Rather than
  use clock-output-names etc, I just opted to call each PLL after it's
  individual base address:
  cccrefclk
    ccc@38100000_pll0
      ccc@38100000_pll0_out3
      ccc@38100000_pll0_out2
      ccc@38100000_pll0_out1
      ccc@38100000_pll0_out0
- dt nodes are now all called "clock-controller"

Conor Dooley (5):
  dt-bindings: clk: rename mpfs-clkcfg binding
  dt-bindings: clk: document PolarFire SoC fabric clocks
  dt-bindings: clk: add PolarFire SoC fabric clock ids
  clk: microchip: add PolarFire SoC fabric clock support
  riscv: dts: microchip: add the mpfs' fabric clock control

 .../bindings/clock/microchip,mpfs-ccc.yaml    |  80 +++++
 ...p,mpfs.yaml => microchip,mpfs-clkcfg.yaml} |   2 +-
 .../dts/microchip/mpfs-icicle-kit-fabric.dtsi |  27 +-
 .../boot/dts/microchip/mpfs-icicle-kit.dts    |   4 +
 .../dts/microchip/mpfs-polarberry-fabric.dtsi |   5 +
 arch/riscv/boot/dts/microchip/mpfs.dtsi       |  34 +-
 drivers/clk/microchip/Makefile                |   1 +
 drivers/clk/microchip/clk-mpfs-ccc.c          | 290 ++++++++++++++++++
 .../dt-bindings/clock/microchip,mpfs-clock.h  |  23 ++
 9 files changed, 453 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/microchip,mpfs-ccc.yaml
 rename Documentation/devicetree/bindings/clock/{microchip,mpfs.yaml => microchip,mpfs-clkcfg.yaml} (96%)
 create mode 100644 drivers/clk/microchip/clk-mpfs-ccc.c


base-commit: b90cb1053190353cc30f0fef0ef1f378ccc063c5
-- 
2.36.1


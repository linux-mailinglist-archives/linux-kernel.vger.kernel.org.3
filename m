Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B86905654B4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 14:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234111AbiGDMQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 08:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbiGDMQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 08:16:22 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4621D4B;
        Mon,  4 Jul 2022 05:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1656936979; x=1688472979;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UOXPiZdv2rmnkPsrp5Jw7thiJz4uNIawvmKSzDwY0tk=;
  b=pjB08Xlq+po3+ovGUTxk+nS79qfbwyItE0aIPzAH7Q9XT83Xl4GeUgHW
   KpLIrY4hx39oqKBWZVDvDai71kZNVDuW4hhA9coLt/yz28Uu14X+4MH19
   iJ+XWO93h4zHl/UNIKWV2TA7LYrEIkuyO/yzNy8LqyOJ69Fiobxk41dzK
   v4xCa3/6qI8DfVCT3wkyvFseIKOMs4al4d+C7fvxcfaAP6Suz/kFG8hI4
   EMCkorIg3RVe1PnYl2D1FQh8IzyxmspJIp7i6B6Tu4X0xHz00mJmWJQCt
   hB6zoJ++q+ayspXGHj+dbItkTNoV2W/jJoLf0qZd1M0oK6GqGvvxap/Ma
   g==;
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="170953245"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Jul 2022 05:16:19 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 4 Jul 2022 05:16:18 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Mon, 4 Jul 2022 05:16:16 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Daire McNamara <daire.mcnamara@microchip.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
Subject: [PATCH v2 00/12] PolarFire SoC reset controller & clock cleanups
Date:   Mon, 4 Jul 2022 13:15:47 +0100
Message-ID: <20220704121558.2088698-1-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey all,
I know I have not sat on the RFC I sent about the aux. bus parts
for too long, but figured I'd just send the whole thing anyway to all
lists etc.

Kinda two things happening in this series, but I sent it together to
ensure the second part would apply correctly.

The first is the reset controller that I promised after discovering the
issue triggered by CONFIG_PM & the phy not coming up correctly. I have
now removed all the messing with resets from clock enable/disable
functions & now use the aux bus to set up a reset controller driver.
Since I needed something to test it, I hooked up the reset for the
Cadence MACB on PolarFire SoC. This has been split into a second series
for v2:
https://lore.kernel.org/all/20220704114511.1892332-1-conor.dooley@microchip.com/

The second part adds rate control for the MSS PLL clock, followed by
some simplifications to the driver & conversions of some custom structs
to the corresponding structs in the framework.

Thanks,
Conor.

Changes since v1:
- split off the net patches
- clk: actually pass the spinlock to the converted dividers & gates
- reset: added a spinlock around RMW access to registers
- reset: switched to BIT(i) macros
- reset: used local copies of some variables as pointed out by Philipp
- reset: dropped the success printout

Conor Dooley (12):
  dt-bindings: clk: microchip: mpfs: add reset controller support
  clk: microchip: mpfs: add reset controller
  reset: add polarfire soc reset support
  MAINTAINERS: add polarfire soc reset controller
  riscv: dts: microchip: add mpfs specific macb reset support
  clk: microchip: mpfs: add module_authors entries
  clk: microchip: mpfs: add MSS pll's set & round rate
  clk: microchip: mpfs: move id & offset out of clock structs
  clk: microchip: mpfs: simplify control reg access
  clk: microchip: mpfs: delete 2 line mpfs_clk_register_foo()
  clk: microchip: mpfs: convert cfg_clk to clk_divider
  clk: microchip: mpfs: convert periph_clk to clk_gate

 .../bindings/clock/microchip,mpfs.yaml        |  17 +-
 MAINTAINERS                                   |   1 +
 arch/riscv/boot/dts/microchip/mpfs.dtsi       |   7 +-
 drivers/clk/microchip/Kconfig                 |   1 +
 drivers/clk/microchip/clk-mpfs.c              | 379 +++++++++---------
 drivers/reset/Kconfig                         |   7 +
 drivers/reset/Makefile                        |   2 +-
 drivers/reset/reset-mpfs.c                    | 157 ++++++++
 include/soc/microchip/mpfs.h                  |   8 +
 9 files changed, 386 insertions(+), 193 deletions(-)
 create mode 100644 drivers/reset/reset-mpfs.c


base-commit: b13baccc3850ca8b8cccbf8ed9912dbaa0fdf7f3
-- 
2.36.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89E844EB548
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 23:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234261AbiC2V3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 17:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234166AbiC2V3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 17:29:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739A5239305;
        Tue, 29 Mar 2022 14:27:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 981246172D;
        Tue, 29 Mar 2022 21:27:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC605C340F0;
        Tue, 29 Mar 2022 21:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648589254;
        bh=a9XcfWbXxQF8HbHMyy9NiaPGCPLjfTBp9GDmcjRitQ4=;
        h=From:To:Cc:Subject:Date:From;
        b=dlvkuqODlMeo2k09cwdS5dS2OyoYwXEFkyadNmoAc2MnA4pG77N6ywbCbLqW4P/Vy
         hh3MC+TsY27V0QGtKQAQHLZDapWhW2LpINAtYgnCUuKG3j7uKDQ7pUVaIgWP65HCKR
         CDuNpZY3HQ2aBeaTsfOXvw2nEbQZCaqg/JlLe49EtR8XhJXr2ztEJE2AFjexk8rHWf
         hjjS8iFFn/koaTzpPIgeZWJMzexj4Rg3xDJ8nA1S5cY1mr2YtldQoz6HpE3bsCWK69
         Tg33P4Pr7ZsTQ/qYTcCMltE7oLagcvLUf596Xlg5Qb0JnPqKolfAAcbVl6QFlJ/uk0
         UQSL9sJXUa1EA==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk changes for the merge window
Date:   Tue, 29 Mar 2022 14:27:32 -0700
Message-Id: <20220329212732.4111049-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        PP_MIME_FAKE_ASCII_TEXT,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 754e0b0e35608ed5206d6a67a791563c631cec07:

  Linux 5.17-rc4 (2022-02-13 12:13:30 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

for you to fetch changes up to cf683abd3913d5e6e51169de75d65ea193452fbd:

  Merge branches 'clk-sifive' and 'clk-visconti' into clk-next (2022-03-29 10:19:52 -0700)

----------------------------------------------------------------
There's one large change in the core clk framework here. We change how
clk_set_rate_range() works so that the frequency is re-evaulated each time the
rate is changed. Previously we wouldn't let clk providers see a rate that was
different if it was still within the range, which could be bad for power if the
clk could run slower when a range expands. Now the clk provider can decide to
do something differently when the constraints change. This broke Nvidia's clk
driver so we had to wait for the fix for that to bake a little more in -next.

The rate range patch series also introduced a kunit suite for the clk framework
that we're going to extend in the next release. It already made it easy to find
corner cases in the rate range patches so I'm excited to see it cover more clk
code and increase our confidence in core framework patches in the future. I
also added a kunit test for the basic clk gate code and that work will continue
to cover more basic clk types: muxes, dividers, etc.

Beyond the core code we have the usual set of clk driver updates and additions.
Qualcomm again dominates the diffstat here with lots more SoCs being supported
and i.MX follows afer that with a similar number of SoCs gaining clk drivers.
Beyond those large additions there's drivers being modernized to use
clk_parent_data so we can move away from global string names for all the clks
in an SoC. Finally there's lots of little fixes all over the clk drivers for
typos, warnings, and missing clks that aren't critical and get batched up
waiting for the next merge window to open. Nothing super big stands out in the
driver pile. Full details are below.

Core:
 - Make clk_set_rate_range() re-evaluate the limits each time
 - Introduce various clk_set_rate_range() tests
 - Add clk_drop_range() to drop a previously set range

New Drivers:
 - i.MXRT1050 clock driver and bindings
 - i.MX8DXL clock driver and bindings
 - i.MX93 clock driver and bindings
 - NCO blocks on Apple SoCs
 - Audio clks on StarFive JH7100 RISC-V SoC
 - Add support for the new Renesas RZ/V2L SoC
 - Qualcomm SDX65 A7 PLL
 - Qualcomm SM6350 GPU clks
 - Qualcomm SM6125, SM6350, QCS2290 display clks
 - Qualcomm MSM8226 multimedia clks

Updates:
 - Kunit tests for clk-gate implementation
 - Terminate arrays with sentinels and make that clearer
 - Cleanup SPDX tags
 - Fix typos in comments
 - Mark mux table as const in clk-mux
 - Make the all_lists array const
 - Convert Cirrus Logic CS2000P driver to regmap, yamlify DT binding and add
   support for dynamic mode
 - Clock configuration on Microchip PolarFire SoCs
 - Free allocations on probe error in Mediatek clk driver
 - Modernize Mediatek clk driver by consolidating code
 - Add watchdog (WDT), I2C, and pin function controller (PFC) clocks on
   Renesas R-Car S4-8
 - Improve the clocks for the Rockchip rk3568 display outputs (parenting, pll-rates)
 - Use of_device_get_match_data() instead of open-coding on Rockchip rk3568
 - Reintroduce the expected fractional-divider behaviour that disappeared
   with the addition of CLK_FRAC_DIVIDER_POWER_OF_TWO_PS
 - Remove SYS PLL 1/2 clock gates for i.MX8M*
 - Remove AUDIO MCLK ROOT from i.MX7D
 - Add fracn gppll clock type used by i.MX93
 - Add new composite clock for i.MX93
 - Add missing media mipi phy ref clock for i.MX8MP
 - Fix off by one in imx_lpcg_parse_clks_from_dt()
 - Rework for the imx pll14xx
 - sama7g5: One low priority fix for GCLK of PDMC
 - Add DMA engine (SYS-DMAC) clocks on Renesas R-Car S4-8
 - Add MOST (MediaLB I/F) clocks on Renesas R-Car E3 and D3
 - Add CAN-FD clocks on Renesas R-Car V3U
 - Qualcomm SC8280XP RPMCC
 - Add some missing clks on Qualcomm MSM8992/MSM8994/MSM8998 SoCs
 - Rework Qualcomm GCC bindings and convert SDM845 camera bindig to YAML
 - Convert various Qualcomm drivers to use clk_parent_data
 - Remove test clocks from various Qualcomm drivers
 - Crypto engine clks on Qualcomm IPQ806x + more freqs for SDCC/NSS
 - Qualcomm SM8150 EMAC, PCIe, UFS GDSCs
 - Better pixel clk frequency support on Qualcomm RCG2 clks

----------------------------------------------------------------
Abel Vesa (4):
      clk: imx7d: Remove audio_mclk_root_clk
      dt-bindings: fsl: scu: add imx8dxl scu clock support
      MAINTAINERS: clk: imx: add git tree and dt-bindings files
      clk: imx: Select MXC_CLK for i.MX93 clock driver

Adam Wujek (1):
      clk: si5341: fix reported clk_rate when output divider is 2

Ansuel Smith (15):
      dt-bindings: clock: split qcom,gcc.yaml to common and specific schema
      dt-bindings: clock: simplify qcom,gcc-apq8064 Documentation
      dt-bindings: clock: document qcom,gcc-ipq8064 binding
      clk: qcom: gcc-ipq806x: fix wrong naming for gcc_pxo_pll8_pll0
      clk: qcom: gcc-ipq806x: convert parent_names to parent_data
      clk: qcom: gcc-ipq806x: use ARRAY_SIZE for num_parents
      clk: qcom: gcc-ipq806x: add additional freq nss cores
      clk: qcom: gcc-ipq806x: add unusued flag for critical clock
      clk: qcom: clk-rcg: add clk_rcg_floor_ops ops
      clk: qcom: gcc-ipq806x: add additional freq for sdc table
      dt-bindings: clock: add ipq8064 ce5 clk define
      clk: qcom: gcc-ipq806x: add CryptoEngine clocks
      dt-bindings: reset: add ipq8064 ce5 resets
      clk: qcom: gcc-ipq806x: add CryptoEngine resets
      dt-bindings: clock: fix dt_binding_check error for qcom,gcc-other.yaml

Bartosz Dudziak (2):
      dt-bindings: clock: Add support for the MSM8226 mmcc
      clk: qcom: Add MSM8226 Multimedia Clock Controller support

Bhupesh Sharma (4):
      clk: qcom: gcc: Add PCIe0 and PCIe1 GDSC for SM8150
      clk: qcom: gcc: Add UFS_CARD and UFS_PHY GDSCs for SM8150
      clk: qcom: gcc: sm8150: Fix some identation issues
      clk: qcom: gcc: Add emac GDSC support for SM8150

Biju Das (2):
      dt-bindings: clock: renesas: Document RZ/V2L SoC
      clk: renesas: rzg2l-cpg: Add support for RZ/V2L SoC

Bjorn Andersson (2):
      dt-bindings: clock: Add sc8280xp to the RPMh clock controller binding
      clk: qcom: rpmhcc: add sc8280xp support to the RPMh clock controller

Chen-Yu Tsai (31):
      clk: mediatek: Use %pe to print errors
      clk: mediatek: gate: Consolidate gate type clk related code
      clk: mediatek: gate: Internalize clk implementation
      clk: mediatek: gate: Implement unregister API
      clk: mediatek: gate: Clean up included headers
      clk: mediatek: cpumux: Implement unregister API
      clk: mediatek: cpumux: Internalize struct mtk_clk_cpumux
      clk: mediatek: cpumux: Clean up included headers
      clk: mediatek: mux: Implement unregister API
      clk: mediatek: mux: Internalize struct mtk_clk_mux
      clk: mediatek: mux: Clean up included headers
      clk: mediatek: pll: Split definitions into separate header file
      clk: mediatek: pll: Implement unregister API
      clk: mediatek: pll: Clean up included headers
      clk: mediatek: Implement mtk_clk_unregister_fixed_clks() API
      clk: mediatek: Implement mtk_clk_unregister_factors() API
      clk: mediatek: Implement mtk_clk_unregister_divider_clks() API
      clk: mediatek: Implement mtk_clk_unregister_composites() API
      clk: mediatek: Add mtk_clk_simple_remove()
      clk: mediatek: mtk: Clean up included headers
      clk: mediatek: cpumux: Implement error handling in register API
      clk: mediatek: gate: Implement error handling in register API
      clk: mediatek: mux: Reverse check for existing clk to reduce nesting level
      clk: mediatek: mux: Implement error handling in register API
      clk: mediatek: pll: Implement error handling in register API
      clk: mediatek: mtk: Implement error handling in register APIs
      clk: mediatek: Unregister clks in mtk_clk_simple_probe() error path
      clk: mediatek: mt8195: Hook up mtk_clk_simple_remove()
      clk: mediatek: mt8195: Implement error handling in probe functions
      clk: mediatek: mt8195: Implement remove functions
      clk: mediatek: Warn if clk IDs are duplicated

Claudiu Beznea (1):
      clk: at91: clk-master: remove dead code

Codrin Ciubotariu (1):
      clk: at91: sama7g5: fix parents of PDMCs' GCLK

Colin Ian King (1):
      clk: imx: remove redundant re-assignment of pll->base

Daire McNamara (1):
      clk: microchip: Add driver for Microchip PolarFire SoC

Dan Carpenter (2):
      clk: imx: off by one in imx_lpcg_parse_clks_from_dt()
      clk: visconti: prevent array overflow in visconti_clk_register_gates()

Daniel Mack (9):
      dt-bindings: clock: convert cs2000-cp bindings to yaml
      dt-bindings: clock: cs2000-cp: document aux-output-source
      dt-bindings: clock: cs2000-cp: document cirrus,clock-skip flag
      dt-bindings: clock: cs2000-cp: document cirrus,dynamic-mode
      clk: cs2000-cp: Make aux output function controllable
      clk: cs2000-cp: add support for dynamic mode
      clk: cs2000-cp: make clock skip setting configurable
      clk: cs2000-cp: freeze config during register fiddling
      clk: cs2000-cp: convert driver to regmap

Dirk Buchwalder (1):
      clk: qcom: ipq8074: Use floor ops for SDCC1 clock

Dmitry Baryshkov (18):
      clk: qcom: gpucc-sdm660: fix two clocks with parent_names
      clk: qcom: gpucc-sdm660: get rid of the test clock
      clk: qcom: gpucc-sdm660: use parent_hws instead of parent_data
      clk: qcom: camcc-sc7180: use ARRAY_SIZE instead of specifying num_parents
      clk: qcom: camcc-sc7180: get rid of the test clock
      clk: qcom: camcc-sc7180: use parent_hws instead of parent_data
      clk: qcom: camcc-sdm845: use ARRAY_SIZE instead of specifying num_parents
      clk: qcom: camcc-sdm845: get rid of the test clock
      clk: qcom: camcc-sdm845: move clock parent tables down
      clk: qcom: camcc-sdm845: convert to parent_hws/_data
      clk: qcom: videocc-sc7180: use parent_hws instead of parent_data
      clk: qcom: gcc-msm8996: use ARRAY_SIZE instead of specifying num_parents
      clk: qcom: gcc-msm8996: drop unsupported clock sources
      clk: qcom: gcc-msm8996: move clock parent tables down
      clk: qcom: gcc-msm8996: use parent_hws/_data instead of parent_names
      clk: qcom: gcc-msm8996: start getting rid of xo clk
      dt-bindings: clocks: convert SDM845 Camera CC bindings to YAML
      dt-bindings: clocks: qcom,sdm845-camcc: add clocks/clock-names

Emil Renner Berthing (7):
      clk: starfive: jh7100: Don't round divisor up twice
      clk: starfive: jh7100: Handle audio_div clock properly
      dt-bindings: clock: Add JH7100 audio clock definitions
      dt-bindings: clock: Add starfive,jh7100-audclk bindings
      clk: starfive: jh7100: Make hw clock implementation reusable
      clk: starfive: jh7100: Support more clock types
      clk: starfive: Add JH7100 audio clock driver

Geert Uytterhoeven (6):
      Merge tag 'renesas-r9a07g054-dt-binding-defs-tag' into renesas-clk-for-v5.18
      clk: renesas: r8a779f0: Fix RSW2 clock divider
      clk: renesas: r8a779f0: Add WDT clock
      clk: renesas: r8a779f0: Add I2C clocks
      clk: renesas: r8a779f0: Add PFC clock
      clk: COMMON_CLK_LAN966X should depend on SOC_LAN966

Giulio Benetti (1):
      dt-bindings: imx: Add clock binding for i.MXRT1050

Jacky Bai (1):
      clk: imx: Add imx8dxl clk driver

Jesse Taube (2):
      dt-bindings: clock: imx: Add documentation for i.MXRT1050 clock
      clk: imx: Add initial support for i.MXRT1050 clock driver

Jonathan Neuschäfer (12):
      clk: nxp: Remove unused variable
      clk: nxp: Declare mux table parameter as const u32 *
      clk: mux: Declare u32 *table parameter as const
      clk: hisilicon: Remove unnecessary cast of mux table to u32 *
      clk: mmp: Declare mux tables as const u32[]
      clk: qcom: Declare mux table as const u32[]
      clk: pistachio: Declare mux table as const u32[]
      clk: actions: Terminate clk_div_table with sentinel element
      clk: loongson1: Terminate clk_div_table with sentinel element
      clk: hisilicon: Terminate clk_div_table with sentinel element
      clk: clps711x: Terminate clk_div_table with sentinel element
      clk: actions: Make sentinel elements more obvious

José Expósito (1):
      clk: mediatek: Fix memory leaks on probe

Julia Lawall (2):
      clk: ti: clkctrl: fix typos in comments
      clk: qcom: sm6125-gcc: fix typos in comments

Konrad Dybcio (8):
      dt-bindings: clock: add QCOM SM6350 display clock bindings
      clk: qcom: Add display clock controller driver for SM6350
      dt-bindings: clock: add SM6350 QCOM Graphics clock bindings
      clk: qcom: Add GPU clock controller driver for SM6350
      dt-bindings: clock: qcom: rpmcc: Add RPM Modem SubSystem (MSS) clocks
      clk: qcom: smd: Add missing RPM clocks for msm8992/4
      clk: qcom: smd: Add missing MSM8998 RPM clocks
      clk: qcom: gcc-msm8994: Fix gpll4 width

Krzysztof Kozlowski (1):
      dt-bindings: clock: drop useless consumer example

Kunihiko Hayashi (1):
      clk: uniphier: Fix fixed-rate initialization

Lad Prabhakar (1):
      clk: renesas: r9a07g044: Update multiplier and divider values for PLL2/3

Laurent Pinchart (1):
      clk: imx8mp: Add missing IMX8MP_CLK_MEDIA_MIPI_PHY1_REF_ROOT clock

Loic Poulain (2):
      dt-bindings: clock: Add qualcomm QCM2290 DISPCC bindings
      clk: qcom: Add display clock controller driver for QCM2290

Marek Vasut (5):
      clk: stm32mp1: Split ETHCK_K into separate MUX and GATE clock
      clk: stm32mp1: Add parent_data to ETHRX clock
      dt-bindings: clk: rs9: Add Renesas 9-series I2C PCIe clock generator
      clk: fixed-factor: Introduce devm_clk_hw_register_fixed_factor_index()
      clk: rs9: Add Renesas 9-series PCIe clock generator driver

Marijn Suijten (1):
      clk: qcom: Fix sorting of SDX_GCC_65 in Makefile and Kconfig

Martin Botka (2):
      dt-bindings: clock: add QCOM SM6125 display clock bindings
      clk: qcom: Add display clock controller driver for SM6125

Martin Povišer (4):
      dt-bindings: clock: Add Apple NCO
      clk: clk-apple-nco: Add driver for Apple NCO
      MAINTAINERS: Add clk-apple-nco under ARM/APPLE MACHINE
      clk: clk-apple-nco: Allow and fix module building

Maxime Ripard (14):
      clk: Fix clk_hw_get_clk() when dev is NULL
      clk: Introduce Kunit Tests for the framework
      clk: Enforce that disjoints limits are invalid
      clk: Always clamp the rounded rate
      clk: Use clamp instead of open-coding our own
      clk: Always set the rate on clk_set_range_rate
      clk: Add clk_drop_range
      clk: bcm: rpi: Add variant structure
      clk: bcm: rpi: Set a default minimum rate
      clk: bcm: rpi: Run some clocks at the minimum rate allowed
      clk: bcm2835: Remove unused variable
      clk: Initialize orphan req_rate
      clk: test: Test clk_set_rate_range on orphan mux
      clk: Drop the rate range on clk_put()

Miaoqian Lin (1):
      clk: tegra: tegra124-emc: Fix missing put_device() call in emc_ensure_emc_driver

Michael Tretter (1):
      clk: zynqmp: replace warn_once with pr_debug for failed clock ops

Minghao Chi (CGEL ZTE) (2):
      clk/rockchip: Use of_device_get_match_data()
      clk: Use of_device_get_match_data()

Nikita Yushchenko (1):
      clk: renesas: r8a7799[05]: Add MLP clocks

Peng Fan (8):
      dt-bindings: clock: Add imx93 clock support
      dt-bindings: clock: add i.MX93 clock definition
      clk: imx: add i.MX93 composite clk
      clk: imx: support fracn gppll
      clk: imx: add i.MX93 clk
      clk: imx8mm: remove SYS PLL 1/2 clock gates
      clk: imx8mn: remove SYS PLL 1/2 clock gates
      clk: imx8mp: remove SYS PLL 1/2 clock gates

Qing Wang (1):
      clk-si5341: replace snprintf in show functions with sysfs_emit

Quentin Schulz (1):
      clk: rockchip: re-add rational best approximation algorithm to the fractional divider

Rob Herring (1):
      dt-bindings: clock: renesas: Make example 'clocks' parsable

Robert Marko (1):
      clk: qcom: ipq8074: fix PCI-E clock oops

Rohit Agarwal (3):
      dt-bindings: clock: Add A7 PLL binding for SDX65
      clk: qcom: Add A7 PLL support for SDX65
      clk: qcom: Add SDX65 APCS clock controller support

Sascha Hauer (11):
      clk: rockchip: Add more PLL rates for rk3568
      clk: rockchip: drop CLK_SET_RATE_PARENT from dclk_vop* on rk3568
      clk: rockchip: Add CLK_SET_RATE_PARENT to the HDMI reference clock on rk3568
      clk: imx: pll14xx: Use register defines consistently
      clk: imx: pll14xx: Drop wrong shifting
      clk: imx: pll14xx: Use FIELD_GET/FIELD_PREP
      clk: imx: pll14xx: consolidate rate calculation
      clk: imx: pll14xx: name variables after usage
      clk: imx: pll14xx: explicitly return lowest rate
      clk: imx: pll14xx: Add pr_fmt
      clk: imx: pll14xx: Support dynamic rates

Shubhrajyoti Datta (2):
      clk: zynq: trivial warning fix
      clk: zynq: Update the parameters to zynq_clk_register_periph_clk

Stephen Boyd (16):
      clk: gate: Add some kunit test suites
      Merge tag 'renesas-clk-for-v5.18-tag1' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers into clk-renesas
      clk: Mark 'all_lists' as const
      clk: Mark clk_core_evict_parent_cache_subtree() 'target' const
      Merge tag 'clk-at91-5.18' of git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux into clk-at91
      Merge tag 'clk-imx-5.18' of git://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux into clk-imx
      Merge tag 'v5.18-rockchip-clk1' of git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip into clk-rockchip
      Merge tag 'renesas-clk-for-v5.18-tag2' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers into clk-renesas
      Merge tag 'qcom-clk-for-5.18' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into clk-qcom
      Merge tag 'v5.17-rc4' into clk-ti
      Merge branches 'clk-microchip', 'clk-si', 'clk-mtk', 'clk-at91' and 'clk-st' into clk-next
      Merge branches 'clk-xilinx', 'clk-kunit', 'clk-cs2000' and 'clk-renesas' into clk-next
      Merge branches 'clk-mvebu', 'clk-const', 'clk-imx' and 'clk-rockchip' into clk-next
      Merge branches 'clk-starfive', 'clk-ti', 'clk-terminate' and 'clk-cleanup' into clk-next
      Merge branches 'clk-range', 'clk-uniphier', 'clk-apple' and 'clk-qcom' into clk-next
      Merge branches 'clk-sifive' and 'clk-visconti' into clk-next

Taniya Das (2):
      clk: qcom: clk-rcg2: Update logic to calculate D value for RCG
      clk: qcom: clk-rcg2: Update the frac table for pixel clock

Tom Rix (2):
      clk: socfpga: cleanup spdx tags
      clk: cleanup comments

Tony Lindgren (11):
      clk: ti: Constify clkctrl_name
      clk: ti: Preserve node in ti_dt_clocks_register()
      clk: ti: Optionally parse IO address from parent clock node
      clk: ti: Add ti_find_clock_provider() to use clock-output-names
      clk: ti: Use clock-output-names for clkctrl
      clk: ti: Add ti_dt_clk_name() helper to use clock-output-names
      clk: ti: Update pll and clockdomain clocks to use ti_dt_clk_name()
      clk: ti: Update component clocks to use ti_dt_clk_name()
      clk: ti: Drop legacy compatibility clocks for am3
      clk: ti: Drop legacy compatibility clocks for am4
      clk: ti: Drop legacy compatibility clocks for dra7

Tudor Ambarus (1):
      clk: at91: sama7g5: Allow MCK1 to be exported and referenced in DT

Ulrich Hecht (1):
      clk: renesas: r8a779a0: Add CANFD module clock

Wang Qing (1):
      clk: mvebu: use time_is_before_eq_jiffies() instead of open coding it

Yoshihiro Shimoda (1):
      clk: renesas: r8a779f0: Add SYS-DMAC clocks

Zixun LI (1):
      clk: at91: allow setting PMC_AUDIOPINCK clock parents via DT

Zong Li (5):
      clk: sifive: duplicate the macro definitions for the time being
      dt-bindings: change the macro name of prci in header files and example
      riscv: dts: Change the macro name of prci in each device node
      clk: sifive: Add SoCs prefix in each SoCs-dependent data
      clk: sifive: Move all stuff into SoCs header files from C files

 .../devicetree/bindings/arm/freescale/fsl,scu.txt  |    1 +
 .../devicetree/bindings/clock/apple,nco.yaml       |   62 ++
 .../bindings/clock/bitmain,bm1880-clk.yaml         |   12 -
 .../bindings/clock/cirrus,cs2000-cp.yaml           |   91 ++
 .../devicetree/bindings/clock/cs2000-cp.txt        |   22 -
 .../devicetree/bindings/clock/idt,versaclock5.yaml |    7 -
 .../devicetree/bindings/clock/imx1-clock.yaml      |    9 -
 .../devicetree/bindings/clock/imx21-clock.yaml     |    9 -
 .../devicetree/bindings/clock/imx23-clock.yaml     |    9 -
 .../devicetree/bindings/clock/imx25-clock.yaml     |    8 -
 .../devicetree/bindings/clock/imx27-clock.yaml     |    9 -
 .../devicetree/bindings/clock/imx28-clock.yaml     |    9 -
 .../devicetree/bindings/clock/imx31-clock.yaml     |    8 -
 .../devicetree/bindings/clock/imx35-clock.yaml     |    8 -
 .../bindings/clock/imx7ulp-pcc-clock.yaml          |   11 -
 .../bindings/clock/imx7ulp-scg-clock.yaml          |   11 -
 .../devicetree/bindings/clock/imx8qxp-lpcg.yaml    |   11 -
 .../devicetree/bindings/clock/imx93-clock.yaml     |   62 ++
 .../devicetree/bindings/clock/imxrt1050-clock.yaml |   59 ++
 .../devicetree/bindings/clock/microchip,mpfs.yaml  |   58 ++
 .../bindings/clock/nvidia,tegra124-car.yaml        |    7 -
 .../bindings/clock/nvidia,tegra20-car.yaml         |    7 -
 .../devicetree/bindings/clock/qcom,a7pll.yaml      |    2 +-
 .../devicetree/bindings/clock/qcom,camcc.txt       |   18 -
 .../bindings/clock/qcom,dispcc-sm6125.yaml         |   87 ++
 .../bindings/clock/qcom,dispcc-sm6350.yaml         |   86 ++
 .../bindings/clock/qcom,gcc-apq8064.yaml           |   29 +-
 .../bindings/clock/qcom,gcc-ipq8064.yaml           |   76 ++
 .../devicetree/bindings/clock/qcom,gcc-other.yaml  |   70 ++
 .../devicetree/bindings/clock/qcom,gcc.yaml        |   59 +-
 .../devicetree/bindings/clock/qcom,gpucc.yaml      |    2 +
 .../devicetree/bindings/clock/qcom,mmcc.yaml       |    1 +
 .../bindings/clock/qcom,qcm2290-dispcc.yaml        |   87 ++
 .../devicetree/bindings/clock/qcom,rpmhcc.yaml     |    1 +
 .../bindings/clock/qcom,sdm845-camcc.yaml          |   65 ++
 .../devicetree/bindings/clock/renesas,9series.yaml |   97 ++
 .../bindings/clock/renesas,cpg-div6-clock.yaml     |   12 +
 .../bindings/clock/renesas,rzg2l-cpg.yaml          |   14 +-
 .../bindings/clock/starfive,jh7100-audclk.yaml     |   57 ++
 .../devicetree/bindings/gpio/sifive,gpio.yaml      |    2 +-
 .../devicetree/bindings/pci/sifive,fu740-pcie.yaml |    2 +-
 .../devicetree/bindings/serial/sifive-serial.yaml  |    2 +-
 MAINTAINERS                                        |   13 +-
 arch/riscv/boot/dts/sifive/fu540-c000.dtsi         |   22 +-
 arch/riscv/boot/dts/sifive/fu740-c000.dtsi         |   26 +-
 drivers/clk/.kunitconfig                           |    4 +
 drivers/clk/Kconfig                                |   39 +-
 drivers/clk/Makefile                               |    6 +-
 drivers/clk/actions/owl-s500.c                     |   16 +-
 drivers/clk/actions/owl-s700.c                     |   17 +-
 drivers/clk/actions/owl-s900.c                     |   26 +-
 drivers/clk/at91/at91rm9200.c                      |    3 +-
 drivers/clk/at91/at91sam9260.c                     |    3 +-
 drivers/clk/at91/at91sam9g45.c                     |    3 +-
 drivers/clk/at91/at91sam9n12.c                     |    3 +-
 drivers/clk/at91/at91sam9rl.c                      |    3 +-
 drivers/clk/at91/at91sam9x5.c                      |    3 +-
 drivers/clk/at91/clk-master.c                      |  117 +--
 drivers/clk/at91/dt-compat.c                       |    3 +-
 drivers/clk/at91/pmc.h                             |    2 +-
 drivers/clk/at91/sam9x60.c                         |    3 +-
 drivers/clk/at91/sama5d2.c                         |    7 +-
 drivers/clk/at91/sama5d3.c                         |    3 +-
 drivers/clk/at91/sama5d4.c                         |    3 +-
 drivers/clk/at91/sama7g5.c                         |   16 +-
 drivers/clk/at91/sckc.c                            |    2 +-
 drivers/clk/axis/clk-artpec6.c                     |    2 +-
 drivers/clk/bcm/clk-bcm2835.c                      |    2 -
 drivers/clk/bcm/clk-iproc.h                        |    2 +-
 drivers/clk/bcm/clk-kona-setup.c                   |    2 +-
 drivers/clk/bcm/clk-raspberrypi.c                  |  127 ++-
 drivers/clk/clk-apple-nco.c                        |  334 +++++++
 drivers/clk/clk-clps711x.c                         |    2 +
 drivers/clk/clk-cs2000-cp.c                        |  240 +++--
 drivers/clk/clk-fixed-factor.c                     |   22 +
 drivers/clk/clk-fractional-divider.c               |    2 +-
 drivers/clk/clk-gate_test.c                        |  464 +++++++++
 drivers/clk/clk-mux.c                              |   10 +-
 drivers/clk/clk-oxnas.c                            |    6 +-
 drivers/clk/clk-renesas-pcie.c                     |  322 +++++++
 drivers/clk/clk-si5341.c                           |   26 +-
 drivers/clk/clk-stm32mp1.c                         |   46 +-
 drivers/clk/clk.c                                  |  137 ++-
 drivers/clk/clk_test.c                             | 1008 ++++++++++++++++++++
 drivers/clk/hisilicon/clk-hi3559a.c                |    4 +-
 drivers/clk/hisilicon/clk.c                        |    2 +-
 drivers/clk/imx/Kconfig                            |   14 +
 drivers/clk/imx/Makefile                           |    8 +-
 drivers/clk/imx/clk-composite-93.c                 |   93 ++
 drivers/clk/imx/clk-fracn-gppll.c                  |  323 +++++++
 drivers/clk/imx/clk-imx7d.c                        |    1 -
 drivers/clk/imx/clk-imx8dxl-rsrc.c                 |   66 ++
 drivers/clk/imx/clk-imx8mm.c                       |   49 +-
 drivers/clk/imx/clk-imx8mn.c                       |   50 +-
 drivers/clk/imx/clk-imx8mp.c                       |   49 +-
 drivers/clk/imx/clk-imx8qxp-lpcg.c                 |    2 +-
 drivers/clk/imx/clk-imx8qxp.c                      |    1 +
 drivers/clk/imx/clk-imx93.c                        |  341 +++++++
 drivers/clk/imx/clk-imxrt1050.c                    |  168 ++++
 drivers/clk/imx/clk-pll14xx.c                      |  287 ++++--
 drivers/clk/imx/clk-scu.h                          |    1 +
 drivers/clk/imx/clk-sscg-pll.c                     |    1 -
 drivers/clk/imx/clk.h                              |   30 +
 drivers/clk/loongson1/clk-loongson1c.c             |    1 +
 drivers/clk/mediatek/clk-apmixed.c                 |    2 +-
 drivers/clk/mediatek/clk-cpumux.c                  |   69 +-
 drivers/clk/mediatek/clk-cpumux.h                  |   13 +-
 drivers/clk/mediatek/clk-gate.c                    |  148 ++-
 drivers/clk/mediatek/clk-gate.h                    |   59 +-
 drivers/clk/mediatek/clk-mt2701.c                  |    5 +-
 drivers/clk/mediatek/clk-mt2712.c                  |    3 +-
 drivers/clk/mediatek/clk-mt6765.c                  |    3 +-
 drivers/clk/mediatek/clk-mt6779.c                  |    3 +-
 drivers/clk/mediatek/clk-mt6797.c                  |    3 +-
 drivers/clk/mediatek/clk-mt7622.c                  |    5 +-
 drivers/clk/mediatek/clk-mt7629.c                  |    5 +-
 drivers/clk/mediatek/clk-mt7986-apmixed.c          |    4 +-
 drivers/clk/mediatek/clk-mt8135.c                  |    3 +-
 drivers/clk/mediatek/clk-mt8167.c                  |    3 +-
 drivers/clk/mediatek/clk-mt8173.c                  |    5 +-
 drivers/clk/mediatek/clk-mt8183.c                  |    3 +-
 drivers/clk/mediatek/clk-mt8192.c                  |   39 +-
 drivers/clk/mediatek/clk-mt8195-apmixedsys.c       |   30 +-
 drivers/clk/mediatek/clk-mt8195-apusys_pll.c       |   25 +-
 drivers/clk/mediatek/clk-mt8195-cam.c              |    1 +
 drivers/clk/mediatek/clk-mt8195-ccu.c              |    1 +
 drivers/clk/mediatek/clk-mt8195-img.c              |    1 +
 drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c     |    1 +
 drivers/clk/mediatek/clk-mt8195-infra_ao.c         |    1 +
 drivers/clk/mediatek/clk-mt8195-ipe.c              |    1 +
 drivers/clk/mediatek/clk-mt8195-mfg.c              |    1 +
 drivers/clk/mediatek/clk-mt8195-peri_ao.c          |    1 +
 drivers/clk/mediatek/clk-mt8195-scp_adsp.c         |    1 +
 drivers/clk/mediatek/clk-mt8195-topckgen.c         |   69 +-
 drivers/clk/mediatek/clk-mt8195-vdec.c             |    1 +
 drivers/clk/mediatek/clk-mt8195-vdo0.c             |   20 +-
 drivers/clk/mediatek/clk-mt8195-vdo1.c             |   20 +-
 drivers/clk/mediatek/clk-mt8195-venc.c             |    1 +
 drivers/clk/mediatek/clk-mt8195-vpp0.c             |    1 +
 drivers/clk/mediatek/clk-mt8195-vpp1.c             |    1 +
 drivers/clk/mediatek/clk-mt8195-wpe.c              |    1 +
 drivers/clk/mediatek/clk-mt8516.c                  |    3 +-
 drivers/clk/mediatek/clk-mtk.c                     |  304 ++++--
 drivers/clk/mediatek/clk-mtk.h                     |  105 +-
 drivers/clk/mediatek/clk-mux.c                     |   89 +-
 drivers/clk/mediatek/clk-mux.h                     |   17 +-
 drivers/clk/mediatek/clk-pll.c                     |  100 +-
 drivers/clk/mediatek/clk-pll.h                     |   57 ++
 drivers/clk/mediatek/reset.c                       |    3 +-
 drivers/clk/meson/meson8b.c                        |    2 +-
 drivers/clk/microchip/Kconfig                      |   10 +
 drivers/clk/microchip/Makefile                     |    1 +
 drivers/clk/microchip/clk-mpfs.c                   |  381 ++++++++
 drivers/clk/mmp/clk-of-mmp2.c                      |    4 +-
 drivers/clk/mmp/pwr-island.c                       |    2 +-
 drivers/clk/mvebu/armada-37xx-periph.c             |    3 +-
 drivers/clk/nxp/clk-lpc18xx-cgu.c                  |    5 +-
 drivers/clk/pistachio/clk-pistachio.c              |    2 +-
 drivers/clk/qcom/Kconfig                           |   59 +-
 drivers/clk/qcom/Makefile                          |    6 +-
 drivers/clk/qcom/camcc-sc7180.c                    |  221 ++---
 drivers/clk/qcom/camcc-sdm845.c                    |  323 ++++---
 drivers/clk/qcom/clk-rcg.c                         |   24 +
 drivers/clk/qcom/clk-rcg.h                         |    1 +
 drivers/clk/qcom/clk-rcg2.c                        |   14 +-
 drivers/clk/qcom/clk-rpmh.c                        |   18 +
 drivers/clk/qcom/clk-smd-rpm.c                     |   53 +-
 drivers/clk/qcom/dispcc-qcm2290.c                  |  555 +++++++++++
 drivers/clk/qcom/dispcc-sm6125.c                   |  709 ++++++++++++++
 drivers/clk/qcom/dispcc-sm6350.c                   |  797 ++++++++++++++++
 drivers/clk/qcom/gcc-ipq806x.c                     |  649 +++++++++----
 drivers/clk/qcom/gcc-ipq8074.c                     |   21 +-
 drivers/clk/qcom/gcc-msm8994.c                     |    1 +
 drivers/clk/qcom/gcc-msm8996.c                     |  971 +++++++++++--------
 drivers/clk/qcom/gcc-sm6125.c                      |    2 +-
 drivers/clk/qcom/gcc-sm8150.c                      |   74 +-
 drivers/clk/qcom/gpucc-sdm660.c                    |   21 +-
 drivers/clk/qcom/gpucc-sm6350.c                    |  521 ++++++++++
 drivers/clk/qcom/kpss-xcc.c                        |    2 +-
 drivers/clk/qcom/mmcc-msm8974.c                    |  206 +++-
 drivers/clk/qcom/videocc-sc7180.c                  |    8 +-
 drivers/clk/renesas/Kconfig                        |    7 +-
 drivers/clk/renesas/Makefile                       |    1 +
 drivers/clk/renesas/r8a77990-cpg-mssr.c            |    1 +
 drivers/clk/renesas/r8a77995-cpg-mssr.c            |    1 +
 drivers/clk/renesas/r8a779a0-cpg-mssr.c            |    1 +
 drivers/clk/renesas/r8a779f0-cpg-mssr.c            |   20 +-
 drivers/clk/renesas/r9a07g044-cpg.c                |  426 +++++----
 drivers/clk/renesas/rzg2l-cpg.c                    |    6 +
 drivers/clk/renesas/rzg2l-cpg.h                    |    1 +
 drivers/clk/rockchip/clk-rk3568.c                  |   20 +-
 drivers/clk/rockchip/clk.c                         |    3 +
 drivers/clk/sifive/Makefile                        |    2 +-
 drivers/clk/sifive/fu540-prci.c                    |   89 --
 drivers/clk/sifive/fu540-prci.h                    |   91 +-
 drivers/clk/sifive/fu740-prci.c                    |  134 ---
 drivers/clk/sifive/fu740-prci.h                    |  130 ++-
 drivers/clk/sifive/sifive-prci.c                   |    5 -
 drivers/clk/socfpga/clk-gate-s10.c                 |    2 +-
 drivers/clk/socfpga/clk-periph-s10.c               |    2 +-
 drivers/clk/socfpga/clk-pll-s10.c                  |    2 +-
 drivers/clk/socfpga/clk-s10.c                      |    2 +-
 drivers/clk/starfive/Kconfig                       |    8 +
 drivers/clk/starfive/Makefile                      |    1 +
 drivers/clk/starfive/clk-starfive-jh7100-audio.c   |  170 ++++
 drivers/clk/starfive/clk-starfive-jh7100.c         |  176 ++--
 drivers/clk/starfive/clk-starfive-jh7100.h         |  112 +++
 drivers/clk/tegra/clk-tegra124-emc.c               |    1 +
 drivers/clk/ti/Makefile                            |    9 +-
 drivers/clk/ti/apll.c                              |   13 +-
 drivers/clk/ti/autoidle.c                          |    2 +-
 drivers/clk/ti/clk-33xx-compat.c                   |  218 -----
 drivers/clk/ti/clk-33xx.c                          |    5 +-
 drivers/clk/ti/clk-43xx-compat.c                   |  225 -----
 drivers/clk/ti/clk-43xx.c                          |    5 +-
 drivers/clk/ti/clk-7xx-compat.c                    |  820 ----------------
 drivers/clk/ti/clk-7xx.c                           |    5 +-
 drivers/clk/ti/clk-dra7-atl.c                      |    6 +-
 drivers/clk/ti/clk.c                               |   86 +-
 drivers/clk/ti/clkctrl.c                           |   59 +-
 drivers/clk/ti/clock.h                             |    4 +-
 drivers/clk/ti/clockdomain.c                       |    2 +-
 drivers/clk/ti/composite.c                         |    6 +-
 drivers/clk/ti/divider.c                           |    6 +-
 drivers/clk/ti/dpll.c                              |    8 +-
 drivers/clk/ti/fapll.c                             |   11 +-
 drivers/clk/ti/fixed-factor.c                      |    2 +-
 drivers/clk/ti/gate.c                              |    4 +-
 drivers/clk/ti/interface.c                         |    4 +-
 drivers/clk/ti/mux.c                               |    4 +-
 drivers/clk/uniphier/clk-uniphier-fixed-rate.c     |    1 +
 drivers/clk/visconti/clkc-tmpv770x.c               |    2 +-
 drivers/clk/visconti/clkc.c                        |    2 +-
 drivers/clk/visconti/clkc.h                        |    3 +
 drivers/clk/zynq/clkc.c                            |   13 +-
 drivers/clk/zynqmp/clk-gate-zynqmp.c               |   12 +-
 drivers/clk/zynqmp/clk-mux-zynqmp.c                |    8 +-
 drivers/clk/zynqmp/divider.c                       |   12 +-
 drivers/clk/zynqmp/pll.c                           |   32 +-
 include/dt-bindings/clock/am3.h                    |   93 --
 include/dt-bindings/clock/am4.h                    |   98 --
 include/dt-bindings/clock/at91.h                   |    2 +
 include/dt-bindings/clock/cirrus,cs2000-cp.h       |   14 +
 include/dt-bindings/clock/dra7.h                   |  168 ----
 include/dt-bindings/clock/imx93-clock.h            |  201 ++++
 include/dt-bindings/clock/imxrt1050-clock.h        |   72 ++
 include/dt-bindings/clock/microchip,mpfs-clock.h   |   45 +
 include/dt-bindings/clock/qcom,dispcc-qcm2290.h    |   34 +
 include/dt-bindings/clock/qcom,dispcc-sm6125.h     |   41 +
 include/dt-bindings/clock/qcom,dispcc-sm6350.h     |   48 +
 include/dt-bindings/clock/qcom,gcc-ipq806x.h       |    5 +-
 include/dt-bindings/clock/qcom,gcc-sm8150.h        |    5 +
 include/dt-bindings/clock/qcom,gpucc-sm6350.h      |   37 +
 include/dt-bindings/clock/qcom,rpmcc.h             |    2 +
 include/dt-bindings/clock/r9a07g054-cpg.h          |  229 +++++
 include/dt-bindings/clock/sifive-fu540-prci.h      |    8 +-
 include/dt-bindings/clock/sifive-fu740-prci.h      |   18 +-
 include/dt-bindings/clock/starfive-jh7100-audio.h  |   41 +
 include/dt-bindings/reset/qcom,gcc-ipq806x.h       |    5 +
 include/linux/clk-provider.h                       |   15 +-
 include/linux/clk.h                                |   11 +
 include/linux/soc/qcom/smd-rpm.h                   |    1 +
 262 files changed, 12609 insertions(+), 4331 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/apple,nco.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/cirrus,cs2000-cp.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/cs2000-cp.txt
 create mode 100644 Documentation/devicetree/bindings/clock/imx93-clock.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/imxrt1050-clock.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/microchip,mpfs.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/qcom,camcc.txt
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,dispcc-sm6125.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,dispcc-sm6350.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-ipq8064.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,qcm2290-dispcc.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sdm845-camcc.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,9series.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh7100-audclk.yaml
 create mode 100644 drivers/clk/.kunitconfig
 create mode 100644 drivers/clk/clk-apple-nco.c
 create mode 100644 drivers/clk/clk-gate_test.c
 create mode 100644 drivers/clk/clk-renesas-pcie.c
 create mode 100644 drivers/clk/clk_test.c
 create mode 100644 drivers/clk/imx/clk-composite-93.c
 create mode 100644 drivers/clk/imx/clk-fracn-gppll.c
 create mode 100644 drivers/clk/imx/clk-imx8dxl-rsrc.c
 create mode 100644 drivers/clk/imx/clk-imx93.c
 create mode 100644 drivers/clk/imx/clk-imxrt1050.c
 create mode 100644 drivers/clk/mediatek/clk-pll.h
 create mode 100644 drivers/clk/microchip/Kconfig
 create mode 100644 drivers/clk/microchip/clk-mpfs.c
 create mode 100644 drivers/clk/qcom/dispcc-qcm2290.c
 create mode 100644 drivers/clk/qcom/dispcc-sm6125.c
 create mode 100644 drivers/clk/qcom/dispcc-sm6350.c
 create mode 100644 drivers/clk/qcom/gpucc-sm6350.c
 delete mode 100644 drivers/clk/sifive/fu540-prci.c
 delete mode 100644 drivers/clk/sifive/fu740-prci.c
 create mode 100644 drivers/clk/starfive/clk-starfive-jh7100-audio.c
 create mode 100644 drivers/clk/starfive/clk-starfive-jh7100.h
 delete mode 100644 drivers/clk/ti/clk-33xx-compat.c
 delete mode 100644 drivers/clk/ti/clk-43xx-compat.c
 delete mode 100644 drivers/clk/ti/clk-7xx-compat.c
 create mode 100644 include/dt-bindings/clock/cirrus,cs2000-cp.h
 create mode 100644 include/dt-bindings/clock/imx93-clock.h
 create mode 100644 include/dt-bindings/clock/imxrt1050-clock.h
 create mode 100644 include/dt-bindings/clock/microchip,mpfs-clock.h
 create mode 100644 include/dt-bindings/clock/qcom,dispcc-qcm2290.h
 create mode 100644 include/dt-bindings/clock/qcom,dispcc-sm6125.h
 create mode 100644 include/dt-bindings/clock/qcom,dispcc-sm6350.h
 create mode 100644 include/dt-bindings/clock/qcom,gpucc-sm6350.h
 create mode 100644 include/dt-bindings/clock/r9a07g054-cpg.h
 create mode 100644 include/dt-bindings/clock/starfive-jh7100-audio.h

-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

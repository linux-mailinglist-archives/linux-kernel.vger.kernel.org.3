Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB3858A417
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 02:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239745AbiHEAKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 20:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiHEAKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 20:10:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C63D18368;
        Thu,  4 Aug 2022 17:10:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67B1961956;
        Fri,  5 Aug 2022 00:10:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A531EC433C1;
        Fri,  5 Aug 2022 00:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659658230;
        bh=4gXwFib+hP/SHBsmpz5v7D7FEqiQA0ZHRLJHf8IudWo=;
        h=From:To:Cc:Subject:Date:From;
        b=G+hX13f7v6lg0hgtrle7gePQZKIEtqj0z/Qp0DC9yW3kQIQ4Ji40eW0rehowEb+in
         Tm6ZVd86/j764bRqU9J5lfyW9lcqs5C90pqwwExcBaZZl8EEs4Yb690xfIlbwzdhnu
         LVaou/vDGs1vJmSNqkYisFKCqllQkwAcDM5FcEH4AHtQcCKNoEv3aTHhfqE47j7qzK
         Lsp927GXnK//uJ2Pe079XGuQucsUMDhRrA9E6q5u4F4hpBhqi1brSY5FtgDl8VF2PD
         dMPpJVduLalM2or/s7LU/uU7Bv+y1q5cMFWRlwpJWUZh5DkA6KLtVBCdbMYAxVVRJl
         brR8494BWNaGg==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk changes for the merge window
Date:   Thu,  4 Aug 2022 17:10:29 -0700
Message-Id: <20220805001029.4036778-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        PP_MIME_FAKE_ASCII_TEXT,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 3d7cb6b04c3f3115719235cc6866b10326de34cd:

  Linux 5.19 (2022-07-31 14:03:01 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

for you to fetch changes up to 08fc500fe3d4b1f0603fb97ad353f246a3d52d2d:

  Merge branch 'clk-allwinner' into clk-next (2022-08-02 12:20:51 -0700)

----------------------------------------------------------------
The clk core gains a new set of APIs that allow drivers to both acquire clks
and prepare and enable them at the same time. This also comes with devm support
so that drivers can make a single call to get and prepare and enable the clk
and have that all undone when their driver is removed. Many folks have
requested this feature over the years, but we've had disagreements about how to
implement it and if it was worthwhile to encourage drivers to use such an API.
Now it's here, so let's see how it goes. I hope that by introducing this API we
can identify drivers that would benefit from further consolidation of clk API
usage, possibly by moving such logic to the bus layer and out of drivers
altogether.

Outside of that major API update, we have the usual collection of driver
updates. A few new SoCs are supported, mostly Qualcomm and Renesas this time
around. Then we have the long tail of non-critical fixes and minor feature
additions to various clk drivers. And finally more clk provider migration to
struct clk_parent_data, reducing boot times in the process.

Core:
 - devm helpers for clk_get() + clk_prepare() and clk_enable()

New Drivers:
 - Support for the camera clock controller in Qualcomm SM8450 and
   the display and gpu clock controllers in Qualcomm SM8350
 - Add support for the Renesas RZ/Five SoC

Updates:
 - Various fixes, new clocks and USB GDSCs are introduced for Qualcomm IPQ8074
 - Fixes to Qualcomm MSM8939 for issues introduced by inheriting the MSM8916
   GCC driver
 - Support for a new type of voteable GDSCs used by Qualcomm SC8280XP PCIe
   GDSCs
 - Qualcomm SC8280XP pipe clocks transitioned to the new phy-mux implementation
 - Qualcomm MSM8996 GCC, RPM clock driver and some clocks in MSM8994 GCC are
   migrated to use clk_parent_data
 - Corrected the topology for Titan (camera) GDSCs on Qualcomm SDM845 and
   SM8250
 - Qualcomm MSM8916 gains more possible frequencies for its GP clocks.
 - The GCC and tsens handling on Qualcomm MSM8960 is reworked to mimic the
   design in IPQ8074 to allow the GCC driver to probe earlier.
 - The regulator based mmcx supply for Qualcomm dispcc and videocc is dropped,
   as the only upstream target that adapted this interface was transitioned
   several kernel versions ago
 - Qualcomm GDSCs found to be enabled at boot will now reflect in the enable
   count of the supply, as was done with the regulator supplies previously
 - Correct adc1, nic_media and edma1's parents for NXP i.MX93
 - rdiv, mfd values, the return rate in recalc_rate and add more frequencies in
   the table for fracn-gppll on i.MX
 - Remove Allwinner workaround logic/compatible in fixed factor code
 - MediaTek clk driver cleanups
 - Add reset support to more MediaTek clk drivers
 - deduplicate Allwinner ccu_clks arrays
 - Allwinner H6 GPU DFS support
 - Adjust Allwinner Kconfig to limit choice
 - Fix initconst confusion on Renesas R-Car Gen4
 - Add GPT/POEG (PWM) clocks and resets on Renesas RZ/G2L
 - Add PFC and WDT clocks and resets on Renesas RZ/V2M
 - Add thermal, SDHI, Z (CPU core), PCIe, and HSCIF (serial) clocks on
   Renesas R-Car S4-8

----------------------------------------------------------------
Abel Vesa (1):
      clk: qcom: Drop mmcx gdsc supply for dispcc and videocc

Andi Kleen (1):
      clk: renesas: rcar-gen4: Fix initconst confusion for cpg_pll_config

Andy Shevchenko (1):
      clk: Remove never used devm_clk_*unregister()

Biju Das (3):
      clk: renesas: r9a07g044: Add GPT clock and reset entry
      clk: renesas: r9a07g044: Add POEG clock and reset entries
      clk: renesas: rzg2l: Fix reset status function

Bjorn Andersson (5):
      Merge tag '20220608105238.2973600-1-dmitry.baryshkov@linaro.org' into clk-for-5.20
      Merge branch '20220515210048.483898-8-robimarko@gmail.com' into clk-for-5.20
      Merge branch '20220701062622.2757831-2-vladimir.zapolskiy@linaro.org' into clk-for-5.20
      Merge branch '20220706154337.2026269-1-robert.foss@linaro.org' into clk-for-5.20
      clk: qcom: gdsc: Bump parent usage count when GDSC is found enabled

Bryan O'Donoghue (10):
      clk: qcom: gcc-msm8939: Add missing SYSTEM_MM_NOC_BFDCD_CLK_SRC
      clk: qcom: gcc-msm8939: Fix bimc_ddr_clk_src rcgr base address
      clk: qcom: gcc-msm8939: Add missing system_mm_noc_bfdcd_clk_src
      clk: qcom: gcc-msm8939: Point MM peripherals to system_mm_noc clock
      clk: qcom: gcc-msm8939: Fix weird field spacing in ftbl_gcc_camss_cci_clk
      clk: qcom: gcc-msm8939: Add missing CAMSS CCI bus clock
      clk: qcom: gcc-msm8939: Fix venus0_vcodec0_clk frequency definitions
      clk: qcom: gcc-msm8939: Add missing CAMSS CPP clock frequencies
      clk: qcom: gcc-msm8939: Add missing MDSS MDP clock frequencies
      clk: qcom: gcc-msm8939: Add missing USB HS system clock frequencies

Christian Marangi (5):
      clk: qcom: clk-hfpll: use poll_timeout macro
      clk: qcom: clk-krait: unlock spin after mux completion
      clk: qcom: clk-krait: add apq/ipq8064 errata workaround
      dt-bindings: clock: fix wrong clock documentation for qcom,rpmcc
      clk: qcom: clk-rpm: convert to parent_data API

Cixi Geng (2):
      dt-bindings: clk: sprd: Add bindings for ums512 clock controller
      clk: sprd: Add dt-bindings include file for UMS512

Dmitry Baryshkov (11):
      clk: qcom: mmcc-msm8996: use ARRAY_SIZE instead of specifying num_parents
      clk: qcom: mmcc-msm8996: move clock parent tables down
      clk: qcom: mmcc-msm8996: use parent_hws/_data instead of parent_names
      clk: qcom: regmap: add PHY clock source implementation
      clk: qcom: gcc-sm8450: use new clk_regmap_phy_mux_ops for PCIe pipe clocks
      clk: qcom: gcc-sc7280: use new clk_regmap_phy_mux_ops for PCIe pipe clocks
      dt-bindings: clock: qcom,gcc-apq8064: move msm8960 compat from gcc-other.yaml
      dt-bindings: clock: qcom,gcc-apq8064: split tsens to the child node
      clk: qcom: gcc-msm8960: create tsens device if there are no child nodes
      dt-bindings: clock: qcom,gcc-msm8996: add more GCC clock sources
      clk: qcom: gcc-msm8994: use parent_hws for gpll0/4

Geert Uytterhoeven (9):
      clk: renesas: r8a73a4: Remove r8a73a4_cpg.reg
      clk: renesas: r8a7740: Remove r8a7740_cpg.reg
      clk: renesas: sh73a0: Remove sh73a0_cpg.reg
      clk: renesas: r8a7778: Remove struct r8a7778_cpg
      clk: renesas: r8a7779: Remove struct r8a7779_cpg
      clk: renesas: rza1: Remove struct rz_cpg
      dt-bindings: clock: renesas,rzg2l: Simplify header file references
      clk: renesas: r8a779f0: Add Z0 and Z1 clock support
      Merge tag 'renesas-r9a07g043-dt-binding-defs-tag2' into HEAD

Haibo Chen (1):
      clk: imx93: use adc_root as the parent clock of adc1

Jacky Bai (1):
      clk: imx93: Correct the edma1's parent clock

Johan Hovold (4):
      clk: qcom: gdsc: add collapse-bit helper
      clk: qcom: gdsc: add support for collapse-vote registers
      clk: qcom: gcc-sc8280xp: use collapse-voting for PCIe GDSCs
      clk: qcom: gcc-sc8280xp: use phy-mux clock for PCIe

Jonathan Marek (1):
      clk: qcom: add support for SM8350 DISPCC

Krzysztof Kozlowski (1):
      dt-bindings: clock: qcom,gcc-sdm845: add parent power domain

Lad Prabhakar (2):
      dt-bindings: clock: r9a07g043-cpg: Add Renesas RZ/Five CPG Clock and Reset Definitions
      clk: renesas: r9a07g043: Add support for RZ/Five SoC

Li kunyu (1):
      clk: qcom: gcc-sm6350: Drop extra semicolon

Liu Ying (1):
      clk: imx: clk-fracn-gppll: Return rate in rate table properly in ->recalc_rate()

Marijn Suijten (3):
      clk: divider: Introduce devm_clk_hw_register_divider_parent_hw()
      clk: mux: Introduce devm_clk_hw_register_mux_parent_hws()
      clk: fixed-factor: Introduce *clk_hw_register_fixed_factor_parent_hw()

Matthias Brugger (2):
      dt-bindings: ARM: Mediatek: Remove msdc binding of MT8192 clock
      clk: mediatek: Delete MT8192 msdc gate

Nikita Travkin (3):
      clk: qcom: clk-rcg2: Fail Duty-Cycle configuration if MND divider is not enabled.
      clk: qcom: clk-rcg2: Make sure to not write d=0 to the NMD register
      clk: qcom: gcc-msm8916: Add rates to the GP clocks

Peng Fan (4):
      clk: imx93: correct nic_media parent
      clk: imx: clk-fracn-gppll: fix mfd value
      clk: imx: clk-fracn-gppll: correct rdiv
      clk: imx: clk-fracn-gppll: Add more freq config for video pll

Phil Edworthy (2):
      clk: renesas: r9a09g011: Add PFC clock and reset entries
      clk: renesas: r9a09g011: Add WDT clock and reset entries

Ralph Siemsen (2):
      clk: renesas: r9a06g032: Drop some unused fields
      clk: renesas: r9a06g032: Fix UART clkgrp bitsel

Ren Zhijie (1):
      clk: qcom: fix build error initializer element is not constant

Rex-BC Chen (17):
      clk: mediatek: reset: Add reset.h
      clk: mediatek: reset: Fix written reset bit offset
      clk: mediatek: reset: Refine and reorder functions in reset.c
      clk: mediatek: reset: Extract common drivers to update function
      clk: mediatek: reset: Merge and revise reset register function
      clk: mediatek: reset: Revise structure to control reset register
      clk: mediatek: reset: Support nonsequence base offsets of reset registers
      clk: mediatek: reset: Support inuput argument index mode
      clk: mediatek: reset: Change return type for clock reset register function
      clk: mediatek: reset: Add new register reset function with device
      clk: mediatek: reset: Add reset support for simple probe
      dt-bindings: arm: mediatek: Add #reset-cells property for MT8192/MT8195
      dt-bindings: reset: mediatek: Add infra_ao reset index for MT8192/MT8195
      clk: mediatek: reset: Add infra_ao reset support for MT8192/MT8195
      dt-bindings: reset: mediatek: Add infra_ao reset index for MT8186
      dt-bindings: arm: mediatek: Add #reset-cells property for MT8186
      clk: mediatek: reset: Add infra_ao reset support for MT8186

Robert Foss (1):
      clk: qcom: add support for SM8350 GPUCC

Robert Marko (9):
      clk: qcom: ipq8074: fix NSS core PLL-s
      clk: qcom: ipq8074: SW workaround for UBI32 PLL lock
      clk: qcom: ipq8074: fix NSS port frequency tables
      dt-bindings: clock: qcom: ipq8074: add PPE crypto clock
      clk: qcom: ipq8074: add PPE crypto clock
      clk: qcom: ipq8074: set BRANCH_HALT_DELAY flag for UBI clocks
      dt-bindings: clocks: qcom,gcc-ipq8074: support power domains
      clk: qcom: ipq8074: add USB GDSCs
      clk: qcom: ipq8074: dont disable gcc_sleep_clk_src

Roman Stratiienko (1):
      clk: sunxi-ng: sun50i: h6: Modify GPU clock configuration to support DFS

Samuel Holland (5):
      clk: sunxi-ng: Deduplicate ccu_clks arrays
      clk: fixed: Remove Allwinner A10 special-case logic
      dt-bindings: clock: fixed-factor: Drop Allwinner A10 compatible
      clk: sunxi: Limit legacy clocks to 32-bit ARM
      clk: sunxi: Do not select the PRCM MFD

Stephen Boyd (9):
      Merge tag 'renesas-clk-for-v5.20-tag1' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers into clk-renesas
      clk: qcom: rpmh: Add note about sleep/wake state for BCMs
      Merge tag 'renesas-clk-for-v5.20-tag2' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers into clk-renesas
      Merge tag 'sunxi-clk-for-5.20-1' of https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux into clk-allwinner
      Merge tag 'clk-imx-5.20' of git://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux into clk-imx
      Merge tag 'qcom-clk-for-5.20' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into clk-qcom
      Merge branches 'clk-basic', 'clk-mtk', 'clk-devm-enable' and 'clk-ti-dt' into clk-next
      Merge branches 'clk-renesas', 'clk-spreadtrum', 'clk-imx' and 'clk-qcom' into clk-next
      Merge branch 'clk-allwinner' into clk-next

Tony Lindgren (1):
      clk: ti: Stop using legacy clkctrl names for omap4 and 5

Uwe Kleine-König (5):
      clk: Improve documentation for devm_clk_get() and its optional variant
      clk: generalize devm_clk_get() a bit
      clk: Provide new devm_clk helpers for prepared and enabled clocks
      clk: meson: axg-audio: Don't duplicate devm_clk_get_enabled()
      clk: Fix pointer casting to prevent oops in devm_clk_release()

Vladimir Zapolskiy (8):
      clk: qcom: camcc-sm8250: Fix halt on boot by reducing driver's init level
      clk: qcom: camcc-sdm845: Fix topology around titan_top power domain
      clk: qcom: camcc-sm8250: Fix topology around titan_top power domain
      clk: qcom: clk-alpha-pll: fix clk_trion_pll_configure description
      clk: qcom: clk-alpha-pll: limit exported symbols to GPL licensed code
      clk: qcom: clk-alpha-pll: add Lucid EVO PLL configuration interfaces
      clk: qcom: clk-alpha-pll: add Rivian EVO PLL configuration interfaces
      clk: qcom: add camera clock controller driver for SM8450 SoC

Wolfram Sang (3):
      clk: renesas: r8a779f0: Add thermal clock
      clk: renesas: r8a779f0: Add SDHI0 clock
      clk: renesas: r8a779f0: Add HSCIF clocks

Yoshihiro Shimoda (1):
      clk: renesas: r8a779f0: Add PCIe clocks

 .../arm/mediatek/mediatek,mt8186-sys-clock.yaml    |    3 +
 .../arm/mediatek/mediatek,mt8192-clock.yaml        |    8 -
 .../arm/mediatek/mediatek,mt8192-sys-clock.yaml    |    3 +
 .../arm/mediatek/mediatek,mt8195-sys-clock.yaml    |    3 +
 .../bindings/clock/fixed-factor-clock.yaml         |    1 -
 .../bindings/clock/qcom,dispcc-sm8x50.yaml         |    6 +-
 .../bindings/clock/qcom,gcc-apq8064.yaml           |   40 +-
 .../bindings/clock/qcom,gcc-ipq8074.yaml           |    5 +
 .../bindings/clock/qcom,gcc-msm8996.yaml           |   16 +
 .../devicetree/bindings/clock/qcom,gcc-other.yaml  |    5 +-
 .../devicetree/bindings/clock/qcom,gcc-sdm845.yaml |    3 +
 .../bindings/clock/qcom,gpucc-sm8350.yaml          |   72 +
 .../devicetree/bindings/clock/qcom,rpmcc.yaml      |   85 +-
 .../bindings/clock/qcom,sm8450-camcc.yaml          |   80 +
 .../bindings/clock/renesas,rzg2l-cpg.yaml          |    7 +-
 .../devicetree/bindings/clock/sprd,ums512-clk.yaml |   71 +
 drivers/clk/clk-devres.c                           |   91 +-
 drivers/clk/clk-fixed-factor.c                     |   56 +-
 drivers/clk/clk.c                                  |   48 -
 drivers/clk/imx/clk-fracn-gppll.c                  |   36 +-
 drivers/clk/imx/clk-imx93.c                        |    6 +-
 drivers/clk/mediatek/clk-mt2701-eth.c              |   10 +-
 drivers/clk/mediatek/clk-mt2701-g3d.c              |   10 +-
 drivers/clk/mediatek/clk-mt2701-hif.c              |   10 +-
 drivers/clk/mediatek/clk-mt2701.c                  |   22 +-
 drivers/clk/mediatek/clk-mt2712.c                  |   22 +-
 drivers/clk/mediatek/clk-mt7622-eth.c              |   10 +-
 drivers/clk/mediatek/clk-mt7622-hif.c              |   12 +-
 drivers/clk/mediatek/clk-mt7622.c                  |   22 +-
 drivers/clk/mediatek/clk-mt7629-eth.c              |   10 +-
 drivers/clk/mediatek/clk-mt7629-hif.c              |   12 +-
 drivers/clk/mediatek/clk-mt8135.c                  |   22 +-
 drivers/clk/mediatek/clk-mt8173.c                  |   22 +-
 drivers/clk/mediatek/clk-mt8183.c                  |   18 +-
 drivers/clk/mediatek/clk-mt8186-infra_ao.c         |   23 +
 drivers/clk/mediatek/clk-mt8192-msdc.c             |   21 -
 drivers/clk/mediatek/clk-mt8192.c                  |   29 +
 drivers/clk/mediatek/clk-mt8195-infra_ao.c         |   24 +
 drivers/clk/mediatek/clk-mtk.c                     |    7 +
 drivers/clk/mediatek/clk-mtk.h                     |    9 +-
 drivers/clk/mediatek/reset.c                       |  198 +-
 drivers/clk/mediatek/reset.h                       |   82 +
 drivers/clk/meson/axg-audio.c                      |   36 +-
 drivers/clk/qcom/Kconfig                           |   22 +-
 drivers/clk/qcom/Makefile                          |    3 +
 drivers/clk/qcom/camcc-sdm845.c                    |    4 +
 drivers/clk/qcom/camcc-sm8250.c                    |   16 +-
 drivers/clk/qcom/camcc-sm8450.c                    | 2856 ++++++++++++++++++++
 drivers/clk/qcom/clk-alpha-pll.c                   |  144 +-
 drivers/clk/qcom/clk-alpha-pll.h                   |   11 +-
 drivers/clk/qcom/clk-hfpll.c                       |   15 +-
 drivers/clk/qcom/clk-krait.c                       |   23 +-
 drivers/clk/qcom/clk-krait.h                       |    1 +
 drivers/clk/qcom/clk-rcg2.c                        |   16 +-
 drivers/clk/qcom/clk-regmap-phy-mux.c              |   62 +
 drivers/clk/qcom/clk-regmap-phy-mux.h              |   33 +
 drivers/clk/qcom/clk-rpm.c                         |   24 +-
 drivers/clk/qcom/clk-rpmh.c                        |    5 +
 drivers/clk/qcom/dispcc-sm8250.c                   |   64 +-
 drivers/clk/qcom/gcc-ipq8074.c                     |  104 +-
 drivers/clk/qcom/gcc-msm8916.c                     |   35 +
 drivers/clk/qcom/gcc-msm8939.c                     |   47 +-
 drivers/clk/qcom/gcc-msm8960.c                     |    6 +-
 drivers/clk/qcom/gcc-msm8994.c                     |    8 +-
 drivers/clk/qcom/gcc-sc7280.c                      |   49 +-
 drivers/clk/qcom/gcc-sc8280xp.c                    |  142 +-
 drivers/clk/qcom/gcc-sm6350.c                      |    2 +-
 drivers/clk/qcom/gcc-sm8450.c                      |   49 +-
 drivers/clk/qcom/gdsc.c                            |   36 +-
 drivers/clk/qcom/gdsc.h                            |    4 +
 drivers/clk/qcom/gpucc-sm8350.c                    |  637 +++++
 drivers/clk/qcom/krait-cc.c                        |    8 +
 drivers/clk/qcom/mmcc-msm8996.c                    | 1052 ++++---
 drivers/clk/qcom/videocc-sm8250.c                  |    4 -
 drivers/clk/renesas/clk-r8a73a4.c                  |   22 +-
 drivers/clk/renesas/clk-r8a7740.c                  |   20 +-
 drivers/clk/renesas/clk-r8a7778.c                  |   31 +-
 drivers/clk/renesas/clk-r8a7779.c                  |   27 +-
 drivers/clk/renesas/clk-rz.c                       |   33 +-
 drivers/clk/renesas/clk-sh73a0.c                   |   26 +-
 drivers/clk/renesas/r8a779f0-cpg-mssr.c            |   10 +
 drivers/clk/renesas/r9a06g032-clocks.c             |   32 +-
 drivers/clk/renesas/r9a07g043-cpg.c                |   32 +
 drivers/clk/renesas/r9a07g044-cpg.c                |   17 +-
 drivers/clk/renesas/r9a09g011-cpg.c                |    5 +
 drivers/clk/renesas/rcar-gen4-cpg.c                |    2 +-
 drivers/clk/renesas/rzg2l-cpg.c                    |    2 +-
 drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c             |   15 +-
 drivers/clk/sunxi-ng/ccu-sun50i-h6.c               |   16 +-
 drivers/clk/sunxi-ng/ccu-sun8i-de2.c               |   77 +-
 drivers/clk/sunxi-ng/ccu-sun8i-h3.c                |  113 +-
 drivers/clk/sunxi-ng/ccu-sun8i-r.c                 |   40 +-
 drivers/clk/sunxi-ng/ccu-sun8i-v3s.c               |   80 +-
 drivers/clk/sunxi/Kconfig                          |    4 +-
 drivers/clk/ti/clk-44xx.c                          |  210 +-
 drivers/clk/ti/clk-54xx.c                          |  160 +-
 drivers/clk/ti/clkctrl.c                           |    4 -
 include/dt-bindings/clock/qcom,dispcc-sm8350.h     |    1 +
 include/dt-bindings/clock/qcom,gcc-ipq8074.h       |    4 +
 include/dt-bindings/clock/qcom,gcc-msm8939.h       |    1 +
 include/dt-bindings/clock/qcom,gpucc-sm8350.h      |   52 +
 include/dt-bindings/clock/qcom,sm8450-camcc.h      |  159 ++
 include/dt-bindings/clock/r9a07g043-cpg.h          |   20 +
 include/dt-bindings/clock/sprd,ums512-clk.h        |  397 +++
 include/dt-bindings/reset/mt8186-resets.h          |    5 +
 include/dt-bindings/reset/mt8192-resets.h          |    8 +
 include/dt-bindings/reset/mt8195-resets.h          |    6 +
 include/linux/clk-provider.h                       |   36 +-
 include/linux/clk.h                                |  134 +-
 109 files changed, 7067 insertions(+), 1492 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,gpucc-sm8350.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
 create mode 100644 drivers/clk/mediatek/reset.h
 create mode 100644 drivers/clk/qcom/camcc-sm8450.c
 create mode 100644 drivers/clk/qcom/clk-regmap-phy-mux.c
 create mode 100644 drivers/clk/qcom/clk-regmap-phy-mux.h
 create mode 100644 drivers/clk/qcom/gpucc-sm8350.c
 create mode 120000 include/dt-bindings/clock/qcom,dispcc-sm8350.h
 create mode 100644 include/dt-bindings/clock/qcom,gpucc-sm8350.h
 create mode 100644 include/dt-bindings/clock/qcom,sm8450-camcc.h
 create mode 100644 include/dt-bindings/clock/sprd,ums512-clk.h

-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

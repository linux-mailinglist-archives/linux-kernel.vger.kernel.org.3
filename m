Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 561E648CDCB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 22:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbiALV26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 16:28:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiALV25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 16:28:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5FB8C06173F;
        Wed, 12 Jan 2022 13:28:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5F47BB8211B;
        Wed, 12 Jan 2022 21:28:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1613C36AE9;
        Wed, 12 Jan 2022 21:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642022934;
        bh=oxdjZBMyx19pIA18ebJD4BZ8Eyfa2ZqKr/tNRiE/6EA=;
        h=From:To:Cc:Subject:Date:From;
        b=Nt5DfCW4cw9Zd0rb7fD482uFbENr2aXQosGyMZeE6dmH+TCBW2wTFw39EHLvibH6o
         fqWxbx7BQiLeLqraonfpG/FEeKSzVJm/scOpJ4/FWL1Ecgt6xrFDRGPGQPwEmpxWIF
         PveEWyxE0Th5CqHDAigElHGi0pwg000XK5gXmShNY4Vcmk+LzDoAQqr2Q8orclRXG3
         iIsjiDgmkzC7OU4DOcNyO3dL9C/a7kPWxVsoo7lsHpOa3YGiNSZ69+o3lrTO5LIKXy
         UljZv1LEUgPjojDYz4KZ1N3VPvQTWF6Hjex5XJtphF7O9HTcuaH1QuaemWv/Oj/cVU
         8f2k5ZgTVuiYA==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk changes for the merge window
Date:   Wed, 12 Jan 2022 13:28:53 -0800
Message-Id: <20220112212853.2401468-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.34.1.575.g55b058a8bb-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 72a0ca203ca7fae34fe61668906fe483b97d9039:

  dt-bindings: clock: Add SM8450 GCC clock bindings (2021-12-14 21:19:13 -0600)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

for you to fetch changes up to 4afd2a9355a9deb16ea42b896820dacf49843a8f:

  Merge branches 'clk-ingenic' and 'clk-mediatek' into clk-next (2022-01-11 18:31:00 -0800)

----------------------------------------------------------------
We have a couple patches in the framework core this time around but
they're mostly minor cleanups and some debugfs stuff. The real work
that's in here is the typical pile of clk driver updates and new SoC
support. Per usual (or maybe just recent trends), Qualcomm gains a
handful of SoC drivers additions and has the largest diffstat. After
that there are quite a few updates to the Allwinner (sunxi) drivers to
support modular drivers and Renesas is heavily updated to add more
support for various clks. Overall it looks pretty normal.

New Drivers:
 - Add MDMA and BDMA clks to Ingenic JZ4760 and JZ4770
 - MediaTek mt7986 SoC basic support
 - Clock and reset driver for Toshiba Visconti SoCs
 - Initial clock driver for the Exynos7885 SoC (Samsung Galaxy A8)
 - Allwinner D1 clks
 - Lan966x Generic Clock Controller driver and associated DT bindings
 - Qualcomm SDX65, SM8450, and MSM8976 GCC clks
 - Qualcomm SDX65 and SM8450 RPMh clks

Updates:
 - Set suppress_bind_attrs to true for i.MX8ULP driver
 - Switch from do_div to div64_ul for throughout all i.MX drivers
 - Fix imx8mn_clko1_sels for i.MX8MN
 - Remove unused IPG_AUDIO_ROOT from i.MX8MP
 - Switch parent for audio_root_clk to audio ahb in i.MX8MP driver
 - Removal of all remaining uses of __clk_lookup() in drivers/clk/samsung
 - Refactoring of the CPU clocks registration to use common interface
 - An update of the Exynos850 driver (support for more clock domains)
   required by the E850-96 development board
 - Prep for runtime PM and generic power domains on Tegra
 - Support modular Allwinner clk drivers via platform bus
 - Lan966x clock driver extended to support clock gating
 - Add serial (SCI1), watchdog (WDT), timer (OSTM), SPI (RSPI), and
   thermal (TSU) clocks and resets on Renesas RZ/G2L
 - Rework SDHI clock handling in the Renesas R-Car Gen3 and RZ/G2 clock
   drivers, and in the Renesas SDHI driver
 - Make the Cortex-A55 (I) clock on Renesas RZ/G2L programmable
 - Document support for the new Renesas R-Car S4-8 (R8A779F0) SoC
 - Add support for the new Renesas R-Car S4-8 (R8A779F0) SoC
 - Add GPU clock and resets on Renesas RZ/G2L
 - Add clk-provider.h to various Qualcomm clk drivers
 - devm version of clk_hw_register_gate()
 - kerneldoc fixes in a couple drivers

----------------------------------------------------------------
Adam Ford (1):
      clk: imx8mn: Fix imx8mn_clko1_sels

Ajit Kumar Pandey (5):
      x86: clk: clk-fch: Add support for newer family of AMD's SOC
      drivers: acpi: acpi_apd: Remove unused device property "is-rv"
      ACPI: APD: Add a fmw property clk-name
      clk: x86: Use dynamic con_id string during clk registration
      clk: x86: Fix clk_gate_flags for RV_CLK_GATE

Alain Volmat (2):
      clk: st: clkgen-fsyn: search reg within node or parent
      clk: st: clkgen-mux: search reg within node or parent

AngeloGioacchino Del Regno (3):
      clk: qcom: Add MSM8976/56 Global Clock Controller (GCC) driver
      clk: mediatek: clk-gate: Shrink by adding clockgating bit check helper
      clk: mediatek: clk-gate: Use regmap_{set/clear}_bits helpers

Biju Das (9):
      clk: renesas: r9a07g044: Add WDT clock and reset entries
      clk: renesas: r9a07g044: Rename CLK_PLL2_DIV16 and CLK_PLL2_DIV20 macros
      clk: renesas: r9a07g044: Add OSTM clock and reset entries
      clk: renesas: rzg2l: Add CPG_PL1_DDIV macro
      clk: renesas: r9a07g044: Change core clock "I" from DEF_FIXED->DEF_DIV
      clk: renesas: r9a07g044: Add TSU clock and reset entry
      clk: renesas: r9a07g044: Rename CLK_PLL3_DIV4 macro
      clk: renesas: r9a07g044: Add mux and divider for G clock
      clk: renesas: r9a07g044: Add GPU clock and reset entries

Bjorn Andersson (3):
      MAINTAINERS: Add entry for Qualcomm clock drivers
      Merge tag 'e15509b2b7c9b600ab38c5269d4fac609c077b5b.1638861860.git.quic_vamslank@quicinc.com' into clk-for-5.17
      Merge tag '20211207114003.100693-2-vkoul@kernel.org' into clk-for-5.17

Cai Huoqing (2):
      clk: socfpga: agilex: Make use of the helper function devm_platform_ioremap_resource()
      clk: socfpga: s10: Make use of the helper function devm_platform_ioremap_resource()

Changcheng Deng (1):
      clk: imx: Use div64_ul instead of do_div

Colin Ian King (4):
      clk/ti/adpll: Make const pointer error a static const array
      clk: stm32mp1: remove redundant assignment to pointer data
      clk: socfpga: remove redundant assignment on division
      clk: socfpga: remove redundant assignment after a mask operation

Conor Dooley (1):
      clk: bm1880: remove kfrees on static allocations

David Virag (5):
      dt-bindings: clock: Add bindings definitions for Exynos7885 CMU
      dt-bindings: clock: Document Exynos7885 CMU bindings
      clk: samsung: Make exynos850_register_cmu shared
      clk: samsung: clk-pll: Add support for pll1417x
      clk: samsung: Add initial Exynos7885 clock driver

Dillon Min (1):
      clk: stm32: Fix ltdc's clock turn off by clk_disable_unused() after system enter shell

Dmitry Osipenko (2):
      clk: tegra: Make vde a child of pll_p on tegra114
      clk: tegra: Support runtime PM and power domain

Geert Uytterhoeven (3):
      clk: renesas: rzg2l: Add missing kerneldoc for resets
      mmc: renesas_sdhi: Use devm_clk_get_optional() to obtain CD clock
      Merge tag 'renesas-r8a779f0-dt-binding-defs-tag' into HEAD

Hans de Goede (1):
      clk: Introduce clk-tps68470 driver

Horatiu Vultur (4):
      clk: gate: Add devm_clk_hw_register_gate()
      dt-bindings: clock: lan966x: Extend for clock gate support
      dt-bindings: clock: lan966x: Extend includes with clock gates
      clk: lan966x: Extend lan966x clock driver for clock gating support

Hui Wang (2):
      clk: imx8mp: Remove IPG_AUDIO_ROOT from imx8mp-clock.h
      clk: imx8mp: Fix the parent clk of the audio_root_clk

Kavyasree Kotagiri (3):
      dt-bindings: clock: lan966x: Add binding includes for lan966x SoC clock IDs
      dt-bindings: clock: lan966x: Add LAN966X Clock Controller
      clk: lan966x: Add lan966x SoC clock driver

Lad Prabhakar (6):
      clk: renesas: r9a07g044: Add clock and reset entry for SCI1
      clk: renesas: r9a07g044: Add RSPI clock and reset entries
      clk: renesas: rzg2l: Check return value of pm_genpd_init()
      clk: renesas: rzg2l: propagate return value of_genpd_add_provider_simple()
      clk: renesas: cpg-mssr: Check return value of pm_genpd_init()
      clk: renesas: cpg-mssr: propagate return value of_genpd_add_provider_simple()

Marek Szyprowski (2):
      dt-bindings: clock: samsung: add IDs for some core clocks
      clk: samsung: remove __clk_lookup() usage

Marijn Suijten (1):
      dt-bindings: clk: qcom: Document MSM8976 Global Clock Controller

Martin Blumenstingl (1):
      clk: meson: gxbb: Fix the SDM_EN bit for MPLL0 on GXBB

Nathan Chancellor (1):
      clk: visconti: Remove pointless NULL check in visconti_pll_add_lookup()

Nobuhiro Iwamatsu (4):
      dt-bindings: clock: Add DT bindings for PLL of Toshiba Visconti TMPV770x SoC
      dt-bindings: clock: Add DT bindings for SMU of Toshiba Visconti TMPV770x SoC
      clk: visconti: Add support common clock driver and reset driver
      MAINTAINERS: Add entries for Toshiba Visconti PLL and clock controller

Paul Cercueil (2):
      dt-bindings: clk/ingenic: Add MDMA and BDMA clocks
      clk: ingenic: Add MDMA and BDMA clocks

Peng Fan (1):
      clk: imx: imx8ulp: set suppress_bind_attrs to true

Randy Dunlap (2):
      clk: imx: pllv1: fix kernel-doc notation for struct clk_pllv1
      clk: Gemini: fix struct name in kernel-doc

Sam Protsenko (9):
      dt-bindings: clock: Add bindings for Exynos850 CMU_APM
      clk: samsung: exynos850: Implement CMU_APM domain
      dt-bindings: clock: Add bindings for Exynos850 CMU_CMGP
      clk: samsung: exynos850: Implement CMU_CMGP domain
      clk: samsung: exynos850: Keep some crucial clocks running
      clk: samsung: exynos850: Register clocks early
      clk: Add write operation for clk_parent debugfs node
      dt-bindings: clock: Add bindings for Exynos850 sysreg clocks
      clk: samsung: exynos850: Add missing sysreg clocks

Sam Shih (3):
      dt-bindings: clock: mediatek: document clk bindings for mediatek mt7986 SoC
      clk: mediatek: add mt7986 clock IDs
      clk: mediatek: add mt7986 clock support

Samuel Holland (10):
      clk: sunxi-ng: Export symbols used by CCU drivers
      clk: sunxi-ng: Allow drivers to be built as modules
      clk: sunxi-ng: Convert early providers to platform drivers
      clk: sunxi-ng: Allow the CCU core to be built as a module
      dt-bindings: clk: Add compatibles for D1 CCUs
      clk: sunxi-ng: div: Add macros using clk_parent_data and clk_hw
      clk: sunxi-ng: mp: Add macros using clk_parent_data and clk_hw
      clk: sunxi-ng: mux: Add macros using clk_parent_data and clk_hw
      clk: sunxi-ng: gate: Add macros for gates with fixed dividers
      clk: sunxi-ng: Add support for the D1 SoC clocks

Shawn Guo (3):
      clk: qcom: smd-rpm: Drop MFD qcom-rpm reference
      clk: qcom: smd-rpm: Drop the use of struct rpm_cc
      clk: qcom: smd-rpm: Drop binary value handling for buffered clock

Shubhrajyoti Datta (1):
      clk: zynq: pll: Fix kernel-doc warnings

Stephen Boyd (18):
      Merge tag 'renesas-clk-for-v5.17-tag1' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers into clk-renesas
      Merge tag 'clk-at91-5.17' of git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux into clk-at91
      clk: clk_core_get() can also return NULL
      clk: __clk_core_init() never takes NULL
      clk: Emit a stern warning with writable debugfs enabled
      Merge tag 'platform-drivers-x86-int3472-1' of git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86 into clk-x86
      Merge tag 'clk-meson-v5.17-1' of https://github.com/BayLibre/clk-meson into clk-amlogic
      Merge tag 'sunxi-clk-for-5.17-1' of https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux into clk-allwinner
      Merge tag 'renesas-clk-for-v5.17-tag2' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers into clk-renesas
      Merge tag 'for-5.17-clk' of git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux into clk-nvidia
      Merge tag 'clk-imx-5.17' of git://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux into clk-imx
      Merge tag 'clk-v5.17-samsung' of https://git.kernel.org/pub/scm/linux/kernel/git/snawrocki/clk into clk-samsung
      Merge tag 'qcom-clk-for-5.17' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into clk-qcom
      Merge branches 'clk-doc', 'clk-renesas', 'clk-at91', 'clk-cleanup' and 'clk-debugfs' into clk-next
      Merge branches 'clk-x86', 'clk-stm', 'clk-amlogic' and 'clk-allwinner' into clk-next
      Merge branches 'clk-nvidia', 'clk-imx', 'clk-samsung' and 'clk-qcom' into clk-next
      Merge branches 'clk-socfpga', 'clk-toshiba', 'clk-st' and 'clk-bitmain' into clk-next
      Merge branches 'clk-ingenic' and 'clk-mediatek' into clk-next

Sudeep Holla (1):
      clk: Drop unused COMMON_CLK_STM32MP157_SCMI config

Sylwester Nawrocki (1):
      clk: samsung: Remove meaningless __init and extern from header files

Taniya Das (3):
      clk: qcom: clk-alpha-pll: Increase PLL lock detect poll time
      clk: qcom: gcc-sc7280: Mark gcc_cfg_noc_lpass_clk always enabled
      clk: Enable/Disable runtime PM for clk_summary

Vamsi Krishna Lanka (2):
      clk: qcom: Add LUCID_EVO PLL type for SDX65
      clk: qcom: Add SDX65 GCC support

Vamsi krishna Lanka (2):
      dt-bindings: clock: Introduce RPMHCC bindings for SDX65
      clk: qcom: Add support for SDX65 RPMh clocks

Vinod Koul (11):
      dt-bindings: clock: Add RPMHCC bindings for SM8450
      clk: qcom: rpmh: add support for SM8450 rpmh clocks
      clk: qcom: Add clock driver for SM8450
      clk: qcom: gcc-sm8350: explicitly include clk-provider.h
      clk: qcom: gcc-msm8994: explicitly include clk-provider.h
      clk: qcom: gcc-sm6350: explicitly include clk-provider.h
      clk: qcom: lpasscc-sc7280: explicitly include clk-provider.h
      clk: qcom: lpasscc-sdm845: explicitly include clk-provider.h
      clk: qcom: mmcc-apq8084: explicitly include clk-provider.h
      clk: qcom: q6sstop-qcs404: explicitly include clk-provider.h
      clk: qcom: turingcc-qcs404: explicitly include clk-provider.h

Will McVicker (1):
      clk: samsung: Update CPU clk registration

Wolfram Sang (9):
      clk: renesas: rcar-gen3: Add dummy SDnH clock
      clk: renesas: rcar-gen3: Add SDnH clock
      clk: renesas: r8a779a0: Add SDnH clock to V3U
      mmc: renesas_sdhi: Flag non-standard SDnH handling for V3M
      clk: renesas: rcar-gen3: Switch to new SD clock handling
      clk: renesas: rcar-gen3: Remove outdated SD_SKIP_FIRST
      mmc: renesas_sdhi: Use dev_err_probe when getting clock fails
      mmc: renesas_sdhi: Parse DT for SDnH
      mmc: renesas_sdhi: Simplify an expression

Yoshihiro Shimoda (3):
      dt-bindings: clock: renesas,cpg-mssr: Document r8a779f0
      clk: renesas: rcar-gen4: Introduce R-Car Gen4 CPG driver
      clk: renesas: cpg-mssr: Add support for R-Car S4-8

 .../bindings/arm/mediatek/mediatek,apmixedsys.txt  |    1 +
 .../bindings/arm/mediatek/mediatek,ethsys.txt      |    1 +
 .../bindings/arm/mediatek/mediatek,infracfg.txt    |    1 +
 .../bindings/arm/mediatek/mediatek,sgmiisys.txt    |    2 +
 .../bindings/arm/mediatek/mediatek,topckgen.txt    |    1 +
 .../bindings/clock/allwinner,sun4i-a10-ccu.yaml    |    4 +
 .../bindings/clock/microchip,lan966x-gck.yaml      |   60 +
 .../bindings/clock/qcom,gcc-msm8976.yaml           |   97 +
 .../devicetree/bindings/clock/qcom,gcc-sdx65.yaml  |   80 +
 .../devicetree/bindings/clock/qcom,rpmhcc.yaml     |    2 +
 .../bindings/clock/renesas,cpg-mssr.yaml           |    1 +
 .../bindings/clock/samsung,exynos7885-clock.yaml   |  166 +
 .../bindings/clock/samsung,exynos850-clock.yaml    |   38 +
 .../bindings/clock/toshiba,tmpv770x-pipllct.yaml   |   57 +
 .../bindings/clock/toshiba,tmpv770x-pismu.yaml     |   52 +
 MAINTAINERS                                        |   12 +
 drivers/acpi/acpi_apd.c                            |   11 +-
 drivers/acpi/scan.c                                |   37 +-
 drivers/clk/Kconfig                                |   26 +-
 drivers/clk/Makefile                               |    5 +-
 drivers/clk/clk-bm1880.c                           |   20 +-
 drivers/clk/clk-gate.c                             |   35 +
 drivers/clk/clk-gemini.c                           |    2 +-
 drivers/clk/clk-lan966x.c                          |  293 ++
 drivers/clk/clk-stm32f4.c                          |    4 -
 drivers/clk/clk-stm32mp1.c                         |    2 -
 drivers/clk/clk-tps68470.c                         |  261 ++
 drivers/clk/clk.c                                  |   80 +-
 drivers/clk/imx/clk-imx8mn.c                       |    6 +-
 drivers/clk/imx/clk-imx8mp.c                       |    2 +-
 drivers/clk/imx/clk-imx8ulp.c                      |    1 +
 drivers/clk/imx/clk-pllv1.c                        |   17 +-
 drivers/clk/imx/clk-pllv3.c                        |    6 +-
 drivers/clk/ingenic/jz4760-cgu.c                   |   10 +
 drivers/clk/ingenic/jz4770-cgu.c                   |    5 +
 drivers/clk/mediatek/Kconfig                       |   17 +
 drivers/clk/mediatek/Makefile                      |    4 +
 drivers/clk/mediatek/clk-gate.c                    |   24 +-
 drivers/clk/mediatek/clk-mt7986-apmixed.c          |  100 +
 drivers/clk/mediatek/clk-mt7986-eth.c              |  132 +
 drivers/clk/mediatek/clk-mt7986-infracfg.c         |  224 ++
 drivers/clk/mediatek/clk-mt7986-topckgen.c         |  342 ++
 drivers/clk/meson/gxbb.c                           |   44 +-
 drivers/clk/qcom/Kconfig                           |   24 +
 drivers/clk/qcom/Makefile                          |    3 +
 drivers/clk/qcom/clk-alpha-pll.c                   |  166 +-
 drivers/clk/qcom/clk-alpha-pll.h                   |    3 +
 drivers/clk/qcom/clk-rpmh.c                        |   52 +
 drivers/clk/qcom/clk-smd-rpm.c                     |   31 +-
 drivers/clk/qcom/gcc-msm8976.c                     | 4155 ++++++++++++++++++++
 drivers/clk/qcom/gcc-msm8994.c                     |    1 +
 drivers/clk/qcom/gcc-sc7280.c                      |    2 +-
 drivers/clk/qcom/gcc-sdx65.c                       | 1611 ++++++++
 drivers/clk/qcom/gcc-sm6350.c                      |    1 +
 drivers/clk/qcom/gcc-sm8350.c                      |    1 +
 drivers/clk/qcom/gcc-sm8450.c                      | 3304 ++++++++++++++++
 drivers/clk/qcom/lpasscc-sc7280.c                  |    1 +
 drivers/clk/qcom/lpasscc-sdm845.c                  |    1 +
 drivers/clk/qcom/mmcc-apq8084.c                    |    1 +
 drivers/clk/qcom/q6sstop-qcs404.c                  |    1 +
 drivers/clk/qcom/turingcc-qcs404.c                 |    1 +
 drivers/clk/renesas/Kconfig                        |   13 +-
 drivers/clk/renesas/Makefile                       |    2 +
 drivers/clk/renesas/r8a774a1-cpg-mssr.c            |   12 +-
 drivers/clk/renesas/r8a774b1-cpg-mssr.c            |   12 +-
 drivers/clk/renesas/r8a774c0-cpg-mssr.c            |    9 +-
 drivers/clk/renesas/r8a774e1-cpg-mssr.c            |   12 +-
 drivers/clk/renesas/r8a7795-cpg-mssr.c             |   12 +-
 drivers/clk/renesas/r8a7796-cpg-mssr.c             |   12 +-
 drivers/clk/renesas/r8a77965-cpg-mssr.c            |   12 +-
 drivers/clk/renesas/r8a77980-cpg-mssr.c            |    3 +-
 drivers/clk/renesas/r8a77990-cpg-mssr.c            |    9 +-
 drivers/clk/renesas/r8a77995-cpg-mssr.c            |    3 +-
 drivers/clk/renesas/r8a779a0-cpg-mssr.c            |  343 +-
 drivers/clk/renesas/r8a779f0-cpg-mssr.c            |  183 +
 drivers/clk/renesas/r9a07g044-cpg.c                |   81 +-
 drivers/clk/renesas/rcar-cpg-lib.c                 |  211 +-
 drivers/clk/renesas/rcar-cpg-lib.h                 |    7 +-
 drivers/clk/renesas/rcar-gen3-cpg.c                |   24 +-
 drivers/clk/renesas/rcar-gen3-cpg.h                |    4 +
 drivers/clk/renesas/rcar-gen4-cpg.c                |  305 ++
 drivers/clk/renesas/rcar-gen4-cpg.h                |   76 +
 drivers/clk/renesas/renesas-cpg-mssr.c             |   60 +-
 drivers/clk/renesas/renesas-cpg-mssr.h             |    3 +-
 drivers/clk/renesas/rzg2l-cpg.c                    |   18 +-
 drivers/clk/renesas/rzg2l-cpg.h                    |    9 +
 drivers/clk/samsung/Makefile                       |    2 +
 drivers/clk/samsung/clk-cpu.c                      |    2 +-
 drivers/clk/samsung/clk-cpu.h                      |    7 -
 drivers/clk/samsung/clk-exynos-arm64.c             |   94 +
 drivers/clk/samsung/clk-exynos-arm64.h             |   20 +
 drivers/clk/samsung/clk-exynos3250.c               |   54 +-
 drivers/clk/samsung/clk-exynos4.c                  |   41 +-
 drivers/clk/samsung/clk-exynos5250.c               |   21 +-
 drivers/clk/samsung/clk-exynos5420.c               |   29 +-
 drivers/clk/samsung/clk-exynos7885.c               |  597 +++
 drivers/clk/samsung/clk-exynos850.c                |  366 +-
 drivers/clk/samsung/clk-pll.c                      |    1 +
 drivers/clk/samsung/clk-pll.h                      |    1 +
 drivers/clk/samsung/clk-s3c2410.c                  |    6 +-
 drivers/clk/samsung/clk-s3c64xx.c                  |    8 +-
 drivers/clk/samsung/clk-s5pv210.c                  |    8 +-
 drivers/clk/samsung/clk.c                          |   14 -
 drivers/clk/samsung/clk.h                          |   36 +-
 drivers/clk/socfpga/clk-agilex.c                   |    4 +-
 drivers/clk/socfpga/clk-gate.c                     |    4 +-
 drivers/clk/socfpga/clk-pll-s10.c                  |    2 +-
 drivers/clk/socfpga/clk-s10.c                      |    4 +-
 drivers/clk/st/clkgen-fsyn.c                       |   13 +-
 drivers/clk/st/clkgen-mux.c                        |   11 +-
 drivers/clk/sunxi-ng/Kconfig                       |   49 +-
 drivers/clk/sunxi-ng/Makefile                      |  101 +-
 drivers/clk/sunxi-ng/ccu-sun20i-d1-r.c             |  140 +
 drivers/clk/sunxi-ng/ccu-sun20i-d1-r.h             |   17 +
 drivers/clk/sunxi-ng/ccu-sun20i-d1.c               | 1390 +++++++
 drivers/clk/sunxi-ng/ccu-sun20i-d1.h               |   15 +
 drivers/clk/sunxi-ng/ccu-sun4i-a10.c               |   58 +-
 drivers/clk/sunxi-ng/ccu-sun50i-a100-r.c           |    4 +-
 drivers/clk/sunxi-ng/ccu-sun50i-a100.c             |    4 +-
 drivers/clk/sunxi-ng/ccu-sun50i-a64.c              |    7 +-
 drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c             |   56 +-
 drivers/clk/sunxi-ng/ccu-sun50i-h6.c               |    7 +-
 drivers/clk/sunxi-ng/ccu-sun50i-h616.c             |   33 +-
 drivers/clk/sunxi-ng/ccu-sun6i-a31.c               |   40 +-
 drivers/clk/sunxi-ng/ccu-sun8i-a23.c               |   35 +-
 drivers/clk/sunxi-ng/ccu-sun8i-a33.c               |   40 +-
 drivers/clk/sunxi-ng/ccu-sun8i-a83t.c              |    7 +-
 drivers/clk/sunxi-ng/ccu-sun8i-de2.c               |    9 +-
 drivers/clk/sunxi-ng/ccu-sun8i-h3.c                |   62 +-
 drivers/clk/sunxi-ng/ccu-sun8i-r.c                 |   65 +-
 drivers/clk/sunxi-ng/ccu-sun8i-r40.c               |    6 +-
 drivers/clk/sunxi-ng/ccu-sun8i-v3s.c               |   57 +-
 drivers/clk/sunxi-ng/ccu-sun9i-a80-de.c            |    7 +-
 drivers/clk/sunxi-ng/ccu-sun9i-a80-usb.c           |    7 +-
 drivers/clk/sunxi-ng/ccu-sun9i-a80.c               |    7 +-
 drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c           |   40 +-
 drivers/clk/sunxi-ng/ccu_common.c                  |    6 +
 drivers/clk/sunxi-ng/ccu_div.c                     |    1 +
 drivers/clk/sunxi-ng/ccu_div.h                     |   78 +
 drivers/clk/sunxi-ng/ccu_frac.c                    |    6 +
 drivers/clk/sunxi-ng/ccu_gate.c                    |    4 +
 drivers/clk/sunxi-ng/ccu_gate.h                    |   32 +-
 drivers/clk/sunxi-ng/ccu_mp.c                      |    2 +
 drivers/clk/sunxi-ng/ccu_mp.h                      |   49 +
 drivers/clk/sunxi-ng/ccu_mult.c                    |    1 +
 drivers/clk/sunxi-ng/ccu_mux.c                     |    6 +
 drivers/clk/sunxi-ng/ccu_mux.h                     |   33 +
 drivers/clk/sunxi-ng/ccu_nk.c                      |    1 +
 drivers/clk/sunxi-ng/ccu_nkm.c                     |    1 +
 drivers/clk/sunxi-ng/ccu_nkmp.c                    |    1 +
 drivers/clk/sunxi-ng/ccu_nm.c                      |    1 +
 drivers/clk/sunxi-ng/ccu_phase.c                   |    1 +
 drivers/clk/sunxi-ng/ccu_reset.c                   |    1 +
 drivers/clk/sunxi-ng/ccu_sdm.c                     |    6 +
 drivers/clk/tegra/Makefile                         |    1 +
 drivers/clk/tegra/clk-device.c                     |  199 +
 drivers/clk/tegra/clk-pll.c                        |    2 +-
 drivers/clk/tegra/clk-super.c                      |    2 +-
 drivers/clk/tegra/clk-tegra114.c                   |    2 +-
 drivers/clk/tegra/clk-tegra20.c                    |   77 +-
 drivers/clk/tegra/clk-tegra30.c                    |  116 +-
 drivers/clk/tegra/clk.c                            |   75 +-
 drivers/clk/tegra/clk.h                            |    2 +
 drivers/clk/ti/adpll.c                             |    2 +-
 drivers/clk/visconti/Kconfig                       |    9 +
 drivers/clk/visconti/Makefile                      |    5 +
 drivers/clk/visconti/clkc-tmpv770x.c               |  291 ++
 drivers/clk/visconti/clkc.c                        |  206 +
 drivers/clk/visconti/clkc.h                        |   76 +
 drivers/clk/visconti/pll-tmpv770x.c                |   85 +
 drivers/clk/visconti/pll.c                         |  340 ++
 drivers/clk/visconti/pll.h                         |   62 +
 drivers/clk/visconti/reset.c                       |  107 +
 drivers/clk/visconti/reset.h                       |   36 +
 drivers/clk/x86/clk-fch.c                          |   48 +-
 drivers/clk/zynq/pll.c                             |   12 +-
 drivers/i2c/i2c-core-acpi.c                        |   22 +-
 drivers/mmc/host/Kconfig                           |    1 +
 drivers/mmc/host/renesas_sdhi.h                    |    4 +
 drivers/mmc/host/renesas_sdhi_core.c               |   45 +-
 drivers/mmc/host/renesas_sdhi_internal_dmac.c      |   21 +
 drivers/platform/x86/intel/int3472/Makefile        |    9 +-
 ...472_clk_and_regulator.c => clk_and_regulator.c} |    2 +-
 drivers/platform/x86/intel/int3472/common.c        |   82 +
 .../{intel_skl_int3472_common.h => common.h}       |    6 +-
 .../{intel_skl_int3472_discrete.c => discrete.c}   |   51 +-
 .../x86/intel/int3472/intel_skl_int3472_common.c   |  106 -
 .../{intel_skl_int3472_tps68470.c => tps68470.c}   |   92 +-
 drivers/platform/x86/intel/int3472/tps68470.h      |   25 +
 .../x86/intel/int3472/tps68470_board_data.c        |  145 +
 include/acpi/acpi_bus.h                            |    5 +-
 include/dt-bindings/clock/exynos4.h                |    4 +-
 include/dt-bindings/clock/exynos5250.h             |    4 +-
 include/dt-bindings/clock/exynos7885.h             |  115 +
 include/dt-bindings/clock/exynos850.h              |   54 +-
 include/dt-bindings/clock/imx8mp-clock.h           |    1 -
 include/dt-bindings/clock/ingenic,jz4760-cgu.h     |    2 +
 include/dt-bindings/clock/ingenic,jz4770-cgu.h     |    1 +
 include/dt-bindings/clock/microchip,lan966x.h      |   34 +
 include/dt-bindings/clock/mt7986-clk.h             |  169 +
 include/dt-bindings/clock/qcom,gcc-msm8976.h       |  240 ++
 include/dt-bindings/clock/qcom,gcc-sdx65.h         |  122 +
 include/dt-bindings/clock/r8a779f0-cpg-mssr.h      |   64 +
 include/dt-bindings/clock/sun20i-d1-ccu.h          |  156 +
 include/dt-bindings/clock/sun20i-d1-r-ccu.h        |   19 +
 include/dt-bindings/clock/toshiba,tmpv770x.h       |  181 +
 include/dt-bindings/power/r8a779f0-sysc.h          |   30 +
 include/dt-bindings/reset/sun20i-d1-ccu.h          |   77 +
 include/dt-bindings/reset/sun20i-d1-r-ccu.h        |   16 +
 include/dt-bindings/reset/toshiba,tmpv770x.h       |   41 +
 include/linux/clk-provider.h                       |   23 +
 include/linux/clk/sunxi-ng.h                       |   15 -
 include/linux/i2c.h                                |   17 +-
 include/linux/mfd/tps68470.h                       |   11 +
 include/linux/platform_data/clk-fch.h              |    2 +-
 include/linux/platform_data/tps68470.h             |   35 +
 216 files changed, 19320 insertions(+), 1401 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/microchip,lan966x-gck.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-msm8976.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-sdx65.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/samsung,exynos7885-clock.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/toshiba,tmpv770x-pipllct.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/toshiba,tmpv770x-pismu.yaml
 create mode 100644 drivers/clk/clk-lan966x.c
 create mode 100644 drivers/clk/clk-tps68470.c
 create mode 100644 drivers/clk/mediatek/clk-mt7986-apmixed.c
 create mode 100644 drivers/clk/mediatek/clk-mt7986-eth.c
 create mode 100644 drivers/clk/mediatek/clk-mt7986-infracfg.c
 create mode 100644 drivers/clk/mediatek/clk-mt7986-topckgen.c
 create mode 100644 drivers/clk/qcom/gcc-msm8976.c
 create mode 100644 drivers/clk/qcom/gcc-sdx65.c
 create mode 100644 drivers/clk/qcom/gcc-sm8450.c
 create mode 100644 drivers/clk/renesas/r8a779f0-cpg-mssr.c
 create mode 100644 drivers/clk/renesas/rcar-gen4-cpg.c
 create mode 100644 drivers/clk/renesas/rcar-gen4-cpg.h
 create mode 100644 drivers/clk/samsung/clk-exynos-arm64.c
 create mode 100644 drivers/clk/samsung/clk-exynos-arm64.h
 create mode 100644 drivers/clk/samsung/clk-exynos7885.c
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun20i-d1-r.c
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun20i-d1-r.h
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun20i-d1.c
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun20i-d1.h
 create mode 100644 drivers/clk/tegra/clk-device.c
 create mode 100644 drivers/clk/visconti/Kconfig
 create mode 100644 drivers/clk/visconti/Makefile
 create mode 100644 drivers/clk/visconti/clkc-tmpv770x.c
 create mode 100644 drivers/clk/visconti/clkc.c
 create mode 100644 drivers/clk/visconti/clkc.h
 create mode 100644 drivers/clk/visconti/pll-tmpv770x.c
 create mode 100644 drivers/clk/visconti/pll.c
 create mode 100644 drivers/clk/visconti/pll.h
 create mode 100644 drivers/clk/visconti/reset.c
 create mode 100644 drivers/clk/visconti/reset.h
 rename drivers/platform/x86/intel/int3472/{intel_skl_int3472_clk_and_regulator.c => clk_and_regulator.c} (99%)
 create mode 100644 drivers/platform/x86/intel/int3472/common.c
 rename drivers/platform/x86/intel/int3472/{intel_skl_int3472_common.h => common.h} (94%)
 rename drivers/platform/x86/intel/int3472/{intel_skl_int3472_discrete.c => discrete.c} (91%)
 delete mode 100644 drivers/platform/x86/intel/int3472/intel_skl_int3472_common.c
 rename drivers/platform/x86/intel/int3472/{intel_skl_int3472_tps68470.c => tps68470.c} (56%)
 create mode 100644 drivers/platform/x86/intel/int3472/tps68470.h
 create mode 100644 drivers/platform/x86/intel/int3472/tps68470_board_data.c
 create mode 100644 include/dt-bindings/clock/exynos7885.h
 create mode 100644 include/dt-bindings/clock/microchip,lan966x.h
 create mode 100644 include/dt-bindings/clock/mt7986-clk.h
 create mode 100644 include/dt-bindings/clock/qcom,gcc-msm8976.h
 create mode 100644 include/dt-bindings/clock/qcom,gcc-sdx65.h
 create mode 100644 include/dt-bindings/clock/r8a779f0-cpg-mssr.h
 create mode 100644 include/dt-bindings/clock/sun20i-d1-ccu.h
 create mode 100644 include/dt-bindings/clock/sun20i-d1-r-ccu.h
 create mode 100644 include/dt-bindings/clock/toshiba,tmpv770x.h
 create mode 100644 include/dt-bindings/power/r8a779f0-sysc.h
 create mode 100644 include/dt-bindings/reset/sun20i-d1-ccu.h
 create mode 100644 include/dt-bindings/reset/sun20i-d1-r-ccu.h
 create mode 100644 include/dt-bindings/reset/toshiba,tmpv770x.h
 create mode 100644 include/linux/platform_data/tps68470.h

-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

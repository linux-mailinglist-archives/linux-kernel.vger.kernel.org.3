Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13D205356DF
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 01:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235246AbiEZX6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 19:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349833AbiEZX62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 19:58:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED54CF7486;
        Thu, 26 May 2022 16:57:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05BE561CAB;
        Thu, 26 May 2022 23:57:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2A06C385B8;
        Thu, 26 May 2022 23:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653609451;
        bh=LY399BQm59wL4Co+pa99FYRWRM/RBPFvqIbwCmZcawQ=;
        h=From:To:Cc:Subject:Date:From;
        b=Ec2x/+g8lOR07G+OFsm6ehf3ame1BYudbsZBmxE138kzXtaqNp4I2cBI+8uMD2cht
         3xSA+2G4aCGenhPQAckSK3XWeFU/jTGiAGCGSLHWyP6ab/+V7dwFMM3hlpPNSlM2//
         8iYsAbS4WI0TD0xfD25FGT8uMCVCedbdhWIqWVvoRQ+kMcR3OUZQ6fZTqje5XiJypE
         60uiXEp2Ir5QZd9EHoZHgShDx8nZlRuDIoTGW8ugCs+nCs/xKJgmtlrOQpTP0EROI1
         eqk0KM5+dQTNxPiLdVV2aFsnpN4RzASx16mwGwd/2XgPkcFLIKSw7uprJYXc8aXlm1
         PGiv7K/zjQ4GQ==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk changes for the merge window
Date:   Thu, 26 May 2022 16:57:29 -0700
Message-Id: <20220526235729.2673148-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        PP_MIME_FAKE_ASCII_TEXT,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 96055bf71ab1629cdedff15bcbc04609cfa1f198:

  dt-bindings: clock: Add r9a09g011 CPG Clock Definitions (2022-05-05 12:04:58 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

for you to fetch changes up to 71cc785d295527587faa8e3d825ef7c0e1cb2d12:

  Merge branch 'clk-qcom' into clk-next (2022-05-25 00:27:32 -0700)

----------------------------------------------------------------
Mainly driver updates this time around. There's a single patch to the core clk
framework that simplifies a runtime PM call. Otherwise the majority of the diff
falls to a few SoC drivers: Qualcomm, STM32 and MediaTek. Those SoCs gain some
new hardware support and what comes along with that is quite a few lines of
data and some clk_ops code. Beyond the new hardware support we have the usual
pile of driver updates that add missing clks on already supported SoCs or fix
up problems like bad clk tree descriptions. It's nice to see that more drivers
are moving to clk_hw based APIs too.

New Drivers:
 - Add STM32MP13 RCC driver (Reset Clock Controller)
 - MediaTek MT8186 SoC clk support
 - Airoha EN7523 SoC system clocks
 - Clock driver for exynosautov9 SoC
 - Renesas R-Car V4H and RZ/V2M SoCs
 - Renesas RZ/G2UL SoC
 - LPASS clk driver for Qualcomm sc7280 SoC
 - GCC clk driver for Qualcomm SC8280XP SoC

Updates:
 - SDCC uses floor clk ops on Qualcomm MSM8976
 - Add modem reset and fix RPM clks on Qualcomm MSM8976
 - Add the two missing CLKOUT clocks for U8500/DB8500 SoC
 - Mark some clks critical on Ingenic X1000
 - Convert ux500 to clk_hw
 - Move MediaTek driver to clk_hw provider APIs
 - Use i2c driver probe_new to avoid id scans
 - Convert a number of Rockchip dt bindings to YAML
 - Mark hclk_vo critical on Rockchip rk3568
 - Use pm_runtime_resume_and_get to fix pm_runtime_get_sync() usage
 - Various cleanups like memory allocation error checks and plugged leaks
 - Allwinner H6 RTC clock support
 - Allwinner H616 32 kHz clock support
 - Add the Universal Flash Storage clock on Renesas R-Car S4-8
 - Add I2C, SSIF-2 (sound), USB, CANFD, OSTM (timer), WDT, SPI Multi
   I/O Bus, RSPI, TSU (thermal), and ADC clocks and resets on Renesas RZ/G2UL
 - Add display clock support on Renesas RZ/G2L
 - Add RPC (QSPI/HyperFlash) clocks on Renesas R-Car E3 and D3
 - Add 27 MHz phy PLL ref clock on i.MX
 - Add mcore_booted module parameter to tell kernel M core has already booted
   for i.MX
 - Remove snvs clock on i.MX because it was for secure world only
 - Add dt bindings for i.MX8MN GPT
 - Add DISP2 pixel clock for i.MX8MP
 - Add clkout1/2 for i.MX8MP
 - Fix parent clock of ubs_root_clk for i.MX8MP
 - Implement better RCG parking on Qualcomm SoCs using the shared RCG clk ops
 - Kerneldoc fixes
 - Switch Tegra BPMP to determine_rate clk op
 - Add a pointer to dt schema for generic clock bindings

----------------------------------------------------------------
Adam Skladowski (4):
      clk: qcom: smd: Update MSM8976 RPM clocks.
      clk: qcom: gcc-msm8976: Set floor ops for SDCC
      dt-bindings: clk: qcom: gcc-msm8976: Add modem reset
      clk: qcom: gcc-msm8976: Add modem reset

Aidan MacDonald (4):
      clk: ingenic: Allow specifying common clock flags
      clk: ingenic: Mark critical clocks in Ingenic SoCs
      mips: ingenic: Do not manually reference the CPU clock
      clk: ingenic-tcu: Fix missing TCU clock for X1000 SoCs

Alvin Šipraga (2):
      dt-bindings: imx: add clock bindings for i.MX8MN GPT
      clk: imx8mn: add GPT support

Andre Przywara (2):
      clk: sunxi-ng: h6-r: Add RTC gate clock
      clk: sunxi-ng: h616: Add PLL derived 32KHz clock

Biju Das (25):
      dt-bindings: clock: renesas: Document RZ/G2UL SoC
      clk: renesas: Add support for RZ/G2UL SoC
      clk: renesas: r9a07g043: Add GPIO clock and reset entries
      clk: renesas: r9a07g043: Add ethernet clock sources
      clk: renesas: r9a07g043: Add GbEthernet clock/reset
      clk: renesas: r9a07g043: Add SDHI clock and reset entries
      clk: renesas: r9a07g043: Add I2C clocks/resets
      clk: renesas: r9a07g043: Add SSIF-2 clock and reset entries
      clk: renesas: r9a07g043: Add USB clocks/resets
      clk: renesas: r9a07g043: Add clock and reset entries for CANFD
      clk: renesas: r9a07g043: Add OSTM clock and reset entries
      clk: renesas: r9a07g043: Add WDT clock and reset entries
      clk: renesas: rzg2l: Add FOUTPOSTDIV clk support
      clk: renesas: rzg2l: Add PLL5_4 clk mux support
      clk: renesas: rzg2l: Add DSI divider clk support
      clk: renesas: r9a07g044: Add M1 clock support
      clk: renesas: r9a07g044: Add {M2, M2_DIV2} Clocks support
      clk: renesas: r9a07g044: Add M3 Clock support
      clk: renesas: r9a07g044: Add M4 Clock support
      clk: renesas: r9a07g044: Add LCDC clock and reset entries
      clk: renesas: r9a07g044: Add DSI clock and reset entries
      clk: renesas: r9a07g043: Add clock and reset entries for SPI Multi I/O Bus Controller
      clk: renesas: r9a07g043: Add RSPI clock and reset entries
      clk: renesas: r9a07g043: Add TSU clock and reset entry
      clk: renesas: r9a07g043: Add clock and reset entries for ADC

Bjorn Andersson (6):
      Merge tag '20220323085010.1753493-4-dmitry.baryshkov@linaro.org' into clk-for-5.19
      Merge branch '20220223172248.18877-1-tdas@codeaurora.org' into clk-for-5.19
      Merge branch '20220411072156.24451-2-michael.srba@seznam.cz' into clk-for-5.19
      dt-bindings: clock: Add Qualcomm SC8280XP GCC bindings
      clk: qcom: add sc8280xp GCC driver
      clk: qcom: rcg2: Cache CFG register updates for parked RCGs

Chanho Park (8):
      clk: samsung: add top clock support for Exynos Auto v9 SoC
      clk: samsung: exynosautov9: add cmu_core clock support
      clk: samsung: exynosautov9: add cmu_peris clock support
      clk: samsung: exynosautov9: add cmu_busmc clock support
      clk: samsung: exynosautov9: add cmu_fsys2 clock support
      clk: samsung: exynosautov9: add cmu_peric0 clock support
      clk: samsung: exynosautov9: add cmu_peric1 clock support
      dt-bindings: clock: exynosautov9: correct count of NR_CLK

Chen-Yu Tsai (5):
      clk: mediatek: Make mtk_clk_register_composite() static
      clk: mediatek: apmixed: Drop error message from clk_register() failure
      clk: mediatek: Replace 'struct clk' with 'struct clk_hw'
      clk: mediatek: Switch to clk_hw provider APIs
      clk: mediatek: mt8173: Switch to clk_hw provider APIs

Christophe JAILLET (1):
      clk: bcm: rpi: Use correct order for the parameters of devm_kcalloc()

Chun-Jie Chen (16):
      dt-bindings: ARM: MediaTek: Add new document bindings of MT8186 clock
      clk: mediatek: Add MT8186 mcusys clock support
      clk: mediatek: Add MT8186 topckgen clock support
      clk: mediatek: Add MT8186 infrastructure clock support
      clk: mediatek: Add MT8186 apmixedsys clock support
      clk: mediatek: Add MT8186 imp i2c wrapper clock support
      clk: mediatek: Add MT8186 mfgsys clock support
      clk: mediatek: Add MT8186 mmsys clock support
      clk: mediatek: Add MT8186 wpesys clock support
      clk: mediatek: Add MT8186 imgsys clock support
      clk: mediatek: Add MT8186 vdecsys clock support
      clk: mediatek: Add MT8186 vencsys clock support
      clk: mediatek: Add MT8186 camsys clock support
      clk: mediatek: Add MT8186 mdpsys clock support
      clk: mediatek: Add MT8186 ipesys clock support
      clk: mediatek: use en_mask as a pure div_en_mask

Colin Ian King (2):
      clk: actions: remove redundant assignment after a mask operation
      clk: mux: remove redundant initialization of variable width

Diogo Ivo (1):
      clk: tegra: Add missing reset deassertion

Dmitry Baryshkov (6):
      clk: qcom: regmap-mux: add pipe clk implementation
      clk: qcom: gcc-sm8450: use new clk_regmap_mux_safe_ops for PCIe pipe clocks
      clk: qcom: gcc-sc7280: use new clk_regmap_mux_safe_ops for PCIe pipe clocks
      Revert "clk: qcom: gcc-sm8450: use new clk_regmap_mux_safe_ops for PCIe pipe clocks"
      Revert "clk: qcom: gcc-sc7280: use new clk_regmap_mux_safe_ops for PCIe pipe clocks"
      Revert "clk: qcom: regmap-mux: add pipe clk implementation"

Felix Fietkau (1):
      clk: en7523: Add clock driver for Airoha EN7523 SoC

Gabriel Fernandez (11):
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

Geert Uytterhoeven (8):
      clk: renesas: r8a77990: Add RPC clocks
      clk: renesas: r8a77995: Add RPC clocks
      clk: renesas: rzg2l: Simplify multiplication/shift logic
      clk: renesas: Move RPC core clocks
      Merge tag 'renesas-r9a07g043-dt-binding-defs-tag' into renesas-clk-for-v5.19
      Merge tag 'renesas-r8a779g0-dt-binding-defs-tag' into renesas-clk-for-v5.19
      clk: renesas: r9a07g044: Fix OSTM1 module clock name
      Merge tag 'renesas-r9a09g011-dt-binding-defs-tag' into renesas-clk-for-v5.19

Georgi Vlaev (2):
      dt-bindings: clock: ehrpwm: Add AM62 specific compatible
      clk: keystone: syscon-clk: Add support for AM62 epwm-tbclk

Hangyu Hua (1):
      clk: ux500: fix a possible off-by-one in u8500_prcc_reset_base()

Jacky Bai (1):
      clk: imx: Remove the snvs clock

Jakob Koschel (1):
      clk: ti: clkctrl: replace usage of found with dedicated list iterator variable

Jiasheng Jiang (1):
      clk: imx: Add check for kcalloc

Johan Jonker (12):
      dt-bindings: clock: fix some conversion style issues for rockchip,rk3399-cru.yaml
      dt-bindings: clock: replace a maintainer for rockchip,rk3399-cru.yaml
      dt-bindings: clock: use generic node name for pmucru example in rockchip,rk3399-cru.yaml
      dt-bindings: clock: fix rk3399 cru clock issues
      dt-bindings: clock: convert rockchip,rv1108-cru.txt to YAML
      dt-bindings: clock: convert rockchip,rk3288-cru.txt to YAML
      dt-bindings: clock: convert rockchip,rk3188-cru.txt to YAML
      dt-bindings: clock: convert rockchip,px30-cru.txt to YAML
      dt-bindings: clock: convert rockchip,rk3308-cru.txt to YAML
      dt-bindings: clock: convert rockchip,rk3036-cru.txt to YAML
      dt-bindings: clock: convert rockchip,rk3228-cru.txt to YAML
      dt-bindings: clock: convert rockchip,rk3368-cru.txt to YAML

John Crispin (1):
      dt-bindings: Add en7523-scu device tree binding documentation

Krzysztof Kozlowski (3):
      dt-bindings: clock: qcom,rpmcc: convert to dtschema
      dt-bindings: clock: qcom,rpmcc: add clocks property
      dt-bindings: clock: qcom,gcc-apq8064: Fix typo in compatible and split apq8084

Len Baker (1):
      clk: ti: composite: Prefer kcalloc over open coded arithmetic

Li Zhengyu (1):
      clk: fixed-rate: Remove redundant if statement

Linus Walleij (5):
      dt-bindings: clock: u8500: Add clkout clock bindings
      clk: ux500: Drop .is_enabled state from PRCMU clocks
      clk: ux500: Drop .is_prepared state from PRCMU clocks
      clk: ux500: Rewrite PRCMU clocks to use clk_hw_*
      clk: ux500: Implement the missing CLKOUT clocks

Lucas Stach (1):
      clk: imx8mp: add clkout1/2 support

Marek Vasut (1):
      clk: imx8mp: Add DISP2 pixel clock

Miaoqian Lin (1):
      clk: imx: scu: Use pm_runtime_resume_and_get to fix pm_runtime_get_sync() usage

Michael Srba (1):
      clk: qcom: gcc-msm8998: add SSC-related clocks

Minghao Chi (1):
      clk: using pm_runtime_resume_and_get instead of pm_runtime_get_sync

Miquel Raynal (1):
      clk: renesas: r9a06g032: Fix the RTC hclock description

Peng Fan (4):
      clk: imx8mq: add 27m phy pll ref clock
      clk: imx: add mcore_booted module paratemter
      clk: imx8m: check mcore_booted before register clk
      clk: imx8mp: fix usb_root_clk parent

Peter Geis (1):
      dt-binding: clock: Add missing rk3568 cru bindings

Phil Edworthy (9):
      clk: renesas: rzg2l: Remove unused notifiers
      dt-bindings: clock: renesas,rzg2l: Document RZ/V2M SoC
      clk: renesas: rzg2l: Move the DEF_MUX array size calc into the macro
      clk: renesas: rzg2l: Add read only versions of the clk macros
      clk: renesas: rzg2l: Set HIWORD mask for all mux and dividers
      clk: renesas: rzg2l: Make use of CLK_MON registers optional
      clk: renesas: rzg2l: Add support for RZ/V2M reset monitor reg
      clk: renesas: Add RZ/V2M support using the rzg2l driver
      clk: renesas: r9a09g011: Add eth clock and reset entries

Rajkumar Kasirajan (1):
      clk: tegra: Replace .round_rate() with .determine_rate()

Rob Herring (1):
      dt-bindings: clock: Replace common binding with link to schema

Sam Shih (1):
      clk: mediatek: update compatible string for MT7986 ethsys

Sascha Hauer (1):
      clk: rockchip: Mark hclk_vo as critical on rk3568

Stephen Boyd (13):
      Merge tag 'renesas-clk-for-v5.19-tag1' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers into clk-renesas
      Merge tag 'renesas-clk-for-v5.19-tag2' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers into clk-renesas
      Merge tag 'for-5.19-clk' of git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux into clk-tegra
      Merge tag 'sunxi-clk-for-5.19-1' of https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux into clk-allwinner
      Merge tag 'clk-imx-5.19' of git://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux into clk-imx
      Merge tag 'v5.19-rockchip-clk2' of git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip into clk-rockchip
      Merge tag 'clk-v5.19-samsung' of https://git.kernel.org/pub/scm/linux/kernel/git/snawrocki/clk into clk-samsung
      Merge tag 'qcom-clk-for-5.19' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into clk-qcom
      Merge tag 'qcom-clk-for-5.19-2' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into clk-qcom
      Merge branches 'clk-ti', 'clk-cleanup', 'clk-airoha', 'clk-i2c-simple' and 'clk-renesas' into clk-next
      Merge branches 'clk-ux500', 'clk-mtk', 'clk-tegra', 'clk-allwinner' and 'clk-imx' into clk-next
      Merge branches 'clk-rockchip', 'clk-ingenic', 'clk-bindings', 'clk-samsung' and 'clk-stm' into clk-next
      Merge branch 'clk-qcom' into clk-next

Stephen Kitt (10):
      clk: cdce706: use simple i2c probe function
      clk: cdce925: use i2c_match_id and simple i2c probe
      clk: cs2000-cp: use simple i2c probe function
      clk: max9485: use simple i2c probe function
      clk: si514: use simple i2c probe function
      clk: si5341: use simple i2c probe function
      clk: si5351: use i2c_match_id and simple i2c probe
      clk: si544: use i2c_match_id and simple i2c probe
      clk: si570: use i2c_match_id and simple i2c probe
      clk: renesas-pcie: use simple i2c probe function

Taniya Das (1):
      clk: qcom: lpass: Add support for LPASS clock controller for SC7280

Thierry Reding (1):
      clk: tegra: Update kerneldoc to match prototypes

Timo Alho (1):
      clk: tegra: Register clocks from root to leaf

Xiaoke Wang (1):
      clk: imx: scu: fix a potential memory leak in __imx_clk_gpr_scu()

Yang Yingliang (1):
      clk: en7523: fix wrong pointer check in en7523_clk_probe()

Yoshihiro Shimoda (4):
      clk: renesas: r8a779f0: Add UFS clock
      dt-bindings: clock: renesas,cpg-mssr: Document r8a779g0
      clk: renesas: rcar-gen4: Add CLK_TYPE_GEN4_PLL4
      clk: renesas: cpg-mssr: Add support for R-Car V4H

 .../arm/mediatek/mediatek,mt8186-clock.yaml        |   56 +
 .../arm/mediatek/mediatek,mt8186-sys-clock.yaml    |   54 +
 .../bindings/clock/airoha,en7523-scu.yaml          |   58 +
 .../devicetree/bindings/clock/clock-bindings.txt   |  188 +-
 .../bindings/clock/qcom,gcc-apq8064.yaml           |    4 +-
 .../bindings/clock/qcom,gcc-apq8084.yaml           |   42 +
 .../bindings/clock/qcom,gcc-sc8280xp.yaml          |  128 +
 .../devicetree/bindings/clock/qcom,rpmcc.txt       |   63 -
 .../devicetree/bindings/clock/qcom,rpmcc.yaml      |   75 +
 .../bindings/clock/renesas,cpg-mssr.yaml           |    1 +
 .../bindings/clock/renesas,rzg2l-cpg.yaml          |   20 +-
 .../bindings/clock/rockchip,px30-cru.txt           |   70 -
 .../bindings/clock/rockchip,px30-cru.yaml          |  119 +
 .../bindings/clock/rockchip,rk3036-cru.txt         |   56 -
 .../bindings/clock/rockchip,rk3036-cru.yaml        |   72 +
 .../bindings/clock/rockchip,rk3188-cru.txt         |   61 -
 .../bindings/clock/rockchip,rk3188-cru.yaml        |   78 +
 .../bindings/clock/rockchip,rk3228-cru.txt         |   58 -
 .../bindings/clock/rockchip,rk3228-cru.yaml        |   74 +
 .../bindings/clock/rockchip,rk3288-cru.txt         |   67 -
 .../bindings/clock/rockchip,rk3288-cru.yaml        |   85 +
 .../bindings/clock/rockchip,rk3308-cru.txt         |   60 -
 .../bindings/clock/rockchip,rk3308-cru.yaml        |   76 +
 .../bindings/clock/rockchip,rk3368-cru.txt         |   61 -
 .../bindings/clock/rockchip,rk3368-cru.yaml        |   78 +
 .../bindings/clock/rockchip,rk3399-cru.yaml        |   33 +-
 .../bindings/clock/rockchip,rk3568-cru.yaml        |   13 +
 .../bindings/clock/rockchip,rv1108-cru.txt         |   59 -
 .../bindings/clock/rockchip,rv1108-cru.yaml        |   75 +
 .../devicetree/bindings/clock/st,stm32mp1-rcc.yaml |    2 +
 .../bindings/clock/stericsson,u8500-clks.yaml      |   57 +
 .../bindings/clock/ti,am654-ehrpwm-tbclk.yaml      |    1 +
 .../devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml |    4 +
 arch/mips/generic/board-ingenic.c                  |   26 -
 drivers/clk/Kconfig                                |   14 +
 drivers/clk/Makefile                               |    2 +
 drivers/clk/actions/owl-pll.c                      |    2 +-
 drivers/clk/bcm/clk-raspberrypi.c                  |    2 +-
 drivers/clk/clk-cdce706.c                          |    5 +-
 drivers/clk/clk-cdce925.c                          |   24 +-
 drivers/clk/clk-cs2000-cp.c                        |    5 +-
 drivers/clk/clk-en7523.c                           |  351 +
 drivers/clk/clk-fixed-rate.c                       |    2 +-
 drivers/clk/clk-max9485.c                          |    5 +-
 drivers/clk/clk-mux.c                              |    4 +-
 drivers/clk/clk-renesas-pcie.c                     |    4 +-
 drivers/clk/clk-si514.c                            |    5 +-
 drivers/clk/clk-si5341.c                           |    5 +-
 drivers/clk/clk-si5351.c                           |   24 +-
 drivers/clk/clk-si544.c                            |   22 +-
 drivers/clk/clk-si570.c                            |   24 +-
 drivers/clk/clk.c                                  |    9 +-
 drivers/clk/imx/clk-composite-8m.c                 |   19 +-
 drivers/clk/imx/clk-imx7d.c                        |    1 -
 drivers/clk/imx/clk-imx8mm.c                       |    3 +-
 drivers/clk/imx/clk-imx8mn.c                       |   41 +-
 drivers/clk/imx/clk-imx8mp.c                       |   24 +-
 drivers/clk/imx/clk-imx8mq.c                       |    5 +-
 drivers/clk/imx/clk-scu.c                          |    6 +-
 drivers/clk/imx/clk.c                              |    5 +
 drivers/clk/imx/clk.h                              |    1 +
 drivers/clk/ingenic/cgu.c                          |    2 +-
 drivers/clk/ingenic/cgu.h                          |    3 +
 drivers/clk/ingenic/jz4725b-cgu.c                  |   10 +
 drivers/clk/ingenic/jz4740-cgu.c                   |   10 +
 drivers/clk/ingenic/jz4760-cgu.c                   |   10 +
 drivers/clk/ingenic/jz4770-cgu.c                   |    5 +
 drivers/clk/ingenic/jz4780-cgu.c                   |   15 +
 drivers/clk/ingenic/tcu.c                          |   35 +-
 drivers/clk/ingenic/x1000-cgu.c                    |   15 +
 drivers/clk/ingenic/x1830-cgu.c                    |   11 +
 drivers/clk/keystone/syscon-clk.c                  |   11 +
 drivers/clk/mediatek/Kconfig                       |    8 +
 drivers/clk/mediatek/Makefile                      |    5 +
 drivers/clk/mediatek/clk-apmixed.c                 |   12 +-
 drivers/clk/mediatek/clk-cpumux.c                  |   50 +-
 drivers/clk/mediatek/clk-cpumux.h                  |    6 +-
 drivers/clk/mediatek/clk-gate.c                    |   52 +-
 drivers/clk/mediatek/clk-gate.h                    |    8 +-
 drivers/clk/mediatek/clk-mt2701-aud.c              |    4 +-
 drivers/clk/mediatek/clk-mt2701-bdp.c              |    4 +-
 drivers/clk/mediatek/clk-mt2701-eth.c              |    4 +-
 drivers/clk/mediatek/clk-mt2701-g3d.c              |    4 +-
 drivers/clk/mediatek/clk-mt2701-hif.c              |    4 +-
 drivers/clk/mediatek/clk-mt2701-img.c              |    4 +-
 drivers/clk/mediatek/clk-mt2701-mm.c               |    4 +-
 drivers/clk/mediatek/clk-mt2701-vdec.c             |    4 +-
 drivers/clk/mediatek/clk-mt2701.c                  |   34 +-
 drivers/clk/mediatek/clk-mt2712-bdp.c              |    4 +-
 drivers/clk/mediatek/clk-mt2712-img.c              |    4 +-
 drivers/clk/mediatek/clk-mt2712-jpgdec.c           |    4 +-
 drivers/clk/mediatek/clk-mt2712-mfg.c              |    4 +-
 drivers/clk/mediatek/clk-mt2712-mm.c               |    4 +-
 drivers/clk/mediatek/clk-mt2712-vdec.c             |    4 +-
 drivers/clk/mediatek/clk-mt2712-venc.c             |    4 +-
 drivers/clk/mediatek/clk-mt2712.c                  |   58 +-
 drivers/clk/mediatek/clk-mt6765-audio.c            |    4 +-
 drivers/clk/mediatek/clk-mt6765-cam.c              |    4 +-
 drivers/clk/mediatek/clk-mt6765-img.c              |    4 +-
 drivers/clk/mediatek/clk-mt6765-mipi0a.c           |    4 +-
 drivers/clk/mediatek/clk-mt6765-mm.c               |    4 +-
 drivers/clk/mediatek/clk-mt6765-vcodec.c           |    4 +-
 drivers/clk/mediatek/clk-mt6765.c                  |   32 +-
 drivers/clk/mediatek/clk-mt6779-aud.c              |    4 +-
 drivers/clk/mediatek/clk-mt6779-cam.c              |    4 +-
 drivers/clk/mediatek/clk-mt6779-img.c              |    4 +-
 drivers/clk/mediatek/clk-mt6779-ipe.c              |    4 +-
 drivers/clk/mediatek/clk-mt6779-mfg.c              |    4 +-
 drivers/clk/mediatek/clk-mt6779-mm.c               |    4 +-
 drivers/clk/mediatek/clk-mt6779-vdec.c             |    4 +-
 drivers/clk/mediatek/clk-mt6779-venc.c             |    4 +-
 drivers/clk/mediatek/clk-mt6779.c                  |   36 +-
 drivers/clk/mediatek/clk-mt6797-img.c              |    4 +-
 drivers/clk/mediatek/clk-mt6797-mm.c               |    4 +-
 drivers/clk/mediatek/clk-mt6797-vdec.c             |    4 +-
 drivers/clk/mediatek/clk-mt6797-venc.c             |    4 +-
 drivers/clk/mediatek/clk-mt6797.c                  |   42 +-
 drivers/clk/mediatek/clk-mt7622-aud.c              |    4 +-
 drivers/clk/mediatek/clk-mt7622-eth.c              |    8 +-
 drivers/clk/mediatek/clk-mt7622-hif.c              |    8 +-
 drivers/clk/mediatek/clk-mt7622.c                  |   48 +-
 drivers/clk/mediatek/clk-mt7629-eth.c              |    8 +-
 drivers/clk/mediatek/clk-mt7629-hif.c              |    8 +-
 drivers/clk/mediatek/clk-mt7629.c                  |   42 +-
 drivers/clk/mediatek/clk-mt7986-apmixed.c          |   22 +-
 drivers/clk/mediatek/clk-mt7986-eth.c              |   14 +-
 drivers/clk/mediatek/clk-mt7986-infracfg.c         |    4 +-
 drivers/clk/mediatek/clk-mt7986-topckgen.c         |   16 +-
 drivers/clk/mediatek/clk-mt8135.c                  |   38 +-
 drivers/clk/mediatek/clk-mt8167-aud.c              |    4 +-
 drivers/clk/mediatek/clk-mt8167-img.c              |    4 +-
 drivers/clk/mediatek/clk-mt8167-mfgcfg.c           |    4 +-
 drivers/clk/mediatek/clk-mt8167-mm.c               |    4 +-
 drivers/clk/mediatek/clk-mt8167-vdec.c             |    4 +-
 drivers/clk/mediatek/clk-mt8167.c                  |   28 +-
 drivers/clk/mediatek/clk-mt8173-mm.c               |    4 +-
 drivers/clk/mediatek/clk-mt8173.c                  |   97 +-
 drivers/clk/mediatek/clk-mt8183-audio.c            |    4 +-
 drivers/clk/mediatek/clk-mt8183-cam.c              |    4 +-
 drivers/clk/mediatek/clk-mt8183-img.c              |    4 +-
 drivers/clk/mediatek/clk-mt8183-ipu0.c             |    4 +-
 drivers/clk/mediatek/clk-mt8183-ipu1.c             |    4 +-
 drivers/clk/mediatek/clk-mt8183-ipu_adl.c          |    4 +-
 drivers/clk/mediatek/clk-mt8183-ipu_conn.c         |    4 +-
 drivers/clk/mediatek/clk-mt8183-mfgcfg.c           |    4 +-
 drivers/clk/mediatek/clk-mt8183-mm.c               |    4 +-
 drivers/clk/mediatek/clk-mt8183-vdec.c             |    4 +-
 drivers/clk/mediatek/clk-mt8183-venc.c             |    4 +-
 drivers/clk/mediatek/clk-mt8183.c                  |   47 +-
 drivers/clk/mediatek/clk-mt8186-apmixedsys.c       |  133 +
 drivers/clk/mediatek/clk-mt8186-cam.c              |   90 +
 drivers/clk/mediatek/clk-mt8186-img.c              |   68 +
 drivers/clk/mediatek/clk-mt8186-imp_iic_wrap.c     |   67 +
 drivers/clk/mediatek/clk-mt8186-infra_ao.c         |  216 +
 drivers/clk/mediatek/clk-mt8186-ipe.c              |   55 +
 drivers/clk/mediatek/clk-mt8186-mcu.c              |  108 +
 drivers/clk/mediatek/clk-mt8186-mdp.c              |   80 +
 drivers/clk/mediatek/clk-mt8186-mfg.c              |   48 +
 drivers/clk/mediatek/clk-mt8186-mm.c               |  111 +
 drivers/clk/mediatek/clk-mt8186-topckgen.c         |  780 ++
 drivers/clk/mediatek/clk-mt8186-vdec.c             |   88 +
 drivers/clk/mediatek/clk-mt8186-venc.c             |   51 +
 drivers/clk/mediatek/clk-mt8186-wpe.c              |   51 +
 drivers/clk/mediatek/clk-mt8192-aud.c              |    4 +-
 drivers/clk/mediatek/clk-mt8192-mm.c               |    4 +-
 drivers/clk/mediatek/clk-mt8192.c                  |   21 +-
 drivers/clk/mediatek/clk-mt8195-apmixedsys.c       |    6 +-
 drivers/clk/mediatek/clk-mt8195-apusys_pll.c       |    6 +-
 drivers/clk/mediatek/clk-mt8195-topckgen.c         |    6 +-
 drivers/clk/mediatek/clk-mt8195-vdo0.c             |    6 +-
 drivers/clk/mediatek/clk-mt8195-vdo1.c             |    6 +-
 drivers/clk/mediatek/clk-mt8516-aud.c              |    4 +-
 drivers/clk/mediatek/clk-mt8516.c                  |   24 +-
 drivers/clk/mediatek/clk-mtk.c                     |  173 +-
 drivers/clk/mediatek/clk-mtk.h                     |   25 +-
 drivers/clk/mediatek/clk-mux.c                     |   50 +-
 drivers/clk/mediatek/clk-mux.h                     |    6 +-
 drivers/clk/mediatek/clk-pll.c                     |   64 +-
 drivers/clk/mediatek/clk-pll.h                     |    6 +-
 drivers/clk/qcom/Kconfig                           |   19 +
 drivers/clk/qcom/Makefile                          |    2 +
 drivers/clk/qcom/clk-rcg.h                         |    2 +
 drivers/clk/qcom/clk-rcg2.c                        |  126 +-
 drivers/clk/qcom/clk-smd-rpm.c                     |    8 +-
 drivers/clk/qcom/gcc-msm8976.c                     |    7 +-
 drivers/clk/qcom/gcc-msm8998.c                     |   56 +
 drivers/clk/qcom/gcc-sc8280xp.c                    | 7488 ++++++++++++++++++++
 drivers/clk/qcom/lpassaudiocc-sc7280.c             |  838 +++
 drivers/clk/qcom/lpasscorecc-sc7280.c              |  431 ++
 drivers/clk/renesas/Kconfig                        |   17 +-
 drivers/clk/renesas/Makefile                       |    3 +
 drivers/clk/renesas/r8a774a1-cpg-mssr.c            |    9 +-
 drivers/clk/renesas/r8a774b1-cpg-mssr.c            |    9 +-
 drivers/clk/renesas/r8a774c0-cpg-mssr.c            |    8 +-
 drivers/clk/renesas/r8a774e1-cpg-mssr.c            |    9 +-
 drivers/clk/renesas/r8a7795-cpg-mssr.c             |    9 +-
 drivers/clk/renesas/r8a7796-cpg-mssr.c             |    9 +-
 drivers/clk/renesas/r8a77965-cpg-mssr.c            |    9 +-
 drivers/clk/renesas/r8a77980-cpg-mssr.c            |   10 +-
 drivers/clk/renesas/r8a77990-cpg-mssr.c            |    7 +
 drivers/clk/renesas/r8a77995-cpg-mssr.c            |   11 +-
 drivers/clk/renesas/r8a779a0-cpg-mssr.c            |   23 +-
 drivers/clk/renesas/r8a779f0-cpg-mssr.c            |   30 +-
 drivers/clk/renesas/r8a779g0-cpg-mssr.c            |  218 +
 drivers/clk/renesas/r9a06g032-clocks.c             |    2 +-
 drivers/clk/renesas/r9a07g043-cpg.c                |  320 +
 drivers/clk/renesas/r9a07g044-cpg.c                |   96 +-
 drivers/clk/renesas/r9a09g011-cpg.c                |  172 +
 drivers/clk/renesas/rcar-gen3-cpg.h                |    5 +-
 drivers/clk/renesas/rcar-gen4-cpg.c                |    5 +
 drivers/clk/renesas/rcar-gen4-cpg.h                |    3 +
 drivers/clk/renesas/renesas-cpg-mssr.c             |    6 +
 drivers/clk/renesas/renesas-cpg-mssr.h             |    1 +
 drivers/clk/renesas/rzg2l-cpg.c                    |  464 +-
 drivers/clk/renesas/rzg2l-cpg.h                    |   87 +-
 drivers/clk/rockchip/clk-rk3568.c                  |    1 +
 drivers/clk/samsung/Makefile                       |    1 +
 drivers/clk/samsung/clk-exynosautov9.c             | 1733 +++++
 drivers/clk/stm32/Makefile                         |    1 +
 drivers/clk/stm32/clk-stm32-core.c                 |  695 ++
 drivers/clk/stm32/clk-stm32-core.h                 |  188 +
 drivers/clk/stm32/clk-stm32mp13.c                  | 1620 +++++
 drivers/clk/stm32/reset-stm32.c                    |  122 +
 drivers/clk/stm32/reset-stm32.h                    |    8 +
 drivers/clk/stm32/stm32mp13_rcc.h                  | 1748 +++++
 drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c             |    5 +
 drivers/clk/sunxi-ng/ccu-sun50i-h6-r.h             |    2 +-
 drivers/clk/sunxi-ng/ccu-sun50i-h616.c             |    8 +
 drivers/clk/sunxi-ng/ccu-sun50i-h616.h             |    2 +-
 drivers/clk/tegra/clk-bpmp.c                       |   87 +-
 drivers/clk/tegra/clk-dfll.c                       |   20 +-
 drivers/clk/ti/clkctrl.c                           |   13 +-
 drivers/clk/ti/composite.c                         |    2 +-
 drivers/clk/ux500/clk-prcmu.c                      |  252 +-
 drivers/clk/ux500/clk.h                            |   70 +-
 drivers/clk/ux500/reset-prcc.c                     |    2 +-
 drivers/clk/ux500/u8500_of_clk.c                   |  350 +-
 include/dt-bindings/clock/en7523-clk.h             |   17 +
 include/dt-bindings/clock/imx8mn-clock.h           |   16 +-
 include/dt-bindings/clock/imx8mp-clock.h           |    9 +-
 include/dt-bindings/clock/mt8186-clk.h             |  445 ++
 include/dt-bindings/clock/qcom,gcc-msm8976.h       |    1 +
 include/dt-bindings/clock/qcom,gcc-sc8280xp.h      |  496 ++
 include/dt-bindings/clock/samsung,exynosautov9.h   |   14 +-
 include/dt-bindings/clock/ste-db8500-clkout.h      |   17 +
 include/dt-bindings/clock/stm32mp13-clks.h         |  229 +
 include/dt-bindings/clock/sun50i-h6-r-ccu.h        |    1 +
 include/dt-bindings/clock/sun50i-h616-ccu.h        |    1 +
 include/dt-bindings/reset/stm32mp13-resets.h       |  100 +
 249 files changed, 22752 insertions(+), 2050 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8186-clock.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8186-sys-clock.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/airoha,en7523-scu.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-apq8084.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-sc8280xp.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/qcom,rpmcc.txt
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/rockchip,px30-cru.txt
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,px30-cru.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3036-cru.txt
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3036-cru.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3188-cru.txt
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3188-cru.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3228-cru.txt
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3228-cru.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3288-cru.txt
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3288-cru.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3308-cru.txt
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3308-cru.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3368-cru.txt
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3368-cru.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/rockchip,rv1108-cru.txt
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rv1108-cru.yaml
 create mode 100644 drivers/clk/clk-en7523.c
 create mode 100644 drivers/clk/mediatek/clk-mt8186-apmixedsys.c
 create mode 100644 drivers/clk/mediatek/clk-mt8186-cam.c
 create mode 100644 drivers/clk/mediatek/clk-mt8186-img.c
 create mode 100644 drivers/clk/mediatek/clk-mt8186-imp_iic_wrap.c
 create mode 100644 drivers/clk/mediatek/clk-mt8186-infra_ao.c
 create mode 100644 drivers/clk/mediatek/clk-mt8186-ipe.c
 create mode 100644 drivers/clk/mediatek/clk-mt8186-mcu.c
 create mode 100644 drivers/clk/mediatek/clk-mt8186-mdp.c
 create mode 100644 drivers/clk/mediatek/clk-mt8186-mfg.c
 create mode 100644 drivers/clk/mediatek/clk-mt8186-mm.c
 create mode 100644 drivers/clk/mediatek/clk-mt8186-topckgen.c
 create mode 100644 drivers/clk/mediatek/clk-mt8186-vdec.c
 create mode 100644 drivers/clk/mediatek/clk-mt8186-venc.c
 create mode 100644 drivers/clk/mediatek/clk-mt8186-wpe.c
 create mode 100644 drivers/clk/qcom/gcc-sc8280xp.c
 create mode 100644 drivers/clk/qcom/lpassaudiocc-sc7280.c
 create mode 100644 drivers/clk/qcom/lpasscorecc-sc7280.c
 create mode 100644 drivers/clk/renesas/r8a779g0-cpg-mssr.c
 create mode 100644 drivers/clk/renesas/r9a07g043-cpg.c
 create mode 100644 drivers/clk/renesas/r9a09g011-cpg.c
 create mode 100644 drivers/clk/samsung/clk-exynosautov9.c
 create mode 100644 drivers/clk/stm32/Makefile
 create mode 100644 drivers/clk/stm32/clk-stm32-core.c
 create mode 100644 drivers/clk/stm32/clk-stm32-core.h
 create mode 100644 drivers/clk/stm32/clk-stm32mp13.c
 create mode 100644 drivers/clk/stm32/reset-stm32.c
 create mode 100644 drivers/clk/stm32/reset-stm32.h
 create mode 100644 drivers/clk/stm32/stm32mp13_rcc.h
 create mode 100644 include/dt-bindings/clock/en7523-clk.h
 create mode 100644 include/dt-bindings/clock/mt8186-clk.h
 create mode 100644 include/dt-bindings/clock/qcom,gcc-sc8280xp.h
 create mode 100644 include/dt-bindings/clock/ste-db8500-clkout.h
 create mode 100644 include/dt-bindings/clock/stm32mp13-clks.h
 create mode 100644 include/dt-bindings/reset/stm32mp13-resets.h

-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

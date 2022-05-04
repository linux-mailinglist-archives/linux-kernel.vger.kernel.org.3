Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFEB451B0DA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 23:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378672AbiEDVgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 17:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378607AbiEDVgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 17:36:36 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041A051E59;
        Wed,  4 May 2022 14:32:57 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 16C3D1F44B22
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651699976;
        bh=Z5GCLSdrkY/+3VJcCY9bv+EixKNHWPKoBT0IYZaa2WA=;
        h=From:To:Cc:Subject:Date:From;
        b=Wqcoau1kTsKQhWlZG00ObhGlFahIy8cKoWhMWsU3qVWs0YesIQYN9UYhHjWTueXp3
         UCt3+9tDM59z07G2wE6rZVT5sAwqDgCMCre2TNo6LmA2+0Q9qusnGWEwyOJoEFH4lR
         1cGzwPw/Rd6vEJlWTbiukQnerq10GRmcG85BwvvFNyzsIWI3/bmdRLlDxzHix2r7Z+
         W0k0qoQ2YlK1XTCoGxqKeRDE5wxnhvn7aUow5oRU2OMyRITBVCvsaQuQ9OUY0V2fOj
         y8UTLkRePo63njnJFafEAB1J3DmS3Jhe9hhw1SL+pWl/fYb8qDfhZI6CGGfJ9uLok1
         a/RUlcfJPfjmQ==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 2E14448146B; Wed,  4 May 2022 23:32:53 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@lists.collabora.co.uk,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCHv2 00/21] Basic RK3588 Support
Date:   Wed,  4 May 2022 23:32:30 +0200
Message-Id: <20220504213251.264819-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patchset adds initial rudimentary support for the rk3588 SoC using
Rockchip's evaluation board for platform bringup. With this patchset it
is possible to boot into stock Debian, if it has been previously installed
on the eMMC in some way (e.g. pre-installed vendor OS) using the Debug UART
as interface. Apart from the eMMC, the CPUs and the UART nothing works and
will be added separately on top step-by-step.

The patch series is based on v5.18-rc1.

This has been sent as a series, since all bits are required for testing
on real HW. It should be fine to merge the mmc, gpio and pinctrl bits
via their own trees. Both, the DT and the clock driver require the shared
include/dt-bindings/clock/rk3588-cru.h, so that requires some coordination.

Changelog since PATCHv1:
 * https://lore.kernel.org/all/20220422170920.401914-1-sebastian.reichel@collabora.com/
 * Fix cover letter to correctly reference 5.18-rc1 last one had a typo
   mentioning 4.18-rc1 (Emil Velikov)
 * Fix title in CRU binding (Krzysztof Kozlowski)
 * Replace status "ok" with "okay" (Krzysztof Kozlowski)
 * Remove simple-bus for clocks and rename clock nodes (Krzysztof Kozlowski)
 * Remove ITS from GIC controller, since the current mainline GIC kernel
   driver cannot handle the rockchip shareability quirk. Instead use MBI
   like the rk356x platform does at the moment. (Robin Murphy)
 * With the previous change it is possible to describe the full CPU cluster;
   for now without operating-point support, which requires additional cpufreq
   changes / rockchip specific driver (Robin Murphy)
 * Remove GIC_CPU_MASK_SIMPLE(4) from armv8-timer (Robin Murphy)
 * Add pmu node for A76
 * Move interrupt-affinity configuration into gic, which has only one
   cluster configured for all CPU cores
 * Fix sdhci-of-dwcmshc reset code to make reset control optional, since
   old rk356x DT does not describe it (Dmitry Osipenko)
 * Modify sdhci-of-dwcmshc, so that dwcmshc_rk35xx_postinit is called between
   sdhci_setup_host() and __sdhci_add_host() (Adrian Hunter)
 * Checked if 'allOf:if:then:' needs changes for rk3588 and none
   are required yet. RK3588 has more syscon nodes and they will need
   changes once support for them is added (Krzysztof Kozlowski)
 * Move SCMI_HCLK_SD definition into correct patch (Rob Herring)
 * Fix warnings found by kernel test robot
 * Add patch to document gpio-ranges in the rockchip gpio-bank to fix
   warnings from dtbs_check
 * Update PLL in the CRU, so that it fully relies on lookup tables instead
   of calculating required PLL parameters for arbitrary frequencies
   (Nicolas Dufresne & Heiko Stübner)
 * Collected Acks
 * Dropped pinctrl and mmc binding patch (applied)

-- Sebastian

Elaine Zhang (6):
  dt-binding: clock: Document rockchip,rk3588-cru bindings
  clk: rockchip: add register offset of the cores select parent
  clk: rockchip: add pll type for RK3588
  clk: rockchip: clk-cpu: add mux setting for cpu change frequency
  clk: rockchip: add dt-binding header for rk3588
  clk: rockchip: Add clock controller for the RK3588

Jianqun Xu (3):
  pinctrl/rockchip: add rk3588 support
  gpio: rockchip: add support for rk3588
  arm64: dts: rockchip: Add rk3588s pinctrl data

Kever Yang (2):
  arm64: dts: rockchip: Add base DT for rk3588 SoC
  arm64: dts: rockchip: Add rk3588-evb1 board

Sebastian Reichel (8):
  dt-bindings: pinctrl: rockchip: add rk3588
  dt-bindings: mmc: sdhci-of-dwcmhsc: Add rk3588
  mmc: sdhci-of-dwcmshc: rename rk3568 to rk35xx
  pinctrl/rockchip: add error handling for pull/drive register getters
  dt-bindings: serial: snps-dw-apb-uart: Add Rockchip RK3588
  dt-bindings: soc: rockchip: add initial rk3588 syscon compatibles
  dt-bindings: gpio: rockchip: add gpio-ranges
  dt-bindings: pinctrl: rockchip: increase max amount of device
    functions

Yifeng Zhao (2):
  mmc: sdhci-of-dwcmshc: add reset call back for rockchip Socs
  mmc: sdhci-of-dwcmshc: add support for rk3588

 .../devicetree/bindings/arm/rockchip.yaml     |    5 +
 .../bindings/clock/rockchip,rk3588-cru.yaml   |   63 +
 .../bindings/gpio/rockchip,gpio-bank.yaml     |    2 +
 .../bindings/mmc/snps,dwcmshc-sdhci.yaml      |    1 +
 .../bindings/pinctrl/rockchip,pinctrl.yaml    |    3 +-
 .../bindings/serial/snps-dw-apb-uart.yaml     |    1 +
 .../devicetree/bindings/soc/rockchip/grf.yaml |    2 +
 arch/arm64/boot/dts/rockchip/Makefile         |    1 +
 .../boot/dts/rockchip/rk3588-evb1-v10.dts     |   34 +
 arch/arm64/boot/dts/rockchip/rk3588.dtsi      |    6 +
 .../boot/dts/rockchip/rk3588s-pinctrl.dtsi    | 3403 +++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi     |  719 ++++
 drivers/clk/rockchip/Kconfig                  |    7 +
 drivers/clk/rockchip/Makefile                 |    1 +
 drivers/clk/rockchip/clk-cpu.c                |   69 +-
 drivers/clk/rockchip/clk-pll.c                |  218 +-
 drivers/clk/rockchip/clk-rk3588.c             | 2497 ++++++++++++
 drivers/clk/rockchip/clk.h                    |   65 +
 drivers/gpio/gpio-rockchip.c                  |    3 +-
 drivers/mmc/host/sdhci-of-dwcmshc.c           |  193 +-
 drivers/pinctrl/pinctrl-rockchip.c            |  468 ++-
 drivers/pinctrl/pinctrl-rockchip.h            |  170 +-
 include/dt-bindings/clock/rk3588-cru.h        | 1492 ++++++++
 23 files changed, 9306 insertions(+), 117 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3588-cru.yaml
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588s-pinctrl.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588s.dtsi
 create mode 100644 drivers/clk/rockchip/clk-rk3588.c
 create mode 100644 include/dt-bindings/clock/rk3588-cru.h

-- 
2.35.1


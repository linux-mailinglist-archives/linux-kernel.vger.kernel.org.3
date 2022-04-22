Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51DB550BE62
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 19:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232632AbiDVROu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 13:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241302AbiDVRMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 13:12:32 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339B09157B;
        Fri, 22 Apr 2022 10:09:36 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 14D901F468DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650647375;
        bh=oZKU0pLxTu4eVBBy9OBJG6OyeGYOH15W+nncmVc3P1o=;
        h=From:To:Cc:Subject:Date:From;
        b=PZRjf+EM6Q3qjjvrKN+isMXE6vt1nVnGaQPm8Gg+kr6cNy5RI04nwk8pAliz8c7T4
         FGuBGONwuEUjOM19nrQaMWe0PRbGLeMaD3v6vsm9RDrkFfjHhb1lqKjbMObqtqrFe7
         3WvjnMs6QevTk2jSWHdhoQrQ5+yI904o7NBUmfDzZqxGwMkg/MA+CuLCFKFahpsesz
         tk/Nd65KAoGu1Pp8SXbifaBbnsZekKD5X8W4gT9qMTHx6oexqKzKrZX1+wBbgtDUOw
         psC7tcatCK27uy8BlwhUuqCZ/Ff2daz5grnooRxRm9CPIei++8xE1pZEf0RenmmsLC
         Ys6beOeO5uf3g==
Received: by jupiter.universe (Postfix, from userid 1000)
        id BE2394807DF; Fri, 22 Apr 2022 19:09:32 +0200 (CEST)
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
Subject: [PATCHv1 00/19] Basic RK3588 Support
Date:   Fri, 22 Apr 2022 19:09:01 +0200
Message-Id: <20220422170920.401914-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
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
as interface. Apart from the eMMC, the boot CPU and the UART. Apart from
that nothing works and will be added separately on top step-by-step.

The patch series is based on v4.18-rc1.

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

Sebastian Reichel (6):
  dt-bindings: mmc: sdhci-of-dwcmhsc: Add rk3588
  mmc: sdhci-of-dwcmshc: rename rk3568 to rk35xx
  dt-bindings: pinctrl: rockchip: add rk3588
  pinctrl/rockchip: add error handling for pull/drive register getters
  dt-bindings: serial: snps-dw-apb-uart: Add Rockchip RK3588
  dt-bindings: soc: rockchip: add initial rk3588 syscon compatibles

Yifeng Zhao (2):
  mmc: sdhci-of-dwcmshc: add reset call back for rockchip Socs
  mmc: sdhci-of-dwcmshc: add support for rk3588

 .../devicetree/bindings/arm/rockchip.yaml     |    5 +
 .../bindings/clock/rockchip,rk3588-cru.yaml   |   63 +
 .../bindings/mmc/snps,dwcmshc-sdhci.yaml      |    1 +
 .../bindings/pinctrl/rockchip,pinctrl.yaml    |    1 +
 .../bindings/serial/snps-dw-apb-uart.yaml     |    1 +
 .../devicetree/bindings/soc/rockchip/grf.yaml |    2 +
 arch/arm64/boot/dts/rockchip/Makefile         |    1 +
 .../boot/dts/rockchip/rk3588-evb1-v10.dts     |   34 +
 arch/arm64/boot/dts/rockchip/rk3588.dtsi      |    6 +
 .../boot/dts/rockchip/rk3588s-pinctrl.dtsi    | 3403 +++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi     |  501 +++
 drivers/clk/rockchip/Kconfig                  |    7 +
 drivers/clk/rockchip/Makefile                 |    1 +
 drivers/clk/rockchip/clk-cpu.c                |   69 +-
 drivers/clk/rockchip/clk-pll.c                |  287 +-
 drivers/clk/rockchip/clk-rk3588.c             | 2496 ++++++++++++
 drivers/clk/rockchip/clk.h                    |   65 +
 drivers/gpio/gpio-rockchip.c                  |    3 +-
 drivers/mmc/host/sdhci-of-dwcmshc.c           |  187 +-
 drivers/pinctrl/pinctrl-rockchip.c            |  468 ++-
 drivers/pinctrl/pinctrl-rockchip.h            |  170 +-
 include/dt-bindings/clock/rk3588-cru.h        | 1492 ++++++++
 22 files changed, 9148 insertions(+), 115 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3588-cru.yaml
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588s-pinctrl.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588s.dtsi
 create mode 100644 drivers/clk/rockchip/clk-rk3588.c
 create mode 100644 include/dt-bindings/clock/rk3588-cru.h

-- 
2.35.1


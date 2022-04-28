Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5AC2513EDC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 01:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353153AbiD1XNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 19:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232236AbiD1XM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 19:12:59 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 794D4852E9;
        Thu, 28 Apr 2022 16:09:43 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1DE9511FB;
        Thu, 28 Apr 2022 16:09:43 -0700 (PDT)
Received: from slackpad.fritz.box (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 680DA3F5A1;
        Thu, 28 Apr 2022 16:09:41 -0700 (PDT)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v11 0/6] arm64: sunxi: Initial Allwinner H616 SoC support
Date:   Fri, 29 Apr 2022 00:09:27 +0100
Message-Id: <20220428230933.15262-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

another attempt in getting the H616 finally officially supported. The
RTC patches went in, and together with the new RTC clock driver this
part is *mostly* covered now. The first two patches plug the last two
holes in the clock tree: the new RTC register gate clock, and the PLL
derived 32KHz clock, both required by the new RTC clock binding. Now
also working on the H6 ;-)
For simplicity I dropped the USB patches again - for now.

This is based on top of 5.18-rc3, but requires the "mark rtc-32k as
critical" clock patch[1], which has been pushed, but didn't reach
Linus' tree yet. Please note that there is no conflict, it's "just"
required for functionality.

For a complete changelog, see below.

Also available here: https://github.com/apritzel/linux/commits/h616-v11

Thanks!
Andre

==================
This series gathers patches to support the Allwinner H616 SoC. This is
a rather uninspired SoC (Quad-A53 with the usual peripherals), but
allows for some cheap development boards and TV boxes, and supports
up to 4GB of DRAM.

Some DT binding patches are sprinkled throughout the series, to add
the new compatible names right before they are used.
Eventually we get the .dtsi for the SoC in patch 3, and the .dts for
the OrangePi Zero2 board[2] in the over-next patch, followed by the
.dts for the X96 Mate TV box[3] afterwards.

U-Boot and Trusted Firmware support is now merged in released versions,
it allows booting via FEL or SD card, also you can TFTP kernels in on
the OrangePi Zero 2 board.

Many thanks to Jernej for his tremendous help on this, also for the
awesome input and help from the #linux-sunxi Freenode channel.

The whole series (including the prerequisites) can also be found here:
https://github.com/apritzel/linux/commits/h616-v11

Happy reviewing!

Cheers,
Andre

[1] https://lore.kernel.org/linux-arm-kernel/20220411050100.40964-1-samuel@sholland.org/
[2] https://linux-sunxi.org/Orange_Pi_Zero_2
[3] https://linux-sunxi.org/X96_Mate

Changelog v10 .. v11:
- Drop already merged RTC patches
- Drop USB patches
- Also add RTC gate clock to the H6, but mark it as unused
- Add X96 Mate manufacturer to vendor list

Changelog v9 .. v10:
- based on ccu-sun6i-rtc clock driver
- add RTC bus clock and 32k system PLL clock
- drop clock related code from actual RTC driver (just use RTC bits)
- .dtsi: remove redundant status = "okay"; from .dtsi
- .dts: drop #address-cells = <0> from IRQ controller nodes
- .dtsi: fix indentation of IR node
- .dtsi: adjust RTC node to new binding
- re-add USB patches

Changelog v8 .. v9:
- RTC: Rely on the division to split of the H:M:S part from the day part
- Add Jernej's Review tags

Changelog v7 .. v8:
- Rebase on top of 5.14-rc1, which already includes the previous v7 02/19
- Drop USB and Ethernet patches (to keep series small)
- Use "clocks: false" in RTC DT binding (2/11)
- Include fix for RTC overflow check (3/11)
- Use div_64() to avoid linking error on some 32-bit platforms (4+5/11)
- Adjust to changed RTC overflow check (5/11)
- Drop USB nodes from .dtsi file
- Move mmc-ddr-1_8v property from .dtsi file into board .dts
- Fix DTC warnings (underscore in node name, soc@0, #a-c in IRQ controllers)

Changelog v6 .. v7:
- Fix AXP305 binding documentation blunder (01/19)
- Improve new linear day support (use existing conversion functions) (04/19)
- Add support for changed RTC alarm registers (05/19)
- Add support for RTCs without a LOSC clock (06/19)
- Rework USB PHY2 SIDDQ quirk to use PHY clocks directly (14/19)
- Add X96 Mate compatible string to binding doc (17/19)
- Add Rob's ACKs

Changelog v5 .. v6:
- Drop already merged clock, pinctrl and MMC support from this series
- Properly fix AXP support by skipping power key initialisation
- Add patch to support new RTC date storage encoding
- Re-add USB HCI PHY refactoring
- Add patch to allow USB reset line sharing
- Add patch to introduce quirk for PHY2 SIDDQ clearing
- Re-add USB nodes to the .dtsi
- Add USB gadget support
- Add DT for X96 Mate TV box

Changelog v4 .. v5:
- Fix CCU binding to pass dtbs_check
- Add RSB compatible string to binding doc
- Rename IR pin name to pass dtbs_check
- Add EMAC compatible string to binding doc
- Drop USB PHY support and binding doc patches 
- Drop USB nodes from .dtsi and .dts
- Drop second EMAC node from .dtsi

Changelog v3 .. v4:
- Drop MMC and pinctrl matches (already in some -next trees)
- Add Maxime's Acks
- Add patch to update the AXP MFD DT bindings
- Add new patch (05/21) to fix axp20x-pek driver
- Change AXP IRQ fix to check for invalid IRQ line number
- Split joint DT bindings patch (v3 18/21) into subsystems
- move dwmac variable to keep christmas tree
- Use enums for USB PHY compatible strings in DT binding
- Enable watchdog (briefly verified to work)
- Add PHY2 to HCI1&3, this fixes USB
- limit r-ccu register frame length to not collide with NMI controller
- add interrupt-controller property to AXP DT node

Changelog v2 .. v3:
- Add Rob's Acks
- Drop redundant maxItems from pinctrl DT binding
- Rename h_i2s* to just i2s* in pinctrl names
- Use more declarative i2s0_d{in,out}{0,1} names
- Add RSB pins to pinctrl
- Include RSB clocks (sharing with newly added H6 versions)
- Fix CEC clock (add 2nd enable bit, also fix predivider flag)
- Rename PMU_UNK1 register in USB PHY
- Add USB and MUSB DT binding patches
- Add MMC/SD speed modes to .dtsi

Changelog v1 .. v2:
- pinctrl: adjust irq bank map to cover undocumented GPIO bank IRQs
- use differing h_i2s0 pin output names
- r-ccu: fix number of used clocks
- ccu: remove PLL-PERIPHy(4X)
- ccu: fix gpu1 divider range
- ccu: fix usb-phy3 parent
- ccu: add missing TV clocks
- ccu: rework to CLK_OF_DECLARE style
- ccu: enable output bit for PLL clocks
- ccu: renumber clocks
- .dtsi: drop sun50i-a64-system-control fallback
- .dtsi: drop unknown SRAM regions
- .dtsi: add more (undocumented) GPIO interrupts
- .dtsi: fix I2C3 pin names
- .dtsi: use a100-emmc fallback for MMC2
- .dtsi: add second EMAC controller
- .dtsi: use H3 MUSB controller fallback
- .dtsi: fix frame size for USB PHY PMU registers
- .dtsi: add USB0 PHY references
- .dtsi: fix IR controller clock source
- .dts: fix LED naming and swap pins
- .dts: use 5V supply parent for USB supply
- .dts: drop dummy IRQ for AXP
- .dts: enable 3V3 header pin power rail
- .dts: add SPI flash node
- .dts: make USB-C port peripheral only
- add IRQ-less AXP support
- add two patches to support more than one EMAC clock
- add patch to rework and extend USB PHY support
- add DT binding documentation patches

Andre Przywara (6):
  clk: sunxi-ng: h6-r: Add RTC gate clock
  clk: sunxi-ng: h616: Add PLL derived 32KHz clock
  arm64: dts: allwinner: Add Allwinner H616 .dtsi file
  dt-bindings: arm: sunxi: Add two H616 board compatible strings
  arm64: dts: allwinner: h616: Add OrangePi Zero 2 board support
  arm64: dts: allwinner: h616: Add X96 Mate TV box support

 .../devicetree/bindings/arm/sunxi.yaml        |  10 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm64/boot/dts/allwinner/Makefile        |   2 +
 .../allwinner/sun50i-h616-orangepi-zero2.dts  | 203 +++++++
 .../dts/allwinner/sun50i-h616-x96-mate.dts    | 177 ++++++
 .../arm64/boot/dts/allwinner/sun50i-h616.dtsi | 574 ++++++++++++++++++
 drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c        |   5 +
 drivers/clk/sunxi-ng/ccu-sun50i-h6-r.h        |   2 +-
 drivers/clk/sunxi-ng/ccu-sun50i-h616.c        |   8 +
 drivers/clk/sunxi-ng/ccu-sun50i-h616.h        |   2 +-
 include/dt-bindings/clock/sun50i-h6-r-ccu.h   |   1 +
 include/dt-bindings/clock/sun50i-h616-ccu.h   |   1 +
 12 files changed, 985 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616-x96-mate.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi

-- 
2.35.3


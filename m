Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39E3B4B25A4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 13:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349984AbiBKM0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 07:26:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241000AbiBKM0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 07:26:51 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DC447E77
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 04:26:49 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F1C81042;
        Fri, 11 Feb 2022 04:26:49 -0800 (PST)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.196.172])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 18B923F70D;
        Fri, 11 Feb 2022 04:26:47 -0800 (PST)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Rob Herring <robh@kernel.org>, Ondrej Jirman <megous@megous.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Samuel Holland <samuel@sholland.org>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v10 00/18] arm64: sunxi: Initial Allwinner H616 SoC support
Date:   Fri, 11 Feb 2022 12:26:25 +0000
Message-Id: <20220211122643.1343315-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

an update of the H616 afer some silence, hope to get the ball rolling
on this again. This is now based on top of 5.17-rc2, plus Samuel's
H616 RTC clock patches, which Maxime took already locally.
This being the first user of this new clock driver revealed some issue,
where the actual RTC clock was not referenced, thus turned off. IIUC
Samuel is thinking about a fix to the clock driver for that. Meanwhile
clk_ignore_unused worked around the issue, so the clock driver and the
RTC work in general.
To accommodate the new clock driver, I needed to add two clocks (RTC bus
clock and the "32K system PLL"), this is done in patch 01 and 02.
The rest of the RTC driver patches (03-05) is just rebased, with the
actual enablement patch (06) now being trivial.
The .dtsi patch (07) has been amended to match the new RTC binding, also
fixing some smaller issues in there.

I also add the USB patches on top, since they seem to be needed by other
SoCs as well, and we should get them moving again. However I would be
happy enough to first see the RTC and basic DT patches handled.

For a complete changelog, see below.

Based on 5.17-rc2, plus Samuel's RTC clock driver series[1].
Let me know if you need a different base.

Also available here: https://github.com/apritzel/linux/commits/h616-v10

Thanks!
Andre

==================
This series gathers patches to support the Allwinner H616 SoC. This is
a rather uninspired SoC (Quad-A53 with the usual peripherals), but
allows for some cheap development boards and TV boxes, and supports
up to 4GB of DRAM.

Some DT binding patches are sprinkled throughout the series, to add
the new compatible names right before they are used.
Patch 3-6 add support for the new RTC: the date is now stored as a
linear number, not broken down into day-month-year. The benefit is that
this lifts the limit of the old date counter, which would have rolled
over around 2032. Also the alarm setting is using the same storage
format as the current time, compared to the number of seconds left used
in existing SoCs.
Eventually we get the .dtsi for the SoC in patch 7, and the .dts for
the OrangePi Zero2 board[2] in the next patch, followed by the .dts
for the X96 Mate TV box[3] afterwards.

U-Boot and Trusted Firmware support is now merged in released versions,
it allows booting via FEL or SD card, also you can TFTP kernels in on
the OrangePi Zero 2 board.

Many thanks to Jernej for his tremendous help on this, also for the
awesome input and help from the #linux-sunxi Freenode channel.

The whole series (including the prerequisites) can also be found here:
https://github.com/apritzel/linux/commits/h616-v10

Happy reviewing!

Cheers,
Andre

[1] https://lore.kernel.org/all/20220203021736.13434-1-samuel@sholland.org/
[2] https://linux-sunxi.org/Orange_Pi_Zero_2
[3] https://linux-sunxi.org/X96_Mate

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

Andre Przywara (18):
  clk: sunxi-ng: h616-r: Add RTC gate clock
  clk: sunxi-ng: h616: Add PLL derived 32KHz clock
  rtc: sun6i: Fix time overflow handling
  rtc: sun6i: Add support for linear day storage
  rtc: sun6i: Add support for broken-down alarm registers
  rtc: sun6i: Add Allwinner H616 support
  arm64: dts: allwinner: Add Allwinner H616 .dtsi file
  dt-bindings: arm: sunxi: Add two H616 board compatible strings
  arm64: dts: allwinner: h616: Add OrangePi Zero 2 board support
  arm64: dts: allwinner: h616: Add X96 Mate TV box support
  dt-bindings: usb: Add H616 compatible string
  phy: sun4i-usb: Rework HCI PHY (aka. "pmu_unk1") handling
  phy: sun4i-usb: Allow reset line to be shared
  phy: sun4i-usb: Introduce port2 SIDDQ quirk
  phy: sun4i-usb: Add support for the H616 USB PHY
  arm64: dts: allwinner: h616: Add USB nodes
  arm64: dts: allwinner: h616: OrangePi Zero 2: Add USB nodes
  arm64: dts: allwinner: h616: X96 Mate: Add USB nodes

 .../devicetree/bindings/arm/sunxi.yaml        |  10 +
 .../devicetree/bindings/usb/generic-ehci.yaml |   1 +
 .../devicetree/bindings/usb/generic-ohci.yaml |   1 +
 arch/arm64/boot/dts/allwinner/Makefile        |   2 +
 .../allwinner/sun50i-h616-orangepi-zero2.dts  | 245 ++++++
 .../dts/allwinner/sun50i-h616-x96-mate.dts    | 202 +++++
 .../arm64/boot/dts/allwinner/sun50i-h616.dtsi | 734 ++++++++++++++++++
 drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c        |   4 +
 drivers/clk/sunxi-ng/ccu-sun50i-h6-r.h        |   2 +-
 drivers/clk/sunxi-ng/ccu-sun50i-h616.c        |   7 +
 drivers/clk/sunxi-ng/ccu-sun50i-h616.h        |   2 +-
 drivers/phy/allwinner/phy-sun4i-usb.c         | 103 ++-
 drivers/rtc/rtc-sun6i.c                       | 134 ++--
 include/dt-bindings/clock/sun50i-h6-r-ccu.h   |   1 +
 include/dt-bindings/clock/sun50i-h616-ccu.h   |   1 +
 15 files changed, 1384 insertions(+), 65 deletions(-)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616-x96-mate.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi

-- 
2.25.1


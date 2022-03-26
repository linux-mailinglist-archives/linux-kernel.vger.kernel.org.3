Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3FD04E8085
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 11:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbiCZKsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 06:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiCZKsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 06:48:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE9649937;
        Sat, 26 Mar 2022 03:46:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 98A99B80092;
        Sat, 26 Mar 2022 10:46:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7C54C340E8;
        Sat, 26 Mar 2022 10:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648291613;
        bh=lQB4l0ySaZSjww3LDHFpeXI1Gr/+snM1r80PmHt17ZY=;
        h=Date:From:To:Cc:Subject:From;
        b=f7fFWX3VNXQTurvuafPylF6LXR206xEbRIDHd7ApJ5GztuOSlxB1wKHFvBGdWQBSa
         20m0qqnhlOWrJQPfpcPx5wofcSMku4iBtQ8Az35iAuVSEg/Ahmqg39FpfINYNtcwNf
         kMU2OXXZsakrOCnxMg0ZTadSL6V+JjDLVVFQRmJE=
Date:   Sat, 26 Mar 2022 11:46:50 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB/Thunderbolt driver changes for 5.18-rc1
Message-ID: <Yj7vGtn8fILavjyL@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 09688c0166e76ce2fb85e86b9d99be8b0084cdf9:

  Linux 5.17-rc8 (2022-03-13 13:23:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.18-rc1

for you to fetch changes up to 46d2c20b0b10cf07a2a24b047a09195ba96c84f7:

  usb: gadget: fsl_qe_udc: Add missing semicolon in qe_ep_dequeue() (2022-03-19 13:46:06 +0100)

----------------------------------------------------------------
USB/Thunderbolt patches for 5.18-rc1

Here is the big set of USB and Thunderbolt changes for 5.18-rc1.

Nothing major in here, just lots of little improvements and cleanups and
new device support.  Highlights are:
	- list iterator fixups for when we walk past the end of the list
	  (a common problem that was cut/pasted in almost all USB gadget
	  drivers)
	- xen USB driver "hardening" for malicious hosts
	- xhci driver updates and fixes for more hardware types
	- xhci debug cable fixes to make it actually work again
	- usb gadget audio driver improvements
	- usb gadget storage fixes to work with OS-X
	- lots of other small usb gadget fixes and updates
	- USB DWC3 driver improvements for more hardware types
	- Lots of other small USB driver improvements
	- DTS updates for some USB platforms

Note, the DTS updates will have a merge conflict in your tree.  The
fixup should be simple, but if not, I can provide a merged tree if
needed.

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alan Stern (2):
      USB: core: Update kerneldoc for usb_get_dev() and usb_get_intf()
      USB: usb-storage: Fix use of bitfields for hardware data in ene_ub6250.c

Alexander Stein (6):
      usb: dwc3: drd: Add support for usb-conn-gpio based usb-role-switch
      usb: dwc3: imx8mp: rename iomem base pointer
      dt-bindings: usb: dwc3-imx8mp: Add imx8mp specific flags
      usb: dwc3: imx8mp: Add support for setting SOC specific flags
      arm64: dts: imx8mp: Add memory for USB3 glue layer to usb3 nodes
      usb: common: usb-conn-gpio: Make VBUS supply completely optional

Allen-KH Cheng (1):
      dt-bindings: usb: mtk-xhci: add compatible for mt8186

AngeloGioacchino Del Regno (1):
      usb: host: xhci-mtk: Simplify supplies handling with regulator_bulk

Anssi Hannula (2):
      xhci: fix garbage USBSTS being logged in some cases
      xhci: fix uninitialized string returned by xhci_decode_ctrl_ctx()

Bin Yang (1):
      usb: dwc3: core: do not use 3.0 clock when operating in 2.0 mode

Bjorn Helgaas (1):
      USB: hcd-pci: Use PCI_STD_NUM_BARS when checking standard BARs

Cai Huoqing (1):
      usbip: vudc: Make use of the helper macro LIST_HEAD()

ChiYuan Huang (2):
      dt-bindings: usb: rt1719: Add binding for Richtek RT1719
      usb: typec: rt1719: Add support for Richtek RT1719

Chris Packham (1):
      usb: host: ehci-platform: Update brcm, xgs-iproc-ehci workaround

Christophe JAILLET (2):
      thunderbolt: Remove useless DMA-32 fallback configuration
      usb: host: xhci-plat: Remove useless DMA-32 fallback configuration

Chunfeng Yun (2):
      dt-bindings: usb: mtk-xhci: add support ip-sleep for mt8195
      usb: xhci-mtk: add support ip-sleep wakeup for mt8195

Colin Ian King (2):
      usb: gadget: f_uac2: change maxpctksize/maxpcktsize to wMaxPacketSize
      USB: serial: usb_wwan: remove redundant assignment to variable i

Conor Dooley (1):
      dt-bindings: usb: add bindings for microchip mpfs musb

Dan Carpenter (1):
      USB: storage: ums-realtek: fix error code in rts51x_read_mem()

Dinh Nguyen (3):
      dt-bindings: usb: dwc2: add compatible "intel,socfpga-agilex-hsotg"
      usb: dwc2: Add platform specific data for Intel's Agilex
      arm64: dts: agilex: use the compatible "intel,socfpga-agilex-hsotg"

Eddie James (1):
      USB: serial: pl2303: add IBM device IDs

Geert Uytterhoeven (2):
      usb: misc: USB_QCOM_EUD should depend on ARCH_QCOM
      usb: Drop commas after SoC match table sentinels

Greg Kroah-Hartman (6):
      Merge tag 'v5.17-rc2' into usb-next
      Merge 5.17-rc4 into usb-next
      Merge 5.17-rc6 into usb-next
      Merge tag 'usb-serial-5.18-rc1' of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-next
      Merge tag 'thunderbolt-for-v5.18-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt into usb-next
      Merge tag 'v5.17-rc8' into usb-next

Gustavo A. R. Silva (5):
      usb: host: ehci-sched: Use struct_size() in kzalloc()
      usb: gadget: f_phonet: Use struct_size() helper in kzalloc()
      usb: host: fotg210: Use struct_size() helper in kzalloc()
      usb: gadget: f_fs: Use struct_size() and flex_array_size() helpers
      usb: xhci-mtk: Use struct_size() helper in create_sch_ep()

H. Nikolaus Schaller (1):
      usb: dwc3: omap: fix "unbalanced disables for smps10_out1" on omap5evm

Hans de Goede (3):
      usb: dwc3: pci: Set the swnode from inside dwc3_pci_quirks()
      usb: dwc3: pci: Set "linux,phy_charger_detect" property on some Bay Trail boards
      usb: dwc3: pci: Also apply Bay Trail GPIO mappings to ulpi-device

Heiner Kallweit (1):
      usb: dwc3-meson-g12a: constify drvdata structs

Henry Lin (1):
      xhci: fix runtime PM imbalance in USB2 resume

Ingo Rohloff (1):
      USB: usbfs: Use a spinlock instead of atomic accesses to tally used memory.

Jakob Koschel (26):
      usb: gadget: fsl: remove usage of list iterator past the loop body
      usb: gadget: bdc: remove usage of list iterator past the loop body
      usb: gadget: udc: atmel: remove usage of list iterator past the loop body
      usb: gadget: udc: pxa25x: remove usage of list iterator past the loop body
      usb: gadget: udc: at91: remove usage of list iterator past the loop body
      usb: gadget: goku_udc: remove usage of list iterator past the loop body
      usb: gadget: udc: gr_udc: remove usage of list iterator past the loop body
      usb: gadget: lpc32xx_udc: remove usage of list iterator past the loop body
      usb: gadget: mv_u3d: remove usage of list iterator past the loop body
      usb: gadget: udc: mv_udc_core: remove usage of list iterator past the loop body
      usb: gadget: net2272: remove usage of list iterator past the loop body
      usb: gadget: udc: net2280: remove usage of list iterator past the loop body
      usb: gadget: omap_udc: remove usage of list iterator past the loop body
      usb: gadget: s3c-hsudc: remove usage of list iterator past the loop body
      usb: gadget: udc-xilinx: remove usage of list iterator past the loop body
      usb: gadget: aspeed: remove usage of list iterator past the loop body
      usb: gadget: configfs: remove using list iterator after loop body as a ptr
      usb: gadget: legacy: remove using list iterator after loop body as a ptr
      usb: gadget: udc: max3420_udc: remove using list iterator after loop body as a ptr
      usb: gadget: tegra-xudc: remove using list iterator after loop body as a ptr
      usb: gadget: composite: remove check of list iterator against head past the loop body
      usb: gadget: pxa27x_udc: replace usage of rc to check if a list element was found
      usb: gadget: composite: remove usage of list iterator past the loop body
      usb: gadget: udc: core: remove usage of list iterator past the loop body
      usb: gadget: dummy_hcd: remove usage of list iterator past the loop body
      usb: gadget: udc: s3c2410: remove usage of list iterator past the loop body

Joe Perches (1):
      usb: gadget: f_uac2: Neaten and reduce size of afunc_validate_opts

Johan Hovold (2):
      USB: serial: simple: add Nokia phone driver
      USB: serial: pl2303: fix GS type detection

Juergen Gross (2):
      xen/usb: don't use arbitrary_virt_to_machine()
      xen/usb: harden xen_hcd against malicious backends

Julia Lawall (2):
      usb: gadget: udc: fix typos in comments
      usb: raw-gadget: use kzalloc

Julian Scheel (3):
      usb: gadget: u_audio: Support multiple sampling rates
      usb: gadget: f_uac2: Support multiple sampling rates
      usb: gadget: f_uac1: Support multiple sampling rates

Kai-Heng Feng (1):
      usb: core: Bail out when port is stuck in reset loop

Krzysztof Kozlowski (3):
      dt-bindings: usb: samsung,exynos-dwc3: convert to dtschema
      dt-bindings: usb: samsung,exynos-usb2: convert to dtschema
      dt-bindings: usb: hcd: correct usb-device path

Linyu Yuan (6):
      usb: host: xhci: use ffs() in xhci_mem_init()
      usb: host: xhci: fix a comment typo in xhci_mem_init()
      usb: host: xhci: update hci_version operation in xhci_gen_setup()
      usb: host: xhci: add blank line in xhci_halt()
      usb: host: xhci: Remove some unnecessary return value initializations
      usb: gadget: Makefile: remove ccflags-y

Luca Weiss (1):
      dt-bindings: usb: qcom,dwc3: Add msm8953 compatible

Mario Limonciello (5):
      thunderbolt: Retry DROM reads for more failure scenarios
      thunderbolt: Do not resume routers if UID is not set
      thunderbolt: Do not make DROM read success compulsory
      thunderbolt: Clarify register definitions for `tb_cap_plug_events`
      thunderbolt: Rename EEPROM handling bits to match USB4 spec

Mathias Nyman (8):
      xhci: dbc: refactor xhci_dbc_init()
      xhci: dbc: create and remove dbc structure in dbgtty driver.
      xhci: dbc: Rename xhci_dbc_init and xhci_dbc_exit
      xhci: dbc: Don't call dbc_tty_init() on every dbc tty probe
      xhci: dbgtty: use IDR to support several dbc instances.
      xhci: Allocate separate command structures for each LPM command
      usb: remove Link Powermanagement (LPM) disable before port reset.
      xhci: make xhci_handshake timeout for xhci_reset() adjustable

Michael Grzeschik (2):
      usb: dwc3: gadget: ep_queue simplify isoc start condition
      usb: dwc3: gadget: move cmd_endtransfer to extra function

Michael Riesch (1):
      dt-bindings: usb: add rk3568 compatible to rockchip, dwc3

Mika Westerberg (3):
      thunderbolt: Disable LTTPR on Intel Titan Ridge
      thunderbolt: Add missing device ID to tb_switch_is_alpine_ridge()
      thunderbolt: Add internal xHCI connect flows for Thunderbolt 3 devices

Neal Liu (1):
      usb: ehci: add pci device support for Aspeed platforms

Oliver Neukum (1):
      xhci: omit mem read just after allocation of trb

Pavel Hofman (11):
      usb: gadget:audio: Replace deprecated macro S_IRUGO
      usb: gadget: u_audio: Move dynamic srate from params to rtd
      usb: gadget: u_audio: Add capture/playback srate getter
      usb: gadget: u_audio: Rate ctl notifies about current srate (0=stopped)
      usb: gadget: u_audio: Add suspend call
      usb: gadget: f_uac2: Add suspend callback
      usb: gadget: f_uac1: Add suspend callback
      usb: gadget: f_uac2: Add HS/SS bInterval to configfs
      usb: gadget: audio: Add HS/SS bInterval params for UAC2
      usb: gadget: f_uac2: Optionally determine bInterval for HS and SS
      usb: gadget: f_uac2: Add speed names to bInterval dbg/warn

Pawel Laszczak (2):
      usb: cdnsp: fix cdnsp_decode_trb function to properly handle ret value
      usb: cdnsp: remove not used temp_64 variables

Peter Zijlstra (3):
      x86/tsc: Be consistent about use_tsc_delay()
      usb: early: xhci-dbc: Remove duplicate keep parsing
      usb: early: xhci-dbc: Fix xdbc number parsing

Rafael J. Wysocki (2):
      USB: ACPI: Replace acpi_bus_get_device()
      thunderbolt: Replace acpi_bus_get_device()

Randy Dunlap (2):
      usb: usbip: eliminate anonymous module_init & module_exit
      usb: gadget: eliminate anonymous module_init & module_exit

Roger Quadros (1):
      usb: gadget: f_mass_storage: Make CD-ROM emulation work with Mac OS-X

Samuel Holland (4):
      dt-bindings: vendor-prefixes: Add willsemi
      dt-bindings: usb: Add WUSB3801 Type-C Port Controller
      usb: typec: Factor out non-PD fwnode properties
      usb: typec: Support the WUSB3801 port controller

Sean Anderson (7):
      dt-bindings: usb: dwc3: Deprecate snps,ref-clock-period-ns
      usb: dwc3: Get clocks individually
      usb: dwc3: Calculate REFCLKPER based on reference clock
      usb: dwc3: Program GFLADJ
      arm64: dts: zynqmp: Move USB clocks to dwc3 node
      arm64: dts: ipq6018: Use reference clock to set dwc3 period
      usb: ulpi: Add debugfs support

Sergey Shtylyov (3):
      usb: host: {e|o}hci-dbg: kill useless 'ret' variable initializers
      usb: host: xhci: drop redundant checks
      usb: host: ehci-q: make qtd_fill() return *unsigned int*

Shruthi Sanil (1):
      usb: dwc3: pci: Add support for Intel Alder Lake

Souradeep Chowdhury (8):
      dt-bindings: Add the yaml bindings for EUD
      bindings: usb: dwc3: Update dwc3 properties for EUD connector
      usb: misc: eud: Add driver support for Embedded USB Debugger(EUD)
      arm64: dts: qcom: sc7280: Add EUD dt node and dwc3 connector
      arm64: dts: qcom: sc7280: Set the default dr_mode for usb2
      MAINTAINERS: Add maintainer entry for EUD
      Revert "arm64: dts: qcom: sc7280: Set the default dr_mode for usb2"
      Revert "arm64: dts: qcom: sc7280: Add EUD dt node and dwc3 connector"

Sven Peter (1):
      usb: typec: tipd: Forward plug orientation to typec subsystem

Thinh Nguyen (3):
      usb: dwc3: drd: Don't check against CONFIG_OF
      usb: dwc3: gadget: Give some time to schedule isoc
      usb: dwc3: gadget: Wait for ep0 xfers to complete during dequeue

Vincent Mailhol (2):
      usb: oxu210hp-hcd: remove redundant call to max_packet() macro
      usb: isp1760: remove redundant max_packet() macro

Wayne Chang (2):
      usb: gadget: tegra-xudc: Do not program SPARAM
      usb: gadget: tegra-xudc: Fix control endpoint's definitions

Wei Ming Chen (1):
      usb: raw-gadget: return -EINVAL if no proper ep address available

Wesley Cheng (2):
      usb: gadget: f_serial: Ensure gserial disconnected during unbind
      usb: dwc3: Issue core soft reset before enabling run/stop

YueHaibing (1):
      usb: gadget: fsl_qe_udc: Add missing semicolon in qe_ep_dequeue()

Yunhao Tian (2):
      usb: gadget: f_uac1: allow changing interface name via configfs
      usb: gadget: f_uac2: allow changing interface name via configfs

kernel test robot (1):
      usb: xhci: fix minmax.cocci warnings

tangmeng (1):
      usb: udc: Fix typo in comment

 Documentation/ABI/testing/configfs-usb-gadget-uac1 |   5 +-
 Documentation/ABI/testing/configfs-usb-gadget-uac2 |   7 +-
 Documentation/ABI/testing/sysfs-driver-eud         |   9 +
 .../devicetree/bindings/soc/qcom/qcom,eud.yaml     |  77 ++
 .../devicetree/bindings/usb/exynos-usb.txt         | 115 ---
 .../devicetree/bindings/usb/fsl,imx8mp-dwc3.yaml   |  31 +-
 .../devicetree/bindings/usb/mediatek,mtk-xhci.yaml |   7 +-
 .../bindings/usb/microchip,mpfs-musb.yaml          |  59 ++
 .../devicetree/bindings/usb/qcom,dwc3.yaml         |   1 +
 .../devicetree/bindings/usb/richtek,rt1719.yaml    |  85 ++
 .../devicetree/bindings/usb/rockchip,dwc3.yaml     |   2 +
 .../bindings/usb/samsung,exynos-dwc3.yaml          | 129 +++
 .../bindings/usb/samsung,exynos-usb2.yaml          | 117 +++
 .../devicetree/bindings/usb/snps,dwc3.yaml         |  13 +-
 Documentation/devicetree/bindings/usb/usb-hcd.yaml |   2 +-
 .../devicetree/bindings/usb/willsemi,wusb3801.yaml |  75 ++
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 Documentation/usb/gadget-testing.rst               |  12 +-
 MAINTAINERS                                        |   8 +
 arch/arm64/boot/dts/freescale/imx8mp.dtsi          |   6 +-
 arch/arm64/boot/dts/qcom/ipq6018.dtsi              |   3 +-
 arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi     |   4 +-
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi             |   4 +-
 arch/x86/kernel/early_printk.c                     |   2 +-
 arch/x86/kernel/tsc.c                              |   6 +-
 drivers/thunderbolt/acpi.c                         |   4 +-
 drivers/thunderbolt/eeprom.c                       |  41 +-
 drivers/thunderbolt/lc.c                           | 110 +++
 drivers/thunderbolt/nhi.c                          |   3 +-
 drivers/thunderbolt/switch.c                       |  81 +-
 drivers/thunderbolt/tb.c                           |  11 +
 drivers/thunderbolt/tb.h                           |   8 +
 drivers/thunderbolt/tb_regs.h                      |  37 +-
 drivers/thunderbolt/tunnel.c                       |  10 +
 drivers/usb/cdns3/cdnsp-debug.h                    | 305 +++----
 drivers/usb/cdns3/cdnsp-gadget.c                   |   3 -
 drivers/usb/chipidea/udc.c                         |   2 +-
 drivers/usb/common/ulpi.c                          |  71 +-
 drivers/usb/common/usb-conn-gpio.c                 |  20 +-
 drivers/usb/core/devio.c                           |  32 +-
 drivers/usb/core/hcd-pci.c                         |   2 +-
 drivers/usb/core/hub.c                             |  21 +-
 drivers/usb/core/usb-acpi.c                        |   2 +-
 drivers/usb/core/usb.c                             |   8 +
 drivers/usb/dwc2/params.c                          |  10 +
 drivers/usb/dwc3/core.c                            | 126 ++-
 drivers/usb/dwc3/core.h                            |  17 +-
 drivers/usb/dwc3/drd.c                             |  13 +
 drivers/usb/dwc3/dwc3-imx8mp.c                     |  77 +-
 drivers/usb/dwc3/dwc3-meson-g12a.c                 |  10 +-
 drivers/usb/dwc3/dwc3-omap.c                       |   2 +-
 drivers/usb/dwc3/dwc3-pci.c                        |  46 +-
 drivers/usb/dwc3/ep0.c                             |  14 +
 drivers/usb/dwc3/gadget.c                          | 118 ++-
 drivers/usb/dwc3/gadget.h                          |   1 +
 drivers/usb/early/xhci-dbc.c                       |  13 +-
 drivers/usb/gadget/Makefile                        |   1 -
 drivers/usb/gadget/composite.c                     |  36 +-
 drivers/usb/gadget/configfs.c                      |  24 +-
 drivers/usb/gadget/function/f_fs.c                 |   4 +-
 drivers/usb/gadget/function/f_mass_storage.c       |  70 +-
 drivers/usb/gadget/function/f_phonet.c             |   4 +-
 drivers/usb/gadget/function/f_serial.c             |   4 +
 drivers/usb/gadget/function/f_uac1.c               | 236 ++++-
 drivers/usb/gadget/function/f_uac2.c               | 476 +++++++---
 drivers/usb/gadget/function/u_audio.c              | 238 ++++-
 drivers/usb/gadget/function/u_audio.h              |  14 +-
 drivers/usb/gadget/function/u_uac1.h               |   7 +-
 drivers/usb/gadget/function/u_uac2.h               |  11 +-
 drivers/usb/gadget/function/uac_common.h           |   9 +
 drivers/usb/gadget/legacy/audio.c                  |  93 +-
 drivers/usb/gadget/legacy/hid.c                    |  23 +-
 drivers/usb/gadget/legacy/inode.c                  |   8 +-
 drivers/usb/gadget/legacy/raw_gadget.c             |  18 +-
 drivers/usb/gadget/legacy/serial.c                 |  10 +-
 drivers/usb/gadget/udc/aspeed-vhub/epn.c           |  12 +-
 drivers/usb/gadget/udc/at91_udc.c                  |  12 +-
 drivers/usb/gadget/udc/atmel_usba_udc.c            |  13 +-
 drivers/usb/gadget/udc/bdc/bdc_ep.c                |  13 +-
 drivers/usb/gadget/udc/core.c                      |  20 +-
 drivers/usb/gadget/udc/dummy_hcd.c                 |  25 +-
 drivers/usb/gadget/udc/fsl_qe_udc.c                |  13 +-
 drivers/usb/gadget/udc/fsl_udc_core.c              |  13 +-
 drivers/usb/gadget/udc/goku_udc.c                  |  12 +-
 drivers/usb/gadget/udc/gr_udc.c                    |  12 +-
 drivers/usb/gadget/udc/lpc32xx_udc.c               |  12 +-
 drivers/usb/gadget/udc/max3420_udc.c               |  18 +-
 drivers/usb/gadget/udc/mv_u3d_core.c               |  12 +-
 drivers/usb/gadget/udc/mv_udc_core.c               |  12 +-
 drivers/usb/gadget/udc/net2272.c                   |  13 +-
 drivers/usb/gadget/udc/net2280.c                   |  13 +-
 drivers/usb/gadget/udc/omap_udc.c                  |  12 +-
 drivers/usb/gadget/udc/pxa25x_udc.c                |  13 +-
 drivers/usb/gadget/udc/pxa27x_udc.c                |  13 +-
 drivers/usb/gadget/udc/renesas_usb3.c              |   2 +-
 drivers/usb/gadget/udc/s3c-hsudc.c                 |  12 +-
 drivers/usb/gadget/udc/s3c2410_udc.c               |  17 +-
 drivers/usb/gadget/udc/snps_udc_core.c             |   2 +-
 drivers/usb/gadget/udc/tegra-xudc.c                |  32 +-
 drivers/usb/gadget/udc/udc-xilinx.c                |  13 +-
 drivers/usb/host/ehci-dbg.c                        |   4 +-
 drivers/usb/host/ehci-pci.c                        |   9 +
 drivers/usb/host/ehci-platform.c                   |   3 +-
 drivers/usb/host/ehci-q.c                          |   7 +-
 drivers/usb/host/ehci-sched.c                      |   4 +-
 drivers/usb/host/fotg210-hcd.c                     |   4 +-
 drivers/usb/host/ohci-dbg.c                        |   4 +-
 drivers/usb/host/oxu210hp-hcd.c                    |   2 +-
 drivers/usb/host/xen-hcd.c                         |  61 +-
 drivers/usb/host/xhci-dbgcap.c                     | 145 ++--
 drivers/usb/host/xhci-dbgcap.h                     |  26 +-
 drivers/usb/host/xhci-dbgtty.c                     |  86 +-
 drivers/usb/host/xhci-hub.c                        |   5 +-
 drivers/usb/host/xhci-mem.c                        |  22 +-
 drivers/usb/host/xhci-mtk-sch.c                    |   7 +-
 drivers/usb/host/xhci-mtk.c                        |  81 +-
 drivers/usb/host/xhci-mtk.h                        |   5 +-
 drivers/usb/host/xhci-plat.c                       |  13 +-
 drivers/usb/host/xhci-rcar.c                       |   2 +-
 drivers/usb/host/xhci.c                            |  65 +-
 drivers/usb/host/xhci.h                            |  16 +-
 drivers/usb/isp1760/isp1760-hcd.c                  |   5 +-
 drivers/usb/misc/Kconfig                           |  11 +
 drivers/usb/misc/Makefile                          |   1 +
 drivers/usb/misc/qcom_eud.c                        | 251 ++++++
 drivers/usb/serial/Kconfig                         |   1 +
 drivers/usb/serial/pl2303.c                        |   2 +
 drivers/usb/serial/pl2303.h                        |   3 +
 drivers/usb/serial/usb-serial-simple.c             |   7 +
 drivers/usb/serial/usb_wwan.c                      |   1 -
 drivers/usb/storage/ene_ub6250.c                   | 155 ++--
 drivers/usb/storage/realtek_cr.c                   |   2 +-
 drivers/usb/typec/Kconfig                          |  22 +
 drivers/usb/typec/Makefile                         |   2 +
 drivers/usb/typec/class.c                          |  43 +
 drivers/usb/typec/rt1719.c                         | 961 +++++++++++++++++++++
 drivers/usb/typec/tcpm/tcpm.c                      |  24 +-
 drivers/usb/typec/tipd/core.c                      |   5 +
 drivers/usb/typec/tipd/tps6598x.h                  |   1 +
 drivers/usb/typec/wusb3801.c                       | 437 ++++++++++
 drivers/usb/usbip/vudc_main.c                      |  10 +-
 include/linux/usb/typec.h                          |   3 +
 include/linux/usb/xhci-dbgp.h                      |   2 +-
 143 files changed, 4892 insertions(+), 1254 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-eud
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,eud.yaml
 delete mode 100644 Documentation/devicetree/bindings/usb/exynos-usb.txt
 create mode 100644 Documentation/devicetree/bindings/usb/microchip,mpfs-musb.yaml
 create mode 100644 Documentation/devicetree/bindings/usb/richtek,rt1719.yaml
 create mode 100644 Documentation/devicetree/bindings/usb/samsung,exynos-dwc3.yaml
 create mode 100644 Documentation/devicetree/bindings/usb/samsung,exynos-usb2.yaml
 create mode 100644 Documentation/devicetree/bindings/usb/willsemi,wusb3801.yaml
 create mode 100644 drivers/usb/gadget/function/uac_common.h
 create mode 100644 drivers/usb/misc/qcom_eud.c
 create mode 100644 drivers/usb/typec/rt1719.c
 create mode 100644 drivers/usb/typec/wusb3801.c

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41BBB53C89A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 12:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243659AbiFCKXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 06:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243524AbiFCKXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 06:23:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C2164C6;
        Fri,  3 Jun 2022 03:23:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4589960AC4;
        Fri,  3 Jun 2022 10:23:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3235CC385A9;
        Fri,  3 Jun 2022 10:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654251785;
        bh=tRLgMzXjvH+MMVbpyn9ExRjIPnZiNiu9NAtdOyQ9PWQ=;
        h=Date:From:To:Cc:Subject:From;
        b=OHet2zofvCtSVAf0jIKVIefNKtgpyRQiarFhTEWQ1lyV4KXaG+AYm26duvOWVs18r
         PHOqpGhbEeIikxzMWmaLFu5/MO0CjVmOLmlijT+3lY+clKtb92K6Z7OhsTTfyHKE4I
         GnZ2X6hOGVq1QhKajePR9xuAX5wMQbVmFthX9Kvw=
Date:   Fri, 3 Jun 2022 12:23:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB / Thunderbolt driver updates for 5.19-rc1
Message-ID: <YpnhBp/nzjpz+Pxr@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 672c0c5173427e6b3e2a9bbb7be51ceeec78093a:

  Linux 5.18-rc5 (2022-05-01 13:57:58 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.19-rc1

for you to fetch changes up to 97fa5887cf283bb75ffff5f6b2c0e71794c02400:

  USB: new quirk for Dell Gen 2 devices (2022-05-20 21:18:23 +0200)

----------------------------------------------------------------
USB / Thunderbolt changes for 5.19-rc1

Here is the "big" set of USB and Thunderbolt driver changes for
5.18-rc1.  For the most part it's been a quiet development cycle for the
USB core, but there are the usual "hot spots" of development activity.

Included in here are:
	- Thunderbolt driver updates:
		- fixes for devices without displayport adapters
		- lane bonding support and improvements
		- other minor changes based on device testing
	- dwc3 gadget driver changes.  It seems this driver will never
	  be finished given that the IP core is showing up in zillions
	  of new devices and each implementation decides to do something
	  different with it...
	- uvc gadget driver updates as more devices start to use and
	  rely on this hardware as well
	- usb_maxpacket() api changes to remove an unneeded and unused
	  parameter.
	- usb-serial driver device id updates and small cleanups
	- typec cleanups and fixes based on device testing
	- device tree updates for usb properties
	- lots of other small fixes and driver updates.

All of these have been in linux-next for weeks with no reported
problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alan Stern (5):
      USB: gadget: Rename usb_gadget_probe_driver()
      USB: gadget: Register udc before gadget
      USB: gadget: Fix mistakes in UDC core kerneldoc
      USB: gadget: Add a new bus for gadgets
      USB: gadget: Add ID numbers to gadget names

Albert Wang (1):
      usb: dwc3: gadget: Move null pinter check to proper place

Andrey Smirnov (1):
      usb: dwc3: Don't switch OTG -> peripheral if extcon is present

AngeloGioacchino Del Regno (1):
      usb: musb: mediatek: Use clk_bulk API to simplify clock operations

Arnd Bergmann (1):
      usb: ehci-omap: drop unused ehci_read() function

Aswath Govindraju (2):
      dt-bindings: usb: Add documentation for AM62 USB Wrapper module
      drivers: usb: dwc3: Add AM62 USB wrapper driver

Bhuvanesh Surachari (1):
      usb: hub: Simplify error and success path in port_over_current_notify

Biju Das (1):
      dt-bindings: usb: renesas,usbhs: Document RZ/G2UL bindings

Bjorn Andersson (7):
      device property: Add helper to match multiple connections
      device property: Use multi-connection matchers for single case
      usb: typec: mux: Check dev_set_name() return value
      usb: typec: mux: Introduce indirection
      usb: typec: mux: Allow multiple mux_devs per mux
      dt-bindings: usb: Add binding for fcs,fsa4480
      usb: typec: mux: Add On Semi fsa4480 driver

Carl Yin(殷张成) (1):
      USB: serial: option: add Quectel BG95 modem

Christophe Leroy (1):
      usb: Prepare cleanup of powerpc's asm/prom.h

Colin Ian King (1):
      USB: gadget: Fix return of -EBUSY

Dan Vacura (3):
      usb: gadget: uvc: allow changing interface name via configfs
      usb: gadget: uvc: remove pause flag use
      usb: dwc3: gadget: increase tx fifo size for ss isoc endpoints

Daniels Umanovskis (1):
      USB: serial: ftdi_sio: clean up printk format specifier

Dmitry Torokhov (1):
      usb: Probe EHCI, OHCI controllers asynchronously

Duoming Zhou (1):
      drivers: usb: host: Fix deadlock in oxu_bus_suspend()

Evan Green (2):
      USB: core: Disable remote wakeup for freeze/quiesce
      USB: hcd-pci: Fully suspend across freeze/thaw cycle

Fabien Parent (1):
      dt-bindings: usb: mediatek,mtu3: add binding for MT8195 SoC

Frank Li (1):
      usb: cdns3: allocate TX FIFO size according to composite EP number

Gil Fine (2):
      thunderbolt: Fix buffer allocation of devices with no DisplayPort adapters
      thunderbolt: Add KUnit test for devices with no DisplayPort adapters

Greg Kroah-Hartman (6):
      Merge 5.18-rc5 into usb-next
      Revert "usb: core: hcd: Create platform devices for onboard hubs in probe()"
      Revert "usb: misc: Add onboard_usb_hub driver"
      Revert "of/platform: Add stubs for of_platform_device_create/destroy()"
      Merge tag 'thunderbolt-for-v5.19-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt into usb-next
      Merge tag 'usb-serial-5.19-rc1' of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-next

Guido Günther (1):
      usb: typec: tipd: Only update power status on IRQ

Guo Zhengkui (1):
      usb: gadget: net2280: use swap() instead of open coding it

Hangyu Hua (1):
      usb: usbip: fix a refcount leak in stub_probe()

Haowen Bai (1):
      testusb: Fix warning comparing pointer to 0

Heikki Krogerus (3):
      thunderbolt: Link USB4 ports to their USB Type-C connectors
      usb: core: acpi: Use the sysdev pointer instead of controller device
      usb: dwc3: host: Stop setting the ACPI companion

Heiner Kallweit (5):
      xhci: factor out parts of xhci_gen_setup()
      xhci: prepare for operation w/o shared hcd
      usb: host: xhci-plat: create shared hcd after having added main hcd
      usb: host: xhci-plat: prepare operation w/o shared hcd
      usb: host: xhci-plat: omit shared hcd if either root hub has no ports

Jakob Koschel (1):
      thunderbolt: Replace usage of found with dedicated list iterator variable

Janusz Krzysztofik (2):
      usb: gadget: omap_udc: Make it CCF clk API compatible
      usb: host: ohci-omap: Make it CCF clk API compatible

Jiapeng Chong (1):
      usb: gadget: u_audio: clean up some inconsistent indenting

Johan Hovold (1):
      USB: serial: pl2303: fix type detection for odd device

Kishon Vijay Abraham I (2):
      usb: core: hcd: Add support for deferring roothub registration
      xhci: Set HCD flag to defer primary roothub registration

Krzysztof Kozlowski (14):
      dt-bindings: usb: samsung,exynos-usb2: include usb-hcd schema
      dt-bindings: usb: samsung,exynos-usb2: add missing required reg
      dt-bindings: usb: am33xx-usb: deprecate '#dma-channels'
      dt-bindings: usb: da8xx-usb: deprecate '#dma-channels'
      dt-bindings: usb: qcom,dwc3: add IPQ8074, MSM8994, QCS404 and SM6125
      dt-bindings: usb: qcom,dwc3: fix clock matching
      arm64: dts: qcom: correct DWC3 node names and unit addresses
      arm64: dts: qcom: ipq8074: add dedicated qcom,ipq8074-dwc3 compatible
      arm64: dts: qcom: msm8994: add dedicated qcom,msm8994-dwc3 compatible
      arm64: dts: qcom: sm6125: add dedicated qcom,sm6125-dwc3 compatible
      arm64: dts: qcom: qcs404: add dedicated qcom,qcs404-dwc3 compatible
      arm64: dts: qcom: msm8996: add clock-names to DWC3 USB node
      arm64: dts: qcom: align DWC3 USB clocks with DT schema
      arm64: dts: qcom: align DWC3 USB interrupts with DT schema

Kushagra Verma (3):
      USB / dwc3: Fix three doc-build warnings
      usb: dwc3: remove a possible unnecessary 'out of memory' message
      USB / dwc3: Fix a checkpatch warning in core.c

Lin Ma (4):
      usb-storage: alauda: fix initFunction error return
      usb-storage: shuttle_usbat: fix initFunction error return
      usb-storage: isd200: fix initFunction error return
      USB: storage: karma: fix rio_karma_init return

Linus Walleij (1):
      usb: isp1760: Fix out-of-bounds array access

Linyu Yuan (2):
      usb: typec: ucsi: add a common function ucsi_unregister_connectors()
      usb: typec: ucsi: Wait for the USB role switches

Marek Szyprowski (1):
      usb: dwc2: gadget: don't reset gadget's driver->bus

Mathias Nyman (5):
      xhci: use generic command timer for stop endpoint commands.
      xhci: prevent U2 link power state if Intel tier policy prevented U1
      xhci: Remove quirk for over 10 year old evaluation hardware
      xhci: Allow host runtime PM as default for Intel Alder Lake N xHCI
      xhci: Don't defer primary roothub registration if there is only one roothub

Matthias Kaehlcke (3):
      of/platform: Add stubs for of_platform_device_create/destroy()
      usb: misc: Add onboard_usb_hub driver
      usb: core: hcd: Create platform devices for onboard hubs in probe()

Mayank Rana (2):
      usb: dwc3: Fix ep0 handling when getting reset while doing control transfer
      usb: dwc3: core: Add error log when core soft reset failed

Miaoqian Lin (1):
      usb: musb: Fix missing of_node_put() in omap2430_probe

Michael Grzeschik (7):
      usb: gadget: uvc: rework uvcg_queue_next_buffer to uvcg_complete_buffer
      usb: gadget: uvc: giveback vb2 buffer on req complete
      usb: gadget: uvc: improve sg exit condition
      usb: gadget: f_acm: add support for USB_CDC_REQ_SEND_BREAK
      usb: gadget: uvc: prevent index variables to start from 0
      usb: gadget: uvc: move structs to common header
      usb: gadget: uvc: track frames in format entries

Mika Westerberg (9):
      thunderbolt: Fix typo in comment
      thunderbolt: Use decimal number with port numbers
      thunderbolt: Dump path config space entries during discovery
      thunderbolt: Use different lane for second DisplayPort tunnel
      thunderbolt: Add debug logging when lane is enabled/disabled
      thunderbolt: Move tb_port_state() prototype to correct place
      thunderbolt: Split setting link width and lane bonding into own functions
      thunderbolt: Ignore port locked error in tb_port_wait_for_link_width()
      thunderbolt: Add support for XDomain lane bonding

Minghao Chi (1):
      usb:oxu210hp-hcd: Use platform_get_irq() to get the interrupt

Monish Kumar R (1):
      USB: new quirk for Dell Gen 2 devices

Nick Hawkins (2):
      dt-bindings: usb: generic-ehci: Add HPE GXP ehci binding
      dt-bindings: usb: generic-ohci: Add HPE GXP ohci binding

Niels Dossche (1):
      usb: usbip: add missing device lock on tweak configuration cmd

Piyush Mehta (5):
      dt-bindings: usb: dwc3-xilinx: add optional property reset-gpios
      usb: dwc3: xilinx: Add gpio-reset support
      usb: host: ehci-xilinx: Fix quoted string split across lines
      usb: gadget: udc: Remove useless variable assignment in xudc_read_fifo()
      usb: host: ehci-xilinx: adding description for return value

Rohit Agarwal (1):
      dt-bindings: usb: qcom,dwc3: Add binding for SDX65

Sergey Shtylyov (2):
      usb: core: devices: remove dead code under #ifdef PROC_EXTRA
      usb: core: devices: drop redundant buffer overflow checks

Souradeep Chowdhury (2):
      arm64: dts: qcom: sc7280: Add EUD dt node and dwc3 connector
      arm64: dts: qcom: sc7280: Set the default dr_mode for usb2

Tanveer Alam (1):
      usb: typec: mux: intel_pmc_mux: Add retry logic to a PMC command

Thinh Nguyen (6):
      usb: dwc3: gadget: Prevent repeat pullup()
      usb: dwc3: gadget: Refactor pullup()
      usb: dwc3: gadget: Don't modify GEVNTCOUNT in pullup()
      usb: dwc3: ep0: Don't prepare beyond Setup stage
      usb: dwc3: gadget: Only End Transfer for ep0 data phase
      usb: dwc3: gadget: Delay issuing End Transfer

Tom Rix (5):
      USB: omap_udc: clean up comment
      usb: gadget: pxa27x_udc: clean up comment
      usb: gadget: s3c-hsudc: clean up comments
      usb: gadget: tegra-xudc: clean up comments
      usb: gadget: net2272: clean up comments

Vincent Mailhol (9):
      usb: deprecate the third argument of usb_maxpacket()
      HID: usbhid: remove third argument of usb_maxpacket()
      Input: remove third argument of usb_maxpacket()
      media: remove third argument of usb_maxpacket()
      net: remove third argument of usb_maxpacket()
      usb: remove third argument of usb_maxpacket()
      sound: usb: remove third argument of usb_maxpacket()
      usb: remove third argument of usb_maxpacket()
      usb: rework usb_maxpacket() using usb_pipe_endpoint()

Wesley Cheng (2):
      usb: dwc3: EP clear halt leading to clearing of delayed_status
      usb: dwc3: gadget: Replace list_for_each_entry_safe() if using giveback

Won Chung (1):
      misc/mei: Add NULL check to component match callback functions

Yang Yingliang (1):
      USB: c67x00: remove unnecessary check of res

Zhen Ni (1):
      USB: host: isp116x: check return value after calling platform_get_resource()

Zheng Yongjun (1):
      usb: dwc3: pci: Fix pm_runtime_get_sync() error checking

周琰杰 (Zhou Yanjie) (3):
      dt-bindings: dwc2: Add bindings for new Ingenic SoCs.
      USB: dwc2: Add OTG support for Ingenic SoCs.
      MIPS: Ingenic: Refresh USB nodes to match driver changes.

 Documentation/ABI/testing/configfs-usb-gadget-uvc  |   1 +
 Documentation/ABI/testing/sysfs-bus-thunderbolt    |  10 +
 .../devicetree/bindings/usb/am33xx-usb.txt         |   7 +-
 .../devicetree/bindings/usb/da8xx-usb.txt          |   5 +-
 Documentation/devicetree/bindings/usb/dwc2.yaml    |   7 +
 .../devicetree/bindings/usb/dwc3-xilinx.yaml       |   4 +
 .../devicetree/bindings/usb/fcs,fsa4480.yaml       |  72 +++
 .../devicetree/bindings/usb/generic-ehci.yaml      |   1 +
 .../devicetree/bindings/usb/generic-ohci.yaml      |   1 +
 .../devicetree/bindings/usb/mediatek,mtu3.yaml     |   1 +
 .../devicetree/bindings/usb/qcom,dwc3.yaml         | 227 +++++++-
 .../devicetree/bindings/usb/renesas,usbhs.yaml     |   4 +
 .../bindings/usb/samsung,exynos-usb2.yaml          |  15 +-
 .../devicetree/bindings/usb/ti,am62-usb.yaml       | 103 ++++
 Documentation/usb/gadget-testing.rst               |   1 +
 arch/arm/boot/dts/qcom-ipq4019.dtsi                |   2 +-
 arch/arm/boot/dts/qcom-sdx55.dtsi                  |  11 +-
 arch/arm64/boot/dts/qcom/apq8096-db820c.dts        |  18 +-
 arch/arm64/boot/dts/qcom/ipq6018.dtsi              |  12 +-
 arch/arm64/boot/dts/qcom/ipq8074.dtsi              |  16 +-
 arch/arm64/boot/dts/qcom/msm8953.dtsi              |  11 +-
 arch/arm64/boot/dts/qcom/msm8994.dtsi              |   7 +-
 .../arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi |  20 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi              |  23 +-
 arch/arm64/boot/dts/qcom/msm8998.dtsi              |  13 +-
 arch/arm64/boot/dts/qcom/qcs404-evb.dtsi           |   7 +-
 arch/arm64/boot/dts/qcom/qcs404.dtsi               |   8 +-
 arch/arm64/boot/dts/qcom/sc7180.dtsi               |  13 +-
 arch/arm64/boot/dts/qcom/sc7280-idp.dts            |   2 +-
 arch/arm64/boot/dts/qcom/sc7280.dtsi               |  68 ++-
 arch/arm64/boot/dts/qcom/sdm630.dtsi               |  12 +-
 arch/arm64/boot/dts/qcom/sdm845.dtsi               |  26 +-
 arch/arm64/boot/dts/qcom/sm6125.dtsi               |  16 +-
 arch/arm64/boot/dts/qcom/sm6350.dtsi               |  11 +-
 arch/arm64/boot/dts/qcom/sm8150.dtsi               |  22 +-
 arch/arm64/boot/dts/qcom/sm8250.dtsi               |  20 +-
 arch/arm64/boot/dts/qcom/sm8350.dtsi               |  21 +-
 arch/arm64/boot/dts/qcom/sm8450.dtsi               |  20 +-
 arch/mips/boot/dts/ingenic/jz4780.dtsi             |   2 +-
 arch/mips/boot/dts/ingenic/x1000.dtsi              |   2 +-
 arch/mips/boot/dts/ingenic/x1830.dtsi              |   2 +-
 drivers/base/property.c                            |  96 +++-
 drivers/hid/usbhid/hid-core.c                      |   2 +-
 drivers/hid/usbhid/usbkbd.c                        |   2 +-
 drivers/hid/usbhid/usbmouse.c                      |   2 +-
 drivers/input/misc/ati_remote2.c                   |   2 +-
 drivers/input/misc/cm109.c                         |   2 +-
 drivers/input/misc/powermate.c                     |   2 +-
 drivers/input/misc/yealink.c                       |   2 +-
 drivers/input/tablet/acecad.c                      |   2 +-
 drivers/input/tablet/pegasus_notetaker.c           |   2 +-
 drivers/media/rc/ati_remote.c                      |   4 +-
 drivers/media/rc/mceusb.c                          |   2 +-
 drivers/media/rc/streamzap.c                       |   2 +-
 drivers/media/rc/xbox_remote.c                     |   2 +-
 drivers/media/usb/tm6000/tm6000-dvb.c              |   2 +-
 drivers/media/usb/tm6000/tm6000-input.c            |   2 +-
 drivers/media/usb/tm6000/tm6000-video.c            |   2 +-
 drivers/misc/mei/hdcp/mei_hdcp.c                   |   2 +-
 drivers/misc/mei/pxp/mei_pxp.c                     |   2 +-
 drivers/net/usb/cdc_ncm.c                          |   4 +-
 drivers/net/usb/lan78xx.c                          |   4 +-
 drivers/net/usb/rndis_host.c                       |   2 +-
 drivers/net/usb/usbnet.c                           |   4 +-
 drivers/net/wireless/mediatek/mt76/usb.c           |   2 +-
 drivers/net/wireless/ralink/rt2x00/rt2x00usb.c     |   4 +-
 drivers/thunderbolt/ctl.c                          |  15 +-
 drivers/thunderbolt/nhi.c                          |   2 +-
 drivers/thunderbolt/path.c                         |   6 +
 drivers/thunderbolt/switch.c                       | 109 +++-
 drivers/thunderbolt/tb.c                           |  25 +-
 drivers/thunderbolt/tb.h                           |   6 +-
 drivers/thunderbolt/tb_msgs.h                      |  39 ++
 drivers/thunderbolt/tb_regs.h                      |   5 +
 drivers/thunderbolt/test.c                         | 108 +++-
 drivers/thunderbolt/tunnel.c                       |  18 +-
 drivers/thunderbolt/tunnel.h                       |   4 +-
 drivers/thunderbolt/usb4_port.c                    |  38 ++
 drivers/thunderbolt/xdomain.c                      | 609 ++++++++++++++++++---
 drivers/usb/atm/usbatm.c                           |   2 +-
 drivers/usb/c67x00/c67x00-drv.c                    |   6 +-
 drivers/usb/c67x00/c67x00-sched.c                  |   4 +-
 drivers/usb/cdns3/cdns3-gadget.c                   |  47 +-
 drivers/usb/cdns3/cdns3-gadget.h                   |   9 +-
 drivers/usb/core/devices.c                         |  47 --
 drivers/usb/core/driver.c                          |  25 +-
 drivers/usb/core/hcd-pci.c                         |   5 +-
 drivers/usb/core/hcd.c                             |  29 +-
 drivers/usb/core/hub.c                             |  10 +-
 drivers/usb/core/quirks.c                          |   3 +
 drivers/usb/core/usb-acpi.c                        |   7 +-
 drivers/usb/dwc2/core.c                            |   9 +
 drivers/usb/dwc2/core.h                            |   5 +
 drivers/usb/dwc2/gadget.c                          |   1 -
 drivers/usb/dwc2/params.c                          |  50 +-
 drivers/usb/dwc3/Kconfig                           |   9 +
 drivers/usb/dwc3/Makefile                          |   1 +
 drivers/usb/dwc3/core.c                            |  81 ++-
 drivers/usb/dwc3/core.h                            |   2 +
 drivers/usb/dwc3/drd.c                             |  50 --
 drivers/usb/dwc3/dwc3-am62.c                       | 332 +++++++++++
 drivers/usb/dwc3/dwc3-pci.c                        |   2 +-
 drivers/usb/dwc3/dwc3-xilinx.c                     |  17 +
 drivers/usb/dwc3/ep0.c                             |  14 +-
 drivers/usb/dwc3/gadget.c                          | 190 ++++---
 drivers/usb/dwc3/gadget.h                          |   2 +
 drivers/usb/dwc3/host.c                            |   2 -
 drivers/usb/gadget/composite.c                     |   2 +-
 drivers/usb/gadget/configfs.c                      |   2 +-
 drivers/usb/gadget/function/f_acm.c                |  10 +
 drivers/usb/gadget/function/f_uvc.c                |   5 +-
 drivers/usb/gadget/function/u_audio.c              |   4 +-
 drivers/usb/gadget/function/u_uvc.h                |   1 +
 drivers/usb/gadget/function/uvc.h                  |   1 +
 drivers/usb/gadget/function/uvc_configfs.c         | 189 +++----
 drivers/usb/gadget/function/uvc_configfs.h         | 120 +++-
 drivers/usb/gadget/function/uvc_queue.c            |  30 +-
 drivers/usb/gadget/function/uvc_queue.h            |   3 +-
 drivers/usb/gadget/function/uvc_video.c            |  17 +-
 drivers/usb/gadget/legacy/dbgp.c                   |   2 +-
 drivers/usb/gadget/legacy/inode.c                  |   2 +-
 drivers/usb/gadget/legacy/raw_gadget.c             |   4 +-
 drivers/usb/gadget/udc/core.c                      | 289 +++++-----
 drivers/usb/gadget/udc/net2272.c                   |   6 +-
 drivers/usb/gadget/udc/net2280.c                   |  14 +-
 drivers/usb/gadget/udc/omap_udc.c                  |  16 +-
 drivers/usb/gadget/udc/pxa27x_udc.h                |   2 +-
 drivers/usb/gadget/udc/s3c-hsudc.c                 |   4 +-
 drivers/usb/gadget/udc/tegra-xudc.c                |   4 +-
 drivers/usb/gadget/udc/udc-xilinx.c                |   2 +-
 drivers/usb/host/ehci-omap.c                       |   5 -
 drivers/usb/host/ehci-platform.c                   |   1 +
 drivers/usb/host/ehci-q.c                          |   4 +-
 drivers/usb/host/ehci-xilinx-of.c                  |  12 +-
 drivers/usb/host/fhci-hcd.c                        |   3 +-
 drivers/usb/host/fotg210-hcd.c                     |   2 +-
 drivers/usb/host/isp116x-hcd.c                     |  11 +-
 drivers/usb/host/isp1362-hcd.c                     |   6 +-
 drivers/usb/host/max3421-hcd.c                     |   6 +-
 drivers/usb/host/ohci-hcd.c                        |   3 +-
 drivers/usb/host/ohci-omap.c                       |  18 +-
 drivers/usb/host/ohci-platform.c                   |   1 +
 drivers/usb/host/ohci-ppc-of.c                     |   3 -
 drivers/usb/host/oxu210hp-hcd.c                    |  16 +-
 drivers/usb/host/r8a66597-hcd.c                    |   3 +-
 drivers/usb/host/sl811-hcd.c                       |   6 +-
 drivers/usb/host/xhci-hub.c                        |   3 +-
 drivers/usb/host/xhci-mem.c                        |  23 +-
 drivers/usb/host/xhci-pci.c                        |   5 +-
 drivers/usb/host/xhci-plat.c                       |  46 +-
 drivers/usb/host/xhci-ring.c                       | 144 ++---
 drivers/usb/host/xhci.c                            | 175 +++---
 drivers/usb/host/xhci.h                            |  30 +-
 drivers/usb/isp1760/isp1760-core.c                 |   8 +
 drivers/usb/isp1760/isp1760-hcd.c                  |   6 +-
 drivers/usb/misc/ftdi-elan.c                       |  15 +-
 drivers/usb/misc/lvstest.c                         |   2 +-
 drivers/usb/musb/mediatek.c                        |  73 +--
 drivers/usb/musb/omap2430.c                        |   1 +
 drivers/usb/serial/ftdi_sio.c                      |   2 +-
 drivers/usb/serial/option.c                        |   2 +
 drivers/usb/serial/pl2303.c                        |   3 +
 drivers/usb/storage/alauda.c                       |   4 +-
 drivers/usb/storage/isd200.c                       |   8 +-
 drivers/usb/storage/karma.c                        |  15 +-
 drivers/usb/storage/onetouch.c                     |   2 +-
 drivers/usb/storage/shuttle_usbat.c                |  28 +-
 drivers/usb/storage/transport.c                    |   2 +-
 drivers/usb/typec/bus.c                            |   2 +-
 drivers/usb/typec/mux.c                            | 271 ++++++---
 drivers/usb/typec/mux.h                            |  12 +-
 drivers/usb/typec/mux/Kconfig                      |  10 +
 drivers/usb/typec/mux/Makefile                     |   1 +
 drivers/usb/typec/mux/fsa4480.c                    | 218 ++++++++
 drivers/usb/typec/mux/intel_pmc_mux.c              |  29 +-
 drivers/usb/typec/mux/pi3usb30532.c                |   8 +-
 drivers/usb/typec/tipd/core.c                      |  32 +-
 drivers/usb/typec/ucsi/ucsi.c                      |  85 +--
 drivers/usb/typec/ucsi/ucsi.h                      |   6 +-
 drivers/usb/usbip/stub_dev.c                       |   2 +-
 drivers/usb/usbip/stub_rx.c                        |   2 +
 include/linux/property.h                           |   5 +
 include/linux/thunderbolt.h                        |  19 +-
 include/linux/usb.h                                |  17 +-
 include/linux/usb/gadget.h                         |  28 +-
 include/linux/usb/hcd.h                            |   2 +
 include/linux/usb/typec_mux.h                      |  22 +-
 sound/usb/line6/pcm.c                              |   4 +-
 sound/usb/midi.c                                   |   4 +-
 sound/usb/usx2y/usb_stream.c                       |   6 +-
 sound/usb/usx2y/usbusx2yaudio.c                    |   2 +-
 sound/usb/usx2y/usx2yhwdeppcm.c                    |   2 +-
 tools/usb/testusb.c                                |   2 +-
 193 files changed, 3677 insertions(+), 1483 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/fcs,fsa4480.yaml
 create mode 100644 Documentation/devicetree/bindings/usb/ti,am62-usb.yaml
 create mode 100644 drivers/usb/dwc3/dwc3-am62.c
 create mode 100644 drivers/usb/typec/mux/fsa4480.c

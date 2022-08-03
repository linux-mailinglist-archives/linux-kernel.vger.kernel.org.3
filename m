Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9440588E4A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 16:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238648AbiHCOKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 10:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236167AbiHCOKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 10:10:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB255FD5;
        Wed,  3 Aug 2022 07:10:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B594615D7;
        Wed,  3 Aug 2022 14:10:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55D4DC433D6;
        Wed,  3 Aug 2022 14:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659535828;
        bh=eb+HSy1nzup9YP71s2uyKgDDV/ckq/cnO60ZwknELWM=;
        h=Date:From:To:Cc:Subject:From;
        b=05OIZ+9C3VJ424JS1YV+e8ws3mI++5qR7Qd207V3qtarqW15D3hLqC88tGAN/y6Ql
         f7O18ixe1+EwGNa63nR6El4t4xeDrTEKW4h1tvBDXz8AUmwXCn6sgJ+UW1VcIPNNjv
         01v1IU6+UBzU7g5bC2soPufAVnbmZUHwdFqiLEfo=
Date:   Wed, 3 Aug 2022 16:10:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB / Thunderbolt driver changes for 6.0-rc1
Message-ID: <YuqB0tl2hjT3x7a4@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit ff6992735ade75aae3e35d16b17da1008d753d28:

  Linux 5.19-rc7 (2022-07-17 13:30:22 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.0-rc1

for you to fetch changes up to 8288c99fc263bcafc5df5fa8c278b2eb8106364e:

  usb: misc: onboard_usb_hub: Remove duplicated power_on delay (2022-07-28 09:21:15 +0200)

----------------------------------------------------------------
USB / Thunderbolt changes for 6.0-rc1

Here is the big set of Thunderbolt and USB changes for 6.0-rc1.

Lots of little things here, nothing major, just constant development on
some new hardware support and cleanups of older drivers.  Highlights of
this pull request are:
	- lots of typec changes and improvements for new hardware
	- new gadget controller driver
	- thunderbolt support for new hardware
	- the normal set of new usb-serial device ids and cleanups
	- loads of dwc3 controller fixes and improvements
	- mtu3 driver updates
	- testusb fixes for longtime issues (not many people use this
	  tool it seems.)
	- minor driver fixes and improvements over the USB tree
	- chromeos platform driver changes were added and then reverted
	  as they depened on some typec changes, but the cross-tree
	  merges caused problems so they will come back later through
	  the platform tree.

All of these have been in linux-next for a while now with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alan Stern (1):
      USB: gadget: Fix use-after-free Read in usb_udc_uevent()

Alexander Stein (5):
      usb: chipidea: ci_hdrc_imx: use dev_err_probe()
      dt-bindings: usb: Add binding for TI USB8041 hub controller
      usb: misc: onboard_usb_hub: Add reset-gpio support
      usb: misc: onboard_usb_hub: Add TI USB8041 hub support
      usb: misc: onboard_usb_hub: Remove duplicated power_on delay

Alexey Sheplyakov (1):
      usb: xhci_plat_remove: avoid NULL dereference

Amelie Delaunay (4):
      usb: host: ohci-platform: add TPL support
      usb: host: ehci-platform: add TPL support
      usb: dwc2: host: add TPL support
      usb: dwc2: gadget: remove D+ pull-up while no vbus with usb-role-switch

Andrey Strachuk (1):
      usb: cdns3: change place of 'priv_ep' assignment in cdns3_gadget_ep_dequeue(), cdns3_gadget_ep_enable()

Artur Bujdoso (1):
      staging: octeon-usb: move driver out of staging

Bryan O'Donoghue (3):
      tools: usb: testusb: Add wireless speed reporting
      tools: usb: testusb: Add super speed reporting
      tools: usb: testusb: Add super-plus speed reporting

Chen Xingdi (1):
      usb: renesas-xhci: Do not print any log while fw verif success

Chunfeng Yun (12):
      dt-bindings: usb: mtk-xhci: add support 'resets' property
      dt-bindings: usb: mtu3: add support 'resets' property
      usb: xhci-mtk: add support optional controller reset
      usb: mtu3: add support controller reset
      usb: mtu3: sync interrupt before unbind the udc
      usb: mtu3: implement udc_async_callbacks of gadget operation
      usb: mtu3: register mtu3_irq by threaded irq
      dt-bindings: usb: mtk-xhci: add compatible for mt8188
      usb: mtu3: print endpoint type as string
      usb: mtu3: add feature to disable device's usb3 port
      usb: mtu3: check capability of usb3 dual role
      usb: mtu3: support function remote wakeup

Clément Léger (1):
      usb: host: ohci-at91: add support to enter suspend using SMC

Colin Ian King (2):
      usb: gadget: ast2600: Fix a couple of spelling mistakes
      usb: phy: remove redundant store to variable var after & operation

Conor Dooley (2):
      usb: musb: Add support for PolarFire SoC's musb controller
      MAINTAINERS: add musb to PolarFire SoC entry

Dan Carpenter (8):
      USB: usbip: clean up mixed use of _irq() and _irqsave()
      usbip: vudc: Don't enable IRQs prematurely
      usb: gadget: aspeed_udc: cleanup loop in ast_dma_descriptor_setup()
      usb: musb: mpfs: Fix error codes in probe()
      usb: gadget: aspeed_udc: fix handling of tx_len == 0
      usb: typec: anx7411: Fix an array out of bounds
      usb: typec: anx7411: fix error checking in anx7411_get_gpio_irq()
      usb: typec: anx7411: use semi-colons instead of commas

Fabrice Gasnier (8):
      dt-bindings: usb: dwc2: document TPL support
      dt-bindings: usb: typec: add bindings for stm32g0 controller
      usb: typec: ucsi: stm32g0: add support for stm32g0 controller
      usb: typec: ucsi: stm32g0: add bootloader support
      dt-bindings: usb: generic-ehci: allow usb-hcd schema properties
      usb: misc: onboard-hub: add support for Microchip USB2514B USB 2.0 hub
      ARM: dts: stm32: add support for USB2514B onboard hub on stm32mp15xx-dkx
      ARM: multi_v7_defconfig: enable USB onboard HUB driver

Frank Li (2):
      usb: cdns3 fix use-after-free at workaround 2
      usb: cdns3: fix random warning message when driver load

George D Sworo (1):
      thunderbolt: Add support for Intel Raptor Lake

Gil Fine (6):
      thunderbolt: Silently ignore CLx enabling in case CLx is not supported
      thunderbolt: CLx disable before system suspend only if previously enabled
      thunderbolt: Fix typos in CLx enabling
      thunderbolt: Change downstream router's TMU rate in both TMU uni/bidir mode
      thunderbolt: Add CL1 support for USB4 and Titan Ridge routers
      thunderbolt: Change TMU mode to HiFi uni-directional once DisplayPort tunneled

Greg Kroah-Hartman (15):
      Revert "ARM: dts: aspeed: Add USB2.0 device controller node"
      Merge v5.19-rc3 into usb-next
      Merge branch 'staging-octeon' of gitolite.kernel.org:/pub/scm/linux/kernel/git/gregkh/staging into usb-next
      Merge 5.19-rc4 into usb-next
      Merge tag 'thunderbolt-for-v5.20-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt into usb-next
      Merge 5.19-rc7 into usb-next
      Revert "platform/chrome: cros_ec_typec: Get retimer handle"
      Revert "platform/chrome: cros_ec_typec: Cleanup switch handle return paths"
      Revert "platform/chrome: cros_typec_switch: Register mode switches"
      Revert "platform/chrome: cros_typec_switch: Add event check"
      Revert "platform/chrome: cros_typec_switch: Set EC retimer"
      Revert "platform/chrome: cros_typec_switch: Add ACPI Kconfig dep"
      Revert "platform/chrome: cros_typec_switch: Add switch driver"
      Revert "platform/chrome: Add Type-C mux set command definitions"
      Merge tag 'usb-serial-5.20-rc1' of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-next

Heikki Krogerus (3):
      usb: typec: Separate USB Power Delivery from USB Type-C
      usb: typec: USB Power Delivery helpers for ports and partners
      usb: typec: tcpm: Register USB Power Delivery Capabilities

Herve Codina (1):
      dt-bindings: usb: atmel: Add Microchip LAN9662 compatible string

Hyunwoo Kim (1):
      usb: host: ehci-q: Fix ehci_submit_single_step_set_feature annotation typo

Jason Wang (1):
      USB: xhci: Fix comment typo

Jiang Jian (3):
      usb: dwc2: drop unexpected word "the" in the comments
      usb: max-3421: drop unexpected word "the" in the comments
      USB: serial: fix repeated word "the" in comments

Jiangshan Yi (1):
      usb: ldusb: replace ternary operator with max_t()

Jiapeng Chong (1):
      usb: gadget: Remove unnecessary print function dev_err()

Jilin Yuan (8):
      usb/atm: fix repeated words in comments
      usb/core: fix repeated words in comments
      usb/host: fix repeated words in comments
      usb/image: fix repeated words in comments
      usb/misc: fix repeated words in comments
      usb/musb: fix repeated words in comments
      usb/typec/tcpm: fix repeated words in comments
      usb/chipidea: fix repeated words in comments

Johan Hovold (10):
      dt-bindings: usb: qcom,dwc3: add SC8280XP binding
      dt-bindings: usb: qcom,dwc3: refine interrupt requirements
      usb: dwc3: qcom: fix missing optional irq warnings
      USB: cdc: add control-signal defines
      USB: cdc: add serial-state defines
      USB: cdc-acm: use CDC control-line defines
      USB: cdc-acm: use CDC serial-state defines
      staging: gdm724x: drop unused CDC defines
      USB: gadget: f_acm: use CDC defines
      USB: serial: fix tty-port initialized comments

Jozef Martiniak (1):
      gadgetfs: ep_io - wait until IRQ finishes

Julia Lawall (3):
      usb: typec: tcpm: fix typo in comment
      usb: gadget: bdc: fix typo in comment
      USB: chipidea: fix typo in comment

Kushagra Verma (4):
      usb: dwc3: Remove the checks of -ENOSYS
      usb: dwc3: Fix bare use of unsigned checkpatch warning
      usb: dwc3: Fix a repeated word checkpatch warning
      usb: dwc3: Fix typos in Kconfig

Laurent Pinchart (1):
      usb: gadget: uvc: Fix comment blocks style

Li Jun (1):
      usb: dwc3: add power down scale setting

Liang He (3):
      usb: host: ohci-ppc-of: Fix refcount leak bug
      usb: renesas: Fix refcount leak bug
      usb: aspeed-vhub: Fix refcount leak bug in ast_vhub_init_desc()

Linyu Yuan (1):
      usb: typec: ucsi: Acknowledge the GET_ERROR_STATUS command completion

Lukas Bulwahn (1):
      MAINTAINERS: Repair file entry in ASPEED USB UDC DRIVER

Mathias Nyman (1):
      usb: Avoid extra usb SET_SEL requests when enabling link power management

Matthias Kaehlcke (5):
      of/platform: Add stubs for of_platform_device_create/destroy()
      dt-bindings: usb: rts5411: Rename property 'companion-hub' to 'peer-hub'
      usb: misc: Add onboard_usb_hub driver
      usb: core: hub: Create platform devices for onboard hubs in hub_probe()
      usb: misc: onboard_hub: Fix 'missing prototype' warning

Mauro Carvalho Chehab (3):
      usb: typec_altmode: add a missing "@" at a kernel-doc parameter
      usb: dwc3: document async_callbacks field
      usb: dwc3: gadget: fix a kernel-doc warning

Maxim Devaev (2):
      usb: gadget: f_mass_storage: forced_eject attribute
      USB: docs: fixed table margin in configfs-usb-gadget-mass-storage

Miaoqian Lin (2):
      usb: host: Fix refcount leak in ehci_hcd_ppc_of_probe
      usb: ohci-nxp: Fix refcount leak in ohci_hcd_nxp_probe

Michael Grzeschik (6):
      usb: gadget: uvc: calculate the number of request depending on framesize
      usb: gadget: uvc: call uvc uvcg_warn on completed status instead of uvcg_info
      usb: hub: port: add sysfs entry to switch port power
      usb: chipidea: udc: implement get_frame
      usb: dwc3: gadget: refactor dwc3_repare_one_trb
      usb: dwc3: gadget: fix high speed multiplier setting

Michael Walle (2):
      usb: gadget: udc: atmel: check rc of devm_gpiod_get_optional()
      usb: gadget: udc: atmel: convert to platform driver

Neal Liu (4):
      usb: gadget: add Aspeed ast2600 udc driver
      ARM: dts: aspeed: Add USB2.0 device controller node
      dt-bindings: usb: add documentation for aspeed udc
      usb: gadget: f_mass_storage: Make CD-ROM emulation works with Windows OS

Nícolas F. R. A. Prado (4):
      dt-bindings: usb: mtk-xhci: Allow wakeup interrupt-names to be optional
      dt-bindings: usb: mtk-xhci: Make all clocks required
      Revert "dt-bindings: usb: mtk-xhci: Make all clocks required"
      usb: typec: retimer: Add missing id check in match callback

Oliver Neukum (1):
      USB: cdc-acm: use define for timeout

Prashant Malani (12):
      usb: typec: mux: Allow muxes to specify mode-switch
      usb: typec: mux: Add CONFIG guards for functions
      usb: typec: Add support for retimers
      usb: typec: Add retimer handle to port
      platform/chrome: Add Type-C mux set command definitions
      platform/chrome: cros_typec_switch: Add switch driver
      platform/chrome: cros_typec_switch: Set EC retimer
      platform/chrome: cros_typec_switch: Add event check
      platform/chrome: cros_typec_switch: Register mode switches
      platform/chrome: cros_ec_typec: Cleanup switch handle return paths
      platform/chrome: cros_ec_typec: Get retimer handle
      platform/chrome: cros_typec_switch: Add ACPI Kconfig dep

Prashanth K (1):
      usb: common: usb-conn-gpio: Allow wakeup from system suspend

Randy Dunlap (1):
      usb: gadget: udc: amd5536 depends on HAS_DMA

Rohith Kollalsi (1):
      usb: dwc3: core: Do not perform GCTL_CORE_SOFTRESET during bootup

Sandeep Maheswaram (5):
      dt-bindings: usb: dwc3: Add wakeup-source property support
      usb: dwc3: core: Host wake up support from system suspend
      usb: dwc3: qcom: Add helper functions to enable,disable wake irqs
      usb: dwc3: qcom: Configure wakeup interrupts during suspend
      usb: dwc3: qcom: Keep power domain on to retain controller status

Sanket Goswami (2):
      ucsi_ccg: Do not hardcode interrupt polarity and type
      ucsi_ccg: ACPI based I2c client enumeration for AMD ASICs

Saurav Girepunje (1):
      usb: musb: remove schedule work called after flush

Sergey Shtylyov (2):
      usb: musb: core: drop redundant checks
      usb: host: xhci: use snprintf() in xhci_decode_trb()

Slark Xiao (1):
      USB: serial: use kmemdup instead of kmalloc + memcpy

Steven Rostedt (Google) (1):
      USB: gadget: udc: tracing: Do not open code __string() with __dynamic_array()

Tang Bin (2):
      usb: gadget: tegra-xudc: Fix error check in tegra_xudc_powerdomain_init()
      usb: xhci: tegra: Fix error check

Thinh Nguyen (2):
      Revert "usb: dwc3: Remove the checks of -ENOSYS"
      usb: dwc3: core: Deprecate GCTL.CORESOFTRESET

Weitao Wang (1):
      USB: HCD: Fix URB giveback issue in tasklet function

Wesley Cheng (1):
      usb: dwc3: ep0: Properly handle setup_packet_pending scenario in data stage

Xiang Wangx (1):
      thunderbolt: Fix typo in comment

Xiang wangx (2):
      USB: ohci-sm501: Fix typo in comment
      USB: storage: Fix typo in comment

Xin Ji (4):
      usb: typec: tcpci: move tcpci.h to include/linux/usb/
      dt-bindings: usb: Add analogix anx7411 PD binding
      usb: typec: anx7411: Add Analogix PD ANX7411 support
      usb: typec: anx7411: fix passing zero to 'PTR_ERR'

Xuezhi Zhang (2):
      usb: core: sysfs: convert sysfs snprintf to sysfs_emit
      USB: usbsevseg: convert sysfs snprintf to sysfs_emit

Yan Xinyu (1):
      USB: serial: usb_wwan: replace DTR/RTS magic numbers with macros

Yang Li (2):
      thunderbolt: Fix some kernel-doc comments
      usb: gadget: u_ether: Remove duplicated include in u_ether.c

Yang Yingliang (4):
      usb: musb: mpfs: add missing clk_disable_unprepare() in mpfs_remove()
      usb: typec: anx7411: Fix wrong pointer passed to PTR_ERR()
      usb: typec: anx7411: Fix return value check in anx7411_register_i2c_dummy_clients()
      usb: typec: anx7411: Fix error return code in anx7411_i2c_probe()

Zhang Jiaming (1):
      USB: serial: io_edgeport: fix spelling mistakes

Zheng Bin (1):
      usb: gadget: aspeed_udc: fix missing spin_unlock_irqrestore in ast_udc_ep_queue

 .../ABI/testing/configfs-usb-gadget-mass-storage   |   10 +-
 .../ABI/testing/sysfs-bus-platform-onboard-usb-hub |    8 +
 Documentation/ABI/testing/sysfs-bus-usb            |   11 +
 Documentation/ABI/testing/sysfs-class-typec        |    8 +
 .../ABI/testing/sysfs-class-usb_power_delivery     |  240 +++
 .../devicetree/bindings/usb/analogix,anx7411.yaml  |   81 +
 .../bindings/usb/aspeed,ast2600-udc.yaml           |   52 +
 .../devicetree/bindings/usb/atmel-usb.txt          |    3 +
 Documentation/devicetree/bindings/usb/dwc2.yaml    |    3 +
 .../devicetree/bindings/usb/generic-ehci.yaml      |    7 +-
 .../devicetree/bindings/usb/mediatek,mtk-xhci.yaml |    5 +
 .../devicetree/bindings/usb/mediatek,mtu3.yaml     |    3 +
 .../devicetree/bindings/usb/qcom,dwc3.yaml         |  152 +-
 .../devicetree/bindings/usb/realtek,rts5411.yaml   |   10 +-
 .../devicetree/bindings/usb/snps,dwc3.yaml         |    5 +
 .../devicetree/bindings/usb/st,typec-stm32g0.yaml  |   91 ++
 .../devicetree/bindings/usb/ti,usb8041.yaml        |   67 +
 Documentation/usb/gadget-testing.rst               |    6 +
 Documentation/usb/mass-storage.rst                 |    9 +
 MAINTAINERS                                        |   15 +
 arch/arm/boot/dts/stm32mp15xx-dkx.dtsi             |    8 +
 arch/arm/configs/multi_v7_defconfig                |    1 +
 arch/mips/configs/cavium_octeon_defconfig          |    2 +-
 drivers/staging/Kconfig                            |    2 -
 drivers/staging/Makefile                           |    1 -
 drivers/staging/gdm724x/gdm_tty.c                  |    6 -
 drivers/staging/octeon-usb/Kconfig                 |   11 -
 drivers/staging/octeon-usb/Makefile                |    2 -
 drivers/staging/octeon-usb/TODO                    |    8 -
 drivers/thunderbolt/ctl.c                          |    6 +-
 drivers/thunderbolt/ctl.h                          |    2 +-
 drivers/thunderbolt/icm.c                          |    2 +
 drivers/thunderbolt/nhi.c                          |    4 +
 drivers/thunderbolt/nhi.h                          |    2 +
 drivers/thunderbolt/switch.c                       |   91 +-
 drivers/thunderbolt/tb.c                           |   68 +-
 drivers/thunderbolt/tb.h                           |   48 +-
 drivers/thunderbolt/tb_regs.h                      |    6 +
 drivers/thunderbolt/tmu.c                          |  221 ++-
 drivers/usb/atm/ueagle-atm.c                       |    2 +-
 drivers/usb/cdns3/cdns3-gadget.c                   |   13 +-
 drivers/usb/chipidea/ci.h                          |    1 +
 drivers/usb/chipidea/ci_hdrc_imx.c                 |   23 +-
 drivers/usb/chipidea/ci_hdrc_imx.h                 |    2 +-
 drivers/usb/chipidea/core.c                        |    2 +
 drivers/usb/chipidea/otg_fsm.c                     |    2 +-
 drivers/usb/chipidea/udc.c                         |   14 +
 drivers/usb/class/cdc-acm.c                        |   44 +-
 drivers/usb/class/cdc-acm.h                        |   20 -
 drivers/usb/common/usb-conn-gpio.c                 |   17 +
 drivers/usb/core/Makefile                          |    4 +
 drivers/usb/core/driver.c                          |    2 +-
 drivers/usb/core/hcd.c                             |   34 +-
 drivers/usb/core/hub.c                             |  108 +-
 drivers/usb/core/hub.h                             |    4 +
 drivers/usb/core/port.c                            |   83 +
 drivers/usb/core/sysfs.c                           |   79 +-
 drivers/usb/core/usb.c                             |    2 +-
 drivers/usb/dwc2/gadget.c                          |    3 +-
 drivers/usb/dwc2/hcd.c                             |    5 +-
 drivers/usb/dwc3/Kconfig                           |    4 +-
 drivers/usb/dwc3/core.c                            |   56 +-
 drivers/usb/dwc3/core.h                            |    3 +
 drivers/usb/dwc3/dwc3-qcom.c                       |  144 +-
 drivers/usb/dwc3/ep0.c                             |    9 +-
 drivers/usb/dwc3/gadget.c                          |   93 +-
 drivers/usb/gadget/function/f_acm.c                |   20 +-
 drivers/usb/gadget/function/f_mass_storage.c       |   36 +-
 drivers/usb/gadget/function/f_uvc.c                |   30 +-
 drivers/usb/gadget/function/storage_common.c       |   15 +
 drivers/usb/gadget/function/storage_common.h       |    2 +
 drivers/usb/gadget/function/u_ether.c              |    1 -
 drivers/usb/gadget/function/uvc_queue.c            |   23 +-
 drivers/usb/gadget/function/uvc_video.c            |   14 +-
 drivers/usb/gadget/legacy/inode.c                  |    1 +
 drivers/usb/gadget/udc/Kconfig                     |   15 +-
 drivers/usb/gadget/udc/Makefile                    |    1 +
 drivers/usb/gadget/udc/aspeed-vhub/hub.c           |    4 +-
 drivers/usb/gadget/udc/aspeed_udc.c                | 1597 +++++++++++++++++++
 drivers/usb/gadget/udc/atmel_usba_udc.c            |   10 +-
 drivers/usb/gadget/udc/bdc/bdc_cmd.c               |    2 +-
 drivers/usb/gadget/udc/core.c                      |   11 +-
 drivers/usb/gadget/udc/tegra-xudc.c                |    8 +-
 drivers/usb/gadget/udc/trace.h                     |    8 +-
 drivers/usb/host/Kconfig                           |   10 +
 drivers/usb/host/Makefile                          |    1 +
 drivers/usb/host/ehci-platform.c                   |    2 +
 drivers/usb/host/ehci-ppc-of.c                     |    1 +
 drivers/usb/host/ehci-q.c                          |    2 +-
 drivers/usb/host/max3421-hcd.c                     |    2 +-
 .../{staging/octeon-usb => usb/host}/octeon-hcd.c  |    0
 .../{staging/octeon-usb => usb/host}/octeon-hcd.h  |    0
 drivers/usb/host/ohci-at91.c                       |   69 +-
 drivers/usb/host/ohci-nxp.c                        |    1 +
 drivers/usb/host/ohci-platform.c                   |    3 +
 drivers/usb/host/ohci-ppc-of.c                     |    1 +
 drivers/usb/host/ohci-sm501.c                      |    2 +-
 drivers/usb/host/uhci-grlib.c                      |    2 +-
 drivers/usb/host/uhci-hcd.h                        |    2 +-
 drivers/usb/host/xhci-mtk.c                        |    7 +
 drivers/usb/host/xhci-pci-renesas.c                |    4 -
 drivers/usb/host/xhci-ring.c                       |    2 +-
 drivers/usb/host/xhci-tegra.c                      |    8 +-
 drivers/usb/host/xhci.h                            |    2 +-
 drivers/usb/image/mdc800.c                         |    2 +-
 drivers/usb/misc/Kconfig                           |   16 +
 drivers/usb/misc/Makefile                          |    1 +
 drivers/usb/misc/ldusb.c                           |    6 +-
 drivers/usb/misc/onboard_usb_hub.c                 |  458 ++++++
 drivers/usb/misc/onboard_usb_hub.h                 |   36 +
 drivers/usb/misc/onboard_usb_hub_pdevs.c           |  143 ++
 drivers/usb/misc/usbsevseg.c                       |    2 +-
 drivers/usb/misc/usbtest.c                         |    2 +-
 drivers/usb/mtu3/mtu3.h                            |    5 +-
 drivers/usb/mtu3/mtu3_core.c                       |   35 +-
 drivers/usb/mtu3/mtu3_debugfs.c                    |    8 +-
 drivers/usb/mtu3/mtu3_gadget.c                     |   38 +-
 drivers/usb/mtu3/mtu3_gadget_ep0.c                 |   10 +-
 drivers/usb/mtu3/mtu3_hw_regs.h                    |   16 +
 drivers/usb/mtu3/mtu3_plat.c                       |   43 +-
 drivers/usb/mtu3/mtu3_trace.h                      |    4 +-
 drivers/usb/musb/Kconfig                           |   13 +-
 drivers/usb/musb/Makefile                          |    1 +
 drivers/usb/musb/mpfs.c                            |  269 ++++
 drivers/usb/musb/musb_core.c                       |   16 +-
 drivers/usb/musb/musb_cppi41.c                     |    2 +-
 drivers/usb/musb/musb_gadget.c                     |    2 -
 drivers/usb/musb/tusb6010.c                        |    2 +-
 drivers/usb/phy/phy-keystone.c                     |    2 +-
 drivers/usb/renesas_usbhs/rza.c                    |    4 +
 drivers/usb/serial/cypress_m8.c                    |    2 +-
 drivers/usb/serial/garmin_gps.c                    |    4 +-
 drivers/usb/serial/io_edgeport.c                   |    4 +-
 drivers/usb/serial/mos7720.c                       |    2 +-
 drivers/usb/serial/opticon.c                       |    4 +-
 drivers/usb/serial/sierra.c                        |    7 +-
 drivers/usb/serial/usb-serial.c                    |    2 +-
 drivers/usb/serial/usb_wwan.c                      |   13 +-
 drivers/usb/storage/transport.c                    |    2 +-
 drivers/usb/typec/Kconfig                          |   11 +
 drivers/usb/typec/Makefile                         |    3 +-
 drivers/usb/typec/anx7411.c                        | 1601 ++++++++++++++++++++
 drivers/usb/typec/class.c                          |  167 +-
 drivers/usb/typec/class.h                          |    6 +
 drivers/usb/typec/mux.c                            |    8 +-
 drivers/usb/typec/pd.c                             |  708 +++++++++
 drivers/usb/typec/pd.h                             |   30 +
 drivers/usb/typec/retimer.c                        |  173 +++
 drivers/usb/typec/retimer.h                        |   15 +
 drivers/usb/typec/tcpm/tcpci.c                     |    3 +-
 drivers/usb/typec/tcpm/tcpci_maxim.c               |    3 +-
 drivers/usb/typec/tcpm/tcpci_mt6360.c              |    3 +-
 drivers/usb/typec/tcpm/tcpci_rt1711h.c             |    2 +-
 drivers/usb/typec/tcpm/tcpm.c                      |  146 +-
 drivers/usb/typec/ucsi/Kconfig                     |   10 +
 drivers/usb/typec/ucsi/Makefile                    |    1 +
 drivers/usb/typec/ucsi/ucsi.c                      |    4 +
 drivers/usb/typec/ucsi/ucsi_ccg.c                  |   28 +-
 drivers/usb/typec/ucsi/ucsi_stm32g0.c              |  777 ++++++++++
 drivers/usb/usbip/vudc_rx.c                        |    6 +-
 drivers/usb/usbip/vudc_sysfs.c                     |   14 +-
 include/linux/of_platform.h                        |   22 +-
 include/linux/usb.h                                |    2 +
 include/linux/usb/hcd.h                            |    1 +
 include/linux/usb/onboard_hub.h                    |   18 +
 include/linux/usb/pd.h                             |   38 +
 .../usb/typec/tcpm => include/linux/usb}/tcpci.h   |    1 +
 include/linux/usb/typec.h                          |   23 +
 include/linux/usb/typec_altmode.h                  |    2 +-
 include/linux/usb/typec_mux.h                      |   44 +-
 include/linux/usb/typec_retimer.h                  |   45 +
 include/uapi/linux/usb/cdc.h                       |   13 +
 tools/usb/testusb.c                                |   18 +-
 173 files changed, 8399 insertions(+), 692 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-platform-onboard-usb-hub
 create mode 100644 Documentation/ABI/testing/sysfs-class-usb_power_delivery
 create mode 100644 Documentation/devicetree/bindings/usb/analogix,anx7411.yaml
 create mode 100644 Documentation/devicetree/bindings/usb/aspeed,ast2600-udc.yaml
 create mode 100644 Documentation/devicetree/bindings/usb/st,typec-stm32g0.yaml
 create mode 100644 Documentation/devicetree/bindings/usb/ti,usb8041.yaml
 delete mode 100644 drivers/staging/octeon-usb/Kconfig
 delete mode 100644 drivers/staging/octeon-usb/Makefile
 delete mode 100644 drivers/staging/octeon-usb/TODO
 create mode 100644 drivers/usb/gadget/udc/aspeed_udc.c
 rename drivers/{staging/octeon-usb => usb/host}/octeon-hcd.c (100%)
 rename drivers/{staging/octeon-usb => usb/host}/octeon-hcd.h (100%)
 create mode 100644 drivers/usb/misc/onboard_usb_hub.c
 create mode 100644 drivers/usb/misc/onboard_usb_hub.h
 create mode 100644 drivers/usb/misc/onboard_usb_hub_pdevs.c
 create mode 100644 drivers/usb/musb/mpfs.c
 create mode 100644 drivers/usb/typec/anx7411.c
 create mode 100644 drivers/usb/typec/pd.c
 create mode 100644 drivers/usb/typec/pd.h
 create mode 100644 drivers/usb/typec/retimer.c
 create mode 100644 drivers/usb/typec/retimer.h
 create mode 100644 drivers/usb/typec/ucsi/ucsi_stm32g0.c
 create mode 100644 include/linux/usb/onboard_hub.h
 rename {drivers/usb/typec/tcpm => include/linux/usb}/tcpci.h (99%)
 create mode 100644 include/linux/usb/typec_retimer.h

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 016E648C54F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 14:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353805AbiALN5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 08:57:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241015AbiALN4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 08:56:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9718C061748;
        Wed, 12 Jan 2022 05:56:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78E226190C;
        Wed, 12 Jan 2022 13:56:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 786A2C36AE5;
        Wed, 12 Jan 2022 13:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641995808;
        bh=qrtJywSoWq2A3DUpZiXLa179d7xdDv4wfltTscP03l0=;
        h=Date:From:To:Cc:Subject:From;
        b=IhYpTobhQNqY6qw/Xa45OCwy2/oo4KFG2cnF8pxIItXIWUjvu+YJydGEwL8sPQ7Ek
         zbzUuV6j7kYAKAliPUlNg3ZQUV8FkOL7YntlMy9zDgNkvCkv2L0KDPAKlnqZd3nUCD
         f6xwso3EksNOpMZO0zDdbbok9VuZzI/PgVRQBPlE=
Date:   Wed, 12 Jan 2022 14:56:46 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB changes for 5.17-rc1
Message-ID: <Yd7eHm8EDkYETMw8@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit c9e6606c7fe92b50a02ce51dda82586ebdf99b48:

  Linux 5.16-rc8 (2022-01-02 14:23:25 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.17-rc1

for you to fetch changes up to cbb4f5f435995a56ef770e35bfafb4bcff8f0ada:

  docs: ABI: fixed formatting in configfs-usb-gadget-uac2 (2022-01-08 15:48:52 +0100)

----------------------------------------------------------------
USB/Thunderbolt changes for 5.17-rc1

Here is the big set of USB and Thunderbolt driver changes for 5.17-rc1.

Nothing major in here, just lots of little updates and cleanups.  These
include:
	- some USB header fixes picked from Ingo's header-splitup work
	- more USB4/Thunderbolt hardware support added
	- USB gadget driver updates and additions
	- USB typec additions (includes some acpi changes, which were
	  acked by the ACPI maintainer)
	- core USB fixes as found by syzbot that were too late for
	  5.16-final
	- USB dwc3 driver updates
	- USB dwc2 driver updates
	- platform_get_irq() conversions of some USB drivers
	- other minor USB driver updates and additions

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alan Stern (2):
      USB: Fix "slab-out-of-bounds Write" bug in usb_hcd_poll_rh_status
      USB: core: Fix bug in resuming hub's handling of wakeup requests

Amelie Delaunay (1):
      usb: dwc2: platform: adopt dev_err_probe() to silent probe defer

Amjad Ouled-Ameur (1):
      usb: dwc3: meson-g12a: fix shared reset control use

Andy Shevchenko (1):
      thunderbolt: Do not dereference fwnode in struct device

Balamanikandan Gunasundar (1):
      usb: gadget: at91_udc: Convert to GPIO descriptors

Changcheng Deng (1):
      xhci: use max() to make code cleaner

Christophe JAILLET (2):
      usb: Remove redundant 'flush_workqueue()' calls
      usb: dwc2: Simplify a bitmap declaration

Chunfeng Yun (2):
      usb: xhci-mtk: remove unnecessary error check
      usb: xhci-mtk: fix random remote wakeup

Dan Carpenter (1):
      usb: hub: make wait_for_connected() take an int instead of a pointer to int

David Heidelberg (1):
      dt-bindings: usb: qcom,dwc3: add binding for IPQ4019 and IPQ8064

Dinh Nguyen (1):
      usb: dwc2: do not gate off the hardware if it does not support clock gating

Dongliang Mu (1):
      usb: bdc: fix error handling code in bdc_resume

Fabrice Gasnier (4):
      dt-bindings: usb: dwc2: document the port when usb-role-switch is used
      dt-bindings: usb: document role-switch-default-mode property in dwc2
      usb: dwc2: drd: add role-switch-default-node support
      usb: dwc2: drd: restore role and overrides upon resume

Gil Fine (7):
      thunderbolt: Add TMU uni-directional mode
      thunderbolt: Add CL0s support for USB4 routers
      thunderbolt: Move usb4_switch_wait_for_bit() to switch.c
      thunderbolt: Implement TMU time disruption for Intel Titan Ridge
      thunderbolt: Rename Intel TB_VSE_CAP_IECS capability
      thunderbolt: Enable CL0s for Intel Titan Ridge
      thunderbolt: Add module parameter for CLx disabling

Greg Kroah-Hartman (8):
      Merge 5.16-rc3 into usb-next
      Merge 5.16-rc4 into usb-next
      Merge 5.16-rc5 into usb-next
      Merge 5.16-rc6 into usb-next
      Revert "usb: host: ehci-sh: propagate errors from platform_get_irq()"
      Merge 5.16-rc8 into usb-next
      Merge tag 'thunderbolt-for-v5.17-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt into usb-next
      USB: common: debug: add needed kernel.h include

Guo Zhengkui (1):
      usb: core: hcd: change sizeof(vaddr) to sizeof(unsigned long)

Haimin Zhang (1):
      USB: ehci_brcm_hub_control: Improve port index sanitizing

Hangyu Hua (2):
      usb: gadget: don't release an existing dev->buf
      usb: gadget: clear related members when goto fail

Heikki Krogerus (5):
      acpi: Export acpi_bus_type
      acpi: Store CRC-32 hash of the _PLD in struct acpi_device
      usb: Link the ports to the connectors they are attached to
      usb: typec: port-mapper: Convert to the component framework
      usb: Remove usb_for_each_port()

Ingo Molnar (4):
      headers/prep: usb: gadget: Fix namespace collision
      headers/prep: Fix non-standard header section: drivers/usb/cdns3/core.h
      headers/prep: Fix non-standard header section: drivers/usb/host/ohci-tmio.c
      headers/deps: USB: Optimize <linux/usb/ch9.h> dependencies, remove <linux/device.h>

Jason Wang (1):
      usb: cdnsp: Remove unneeded semicolon after `}'

John Keeping (4):
      usb: gadget: f_midi: allow resetting index option
      usb: dwc2: gadget: use existing helper
      usb: dwc2: gadget: initialize max_speed from params
      usb: gadget: u_audio: fix calculations for small bInterval

Juergen Gross (3):
      usb: Add Xen pvUSB protocol description
      usb: Introduce Xen pvUSB frontend (xen hcd)
      xen: add Xen pvUSB maintainer

Kai-Heng Feng (1):
      usb: hub: Add delay for SuperSpeed hub resume to let links transit to U0

Kees Cook (1):
      thunderbolt: xdomain: Avoid potential stack OOB read

Lad Prabhakar (6):
      usb: host: fotg210: Use platform_get_irq() to get the interrupt
      usb: renesas_usbhs: Use platform_get_irq() to get the interrupt
      usb: dwc3: Drop unneeded calls to platform_get_resource_byname()
      usb: isp1760: Use platform_get_irq() to get the interrupt
      usb: cdns3: Use platform_get_irq_byname() to get the interrupt
      usb: musb: dsps: Use platform_get_irq_byname() to get the interrupt

Linyu Yuan (4):
      usb: gadget: configfs: simplify os_desc_item_to_gadget_info() helper
      usb: gadget: configfs: remove os_desc_attr_release()
      usb: gadget: configfs: use to_config_usb_cfg() in os_desc_link()
      usb: gadget: configfs: use to_usb_function_instance() in cfg (un)link func

Luca Weiss (1):
      dt-bindings: usb: qcom,dwc3: Add SM6350 compatible

Lukas Bulwahn (1):
      MAINTAINERS: remove typo from XEN PVUSB DRIVER section

Manish Narani (1):
      dt-bindings: usb: dwc3-xilinx: Convert USB DWC3 bindings

Mathias Nyman (1):
      usb: hub: avoid warm port reset during USB3 disconnect

Miaoqian Lin (2):
      usb: dwc3: dwc3-qcom: Add missing platform_device_put() in dwc3_qcom_acpi_register_core
      usb: dwc3: qcom: Fix NULL vs IS_ERR checking in dwc3_qcom_probe

Mika Westerberg (6):
      thunderbolt: Runtime PM activate both ends of the device link
      thunderbolt: Tear down existing tunnels when resuming from hibernate
      thunderbolt: Runtime resume USB4 port when retimers are scanned
      thunderbolt: Do not allow subtracting more NFC credits than configured
      thunderbolt: Do not program path HopIDs for USB4 routers
      thunderbolt: Add debug logging of DisplayPort resource allocation

Neal Liu (4):
      usb: uhci: add aspeed ast2600 uhci support
      usb: aspeed-vhub: add qualifier descriptor
      usb: aspeed-vhub: fix ep0 OUT ack received wrong length issue
      usb: aspeed-vhub: support test mode feature

Pavankumar Kondeti (1):
      usb: gadget: f_fs: Use stream_open() for endpoint files

Pavel Hofman (4):
      docs: ABI: added missing num_requests param to UAC2
      docs: ABI: fixed req_number desc in UAC1
      usb: gadget: u_audio: Subdevice 0 for capture ctls
      docs: ABI: fixed formatting in configfs-usb-gadget-uac2

Philipp Hortmann (3):
      Docs: usb: update err() to pr_err() and replace __FILE__
      Docs: usb: update comment and code near increment usage count
      Docs: usb: update writesize, copy_from_user, usb_fill_bulk_urb, usb_submit_urb

Qihang Hu (1):
      usb: gadget: composite: Show warning if function driver's descriptors are incomplete.

Razvan Heghedus (2):
      usb: core: Export usb_device_match_id
      usb: misc: ehset: Rework test mode entry

Rob Herring (6):
      usb: ohci-spear: Remove direct access to platform_device resource list
      usb: ohci-s3c2410: Use platform_get_irq() to get the interrupt
      usb: uhci: Use platform_get_irq() to get the interrupt
      usb: chipidea: Set the DT node on the child device
      usb: musb: Drop unneeded resource copying
      usb: musb: Set the DT node on the child device

Saranya Gopal (1):
      usb: typec: ucsi: Expose number of alternate modes in partner

Sergey Shtylyov (4):
      usb: gadget: udc: bcm63xx: propagate errors from platform_get_irq()
      usb: gadget: udc: pxa25x: propagate errors from platform_get_irq()
      usb: host: ehci-sh: propagate errors from platform_get_irq()
      usb: host: ohci-omap: propagate errors from platform_get_irq()

Shubhrajyoti Datta (1):
      usb: xilinx: Add suspend resume support

Thierry Reding (1):
      dt-bindings: usb: tegra-xudc: Document interconnects and iommus properties

Thinh Nguyen (4):
      usb: dwc3: gadget: Skip checking Update Transfer status
      usb: dwc3: gadget: Ignore Update Transfer cmd params
      usb: dwc3: gadget: Skip reading GEVNTSIZn
      usb: dwc3: gadget: Support Multi-Stream Transfer

Vinod Koul (1):
      dt-bindings: usb: qcom,dwc3: add binding for SM8450

Wei Ming Chen (1):
      usb: core: Fix file path that does not exist

Wei Yongjun (1):
      usb: ftdi-elan: fix memory leak on device disconnect

Xiaoke Wang (1):
      thunderbolt: Check return value of kmemdup() in icm_handle_event()

Yang Yingliang (1):
      usb: host: xen-hcd: add missing unlock in error path

luo penghao (1):
      usb-storage: Remove redundant assignments

 Documentation/ABI/testing/configfs-usb-gadget-uac1 |    2 +-
 Documentation/ABI/testing/configfs-usb-gadget-uac2 |    2 +
 Documentation/ABI/testing/sysfs-bus-usb            |    9 +
 Documentation/devicetree/bindings/usb/dwc2.yaml    |   13 +
 .../devicetree/bindings/usb/dwc3-xilinx.txt        |   56 -
 .../devicetree/bindings/usb/dwc3-xilinx.yaml       |  131 ++
 .../devicetree/bindings/usb/nvidia,tegra-xudc.yaml |   13 +
 .../devicetree/bindings/usb/qcom,dwc3.yaml         |    4 +
 .../driver-api/usb/writing_usb_driver.rst          |   32 +-
 Documentation/usb/gadget-testing.rst               |    2 +-
 MAINTAINERS                                        |    8 +
 drivers/acpi/bus.c                                 |    1 +
 drivers/acpi/scan.c                                |   16 +
 drivers/thunderbolt/acpi.c                         |   15 +-
 drivers/thunderbolt/icm.c                          |    7 +-
 drivers/thunderbolt/lc.c                           |   24 +
 drivers/thunderbolt/path.c                         |   42 +-
 drivers/thunderbolt/retimer.c                      |   28 +-
 drivers/thunderbolt/switch.c                       |  493 +++++-
 drivers/thunderbolt/tb.c                           |   91 +-
 drivers/thunderbolt/tb.h                           |  106 +-
 drivers/thunderbolt/tb_msgs.h                      |   47 +-
 drivers/thunderbolt/tb_regs.h                      |  113 +-
 drivers/thunderbolt/tmu.c                          |  337 +++-
 drivers/thunderbolt/tunnel.c                       |   27 +-
 drivers/thunderbolt/tunnel.h                       |    9 +-
 drivers/thunderbolt/usb4.c                         |   52 +-
 drivers/thunderbolt/xdomain.c                      |   16 +-
 drivers/usb/cdns3/cdns3-plat.c                     |   14 +-
 drivers/usb/cdns3/cdnsp-gadget.c                   |    2 +-
 drivers/usb/cdns3/core.h                           |    6 +-
 drivers/usb/chipidea/core.c                        |    1 +
 drivers/usb/chipidea/otg.c                         |    5 +-
 drivers/usb/common/debug.c                         |    1 +
 drivers/usb/core/driver.c                          |    3 +-
 drivers/usb/core/generic.c                         |    2 +-
 drivers/usb/core/hcd.c                             |   11 +-
 drivers/usb/core/hub.c                             |   37 +-
 drivers/usb/core/port.c                            |   32 +
 drivers/usb/core/usb.c                             |   46 -
 drivers/usb/dwc2/core.h                            |    6 +-
 drivers/usb/dwc2/drd.c                             |   51 +-
 drivers/usb/dwc2/gadget.c                          |   17 +-
 drivers/usb/dwc2/hcd.c                             |    7 +-
 drivers/usb/dwc2/platform.c                        |   63 +-
 drivers/usb/dwc3/core.h                            |    9 +
 drivers/usb/dwc3/dwc3-meson-g12a.c                 |   17 +-
 drivers/usb/dwc3/dwc3-qcom.c                       |   15 +-
 drivers/usb/dwc3/gadget.c                          |   59 +-
 drivers/usb/dwc3/host.c                            |   45 +-
 drivers/usb/gadget/composite.c                     |   39 +-
 drivers/usb/gadget/configfs.c                      |   39 +-
 drivers/usb/gadget/function/f_fs.c                 |    4 +-
 drivers/usb/gadget/function/f_midi.c               |   48 +-
 drivers/usb/gadget/function/u_audio.c              |   28 +-
 drivers/usb/gadget/legacy/inode.c                  |   18 +-
 drivers/usb/gadget/udc/aspeed-vhub/dev.c           |   19 +-
 drivers/usb/gadget/udc/aspeed-vhub/ep0.c           |    7 +
 drivers/usb/gadget/udc/aspeed-vhub/hub.c           |   47 +-
 drivers/usb/gadget/udc/aspeed-vhub/vhub.h          |    1 +
 drivers/usb/gadget/udc/at91_udc.c                  |   67 +-
 drivers/usb/gadget/udc/at91_udc.h                  |    8 +-
 drivers/usb/gadget/udc/bcm63xx_udc.c               |    8 +-
 drivers/usb/gadget/udc/bdc/bdc_core.c              |    1 +
 drivers/usb/gadget/udc/mv_udc_core.c               |    4 +-
 drivers/usb/gadget/udc/pxa25x_udc.c                |    2 +-
 drivers/usb/gadget/udc/udc-xilinx.c                |   56 +
 drivers/usb/host/Kconfig                           |   11 +
 drivers/usb/host/Makefile                          |    1 +
 drivers/usb/host/ehci-brcm.c                       |    6 +-
 drivers/usb/host/fotg210-hcd.c                     |   11 +-
 drivers/usb/host/ohci-omap.c                       |    2 +-
 drivers/usb/host/ohci-s3c2410.c                    |   10 +-
 drivers/usb/host/ohci-spear.c                      |    2 +-
 drivers/usb/host/ohci-tmio.c                       |    5 -
 drivers/usb/host/u132-hcd.c                        |    1 -
 drivers/usb/host/uhci-platform.c                   |    9 +-
 drivers/usb/host/xen-hcd.c                         | 1609 ++++++++++++++++++++
 drivers/usb/host/xhci-mtk.c                        |   16 +-
 drivers/usb/host/xhci.c                            |    6 +-
 drivers/usb/isp1760/isp1760-if.c                   |   16 +-
 drivers/usb/misc/ehset.c                           |   58 +
 drivers/usb/misc/ftdi-elan.c                       |    1 +
 drivers/usb/musb/am35x.c                           |    2 +
 drivers/usb/musb/da8xx.c                           |   20 +-
 drivers/usb/musb/jz4740.c                          |    1 +
 drivers/usb/musb/mediatek.c                        |    2 +
 drivers/usb/musb/musb_dsps.c                       |   15 +-
 drivers/usb/musb/omap2430.c                        |   23 +-
 drivers/usb/musb/ux500.c                           |   18 +-
 drivers/usb/phy/phy-mv-usb.c                       |    5 +-
 drivers/usb/renesas_usbhs/common.c                 |   14 +-
 drivers/usb/renesas_usbhs/common.h                 |    1 -
 drivers/usb/renesas_usbhs/mod.c                    |   14 +-
 drivers/usb/storage/sierra_ms.c                    |    2 -
 drivers/usb/typec/Makefile                         |    3 +-
 drivers/usb/typec/class.c                          |    2 -
 drivers/usb/typec/class.h                          |   10 +-
 drivers/usb/typec/port-mapper.c                    |  279 +---
 drivers/usb/typec/ucsi/ucsi.c                      |   16 +-
 drivers/usb/usbip/usbip_event.c                    |    1 -
 include/acpi/acpi_bus.h                            |    1 +
 include/linux/usb.h                                |    9 -
 include/linux/usb/ch9.h                            |    3 +-
 include/linux/usb/typec.h                          |   12 -
 include/xen/interface/io/usbif.h                   |  405 +++++
 106 files changed, 4185 insertions(+), 978 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/usb/dwc3-xilinx.txt
 create mode 100644 Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml
 create mode 100644 drivers/usb/host/xen-hcd.c
 create mode 100644 include/xen/interface/io/usbif.h

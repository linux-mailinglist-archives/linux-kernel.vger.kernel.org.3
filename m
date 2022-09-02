Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB0625AB550
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 17:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235956AbiIBPfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 11:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236881AbiIBPfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 11:35:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05B3FC324;
        Fri,  2 Sep 2022 08:21:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E17461EF9;
        Fri,  2 Sep 2022 15:21:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8888AC433C1;
        Fri,  2 Sep 2022 15:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662132064;
        bh=qE2qCvBtrok6rAcPCYzRK7qWcNI6d3AZ5fz62vWBTcs=;
        h=Date:From:To:Cc:Subject:From;
        b=s3XPBtMbVXP0qfzenNqFPFpwenonPZxA50VRY+iAG5u6Z8pkt1bbJxgbz24BjAcrI
         4fYjDDpBrdEBedLIX1lxNNBAs4Wp51zH5TyupqUyedVv3VLqRZ9erAwM9NSHFGKbjl
         Vdmz7UQiaOIedsQ6r6DhfJuNVE5dCIWxLb5F4K/0=
Date:   Fri, 2 Sep 2022 17:21:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB / Thunderbolt driver fixes for 6.0-rc4
Message-ID: <YxIfXoyXB6UQulWv@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.0-rc4

for you to fetch changes up to fe0a2ac7c627b064c479ad0c3b25e531d342e048:

  Revert "usb: gadget: udc-xilinx: replace memcpy with memcpy_toio" (2022-09-02 09:10:08 +0200)

----------------------------------------------------------------
USB/Thunderbolt driver fixes for 6.0-rc4

Here are a lot of small USB and Thunderbolt driver fixes for 6.0-rc4 for
reported problems.  Included in here are:
  - new usb-serial driver ids
  - dwc3 driver bugfixes for reported problems with 6.0-rc1
  - new device quirks, and reverts of some quirks that were incorrect
  - gadget driver bugfixes for reported problems
  - USB host controller bugfixes (xhci and others)
  - other small USB fixes, details in the shortlog
  - small thunderbolt driver fixes

All of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alan Stern (3):
      USB: gadget: Fix obscure lockdep violation for udc_mutex
      USB: core: Prevent nested device-reset calls
      media: mceusb: Use new usb_control_msg_*() routines

Arnd Bergmann (1):
      musb: fix USB_MUSB_TUSB6010 dependency

Badhri Jagan Sridharan (1):
      usb: typec: tcpm: Return ENOTSUPP for power supply prop writes

Chunfeng Yun (3):
      usb: xhci-mtk: relax TT periodic bandwidth allocation
      usb: xhci-mtk: fix bandwidth release issue
      dt-bindings: usb: mtu3: add compatible for mt8188

Greg Kroah-Hartman (4):
      Merge tag 'thunderbolt-for-v6.0-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt into usb-linus
      Revert "usb: add quirks for Lenovo OneLink+ Dock"
      Merge tag 'usb-serial-6.0-rc4' of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-linus
      Revert "usb: gadget: udc-xilinx: replace memcpy with memcpy_toio"

Heikki Krogerus (2):
      usb: dwc3: pci: Add support for Intel Raptor Lake
      usb: typec: Remove retimers properly

Heiner Kallweit (1):
      usb: dwc2: fix wrong order of phy_power_on and phy_init

Hu Xiaoying (1):
      usb: storage: Add ASUS <0x0b05:0x1932> to IGNORE_UAS

Jean-Francois Le Fillatre (1):
      usb: add quirks for Lenovo OneLink+ Dock

Jing Leng (1):
      usb: gadget: f_uac2: fix superspeed transfer

Johan Hovold (14):
      usb: dwc3: fix PHY disable sequence
      Revert "usb: dwc3: qcom: Keep power domain on to retain controller status"
      usb: dwc3: qcom: fix gadget-only builds
      usb: dwc3: qcom: fix use-after-free on runtime-PM wakeup
      usb: dwc3: qcom: fix runtime PM wakeup
      usb: dwc3: qcom: fix peripheral and OTG suspend
      dt-bindings: usb: qcom,dwc3: add wakeup-source property
      usb: dwc3: qcom: fix wakeup implementation
      usb: dwc3: qcom: clean up suspend callbacks
      usb: dwc3: qcom: suppress unused-variable warning
      usb: dwc3: disable USB core PHY management
      USB: serial: cp210x: add Decagon UCA device id
      USB: serial: ch341: fix lost character on LCR updates
      USB: serial: ch341: fix disabled rx timer on older devices

Konrad Dybcio (1):
      dt-bindings: usb: qcom,dwc3: Add SM6375 compatible

Krishna Kurapati (1):
      usb: gadget: mass_storage: Fix cdrom data transfers on MAC-OS

Mathias Nyman (3):
      xhci: Fix null pointer dereference in remove if xHC has only one roothub
      xhci: Add grace period after xHC start to prevent premature runtime suspend.
      Revert "xhci: turn off port power in shutdown"

Matthias Kaehlcke (1):
      usb: misc: onboard_usb_hub: Drop reset delay in onboard_hub_power_off()

Mika Westerberg (2):
      thunderbolt: Use the actual buffer in tb_async_error()
      thunderbolt: Check router generation before connecting xHCI

Niek Nooijens (1):
      USB: serial: ftdi_sio: add Omron CS1W-CIF31 device id

Pablo Sun (1):
      usb: typec: altmodes/displayport: correct pin assignment for UFP receptacles

Pawel Laszczak (2):
      usb: cdns3: fix incorrect handling TRB_SMM flag for ISOC transfer
      usb: cdns3: fix issue with rearming ISO OUT endpoint

Piyush Mehta (1):
      usb: gadget: udc-xilinx: replace memcpy with memcpy_toio

Slark Xiao (1):
      USB: serial: option: add support for Cinterion MV32-WA/WB RmNet mode

Takashi Iwai (1):
      Revert "usb: typec: ucsi: add a common function ucsi_unregister_connectors()"

Thierry GUIBERT (1):
      USB: cdc-acm: Add Icom PMR F3400 support (0c26:0020)

Utkarsh Patel (1):
      usb: typec: intel_pmc_mux: Add new ACPI ID for Meteor Lake IOM device

Wesley Cheng (1):
      usb: dwc3: gadget: Avoid duplicate requests to enable Run/Stop

Witold Lipieta (1):
      usb-storage: Add ignore-residue quirk for NXP PN7462AU

Yan Xinyu (1):
      USB: serial: option: add support for OPPO R11 diag port

Yonglin Tan (1):
      USB: serial: option: add Quectel EM060K modem

 .../devicetree/bindings/usb/mediatek,mtu3.yaml     |  1 +
 .../devicetree/bindings/usb/qcom,dwc3.yaml         |  6 ++
 drivers/media/rc/mceusb.c                          | 35 ++++----
 drivers/thunderbolt/ctl.c                          |  2 +-
 drivers/thunderbolt/switch.c                       |  6 +-
 drivers/usb/cdns3/cdns3-gadget.c                   |  4 +-
 drivers/usb/class/cdc-acm.c                        |  3 +
 drivers/usb/core/hub.c                             | 10 +++
 drivers/usb/dwc2/platform.c                        |  8 +-
 drivers/usb/dwc3/core.c                            | 24 +++---
 drivers/usb/dwc3/dwc3-pci.c                        |  4 +
 drivers/usb/dwc3/dwc3-qcom.c                       | 96 +++++++++++++---------
 drivers/usb/dwc3/gadget.c                          |  8 +-
 drivers/usb/dwc3/host.c                            | 11 +++
 drivers/usb/gadget/function/f_uac2.c               | 16 +++-
 drivers/usb/gadget/function/storage_common.c       |  6 +-
 drivers/usb/gadget/udc/core.c                      | 26 +++---
 drivers/usb/host/xhci-hub.c                        | 13 ++-
 drivers/usb/host/xhci-mtk-sch.c                    | 15 +---
 drivers/usb/host/xhci-plat.c                       | 11 ++-
 drivers/usb/host/xhci.c                            | 19 ++---
 drivers/usb/host/xhci.h                            |  4 +-
 drivers/usb/misc/onboard_usb_hub.c                 |  5 +-
 drivers/usb/musb/Kconfig                           |  2 +-
 drivers/usb/serial/ch341.c                         | 16 +++-
 drivers/usb/serial/cp210x.c                        |  1 +
 drivers/usb/serial/ftdi_sio.c                      |  2 +
 drivers/usb/serial/ftdi_sio_ids.h                  |  6 ++
 drivers/usb/serial/option.c                        | 15 ++++
 drivers/usb/storage/unusual_devs.h                 |  7 ++
 drivers/usb/storage/unusual_uas.h                  |  7 ++
 drivers/usb/typec/altmodes/displayport.c           |  4 +-
 drivers/usb/typec/class.c                          |  1 +
 drivers/usb/typec/mux/intel_pmc_mux.c              |  9 +-
 drivers/usb/typec/tcpm/tcpm.c                      |  7 ++
 drivers/usb/typec/ucsi/ucsi.c                      | 53 ++++++------
 include/linux/usb.h                                |  2 +
 include/linux/usb/typec_dp.h                       |  5 ++
 38 files changed, 303 insertions(+), 167 deletions(-)

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7C84A2FAE
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 14:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348189AbiA2NLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 08:11:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239739AbiA2NLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 08:11:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34CE7C061714;
        Sat, 29 Jan 2022 05:11:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 717ACB811EA;
        Sat, 29 Jan 2022 13:11:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D484DC340E5;
        Sat, 29 Jan 2022 13:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643461896;
        bh=WL1zPq7qPyVP2phf4SmUWmSQlcrTRlPlpSB7FeBMr4E=;
        h=Date:From:To:Cc:Subject:From;
        b=lbRmkCbgrhnIjjHKLC6C5ss6I4tgPtyHAIJqew4CqIEWUbPa5K3RkpG/NydLh/0Q9
         uNjAP02G1NxeqBebaZ2tu3rPuVBuSg1kBuWFBEaZuk7L3aJZFkgpINsFDQWDkfMvTZ
         2en/esMec2WCWvb5oU+fZoU09nDsxcE0zBTmaRUI=
Date:   Sat, 29 Jan 2022 14:11:33 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB fixes for 5.17-rc2
Message-ID: <YfU9Bdjy8/Z0qQX/@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.17-rc2

for you to fetch changes up to 79aa3e19fe8f5be30e846df8a436bfe306e8b1a6:

  usb: cdnsp: Fix segmentation fault in cdns_lost_power function (2022-01-26 14:11:16 +0100)

----------------------------------------------------------------
USB driver fixes for 5.17-rc2

Here are some small USB driver fixes for 5.17-rc2 that resolve a number
of reported problems.  These include:
	- typec driver fixes
	- xhci platform driver fixes for suspending
	- ulpi core fix
	- role.h build fix
	- new device ids
	- syzbot-reported bugfixes
	- gadget driver fixes
	- dwc3 driver fixes
	- other small fixes

All of these have been in linux-next this week with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alan Stern (2):
      usb-storage: Add unusual-devs entry for VL817 USB-SATA bridge
      USB: core: Fix hang in usb_kill_urb by adding memory barriers

Amelie Delaunay (1):
      usb: dwc2: gadget: don't try to disable ep0 in dwc2_hsotg_suspend

Badhri Jagan Sridharan (2):
      usb: typec: tcpm: Do not disconnect while receiving VBUS off
      usb: typec: tcpm: Do not disconnect when receiving VSAFE0V

Frank Li (1):
      usb: xhci-plat: fix crash when suspend if remote wake enable

Heikki Krogerus (2):
      usb: typec: Only attempt to link USB ports if there is fwnode
      usb: typec: Don't try to register component master without components

Jon Hunter (1):
      usb: common: ulpi: Fix crash in ulpi_match()

Linyu Yuan (1):
      usb: roles: fix include/linux/usb/role.h compile issue

Miles Chen (1):
      usb: gadget: at91_udc: fix incorrect print type

Pavankumar Kondeti (1):
      usb: gadget: f_sourcesink: Fix isoc transfer for USB_SPEED_SUPER_PLUS

Pawel Laszczak (1):
      usb: cdnsp: Fix segmentation fault in cdns_lost_power function

Robert Hancock (2):
      usb: dwc3: xilinx: Skip resets and USB3 register settings for USB2.0 mode
      usb: dwc3: xilinx: Fix error handling when getting USB3 PHY

Sing-Han Chen (1):
      ucsi_ccg: Check DEV_INT bit only when starting CCG4

Xu Yang (1):
      usb: typec: tcpci: don't touch CC line if it's Vconn source

 drivers/usb/cdns3/drd.c                    |  6 +++---
 drivers/usb/common/ulpi.c                  |  7 +++++--
 drivers/usb/core/hcd.c                     | 14 ++++++++++++++
 drivers/usb/core/urb.c                     | 12 ++++++++++++
 drivers/usb/dwc2/gadget.c                  |  2 +-
 drivers/usb/dwc3/dwc3-xilinx.c             | 23 ++++++++++++++++++-----
 drivers/usb/gadget/function/f_sourcesink.c |  1 +
 drivers/usb/gadget/udc/at91_udc.c          |  2 +-
 drivers/usb/host/xhci-plat.c               |  3 +++
 drivers/usb/storage/unusual_devs.h         | 10 ++++++++++
 drivers/usb/typec/port-mapper.c            |  8 +++++++-
 drivers/usb/typec/tcpm/tcpci.c             | 26 ++++++++++++++++++++++++++
 drivers/usb/typec/tcpm/tcpci.h             |  1 +
 drivers/usb/typec/tcpm/tcpm.c              |  7 ++++++-
 drivers/usb/typec/ucsi/ucsi_ccg.c          |  2 +-
 include/linux/usb/role.h                   |  6 ++++++
 16 files changed, 115 insertions(+), 15 deletions(-)

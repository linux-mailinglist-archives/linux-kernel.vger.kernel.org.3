Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3E9E479BD7
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 17:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233694AbhLRQ6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 11:58:33 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:37650 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbhLRQ6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 11:58:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7AC560B13;
        Sat, 18 Dec 2021 16:58:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99499C36AE1;
        Sat, 18 Dec 2021 16:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1639846711;
        bh=P++GSd247vKL0+vUiunK84t91Cn/zwqebVvITnJJxl8=;
        h=Date:From:To:Cc:Subject:From;
        b=mxk/1GTW6nzLdAa1GZ22JGYG0iyb6UO+kBXSzka1BaGsyVHlG+tKcXYwu7N6BJt3Z
         GRLWDbwNB3nlEvBgNd+gOBm3vE7k5d6fPJyCPSauIOCq5kvVV4Kfo85y+x23fanP8P
         yzqK9bM506qDfUGdRafFUWXUPlrLtaS9NdJOZtqo=
Date:   Sat, 18 Dec 2021 17:58:28 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB fixes for 5.16-rc6
Message-ID: <Yb4TNA/HoeI8NbTx@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 2585cf9dfaaddf00b069673f27bb3f8530e2039c:

  Linux 5.16-rc5 (2021-12-12 14:53:01 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.16-rc6

for you to fetch changes up to c4d936efa46d8ea183df16c0f3fa4423327da51d:

  Revert "usb: early: convert to readl_poll_timeout_atomic()" (2021-12-17 16:29:11 +0100)

----------------------------------------------------------------
USB fixes for 5.16-rc6

Here are a number of small USB driver fixes for reported problems for
5.16-rc6.  They include:
	- dwc2 driver fixes
	- xhci driver fixes
	- cdnsp driver fixes
	- typec driver fix
	- gadget u_ether driver fix
	- new quirk additions
	- usb gadget endpoint calculation fix
	- usb serial new device ids
	- revert of a xhci-dbg change that broke early debug booting

All changes, except for the revert, have been in linux-next with no
reported problems.  The revert was from yesterday, and it was reported
by the developers affected that it resolved their problem.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Amelie Delaunay (1):
      usb: dwc2: fix STM ID/VBUS detection startup delay in dwc2_driver_probe

Chunfeng Yun (1):
      usb: xhci-mtk: fix list_del warning when enable list debug

Daniele Palmas (1):
      USB: serial: option: add Telit FN990 compositions

Greg Kroah-Hartman (3):
      USB: gadget: bRequestType is a bitfield, not a enum
      Merge tag 'usb-serial-5.16-rc6' of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-linus
      Revert "usb: early: convert to readl_poll_timeout_atomic()"

Jimmy Wang (1):
      USB: NO_LPM quirk Lenovo USB-C to Ethernet Adapher(RTL8153-04)

Johan Hovold (1):
      USB: serial: cp210x: fix CP2105 GPIO registration

Marian Postevca (1):
      usb: gadget: u_ether: fix race in setting MAC address in setup phase

Nehal Bakulchandra Shah (1):
      usb: xhci: Extend support for runtime power management for AMD's Yellow carp.

Pawel Laszczak (4):
      usb: cdnsp: Fix incorrect calling of cdnsp_died function
      usb: cdnsp: Fix issue in cdnsp_log_ep trace event
      usb: cdnsp: Fix incorrect status for control request
      usb: cdnsp: Fix lack of spin_lock_irqsave/spin_lock_restore

Xu Yang (1):
      usb: typec: tcpm: fix tcpm unregister port but leave a pending timer

 drivers/usb/cdns3/cdnsp-gadget.c      | 12 ++++++++++++
 drivers/usb/cdns3/cdnsp-ring.c        | 11 ++++++++++-
 drivers/usb/cdns3/cdnsp-trace.h       |  4 ++--
 drivers/usb/core/quirks.c             |  3 +++
 drivers/usb/dwc2/platform.c           |  3 +++
 drivers/usb/early/xhci-dbc.c          | 15 +++++++++++----
 drivers/usb/gadget/composite.c        |  6 +++---
 drivers/usb/gadget/function/u_ether.c | 16 ++++++----------
 drivers/usb/gadget/legacy/dbgp.c      |  6 +++---
 drivers/usb/gadget/legacy/inode.c     |  6 +++---
 drivers/usb/host/xhci-mtk-sch.c       |  2 +-
 drivers/usb/host/xhci-pci.c           |  6 +++++-
 drivers/usb/serial/cp210x.c           |  6 ++++--
 drivers/usb/serial/option.c           |  8 ++++++++
 drivers/usb/typec/tcpm/tcpm.c         | 18 +++++++++++++-----
 15 files changed, 87 insertions(+), 35 deletions(-)

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED1EF471A93
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 15:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbhLLOLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 09:11:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbhLLOLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 09:11:32 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E0CC061714;
        Sun, 12 Dec 2021 06:11:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D04CDCE0B6B;
        Sun, 12 Dec 2021 14:11:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70364C341CA;
        Sun, 12 Dec 2021 14:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1639318289;
        bh=1YaANl1M0R+YI0xtg229PcF3JisYJpSJ1L86JclSVqE=;
        h=Date:From:To:Cc:Subject:From;
        b=pmISb5crcGCIJKo/Y5/OAo7GqwfmBtD+EOmGnCr+cwSPMzxlWfJdbxZEg1Wm7ipie
         7KJcy76eq8k51YfTpvXjnhU5EHDWiBJTetRkWgg7WYxcw7mMXvqNN60kMagPjhv/cw
         Qks5+FgQ31Xe6J3CupXikHjwcfTopFvrPd2CiaZU=
Date:   Sun, 12 Dec 2021 15:11:26 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB fixes for 5.16-rc5
Message-ID: <YbYDDrBFYegNGQ7m@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 0fcfb00b28c0b7884635dacf38e46d60bf3d4eb1:

  Linux 5.16-rc4 (2021-12-05 14:08:22 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.16-rc5

for you to fetch changes up to ca5737396927afd4d57b133fd2874bbcf3421cdb:

  usb: core: config: using bit mask instead of individual bits (2021-12-12 13:06:39 +0100)

----------------------------------------------------------------
USB fixes for 5.16-rc5

Here are some small USB fixes for 5.16-rc5.  They include:
	- gadget driver fixes for reported issues
	- xhci fixes for reported problems.
	- config endpoint parsing fixes for where we got bitfields wrong

Most of these have been in linux-next, the remaining few were not, but
got lots of local testing in my systems and in some cloud testing
infrastructures.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Douglas Anderson (1):
      Revert "usb: dwc3: dwc3-qcom: Enable tx-fifo-resize property by default"

Greg Kroah-Hartman (2):
      USB: gadget: detect too-big endpoint 0 requests
      USB: gadget: zero allocate endpoint 0 buffers

Kai-Heng Feng (1):
      xhci: Remove CONFIG_USB_DEFAULT_PERSIST to prevent xHCI from runtime suspending

Mathias Nyman (1):
      xhci: avoid race between disable slot command and host runtime suspend

Pavel Hofman (2):
      usb: core: config: fix validation of wMaxPacketValue entries
      usb: core: config: using bit mask instead of individual bits

 drivers/usb/core/config.c         |  6 +++---
 drivers/usb/dwc3/dwc3-qcom.c      | 15 ---------------
 drivers/usb/gadget/composite.c    | 14 +++++++++++++-
 drivers/usb/gadget/legacy/dbgp.c  | 15 ++++++++++++++-
 drivers/usb/gadget/legacy/inode.c | 16 +++++++++++++++-
 drivers/usb/host/xhci-hub.c       |  1 +
 drivers/usb/host/xhci-ring.c      |  1 -
 drivers/usb/host/xhci.c           | 26 +++++++++++++++-----------
 8 files changed, 61 insertions(+), 33 deletions(-)

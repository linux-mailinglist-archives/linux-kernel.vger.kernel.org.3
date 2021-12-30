Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15D4D481E5D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 17:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241389AbhL3Qw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 11:52:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235870AbhL3Qw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 11:52:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91EEBC061574;
        Thu, 30 Dec 2021 08:52:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D87D61712;
        Thu, 30 Dec 2021 16:52:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF073C36AE9;
        Thu, 30 Dec 2021 16:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640883144;
        bh=o/Yzw84CMO1RRStlTxHpA82o1M7bIJG1uP0eVld3PP8=;
        h=Date:From:To:Cc:Subject:From;
        b=yHx/sGcC7dyTUsNg5yxHamebPKE7vcn33z4D1bOnp1hx0wVu5vFzUlm1ugFba0Nw9
         BAyUFpU+KKTiUMIggI/CgiEZvNGQqSnxD42rnmWEqiwZRMwIxsT3DMPiiHo4cr7fDV
         0sZd10Z0dpTnvyFnYL6N2XGa2Na+2tCg3FqgQesc=
Date:   Thu, 30 Dec 2021 17:52:21 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB fixes for 5.16-final
Message-ID: <Yc3jxXB0JoKOrxb9@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit a7904a538933c525096ca2ccde1e60d0ee62c08e:

  Linux 5.16-rc6 (2021-12-19 14:14:33 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.16

for you to fetch changes up to 3f345e907a8e7c56fdebf7231cd67afc85d02aaa:

  usb: typec: ucsi: Only check the contract if there is a connection (2021-12-21 16:30:53 +0100)

----------------------------------------------------------------
USB fixes for 5.16-final

Here are some small USB driver fixes for 5.16 to resolve some reported
problems:
	- mtu3 driver fixes
	- typec ucsi driver fix
	- xhci driver quirk added
	- usb gadget f_fs fix for reported crash

All of these have been in linux-next for a while with no reported
problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Chunfeng Yun (4):
      usb: mtu3: fix interval value for intr and isoc
      usb: mtu3: add memory barrier before set GPD's HWO
      usb: mtu3: fix list_head check warning
      usb: mtu3: set interval of FS intr and isoc endpoint

Heikki Krogerus (1):
      usb: typec: ucsi: Only check the contract if there is a connection

Mathias Nyman (1):
      xhci: Fresco FL1100 controller should not have BROKEN_MSI quirk set.

Vincent Pelletier (1):
      usb: gadget: f_fs: Clear ffs_eventfd in ffs_data_clear.

 drivers/usb/gadget/function/f_fs.c |  9 ++++++---
 drivers/usb/host/xhci-pci.c        |  5 ++++-
 drivers/usb/mtu3/mtu3_gadget.c     | 12 ++++++++++--
 drivers/usb/mtu3/mtu3_qmu.c        |  7 ++++++-
 drivers/usb/typec/ucsi/ucsi.c      |  4 +++-
 5 files changed, 29 insertions(+), 8 deletions(-)

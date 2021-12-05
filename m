Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A89B468AB1
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 13:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233572AbhLEMIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 07:08:51 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:55048 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233481AbhLEMIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 07:08:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AD3F1B80E1B;
        Sun,  5 Dec 2021 12:05:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC48AC341C1;
        Sun,  5 Dec 2021 12:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638705920;
        bh=2M5VDeecT6Sa6kwQ1njt2PR51joDLkpEq/aVUU8aVBU=;
        h=Date:From:To:Cc:Subject:From;
        b=xr+2Yj82pMsK6kba58HNmEyO/Asy4151XNwFIYFZN8M1WixcSsM1RmAGfFCnDf8YP
         Woo0ri215UOIs/2/ugvc+Ea/IOQmgj396uDQ+iGtTmJlC2rvLAmVC6itL6CV4GthPf
         6no6/r1lxNct+xiNi0fXRx711zvkabVaR+V8uphU=
Date:   Sun, 5 Dec 2021 13:05:17 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB fixes for 5.16-rc4
Message-ID: <Yayq/Xdb/pHSS7/l@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit d58071a8a76d779eedab38033ae4c821c30295a5:

  Linux 5.16-rc3 (2021-11-28 14:09:19 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.16-rc4

for you to fetch changes up to 37307f7020ab38dde0892a578249bf63d00bca64:

  usb: cdnsp: Fix a NULL pointer dereference in cdnsp_endpoint_init() (2021-12-03 13:57:45 +0100)

----------------------------------------------------------------
USB fixes for 5.16-rc4

Here are some small USB fixes for a few reported issues.  Included in
here are:
	- xhci fix for a _much_ reported regression.  I don't think
	  there's a community distro that has not reported this problem
	  yet :(
	- new USB quirk addition
	- cdns3 minor fixes
	- typec regression fix.

All of these have been in linux-next with no reported problems, and the
xhci fix has been reported by many to resolve their reported problem.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Badhri Jagan Sridharan (1):
      usb: typec: tcpm: Wait in SNK_DEBOUNCED until disconnect

Frank Li (1):
      usb: cdns3: gadget: fix new urb never complete if ep cancel previous requests

Mathias Nyman (1):
      xhci: Fix commad ring abort, write all 64 bits to CRCR register.

Ole Ernst (1):
      USB: NO_LPM quirk Lenovo Powered USB-C Travel Hub

Zhou Qingyang (1):
      usb: cdnsp: Fix a NULL pointer dereference in cdnsp_endpoint_init()

 drivers/usb/cdns3/cdns3-gadget.c | 20 ++++----------------
 drivers/usb/cdns3/cdnsp-mem.c    |  3 +++
 drivers/usb/core/quirks.c        |  3 +++
 drivers/usb/host/xhci-ring.c     | 21 ++++++++++++++-------
 drivers/usb/typec/tcpm/tcpm.c    |  4 ----
 5 files changed, 24 insertions(+), 27 deletions(-)

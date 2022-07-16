Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB1E576C2C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 08:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbiGPGYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 02:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbiGPGYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 02:24:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13F912AF5;
        Fri, 15 Jul 2022 23:24:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 538F5B82F5B;
        Sat, 16 Jul 2022 06:24:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62985C34114;
        Sat, 16 Jul 2022 06:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657952665;
        bh=AkmbZ57L8DAjMKN8cVHc0da89FpXYgpW0mPMHQg5OMI=;
        h=Date:From:To:Cc:Subject:From;
        b=wsXKBF9zduaYzJLdTzRCEY8H6DlBD/Bt2TAis1ZmhogzALzTWLU6ZDHDiPqFLmiOF
         zr3lmeWHM5Aut37dm9PIZHHbEIb74XXV+JaDX8WM8WDHvLQb3xZHDr+jW5BLV1/Hx2
         cAEiPaeCpj9oFu7GGFowVPM3lbKD88ptdSTK14kc=
Date:   Sat, 16 Jul 2022 08:24:20 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB driver fixes for 5.19-rc7
Message-ID: <YtJZlE1lf8EdUYRM@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 32346491ddf24599decca06190ebca03ff9de7f8:

  Linux 5.19-rc6 (2022-07-10 14:40:51 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.19-rc7

for you to fetch changes up to 3486af89dd3c0b0bef194c4bccf17c31ef16b99f:

  Merge tag 'usb-serial-5.19-rc7' of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-linus (2022-07-14 16:22:12 +0200)

----------------------------------------------------------------
USB driver fixes for 5.19-rc7

Here are some small USB driver fixes and new device ids for 5.19-rc7.
They include:
	- new usb-serial driver ids
	- typec uevent fix
	- uvc gadget driver fix
	- dwc3 driver fixes
	- ehci-fsl driver fix

Note, I had to merge in 5.19-rc6 into this branch in order to do a clean
merge with the usb-serial fixes tree as they were based on that tag of
yours.

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Darren Stevens (1):
      drivers/usb/host/ehci-fsl: Fix interrupt setup in host mode.

Greg Kroah-Hartman (2):
      Merge tag 'v5.19-rc6' into usb-linus
      Merge tag 'usb-serial-5.19-rc7' of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-linus

Linyu Yuan (1):
      usb: typec: add missing uevent when partner support PD

Lucien Buchmann (1):
      USB: serial: ftdi_sio: add Belimo device ids

Michael Grzeschik (1):
      usb: gadget: uvc: fix changing interface name via configfs

Thinh Nguyen (1):
      usb: dwc3: gadget: Fix event pending check

Yang Yingliang (1):
      usb: dwc3-am62: remove unnecesary clk_put()

 drivers/usb/dwc3/dwc3-am62.c               |  8 ++------
 drivers/usb/dwc3/gadget.c                  |  4 +++-
 drivers/usb/gadget/function/uvc_configfs.c |  6 ++++--
 drivers/usb/host/ehci-fsl.c                | 11 +++--------
 drivers/usb/host/fsl-mph-dr-of.c           |  3 +++
 drivers/usb/serial/ftdi_sio.c              |  3 +++
 drivers/usb/serial/ftdi_sio_ids.h          |  6 ++++++
 drivers/usb/typec/class.c                  |  1 +
 8 files changed, 25 insertions(+), 17 deletions(-)

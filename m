Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3BBA4B3439
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 11:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233480AbiBLKab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 05:30:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbiBLKaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 05:30:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50AE02611C;
        Sat, 12 Feb 2022 02:30:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E657660B6A;
        Sat, 12 Feb 2022 10:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4129C340E7;
        Sat, 12 Feb 2022 10:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644661826;
        bh=Li/ATbW+lmxvZ/cSftvODxa3jlx5aR8zqID/6gfHd1A=;
        h=Date:From:To:Cc:Subject:From;
        b=teSGSFa9Ho5OPPRwZTTiOPku8bTRBs1BshwPir9DGkd1lI4xGs9kpQqbxcmWNxsPv
         O58h1eXXlAt9wfZ56ruKZutfBX8smrKmn1ca/rC+7HD3+fYbMmHCoSPnipCjTPmQJp
         V/At+H2UOUSIaSvzaCQIe823KC7vx4gE65cKUOfk=
Date:   Sat, 12 Feb 2022 11:30:23 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB fixes for 5.17-rc4
Message-ID: <YgeMP/kEFRI1Aq6T@kroah.com>
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

The following changes since commit 26291c54e111ff6ba87a164d85d4a4e134b7315c:

  Linux 5.17-rc2 (2022-01-30 15:37:07 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.17-rc4

for you to fetch changes up to 736e8d89044c1c330967fb938fa766cd9e0d8af0:

  Revert "usb: dwc2: drd: fix soft connect when gadget is unconfigured" (2022-02-12 10:08:54 +0100)

----------------------------------------------------------------
USB fixes for 5.17-rc4

Here are some small USB driver fixes for 5.17-rc4 that resolve some
reported issues and add new device ids:
	- usb-serial new device ids
	- ulpi cleanup fixes
	- f_fs use-after-free fix
	- dwc3 driver fixes
	- ax88179_178a usb network driver fix
	- usb gadget fixes

There is a revert at the end of this series to resolve a build problem
that 0-day found yesterday.  Most of these have been in linux-next,
except for the last few, and all have now passed 0-day tests.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Adam Ford (1):
      usb: gadget: udc: renesas_usb3: Fix host to USB_ROLE_NONE transition

Cameron Williams (1):
      USB: serial: ftdi_sio: add support for Brainboxes US-159/235/320

Fabio M. De Francesco (1):
      usb: core: Unregister device on component_add() failure

Fabrice Gasnier (1):
      usb: dwc2: drd: fix soft connect when gadget is unconfigured

Greg Kroah-Hartman (3):
      usb: gadget: rndis: check size of RNDIS_MSG_SET command
      Merge tag 'usb-serial-5.17-rc4' of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-linus
      Revert "usb: dwc2: drd: fix soft connect when gadget is unconfigured"

Jann Horn (2):
      usb: raw-gadget: fix handling of dual-direction-capable endpoints
      net: usb: ax88179_178a: Fix out-of-bounds accesses in RX fixup

Johan Hovold (2):
      USB: serial: cp210x: add NCR Retail IO box id
      USB: serial: cp210x: add CPI Bulk Coin Recycler id

Pavel Hofman (1):
      usb: gadget: f_uac2: Define specific wTerminalType

Pawel Dembicki (1):
      USB: serial: option: add ZTE MF286D modem

Robert Hancock (1):
      usb: dwc3: xilinx: fix uninitialized return value

Sean Anderson (2):
      usb: ulpi: Move of_node_put to ulpi_dev_release
      usb: ulpi: Call of_node_put correctly

Stephan Brunner (1):
      USB: serial: ch341: add support for GW Instek USB2.0-Serial devices

Szymon Heidrich (1):
      USB: gadget: validate interface OS descriptor requests

Tommaso Merciai (1):
      usb: usb251xb: add boost-up property support

Udipto Goswami (2):
      usb: f_fs: Fix use-after-free for epfile
      usb: dwc3: gadget: Prevent core from processing stale TRBs

 drivers/net/usb/ax88179_178a.c         | 68 +++++++++++++++++++---------------
 drivers/usb/common/ulpi.c              | 10 +++--
 drivers/usb/core/port.c                |  9 +++--
 drivers/usb/dwc3/dwc3-xilinx.c         |  2 +-
 drivers/usb/dwc3/gadget.c              | 13 +++++++
 drivers/usb/gadget/composite.c         |  3 ++
 drivers/usb/gadget/function/f_fs.c     | 56 +++++++++++++++++++++-------
 drivers/usb/gadget/function/f_uac2.c   |  4 +-
 drivers/usb/gadget/function/rndis.c    |  9 +++--
 drivers/usb/gadget/legacy/raw_gadget.c |  2 +-
 drivers/usb/gadget/udc/renesas_usb3.c  |  2 +
 drivers/usb/misc/usb251xb.c            |  4 +-
 drivers/usb/serial/ch341.c             |  1 +
 drivers/usb/serial/cp210x.c            |  2 +
 drivers/usb/serial/ftdi_sio.c          |  3 ++
 drivers/usb/serial/ftdi_sio_ids.h      |  3 ++
 drivers/usb/serial/option.c            |  2 +
 17 files changed, 136 insertions(+), 57 deletions(-)

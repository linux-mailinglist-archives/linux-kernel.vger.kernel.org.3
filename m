Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 614D1515EEB
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 17:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359711AbiD3P4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 11:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358945AbiD3P4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 11:56:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A597C527ED;
        Sat, 30 Apr 2022 08:53:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5799FB803F7;
        Sat, 30 Apr 2022 15:53:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD042C385AA;
        Sat, 30 Apr 2022 15:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651333989;
        bh=h/T/UY34Ovs/LcnMrzIJ46hd3lr/K5vQaUAvXYDDAMo=;
        h=Date:From:To:Cc:Subject:From;
        b=cozFTpUZLzmZyeyH8hEdGID1hhBBK/wyT+/gi+VTDkxT90ayYXB4nV5JDxhEuoefD
         +59jywqqPBmITKPCyGHZ3c+8y9IqkBh4G15sJQza/SV1yco42s9r0XYy+wh138vb2X
         ARL2FqA+CHSVZVX0Hw1ZMrS7Y6vnPoPxNYABIZSI=
Date:   Sat, 30 Apr 2022 17:53:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial driver fixes for 5.18-rc5
Message-ID: <Ym1bYgkmZYmrF6x5@kroah.com>
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

The following changes since commit ce522ba9ef7e2d9fb22a39eb3371c0c64e2a433e:

  Linux 5.18-rc2 (2022-04-10 14:21:36 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.18-rc5

for you to fetch changes up to 19317433057dc1f2ca9a975e4e6b547282c2a5ef:

  tty: n_gsm: fix sometimes uninitialized warning in gsm_dlci_modem_output() (2022-04-26 08:09:46 +0200)

----------------------------------------------------------------
TTY/Serial fixes for 5.18-rc5

Here are some small serial driver fixes, and a larger number of GSM line
discipline fixes for 5.18-rc5.

These include:
	- lots of tiny n_gsm fixes for issues to resolve a number of
	  reported problems.  Seems that people are starting to actually
	  use this code again.
	- 8250 driver fixes for some devices
	- imx serial driver fix
	- amba-pl011 driver fix

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Daniel Starke (21):
      tty: n_gsm: fix missing mux reset on config change at responder
      tty: n_gsm: fix restart handling via CLD command
      tty: n_gsm: fix decoupled mux resource
      tty: n_gsm: fix mux cleanup after unregister tty device
      tty: n_gsm: fix wrong signal octet encoding in convergence layer type 2
      tty: n_gsm: fix frame reception handling
      tty: n_gsm: fix malformed counter for out of frame data
      tty: n_gsm: fix insufficient txframe size
      tty: n_gsm: fix wrong DLCI release order
      tty: n_gsm: fix missing explicit ldisc flush
      tty: n_gsm: fix wrong command retry handling
      tty: n_gsm: fix wrong command frame length field encoding
      tty: n_gsm: fix wrong signal octets encoding in MSC
      tty: n_gsm: fix missing tty wakeup in convergence layer type 2
      tty: n_gsm: fix reset fifo race condition
      tty: n_gsm: fix incorrect UA handling
      tty: n_gsm: fix missing update of modem controls after DLCI open
      tty: n_gsm: fix broken virtual tty handling
      tty: n_gsm: fix invalid use of MSC in advanced option
      tty: n_gsm: fix software flow control handling
      tty: n_gsm: fix sometimes uninitialized warning in gsm_dlci_modem_output()

Hui Wang (1):
      Revert "serial: sc16is7xx: Clear RS485 bits in the shutdown"

Johan Hovold (1):
      serial: imx: fix overrun interrupts in DMA mode

Lino Sanfilippo (1):
      serial: amba-pl011: do not time out prematurely when draining tx fifo

Maciej W. Rozycki (2):
      serial: 8250: Also set sticky MCR bits in console restoration
      serial: 8250: Correct the clock for EndRun PTP/1588 PCIe device

Tony Lindgren (1):
      serial: 8250: Fix runtime PM for start_tx() for empty buffer

 drivers/tty/n_gsm.c                 | 477 +++++++++++++++++++++---------------
 drivers/tty/serial/8250/8250_pci.c  |   8 +-
 drivers/tty/serial/8250/8250_port.c |   6 +-
 drivers/tty/serial/amba-pl011.c     |   9 +-
 drivers/tty/serial/imx.c            |   2 +-
 drivers/tty/serial/sc16is7xx.c      |   6 +-
 6 files changed, 293 insertions(+), 215 deletions(-)

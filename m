Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B66FD4A2FB0
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 14:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349531AbiA2NL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 08:11:57 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:46806 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239739AbiA2NLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 08:11:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C38D60C75;
        Sat, 29 Jan 2022 13:11:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91298C340E5;
        Sat, 29 Jan 2022 13:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643461914;
        bh=pVMrF2W04FDCluw+LRWB6W2yETOEVIUjr7cu3PrFO7E=;
        h=Date:From:To:Cc:Subject:From;
        b=2FpmpiS+8t7JZJK2zR7Zegd52OVWpbCfZSUaOQ40UKAMMHWFTREICf/L1lKVvqNp1
         K9dGywyQmkM/KBouM+OfoetNdUF5idZ/RPa/3lHdsrsX5VcdRNgdWZi1yeda8otiEZ
         l77D8VP60sv6UaD06377qznv+dSB3HlyrCUQxgPY=
Date:   Sat, 29 Jan 2022 14:11:51 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial driver fixes for 5.17-rc2
Message-ID: <YfU9F+OwlK+Rso3T@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.17-rc2

for you to fetch changes up to d1ad2721b1eb05d54e81393a7ebc332d4a35c68f:

  kbuild: remove include/linux/cyclades.h from header file check (2022-01-27 08:51:08 +0100)

----------------------------------------------------------------
TTY/Serial driver fixes for 5.17-rc2

Here are some small bug fixes and reverts for reported problems with the
tty core and drivers.  They include:
	- revert the fifo use for the 8250 console mode.  It caused too
	  many regressions and problems, and had a bug in it as well.
	  This is being reworked and should show up in a later -rc1
	  release, but it's not ready for 5.17
	- rpmsg tty race fix
	- restore the cyclades.h uapi header file.  Turns out a compiler
	  test suite used it for some unknown reason.  Bring it back
	  just for the parts that are used by the builder test so they
	  continue to build.  No functionality is restored as no one
	  actually has this hardware anymore, nor is it really tested.
	- stm32 driver fixes
	- n_gsm flow control fixes
	- pl011 driver fix
	- rs485 initialization fix

All of these have been in linux-next this week with no reported
problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Arnaud Pouliquen (1):
      tty: rpmsg: Fix race condition releasing tty port

Cameron Williams (1):
      tty: Add support for Brainboxes UC cards.

Greg Kroah-Hartman (2):
      Revert "tty: serial: Use fifo in 8250 console driver"
      kbuild: remove include/linux/cyclades.h from header file check

Jochen Mades (1):
      serial: pl011: Fix incorrect rs485 RTS polarity on set_mctrl

Lukas Wunner (1):
      serial: core: Initialize rs485 RTS polarity already on probe

Maciej W. Rozycki (1):
      tty: Partially revert the removal of the Cyclades public API

Robert Hancock (1):
      serial: 8250: of: Fix mapped region size when using reg-offset property

Valentin Caron (2):
      serial: stm32: prevent TDR register overwrite when sending x_char
      serial: stm32: fix software flow control transfer

daniel.starke@siemens.com (1):
      tty: n_gsm: fix SW flow control encoding/handling

 drivers/tty/n_gsm.c                 |   4 +-
 drivers/tty/rpmsg_tty.c             |  40 ++++++++++-----
 drivers/tty/serial/8250/8250_of.c   |  11 +++-
 drivers/tty/serial/8250/8250_pci.c  | 100 +++++++++++++++++++++++++++++++++++-
 drivers/tty/serial/8250/8250_port.c |  61 +++-------------------
 drivers/tty/serial/amba-pl011.c     |  11 +---
 drivers/tty/serial/serial_core.c    |  34 +++++-------
 drivers/tty/serial/stm32-usart.c    |  14 ++++-
 include/uapi/linux/cyclades.h       |  35 +++++++++++++
 usr/include/Makefile                |   1 +
 10 files changed, 205 insertions(+), 106 deletions(-)
 create mode 100644 include/uapi/linux/cyclades.h

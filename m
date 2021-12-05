Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C697A468AAF
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 13:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233540AbhLEMIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 07:08:18 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:49812 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233481AbhLEMIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 07:08:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC61D60FC5;
        Sun,  5 Dec 2021 12:04:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8792BC341C1;
        Sun,  5 Dec 2021 12:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638705890;
        bh=f7p5QXBOBHZzxvdGaceLzRNg7RlFFCrBhaw23iIZBro=;
        h=Date:From:To:Cc:Subject:From;
        b=aK4xzM0r6t8Ujnl2sz4jfkg60AQNvSZEgzZYEEI8TTjx1utjDGdP3A6AOG4Ie7+V/
         VeYEu+yOp+kN2owXVhIDrf1I3z0+Ke7qL4CWOmIUmtcJOdzsUWabw3K2yiJc/R4YaB
         gSZzEoio76ALbGqCMNwh3uGuG2wW3wnqpm4qI3N4=
Date:   Sun, 5 Dec 2021 13:04:46 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial driver fixes for 5.16-rc4
Message-ID: <Yayq3iB/M3SJjvXK@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 136057256686de39cc3a07c2e39ef6bc43003ff6:

  Linux 5.16-rc2 (2021-11-21 13:47:39 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.16-rc4

for you to fetch changes up to 9cabe26e65a893afd5846908aa393bd283ab6609:

  serial: 8250_bcm7271: UART errors after resuming from S2 (2021-12-03 14:14:49 +0100)

----------------------------------------------------------------
TTY/Serial fixes for 5.16-rc4

Here are some small TTY and Serial driver fixes for 5.16-rc4 to resolve
a number of reported problems.

They include:
	- liteuart serial driver fixes
	- 8250_pci serial driver fixes for pericom devices
	- 8250 RTS line control fix while in RS-485 mode
	- tegra serial driver fix
	- msm_serial driver fix
	- pl011 serial driver new id
	- fsl_lpuart revert of broken change
	- 8250_bcm7271 serial driver fix
	- MAINTAINERS file update for rpmsg tty driver that came in
	  5.16-rc1
	- vgacon fix for reported problem

All of these, except for the 8250_bcm7271 fix have been in linux-next
with no reported problem.  The 8250_bcm7271 fix was added to the tree on
Friday so no chance to be linux-next yet.  But it should be fine as the
affected developers submitted it.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Al Cooper (1):
      serial: 8250_bcm7271: UART errors after resuming from S2

Alexander Stein (1):
      Revert "tty: serial: fsl_lpuart: drop earlycon entry for i.MX8QXP"

Arnaud Pouliquen (1):
      MAINTAINERS: Add rpmsg tty driver maintainer

Ilia Sergachev (1):
      serial: liteuart: Fix NULL pointer dereference in ->remove()

Jay Dolan (2):
      serial: 8250_pci: Fix ACCES entries in pci_serial_quirks array
      serial: 8250_pci: rewrite pericom_do_set_divisor()

Johan Hovold (4):
      serial: core: fix transmit-buffer reset and memleak
      serial: liteuart: fix use-after-free and memleak on unbind
      serial: liteuart: fix minor-number leak on probe errors
      serial: liteuart: relax compile-test dependencies

Lukas Wunner (1):
      serial: 8250: Fix RTS modem control while in rs485 mode

Maciej W. Rozycki (1):
      vgacon: Propagate console boot parameters before calling `vc_resize'

Patrik John (1):
      serial: tegra: Change lower tolerance baud rate limit for tegra20 and tegra30

Pierre Gondois (1):
      serial: pl011: Add ACPI SBSA UART match id

Sven Eckelmann (1):
      tty: serial: msm_serial: Deactivate RX DMA for polling support

 MAINTAINERS                            |  6 ++++++
 drivers/tty/serial/8250/8250_bcm7271.c | 13 ++++++++++++
 drivers/tty/serial/8250/8250_pci.c     | 39 ++++++++++++++++++++++------------
 drivers/tty/serial/8250/8250_port.c    |  7 ------
 drivers/tty/serial/Kconfig             |  2 +-
 drivers/tty/serial/amba-pl011.c        |  1 +
 drivers/tty/serial/fsl_lpuart.c        |  1 +
 drivers/tty/serial/liteuart.c          | 20 ++++++++++++++---
 drivers/tty/serial/msm_serial.c        |  3 +++
 drivers/tty/serial/serial-tegra.c      |  4 ++--
 drivers/tty/serial/serial_core.c       | 18 +++++++++++++++-
 drivers/video/console/vgacon.c         | 14 +++++++-----
 12 files changed, 95 insertions(+), 33 deletions(-)

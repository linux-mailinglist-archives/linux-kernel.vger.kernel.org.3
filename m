Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61A8C48C54D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 14:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353818AbiALN42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 08:56:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353790AbiALN4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 08:56:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EECEC061748;
        Wed, 12 Jan 2022 05:56:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E06561988;
        Wed, 12 Jan 2022 13:56:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0CB3C36AEA;
        Wed, 12 Jan 2022 13:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641995777;
        bh=Jh2sdZHXZxFs3QySakLm/p5Q99AdhyOjRAQrLG8ICsQ=;
        h=Date:From:To:Cc:Subject:From;
        b=xRZCsyELSOtAv7eXSERWkAAFVVu5DNtpQq/xxRjrAuWPxUJ4lbJlA+0JOGM7XkfuP
         zPTAfWajQ3AsP5EfE5XOYFakFIy9jB9216I6wIr5Giwtv2hSIgFDnQevWLneQ4pdK+
         OlYX5XY1Btar5FEHhmU9zYneOQDH0mWe4sE2qe2s=
Date:   Wed, 12 Jan 2022 14:56:14 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial driver changes for 5.17-rc1
Message-ID: <Yd7d/lD76eYkCjul@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit a7904a538933c525096ca2ccde1e60d0ee62c08e:

  Linux 5.16-rc6 (2021-12-19 14:14:33 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.17-rc1

for you to fetch changes up to 93a770b7e16772530196674ffc79bb13fa927dc6:

  serial: core: Keep mctrl register state and cached copy in sync (2022-01-06 16:01:48 +0100)

----------------------------------------------------------------
TTY/Serial driver updates for 5.17-rc1

Here is the big set of tty/serial driver updates for 5.17-rc1.

Nothing major in here, just lots of good updates and fixes, including:
	- more tty core cleanups from Jiri as well as mxser driver
	  cleanups.  This is the majority of the core diffstat
	- tty documentation updates from Jiri
	- platform_get_irq() updates
	- various serial driver updates for new features and hardware
	- fifo usage for 8250 console, reducing cpu load a lot
	- LED fix for keyboards, long-time bugfix that went through many
	  revisions
	- minor cleanups

All have been in linux-next for a while with no reported problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Abel Vesa (1):
      dt-bindings: serial: fsl-lpuart: Fix i.MX 8QM compatible matching

Alyssa Ross (1):
      serial: liteuart: fix MODULE_ALIAS

Andy Shevchenko (3):
      serial: 8250_pci: Split out Pericom driver
      serial: 8250_pericom: Use serial_dl_write() instead of open coded
      tty: tty_io: Switch to vmalloc() fallback in case of TTY_NO_WRITE_SPLIT

Biju Das (2):
      dt-bindings: serial: renesas,scif: Document RZ/V2L SoC
      dt-bindings: serial: renesas,sci: Document RZ/V2L SoC

Cai Huoqing (1):
      tty: mips_ejtag_fdc: Make use of the helper function kthread_run_on_cpu()

Colin Ian King (1):
      serial: 8250_pci: remove redundant assignment to tmp after the mask operation

Emil Renner Berthing (1):
      serial: 8250_dw: Add StarFive JH7100 quirk

Fugang Duan (2):
      tty: serial: imx: clear the RTSD status before enable the RTSD irq
      tty: serial: imx: disable UCR4_OREN in .stop_rx() instead of .shutdown()

Geert Uytterhoeven (3):
      serial: sh-sci: Drop support for "sci_ick" clock
      serial: sh-sci: Use dev_err_probe()
      serial: sh-sci: Use devm_clk_get_optional()

Greg Kroah-Hartman (3):
      Merge 5.16-rc4 into tty-next
      Merge 5.16-rc6 into tty-next
      Revert "serdev: BREAK/FRAME/PARITY/OVERRUN notification prototype V2"

Jacky Bai (1):
      dt-bindings: serial: fsl-lpuart: Add imx8ulp compatible string

Jay Dolan (1):
      serial: 8250_pericom: Re-enable higher baud rates

Jesse Taube (2):
      dt-bindings: serial: fsl-lpuart: add i.MXRT1050 compatible
      tty: serial: fsl_lpuart: Add i.MXRT1050 support

Jing Yao (1):
      serial: 8250: replace snprintf in show functions with sysfs_emit

Jiri Slaby (51):
      n_gsm: remove unused parameters from gsm_error()
      tty: remove TTY_SOFT_SAK part from __do_SAK()
      tty: remove tty NULL check from __do_SAK()
      tty: clean up whitespace in __do_SAK()
      tty: serial, join uport checks in uart_port_shutdown()
      mxser: remove wait for sent from mxser_close_port
      mxser: rename mxser_close_port() to mxser_stop_rx()
      mxser: keep only !tty test in ISR
      mxser: move MSR read to mxser_check_modem_status()
      mxser: clean up tx handling in mxser_transmit_chars()
      mxser: remove pointless xmit_buf checks
      mxser: remove tty->driver_data NULL check
      mxser: call stop_rx from mxser_shutdown_port()
      mxser: don't flush buffer from mxser_close() directly
      mxser: use tty_port_close() in mxser_close()
      mxser: extract TX empty check from mxser_wait_until_sent()
      mxser: use msleep_interruptible() in mxser_wait_until_sent()
      mxser: clean up timeout handling in mxser_wait_until_sent()
      mxser: don't throttle manually
      mxser: remove tty parameter from mxser_receive_chars_new()
      mxser: increase buf_overrun if tty_insert_flip_char() fails
      mxser: add MOXA prefix to some PCI device IDs
      mxser: move ids from pci_ids.h here
      mxser: use PCI_DEVICE_DATA
      tty: drivers/tty/, stop using tty_schedule_flip()
      tty: the rest, stop using tty_schedule_flip()
      tty: drop tty_schedule_flip()
      tty: remove file from tty_ldisc_ops::ioctl and compat_ioctl
      tty: finish kernel-doc of tty_struct members
      tty: add kernel-doc for tty_port
      tty: add kernel-doc for tty_driver
      tty: add kernel-doc for tty_operations
      tty: add kernel-doc for tty_port_operations
      tty: add kernel-doc for tty_ldisc_ops
      tty: combine tty_operations triple docs into kernel-doc
      tty: combine tty_ldisc_ops docs into kernel-doc
      tty: reformat tty_struct::flags into kernel-doc
      tty: reformat TTY_DRIVER_ flags into kernel-doc
      tty: reformat kernel-doc in tty_port.c
      tty: reformat kernel-doc in tty_io.c
      tty: reformat kernel-doc in tty_ldisc.c
      tty: reformat kernel-doc in tty_buffer.c
      tty: fix kernel-doc in n_tty.c
      tty: reformat kernel-doc in n_tty.c
      tty: add kernel-doc for more tty_driver functions
      tty: add kernel-doc for more tty_port functions
      tty: move tty_ldisc docs to new Documentation/tty/
      tty: make tty_ldisc docs up-to-date
      tty: more kernel-doc for tty_ldisc
      tty: add kernel-doc for tty_standard_install
      Documentation: add TTY chapter

Lad Prabhakar (15):
      dt-bindings: serial: renesas,scif: Make resets as a required property
      dt-bindings: serial: renesas,sci: Document RZ/G2L SoC
      serial: sh-sci: Add support to deassert/assert reset line
      serial: altera: Use platform_get_irq_optional() to get the interrupt
      serial: 8250_bcm7271: Use platform_get_irq() to get the interrupt
      serial: 8250_bcm7271: Propagate error codes from brcmuart_probe()
      serial: meson: Use platform_get_irq() to get the interrupt
      serial: pxa: Use platform_get_irq() to get the interrupt
      serial: altera_jtaguart: Use platform_get_irq_optional() to get the interrupt
      serial: vt8500: Use platform_get_irq() to get the interrupt
      serial: ar933x: Use platform_get_irq() to get the interrupt
      serial: bcm63xx: Use platform_get_irq() to get the interrupt
      serial: pmac_zilog: Use platform_get_irq() to get the interrupt
      tty: goldfish: Use platform_get_irq() to get the interrupt
      serial: 8250_bcm7271: Fix return error code in case of dma_alloc_coherent() failure

Lino Sanfilippo (1):
      serial: amba-pl011: do not request memory region twice

Lizhi Hou (1):
      tty: serial: uartlite: allow 64 bit address

Lukas Bulwahn (1):
      arm: remove zte zx platform left-over

Lukas Wunner (6):
      serial: Fix incorrect rs485 polarity on uart open
      serial: 8250: Move Alpha-specific quirk out of the core
      serial: pl010: Drop CR register reset on set_termios
      serial: pl011: Drop CR register reset on set_termios
      serial: pl011: Drop redundant DTR/RTS preservation on close/open
      serial: core: Keep mctrl register state and cached copy in sync

Magnus Damm (2):
      serial: sh-sci: Remove BREAK/FRAME/PARITY/OVERRUN printouts
      serdev: BREAK/FRAME/PARITY/OVERRUN notification prototype V2

Muhammad Usama Anjum (1):
      serial: lantiq: store and compare return status correctly

Rob Herring (2):
      serial: lantiq: Use platform_get_irq() to get the interrupt
      serial: atmel: Use platform_get_irq() to get the interrupt

Sam Protsenko (3):
      tty: serial: samsung: Remove USI initialization
      tty: serial: samsung: Enable console as module
      tty: serial: samsung: Fix console registration from module

Sherry Sun (1):
      tty: serial: fsl_lpuart: add timeout for wait_event_interruptible in .shutdown()

Tudor Ambarus (2):
      tty: serial: atmel: Check return code of dmaengine_submit()
      tty: serial: atmel: Call dma_async_issue_pending()

Valentin Caron (4):
      serial: stm32: move tx dma terminate DMA to shutdown
      serial: stm32: rework TX DMA state condition
      serial: stm32: fix flow control transfer in DMA mode
      serial: stm32: correct loop for dma error handling

Wander Lairson Costa (1):
      tty: serial: Use fifo in 8250 console driver

Xiang wangx (1):
      tty/ldsem: Fix syntax errors in comments

Xianwei Zhao (1):
      dt-bindings: serial: amlogic, meson-uart: support S4

Yanteng Si (1):
      docs/driver-api: Replace a comma in the n_gsm.rst with a double colon

Yoshihiro Shimoda (2):
      dt-bindings: serial: renesas,scif: Document r8a779f0 bindings
      tty: serial: sh-sci: Add support for R-Car Gen4

Yu Tu (1):
      tty: serial: meson: Drop the legacy compatible strings and clock code

lianzhi chang (1):
      tty: Fix the keyboard led light display problem

 .../bindings/serial/amlogic,meson-uart.yaml        |   2 +
 .../devicetree/bindings/serial/fsl-lpuart.yaml     |   8 +-
 .../devicetree/bindings/serial/renesas,sci.yaml    |  48 +-
 .../devicetree/bindings/serial/renesas,scif.yaml   |  15 +
 Documentation/driver-api/serial/index.rst          |   1 -
 Documentation/driver-api/serial/n_gsm.rst          |   8 +-
 Documentation/driver-api/serial/tty.rst            | 328 --------
 Documentation/index.rst                            |   1 +
 Documentation/tty/index.rst                        |  63 ++
 Documentation/tty/n_tty.rst                        |  22 +
 Documentation/tty/tty_buffer.rst                   |  46 +
 Documentation/tty/tty_driver.rst                   | 128 +++
 Documentation/tty/tty_internals.rst                |  31 +
 Documentation/tty/tty_ldisc.rst                    |  85 ++
 Documentation/tty/tty_port.rst                     |  70 ++
 Documentation/tty/tty_struct.rst                   |  81 ++
 arch/alpha/kernel/srmcons.c                        |   2 +-
 arch/arm/include/debug/pl01x.S                     |   7 -
 drivers/accessibility/speakup/spk_ttyio.c          |   4 +-
 drivers/bluetooth/hci_ldisc.c                      |   5 +-
 drivers/input/serio/serport.c                      |   5 +-
 drivers/net/can/slcan.c                            |   4 +-
 drivers/net/hamradio/6pack.c                       |   4 +-
 drivers/net/hamradio/mkiss.c                       |   4 +-
 drivers/net/ppp/ppp_async.c                        |   3 +-
 drivers/net/ppp/ppp_synctty.c                      |   3 +-
 drivers/net/slip/slip.c                            |   4 +-
 drivers/s390/char/keyboard.h                       |   4 +-
 drivers/tty/goldfish.c                             |  12 +-
 drivers/tty/mips_ejtag_fdc.c                       |  22 +-
 drivers/tty/moxa.c                                 |   4 +-
 drivers/tty/mxser.c                                | 306 +++----
 drivers/tty/n_gsm.c                                |  11 +-
 drivers/tty/n_hdlc.c                               |   5 +-
 drivers/tty/n_tty.c                                | 692 ++++++++--------
 drivers/tty/serial/8250/8250.h                     |  12 +-
 drivers/tty/serial/8250/8250_alpha.c               |  21 +
 drivers/tty/serial/8250/8250_bcm7271.c             |  23 +-
 drivers/tty/serial/8250/8250_core.c                |   9 +-
 drivers/tty/serial/8250/8250_dw.c                  |   3 +
 drivers/tty/serial/8250/8250_pci.c                 | 407 +--------
 drivers/tty/serial/8250/8250_pericom.c             | 214 +++++
 drivers/tty/serial/8250/8250_port.c                |  65 +-
 drivers/tty/serial/8250/Kconfig                    |   8 +
 drivers/tty/serial/8250/Makefile                   |   3 +
 drivers/tty/serial/Kconfig                         |   2 +-
 drivers/tty/serial/altera_jtaguart.c               |  11 +-
 drivers/tty/serial/altera_uart.c                   |   9 +-
 drivers/tty/serial/amba-pl010.c                    |   3 -
 drivers/tty/serial/amba-pl011.c                    |  73 +-
 drivers/tty/serial/ar933x_uart.c                   |  12 +-
 drivers/tty/serial/atmel_serial.c                  |  16 +-
 drivers/tty/serial/bcm63xx_uart.c                  |  10 +-
 drivers/tty/serial/fsl_lpuart.c                    |  12 +-
 drivers/tty/serial/imx.c                           |  13 +-
 drivers/tty/serial/lantiq.c                        |  34 +-
 drivers/tty/serial/liteuart.c                      |   2 +-
 drivers/tty/serial/lpc32xx_hs.c                    |   2 +-
 drivers/tty/serial/meson_uart.c                    |  45 +-
 drivers/tty/serial/pmac_zilog.c                    |  12 +-
 drivers/tty/serial/pxa.c                           |  12 +-
 drivers/tty/serial/samsung_tty.c                   |  78 +-
 drivers/tty/serial/serial_core.c                   |  19 +-
 drivers/tty/serial/sh-sci.c                        |  91 +-
 drivers/tty/serial/stm32-usart.c                   |  74 +-
 drivers/tty/serial/stm32-usart.h                   |   2 +-
 drivers/tty/serial/sunsu.c                         |   3 +-
 drivers/tty/serial/uartlite.c                      |   2 +-
 drivers/tty/serial/vt8500_serial.c                 |  12 +-
 drivers/tty/tty_buffer.c                           | 279 +++----
 drivers/tty/tty_io.c                               | 921 ++++++++++-----------
 drivers/tty/tty_ldisc.c                            | 292 +++----
 drivers/tty/tty_ldsem.c                            |   2 +-
 drivers/tty/tty_port.c                             | 223 +++--
 drivers/tty/vt/keyboard.c                          |  18 +-
 drivers/tty/vt/vt.c                                |   2 +-
 drivers/usb/class/cdc-acm.c                        |   4 -
 include/linux/amba/bus.h                           |   6 -
 include/linux/pci_ids.h                            |  18 -
 include/linux/serial_8250.h                        |   2 -
 include/linux/serial_s3c.h                         |   9 -
 include/linux/tty.h                                | 153 +++-
 include/linux/tty_driver.h                         | 572 ++++++++-----
 include/linux/tty_flip.h                           |   1 -
 include/linux/tty_ldisc.h                          | 287 ++++---
 include/linux/tty_port.h                           | 131 ++-
 net/nfc/nci/uart.c                                 |   5 +-
 87 files changed, 3297 insertions(+), 2980 deletions(-)
 delete mode 100644 Documentation/driver-api/serial/tty.rst
 create mode 100644 Documentation/tty/index.rst
 create mode 100644 Documentation/tty/n_tty.rst
 create mode 100644 Documentation/tty/tty_buffer.rst
 create mode 100644 Documentation/tty/tty_driver.rst
 create mode 100644 Documentation/tty/tty_internals.rst
 create mode 100644 Documentation/tty/tty_ldisc.rst
 create mode 100644 Documentation/tty/tty_port.rst
 create mode 100644 Documentation/tty/tty_struct.rst
 create mode 100644 drivers/tty/serial/8250/8250_alpha.c
 create mode 100644 drivers/tty/serial/8250/8250_pericom.c

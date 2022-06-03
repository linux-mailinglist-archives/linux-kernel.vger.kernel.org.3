Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77DFD53C894
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 12:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243643AbiFCKW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 06:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243524AbiFCKWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 06:22:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CDFD64C6;
        Fri,  3 Jun 2022 03:22:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 13366B822A8;
        Fri,  3 Jun 2022 10:22:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AAFEC385A9;
        Fri,  3 Jun 2022 10:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654251762;
        bh=RcxqPgIwFiUD4esjBVYJ/i5KMB+3Jow+fCQP7boB9dM=;
        h=Date:From:To:Cc:Subject:From;
        b=qeqGbIrMcIEbEFMG8XSckHFm2oFGLROkcYso6NuUxkVoSWRm+jDB4cukD2XE1Eqlo
         0Dxa21SH3W7sM538cWgBPEJiMTxUEMkp+kGkpebhlZwgm9fdvVt3m4vexNqM4iEwrC
         csd4e0iAH3+SF57tps2VQTyh/g7iE9CFRDI3OtO0=
Date:   Fri, 3 Jun 2022 12:22:39 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial driver updates for 5.19-rc1
Message-ID: <Ypng7xL2s6mAlODi@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 42226c989789d8da4af1de0c31070c96726d990c:

  Linux 5.18-rc7 (2022-05-15 18:08:58 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.19-rc1

for you to fetch changes up to 25e02ba60f0fbe65ba07553b5b2b8867726273c4:

  tty: Rework receive flow control char logic (2022-05-19 18:33:34 +0200)

----------------------------------------------------------------
TTY / Serial driver changes for 5.19-rc1

Here is the big set of tty and serial driver updates for 5.19-rc1.

Lots of tiny cleanups in here, the major stuff is:
	- termbit cleanups and unification by Ilpo.  A much needed
	  change that goes a long way to making things simpler for all
	  of the different arches
	- tty documentation cleanups and movements to their own place in
	  the documentation tree
	- old tty driver cleanups and fixes from Jiri to bring some
	  existing drivers into the modern world
	- RS485 cleanups and unifications to make it easier for
	  individual drivers to support this mode instead of having to
	  duplicate logic in each driver
	- Lots of 8250 driver updates and additions
	- new device id additions
	- n_gsm continued fixes and cleanups
	- other minor serial driver updates and cleanups

All of these have been in linux-next for weeks with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Al Cooper (1):
      serial: When UART is suspended, set RTS to false

Andy Shevchenko (3):
      serial: 8250_dw: Update the list of OF headers used by driver
      serial: 8250_dw: Use devm_add_action_or_reset()
      serial: 8250_dw: Use dev_err_probe()

AngeloGioacchino Del Regno (1):
      Revert "serial: 8250_mtk: Make sure to select the right FEATURE_SEL"

Changbin Du (1):
      sysrq: do not omit current cpu when showing backtrace of all active CPUs

Christophe Leroy (2):
      tty: hvc: Prepare cleanup of powerpc's asm/prom.h
      tty: serial: Prepare cleanup of powerpc's asm/prom.h

Daniel Gibson (1):
      tty: n_tty: Restore EOF push handling behavior

Daniel Starke (2):
      tty: n_gsm: clean up dead code in gsm_queue()
      tty: n_gsm: clean up implicit CR bit encoding in address field

Duoming Zhou (1):
      drivers: tty: serial: Fix deadlock in sa1100_set_termios()

Emil Renner Berthing (1):
      serial: 8250: dw: Create a generic platform data structure

Eric Tremblay (3):
      serial: 8250: Handle UART without interrupt on TEMT using em485
      serial: 8250: Add UART_CAP_NOTEMT on PORT_16550A_FSL64
      serial: 8250: add compatible for fsl,16550-FIFO64

Geert Uytterhoeven (4):
      dt-bindings: serial: renesas,hscif: R-Car V3U is R-Car Gen4
      dt-bindings: serial: renesas,scif: R-Car V3U is R-Car Gen4
      serial: 8250: core: Remove unneeded <linux/pm_runtime.h>
      serial: 8250: pxa: Remove unneeded <linux/pm_runtime.h>

Greg Kroah-Hartman (2):
      Merge 5.18-rc5 into tty-next
      Merge 5.18-rc7 into usb-next

Hector Martin (1):
      tty: serial: samsung_tty: Fix suspend/resume on S5L

Heikki Krogerus (1):
      serial: 8250: dw: Fix NULL pointer dereference

Huang Guobin (1):
      tty: Fix a possible resource leak in icom_probe

Ilpo Järvinen (30):
      Revert "serial: 8250: Handle UART without interrupt on TEMT using em485"
      tty: Add function for handling flow control chars
      serial: Store character timing information to uart_port
      serial: 8250: use THRE & __stop_tx also with DMA
      serial: 8250: Handle UART without interrupt on TEMT
      serial: 8250_dwlib: RS485 HW half & full duplex support
      serial: 8250_dwlib: Implement SW half duplex support
      dt_bindings: rs485: Add receiver enable polarity
      ACPI / property: Document RS485 _DSD properties
      serial: men_z135_uart: Drop duplicated iotype assignment
      termbits: Convert octal defines to hex
      termbits.h: create termbits-common.h for identical bits
      termbits.h: Align lines & format
      termbits.h: Remove posix_types.h include
      tty: remove CMSPAR ifdefs
      tty: remove BOTHER ifdefs
      tty: remove IBSHIFT ifdefs
      serial: fsl_lpuart: Remove unnecessary clearing for CRTSCTS
      serial: jsm: Use B0 instead of 0
      serial: 8250_fintek: Check SER_RS485_RTS_* only with RS485
      serial: uartlite: Fix BRKINT clearing
      serial: digicolor-usart: Don't allow CS5-6
      serial: rda-uart: Don't allow CS5-6
      serial: txx9: Don't allow CS5-6
      serial: sh-sci: Don't allow CS5-6
      serial: sifive: Sanitize CSIZE and c_iflag
      serial: st-asc: Sanitize CSIZE and correct PARENB for CS7
      serial: stm32-usart: Correct CSIZE, bits, and parity
      pcmcia: synclink_cs: Don't allow CS5-6
      tty: Rework receive flow control char logic

Jaewon Kim (1):
      tty: serial: samsung: add spin_lock for interrupt and console_write

Jiri Slaby (49):
      Documentation: move tty to driver-api
      Documentation: tty: introduce "Other Documentation"
      Documentation: tty: move n_gsm to tty
      Documentation: tty: move moxa-smartio.rst to tty
      Documentation: tty: n_gsm, delete "Additional Documentation"
      Documentation: tty: n_gsm, use power of ReST
      tty: serial: mpc52xx_uart: remove double ifdeffery
      tty: serial: owl-uart, send x_char even if stopped
      tty: serial: altera: use altera_jtaguart_stop_tx()
      Documentation: fix tty link
      serial: icom: remove ICOM_VERSION_STR macro
      serial: icom: switch vague casts to container_of
      serial: icom: remove to_icom_adapter() and icom_kref_release()
      serial: icom: use proper __le types and functions
      serial: icom: move header content to .c
      serial: icom: use ARRAY_SIZE
      serial: icom: make icom_acfg_baud const and unsigned
      serial: icom: use list_for_each_entry()
      serial: icom: delete empty serial hooks
      serial: icom: remove unused struct icom_port members
      serial: xilinx_uartps: return early in cdns_uart_handle_tx()
      serial: xilinx_uartps: cache xmit in cdns_uart_handle_tx()
      serial: zs: use NULL as a pointer, not 0
      serial: qcom: use check for empty instead of pending
      serial: pic32: make SERIAL_PIC32_CONSOLE depend on SERIAL_PIC32=y
      serial: allow COMPILE_TEST for some drivers
      serial: pic32: remove unused items from the header
      serial: pic32: move header content to .c
      serial: pic32: remove constants from struct pic32_sport
      serial: pic32: simplify clk handling
      serial: pic32: simplify pic32_sport::enable_tx_irq handling
      serial: pic32: remove pic32_get_port() macro
      serial: pic32: convert to_pic32_sport() to an inline
      serial: pic32: don't assign pic32_sport::cts_gpio twice
      serial: pic32: don't zero members of kzalloc-ated structure
      serial: pic32: free up irq names correctly
      serial: pic32: restore disabled irqs in pic32_uart_startup()
      serial: pch: move size check from pop_tx one level up
      serial: pch: don't overwrite xmit->buf[0] by x_char
      serial: pch: decomission pch_uart_hal_write()
      serial: pch: remove debug print from pop_tx
      serial: pch: remove xmit circ_buf size double check
      serial: pch: simplify pop_tx() even more
      serial: pch: inline pop_tx() into handle_tx()
      serial: amba-pl011: move header content to .c
      serial: pmac_zilog: remove unfinished DBDMA support
      serial: pmac_zilog: remove unused uart_pmac_port::termios_cache
      serial: pmac_zilog: remove tracing prints
      serial: pmac_zilog: remove initial print

John Ogness (2):
      serial: meson: acquire port->lock in startup()
      serial: msm_serial: disable interrupts in __msm_console_write()

Junwen Wu (1):
      tty/sysrq: change the definition of sysrq_key_table's element to make it more readable

Kuldeep Singh (1):
      dt-bindings: serial: Update Qualcomm geni based QUP UART bindings

Kunihiko Hayashi (2):
      dt-bindings: serial: uniphier: Use maxItems for a single clock
      dt-bindings: serial: uniphier: Add "resets" property as optional

Lino Sanfilippo (9):
      serial: core: move RS485 configuration tasks from drivers into core
      serial: amba-pl011: remove redundant code in rs485_config
      serial: stm32: remove redundant code in rs485_config
      serial: sc16is7xx: remove redundant check in rs485_config
      serial: omap: remove redundant code in rs485_config
      serial: max310: remove redundant memset in rs485_config
      serial: imx: remove redundant assignment in rs485_config
      serial: fsl_lpuart: remove redundant code in rs485_config functions
      serial: atmel: remove redundant assignment in rs485_config

Maciej W. Rozycki (9):
      serial: 8250: Report which option to enable for blacklisted PCI devices
      serial: 8250: Fold EndRun device support into OxSemi Tornado code
      serial: 8250: Export ICR access helpers for internal use
      serial: 8250: Add proper clock handling for OxSemi PCIe devices
      serial: sifive: Report actual baud base rather than fixed 115200
      serial: sifive: Remove duplicate `clkin_rate' setting
      Documentation: Move Oxford Semiconductor PCIe (Tornado) 950 to misc-devices
      Documentation: Reformat Oxford Semiconductor PCIe (Tornado) 950
      Documentation: Wire Oxford Semiconductor PCIe (Tornado) 950

Marek Vasut (2):
      serial: stm32: Factor out GPIO RTS toggling into separate function
      serial: stm32: Use TC interrupt to deassert GPIO RTS in RS485 mode

Miaoqian Lin (2):
      tty: serial: owl: Fix missing clk_disable_unprepare() in owl_uart_probe
      serial: 8250_aspeed_vuart: Fix potential NULL dereference in aspeed_vuart_probe

Miquel Raynal (5):
      serial: 8250: dw: Move the USR register to pdata
      serial: 8250: dw: Allow to use a fallback CPR value if not synthesized
      serial: 8250: dma: Allow driver operations before starting DMA transfers
      serial: 8250: dw: Introduce an rx_timeout variable in the IRQ path
      serial: 8250: dw: Move the IO accessors to 8250_dwlib.h

Peng Fan (1):
      dt-bindings: serial: fsl-lpuart: Add imx93 compatible string

Phil Edworthy (6):
      dt-bindings: serial: renesas,em-uart: Document r9a09g011 bindings
      serial: 8250: Make SERIAL_8250_EM available for arm64 systems
      serial: 8250: dw: Move definitions to the shared header
      serial: 8250: dw: Add support for DMA flow controlling devices
      serial: 8250: dw: Improve RZN1 support
      dt-bindings: serial: renesas,em-uart: Add RZ/V2M clock to access the registers

Randy Dunlap (1):
      MAINTAINERS: fix location of moxa-smartio.rst

Shanker Donthineni (1):
      tty: hvc: dcc: Bind driver to CPU core0 for reads and writes

Sherry Sun (2):
      tty: serial: fsl_lpuart: fix potential bug when using both of_alias_get_id and ida_simple_get
      tty: serial: fsl_lpuart: remove the count initialization as it is not needed

Tom Rix (1):
      serial: sunplus-uart: change sunplus_console_ports from global to static

Tomasz Moń (1):
      serial: core: fix tcdrain() with CTS enabled

Tony Lindgren (1):
      tty: n_gsm: Fix packet data hex dump output

Valentin Caron (3):
      serial: stm32: remove infinite loop possibility in putchar function
      serial: stm32: add KGDB support
      serial: stm32: add earlycon support

Vijaya Krishna Nivarthi (2):
      tty: serial: qcom-geni-serial: Remove uart frequency table. Instead, find suitable frequency with call to clk_round_rate.
      serial: core: Do stop_rx in suspend path for console if console_suspend is disabled

Vincent Whitchurch (1):
      char: ttyprintk: register console

Wan Jiabing (2):
      tty/hvc_opal: simplify if-if to if-else
      tty: hvcs: simplify if-if to if-else

Wander Lairson Costa (1):
      serial/8250: Use fifo in 8250 console driver

Wang Weiyang (1):
      tty: goldfish: Use tty_port_destroy() to destroy port

Yoshihiro Shimoda (1):
      dt-bindings: serial: renesas,hscif: Document r8a779g0 bindings

Yu Tu (3):
      tty: serial: meson: Use DIV_ROUND_CLOSEST to calculate baud rates
      tty: serial: meson: Add a 12MHz internal clock rate to calculate baud rate in order to meet the baud rate requirements of special BT modules
      tty: serial: meson: Added S4 SOC compatibility

YueHaibing (1):
      serial: cpm_uart: Fix build error without CONFIG_SERIAL_CPM_CONSOLE

Zheyu Ma (1):
      tty: synclink_gt: Fix null-pointer-dereference in slgt_clean()

 .../devicetree/bindings/serial/fsl-lpuart.yaml     |   4 +-
 .../bindings/serial/qcom,serial-geni-qcom.yaml     |  86 ++++
 .../bindings/serial/renesas,em-uart.yaml           |  37 +-
 .../devicetree/bindings/serial/renesas,hscif.yaml  |   9 +-
 .../devicetree/bindings/serial/renesas,scif.yaml   |   2 +-
 .../devicetree/bindings/serial/rs485.yaml          |   5 +
 .../bindings/serial/socionext,uniphier-uart.yaml   |   5 +-
 Documentation/driver-api/index.rst                 |   1 +
 Documentation/driver-api/serial/driver.rst         |   2 +-
 Documentation/driver-api/serial/index.rst          |   2 -
 Documentation/driver-api/serial/n_gsm.rst          | 159 ------
 Documentation/{ => driver-api}/tty/index.rst       |  22 +-
 .../driver-api/{serial => tty}/moxa-smartio.rst    |   0
 Documentation/driver-api/tty/n_gsm.rst             | 153 ++++++
 Documentation/{ => driver-api}/tty/n_tty.rst       |   0
 Documentation/{ => driver-api}/tty/tty_buffer.rst  |   0
 Documentation/{ => driver-api}/tty/tty_driver.rst  |   0
 .../{ => driver-api}/tty/tty_internals.rst         |   0
 Documentation/{ => driver-api}/tty/tty_ldisc.rst   |   0
 Documentation/{ => driver-api}/tty/tty_port.rst    |   0
 Documentation/{ => driver-api}/tty/tty_struct.rst  |   0
 Documentation/firmware-guide/acpi/enumeration.rst  |  25 +
 Documentation/index.rst                            |   1 -
 Documentation/misc-devices/index.rst               |   1 +
 Documentation/misc-devices/oxsemi-tornado.rst      | 131 +++++
 MAINTAINERS                                        |   2 +-
 arch/alpha/include/uapi/asm/termbits.h             | 214 +++-----
 arch/mips/include/uapi/asm/termbits.h              | 249 ++++------
 arch/parisc/include/uapi/asm/termbits.h            | 241 ++++-----
 arch/powerpc/include/uapi/asm/termbits.h           | 182 +++----
 arch/sparc/include/uapi/asm/termbits.h             | 223 ++++-----
 drivers/char/Kconfig                               |   3 +-
 drivers/char/pcmcia/synclink_cs.c                  |   8 +-
 drivers/char/ttyprintk.c                           |  16 +
 drivers/tty/amiserial.c                            |   2 -
 drivers/tty/goldfish.c                             |   2 +
 drivers/tty/hvc/Kconfig                            |  19 +
 drivers/tty/hvc/hvc_dcc.c                          | 194 +++++++-
 drivers/tty/hvc/hvc_opal.c                         |   6 +-
 drivers/tty/hvc/hvc_vio.c                          |   2 +-
 drivers/tty/hvc/hvcs.c                             |   5 +-
 drivers/tty/hvc/hvsi.c                             |   2 +-
 drivers/tty/mxser.c                                |   5 +-
 drivers/tty/n_gsm.c                                |  37 +-
 drivers/tty/n_tty.c                                |  73 ++-
 drivers/tty/serial/8250/8250.h                     |  41 ++
 drivers/tty/serial/8250/8250_aspeed_vuart.c        |   2 +
 drivers/tty/serial/8250/8250_core.c                |   1 -
 drivers/tty/serial/8250/8250_dma.c                 |   7 +-
 drivers/tty/serial/8250/8250_dw.c                  | 229 ++++++---
 drivers/tty/serial/8250/8250_dwlib.c               | 116 ++++-
 drivers/tty/serial/8250/8250_dwlib.h               |  51 ++
 drivers/tty/serial/8250/8250_fintek.c              |   8 +-
 drivers/tty/serial/8250/8250_mtk.c                 |   7 -
 drivers/tty/serial/8250/8250_of.c                  |   2 +
 drivers/tty/serial/8250/8250_pci.c                 | 480 ++++++++++++------
 drivers/tty/serial/8250/8250_port.c                | 140 ++++--
 drivers/tty/serial/8250/8250_pxa.c                 |   1 -
 drivers/tty/serial/8250/Kconfig                    |   2 +-
 drivers/tty/serial/Kconfig                         |   9 +-
 drivers/tty/serial/altera_jtaguart.c               |   6 +-
 drivers/tty/serial/amba-pl011.c                    |  48 +-
 drivers/tty/serial/amba-pl011.h                    |  35 --
 drivers/tty/serial/atmel_serial.c                  |   4 +-
 drivers/tty/serial/cpm_uart/cpm_uart.h             |   2 +
 drivers/tty/serial/cpm_uart/cpm_uart_core.c        |   2 +-
 drivers/tty/serial/cpm_uart/cpm_uart_cpm2.c        |   1 -
 drivers/tty/serial/digicolor-usart.c               |   2 +
 drivers/tty/serial/fsl_lpuart.c                    |  66 +--
 drivers/tty/serial/icom.c                          | 538 +++++++++++++++------
 drivers/tty/serial/icom.h                          | 274 -----------
 drivers/tty/serial/imx.c                           |   2 -
 drivers/tty/serial/jsm/jsm_cls.c                   |   8 +-
 drivers/tty/serial/jsm/jsm_neo.c                   |   8 +-
 drivers/tty/serial/max310x.c                       |   1 -
 drivers/tty/serial/men_z135_uart.c                 |   1 -
 drivers/tty/serial/meson_uart.c                    |  40 +-
 drivers/tty/serial/mpc52xx_uart.c                  |   5 +-
 drivers/tty/serial/msm_serial.c                    |   5 +
 drivers/tty/serial/omap-serial.c                   |  13 +-
 drivers/tty/serial/owl-uart.c                      |   7 +-
 drivers/tty/serial/pch_uart.c                      |  77 +--
 drivers/tty/serial/pic32_uart.c                    | 159 ++++--
 drivers/tty/serial/pic32_uart.h                    | 125 -----
 drivers/tty/serial/pmac_zilog.c                    |  69 +--
 drivers/tty/serial/pmac_zilog.h                    |  11 -
 drivers/tty/serial/qcom_geni_serial.c              |  58 ++-
 drivers/tty/serial/rda-uart.c                      |   2 +
 drivers/tty/serial/sa1100.c                        |   4 +-
 drivers/tty/serial/samsung_tty.c                   |  13 +
 drivers/tty/serial/sc16is7xx.c                     |  10 -
 drivers/tty/serial/serial_core.c                   |  89 +++-
 drivers/tty/serial/serial_txx9.c                   |   2 +
 drivers/tty/serial/sh-sci.c                        |   6 +-
 drivers/tty/serial/sifive.c                        |  20 +-
 drivers/tty/serial/st-asc.c                        |   4 +
 drivers/tty/serial/stm32-usart.c                   | 225 +++++++--
 drivers/tty/serial/stm32-usart.h                   |   3 +
 drivers/tty/serial/sunplus-uart.c                  |   2 +-
 drivers/tty/serial/sunsu.c                         |   2 -
 drivers/tty/serial/uartlite.c                      |   3 +-
 drivers/tty/serial/xilinx_uartps.c                 |  46 +-
 drivers/tty/serial/zs.c                            |   2 +-
 drivers/tty/synclink_gt.c                          |   2 +
 drivers/tty/sysrq.c                                |  27 +-
 drivers/tty/tty_baudrate.c                         |  35 +-
 drivers/tty/tty_ioctl.c                            |   2 -
 drivers/usb/class/cdc-acm.h                        |   8 -
 drivers/usb/serial/ark3116.c                       |   3 +-
 drivers/usb/serial/whiteheat.c                     |   4 -
 include/linux/serial_core.h                        |   1 +
 include/linux/serial_s3c.h                         |   3 +
 include/uapi/asm-generic/termbits-common.h         |  65 +++
 include/uapi/asm-generic/termbits.h                | 239 ++++-----
 114 files changed, 3164 insertions(+), 2451 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/qcom,serial-geni-qcom.yaml
 delete mode 100644 Documentation/driver-api/serial/n_gsm.rst
 rename Documentation/{ => driver-api}/tty/index.rst (81%)
 rename Documentation/driver-api/{serial => tty}/moxa-smartio.rst (100%)
 create mode 100644 Documentation/driver-api/tty/n_gsm.rst
 rename Documentation/{ => driver-api}/tty/n_tty.rst (100%)
 rename Documentation/{ => driver-api}/tty/tty_buffer.rst (100%)
 rename Documentation/{ => driver-api}/tty/tty_driver.rst (100%)
 rename Documentation/{ => driver-api}/tty/tty_internals.rst (100%)
 rename Documentation/{ => driver-api}/tty/tty_ldisc.rst (100%)
 rename Documentation/{ => driver-api}/tty/tty_port.rst (100%)
 rename Documentation/{ => driver-api}/tty/tty_struct.rst (100%)
 create mode 100644 Documentation/misc-devices/oxsemi-tornado.rst
 delete mode 100644 drivers/tty/serial/amba-pl011.h
 delete mode 100644 drivers/tty/serial/icom.h
 delete mode 100644 drivers/tty/serial/pic32_uart.h
 create mode 100644 include/uapi/asm-generic/termbits-common.h

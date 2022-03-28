Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDD284E9878
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 15:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243342AbiC1NnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 09:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243350AbiC1Nmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 09:42:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7190E31532;
        Mon, 28 Mar 2022 06:41:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F414661163;
        Mon, 28 Mar 2022 13:41:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09EDCC004DD;
        Mon, 28 Mar 2022 13:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648474868;
        bh=NvCpAH/O59jFUVMaTlMuGW4GmmwpcLL8K/WTXn+P1Dg=;
        h=Date:From:To:Cc:Subject:From;
        b=V0ZKKcyW/f9rReZbAjgvDnr9a+dAOyWBWKZ7RTU9vfebfvLjd4l2qqjYA5rHhFuHr
         WDE0g1ais0C2S7SZHt8chzwEU+2A36PtSRWsNcj4ZHikMHXyrJ387+rzlCaFWvac5E
         kjuRgPoXn3MR07Bc3AUEM/ovyLJ/4pjBhIBVY5Gw=
Date:   Mon, 28 Mar 2022 15:41:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial driver changes for 5.18-rc1
Message-ID: <YkG68oNE448ucfPD@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 7e57714cd0ad2d5bb90e50b5096a0e671dec1ef3:

  Linux 5.17-rc6 (2022-02-27 14:36:33 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.18-rc1

for you to fetch changes up to b31c41339f4f8a833cb9dc509f87aab6a159ffe4:

  vt_ioctl: fix potential spectre v1 in VT_DISALLOCATE (2022-03-18 14:35:01 +0100)

----------------------------------------------------------------
TTY/Serial driver changes for 5.18-rc1

Here are the big set of tty and serial driver changes for 5.18-rc1.

Nothing major, some more good cleanups from Jiri and 2 new serial
drivers.  Highlights include:
	- termbits cleanups
	- export symbol cleanups and other core cleanups from Jiri Slaby
	- new sunplus and mvebu uart drivers (amazing that people are
	  still creating new uarts...)
	- samsung serial driver cleanups
	- ldisc 29 is now "reserved" for experimental/development line
	  disciplines
	- lots of other tiny fixes and cleanups to serial drivers and
	  bindings

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Abel Vesa (3):
      dt-bindings: serial: fsl-lpuart: Add i.MX8DXL compatible
      dt-bindings: serial: fsl-lpuart: Drop i.MX8QXP backwards compatibility
      dt-bindings: serial: fsl-lpuart: Remove i.MX8QM from enum

Adrien Thierry (1):
      serial: 8250_bcm2835aux: Add ACPI support

Alexander Vorwerk (1):
      tty: serial: jsm: fix two assignments in if conditions

Allen-KH Cheng (1):
      dt-bindings: serial: Add compatible for Mediatek MT8186

Andy Shevchenko (9):
      serial: 8250_exar: derive nr_ports from PCI ID for Acces I/O cards
      amiserial: Drop duplicate NULL check in shutdown()
      serial: core: Fix the definition name in the comment of UPF_* flags
      tty: Drop duplicate NULL check in TTY port functions
      serial: core: Drop duplicate NULL check in uart_*shutdown()
      serial: 8250_mid: Get rid of custom MID_DEVICE() macro
      serial: 8250_mid: Remove unneeded test for ->setup() presence
      serial: 8250_mid: Balance reference count for PCI DMA device
      serial: 8250_lpss: Balance reference count for PCI DMA device

Biju Das (3):
      dt-bindings: serial: renesas,scif: Remove redundant renesas,scif-r9a07g054
      dt-bindings: serial: renesas,scif: Document RZ/G2UL SoC
      dt-bindings: serial: renesas,sci: Document RZ/G2UL SoC

Colin Ian King (2):
      serial: 8250_mtk: make two read-only arrays static const
      tty: serial: jsm: remove redundant assignments to variable linestatus

Erwan Le Ray (2):
      serial: mctrl_gpio: add a new API to enable / disable wake_irq
      serial: stm32: enable / disable wake irqs for mcrtl_gpio wakeup sources

Geert Uytterhoeven (2):
      serial: sh-sci: Simplify multiplication/shift logic
      serial: SERIAL_SUNPLUS should depend on ARCH_SUNPLUS

Greg Kroah-Hartman (4):
      Merge tag 'v5.17-rc2' into tty-next
      Merge 5.17-rc4 into tty-next
      Merge 5.17-rc6 into tty-next
      Revert "tty: serial: meson: *"

Hammer Hsieh (3):
      dt-bindings: serial: Add bindings doc for Sunplus SoC UART Driver
      serial: sunplus-uart: Add Sunplus SoC UART Driver
      serial: sunplus-uart: Fix compile error while CONFIG_SERIAL_SUNPLUS_CONSOLE=n

Harald Seiler (1):
      tty: serial: imx: Add fast path when rs485 delays are 0

Hui Wang (1):
      serial: sc16is7xx: Clear RS485 bits in the shutdown

Ilpo Järvinen (3):
      ia64: termbits.h is identical to asm-generic one
      xtensa: termbits.h is identical to asm-generic one
      serial: 8250: fix XOFF/XON sending when DMA is used

Jiri Slaby (22):
      serial: core: clean up EXPORT_SYMBOLs
      serial: atmel_serial: include circ_buf.h
      tty: add kfifo to tty_port
      tty: tty_port_open, document shutdown vs failed activate
      mxser: fix xmit_buf leak in activate when LSR == 0xff
      mxser: use tty_port xmit_buf helpers
      mxser: switch from xmit_buf to kfifo
      serial: fsl_linflexuart: deduplicate character sending
      serial: fsl_linflexuart: don't call uart_write_wakeup() twice
      serial: mcf: use helpers in mcf_tx_chars()
      tty: serial: mpc52xx_uart: make rx/tx hooks return unsigned
      tty: serial: serial_txx9: remove info print from init
      tty: serial: lpc32xx_hs: use serial_lpc32xx_stop_tx() helper
      tty: serial: amba-pl010: use more uart_port pointers
      tty: serial: define UART_LCR_WLEN() macro
      tty: serial: make use of UART_LCR_WLEN() + tty_get_char_size()
      USB: serial: make use of UART_LCR_WLEN() + tty_get_char_size()
      sdio_uart: make use of UART_LCR_WLEN() + tty_get_char_size()
      mxser: make use of UART_LCR_WLEN() + tty_get_char_size()
      serial: make uart_console_write->putchar()'s character an unsigned char
      tty: serial: serial_txx9: remove struct uart_txx9_port
      serial: samsung_tty: do not unlock port->lock for uart_write_wakeup()

Krzysztof Kozlowski (10):
      dt-bindings: serial: samsung_uart: Document Exynos5433 compatible
      serial: 8250_tegra: mark acpi_device_id as unused with !ACPI
      tty: serial: samsung: embed s3c24xx_uart_info in parent structure
      tty: serial: samsung: embed s3c2410_uartcfg in parent structure
      tty: serial: samsung: reduce number of casts
      tty: serial: samsung: constify s3c24xx_serial_drv_data
      tty: serial: samsung: constify UART name
      tty: serial: samsung: constify s3c24xx_serial_drv_data members
      tty: serial: samsung: constify variables and pointers
      tty: serial: samsung: simplify getting OF match data

Lech Perczak (3):
      sc16is7xx: Preserve EFR bits on update
      sc16is7xx: Update status lines in single call
      sc16is7xx: Separate GPIOs from modem control lines

Maciej W. Rozycki (1):
      serial: 8250: Correct Kconfig help text for blacklisted PCI devices

Max Staudt (1):
      tty: Reserve ldisc 29 for development purposes

Michael Walle (1):
      tty: serial: atmel: add earlycon support

Pali Rohár (7):
      MAINTAINERS: Add Pali Rohár as mvebu-uart.c maintainer
      math64: New DIV_U64_ROUND_CLOSEST helper
      dt-bindings: mvebu-uart: document DT bindings for marvell,armada-3700-uart-clock
      serial: mvebu-uart: implement UART clock driver for configuring UART base clock
      dt-bindings: mvebu-uart: update information about UART clock
      serial: mvebu-uart: implement support for baudrates higher than 230400 Bd
      arm64: dts: marvell: armada-37xx: add device node for UART clock and use it

Rafael J. Wysocki (1):
      tty: Replace acpi_bus_get_device()

Rafał Miłecki (1):
      tty: serial: bcm63xx: use more precise Kconfig symbol

Randy Dunlap (2):
      tty: hvc: fix return value of __setup handler
      kgdboc: fix return value of __setup handler

Sherry Sun (1):
      tty: serial: fsl_lpuart: count tty buffer overruns

Steffen Trumtrar (1):
      serial: 8250: Return early in .start_tx() if there are no chars to send

Tomasz Moń (4):
      serial: imx: reduce RX interrupt frequency
      sc16is7xx: Properly resume TX after stop
      sc16is7xx: Handle modem status lines
      sc16is7xx: Set AUTOCTS and AUTORTS bits

Uwe Kleine-König (1):
      serial: 8250: Fix race condition in RTS-after-send handling

Vincent Whitchurch (2):
      dt-bindings: serial: samsung: Add ARTPEC-8 UART
      tty: serial: samsung: Add ARTPEC-8 support

Wei Yongjun (1):
      serial: mvebu-uart: fix return value check in mvebu_uart_clock_probe()

Woody Lin (1):
      serial: samsung: Add samsung_early_read to support early kgdboc

Xiaomeng Tong (1):
      vt_ioctl: fix potential spectre v1 in VT_DISALLOCATE

Xu Wang (1):
      tty: serial: max3100: Remove redundant 'flush_workqueue()' calls

Yang Guang (1):
      serial: 8250_aspeed_vuart: replace snprintf with sysfs_emit

Yu Tu (7):
      tty: serial: meson: Move request the register region to probe
      tty: serial: meson: Use devm_ioremap_resource to get register mapped memory
      tty: serial: meson: Describes the calculation of the UART baud rate clock using a clock frame
      tty: serial: meson: Make some bit of the REG5 register writable
      tty: serial: meson: The system stuck when you run the stty command on the console to change the baud rate
      tty: serial: meson: Added S4 SOC compatibility
      tty: serial: meson: Fix the compile link error reported by kernel test robot

Zev Weiss (1):
      serial: 8250_aspeed_vuart: add PORT_ASPEED_VUART port type

 .../clock/marvell,armada-3700-uart-clock.yaml      |  59 ++
 .../devicetree/bindings/serial/fsl-lpuart.yaml     |  10 +-
 .../devicetree/bindings/serial/mtk-uart.txt        |   1 +
 .../devicetree/bindings/serial/mvebu-uart.txt      |   9 +-
 .../devicetree/bindings/serial/renesas,sci.yaml    |   2 +
 .../devicetree/bindings/serial/renesas,scif.yaml   |   5 +-
 .../devicetree/bindings/serial/samsung_uart.yaml   |   4 +
 .../bindings/serial/sunplus,sp7021-uart.yaml       |  56 ++
 MAINTAINERS                                        |  13 +
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi       |  14 +-
 arch/ia64/include/uapi/asm/termbits.h              | 209 ------
 arch/xtensa/include/uapi/asm/termbits.h            | 221 ------
 drivers/mmc/core/sdio_uart.c                       |  17 +-
 drivers/tty/amiserial.c                            |   6 +-
 drivers/tty/goldfish.c                             |   2 +-
 drivers/tty/hvc/hvc_dcc.c                          |   2 +-
 drivers/tty/hvc/hvc_iucv.c                         |   4 +-
 drivers/tty/mxser.c                                | 125 ++--
 drivers/tty/serdev/core.c                          |   7 +-
 drivers/tty/serial/21285.c                         |   2 +-
 drivers/tty/serial/8250/8250_aspeed_vuart.c        |   8 +-
 drivers/tty/serial/8250/8250_bcm2835aux.c          |  52 +-
 drivers/tty/serial/8250/8250_dma.c                 |  11 +-
 drivers/tty/serial/8250/8250_early.c               |   2 +-
 drivers/tty/serial/8250/8250_exar.c                |  37 +-
 drivers/tty/serial/8250/8250_ingenic.c             |   2 +-
 drivers/tty/serial/8250/8250_lpss.c                |  28 +-
 drivers/tty/serial/8250/8250_mid.c                 |  43 +-
 drivers/tty/serial/8250/8250_mtk.c                 |   4 +-
 drivers/tty/serial/8250/8250_omap.c                |  16 +-
 drivers/tty/serial/8250/8250_port.c                |  45 +-
 drivers/tty/serial/8250/8250_tegra.c               |   2 +-
 drivers/tty/serial/8250/Kconfig                    |  16 +-
 drivers/tty/serial/Kconfig                         |  32 +-
 drivers/tty/serial/Makefile                        |   1 +
 drivers/tty/serial/altera_jtaguart.c               |   4 +-
 drivers/tty/serial/altera_uart.c                   |   2 +-
 drivers/tty/serial/amba-pl010.c                    | 176 +++--
 drivers/tty/serial/amba-pl011.c                    |   6 +-
 drivers/tty/serial/apbuart.c                       |   2 +-
 drivers/tty/serial/ar933x_uart.c                   |   2 +-
 drivers/tty/serial/arc_uart.c                      |   2 +-
 drivers/tty/serial/atmel_serial.c                  |  27 +-
 drivers/tty/serial/bcm63xx_uart.c                  |   2 +-
 drivers/tty/serial/clps711x.c                      |   2 +-
 drivers/tty/serial/digicolor-usart.c               |   2 +-
 drivers/tty/serial/dz.c                            |   2 +-
 drivers/tty/serial/earlycon-arm-semihost.c         |   2 +-
 drivers/tty/serial/earlycon-riscv-sbi.c            |   2 +-
 drivers/tty/serial/fsl_linflexuart.c               |  50 +-
 drivers/tty/serial/fsl_lpuart.c                    |  24 +-
 drivers/tty/serial/imx.c                           |  22 +-
 drivers/tty/serial/imx_earlycon.c                  |   2 +-
 drivers/tty/serial/ip22zilog.c                     |   2 +-
 drivers/tty/serial/jsm/jsm_cls.c                   |  20 +-
 drivers/tty/serial/jsm/jsm_neo.c                   |  19 +-
 drivers/tty/serial/jsm/jsm_tty.c                   |   3 +-
 drivers/tty/serial/kgdboc.c                        |   6 +-
 drivers/tty/serial/lantiq.c                        |   2 +-
 drivers/tty/serial/liteuart.c                      |   2 +-
 drivers/tty/serial/lpc32xx_hs.c                    |  12 +-
 drivers/tty/serial/max3100.c                       |   1 -
 drivers/tty/serial/mcf.c                           |   7 +-
 drivers/tty/serial/meson_uart.c                    |   2 +-
 drivers/tty/serial/milbeaut_usio.c                 |   2 +-
 drivers/tty/serial/mpc52xx_uart.c                  |  22 +-
 drivers/tty/serial/mps2-uart.c                     |   4 +-
 drivers/tty/serial/mvebu-uart.c                    | 600 +++++++++++++++-
 drivers/tty/serial/mxs-auart.c                     |   2 +-
 drivers/tty/serial/omap-serial.c                   |  20 +-
 drivers/tty/serial/owl-uart.c                      |   2 +-
 drivers/tty/serial/pch_uart.c                      |   2 +-
 drivers/tty/serial/pic32_uart.c                    |   2 +-
 drivers/tty/serial/pmac_zilog.c                    |   2 +-
 drivers/tty/serial/pxa.c                           |  18 +-
 drivers/tty/serial/qcom_geni_serial.c              |   2 +-
 drivers/tty/serial/rda-uart.c                      |   2 +-
 drivers/tty/serial/sa1100.c                        |   2 +-
 drivers/tty/serial/samsung_tty.c                   | 296 ++++----
 drivers/tty/serial/sb1250-duart.c                  |   2 +-
 drivers/tty/serial/sc16is7xx.c                     | 263 ++++++-
 drivers/tty/serial/sccnxp.c                        |   2 +-
 drivers/tty/serial/serial-tegra.c                  |  22 +-
 drivers/tty/serial/serial_core.c                   |  40 +-
 drivers/tty/serial/serial_mctrl_gpio.c             |  38 +
 drivers/tty/serial/serial_mctrl_gpio.h             |  18 +
 drivers/tty/serial/serial_txx9.c                   | 369 +++++-----
 drivers/tty/serial/sh-sci.c                        |   4 +-
 drivers/tty/serial/sifive.c                        |   4 +-
 drivers/tty/serial/sprd_serial.c                   |   4 +-
 drivers/tty/serial/st-asc.c                        |   2 +-
 drivers/tty/serial/stm32-usart.c                   |   5 +-
 drivers/tty/serial/sunplus-uart.c                  | 775 +++++++++++++++++++++
 drivers/tty/serial/sunsab.c                        |   2 +-
 drivers/tty/serial/sunsu.c                         |   2 +-
 drivers/tty/serial/sunzilog.c                      |   4 +-
 drivers/tty/serial/uartlite.c                      |   4 +-
 drivers/tty/serial/vr41xx_siu.c                    |  17 +-
 drivers/tty/serial/vt8500_serial.c                 |   2 +-
 drivers/tty/serial/xilinx_uartps.c                 |   2 +-
 drivers/tty/serial/zs.c                            |   2 +-
 drivers/tty/tty_port.c                             |  18 +-
 drivers/tty/vt/vt_ioctl.c                          |  10 +-
 drivers/usb/serial/ark3116.c                       |  17 +-
 drivers/usb/serial/f81232.c                        |  16 +-
 drivers/usb/serial/f81534.c                        |  16 +-
 drivers/usb/serial/mos7720.c                       |  20 +-
 drivers/usb/serial/quatech2.c                      |  16 +-
 drivers/usb/serial/ssu100.c                        |  16 +-
 include/linux/math64.h                             |  13 +
 include/linux/serial.h                             |   2 +
 include/linux/serial_core.h                        |   6 +-
 include/linux/tty_port.h                           |   3 +
 include/uapi/linux/serial_core.h                   |   6 +
 include/uapi/linux/tty.h                           |   6 +-
 115 files changed, 2727 insertions(+), 1473 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/marvell,armada-3700-uart-clock.yaml
 create mode 100644 Documentation/devicetree/bindings/serial/sunplus,sp7021-uart.yaml
 delete mode 100644 arch/ia64/include/uapi/asm/termbits.h
 delete mode 100644 arch/xtensa/include/uapi/asm/termbits.h
 create mode 100644 drivers/tty/serial/sunplus-uart.c

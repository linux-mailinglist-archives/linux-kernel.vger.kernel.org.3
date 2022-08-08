Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5D458C826
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 14:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242198AbiHHMJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 08:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbiHHMJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 08:09:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7903925CF;
        Mon,  8 Aug 2022 05:09:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 03F44B80E7F;
        Mon,  8 Aug 2022 12:09:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5151EC433C1;
        Mon,  8 Aug 2022 12:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659960550;
        bh=2rIREooG7rOkT3nfFo4tkMikJS/rUeGKb6UF22rrk7c=;
        h=Date:From:To:Cc:Subject:From;
        b=zrtGZ3ZW6RNCuu4xTPV9sydh1fha4pKy/W0gaUixv5RhTW//rnH/IVaV8+yzxhI2r
         mx9IgNy14cXwCqjRy1GD1FE+NVAKoqQgFoiKpYSIvBrTT6g1QbeMPwCNcmLO8SCdSW
         m7pVw9hjRCbpGEtBKmDKPcI7n0dWKmMDPPeLFAl0=
Date:   Mon, 8 Aug 2022 14:09:07 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial driver changes for 6.0-rc1
Message-ID: <YvD84wGcwBuUpdtn@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
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

The following changes since commit a111daf0c53ae91e71fd2bfe7497862d14132e3e:

  Linux 5.19-rc3 (2022-06-19 15:06:47 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.0-rc1

for you to fetch changes up to 0fec518018cc5ceffa706370b6e3acbbb1e3c798:

  tty: serial: qcom-geni-serial: Fix %lu -> %u in print statements (2022-08-03 08:23:35 +0200)

----------------------------------------------------------------
TTY / Serial driver changes for 6.0-rc1

Here is the big set of tty and serial driver changes for 6.0-rc1.

It was delayed from last week as I wanted to make sure the last commit
here got some good testing in linux-next and elsewhere as it seemed to
show up only late in testing for some reason.

Nothing major here, just lots of cleanups from Jiri and Ilpo to make the
tty core cleaner (Jiri) and the rs485 code simpler to use (Ilpo).  Also
included in here is the obligatory n_gsm updates from Daniel Starke and
lots of tiny driver updates and minor fixes and tweaks for other smaller
serial drivers.

Full details are in the shortlog.

All of these have been in linux-next for a while with no reported
problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Andy Shevchenko (2):
      serial: 8250_dw: Sort headers alphabetically
      serial: 8250_dw: Drop PM ifdeffery

AngeloGioacchino Del Regno (1):
      dt-bindings: serial: mtk-uart: Convert txt to json-schema

Ben Dooks (1):
      serial: stm32: make info structs static to avoid sparse warnings

Cameron Williams (1):
      tty: 8250: Add support for Brainboxes PX cards.

Chanho Park (2):
      tty: serial: samsung_tty: support more than 4 uart ports
      tty: serial: samsung_tty: loopback mode support

Christophe JAILLET (1):
      serial: sifive: Remove useless license text when SPDX-License-Identifier is already used

Claudiu Beznea (4):
      tty: serial: atmel: stop using legacy pm ops
      tty: serial: atmel: use devm_clk_get()
      tty: serial: atmel: remove enable/disable clock due to atmel_console_setup()
      serial: st-asc: remove include of pm_runtime.h

Cosmin Tanislav (4):
      serial: max310x: use regmap methods for SPI batch operations
      serial: max310x: use a separate regmap for each port
      serial: max310x: make accessing revision id interface-agnostic
      serial: max310x: implement I2C support

Daniel Starke (13):
      tty: n_gsm: fix user open not possible at responder until initiator open
      tty: n_gsm: fix tty registration before control channel open
      tty: n_gsm: fix wrong queuing behavior in gsm_dlci_data_output()
      tty: n_gsm: fix missing timer to handle stalled links
      tty: n_gsm: fix non flow control frames during mux flow off
      tty: n_gsm: fix packet re-transmission without open control channel
      tty: n_gsm: fix race condition in gsmld_write()
      tty: n_gsm: fix deadlock and link starvation in outgoing data path
      tty: n_gsm: fix resource allocation order in gsm_activate_mux()
      tty: n_gsm: fix wrong T1 retry count handling
      tty: n_gsm: fix DM command
      tty: n_gsm: fix flow control handling in tx path
      tty: n_gsm: fix missing corner cases in gsmld_poll()

Doug Berger (1):
      serial: 8250_bcm7271: Save/restore RTS in suspend/resume

Douglas Anderson (1):
      tty: serial: qcom-geni-serial: Fix %lu -> %u in print statements

Geert Uytterhoeven (1):
      serial: 8250: SERIAL_8250_ASPEED_VUART should depend on ARCH_ASPEED

Greg Kroah-Hartman (1):
      Merge tag 'v5.19-rc3' into tty-next

Guo Mengqi (1):
      serial: 8250_bcm2835aux: Add missing clk_disable_unprepare()

Ilpo Järvinen (69):
      serial: 8250: kill __do_stop_tx()
      serial: 8250: handle __start_tx() call in start_tx()
      serial: 8250: Store to lsr_save_flags after lsr read
      serial: 8250: Create serial_lsr_in()
      serial: 8250: Get preserved flags using serial_lsr_in()
      serial: 8250: Adjust misleading LSR related comment
      serial: 8250_dw: Use serial_lsr_in() in dw8250_handle_irq()
      serial: 8250_dw: Store LSR into lsr_saved_flags in dw8250_tx_wait_empty()
      serial: Add uart_rs485_config()
      serial: Move serial_rs485 sanitization into separate function
      serial: Add rs485_supported to uart_port
      serial: 8250: Create serial8250_em485_supported for em485 users
      serial: 8250_bcm2835aux: Use serial8250_em485_supported
      serial: 8250_dwlib: Fill in rs485_supported
      serial: 8250_exar: Fill in rs485_supported
      serial: 8250_fintek: Fill in rs485_supported
      serial: 8250_lpc18cc: Fill in rs485_supported
      serial: 8250_of: Use serial8250_em485_supported
      serial: 8250_pci: Fill in rs485_supported for pci_fintek
      serial: pl011: Fill in rs485_supported
      serial: ar933x: Fill in rs485_supported
      serial: atmel: Fill in rs485_supported
      serial: fsl_lpuart: Fill in rs485_supported
      serial: imx: Fill in rs485_supported
      serial: max310x: Fill in rs485_supported
      serial: mcf: Fill in rs485_supported
      serial: omap: Fill in rs485_supported
      serial: sc16is7xx: Fill in rs485_supported
      serial: stm32: Fill in rs485_supported
      serial: Sanitize rs485_struct
      serial: Clear rs485 struct when non-RS485 mode is set
      serial: return -EINVAL for non-legacy RS485 flags
      serial: 8250_dwlib: Remove serial_rs485 sanitization
      serial: 8250_fintek: Remove serial_rs485 sanitization
      serial: 8250: lpc18xx: Remove serial_rs485 sanitization
      serial: 8250_pci: Remove serial_rs485 sanitization
      serial: pl011: Remove serial_rs485 sanitization
      serial: fsl_lpuart: Call core's sanitization and remove custom one
      serial: imx: Remove serial_rs485 sanitization
      serial: max310x: Remove serial_rs485 sanitization
      serial: 8250_exar: Remove serial_rs485 assignment
      serial: mcf: Remove serial_rs485 assignment
      serial: sc16is7xx: Remove serial_rs485 assignment
      serial: 8250: Remove serial_rs485 sanitization from em485
      tty: Implement lookahead to process XON/XOFF timely
      tty: Use flow-control char function on closing path
      serial: 8250: Use UART_LCR_WLEN8 instead of literal
      serial: 8250_pericom: Use UART_LCR_DLAB
      tty: Add closing marker into comment in tty_ldisc.h
      serial: Drop timeout from uart_port
      MAINTAINERS: Update DW 8250 UART maintainership
      serial: msm: Convert container_of UART_TO_MSM to static inline
      serial: msm: Rename UART_* defines to MSM_UART_*
      serial: Use bits for UART_LSR_BRK_ERROR_BITS/MSR_ANY_DELTA
      serial: 8250: Use C99 array initializer & define UART_REG_UNMAPPED
      serial: Convert SERIAL_XMIT_SIZE to UART_XMIT_SIZE
      serial: Consolidate BOTH_EMPTY use
      serial: 8250: make saved LSR larger
      serial: 8250: create lsr_save_mask
      serial: 8250_lpss: Use 32-bit reads
      serial: take termios_rwsem for ->rs485_config() & pass termios as param
      serial: Support for RS-485 multipoint addresses
      serial: 8250_dwlib: Support for 9th bit multipoint addressing
      serial: 8250_dw: Take port lock while accessing LSR
      8250_dwlib: Convert bitops to newer form
      serial: 8250_dw: Use dw8250_serial_out() in dw8250_serial_out38x()
      MIPS: ath79: Remove one of the identical args in early_printk
      serial: Embed rs485_supported to uart_port
      serial: RS485 termination is supported if DT provides one

Jagan Teki (1):
      dt-bindings: serial: snps-dw-apb-uart: Document Rockchip RV1126

Jason Wang (1):
      tty: amiserial: Fix comment typo

Jiri Slaby (53):
      serial: pmac_zilog: remove unused header
      tty/vt: defkeymap.c_shipped, little unification with loadkeys
      tty/vt: Makefile, add --unicode for loadkeys invocation
      tty/vt: consolemap: use ARRAY_SIZE()
      tty/vt: consolemap: rename and document struct uni_pagedir
      tty/vt: consolemap: define UNI_* macros for constants
      tty/vt: consolemap: decrypt inverse_translate()
      tty/vt: consolemap: remove extern from function decls
      tty/vt: consolemap: convert macros to static inlines
      tty/vt: consolemap: make parameters of inverse_translate() saner
      tty/vt: consolemap: one line = one statement
      tty/vt: consolemap: use | for binary addition
      tty/vt: consolemap: introduce UNI_*() macros
      tty/vt: consolemap: zero uni_pgdir using kcalloc()
      tty/vt: consolemap: use sizeof(*pointer) instead of sizeof(type)
      tty/vt: consolemap: make con_set_unimap() more readable
      tty/vt: consolemap: make con_get_unimap() more readable
      tty/vt: consolemap: make p1 increment less confusing in con_get_unimap()
      tty/vt: consolemap: check put_user() in con_get_unimap()
      tty/vt: consolemap: introduce enum translation_map and use it
      tty/vt: consolemap: remove glyph < 0 check from set_inverse_trans_unicode()
      tty/vt: consolemap: extract dict unsharing to con_unshare_unimap()
      tty/vt: consolemap: saner variable names in set_inverse_trans_unicode()
      tty/vt: consolemap: saner variable names in conv_uni_to_pc()
      tty/vt: consolemap: saner variable names in con_insert_unipair()
      tty/vt: consolemap: saner variable names in con_unify_unimap()
      tty/vt: consolemap: saner variable names in con_do_clear_unimap()
      tty/vt: consolemap: saner variable names in con_unshare_unimap()
      tty/vt: consolemap: saner variable names in con_release_unimap()
      tty/vt: consolemap: saner variable names in con_copy_unimap()
      tty/vt: consolemap: saner variable names in con_get_unimap()
      tty/vt: consolemap: saner variable names in con_set_unimap()
      tty/vt: consolemap: saner variable names in con_set_default_unimap()
      tty/vt: consolemap: make conv_uni_to_pc() more readable
      tty/vt: consolemap: remove superfluous whitespace
      tty/vt: consolemap: change refcount only if needed in con_do_clear_unimap()
      tty/vt: consolemap: extract con_allocate_new() from con_do_clear_unimap()
      tty/vt: consolemap: use con_allocate_new() in con_unshare_unimap()
      tty/vt: consolemap: walk the buffer only once in con_set_trans_old()
      tty/vt: consolemap: use ARRAY_SIZE(), part II.
      tty/vt: consolemap: remove unused parameter from set_inverse_trans_unicode()
      tty/vt: consolemap: saner variable names in set_inverse_trans_unicode()
      tty/vt: consolemap: saner variable names in set_inverse_transl()
      tty/vt: consolemap: rename struct vc_data::vc_uni_pagedir*
      tty/vt: consolemap: improve UNI_*() macros definitions
      tty/vt: consolemap: remove dflt reset from con_do_clear_unimap()
      tty/vt: consolemap: use E_TABSZ for the translations size
      Documentation: serial: move uart_ops documentation to the struct
      Documentation: serial: dedup kernel-doc for uart functions
      Documentation: serial: move GPIO kernel-doc to the functions
      Documentation: serial: link uart_ops properly
      tty: serial: serial_core, reformat kernel-doc for functions
      tty: serial: document uart_get_console()

Julia Lawall (2):
      tty: fix typos in comments
      serial: tegra: fix typos in comments

Liang He (2):
      drivers: tty: serial: Add missing of_node_put() in serial-tegra.c
      tty: serial: Fix refcount leak bug in ucc_uart.c

Lino Sanfilippo (8):
      serial: ar933x: Fix check for RS485 support
      serial: ar933x: Remove superfluous code in ar933x_config_rs485()
      serial: core, 8250: set RS485 termination GPIO in serial core
      serial: core: move sanitizing of RS485 delays into own function
      serial: core: sanitize RS485 delays read from device tree
      dt_bindings: rs485: Correct delay values
      serial: 8250_dwlib: remove redundant sanity check for RS485 flags
      serial: 8250: lpc18xx: Remove redundant sanity check for RS485 flags

Marek Szyprowski (1):
      tty: serial: samsung_tty: fix s3c24xx_serial_set_mctrl()

Michael Walle (1):
      earlycon: prevent multiple register_console()

Narendra Hadke (1):
      serial: mvebu-uart: uart2 error bits clearing

Sebastian Reichel (1):
      dt-bindings: serial: snps-dw-apb-uart: Add Rockchip RK3588

Shenwei Wang (1):
      serial: fsl_lpuart: zero out parity bit in CS7 mode

Sherry Sun (1):
      tty: serial: fsl_lpuart: correct the count of break characters

Tetsuo Handa (1):
      tty: vt: initialize unicode screen buffer

Thomas Bogendoerfer (1):
      serial: remove VR41XX serial driver

Tomer Maimon (1):
      dt-bindings: serial: 8250: Add npcm845 compatible string

Uwe Kleine-König (1):
      serial: 8250_fsl: Don't report FE, PE and OE twice

VAMSHI GAJJELA (1):
      serial: 8250_dw: Avoid pslverr on reading empty receiver fifo

Vijaya Krishna Nivarthi (1):
      tty: serial: qcom-geni-serial: Fix get_clk_div_rate() which otherwise could return a sub-optimal clock rate.

Wolfram Sang (1):
      dt-bindings: serial: renesas,hscif: Document r8a779f0 bindings

Xiang wangx (1):
      serial: kgdboc: Fix typo in comment

Xuezhi Zhang (1):
      tty: vt: convert sysfs snprintf to sysfs_emit

Yang Yingliang (1):
      serial: pic32: fix missing clk_disable_unprepare() on error in pic32_uart_startup()

Zhang Jiaming (1):
      serial: 8250_port: Fix spelling mistake

 Documentation/devicetree/bindings/serial/8250.yaml |   1 +
 .../devicetree/bindings/serial/mediatek,uart.yaml  | 120 +++
 .../devicetree/bindings/serial/mtk-uart.txt        |  59 --
 .../devicetree/bindings/serial/renesas,hscif.yaml  |   1 +
 .../devicetree/bindings/serial/rs485.yaml          |   4 +-
 .../bindings/serial/snps-dw-apb-uart.yaml          |   2 +
 Documentation/driver-api/serial/driver.rst         | 482 +----------
 Documentation/driver-api/serial/serial-rs485.rst   |  38 +-
 MAINTAINERS                                        |   3 +-
 arch/mips/ath79/early_printk.c                     |  17 +-
 drivers/accessibility/braille/braille_console.c    |   2 +-
 drivers/accessibility/speakup/main.c               |   2 +-
 drivers/accessibility/speakup/serialio.h           |   3 +-
 drivers/of/fdt.c                                   |   4 +-
 drivers/tty/amiserial.c                            |  20 +-
 drivers/tty/mips_ejtag_fdc.c                       |   4 +-
 drivers/tty/n_gsm.c                                | 757 ++++++++++++-----
 drivers/tty/n_tty.c                                |  92 +-
 drivers/tty/serial/8250/8250.h                     |  24 +-
 drivers/tty/serial/8250/8250_bcm2835aux.c          |   7 +-
 drivers/tty/serial/8250/8250_bcm7271.c             |  24 +-
 drivers/tty/serial/8250/8250_core.c                |   8 +-
 drivers/tty/serial/8250/8250_dw.c                  |  68 +-
 drivers/tty/serial/8250/8250_dwlib.c               | 152 +++-
 drivers/tty/serial/8250/8250_early.c               |   4 +-
 drivers/tty/serial/8250/8250_exar.c                |  25 +-
 drivers/tty/serial/8250/8250_fintek.c              |  31 +-
 drivers/tty/serial/8250/8250_fsl.c                 |   4 +-
 drivers/tty/serial/8250/8250_ingenic.c             |   2 +-
 drivers/tty/serial/8250/8250_lpc18xx.c             |  28 +-
 drivers/tty/serial/8250/8250_lpss.c                |   2 +-
 drivers/tty/serial/8250/8250_of.c                  |   1 +
 drivers/tty/serial/8250/8250_omap.c                |   7 +-
 drivers/tty/serial/8250/8250_pci.c                 | 135 ++-
 drivers/tty/serial/8250/8250_pericom.c             |   2 +-
 drivers/tty/serial/8250/8250_port.c                | 157 ++--
 drivers/tty/serial/8250/Kconfig                    |   1 +
 drivers/tty/serial/Kconfig                         |  18 +-
 drivers/tty/serial/Makefile                        |   1 -
 drivers/tty/serial/amba-pl011.c                    |  15 +-
 drivers/tty/serial/ar933x_uart.c                   |  27 +-
 drivers/tty/serial/atmel_serial.c                  | 103 +--
 drivers/tty/serial/earlycon.c                      |   3 +
 drivers/tty/serial/fsl_lpuart.c                    |  67 +-
 drivers/tty/serial/imx.c                           |  21 +-
 drivers/tty/serial/kgdboc.c                        |   2 +-
 drivers/tty/serial/max310x.c                       | 272 ++++--
 drivers/tty/serial/mcf.c                           |  10 +-
 drivers/tty/serial/meson_uart.c                    |   2 +-
 drivers/tty/serial/msm_serial.c                    | 550 ++++++------
 drivers/tty/serial/mux.c                           |   6 -
 drivers/tty/serial/mvebu-uart.c                    |  11 +
 drivers/tty/serial/omap-serial.c                   |  18 +-
 drivers/tty/serial/owl-uart.c                      |   2 +-
 drivers/tty/serial/pch_uart.c                      |   7 +-
 drivers/tty/serial/pic32_uart.c                    |   4 +-
 drivers/tty/serial/pmac_zilog.c                    |   1 -
 drivers/tty/serial/pxa.c                           |   5 +-
 drivers/tty/serial/qcom_geni_serial.c              |  88 +-
 drivers/tty/serial/rda-uart.c                      |   2 +-
 drivers/tty/serial/samsung_tty.c                   |  90 +-
 drivers/tty/serial/sc16is7xx.c                     |  10 +-
 drivers/tty/serial/serial-tegra.c                  |   5 +-
 drivers/tty/serial/serial_core.c                   | 452 ++++++----
 drivers/tty/serial/serial_mctrl_gpio.c             |  48 ++
 drivers/tty/serial/sifive.c                        |  10 -
 drivers/tty/serial/st-asc.c                        |   1 -
 drivers/tty/serial/stm32-usart.c                   |  79 +-
 drivers/tty/serial/stm32-usart.h                   |  68 --
 drivers/tty/serial/sunsu.c                         |   4 +-
 drivers/tty/serial/ucc_uart.c                      |   2 +
 drivers/tty/serial/vr41xx_siu.c                    | 934 ---------------------
 drivers/tty/tty_buffer.c                           |  59 +-
 drivers/tty/tty_io.c                               |   2 +-
 drivers/tty/tty_ioctl.c                            |   4 +
 drivers/tty/tty_port.c                             |  21 +
 drivers/tty/vt/Makefile                            |   2 +-
 drivers/tty/vt/consolemap.c                        | 684 ++++++++-------
 drivers/tty/vt/defkeymap.c_shipped                 |   6 +-
 drivers/tty/vt/selection.c                         |   3 +-
 drivers/tty/vt/vt.c                                |  16 +-
 drivers/usb/misc/sisusbvga/sisusb_con.c            |   2 +-
 drivers/video/console/vgacon.c                     |  12 +-
 drivers/video/fbdev/core/fbcon.c                   |   8 +-
 include/linux/console_struct.h                     |   6 +-
 include/linux/consolemap.h                         |  60 +-
 include/linux/serial.h                             |  15 +-
 include/linux/serial_8250.h                        |   7 +-
 include/linux/serial_core.h                        | 364 +++++++-
 include/linux/serial_s3c.h                         |   2 +-
 include/linux/tty_buffer.h                         |   1 +
 include/linux/tty_ldisc.h                          |  14 +
 include/linux/tty_port.h                           |   2 +
 include/uapi/asm-generic/termbits-common.h         |   1 +
 include/uapi/linux/serial.h                        |  20 +-
 include/uapi/linux/serial_core.h                   |   4 -
 include/uapi/linux/serial_reg.h                    |   4 +-
 97 files changed, 3353 insertions(+), 3197 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/mediatek,uart.yaml
 delete mode 100644 Documentation/devicetree/bindings/serial/mtk-uart.txt
 delete mode 100644 drivers/tty/serial/vr41xx_siu.c

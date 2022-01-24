Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4C84497937
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 08:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241669AbiAXHOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 02:14:34 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:58026 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233178AbiAXHOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 02:14:32 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 93F411F38B;
        Mon, 24 Jan 2022 07:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643008471; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=od/6bmpL5QY23AfGF50zkOPRQfxWP2Er4D6NaSlOBcA=;
        b=k3bKU8fFLZpLRPlvH8PgtY+6Pox0kfnD0hZOYr6XaOpX40VxwKZBn1DU7rLOsxldQANkkR
        OvbPnjz2aoi0WFckzk0HW253Rztk5aQjtpODKnwilbf4XDCEgFlThWUDcsYskL/ZAeNDd/
        RH2BK2mOQ4i/+AmLjrpeawBD0pZDQeo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643008471;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=od/6bmpL5QY23AfGF50zkOPRQfxWP2Er4D6NaSlOBcA=;
        b=lp2uHRblzKQ43eGjrdKAW2y582dmcS1pGlmcxGB41+DFh+JC5gwhCFVbmN253q1xzKKnzV
        LkwH1cJumS7vUFDA==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 58329A3B84;
        Mon, 24 Jan 2022 07:14:31 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        johan@kernel.org, Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 00/11] TTY patches for 5.18
Date:   Mon, 24 Jan 2022 08:14:19 +0100
Message-Id: <20220124071430.14907-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are small random cleanups and improvements I came across while
doing larger cleanups which are not finished yet. So flushing only these
from my queue at this very moment for 5.18.

Jiri Slaby (11):
  serial: core: clean up EXPORT_SYMBOLs
  serial: atmel_serial: include circ_buf.h
  tty: add kfifo to tty_port
  tty: tty_port_open, document shutdown vs failed activate
  mxser: fix xmit_buf leak in activate when LSR == 0xff
  mxser: use tty_port xmit_buf helpers
  mxser: switch from xmit_buf to kfifo
  serial: fsl_linflexuart: deduplicate character sending
  serial: fsl_linflexuart: don't call uart_write_wakeup() twice
  serial: make uart_console_write->putchar()'s character a char
  serial: mcf: use helpers in mcf_tx_chars()

 drivers/tty/goldfish.c                     |   2 +-
 drivers/tty/hvc/hvc_dcc.c                  |   2 +-
 drivers/tty/mxser.c                        | 109 +++++++++------------
 drivers/tty/serial/21285.c                 |   2 +-
 drivers/tty/serial/8250/8250_early.c       |   2 +-
 drivers/tty/serial/8250/8250_ingenic.c     |   2 +-
 drivers/tty/serial/8250/8250_port.c        |   2 +-
 drivers/tty/serial/altera_jtaguart.c       |   4 +-
 drivers/tty/serial/altera_uart.c           |   2 +-
 drivers/tty/serial/amba-pl010.c            |   2 +-
 drivers/tty/serial/amba-pl011.c            |   6 +-
 drivers/tty/serial/apbuart.c               |   2 +-
 drivers/tty/serial/ar933x_uart.c           |   2 +-
 drivers/tty/serial/arc_uart.c              |   2 +-
 drivers/tty/serial/atmel_serial.c          |   3 +-
 drivers/tty/serial/bcm63xx_uart.c          |   2 +-
 drivers/tty/serial/clps711x.c              |   2 +-
 drivers/tty/serial/digicolor-usart.c       |   2 +-
 drivers/tty/serial/dz.c                    |   2 +-
 drivers/tty/serial/earlycon-arm-semihost.c |   2 +-
 drivers/tty/serial/earlycon-riscv-sbi.c    |   2 +-
 drivers/tty/serial/fsl_linflexuart.c       |  50 ++++------
 drivers/tty/serial/fsl_lpuart.c            |   4 +-
 drivers/tty/serial/imx.c                   |   2 +-
 drivers/tty/serial/imx_earlycon.c          |   2 +-
 drivers/tty/serial/ip22zilog.c             |   2 +-
 drivers/tty/serial/lantiq.c                |   2 +-
 drivers/tty/serial/liteuart.c              |   2 +-
 drivers/tty/serial/lpc32xx_hs.c            |   2 +-
 drivers/tty/serial/mcf.c                   |   7 +-
 drivers/tty/serial/meson_uart.c            |   2 +-
 drivers/tty/serial/milbeaut_usio.c         |   2 +-
 drivers/tty/serial/mps2-uart.c             |   4 +-
 drivers/tty/serial/mvebu-uart.c            |   4 +-
 drivers/tty/serial/mxs-auart.c             |   2 +-
 drivers/tty/serial/omap-serial.c           |   2 +-
 drivers/tty/serial/owl-uart.c              |   2 +-
 drivers/tty/serial/pch_uart.c              |   2 +-
 drivers/tty/serial/pic32_uart.c            |   2 +-
 drivers/tty/serial/pmac_zilog.c            |   2 +-
 drivers/tty/serial/pxa.c                   |   2 +-
 drivers/tty/serial/qcom_geni_serial.c      |   2 +-
 drivers/tty/serial/rda-uart.c              |   2 +-
 drivers/tty/serial/sa1100.c                |   2 +-
 drivers/tty/serial/samsung_tty.c           |   4 +-
 drivers/tty/serial/sb1250-duart.c          |   2 +-
 drivers/tty/serial/sccnxp.c                |   2 +-
 drivers/tty/serial/serial_core.c           |  20 ++--
 drivers/tty/serial/serial_txx9.c           |   2 +-
 drivers/tty/serial/sh-sci.c                |   2 +-
 drivers/tty/serial/sifive.c                |   4 +-
 drivers/tty/serial/sprd_serial.c           |   2 +-
 drivers/tty/serial/st-asc.c                |   2 +-
 drivers/tty/serial/stm32-usart.c           |   2 +-
 drivers/tty/serial/sunsu.c                 |   2 +-
 drivers/tty/serial/sunzilog.c              |   4 +-
 drivers/tty/serial/uartlite.c              |   4 +-
 drivers/tty/serial/vr41xx_siu.c            |   2 +-
 drivers/tty/serial/vt8500_serial.c         |   2 +-
 drivers/tty/serial/xilinx_uartps.c         |   2 +-
 drivers/tty/serial/zs.c                    |   2 +-
 drivers/tty/tty_port.c                     |   9 +-
 include/linux/serial_core.h                |   2 +-
 include/linux/tty_port.h                   |   3 +
 64 files changed, 155 insertions(+), 180 deletions(-)

-- 
2.34.1


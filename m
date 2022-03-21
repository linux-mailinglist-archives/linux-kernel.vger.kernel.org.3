Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25EB94E2E1B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 17:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351233AbiCUQdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 12:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347933AbiCUQcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 12:32:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D36AF7F53;
        Mon, 21 Mar 2022 09:31:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB67861359;
        Mon, 21 Mar 2022 16:31:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E60F3C340E8;
        Mon, 21 Mar 2022 16:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647880269;
        bh=ctULTT0GSfG8hav4PRZOGF3yac+G3Xi+dkyRGpjQzpE=;
        h=From:To:Cc:Subject:Date:From;
        b=AQ9Fsw7AT7Geq902HBW7Lx9ReY1rCM/lHS5R/cMBrFv+KtQYiZc1X8DvWCqiqWZGg
         8fIDGv9Xy/MFvTX+tsFqjKBWRSVYpd87gYyqPCJJJ+5M3vrJ8krd/tbsoFDjNvaAaK
         oWH5ELXqmTb6bzYOrAGcG1MTXBQPLlx1WTijK7+WyCz+mV1KOWPV3MDlf0W6q+iKh9
         wtX6PpeWyF9h/wGbYsKijnW//e81uqQ7KHd9mdeLYOfrLqpafOHRsXuBG8vU9PCsAH
         8RJ/kmpQIP+e2xq6IKX/nt8v8+EkEo6SNuJkCNUVHqS5CPVdCR2GtKT5fVPEXj+nw/
         BpednmGvePkpA==
Received: by pali.im (Postfix)
        id 062C0A5B; Mon, 21 Mar 2022 17:31:06 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] serial: Fix support for UPF_SPD_* flags
Date:   Mon, 21 Mar 2022 17:30:52 +0100
Message-Id: <20220321163055.4058-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support for UPF_SPD_* flags is currently broken in more drivers for two
reasons. First one is that uart_update_timeout() function does not
calculate timeout for UPF_SPD_CUST flag correctly. Second reason is that
userspace termios structre is modified by most drivers after each
TIOCSSERIAL or TCSETS call to discard activation of UPF_SPD_* flags.

Reproducer for these issues:

  #include <termios.h>
  #include <sys/ioctl.h>
  #include <asm/ioctls.h>
  #include <linux/serial.h>

  static unsigned cdiv(unsigned a, unsigned b) {
    if (!b) return b;
    return (a + (b/2)) / b;
  }

  void set_active_spd_cust_baud(int fd, unsigned baudrate) {
    struct serial_struct serial;
    struct termios termios;
    tcgetattr(fd, &termios);
    ioctl(fd, TIOCGSERIAL, &serial);
    serial.flags &= ~ASYNC_SPD_MASK;
    serial.flags |= ASYNC_SPD_CUST;
    serial.custom_divisor = cdiv(serial.baud_base, baudrate);
    ioctl(fd, TIOCSSERIAL, &serial);
    cfsetspeed(&termios, B38400);
    tcsetattr(fd, TCSANOW, &termios);
  }

  int is_spd_cust_active(int fd) {
    struct serial_struct serial;
    struct termios termios;
    tcgetattr(fd, &termios);
    ioctl(fd, TIOCGSERIAL, &serial);
    return
      (serial.flags & ASYNC_SPD_MASK) == ASYNC_SPD_CUST &&
      cfgetospeed(&termios) == B38400;
  }

(error handling was ommited for simplification)

After calling set_active_spd_cust_baud() function SPD custom divisor
should be active and therefore is_spd_cust_active() should return true.

But it is not active (cfgetospeed does not return B38400) and this patch
series should fix it. I have tested it with 8250 driver.


Originally Johan Hovold reported that there may be issue with these
ASYNC_SPD_FLAGS in email:
https://lore.kernel.org/linux-serial/20211007133146.28949-1-johan@kernel.org/


Johan, Greg, could you please test these patches if there is not any
regression?


Pali Rohár (3):
  serial: core: Document why UPF_SPD_CUST is not handled in
    uart_get_baud_rate()
  serial: core: Fix function uart_update_timeout() to handle
    UPF_SPD_CUST flag
  serial: Fix support for UPF_SPD_* flags in serial drivers

 drivers/tty/serial/21285.c          |  2 +-
 drivers/tty/serial/8250/8250_mtk.c  |  2 +-
 drivers/tty/serial/8250/8250_omap.c |  2 +-
 drivers/tty/serial/8250/8250_port.c |  2 +-
 drivers/tty/serial/altera_uart.c    |  2 +-
 drivers/tty/serial/ar933x_uart.c    |  2 +-
 drivers/tty/serial/arc_uart.c       |  2 +-
 drivers/tty/serial/dz.c             |  2 +-
 drivers/tty/serial/imx.c            |  3 +-
 drivers/tty/serial/lantiq.c         |  2 +-
 drivers/tty/serial/lpc32xx_hs.c     |  2 +-
 drivers/tty/serial/men_z135_uart.c  |  2 +-
 drivers/tty/serial/mps2-uart.c      |  2 +-
 drivers/tty/serial/msm_serial.c     |  2 +-
 drivers/tty/serial/mvebu-uart.c     |  2 +-
 drivers/tty/serial/owl-uart.c       |  2 +-
 drivers/tty/serial/pch_uart.c       |  2 +-
 drivers/tty/serial/pic32_uart.c     |  2 +-
 drivers/tty/serial/rda-uart.c       |  2 +-
 drivers/tty/serial/rp2.c            |  2 +-
 drivers/tty/serial/sccnxp.c         |  2 +-
 drivers/tty/serial/serial-tegra.c   |  2 +-
 drivers/tty/serial/serial_core.c    | 76 ++++++++++++++++++++++++++++-
 drivers/tty/serial/sprd_serial.c    |  2 +-
 drivers/tty/serial/timbuart.c       |  2 +-
 drivers/tty/serial/vt8500_serial.c  |  2 +-
 drivers/tty/serial/xilinx_uartps.c  |  2 +-
 include/linux/serial_core.h         |  2 +
 28 files changed, 103 insertions(+), 28 deletions(-)

-- 
2.20.1


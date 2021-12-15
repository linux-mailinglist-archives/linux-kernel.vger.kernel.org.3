Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2C44753F7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 08:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240632AbhLOH6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 02:58:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235592AbhLOH6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 02:58:40 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1102C061574;
        Tue, 14 Dec 2021 23:58:39 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id o4so19958438pfp.13;
        Tue, 14 Dec 2021 23:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=t5evHBPBS2G9SDCjwG+itx/1b630mANVexHP2C5AUCQ=;
        b=b2qVwXOZEQSL+rnJrA2ylV/bzDUKbSX8bGookqJg0BNLKPb8ueySgHRoz8KhdsO96H
         urWMEx7TLNcbln0b5RdcUPG0ecn44CO7vl+6KwG5OFf9GDDS3QylhMt1f+6Z9DsHUwEq
         YiSq0hzpQJaoMUutf4LsnyHTmln9uOu8O9qhW8+5ZGxofIfLKvTwbEyU+7Db2l+0XkQ0
         fz0LdKF0Lso7IgaHoFzYEnb59wlVh9Rosx9D4TrVN+0Anv3D6Vjh71gW/sfmm+T7Hayo
         KquHCKJjlNWKE4bFt6rGSO7BgHArPwF0j3YE9zUuQFcRzTJkp86kIy9d/ndoRVA2FJqr
         m5Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=t5evHBPBS2G9SDCjwG+itx/1b630mANVexHP2C5AUCQ=;
        b=cHwdn+sPXfrgEYOlvhYF/5x3zNeop/OW9EdCVp9cSZfiBhCTuEooZfUlovBaJl0MrL
         KUd7V1TBdNTJumon7MwybFtAKydWpFnVuBg3yF7tLnCv3pxDt/QikpZahE/McdGdX8xf
         pwSsEiRq/kyaCY7PcCRFHEauxZXPHm9t7SGHiI5yTWW566xIhAgL4PgR7J9z4DDSlxoY
         0hkvClg0lWl6C+uVEW+7JEnzBHHTWYAaie7Uop6ce+ncgZ37dFWPNsulDqj28WBQX1GB
         9a73RwEQrBum8S40TXw5q8wE4S0RFreLG6zcK4V1dFQgVBy2Sx/XarV8SuFzYPaugFqR
         tmDQ==
X-Gm-Message-State: AOAM531ZhE6HhxMHg2/gXTcX9bxH62L/dEeznr3+moW5LiCr8UEDBE2T
        e+r5HxhXP/bpUhXsGixdDR0=
X-Google-Smtp-Source: ABdhPJwzT8g/dTl6M8Jf/DL+idNTs5kKFkBZClo6StaKK/pyVU/yin8yPI5D3ghiQKQih9zi6V2ioQ==
X-Received: by 2002:a65:5bce:: with SMTP id o14mr6950781pgr.347.1639555119329;
        Tue, 14 Dec 2021 23:58:39 -0800 (PST)
Received: from localhost (59-120-186-245.hinet-ip.hinet.net. [59.120.186.245])
        by smtp.gmail.com with ESMTPSA id hk18sm4935266pjb.20.2021.12.14.23.58.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Dec 2021 23:58:38 -0800 (PST)
From:   "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
X-Google-Original-From: "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        peter_hong@fintek.com.tw
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        rel+kernel@agilox.net,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
Subject: [PATCH V1 1/1] serial: 8250_fintek: Fix garbled text for console
Date:   Wed, 15 Dec 2021 15:58:35 +0800
Message-Id: <20211215075835.2072-1-hpeter+linux_kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit fab8a02b73eb ("serial: 8250_fintek: Enable high speed mode on Fintek F81866")
introduced support to use high baudrate with Fintek SuperIO UARTs. It'll
change clocksources when the UART probed.

But when user add kernel parameter "console=ttyS0,115200 console=tty0" to make
the UART as console output, the console will output garbled text after the
following kernel message.

[    3.681188] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled

The issue is occurs in following step:
	probe_setup_port() -> fintek_8250_goto_highspeed()

It change clocksource from 115200 to 921600 with wrong time, it should change
clocksource in set_termios() not in probed. The following 3 patches are
implemented change clocksource in fintek_8250_set_termios().

Commit 58178914ae5b ("serial: 8250_fintek: UART dynamic clocksource on Fintek F81216H")
Commit 195638b6d44f ("serial: 8250_fintek: UART dynamic clocksource on Fintek F81866")
Commit 423d9118c624 ("serial: 8250_fintek: Add F81966 Support")

Due to the high baud rate had implemented above 3 patches and the patch
Commit fab8a02b73eb ("serial: 8250_fintek: Enable high speed mode on Fintek F81866")
is bugged, So this patch will remove it.

Fixes: fab8a02b73eb ("serial: 8250_fintek: Enable high speed mode on Fintek F81866")
Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
---
 drivers/tty/serial/8250/8250_fintek.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_fintek.c b/drivers/tty/serial/8250/8250_fintek.c
index 31c9e83ea3cb..251f0018ae8c 100644
--- a/drivers/tty/serial/8250/8250_fintek.c
+++ b/drivers/tty/serial/8250/8250_fintek.c
@@ -290,25 +290,6 @@ static void fintek_8250_set_max_fifo(struct fintek_8250 *pdata)
 	}
 }
 
-static void fintek_8250_goto_highspeed(struct uart_8250_port *uart,
-			      struct fintek_8250 *pdata)
-{
-	sio_write_reg(pdata, LDN, pdata->index);
-
-	switch (pdata->pid) {
-	case CHIP_ID_F81966:
-	case CHIP_ID_F81866: /* set uart clock for high speed serial mode */
-		sio_write_mask_reg(pdata, F81866_UART_CLK,
-			F81866_UART_CLK_MASK,
-			F81866_UART_CLK_14_769MHZ);
-
-		uart->port.uartclk = 921600 * 16;
-		break;
-	default: /* leave clock speed untouched */
-		break;
-	}
-}
-
 static void fintek_8250_set_termios(struct uart_port *port,
 				    struct ktermios *termios,
 				    struct ktermios *old)
@@ -430,7 +411,6 @@ static int probe_setup_port(struct fintek_8250 *pdata,
 
 				fintek_8250_set_irq_mode(pdata, level_mode);
 				fintek_8250_set_max_fifo(pdata);
-				fintek_8250_goto_highspeed(uart, pdata);
 
 				fintek_8250_exit_key(addr[i]);
 
-- 
2.17.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51994C28B0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 10:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233049AbiBXJzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 04:55:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbiBXJzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 04:55:52 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE9C285737;
        Thu, 24 Feb 2022 01:55:22 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 683A71F43D;
        Thu, 24 Feb 2022 09:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645696521; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=QX4pwJ95VPUYGIdo+wEwkfjIMCQstOundOUIBWQsseE=;
        b=Vf6ONM1AFqAP0pA7ChpaUKhyJrQcnHs6cL/AN8y4wnPSs+AmZ2GQFgD0wfRo6OKFJ4Xbes
        cSW+uGZkUO32fk2xL17oXkAuQX+JZaQcSOH/rbeVgcMUWLonbO5TqdQKdXikqivRwYL4oh
        jiWX3OxEEU4Vgqn00FpMSzq1J4kTx1g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645696521;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=QX4pwJ95VPUYGIdo+wEwkfjIMCQstOundOUIBWQsseE=;
        b=SeSuiXULhLS6cjrSADKC3dfkFEihDSExwnkc+n5ySfHnh5V6zUvtckklW0VhE8F6JJFi8h
        Cyx+ht1KpZN+DNBw==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 3DF24A3B89;
        Thu, 24 Feb 2022 09:55:21 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 0/5] UART_LCR_WLEN cleanups
Date:   Thu, 24 Feb 2022 10:55:17 +0100
Message-Id: <20220224095517.30872-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many drivers currently do:
   switch (cflag & CSIZE) {
   case CS5:
           lcr = UART_LCR_WLEN5;
           break;
   case CS6:
           lcr = UART_LCR_WLEN6;
           break;
   case CS7:
           lcr = UART_LCR_WLEN7;
           break;
   default:
   case CS8:
           lcr = UART_LCR_WLEN8;
           break;
   }

We can simplify it to:
   lcr = UART_LCR_WLEN(tty_get_char_size(cflag));
if we define UART_LCR_WLEN() properly first.

So UART_LCR_WLEN is defined in this series and all such drivers are
converted too.

We could go even further: to define something like uart_compute_LCR()
and compute there whole LCR based even on parity+stop fields in cflag. I
will try if it is worth it later. But this series on its own drops some
duplicated lines already.

Jiri Slaby (5):
  tty: serial: define UART_LCR_WLEN() macro
  tty: serial: make use of UART_LCR_WLEN() + tty_get_char_size()
  USB: serial: make use of UART_LCR_WLEN() + tty_get_char_size()
  sdio_uart: make use of UART_LCR_WLEN() + tty_get_char_size()
  mxser: make use of UART_LCR_WLEN() + tty_get_char_size()

 drivers/mmc/core/sdio_uart.c        | 16 +---------------
 drivers/tty/mxser.c                 | 16 +---------------
 drivers/tty/serial/8250/8250_omap.c | 16 +---------------
 drivers/tty/serial/8250/8250_port.c | 16 +---------------
 drivers/tty/serial/jsm/jsm_cls.c    | 16 +---------------
 drivers/tty/serial/jsm/jsm_neo.c    | 16 +---------------
 drivers/tty/serial/omap-serial.c    | 16 +---------------
 drivers/tty/serial/pxa.c            | 16 +---------------
 drivers/tty/serial/serial-tegra.c   | 22 ++++------------------
 drivers/tty/serial/vr41xx_siu.c     | 15 +--------------
 drivers/usb/serial/ark3116.c        | 17 ++---------------
 drivers/usb/serial/f81232.c         | 16 +---------------
 drivers/usb/serial/f81534.c         | 16 +---------------
 drivers/usb/serial/mos7720.c        | 20 +-------------------
 drivers/usb/serial/quatech2.c       | 16 +---------------
 drivers/usb/serial/ssu100.c         | 16 +---------------
 include/uapi/linux/serial_reg.h     |  1 +
 17 files changed, 21 insertions(+), 246 deletions(-)

-- 
2.35.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07F9052A00F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 13:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244171AbiEQLIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 07:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344934AbiEQLIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 07:08:23 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80DDC60FB;
        Tue, 17 May 2022 04:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652785697; x=1684321697;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3RnQRuR6bhTHb3WuNEk9N0DsLlzhv/5aX1wkEj3xq6s=;
  b=Ht5bA9U4XnDJfoFMvPNZjuXu5yGESGfyaFAS3JclNdx8Z/8QOnMGd4Db
   J8fioTKq08UFWu+YReff+hWKH7fEyLngZ9n9qgbssJUYfnq7eQLlpPQk1
   wcErd6akNGsnCm7N3wFyBmUnmOV7aun2Viig0bwGNRu8nkQwptE5CUGog
   OfjwBhj2yJbqVVY2dNB/mdYm5C6VndSm8yZIMZozuX1KFcKaS+hAL2+ig
   6VPhvfEyaY8WeQm8zoi/YwlAXJn91hoqYrr1O4/fZjf3HdRPwfLgZrS5c
   qJKRQbl0N1Fy0HsN+fHF+w2kJX0UnM+Fse3GYMGQp9GfndOhILN/KZWFz
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="271268774"
X-IronPort-AV: E=Sophos;i="5.91,232,1647327600"; 
   d="scan'208";a="271268774"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 04:08:17 -0700
X-IronPort-AV: E=Sophos;i="5.91,232,1647327600"; 
   d="scan'208";a="568831099"
Received: from mtarral-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.52.88])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 04:08:14 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 6/9] serial: sifive: Sanitize CSIZE and c_iflag
Date:   Tue, 17 May 2022 14:07:34 +0300
Message-Id: <20220517110737.37148-7-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220517110737.37148-1-ilpo.jarvinen@linux.intel.com>
References: <20220517110737.37148-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only CS8 is supported but CSIZE was not sanitized to CS8.

Set CSIZE correctly so that userspace knows the effective value.
Incorrect CSIZE also results in miscalculation of the frame bits in
tty_get_char_size() or in its predecessor where the roughly the same
code is directly within uart_update_timeout().

Similarly, INPCK, PARMRK, and BRKINT are reported textually unsupported
but were not cleared in termios c_iflag which is the machine-readable
format.

Cc: Paul Walmsley <paul.walmsley@sifive.com>
Fixes: 45c054d0815b (tty: serial: add driver for the SiFive UART)
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/sifive.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sifive.c b/drivers/tty/serial/sifive.c
index f5ac14c384c4..c1c0fb9c1822 100644
--- a/drivers/tty/serial/sifive.c
+++ b/drivers/tty/serial/sifive.c
@@ -666,12 +666,16 @@ static void sifive_serial_set_termios(struct uart_port *port,
 	int rate;
 	char nstop;
 
-	if ((termios->c_cflag & CSIZE) != CS8)
+	if ((termios->c_cflag & CSIZE) != CS8) {
 		dev_err_once(ssp->port.dev, "only 8-bit words supported\n");
+		termios->c_cflag &= ~CSIZE;
+		termios->c_cflag |= CS8;
+	}
 	if (termios->c_iflag & (INPCK | PARMRK))
 		dev_err_once(ssp->port.dev, "parity checking not supported\n");
 	if (termios->c_iflag & BRKINT)
 		dev_err_once(ssp->port.dev, "BREAK detection not supported\n");
+	termios->c_iflag &= ~(INPCK|PARMRK|BRKINT);
 
 	/* Set number of stop bits */
 	nstop = (termios->c_cflag & CSTOPB) ? 2 : 1;
-- 
2.30.2


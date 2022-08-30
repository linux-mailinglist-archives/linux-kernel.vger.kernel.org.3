Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C4C5A5E9E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 10:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbiH3IvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 04:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbiH3IuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 04:50:25 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A615F4D;
        Tue, 30 Aug 2022 01:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661849407; x=1693385407;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+zvycWgHswi1PPV0RnXSYc/K43LbVY11y+f+/3GNfko=;
  b=DrF8CrfrKWH2GYBJJKgEpms4Q8xRoMgM81F6lSwDFdpYMjOEWulUzv19
   yZuGLCnUGTGvrNLSpSviZjep2S6sKb5hSyMI0pLdYGg+KqAIPc+O/p/vh
   O5G7ub1NkkgPGwqQdu0wSD8Hf3MCYIhNEGFZyxMN/d5frib6wg7tAfA2T
   7z6qP8cJeRQqV+cOG9Otcl8fX1NFgM78ffLx2lDN/IWwfF4ab7FQW2q3I
   W+5geqxhB8gTqItiBXrcdmDPMfeXWeWAUwRxEDxtTB6/x9aZ3sV503fzh
   N7Kc5BIRLGTJX4RL660HldqI90cSSSu8A218nEfXUPL/nj/FRA8PBcOTQ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="293866357"
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="293866357"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 01:50:03 -0700
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="672761927"
Received: from arnesgom-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.54.235])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 01:50:00 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v2 5/5] serial: tegra: Remove custom frame size calculation
Date:   Tue, 30 Aug 2022 11:49:25 +0300
Message-Id: <20220830084925.5608-6-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220830084925.5608-1-ilpo.jarvinen@linux.intel.com>
References: <20220830084925.5608-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The number of bits can be calculated using tty_get_frame_size(), no
need for the driver to do it on its own.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/serial-tegra.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index ad4f3567ff90..5a56bd20abcd 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -1278,7 +1278,6 @@ static void tegra_uart_set_termios(struct uart_port *u,
 	unsigned long flags;
 	unsigned int lcr;
 	unsigned char char_bits;
-	int symb_bit = 1;
 	struct clk *parent_clk = clk_get_parent(tup->uart_clk);
 	unsigned long parent_clk_rate = clk_get_rate(parent_clk);
 	int max_divider = (tup->cdata->support_clk_src_div) ? 0x7FFF : 0xFFFF;
@@ -1305,7 +1304,6 @@ static void tegra_uart_set_termios(struct uart_port *u,
 	termios->c_cflag &= ~CMSPAR;
 
 	if ((termios->c_cflag & PARENB) == PARENB) {
-		symb_bit++;
 		if (termios->c_cflag & PARODD) {
 			lcr |= UART_LCR_PARITY;
 			lcr &= ~UART_LCR_EPAR;
@@ -1318,22 +1316,18 @@ static void tegra_uart_set_termios(struct uart_port *u,
 	}
 
 	char_bits = tty_get_char_size(termios->c_cflag);
-	symb_bit += char_bits;
 	lcr &= ~UART_LCR_WLEN8;
 	lcr |= UART_LCR_WLEN(char_bits);
 
 	/* Stop bits */
-	if (termios->c_cflag & CSTOPB) {
+	if (termios->c_cflag & CSTOPB)
 		lcr |= UART_LCR_STOP;
-		symb_bit += 2;
-	} else {
+	else
 		lcr &= ~UART_LCR_STOP;
-		symb_bit++;
-	}
 
 	tegra_uart_write(tup, lcr, UART_LCR);
 	tup->lcr_shadow = lcr;
-	tup->symb_bit = symb_bit;
+	tup->symb_bit = tty_get_frame_size(termios->c_cflag);
 
 	/* Baud rate. */
 	baud = uart_get_baud_rate(u, termios, oldtermios,
-- 
2.30.2


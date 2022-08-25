Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 508BD5A0C15
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 10:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238045AbiHYI65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 04:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237510AbiHYI6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 04:58:46 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9CBA896F;
        Thu, 25 Aug 2022 01:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661417917; x=1692953917;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xWcqRqK9GSZt9NznWIFPcoPcb1DvRs46teeJkfDwcKk=;
  b=BH9+8xdaFNVEJwYngzSF0QvALLrV34bK68anUupewcQyt+0afe3tW7uq
   Fi8iwBU2s88gQ9J6XPEqPebIn81iDOT5XjrkdKPdmWEcMdQQI17tVjzrV
   VHu6Rsm0WvtMYym/d3/zMGuIRb+U3JK7/pvovbEx+nej5NtEn7fOZn7jL
   Z1LWZSvTkFQ/Vjg2bHFF6QBHOX+ucWIgkw726BHtTB7em+/wiThLDfMyn
   J6062YIYL6Ng4mTHhXMPj9qaS0U0x9oq4fhved3QQUuIoX3h14Zug4YOZ
   inMVEin6H09B6DUyXYo5RU+jOFJEdoBEnpMwGMPHYgLCZeI9gc9vE1zil
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="273941445"
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; 
   d="scan'208";a="273941445"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 01:58:37 -0700
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; 
   d="scan'208";a="670893955"
Received: from mblazque-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.44.101])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 01:58:34 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 5/5] serial: tegra: Remove custom frame size calculation
Date:   Thu, 25 Aug 2022 11:58:10 +0300
Message-Id: <20220825085810.7290-6-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220825085810.7290-1-ilpo.jarvinen@linux.intel.com>
References: <20220825085810.7290-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The number of bits can be calculated using tty_get_frame_size(), no
need for the driver to do it on its own.

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


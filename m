Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C44915A0C07
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 10:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236760AbiHYI6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 04:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236094AbiHYI60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 04:58:26 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A152A895E;
        Thu, 25 Aug 2022 01:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661417905; x=1692953905;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/0WWmiRPF3uFY9MzfKxoOf7bMrDf+HChU7RPdgkXq9c=;
  b=VhCPI65E2tTUr1DMvkpSgUZXfJoVDbFqvK9y/neg/5RsKRbjyIUbiRYP
   naKtQiv874kQ0NhrN/EUCCR8JZpViTrp53A26CSt8gO929ZHCzufEauA2
   NkCE3GDILiRTMUQs6bCBauzsge+A/lYqbiTIlHB//ZaJO/p4nivSZ5kui
   j7dMlHvZjrSE1yY1LTfUHauJHFGH0/B0D5oX517GoAK20eUjgtCNz1MuP
   H3R+zi+gQ4VLjP584qHwZRa9Jft2jRld9VXOY5J5NqwWq7jFmFZ90Sg8v
   LCQtBMBMTKBGTM5BpKV3yrNGGWZJveEsxko0g8bu/GGUK4GFVJE0St4Pm
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="273941384"
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; 
   d="scan'208";a="273941384"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 01:58:24 -0700
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; 
   d="scan'208";a="670893909"
Received: from mblazque-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.44.101])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 01:58:22 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, Timur Tabi <timur@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/5] serial: ucc_uart: Remove custom frame size calculation
Date:   Thu, 25 Aug 2022 11:58:06 +0300
Message-Id: <20220825085810.7290-2-ilpo.jarvinen@linux.intel.com>
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

Also remove a comment on number of bits that doesn't match the code nor
the comment on ucc_uart_pram's rx_length ("minus 1" part differs). That
comment seems a verbatim copy of that in cpm_uart/cpm_uart_core.c
anyway so perhaps it was just copied over w/o much thinking.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/ucc_uart.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/tty/serial/ucc_uart.c b/drivers/tty/serial/ucc_uart.c
index 3cc9ef08455c..7331964163c5 100644
--- a/drivers/tty/serial/ucc_uart.c
+++ b/drivers/tty/serial/ucc_uart.c
@@ -853,13 +853,6 @@ static void qe_uart_set_termios(struct uart_port *port,
 	u16 upsmr = ioread16be(&uccp->upsmr);
 	struct ucc_uart_pram __iomem *uccup = qe_port->uccup;
 	u16 supsmr = ioread16be(&uccup->supsmr);
-	u8 char_length = 2; /* 1 + CL + PEN + 1 + SL */
-
-	/* Character length programmed into the mode register is the
-	 * sum of: 1 start bit, number of data bits, 0 or 1 parity bit,
-	 * 1 or 2 stop bits, minus 1.
-	 * The value 'bits' counts this for us.
-	 */
 
 	/* byte size */
 	upsmr &= UCC_UART_UPSMR_CL_MASK;
@@ -869,22 +862,18 @@ static void qe_uart_set_termios(struct uart_port *port,
 	case CS5:
 		upsmr |= UCC_UART_UPSMR_CL_5;
 		supsmr |= UCC_UART_SUPSMR_CL_5;
-		char_length += 5;
 		break;
 	case CS6:
 		upsmr |= UCC_UART_UPSMR_CL_6;
 		supsmr |= UCC_UART_SUPSMR_CL_6;
-		char_length += 6;
 		break;
 	case CS7:
 		upsmr |= UCC_UART_UPSMR_CL_7;
 		supsmr |= UCC_UART_SUPSMR_CL_7;
-		char_length += 7;
 		break;
 	default:	/* case CS8 */
 		upsmr |= UCC_UART_UPSMR_CL_8;
 		supsmr |= UCC_UART_SUPSMR_CL_8;
-		char_length += 8;
 		break;
 	}
 
@@ -892,13 +881,11 @@ static void qe_uart_set_termios(struct uart_port *port,
 	if (termios->c_cflag & CSTOPB) {
 		upsmr |= UCC_UART_UPSMR_SL;
 		supsmr |= UCC_UART_SUPSMR_SL;
-		char_length++;  /* + SL */
 	}
 
 	if (termios->c_cflag & PARENB) {
 		upsmr |= UCC_UART_UPSMR_PEN;
 		supsmr |= UCC_UART_SUPSMR_PEN;
-		char_length++;  /* + PEN */
 
 		if (!(termios->c_cflag & PARODD)) {
 			upsmr &= ~(UCC_UART_UPSMR_RPM_MASK |
@@ -953,7 +940,7 @@ static void qe_uart_set_termios(struct uart_port *port,
 	iowrite16be(upsmr, &uccp->upsmr);
 	if (soft_uart) {
 		iowrite16be(supsmr, &uccup->supsmr);
-		iowrite8(char_length, &uccup->rx_length);
+		iowrite8(tty_get_frame_size(termios->c_cflag), &uccup->rx_length);
 
 		/* Soft-UART requires a 1X multiplier for TX */
 		qe_setbrg(qe_port->us_info.rx_clock, baud, 16);
-- 
2.30.2


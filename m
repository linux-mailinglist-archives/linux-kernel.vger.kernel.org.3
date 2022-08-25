Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9879D5A0C16
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 10:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237365AbiHYI6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 04:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236540AbiHYI62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 04:58:28 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C928A895E;
        Thu, 25 Aug 2022 01:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661417907; x=1692953907;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PyKfNVg9kX6GwGqHuc+KZ4p4tdSz9WytUz5q38WWqy0=;
  b=lJho7PdkpJzIywNxNOo+MTb91okXtrnLLO+0Os5ICzcqbvIHTipp4loE
   dkCyFSeAxvNPhsvexOx9bWYFUnjdlNc3aXNG5hWqSdxy3T6W1fp1b0jTK
   rOTILvt4gW+CEBqLls5B/090FXDHGx3UtLyv6gGqFwcyT0pZHY6KbCgvT
   +jgxDg8TZa6MathJUloyrXDi3OT5uqtVs82li1QJQP+6d4TOWCKZciBlI
   kpqw4URVkrMe6kBkPHTPH8O55rOOvlUOPgMNj+wWJLl9duSAeU4yRKvxl
   AKRU+AXDQKdU2xmD8LfC+WHkJMDSXuLlCaS67Q1TVWpRpx2RH8PGWPC/R
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="273941395"
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; 
   d="scan'208";a="273941395"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 01:58:27 -0700
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; 
   d="scan'208";a="670893918"
Received: from mblazque-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.44.101])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 01:58:25 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 2/5] serial: cpm_uart: Remove custom frame size calculation
Date:   Thu, 25 Aug 2022 11:58:07 +0300
Message-Id: <20220825085810.7290-3-ilpo.jarvinen@linux.intel.com>
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

The number of bits can be calculated using helpers in core, no need for
the driver to do it on its own.

The mode register is programmed with frame bits minus 1, rearrange the
comments related to that "feature" closer to the actual write.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/cpm_uart/cpm_uart_core.c | 28 ++++++---------------
 1 file changed, 7 insertions(+), 21 deletions(-)

diff --git a/drivers/tty/serial/cpm_uart/cpm_uart_core.c b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
index db07d6a5d764..96c6ee379c03 100644
--- a/drivers/tty/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
@@ -489,7 +489,6 @@ static void cpm_uart_set_termios(struct uart_port *port,
 	int baud;
 	unsigned long flags;
 	u16 cval, scval, prev_mode;
-	int bits, sbits;
 	struct uart_cpm_port *pinfo =
 		container_of(port, struct uart_cpm_port, port);
 	smc_t __iomem *smcp = pinfo->smcp;
@@ -515,28 +514,17 @@ static void cpm_uart_set_termios(struct uart_port *port,
 	if (maxidl > 0x10)
 		maxidl = 0x10;
 
-	/* Character length programmed into the mode register is the
-	 * sum of: 1 start bit, number of data bits, 0 or 1 parity bit,
-	 * 1 or 2 stop bits, minus 1.
-	 * The value 'bits' counts this for us.
-	 */
 	cval = 0;
 	scval = 0;
 
-	/* byte size */
-	bits = tty_get_char_size(termios->c_cflag);
-	sbits = bits - 5;
-
 	if (termios->c_cflag & CSTOPB) {
 		cval |= SMCMR_SL;	/* Two stops */
 		scval |= SCU_PSMR_SL;
-		bits++;
 	}
 
 	if (termios->c_cflag & PARENB) {
 		cval |= SMCMR_PEN;
 		scval |= SCU_PSMR_PEN;
-		bits++;
 		if (!(termios->c_cflag & PARODD)) {
 			cval |= SMCMR_PM_EVEN;
 			scval |= (SCU_PSMR_REVP | SCU_PSMR_TEVP);
@@ -580,11 +568,6 @@ static void cpm_uart_set_termios(struct uart_port *port,
 
 	spin_lock_irqsave(&port->lock, flags);
 
-	/* Start bit has not been added (so don't, because we would just
-	 * subtract it later), and we need to add one for the number of
-	 * stops bits (there is always at least one).
-	 */
-	bits++;
 	if (IS_SMC(pinfo)) {
 		/*
 		 * MRBLR can be changed while an SMC/SCC is operating only
@@ -604,13 +587,16 @@ static void cpm_uart_set_termios(struct uart_port *port,
 		 */
 		prev_mode = in_be16(&smcp->smc_smcmr) & (SMCMR_REN | SMCMR_TEN);
 		/* Output in *one* operation, so we don't interrupt RX/TX if they
-		 * were already enabled. */
-		out_be16(&smcp->smc_smcmr, smcr_mk_clen(bits) | cval |
-		    SMCMR_SM_UART | prev_mode);
+		 * were already enabled.
+		 * Character length programmed into the register is frame bits minus 1.
+		 */
+		out_be16(&smcp->smc_smcmr, smcr_mk_clen(tty_get_frame_size(termios->c_cflag) - 1) |
+					   cval | SMCMR_SM_UART | prev_mode);
 	} else {
 		out_be16(&pinfo->sccup->scc_genscc.scc_mrblr, pinfo->rx_fifosize);
 		out_be16(&pinfo->sccup->scc_maxidl, maxidl);
-		out_be16(&sccp->scc_psmr, (sbits << 12) | scval);
+		out_be16(&sccp->scc_psmr, (UART_LCR_WLEN(tty_get_char_size(termios->c_cflag))
+					   << 12) | scval);
 	}
 
 	if (pinfo->clk)
-- 
2.30.2


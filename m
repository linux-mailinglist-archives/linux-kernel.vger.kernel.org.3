Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 296805A5E97
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 10:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbiH3Iua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 04:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231717AbiH3IuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 04:50:08 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B59F9FCB;
        Tue, 30 Aug 2022 01:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661849395; x=1693385395;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tp8AdUXc/CyFpAtBRv1FRHZ47fXqPlu3sywMVyMvX4w=;
  b=ma41IJYTagrVRN3J6+HhPQEfCImzD/9G+8klJLl9img1l7QPqXgjYZY9
   UCeJztvWOjkYw6YfvaS2VZYznOX22yg3rqcpQs29AiiPYslG542DDSUSP
   MH25SiZ82J3TXu/9gI3uBMCdiLPoVZr26eY8vLB6I2JSXoQUa91gs0ubo
   iduq+QoNa3Pw6sAx/eQTayFdnomYzpFeygGXqoyhWrdWH7CdIG1vcJO7u
   cJW4Hs8zRagFbgRRhfvMcIBCmZafSOxUS3ncy2lGO+/z2owjHAemabHcU
   vD7s2BWi9PBb3RsIPLeTEJ7W1u18CEB3ifyQEpMx2d3YMGzCg10IuKX91
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="293866316"
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="293866316"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 01:49:52 -0700
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="672761862"
Received: from arnesgom-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.54.235])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 01:49:49 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v2 2/5] serial: cpm_uart: Remove custom frame size calculation
Date:   Tue, 30 Aug 2022 11:49:22 +0300
Message-Id: <20220830084925.5608-3-ilpo.jarvinen@linux.intel.com>
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

The number of bits can be calculated using helpers in core, no need for
the driver to do it on its own.

The mode register is programmed with frame bits minus 1, rearrange the
comments related to that "feature" closer to the actual write.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/cpm_uart/cpm_uart_core.c | 31 +++++++--------------
 1 file changed, 10 insertions(+), 21 deletions(-)

diff --git a/drivers/tty/serial/cpm_uart/cpm_uart_core.c b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
index db07d6a5d764..28c73c28f0c5 100644
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
@@ -580,12 +568,9 @@ static void cpm_uart_set_termios(struct uart_port *port,
 
 	spin_lock_irqsave(&port->lock, flags);
 
-	/* Start bit has not been added (so don't, because we would just
-	 * subtract it later), and we need to add one for the number of
-	 * stops bits (there is always at least one).
-	 */
-	bits++;
 	if (IS_SMC(pinfo)) {
+		unsigned int bits = tty_get_frame_size(termios->c_cflag);
+
 		/*
 		 * MRBLR can be changed while an SMC/SCC is operating only
 		 * if it is done in a single bus cycle with one 16-bit move
@@ -604,13 +589,17 @@ static void cpm_uart_set_termios(struct uart_port *port,
 		 */
 		prev_mode = in_be16(&smcp->smc_smcmr) & (SMCMR_REN | SMCMR_TEN);
 		/* Output in *one* operation, so we don't interrupt RX/TX if they
-		 * were already enabled. */
-		out_be16(&smcp->smc_smcmr, smcr_mk_clen(bits) | cval |
-		    SMCMR_SM_UART | prev_mode);
+		 * were already enabled.
+		 * Character length programmed into the register is frame bits minus 1.
+		 */
+		out_be16(&smcp->smc_smcmr, smcr_mk_clen(bits - 1) | cval |
+					   SMCMR_SM_UART | prev_mode);
 	} else {
+		unsigned int bits = tty_get_char_size(termios->c_cflag);
+
 		out_be16(&pinfo->sccup->scc_genscc.scc_mrblr, pinfo->rx_fifosize);
 		out_be16(&pinfo->sccup->scc_maxidl, maxidl);
-		out_be16(&sccp->scc_psmr, (sbits << 12) | scval);
+		out_be16(&sccp->scc_psmr, (UART_LCR_WLEN(bits) << 12) | scval);
 	}
 
 	if (pinfo->clk)
-- 
2.30.2


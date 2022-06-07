Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 925D653F832
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 10:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238219AbiFGIaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 04:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238284AbiFGIaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 04:30:09 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F09CFE29;
        Tue,  7 Jun 2022 01:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654590607; x=1686126607;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y1kaCaz5N1o1+4WtActhJKFA70UAkSgBZb5Wg1uAewU=;
  b=J09y4G52tJSM8ZP/Ee8+lwM4C8XRYHaQRNwVmbbik+FrhTQI5ysZLa0W
   PciF03UKaHVXYOjxXRlWwEdHQqhQU0gakMG+cgqY8jUX0WhbvVLQk5I1E
   Tricm+bRkWSMSKeFCrerA6WfUIGBhYTShYXk1NEXaWVr8zvIUXjw+KgML
   o4pYwKMGCizZkd/n2JXBAgjFrd27tDWEgKsc76OXUaTZmKt15nF0mIrkW
   dwicipM3zjFYI27LdpQwe1OB1OkLGcxbjSvjQKYcX164Qu9OS6uu/y/+i
   LWGWrPu9ZlHMC20Bblikceka/yN9IpMRVTZkZYPQF7WQnvuFomBfEin2H
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="277393768"
X-IronPort-AV: E=Sophos;i="5.91,283,1647327600"; 
   d="scan'208";a="277393768"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 01:30:06 -0700
X-IronPort-AV: E=Sophos;i="5.91,283,1647327600"; 
   d="scan'208";a="584103573"
Received: from akmessan-mobl1.amr.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.214.146])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 01:30:04 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Joshua Scott <joshua.scott@alliedtelesis.co.nz>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 6/6] serial: 8250_dw: Store LSR into lsr_saved_flags in dw8250_tx_wait_empty()
Date:   Tue,  7 Jun 2022 11:29:34 +0300
Message-Id: <20220607082934.7242-7-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220607082934.7242-1-ilpo.jarvinen@linux.intel.com>
References: <20220607082934.7242-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure LSR flags are preserved in dw8250_tx_wait_empty(). This
function is called from a low-level out function and therefore cannot
call serial_lsr_in() as it would lead to infinite recursion.

It is borderline if the flags need to be saved here at all since this
code relates to writing LCR register which usually implies no important
characters should be arriving.

Fixes: 914eaf935ec7 ("serial: 8250_dw: Allow TX FIFO to drain before writing to UART_LCR")
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dw.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 1fae45991812..4cc69bb612ab 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -122,12 +122,15 @@ static void dw8250_check_lcr(struct uart_port *p, int value)
 /* Returns once the transmitter is empty or we run out of retries */
 static void dw8250_tx_wait_empty(struct uart_port *p)
 {
+	struct uart_8250_port *up = up_to_u8250p(p);
 	unsigned int tries = 20000;
 	unsigned int delay_threshold = tries - 1000;
 	unsigned int lsr;
 
 	while (tries--) {
 		lsr = readb (p->membase + (UART_LSR << p->regshift));
+		up->lsr_saved_flags |= lsr & LSR_SAVE_FLAGS;
+
 		if (lsr & UART_LSR_TEMT)
 			break;
 
-- 
2.30.2


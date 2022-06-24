Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE5E855A2EF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 22:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbiFXUmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 16:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbiFXUmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 16:42:46 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C80828BD;
        Fri, 24 Jun 2022 13:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656103364; x=1687639364;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Pg8HfHQVzm2IEUjcc48JaOFotrDQ52w9kSRF6zutRGQ=;
  b=i0a3XMDYIiQMUJCxct8Og1ytmp3gJk7lcJRXjaGYGvzUk3i1L8W9qP0i
   YKW6VcIN1UrnLy8ogN8uiYPXisw3L/Zyt3KuneWKF+fPTdIjKQPFTwC8O
   V9SDCbURlzmaQon7ikyYfFc2jNcgbuQUFzadeAU9WSBYs8z59DMjLvi6l
   o6hDXB4tUIog9Vt7BU3yjDnxVhJzvpO/2i/WN0mwz99JkPTO4GcO+rGW+
   nB9jEiS7Yeu3v+uLOPYEBKz1BZ7+sOYWlYGUlZUp9JDj5A8Hg6Qu28XDw
   VnT1ggzFqAt4hhlgY/X6BXP0rfPfP13CiJY0QnJjX71U8oIQO3vF9RU9Q
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10388"; a="260899842"
X-IronPort-AV: E=Sophos;i="5.92,220,1650956400"; 
   d="scan'208";a="260899842"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2022 13:42:44 -0700
X-IronPort-AV: E=Sophos;i="5.92,220,1650956400"; 
   d="scan'208";a="593381071"
Received: from vhavel-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.216.91])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2022 13:42:41 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Lukas Wunner <lukas@wunner.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v9 2/6] serial: 8250: create lsr_save_mask
Date:   Fri, 24 Jun 2022 23:42:06 +0300
Message-Id: <20220624204210.11112-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220624204210.11112-1-ilpo.jarvinen@linux.intel.com>
References: <20220624204210.11112-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow drivers to alter LSR save mask.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250.h      | 2 +-
 drivers/tty/serial/8250/8250_core.c | 4 ++++
 drivers/tty/serial/8250/8250_dw.c   | 2 +-
 include/linux/serial_8250.h         | 1 +
 4 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 0ff5688ba90c..5cc967fe3b59 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -138,7 +138,7 @@ static inline u16 serial_lsr_in(struct uart_8250_port *up)
 	u16 lsr = up->lsr_saved_flags;
 
 	lsr |= serial_in(up, UART_LSR);
-	up->lsr_saved_flags = lsr & LSR_SAVE_FLAGS;
+	up->lsr_saved_flags = lsr & up->lsr_save_mask;
 
 	return lsr;
 }
diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 90ddc8924811..57e86133af4f 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -1007,6 +1007,7 @@ int serial8250_register_8250_port(const struct uart_8250_port *up)
 		uart->port.rs485	= up->port.rs485;
 		uart->rs485_start_tx	= up->rs485_start_tx;
 		uart->rs485_stop_tx	= up->rs485_stop_tx;
+		uart->lsr_save_mask	= up->lsr_save_mask;
 		uart->dma		= up->dma;
 
 		/* Take tx_loadsz from fifosize if it wasn't set separately */
@@ -1094,6 +1095,9 @@ int serial8250_register_8250_port(const struct uart_8250_port *up)
 			ret = 0;
 		}
 
+		if (!uart->lsr_save_mask)
+			uart->lsr_save_mask = LSR_SAVE_FLAGS;	/* Use default LSR mask */
+
 		/* Initialise interrupt backoff work if required */
 		if (up->overrun_backoff_time_ms > 0) {
 			uart->overrun_backoff_time_ms =
diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 4cc69bb612ab..167a691c7b19 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -129,7 +129,7 @@ static void dw8250_tx_wait_empty(struct uart_port *p)
 
 	while (tries--) {
 		lsr = readb (p->membase + (UART_LSR << p->regshift));
-		up->lsr_saved_flags |= lsr & LSR_SAVE_FLAGS;
+		up->lsr_saved_flags |= lsr & up->lsr_save_mask;
 
 		if (lsr & UART_LSR_TEMT)
 			break;
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index 4565f25ba9a2..8c7b793aa4d7 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -120,6 +120,7 @@ struct uart_8250_port {
 	 */
 #define LSR_SAVE_FLAGS UART_LSR_BRK_ERROR_BITS
 	u16			lsr_saved_flags;
+	u16			lsr_save_mask;
 #define MSR_SAVE_FLAGS UART_MSR_ANY_DELTA
 	unsigned char		msr_saved_flags;
 
-- 
2.30.2


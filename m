Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11CFE4A9BF2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 16:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359676AbiBDP16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 10:27:58 -0500
Received: from mga14.intel.com ([192.55.52.115]:47154 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231651AbiBDP15 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 10:27:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643988477; x=1675524477;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=37aYT7hWQ+Sf/jRnuoiNMLCZKYTC1oTxPKBGbo5Qx3w=;
  b=S3ZcNFKNu/c6LClWUpGN7wI4IsJiJ0Kz3wCAhTweysfes+lm9hGOYSIU
   lI7cf4tjcbyTtU06nnF3BVnVPgdvS05qGhqZyOBAVarLBpP+9LmVr8D7D
   sQ6l235HXc9Uc1q10r+8RuVynHB7AR8AMqbUVlidFVA/kPRAXj8SOmD/U
   ZxWQMSLe5ciSq8usLYvQ1oHcQAAF67wjFXbSU4cpQtiGxJZyy2cDFtdV9
   Cs1vyTxNRXVUXfPU3BGHblYPNMcYrormvcuQRt/gmgWxw4mPg+XCVUQ/u
   E+aTue+Lr1DOAAM7KWoOhQFJJQho+Jzx6lh1idKO3J5c7YqQrZKw/A1UU
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10247"; a="248598097"
X-IronPort-AV: E=Sophos;i="5.88,343,1635231600"; 
   d="scan'208";a="248598097"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 07:27:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,343,1635231600"; 
   d="scan'208";a="677123986"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 04 Feb 2022 07:27:56 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A59D0204; Fri,  4 Feb 2022 17:28:10 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/1] serial: core: Drop duplicate NULL check in uart_*shutdown()
Date:   Fri,  4 Feb 2022 17:28:08 +0200
Message-Id: <20220204152808.10808-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The free_page(addr), which becomes free_pages(addr, 0) checks addr
against 0. No need to repeat this check in the callers.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Jiri Slaby <jirislaby@kernel.org>
---
v2: rebased on top of tty-next (Greg), added tag (Jiri)
 drivers/tty/serial/serial_core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index ba4baa756d51..846192a7b4bf 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -317,8 +317,7 @@ static void uart_shutdown(struct tty_struct *tty, struct uart_state *state)
 	state->xmit.buf = NULL;
 	uart_port_unlock(uport, flags);
 
-	if (xmit_buf)
-		free_page((unsigned long)xmit_buf);
+	free_page((unsigned long)xmit_buf);
 }
 
 /**
@@ -1569,8 +1568,7 @@ static void uart_tty_port_shutdown(struct tty_port *port)
 	state->xmit.buf = NULL;
 	spin_unlock_irq(&uport->lock);
 
-	if (buf)
-		free_page((unsigned long)buf);
+	free_page((unsigned long)buf);
 
 	uart_change_pm(state, UART_PM_STATE_OFF);
 }
-- 
2.34.1


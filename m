Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4023F53E819
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233511AbiFFKJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 06:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233257AbiFFKGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 06:06:07 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB9B137C52;
        Mon,  6 Jun 2022 03:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654509966; x=1686045966;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1ykVVHaG5+z6JMvFP2Lra95WjkVnEbI89bCUkQzfrvg=;
  b=SyChIlk2zTGpzc9kYp/5fHLX7TZ/hwkxW/cyWyud8yU949+lLrRbyt9B
   5TGkFzBeOWFNrrkS90kYRCkaG9monXYf2yxJ+q1yHyacyZVvZkUBJURQ4
   pzAim9ecCJjS3xKqx2beJxswfQGwUluQXr3qk16r7q+4Z5ZJ+ATMQOm48
   lgrXQ+jmaeK7juybmHtX8lP3SdiqcmCo/iF6uDyMOgQzSV/5TDmWe5XDd
   ggHWcMlVO2oDH+s1tBXj8Wjp/Px2iV38AQw5QwKUXBSM9jBV1arIcP4Io
   YQAoO3ypsMiC/91tnjPN29SAI/0qUzg8KupfpNYgEkS4qxrlgO4TnJY+V
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10369"; a="362987078"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="362987078"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 03:06:05 -0700
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="635523827"
Received: from amkossek-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.57.11])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 03:06:04 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 25/36] serial: 8250_dwlib: Remove serial_rs485 sanitization
Date:   Mon,  6 Jun 2022 13:04:22 +0300
Message-Id: <20220606100433.13793-26-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220606100433.13793-1-ilpo.jarvinen@linux.intel.com>
References: <20220606100433.13793-1-ilpo.jarvinen@linux.intel.com>
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

Serial core handles serial_rs485 sanitization and rs485 struct
assignment. As serial_rs485 is already clear for the non-RS485 case by
serial core, there no need to clear flags in the driver.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dwlib.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dwlib.c b/drivers/tty/serial/8250/8250_dwlib.c
index 120b29519d74..c83e7eaf3877 100644
--- a/drivers/tty/serial/8250/8250_dwlib.c
+++ b/drivers/tty/serial/8250/8250_dwlib.c
@@ -93,9 +93,6 @@ static int dw8250_rs485_config(struct uart_port *p, struct serial_rs485 *rs485)
 	tcr &= ~DW_UART_TCR_XFER_MODE;
 
 	if (rs485->flags & SER_RS485_ENABLED) {
-		/* Clear unsupported flags. */
-		rs485->flags &= SER_RS485_ENABLED | SER_RS485_RX_DURING_TX |
-				SER_RS485_RTS_ON_SEND | SER_RS485_RTS_AFTER_SEND;
 		tcr |= DW_UART_TCR_RS485_EN;
 
 		if (rs485->flags & SER_RS485_RX_DURING_TX) {
@@ -111,8 +108,6 @@ static int dw8250_rs485_config(struct uart_port *p, struct serial_rs485 *rs485)
 		dw8250_writel_ext(p, DW_UART_DE_EN, 1);
 		dw8250_writel_ext(p, DW_UART_RE_EN, 1);
 	} else {
-		rs485->flags = 0;
-
 		tcr &= ~DW_UART_TCR_RS485_EN;
 	}
 
@@ -127,11 +122,6 @@ static int dw8250_rs485_config(struct uart_port *p, struct serial_rs485 *rs485)
 
 	dw8250_writel_ext(p, DW_UART_TCR, tcr);
 
-	rs485->delay_rts_before_send = 0;
-	rs485->delay_rts_after_send = 0;
-
-	p->rs485 = *rs485;
-
 	return 0;
 }
 
-- 
2.30.2


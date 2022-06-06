Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4096D53E846
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233449AbiFFKGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 06:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233289AbiFFKFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 06:05:33 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE166FA19;
        Mon,  6 Jun 2022 03:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654509929; x=1686045929;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=30sgEmomZFJSjr9ND+w2PFIvZclLSnuuV9GPE1kuVgI=;
  b=P/6fB59tKAS+++Ev8mLX5KcQJjwgT0nIKcD74+Fv/vC7G8/Pj0ibNTcO
   9mY4p1twYlb+wyh+OcBr1KjDM+JSzPCr9obHxGZ6B6JtRj85UwVfzDChK
   +MRbIgj3+1LNFyjEDVYnjGrjX/dUNeNhTjpyupL1fTL6tc7pKNdLYG0VM
   b7SMI4rJg8Pni5sPq7LLhls+9AAE0Y5uamJa8irKRWIvmqCSBKFDUUUIt
   lPjJHiu7xdq7a7047fUnjbjorqej5nKIKavHlq4842+9HVSXeh9a4T+36
   N4OBq2xm14GKaXP1GJKmQ45IjGrm5RCa6fe7XDRtSlR3y42lEppLv2XM7
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10369"; a="362987036"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="362987036"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 03:05:03 -0700
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="635523476"
Received: from amkossek-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.57.11])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 03:05:01 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 04/36] serial: 8250: Create serial8250_em485_supported for em485 users
Date:   Mon,  6 Jun 2022 13:04:01 +0300
Message-Id: <20220606100433.13793-5-ilpo.jarvinen@linux.intel.com>
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

Create serial8250_em485_supported for the serial_rs485 features
supported by the em485 framework.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250.h      | 1 +
 drivers/tty/serial/8250/8250_port.c | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index d70adaa3b117..e5d44867a876 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -187,6 +187,7 @@ int serial8250_em485_config(struct uart_port *port, struct serial_rs485 *rs485);
 void serial8250_em485_start_tx(struct uart_8250_port *p);
 void serial8250_em485_stop_tx(struct uart_8250_port *p);
 void serial8250_em485_destroy(struct uart_8250_port *p);
+extern struct serial_rs485 serial8250_em485_supported;
 
 /* MCR <-> TIOCM conversion */
 static inline int serial8250_TIOCM_to_MCR(int tiocm)
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index d7384ab364d2..a825fbc215a7 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -647,6 +647,14 @@ void serial8250_em485_destroy(struct uart_8250_port *p)
 }
 EXPORT_SYMBOL_GPL(serial8250_em485_destroy);
 
+struct serial_rs485 serial8250_em485_supported = {
+	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND | SER_RS485_RTS_AFTER_SEND |
+		 SER_RS485_TERMINATE_BUS | SER_RS485_RX_DURING_TX,
+	.delay_rts_before_send = 1,
+	.delay_rts_after_send = 1,
+};
+EXPORT_SYMBOL_GPL(serial8250_em485_supported);
+
 /**
  * serial8250_em485_config() - generic ->rs485_config() callback
  * @port: uart port
-- 
2.30.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 266FD53E6A4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233398AbiFFKFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 06:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233081AbiFFKF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 06:05:29 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D7D6B7CC;
        Mon,  6 Jun 2022 03:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654509924; x=1686045924;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UPKALUhJ57HvaWDZolkV+MIlJXrWd+36QgzI4liyduE=;
  b=lF/Gh3WLZLTqCjYR0f7ocPh+f2pxTbo2bQf1XM5A8u+LVPTYS/QJlI1Y
   Z0q8Vx6hJ10WPquYbZGssxQ7eoJPvze/Y1IKdMyIX0rI8GxDcdq1alJ31
   3bXfWP5dHD5eO88VBj7vXW4NVZ8i4ck4IIECOAAsqbaLOVAnAVe+yCqm5
   ObQ7RX7RFKO9szKRHKlf7n2KdaH+xcGs/UmQu6kMRp1hSO++YoDsGr8S4
   p2OFPgqVBcTo7CAJkaL04sIxw4sJQzXAhZCCS1IA1m1R+/bq6132WCJPI
   KFb8JwvghDLXGZ/7PeX50PDOMhLtnRZCNgFCtxj7Fi3Gwrc+bc9NlmNZj
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10369"; a="362987033"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="362987033"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 03:04:57 -0700
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="635523421"
Received: from amkossek-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.57.11])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 03:04:56 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 02/36] serial: Move serial_rs485 sanitization into separate function
Date:   Mon,  6 Jun 2022 13:03:59 +0300
Message-Id: <20220606100433.13793-3-ilpo.jarvinen@linux.intel.com>
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

Add uart_sanitize_serial_rs485() function for sanitizing serial_rs485
structure fields.

No functional changes.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/serial_core.c | 55 +++++++++++++++++---------------
 1 file changed, 30 insertions(+), 25 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 8466181db4e9..44a50158552d 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1276,6 +1276,35 @@ static int uart_get_icount(struct tty_struct *tty,
 	return 0;
 }
 
+static void uart_sanitize_serial_rs485(struct uart_port *port, struct serial_rs485 *rs485)
+{
+	/* pick sane settings if the user hasn't */
+	if (!(rs485->flags & SER_RS485_RTS_ON_SEND) ==
+	    !(rs485->flags & SER_RS485_RTS_AFTER_SEND)) {
+		dev_warn_ratelimited(port->dev,
+			"%s (%d): invalid RTS setting, using RTS_ON_SEND instead\n",
+			port->name, port->line);
+		rs485->flags |= SER_RS485_RTS_ON_SEND;
+		rs485->flags &= ~SER_RS485_RTS_AFTER_SEND;
+	}
+
+	if (rs485->delay_rts_before_send > RS485_MAX_RTS_DELAY) {
+		rs485->delay_rts_before_send = RS485_MAX_RTS_DELAY;
+		dev_warn_ratelimited(port->dev,
+			"%s (%d): RTS delay before sending clamped to %u ms\n",
+			port->name, port->line, rs485->delay_rts_before_send);
+	}
+
+	if (rs485->delay_rts_after_send > RS485_MAX_RTS_DELAY) {
+		rs485->delay_rts_after_send = RS485_MAX_RTS_DELAY;
+		dev_warn_ratelimited(port->dev,
+			"%s (%d): RTS delay after sending clamped to %u ms\n",
+			port->name, port->line, rs485->delay_rts_after_send);
+	}
+	/* Return clean padding area to userspace */
+	memset(rs485->padding, 0, sizeof(rs485->padding));
+}
+
 int uart_rs485_config(struct uart_port *port)
 {
 	return port->rs485_config(port, &port->rs485);
@@ -1311,31 +1340,7 @@ static int uart_set_rs485_config(struct uart_port *port,
 	if (copy_from_user(&rs485, rs485_user, sizeof(*rs485_user)))
 		return -EFAULT;
 
-	/* pick sane settings if the user hasn't */
-	if (!(rs485.flags & SER_RS485_RTS_ON_SEND) ==
-	    !(rs485.flags & SER_RS485_RTS_AFTER_SEND)) {
-		dev_warn_ratelimited(port->dev,
-			"%s (%d): invalid RTS setting, using RTS_ON_SEND instead\n",
-			port->name, port->line);
-		rs485.flags |= SER_RS485_RTS_ON_SEND;
-		rs485.flags &= ~SER_RS485_RTS_AFTER_SEND;
-	}
-
-	if (rs485.delay_rts_before_send > RS485_MAX_RTS_DELAY) {
-		rs485.delay_rts_before_send = RS485_MAX_RTS_DELAY;
-		dev_warn_ratelimited(port->dev,
-			"%s (%d): RTS delay before sending clamped to %u ms\n",
-			port->name, port->line, rs485.delay_rts_before_send);
-	}
-
-	if (rs485.delay_rts_after_send > RS485_MAX_RTS_DELAY) {
-		rs485.delay_rts_after_send = RS485_MAX_RTS_DELAY;
-		dev_warn_ratelimited(port->dev,
-			"%s (%d): RTS delay after sending clamped to %u ms\n",
-			port->name, port->line, rs485.delay_rts_after_send);
-	}
-	/* Return clean padding area to userspace */
-	memset(rs485.padding, 0, sizeof(rs485.padding));
+	uart_sanitize_serial_rs485(port, &rs485);
 
 	spin_lock_irqsave(&port->lock, flags);
 	ret = port->rs485_config(port, &rs485);
-- 
2.30.2


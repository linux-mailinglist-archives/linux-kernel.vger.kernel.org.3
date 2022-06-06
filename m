Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8A253E751
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233787AbiFFKIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 06:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233472AbiFFKGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 06:06:06 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3408A12D1D5;
        Mon,  6 Jun 2022 03:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654509958; x=1686045958;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3ePdwoX+DSakNv+ndMXaVUewbzkFOgoQ5XvDH6NwVyI=;
  b=VjDQ8wbVggOR2ISOSCz8yGUU60pdMVS6YISTfxQQvDO45BkoG10x75+D
   grrMyxGgNUxJy0NcWF7YYJ8lh475HnYvRyLslZN9wcjpd4PeYgVPNQSRv
   KOx7YpCAbfPO4UVVs9PhvlrlbohJuu1+aRty19ClDAMFJqIWcbX2nLCy/
   U1t2m+jGPgNl9vg14xV49/G4gQYFJ/k2VfwK61ISp3tamTfxSlpfjwSci
   xihsUtidViodI/jqTb7eecArwu/00tJYBteR933pzgGBbwMEvX3xCfqC1
   i97Y7GWbKXiZqPRhGu8uDD5sKYx8LRWFdD6B6v6yTgWH1grwEjAFWAaw/
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10369"; a="362987071"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="362987071"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 03:05:58 -0700
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="635523793"
Received: from amkossek-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.57.11])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 03:05:55 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 22/36] serial: Sanitize rs485_struct
Date:   Mon,  6 Jun 2022 13:04:19 +0300
Message-Id: <20220606100433.13793-23-ilpo.jarvinen@linux.intel.com>
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

Sanitize serial_rs485 struct before calling into rs485_setup. The
drivers provide supported_rs485 to help sanitization of the fields.

If neither of SER_RS485_RTS_ON_SEND or SER_RS485_RTS_AFTER_SEND
supported, don't pretend they can be set to sane settings but clear
them both instead. If only one of them is supported it may look
tempting to use the one driver supports to set the other, however, the
userspace does not have that information readily available so it
wouldn't be helpful.

While adjusting the documentation, remove also the claim that
TIOCGRS485 would call driver specific code. In reality, it does nothing
else than copies the stored serial_rs485 structure from uart_port to
userspace.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 .../driver-api/serial/serial-rs485.rst        | 12 ++++---
 drivers/tty/serial/serial_core.c              | 33 ++++++++++++++++---
 2 files changed, 37 insertions(+), 8 deletions(-)

diff --git a/Documentation/driver-api/serial/serial-rs485.rst b/Documentation/driver-api/serial/serial-rs485.rst
index 6bc824f948f9..00b5d333acba 100644
--- a/Documentation/driver-api/serial/serial-rs485.rst
+++ b/Documentation/driver-api/serial/serial-rs485.rst
@@ -38,10 +38,14 @@ RS485 Serial Communications
    the values given by the device tree.
 
    Any driver for devices capable of working both as RS232 and RS485 should
-   implement the rs485_config callback in the uart_port structure. The
-   serial_core calls rs485_config to do the device specific part in response
-   to TIOCSRS485 and TIOCGRS485 ioctls (see below). The rs485_config callback
-   receives a pointer to struct serial_rs485.
+   implement the rs485_config callback and provide rs485_supported in the
+   uart_port structure. The serial core calls rs485_config to do the device
+   specific part in response to TIOCSRS485 ioctl (see below). The rs485_config
+   callback receives a pointer to a sanitizated serial_rs485 structure. The
+   serial_rs485 userspace provides is sanitized before calling rs485_config
+   using rs485_supported that indicates what RS485 features the driver supports
+   for the uart_port. TIOCGRS485 ioctl can be used to read back the
+   serial_rs485 structure matching to the current configuration.
 
 4. Usage from user-level
 ========================
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 44a50158552d..f0d7b3d20731 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1278,36 +1278,61 @@ static int uart_get_icount(struct tty_struct *tty,
 
 static void uart_sanitize_serial_rs485(struct uart_port *port, struct serial_rs485 *rs485)
 {
+	u32 supported_flags = port->rs485_supported->flags;
+
 	/* pick sane settings if the user hasn't */
-	if (!(rs485->flags & SER_RS485_RTS_ON_SEND) ==
+	if ((supported_flags & (SER_RS485_RTS_ON_SEND|SER_RS485_RTS_AFTER_SEND)) &&
+	    !(rs485->flags & SER_RS485_RTS_ON_SEND) ==
 	    !(rs485->flags & SER_RS485_RTS_AFTER_SEND)) {
 		dev_warn_ratelimited(port->dev,
 			"%s (%d): invalid RTS setting, using RTS_ON_SEND instead\n",
 			port->name, port->line);
 		rs485->flags |= SER_RS485_RTS_ON_SEND;
 		rs485->flags &= ~SER_RS485_RTS_AFTER_SEND;
+		supported_flags |= SER_RS485_RTS_ON_SEND|SER_RS485_RTS_AFTER_SEND;
 	}
 
-	if (rs485->delay_rts_before_send > RS485_MAX_RTS_DELAY) {
+	if (!port->rs485_supported->delay_rts_before_send) {
+		if (rs485->delay_rts_before_send) {
+			dev_warn_ratelimited(port->dev,
+				"%s (%d): RTS delay before sending not supported\n",
+				port->name, port->line);
+		}
+		rs485->delay_rts_before_send = 0;
+	} else if (rs485->delay_rts_before_send > RS485_MAX_RTS_DELAY) {
 		rs485->delay_rts_before_send = RS485_MAX_RTS_DELAY;
 		dev_warn_ratelimited(port->dev,
 			"%s (%d): RTS delay before sending clamped to %u ms\n",
 			port->name, port->line, rs485->delay_rts_before_send);
 	}
 
-	if (rs485->delay_rts_after_send > RS485_MAX_RTS_DELAY) {
+	if (!port->rs485_supported->delay_rts_after_send) {
+		if (rs485->delay_rts_after_send) {
+			dev_warn_ratelimited(port->dev,
+				"%s (%d): RTS delay after sending not supported\n",
+				port->name, port->line);
+		}
+		rs485->delay_rts_after_send = 0;
+	} else if (rs485->delay_rts_after_send > RS485_MAX_RTS_DELAY) {
 		rs485->delay_rts_after_send = RS485_MAX_RTS_DELAY;
 		dev_warn_ratelimited(port->dev,
 			"%s (%d): RTS delay after sending clamped to %u ms\n",
 			port->name, port->line, rs485->delay_rts_after_send);
 	}
+
+	rs485->flags &= supported_flags;
+
 	/* Return clean padding area to userspace */
 	memset(rs485->padding, 0, sizeof(rs485->padding));
 }
 
 int uart_rs485_config(struct uart_port *port)
 {
-	return port->rs485_config(port, &port->rs485);
+	struct serial_rs485 *rs485 = &port->rs485;
+
+	uart_sanitize_serial_rs485(port, rs485);
+
+	return port->rs485_config(port, rs485);
 }
 EXPORT_SYMBOL_GPL(uart_rs485_config);
 
-- 
2.30.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 742BF53E7AF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233801AbiFFKIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 06:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233477AbiFFKGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 06:06:06 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87BC134E3E;
        Mon,  6 Jun 2022 03:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654509961; x=1686045961;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t7MRrVBt8mtQZVQp8WCbEVVhXVvzT6OcQwCWqDrYLuE=;
  b=mYiKP2grGFypaXBt0Elb8jeHUPg5oMZnVy0KOlGcjvm5/BR5e8DwzlCN
   Fz1n0dTcjbugNPT7GBEvxletzcq2vMch/KI9LZ6rSu8e9Z5CAzeNwxU2e
   0AjvOHx3Wg1xYtDku1pAqat6JDXsDF9Fsv0w6k+lMTqsKWigy0tRLlZcM
   JA4qfRMCpHNel9eJVxkAZRYceJdJi90ghJtWoEMR/FaIrIwbV7iItLeb4
   93emXyD4j9dKzIkyX5T2MYfBlZdwYhKAgFbM249VrnbZOHB3LzDTaaUij
   ppXk2jk3cZpCJNdRaP4DzK5fuKvMrsaRYpo2dV+WbBZ6kZJBuPRqYLC3b
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10369"; a="362987072"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="362987072"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 03:06:00 -0700
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="635523812"
Received: from amkossek-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.57.11])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 03:05:58 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 23/36] serial: Clear rs485 struct when non-RS485 mode is set
Date:   Mon,  6 Jun 2022 13:04:20 +0300
Message-Id: <20220606100433.13793-24-ilpo.jarvinen@linux.intel.com>
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

When SER_RS485_ENABLED is not set, having any other flag/field set in
serial_rs485 struct does not have an effect different from not having
them set. Thus, make the serial_rs485 struct also match the behavior
for all flags, not just SER_RS485_ENABLED.

Some drivers do similar clearing of rs485 struct in their
rs485_config() already, but not all. This change makes the behavior
consistent across drivers.

Don't try to validate rs485 struct further when no RS485 is requested,
this silences some bogus warnings.

This change has (minor) userspace visible impact.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/serial_core.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index f0d7b3d20731..6be538720564 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1280,6 +1280,11 @@ static void uart_sanitize_serial_rs485(struct uart_port *port, struct serial_rs4
 {
 	u32 supported_flags = port->rs485_supported->flags;
 
+	if (!(rs485->flags & SER_RS485_ENABLED)) {
+		memset(rs485, 0, sizeof(*rs485));
+		return;
+	}
+
 	/* pick sane settings if the user hasn't */
 	if ((supported_flags & (SER_RS485_RTS_ON_SEND|SER_RS485_RTS_AFTER_SEND)) &&
 	    !(rs485->flags & SER_RS485_RTS_ON_SEND) ==
@@ -1329,10 +1334,15 @@ static void uart_sanitize_serial_rs485(struct uart_port *port, struct serial_rs4
 int uart_rs485_config(struct uart_port *port)
 {
 	struct serial_rs485 *rs485 = &port->rs485;
+	int ret;
 
 	uart_sanitize_serial_rs485(port, rs485);
 
-	return port->rs485_config(port, rs485);
+	ret = port->rs485_config(port, rs485);
+	if (ret)
+		memset(rs485, 0, sizeof(*rs485));
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(uart_rs485_config);
 
-- 
2.30.2


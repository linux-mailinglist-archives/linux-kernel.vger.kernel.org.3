Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1035455FC73
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 11:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbiF2Jsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 05:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233027AbiF2Jsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 05:48:46 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09AD03D1D7;
        Wed, 29 Jun 2022 02:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656496125; x=1688032125;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kR520z9Moq5dCNqgaHhzTffg8JxRytrsfPcAIOtwgTE=;
  b=iuy2Oc59R3Z5Thts1yxX9y/5DH0xiWyLPRX9nQHI+cM1cJM9O88loWYP
   l6a28CwwKBowY2tbY0N98EuGJ0a6u0XoWdVA2hbUI0s3jE6OSz8zK1p4T
   pAiQZ87uEtbDfzNJByTttNWb0MV7UKf5iUpjgEwHvW1TYLSqFZrsthDwg
   tAswB5PEksuOFljFDqE+BTdmgyeq0BhtlCm6ZIKE8idsNwyvlXXE1qjCF
   uQegklAY4DRk7YkHp7ZhmCfBZIVll9FZvEvGgD9qLCSYR/D96bfDpvMec
   9+j+ab0aHXxozUN83B+qdvSsseBH0IzPAhvL4Tq9CVJwD58zKdXIgyGMU
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="262395191"
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="262395191"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 02:48:45 -0700
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="647322406"
Received: from dsummer-mobl.ger.corp.intel.com ([10.252.38.121])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 02:48:43 -0700
Date:   Wed, 29 Jun 2022 12:48:41 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Tony Lindgren <tony@atomide.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] serial: 8250: Fix PM usage_count for console handover
Message-ID: <b4f428e9-491f-daf2-2232-819928dc276e@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1304406510-1656496125=:1529"
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1304406510-1656496125=:1529
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

When console is enabled, univ8250_console_setup() calls
serial8250_console_setup() before .dev is set to uart_port. Therefore,
it will not call pm_runtime_get_sync(). Later, when the actual driver
is going to take over univ8250_console_exit() is called. As .dev is
already set, serial8250_console_exit() makes pm_runtime_put_sync() call
with usage count being zero triggering PM usage count warning
(extra debug for univ8250_console_setup(), univ8250_console_exit(), and
serial8250_register_ports()):

[    0.068987] univ8250_console_setup ttyS0 nodev
[    0.499670] printk: console [ttyS0] enabled
[    0.717955] printk: console [ttyS0] printing thread started
[    1.960163] serial8250_register_ports assigned dev for ttyS0
[    1.976830] printk: console [ttyS0] disabled
[    1.976888] printk: console [ttyS0] printing thread stopped
[    1.977073] univ8250_console_exit ttyS0 usage:0
[    1.977075] serial8250 serial8250: Runtime PM usage count underflow!
[    1.977429] dw-apb-uart.6: ttyS0 at MMIO 0x4010006000 (irq = 33, base_baud = 115200) is a 16550A
[    1.977812] univ8250_console_setup ttyS0 usage:2
[    1.978167] printk: console [ttyS0] printing thread started
[    1.978203] printk: console [ttyS0] enabled

To fix the issue, call pm_runtime_get_sync() in
serial8250_register_ports() as soon as .dev is set for an uart_port
if it has console enabled.

This problem became apparent only recently because 82586a721595 ("PM:
runtime: Avoid device usage count underflows") added the warning
printout. I confirmed this problem also occurs with v5.18 (w/o the
warning printout, obviously).

Fixes: bedb404e91bb ("serial: 8250_port: Don't use power management for kernel console")
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Tony Lindgren <tony@atomide.com>
Tested-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

---
v2:
- Remove reference to reverted printk kthreads from the changelog
- Collect rev/tested-bys

 drivers/tty/serial/8250/8250_core.c | 4 ++++
 drivers/tty/serial/serial_core.c    | 5 -----
 include/linux/serial_core.h         | 5 +++++
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 57e86133af4f..2e83e7367441 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -23,6 +23,7 @@
 #include <linux/sysrq.h>
 #include <linux/delay.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/tty.h>
 #include <linux/ratelimit.h>
 #include <linux/tty_flip.h>
@@ -558,6 +559,9 @@ serial8250_register_ports(struct uart_driver *drv, struct device *dev)
 
 		up->port.dev = dev;
 
+		if (uart_console_enabled(&up->port))
+			pm_runtime_get_sync(up->port.dev);
+
 		serial8250_apply_quirks(up);
 		uart_add_one_port(drv, &up->port);
 	}
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 85ef7ef00b82..3161445504bc 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2024,11 +2024,6 @@ static int uart_proc_show(struct seq_file *m, void *v)
 }
 #endif
 
-static inline bool uart_console_enabled(struct uart_port *port)
-{
-	return uart_console(port) && (port->cons->flags & CON_ENABLED);
-}
-
 static void uart_port_spin_lock_init(struct uart_port *port)
 {
 	spin_lock_init(&port->lock);
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index b7b86ee3cb12..9d8aa139b175 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -404,6 +404,11 @@ static const bool earlycon_acpi_spcr_enable EARLYCON_USED_OR_UNUSED;
 static inline int setup_earlycon(char *buf) { return 0; }
 #endif
 
+static inline bool uart_console_enabled(struct uart_port *port)
+{
+	return uart_console(port) && (port->cons->flags & CON_ENABLED);
+}
+
 struct uart_port *uart_get_console(struct uart_port *ports, int nr,
 				   struct console *c);
 int uart_parse_earlycon(char *p, unsigned char *iotype, resource_size_t *addr,

-- 
tg: (f287f971e256..) fix/console-usage_count (depends on: tty-next)
--8323329-1304406510-1656496125=:1529--

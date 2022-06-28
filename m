Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC7FC55EA81
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 19:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbiF1Q7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 12:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiF1Q7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 12:59:01 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDA0139;
        Tue, 28 Jun 2022 09:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656435540; x=1687971540;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZMmJv0Aq1HwpnPUpXeTro+xXVdnw6ntT+2+Mu0JHFpA=;
  b=R7FNwhCwPsEWOn2V7Y72JBBh4Tlu6UgIZO4OLFOKg3IWF/FGc9YJWGRf
   s3VnIydYFrEBNATIsocqpVOQy+1M8drp0mKn6a72fi1FoJwobD2Gu3kak
   umCMRQgRByv8JMp0STpmPe9qyZid383PvN2/EJC/lB9NsPjaqgdJdkL3i
   XAzDY4KeEPmopmaE5YCnWb94XJ+DqFLSkm1OrI/vQc4buTmSXrx7dDCkw
   Jbp45nMXAe0T/L2/lg1hoanNivewMppHSgz/x62lno+hOXGGHDoKI3lc1
   XbDpK1QO03yyIIn3wp4FC/rGSNNTUWGwFSR48/xOwNVWCsYhibvD3n4xt
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="343485041"
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="343485041"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 09:58:51 -0700
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="646995337"
Received: from iannetti-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.216.215])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 09:58:49 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tony Lindgren <tony@atomide.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH] serial: 8250: Fix PM usage_count for console handover
Date:   Tue, 28 Jun 2022 19:58:34 +0300
Message-Id: <20220628165834.63044-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
warning printout, obviously) so the recent printk kthreads are not the
cause for this.

Fixes: bedb404e91bb ("serial: 8250_port: Don't use power management for kernel console")
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

---
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

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8EB55A5CEA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 09:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbiH3Hag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 03:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbiH3HaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 03:30:19 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E7652E46;
        Tue, 30 Aug 2022 00:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661844614; x=1693380614;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VJx+d3L2Syoc8RuvSxP1X6m5sHiEy1kxz2aW9SYYtwY=;
  b=MPySqSZ6mTsRGQnTjxpJzd5w7UkZEjMrqaW4gRBkzf/DcBt4U4QBIiSG
   Z2bP8sr2vg/67qZdesCPohX6KexmU2FCZaBcJOwXbX/yZoht9J8woQG3g
   C0hN5rxCvIHkxy34+bM08QVOPjZZG7dVFzzqe+iqAk9zMXVGM19M2szxF
   XI6Wv5ocUsvl7uRdYB1JbTE2y16mJjbBRnZ/RoCdesBMYHheRr0S/v2qz
   rLRHt1GZZu7NchRLsPM6OlRCx8xZ1Iunn2uhcOE6VAiH/VB9TlULVu7bd
   z9bNNstSzDa+1HgMpBTe/v6ZfxQwUZCgKlQAIEMr8rEV3G/t/+NHIxlun
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="282077236"
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="282077236"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 00:30:12 -0700
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="641262659"
Received: from arnesgom-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.54.235])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 00:30:10 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v2 2/4] serial: add helpers to copy serial_rs485 from/to userspace
Date:   Tue, 30 Aug 2022 10:29:54 +0300
Message-Id: <20220830072956.3630-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220830072956.3630-1-ilpo.jarvinen@linux.intel.com>
References: <20220830072956.3630-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to the padding fields, the copying will need to do a bit more than
usual.

Move padding clearing into the helper that copies back to userspace.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/serial_core.c | 41 +++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 8834414a0b2f..4a4ed619ee71 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1375,10 +1375,6 @@ static void uart_sanitize_serial_rs485(struct uart_port *port, struct serial_rs4
 	rs485->flags &= supported_flags;
 
 	uart_sanitize_serial_rs485_delays(port, rs485);
-
-	/* Return clean padding area to userspace */
-	memset(rs485->padding0, 0, sizeof(rs485->padding0));
-	memset(rs485->padding1, 0, sizeof(rs485->padding1));
 }
 
 static void uart_set_rs485_termination(struct uart_port *port,
@@ -1407,6 +1403,28 @@ int uart_rs485_config(struct uart_port *port)
 }
 EXPORT_SYMBOL_GPL(uart_rs485_config);
 
+static int serial_rs485_from_user(struct serial_rs485 *rs485,
+				  const struct serial_rs485 __user *rs485_user)
+{
+	if (copy_from_user(rs485, rs485_user, sizeof(*rs485)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int serial_rs485_to_user(struct serial_rs485 __user *rs485_user,
+				struct serial_rs485 *rs485)
+{
+	/* Return clean padding area to userspace */
+	memset(rs485->padding0, 0, sizeof(rs485->padding0));
+	memset(rs485->padding1, 0, sizeof(rs485->padding1));
+
+	if (copy_to_user(rs485_user, rs485, sizeof(*rs485)))
+		return -EFAULT;
+
+	return 0;
+}
+
 static int uart_get_rs485_config(struct uart_port *port,
 			 struct serial_rs485 __user *rs485_user)
 {
@@ -1417,10 +1435,7 @@ static int uart_get_rs485_config(struct uart_port *port,
 	rs485 = port->rs485;
 	spin_unlock_irqrestore(&port->lock, flags);
 
-	if (copy_to_user(rs485_user, &rs485, sizeof(rs485)))
-		return -EFAULT;
-
-	return 0;
+	return serial_rs485_to_user(rs485_user, &rs485);
 }
 
 static int uart_set_rs485_config(struct tty_struct *tty, struct uart_port *port,
@@ -1433,8 +1448,9 @@ static int uart_set_rs485_config(struct tty_struct *tty, struct uart_port *port,
 	if (!port->rs485_config)
 		return -ENOTTY;
 
-	if (copy_from_user(&rs485, rs485_user, sizeof(*rs485_user)))
-		return -EFAULT;
+	ret = serial_rs485_from_user(&rs485, rs485_user);
+	if (ret)
+		return ret;
 
 	ret = uart_check_rs485_flags(port, &rs485);
 	if (ret)
@@ -1450,10 +1466,7 @@ static int uart_set_rs485_config(struct tty_struct *tty, struct uart_port *port,
 	if (ret)
 		return ret;
 
-	if (copy_to_user(rs485_user, &port->rs485, sizeof(port->rs485)))
-		return -EFAULT;
-
-	return 0;
+	return serial_rs485_to_user(rs485_user, &port->rs485);
 }
 
 static int uart_get_iso7816_config(struct uart_port *port,
-- 
2.30.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44BDD5A29E8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 16:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344564AbiHZOqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 10:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343947AbiHZOqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 10:46:47 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CFFFD87D9;
        Fri, 26 Aug 2022 07:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661525206; x=1693061206;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eXJbBe/5ycXuCWYqrcqoy4JvkM5qhTcXgKIWnTL3yIE=;
  b=V0OpgPaZbSKDcvo2NXd1Kw6w5I7h3ooa0xDaqc9e2eRYr3ErN5aHCyh4
   Dz+KNWeX3h+K+iG/z8DLTB5ohocvLa9mEhdgPEQpvnDrgXDt/F/xRus9W
   L/l7jSIMN+9xCjKCuZG1pIebNkzFEYRhUMBwHYOzXS5PFqRnBJyoh4wv1
   ziTjXFWMaORCLWYBuFL00+8r4hwng7dQSppP6vIgle6gQIwx2tMGyTp4z
   0+dH7W9/hKQY2CamZS6AFb0+PwVyKJLgds3wKxewJToUBn/+EdpGjau5f
   Tk1n3Rq+S9MkxQQBtSV4ncrctzMNjV23kBcYglW+sRUbtRO4vQAErJhir
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10451"; a="295792975"
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="295792975"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 07:46:45 -0700
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="671488346"
Received: from syeghiay-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.41.100])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 07:46:43 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 2/3] serial: add helpers to copy serial_rs485 from/to userspace
Date:   Fri, 26 Aug 2022 17:46:28 +0300
Message-Id: <20220826144629.11507-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220826144629.11507-1-ilpo.jarvinen@linux.intel.com>
References: <20220826144629.11507-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to the padding fields, the copying will need to a bit more than
usual.

Move padding clearing into the helper that copies back to userspace.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/serial_core.c | 41 +++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 9c1bf36b7a93..6d57cfdeda9d 100644
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
 
+static int user_rs485_to_kernel_serial_rs485(struct serial_rs485 *rs485,
+					     const struct serial_rs485 __user *rs485_user)
+{
+	if (copy_from_user(rs485, rs485_user, sizeof(*rs485)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int kernel_serial_rs485_to_user_rs485(struct serial_rs485 __user *rs485_user,
+					     struct serial_rs485 *rs485)
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
+	return kernel_serial_rs485_to_user_rs485(rs485_user, &rs485);
 }
 
 static int uart_set_rs485_config(struct tty_struct *tty, struct uart_port *port,
@@ -1433,8 +1448,9 @@ static int uart_set_rs485_config(struct tty_struct *tty, struct uart_port *port,
 	if (!port->rs485_config)
 		return -ENOTTY;
 
-	if (copy_from_user(&rs485, rs485_user, sizeof(*rs485_user)))
-		return -EFAULT;
+	ret = user_rs485_to_kernel_serial_rs485(&rs485, rs485_user);
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
+	return kernel_serial_rs485_to_user_rs485(rs485_user, &port->rs485);
 }
 
 static int uart_get_iso7816_config(struct uart_port *port,
-- 
2.30.2


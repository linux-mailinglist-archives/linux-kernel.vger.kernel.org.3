Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0448A53EB68
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233699AbiFFKIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 06:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233479AbiFFKGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 06:06:06 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F561207C1;
        Mon,  6 Jun 2022 03:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654509963; x=1686045963;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VcmEhh33jjTVe3ALqkigMTRIMktLH1f2shl4rAVdsNo=;
  b=AqkQC/tCmQaRPkmD8xPghrPUconYc5+bo4flPgoKUClgpcwaURf7ui9f
   AnP41louFP+sLyKdnxl53cy3ka69Ks7lRrO5g9khfWvlirQR4dMalAS3M
   /TAjnsxaY/D0odmZwFWUuDl1KlHE2F5FjOru+M6Dwhj1eKan83wjcTvl+
   IlZO345kwectIf8mWJKxHorsSkFn3tb0h1wwHjdyCKrtsgU+EHq+wlM95
   /YZNRrE+4SfE3JcRkcJ89/zOIcBfLL1/fT4Iaig/N8bLVOIHhrqJm5Xb+
   YjEtgaWIZonReeBXMj/yBpIGS/YylueQy487rtzp1BCjk1jnWRjs4Zkvc
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10369"; a="362987076"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="362987076"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 03:06:03 -0700
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="635523814"
Received: from amkossek-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.57.11])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 03:06:01 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 24/36] serial: return -EINVAL for non-legacy RS485 flags
Date:   Mon,  6 Jun 2022 13:04:21 +0300
Message-Id: <20220606100433.13793-25-ilpo.jarvinen@linux.intel.com>
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

In order to be add new flags more cleanly and safely, return -EINVAL
from TIOCSRS485 ioctl for the flags bits which are not among the
current legacy ones.

This might cause a regression for userspace as those non-flag bits do
not currently trigger -EINVAL. However, it would only occur if the
userspace is sending garbage bits so perhaps we'll get away with this
change.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/serial_core.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 6be538720564..621fc15e2e54 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1276,6 +1276,27 @@ static int uart_get_icount(struct tty_struct *tty,
 	return 0;
 }
 
+#define SER_RS485_LEGACY_FLAGS	(SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND | \
+				 SER_RS485_RTS_AFTER_SEND | SER_RS485_RX_DURING_TX | \
+				 SER_RS485_TERMINATE_BUS)
+
+static int uart_check_rs485_flags(struct uart_port *port, struct serial_rs485 *rs485)
+{
+	u32 flags = rs485->flags;
+
+	/* Don't return -EINVAL for unsupported legacy flags */
+	flags &= ~SER_RS485_LEGACY_FLAGS;
+
+	/*
+	 * For any bit outside of the legacy ones that is not supported by
+	 * the driver, return -EINVAL.
+	 */
+	if (flags & ~port->rs485_supported->flags)
+		return -EINVAL;
+
+	return 0;
+}
+
 static void uart_sanitize_serial_rs485(struct uart_port *port, struct serial_rs485 *rs485)
 {
 	u32 supported_flags = port->rs485_supported->flags;
@@ -1375,6 +1396,9 @@ static int uart_set_rs485_config(struct uart_port *port,
 	if (copy_from_user(&rs485, rs485_user, sizeof(*rs485_user)))
 		return -EFAULT;
 
+	ret = uart_check_rs485_flags(port, &rs485);
+	if (ret)
+		return ret;
 	uart_sanitize_serial_rs485(port, &rs485);
 
 	spin_lock_irqsave(&port->lock, flags);
-- 
2.30.2


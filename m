Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70BDC5A5CE9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 09:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbiH3Hac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 03:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbiH3HaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 03:30:18 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66B243E60;
        Tue, 30 Aug 2022 00:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661844611; x=1693380611;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/MfJB+K7qxvlPWSl6SnbaFRSJPE9DhdSLxgSaZcZ8cA=;
  b=cerKoRnd4BJTpoaL60ukCZy/B2iMRdiS2v2b60zyIzpTqunhe1zUQZRb
   ZMC69eb3InrX0GdBWGLPUb0+lkIapPpAHa2Eff96tg4nS2eCER2yGKRIF
   4mJB0QGKWApaHy3DKVq9SSVAPN1ADumY5ZIeQ8mTpnISgBsyQm2fAgLYQ
   nYJ1bUQWWoQh0WyxGBY7+J/kNQNSXUp4LuxvWT2Hln7yrldoC7O/E18kh
   GLWn7vhxMsbA0Z6GFFpYiioVnQzvn4OmtlUzrfmYxNYv14wKaBatGVtf8
   ykRNumaHn8ltg/LExS1FKkPwG81qiyxbdHWXebNpuiI+xSIkED6kM9WNE
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="282077223"
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="282077223"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 00:30:09 -0700
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="641262636"
Received: from arnesgom-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.54.235])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 00:30:06 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v2 1/4] serial: Rename vars in uart_get_rs485_config()
Date:   Tue, 30 Aug 2022 10:29:53 +0300
Message-Id: <20220830072956.3630-2-ilpo.jarvinen@linux.intel.com>
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

Make variable names to match uart_set_rs485_config() ones:
	- rs485 -> rs485_user
	- aux -> rs485

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/serial_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 12c87cd201a7..8834414a0b2f 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1408,16 +1408,16 @@ int uart_rs485_config(struct uart_port *port)
 EXPORT_SYMBOL_GPL(uart_rs485_config);
 
 static int uart_get_rs485_config(struct uart_port *port,
-			 struct serial_rs485 __user *rs485)
+			 struct serial_rs485 __user *rs485_user)
 {
+	struct serial_rs485 rs485;
 	unsigned long flags;
-	struct serial_rs485 aux;
 
 	spin_lock_irqsave(&port->lock, flags);
-	aux = port->rs485;
+	rs485 = port->rs485;
 	spin_unlock_irqrestore(&port->lock, flags);
 
-	if (copy_to_user(rs485, &aux, sizeof(aux)))
+	if (copy_to_user(rs485_user, &rs485, sizeof(rs485)))
 		return -EFAULT;
 
 	return 0;
-- 
2.30.2


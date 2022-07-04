Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68820565139
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 11:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbiGDJp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 05:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233358AbiGDJpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 05:45:51 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31645F7D;
        Mon,  4 Jul 2022 02:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656927944; x=1688463944;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nrdI1aqCOmMQHJwk0uWLeNOFyiDw3uvCvQxr40EDQMU=;
  b=NZzwjCV5S+RhuZEHRO5WRP0vJw1fsqjV0GZayW8VSohhkHC4A63fNITi
   a7jwZoUAeMsYQTQRqWiAjpgI5GswdahjR3tPWjzout3yxNvBXy5Ejrynd
   mA3/588n7oXvutZMOcu2XVgLR+WCaOhrSmlkZs+OUFc7Hg39LLbJo6duH
   SY/Q3usuwqmcp0imA2OOZsxmAeo2kcgItliWtO1/q6sKvkvSs8M8gepB6
   ocPdLv1JQ7BK+FJWQ3e56i3xTYDBwqLweVPTv5UfU6BtSvSwB/Mb/6Mm6
   Y/n+QMX5ODGpZZB+REHBVjgmh5lgLig/ZMfaswUCTZZTsyWquROfoX3Fk
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10397"; a="266111813"
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="266111813"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 02:45:44 -0700
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="649508842"
Received: from bclindho-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.49.27])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 02:45:41 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 2/2] serial: RS485 termination is supported if DT provides one
Date:   Mon,  4 Jul 2022 12:45:15 +0300
Message-Id: <20220704094515.6831-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220704094515.6831-1-ilpo.jarvinen@linux.intel.com>
References: <20220704094515.6831-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When DT provides rs485-term, set termination flag as supported.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/serial_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index a9cf1044a9fa..1db44cde76f6 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3409,6 +3409,8 @@ int uart_get_rs485_mode(struct uart_port *port)
 		port->rs485_term_gpio = NULL;
 		return dev_err_probe(dev, ret, "Cannot get rs485-term-gpios\n");
 	}
+	if (port->rs485_term_gpio)
+		port->rs485_supported.flags |= SER_RS485_TERMINATE_BUS;
 
 	return 0;
 }
-- 
2.30.2


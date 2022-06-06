Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A624A53E67D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233577AbiFFKGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 06:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233299AbiFFKFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 06:05:34 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E6C703F8;
        Mon,  6 Jun 2022 03:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654509933; x=1686045933;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=45ZGB+Mt9hakBvLDZWBXID2+gQ0mP+GP7HtxatKCn3U=;
  b=RxpNUNL15K5rIEzbb9RLZpSnC+J4vHykTwx8vrbN8iOKEn1qjil7bGgf
   mlQdL9M19b7yhxbyxqUw+DYuxkUw0FWNtUk864jDP3BbcyHt8Zr8xpEv4
   OgHd7V8R4Pdq09u+0N7VJV+cFsT8zmFESSk/rwZp5ohxDopUxXjpWCUkV
   SZMtJwQy1MYAYJK3BK8HIovumhoeKIx733hH0fu7oJpz7AuDZ4GM9FAY+
   +kmTFUMtLHJPjq671LM8b+XCZGNdVuYh1kAZHxs4VZfz4ttAF+f/kr+BP
   nmZb1Z4RQ5ZSqD3degdJMA5rxSyeJHOCuE8c+JBjkFbrG2NA5iwKRjmJ5
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10369"; a="362987043"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="362987043"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 03:05:16 -0700
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="635523593"
Received: from amkossek-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.57.11])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 03:05:14 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 08/36] serial: 8250_fintek: Fill in rs485_supported
Date:   Mon,  6 Jun 2022 13:04:05 +0300
Message-Id: <20220606100433.13793-9-ilpo.jarvinen@linux.intel.com>
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

Add information on supported serial_rs485 features.

Differentiate based on which port is in question.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250_fintek.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_fintek.c b/drivers/tty/serial/8250/8250_fintek.c
index dba5950b8d0e..6e98c376e082 100644
--- a/drivers/tty/serial/8250/8250_fintek.c
+++ b/drivers/tty/serial/8250/8250_fintek.c
@@ -424,6 +424,17 @@ static int probe_setup_port(struct fintek_8250 *pdata,
 	return -ENODEV;
 }
 
+/* Only the first port supports delays */
+static const struct serial_rs485 fintek_8250_rs485_supported_port0 = {
+	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND | SER_RS485_RTS_AFTER_SEND,
+	.delay_rts_before_send = 1,
+	.delay_rts_after_send = 1,
+};
+
+static const struct serial_rs485 fintek_8250_rs485_supported = {
+	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND | SER_RS485_RTS_AFTER_SEND,
+};
+
 static void fintek_8250_set_rs485_handler(struct uart_8250_port *uart)
 {
 	struct fintek_8250 *pdata = uart->port.private_data;
@@ -435,6 +446,10 @@ static void fintek_8250_set_rs485_handler(struct uart_8250_port *uart)
 	case CHIP_ID_F81866:
 	case CHIP_ID_F81865:
 		uart->port.rs485_config = fintek_8250_rs485_config;
+		if (!pdata->index)
+			uart->port.rs485_supported = &fintek_8250_rs485_supported_port0;
+		else
+			uart->port.rs485_supported = &fintek_8250_rs485_supported;
 		break;
 
 	default: /* No RS485 Auto direction functional */
-- 
2.30.2


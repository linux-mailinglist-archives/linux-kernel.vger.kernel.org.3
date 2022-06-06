Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B29A53EA0F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233529AbiFFKG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 06:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233290AbiFFKFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 06:05:33 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEEE17037D;
        Mon,  6 Jun 2022 03:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654509931; x=1686045931;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mvMP5iOD0jyEc6hOIs4E2k/EmjgKpS0mQlR4xWMekx0=;
  b=XTza74f/4pFYwUzFa9fLyuZ3nV41yw6QForA+rjeLUYyq8mKEGbT02Dn
   tKaU7R7dWoDrC67ImBO0S6ZzAHLuzT9P+GaDeI/SJrlN1sC/dtjQYr32W
   GopXaQWophrXv5E5Z9xjeOw6j7J50vKLYvVhtgXG7ltNTVLl1wYasD+GR
   Gmd4d/ZpCuxsWwTV3+Ab5+jpPClCQCGr3sQiyui8FMlR0Cg/x5HomRMT/
   lfSX9xEEpSNENRJfxY7C00cyIL0TxF/ln+7uFsIabw7sLKN3Y4UMQqomH
   ILBDFasSQYnDjABQe8xmpG18XFSpvCih/AA6Yizwua9qmBrNctt5PLwjS
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10369"; a="362987040"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="362987040"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 03:05:10 -0700
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="635523560"
Received: from amkossek-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.57.11])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 03:05:08 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 06/36] serial: 8250_dwlib: Fill in rs485_supported
Date:   Mon,  6 Jun 2022 13:04:03 +0300
Message-Id: <20220606100433.13793-7-ilpo.jarvinen@linux.intel.com>
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

Add information on supported serial_rs485 features. When the driver is
using em485, take advantage of serial8250_em485_supported.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dwlib.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_dwlib.c b/drivers/tty/serial/8250/8250_dwlib.c
index fbabfdd8c7b8..120b29519d74 100644
--- a/drivers/tty/serial/8250/8250_dwlib.c
+++ b/drivers/tty/serial/8250/8250_dwlib.c
@@ -149,6 +149,11 @@ static bool dw8250_detect_rs485_hw(struct uart_port *p)
 	return reg;
 }
 
+static const struct serial_rs485 dw8250_rs485_supported = {
+	.flags = SER_RS485_ENABLED | SER_RS485_RX_DURING_TX | SER_RS485_RTS_ON_SEND |
+		 SER_RS485_RTS_AFTER_SEND,
+};
+
 void dw8250_setup_port(struct uart_port *p)
 {
 	struct dw8250_port_data *pd = p->private_data;
@@ -159,8 +164,10 @@ void dw8250_setup_port(struct uart_port *p)
 	pd->hw_rs485_support = dw8250_detect_rs485_hw(p);
 	if (pd->hw_rs485_support) {
 		p->rs485_config = dw8250_rs485_config;
+		p->rs485_supported = &dw8250_rs485_supported;
 	} else {
 		p->rs485_config = serial8250_em485_config;
+		p->rs485_supported = &serial8250_em485_supported;
 		up->rs485_start_tx = serial8250_em485_start_tx;
 		up->rs485_stop_tx = serial8250_em485_stop_tx;
 	}
-- 
2.30.2


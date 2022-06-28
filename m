Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B376F55E668
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346823AbiF1Nmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 09:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346761AbiF1Nmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 09:42:50 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE13827CD0;
        Tue, 28 Jun 2022 06:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656423768; x=1687959768;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=50gRAoZGM9NF7c6C4HXrCkF3YdGjg4EaBCk9JFs1D5Y=;
  b=hzc6XVIRkLT5CoaZMDxKoWL2bskRBmYwJUStbeMRDjVd4zkQbNV2981j
   AOI8dDc04/Jtk0eHjufI1oqrjAFDkhog/3uDsVZa1Wx3FckESn7/2IDc1
   +P7o2T2Q+413oOattK6iMQRwvnxgw65lF1zbu+GwfB47aoyBia3pooTFD
   vUM3Seu4hpZKZNtUYKJUlC5H1ar72gcbvqSrk+gwmJvQsSf3VlRRV17mi
   WS7vGaQlnrIyGdDy8s6u0Pl7qVFqGfwhcHb3wwJEd4kKiQ+79m3eYyi18
   OrjLlWM1lh8ltify0mI+QgniniDgsqFpcG6XcuK6S7gbkA2bRC907hLD8
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="281780633"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="281780633"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 06:42:48 -0700
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="646918016"
Received: from iannetti-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.216.215])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 06:42:46 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] serial: 8250_dw: Use dw8250_serial_out() in dw8250_serial_out38x()
Date:   Tue, 28 Jun 2022 16:42:31 +0300
Message-Id: <20220628134234.53771-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220628134234.53771-1-ilpo.jarvinen@linux.intel.com>
References: <20220628134234.53771-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Place dw8250_serial_out() before dw8250_serial_out38x() so that it can
be called from dw8250_serial_out38x() to do the actual write.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dw.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 167a691c7b19..41bf063396e4 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -143,29 +143,23 @@ static void dw8250_tx_wait_empty(struct uart_port *p)
 	}
 }
 
-static void dw8250_serial_out38x(struct uart_port *p, int offset, int value)
+static void dw8250_serial_out(struct uart_port *p, int offset, int value)
 {
 	struct dw8250_data *d = to_dw8250_data(p->private_data);
 
-	/* Allow the TX to drain before we reconfigure */
-	if (offset == UART_LCR)
-		dw8250_tx_wait_empty(p);
-
 	writeb(value, p->membase + (offset << p->regshift));
 
 	if (offset == UART_LCR && !d->uart_16550_compatible)
 		dw8250_check_lcr(p, value);
 }
 
-
-static void dw8250_serial_out(struct uart_port *p, int offset, int value)
+static void dw8250_serial_out38x(struct uart_port *p, int offset, int value)
 {
-	struct dw8250_data *d = to_dw8250_data(p->private_data);
-
-	writeb(value, p->membase + (offset << p->regshift));
+	/* Allow the TX to drain before we reconfigure */
+	if (offset == UART_LCR)
+		dw8250_tx_wait_empty(p);
 
-	if (offset == UART_LCR && !d->uart_16550_compatible)
-		dw8250_check_lcr(p, value);
+	dw8250_serial_out(p, offset, value);
 }
 
 static unsigned int dw8250_serial_in(struct uart_port *p, int offset)
-- 
2.30.2


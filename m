Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE5F55D902
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343998AbiF1JmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 05:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241029AbiF1JmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 05:42:06 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2291252BD;
        Tue, 28 Jun 2022 02:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656409326; x=1687945326;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JsMXjIg8C9OG1eayahYeUAeX1A9gxni645x5KsPj9vw=;
  b=E3mPT6LVbiDohjed0sCnpwf/keG/AbIEi365/ktd3Kbi6vfdg/uAUQNM
   FzkjtFZ7gl6hyGzTMgKMnhEtalv3dgipO7yjQlZnGIpBYktV0Pkwe7fQR
   zJm4En0Y90d7HR4PGyGwpftHUlfNsF4pTe1wHRZO5CKXPVS7pwrpThGcH
   XY80jXNQ7rDoCYfJMB4kHlxKB6ENp2jFtGpvGa/M403HdWAvS5KPxLX3C
   aVxPpmrY5cO2LEzTrp0ntwUxexdex+ittwNOPHCrj6ZKW8Ext30ygXSqE
   ZjQqlIwJpSWAFQSxzWYcHybzqvMuRIQFulqBc45poa2uQPxJ3+lbUjMAl
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="282428984"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="282428984"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 02:42:05 -0700
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="646843688"
Received: from iannetti-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.216.215])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 02:42:02 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Allen Yan <yanwei@marvell.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH] serial: mvebu: Apply old baudrate to termios
Date:   Tue, 28 Jun 2022 12:41:55 +0300
Message-Id: <20220628094155.26297-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A fallback baud rate was derived from old termios but got never applied
to (new/current) termios. Old termios is dropped once ->set_termios()
call chain completes, only termios persists the values. Encode also the
old baud rate into termios.

Fixes: 68a0db1d7da2 ("serial: mvebu-uart: add function to change baudrate")
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

---
 drivers/tty/serial/mvebu-uart.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
index 0429c2a54290..12a79018697f 100644
--- a/drivers/tty/serial/mvebu-uart.c
+++ b/drivers/tty/serial/mvebu-uart.c
@@ -592,10 +592,9 @@ static void mvebu_uart_set_termios(struct uart_port *port,
 		if (old)
 			baud = uart_get_baud_rate(port, old, NULL,
 						  min_baud, max_baud);
-	} else {
-		tty_termios_encode_baud_rate(termios, baud, baud);
-		uart_update_timeout(port, termios->c_cflag, baud);
 	}
+	tty_termios_encode_baud_rate(termios, baud, baud);
+	uart_update_timeout(port, termios->c_cflag, baud);
 
 	/* Only the following flag changes are supported */
 	if (old) {

-- 
tg: (f287f971e256..) fix/mvebu-apply-old-baud (depends on: tty-next)

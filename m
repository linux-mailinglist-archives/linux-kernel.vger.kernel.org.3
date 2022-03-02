Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18BA4CA177
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 10:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240773AbiCBJ54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 04:57:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240748AbiCBJ5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 04:57:44 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE12E97B96;
        Wed,  2 Mar 2022 01:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646215021; x=1677751021;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mG40HTqpEgp/9V7rBkq1TB4ShO4U7Y47+Ht/i8vsZY8=;
  b=U21VTUMscXCB+irCii/TWrWjAHl/6s//6TalBV8KojC8h4ZYJn6PzcWA
   dnnLtMuSIKcQRVuLJesrB1JNxwpG6ogMclD2Dpq/8WHigxs02QJbUmkuJ
   N3DxWyKZOU8nRydhN1mwnpA5K+quhfNh5//8ZHLzUDVFhalP2f8MuDLzs
   Bi/5Y/HMyO6i2VFiXQJHZecWr3TxsjQOdJIS5WAw1USxvyvWbZfqZ/mbr
   PljetaVwX+FHLMafbzH9DNDoiSqIH06790FnjYDoh2Cm/mSnBZPysxeQq
   dL3rVjH2Wjj7sto/PjPlC8xUg6QCC7kEhtTVI0MZtcURMZ9eek69MCZ52
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="233980139"
X-IronPort-AV: E=Sophos;i="5.90,148,1643702400"; 
   d="scan'208";a="233980139"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 01:57:01 -0800
X-IronPort-AV: E=Sophos;i="5.90,148,1643702400"; 
   d="scan'208";a="551182079"
Received: from abotoi-mobl2.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.218.48])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 01:56:58 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Johan Hovold <johan@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Raymond Tan <raymond.tan@intel.com>
Subject: [PATCH 2/7] serial: 8250_dwlib: RS485 HW full duplex support
Date:   Wed,  2 Mar 2022 11:56:01 +0200
Message-Id: <20220302095606.14818-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220302095606.14818-1-ilpo.jarvinen@linux.intel.com>
References: <20220302095606.14818-1-ilpo.jarvinen@linux.intel.com>
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

The Synopsys DesignWare UART has a build-in support for the
RS485 protocol from IP version 4.0 onward. This patch enables
the support of HW Full Duplex mode support for it.

To ask for full duplex mode, userspace sets SER_RS485_RX_DURING_TX
flag and HW will take care of the rest.

Co-developed-by: Raymond Tan <raymond.tan@intel.com>
Signed-off-by: Raymond Tan <raymond.tan@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dwlib.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dwlib.c b/drivers/tty/serial/8250/8250_dwlib.c
index a4f09a95049b..d26792999984 100644
--- a/drivers/tty/serial/8250/8250_dwlib.c
+++ b/drivers/tty/serial/8250/8250_dwlib.c
@@ -110,9 +110,14 @@ static int dw8250_rs485_config(struct uart_port *p, struct serial_rs485 *rs485)
 
 	if (rs485->flags & SER_RS485_ENABLED) {
 		/* Clearing unsupported flags. */
-		rs485->flags &= SER_RS485_ENABLED;
-
-		tcr |= DW_UART_TCR_RS485_EN | DW_UART_TCR_XFER_MODE_DE_OR_RE;
+		rs485->flags &= SER_RS485_ENABLED | SER_RS485_RX_DURING_TX;
+		tcr |= DW_UART_TCR_RS485_EN;
+
+		if (rs485->flags & SER_RS485_RX_DURING_TX) {
+			tcr |= DW_UART_TCR_XFER_MODE_DE_DURING_RE;
+		} else {
+			tcr |= DW_UART_TCR_XFER_MODE_DE_OR_RE;
+		}
 		dw8250_writel_ext(p, DW_UART_DE_EN, 1);
 		dw8250_writel_ext(p, DW_UART_RE_EN, 1);
 	} else {
-- 
2.30.2


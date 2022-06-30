Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F63556173C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 12:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234780AbiF3KGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 06:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234754AbiF3KGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 06:06:20 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B9A244746;
        Thu, 30 Jun 2022 03:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656583562; x=1688119562;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aArJ+/tttqsgdUdRKLHM2+KGCl1I1CRCDeLBubWfQwE=;
  b=PNBZq6mfFWoqxaaECS3VEiO0KkpuyCXqzm5ALCfjpjhy4OY0OIPq1s6e
   ZFDFu6/j+9ZUOFneOTXYW6NA4mrPctVPj4ivRxMgcbHBKHCBQWKVaUDY3
   78CMJSnMbV1qkha+yNV2QAKy3xvlSKif60F5/leAaIyahgGmhJ82T8hzU
   Xr8h6y7niYiawspT1yPezh0a+DyLR78p0Nn3aCGT3r2vmGxboAlY2FhsB
   YYHPK1Gm2XYYw1yYNIRYlKbZS72s6my6Zp/Ua2Y06kNuPoZGOLqcqRkq8
   DIajF5/jgscf+SNcnL+XFh+R7TlRGsOiJ1PzDE7zNuZjZhW/hVqR6Wra6
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="282340073"
X-IronPort-AV: E=Sophos;i="5.92,233,1650956400"; 
   d="scan'208";a="282340073"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 03:05:49 -0700
X-IronPort-AV: E=Sophos;i="5.92,233,1650956400"; 
   d="scan'208";a="647826781"
Received: from emontau-mobl2.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.42.178])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 03:05:48 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] 8250_dwlib: Convert bitops to newer form
Date:   Thu, 30 Jun 2022 13:05:36 +0300
Message-Id: <20220630100536.41329-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
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

Instead of open-coding, use BIT(), GENMASK(), and FIELD_GET() helpers.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dwlib.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dwlib.c b/drivers/tty/serial/8250/8250_dwlib.c
index da330ef46446..a8bbed74ea70 100644
--- a/drivers/tty/serial/8250/8250_dwlib.c
+++ b/drivers/tty/serial/8250/8250_dwlib.c
@@ -46,21 +46,21 @@
 #define DW_UART_LCR_EXT_TRANSMIT_MODE	BIT(3)
 
 /* Component Parameter Register bits */
-#define DW_UART_CPR_ABP_DATA_WIDTH	(3 << 0)
-#define DW_UART_CPR_AFCE_MODE		(1 << 4)
-#define DW_UART_CPR_THRE_MODE		(1 << 5)
-#define DW_UART_CPR_SIR_MODE		(1 << 6)
-#define DW_UART_CPR_SIR_LP_MODE		(1 << 7)
-#define DW_UART_CPR_ADDITIONAL_FEATURES	(1 << 8)
-#define DW_UART_CPR_FIFO_ACCESS		(1 << 9)
-#define DW_UART_CPR_FIFO_STAT		(1 << 10)
-#define DW_UART_CPR_SHADOW		(1 << 11)
-#define DW_UART_CPR_ENCODED_PARMS	(1 << 12)
-#define DW_UART_CPR_DMA_EXTRA		(1 << 13)
-#define DW_UART_CPR_FIFO_MODE		(0xff << 16)
+#define DW_UART_CPR_ABP_DATA_WIDTH	GENMASK(1, 0)
+#define DW_UART_CPR_AFCE_MODE		BIT(4)
+#define DW_UART_CPR_THRE_MODE		BIT(5)
+#define DW_UART_CPR_SIR_MODE		BIT(6)
+#define DW_UART_CPR_SIR_LP_MODE		BIT(7)
+#define DW_UART_CPR_ADDITIONAL_FEATURES	BIT(8)
+#define DW_UART_CPR_FIFO_ACCESS		BIT(9)
+#define DW_UART_CPR_FIFO_STAT		BIT(10)
+#define DW_UART_CPR_SHADOW		BIT(11)
+#define DW_UART_CPR_ENCODED_PARMS	BIT(12)
+#define DW_UART_CPR_DMA_EXTRA		BIT(13)
+#define DW_UART_CPR_FIFO_MODE		GENMASK(23, 16)
 
 /* Helper for FIFO size calculation */
-#define DW_UART_CPR_FIFO_SIZE(a)	(((a >> 16) & 0xff) * 16)
+#define DW_UART_CPR_FIFO_SIZE(a)	(FIELD_GET(DW_UART_CPR_FIFO_MODE, (a)) * 16)
 
 /*
  * divisor = div(I) + div(F)
-- 
2.30.2


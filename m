Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561A74B6993
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 11:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236623AbiBOKlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 05:41:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbiBOKlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 05:41:35 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830A6F01;
        Tue, 15 Feb 2022 02:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644921684; x=1676457684;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bUFqVIa927kOx97MLVPfcfP+TipMCW3yTUUD0NGSecA=;
  b=j0JT2hU+uhgTIxY+pT+TUp95mr0rXmLHOwvvYrHDXfve/fE68EyIpkDf
   lXvTT5yv0nYP5iYzYVnXjYSPRgyRQ8doYZCU1tS1oh64fKJ5K9rvPf36V
   4+2RmKr0bS8tLkkDNkJxfLKVQWhPXeXXK3gFQbrNqN4PE6Xc/TE93CEbJ
   e17MqOy7iGqjBmLo++61SiVSl8M85XUthXSTSfq+0k2TfzaEVSm2aB+3J
   3kxzn85+8LKb+rf9AEKJSa9qIt7E22HV8l4/eAZEqlQ7Nz9NQKtrOJO06
   7R2UrqJSIrZjX6RFz6/HvmP7hTxZZ5Y3tx84b2YV3VbxQsT5GAiTx09nL
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="250268251"
X-IronPort-AV: E=Sophos;i="5.88,370,1635231600"; 
   d="scan'208";a="250268251"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 02:41:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,370,1635231600"; 
   d="scan'208";a="502361940"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 15 Feb 2022 02:41:12 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D577F15B; Tue, 15 Feb 2022 12:41:27 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v1 1/1] serial: 8250_mid: Get rid of custom MID_DEVICE() macro
Date:   Tue, 15 Feb 2022 12:41:26 +0200
Message-Id: <20220215104126.7220-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since PCI core provides a generic PCI_DEVICE_DATA() macro,
replace MID_DEVICE() with former one.

No functional change intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_mid.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_mid.c b/drivers/tty/serial/8250/8250_mid.c
index 5616fc0f7403..a2a03acb04ad 100644
--- a/drivers/tty/serial/8250/8250_mid.c
+++ b/drivers/tty/serial/8250/8250_mid.c
@@ -377,16 +377,14 @@ static const struct mid8250_board dnv_board = {
 	.exit = dnv_exit,
 };
 
-#define MID_DEVICE(id, board) { PCI_VDEVICE(INTEL, id), (kernel_ulong_t)&board }
-
 static const struct pci_device_id pci_ids[] = {
-	MID_DEVICE(PCI_DEVICE_ID_INTEL_PNW_UART1, pnw_board),
-	MID_DEVICE(PCI_DEVICE_ID_INTEL_PNW_UART2, pnw_board),
-	MID_DEVICE(PCI_DEVICE_ID_INTEL_PNW_UART3, pnw_board),
-	MID_DEVICE(PCI_DEVICE_ID_INTEL_TNG_UART, tng_board),
-	MID_DEVICE(PCI_DEVICE_ID_INTEL_CDF_UART, dnv_board),
-	MID_DEVICE(PCI_DEVICE_ID_INTEL_DNV_UART, dnv_board),
-	{ },
+	{ PCI_DEVICE_DATA(INTEL, PNW_UART1, &pnw_board) },
+	{ PCI_DEVICE_DATA(INTEL, PNW_UART2, &pnw_board) },
+	{ PCI_DEVICE_DATA(INTEL, PNW_UART3, &pnw_board) },
+	{ PCI_DEVICE_DATA(INTEL, TNG_UART, &tng_board) },
+	{ PCI_DEVICE_DATA(INTEL, CDF_UART, &dnv_board) },
+	{ PCI_DEVICE_DATA(INTEL, DNV_UART, &dnv_board) },
+	{ }
 };
 MODULE_DEVICE_TABLE(pci, pci_ids);
 
-- 
2.34.1


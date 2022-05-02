Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83D6516F25
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 13:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384822AbiEBL75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 07:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233089AbiEBL7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 07:59:51 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C501B796;
        Mon,  2 May 2022 04:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651492583; x=1683028583;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LU/yq2s1oiKyRxaX8QPYQK3cW92BG0hvyB55dS1zvnY=;
  b=bGR0VMGNJiB0kh6bqN3kxw3bFix7H9IWfbmn9pY2Q3aaE6cc7WPr7ViT
   G7bqSLJB9O8CDj5MXPHRlqxKeBnKVGw1ku5HCCgNWOqYtYvN76LxRSXcr
   OQkO+w+jNyDfjEJuXbOJsC3bpD26+V+/a2OnfLKQMA4kw9G2EYy7kfWYM
   RRLmK9sYUW08xeUqH7xSWaWG3CzioR0weqs1cAw+jqlQKv6CCc2097Vb9
   eNjYw5+dmPTjnCn83q0aFkSLo0Q9s2BOaK2CO41Zl454Gi/xv+zBWm2yC
   nktYWs+VR0nCfq5fUil8KulDOKlhXwqtEUVnUU9K41MWmPmaPXD9agpCn
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10334"; a="247100462"
X-IronPort-AV: E=Sophos;i="5.91,190,1647327600"; 
   d="scan'208";a="247100462"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 04:56:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,190,1647327600"; 
   d="scan'208";a="707576070"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 02 May 2022 04:56:20 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] serial: 8250: dw: Fix NULL pointer dereference
Date:   Mon,  2 May 2022 14:56:21 +0300
Message-Id: <20220502115621.77985-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dw8250_platform_data is only used on DT platforms for now.

Fixes: 4a218b277fdb ("serial: 8250: dw: Create a generic platform data structure")
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
Hi,

I'm sorry, I have to resend this (to you guys).
I left out the mailing lists.

Br,
---
 drivers/tty/serial/8250/8250_dw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 0cf1a99dc1244..31422e44c64ff 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -433,9 +433,9 @@ static void dw8250_prepare_rx_dma(struct uart_8250_port *p)
 static void dw8250_quirks(struct uart_port *p, struct dw8250_data *data)
 {
 	struct device_node *np = p->dev->of_node;
-	unsigned int quirks = data->pdata->quirks;
 
 	if (np) {
+		unsigned int quirks = data->pdata->quirks;
 		int id;
 
 		/* get index of serial line, if found in DT aliases */
-- 
2.35.1


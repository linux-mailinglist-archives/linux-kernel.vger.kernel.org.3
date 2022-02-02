Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E42A4A7687
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 18:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238817AbiBBRKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 12:10:50 -0500
Received: from mga06.intel.com ([134.134.136.31]:35132 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230361AbiBBRKr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 12:10:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643821848; x=1675357848;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GrvrH0tQQh4vU96P3GxSl6OBtmroTxelmCJ3/Fm2GcE=;
  b=AMNVaxikv5ESTwFRAW8wRHwzakZnImCaoilWmDP9w8JPejd2YOeH8QfF
   HbEkx78io78okD6qQIZf97e1jHMjC8SktYz2vaXRHvpHXERJ1eJGV3iF3
   GCXNhli2+zYvGo9XhdvbMWZV30IH4VDLuxZ8y7kJ7y0OnKtg8mYcrq0B2
   vFdSEGp/BP+9Lw6xhHBcH8XE3LJEYVWOjvu7SazNSC+FWvTxLworutH1h
   rXZhz9AAsx0R6vcH+NzAssihlpGT2yNeZwqdgRTZIMiZ7b9f2KPbGy7Pk
   x3xiG815RgChpse8ezmKsVZ5KTZh49zEzwICCPosOIH7POAvzPXMduUun
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="308700927"
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="308700927"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 08:57:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="534914765"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 02 Feb 2022 08:56:52 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 21C023B7; Wed,  2 Feb 2022 18:57:07 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] tty: Drop duplicate NULL check in TTY port functions
Date:   Wed,  2 Feb 2022 18:57:04 +0200
Message-Id: <20220202165704.5680-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The free_page(addr), which becomes free_pages(addr, 0) checks addr against 0.
No need to repeat this check in the callers, i.e.  tty_port_free_xmit_buf()
and tty_port_destructor().

Note, INIT_KFIFO() is safe without that check, because it's aware of kfifo PTR
versus embedded kfifo.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/tty_port.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index 4282895ede9e..880608a65773 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -240,11 +240,9 @@ EXPORT_SYMBOL(tty_port_alloc_xmit_buf);
 void tty_port_free_xmit_buf(struct tty_port *port)
 {
 	mutex_lock(&port->buf_mutex);
-	if (port->xmit_buf != NULL) {
-		free_page((unsigned long)port->xmit_buf);
-		port->xmit_buf = NULL;
-		INIT_KFIFO(port->xmit_fifo);
-	}
+	free_page((unsigned long)port->xmit_buf);
+	port->xmit_buf = NULL;
+	INIT_KFIFO(port->xmit_fifo);
 	mutex_unlock(&port->buf_mutex);
 }
 EXPORT_SYMBOL(tty_port_free_xmit_buf);
@@ -271,8 +269,7 @@ static void tty_port_destructor(struct kref *kref)
 	/* check if last port ref was dropped before tty release */
 	if (WARN_ON(port->itty))
 		return;
-	if (port->xmit_buf)
-		free_page((unsigned long)port->xmit_buf);
+	free_page((unsigned long)port->xmit_buf);
 	tty_port_destroy(port);
 	if (port->ops && port->ops->destruct)
 		port->ops->destruct(port);
-- 
2.34.1


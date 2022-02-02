Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED9FA4A7688
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 18:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346143AbiBBRK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 12:10:26 -0500
Received: from mga14.intel.com ([192.55.52.115]:60234 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346145AbiBBRKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 12:10:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643821820; x=1675357820;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AYG8F+5sXGC9wmI7ylQnq2WQBsMvjdqnXaMozC3jUkE=;
  b=hmpIxKzvPgMiWuk7jMyXrzi6HprbC0HYsuGR/T525GacdHppz2SoIOZR
   8Azx8vn2M/gVBzr3snUvsNI1UuwUHvxo1Yg0a+VuQMINsScSqbeQIYu+H
   /cxi9iIZFOW9m4J9YqiiL3NzbsMeZSI5mtsO9F5dO1smy9KlkMzGHUScR
   c9SRSRqNKPXt2goCcqlOcg7ib9FW3kdFB95SX+fPxXLXSA5M8GkrbJo+7
   QgQctz4GyrW/pCCv3kIIuZ7gbA5dt61JNn4FQdDUKzs2vuCzY7A/hVYF1
   p6aFOx6sYx3w2TEocwvznNKxkI0sE/5Nf5/6w2u4OHmDtNAaPlEPSlG/0
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="248190488"
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="248190488"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 08:56:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="482893472"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 02 Feb 2022 08:56:36 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2472D3B7; Wed,  2 Feb 2022 18:56:51 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] serial: core: Drop duplicate NULL check in uart_*shutdown()
Date:   Wed,  2 Feb 2022 18:56:48 +0200
Message-Id: <20220202165648.5610-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The free_page(addr), which becomes free_pages(addr, 0) checks addr
against 0. No need to repeat this check in the callers.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/serial_core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 57f472268b6d..59f93040d807 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -328,8 +328,7 @@ static void uart_shutdown(struct tty_struct *tty, struct uart_state *state)
 	state->xmit.buf = NULL;
 	spin_unlock_irqrestore(&uport->lock, flags);
 
-	if (xmit_buf)
-		free_page((unsigned long)xmit_buf);
+	free_page((unsigned long)xmit_buf);
 }
 
 /**
@@ -1621,8 +1620,7 @@ static void uart_tty_port_shutdown(struct tty_port *port)
 	state->xmit.buf = NULL;
 	spin_unlock_irq(&uport->lock);
 
-	if (buf)
-		free_page((unsigned long)buf);
+	free_page((unsigned long)buf);
 }
 
 static void uart_wait_until_sent(struct tty_struct *tty, int timeout)
-- 
2.34.1


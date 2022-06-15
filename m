Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45FBE54C44E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 11:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346785AbiFOJIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 05:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344115AbiFOJHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 05:07:48 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D61318;
        Wed, 15 Jun 2022 02:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655284045; x=1686820045;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=HAnzpIYqjQ6/BJ8qJrY4ssrEeQWRAxVZqY91Bj00quk=;
  b=UbyCqL0kst1AJK10Ey8C94DyQUx9HHEr3s2j6v31SS2FlH9zf8Rh3z/s
   S19f6FpFr/4jm/BHYBrL+i2kRW/n+0pWMO89SssTv1XAxGzCRhTLnwKXG
   jNxwJfxt2KBeJydwHM7qTyxrq2jq55WDkNf046WrUxwfuex6QborXl1sT
   8KkPS+qyxisBEIOH3/+oqEy3aXa5SmsYZEquauILJk8tGBDJsMMrAVB7T
   QIHxhk283Qe0lRaMXzLAwqVeaPKme3kA1cYIuTzQsievj8xju8IFAYDO0
   Q5bJK165t/4sNb9DT+GoQSUGBL86VwDmgQET3jhWJnOyKy1xlMhVZYdAE
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="276464684"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="276464684"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 02:07:25 -0700
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="830934154"
Received: from mgrymel-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.41.34])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 02:07:23 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] serial: 8250: Fix __stop_tx() & DMA Tx restart races
Date:   Wed, 15 Jun 2022 12:06:49 +0300
Message-Id: <20220615090651.15340-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220615090651.15340-1-ilpo.jarvinen@linux.intel.com>
References: <20220615090651.15340-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit e8ffbb71f783 ("serial: 8250: use THRE & __stop_tx also with
DMA") changed __dma_tx_complete() to enable THRI that is cleared in
__stop_tx() once THRE is asserted as UART runs out bits to transmit. It
is possible, however, that more data arrives in between in which case
serial8250_tx_dma() resumes Tx. THRI is not supposed to be on during
DMA Tx because DMA is based on completion handler, therefore THRI must
be cleared unconditionally in serial8250_tx_dma().

When Tx is about to start, another race window exists with
serial8250_handle_irq() leading to a call into __stop_tx() while the
Tx has already been resumed:

__tx_complete():
  -> spin_lock(port->lock)
  -> dma->tx_running = 0
  -> serial8250_set_THRI()
  -> spin_unlock(port->lock)

uart_start():
				serial8250_handle_irq():
  -> spin_lock(port->lock)
  -> serial8250_tx_dma():
    -> dma->tx_running = 1
  -> spin_unlock(port->lock)
				  -> spin_lock(port->lock)
				  -> __stop_tx()

Close this race by checking !dma->tx_running before calling into
__stop_tx().

Fixes: e8ffbb71f783 ("serial: 8250: use THRE & __stop_tx also with DMA")
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dma.c  | 6 +++---
 drivers/tty/serial/8250/8250_port.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
index 7133fceed35e..a8dba4a0a8fb 100644
--- a/drivers/tty/serial/8250/8250_dma.c
+++ b/drivers/tty/serial/8250/8250_dma.c
@@ -106,10 +106,10 @@ int serial8250_tx_dma(struct uart_8250_port *p)
 				   UART_XMIT_SIZE, DMA_TO_DEVICE);
 
 	dma_async_issue_pending(dma->txchan);
-	if (dma->tx_err) {
+	serial8250_clear_THRI(p);
+	if (dma->tx_err)
 		dma->tx_err = 0;
-		serial8250_clear_THRI(p);
-	}
+
 	return 0;
 err:
 	dma->tx_err = 1;
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 953b0fadfd4c..684a1f1fd686 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1936,7 +1936,7 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
 	if ((status & UART_LSR_THRE) && (up->ier & UART_IER_THRI)) {
 		if (!up->dma || up->dma->tx_err)
 			serial8250_tx_chars(up);
-		else
+		else if (!up->dma->tx_running)
 			__stop_tx(up);
 	}
 
-- 
2.30.2


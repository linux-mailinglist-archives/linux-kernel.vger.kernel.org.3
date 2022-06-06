Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7257B53EB61
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238618AbiFFNPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 09:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238616AbiFFNPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 09:15:21 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E956236E38;
        Mon,  6 Jun 2022 06:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654521320; x=1686057320;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VptkMufomdRSrg3I6L8NzNQ9Iz/Fv8+mCnYXfJFZ6Cg=;
  b=aaDDvIU48rBgeO9ALP+J03LAjmjQEYAgHUAiTybH2RNswZD6lNdTDnXq
   RX0HlQug72uCmq/ir03U442BJXTMsAi8sHonXa5D3IR8E1/RBl3KNqxn3
   enVhcs+5X15yJQrVzlTGXZJvChhmYCpBGQHKXK0XSqdNAVC+KD40t/s4v
   VStlixgq05JK0/W196TwE46XnkLiFphdUA3H3xv/k+8UfaFLIC1PpaRbt
   3tpcSRbKvehF0X8LWYDx9bFOky0iRM1MPkSJf0XUFMUhpw+5N1Wdt7O5Y
   GKqrVXaUf278J4TmBMfjUZfQfyzRlgcIFBYT8Ta53H2DLX1iPoks6DM8k
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10369"; a="339948477"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="339948477"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 06:11:56 -0700
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="583630999"
Received: from amkossek-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.57.11])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 06:11:51 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Douglas Anderson <dianders@chromium.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@penugtronix.de>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 5/6] serial: 8250_dw: Use serial_lsr_in() in dw8250_handle_irq()
Date:   Mon,  6 Jun 2022 16:11:23 +0300
Message-Id: <20220606131124.53394-6-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220606131124.53394-1-ilpo.jarvinen@linux.intel.com>
References: <20220606131124.53394-1-ilpo.jarvinen@linux.intel.com>
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

dw8250_handle_irq() reads LSR under a few conditions, convert both to
use serial_lsr_in() in order to preserve LSR flags properly across
reads.

Cc: Douglas Anderson <dianders@chromium.org>
Cc: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Fixes: 424d79183af0 ("serial: 8250_dw: Avoid "too much work" from bogus rx timeout interrupt")
Fixes: aa63d786cea2 ("serial: 8250: dw: Add support for DMA flow controlling devices")
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index f57bbd32ef11..1fae45991812 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -253,7 +253,7 @@ static int dw8250_handle_irq(struct uart_port *p)
 	 */
 	if (!up->dma && rx_timeout) {
 		spin_lock_irqsave(&p->lock, flags);
-		status = p->serial_in(p, UART_LSR);
+		status = serial_lsr_in(up);
 
 		if (!(status & (UART_LSR_DR | UART_LSR_BI)))
 			(void) p->serial_in(p, UART_RX);
@@ -263,7 +263,7 @@ static int dw8250_handle_irq(struct uart_port *p)
 
 	/* Manually stop the Rx DMA transfer when acting as flow controller */
 	if (quirks & DW_UART_QUIRK_IS_DMA_FC && up->dma && up->dma->rx_running && rx_timeout) {
-		status = p->serial_in(p, UART_LSR);
+		status = serial_lsr_in(up);
 		if (status & (UART_LSR_DR | UART_LSR_BI)) {
 			dw8250_writel_ext(p, RZN1_UART_RDMACR, 0);
 			dw8250_writel_ext(p, DW_UART_DMASA, 1);
-- 
2.30.2


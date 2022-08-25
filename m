Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E706B5A0C56
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 11:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238975AbiHYJRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 05:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238964AbiHYJR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 05:17:28 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C174DA0261;
        Thu, 25 Aug 2022 02:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661419045; x=1692955045;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MjrKZ5cYNhk+dL0Fd0cvj6Jjmr5zP3B9DluglCDwBko=;
  b=Pdzh9POeGnioWKZnO/hT7hcSpT7ExyAdZrcIffcinSUTnHrD1zjzmf0G
   CiJNrNFf/57gVw1o6bBvfWAO0bslj1KcuGg1cMebUom1Iq4ElH/oHkGfQ
   Mq8zh52zvSWZuyiJLXRm6+kiMMj9ZJGr4kcmvynFAS8ICT+F/HuPzzXmf
   udAwZdLbhlRBq7/2EVbWT2HvIXZ008dRoWtMFtVSXKXeGUp8PqqD7B7pt
   AfMCFEbvwknmrl4FLsdNINjvEicvFQv1N3I5hhld1A/ESFIMtN4CNA4J5
   i3trTKZl2Yb2MGGL3dkEzm9dBXMq/evcB6GO7HlmsiuLpGtcp/XdyPEBb
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="355917181"
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; 
   d="scan'208";a="355917181"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 02:17:25 -0700
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; 
   d="scan'208";a="938254139"
Received: from mblazque-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.44.101])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 02:17:22 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Alan Cox <alan@linux.intel.com>,
        Stephen Warren <swarren@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 2/3] serial: tegra: Use uart_xmit_advance(), fixes icount.tx accounting
Date:   Thu, 25 Aug 2022 12:17:06 +0300
Message-Id: <20220825091707.8112-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220825091707.8112-1-ilpo.jarvinen@linux.intel.com>
References: <20220825091707.8112-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DMA complete & stop paths did not correctly account Tx'ed characters
into icount.tx. Using uart_xmit_advance() fixes the problem.

Fixes: e9ea096dd225 ("serial: tegra: add serial driver")
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/serial-tegra.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index ad4f3567ff90..a5748e41483b 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -525,7 +525,7 @@ static void tegra_uart_tx_dma_complete(void *args)
 	count = tup->tx_bytes_requested - state.residue;
 	async_tx_ack(tup->tx_dma_desc);
 	spin_lock_irqsave(&tup->uport.lock, flags);
-	xmit->tail = (xmit->tail + count) & (UART_XMIT_SIZE - 1);
+	uart_xmit_advance(&tup->uport, count);
 	tup->tx_in_progress = 0;
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 		uart_write_wakeup(&tup->uport);
@@ -613,7 +613,6 @@ static unsigned int tegra_uart_tx_empty(struct uart_port *u)
 static void tegra_uart_stop_tx(struct uart_port *u)
 {
 	struct tegra_uart_port *tup = to_tegra_uport(u);
-	struct circ_buf *xmit = &tup->uport.state->xmit;
 	struct dma_tx_state state;
 	unsigned int count;
 
@@ -624,7 +623,7 @@ static void tegra_uart_stop_tx(struct uart_port *u)
 	dmaengine_tx_status(tup->tx_dma_chan, tup->tx_cookie, &state);
 	count = tup->tx_bytes_requested - state.residue;
 	async_tx_ack(tup->tx_dma_desc);
-	xmit->tail = (xmit->tail + count) & (UART_XMIT_SIZE - 1);
+	uart_xmit_advance(&tup->uport, count);
 	tup->tx_in_progress = 0;
 }
 
-- 
2.30.2


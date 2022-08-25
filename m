Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1AD05A0C14
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 10:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237642AbiHYI6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 04:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236838AbiHYI6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 04:58:33 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C77A897D;
        Thu, 25 Aug 2022 01:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661417910; x=1692953910;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Mo3+Z0Et9XVBfR5W8mmg0CVqSKWWShtgU39BQYehL8Y=;
  b=kRUXDG8TqwxdBtN2dzH1lrTTF4C2m0T4NiICaoStS9n+AdfXyFnz6xPn
   JqiXOjJUoG10GAW/lY1mMLm9p92REtdTxFmkaI5ZK9IYHsdkf7545FeEf
   MynM3aVLNDdtn0R1gjVj+NnbIamf9rFnWJ3Kv6shNC/XfKhNPa0K667Kl
   I4NoIeuNeUVbJro3s9Roh7NW0qI2lxpQY+K60TecpaVvkdmg3h0BBgMqr
   dhDQ+FZLl0JsqSJpd8NqbiGhL03VDcdYCMFHTlopOl4IKSjitXgQY2aKh
   fchEnMA0PedeeZtxojHuk17d+VTH2dPX/rNh0GkWOYP7YHg3CowDxt5L6
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="273941407"
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; 
   d="scan'208";a="273941407"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 01:58:30 -0700
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; 
   d="scan'208";a="670893930"
Received: from mblazque-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.44.101])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 01:58:28 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 3/5] serial: fsl_lpuart: Remove custom frame size calculation
Date:   Thu, 25 Aug 2022 11:58:08 +0300
Message-Id: <20220825085810.7290-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220825085810.7290-1-ilpo.jarvinen@linux.intel.com>
References: <20220825085810.7290-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The number of bits can be calculated using tty_get_frame_size(), no
need for the driver to do it on its own.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/fsl_lpuart.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index f6c33cd228c8..926460f1dc08 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1284,23 +1284,19 @@ static inline int lpuart_start_rx_dma(struct lpuart_port *sport)
 	struct dma_slave_config dma_rx_sconfig = {};
 	struct circ_buf *ring = &sport->rx_ring;
 	int ret, nent;
-	int bits, baud;
+	int baud;
 	struct tty_port *port = &sport->port.state->port;
 	struct tty_struct *tty = port->tty;
 	struct ktermios *termios = &tty->termios;
 	struct dma_chan *chan = sport->dma_rx_chan;
 
 	baud = tty_get_baud_rate(tty);
-
-	bits = (termios->c_cflag & CSIZE) == CS7 ? 9 : 10;
-	if (termios->c_cflag & PARENB)
-		bits++;
-
 	/*
 	 * Calculate length of one DMA buffer size to keep latency below
 	 * 10ms at any baud rate.
 	 */
-	sport->rx_dma_rng_buf_len = (DMA_RX_TIMEOUT * baud /  bits / 1000) * 2;
+	sport->rx_dma_rng_buf_len = (DMA_RX_TIMEOUT * baud / tty_get_frame_size(termios->c_cflag) /
+				     1000) * 2;
 	sport->rx_dma_rng_buf_len = (1 << (fls(sport->rx_dma_rng_buf_len) - 1));
 	if (sport->rx_dma_rng_buf_len < 16)
 		sport->rx_dma_rng_buf_len = 16;
-- 
2.30.2


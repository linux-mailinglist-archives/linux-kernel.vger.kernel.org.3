Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9656359E804
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 18:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245570AbiHWQvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 12:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245736AbiHWQua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 12:50:30 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC82C6940;
        Tue, 23 Aug 2022 07:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661264352; x=1692800352;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PsOi3fbzWr8P5Muv3jMlM40nS/z+63mGM4QBzrU8bew=;
  b=MysyLZh2i0qpIHpeo5F1aAqv69fFsyeMvJi4HNqzyWGadYeKeq6uIIdE
   n4u0GpUx6IlOeEAiOK+yxPsSqWOIRXdxko4aUqRfu0MasiRV57rpws7L9
   1M56ORV4qv/A0PCrQej95rEspknqEhtoQ/Bsjf41IjQGuReTpOLmOwp5x
   oRU2fI2uTpoBgKSmUD9pbmy7aVwWZqdc3h0zdF2xGi+g5npcV+wPw6+/O
   K6ioKoTW1hV3UlM4VdbD7pQ8J3Xdh96WjZ72W3e8TLiKYQ3hTYhPrRPw1
   SakL2Ymd9AYGtdxjmZ2Wh/+gMUpDr0rZMdZ5WN+G6pUrVvYUE17qKNVJm
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="276723953"
X-IronPort-AV: E=Sophos;i="5.93,257,1654585200"; 
   d="scan'208";a="276723953"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 07:18:57 -0700
X-IronPort-AV: E=Sophos;i="5.93,257,1654585200"; 
   d="scan'208";a="638671449"
Received: from kimtingt-mobl.gar.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.42.4])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 07:18:54 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 3/3] serial: pch_uart: CIRC_CNT_TO_END() is enough
Date:   Tue, 23 Aug 2022 17:18:39 +0300
Message-Id: <20220823141839.165244-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220823141839.165244-1-ilpo.jarvinen@linux.intel.com>
References: <20220823141839.165244-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Testing also CIRC_CNT() with CIRC_CNT_TO_END() is unnecessary because
to latter alone covers all necessary cases.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/pch_uart.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index 8a9065e4a903..116a2e76093d 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -898,9 +898,7 @@ static unsigned int dma_handle_tx(struct eg20t_port *priv)
 		fifo_size--;
 	}
 
-	bytes = min((int)CIRC_CNT(xmit->head, xmit->tail,
-			     UART_XMIT_SIZE), CIRC_CNT_TO_END(xmit->head,
-			     xmit->tail, UART_XMIT_SIZE));
+	bytes = CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE);
 	if (!bytes) {
 		dev_dbg(priv->port.dev, "%s 0 bytes return\n", __func__);
 		pch_uart_hal_disable_interrupt(priv, PCH_UART_HAL_TX_INT);
-- 
2.30.2


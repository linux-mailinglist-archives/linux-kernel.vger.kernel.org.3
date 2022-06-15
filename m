Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBEA54C457
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 11:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344063AbiFOJIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 05:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239449AbiFOJHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 05:07:49 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A682658;
        Wed, 15 Jun 2022 02:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655284051; x=1686820051;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rPEgutCYQxCEj6n1NlFVBS763xWOp9KYB+LXwOMc4es=;
  b=jOMRJwlecZ0UapmQLnY5fxsi65Fq130TS0kZ0iEJeOqQRBRMNfODHRie
   z4ZhGENDBkBApFKWSQqtJFAkZPLBH6yPyKU7viWuwKw5hxAuDz+BxjtdF
   dDtPG6/mqP2E4K15lMjFxnqIQ5LmNvnWZtDfslVO+CIG9uA5QwMd7IAXD
   LUpJGtWsSvPvdvWoAnoFw4uFQxXs9NSVgahCAnDhBckyzecgLxnC/Culh
   wi/qXI0JhUJ3rQqSpYf5ajtD/xutBj3lcH6ALdxJnwlELbQVZWBLO2TRP
   YOPZyapv8npjFUUNxqkhskW0EDoLMV329M8wlMEReXK7UDGhqwYQu7nta
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="276464717"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="276464717"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 02:07:30 -0700
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="830934168"
Received: from mgrymel-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.41.34])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 02:07:29 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 3/3] serial: 8250_dma: No need for if (dma->tx_err)
Date:   Wed, 15 Jun 2022 12:06:51 +0300
Message-Id: <20220615090651.15340-4-ilpo.jarvinen@linux.intel.com>
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

The code can just clear dma->tx_err unconditionally.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dma.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
index a8dba4a0a8fb..d99020fd3427 100644
--- a/drivers/tty/serial/8250/8250_dma.c
+++ b/drivers/tty/serial/8250/8250_dma.c
@@ -107,8 +107,7 @@ int serial8250_tx_dma(struct uart_8250_port *p)
 
 	dma_async_issue_pending(dma->txchan);
 	serial8250_clear_THRI(p);
-	if (dma->tx_err)
-		dma->tx_err = 0;
+	dma->tx_err = 0;
 
 	return 0;
 err:
-- 
2.30.2


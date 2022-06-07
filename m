Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEFAA53F862
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 10:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238352AbiFGImS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 04:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238345AbiFGImM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 04:42:12 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106CB32ED2;
        Tue,  7 Jun 2022 01:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654591330; x=1686127330;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hue1OWpyEYvWCbIXGd1i/2Zb5JQTovT2W/Hw1M+6dDo=;
  b=SGfLqe3OCq7743MylU0g1UbnRwkB2Nb6rN9YE4Bj+Ehflwg01JjiD2ER
   qhgd63fesfwdkYYII3urFdLeqDuAyaaiOz2ejxKKNXS1ujLvXTNv86MaD
   BLe2D0et5Hf3/IwOWDTp0tDWJzJ3+xjaMYPv+YwR1LDfJ2uGFwLFoE27K
   +hFuJvXzlwH/7rKEuuBUSidiIUagm+lwrsfWaQv+ExQwlid8ls/OCl5tX
   IUqInHBNsYTCO8enmt+5k7KRVOVzZbH6/Ne8MOc4+M15199ANEfBDBeN+
   tnCEwUo6Cv4+kIao0J0+btdIN7aWYD+WSOelZaRFcc9P2adE+Qs5BD/cV
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="277398633"
X-IronPort-AV: E=Sophos;i="5.91,283,1647327600"; 
   d="scan'208";a="277398633"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 01:42:09 -0700
X-IronPort-AV: E=Sophos;i="5.91,283,1647327600"; 
   d="scan'208";a="647933840"
Received: from akmessan-mobl1.amr.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.214.146])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 01:42:07 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 2/2] serial: 8250: handle __start_tx() call in start_tx()
Date:   Tue,  7 Jun 2022 11:41:54 +0300
Message-Id: <20220607084154.8172-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220607084154.8172-1-ilpo.jarvinen@linux.intel.com>
References: <20220607084154.8172-1-ilpo.jarvinen@linux.intel.com>
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

As either start_tx_rs485() or start_tx() calls __start_tx() as the last
line of their logic, it makes sense to just move that call into
start_tx(). When start_tx_rs485() wants to defer tx using timer, return
false so start_tx() can return based on it.

Reorganize em485 code in serial8250_start_tx() so that the return can be
shared for the cases where tx start is deferred.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250_port.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 448cfbb05f63..a3ffbdfe8fae 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1610,7 +1610,8 @@ void serial8250_em485_start_tx(struct uart_8250_port *up)
 }
 EXPORT_SYMBOL_GPL(serial8250_em485_start_tx);
 
-static inline void start_tx_rs485(struct uart_port *port)
+/* Returns false, if start_tx_timer was setup to defer TX start */
+static bool start_tx_rs485(struct uart_port *port)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
 	struct uart_8250_em485 *em485 = up->em485;
@@ -1638,11 +1639,11 @@ static inline void start_tx_rs485(struct uart_port *port)
 			em485->active_timer = &em485->start_tx_timer;
 			start_hrtimer_ms(&em485->start_tx_timer,
 					 up->port.rs485.delay_rts_before_send);
-			return;
+			return false;
 		}
 	}
 
-	__start_tx(port);
+	return true;
 }
 
 static enum hrtimer_restart serial8250_em485_handle_start_tx(struct hrtimer *t)
@@ -1672,14 +1673,12 @@ static void serial8250_start_tx(struct uart_port *port)
 
 	serial8250_rpm_get_tx(up);
 
-	if (em485 &&
-	    em485->active_timer == &em485->start_tx_timer)
-		return;
-
-	if (em485)
-		start_tx_rs485(port);
-	else
-		__start_tx(port);
+	if (em485) {
+		if ((em485->active_timer == &em485->start_tx_timer) ||
+		    !start_tx_rs485(port))
+			return;
+	}
+	__start_tx(port);
 }
 
 static void serial8250_throttle(struct uart_port *port)
-- 
2.30.2


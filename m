Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13C6525DA5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 10:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344943AbiEMIaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 04:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378232AbiEMI3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 04:29:35 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5AA22A8044;
        Fri, 13 May 2022 01:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652430574; x=1683966574;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i/rvxH9ZLre6XraRA3WS4Jp+6HQyWQYFAXCHTJjqLGM=;
  b=D4BuKgp3QcHm0Uvka3ij96g5k2ZB7imi1YRy52sH+dDVkoFzg3OGCrqG
   gllpD7CuDpgFT84vP2YtWlUmCB8771UT5VwjWYo9R2wMZHmaxOKmjrfNe
   QzOK4N876GLxN3316cqpVLK/lD0sJUTsd9Tu8XG43tugRWhSoxGBGZXx2
   va2e8KhGfv2ovzVs37h34CrKvDDspL8OzKMHSDmc6sUhML7wvwwSqrur5
   UBXvY1Pa+C0a7rho+X6lNpbXiah4ukxs4eoKy2SzQwxBfFQDmakyMZ433
   yj9iUtwtxEVkOUlEIZQxR6VEncanTQUq84atvTduu7n/dUgOAGzlYiLrF
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="270385198"
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="270385198"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 01:29:34 -0700
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="567107500"
Received: from huberth-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.34.58])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 01:29:32 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 4/5] serial: fsl_lpuart: Remove unnecessary clearing for CRTSCTS
Date:   Fri, 13 May 2022 11:29:05 +0300
Message-Id: <20220513082906.11096-5-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220513082906.11096-1-ilpo.jarvinen@linux.intel.com>
References: <20220513082906.11096-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

if (termios->c_cflag & CRTSCTS) guarantees that CRTSCTS is not ever set
in the else block so clearing it is unnecessary.

While at it, remove also one pair of extra parenthesis.

Reviewed-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/fsl_lpuart.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 75b3c36c13bc..d3bb46cb7185 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -2110,12 +2110,10 @@ lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
 	if (sport->port.rs485.flags & SER_RS485_ENABLED)
 		termios->c_cflag &= ~CRTSCTS;
 
-	if (termios->c_cflag & CRTSCTS) {
-		modem |= (UARTMODIR_RXRTSE | UARTMODIR_TXCTSE);
-	} else {
-		termios->c_cflag &= ~CRTSCTS;
+	if (termios->c_cflag & CRTSCTS)
+		modem |= UARTMODIR_RXRTSE | UARTMODIR_TXCTSE;
+	else
 		modem &= ~(UARTMODIR_RXRTSE | UARTMODIR_TXCTSE);
-	}
 
 	if (termios->c_cflag & CSTOPB)
 		bd |= UARTBAUD_SBNS;
-- 
2.30.2


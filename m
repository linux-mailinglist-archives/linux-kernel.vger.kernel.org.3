Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3E88523077
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 12:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241357AbiEKKMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 06:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241058AbiEKKM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 06:12:29 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DC321A94C;
        Wed, 11 May 2022 03:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652263928; x=1683799928;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EiPw22QBwiYjNZhy2MWCDoPUZBiGSzJ5rdmbTiN1S3Y=;
  b=cBJYkzUlChLNcWP0qkzZ/s+Ep5pRhC8ofmZxv0bPyiU4uDlw9/g8UuXB
   rh3xEWkVoV7CU8A1CBfNR0GzOSngtbF5T9wVuJ+3O2XGmZ8UwlsyT6Xkl
   vIPUTUFNcI9S3nZpuZgIU7EBJXjLIIM0+8bDR5SNeTWTtt01tkYp1gJwX
   TycnB+jdSTlpHsZz2F/PE9JLiQarwpT6u1tBb9BhJBwGbUVkERu3js9kt
   IKgr8O0zLfHBmMS8xL/eNL9nFtOerccsqlaXT4OE//4Kv4yURWGsQLsYL
   f+TfieCZ1ZCTw/uiROBoRvIYpgSE5y/Fv6G5RIzzsRXYFfZ7FZxL7RPFR
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="250184346"
X-IronPort-AV: E=Sophos;i="5.91,216,1647327600"; 
   d="scan'208";a="250184346"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 03:12:08 -0700
X-IronPort-AV: E=Sophos;i="5.91,216,1647327600"; 
   d="scan'208";a="594049651"
Received: from meliyahx-mobl2.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.32.210])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 03:12:06 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 4/5] serial: fsl_lpuart: Remove unnecessary clearing for CRTSCTS
Date:   Wed, 11 May 2022 13:11:38 +0300
Message-Id: <20220511101139.5306-5-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220511101139.5306-1-ilpo.jarvinen@linux.intel.com>
References: <20220511101139.5306-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

if (termios->c_cflag & CRTSCTS) guarantees that CRTSCTS is not ever set
in the else block so clearing it is unnecessary.

While at it, remove also one pair of extra parenthesis.

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


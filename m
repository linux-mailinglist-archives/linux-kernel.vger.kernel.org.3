Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 108E152A001
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 13:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344911AbiEQLIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 07:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344899AbiEQLH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 07:07:59 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6E419020;
        Tue, 17 May 2022 04:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652785677; x=1684321677;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OPXJ4evp1SveqnRrI1ZxE35Iny9xfr/vhM5iE/upNFU=;
  b=WX0H/gnkazyTGL/0gOV4I5YSFaOZAAsoSeEEv5PoLpx5p428FWvZ0rZ4
   CDKiLeTMqCJgbUYl/FL64TQxSqoYMQU0UyRRSbkZwArIKICNTVQq+dA2N
   4V8HQeWl6KICtsrCOc6UX2RVr/XIcfkg51r0SP0MwcpZ9xp643aCm4CtE
   vVSVMftrv4PfOOzjOAs05QPM4vKeMzrYKqvFK/q3bTS3dOaWfBTU43WGs
   YfR3KUUJc1hFjewPT+o6KuoUUC0gP19be954vIBzC9/eHgP4AOV0LKp3u
   VY4kl7JSxWZF6SfqILlHf0QV5Xia6jckfVujC/783/uU6aLTZPulR/Aql
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="271268665"
X-IronPort-AV: E=Sophos;i="5.91,232,1647327600"; 
   d="scan'208";a="271268665"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 04:07:57 -0700
X-IronPort-AV: E=Sophos;i="5.91,232,1647327600"; 
   d="scan'208";a="568830894"
Received: from mtarral-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.52.88])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 04:07:54 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Peter Korsgaard <jacmet@sunsite.dk>,
        Sean Anderson <sean.anderson@seco.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/9] serial: uartline: Fix BRKINT clearing
Date:   Tue, 17 May 2022 14:07:29 +0300
Message-Id: <20220517110737.37148-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220517110737.37148-1-ilpo.jarvinen@linux.intel.com>
References: <20220517110737.37148-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BRKINT is within c_iflag rather than c_cflag.

Cc: Sean Anderson <sean.anderson@seco.com>
Fixes: ea017f5853e9 (tty: serial: uartlite: Prevent changing fixed parameters)
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/uartlite.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index 007db67292a2..880e2afbb97b 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -321,7 +321,8 @@ static void ulite_set_termios(struct uart_port *port, struct ktermios *termios,
 	struct uartlite_data *pdata = port->private_data;
 
 	/* Set termios to what the hardware supports */
-	termios->c_cflag &= ~(BRKINT | CSTOPB | PARENB | PARODD | CSIZE);
+	termios->c_iflag &= ~BRKINT;
+	termios->c_cflag &= ~(CSTOPB | PARENB | PARODD | CSIZE);
 	termios->c_cflag |= pdata->cflags & (PARENB | PARODD | CSIZE);
 	tty_termios_encode_baud_rate(termios, pdata->baud, pdata->baud);
 
-- 
2.30.2


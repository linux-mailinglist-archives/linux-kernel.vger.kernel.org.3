Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C07752CE2F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 10:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbiESITC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 04:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235382AbiESISZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 04:18:25 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C743E62CFB;
        Thu, 19 May 2022 01:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652948302; x=1684484302;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yXH0niLYHG57xT7R+b79ONJ4T4gTxInwV+ZgiQ48WMU=;
  b=Nmuffa12EZfqYEC4MKBHWdL1Id4pN/yg8o7TKzS79VZHO4Huztk3KQ6s
   sAqjOENj5FHVy9EINluhl0j9HtSWYISR4rjzho4qbooRyV6ccLg1zYtoG
   LgWPLCrffbKSOguK9Qy8RYOEUCB2DdNCJJrCvdBjlBEGbFnhFhNtbw5nP
   FsU3WHiJ0sC7sc+4DI+QvgMx+SMxN2iaxN7T5SGuMnamB2Zl7dd9JDUJx
   IKBbdEId9N3tKaNt2drU7mXene8zzCasUbfSqWG2YAQGfvTym3Rm/uozU
   F8/9ZZBWPi++tlyic2FJgXdE69eruBHDB5gg4itzIFGjcbBeB+Y7MqEZG
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="272218858"
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="272218858"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 01:18:22 -0700
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="598431166"
Received: from ivanovbx-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.33.234])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 01:18:20 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>,
        Peter Korsgaard <jacmet@sunsite.dk>,
        Sean Anderson <sean.anderson@seco.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 1/9] serial: uartlite: Fix BRKINT clearing
Date:   Thu, 19 May 2022 11:18:00 +0300
Message-Id: <20220519081808.3776-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220519081808.3776-1-ilpo.jarvinen@linux.intel.com>
References: <20220519081808.3776-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BRKINT is within c_iflag rather than c_cflag.

Fixes: ea017f5853e9 (tty: serial: uartlite: Prevent changing fixed parameters)
Reviewed-by: Sean Anderson <sean.anderson@seco.com>
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


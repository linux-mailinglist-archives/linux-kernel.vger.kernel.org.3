Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFDF053F860
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 10:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238340AbiFGImJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 04:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238324AbiFGImH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 04:42:07 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ECA1D2473;
        Tue,  7 Jun 2022 01:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654591327; x=1686127327;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=y2ISjMALAGhLIAxQw31aGSmQB7i2n1sVXOd+oGrYVHk=;
  b=UcI/vhrCVp6lMDfs4OUJ3MDJSrGACT1UfLs4A+jCQ31f9zjYSLdI6c3e
   KXzDQcimuval2M3bqyb9qzdwAdSORA++BNmfZuI6OctlPuGwgRgRKEsWO
   gqHyrBiVJ6xs7WOIfFXUhCP3kyuTJ2KdWKroEmqciHcRtRCnINgIewsTp
   fVYRwva2UgOW3iaSDRIKqod0GHMY2cMWPbIs4OxyIgzm7jXHoq5OyKCVr
   1Rov8ECSJSegIFw/4C+pkXvuknBRf4L/5BhDpBaSGaTiwnUZcN7ts7rlC
   7g/EVJm/iIXA7gAEownSSxuq/v2mHsgfGLqNPty9j95qa1VOmeyz0PLYr
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="277398604"
X-IronPort-AV: E=Sophos;i="5.91,283,1647327600"; 
   d="scan'208";a="277398604"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 01:42:04 -0700
X-IronPort-AV: E=Sophos;i="5.91,283,1647327600"; 
   d="scan'208";a="647933825"
Received: from akmessan-mobl1.amr.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.214.146])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 01:42:02 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/2] serial: 8250: kill __do_stop_tx()
Date:   Tue,  7 Jun 2022 11:41:53 +0300
Message-Id: <20220607084154.8172-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
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

There seems to be little reason for __do_stop_tx() to exits on its own.
It is rather simple and is only called from __stop_tx(). Thus, move its
logic into __stop_tx().

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250_port.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 78b6dedc43e6..448cfbb05f63 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1503,12 +1503,6 @@ static void __stop_tx_rs485(struct uart_8250_port *p, u64 stop_delay)
 	}
 }
 
-static inline void __do_stop_tx(struct uart_8250_port *p)
-{
-	if (serial8250_clear_THRI(p))
-		serial8250_rpm_put_tx(p);
-}
-
 static inline void __stop_tx(struct uart_8250_port *p)
 {
 	struct uart_8250_em485 *em485 = p->em485;
@@ -1542,7 +1536,9 @@ static inline void __stop_tx(struct uart_8250_port *p)
 
 		__stop_tx_rs485(p, stop_delay);
 	}
-	__do_stop_tx(p);
+
+	if (serial8250_clear_THRI(p))
+		serial8250_rpm_put_tx(p);
 }
 
 static void serial8250_stop_tx(struct uart_port *port)
-- 
2.30.2


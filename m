Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC335A5E94
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 10:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbiH3IuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 04:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231718AbiH3IuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 04:50:08 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FEFC1116D;
        Tue, 30 Aug 2022 01:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661849396; x=1693385396;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7tobZ5SnMmu7atea54D1+8bNrJpPf5EPxFoyVmNne08=;
  b=bIbYO8E7Q5WAjtSg5TmOOhnWMvoUVKv87Tl43+sw0m+Dt1nzpJO4H3cN
   82deaUbfPrfWrRA/39jxbx02No4f1P1wQ0vv7FFX7ziJHAdBwdafis4M4
   t9DpCQcdUDhM7bGtKka4G7A/H0N3DkjyeIWXvmNR/LPy+QP5rZKdxyT0y
   gkS1XCdFYoEDkmokHjQECvP/s3LZOL/WtCvrWu4gi6o4u/MVN05isjg6y
   8o3keThBGnmjjl48IR/OpJI/EA7NfGcnEWjR9xVfcpsIoDYqlDwBJasU0
   /FzWu/soRr9JYWvWKmp3FtsEgB63Jl11cBv+Yrx+TIiNRY6Yo1/VczxhZ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="293866325"
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="293866325"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 01:49:55 -0700
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="672761871"
Received: from arnesgom-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.54.235])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 01:49:53 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v2 3/5] serial: fsl_lpuart: Remove custom frame size calculation
Date:   Tue, 30 Aug 2022 11:49:23 +0300
Message-Id: <20220830084925.5608-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220830084925.5608-1-ilpo.jarvinen@linux.intel.com>
References: <20220830084925.5608-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The number of bits can be calculated using tty_get_frame_size(), no
need for the driver to do it on its own. Change bits to unsigned and
baud too since we're touching the declarations line anyway (the
respective core functions are typed unsigned).

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/fsl_lpuart.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index f6c33cd228c8..7fef653e7265 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1284,17 +1284,12 @@ static inline int lpuart_start_rx_dma(struct lpuart_port *sport)
 	struct dma_slave_config dma_rx_sconfig = {};
 	struct circ_buf *ring = &sport->rx_ring;
 	int ret, nent;
-	int bits, baud;
 	struct tty_port *port = &sport->port.state->port;
 	struct tty_struct *tty = port->tty;
 	struct ktermios *termios = &tty->termios;
 	struct dma_chan *chan = sport->dma_rx_chan;
-
-	baud = tty_get_baud_rate(tty);
-
-	bits = (termios->c_cflag & CSIZE) == CS7 ? 9 : 10;
-	if (termios->c_cflag & PARENB)
-		bits++;
+	unsigned int bits = tty_get_frame_size(termios->c_cflag);
+	unsigned int baud = tty_get_baud_rate(tty);
 
 	/*
 	 * Calculate length of one DMA buffer size to keep latency below
-- 
2.30.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42D2453E6F7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238523AbiFFNMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 09:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238495AbiFFNLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 09:11:47 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6DB7C0E31;
        Mon,  6 Jun 2022 06:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654521106; x=1686057106;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MTzb+iKj/sM7duxsLn/L4rAkVV4+m6q81A4vy02OOQ8=;
  b=lbFM+qFp29+ugC8FVAHHNrILJW31CFtuOgcBPmuKqMCvmcSQp5Teslvl
   eCxxroJgLA9H/jng588J14BWhGDD+r7MS2EgJho9e8iO/PBb5QR8QYKQJ
   K+SIIacIFCR7CKIWOKS8WXTXloqmRkTS9qnwRzOsMGaUzBCm5WYhfqmbO
   RS8MWPhR5tI/jr6Lk6gQDatbs5VKY5ntyOxBMcWxTrU90WkHNXupKd0Il
   HjNXbtg/zkmpsUln44xFFylxZeTFB77h+fTUTPnCrfZOXKf1qO5e/KwzL
   z89hLUPgLf4Q6KZZl/tw8f+Sg2x8PS8ztCUpEYySX9hzEP9mZLqa0WPUw
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10369"; a="274191255"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="274191255"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 06:11:46 -0700
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="583630925"
Received: from amkossek-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.57.11])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 06:11:43 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@penugtronix.de>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 3/6] serial: 8250: Get preserved flags using serial_lsr_in()
Date:   Mon,  6 Jun 2022 16:11:21 +0300
Message-Id: <20220606131124.53394-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220606131124.53394-1-ilpo.jarvinen@linux.intel.com>
References: <20220606131124.53394-1-ilpo.jarvinen@linux.intel.com>
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

serial8250_handle_irq() assumes it's the first to read LSR register.
However, there are 8250 drivers which perform LSR read in their own irq
handler prior to calling serial8250_handle_irq(). As not all flags are
preserved across LSR reads, use serial_lsr_in() helper to get all the
preserved flags.

This commit might fix other commits too besides the ones for DW UART
mentioned below. It's just not clear to me which of the other devices
clear some of the LSR flags on read. AFAIK, nobody has complained about
this problem (either against DW or other devices) so it might not have
that bad impact in the end.

Fixes: 424d79183af0 ("serial: 8250_dw: Avoid "too much work" from bogus rx timeout interrupt")
Fixes: aa63d786cea2 ("serial: 8250: dw: Add support for DMA flow controlling devices")
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250_port.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index ec5abeb638eb..a0ea048eb2ad 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1916,7 +1916,7 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
 
 	spin_lock_irqsave(&port->lock, flags);
 
-	status = serial_port_in(port, UART_LSR);
+	status = serial_lsr_in(up);
 
 	/*
 	 * If port is stopped and there are no error conditions in the
-- 
2.30.2


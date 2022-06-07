Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E40C53F837
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 10:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238261AbiFGIae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 04:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238231AbiFGIaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 04:30:03 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D974D0292;
        Tue,  7 Jun 2022 01:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654590598; x=1686126598;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MTzb+iKj/sM7duxsLn/L4rAkVV4+m6q81A4vy02OOQ8=;
  b=IABUjfe8anyod6AsEE1mMb9GpVgCewIj0p9Zp1VC2UEOMAJQbZM3PXJo
   KFv+UnVUZFefdahcoXL4rci0onK7CXL3sIl5d5ZL7/haXFOuRPtilEmeS
   ZaU8oJ10UF4tQhDcr4Io2WWDQpIKf5ETsbg/Mv4LTT37RgIPsANxzMSki
   LL8azUeXyLeIae/iXq5w2yIp0k84MKWyZ6+i06tQuQvGLQwVEGq+K7UyX
   6F9Jwh5fcgwqp6StVHeI5y/w8Ktev0MbUZHHTzVioLhIxC+ydpPv+1ING
   eVWOeT2GTkrfDGStEP+KtMYralN4DtMf/P6/T+bmFKr5VwPxd2LQ2lcph
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="277393659"
X-IronPort-AV: E=Sophos;i="5.91,283,1647327600"; 
   d="scan'208";a="277393659"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 01:29:56 -0700
X-IronPort-AV: E=Sophos;i="5.91,283,1647327600"; 
   d="scan'208";a="584103487"
Received: from akmessan-mobl1.amr.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.214.146])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 01:29:53 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Douglas Anderson <dianders@chromium.org>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 3/6] serial: 8250: Get preserved flags using serial_lsr_in()
Date:   Tue,  7 Jun 2022 11:29:31 +0300
Message-Id: <20220607082934.7242-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220607082934.7242-1-ilpo.jarvinen@linux.intel.com>
References: <20220607082934.7242-1-ilpo.jarvinen@linux.intel.com>
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC61754C452
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 11:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346895AbiFOJIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 05:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244794AbiFOJHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 05:07:49 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7FAD74;
        Wed, 15 Jun 2022 02:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655284048; x=1686820048;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=tzOwzKU2PlO38M7mQ6u8ns1x2zwrHZwHhpoGZ0wAtXA=;
  b=juTQtbuDBce6o8s2gH1DfQL2QQ9a+RCKZZFTEzTempFAOZ48t0T4WOJy
   ZzFFtx9i1zEOONTqWbAcXMLExba4zS2kj6MZyJVvVHzfmfDVwBk5yxEpx
   k8cdgygRvOXYJZxVqweDvnrSQfVHpurVFGrh6KfxTsUZLtqqqWOWyqydg
   Z6CxtwBjykvYWhpL2+9WmT2Y+tXLdic7UoaFfUqSPscBI0J2Az1ex1IOx
   Jb4LUZJpc1RdpB+vtc/7xNMiHjpFbeN89wDuFP3iCsYPYr7rQRPBoUGnM
   nXzxiElM/Fn/Zr1p9N/ZFax1pbe6f8IT4d84njy1puaroYYJrhKCK+Z0E
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="276464703"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="276464703"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 02:07:28 -0700
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="830934158"
Received: from mgrymel-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.41.34])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 02:07:26 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] serial: 8250_dw: Take port lock while accessing LSR
Date:   Wed, 15 Jun 2022 12:06:50 +0300
Message-Id: <20220615090651.15340-3-ilpo.jarvinen@linux.intel.com>
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

Accessing LSR requires port lock because it mutates lsr_saved_flags
in serial_lsr_in().

Fixes: 197eb5c416ff ("serial: 8250_dw: Use serial_lsr_in() in dw8250_handle_irq()")
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dw.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 4cc69bb612ab..f67fad3233e9 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -266,7 +266,10 @@ static int dw8250_handle_irq(struct uart_port *p)
 
 	/* Manually stop the Rx DMA transfer when acting as flow controller */
 	if (quirks & DW_UART_QUIRK_IS_DMA_FC && up->dma && up->dma->rx_running && rx_timeout) {
+		spin_lock_irqsave(&p->lock, flags);
 		status = serial_lsr_in(up);
+		spin_unlock_irqrestore(&p->lock, flags);
+
 		if (status & (UART_LSR_DR | UART_LSR_BI)) {
 			dw8250_writel_ext(p, RZN1_UART_RDMACR, 0);
 			dw8250_writel_ext(p, DW_UART_DMASA, 1);
-- 
2.30.2


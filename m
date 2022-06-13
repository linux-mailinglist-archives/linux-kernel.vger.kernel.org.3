Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9710A54813E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 10:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237424AbiFMH5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 03:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbiFMH5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 03:57:46 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884E51143;
        Mon, 13 Jun 2022 00:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655107065; x=1686643065;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=c6mNhGidI+ySUPBHiYszEppKlWzF5e7hTBCpcXyDgw4=;
  b=aNiHxCX0Vql1nNKpit7q6fH579NiNZg2sYzC8CU7zR+HYiVh2ats0Rjs
   k1Aw7eCkMpIL1GHN3lbjcjKER9sGf5tuCFr9EsNy7FWS7FFR97WQQjbqX
   JuGQYLEIcg9/V69R17WK0IisM2kK+L3tQY2YHuSPSx9u8kbDOgnN6gcDm
   5h+ejHfat0lVIbnFitVOjegzgZOVnprauXIYBUUfqI05FAzqON2msS+re
   wqP/pzQZkzpLmbMXSyWx6KOdteLjQzrQOq4rVybVhP+DzO4r7os+ZgHs5
   k4FmvX1ILhZqm2qSdqoHB/dG53+T/dZNZxtPMyKsshNJXwtqXUzzNO9Or
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10376"; a="279252567"
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="279252567"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 00:57:45 -0700
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="587667382"
Received: from fnechitx-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.40.115])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 00:57:43 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/2] serial: 8250: Use UART_LCR_WLEN8 instead of literal
Date:   Mon, 13 Jun 2022 10:57:35 +0300
Message-Id: <20220613075736.12283-1-ilpo.jarvinen@linux.intel.com>
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

Use UART_LCR_WLEN8 instead of literal 0x03 in size_fifo().

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250_port.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 953b0fadfd4c..8365c7ad3576 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -843,7 +843,7 @@ static int size_fifo(struct uart_8250_port *up)
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_A);
 	old_dl = serial_dl_read(up);
 	serial_dl_write(up, 0x0001);
-	serial_out(up, UART_LCR, 0x03);
+	serial_out(up, UART_LCR, UART_LCR_WLEN8);
 	for (count = 0; count < 256; count++)
 		serial_out(up, UART_TX, count);
 	mdelay(20);/* FIXME - schedule_timeout */
-- 
2.30.2


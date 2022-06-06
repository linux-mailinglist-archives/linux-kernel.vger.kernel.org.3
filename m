Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51C1853EC73
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233711AbiFFKJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 06:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233435AbiFFKGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 06:06:18 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0144B13C4F3;
        Mon,  6 Jun 2022 03:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654509976; x=1686045976;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fM4JuWr/FScBki1o0CtzEbeVzUK3YqLgHDTrpxUHcIk=;
  b=TwskeiJ8ECJdSDGTI2U67xfScwdKz8UuSUwyneSusD7uimr2iiZF7B02
   6ynv6ooX8aEt/0xipn2lpDtqif02ZL/rpjgI+ehFfEpM9k5mqMUOY075Q
   cNSZmh6huJgCELDDnuyzLUpJO2Sjk4ko5/lVsUhe3VgLcRN5XUHBQe7AE
   680wzAMA1s/dckA+Cu3L9jwzAQnRaDJgmXtwR1ovJY9UGiKb610Ou5b5J
   OPdFOjHJAg1DWFKU2en7NgLp1JmvSXKyH8driEM8L8pnP+mKUbSMM3plD
   /QCj5+EpMWEE2Usp2U22C0NIjThBB+/sHQehgHnO2NvKPrRDf3HSG9ht7
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10369"; a="362987084"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="362987084"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 03:06:16 -0700
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="635523865"
Received: from amkossek-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.57.11])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 03:06:14 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 29/36] serial: pl011: Remove serial_rs485 sanitization
Date:   Mon,  6 Jun 2022 13:04:26 +0300
Message-Id: <20220606100433.13793-30-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220606100433.13793-1-ilpo.jarvinen@linux.intel.com>
References: <20220606100433.13793-1-ilpo.jarvinen@linux.intel.com>
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

Serial core handles serial_rs485 sanitization.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/amba-pl011.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index cdc466e89aa8..eccd66625d25 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2681,17 +2681,12 @@ static int pl011_find_free_port(void)
 static int pl011_get_rs485_mode(struct uart_amba_port *uap)
 {
 	struct uart_port *port = &uap->port;
-	struct serial_rs485 *rs485 = &port->rs485;
 	int ret;
 
 	ret = uart_get_rs485_mode(port);
 	if (ret)
 		return ret;
 
-	/* clamp the delays to [0, 100ms] */
-	rs485->delay_rts_before_send = min(rs485->delay_rts_before_send, 100U);
-	rs485->delay_rts_after_send = min(rs485->delay_rts_after_send, 100U);
-
 	return 0;
 }
 
-- 
2.30.2


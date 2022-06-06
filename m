Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B7953E960
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233766AbiFFKHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 06:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233349AbiFFKFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 06:05:41 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D144F10A62B;
        Mon,  6 Jun 2022 03:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654509937; x=1686045937;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wwmLHiqZboEiZnfiV6e1hu8KZfAipQe3aQ1BtK145s8=;
  b=Dtd4fF2XKtLCivDKQAnG7tfL1+a+pRMAlyjmq21sLcRPF6Ew8a4TdQUx
   ZMM5Du9uqnWovlrfnQICXE/o5JT4an8xaPBoe2c2+Yfup9/911Dy7TO54
   Tqrs7EStMJFHPpFS0qZAFlIP8e9BTzWBx3WojfvtKliTJV44M6QUFsNra
   qW+yZbdgGMlVi68YM1jDJ9pHq4Ee/S2wKDNPfTqxELlGWGKHcWPyin48M
   qNODD4wvyFF7lcWwERGbHhKJkcQ++1qHY1hhQM48BYsZhfPbjQpvs3AJr
   KuGio716yOljfHoHwFpVcwC1tOOJJkA7bejkI6Ct/w/FnN+Wq6+FTlMcj
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10369"; a="362987057"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="362987057"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 03:05:37 -0700
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="635523724"
Received: from amkossek-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.57.11])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 03:05:35 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 15/36] serial: fsl_lpuart: Fill in rs485_supported
Date:   Mon,  6 Jun 2022 13:04:12 +0300
Message-Id: <20220606100433.13793-16-ilpo.jarvinen@linux.intel.com>
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

Add information on supported serial_rs485 features.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/fsl_lpuart.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 509a7912fa9d..88692dc9eefa 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -2621,6 +2621,11 @@ static struct uart_driver lpuart_reg = {
 	.cons		= LPUART_CONSOLE,
 };
 
+static const struct serial_rs485 lpuart_rs485_supported = {
+	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND | SER_RS485_RTS_AFTER_SEND,
+	/* delay_rts_* and RX_DURING_TX are not supported */
+};
+
 static int lpuart_probe(struct platform_device *pdev)
 {
 	const struct lpuart_soc_data *sdata = of_device_get_match_data(&pdev->dev);
@@ -2660,6 +2665,7 @@ static int lpuart_probe(struct platform_device *pdev)
 		sport->port.rs485_config = lpuart32_config_rs485;
 	else
 		sport->port.rs485_config = lpuart_config_rs485;
+	sport->port.rs485_supported = &lpuart_rs485_supported;
 
 	sport->ipg_clk = devm_clk_get(&pdev->dev, "ipg");
 	if (IS_ERR(sport->ipg_clk)) {
-- 
2.30.2


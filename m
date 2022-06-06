Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E760D53E7FF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233734AbiFFKJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 06:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233538AbiFFKGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 06:06:31 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF26F14084B;
        Mon,  6 Jun 2022 03:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654509986; x=1686045986;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7XJq3KuEwylRleSQc/kmsQM+84+gFlD9hNoKE43ukeE=;
  b=TCDO5eVXQ+w4bw109315m9zeLTX1V5oYlmIdqAQ1zpFvvbczPfXg64Qt
   no6tqj/1Ewwyppx8D5eZBlN7LyGvIZvKGB9pYBzjvw8PplZOP18u7Tk2Q
   NQvj28UhVJTsiklOu2i+lKa6X8elgxIqSBptkl3vgAt2JSNK70DD5ZlXl
   GBE/tjFsqLtd5P1NUTSAetgKi4nwAWxUbTKkf9X7WxOxMclDV9oJrz13o
   fqOXN9rwNsGcC4eugDx/IjWQh0TJK6eESbao7mmaDDeINXAYsk0id+hqS
   OjA7FZ1YiK6iyxNCP4YJF25HVUa/qOTQvBWC1942kgANqapc1RuD294XO
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10369"; a="362987087"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="362987087"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 03:06:23 -0700
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="635523878"
Received: from amkossek-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.57.11])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 03:06:20 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 31/36] serial: imx: Remove serial_rs485 sanitization
Date:   Mon,  6 Jun 2022 13:04:28 +0300
Message-Id: <20220606100433.13793-32-ilpo.jarvinen@linux.intel.com>
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

The driver provides different rs485_supported for the case where RTS is
not available making it unnecessary to handle it in
imx_uart_rs485_config.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/imx.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index ba853bc9b4db..1e96ddd2e262 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1913,10 +1913,6 @@ static int imx_uart_rs485_config(struct uart_port *port,
 	struct imx_port *sport = (struct imx_port *)port;
 	u32 ucr2;
 
-	/* RTS is required to control the transmitter */
-	if (!sport->have_rtscts && !sport->have_rtsgpio)
-		rs485conf->flags &= ~SER_RS485_ENABLED;
-
 	if (rs485conf->flags & SER_RS485_ENABLED) {
 		/* Enable receiver if low-active RTS signal is requested */
 		if (sport->have_rtscts &&  !sport->have_rtsgpio &&
-- 
2.30.2


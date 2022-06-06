Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7839453E615
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233630AbiFFKHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 06:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233391AbiFFKFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 06:05:42 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 863D46D19A;
        Mon,  6 Jun 2022 03:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654509941; x=1686045941;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xfl+6OEZtY6tN3qb8+voitCmW0WYuA4tz0RJFqBgckQ=;
  b=l+bCZgfmEKe9XkWVHvf8jfbX9BkFrjLT/x2HvzrWI0IVskCB0/xR0fv4
   O0pV6rqr4UrHIaUDhTRWyGLZ7Ql4Vs5KxxJymYbPu+lk/EUwl497jlIzH
   hqqdxm9nFGbMs07IjrelkMg4IsPMZT1bN6uTZk/VJIBv1ym2KafvgFmtX
   ed5+44WJ7JnGA5NrtWqwUSrTtDGpKviBTWsFlKaZh/NFqoWpulhej4SS1
   zzqr44FCYzGyKHdOJ4yXVDPGRWK2nw5pWa+7pfDwthIuCdpzd2cSpyi03
   1m3odjsRX4v5cOunItmwpbxi/m+ObL+Ig8ml7aDsnNGGCG+bBmVm86AU0
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10369"; a="362987059"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="362987059"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 03:05:41 -0700
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="635523733"
Received: from amkossek-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.57.11])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 03:05:38 -0700
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
Subject: [PATCH 16/36] serial: imx: Fill in rs485_supported
Date:   Mon,  6 Jun 2022 13:04:13 +0300
Message-Id: <20220606100433.13793-17-ilpo.jarvinen@linux.intel.com>
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

In the case where RTS is lacking, RS485 cannot be enabled so provide
zero rs485_supported for that case. Perhaps it would make sense to not
provide rs485_config() at all in that case but such a change would have
userspace visible impact/change in behavior so this patch does not
attempt it.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/imx.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 9ce09b81ac9b..ba853bc9b4db 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2200,6 +2200,14 @@ static enum hrtimer_restart imx_trigger_stop_tx(struct hrtimer *t)
 	return HRTIMER_NORESTART;
 }
 
+static const struct serial_rs485 imx_no_rs485 = {};	/* No RS485 if no RTS */
+static const struct serial_rs485 imx_rs485_supported = {
+	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND | SER_RS485_RTS_AFTER_SEND |
+		 SER_RS485_RX_DURING_TX,
+	.delay_rts_before_send = 1,
+	.delay_rts_after_send = 1,
+};
+
 /* Default RX DMA buffer configuration */
 #define RX_DMA_PERIODS		16
 #define RX_DMA_PERIOD_LEN	(PAGE_SIZE / 4)
@@ -2279,6 +2287,11 @@ static int imx_uart_probe(struct platform_device *pdev)
 	sport->port.has_sysrq = IS_ENABLED(CONFIG_SERIAL_IMX_CONSOLE);
 	sport->port.ops = &imx_uart_pops;
 	sport->port.rs485_config = imx_uart_rs485_config;
+	/* RTS is required to control the RS485 transmitter */
+	if (sport->have_rtscts || sport->have_rtsgpio)
+		sport->port.rs485_supported = &imx_rs485_supported;
+	else
+		sport->port.rs485_supported = &imx_no_rs485;
 	sport->port.flags = UPF_BOOT_AUTOCONF;
 	timer_setup(&sport->timer, imx_uart_timeout, 0);
 
-- 
2.30.2


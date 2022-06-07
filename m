Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65BD541D71
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 00:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384117AbiFGWOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 18:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380094AbiFGVL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 17:11:29 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC2A217639;
        Tue,  7 Jun 2022 11:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654627989; x=1686163989;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=DJX1fTXVl6qyeFmIlJ6koAYNPAMtDi8XGkKfp/5Rjkk=;
  b=OCHIyRs9DtIpE3t6KEdc/Sn6Pj4wgi7d8G0+H6n7SRoJZGft383hbNly
   IbUtL7MU99R8ipjARhLUzWttPDQHhgcp2Ajzkf6j1+HfY/AMdSn86wL19
   ubHqOKvF8IMThdDk4PuNAy4tAC3iFaRF54DBB7df+BDWHJKxCmon5U4LS
   g=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 07 Jun 2022 11:53:07 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 07 Jun 2022 11:53:06 -0700
X-QCInternal: smtphost
Received: from hu-vnivarth-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.111.166])
  by ironmsg01-blr.qualcomm.com with ESMTP; 08 Jun 2022 00:22:52 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3994820)
        id 898523F76; Wed,  8 Jun 2022 00:22:51 +0530 (+0530)
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     quic_msavaliy@quicinc.com, dianders@chromium.org, mka@chromium.org,
        swboyd@chromium.org,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Subject: [PATCH 1/2] serial: core: Introduce callback for start_rx and do stop_rx in suspend only if this callback implementation is present.
Date:   Wed,  8 Jun 2022 00:22:44 +0530
Message-Id: <1654627965-1461-2-git-send-email-quic_vnivarth@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1654627965-1461-1-git-send-email-quic_vnivarth@quicinc.com>
References: <1654627965-1461-1-git-send-email-quic_vnivarth@quicinc.com>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In suspend sequence there is a need to perform stop_rx during suspend
sequence to prevent any asynchronous data over rx line. However this
can cause problem to drivers which dont do re-start_rx during set_termios.

Add new callback start_rx and perform stop_rx only when implementation of
start_rx is present. Also add call to start_rx in resume sequence so that
drivers who come across this problem can make use of this framework.

Fixes: c9d2325cdb92 ("serial: core: Do stop_rx in suspend path for console if console_suspend is disabled")
Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
---
 drivers/tty/serial/serial_core.c | 9 ++++++---
 include/linux/serial_core.h      | 1 +
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 9a85b41..338ebad 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2214,11 +2214,12 @@ int uart_suspend_port(struct uart_driver *drv, struct uart_port *uport)
 	/*
 	 * Nothing to do if the console is not suspending
 	 * except stop_rx to prevent any asynchronous data
-	 * over RX line. Re-start_rx, when required, is
-	 * done by set_termios in resume sequence
+	 * over RX line. However ensure that we will be
+	 * able to Re-start_rx later.
 	 */
 	if (!console_suspend_enabled && uart_console(uport)) {
-		uport->ops->stop_rx(uport);
+		if (uport->ops->start_rx)
+			uport->ops->stop_rx(uport);
 		goto unlock;
 	}
 
@@ -2310,6 +2311,8 @@ int uart_resume_port(struct uart_driver *drv, struct uart_port *uport)
 		if (console_suspend_enabled)
 			uart_change_pm(state, UART_PM_STATE_ON);
 		uport->ops->set_termios(uport, &termios, NULL);
+		if (!console_suspend_enabled && uport->ops->start_rx)
+			uport->ops->start_rx(uport);
 		if (console_suspend_enabled)
 			console_start(uport->cons);
 	}
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index cbd5070..657a0fc 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -45,6 +45,7 @@ struct uart_ops {
 	void		(*unthrottle)(struct uart_port *);
 	void		(*send_xchar)(struct uart_port *, char ch);
 	void		(*stop_rx)(struct uart_port *);
+	void		(*start_rx)(struct uart_port *);
 	void		(*enable_ms)(struct uart_port *);
 	void		(*break_ctl)(struct uart_port *, int ctl);
 	int		(*startup)(struct uart_port *);
-- 
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by the Linux Foundation.


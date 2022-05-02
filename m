Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 690D3516DB1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 11:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384342AbiEBJvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 05:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384415AbiEBJvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 05:51:00 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3B113E83;
        Mon,  2 May 2022 02:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651484851; x=1683020851;
  h=from:to:cc:subject:date:message-id;
  bh=lJvh+GysjJsgQmdPaDpyMJYF+wTQQxzW4XnXPVDg9Vw=;
  b=JgunQ+LjvysXcudWrN8L9OdTMlZwsS1lTDvOUBbNFzqej58ZLyndwRd0
   dOyz0pu6EkZFHxEaJkmLhZA3nUuiQUKicP2Tu4YYxpPVd1ipZvVSDkLbV
   6bofWbjG01dDAgMTuj2CLUoTphnO7Y/KX/e39AQcUSN8JxdjM+VssDTFz
   g=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 02 May 2022 02:47:30 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 02 May 2022 02:47:29 -0700
X-QCInternal: smtphost
Received: from hu-vnivarth-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.111.166])
  by ironmsg02-blr.qualcomm.com with ESMTP; 02 May 2022 15:17:18 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3994820)
        id F34363CB4; Mon,  2 May 2022 15:17:17 +0530 (+0530)
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     quic_msavaliy@quicinc.com, dianders@chromium.org,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Subject: [PATCH] serial: core: Do stop_rx in suspend path for console if console_suspend is disabled
Date:   Mon,  2 May 2022 15:17:15 +0530
Message-Id: <1651484835-25189-1-git-send-email-quic_vnivarth@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the case of console_suspend disabled, if back to back suspend/resume
test is executed, at the end of test, sometimes console would appear to
be frozen not responding to input. This would happen because, during
resume, rx transactions can come in before system is ready, malfunction
of rx happens in turn resulting in console appearing to be stuck.

Do a stop_rx in suspend sequence to prevent this.

Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
---
 drivers/tty/serial/serial_core.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 82a1770..e8c6875 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2211,9 +2211,16 @@ int uart_suspend_port(struct uart_driver *drv, struct uart_port *uport)
 	}
 	put_device(tty_dev);
 
-	/* Nothing to do if the console is not suspending */
-	if (!console_suspend_enabled && uart_console(uport))
+	/*
+	 * Nothing to do if the console is not suspending
+	 * except stop_rx to prevent any asynchronous data
+	 * over RX line. Re start_rx, when required, is
+	 * done by set_termios in resume sequence
+	 */
+	if (!console_suspend_enabled && uart_console(uport)) {
+		uport->ops->stop_rx(uport);
 		goto unlock;
+	}
 
 	uport->suspended = 1;
 
-- 
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by the Linux Foundation.


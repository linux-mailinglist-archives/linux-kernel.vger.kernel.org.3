Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF735280B7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 11:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241979AbiEPJUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 05:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234385AbiEPJUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 05:20:35 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF5526102;
        Mon, 16 May 2022 02:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652692829; x=1684228829;
  h=from:to:cc:subject:date:message-id;
  bh=f+gPMpnzEuE1lo/LHuKc1FpoHI7Zthw1RbS6wbpsxzw=;
  b=gRHMRINTY3zZdy0ADzNnvge4WuH8+VIi9pSuC46WtISUdK51uOG9QvY+
   yaSAMS9Cj8p/cB6id8pHmv7dhkIJYV8SCNFxLVtnugIWYZn3HfU5gAwtN
   sJV6ZvQPPyjrp6p9JObM8hlcC1mWV5zaKCeCXhICGyTJa7ASqTekKzitB
   c=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 16 May 2022 02:20:28 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA; 16 May 2022 02:20:27 -0700
X-QCInternal: smtphost
Received: from hu-vnivarth-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.111.166])
  by ironmsg02-blr.qualcomm.com with ESMTP; 16 May 2022 14:50:14 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3994820)
        id D4B3E3E54; Mon, 16 May 2022 14:50:13 +0530 (+0530)
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     quic_msavaliy@quicinc.com, dianders@chromium.org, mka@chromium.org,
        swboyd@chromium.org,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Subject: [V4] serial: core: Do stop_rx in suspend path for console if console_suspend is disabled
Date:   Mon, 16 May 2022 14:50:10 +0530
Message-Id: <1652692810-31148-1-git-send-email-quic_vnivarth@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
v4: moved the change to serial core to apply for all drivers
v3: swapped the order of conditions to be more human readable
v2: restricted patch to contain only stop_rx in suspend sequence
v1: intial patch contained 2 additional unrelated changes in vicinity
---
 drivers/tty/serial/serial_core.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 82a1770..9a85b41 100644
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
+	 * over RX line. Re-start_rx, when required, is
+	 * done by set_termios in resume sequence
+	 */
+	if (!console_suspend_enabled && uart_console(uport)) {
+		uport->ops->stop_rx(uport);
 		goto unlock;
+	}
 
 	uport->suspended = 1;
 
-- 
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by the Linux Foundation.


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E934E9ED7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 20:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245162AbiC1ST2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 14:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240970AbiC1ST1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 14:19:27 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1B345AD2;
        Mon, 28 Mar 2022 11:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648491466; x=1680027466;
  h=from:to:cc:subject:date:message-id;
  bh=Bb91pJm1kGSwurPQgwz7cFnRs4FbBTLF/d/dsS4oK5g=;
  b=xxdK53JTLcGSJVgsy+jzDWbvhtdfK51/gq1Ql40DqqAGj8rXbnNwDGl4
   WUeLzttKo5dJaVWzfGSijomh5DHC3wanRQ3wu88XwUtrOhFplr/E8PVnv
   M7SZDD2EFOhwnHpAl9hy3uG6qrtTFa/KBZbY6qmN0qSrOXWJKQPrtFGn5
   Q=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 28 Mar 2022 11:17:45 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 28 Mar 2022 11:17:44 -0700
X-QCInternal: smtphost
Received: from hu-vnivarth-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.111.166])
  by ironmsg01-blr.qualcomm.com with ESMTP; 28 Mar 2022 23:47:30 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3994820)
        id 9F8BA419F; Mon, 28 Mar 2022 23:47:29 +0530 (+0530)
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     quic_msavaliy@quicinc.com, dianders@chromium.org,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Subject: [PATCH] drivers/tty/serial/qcom-geni-serial: Do stop_rx in suspend path for console if console_suspend is disabled
Date:   Mon, 28 Mar 2022 23:47:24 +0530
Message-Id: <1648491444-17137-1-git-send-email-quic_vnivarth@quicinc.com>
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

[Why]
For the case of console_suspend disabled, if back to back suspend/resume
test is executed, at the end of test, sometimes console would appear to
be frozen not responding to input. This would happen because, for
console_suspend disabled, suspend/resume routines only turn resources
off/on but don't do a port close/open.
As a result, during resume, some rx transactions come in before system is
ready, malfunction of rx happens in turn resulting in console appearing
to be stuck.

[How]
Do a stop_rx in suspend sequence to prevent this. start_rx is already
present in resume sequence as part of call to set_termios which does a
stop_rx/start_rx.
Additionally other changes have been made at same place
a) replace the hardcoded flags with macros
b) perform voting before calling resume_port in resume sequence
c) consequently, swap the order in suspend sequence

Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
---
 drivers/tty/serial/qcom_geni_serial.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index aedc388..37d064f 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -19,6 +19,7 @@
 #include <linux/slab.h>
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
+#include <dt-bindings/interconnect/qcom,icc.h>
 
 /* UART specific GENI registers */
 #define SE_UART_LOOPBACK_CFG		0x22c
@@ -1477,34 +1478,38 @@ static int qcom_geni_serial_remove(struct platform_device *pdev)
 
 static int __maybe_unused qcom_geni_serial_sys_suspend(struct device *dev)
 {
+	int ret;
 	struct qcom_geni_serial_port *port = dev_get_drvdata(dev);
 	struct uart_port *uport = &port->uport;
 	struct qcom_geni_private_data *private_data = uport->private_data;
 
+	/* do a stop_rx here, start_rx is handled in uart_resume_port by call to setermios */
+	if (!console_suspend_enabled && uart_console(uport))
+		uport->ops->stop_rx(uport);
+
 	/*
 	 * This is done so we can hit the lowest possible state in suspend
 	 * even with no_console_suspend
 	 */
+	ret = uart_suspend_port(private_data->drv, uport);
 	if (uart_console(uport)) {
-		geni_icc_set_tag(&port->se, 0x3);
+		geni_icc_set_tag(&port->se, QCOM_ICC_TAG_ACTIVE_ONLY);
 		geni_icc_set_bw(&port->se);
 	}
-	return uart_suspend_port(private_data->drv, uport);
+	return ret;
 }
 
 static int __maybe_unused qcom_geni_serial_sys_resume(struct device *dev)
 {
-	int ret;
 	struct qcom_geni_serial_port *port = dev_get_drvdata(dev);
 	struct uart_port *uport = &port->uport;
 	struct qcom_geni_private_data *private_data = uport->private_data;
 
-	ret = uart_resume_port(private_data->drv, uport);
 	if (uart_console(uport)) {
-		geni_icc_set_tag(&port->se, 0x7);
+		geni_icc_set_tag(&port->se, QCOM_ICC_TAG_ALWAYS);
 		geni_icc_set_bw(&port->se);
 	}
-	return ret;
+	return uart_resume_port(private_data->drv, uport);
 }
 
 static const struct dev_pm_ops qcom_geni_serial_pm_ops = {
-- 
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by the Linux Foundation.


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3610A4F7771
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 09:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241767AbiDGH2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 03:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241955AbiDGH2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 03:28:17 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11D0B6D11;
        Thu,  7 Apr 2022 00:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649316375; x=1680852375;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=7j8XYUAv1vr0VyJnGy5NGzz9qT476I8xUjAkxpXl+to=;
  b=he+6DSD9HW+LHUeUH+m4JJftPSVnmko3WBWU5mheJ15XtG74S0H9iEUb
   37OpvGZK9RMGbe2xQSgqx1x7XggLLwYd5eqyaMTaQCuxlXO/qgU0iKBOE
   0aG5PWwIAbF4xLp7wfodfqUTwtvPcrem1rjceV2nVbbpAFOHlQsXcGMY3
   c=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 07 Apr 2022 00:26:15 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 07 Apr 2022 00:26:14 -0700
X-QCInternal: smtphost
Received: from hu-vnivarth-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.111.166])
  by ironmsg01-blr.qualcomm.com with ESMTP; 07 Apr 2022 12:56:01 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3994820)
        id 3C8273B72; Thu,  7 Apr 2022 12:56:00 +0530 (+0530)
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     quic_msavaliy@quicinc.com, dianders@chromium.org,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Subject: [V3] drivers/tty/serial/qcom-geni-serial: Do stop_rx in suspend path for console if console_suspend is disabled
Date:   Thu,  7 Apr 2022 12:55:51 +0530
Message-Id: <1649316351-9220-2-git-send-email-quic_vnivarth@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1649316351-9220-1-git-send-email-quic_vnivarth@quicinc.com>
References: <1649316351-9220-1-git-send-email-quic_vnivarth@quicinc.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the case of console_suspend disabled, if back to back suspend/resume
test is executed, at the end of test, sometimes console would appear to
be frozen not responding to input. This would happen because, for
console_suspend disabled, suspend/resume routines only turn resources
off/on but don't do a port close/open.
As a result, during resume, some rx transactions come in before system is
ready, malfunction of rx happens in turn resulting in console appearing
to be stuck.

Do a stop_rx in suspend sequence to prevent this. start_rx is already
present in resume sequence as part of call to set_termios which does a
stop_rx/start_rx.

Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
---
v3: swapped the order of conditions to be more human readable
v2: restricted patch to contain only stop_rx in suspend sequence
v1: intial patch contained 2 additional unrelated changes in vicinity
---
 drivers/tty/serial/qcom_geni_serial.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 1543a60..53723d2 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1481,6 +1481,10 @@ static int __maybe_unused qcom_geni_serial_sys_suspend(struct device *dev)
 	struct uart_port *uport = &port->uport;
 	struct qcom_geni_private_data *private_data = uport->private_data;
 
+	/* do a stop_rx here, start_rx is handled in uart_resume_port by call to setermios */
+	if (uart_console(uport) && !console_suspend_enabled)
+		uport->ops->stop_rx(uport);
+
 	/*
 	 * This is done so we can hit the lowest possible state in suspend
 	 * even with no_console_suspend
-- 
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by the Linux Foundation.


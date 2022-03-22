Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF7414E39A4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 08:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237577AbiCVHdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 03:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237562AbiCVHdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 03:33:52 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3E41D0E8;
        Tue, 22 Mar 2022 00:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647934344; x=1679470344;
  h=from:to:cc:subject:date:message-id;
  bh=bRNWpg+p75m8VUEO5mpqu7xiwCamh4vnnXXnJwBus9U=;
  b=dfR/CcLrcklrZ8h9CY/+dRIK7pxUbrZOGNwias5EPXzRMJCWu8Ha/5y7
   b1Cxvm+LwtYCmynSPCEE7YZGrEOAZcTgtjfmnH2eDkCvsRQX5Ocm7sRDC
   U2O3QkQneMqrH98gTsgXRPZoV1YhKc/iJY6SsB7F5TXJuPFa5EOvTg/JK
   w=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 22 Mar 2022 00:32:24 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 22 Mar 2022 00:32:23 -0700
X-QCInternal: smtphost
Received: from hu-vnivarth-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.111.166])
  by ironmsg02-blr.qualcomm.com with ESMTP; 22 Mar 2022 13:02:10 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3994820)
        id 8E2A944A2; Tue, 22 Mar 2022 13:02:09 +0530 (+0530)
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     quic_msavaliy@quicinc.com, quic_dkammath@quicinc.com,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Subject: [PATCH] drivers/tty/serial/qcom-geni-serial: Remove uart frequency table. Instead, find suitable frequency with call to clk_round_rate.
Date:   Tue, 22 Mar 2022 13:01:55 +0530
Message-Id: <1647934315-5189-1-git-send-email-quic_vnivarth@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Why]
This change is part of resolving feedback for an earlier
patch. The UART frequency table is to be replaced with a
call to clk_round_rate so it would work regardless of
what the clk driver supports for the particular SoC.

[How]
Try to find a frequency and divider that exactly matches
the required rate. If not found, return the closest
possible frequency and set divider to 1.

Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
---
 drivers/tty/serial/qcom_geni_serial.c | 57 ++++++++++++++++++++---------------
 1 file changed, 33 insertions(+), 24 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index aedc388..5226673 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -149,12 +149,6 @@ static unsigned int qcom_geni_serial_tx_empty(struct uart_port *port);
 static void qcom_geni_serial_stop_rx(struct uart_port *uport);
 static void qcom_geni_serial_handle_rx(struct uart_port *uport, bool drop);
 
-static const unsigned long root_freq[] = {7372800, 14745600, 19200000, 29491200,
-					32000000, 48000000, 51200000, 64000000,
-					80000000, 96000000, 100000000,
-					102400000, 112000000, 120000000,
-					128000000};
-
 #define to_dev_port(ptr, member) \
 		container_of(ptr, struct qcom_geni_serial_port, member)
 
@@ -946,32 +940,46 @@ static int qcom_geni_serial_startup(struct uart_port *uport)
 	return 0;
 }
 
-static unsigned long get_clk_cfg(unsigned long clk_freq)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(root_freq); i++) {
-		if (!(root_freq[i] % clk_freq))
-			return root_freq[i];
-	}
-	return 0;
-}
-
-static unsigned long get_clk_div_rate(unsigned int baud,
+static unsigned long get_clk_div_rate(struct clk *clk, unsigned int baud,
 			unsigned int sampling_rate, unsigned int *clk_div)
 {
 	unsigned long ser_clk;
 	unsigned long desired_clk;
+	unsigned long freq, prev, freq_first;
+
+	if (!clk) {
+		pr_err("%s: Invalid clock handle\n", __func__);
+		return 0;
+	}
 
 	desired_clk = baud * sampling_rate;
-	ser_clk = get_clk_cfg(desired_clk);
-	if (!ser_clk) {
-		pr_err("%s: Can't find matching DFS entry for baud %d\n",
-								__func__, baud);
-		return ser_clk;
+	if (!desired_clk) {
+		pr_err("%s: Invalid frequency\n", __func__);
+		return 0;
 	}
 
+	freq_first = 0;
+	prev = desired_clk;
+	freq = desired_clk - 1;
+	do {
+		if (freq != (desired_clk - 1))
+			prev = freq;
+
+		freq = clk_round_rate(clk, (freq + 1));
+
+		if (!freq_first)
+			freq_first = freq;
+	} while ((freq % desired_clk) && (freq > 0) && (freq != prev));
+
+	if (!(freq % desired_clk))
+		ser_clk = freq;
+	else
+		ser_clk = freq_first;
+
 	*clk_div = ser_clk / desired_clk;
+	if ((ser_clk) && (!(*clk_div)))
+		*clk_div = 1;
+
 	return ser_clk;
 }
 
@@ -1003,7 +1011,8 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
 	if (ver >= QUP_SE_VERSION_2_5)
 		sampling_rate /= 2;
 
-	clk_rate = get_clk_div_rate(baud, sampling_rate, &clk_div);
+	clk_rate = get_clk_div_rate((port->se).clk, baud,
+		sampling_rate, &clk_div);
 	if (!clk_rate)
 		goto out_restart_rx;
 
-- 
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by the Linux Foundation.


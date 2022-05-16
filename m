Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4395528244
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 12:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238698AbiEPKjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 06:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbiEPKix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 06:38:53 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB7D237DC;
        Mon, 16 May 2022 03:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652697532; x=1684233532;
  h=from:to:cc:subject:date:message-id;
  bh=uv3hpvVLaKZAIJnN9FauPkILRYjjAJhkGFBGer0v5m4=;
  b=IbOqfwIXGkmuJkqPk6bynuT0XWe8Vo9FsoeX39BsWji+2FOLT7cshGEZ
   rhYvCPSKtAJjniOrVoyfGqAXQZV177f/ys02BmfNuQUQNuv8xqnejiRL2
   keRXQ9YdvuREfJ1qa5hCr8hxonDAM5kUO2fw0/R1Lsjl4+BM3cplu1D4N
   s=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 16 May 2022 03:38:52 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 16 May 2022 03:38:50 -0700
X-QCInternal: smtphost
Received: from hu-vnivarth-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.111.166])
  by ironmsg02-blr.qualcomm.com with ESMTP; 16 May 2022 16:08:34 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3994820)
        id D1B523E6D; Mon, 16 May 2022 16:08:32 +0530 (+0530)
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     quic_msavaliy@quicinc.com, dianders@chromium.org, mka@chromium.org,
        swboyd@chromium.org, quic_c_skakit@quicinc.com,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Subject: [V2] tty: serial: qcom-geni-serial: Remove uart frequency table. Instead, find suitable frequency with call to clk_round_rate.
Date:   Mon, 16 May 2022 16:08:30 +0530
Message-Id: <1652697510-30543-1-git-send-email-quic_vnivarth@quicinc.com>
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

Replace the UART frequency table 'root_freq[]' with logic around
clk_round_rate() so that SoC details like the available clk frequencies
can change and this driver still works. This reduces tight coupling
between this UART driver and the SoC clk driver because we no longer
have to update the 'root_freq[]' array for new SoCs. Instead the driver
determines the available frequencies at runtime.

Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
---
v2: loops through clk dividers to zero-in quickly
v1: intial patch looped through available clk frequencies
---
 drivers/tty/serial/qcom_geni_serial.c | 56 ++++++++++++++++++++++-------------
 1 file changed, 36 insertions(+), 20 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index f496102..4733a23 100644
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
 
@@ -946,25 +940,43 @@ static int qcom_geni_serial_startup(struct uart_port *uport)
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
+	unsigned long freq, prev;
+	unsigned long div, maxdiv;
+	int64_t mult;
 
 	desired_clk = baud * sampling_rate;
-	ser_clk = get_clk_cfg(desired_clk);
+	if (!desired_clk) {
+		pr_err("%s: Invalid frequency\n", __func__);
+		return 0;
+	}
+
+	maxdiv = CLK_DIV_MSK >> CLK_DIV_SHFT;
+	prev = 0;
+
+	for (div = 1; div <= maxdiv; div++) {
+		mult = div * desired_clk;
+		if (mult > ULONG_MAX)
+			break;
+
+		freq = clk_round_rate(clk, (unsigned long)mult);
+		if (!(freq % desired_clk)) {
+			ser_clk = freq;
+			break;
+		}
+
+		if (!prev)
+			ser_clk = freq;
+		else if (prev == freq)
+			break;
+
+		prev = freq;
+	}
+
 	if (!ser_clk) {
 		pr_err("%s: Can't find matching DFS entry for baud %d\n",
 								__func__, baud);
@@ -972,6 +984,9 @@ static unsigned long get_clk_div_rate(unsigned int baud,
 	}
 
 	*clk_div = ser_clk / desired_clk;
+	if (!(*clk_div))
+		*clk_div = 1;
+
 	return ser_clk;
 }
 
@@ -1003,7 +1018,8 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
 	if (ver >= QUP_SE_VERSION_2_5)
 		sampling_rate /= 2;
 
-	clk_rate = get_clk_div_rate(baud, sampling_rate, &clk_div);
+	clk_rate = get_clk_div_rate(port->se.clk, baud,
+		sampling_rate, &clk_div);
 	if (!clk_rate)
 		goto out_restart_rx;
 
-- 
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by the Linux Foundation.


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9DB571A45
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 14:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233193AbiGLMpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 08:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233143AbiGLMpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 08:45:34 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA304AC071;
        Tue, 12 Jul 2022 05:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657629930; x=1689165930;
  h=from:to:cc:subject:date:message-id;
  bh=XCK/6S5RyHxCjXntW/hENDl8YgUipte7us+y1QdZPDw=;
  b=CHBqynBQw2wr5wCKQZ8/pJGijE9NtsGrpW/kpvsxYZhMqDH/pUejPGOF
   ZzmchKRyej7zAG05mtbS070Z2qQEh/zLWAVP82I2u16feaI2i6WOCeKai
   BGhn8OqIlempj6TCtxlkOLdjIWeGcuIA8IR73cNf19TPk+kgzUH685uRJ
   U=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 12 Jul 2022 05:45:29 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 12 Jul 2022 05:45:27 -0700
X-QCInternal: smtphost
Received: from hu-vnivarth-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.111.166])
  by ironmsg01-blr.qualcomm.com with ESMTP; 12 Jul 2022 18:15:11 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3994820)
        id 2F0F840DC; Tue, 12 Jul 2022 18:15:10 +0530 (+0530)
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     quic_msavaliy@quicinc.com, dianders@chromium.org, mka@chromium.org,
        swboyd@chromium.org,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Subject: [V5] tty: serial: qcom-geni-serial: Fix get_clk_div_rate() which otherwise could return a sub-optimal clock rate.
Date:   Tue, 12 Jul 2022 18:15:05 +0530
Message-Id: <1657629905-24685-1-git-send-email-quic_vnivarth@quicinc.com>
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

In the logic around call to clk_round_rate(), for some corner conditions,
get_clk_div_rate() could return an sub-optimal clock rate. Also, if an
exact clock rate was not found lowest clock was being returned.

Search for suitable clock rate in 2 steps
a) exact match or within 2% tolerance
b) within 5% tolerance
This also takes care of corner conditions.

Fixes: c2194bc999d4 ("tty: serial: qcom-geni-serial: Remove uart frequency table. Instead, find suitable frequency with call to clk_round_rate")
Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
---
v5: corrected format specifiers for logs
v4: replaced pr_dbg calls with dev_dbg
v3: simplified algorithm further, fixed robot compile warnings
v2: removed minor optimisations to make more readable
v1: intial patch contained slightly complicated logic
---
 drivers/tty/serial/qcom_geni_serial.c | 89 +++++++++++++++++++++--------------
 1 file changed, 54 insertions(+), 35 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 2e23b65..f5b9b8e 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -943,52 +943,71 @@ static int qcom_geni_serial_startup(struct uart_port *uport)
 	return 0;
 }
 
-static unsigned long get_clk_div_rate(struct clk *clk, unsigned int baud,
-			unsigned int sampling_rate, unsigned int *clk_div)
+static unsigned long find_clk_rate_in_tol(struct clk *clk, unsigned int desired_clk,
+			unsigned int *clk_div, unsigned int percent_tol)
 {
-	unsigned long ser_clk;
-	unsigned long desired_clk;
-	unsigned long freq, prev;
+	unsigned long freq;
 	unsigned long div, maxdiv;
-	int64_t mult;
-
-	desired_clk = baud * sampling_rate;
-	if (!desired_clk) {
-		pr_err("%s: Invalid frequency\n", __func__);
-		return 0;
-	}
+	u64 mult;
+	unsigned long offset, abs_tol, achieved;
 
+	abs_tol = div_u64((u64)desired_clk * percent_tol, 100);
 	maxdiv = CLK_DIV_MSK >> CLK_DIV_SHFT;
-	prev = 0;
-
-	for (div = 1; div <= maxdiv; div++) {
-		mult = div * desired_clk;
-		if (mult > ULONG_MAX)
+	div = 1;
+	while (div <= maxdiv) {
+		mult = (u64)div * desired_clk;
+		if (mult != (unsigned long)mult)
 			break;
 
-		freq = clk_round_rate(clk, (unsigned long)mult);
-		if (!(freq % desired_clk)) {
-			ser_clk = freq;
-			break;
-		}
+		offset = div * abs_tol;
+		freq = clk_round_rate(clk, mult - offset);
 
-		if (!prev)
-			ser_clk = freq;
-		else if (prev == freq)
+		/* Can only get lower if we're done */
+		if (freq < mult - offset)
 			break;
 
-		prev = freq;
+		/*
+		 * Re-calculate div in case rounding skipped rates but we
+		 * ended up at a good one, then check for a match.
+		 */
+		div = DIV_ROUND_CLOSEST(freq, desired_clk);
+		achieved = DIV_ROUND_CLOSEST(freq, div);
+		if (achieved <= desired_clk + abs_tol &&
+		    achieved >= desired_clk - abs_tol) {
+			*clk_div = div;
+			return freq;
+		}
+
+		div = DIV_ROUND_UP(freq, desired_clk);
 	}
 
-	if (!ser_clk) {
-		pr_err("%s: Can't find matching DFS entry for baud %d\n",
-								__func__, baud);
-		return ser_clk;
+	return 0;
+}
+
+static unsigned long get_clk_div_rate(struct clk *clk, struct device *dev,
+		unsigned int baud, unsigned int sampling_rate, unsigned int *clk_div)
+{
+	unsigned long ser_clk;
+	unsigned long desired_clk;
+
+	desired_clk = baud * sampling_rate;
+	if (!desired_clk) {
+		dev_dbg(dev, "Invalid frequency\n");
+		return 0;
 	}
 
-	*clk_div = ser_clk / desired_clk;
-	if (!(*clk_div))
-		*clk_div = 1;
+	/*
+	 * try to find a clock rate within 2% tolerance, then within
+	 */
+	ser_clk = find_clk_rate_in_tol(clk, desired_clk, clk_div, 2);
+	if (!ser_clk)
+		ser_clk = find_clk_rate_in_tol(clk, desired_clk, clk_div, 5);
+
+	if (!ser_clk)
+		dev_err(dev, "Couldn't find suitable clock rate for %lu\n", desired_clk);
+	else
+		dev_dbg(dev, "desired_clk-%lu, ser_clk-%lu, clk_div-%u\n",
+				desired_clk, ser_clk, *clk_div);
 
 	return ser_clk;
 }
@@ -1021,8 +1040,8 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
 	if (ver >= QUP_SE_VERSION_2_5)
 		sampling_rate /= 2;
 
-	clk_rate = get_clk_div_rate(port->se.clk, baud,
-		sampling_rate, &clk_div);
+	clk_rate = get_clk_div_rate(port->se.clk, port->se.dev, baud,
+					sampling_rate, &clk_div);
 	if (!clk_rate)
 		goto out_restart_rx;
 
-- 
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by the Linux Foundation.


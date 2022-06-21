Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D06AC553941
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 19:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351793AbiFUR5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 13:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233529AbiFUR5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 13:57:42 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2301D0D9;
        Tue, 21 Jun 2022 10:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655834261; x=1687370261;
  h=from:to:cc:subject:date:message-id;
  bh=IhpY0nvaFsgCuREHN0wAidroPYiiZ/Yc0RCBikSIN8s=;
  b=etvoddiJDCTrhIgWEkaNs69M+e61z8BxA4yNlEYGTGp1tdhTk4l7azNy
   OTGtZwsxR0xjJ49yqOn+l9foW2+rm/It25w4wlEneTeInRlQUEJWnemnJ
   dP/RQF70ip8yt/4ILOG2swgaZW0/YX/ah9gFr0GP9YdJIilMw9vG3Q61z
   Y=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 21 Jun 2022 10:57:41 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 21 Jun 2022 10:57:39 -0700
X-QCInternal: smtphost
Received: from hu-vnivarth-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.111.166])
  by ironmsg02-blr.qualcomm.com with ESMTP; 21 Jun 2022 23:27:24 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3994820)
        id 641833FF1; Tue, 21 Jun 2022 23:27:23 +0530 (+0530)
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     quic_msavaliy@quicinc.com, dianders@chromium.org, mka@chromium.org,
        swboyd@chromium.org,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Subject: [PATCH] tty: serial: qcom-geni-serial: Fix get_clk_div_rate() which otherwise could return a sub-optimal clock rate.
Date:   Tue, 21 Jun 2022 23:27:19 +0530
Message-Id: <1655834239-20812-1-git-send-email-quic_vnivarth@quicinc.com>
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

In the logic around call to clk_round_rate, for some corner conditions,
get_clk_div_rate() could return an sub-optimal clock rate. Also, if an
exact clock rate was not found lowest clock was being returned.

Search for suitable clock rate in 2 steps
a) exact match or within 2% tolerance
b) within 5% tolerance
This also takes care of corner conditions.

Fixes: c2194bc999d4 ("tty: serial: qcom-geni-serial: Remove uart frequency table. Instead, find suitable frequency with call to clk_round_rate")
Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
---
 drivers/tty/serial/qcom_geni_serial.c | 134 ++++++++++++++++++++++++++--------
 1 file changed, 102 insertions(+), 32 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 2e23b65..8d247c1 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -943,52 +943,123 @@ static int qcom_geni_serial_startup(struct uart_port *uport)
 	return 0;
 }
 
-static unsigned long get_clk_div_rate(struct clk *clk, unsigned int baud,
-			unsigned int sampling_rate, unsigned int *clk_div)
+static unsigned long find_clk_rate_in_tol(struct clk *clk, unsigned int desired_clk,
+			unsigned int *clk_div, unsigned int percent_tol, bool *exact_match)
 {
+	unsigned long freq;
+	unsigned long div, maxdiv, new_div;
+	unsigned long long mult;
 	unsigned long ser_clk;
-	unsigned long desired_clk;
-	unsigned long freq, prev;
-	unsigned long div, maxdiv;
-	int64_t mult;
-
-	desired_clk = baud * sampling_rate;
-	if (!desired_clk) {
-		pr_err("%s: Invalid frequency\n", __func__);
-		return 0;
-	}
+	unsigned long test_freq, offset, new_freq;
 
+	ser_clk = 0;
 	maxdiv = CLK_DIV_MSK >> CLK_DIV_SHFT;
-	prev = 0;
+	div = 1;
 
-	for (div = 1; div <= maxdiv; div++) {
-		mult = div * desired_clk;
-		if (mult > ULONG_MAX)
+	while (div <= maxdiv) {
+		mult = (unsigned long long)div * desired_clk;
+		if (mult != (unsigned long)mult)
 			break;
 
-		freq = clk_round_rate(clk, (unsigned long)mult);
-		if (!(freq % desired_clk)) {
-			ser_clk = freq;
-			break;
+		/*
+		 * Loop requesting a freq within tolerance and possibly exact freq.
+		 *
+		 * We'll keep track of the lowest freq inexact match we found
+		 * but always try to find a perfect match. NOTE: this algorithm
+		 * could miss a slightly better freq if there's more than one
+		 * freq between (freq - offset) and (freq) but (freq) can't be made
+		 * exactly, but that's OK.
+		 *
+		 * This absolutely relies on the fact that the Qualcomm clock
+		 * driver always rounds up.
+		 * We make use of exact_match as an I/O param.
+		 */
+
+		/* look only for exact match if within tolerance is already found */
+		if (ser_clk)
+			offset = 0;
+		else
+			offset = (mult * percent_tol) / 100;
+
+		test_freq = mult - offset;
+		freq = clk_round_rate(clk, test_freq);
+
+		/*
+		 * A dead-on freq is an insta-win, look for it only in 1st run
+		 */
+		if (*exact_match) {
+			if (!(freq % desired_clk)) {
+				ser_clk = freq;
+				*clk_div = freq / desired_clk;
+				return ser_clk;
+			}
+		}
+
+		if (!ser_clk) {
+			new_div = DIV_ROUND_CLOSEST(freq, desired_clk);
+			new_freq = new_div * desired_clk;
+			offset = (new_freq * percent_tol) / 100;
+
+			if (new_freq - offset <= freq && freq <= new_freq + offset) {
+				/* Save the first (lowest freq) within tolerance */
+				ser_clk = freq;
+				*clk_div = new_div;
+				/* no more search for exact match required in 2nd run */
+				if (!(*exact_match))
+					break;
+			}
 		}
 
-		if (!prev)
-			ser_clk = freq;
-		else if (prev == freq)
+		div = freq / desired_clk + 1;
+
+		/*
+		 * Only time clock framework doesn't round up is if
+		 * we're past the max clock rate. We're done searching
+		 * if that's the case.
+		 */
+		if (freq < test_freq)
 			break;
+	}
+
+	*exact_match = false;
+	return ser_clk;
+}
+
+static unsigned long get_clk_div_rate(struct clk *clk, unsigned int baud,
+			unsigned int sampling_rate, unsigned int *clk_div)
+{
+	unsigned long ser_clk;
+	unsigned long desired_clk;
+	unsigned long desired_tol;
+	bool exact_match;
 
-		prev = freq;
+	desired_clk = baud * sampling_rate;
+	if (!desired_clk) {
+		pr_err("%s: Invalid frequency\n", __func__);
+		return 0;
 	}
 
-	if (!ser_clk) {
-		pr_err("%s: Can't find matching DFS entry for baud %d\n",
-								__func__, baud);
+	/* try to find exact clock rate or within 2% tolerance */
+	ser_clk = 0;
+	exact_match = true;
+	desired_tol = 2;
+
+	ser_clk = find_clk_rate_in_tol(clk, desired_clk, clk_div, desired_tol, &exact_match);
+	if (ser_clk) {
+		if (!exact_match)
+			pr_warn("Cannot find exact match clk_rate, using one within 2 percent tolerance\n");
 		return ser_clk;
 	}
 
-	*clk_div = ser_clk / desired_clk;
-	if (!(*clk_div))
-		*clk_div = 1;
+	/* try within 5% tolerance now, no need to look for exact match */
+	exact_match = false;
+	desired_tol = 5;
+
+	ser_clk = find_clk_rate_in_tol(clk, desired_clk, clk_div, desired_tol, &exact_match);
+	if (ser_clk)
+		pr_warn("Cannot find exact match clk_rate, using one within 5 percent tolerance\n");
+	else
+		pr_err("Cannot find suitable clk_rate, giving up\n");
 
 	return ser_clk;
 }
@@ -1021,8 +1092,7 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
 	if (ver >= QUP_SE_VERSION_2_5)
 		sampling_rate /= 2;
 
-	clk_rate = get_clk_div_rate(port->se.clk, baud,
-		sampling_rate, &clk_div);
+	clk_rate = get_clk_div_rate(port->se.clk, baud, sampling_rate, &clk_div);
 	if (!clk_rate)
 		goto out_restart_rx;
 
-- 
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by the Linux Foundation.


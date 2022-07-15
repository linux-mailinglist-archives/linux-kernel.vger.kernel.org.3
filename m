Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392C45766FB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 20:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbiGOS4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 14:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiGOS42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 14:56:28 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590102DAA2;
        Fri, 15 Jul 2022 11:56:27 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26FEs6KC031633;
        Fri, 15 Jul 2022 18:55:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=9wiYGNZN6tmOdPV5LNB6z205KdtgihGjwpgjz9fRBbk=;
 b=jFD7Hkisz/gPy41HLTpPLMM5U77kczSFF3ZFB79T5ucz2iQz1QwBy7FifKXHP0+2mjvA
 SvQthBAWzbHnJUwsdhF1OUVoqLG0N/F6XlFU/8ZrLs0P2Ym4pkDQg8Bgqv3P/wlqMnLj
 nf6mHWQhP55Cfi9J3H3bH1Y/2VMbm8Kv5EknSQgbX32zoHmSgqKfffAtGU3UWInqjso3
 lAQ2+pv5nIucn9jVkOwCwU4AXT1k1yv1dcfoGlZ8eLxh1TsInX8v60COR+0vvKiPOXbH
 IiT6NUaicyx/a0ctE80OqJRkBvaqtKHH2GMJW9Teg6tabEbvwHGf4rdwBav4568fFbes uQ== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hawhwjt6t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Jul 2022 18:55:52 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 26FItmTU001945;
        Fri, 15 Jul 2022 18:55:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3h72rjjuc2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 15 Jul 2022 18:55:48 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26FItmW8001940;
        Fri, 15 Jul 2022 18:55:48 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-vnivarth-hyd.qualcomm.com [10.213.111.166])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 26FItmej001939;
        Fri, 15 Jul 2022 18:55:48 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3994820)
        id 6992C410F; Sat, 16 Jul 2022 00:25:47 +0530 (+0530)
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     quic_msavaliy@quicinc.com, dianders@chromium.org, mka@chromium.org,
        swboyd@chromium.org,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Subject: [V6] tty: serial: qcom-geni-serial: Fix get_clk_div_rate() which otherwise could return a sub-optimal clock rate.
Date:   Sat, 16 Jul 2022 00:25:43 +0530
Message-Id: <1657911343-1909-1-git-send-email-quic_vnivarth@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: b5i3boycqfCgB3ZPaLuNrhL0z4vbzPI6
X-Proofpoint-ORIG-GUID: b5i3boycqfCgB3ZPaLuNrhL0z4vbzPI6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-15_10,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 phishscore=0 priorityscore=1501 spamscore=0 malwarescore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207150084
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Fixes: c2194bc999d4 ("tty: serial: qcom-geni-serial: Remove uart frequency table. Instead, find suitable frequency with call to clk_round_rate")
Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
---
v6: moved logging to caller function
v5: corrected format specifiers for logs
v4: replaced pr_dbg calls with dev_dbg
v3: simplified algorithm further, fixed robot compile warnings
v2: removed minor optimisations to make more readable
v1: intial patch contained slightly complicated logic
---
 drivers/tty/serial/qcom_geni_serial.c | 88 +++++++++++++++++++++--------------
 1 file changed, 53 insertions(+), 35 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 2e23b65..624ffe1 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -943,52 +943,63 @@ static int qcom_geni_serial_startup(struct uart_port *uport)
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
-	}
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
 
-	if (!ser_clk) {
-		pr_err("%s: Can't find matching DFS entry for baud %d\n",
-								__func__, baud);
-		return ser_clk;
+		div = DIV_ROUND_UP(freq, desired_clk);
 	}
 
-	*clk_div = ser_clk / desired_clk;
-	if (!(*clk_div))
-		*clk_div = 1;
+	return 0;
+}
+
+static unsigned long get_clk_div_rate(struct clk *clk, unsigned int baud,
+			unsigned int sampling_rate, unsigned int *clk_div)
+{
+	unsigned long ser_clk;
+	unsigned long desired_clk;
+
+	desired_clk = baud * sampling_rate;
+	if (!desired_clk)
+		return 0;
+
+	/*
+	 * try to find a clock rate within 2% tolerance, then within 5%
+	 */
+	ser_clk = find_clk_rate_in_tol(clk, desired_clk, clk_div, 2);
+	if (!ser_clk)
+		ser_clk = find_clk_rate_in_tol(clk, desired_clk, clk_div, 5);
 
 	return ser_clk;
 }
@@ -1023,8 +1034,15 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
 
 	clk_rate = get_clk_div_rate(port->se.clk, baud,
 		sampling_rate, &clk_div);
-	if (!clk_rate)
+	if (!clk_rate) {
+		dev_err(port->se.dev,
+			"Couldn't find suitable clock rate for %lu\n",
+			baud * sampling_rate);
 		goto out_restart_rx;
+	}
+
+	dev_dbg(port->se.dev, "desired_rate-%lu, clk_rate-%lu, clk_div-%u\n",
+			baud * sampling_rate, clk_rate, clk_div);
 
 	uport->uartclk = clk_rate;
 	dev_pm_opp_set_rate(uport->dev, clk_rate);
-- 
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by the Linux Foundation.


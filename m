Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6724CADDC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 19:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244728AbiCBSsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 13:48:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244719AbiCBSr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 13:47:59 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49343D5F7B;
        Wed,  2 Mar 2022 10:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1646246835; x=1677782835;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ss1yJ8C2o2JNvk+SxQ1vw9WaY3rA4Jk7i+Ds45rTd/o=;
  b=vasoUOvkxgulG9gUFaLhghwKxRHG/W5xD9QUfzETBROht1j7WVXxVCuT
   Jxa6G+INgcdd1vh/m/phBnmTpgeVu1C9Ln7psc1X1jjjOgasG/I9AL8K6
   ph+A1BpIR9nMdV7nEn2rdlCtOr/XpNGd+TrneA1UIyuZJngFR4jRuobR+
   8=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 02 Mar 2022 10:47:15 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 10:47:14 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 2 Mar 2022 10:47:14 -0800
Received: from hu-amelende-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 2 Mar 2022 10:47:13 -0800
From:   Anjelique Melendez <quic_amelende@quicinc.com>
To:     <dmitry.torokhov@gmail.com>
CC:     <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <collinsd@codeaurora.org>,
        <bjorn.andersson@linaro.org>, <swboyd@chromium.org>,
        <skakit@codeaurora.org>,
        Anjelique Melendez <quic_amelende@quicinc.com>
Subject: [RESEND PATCH v4 4/4] input: misc: pm8941-pwrkey: simulate missed key press events
Date:   Wed, 2 Mar 2022 10:45:29 -0800
Message-ID: <20220302184525.19781-5-quic_amelende@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220302184525.19781-1-quic_amelende@quicinc.com>
References: <20220302184525.19781-1-quic_amelende@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Collins <collinsd@codeaurora.org>

The status of the keys connected to the KPDPWR_N and RESIN_N pins
is identified by reading corresponding bits in the interrupt real
time status register.  If the status has changed by the time that
the interrupt is handled then a press event will be missed.

Maintain a last known status variable to find unbalanced release
events and simulate press events for each accordingly.

Signed-off-by: David Collins <collinsd@codeaurora.org>
Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
---
 drivers/input/misc/pm8941-pwrkey.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/input/misc/pm8941-pwrkey.c b/drivers/input/misc/pm8941-pwrkey.c
index 881943ab4d55..3519152759dd 100644
--- a/drivers/input/misc/pm8941-pwrkey.c
+++ b/drivers/input/misc/pm8941-pwrkey.c
@@ -76,6 +76,7 @@ struct pm8941_pwrkey {
 	u32 code;
 	u32 sw_debounce_time_us;
 	ktime_t sw_debounce_end_time;
+	bool last_status;
 	const struct pm8941_data *data;
 };
 
@@ -162,6 +163,16 @@ static irqreturn_t pm8941_pwrkey_irq(int irq, void *_data)
 		pwrkey->sw_debounce_end_time = ktime_add_us(ktime_get(),
 						pwrkey->sw_debounce_time_us);
 
+	/*
+	 * Simulate a press event in case a release event occurred without a
+	 * corresponding press event.
+	 */
+	if (!pwrkey->last_status && !sts) {
+		input_report_key(pwrkey->input, pwrkey->code, 1);
+		input_sync(pwrkey->input);
+	}
+	pwrkey->last_status = sts;
+
 	input_report_key(pwrkey->input, pwrkey->code, sts);
 	input_sync(pwrkey->input);
 
-- 
2.34.1


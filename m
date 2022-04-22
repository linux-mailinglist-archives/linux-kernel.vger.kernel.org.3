Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1FB50C22D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 00:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbiDVWKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbiDVWIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:08:14 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 049F12C6E05;
        Fri, 22 Apr 2022 13:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650660877; x=1682196877;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G4z9WMGmzn5R8PACI1EDOWSQ9HwBuIwz18XwcrjNmJ0=;
  b=mWARJDqWM6+0BoB7IhpG02582jjwpwAWrvBTP++d6kDLP7t7M8THnB76
   g9K4gje8poAvzzphzYmz3JoIRmjeoJVxNnk+lbOX7ZTDV09a8HB2TjyUo
   FjCof7KqHOXJVtqFbKFBtI3uckFzsfptnpq0x6ZdhGjuRwVqVKBLzUs4H
   4=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 22 Apr 2022 12:14:37 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 12:14:36 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 22 Apr 2022 12:14:36 -0700
Received: from hu-amelende-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 22 Apr 2022 12:14:36 -0700
From:   Anjelique Melendez <quic_amelende@quicinc.com>
To:     <dmitry.torokhov@gmail.com>, <corbet@lwn.net>, <sre@kernel.org>,
        <robh+dt@kernel.org>
CC:     <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <bjorn.andersson@linaro.org>,
        <swboyd@chromium.org>, <linux-doc@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        David Collins <collinsd@codeaurora.org>,
        Anjelique Melendez <quic_amelende@quicinc.com>
Subject: [PATCH v6 5/5] input: misc: pm8941-pwrkey: simulate missed key press events
Date:   Fri, 22 Apr 2022 12:12:43 -0700
Message-ID: <20220422191239.6271-6-quic_amelende@quicinc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422191239.6271-1-quic_amelende@quicinc.com>
References: <20220422191239.6271-1-quic_amelende@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
2.35.1


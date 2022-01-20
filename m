Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9EA495598
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 21:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377723AbiATUo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 15:44:26 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:49766 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347295AbiATUoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 15:44:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1642711465; x=1674247465;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=usZwPYTGoT6OVxIL66S3HEIeDlMzBm+6CatAexWJ4v0=;
  b=DvNSeYlPHxzS332dyrUazaYFLIV+qi9YttWEp+5ErFW21uEsN2D5K+uo
   Th7guUw1k5aT1vHC1BY3Rx6WjuHvlm9+iCf0XxR6bTi1jZ93AJ2fER8fP
   y+hBRqqOJOHsdEAENC5NqrvBfq2b1YrhSvMGKFrf94qxyy5wgJl/Izw7o
   8=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 20 Jan 2022 12:44:25 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2022 12:44:25 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 20 Jan 2022 12:44:24 -0800
Received: from hu-amelende-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 20 Jan 2022 12:44:24 -0800
From:   Anjelique Melendez <quic_amelende@quicinc.com>
To:     <dmitry.torokhov@gmail.com>
CC:     <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <collinsd@codeaurora.org>,
        <bjorn.andersson@linaro.org>, <swboyd@chromium.org>,
        <skakit@codeaurora.org>,
        Anjelique Melendez <quic_amelende@quicinc.com>
Subject: [PATCH 2/3] input: misc: pm8941-pwrkey: simulate missed key press events
Date:   Thu, 20 Jan 2022 12:41:35 -0800
Message-ID: <20220120204132.17875-3-quic_amelende@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220120204132.17875-1-quic_amelende@quicinc.com>
References: <20220120204132.17875-1-quic_amelende@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
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

Change-Id: I180469a7048a40e490f21d0f8b9504136131e75b
Signed-off-by: David Collins <collinsd@codeaurora.org>
Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
---
 drivers/input/misc/pm8941-pwrkey.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/input/misc/pm8941-pwrkey.c b/drivers/input/misc/pm8941-pwrkey.c
index b912ce00ce1c..0ce00736e695 100644
--- a/drivers/input/misc/pm8941-pwrkey.c
+++ b/drivers/input/misc/pm8941-pwrkey.c
@@ -77,6 +77,7 @@ struct pm8941_pwrkey {
 	u32 code;
 	u32 sw_debounce_time_us;
 	ktime_t last_release_time;
+	bool last_status;
 	const struct pm8941_data *data;
 };
 
@@ -166,6 +167,16 @@ static irqreturn_t pm8941_pwrkey_irq(int irq, void *_data)
 	if (pwrkey->sw_debounce_time_us && !sts)
 		pwrkey->last_release_time = ktime_get();
 
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


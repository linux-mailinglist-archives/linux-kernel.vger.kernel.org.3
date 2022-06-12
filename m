Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C78C547863
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 05:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234398AbiFLD0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 23:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbiFLDZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 23:25:57 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D7066CBF;
        Sat, 11 Jun 2022 20:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655004340; x=1686540340;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=Ht5tFAx/b0oY9oX+FB+kzZOocBM2sta/Sgzs8nZLw/o=;
  b=rzxbAUh9KH/Kfdyv7IZaAtGLcSAhVYKPtLBYUJjB10XlXSDlIDQMOnpR
   lspZo6f9h+kVQZdIP1eeViEmMZ0oAxOlZeyMs7/WDlHGb+/w7IfkGeScW
   iWI7765Zd7oMXh+luwmDJOy4vyvX+O8h4KV1BoGbbxuw+My5InV30cQw3
   A=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 11 Jun 2022 20:25:39 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2022 20:25:39 -0700
Received: from nalasex01c.na.qualcomm.com (10.47.97.35) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sat, 11 Jun 2022 20:25:39 -0700
Received: from fenglinw-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sat, 11 Jun 2022 20:25:36 -0700
From:   Fenglin Wu <quic_fenglinw@quicinc.com>
To:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sboyd@kernel.org>
CC:     <quic_collinsd@quicinc.com>, <quic_subbaram@quicinc.com>,
        <quic_fenglinw@quicinc.com>, <tglx@linutronix.de>,
        <maz@kernel.org>, "David Collins" <collinsd@codeaurora.org>
Subject: [RESEND PATCH v6 10/10] spmi: pmic-arb: increase SPMI transaction timeout delay
Date:   Sun, 12 Jun 2022 11:24:46 +0800
Message-ID: <1655004286-11493-11-git-send-email-quic_fenglinw@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1655004286-11493-1-git-send-email-quic_fenglinw@quicinc.com>
References: <1655004286-11493-1-git-send-email-quic_fenglinw@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
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

Increase the SPMI transaction timeout delay from 100 us to
1000 us in order to account for the slower execution time
found on some simulator targets.

Signed-off-by: David Collins <collinsd@codeaurora.org>
Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
---
 drivers/spmi/spmi-pmic-arb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
index 0496e5d..45f9344 100644
--- a/drivers/spmi/spmi-pmic-arb.c
+++ b/drivers/spmi/spmi-pmic-arb.c
@@ -91,7 +91,7 @@ enum pmic_arb_channel {
 
 /* Maximum number of support PMIC peripherals */
 #define PMIC_ARB_MAX_PERIPHS		512
-#define PMIC_ARB_TIMEOUT_US		100
+#define PMIC_ARB_TIMEOUT_US		1000
 #define PMIC_ARB_MAX_TRANS_BYTES	(8)
 
 #define PMIC_ARB_APID_MASK		0xFF
-- 
2.7.4


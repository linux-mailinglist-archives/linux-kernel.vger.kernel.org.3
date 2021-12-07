Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 833BD46B879
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 11:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234816AbhLGKM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 05:12:28 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:38473 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234794AbhLGKM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 05:12:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638871737; x=1670407737;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=ygn5hxDdH773PaUSAwO94cOyRjZXiV13Bv5r2U2cJyA=;
  b=OJ5kifjNOox3aiv7dncE2yJnyGH9oMoMtmscUceG8fqR4D0ndVi9DvGM
   OcKfQPVpvaYldLSj5RR8QZg5u0FxG3viAjXUef4TjKoA9sk2KjRkhFRZv
   tUyf27TjwuSz9VagTArw43uZcM7mKlw1vD99zp+iD9LkW3gXPQi5mF45b
   o=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 07 Dec 2021 02:08:57 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 02:08:57 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 7 Dec 2021 02:08:56 -0800
Received: from blr-ubuntu-173.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 7 Dec 2021 02:08:53 -0800
From:   Rajendra Nayak <quic_rjendra@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <swboyd@chromium.org>, <mka@chromium.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
Subject: [PATCH v2 2/3] soc: qcom: rpmhpd: Remove mx/cx relationship on sc7280
Date:   Tue, 7 Dec 2021 15:38:31 +0530
Message-ID: <1638871712-18636-3-git-send-email-quic_rjendra@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1638871712-18636-1-git-send-email-quic_rjendra@quicinc.com>
References: <1638871712-18636-1-git-send-email-quic_rjendra@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While the requirement to specify the active + sleep and active-only MX
power-domains as the parents of the corresponding CX power domains is
applicable for most SoCs, we have some like the sc7280 where this 
dependency is not applicable.
Define new rpmhpd structs for cx and cx_ao without the mx as
parent and use them for sc7280.

Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
---
 drivers/soc/qcom/rpmhpd.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
index c71481d..4599efe 100644
--- a/drivers/soc/qcom/rpmhpd.c
+++ b/drivers/soc/qcom/rpmhpd.c
@@ -120,6 +120,20 @@ static struct rpmhpd cx_ao = {
 	.res_name = "cx.lvl",
 };
 
+static struct rpmhpd cx_ao_no_parent;
+static struct rpmhpd cx_no_parent = {
+	.pd = { .name = "cx", },
+	.peer = &cx_ao_no_parent,
+	.res_name = "cx.lvl",
+};
+
+static struct rpmhpd cx_ao_no_parent = {
+	.pd = { .name = "cx_ao", },
+	.active_only = true,
+	.peer = &cx_no_parent,
+	.res_name = "cx.lvl",
+};
+
 static struct rpmhpd mmcx_ao;
 static struct rpmhpd mmcx = {
 	.pd = { .name = "mmcx", },
@@ -273,8 +287,8 @@ static const struct rpmhpd_desc sc7180_desc = {
 
 /* SC7280 RPMH powerdomains */
 static struct rpmhpd *sc7280_rpmhpds[] = {
-	[SC7280_CX] = &cx,
-	[SC7280_CX_AO] = &cx_ao,
+	[SC7280_CX] = &cx_no_parent,
+	[SC7280_CX_AO] = &cx_ao_no_parent,
 	[SC7280_EBI] = &ebi,
 	[SC7280_GFX] = &gfx,
 	[SC7280_MX] = &mx,
-- 
2.7.4


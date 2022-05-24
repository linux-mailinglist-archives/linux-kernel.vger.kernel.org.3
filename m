Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60D84532AA0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 14:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237466AbiEXMqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 08:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236553AbiEXMqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 08:46:37 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA73237E3;
        Tue, 24 May 2022 05:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653396397; x=1684932397;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=N3Xf5bmejGKFxtZK+8/nPOKH7zCaWbe4gqpegVg1phk=;
  b=A7+6jTdhtYKcJWPPxNbj2OwwXol140K7mQIqQtNXCHJ8fmp+BXr+MHNq
   ry4U37SokRVOKh6AmVF/VIYTcbTeb5v2+DWYkZ7uvbssxPdVdSuyUK0lH
   mbJ8V0egTlZ+HseUHRXSUBbkIu9xJdIPIHUGqVn77/OUfp1gP7f7cbLkB
   0=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 24 May 2022 05:46:36 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 05:46:36 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 24 May 2022 05:45:55 -0700
Received: from blr-ubuntu-87.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 24 May 2022 05:45:53 -0700
From:   Sibi Sankar <quic_sibis@quicinc.com>
To:     <bjorn.andersson@linaro.org>
CC:     <agross@kernel.org>, <mathieu.poirier@linaro.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>
Subject: [V4 2/2] remoteproc: qcom_q6v5: Introduce panic handler for MSS
Date:   Tue, 24 May 2022 18:15:35 +0530
Message-ID: <1653396335-6295-3-git-send-email-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1653396335-6295-1-git-send-email-quic_sibis@quicinc.com>
References: <1653396335-6295-1-git-send-email-quic_sibis@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the MSS q6v5 remoteproc drivers implement the panic handler
that will invoke a stop to prepare the remoteprocs for post mortem
debugging.

Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---
 drivers/remoteproc/qcom_q6v5_mss.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
index 46ca841371c8..8a66e70e3bfd 100644
--- a/drivers/remoteproc/qcom_q6v5_mss.c
+++ b/drivers/remoteproc/qcom_q6v5_mss.c
@@ -1623,11 +1623,19 @@ static int qcom_q6v5_register_dump_segments(struct rproc *rproc,
 	return ret;
 }
 
+static unsigned long q6v5_panic(struct rproc *rproc)
+{
+	struct q6v5 *qproc = (struct q6v5 *)rproc->priv;
+
+	return qcom_q6v5_panic(&qproc->q6v5);
+}
+
 static const struct rproc_ops q6v5_ops = {
 	.start = q6v5_start,
 	.stop = q6v5_stop,
 	.parse_fw = qcom_q6v5_register_dump_segments,
 	.load = q6v5_load,
+	.panic = q6v5_panic,
 };
 
 static void qcom_msa_handover(struct qcom_q6v5 *q6v5)
-- 
2.7.4


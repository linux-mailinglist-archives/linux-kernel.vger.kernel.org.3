Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9D69532AF6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 15:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237605AbiEXNOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 09:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237607AbiEXNOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 09:14:09 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A959344B;
        Tue, 24 May 2022 06:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653398047; x=1684934047;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=AlBEJIoNEMC16/4ts/gX8iyplCsO76uHyacKGmtrf0A=;
  b=YbyqyfRvsKFIv/KHdInMOk4Q2MYXbTiiTKBiqkyH8ISYTbTXrF7Kn2Pp
   SZzM7wL4r1h3p7zdihv9/y4J0Dbb2gsCGy2zfres21uDIs3tnPyFDlqeB
   CJToM9Le0sEknM61/ekA83zo8vl0k3ovEPyhF1M49muYB3AB3BWz+V5e7
   Y=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 24 May 2022 06:14:07 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 06:14:07 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 24 May 2022 06:14:07 -0700
Received: from blr-ubuntu-87.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 24 May 2022 06:14:04 -0700
From:   Sibi Sankar <quic_sibis@quicinc.com>
To:     <bjorn.andersson@linaro.org>
CC:     <agross@kernel.org>, <mathieu.poirier@linaro.org>,
        <dmitry.baryshkov@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Siddharth Gupta <sidgup@codeaurora.org>,
        Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH 3/7] remoteproc: qcom: pas: Mark va as io memory
Date:   Tue, 24 May 2022 18:43:33 +0530
Message-ID: <1653398017-28426-4-git-send-email-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1653398017-28426-1-git-send-email-quic_sibis@quicinc.com>
References: <1653398017-28426-1-git-send-email-quic_sibis@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
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

From: Siddharth Gupta <sidgup@codeaurora.org>

The pas driver remaps the entire carveout region using the dev_ioremap_wc()
call, which is then used in the adsp_da_to_va() calls made by the rproc
framework. This change marks the va returned by this call as an iomem va.

Signed-off-by: Siddharth Gupta <sidgup@codeaurora.org>
Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---
 drivers/remoteproc/qcom_q6v5_pas.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index 7313fc0a3c01..a53f8a04f4af 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -291,6 +291,9 @@ static void *adsp_da_to_va(struct rproc *rproc, u64 da, size_t len, bool *is_iom
 	if (offset < 0 || offset + len > adsp->mem_size)
 		return NULL;
 
+	if (is_iomem)
+		*is_iomem = true;
+
 	return adsp->mem_region + offset;
 }
 
-- 
2.7.4


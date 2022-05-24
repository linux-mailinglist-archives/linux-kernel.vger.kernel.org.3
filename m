Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7A7A532AF3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 15:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237656AbiEXNOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 09:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237659AbiEXNO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 09:14:27 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2799969C;
        Tue, 24 May 2022 06:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653398058; x=1684934058;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=4apJ2YIhGkoEwTiNR6MNe7V3jPUQO6PtbPX8m3NH/3E=;
  b=TKodrGyvGhRuZTM21Tq/QcO9Vfkmp+VOJe/3+NA4XKa0vKuVbfRxkrXJ
   hx70TLgbFKnpY5kRGValFopUq2AmiW2RDSMIrrjE6ju4HktZV/kP54uc7
   GlKtOTR9Asc1RsRVdNA7ifRWI72HAfGBKfLr1jKJ+oqbEk2cxJwV8F6sV
   A=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 24 May 2022 06:14:17 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 06:14:17 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 24 May 2022 06:14:17 -0700
Received: from blr-ubuntu-87.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 24 May 2022 06:14:14 -0700
From:   Sibi Sankar <quic_sibis@quicinc.com>
To:     <bjorn.andersson@linaro.org>
CC:     <agross@kernel.org>, <mathieu.poirier@linaro.org>,
        <dmitry.baryshkov@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Siddharth Gupta <sidgup@codeaurora.org>,
        Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH 6/7] remoteproc: qcom: Check elf class before minidump
Date:   Tue, 24 May 2022 18:43:36 +0530
Message-ID: <1653398017-28426-7-git-send-email-quic_sibis@quicinc.com>
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

When the minidump is done with the elf64 class we need to create
the dumps using the section headers, otherwise we need to default
to dump creation using the program headers.

Fixes: 8ed8485c4f05 ("remoteproc: qcom: Add capability to collect minidumps")
Signed-off-by: Siddharth Gupta <sidgup@codeaurora.org>
Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---
 drivers/remoteproc/qcom_common.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/qcom_common.c b/drivers/remoteproc/qcom_common.c
index 4b91e3c9eafa..959fb24d57ec 100644
--- a/drivers/remoteproc/qcom_common.c
+++ b/drivers/remoteproc/qcom_common.c
@@ -174,7 +174,11 @@ void qcom_minidump(struct rproc *rproc, unsigned int minidump_id)
 		dev_err(&rproc->dev, "Failed with error: %d while adding minidump entries\n", ret);
 		goto clean_minidump;
 	}
-	rproc_coredump_using_sections(rproc);
+
+	if (rproc->elf_class == ELFCLASS64)
+		rproc_coredump_using_sections(rproc);
+	else
+		rproc_coredump(rproc);
 clean_minidump:
 	qcom_minidump_cleanup(rproc);
 }
-- 
2.7.4


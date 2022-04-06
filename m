Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F313A4F69C3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 21:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbiDFTZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 15:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbiDFTYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 15:24:38 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7640AED9FD;
        Wed,  6 Apr 2022 11:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649269693; x=1680805693;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=Rs79KJhe70Gy0XLPZF0IzThau8hzcUa246qSlKDLfaI=;
  b=IM+A14nsHYV5nTRgK2huqHhx9t9lUtpDUokFlUHwaLnH/suIjsFmNGDE
   VUqapIAJJIOshkeyJSQlYTr4/cWWoIbB6NiP+ezTe/qO98Kabel10PZwn
   E/PnKMheTeZJyVX5JpVeFc4hOiF3jpoGges515i+u4psZJgpfk2LZDt/6
   Q=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 06 Apr 2022 11:28:13 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 11:28:13 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 6 Apr 2022 11:28:12 -0700
Received: from hu-ylal-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 6 Apr 2022 11:28:10 -0700
From:   Yogesh Lal <quic_ylal@quicinc.com>
To:     <bjorn.andersson@linaro.org>, <quic_sibis@quicinc.com>
CC:     <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Yogesh Lal <quic_ylal@quicinc.com>
Subject: [PATCH] remoteproc: qcom: Add fallback mechanism for full coredump collection
Date:   Wed, 6 Apr 2022 23:57:42 +0530
Message-ID: <1649269662-20338-1-git-send-email-quic_ylal@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
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

In case remoteproc's firmware missing minidump support, during crash
scenario coredump does not collected. This change adds a fallback
mechanism for full coredump collection in the event of a crash.

Signed-off-by: Yogesh Lal <quic_ylal@quicinc.com>
---
 drivers/remoteproc/qcom_common.c   | 11 ++++++++---
 drivers/remoteproc/qcom_q6v5_pas.c |  1 +
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/remoteproc/qcom_common.c b/drivers/remoteproc/qcom_common.c
index 4b91e3c..68bd0bc 100644
--- a/drivers/remoteproc/qcom_common.c
+++ b/drivers/remoteproc/qcom_common.c
@@ -162,13 +162,18 @@ void qcom_minidump(struct rproc *rproc, unsigned int minidump_id)
 	 * is initialized in memory and encryption status is set.
 	 */
 	if (subsystem->regions_baseptr == 0 ||
-	    le32_to_cpu(subsystem->status) != 1 ||
-	    le32_to_cpu(subsystem->enabled) != MD_SS_ENABLED ||
-	    le32_to_cpu(subsystem->encryption_status) != MD_SS_ENCR_DONE) {
+		le32_to_cpu(subsystem->status) != 1 ||
+		le32_to_cpu(subsystem->enabled) != MD_SS_ENABLED) {
+			return rproc_coredump(rproc);
+		}
+
+	if (le32_to_cpu(subsystem->encryption_status) != MD_SS_ENCR_DONE) {
 		dev_err(&rproc->dev, "Minidump not ready, skipping\n");
 		return;
 	}
 
+	rproc_coredump_cleanup(rproc);
+
 	ret = qcom_add_minidump_segments(rproc, subsystem);
 	if (ret) {
 		dev_err(&rproc->dev, "Failed with error: %d while adding minidump entries\n", ret);
diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index 1ae47cc..40bf747 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -293,6 +293,7 @@ static const struct rproc_ops adsp_minidump_ops = {
 	.start = adsp_start,
 	.stop = adsp_stop,
 	.da_to_va = adsp_da_to_va,
+	.parse_fw = qcom_register_dump_segments,
 	.load = adsp_load,
 	.panic = adsp_panic,
 	.coredump = adsp_minidump,
-- 
2.7.4


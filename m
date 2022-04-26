Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDBFB50FB3D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 12:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346414AbiDZKqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 06:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348977AbiDZKpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:45:51 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946B5CF;
        Tue, 26 Apr 2022 03:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650969392; x=1682505392;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=apd35d7BYOvqx7f5UyepnqlMxVdwfN37PS+LrGA7JK4=;
  b=MWg4E3weB3gb2vDyazwvYxySMZueGT9ecz43/0NEeKZU7Yle1NvfBaYu
   BBvNKQ+R7eGgXkPhGWvkikFuzUycJ096fzQn3d9+hPvvAaq/d0pVyUSZG
   TmuIJEX9LByVdEaWwq27x1STmyhnUlfYW2Qu3eKKdiS1LrZVl6dPaZqz0
   8=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 26 Apr 2022 03:36:32 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 03:36:32 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 26 Apr 2022 03:36:31 -0700
Received: from hu-ylal-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 26 Apr 2022 03:36:29 -0700
From:   Yogesh Lal <quic_ylal@quicinc.com>
To:     <bjorn.andersson@linaro.org>, <quic_sibis@quicinc.com>
CC:     <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Yogesh Lal <quic_ylal@quicinc.com>
Subject: [PATCH v2] remoteproc: qcom: Add fallback mechanism for full coredump collection
Date:   Tue, 26 Apr 2022 16:06:14 +0530
Message-ID: <1650969374-19245-1-git-send-email-quic_ylal@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/remoteproc/qcom_common.c   | 9 ++++++---
 drivers/remoteproc/qcom_q6v5_pas.c | 1 +
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/remoteproc/qcom_common.c b/drivers/remoteproc/qcom_common.c
index 4b91e3c..12b4142 100644
--- a/drivers/remoteproc/qcom_common.c
+++ b/drivers/remoteproc/qcom_common.c
@@ -162,9 +162,12 @@ void qcom_minidump(struct rproc *rproc, unsigned int minidump_id)
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


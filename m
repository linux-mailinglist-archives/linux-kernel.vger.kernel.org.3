Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 921774E4413
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 17:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239015AbiCVQU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 12:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236352AbiCVQU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 12:20:56 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55C411A28;
        Tue, 22 Mar 2022 09:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647965966; x=1679501966;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=U7HtkD8e2y1BOHA9zy3SPJmEKe96PjQ8/7rxSr5oFsI=;
  b=dS3vIWW1rB5aytj1fgPR4CeR5G5L+MIMt0c4m/gwp7CaoamTuL82aNqX
   71CU4218QZguGlG39Zt2s8pUzc4mjyrpkNH1yU6vuqRSXV+LvFPX1EUoY
   PnJr3cJ2h/9tGZvCKG1VuOHKO6eIZPpeClGWnwhDp6ycxpzrYcaEbyetj
   c=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 22 Mar 2022 09:19:25 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 09:19:24 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 22 Mar 2022 09:19:24 -0700
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 22 Mar 2022 09:19:18 -0700
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@codeaurora.org>,
        <perex@perex.cz>, <tiwai@suse.com>,
        <srinivas.kandagatla@linaro.org>, <rohitkr@codeaurora.org>,
        <linux-arm-msm@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <swboyd@chromium.org>, <judyhsiao@chromium.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        "Venkata Prasad Potturu" <quic_potturu@quicinc.com>
Subject: [PATCH] ASoC: codecs: Fix error handling in power domain init and exit handlers
Date:   Tue, 22 Mar 2022 21:48:57 +0530
Message-ID: <1647965937-32203-1-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
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

Update error handling in power domain init and exit handlers, as existing handling
may cause issues in device remove function.
Use appropriate pm core api for power domain get and sync to avoid redundant code.

Fixes: 9e3d83c52844 ("ASoC: codecs: Add power domains support in digital macro codecs")

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 sound/soc/codecs/lpass-macro-common.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/sound/soc/codecs/lpass-macro-common.c b/sound/soc/codecs/lpass-macro-common.c
index 6cede75..3c661fd 100644
--- a/sound/soc/codecs/lpass-macro-common.c
+++ b/sound/soc/codecs/lpass-macro-common.c
@@ -24,42 +24,45 @@ struct lpass_macro *lpass_macro_pds_init(struct device *dev)
 		return ERR_PTR(-ENOMEM);
 
 	l_pds->macro_pd = dev_pm_domain_attach_by_name(dev, "macro");
-	if (IS_ERR_OR_NULL(l_pds->macro_pd))
-		return NULL;
-
-	ret = pm_runtime_get_sync(l_pds->macro_pd);
-	if (ret < 0) {
-		pm_runtime_put_noidle(l_pds->macro_pd);
+	if (IS_ERR_OR_NULL(l_pds->macro_pd)) {
+		ret = PTR_ERR(l_pds->macro_pd);
 		goto macro_err;
 	}
 
+	ret = pm_runtime_resume_and_get(l_pds->macro_pd);
+	if (ret < 0)
+		goto macro_sync_err;
+
 	l_pds->dcodec_pd = dev_pm_domain_attach_by_name(dev, "dcodec");
-	if (IS_ERR_OR_NULL(l_pds->dcodec_pd))
+	if (IS_ERR_OR_NULL(l_pds->dcodec_pd)) {
+		ret = PTR_ERR(l_pds->dcodec_pd);
 		goto dcodec_err;
+	}
 
-	ret = pm_runtime_get_sync(l_pds->dcodec_pd);
-	if (ret < 0) {
-		pm_runtime_put_noidle(l_pds->dcodec_pd);
+	ret = pm_runtime_resume_and_get(l_pds->dcodec_pd);
+	if (ret < 0)
 		goto dcodec_sync_err;
-	}
 	return l_pds;
 
 dcodec_sync_err:
 	dev_pm_domain_detach(l_pds->dcodec_pd, false);
 dcodec_err:
 	pm_runtime_put(l_pds->macro_pd);
-macro_err:
+macro_sync_err:
 	dev_pm_domain_detach(l_pds->macro_pd, false);
+macro_err:
 	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(lpass_macro_pds_init);
 
 void lpass_macro_pds_exit(struct lpass_macro *pds)
 {
-	pm_runtime_put(pds->macro_pd);
-	dev_pm_domain_detach(pds->macro_pd, false);
-	pm_runtime_put(pds->dcodec_pd);
-	dev_pm_domain_detach(pds->dcodec_pd, false);
+	if (pds) {
+		pm_runtime_put(pds->macro_pd);
+		dev_pm_domain_detach(pds->macro_pd, false);
+		pm_runtime_put(pds->dcodec_pd);
+		dev_pm_domain_detach(pds->dcodec_pd, false);
+	}
 }
 EXPORT_SYMBOL_GPL(lpass_macro_pds_exit);
 
-- 
2.7.4


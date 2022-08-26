Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21F685A1E40
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 03:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbiHZBhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 21:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244189AbiHZBhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 21:37:22 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14061C2E98;
        Thu, 25 Aug 2022 18:37:21 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MDMmq1Svjz1N7K7;
        Fri, 26 Aug 2022 09:33:47 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 26 Aug 2022 09:37:19 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 26 Aug
 2022 09:37:18 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>
CC:     <agross@kernel.org>, <bjorn.andersson@linaro.org>
Subject: [PATCH -next 3/3] remoteproc: qcom: wcss: Use dev_err_probe() helper in q6v5_wcss_init_clock()
Date:   Fri, 26 Aug 2022 09:45:11 +0800
Message-ID: <20220826014511.2270433-3-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220826014511.2270433-1-yangyingliang@huawei.com>
References: <20220826014511.2270433-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dev_err() can be replace with dev_err_probe() which will check if error
code is -EPROBE_DEFER.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/remoteproc/qcom_q6v5_wcss.c | 90 ++++++++++-------------------
 1 file changed, 30 insertions(+), 60 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_wcss.c b/drivers/remoteproc/qcom_q6v5_wcss.c
index 209fc1bd1424..ec9ad2c019aa 100644
--- a/drivers/remoteproc/qcom_q6v5_wcss.c
+++ b/drivers/remoteproc/qcom_q6v5_wcss.c
@@ -902,87 +902,57 @@ static int q6v5_wcss_init_clock(struct q6v5_wcss *wcss)
 	int ret;
 
 	wcss->xo = devm_clk_get(wcss->dev, "xo");
-	if (IS_ERR(wcss->xo)) {
-		ret = PTR_ERR(wcss->xo);
-		if (ret != -EPROBE_DEFER)
-			dev_err(wcss->dev, "failed to get xo clock");
-		return ret;
-	}
+	if (IS_ERR(wcss->xo))
+		return dev_err_probe(wcss->dev, PTR_ERR(wcss->xo),
+				     "failed to get xo clock");
 
 	wcss->gcc_abhs_cbcr = devm_clk_get(wcss->dev, "gcc_abhs_cbcr");
-	if (IS_ERR(wcss->gcc_abhs_cbcr)) {
-		ret = PTR_ERR(wcss->gcc_abhs_cbcr);
-		if (ret != -EPROBE_DEFER)
-			dev_err(wcss->dev, "failed to get gcc abhs clock");
-		return ret;
-	}
+	if (IS_ERR(wcss->gcc_abhs_cbcr))
+		return dev_err_probe(wcss->dev, PTR_ERR(wcss->gcc_abhs_cbcr),
+				     "failed to get gcc abhs clock");
 
 	wcss->gcc_axim_cbcr = devm_clk_get(wcss->dev, "gcc_axim_cbcr");
-	if (IS_ERR(wcss->gcc_axim_cbcr)) {
-		ret = PTR_ERR(wcss->gcc_axim_cbcr);
-		if (ret != -EPROBE_DEFER)
-			dev_err(wcss->dev, "failed to get gcc axim clock\n");
-		return ret;
-	}
+	if (IS_ERR(wcss->gcc_axim_cbcr))
+		return dev_err_probe(wcss->dev, PTR_ERR(wcss->gcc_axim_cbcr),
+				     "failed to get gcc axim clock\n");
 
 	wcss->ahbfabric_cbcr_clk = devm_clk_get(wcss->dev,
 						"lcc_ahbfabric_cbc");
-	if (IS_ERR(wcss->ahbfabric_cbcr_clk)) {
-		ret = PTR_ERR(wcss->ahbfabric_cbcr_clk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(wcss->dev, "failed to get ahbfabric clock\n");
-		return ret;
-	}
+	if (IS_ERR(wcss->ahbfabric_cbcr_clk))
+		return dev_err_probe(wcss->dev, PTR_ERR(wcss->ahbfabric_cbcr_clk),
+				     "failed to get ahbfabric clock\n");
 
 	wcss->lcc_csr_cbcr = devm_clk_get(wcss->dev, "tcsr_lcc_cbc");
-	if (IS_ERR(wcss->lcc_csr_cbcr)) {
-		ret = PTR_ERR(wcss->lcc_csr_cbcr);
-		if (ret != -EPROBE_DEFER)
-			dev_err(wcss->dev, "failed to get csr cbcr clk\n");
-		return ret;
-	}
+	if (IS_ERR(wcss->lcc_csr_cbcr))
+		return dev_err_probe(wcss->dev, PTR_ERR(wcss->lcc_csr_cbcr),
+				     "failed to get csr cbcr clk\n");
 
 	wcss->ahbs_cbcr = devm_clk_get(wcss->dev,
 				       "lcc_abhs_cbc");
-	if (IS_ERR(wcss->ahbs_cbcr)) {
-		ret = PTR_ERR(wcss->ahbs_cbcr);
-		if (ret != -EPROBE_DEFER)
-			dev_err(wcss->dev, "failed to get ahbs_cbcr clk\n");
-		return ret;
-	}
+	if (IS_ERR(wcss->ahbs_cbcr))
+		return dev_err_probe(wcss->dev, PTR_ERR(wcss->ahbs_cbcr),
+				     "failed to get ahbs_cbcr clk\n");
 
 	wcss->tcm_slave_cbcr = devm_clk_get(wcss->dev,
 					    "lcc_tcm_slave_cbc");
-	if (IS_ERR(wcss->tcm_slave_cbcr)) {
-		ret = PTR_ERR(wcss->tcm_slave_cbcr);
-		if (ret != -EPROBE_DEFER)
-			dev_err(wcss->dev, "failed to get tcm cbcr clk\n");
-		return ret;
-	}
+	if (IS_ERR(wcss->tcm_slave_cbcr))
+		return dev_err_probe(wcss->dev, PTR_ERR(wcss->tcm_slave_cbcr),
+				     "failed to get tcm cbcr clk\n");
 
 	wcss->qdsp6ss_abhm_cbcr = devm_clk_get(wcss->dev, "lcc_abhm_cbc");
-	if (IS_ERR(wcss->qdsp6ss_abhm_cbcr)) {
-		ret = PTR_ERR(wcss->qdsp6ss_abhm_cbcr);
-		if (ret != -EPROBE_DEFER)
-			dev_err(wcss->dev, "failed to get abhm cbcr clk\n");
-		return ret;
-	}
+	if (IS_ERR(wcss->qdsp6ss_abhm_cbcr))
+		return dev_err_probe(wcss->dev, PTR_ERR(wcss->qdsp6ss_abhm_cbcr),
+				     "failed to get abhm cbcr clk\n");
 
 	wcss->qdsp6ss_axim_cbcr = devm_clk_get(wcss->dev, "lcc_axim_cbc");
-	if (IS_ERR(wcss->qdsp6ss_axim_cbcr)) {
-		ret = PTR_ERR(wcss->qdsp6ss_axim_cbcr);
-		if (ret != -EPROBE_DEFER)
-			dev_err(wcss->dev, "failed to get axim cbcr clk\n");
-		return ret;
-	}
+	if (IS_ERR(wcss->qdsp6ss_axim_cbcr))
+		return dev_err_probe(wcss->dev, PTR_ERR(wcss->qdsp6ss_axim_cbcr),
+				     "failed to get axim cbcr clk\n");
 
 	wcss->lcc_bcr_sleep = devm_clk_get(wcss->dev, "lcc_bcr_sleep");
-	if (IS_ERR(wcss->lcc_bcr_sleep)) {
-		ret = PTR_ERR(wcss->lcc_bcr_sleep);
-		if (ret != -EPROBE_DEFER)
-			dev_err(wcss->dev, "failed to get bcr cbcr clk\n");
-		return ret;
-	}
+	if (IS_ERR(wcss->lcc_bcr_sleep))
+		return dev_err_probe(wcss->dev, PTR_ERR(wcss->lcc_bcr_sleep),
+				     "failed to get bcr cbcr clk\n");
 
 	return 0;
 }
-- 
2.25.1


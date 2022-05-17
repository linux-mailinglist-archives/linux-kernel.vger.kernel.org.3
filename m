Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9B752A2A6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 15:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233242AbiEQNF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 09:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbiEQNFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 09:05:09 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B255B49A;
        Tue, 17 May 2022 06:05:08 -0700 (PDT)
Received: from kwepemi500023.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4L2bt26xRrzhZ9v;
        Tue, 17 May 2022 21:04:10 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemi500023.china.huawei.com
 (7.221.188.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 17 May
 2022 21:04:44 +0800
From:   Peng Wu <wupeng58@huawei.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>, <kishon@ti.com>,
        <vkoul@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wupeng58@huawei.com>,
        <liwei391@huawei.com>
Subject: [PATCH] phy: qcom: fix missing clk_disable_unprepare() on err in qcom_pcie2_phy_power_on
Date:   Tue, 17 May 2022 13:00:00 +0000
Message-ID: <20220517130000.28943-1-wupeng58@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500023.china.huawei.com (7.221.188.76)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the missing clk_disable_unprepare() before return
from qcom_pcie2_phy_power_on() in the error handling case.

Signed-off-by: Peng Wu <wupeng58@huawei.com>
---
 drivers/phy/qualcomm/phy-qcom-pcie2.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-pcie2.c b/drivers/phy/qualcomm/phy-qcom-pcie2.c
index 5407e59bb185..1cc8145e0811 100644
--- a/drivers/phy/qualcomm/phy-qcom-pcie2.c
+++ b/drivers/phy/qualcomm/phy-qcom-pcie2.c
@@ -162,8 +162,10 @@ static int qcom_pcie2_phy_power_on(struct phy *phy)
 
 	ret = readl_poll_timeout(qphy->base + PCIE20_PARF_PHY_STTS, val,
 				 !(val & BIT(0)), 1000, 10);
-	if (ret)
+	if (ret) {
+		clk_disable_unprepare(qphy->pipe_clk);
 		dev_err(qphy->dev, "phy initialization failed\n");
+	}
 
 out:
 	return ret;
-- 
2.17.1


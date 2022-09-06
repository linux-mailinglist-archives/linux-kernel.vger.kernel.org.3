Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3871F5AE17B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 09:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238538AbiIFHqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 03:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbiIFHqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 03:46:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E2613E07;
        Tue,  6 Sep 2022 00:46:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5ACD61155;
        Tue,  6 Sep 2022 07:46:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CE45C433D6;
        Tue,  6 Sep 2022 07:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662450375;
        bh=8RSrPpGtvElac1kS8M9uHdFBuedVlaLfCxlKm5Xf6/E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=STQxj+UKUIyAaAtsaxoWV26cK4xIhMZr1gTjDjNWHrx30Ugaqlty0UqZDui+PNi3E
         5bAfIbZlYtvidRAi/NUdQ1N633jwUlTnzt8ifXY/rvrevUcwLqJcyil/KAqPb5Ne/+
         cinFbfVJDMbjBHSE9mI/+HlQVZASjJj0liG1gMFSRgFuF5LZDGaKgZT7JngcgkwrZu
         pzps9NG/67VRKMXKhLNurnMZIMmjWEpbGiAgpNJSAbZ4QpTZdSDrHq0ZqZ1UBplXwR
         uoZfP/gVriBi8ZNRCrgwUC/0CWppjE2y00CEeSgFfUsQXxfOcnm9HLGBazxaOA2kfL
         7CDUY9kQ+kh0A==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oVTHm-00019G-IB; Tue, 06 Sep 2022 09:46:18 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 1/3] phy: qcom-qmp-pcie: drop if (table) conditions
Date:   Tue,  6 Sep 2022 09:45:48 +0200
Message-Id: <20220906074550.4383-2-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220906074550.4383-1-johan+linaro@kernel.org>
References: <20220906074550.4383-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Drop unused if (table) conditions, since the function
qcom_qmp_phy_pcie_configure_lane() has this check anyway.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index 3ddbb8e89f04..536a6ac835c1 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -1930,8 +1930,7 @@ static int qcom_qmp_phy_pcie_serdes_init(struct qmp_phy *qphy)
 	int serdes_tbl_num = cfg->serdes_tbl_num;
 
 	qcom_qmp_phy_pcie_configure(serdes, cfg->regs, serdes_tbl, serdes_tbl_num);
-	if (cfg->serdes_tbl_sec)
-		qcom_qmp_phy_pcie_configure(serdes, cfg->regs, cfg->serdes_tbl_sec,
+	qcom_qmp_phy_pcie_configure(serdes, cfg->regs, cfg->serdes_tbl_sec,
 				       cfg->serdes_tbl_num_sec);
 
 	return 0;
@@ -2037,44 +2036,38 @@ static int qcom_qmp_phy_pcie_power_on(struct phy *phy)
 	/* Tx, Rx, and PCS configurations */
 	qcom_qmp_phy_pcie_configure_lane(tx, cfg->regs,
 				    cfg->tx_tbl, cfg->tx_tbl_num, 1);
-	if (cfg->tx_tbl_sec)
-		qcom_qmp_phy_pcie_configure_lane(tx, cfg->regs, cfg->tx_tbl_sec,
+	qcom_qmp_phy_pcie_configure_lane(tx, cfg->regs, cfg->tx_tbl_sec,
 					    cfg->tx_tbl_num_sec, 1);
 
 	/* Configuration for other LANE for USB-DP combo PHY */
 	if (cfg->is_dual_lane_phy) {
 		qcom_qmp_phy_pcie_configure_lane(qphy->tx2, cfg->regs,
 					    cfg->tx_tbl, cfg->tx_tbl_num, 2);
-		if (cfg->tx_tbl_sec)
-			qcom_qmp_phy_pcie_configure_lane(qphy->tx2, cfg->regs,
+		qcom_qmp_phy_pcie_configure_lane(qphy->tx2, cfg->regs,
 						    cfg->tx_tbl_sec,
 						    cfg->tx_tbl_num_sec, 2);
 	}
 
 	qcom_qmp_phy_pcie_configure_lane(rx, cfg->regs,
 				    cfg->rx_tbl, cfg->rx_tbl_num, 1);
-	if (cfg->rx_tbl_sec)
-		qcom_qmp_phy_pcie_configure_lane(rx, cfg->regs,
+	qcom_qmp_phy_pcie_configure_lane(rx, cfg->regs,
 					    cfg->rx_tbl_sec, cfg->rx_tbl_num_sec, 1);
 
 	if (cfg->is_dual_lane_phy) {
 		qcom_qmp_phy_pcie_configure_lane(qphy->rx2, cfg->regs,
 					    cfg->rx_tbl, cfg->rx_tbl_num, 2);
-		if (cfg->rx_tbl_sec)
-			qcom_qmp_phy_pcie_configure_lane(qphy->rx2, cfg->regs,
+		qcom_qmp_phy_pcie_configure_lane(qphy->rx2, cfg->regs,
 						    cfg->rx_tbl_sec,
 						    cfg->rx_tbl_num_sec, 2);
 	}
 
 	qcom_qmp_phy_pcie_configure(pcs, cfg->regs, cfg->pcs_tbl, cfg->pcs_tbl_num);
-	if (cfg->pcs_tbl_sec)
-		qcom_qmp_phy_pcie_configure(pcs, cfg->regs, cfg->pcs_tbl_sec,
+	qcom_qmp_phy_pcie_configure(pcs, cfg->regs, cfg->pcs_tbl_sec,
 				       cfg->pcs_tbl_num_sec);
 
 	qcom_qmp_phy_pcie_configure(pcs_misc, cfg->regs, cfg->pcs_misc_tbl,
 			       cfg->pcs_misc_tbl_num);
-	if (cfg->pcs_misc_tbl_sec)
-		qcom_qmp_phy_pcie_configure(pcs_misc, cfg->regs, cfg->pcs_misc_tbl_sec,
+	qcom_qmp_phy_pcie_configure(pcs_misc, cfg->regs, cfg->pcs_misc_tbl_sec,
 				       cfg->pcs_misc_tbl_num_sec);
 
 	/*
-- 
2.35.1


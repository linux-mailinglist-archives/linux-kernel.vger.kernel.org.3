Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 010B1508C14
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 17:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380218AbiDTP2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 11:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377076AbiDTP2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 11:28:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C231C434A2;
        Wed, 20 Apr 2022 08:25:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6723061924;
        Wed, 20 Apr 2022 15:25:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C25F1C385A1;
        Wed, 20 Apr 2022 15:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650468346;
        bh=IFO7zkqpAOdI3qLxiErIiXVRmsyaS2XtE7709e9/pfk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XE3+Jgt/WUc1wrYPDIy4lj0c/50nxH5J+kZkGxQiWpBbyubqdMBIQcE6mzq2w2nSZ
         +A3qDqwP2IvTK7Svc/D9oXdHOqKpaqQj2xICTE502RnER3BMIx7Z/frwUYTev8xIr9
         yZIpLyzCs0OXA1URxzFM+W5NAcv7FTnJYsJVAPw41wfF0ttJHwXLEmDsx3aUDiiNkz
         U3yzXJ3yoosw464XcZpsSO2h9Vg5RBDovaaRKoF6mlWVx+0WLUr4tPMvJjENKDTpaD
         VHc+f7rktWx5rnmtiXkluzxwJa0iTri3vUyR5QHtPeWFSDJGPcjBxYuT2U/LEMBCOA
         TBMBuLj9tmQzA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1nhCD6-0001Sc-1l; Wed, 20 Apr 2022 17:25:40 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Evan Green <evgreen@chromium.org>
Subject: [PATCH 2/2] phy: qcom-qmp: fix pipe-clock imbalance on power-on failure
Date:   Wed, 20 Apr 2022 17:23:31 +0200
Message-Id: <20220420152331.5527-3-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220420152331.5527-1-johan+linaro@kernel.org>
References: <20220420152331.5527-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure to disable the pipe clock also if ufs-reset deassertion fails
during power on.

Note that the ufs-reset is asserted in qcom_qmp_phy_com_exit().

Fixes: c9b589791fc1 ("phy: qcom: Utilize UFS reset controller")
Cc: Evan Green <evgreen@chromium.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
index 8c2300bfe489..7d2d1ab061f7 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
@@ -5375,14 +5375,14 @@ static int qcom_qmp_phy_power_on(struct phy *phy)
 		if (ret) {
 			dev_err(qmp->dev, "lane%d reset deassert failed\n",
 				qphy->index);
-			goto err_lane_rst;
+			return ret;
 		}
 	}
 
 	ret = clk_prepare_enable(qphy->pipe_clk);
 	if (ret) {
 		dev_err(qmp->dev, "pipe_clk enable failed err=%d\n", ret);
-		goto err_clk_enable;
+		goto err_reset_lane;
 	}
 
 	/* Tx, Rx, and PCS configurations */
@@ -5433,7 +5433,7 @@ static int qcom_qmp_phy_power_on(struct phy *phy)
 
 	ret = reset_control_deassert(qmp->ufs_reset);
 	if (ret)
-		goto err_lane_rst;
+		goto err_disable_pipe_clk;
 
 	qcom_qmp_phy_configure(pcs_misc, cfg->regs, cfg->pcs_misc_tbl,
 			       cfg->pcs_misc_tbl_num);
@@ -5472,17 +5472,17 @@ static int qcom_qmp_phy_power_on(struct phy *phy)
 					 PHY_INIT_COMPLETE_TIMEOUT);
 		if (ret) {
 			dev_err(qmp->dev, "phy initialization timed-out\n");
-			goto err_pcs_ready;
+			goto err_disable_pipe_clk;
 		}
 	}
 	return 0;
 
-err_pcs_ready:
+err_disable_pipe_clk:
 	clk_disable_unprepare(qphy->pipe_clk);
-err_clk_enable:
+err_reset_lane:
 	if (cfg->has_lane_rst)
 		reset_control_assert(qphy->lane_rst);
-err_lane_rst:
+
 	return ret;
 }
 
-- 
2.35.1


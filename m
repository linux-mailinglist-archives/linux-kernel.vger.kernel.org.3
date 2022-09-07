Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACD15B027C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 13:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbiIGLI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 07:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbiIGLH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 07:07:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BE9A347D;
        Wed,  7 Sep 2022 04:07:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D4B4BB81C29;
        Wed,  7 Sep 2022 11:07:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 942A5C4314C;
        Wed,  7 Sep 2022 11:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662548868;
        bh=0OLQo5HG5t0mohZzuG/02hbLS2lB2JW6h+/81xwTWDc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O5apGTyvfzRzSOtkZsR0vJYatWBow0UMxYLDAUJ0BeAjHqKQfCYkGaqDE4LPT0iJD
         aQlTHi/rZD4TJ9W87VhTOipbREBzJjM3x5KNrYgmbNWFBtbShA2/C4nv5KNmcYaNcm
         vGSGvrhWHsv9IlOmjQAurFL7SehUPe7l/cR5GH63keiNcjkMMUneiZOsqJj9Klz5k+
         PkPFmqj88A9LwD35+56OukBLoWxxAwM4LVlu1cZcixc0iaYBwNEFL8roc6BvkZfby7
         IXVKgtw+gdoZYuGRFwYheXKJhUajbzYDdcGiR5IJLiua+7KTeUGGtbSSQj6uzG9pZB
         fAuPCc0rLx59g==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oVsuO-0004z5-MB; Wed, 07 Sep 2022 13:07:52 +0200
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
Subject: [PATCH 07/16] phy: qcom-qmp-ufs: drop unused runtime PM implementation
Date:   Wed,  7 Sep 2022 13:07:19 +0200
Message-Id: <20220907110728.19092-8-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220907110728.19092-1-johan+linaro@kernel.org>
References: <20220907110728.19092-1-johan+linaro@kernel.org>
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

Drop the unused and incomplete runtime PM implementation, which was
only used by USB PHYs before splitting the QMP driver.

Note that the runtime PM was never disabled (and state restored) on
driver unbind.

This effectively reverts commit ac0d239936bd ("phy: qcom-qmp: Add
support for runtime PM").

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 38 -------------------------
 1 file changed, 38 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
index 01a99a06fd4f..7bd3c992b841 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
@@ -53,17 +53,6 @@
 #define USB3_MODE				BIT(0) /* enables USB3 mode */
 #define DP_MODE					BIT(1) /* enables DP mode */
 
-/* QPHY_PCS_AUTONOMOUS_MODE_CTRL register bits */
-#define ARCVR_DTCT_EN				BIT(0)
-#define ALFPS_DTCT_EN				BIT(1)
-#define ARCVR_DTCT_EVENT_SEL			BIT(4)
-
-/* QPHY_PCS_LFPS_RXTERM_IRQ_CLEAR register bits */
-#define IRQ_CLEAR				BIT(0)
-
-/* QPHY_PCS_LFPS_RXTERM_IRQ_STATUS register bits */
-#define RCVR_DETECT				BIT(0)
-
 /* QPHY_V3_PCS_MISC_CLAMP_ENABLE register bits */
 #define CLAMP_EN				BIT(0) /* enables i/o clamp_n */
 
@@ -125,9 +114,6 @@ enum qphy_reg_layout {
 	QPHY_START_CTRL,
 	QPHY_PCS_READY_STATUS,
 	QPHY_PCS_STATUS,
-	QPHY_PCS_AUTONOMOUS_MODE_CTRL,
-	QPHY_PCS_LFPS_RXTERM_IRQ_CLEAR,
-	QPHY_PCS_LFPS_RXTERM_IRQ_STATUS,
 	QPHY_PCS_POWER_DOWN_CONTROL,
 	/* PCS_MISC registers */
 	QPHY_PCS_MISC_TYPEC_CTRL,
@@ -635,7 +621,6 @@ struct qmp_phy_cfg {
  * @pcs_misc: iomapped memory space for lane's pcs_misc
  * @index: lane index
  * @qmp: QMP phy to which this lane belongs
- * @mode: current PHY mode
  */
 struct qmp_phy {
 	struct phy *phy;
@@ -649,7 +634,6 @@ struct qmp_phy {
 	void __iomem *pcs_misc;
 	unsigned int index;
 	struct qcom_qmp *qmp;
-	enum phy_mode mode;
 };
 
 /**
@@ -1117,16 +1101,6 @@ static int qcom_qmp_phy_ufs_disable(struct phy *phy)
 	return qcom_qmp_phy_ufs_exit(phy);
 }
 
-static int qcom_qmp_phy_ufs_set_mode(struct phy *phy,
-				 enum phy_mode mode, int submode)
-{
-	struct qmp_phy *qphy = phy_get_drvdata(phy);
-
-	qphy->mode = mode;
-
-	return 0;
-}
-
 static int qcom_qmp_phy_ufs_vreg_init(struct device *dev, const struct qmp_phy_cfg *cfg)
 {
 	struct qcom_qmp *qmp = dev_get_drvdata(dev);
@@ -1162,7 +1136,6 @@ static int qcom_qmp_phy_ufs_clk_init(struct device *dev, const struct qmp_phy_cf
 static const struct phy_ops qcom_qmp_ufs_ops = {
 	.power_on	= qcom_qmp_phy_ufs_enable,
 	.power_off	= qcom_qmp_phy_ufs_disable,
-	.set_mode	= qcom_qmp_phy_ufs_set_mode,
 	.owner		= THIS_MODULE,
 };
 
@@ -1332,14 +1305,6 @@ static int qcom_qmp_phy_ufs_probe(struct platform_device *pdev)
 	if (!qmp->phys)
 		return -ENOMEM;
 
-	pm_runtime_set_active(dev);
-	pm_runtime_enable(dev);
-	/*
-	 * Prevent runtime pm from being ON by default. Users can enable
-	 * it using power/control in sysfs.
-	 */
-	pm_runtime_forbid(dev);
-
 	id = 0;
 	for_each_available_child_of_node(dev->of_node, child) {
 		/* Create per-lane phy */
@@ -1356,13 +1321,10 @@ static int qcom_qmp_phy_ufs_probe(struct platform_device *pdev)
 	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
 	if (!IS_ERR(phy_provider))
 		dev_info(dev, "Registered Qcom-QMP phy\n");
-	else
-		pm_runtime_disable(dev);
 
 	return PTR_ERR_OR_ZERO(phy_provider);
 
 err_node_put:
-	pm_runtime_disable(dev);
 	of_node_put(child);
 	return ret;
 }
-- 
2.35.1


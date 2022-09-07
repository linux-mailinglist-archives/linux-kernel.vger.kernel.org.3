Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75EFF5B0275
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 13:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbiIGLIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 07:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiIGLHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 07:07:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CFDE9E0F1;
        Wed,  7 Sep 2022 04:07:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 370CC61888;
        Wed,  7 Sep 2022 11:07:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8CB2C43157;
        Wed,  7 Sep 2022 11:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662548868;
        bh=i3GLcfaQY/Hs2uoFIcfYbMIocl+SKu8NmymrisvBoJE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a+zrzw1YXiOpepM3+BAZ2EmZPlpjFk+KLLIph2DIIkGgAL6vp3L8XaXMio034gh2U
         ZPWyt66FkaowG+/7Hd6xU4rJatvFtjPbm6XLANtkw/8xxGXSAVyVtF42vzyZahed9n
         gpg3tb0CiOBQUBe00AA4X9aghF/++b+b6dLS3IezgFTDg17EMcBrq82PvfR1KHehVl
         6LZ9CCufcm6LEh6JaINbq7ywmMQnYBed94Qzau8pkz4XAFv6N6vXkyuGEgo/zoQAoM
         FOEiHbfMVQHO/FAwMYYNieopjDB2xI0iMjLZFZnC5kEIpmWDzmNDZ0RelqBT9mlAvQ
         TTua3Wtx6KGqg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oVsuO-0004yy-Fh; Wed, 07 Sep 2022 13:07:52 +0200
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
Subject: [PATCH 05/16] phy: qcom-qmp-pcie-msm8996: drop unused runtime PM implementation
Date:   Wed,  7 Sep 2022 13:07:17 +0200
Message-Id: <20220907110728.19092-6-johan+linaro@kernel.org>
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
 .../phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c  | 37 -------------------
 1 file changed, 37 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c
index a4ff15b289cd..a5b9a81541c4 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c
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
@@ -308,7 +294,6 @@ struct qmp_phy {
 	unsigned int index;
 	struct qcom_qmp *qmp;
 	struct reset_control *lane_rst;
-	enum phy_mode mode;
 };
 
 /**
@@ -718,16 +703,6 @@ static int qcom_qmp_phy_pcie_msm8996_disable(struct phy *phy)
 	return qcom_qmp_phy_pcie_msm8996_exit(phy);
 }
 
-static int qcom_qmp_phy_pcie_msm8996_set_mode(struct phy *phy,
-				 enum phy_mode mode, int submode)
-{
-	struct qmp_phy *qphy = phy_get_drvdata(phy);
-
-	qphy->mode = mode;
-
-	return 0;
-}
-
 static int qcom_qmp_phy_pcie_msm8996_vreg_init(struct device *dev, const struct qmp_phy_cfg *cfg)
 {
 	struct qcom_qmp *qmp = dev_get_drvdata(dev);
@@ -844,7 +819,6 @@ static int phy_pipe_clk_register(struct qcom_qmp *qmp, struct device_node *np)
 static const struct phy_ops qcom_qmp_phy_pcie_msm8996_ops = {
 	.power_on	= qcom_qmp_phy_pcie_msm8996_enable,
 	.power_off	= qcom_qmp_phy_pcie_msm8996_disable,
-	.set_mode	= qcom_qmp_phy_pcie_msm8996_set_mode,
 	.owner		= THIS_MODULE,
 };
 
@@ -989,14 +963,6 @@ static int qcom_qmp_phy_pcie_msm8996_probe(struct platform_device *pdev)
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
@@ -1024,13 +990,10 @@ static int qcom_qmp_phy_pcie_msm8996_probe(struct platform_device *pdev)
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


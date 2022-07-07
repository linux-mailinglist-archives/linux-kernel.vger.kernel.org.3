Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B523F56A476
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 15:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236232AbiGGNtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 09:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236120AbiGGNrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 09:47:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1727221260;
        Thu,  7 Jul 2022 06:47:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 92906B8222A;
        Thu,  7 Jul 2022 13:47:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C583C341ED;
        Thu,  7 Jul 2022 13:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657201661;
        bh=idICe18a4rExFwkuq6iAbQ7o+y4Szu7dxszLezAghwc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hdndot8kAOYaU2vt0MiEFqIRdcZ2hy2MWCB30RAEpocCM+7ahwUuLWjASUDUCxd1l
         /GWPweUnuuqnTgJVtQJHg3WgzJC1hgShkZvZZsh9x2xLYvYDQNDw3XctMJfz0fk1ID
         +0cV7xTDJsvzROkpJx9mWPsDtSMcpx+tRGALrXKvEgNU/TznV1uQ6XhKYPpQ3OxKDn
         t5HU4YGcjVXZqqAQr2bcHx71AfXInNZMenCeT6/hCwoqDI4PFuwUGT5QczCT3yQ6qG
         cl/LFCbbVQIiMAX5zqW6KY04IxKvq1NuVE8/QOKdJMX5L8uOhrU5DB/GzkINtKQDyr
         cjeNewiPOVdMw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1o9Rr6-0000yk-3N; Thu, 07 Jul 2022 15:47:44 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2 28/30] phy: qcom-qmp-pcie-msm8996: drop pipe clock lane suffix
Date:   Thu,  7 Jul 2022 15:47:23 +0200
Message-Id: <20220707134725.3512-29-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220707134725.3512-1-johan+linaro@kernel.org>
References: <20220707134725.3512-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pipe clock is defined in the "lane" node so there's no need to keep
adding a redundant lane-number suffix to the clock name.

Update driver to support the new binding where the pipe clock name has
been deprecated by instead requesting the clock by index.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c
index 812d14afb5ec..af2f14a53b38 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c
@@ -872,7 +872,6 @@ int qcom_qmp_phy_pcie_msm8996_create(struct device *dev, struct device_node *np,
 	struct qcom_qmp *qmp = dev_get_drvdata(dev);
 	struct phy *generic_phy;
 	struct qmp_phy *qphy;
-	char prop_name[MAX_PROP_NAME];
 	int ret;
 
 	qphy = devm_kzalloc(dev, sizeof(*qphy), GFP_KERNEL);
@@ -904,8 +903,7 @@ int qcom_qmp_phy_pcie_msm8996_create(struct device *dev, struct device_node *np,
 	if (!qphy->pcs_misc)
 		dev_vdbg(dev, "PHY pcs_misc-reg not used\n");
 
-	snprintf(prop_name, sizeof(prop_name), "pipe%d", id);
-	qphy->pipe_clk = devm_get_clk_from_child(dev, np, prop_name);
+	qphy->pipe_clk = devm_get_clk_from_child(dev, np, NULL);
 	if (IS_ERR(qphy->pipe_clk)) {
 		return dev_err_probe(dev, PTR_ERR(qphy->pipe_clk),
 				     "failed to get lane%d pipe clock\n", id);
-- 
2.35.1


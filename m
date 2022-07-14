Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7A6574E2D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 14:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239553AbiGNMpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 08:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239473AbiGNMoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 08:44:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA6F4599E;
        Thu, 14 Jul 2022 05:44:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D216061FBC;
        Thu, 14 Jul 2022 12:44:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFD25C36AF9;
        Thu, 14 Jul 2022 12:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657802645;
        bh=Rjt84oz1GE8/XtxkoEJv9XH95bgR17zbVUZRhDI5L6g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=diMmJwvQiJKddPkmdb9hPc8CnmZ6J7L83xX/7KHk9FMd24/cNtbISTitqRE/e/fT4
         UYN0emQ9z4Ee8QZ+XrbRNvI6yf5/U7m454IXnI2aHdymq9HIlqqWu0ORIq9WgHlsZM
         7OUrTAfKIM1kavf1bnujq5ZSTA2yvU2mvfpgwwN5Q9p/1WAjsTM8uT/ntbig4OOWTY
         uIEWQM4smtxsSRSp/yn+M1JDNJYG1kV9seIP4QewEjZQoWWRxgWLXzK3jCa5X+qoGo
         msYBXVrpoqz7PC69JusU/UDRlPgBhN+kVmMh9Ud27w97TD33s9vxU7dlwzxNaT4P6D
         nqGw/Y8/B1EWg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oByCR-0007ER-Am; Thu, 14 Jul 2022 14:44:11 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v3 29/30] phy: qcom-qmp-pcie-msm8996: drop reset lane suffix
Date:   Thu, 14 Jul 2022 14:43:32 +0200
Message-Id: <20220714124333.27643-30-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220714124333.27643-1-johan+linaro@kernel.org>
References: <20220714124333.27643-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lane reset is defined in the "lane" node so there's no need to keep
adding a redundant lane-number suffix to the reset name.

Update driver to support the new binding where the "lane" reset name has
been deprecated by instead requesting the reset by index.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c
index 7b893c66cf75..a4ff15b289cd 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c
@@ -860,7 +860,6 @@ int qcom_qmp_phy_pcie_msm8996_create(struct device *dev, struct device_node *np,
 	struct qcom_qmp *qmp = dev_get_drvdata(dev);
 	struct phy *generic_phy;
 	struct qmp_phy *qphy;
-	char prop_name[MAX_PROP_NAME];
 	int ret;
 
 	qphy = devm_kzalloc(dev, sizeof(*qphy), GFP_KERNEL);
@@ -898,9 +897,7 @@ int qcom_qmp_phy_pcie_msm8996_create(struct device *dev, struct device_node *np,
 				     "failed to get lane%d pipe clock\n", id);
 	}
 
-	/* Get lane reset, if any */
-	snprintf(prop_name, sizeof(prop_name), "lane%d", id);
-	qphy->lane_rst = of_reset_control_get_exclusive(np, prop_name);
+	qphy->lane_rst = of_reset_control_get_exclusive_by_index(np, 0);
 	if (IS_ERR(qphy->lane_rst)) {
 		dev_err(dev, "failed to get lane%d reset\n", id);
 		return PTR_ERR(qphy->lane_rst);
-- 
2.35.1


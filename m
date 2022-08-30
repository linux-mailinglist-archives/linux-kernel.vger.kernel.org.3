Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85E885A61F9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 13:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbiH3LbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 07:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbiH3LaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 07:30:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D2922B3F;
        Tue, 30 Aug 2022 04:30:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED97D6155A;
        Tue, 30 Aug 2022 11:30:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3824C4347C;
        Tue, 30 Aug 2022 11:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661859001;
        bh=ik9HtwhDAeYEiLoS39U3DGxmuHrw4bv1UDZj63E1omk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gf8uBIbwLamMrT3CU6hmdqylMIZTwCz6n11AT2ds+tCwJoEPIgmBHq48yTsbJeGWF
         vTkfgttp1pe1Y4HcedXXrUBZW5e6nHbAKcXHRHQH0rvLKV61a0WSMTRACPXvZVvPYv
         0Z25hikFY3X8CyRViqCxag9lIq/3eSRljpWgYUbYWwTjPWwKUibHMWgTz+Lutl19CK
         677SXIcjBX7gekeNE8x4lWPmsn84rPaGAp0E8Y/iMcaJh5+CBKGbH7fliv1Njs8wh8
         53KCEMFC5iw1Sq6aqtNxYIP2S9A7XFuAvASZPJ/uAa4hhlpmQxZvfPK1WzjEUX40+m
         q1hiORMA9SEyA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oSzRP-00011D-DR; Tue, 30 Aug 2022 13:29:59 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 29/30] phy: qcom-qmp-pcie-msm8996: drop reset lane suffix
Date:   Tue, 30 Aug 2022 13:29:22 +0200
Message-Id: <20220830112923.3725-30-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220830112923.3725-1-johan+linaro@kernel.org>
References: <20220830112923.3725-1-johan+linaro@kernel.org>
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

The lane reset is defined in the "lane" node so there's no need to keep
adding a redundant lane-number suffix to the reset name.

Update driver to support the new binding where the "lane" reset name has
been deprecated by instead requesting the reset by index.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
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


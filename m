Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23505578C5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 13:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbiFWLdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 07:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbiFWLdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 07:33:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D025D2F661;
        Thu, 23 Jun 2022 04:33:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7E275B8224C;
        Thu, 23 Jun 2022 11:33:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4518AC3411B;
        Thu, 23 Jun 2022 11:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655984019;
        bh=4OZWF88ZGl7gNa7eawf1xJ3ZOtfszFqU8X+FxZF/O3E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QRlTwtmP0+T7kG1SQrsC3QOFxOnes+2sZ3eGK0AEe8ZPloEP1/h5Rh7BB2TFocbCh
         YsjO7Sc8CQMLMPoGLDlDX3pqRisbJKXVkVppHY6m4/5jbb+K+e9v0ZP24DdGCa2P5G
         1o6OfRmzTLgZrRmckzYZLEBQTjhbOncEhU9nya3Em1UNUCUiXU3D7EB+YiEW7pXeci
         FoSAn/Q3z/Qn75p+7kjOdbt4Ke0T5rdT17JhGakXeLtsrY4mMB9pRmsI6TF/6COZpq
         668QaX3oIrYmlKg2m8kYQRLEMPW3SO+8Vh10jIgOmv5d1nR5U3XB72Zfac6RbpEKFl
         YuaQ+sxwtdBvw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1o4L5c-0007kP-Q9; Thu, 23 Jun 2022 13:33:36 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 3/3] phy: qcom-qmp-usb: clean up pipe clock handling
Date:   Thu, 23 Jun 2022 13:33:14 +0200
Message-Id: <20220623113314.29761-4-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220623113314.29761-1-johan+linaro@kernel.org>
References: <20220623113314.29761-1-johan+linaro@kernel.org>
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

Clean up the pipe clock handling by using dev_err_probe() to handle
probe deferral and dropping the obsolete comment that claimed that the
pipe clock was optional for some other PHY types.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
index aebe5ed4e4e3..40e87f75ec4a 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
@@ -2530,22 +2530,11 @@ int qcom_qmp_phy_usb_create(struct device *dev, struct device_node *np, int id,
 	if (!qphy->pcs_misc)
 		dev_vdbg(dev, "PHY pcs_misc-reg not used\n");
 
-	/*
-	 * Get PHY's Pipe clock, if any. USB3 and PCIe are PIPE3
-	 * based phys, so they essentially have pipe clock. So,
-	 * we return error in case phy is USB3 or PIPE type.
-	 * Otherwise, we initialize pipe clock to NULL for
-	 * all phys that don't need this.
-	 */
 	snprintf(prop_name, sizeof(prop_name), "pipe%d", id);
 	qphy->pipe_clk = devm_get_clk_from_child(dev, np, prop_name);
 	if (IS_ERR(qphy->pipe_clk)) {
-		ret = PTR_ERR(qphy->pipe_clk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev,
-				"failed to get lane%d pipe_clk, %d\n",
-				id, ret);
-		return ret;
+		return dev_err_probe(dev, PTR_ERR(qphy->pipe_clk),
+				     "failed to get lane%d pipe clock\n", id);
 	}
 
 	generic_phy = devm_phy_create(dev, np, &qcom_qmp_phy_usb_ops);
-- 
2.35.1


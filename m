Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56FF3588C34
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 14:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238039AbiHCMel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 08:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233057AbiHCMef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 08:34:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA67628E0F;
        Wed,  3 Aug 2022 05:34:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 711D861378;
        Wed,  3 Aug 2022 12:34:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE2C6C433D6;
        Wed,  3 Aug 2022 12:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659530073;
        bh=msh6rGbtOmkvBZUPclv6+UinjCPJTZ0keeEvElEwjSI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LUjazEmu4ouTtCOZNf92NowWYMERm7oiSTSewuuHFHXIbMhiyrpR5tY5jxuOLV3Zm
         J0FR1QWQleRyiYExEZ3cAiQ9jzdtxkNPrRD0as5iTXOIxsLR2nAaIc30766Oa0Czj0
         6CgL5PMFSw0HpzSH9vHyCrkZkHlRBof4NLLNzmb2w0Dp9137I61kCoa7Yn7W9pLDOp
         qacGgLSUeB9DqD/dbtm9HWPG6IgS6TrxEQOVYSNt51ZSkZ7Y5XlyOzAsHi5NlHTDUC
         rSh/RY3O9qURMVkMYWLtw3YMRE7kiIPU5CHB8EoRD8Ux55a8FAnglcsfeAB7McINvb
         ERnUKqq1q7epg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oJDaO-00028D-PU; Wed, 03 Aug 2022 14:34:52 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Douglas Anderson <dianders@chromium.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 2/2] phy: qcom-edp: drop regulator loads
Date:   Wed,  3 Aug 2022 14:33:32 +0200
Message-Id: <20220803123332.8138-3-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220803123332.8138-1-johan+linaro@kernel.org>
References: <20220803123332.8138-1-johan+linaro@kernel.org>
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

Drivers should not be specifying active-mode regulator loads unless
supporting an idle mode where the load is reduced during runtime.

This effectively reverts commit a4888b2005d1 ("phy: qcom-edp: add
regulator_set_load to edp phy")

Link: https://lore.kernel.org/r/YuPps+cvVAMugWmy@sirena.org.uk
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-edp.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
index 7e3570789845..cacd32f6e0cc 100644
--- a/drivers/phy/qualcomm/phy-qcom-edp.c
+++ b/drivers/phy/qualcomm/phy-qcom-edp.c
@@ -639,18 +639,6 @@ static int qcom_edp_phy_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = regulator_set_load(edp->supplies[0].consumer, 21800); /* 1.2 V vdda-phy */
-	if (ret) {
-		dev_err(dev, "failed to set load at %s\n", edp->supplies[0].supply);
-		return ret;
-	}
-
-	ret = regulator_set_load(edp->supplies[1].consumer, 36000); /* 0.9 V vdda-pll */
-	if (ret) {
-		dev_err(dev, "failed to set load at %s\n", edp->supplies[1].supply);
-		return ret;
-	}
-
 	ret = qcom_edp_clks_register(edp, pdev->dev.of_node);
 	if (ret)
 		return ret;
-- 
2.35.1


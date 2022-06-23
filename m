Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC2A5578C6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 13:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbiFWLdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 07:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbiFWLdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 07:33:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F503336F;
        Thu, 23 Jun 2022 04:33:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B6C12B8224D;
        Thu, 23 Jun 2022 11:33:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 595B3C341C7;
        Thu, 23 Jun 2022 11:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655984019;
        bh=rF+KnkI8TrvuBOWUOKxZrJzbKbUt+JURZ8zGL45kkxs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f31BjyG3rUQD5UMRNzPEvh6jmBF8vkqf3MgFOKD1wvcbTfM0XrSwXr85kmFd6aMif
         sLG7i4v0Df/TpIGNn50+q4w9Y386n5yEcjP4PoTjsx/SWCDpmxC2yvbaneNdnt3aeP
         PcOqQMdDNW4SPC2wiE+8wXH+emXMJvzhVozCrjc8qu+DbzLdqu95Wm896fvCZEPvbm
         z6ezr2lYK/epWpI446emHB6gwJz+iDT65N78UmQcdptQ43ullzZzUYsm6b1jw9rlzk
         vGwXg8EYWINeprBEKy14Sc0EHOJDIPYUG6Du10lcvOniI+LD/nayokD6/e4tmiSqRB
         WRtX1CfVruapw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1o4L5c-0007kL-Kr; Thu, 23 Jun 2022 13:33:36 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 1/3] phy: qcom-qmp-pcie: drop obsolete pipe clock type check
Date:   Thu, 23 Jun 2022 13:33:12 +0200
Message-Id: <20220623113314.29761-2-johan+linaro@kernel.org>
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

Drop the obsolete pipe clock handling which was used to treat the pipe
clock as optional for types other than PCIe and USB and which is no
longer needed since splitting the PHY driver.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index b2cd0cf965d8..385ea3d8de08 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -2210,26 +2210,11 @@ int qcom_qmp_phy_pcie_create(struct device *dev, struct device_node *np, int id,
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
-		if (cfg->type == PHY_TYPE_PCIE ||
-		    cfg->type == PHY_TYPE_USB3) {
-			ret = PTR_ERR(qphy->pipe_clk);
-			if (ret != -EPROBE_DEFER)
-				dev_err(dev,
-					"failed to get lane%d pipe_clk, %d\n",
-					id, ret);
-			return ret;
-		}
-		qphy->pipe_clk = NULL;
+		return dev_err_probe(dev, PTR_ERR(qphy->pipe_clk),
+				     "failed to get lane%d pipe clock\n", id);
 	}
 
 	generic_phy = devm_phy_create(dev, np, &qcom_qmp_phy_pcie_ops);
-- 
2.35.1


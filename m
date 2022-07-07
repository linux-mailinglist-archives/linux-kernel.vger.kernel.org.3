Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F039156A47A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 15:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236282AbiGGNt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 09:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236103AbiGGNrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 09:47:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624FA1FCD6;
        Thu,  7 Jul 2022 06:47:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 76C1462049;
        Thu,  7 Jul 2022 13:47:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9083DC341F2;
        Thu,  7 Jul 2022 13:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657201661;
        bh=if7x9pUFUD8PopCzs/NYjEUQxvbby1hAw9eciZM4+V4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QzkzIeMzJKw1Rq2wRdJPGUbA+d4SWDDVM0DhtgUatxOhFm48arTnEr0hPMj8R51a0
         WMdNYPk8iCuhAAY6/L/8m5f3IY8MPHbwMvKcP95GDY7rPQzs3+iAmDNRliYXyx9m4Y
         WikmOWMg9+yVEe9T6MTzJ9eyjtvnAr9snwtk64TYodjDB1uIuNVvwd0dQFB/wqI1OF
         mTIXK1gH99GD74yat9mI4TUF/xGL8RrG5Qb5c3DTBnwk1hPhjcW10gdeF+a+9DqoF4
         HtKUbZ1yqAJTfPOKbCS42dICyDe410JMyFpb/zYw+pyVVsYNj3OD0Q4GJnpy4h64k1
         acXB3B7he7MXw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1o9Rr6-0000zK-86; Thu, 07 Jul 2022 15:47:44 +0200
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
Subject: [PATCH v2 30/30] phy: qcom-qmp-usb: drop pipe clock lane suffix
Date:   Thu,  7 Jul 2022 15:47:25 +0200
Message-Id: <20220707134725.3512-31-johan+linaro@kernel.org>
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
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
index 994a8232be7b..2ed9b031bde4 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
@@ -2609,7 +2609,6 @@ int qcom_qmp_phy_usb_create(struct device *dev, struct device_node *np, int id,
 	struct qcom_qmp *qmp = dev_get_drvdata(dev);
 	struct phy *generic_phy;
 	struct qmp_phy *qphy;
-	char prop_name[MAX_PROP_NAME];
 	int ret;
 
 	qphy = devm_kzalloc(dev, sizeof(*qphy), GFP_KERNEL);
@@ -2665,8 +2664,7 @@ int qcom_qmp_phy_usb_create(struct device *dev, struct device_node *np, int id,
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


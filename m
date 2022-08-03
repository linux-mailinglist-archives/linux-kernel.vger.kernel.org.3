Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E172588C36
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 14:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238049AbiHCMer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 08:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235025AbiHCMeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 08:34:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3911CB0A;
        Wed,  3 Aug 2022 05:34:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1D030B8225D;
        Wed,  3 Aug 2022 12:34:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C210DC433B5;
        Wed,  3 Aug 2022 12:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659530073;
        bh=cjlE0FBFyWe53Ldcvjg0DL1JexEytGR7NT8J4Bje9cc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=feZngJJTY0tNOTzjj8N2qtbNbFIcfLhpfgYzUNvQg9zG7X6Gdh/uGsNNJDrOJBWeG
         n/q09Y68ifunJQPBxdHbde3WIipPnVO9KEpe88ey8vP5mdyYCKShJVR4GXMq6FqRy+
         lC4MfMGTp1aTykXmSruXunqgQyasGkyTbtQqKFkWLSmFsMww4HGFkqmgaGslAVC/nv
         wPa90AlEHY1l2vQ62S1jzXLUAzNcXoSbpzxVqjhuyvHSr1SrrkFDfqw8zvMyYUFt1a
         FVPz9pNYjrLx/xA3+J89yvL0cYSUFN63oGciekd0y5Wi2QcFggFsfTOUFVvo7XmDbD
         QNGfE78M+IxxA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oJDaO-00028B-My; Wed, 03 Aug 2022 14:34:52 +0200
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
Subject: [PATCH 1/2] phy: qcom-qmp-combo: drop regulator loads
Date:   Wed,  3 Aug 2022 14:33:31 +0200
Message-Id: <20220803123332.8138-2-johan+linaro@kernel.org>
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

This effectively reverts commit 85936d4f3815 ("phy: qcom-qmp: add
regulator_set_load to dp phy").

Link: https://lore.kernel.org/r/YuPps+cvVAMugWmy@sirena.org.uk
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 40 +++++------------------
 1 file changed, 9 insertions(+), 31 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index 4b1828976104..3663252622be 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -607,17 +607,6 @@ static const struct qmp_phy_init_tbl qmp_v4_dp_tx_tbl[] = {
 };
 
 
-/* list of regulators */
-struct qmp_regulator_data {
-	const char *name;
-	unsigned int enable_load;
-};
-
-static struct qmp_regulator_data qmp_phy_vreg_l[] = {
-	{ .name = "vdda-phy", .enable_load = 21800 },
-	{ .name = "vdda-pll", .enable_load = 36000 },
-};
-
 struct qmp_phy;
 
 /* struct qmp_phy_cfg - per-PHY initialization config */
@@ -662,7 +651,7 @@ struct qmp_phy_cfg {
 	const char * const *reset_list;
 	int num_resets;
 	/* regulators to be requested */
-	const struct qmp_regulator_data *vreg_list;
+	const char * const *vreg_list;
 	int num_vregs;
 
 	/* array of registers with different offsets */
@@ -831,6 +820,11 @@ static const char * const sc7180_usb3phy_reset_l[] = {
 	"phy",
 };
 
+/* list of regulators */
+static const char * const qmp_phy_vreg_l[] = {
+	"vdda-phy", "vdda-pll",
+};
+
 static const struct qmp_phy_cfg sc7180_usb3phy_cfg = {
 	.type			= PHY_TYPE_USB3,
 	.nlanes			= 1,
@@ -1992,32 +1986,16 @@ static int qcom_qmp_phy_combo_vreg_init(struct device *dev, const struct qmp_phy
 {
 	struct qcom_qmp *qmp = dev_get_drvdata(dev);
 	int num = cfg->num_vregs;
-	int ret, i;
+	int i;
 
 	qmp->vregs = devm_kcalloc(dev, num, sizeof(*qmp->vregs), GFP_KERNEL);
 	if (!qmp->vregs)
 		return -ENOMEM;
 
 	for (i = 0; i < num; i++)
-		qmp->vregs[i].supply = cfg->vreg_list[i].name;
+		qmp->vregs[i].supply = cfg->vreg_list[i];
 
-	ret = devm_regulator_bulk_get(dev, num, qmp->vregs);
-	if (ret) {
-		dev_err(dev, "failed at devm_regulator_bulk_get\n");
-		return ret;
-	}
-
-	for (i = 0; i < num; i++) {
-		ret = regulator_set_load(qmp->vregs[i].consumer,
-					cfg->vreg_list[i].enable_load);
-		if (ret) {
-			dev_err(dev, "failed to set load at %s\n",
-				qmp->vregs[i].supply);
-			return ret;
-		}
-	}
-
-	return 0;
+	return devm_regulator_bulk_get(dev, num, qmp->vregs);
 }
 
 static int qcom_qmp_phy_combo_reset_init(struct device *dev, const struct qmp_phy_cfg *cfg)
-- 
2.35.1


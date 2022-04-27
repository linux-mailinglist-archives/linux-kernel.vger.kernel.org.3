Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA2A511145
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 08:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358171AbiD0Gjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 02:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358180AbiD0Gis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 02:38:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC82DAC;
        Tue, 26 Apr 2022 23:35:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A48A9B82504;
        Wed, 27 Apr 2022 06:35:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53DE8C385AF;
        Wed, 27 Apr 2022 06:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651041335;
        bh=S7L7LCfQw9ybG+HTyJrxZ9N79OTqInjfPScQ2OGVp+Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Aw/hwbhuNiAjclNMtdRoTPB/EuKV8w/i9HhU75hQvcpQnRi975vAk904voio6LY3e
         97U+eP03pUzkl+a29/PzZA7K5H0s7jWlo2QsWVcEIiSw++JlNGoxrVg+e5DCM77ESu
         ROsL0egHLEpo5f55H/WyvFxaCVGTQGt1C6kE0E2sat6cO/k+m3zb5poUDyKd+B3WCK
         HNs2SoJkjeBDkdHAeVpoMglvvonXHjsXLhuq1c6rEeO/aMzHNLuIVpFzn/SfbIWiSK
         kIRkQkOrx6/l34MieqhhWkghjDnLgFZNn6g2+X96lv3FLNnhsuVlUVf3wpVIjxaSNB
         QaRfeOCLNcPmQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1njbGz-0008VZ-3R; Wed, 27 Apr 2022 08:35:37 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2 3/3] phy: qcom-qmp: switch to explicit reset helpers
Date:   Wed, 27 Apr 2022 08:32:43 +0200
Message-Id: <20220427063243.32576-4-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220427063243.32576-1-johan+linaro@kernel.org>
References: <20220427063243.32576-1-johan+linaro@kernel.org>
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

Switch to consistently using the explicit reset-controller API which
makes it clear that the reset controllers are used exclusively by the
PHY driver.

Note that the deprecated of_reset_control_get() and
devm_reset_control_get() are just transitional wrappers for the explicit
API so there's no functional change.

Suggested-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
index 3f77830921f5..160d723fc773 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
@@ -5701,7 +5701,7 @@ static int qcom_qmp_phy_reset_init(struct device *dev, const struct qmp_phy_cfg
 		struct reset_control *rst;
 		const char *name = cfg->reset_list[i];
 
-		rst = devm_reset_control_get(dev, name);
+		rst = devm_reset_control_get_exclusive(dev, name);
 		if (IS_ERR(rst)) {
 			dev_err(dev, "failed to get %s reset\n", name);
 			return PTR_ERR(rst);
@@ -6099,7 +6099,7 @@ int qcom_qmp_phy_create(struct device *dev, struct device_node *np, int id,
 	/* Get lane reset, if any */
 	if (cfg->has_lane_rst) {
 		snprintf(prop_name, sizeof(prop_name), "lane%d", id);
-		qphy->lane_rst = of_reset_control_get(np, prop_name);
+		qphy->lane_rst = of_reset_control_get_exclusive(np, prop_name);
 		if (IS_ERR(qphy->lane_rst)) {
 			dev_err(dev, "failed to get lane%d reset\n", id);
 			return PTR_ERR(qphy->lane_rst);
-- 
2.35.1


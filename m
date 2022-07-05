Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6D85666FC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 11:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232495AbiGEJup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 05:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbiGEJtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 05:49:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4AB712777;
        Tue,  5 Jul 2022 02:49:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 888CC61940;
        Tue,  5 Jul 2022 09:49:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 565A7C36B03;
        Tue,  5 Jul 2022 09:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657014545;
        bh=YMvAOoxj66wx3vQtLy6RtQ77bhpRxfXPIBlYHFKEAkM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DWSSxYGX2Rou1bXKSrmfSI3NcuE0Gv7nf1rQSkHzkSpx+XvreYDTiSCG9p1nQuTQ0
         cttp0E9RR0tnw4KK1AJCG/oE2fIDw8ZZODUpiTfWjsFUx71ph6PICFImzxPEXxPvh2
         kj9jxmaDD0tBYr9uBRzz+dIOfm017deDchFFQ+cOTL75+mzrIYMeRD1lorVC8RQOuV
         Uow4IDe61D7+JHm5wVizd8vHUpj7xJAcnCIgdYHrV1r18/imE3pCOeI58syf9TcWeu
         d2ISrjBxRsV7THQsVtiSfIr3mtdvUtO+N9R4p7ChHjWFr+HlwBeEKvIthlSJs7V4sY
         e2RftCF6M3jlQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1o8fB4-0004aC-7o; Tue, 05 Jul 2022 11:49:06 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 40/43] phy: qcom-qmp-combo: drop pipe clock lane suffix
Date:   Tue,  5 Jul 2022 11:42:36 +0200
Message-Id: <20220705094239.17174-41-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220705094239.17174-1-johan+linaro@kernel.org>
References: <20220705094239.17174-1-johan+linaro@kernel.org>
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

Drop the lane suffix from the pipe clock name, but continue supporting
the legacy name as a fall back.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index b266514ae9ee..7b2eb234cfc2 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -2558,8 +2558,12 @@ int qcom_qmp_phy_combo_create(struct device *dev, struct device_node *np, int id
 	 * Otherwise, we initialize pipe clock to NULL for
 	 * all phys that don't need this.
 	 */
-	snprintf(prop_name, sizeof(prop_name), "pipe%d", id);
-	qphy->pipe_clk = devm_get_clk_from_child(dev, np, prop_name);
+	qphy->pipe_clk = devm_get_clk_from_child(dev, np, "pipe");
+	if (IS_ERR(qphy->pipe_clk) && PTR_ERR(qphy->pipe_clk) != -EPROBE_DEFER) {
+		/* Fall back to the legacy pipe clock name. */
+		snprintf(prop_name, sizeof(prop_name), "pipe%d", id);
+		qphy->pipe_clk = devm_get_clk_from_child(dev, np, prop_name);
+	}
 	if (IS_ERR(qphy->pipe_clk)) {
 		if (cfg->type == PHY_TYPE_USB3) {
 			ret = PTR_ERR(qphy->pipe_clk);
-- 
2.35.1


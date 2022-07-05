Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1775666F7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 11:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232483AbiGEJun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 05:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbiGEJtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 05:49:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F90DDFEF;
        Tue,  5 Jul 2022 02:49:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A98D261919;
        Tue,  5 Jul 2022 09:49:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 793F2C341ED;
        Tue,  5 Jul 2022 09:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657014545;
        bh=qN2MBS4iXGKTp1LW3/dBfjDQA+8VCN1gORTM4XGT/iM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DWmeq/gYfSAg1ikbfrLtH3CMfWj9qsAoxOQQhIn+zQtPFlk6MJX1xvHNNRWYo0lML
         fucZakFMVgY/ggoVfswqb0HwlzPxnzoRtURtVfUw/qDH8oOkRdumR+d+FJF36ERF0I
         49vBVpfGADAhp7VYNfXfcJZpgd6DxGEYbcV42aroyPQDDVF/bfSW71nWXGT5wUOeWM
         tGP6qLNv6zfSDYmHjx+NFmIXzAEHTWKOO6DtNtQI+nAbK58l9d1jxWwdSKE3e4rQJ+
         Qjrlo035l9tGAb0ardpolr0Tf1NcGUAKdJnJmzHcjjDaVrKyW1ehbiFQscF/+a5iom
         Xk9Gxg5SQXfvQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1o8fB4-0004az-Fq; Tue, 05 Jul 2022 11:49:06 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 42/43] phy: qcom-qmp-pcie-msm8996: drop reset lane suffix
Date:   Tue,  5 Jul 2022 11:42:38 +0200
Message-Id: <20220705094239.17174-43-johan+linaro@kernel.org>
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

The lane reset is defined in the "lane" node so there's no need to keep
adding a redundant lane-number suffix to the reset name.

Drop the lane-number suffix from the lane reset name, but continue
supporting the legacy name as a fall back.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c
index b8481dab54db..9ddb42fa5f7a 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c
@@ -915,9 +915,12 @@ int qcom_qmp_phy_pcie_msm8996_create(struct device *dev, struct device_node *np,
 				     "failed to get lane%d pipe clock\n", id);
 	}
 
-	/* Get lane reset, if any */
-	snprintf(prop_name, sizeof(prop_name), "lane%d", id);
-	qphy->lane_rst = of_reset_control_get_exclusive(np, prop_name);
+	qphy->lane_rst = of_reset_control_get_exclusive(np, "lane");
+	if (IS_ERR(qphy->lane_rst) && PTR_ERR(qphy->lane_rst) != -EPROBE_DEFER) {
+		/* Fall back to the legacy lane reset name. */
+		snprintf(prop_name, sizeof(prop_name), "lane%d", id);
+		qphy->lane_rst = of_reset_control_get_exclusive(np, prop_name);
+	}
 	if (IS_ERR(qphy->lane_rst)) {
 		dev_err(dev, "failed to get lane%d reset\n", id);
 		return PTR_ERR(qphy->lane_rst);
-- 
2.35.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D3156B235
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 07:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237179AbiGHFVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 01:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237074AbiGHFVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 01:21:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949EC796AC;
        Thu,  7 Jul 2022 22:21:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 52420B824AB;
        Fri,  8 Jul 2022 05:21:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D337C341C0;
        Fri,  8 Jul 2022 05:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657257669;
        bh=KLGJw23mYWR4pbhJCYVyVEuZAxCLz5NIUf6oVzI57yA=;
        h=From:To:Cc:Subject:Date:From;
        b=S7BUK5w9vrnjRZnzS5isQ3Ugt5r1bU8Q9zxrIUp6qrvoa1IxvV04oxpmAFugv0Ja8
         EhYb814z3yTmbG2q9grtmPDvoTSiUjkPzxwgCWTAt8GFDPvqCK0vGne5w+nEqMedLs
         ZfhlcIyS0vzsPKBzYIxHqtG/lKs+SlfbM0Jbw4juRwxVAbAru6OOkYvIuQR1woHOPP
         VtZ5Nf9bQn+C+rhdITOj6Rd01gM9roeMY7fqhTsCGNG2k3peWDVr4CMBW0MQqXahKB
         OTDmVWeS6g6PWxQGEVFJKYo7KfivOyWfpXg311PpAVAq1dLPDLOKLTjB0+Dc4vwe1x
         pxUdBl9lyhUbA==
From:   Vinod Koul <vkoul@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-phy@lists.infradead.org, Vinod Koul <vkoul@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH] phy: qcom-qmp-usb: statify qmp_phy_vreg_l
Date:   Fri,  8 Jul 2022 10:50:59 +0530
Message-Id: <20220708052059.3049443-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.36.1
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

qmp_phy_vreg_l should be marked static, this resolves warning:

drivers/phy/qualcomm/phy-qcom-qmp-combo.c:616:27: warning: symbol 'qmp_phy_vreg_l' was not declared. Should it be static?

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index c77e427a74cf..4b1828976104 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -613,7 +613,7 @@ struct qmp_regulator_data {
 	unsigned int enable_load;
 };
 
-struct qmp_regulator_data qmp_phy_vreg_l[] = {
+static struct qmp_regulator_data qmp_phy_vreg_l[] = {
 	{ .name = "vdda-phy", .enable_load = 21800 },
 	{ .name = "vdda-pll", .enable_load = 36000 },
 };
-- 
2.36.1


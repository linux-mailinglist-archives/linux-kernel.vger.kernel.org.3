Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06E3B58AA98
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 14:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240707AbiHEMNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 08:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240672AbiHEMNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 08:13:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4463D286F4;
        Fri,  5 Aug 2022 05:13:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D54AB619EC;
        Fri,  5 Aug 2022 12:13:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AD51C433C1;
        Fri,  5 Aug 2022 12:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659701585;
        bh=PA3Jes8esomv6XUVX1XLh+eeP+V+PWzpFq3Big4vhOU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VDmcgm2XSpCJj4Iz+JkznFB0Cw7XoELcozT1CtzxxeJZOuTqIoFw4KqlD0PD+1xs/
         1sUHnrYJw9Cfe8BKymosmZooo1myuNfOt0SI8kCqDUj1ORnwrFmDaP3bCHBbD0ZgvZ
         WuNseB4g1AneyBOLFc4rx72favCbME0YI9GcK5eEBFH+9IQrrx667UtXqnbZidLD7e
         ywunXn9aHY19CNZrDHJPU6Q5PWs6MhfH8ZhFDMJ/D+YOlxqS8PuYAffwF50srtGh3b
         x9nroS5/rwQJRtFyj1iyDEZAWy5ahtH8i4hN+Mb2utT/7h4LkpoWOM/G9SiXRLdMho
         0iNLEyXVREF5Q==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oJwCn-0002hI-JP; Fri, 05 Aug 2022 14:13:29 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 1/2] clk: gcc-sc8280xp: keep PCIe power-domains always-on
Date:   Fri,  5 Aug 2022 14:12:49 +0200
Message-Id: <20220805121250.10347-2-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220805121250.10347-1-johan+linaro@kernel.org>
References: <20220805121250.10347-1-johan+linaro@kernel.org>
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

The Qualcomm PCIe driver does not yet implement suspend so to keep the
PCIe power domains always-on for now to avoid crashing during resume.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/clk/qcom/gcc-sc8280xp.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/qcom/gcc-sc8280xp.c b/drivers/clk/qcom/gcc-sc8280xp.c
index a2f3ffcc5849..eaeada42e13a 100644
--- a/drivers/clk/qcom/gcc-sc8280xp.c
+++ b/drivers/clk/qcom/gcc-sc8280xp.c
@@ -6768,6 +6768,10 @@ static struct gdsc pcie_1_tunnel_gdsc = {
 	.flags = VOTABLE,
 };
 
+/*
+ * The Qualcomm PCIe driver does not yet implement suspend so to keep the
+ * PCIe power domains always-on for now.
+ */
 static struct gdsc pcie_2a_gdsc = {
 	.gdscr = 0x9d004,
 	.collapse_ctrl = 0x52128,
@@ -6776,7 +6780,7 @@ static struct gdsc pcie_2a_gdsc = {
 		.name = "pcie_2a_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
-	.flags = VOTABLE,
+	.flags = VOTABLE | ALWAYS_ON,
 };
 
 static struct gdsc pcie_2b_gdsc = {
@@ -6787,7 +6791,7 @@ static struct gdsc pcie_2b_gdsc = {
 		.name = "pcie_2b_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
-	.flags = VOTABLE,
+	.flags = VOTABLE | ALWAYS_ON,
 };
 
 static struct gdsc pcie_3a_gdsc = {
@@ -6798,7 +6802,7 @@ static struct gdsc pcie_3a_gdsc = {
 		.name = "pcie_3a_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
-	.flags = VOTABLE,
+	.flags = VOTABLE | ALWAYS_ON,
 };
 
 static struct gdsc pcie_3b_gdsc = {
@@ -6809,7 +6813,7 @@ static struct gdsc pcie_3b_gdsc = {
 		.name = "pcie_3b_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
-	.flags = VOTABLE,
+	.flags = VOTABLE | ALWAYS_ON,
 };
 
 static struct gdsc pcie_4_gdsc = {
@@ -6820,7 +6824,7 @@ static struct gdsc pcie_4_gdsc = {
 		.name = "pcie_4_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
-	.flags = VOTABLE,
+	.flags = VOTABLE | ALWAYS_ON,
 };
 
 static struct gdsc ufs_card_gdsc = {
-- 
2.35.1


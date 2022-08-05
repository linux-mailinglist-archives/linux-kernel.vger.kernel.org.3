Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22E2558AA9A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 14:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240714AbiHEMNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 08:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbiHEMNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 08:13:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA1843E49;
        Fri,  5 Aug 2022 05:13:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE7A9619F2;
        Fri,  5 Aug 2022 12:13:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ECA3C433D6;
        Fri,  5 Aug 2022 12:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659701585;
        bh=QE/B3jAG/zflVLqqj8OYDIfnigG3Trc7SVAyes1GBf8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S/gGN9iVAPz9t+jeVGe/UYb9jKzYNYmzaIzwad9DQ/b0S0jdol+D1b2T6xEDdZ6mp
         6UUJq+SmcTFYdN37nCQYOGhEco6NejKAHMeMD7mipQwPWILQYH3gsQXa9Wjq6gig4j
         ngjnERyobNSnFEsmjYPstOnHLxTLgiBUoqzyMjYblpav8Pipem4I1yWY7A54gCB3Jw
         3OGEE4vbIJ4hl5+aLBkSzEo0z/aMYWSRgyDkl95Lj4rANCy524fivCkVSJ2iUPBEc+
         tieImzDvG3JWP2FgoewuQfdqdEe5sY2QG5WEsFYUx95PUBaQPeb0piPl4nk9/b2VxI
         AHOTTF/ybHcFA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oJwCn-0002hK-Md; Fri, 05 Aug 2022 14:13:29 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 2/2] clk: gcc-sc8280xp: keep USB power-domains always-on
Date:   Fri,  5 Aug 2022 14:12:50 +0200
Message-Id: <20220805121250.10347-3-johan+linaro@kernel.org>
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

The Qualcomm DWC3 driver suspend implementation appears to be incomplete
for SC8280XP so keep the USB power domains always-on for now so that the
controller survives a suspend cycle.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/clk/qcom/gcc-sc8280xp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/clk/qcom/gcc-sc8280xp.c b/drivers/clk/qcom/gcc-sc8280xp.c
index eaeada42e13a..7768e6901dcc 100644
--- a/drivers/clk/qcom/gcc-sc8280xp.c
+++ b/drivers/clk/qcom/gcc-sc8280xp.c
@@ -6843,12 +6843,17 @@ static struct gdsc ufs_phy_gdsc = {
 	.pwrsts = PWRSTS_OFF_ON,
 };
 
+/*
+ * The Qualcomm DWC3 driver suspend implementation appears to be incomplete
+ * for sc8280xp so keep the USB power domains always-on for now.
+ */
 static struct gdsc usb30_mp_gdsc = {
 	.gdscr = 0xab004,
 	.pd = {
 		.name = "usb30_mp_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
+	.flags = ALWAYS_ON,
 };
 
 static struct gdsc usb30_prim_gdsc = {
@@ -6857,6 +6862,7 @@ static struct gdsc usb30_prim_gdsc = {
 		.name = "usb30_prim_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
+	.flags = ALWAYS_ON,
 };
 
 static struct gdsc usb30_sec_gdsc = {
@@ -6865,6 +6871,7 @@ static struct gdsc usb30_sec_gdsc = {
 		.name = "usb30_sec_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
+	.flags = ALWAYS_ON,
 };
 
 static struct clk_regmap *gcc_sc8280xp_clocks[] = {
-- 
2.35.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9184652E9AB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 12:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348083AbiETKKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 06:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347993AbiETKKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 06:10:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D473E27A1;
        Fri, 20 May 2022 03:10:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92D2161D00;
        Fri, 20 May 2022 10:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6F5AC385A9;
        Fri, 20 May 2022 10:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653041421;
        bh=1N46Qkx0Z5bW5ia5AHUCWh9Ku/rSDVIUhfiDm17KXzk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P12pYSHM1NQRTjx6Hh9W1EKN+rBgFPVQB8XszcMp6DZSzSpG6lKdILxjgw9lqFvX5
         nrnViA1rpiAKmBU96AdM6pYXUPVvHuW2+4WbGXIHqcsfXCuCRvBsEaMcORGVqdTZLI
         jM8ZR2NWTX1wFL2gYeaMMYdBKtR6dpRkiFxvAtz8x58w8OpFBM8ShG7+qf0LayGqKy
         5U4Liaw8rC0DiWa54zDl+2Q57uXC0m5pmyqdoTm/lxE9R2EqGMMR2E7wgEZ7eIQoQE
         rInZHQg3h0k5boV3STuQA+jFjx3N77gV58MDgRtTPN65Q/tiOk97T7zstp2dyfH23u
         F3x+W4eE+8GcA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1nrzaO-00056y-FH; Fri, 20 May 2022 12:10:20 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 2/3] clk: qcom: gdsc: add support for collapse-vote registers
Date:   Fri, 20 May 2022 12:09:47 +0200
Message-Id: <20220520100948.19622-3-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220520100948.19622-1-johan+linaro@kernel.org>
References: <20220520100948.19622-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recent Qualcomm platforms have APCS collapse-vote registers that allow
for sharing GDSCs with other masters (e.g. LPASS).

Add support for using such vote registers instead of the control
register when updating the GDSC power state.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/clk/qcom/gdsc.c | 9 +++++++--
 drivers/clk/qcom/gdsc.h | 4 ++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
index c676416e685f..6f746158d28f 100644
--- a/drivers/clk/qcom/gdsc.c
+++ b/drivers/clk/qcom/gdsc.c
@@ -137,8 +137,13 @@ static int gdsc_update_collapse_bit(struct gdsc *sc, bool val)
 	u32 reg, mask;
 	int ret;
 
-	reg = sc->gdscr;
-	mask = SW_COLLAPSE_MASK;
+	if (sc->collapse_mask) {
+		reg = sc->collapse_ctrl;
+		mask = sc->collapse_mask;
+	} else {
+		reg = sc->gdscr;
+		mask = SW_COLLAPSE_MASK;
+	}
 
 	ret = regmap_update_bits(sc->regmap, reg, mask, val ? mask : 0);
 	if (ret)
diff --git a/drivers/clk/qcom/gdsc.h b/drivers/clk/qcom/gdsc.h
index ad313d7210bd..5de48c9439b2 100644
--- a/drivers/clk/qcom/gdsc.h
+++ b/drivers/clk/qcom/gdsc.h
@@ -18,6 +18,8 @@ struct reset_controller_dev;
  * @pd: generic power domain
  * @regmap: regmap for MMIO accesses
  * @gdscr: gsdc control register
+ * @collapse_ctrl: APCS collapse-vote register
+ * @collapse_mask: APCS collapse-vote mask
  * @gds_hw_ctrl: gds_hw_ctrl register
  * @cxcs: offsets of branch registers to toggle mem/periph bits in
  * @cxc_count: number of @cxcs
@@ -35,6 +37,8 @@ struct gdsc {
 	struct generic_pm_domain	*parent;
 	struct regmap			*regmap;
 	unsigned int			gdscr;
+	unsigned int			collapse_ctrl;
+	unsigned int			collapse_mask;
 	unsigned int			gds_hw_ctrl;
 	unsigned int			clamp_io_ctrl;
 	unsigned int			*cxcs;
-- 
2.35.1


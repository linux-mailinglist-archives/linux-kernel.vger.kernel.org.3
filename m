Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77BD055DC06
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345613AbiF1MXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 08:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344426AbiF1MXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 08:23:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5590213CD8;
        Tue, 28 Jun 2022 05:23:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EB3F2B81E0A;
        Tue, 28 Jun 2022 12:23:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4571AC341CF;
        Tue, 28 Jun 2022 12:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656419011;
        bh=pXV/Nifo7ZhBaapzRCp8sn27XTIo2SKqC2ty0bQ8eTo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sElN7b+rzMLOeuPBwCli5dJvKMF23ZOTVW5+i/RaN9wYbMY4V+9xhy0kA8amUU9uz
         mbepD3deIyV2kIWIlk/R46OS8ATpD0EmFrI+GFp6Tmw1Dod9HbORyYbwL8yw0p5hZd
         xLy6AsOZaxXMkxj57NsKdFQiTfRGfB37zehVfszzolfDQXykWdtCd7bc4Bd+kQkdEK
         u6VTu6xizhyGRFovL2jWpKXagRFYdlUI9/PFwUNnI9sdFtrH1JThx4q/5G6I8Extgv
         os+T5La1R3pvtIuqsSmhWXT+429rsS4O5telOamfnzM/yR/GC+yGEz7hThG+XO5hrr
         w6NYzqnKJ4HCA==
From:   Roger Quadros <rogerq@kernel.org>
To:     kishon@ti.com, vkoul@kernel.org
Cc:     vigneshr@ti.com, t-patil@ti.com, sjakhade@cadence.com,
        s-vadapalli@ti.com, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Roger Quadros <rogerq@kernel.org>
Subject: [PATCH 7/7] phy: ti: phy-j721e-wiz: set PMA_CMN_REFCLK_DIG_DIV based on reflk rate
Date:   Tue, 28 Jun 2022 15:22:55 +0300
Message-Id: <20220628122255.24265-8-rogerq@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220628122255.24265-1-rogerq@kernel.org>
References: <20220628122255.24265-1-rogerq@kernel.org>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For J7200-SR2.0 and AM64 we don't model Common refclock divider as
a clock divider as the divisor rate is fixed based on operating
reference clock frequency. We just program the recommended value
into the register. This simplifies the device tree and implementation
a lot.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/phy/ti/phy-j721e-wiz.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/phy/ti/phy-j721e-wiz.c b/drivers/phy/ti/phy-j721e-wiz.c
index cc2ab5152f07..20af142580ad 100644
--- a/drivers/phy/ti/phy-j721e-wiz.c
+++ b/drivers/phy/ti/phy-j721e-wiz.c
@@ -24,6 +24,11 @@
 #include <linux/regmap.h>
 #include <linux/reset-controller.h>
 
+#define REF_CLK_19_2MHZ         19200000
+#define REF_CLK_25MHZ           25000000
+#define REF_CLK_100MHZ          100000000
+#define REF_CLK_156_25MHZ       156250000
+
 /* SCM offsets */
 #define SERDES_SUP_CTRL		0x4400
 
@@ -1053,6 +1058,25 @@ static int wiz_clock_init(struct wiz *wiz, struct device_node *node)
 	else
 		regmap_field_write(wiz->pma_cmn_refclk_int_mode, 0x3);
 
+	switch (wiz->type) {
+	case AM64_WIZ_10G:
+	case J7200_WIZ_10G:
+		switch (rate) {
+		case REF_CLK_100MHZ:
+			regmap_field_write(wiz->div_sel_field[CMN_REFCLK_DIG_DIV], 0x2);
+			break;
+		case REF_CLK_156_25MHZ:
+			regmap_field_write(wiz->div_sel_field[CMN_REFCLK_DIG_DIV], 0x3);
+			break;
+		default:
+			regmap_field_write(wiz->div_sel_field[CMN_REFCLK_DIG_DIV], 0);
+			break;
+		}
+		break;
+	default:
+		break;
+	}
+
 	if (wiz->data->pma_cmn_refclk1_int_mode) {
 		clk = devm_clk_get(dev, "core_ref1_clk");
 		if (IS_ERR(clk)) {
-- 
2.17.1


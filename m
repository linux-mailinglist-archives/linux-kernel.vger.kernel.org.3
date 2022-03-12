Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E438B4D6F5D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 14:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbiCLN7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 08:59:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbiCLN7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 08:59:03 -0500
Received: from hutie.ust.cz (unknown [IPv6:2a03:3b40:fe:f0::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1ED26ACC;
        Sat, 12 Mar 2022 05:57:54 -0800 (PST)
From:   =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1647093470; bh=D4KdA+ZrW7aJFNAnE8O5SFW/OiSq5fNJDXeWNiLTHd4=;
        h=From:To:Cc:Subject:Date;
        b=OZD56KzfO1Wn1Zlx+CZzL3DXM+t8uwwpnG4D4BR2pRoNc+gwUYNmsMpXdlUp706jn
         MRrhXraCVBUkf/C7JuzPYb2G2RFu1UYj4ImgetJHD2yP9+7D9xAblI43f8/Xr7XBnI
         xE83Sc5ONKaBPeL8vvX0eGS6iQtxMGAl22vjgnC8=
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
Subject: [PATCH] clk: clk-apple-nco: Allow and fix module building
Date:   Sat, 12 Mar 2022 14:57:22 +0100
Message-Id: <20220312135722.20770-1-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_FAIL,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
---

This slipped through. Applies to clk-next, feel free to squash. Thanks!

 drivers/clk/Kconfig         | 2 +-
 drivers/clk/clk-apple-nco.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index af4d037e18e3..65e2f8c04f32 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -60,7 +60,7 @@ config LMK04832
 	  Low-Noise JESD204B Compliant Clock Jitter Cleaner With Dual Loop PLLs
 
 config COMMON_CLK_APPLE_NCO
-	bool "Clock driver for Apple SoC NCOs"
+	tristate "Clock driver for Apple SoC NCOs"
 	depends on ARCH_APPLE || COMPILE_TEST
 	default ARCH_APPLE
 	help
diff --git a/drivers/clk/clk-apple-nco.c b/drivers/clk/clk-apple-nco.c
index 208ee2945209..39472a51530a 100644
--- a/drivers/clk/clk-apple-nco.c
+++ b/drivers/clk/clk-apple-nco.c
@@ -318,7 +318,7 @@ static const struct of_device_id applnco_ids[] = {
 	{ .compatible = "apple,nco" },
 	{ }
 };
-MODULE_DEVICE_TABLE(of, applnco_ids)
+MODULE_DEVICE_TABLE(of, applnco_ids);
 
 static struct platform_driver applnco_driver = {
 	.driver = {
-- 
2.33.0


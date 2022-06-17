Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA9E54F570
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 12:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380787AbiFQKeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 06:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbiFQKeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 06:34:17 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235B36AA5A;
        Fri, 17 Jun 2022 03:34:15 -0700 (PDT)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id D28E5E0004;
        Fri, 17 Jun 2022 10:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1655462054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Sh3h0KKkH6ovJsX0vy6O3bBPL81E+4+ofSuniX7ztG4=;
        b=Xy6M9vpl+zl00OQvESFdbLJ0pEVP/qApo5QP44FMG3tjrWlx1CSkmTGz6DWIotYjfLxnDS
        7fXhi/FOOcY2bXoUEFCfZccATy40KEiIPwoGdT7UFb5JjOtgp1KElTvGD4MmEzWp/xhynK
        oB44dMN75FryY8HlMVAMA/sazwkSQZnEIAZddsTmFC3Z8zGSPigbxf3EIWvKXlSQYs5MTt
        s+/tLQRi5sJHevMz5zsg/ivX2vcfjwC6VUA0Kxj8hUA1uLcgmgPQrm7ST+9dGlSp9zEPeY
        zaO1uqnIIz2R8SrYnqaKbekn0Uh9Ps+WASAcuRUD3RWZw4/pS0o//5cbxN/5mw==
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
Subject: [PATCH] clk: allow building lan966x as a module
Date:   Fri, 17 Jun 2022 12:33:06 +0200
Message-Id: <20220617103306.489466-1-clement.leger@bootlin.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set the COMMON_CLK_LAN966X option as a tristate and switch from
builtin_platform_driver() to module_platform_driver() to allow building
and using this driver as a module.

Signed-off-by: Clément Léger <clement.leger@bootlin.com>
---
 drivers/clk/Kconfig       | 2 +-
 drivers/clk/clk-lan966x.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 48f8f4221e21..ac77d4b2c742 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -249,7 +249,7 @@ config COMMON_CLK_GEMINI
 	  platform, also known as SL3516 or CS3516.
 
 config COMMON_CLK_LAN966X
-	bool "Generic Clock Controller driver for LAN966X SoC"
+	tristate "Generic Clock Controller driver for LAN966X SoC"
 	depends on HAS_IOMEM
 	depends on OF
 	depends on SOC_LAN966 || COMPILE_TEST
diff --git a/drivers/clk/clk-lan966x.c b/drivers/clk/clk-lan966x.c
index d1535ac13e89..90a335ddd735 100644
--- a/drivers/clk/clk-lan966x.c
+++ b/drivers/clk/clk-lan966x.c
@@ -286,7 +286,7 @@ static struct platform_driver lan966x_clk_driver = {
 		.of_match_table = lan966x_clk_dt_ids,
 	},
 };
-builtin_platform_driver(lan966x_clk_driver);
+module_platform_driver(lan966x_clk_driver);
 
 MODULE_AUTHOR("Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>");
 MODULE_DESCRIPTION("LAN966X clock driver");
-- 
2.36.1


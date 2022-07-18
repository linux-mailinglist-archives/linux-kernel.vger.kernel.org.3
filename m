Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41075578D3A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 00:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234500AbiGRWCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 18:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233142AbiGRWCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 18:02:42 -0400
X-Greylist: delayed 471 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 18 Jul 2022 15:02:40 PDT
Received: from mail.tpi.com (mail.tpi.com [50.126.108.186])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFAF30578
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 15:02:40 -0700 (PDT)
Received: from sushi.tpi.com (sushi.tpi.com [10.0.0.212])
        by mail.tpi.com (Postfix) with ESMTPA id E451347ECA5F;
        Mon, 18 Jul 2022 14:54:47 -0700 (PDT)
From:   Dean Gehnert <deang@tpi.com>
Cc:     Dean Gehnert <deang@tpi.com>, Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: imx6: suspend: Use the size of imx6_suspend() function for fncpy()
Date:   Mon, 18 Jul 2022 14:54:26 -0700
Message-Id: <20220718215426.21501-1-deang@tpi.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the size of the imx6_suspend() function for fncpy() instead
of the hard coded size of 'MX6Q_SUSPEND_OCRAM_SIZE - sizeof(*pm_info)'.
Only need to copy the size of the imx6_suspend() function and
not extra code space beyond the function.

Cc: Russell King <linux@armlinux.org.uk>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Fixes: df595746fa69 ("ARM: imx: add suspend in ocram support for i.mx6q")
Signed-off-by: Dean Gehnert <deang@tpi.com>
---
 arch/arm/mach-imx/common.h       | 2 ++
 arch/arm/mach-imx/pm-imx6.c      | 2 +-
 arch/arm/mach-imx/suspend-imx6.S | 3 +++
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index 13f3068e9845..c73152786ead 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -96,10 +96,12 @@ int imx_cpu_kill(unsigned int cpu);
 void imx53_suspend(void __iomem *ocram_vbase);
 extern const u32 imx53_suspend_sz;
 void imx6_suspend(void __iomem *ocram_vbase);
+extern const u32 imx6_suspend_sz;
 #else
 static inline void imx53_suspend(void __iomem *ocram_vbase) {}
 static const u32 imx53_suspend_sz;
 static inline void imx6_suspend(void __iomem *ocram_vbase) {}
+static const u32 imx6_suspend_sz;
 #endif
 
 void v7_cpu_resume(void);
diff --git a/arch/arm/mach-imx/pm-imx6.c b/arch/arm/mach-imx/pm-imx6.c
index 045b9fdd342d..d467ca05b95f 100644
--- a/arch/arm/mach-imx/pm-imx6.c
+++ b/arch/arm/mach-imx/pm-imx6.c
@@ -570,7 +570,7 @@ static int __init imx6q_suspend_init(const struct imx6_pm_socdata *socdata)
 	imx6_suspend_in_ocram_fn = fncpy(
 		suspend_ocram_base + sizeof(*pm_info),
 		&imx6_suspend,
-		MX6Q_SUSPEND_OCRAM_SIZE - sizeof(*pm_info));
+		imx6_suspend_sz);
 
 	__arm_iomem_set_ro(suspend_ocram_base, MX6Q_SUSPEND_OCRAM_SIZE);
 
diff --git a/arch/arm/mach-imx/suspend-imx6.S b/arch/arm/mach-imx/suspend-imx6.S
index e06f946b75b9..ee19ac288a90 100644
--- a/arch/arm/mach-imx/suspend-imx6.S
+++ b/arch/arm/mach-imx/suspend-imx6.S
@@ -328,3 +328,6 @@ resume:
 
 	ret	lr
 ENDPROC(imx6_suspend)
+
+ENTRY(imx6_suspend_sz)
+        .word   . - imx6_suspend
-- 
2.17.1


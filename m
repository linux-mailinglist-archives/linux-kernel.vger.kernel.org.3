Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 742744C3E8D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 07:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237926AbiBYGpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 01:45:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237924AbiBYGpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 01:45:40 -0500
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D05E2763F1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 22:45:08 -0800 (PST)
Received: from droid01-cd.amlogic.com (10.98.11.200) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2176.14; Fri, 25 Feb 2022
 14:45:05 +0800
From:   Shunzhou Jiang <shunzhou.jiang@amlogic.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <narmstrong@baylibre.com>, <khilman@baylibre.com>,
        <jbrunet@baylibre.com>, <martin.blumenstingl@googlemail.com>,
        <jianxin.pan@amlogic.com>, <shunzhou.jiang@amlogic.com>
Subject: [PATCH V4 2/2] soc: s4: Add support for power domains controller
Date:   Fri, 25 Feb 2022 14:44:55 +0800
Message-ID: <20220225064455.1369197-3-shunzhou.jiang@amlogic.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220225064455.1369197-1-shunzhou.jiang@amlogic.com>
References: <20220225064455.1369197-1-shunzhou.jiang@amlogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.98.11.200]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support s4 Power controller. In s4, power control
registers are in secure domain, and should be accessed by smc.

Signed-off-by: Shunzhou Jiang <shunzhou.jiang@amlogic.com>
---
 drivers/soc/amlogic/meson-secure-pwrc.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/soc/amlogic/meson-secure-pwrc.c b/drivers/soc/amlogic/meson-secure-pwrc.c
index 59bd195fa9c9..a10a417a87db 100644
--- a/drivers/soc/amlogic/meson-secure-pwrc.c
+++ b/drivers/soc/amlogic/meson-secure-pwrc.c
@@ -11,6 +11,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <dt-bindings/power/meson-a1-power.h>
+#include <dt-bindings/power/meson-s4-power.h>
 #include <linux/arm-smccc.h>
 #include <linux/firmware/meson/meson_sm.h>
 #include <linux/module.h>
@@ -119,6 +120,18 @@ static struct meson_secure_pwrc_domain_desc a1_pwrc_domains[] = {
 	SEC_PD(RSA,	0),
 };
 
+static struct meson_secure_pwrc_domain_desc s4_pwrc_domains[] = {
+	SEC_PD(S4_DOS_HEVC,	0),
+	SEC_PD(S4_DOS_VDEC,	0),
+	SEC_PD(S4_VPU_HDMI,	0),
+	SEC_PD(S4_USB_COMB,	0),
+	SEC_PD(S4_GE2D,		0),
+	/* ETH is for ethernet online wakeup, and should be always on */
+	SEC_PD(S4_ETH,		GENPD_FLAG_ALWAYS_ON),
+	SEC_PD(S4_DEMOD,	0),
+	SEC_PD(S4_AUDIO,	0),
+};
+
 static int meson_secure_pwrc_probe(struct platform_device *pdev)
 {
 	int i;
@@ -187,11 +200,20 @@ static struct meson_secure_pwrc_domain_data meson_secure_a1_pwrc_data = {
 	.count = ARRAY_SIZE(a1_pwrc_domains),
 };
 
+static struct meson_secure_pwrc_domain_data meson_secure_s4_pwrc_data = {
+	.domains = s4_pwrc_domains,
+	.count = ARRAY_SIZE(s4_pwrc_domains),
+};
+
 static const struct of_device_id meson_secure_pwrc_match_table[] = {
 	{
 		.compatible = "amlogic,meson-a1-pwrc",
 		.data = &meson_secure_a1_pwrc_data,
 	},
+	{
+		.compatible = "amlogic,meson-s4-pwrc",
+		.data = &meson_secure_s4_pwrc_data,
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, meson_secure_pwrc_match_table);
-- 
2.34.1


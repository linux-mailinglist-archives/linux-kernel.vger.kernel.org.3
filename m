Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 921B949C37D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 07:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235025AbiAZGKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 01:10:35 -0500
Received: from mail-sh.amlogic.com ([58.32.228.43]:63091 "EHLO
        mail-sh.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234959AbiAZGKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 01:10:34 -0500
Received: from droid01-cd.amlogic.com (10.98.11.200) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2176.14; Wed, 26 Jan 2022
 14:10:31 +0800
From:   Shunzhou Jiang <shunzhou.jiang@amlogic.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <narmstrong@baylibre.com>, <khilman@baylibre.com>,
        <jbrunet@baylibre.com>, <martin.blumenstingl@googlemail.com>,
        <jianxin.pan@amlogic.com>, <shunzhou.jiang@amlogic.com>
Subject: [PATCH 2/2] soc: s4: Add support for power domains controller
Date:   Wed, 26 Jan 2022 14:10:18 +0800
Message-ID: <20220126061018.705338-3-shunzhou.jiang@amlogic.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220126061018.705338-1-shunzhou.jiang@amlogic.com>
References: <20220126061018.705338-1-shunzhou.jiang@amlogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.98.11.200]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support s4 Power controller. In s4, power control
registers are in secure domain, and should be accessed by smc.

Signed-off-by: Shunzhou Jiang <shunzhou.jiang@amlogic.com>
---
 drivers/soc/amlogic/meson-secure-pwrc.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/soc/amlogic/meson-secure-pwrc.c b/drivers/soc/amlogic/meson-secure-pwrc.c
index 59bd195fa9c9..8fee01aabab6 100644
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
@@ -119,6 +120,17 @@ static struct meson_secure_pwrc_domain_desc a1_pwrc_domains[] = {
 	SEC_PD(RSA,	0),
 };
 
+static struct meson_secure_pwrc_domain_desc s4_pwrc_domains[] = {
+	SEC_PD(S4_DOS_HEVC,	0),
+	SEC_PD(S4_DOS_VDEC,	0),
+	SEC_PD(S4_VPU_HDMI,	GENPD_FLAG_ALWAYS_ON),
+	SEC_PD(S4_USB_COMB,	GENPD_FLAG_ALWAYS_ON),
+	SEC_PD(S4_GE2D,		0),
+	SEC_PD(S4_ETH,		GENPD_FLAG_ALWAYS_ON),
+	SEC_PD(S4_DEMOD,	0),
+	SEC_PD(S4_AUDIO,	0),
+};
+
 static int meson_secure_pwrc_probe(struct platform_device *pdev)
 {
 	int i;
@@ -187,11 +199,20 @@ static struct meson_secure_pwrc_domain_data meson_secure_a1_pwrc_data = {
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


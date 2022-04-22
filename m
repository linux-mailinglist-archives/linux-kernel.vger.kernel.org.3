Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8BE750BC9C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 18:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354434AbiDVQLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 12:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiDVQLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 12:11:20 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2105.outbound.protection.outlook.com [40.92.19.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD665E161;
        Fri, 22 Apr 2022 09:08:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BOLfevKZgghM5cDnQJ50seQLwRjPfY3lWzxgyWXjKqeRALHSZX/z8mNRDwPsh0kqLtyYK2cWeMNG5yAnjmV4xFHemac0dEKDsZZRs2YL2FI3JM/w4jQw6xGD2s4tDYuubOU6Rge4iXxn8nei1/4MJ8HPcEVVjAQzM1gdWHefB+gMutoctLFVx4i44Zzgsrb3ZRwxNwYZ+/u8YvtyFfrYiD3ir+0NoiAB+MCRhgc2RkOvKNYJrEafPIRPHHWl1FB+uUJBRMe3lmUOUnYaCXSVGN2mTydRhtHjiXbx6jDGNldY6uqp8J4X+9BiOF5IzqlnyMfH+OqFfUEfopBy+v+vZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lT6NmnNPgJP0jHc/iRnZE4KM7wQ/M4jaYXih4ftQwe8=;
 b=YQA9kT83/F+WlDpqybfKXJYAA8SSiKXjc2HV5kUcc/0vc4Q3q0Ay30rJVoRTlMmuX/RD93/JPgUsUeZvcg5OY9ITSRjY63rRKmy1PbRhCCb7H5PZIgPf2SZlqGZvLA3QrobMoUnEN9R3TDjdazEysa/RrPDPFqzNWlTjhltKuW5602loMcLtWe9Li3tHN1ZwNOCDvVCfz9UaHEub+fkMxHzkLcZl9okQ8cjp73EwPID5OiS9CgvyBkXDPqhWBjdv+wzS3P+xOkELb7EvyopHKZzhQBli9ISepp8SCSe88ursgFKxn+CW8ICYlCnS9rfpiPE+OF3ooau96jR4dTJAlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lT6NmnNPgJP0jHc/iRnZE4KM7wQ/M4jaYXih4ftQwe8=;
 b=iNrA1v5fBeuRjXotxSo1Dw0m+ophcGzmKTPwYaLLx7hGhHcLqRzdUol94N3i5lQ7x+iZ5q/eVFEyLgggtcHlvtBRJqpar3Oc+dvOuSkUuCwGVLIsxaG6r5KCYZMtOKRNLH03vOZeUG/go+Tgj0Id7kwVGYNU5IgxwoPKiMT5p1NAcFC716dkId4942lQSUZlxeipfxLvkJtBUhNWkJMk7+RIG5o0wwRczu405mTUc8KkWoa62nrmcMLKsYZEXTf5ODxktS7ojLDXofXCHoGzKQKCO09oi511MUNY8gX5U4JRoS/2ekPeWH05hA4jmWqduzMl4OT5Mk0RgVmAAY1h1g==
Received: from BYAPR20MB2472.namprd20.prod.outlook.com (2603:10b6:a03:155::16)
 by CY4PR20MB1413.namprd20.prod.outlook.com (2603:10b6:903:15c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 22 Apr
 2022 16:08:25 +0000
Received: from BYAPR20MB2472.namprd20.prod.outlook.com
 ([fe80::3480:160a:eb92:d6e3]) by BYAPR20MB2472.namprd20.prod.outlook.com
 ([fe80::3480:160a:eb92:d6e3%6]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 16:08:25 +0000
From:   icenowy@outlook.com
To:     Hans de Goede <hdegoede@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, Icenowy Zheng <icenowy@sipeed.com>
Subject: [PATCH 2/2] Input: sun4i-lradc-keys - add support for R329 LRADC
Date:   Sat, 23 Apr 2022 00:07:44 +0800
Message-ID: <BYAPR20MB2472CFFE1C453824BFF49219BCF79@BYAPR20MB2472.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422160744.1074052-1-icenowy@outlook.com>
References: <20220422160744.1074052-1-icenowy@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [siOOfMH78WenmyrJqCZOtJs+xYBa7IvQ]
X-ClientProxiedBy: HK2PR02CA0218.apcprd02.prod.outlook.com
 (2603:1096:201:20::30) To BYAPR20MB2472.namprd20.prod.outlook.com
 (2603:10b6:a03:155::16)
X-Microsoft-Original-Message-ID: <20220422160744.1074052-2-icenowy@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd0147f2-27f5-43fd-502f-08da247a5485
X-MS-TrafficTypeDiagnostic: CY4PR20MB1413:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZYdmVhZqqgyiWC1zEpiT7zHTWIsKqXuLW5m/f5WuaflQ6wl1FfwDgsOjMrehZSp9sxi6ihXBbpw2ntcb8HC1saCB6j8BvunxMxcXaXMqIX8W2bQsAB7pJ2IAkKj+0qd+xH2eUtJU4HJR6+9xagS3UakfYJx0kp6KsBFn/dkmnmqmNMH0eJsF7e6RhVOdx1SFH3TaRaGXPHYVN/kTS8F/B18XTPAwqJ/SQgrvX5ByS5WO6i1YdK50GD3qyk0FeGNqN2V9m8gN++cMKElEnN+eNspIi1Yjd102SE9kRSCRp8f0uIBmDSX0RUDbv8S5Tze1YkGy6SwXmwWRh/OVQI4J6Aug77vbRUM6rsWiPf1lvquJm/2AwhYItP6WB1u3WRWl37ZbYOePFPBVosYYMAgIRpPLcB/s3+Gj05mSaJAZmUyd69vY8X6PeF4AeIyKEvdGZi2ARra+7aVhosl96a3THVyXaZ9K1Uj8x3FU72fICab5XzFVpRidVsmL5ZE++fVZpEZIfc8Kg8IZMn9+powlQm6EscPasOgUp23KpAHgnKkAer3ylofaBvzhqe2e6LYDROEik6iUxeqnOGIXBHy+fg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yq8Gv4tOtACTyRP/MhApfezpsvAk+RsueTJtt5IK2+8SQla4vDPa3IJBYFll?=
 =?us-ascii?Q?UtKovgW3Ki9yRVz++Lz6IBls/2c81NVZ0WphnpfgR1NPAVeFxjfSheJ/bKjV?=
 =?us-ascii?Q?jiDqCGdlpO7mSig46nGIPr21MFZ8Trp0Yd2r5AP4AQT6rdX7ioACQzxdjg9r?=
 =?us-ascii?Q?lavYspI2KhRhuawPOfPjgeTLsI9py0QuJ45J4Zvb4aRXpv0pgWYbL6xQvnLt?=
 =?us-ascii?Q?PuKs3Ao+MUGI2Z3IwOui1/xfnT+6/EymwtdLHmO9V6hj0fDvF9GAux26KA5q?=
 =?us-ascii?Q?VDVDPGPbYuqSVhgfL07Mf0lCVcht/7QBCUChEUcS5ptftrYLv3l8Vqj5nJci?=
 =?us-ascii?Q?DvV3BgtK+LSLVP32A7/zf2eb/PhusUHQpp4bKaDVVviU5xzovoNnfkS4TmZz?=
 =?us-ascii?Q?Xt1KxP0M1Yyn016KsSxRFZvxZ1dacvfO3lgc0MhxsbCQWOFR1QRqSDQJwp38?=
 =?us-ascii?Q?r/GqFAgE7YzhxgvIIXcemk+Df5TWljhItbAk2Vb88m0z40IE9FOLNwPfQPil?=
 =?us-ascii?Q?fDtAY+LgvoteOtkdR2wA1G7CENs0N2K2gvTt2leib/CUdy4xDYqKaImt7OST?=
 =?us-ascii?Q?coyvjG04GD5eQQvXWin8S6Rpc0fpBoyLCFUSsz6jUEwRbVEv+LJUuSfD7hhW?=
 =?us-ascii?Q?wyL9OqXhqu9A5Cf2dYGgE7pPylaKwPaYgJiNOoe+3wkS0PnCY+20Jd7eYEKC?=
 =?us-ascii?Q?KOZHyoQRFb81Fa/mI2oVlLmPC3pPVzwyZLoJ9tbcMGu4K8Ht4w5l8bE1z4nj?=
 =?us-ascii?Q?MDlsrLduF2joxMs1G8nHXO3dKAZG+NnchiMsAa9eEEMxbEDdD4otrwr/ymrA?=
 =?us-ascii?Q?wUtbBPnV1ji7buvcSWpVgn9j0zY5p0cm8E8p1ngrF5j4h8edBY0fxLo6CMTc?=
 =?us-ascii?Q?UV2tkyhpT23PZbAHtlbzi0VSYyrdZF1Y4v6QJa7qWNYew58Pbq8qNt6R7a2m?=
 =?us-ascii?Q?tJBO0BXDhtZ4kzlx3oSxWjBY61r9idhutpnciKOwH8FpRolU1r5lDV89falg?=
 =?us-ascii?Q?Tpl+0JvBIcJqm91fnndImI9DRFFebksIRA/nI4BqvMLT3MVg8obtdFk+ZBzq?=
 =?us-ascii?Q?R6MfxoVAUxpgdmweKi8lqsHNDCyNCIxgbwev3gqz8Cxk0TxZKnodvrjNZVVn?=
 =?us-ascii?Q?i4doYljkWwhfFclhCJmbDeRGxbAM3/tZloYZKhjM8ZAWWNNCzwHMeS+2Q1G3?=
 =?us-ascii?Q?lPcf/IgxEcSoljt3oZF2a4rYdFy4qknhQlAa25J/Ef1KoigdUjMguKOUfdUD?=
 =?us-ascii?Q?2GhYs2EIAN6pi8ZphzW3XFjbTO5LZekyvbGpRA6xMtClD9L0Zrx4Wpn+6U6Q?=
 =?us-ascii?Q?0naqBPyxNPFJAJylXC/2sy6QfNeugKYjOc0DPlx4Xg5abb2cH+EDJJkgCzWo?=
 =?us-ascii?Q?rBP1K0KYv20Cv9gX8/iuKZLAoXOohakOeTZhzuGRvQRs9JfIXNxoIPLaIyUx?=
 =?us-ascii?Q?8WZLYZEXOf8=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd0147f2-27f5-43fd-502f-08da247a5485
X-MS-Exchange-CrossTenant-AuthSource: BYAPR20MB2472.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 16:08:25.4135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR20MB1413
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Icenowy Zheng <icenowy@sipeed.com>

Allwinner R329 has similar LRADC with previous Allwinner SoCs, with a
reference voltage of 3/4 AVCC. However, compared with previous SoCs, it
has bus clock and reset for LRADC.

Add support for it.

Signed-off-by: Icenowy Zheng <icenowy@sipeed.com>
---
 drivers/input/keyboard/sun4i-lradc-keys.c | 39 +++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/input/keyboard/sun4i-lradc-keys.c b/drivers/input/keyboard/sun4i-lradc-keys.c
index 4a796bed48ac..29365a0646dc 100644
--- a/drivers/input/keyboard/sun4i-lradc-keys.c
+++ b/drivers/input/keyboard/sun4i-lradc-keys.c
@@ -14,6 +14,7 @@
  * there are no boards known to use channel 1.
  */
 
+#include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/input.h>
@@ -23,6 +24,7 @@
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
+#include <linux/reset.h>
 #include <linux/slab.h>
 
 #define LRADC_CTRL		0x00
@@ -58,10 +60,12 @@
 /* struct lradc_variant - Describe sun4i-a10-lradc-keys hardware variant
  * @divisor_numerator:		The numerator of lradc Vref internally divisor
  * @divisor_denominator:	The denominator of lradc Vref internally divisor
+ * @has_bus_gate_reset:		Whether the LRADC hardware has bus gate/reset
  */
 struct lradc_variant {
 	u8 divisor_numerator;
 	u8 divisor_denominator;
+	bool has_bus_gate_reset;
 };
 
 static const struct lradc_variant lradc_variant_a10 = {
@@ -74,6 +78,12 @@ static const struct lradc_variant r_lradc_variant_a83t = {
 	.divisor_denominator = 4
 };
 
+static const struct lradc_variant lradc_variant_r329 = {
+	.divisor_numerator = 3,
+	.divisor_denominator = 4,
+	.has_bus_gate_reset = true,
+};
+
 struct sun4i_lradc_keymap {
 	u32 voltage;
 	u32 keycode;
@@ -84,6 +94,8 @@ struct sun4i_lradc_data {
 	struct input_dev *input;
 	void __iomem *base;
 	struct regulator *vref_supply;
+	struct clk *bus_clk;
+	struct reset_control *bus_rst;
 	struct sun4i_lradc_keymap *chan0_map;
 	const struct lradc_variant *variant;
 	u32 chan0_map_count;
@@ -140,6 +152,16 @@ static int sun4i_lradc_open(struct input_dev *dev)
 	if (error)
 		return error;
 
+	if (lradc->variant->has_bus_gate_reset) {
+		error = reset_control_deassert(lradc->bus_rst);
+		if (error)
+			return error;
+
+		error = clk_prepare_enable(lradc->bus_clk);
+		if (error)
+			return error;
+	}
+
 	lradc->vref = regulator_get_voltage(lradc->vref_supply) *
 		      lradc->variant->divisor_numerator /
 		      lradc->variant->divisor_denominator;
@@ -164,6 +186,11 @@ static void sun4i_lradc_close(struct input_dev *dev)
 		SAMPLE_RATE(2), lradc->base + LRADC_CTRL);
 	writel(0, lradc->base + LRADC_INTC);
 
+	if (lradc->variant->has_bus_gate_reset) {
+		clk_disable_unprepare(lradc->bus_clk);
+		reset_control_assert(lradc->bus_rst);
+	}
+
 	regulator_disable(lradc->vref_supply);
 }
 
@@ -272,6 +299,16 @@ static int sun4i_lradc_probe(struct platform_device *pdev)
 	if (IS_ERR(lradc->base))
 		return PTR_ERR(lradc->base);
 
+	if (lradc->variant->has_bus_gate_reset) {
+		lradc->bus_clk = devm_clk_get(dev, NULL);
+		if (IS_ERR(lradc->bus_clk))
+			return PTR_ERR(lradc->bus_clk);
+
+		lradc->bus_rst = devm_reset_control_get(dev, NULL);
+		if (IS_ERR(lradc->bus_rst))
+			return PTR_ERR(lradc->bus_rst);
+	}
+
 	error = devm_request_irq(dev, platform_get_irq(pdev, 0),
 				 sun4i_lradc_irq, 0,
 				 "sun4i-a10-lradc-keys", lradc);
@@ -290,6 +327,8 @@ static const struct of_device_id sun4i_lradc_of_match[] = {
 		.data = &lradc_variant_a10 },
 	{ .compatible = "allwinner,sun8i-a83t-r-lradc",
 		.data = &r_lradc_variant_a83t },
+	{ .compatible = "allwinner,sun50i-r329-lradc",
+		.data = &lradc_variant_r329 },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, sun4i_lradc_of_match);
-- 
2.35.1


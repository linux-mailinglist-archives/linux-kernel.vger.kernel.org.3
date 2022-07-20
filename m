Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A836757B39C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 11:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237587AbiGTJP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 05:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236865AbiGTJPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 05:15:50 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2070.outbound.protection.outlook.com [40.107.20.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558C32A73A;
        Wed, 20 Jul 2022 02:15:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PG7ivB2Z/HAUgyaTgrEA1A0TOn5QsHDVz/AakGso/SjUvxsA/H4nr91zNo6mKZ4m/NsXZHAySt/plD+VbNTEqoKGpy1VBz4uUo8fJKcKLsArvA2oyHyKcu17vo1pIySyacGQzk1C1kPbjZqhjPZ2m6zDBVIzRIw5mMzSeodP/vhfGlm55UXENBrptoHVnLqPjGS10Hkabk+enerjQEIIFj+te3ORGgmMC3sIzg/ZcdR5A8ZjZizVKYhQ8EK0fLdCVL4LMypwMSmh9mqALaTfCt5c+hsAhBuYuGC9GE0HmNFgNP3LAGLvpW/iXowiq1uLJb4dJ9hn59IDqd9GcXf75g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3KQrkCJyMAeEH+ynLgaEIl0E7qyivNBW6aAam3nF9Fc=;
 b=ehlGxTUZNM3wDZu2G2V2dnZhGl2GfEkZVOL5svnZh3EaX7jHjgQyqBJ0Amkn5e++c+jY34aw4PySnlkqkLbbc3bDuN2tb635e3AAW6DU0yMlBcEbUp38qd1dy11Sat75Zpq4TAPgZtFTzd3T225vSZPQ0X+r4K7vp+l7NJ10yxtEv6r1LT6o93T8vcrGkNE/ywthxVLX3HyQ5kK77spMbwWUc4CW36IefKymtm374I0gD2L31u2aQRCY4LUFi3r5V5mqAlVlSD45DAwbKx1uVD17SWAsqo2FI5jVqQnBCz7HVI9EsrIxRZJ+lt5+nREjylsC1ooQx/1JvlQhpFk6Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3KQrkCJyMAeEH+ynLgaEIl0E7qyivNBW6aAam3nF9Fc=;
 b=e7f8ZmrJ0rXz6ioT6p8mQLzkfprgzYEqBIF5qyz59qr24yXXi3Xm2OdK9oMVJ6pUR0HDIyg6qxdcjlIhvzK+3V924wR82Vx7TWUSqcy4dwZnqZE4Vm4hpKZimJ2/bveFkeyQBfKjIELAoj1/czsgFXXmJ90UJLLBMr53rq1FfSU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from AM4PR0802MB2131.eurprd08.prod.outlook.com
 (2603:10a6:200:5c::22) by VI1PR08MB3934.eurprd08.prod.outlook.com
 (2603:10a6:803:df::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Wed, 20 Jul
 2022 09:15:46 +0000
Received: from AM4PR0802MB2131.eurprd08.prod.outlook.com
 ([fe80::dcaa:905c:ff8:1f5b]) by AM4PR0802MB2131.eurprd08.prod.outlook.com
 ([fe80::dcaa:905c:ff8:1f5b%9]) with mapi id 15.20.5458.018; Wed, 20 Jul 2022
 09:15:46 +0000
From:   Michael Riesch <michael.riesch@wolfvision.net>
To:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Liang Chen <cl@rock-chips.com>
Subject: [PATCH 2/3] phy: rockchip: add support for the rk356x variant to rockchip-inno-csidphy
Date:   Wed, 20 Jul 2022 11:15:26 +0200
Message-Id: <20220720091527.1270365-3-michael.riesch@wolfvision.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220720091527.1270365-1-michael.riesch@wolfvision.net>
References: <20220720091527.1270365-1-michael.riesch@wolfvision.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0129.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::8) To AM4PR0802MB2131.eurprd08.prod.outlook.com
 (2603:10a6:200:5c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c72e7a37-670f-4590-608b-08da6a306e19
X-MS-TrafficTypeDiagnostic: VI1PR08MB3934:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1G5qgWNC//Zw913iJC4vWMydBc3xWrIGeQM7SmsA+xUOz6ufWPsD9mSwcV5Zh+Ca3l/eflP/HSDLtXI7s9pjOubIBZYGPDmF+9mWtc9Nm4b9sDLkKIgGgGvQMDWKaKKHTOk/ZOxQtRDo96dWh2cMOMpYaFrQHu7o6S2CeOcO0nHpjFrj8uc9iq27Xvquh13ShOmkxhtGuKpoV7h6Vn4qz3GP3wAgJLEbShgVFb+kzbKTZc99X1z5evkMRd3BfymysY7PiQgrMrsvPg9sVMR6ThSB975uu0quSteQt5yxMWTPJRGEAPqH3GRyfuKw012uGb+mNNegU52XA6snpfTWBmBMVKJzXSgJVCF4MIHRs3AgSnaxxEWHpXJ19pUD8k98BvitdKn183/YhUqWHZh+2eqXJeqVQF8/TXl3Jn78AN2Z0V4/ci1xJpo7TOmVYr8qDmBjRnvS6mhtPIYy2Iep84TJsqpS+kxel1oLaDfPFUuuWVFFLxzXoKOrJTAo7wQcoggw1dEN9MPAmJbL4z6AvHqcDkgyYucmE99hZW2/nDfyitHBxeUjaFnUvMryfySfI2zqNtvzHtL5AmlG3tfi/dM7k2myINpWyr8fgQ+CRpkwp7HtxUHh7dZXRnDwRE4t1qQdKdAh6+oWu5/xdxZV5UtKc+wisq+8vEShrbiRo1Ta83Y87U0G9pAJ+k2Uc37OoLBrt19SDSOtqf5pTHoozDWqckHTl9aewKjDrq/YVp/VZ7Erg149TLBPZt9HDQzC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0802MB2131.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39840400004)(396003)(376002)(366004)(136003)(38100700002)(52116002)(41300700001)(6506007)(6666004)(8936002)(7416002)(5660300002)(6486002)(2616005)(478600001)(1076003)(66476007)(8676002)(66946007)(66556008)(6512007)(54906003)(316002)(4326008)(2906002)(186003)(44832011)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+hU/suxb/OrI6V18m1Ag5LVUpw9AfXw5mX1bVCCwaCacvmL+0op1TF17ueXr?=
 =?us-ascii?Q?0d8YyDyFYHttDooDXbEVabLsAbu1CRA/8rv9Em/uSBoT4lMG8Hd5sj0ku3sm?=
 =?us-ascii?Q?7lmyHh9ilgK9aaIq9H0AJsiLiPJ6vj97Knb3zcl3s1hNKuwed+LSRax6x+0T?=
 =?us-ascii?Q?zyI4sneV4sMUftgPcBpACaFwShx8wwS5XEdUz1jjMGszuIk8vSh+dNKuTyrg?=
 =?us-ascii?Q?SqhhUylz6BAC1qhVmDfLxz9e+KO0GyLoHrIOjonHtzJ/gvja3964xfuWcr+e?=
 =?us-ascii?Q?5XkTTTX9FjSLHb6795u7A/pxwynKCrOwA60PKM4KVGNcEEfwsttyHxpH3fwL?=
 =?us-ascii?Q?iirNQejtEq3E3NJ2OxA0OcWgSMJP98oM38PVWBfp4qpnPBH3gYHj53fGcQSL?=
 =?us-ascii?Q?J9nb8KPEnlWZzctxJb92MZS1KEvxokO1OydhBpg1hoNlNxw65MU7HpCwInTj?=
 =?us-ascii?Q?4wJgvdTWDMN/p9wyppVqNpsMq1dzpzZGtOeJ4qdsXdx+0K+p7bRK+53S+YqK?=
 =?us-ascii?Q?huWRNYNOUbZ69PagyK79nhcuRRY76Pwp2VCJdrIBUDVnGBColz5Veltou04l?=
 =?us-ascii?Q?EfqVFyvyZ5j1jAK63Oa9Io5SfjJCWuDB8k2YHZH+8e52cGsjCZ85e44aXNA7?=
 =?us-ascii?Q?v4SeR+z+EWz4FVsD8sPu8sn2hX34J4UiF4odyG92+UQSON2tafUzCa8d9wkR?=
 =?us-ascii?Q?J70hoxOATy9hbJK8hOAaInctJu8THY3jKkFS1OK3cgzxhF3XumYQjswhbwNU?=
 =?us-ascii?Q?d8LgG9ZzjYmPQkCM1lVoAdHwV/ehxmAvn+87U8IXtr7sTwR13ZD+chmFhSyG?=
 =?us-ascii?Q?MErACKFze3EgLEXf+TD039sejIef1a0ejltE+vAUeEzNwHFX4w3BYA3yqSzf?=
 =?us-ascii?Q?9IvbGH18v1yuCzclboN9MgQ2hm2y/JsjLJ/P2tEsUHfCadEHbhwfMAq7himg?=
 =?us-ascii?Q?DbrhA0yAx/3dxdD5TlVQM56sZSjlRutJcMMY/ea16+rr6MyjbmyyJy6pTKlO?=
 =?us-ascii?Q?9TnX/2/2SLCOxkIc+bxD+G2eIx9s3aFEYM/wewFUZv9zkN4tbgm+dKBgUCMu?=
 =?us-ascii?Q?BCtCCJK71cMGYCBy4tD7YNrupAvcfLrGhgvJuH+0WOEW6Omc/7lsc32L/gdn?=
 =?us-ascii?Q?ifHeSdbMkZM7XASEqDprSO96tXmmwrj1aOianxgAI60AvGFnTAq1AhFCTnSK?=
 =?us-ascii?Q?4l/numj/U+YevsDrIBrH/v2Wds4jjpJe3ZsAqrRN/E8dhap+oW5Ri3bORexr?=
 =?us-ascii?Q?mG/TffMC+YIx8xf6dhUi2AUKpCMlgR2mk1EVTRfWjL+yZrR0tEgJG2/gqPDY?=
 =?us-ascii?Q?xZo3hQmfZiy0RCt9ts6Ak2ad+I6T9NTCFlO/+9s3wHesudACbqW4KLOeA4t3?=
 =?us-ascii?Q?MaSwUg93Z+a9g6si3sPF97/i+MGU147+wMkQM2qTeKxu1GKjnedtUgLTpS9g?=
 =?us-ascii?Q?V5GCqnhYtwWmIYClWtAarwvxURDiT4GgOcbGkfyTkn8/G/tpXRcbxnyET0Gb?=
 =?us-ascii?Q?POxP9BOrckzGGJzURgRb+hpMZz8yXog48tDGyNn+S4X3klyaPOnYgB3oxKLm?=
 =?us-ascii?Q?IAqHml/dMXW6JkoZov0eeJdx+3i/twicmmzIwdXjsLghv95LLKqDV3BiVRdr?=
 =?us-ascii?Q?iMuAh8zYuzxinRiqZWgcX9fxi8+z8ZR0g3MG9EHCR59rOFjewnc96S6fEozu?=
 =?us-ascii?Q?lrjAGg=3D=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: c72e7a37-670f-4590-608b-08da6a306e19
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0802MB2131.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2022 09:15:46.5259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oB0Fg1zjZeRASUGUhMLeIhAq0UU5JLKv+CQUPdnHjXtOExPs/xuPiBy9hPvVHlcnPucmRNHO28dQu4MwDhtCz+Bk5Gonc2G08wscTk7zJIY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3934
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for variant found in Rockchip RK356x SoCs. Note that
only the basic operating mode is supported, in which all four CSI lines
are controlled by the Rockchip ISP.

Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
---
 .../phy/rockchip/phy-rockchip-inno-csidphy.c  | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-csidphy.c b/drivers/phy/rockchip/phy-rockchip-inno-csidphy.c
index ca13a604ab4f..75f948bdea6a 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-csidphy.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-csidphy.c
@@ -27,6 +27,9 @@
 
 #define RK3368_GRF_SOC_CON6_OFFSET	0x0418
 
+#define RK3568_GRF_VI_CON0		0x0340
+#define RK3568_GRF_VI_CON1		0x0344
+
 /* PHY */
 #define CSIDPHY_CTRL_LANE_ENABLE		0x00
 #define CSIDPHY_CTRL_LANE_ENABLE_CK		BIT(6)
@@ -58,9 +61,11 @@
 #define RK1808_CSIDPHY_CLK_WR_THS_SETTLE	0x160
 #define RK3326_CSIDPHY_CLK_WR_THS_SETTLE	0x100
 #define RK3368_CSIDPHY_CLK_WR_THS_SETTLE	0x100
+#define RK3568_CSIDPHY_CLK_WR_THS_SETTLE	0x160
 
 /* Calibration reception enable */
 #define RK1808_CSIDPHY_CLK_CALIB_EN		0x168
+#define RK3568_CSIDPHY_CLK_CALIB_EN		0x168
 
 /*
  * The higher 16-bit of this register is used for write protection
@@ -103,6 +108,12 @@ static const struct dphy_reg rk3368_grf_dphy_regs[] = {
 	[GRF_DPHY_CSIPHY_FORCERXMODE] = PHY_REG(RK3368_GRF_SOC_CON6_OFFSET, 4, 8),
 };
 
+static const struct dphy_reg rk3568_grf_dphy_regs[] = {
+	[GRF_DPHY_CSIPHY_FORCERXMODE] = PHY_REG(RK3568_GRF_VI_CON0, 4, 0),
+	[GRF_DPHY_CSIPHY_DATALANE_EN] = PHY_REG(RK3568_GRF_VI_CON0, 4, 4),
+	[GRF_DPHY_CSIPHY_CLKLANE_EN] = PHY_REG(RK3568_GRF_VI_CON0, 1, 8),
+};
+
 struct hsfreq_range {
 	u32 range_h;
 	u8 cfg_bit;
@@ -352,6 +363,15 @@ static const struct dphy_drv_data rk3368_mipidphy_drv_data = {
 	.grf_regs = rk3368_grf_dphy_regs,
 };
 
+static const struct dphy_drv_data rk3568_mipidphy_drv_data = {
+	.pwrctl_offset = -1,
+	.ths_settle_offset = RK3568_CSIDPHY_CLK_WR_THS_SETTLE,
+	.calib_offset = RK3568_CSIDPHY_CLK_CALIB_EN,
+	.hsfreq_ranges = rk1808_mipidphy_hsfreq_ranges,
+	.num_hsfreq_ranges = ARRAY_SIZE(rk1808_mipidphy_hsfreq_ranges),
+	.grf_regs = rk3568_grf_dphy_regs,
+};
+
 static const struct of_device_id rockchip_inno_csidphy_match_id[] = {
 	{
 		.compatible = "rockchip,px30-csi-dphy",
@@ -369,6 +389,10 @@ static const struct of_device_id rockchip_inno_csidphy_match_id[] = {
 		.compatible = "rockchip,rk3368-csi-dphy",
 		.data = &rk3368_mipidphy_drv_data,
 	},
+	{
+		.compatible = "rockchip,rk3568-csi-dphy",
+		.data = &rk3568_mipidphy_drv_data,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, rockchip_inno_csidphy_match_id);
-- 
2.30.2


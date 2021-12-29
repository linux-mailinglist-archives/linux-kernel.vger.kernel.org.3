Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC526480E44
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 01:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238028AbhL2Aht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 19:37:49 -0500
Received: from mail-mw2nam10on2118.outbound.protection.outlook.com ([40.107.94.118]:8991
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234136AbhL2Ahq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 19:37:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bxnHKRWhe8f3jtORyvNGc0kTAiHA1HIIh/iwbxSKM8Lqes+EKXXZ6zhI2ujpfnc5rZI4Z2fLryh7DxljN7MsISYibFS4dVYPZxBpThkduSNNXDiW6EKLuBgR/8M2QmN18RYzkI2tN2bZFOIMmRIDQuH61TSItUz+5qrMYaI0Kj0JFUM3HeGeJoPI41bebFLiJ6woWSQnCOGKlG2oAKtUFAeVIZhWtIkMRtXPsI23FZG9tH+WzdxTxg8PUGlWU7s7rMkpHtFCAoetHr6REtHAO4YmVX8DwNKf0cLwaCSTH13MRSYiU0a/Hw98VFGsYJ1sGFlwZqHXqINNWHIupdjkKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z1pIl7S3A9QKhyV2Tb5uhGibnAzkoHPXQjsumWu55+o=;
 b=lpNd9Z5vljPpODmipGfjIxJ2vDVtjr5rcl6U/Qz3/HYNzqhQvloOGTh8Cz7tWh1VXXS80IAawc+PBXff6Cu1jmFivMoiw+fHXmb5oTlYohv1bMJT0JQqJ9l8Fpqh0Rhd58fUceXZYn59dTz8MKQ02ZoDmg+/uxWx8VYGapTEJnxySmWpQDenjcEG97KVqNegJgWeX+lC03j2nXE0gyUuqWJPdNhOf7rP1UpC4inHjToojxdofQF2sA9t/WpX7rsQW9F4D5vx0LFA0wpdm+FeZ3kObBWOdH72X4O/XM0Alfsj09XWoGb8pD7J1rxcsGchQnTSH9O3kIdpPLICY/oTaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z1pIl7S3A9QKhyV2Tb5uhGibnAzkoHPXQjsumWu55+o=;
 b=s8LunFd0Gh29tL9ODwYljktnGOzxXSWfYd2ePaz66wvfIEmHY8ve+UUt+yHgZzvBc28qlcWP2fNsu+Soz01WVwg6WvhRVxElmEOJnMoRi/U2H+ixw+Hhv4ZOUZjTDxy/S/Riloo8ZQBfXRPDbyxoCg2ImUGyKiTAUApioPPz4l4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com (10.174.170.165) by
 CO1PR10MB4612.namprd10.prod.outlook.com (20.182.138.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4823.17; Wed, 29 Dec 2021 00:37:45 +0000
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::2d52:2a96:7e6c:460f]) by MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::2d52:2a96:7e6c:460f%4]) with mapi id 15.20.4823.023; Wed, 29 Dec 2021
 00:37:45 +0000
From:   Colin Foster <colin.foster@in-advantage.com>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        UNGLinuxDriver@microchip.com,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Lars Povlsen <lars.povlsen@microchip.com>
Subject: [PATCH v1 pinctrl-next 1/1] pinctrl: microchip-sgpio: add activity and blink functionality
Date:   Tue, 28 Dec 2021 16:37:29 -0800
Message-Id: <20211229003729.618079-2-colin.foster@in-advantage.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211229003729.618079-1-colin.foster@in-advantage.com>
References: <20211229003729.618079-1-colin.foster@in-advantage.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CO1PR15CA0085.namprd15.prod.outlook.com
 (2603:10b6:101:20::29) To MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dfb5939e-0318-4e8c-34da-08d9ca636e17
X-MS-TrafficTypeDiagnostic: CO1PR10MB4612:EE_
X-Microsoft-Antispam-PRVS: <CO1PR10MB461267BB226B563E0444111DA4449@CO1PR10MB4612.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8apr4PnUmB2Q7FHfiqXZ87RNlhOqMWjw9kmIo2Oc3T1gssiNStP36PeixD+GgiDKC3HOwOwa94tlmdf84/AKwDpur/H14mAyvI+7ipm8AaX1HB3lnL5w48WQRJirLtM1kKw8mCt1lHdaWmuQkyTz5aRVsZyWGIerAWhF5zB7cOwjEyT44J+P26Ip6sN1V3fd7NILjnL/k5Mfag4TwAmiEf3BMO9hjNcmbMMfC0mU0vsb2okJmlThkb6ML2mB92MdCCeA1sECP+RV8zAkO9fFHs8M32gKMVD2MHXuqJubivkgXPFVHvkyDwARywFNHIrWh1c2QhWw8wmkRtag9bB3iLY5aqjiaN4HrV+1nHMQFIPzWQy1L8AOe5qccyhPluNppWAic2X7XF07DjR6osWMCmiOJKtquCaP0cA0AdQ5Uc8mEktdlt1HChIiYWXMsJohl59lKI5lEBEXbIDrdek0Qni9IkSg72XfT9LjXumHkkzPBdalYgW8MXsfgaoDQElMZEaxZvcMwSsvuDsbF4KtiOIIgfBTedxNlE0RgCMsnYMwvkXuLspOPQB9HeQliRv03JkKT+ggi2tPKoZK7mgBIUyEoETaKhYMYBmOfPGZEHQbfq8Mw7UxhmasBzzjyX/pmrvUUnOhZmvS8cW+siq32jKU4znU9XUGDAfskjuLJbA7a2dgI0ShvGwoNn401K1AZGFJFO8JTM8YFoA0QoWcMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2351.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(39830400003)(366004)(42606007)(136003)(346002)(66946007)(8936002)(2616005)(5660300002)(1076003)(8676002)(186003)(38350700002)(26005)(316002)(6486002)(38100700002)(6512007)(508600001)(54906003)(2906002)(86362001)(66556008)(6666004)(83380400001)(66476007)(36756003)(4326008)(52116002)(6506007)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tsrTXiBn740irIEx/6HL+dXov/4IXe5FOvVcJ4qmvu23Ax2mLXd34rpz460k?=
 =?us-ascii?Q?Jxlkp0+zftHCre4rlRrCNb0SfkBGJkR2KIqdrpjpnE0uiQAC/FqMtWKqNHIW?=
 =?us-ascii?Q?Yj/p4of5HboyoasF/bdNjw3SjbJsxgAicWOMQujFp0SFmxcPrBgyBT78OTTW?=
 =?us-ascii?Q?5bC26If2ChPPR5rMI/4WngN/6VpDVRoVmdGraKDKtJ+KMuUf8YJPH4ARC9Wj?=
 =?us-ascii?Q?HrO6qyznsYWlJ/VrdebzEyevuVcA5/5AD2M3d1yCTPj8gdZd30lkVevWE4oY?=
 =?us-ascii?Q?XdXpAmyZzy33roMCfNlpiCLOQYBuSMzi+ncqeJ0SCWaYvR5zUPaVjbdBUc8q?=
 =?us-ascii?Q?hZSctUeO45AXxCIMPy/dkN9rnb83MeIzwrw787ERiMd+QEjdt4wn4Zy4an4Z?=
 =?us-ascii?Q?S9gH+TA6OGDE4bSiuXuya/pakhF8qqKb41J/xBkWh3pDto8RrF6/63d6nkek?=
 =?us-ascii?Q?hv3RrnfTSpqvMAvsUEu9vnILLmE37QedzebYx53SlTGfuk2IMGV2OihKQqr4?=
 =?us-ascii?Q?v0Zr6A1xiJ8oTWmEjFBFVnoGnd+sNi6f0uIaXOdJIdlkIxNIv17k80tm4hRn?=
 =?us-ascii?Q?vTSu6bfhQ0IZkuLodGQsOB2CyhbEMppS//hBMvB1rFe63pXuOFL9IciE66YC?=
 =?us-ascii?Q?r2/92Pwx2//mwU4cdHexR4GM5h7PBY4paZqRMjZTGCUgRRkKWLLGtpnro5g6?=
 =?us-ascii?Q?uSCRhUE7Yc/ln2Z6Lvnuu2jKjBAOvPRP7OSxvMVx73wgHRfBEjg2x2ccnudy?=
 =?us-ascii?Q?Z80qKtMdGy3hfQF7YnQky6GFp01HBQmDkdD43bpFM6Qggh2zos3rmRX4KCWL?=
 =?us-ascii?Q?+xOugidQA1rqv3y2id6Yu7SXco9PFQAHqWmaDXu6CPWbPAcqq+re/WDLFSe4?=
 =?us-ascii?Q?UhTyGsdCPy87XrgfXfsSzTh5NDyoLnvOx6NvWz+Ai5Q1lwUvfaa1M68U6ZMy?=
 =?us-ascii?Q?CcwZve5U9ivpww2iFANeI6UdwzpzZBiV6neK87n3fHSPkHETYUW9VAA76sjw?=
 =?us-ascii?Q?u/HwSd6ZlPkfe5FevZ4bNE9HnliRh910XXnRTPP741J1S4Ex1Mw9HbcNdJLh?=
 =?us-ascii?Q?+eFuhJ4Pmq/6Df5Tp/qI0r2tvpY7uU5ZEMqyBho1Ip5v8KWbKXibN5RAW3WM?=
 =?us-ascii?Q?a2qJH4Zw2Pknlg/gtT8KQgbMwXgKa+BuZXcXmkBsXiTSkqeBNhH9AVDnFU4i?=
 =?us-ascii?Q?KEPGszDw17tamqM00z7gDeGWfsxiYYBRKJTvZi7n9RpnQixDU06paMMUESLx?=
 =?us-ascii?Q?vK9LSQdSQEbDbJjxuDyBqAjAlftossOVxn44sLuWAu3VXYmFNVCm/iHM1xI+?=
 =?us-ascii?Q?chJIU/aQRfmvXoIIPpXfR5YSZmabQF5+gxz6HvWb7T3LilTqCkQK234ZUuLU?=
 =?us-ascii?Q?ZICjnGByG/J1mDZY246vEdqyXxi2J2LrO++u+7FprRiJFMALZJq7j3nRGmOW?=
 =?us-ascii?Q?Uq9kZ+yzlsQ5CWlU+u7++/9rSSoZQD3h2cTzqw6uPtSTpwKTNguNpgvtlanQ?=
 =?us-ascii?Q?8IFTpaDizVpaKOZJHRJNsURJW8cK7+AOaz+lg4XTSDK54JtjoJJcFpN6xR2b?=
 =?us-ascii?Q?0peTpWocAL/pQJpqjKNhXyWrtcaeZ5gWJdv23pzolImu3RfmwLm6nDCpbuOF?=
 =?us-ascii?Q?kxsaOvULrRPD1mD4/1TpQ1QZOaPiaSUXtWpCk5vG85nYrfyug4v9SWCQ/M0G?=
 =?us-ascii?Q?kaRD7g=3D=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfb5939e-0318-4e8c-34da-08d9ca636e17
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2351.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2021 00:37:44.8942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lrjbq3xWDfON8KJyHMXOx21kXHzvofbw+paOi2ifOqM4NG8hbH/7w0KYcLd9hpFH1teoPKvzMeLouIiSwLYqj+yEU7DO2BecE12u6nqqPAY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4612
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add additional functions - two blink and two activity, for each SGPIO
output.

Signed-off-by: Colin Foster <colin.foster@in-advantage.com>
---
 drivers/pinctrl/pinctrl-microchip-sgpio.c | 135 +++++++++++++++++++++-
 1 file changed, 130 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-microchip-sgpio.c b/drivers/pinctrl/pinctrl-microchip-sgpio.c
index 8e081c90bdb2..e3230e5dedc0 100644
--- a/drivers/pinctrl/pinctrl-microchip-sgpio.c
+++ b/drivers/pinctrl/pinctrl-microchip-sgpio.c
@@ -51,6 +51,15 @@ enum {
 	SGPIO_FLAGS_HAS_IRQ	= BIT(0),
 };
 
+enum {
+	FUNC_GPIO,
+	FUNC_BLINK0,
+	FUNC_BLINK1,
+	FUNC_ACTIVITY0,
+	FUNC_ACTIVITY1,
+	FUNC_MAX,
+};
+
 struct sgpio_properties {
 	int arch;
 	int flags;
@@ -60,16 +69,22 @@ struct sgpio_properties {
 #define SGPIO_LUTON_AUTO_REPEAT  BIT(5)
 #define SGPIO_LUTON_PORT_WIDTH   GENMASK(3, 2)
 #define SGPIO_LUTON_CLK_FREQ     GENMASK(11, 0)
+#define SGPIO_LUTON_SIO_BMODE_0	 GENMASK(21, 20)
+#define SGPIO_LUTON_SIO_BMODE_1	 GENMASK(19, 18)
 #define SGPIO_LUTON_BIT_SOURCE   GENMASK(11, 0)
 
 #define SGPIO_OCELOT_AUTO_REPEAT BIT(10)
 #define SGPIO_OCELOT_PORT_WIDTH  GENMASK(8, 7)
 #define SGPIO_OCELOT_CLK_FREQ    GENMASK(19, 8)
+#define SGPIO_OCELOT_SIO_BMODE_0 GENMASK(20, 19)
+#define SGPIO_OCELOT_SIO_BMODE_1 GENMASK(22, 21)
 #define SGPIO_OCELOT_BIT_SOURCE  GENMASK(23, 12)
 
 #define SGPIO_SPARX5_AUTO_REPEAT BIT(6)
 #define SGPIO_SPARX5_PORT_WIDTH  GENMASK(4, 3)
 #define SGPIO_SPARX5_CLK_FREQ    GENMASK(19, 8)
+#define SGPIO_SPARX5_SIO_BMODE_0 GENMASK(16, 15)
+#define SGPIO_SPARX5_SIO_BMODE_1 GENMASK(18, 17)
 #define SGPIO_SPARX5_BIT_SOURCE  GENMASK(23, 12)
 
 #define SGPIO_MASTER_INTR_ENA    BIT(0)
@@ -98,22 +113,46 @@ static const struct sgpio_properties properties_sparx5 = {
 	.regoff = { 0x00, 0x06, 0x26, 0x04, 0x05, 0x2a, 0x32, 0x3a, 0x3e, 0x42 },
 };
 
-static const char * const functions[] = { "gpio" };
+static const char * const function_names[] = {
+	[FUNC_GPIO] = "gpio",
+	[FUNC_BLINK0] = "blink0",
+	[FUNC_BLINK1] = "blink1",
+	[FUNC_ACTIVITY0] = "activity0",
+	[FUNC_ACTIVITY1] = "activity1",
+};
+
+static const int function_values[] = {
+	[FUNC_GPIO] = 0,
+	[FUNC_BLINK0] = 2,
+	[FUNC_BLINK1] = 3,
+	[FUNC_ACTIVITY0] = 4,
+	[FUNC_ACTIVITY1] = 5,
+};
+
+struct sgpio_pmx_func {
+	const char **groups;
+	unsigned int ngroups;
+};
 
 struct sgpio_bank {
 	struct sgpio_priv *priv;
 	bool is_input;
 	struct gpio_chip gpio;
 	struct pinctrl_desc pctl_desc;
+	struct sgpio_pmx_func func[FUNC_MAX];
+	struct pinctrl_pin_desc *pins;
 };
 
 struct sgpio_priv {
 	struct device *dev;
 	struct sgpio_bank in;
 	struct sgpio_bank out;
+	int ngpios;
 	u32 bitcount;
 	u32 ports;
 	u32 clock;
+	u32 bmode0;
+	u32 bmode1;
 	struct regmap *regs;
 	const struct sgpio_properties *properties;
 };
@@ -223,6 +262,32 @@ static inline void sgpio_configure_clock(struct sgpio_priv *priv, u32 clkfrq)
 	sgpio_clrsetbits(priv, REG_SIO_CLOCK, 0, clr, set);
 }
 
+static inline void sgpio_configure_blink_modes(struct sgpio_priv *priv)
+{
+	u32 clr, set;
+
+	switch (priv->properties->arch) {
+	case SGPIO_ARCH_LUTON:
+		clr = SGPIO_LUTON_SIO_BMODE_0 | SGPIO_LUTON_SIO_BMODE_1;
+		set = FIELD_PREP(SGPIO_LUTON_SIO_BMODE_0, priv->bmode0) |
+		      FIELD_PREP(SGPIO_LUTON_SIO_BMODE_1, priv->bmode1);
+		break;
+	case SGPIO_ARCH_OCELOT:
+		clr = SGPIO_OCELOT_SIO_BMODE_0 | SGPIO_OCELOT_SIO_BMODE_1;
+		set = FIELD_PREP(SGPIO_OCELOT_SIO_BMODE_0, priv->bmode0) |
+		      FIELD_PREP(SGPIO_OCELOT_SIO_BMODE_1, priv->bmode1);
+		break;
+	case SGPIO_ARCH_SPARX5:
+		clr = SGPIO_SPARX5_SIO_BMODE_0 | SGPIO_SPARX5_SIO_BMODE_1;
+		set = FIELD_PREP(SGPIO_SPARX5_SIO_BMODE_0, priv->bmode0) |
+		      FIELD_PREP(SGPIO_SPARX5_SIO_BMODE_1, priv->bmode1);
+		break;
+	default:
+		return;
+	}
+	sgpio_clrsetbits(priv, REG_SIO_CONFIG, 0, clr, set);
+}
+
 static void sgpio_output_set(struct sgpio_priv *priv,
 			     struct sgpio_port_addr *addr,
 			     int value)
@@ -352,13 +417,18 @@ static const struct pinconf_ops sgpio_confops = {
 
 static int sgpio_get_functions_count(struct pinctrl_dev *pctldev)
 {
-	return 1;
+	struct sgpio_bank *bank = pinctrl_dev_get_drvdata(pctldev);
+
+	if (bank->is_input)
+		return 1;
+	else
+		return ARRAY_SIZE(function_names);
 }
 
 static const char *sgpio_get_function_name(struct pinctrl_dev *pctldev,
 					   unsigned int function)
 {
-	return functions[0];
+	return function_names[function];
 }
 
 static int sgpio_get_function_groups(struct pinctrl_dev *pctldev,
@@ -366,8 +436,10 @@ static int sgpio_get_function_groups(struct pinctrl_dev *pctldev,
 				     const char *const **groups,
 				     unsigned *const num_groups)
 {
-	*groups  = functions;
-	*num_groups = ARRAY_SIZE(functions);
+	struct sgpio_bank *bank = pinctrl_dev_get_drvdata(pctldev);
+
+	*groups  = bank->func[function].groups;
+	*num_groups = bank->func[function].ngroups;
 
 	return 0;
 }
@@ -375,6 +447,15 @@ static int sgpio_get_function_groups(struct pinctrl_dev *pctldev,
 static int sgpio_pinmux_set_mux(struct pinctrl_dev *pctldev,
 				unsigned int selector, unsigned int group)
 {
+	struct sgpio_bank *bank = pinctrl_dev_get_drvdata(pctldev);
+	struct sgpio_priv *priv = bank->priv;
+	struct sgpio_port_addr addr;
+	int f;
+
+	f = function_values[selector];
+	sgpio_pin_to_addr(priv, group, &addr);
+	sgpio_output_set(priv, &addr, f);
+
 	return 0;
 }
 
@@ -693,6 +774,30 @@ static void sgpio_irq_handler(struct irq_desc *desc)
 	}
 }
 
+static int sgpio_create_group_func_map(struct device *dev,
+				       struct sgpio_bank *bank)
+{
+	struct sgpio_priv *priv = bank->priv;
+	int f, i;
+
+	if (bank->is_input)
+		return 0;
+
+	for (f = 0; f < FUNC_MAX; f++) {
+		bank->func[f].ngroups = priv->ngpios;
+		bank->func[f].groups = devm_kcalloc(dev, priv->ngpios,
+						    sizeof(char *), GFP_KERNEL);
+
+		if (!bank->func[f].groups)
+			return -ENOMEM;
+
+		for (i = 0; i < priv->ngpios; i++)
+			bank->func[f].groups[i] = bank->pins[i].name;
+	}
+
+	return 0;
+}
+
 static int microchip_sgpio_register_bank(struct device *dev,
 					 struct sgpio_priv *priv,
 					 struct fwnode_handle *fwnode,
@@ -716,6 +821,7 @@ static int microchip_sgpio_register_bank(struct device *dev,
 		ngpios = 64;
 	}
 
+	priv->ngpios = ngpios;
 	priv->bitcount = ngpios / SGPIO_BITS_PER_WORD;
 	if (priv->bitcount > SGPIO_MAX_BITS) {
 		dev_err(dev, "Bit width exceeds maximum (%d)\n",
@@ -738,6 +844,7 @@ static int microchip_sgpio_register_bank(struct device *dev,
 
 	pctl_desc->npins = ngpios;
 	pctl_desc->pins = pins;
+	bank->pins = pins;
 
 	for (i = 0; i < ngpios; i++) {
 		struct sgpio_port_addr addr;
@@ -753,6 +860,12 @@ static int microchip_sgpio_register_bank(struct device *dev,
 			return -ENOMEM;
 	}
 
+	ret = sgpio_create_group_func_map(dev, bank);
+	if (ret) {
+		dev_err(dev, "Unable to create group func map.\n");
+		return ret;
+	}
+
 	pctldev = devm_pinctrl_register(dev, pctl_desc, bank);
 	if (IS_ERR(pctldev))
 		return dev_err_probe(dev, PTR_ERR(pctldev), "Failed to register pinctrl\n");
@@ -895,6 +1008,18 @@ static int microchip_sgpio_probe(struct platform_device *pdev)
 		sgpio_writel(priv, 0, REG_PORT_CONFIG, port);
 	sgpio_writel(priv, priv->ports, REG_PORT_ENABLE, 0);
 
+	/*
+	 * The datasheet and register definitions contradict themselves, at
+	 * least for the VSC7512. The Datasheet Revision 4.2 describes both
+	 * default blink modes as 20 Hz, but the registers show the default
+	 * blink mode 0 as 5 Hz. Two identical blink modes aren't very useful,
+	 * so override BMODE_0 here to match the 5Hz "default" described in the
+	 * register map.
+	 */
+	if (priv->properties->arch == SGPIO_ARCH_OCELOT)
+		priv->bmode0 = 2;
+	sgpio_configure_blink_modes(priv);
+
 	return 0;
 }
 
-- 
2.25.1


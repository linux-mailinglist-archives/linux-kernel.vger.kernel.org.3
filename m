Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1EC957B399
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 11:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbiGTJQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 05:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232026AbiGTJPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 05:15:51 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2070.outbound.protection.outlook.com [40.107.20.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446C32E9F8;
        Wed, 20 Jul 2022 02:15:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dj+Y7iAQUghxTnLOkAR6BCNBcXy2X0wNrwIvpSfKgWkp3YYLwEnXj/brmiPwV3Kzms3ng1cdzWMFZ2IOY/i+fuuyjd36U0E+R2zvy+BBCaTdKWHC+YHADT9bTwd/SsMGFyBpkXHA98O7HlfEJbolURXXYqVSlbT0TCoMN8Lt8Tp++I56P0d3vXt7IASvwhFP5pMsC3aVXXB3UUAgBeXfOsQ5ZULH5oV+LCQxtXYFUKoFdGMvVEUOu0aFM19jYewdtDm9HaGyfHtGB9Wgws8Ic6hsODqNJAahEgaq/z/KLuaUzcp6Zzf4ixkVhWH1scOz5asFuzdfLJ8u7ryV/MSIFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FpfwSrVzevjJQQTaaJ+swW9Ris/wtp2z/7wmHe3+9/o=;
 b=hladPWHkW6oNdOUBq/WKsP1gAGrGs0f+jSWhYGIz5SvpS8WdsRYcrVDVbAHbcoHtFq2DoBgaSxP2xbBxAW6C78UBLv0iW2uHke9k96gJEvlvkN+ia/lXvjitBJ6USwTZNFXkMlpeyQuiJBaP8AlpNfeI4ubxXXcr/4W17HSjtO6HztS/mQcXR/DGpkbcF2f1eaP8aMJx7BDY6OQ1Py4MRR+gYiWGR+GTStuegnnnHzE65i2z38WJMoZRk867bGfYG5ZnV5/83HnjnMfY2ruHSXYXSUa+tmqjaubw7CYJATtwSrytLaSXmW4qIGJIFzaR52nmoh5YV3suFr61InYQKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FpfwSrVzevjJQQTaaJ+swW9Ris/wtp2z/7wmHe3+9/o=;
 b=D/8enNyUZ7toJXjrJZvY/V6xujzRXoTRdq07iNSNVKC01Wv15G+CvGJ2ptoIrnXDtRIESzFydEGCiRB7zd4ErfEQcHZ/kwjwZ/dhSVEnj/BWc7LSmQXJDRXTg+lMDZZTxP1Av64vRMaZWrupKpA9I4j1WS3AudCUyLSHktEWhSc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from AM4PR0802MB2131.eurprd08.prod.outlook.com
 (2603:10a6:200:5c::22) by VI1PR08MB3934.eurprd08.prod.outlook.com
 (2603:10a6:803:df::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Wed, 20 Jul
 2022 09:15:47 +0000
Received: from AM4PR0802MB2131.eurprd08.prod.outlook.com
 ([fe80::dcaa:905c:ff8:1f5b]) by AM4PR0802MB2131.eurprd08.prod.outlook.com
 ([fe80::dcaa:905c:ff8:1f5b%9]) with mapi id 15.20.5458.018; Wed, 20 Jul 2022
 09:15:47 +0000
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
Subject: [PATCH 3/3] arm64: dts: rockchip: add csi dphy node to rk356x
Date:   Wed, 20 Jul 2022 11:15:27 +0200
Message-Id: <20220720091527.1270365-4-michael.riesch@wolfvision.net>
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
X-MS-Office365-Filtering-Correlation-Id: ea02d018-38f5-4a98-1977-08da6a306ed8
X-MS-TrafficTypeDiagnostic: VI1PR08MB3934:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +wUns6jhnx2Pbhs1D3PuMSiMwgFAKFn18bbQVFHZutM2iRVgLOlcm3uTDl14NQajVLO8UCZ0iThjXZy2rrDDxiiuiDtDknbP96dLfZnbI3TiYNeE7nRovIUWPPmV6YfW5mqfldVhVo5J9/z7J+f2ErPIULW3VXU5Wztqn5pufAf3X1h+SYLDF/ieIspN59oxdbqnd/w+UDC477NFmByA5oxu/kPzqeY7sxlaBmth0xKhc1p+NH/6vejqoaCPFkumtMYka7JxbEdHsN42xPbeZda8QVCA6wqoei1bTCdPWB2w0X2vkJC5OGNZBTdvAf4X2MI0MblqZcXNVnmvKx1TMLReu/I+VHAHWfsdqRfHq54pb/KuZm9YfbfX1aRcKSmj5PuSGBjGjNpv5Vwl8WQBRsUYTF5p3I66ThKbtO4o+vi1rCvnilcrQ+RVkeciMEqHNXMwF2Zywz5c+9mH+ZdS6ilg+BzVO7z3oMcYF7cfrzEVvYn2FLfTi9c64A/30U/7Ro7g6rXWRj5IFhk7a/DFIZg7z4WjpYcX/0hIjw5n9zy3bkKretRIwJAPZ52hUBQpQ4c6WetXLR1DNIrQpnB/5eUOwReMd6rkFMMiRKqqaZ32Jomx01VlzmbX8iNhdxWRgKMrLlPmykPAdr83Cefy7hUL9Mv3EBDqKFgLR0W9GSHZ990sLJmhUeVRB6xuIWAZhIobnPdLY2Ox87J+qlxsoYLwcyIC8V/3/+yyX4tIFRM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0802MB2131.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39840400004)(396003)(376002)(366004)(136003)(38100700002)(52116002)(41300700001)(6506007)(6666004)(8936002)(7416002)(5660300002)(6486002)(2616005)(478600001)(4744005)(1076003)(66476007)(8676002)(66946007)(66556008)(83380400001)(6512007)(54906003)(316002)(4326008)(2906002)(186003)(44832011)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NXJb+jBsUwqXh+zzahqV0Uc4UnjAR0oqh+meNhHfgE5QuXhVEtDYr1dUy8M9?=
 =?us-ascii?Q?3KBdr8OqR5CoRV1RbwqduorO38bjjKWkG8RWnOO0C2A4NgVgys6BfB9/M/9K?=
 =?us-ascii?Q?F8A7QjIS+dQw/GL3b/druz93ScX+WFDemxDR1DcdKJBsP8a489F7Gyiq85YR?=
 =?us-ascii?Q?UtYAQI7D8TuEqDHaZfJJ/ppB/2xkCVYxFymJ/7hFJsD+0Pot9C93dqygWvXb?=
 =?us-ascii?Q?yvGgrTUWY9BfAT8wT/+OCszJfRg7ji6ueEWEo7E1gI3ywuiO5tdbo8mcKJ1/?=
 =?us-ascii?Q?Mht3/X0HwI6kqzaY7Ojmo4LWp31XNX62F5+IuuvUskMJKxlBblmUREPkZFC0?=
 =?us-ascii?Q?oIIs1Bc/6UR3W+2iFg2jZjTLkf71Y1+/VPV3J53uC/7wwfQkA6B3GlYBs8hu?=
 =?us-ascii?Q?q0+TAbIPM6koYzbHnRF/1PUeAH5TPqUidY9UCVy0qsYwdlbxlNrBGy+Ll/LU?=
 =?us-ascii?Q?ZDINhW1HZfMNff2ClCq/9PKxbQd+XirOzAhIv+Xc2wiTL1WuOoMB77OSW8nP?=
 =?us-ascii?Q?GcZA/ElB5724c6SXHEC9jMXh0/vIzamBfLIAx7R6y/g2g/4IAT0zJBvcPEFg?=
 =?us-ascii?Q?jPFYauP+ztPdROoSu3+uAZtyjq/eK6YeAiI1LnTxa3II8ABIb5eVMmRFr4OF?=
 =?us-ascii?Q?3HZwrBObT7w1PwSgcJB2xofvgPp3qgYFEDS0yOfiS2lh0X178jurOCjlsdnk?=
 =?us-ascii?Q?VGygG3O82yptexujcl7BP4kke09n/Z6GEGun7sCG6KX7EYrnuqlwPwSJ55DX?=
 =?us-ascii?Q?87TuP63tj5EPRR97d6vVmOFqD7q52YYmL2S6thuonNlqm4QSZ7b9QZQnvxI9?=
 =?us-ascii?Q?e+Wdlx5MkYl/Xs6Pq5lRzYbzJOpi54c16JxNZrbUJg3efkF/cxj5/BI9xKay?=
 =?us-ascii?Q?+9pMUwRHA3OgZIg1ViSxK/lKZwARxQRRYymsQN5d5zDaEZil0p99wb1XyrsK?=
 =?us-ascii?Q?Y5s0PlHuar7/zWM2B28cIlLUvyqPqcobIk5f3lI3Lw9czcNPNzwpG1vCJtKu?=
 =?us-ascii?Q?ar4NW2gOAuUSJJ4/cPgF+JZyyfqIWoqn39rB8OrGrVDpdYLlh/3J4Rw0VZxv?=
 =?us-ascii?Q?3SOLvys4SQs6xtoQvfXdjXOSfaORl86h1SxeyfIj8rP1hrj/vDvLqjFYNbpc?=
 =?us-ascii?Q?QaF3ME2OGKHLYJfH1Dsx/2K3eMHeGJ2WRo1lTOFI+I6SRg9QXQPQlYqHwrCt?=
 =?us-ascii?Q?SeKYNnXI/8X7foSm2IiDLYeQs/E8WfBPOQ2m/xzZCwSgzDk+fQvdCAX4gbgV?=
 =?us-ascii?Q?bDv12gSlmyeL7bkVTjnlLfltzsJMGo7KudWPpFvTUX3elG2dAqYxJE/o69ef?=
 =?us-ascii?Q?StK54HcxCzCHJc5FJhsNgBH/AxM8/tKVW4COGQDDWIF9g4HDFHeIM80/BNe2?=
 =?us-ascii?Q?UyeO0Yux+lMlpQH58jwrJRWiOSbXyjuXvES/7xdp3eULpzYRutQEJkQdcJVt?=
 =?us-ascii?Q?aYJgW644j3fnD13tL5z73h4Qe3gxqteMu37YXagDO97elwfy1D6atsT9eWKn?=
 =?us-ascii?Q?D4Xx7RnLm3izozDOJ7JDFLyANMUzA60z4zMC1CWDvxxbvSY64Ge/1mCozd3I?=
 =?us-ascii?Q?15aqDvd/JtWmSJqDUiMKAeHMXlMJk6ZZk3BD/bXsDjeLtHazd+Es4uiqGwsP?=
 =?us-ascii?Q?LeY7LTnWGXduYb4Lq5i+JB9aaYzSzVAO8L+M4FJamyO4V+evHQpDiMCmCq8l?=
 =?us-ascii?Q?T1sRHQ=3D=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: ea02d018-38f5-4a98-1977-08da6a306ed8
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0802MB2131.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2022 09:15:47.8383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9nZ1Nkf/iNERPdlgUT86FA67IauoF5JV2IB4mDDanTMWiZREGJsRuh9mU8f+mxMxbIaxY1t1v0GGd+PlFxSkZdNnwn0wGdfC7OKpzZCuHC4=
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

Add the MIPI CSI DPHY node to the RK356x device tree.

Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
---
 arch/arm64/boot/dts/rockchip/rk356x.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
index 7d9ad6aa4052..16d18170ae82 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
@@ -1544,6 +1544,18 @@ combphy2: phy@fe840000 {
 		status = "disabled";
 	};
 
+	csi_dphy: phy@fe870000 {
+		compatible = "rockchip,rk3568-csi-dphy";
+		reg = <0x0 0xfe870000 0x0 0x10000>;
+		clocks = <&cru PCLK_MIPICSIPHY>;
+		clock-names = "pclk";
+		#phy-cells = <0>;
+		resets = <&cru SRST_P_MIPICSIPHY>;
+		reset-names = "apb";
+		rockchip,grf = <&grf>;
+		status = "disabled";
+	};
+
 	usb2phy0: usb2phy@fe8a0000 {
 		compatible = "rockchip,rk3568-usb2phy";
 		reg = <0x0 0xfe8a0000 0x0 0x10000>;
-- 
2.30.2


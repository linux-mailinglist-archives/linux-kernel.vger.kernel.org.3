Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405274C41FD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 11:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239344AbiBYKKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 05:10:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239084AbiBYKKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 05:10:35 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2085.outbound.protection.outlook.com [40.107.20.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B691AAFCC;
        Fri, 25 Feb 2022 02:10:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SAJVcqzhXlCByAWs47c4rxs1q26WNR6t7RG0N2yuMwYtpmuBXvQLrOrQZE9BLiRFVXSxwSMFTbBTETSdH1tOUDnvpVYDYQVERgguFLxKsuJ+XH/Qrqgo6sOOyEAzU+R9Jz3jOeeQi5MmC0z+fdH5+GhkMO34GsX8QaQP5r64z2+nK322IaakT0glzyO6602f1OY9gLF72BYE4nwA4nsayFr7kNuBtsPEfksUSuLC/Ib5egtcr17LHHj3iyaU/mkSW3yXZwRlwuaI13BcBlAsNItwLsFU/fF/ZNJ12J7jhyK2TwTApz5UTtJPGzsnDbzUGh7w2iLgDZ3xEArd5EmMOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AazVyA7esOdO+psHpqeYc37bJSCysPQC74Ytte9NvN0=;
 b=GgBVkur0hsMHrsXd/giee+1XUHm6SIZRoEjijZbH0mwZ3Hc+HYAWqs9Dv4XWl4ok460wrVGTx/81fVJGwgkqTbsNlSk2zHh8MgOZmiGpc9ifh/g38ImPb9y82m2glflAZiM2SFzZ4L6hitjmEHtvYrOoHvS7dhgIbWY46yWn4h4kkCLyyDQGzrpm66qmR8HiEKLNlmqLCcW/44SjdivKdNDwQvzMcTZnV4wurZYc8cgDKXZSO5fD7xAfqqRiPfhTT8dR3LOWVP/nB4Nb9pC88UQzlcA2+WiKOeR/uBHQr83WNRG2Ew+qTKfHdQgm7WqcGV2NeoAPWjzKpb3fqtlFDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AazVyA7esOdO+psHpqeYc37bJSCysPQC74Ytte9NvN0=;
 b=KqEoc5Ikxlkj82rd5L8ls8n71MCHk+3r6LkoFYtq1M9IkkdZ0bxsyLptwR3mbuWanYsP03VYFg/0wPZ9tKvLnak7fuxkr0XdzYlijL0fCR4Lqtjzjm9POV2Y19D7cid1IA7dcEogSJv2Z+UlRNW3MUDKSatIy5NlPaBZKV+ijro=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com (2603:10a6:3:e1::23)
 by DB8PR08MB4169.eurprd08.prod.outlook.com (2603:10a6:10:ab::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Fri, 25 Feb
 2022 10:09:59 +0000
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::f9ee:a333:b115:5049]) by HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::f9ee:a333:b115:5049%4]) with mapi id 15.20.4995.028; Fri, 25 Feb 2022
 10:09:59 +0000
From:   Michael Riesch <michael.riesch@wolfvision.net>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Liang Chen <cl@rock-chips.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Johan Jonker <jbx6244@gmail.com>,
        Simon Xue <xxm@rock-chips.com>,
        Yifeng Zhao <yifeng.zhao@rock-chips.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Subject: [PATCH 2/2] arm64: dts: rockchip: add usb3 support to rk3568-evb1-v10
Date:   Fri, 25 Feb 2022 11:09:43 +0100
Message-Id: <20220225100943.2115933-3-michael.riesch@wolfvision.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220225100943.2115933-1-michael.riesch@wolfvision.net>
References: <20220225100943.2115933-1-michael.riesch@wolfvision.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0146.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::7) To HE1PR0802MB2426.eurprd08.prod.outlook.com
 (2603:10a6:3:e1::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4cb23e4b-aa37-48ee-fc41-08d9f846fb24
X-MS-TrafficTypeDiagnostic: DB8PR08MB4169:EE_
X-Microsoft-Antispam-PRVS: <DB8PR08MB416986906A8E6560D8B363EAF23E9@DB8PR08MB4169.eurprd08.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3SOPZMInKTHMKwwvEGq8SgzHTyb7Rw6pr4JH9clT72S4wCyKJdTlK2GOqwdaxDsQkNlGb4XMNNtozWJm5BDU0IIcB3Ps/KXLNWsmV62GMht/9/TJQwY/VSi2x5qZpjlGvs/1tO9ue9F6WBUpaauwzydI88Xz5VFh4npSp9zyuDsfIwVp3pavano1a+GGYW0mfHewG9i5bslFV3rq441hpC7A/t0a78STSvMW1lTJjP9cJBQrsHe1b8GhWGIIDfMZQIMUe/6L7VoQkD9ZDkTdvV1KCnT//7/6rdz+HNTLSRuOhnVmobermARiAJZ5GBLgS+zkpqI5gCp8QQf6v0e4BGzQGk6b32eKtCOsBX7zP6sWpHzHjKKCGS10AzhUTGmk+wy09q0hQqrzgwZWNpfchG7gtMsn6ICPaDxtFrSTEIYRYwZhaUugCjjPx73v9ZR8TZmLrGbTgwUtcG/QxEl2kIeYSnm50XKXgD24IvCs22ga8K9B5UXhQd5hpkU36nmzHvJRZoFrRSOZrREimPSyloat6tgK/+guQB8ta7WLZJs50+Foa9evfUUOXW1lTYtJMnGgYHNuKCdd7+jzQTCet+MpfIOj80P/4F6J3u843t+6IW5X56B2VgpbxEvDcxO10Z+nYAzPtC3zuDNKzd04eA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0802MB2426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(396003)(346002)(376002)(136003)(39850400004)(366004)(36756003)(83380400001)(2906002)(2616005)(186003)(1076003)(52116002)(44832011)(6506007)(6512007)(5660300002)(6666004)(8676002)(4326008)(54906003)(508600001)(38100700002)(316002)(8936002)(86362001)(66946007)(66476007)(6486002)(66556008)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3AIG3oKuZyC3tUltvDCQpQuAbdkHowLXZSVkoNXyIQ+dHj/QXv6aRqh71pVQ?=
 =?us-ascii?Q?2qcXcXt3MMW1d6bIgcx2+be+toQ7pmlnO76GcPPoPmo9nvlenpiWjquzilKZ?=
 =?us-ascii?Q?+P56g0u43s8A0eIW5FVqTi3f6au9Cgf8KP+T02JbejWaSmowWTi9VYf5Imbz?=
 =?us-ascii?Q?VNXbtmFzFlXlfA4aPAmz5Ei1CtXza22SmP3M/ucGruc32csJFvMdqemMkTtS?=
 =?us-ascii?Q?NKVbgPXvq5a0g+jt9uYpZwXciVdd+SEKsqOR8EwwJpKCZPuuVAYtyeOyRR2Y?=
 =?us-ascii?Q?di68x0aYbB46/CIQOjX+PzJYUcSP1FP4myGujvhQT3QFpw73UIVAb+NbPhLC?=
 =?us-ascii?Q?f+Vbx8S9PATSAyk++Tej7JKDa+scM/f8mf4YliJwuIfCAzW0vVTO2i2NQ6I3?=
 =?us-ascii?Q?ZENklLaQMxE4Dg+j0QLQsTShiRB/2lqTUoLMsHqaojjkxwe7CRSKZQy56tk5?=
 =?us-ascii?Q?rXY+ZWE2dqkhprRb3q/nyqDEFI9FAD6W8+KH0ok7w6UrH2BGCR4laNAcZife?=
 =?us-ascii?Q?gK8PfLqSlSDyySvNpIw/cUB/PaC8xt3RtTAIGJSMifjkeJC20mQRDe4Tp12t?=
 =?us-ascii?Q?AX3F0dv3CfJRgD59ps6o9M9py5oMapGuwfCdxhQzl2X3wu07CZklmPGsx+bY?=
 =?us-ascii?Q?vHJXsF0ZRYIVmTCeE2oEMXUqiSQuoVaiSmZGTPPPItf36yIRSPlZYTo3jyGK?=
 =?us-ascii?Q?0huyQQc6qax3yz08OwgBDgn2o+6OB3XuP5spF0njh3PvfSF1FZDDf3dheu+6?=
 =?us-ascii?Q?bWSocU7q6juoWAatulp6as9aCrVD8BnCabpBRWQoqRkjA3aegP8JIukzo4Ut?=
 =?us-ascii?Q?DHJmATpYSuFijrtyLURFYBo3rhZawzKAZj5Ryw5IQ8FqLvQpQ414f/cxOtoV?=
 =?us-ascii?Q?ABC78BEgCXGvpDS12K9jWFLPGtJl6Vq7w3dscXCxu6wY0Z9xJvx63wKtrPgq?=
 =?us-ascii?Q?xH+w7M6mcPtkYoDgwcPeEL7e1vraF8stWD/K67bIOh6+xGzE32bPOJ6LiNvm?=
 =?us-ascii?Q?NdNBFy7/gIlOjkfqI9yXnb77TFWEJPga3gRGUcgh3RUKpDYWapI8SpI7adKY?=
 =?us-ascii?Q?MpbLBhteZaOj2c8VBWsdD8Oq0Au0YSyD/mfgG9PWy78Br31e6SM6alQo7wiC?=
 =?us-ascii?Q?66BqCh+07IOq6RodwDntzm0ZHmx+5psc0IydWA9dBXYQosyUzTIBuepX5byK?=
 =?us-ascii?Q?Gh9BiBcm/rCgWf5F7Y6UqPENvYPbFmrQ78yRYu2BLiG8dDSRR4Ymmf+Qnxyi?=
 =?us-ascii?Q?7zpoiagNiKDcHA7+Jlaoit7HUoggnCCS6AoREsoet+mcbAoO1CclT/QvowL1?=
 =?us-ascii?Q?pxC+/3vsubbuocDE9Efdqo37O7rSDHoXHNhQ3c/JZaF5PKTIX3YoA1fI3OiQ?=
 =?us-ascii?Q?SjUlv1ObJ0ebvHtZdLFGVAXxL7QRePBg3gre0sW56rIvfVKEgN9LLuEqIGQO?=
 =?us-ascii?Q?Ry50l23I6CN/QjK1p/8CTv/vsFb82leRDv/sNQVVlKBM0WIYswsrGSX9qvvC?=
 =?us-ascii?Q?3MeonrCwGN3v5zLal2fC1c7XxEJDfOfTc2zjSd+SMqM6eEemw7D+JNMnKoDQ?=
 =?us-ascii?Q?exGJ8dwF68TjqRNEAYTl6ZnsNARBKCjPfgqE8wNFhGCRZmbb9yghS11bYGb1?=
 =?us-ascii?Q?nhowXJq1VnTBn2aRjPMEEakg3sQl2Pro9SEuqrlUz+rt3GOTnnlOZ/evOoG/?=
 =?us-ascii?Q?2Nfnn8FahqssWldRJCLZCdMGwEHH41kESXGOAeDA+HbblnPUqpPRotuCgvbU?=
 =?us-ascii?Q?Bjhj22KpQW1HdfboBK0AideXHOf9f1s=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cb23e4b-aa37-48ee-fc41-08d9f846fb24
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0802MB2426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 10:09:59.5790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZXAbmTD2ZxEIgWu8dNl832JJEMItpbVhuO9GnZ0nOKoSzvameolyN+a/iMeZb9aEHWlzRb+v2Pr0ko+CVzAy95NVDHwu7vmyetBEiJ7s//w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4169
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Rockchip RK3568 EVB1 features one USB 3.0 device-only
(USB 2.0 OTG) port and one USB 3.0 host-only port.
Activate the USB 3.0 controller nodes and phy nodes in the
device tree.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
---
 .../boot/dts/rockchip/rk3568-evb1-v10.dts     | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts b/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
index a794a0ea5c70..dad3d2682b02 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
@@ -103,6 +103,18 @@ vcc5v0_usb_host: vcc5v0-usb-host {
 		vin-supply = <&vcc5v0_usb>;
 	};
 
+	vcc5v0_usb_otg: vcc5v0-usb-otg {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio0 RK_PA5 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&vcc5v0_usb_otg_en>;
+		regulator-name = "vcc5v0_usb_otg";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vcc5v0_usb>;
+	};
+
 	vcc3v3_lcd0_n: vcc3v3-lcd0-n {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_lcd0_n";
@@ -136,6 +148,14 @@ regulator-state-mem {
 	};
 };
 
+&combphy0 {
+	status = "okay";
+};
+
+&combphy1 {
+	status = "okay";
+};
+
 &cpu0 {
 	cpu-supply = <&vdd_cpu>;
 };
@@ -507,6 +527,9 @@ usb {
 		vcc5v0_usb_host_en: vcc5v0_usb_host_en {
 			rockchip,pins = <0 RK_PA6 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
+		vcc5v0_usb_otg_en: vcc5v0_usb_otg_en {
+			rockchip,pins = <0 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
 	};
 };
 
@@ -560,6 +583,10 @@ &uart2 {
 	status = "okay";
 };
 
+&usb_host0_dwc3 {
+	extcon = <&usb2phy0>;
+};
+
 &usb_host0_ehci {
 	status = "okay";
 };
@@ -568,6 +595,10 @@ &usb_host0_ohci {
 	status = "okay";
 };
 
+&usb_host0_xhci {
+	status = "okay";
+};
+
 &usb_host1_ehci {
 	status = "okay";
 };
@@ -576,6 +607,24 @@ &usb_host1_ohci {
 	status = "okay";
 };
 
+&usb_host1_xhci {
+	status = "okay";
+};
+
+&usb2phy0 {
+	status = "okay";
+};
+
+&usb2phy0_host {
+	phy-supply = <&vcc5v0_usb_host>;
+	status = "okay";
+};
+
+&usb2phy0_otg {
+	vbus-supply = <&vcc5v0_usb_otg>;
+	status = "okay";
+};
+
 &usb2phy1 {
 	status = "okay";
 };
-- 
2.30.2


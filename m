Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5E4E49EAC8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 20:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiA0TFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 14:05:16 -0500
Received: from mail-am6eur05on2087.outbound.protection.outlook.com ([40.107.22.87]:49248
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239096AbiA0TFN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 14:05:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XrA6EFXUioPOuQGbNS3pjhfeZ0T4fbxhmUa2Y/DNzfiPNmDB2UlPnAvc9Za/lu83nT6Fl+7y5thEDVOISNF/7WFfba7f2GWgyqxd8nXgIsG/LKY7h0PqEWSYfZM+0OqtbwWfpCheLBmFx8W54cBt1hGlSNu/6aw1h811eL3blzFyI5enOQOZAOiOPNu1xLWtbhJtQxmXKpRnqcmQgEVaTifQ4m0IFIqzuWDVmQOk22zSjp4PWSRiSg/6NipfJB4wtE+yGxXNJ1wiPYSzaZD90TLAf6mcMbnptWFptcwDN27ax9OCKnBac0hxzoyEOrMbBK6CRSBW8s1i8wKaszpoYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kIOXQA3PKm8u78cTTrQaCwjXsfrHlm0ewbpaN4mbu08=;
 b=Tt4UA5coQTFH46nnxijO3XgpU/HJH2rdkK6RAU1hbEjIo1xNAMIpNWSNzEovKZkt2M5MgNFUqlCBMSb3gOLoNyzN02Tc/g97xT8UyAgyeFgaFded69cgBMY0/pb1mjSA30P3kuOHV/D/hkFw6Ur1eDVS3O3Fg6F82WfBHBkJN6HwiHyLEbP2ufMHjnL2Ffwqi+aj1xnIHry6CysLpneSauMGFUDfIGu6E5MsNuG9clYVH6b+jiOpIWR+XpfFAnQ9eAgx5Fg7oUwxRPlyjwkSkkjN8CAGmh1LQX1v2xLwhiNzp7PzJTucgGHo+irmrLAK7LaOs2lOr37FhCvuR3OamQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kIOXQA3PKm8u78cTTrQaCwjXsfrHlm0ewbpaN4mbu08=;
 b=E2s8RgX/B99IRZqSTQN0PUGArqeKJunmlkiHF8l0kYa67GJNiyKectdO3E8gQxP/b5sGYVe+ZobfWbOkL5ZcwIzT7NCxVpFKd0rw0F7NQma0R4foZgUQ9sqayOvtQxWWm6TKwJyDNiLuZ0Bz39kAq8x36+lp0Unk9KFXzImMB2w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com (2603:10a6:3:e1::23)
 by AM6PR08MB4072.eurprd08.prod.outlook.com (2603:10a6:20b:a8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Thu, 27 Jan
 2022 19:05:11 +0000
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::e14f:197:5001:4c56]) by HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::e14f:197:5001:4c56%3]) with mapi id 15.20.4930.017; Thu, 27 Jan 2022
 19:05:11 +0000
From:   Michael Riesch <michael.riesch@wolfvision.net>
To:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Liang Chen <cl@rock-chips.com>
Subject: [PATCH 2/2] arm64: dts: rockchip: add usb2 support to rk3568-evb1-v10
Date:   Thu, 27 Jan 2022 20:04:56 +0100
Message-Id: <20220127190456.2195527-2-michael.riesch@wolfvision.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220127190456.2195527-1-michael.riesch@wolfvision.net>
References: <20220127190456.2195527-1-michael.riesch@wolfvision.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0179.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:45::19) To HE1PR0802MB2426.eurprd08.prod.outlook.com
 (2603:10a6:3:e1::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 599868e6-ece3-4874-abce-08d9e1c7f161
X-MS-TrafficTypeDiagnostic: AM6PR08MB4072:EE_
X-Microsoft-Antispam-PRVS: <AM6PR08MB40725D67153EC74A479A6D88F2219@AM6PR08MB4072.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sgkb80d2aVJwMHWyzxI3qo3GITemEU/3zCumHsdUmTkQ20qJ9rX5UoZN7JjJztyMTg/gIL5Qv+xJhByIfkBrpDENR8w3SPLksY19Bi1dxwurpFHIQyjVsx3KjJV1kofhaCROwRmsp6AZjo3XzTcp4bMpbr6Usm7LRm4uZoLU+64cb6KjmeRt05JNH9/GxasjERj8jtNeeT8qJ/mrR3Ob1dow7qHlZhxgRECimMjq7qrV7/u98s8JUm0Wj47pn9jHmqf4FdwjyCM4esKR1XBs6QNUbTmP4SUBZUIsGub+xUOX6vREJLHFVLp6fyPFJevQ0c95C45HcdaUF7SHvv/Z3RzO82UBEYoOq3sNbXDqwx5Ym6HKj/OztAzIqGM9ELLakjwePNkLAYjvsWFJ+ASF38T42JGpuWA4+myNriA1/2v1OYQpx9iLeruO3GI7jA2P9KwjaUpq/NMwc6GgCt6yGtxR3xcPEzBgRYLKFVzco4+QwZH/Wg4Q2mIgNJDydtQ0egvNFEzergOy9yR+cBOJsQAz4GbSBHJGiwMBvY6/WK6nzsAF5yBExH/q07m+qf45f9P7Pom1Z4Nq1kmH4ECQbaL5CR0ijIpvp5z6I0lf0xY+deL/s607NoBvUKdlhGVhkAktgdujMjkEONylgm4e8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0802MB2426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(4326008)(8936002)(66476007)(86362001)(66946007)(83380400001)(66556008)(38100700002)(5660300002)(44832011)(6666004)(186003)(2906002)(36756003)(316002)(2616005)(54906003)(6512007)(508600001)(1076003)(52116002)(6486002)(6506007)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SMZR/sKZXCVhc4a9uUkwiy/xUrrWA5RN2+25xmpUGn/4CmB5emB+xo0SQuT1?=
 =?us-ascii?Q?eXhJfF9HnAhgys/39RxW3C2hjuCDLVSDGjtMj4DW97Rsy+CB1pgp3G+dqq/N?=
 =?us-ascii?Q?J+o33FFKtIMQ9lTMpjNQf3jjYBaEpIBIjgJJEPYPR5VgxnZBmnoc/eUxWYtT?=
 =?us-ascii?Q?zMJDCGaSTJtCYlLVvAEY4mAix85EQS5OyFTwx0LZorhYGzwg44CrSXAnedMF?=
 =?us-ascii?Q?qz+rodtipWY7ZhceYXEfJRREABAoihn+lNfPt18IfAhR2dvYj4ODC9b8DrOZ?=
 =?us-ascii?Q?pSHIFg7h+uGw5cnaIQDWrqfVukZ4tbkj8US+AViYGfu/6ruX91hJn0QsuWIt?=
 =?us-ascii?Q?uaEg6sZJLwCJCIAhStxEtGnHsHVuhx13cijCC3P5Wb90RhNg8vN2II+y1dQG?=
 =?us-ascii?Q?CfKUEE+JrRqiRtA6sL9luG892ZnkMvNtCd0hegmLy9EMsP3eRHnGq1cu9NOB?=
 =?us-ascii?Q?TdEDpZQ7Ax3giyhaM1D2iF7vcVSgLtbGMCIPIaNgYqrun4xfaSKX0jvGL5+g?=
 =?us-ascii?Q?n5IHZPalBQf/DMpef6Sr8rcNMqCdWg/lPYoFYcV9YFQ+HT9ezVQtv42t9WRF?=
 =?us-ascii?Q?gfiOKYPov+IhN1jjBFJfEX3B8ALTv8rNg+L3GWc96pb1y7HKk0u7BB0LLetR?=
 =?us-ascii?Q?PXGdFhJGwPJeo3HUs4Oiv44WSVVZJiUBBK2lglp93VjdkUNvQG6MRsdxYRFK?=
 =?us-ascii?Q?ammtFGZ0hU8EbRJxFv1BX1KgR/baqfKMa7k219+qxpYHG6V9yhOphbaBly3s?=
 =?us-ascii?Q?zsxcOxKkp7xZNcXqHmezkoYcdwEsJW8ZxnPcCtcX98JSHwe00pRmmUbf6N9+?=
 =?us-ascii?Q?0KCnXB/u5cAObLQeJPZ9oUIgDTtkSvJ6r3qvN3bD6Z79FQg07Wb513EokomQ?=
 =?us-ascii?Q?xMgp4lh1cilHsejDObBWRceXYuiPt4govQEoT0U9URszTvZVJe8pnQRjyqLE?=
 =?us-ascii?Q?AkwSiojAypzPgJpxXOn8Uhx9v09xZHZUBYLEBsC1S9hA0v2Ey1KWoqDAkDM4?=
 =?us-ascii?Q?6BJ07ZfhRUxeeEkMe25IikvRhVj+r4yxdssR2ZH5wLVKkXr/tluD5EDRMdRU?=
 =?us-ascii?Q?24syeOQZeuWvJcCQF2WpqU0DozXIEOaL3Zn2CtYpMMarN2ExRCoS21fjw0H+?=
 =?us-ascii?Q?Q87r9MOaI4nK+/beNf11KpgLwZhzInjP7gEuvHx3ejcpCTBlmvScUsGtyKCT?=
 =?us-ascii?Q?1Whd88JVQNxVgElIp4JTVBGy8EjUOtcz8H6bMU1y4jNRJklTA0bxu6hiNdIO?=
 =?us-ascii?Q?+Ohecty+o799L6kw0NYJyffgCD/hTevM1A/p2CLLQ93ei7QJmw7hDmRSY5H5?=
 =?us-ascii?Q?a58TTtAns0I4VP3Jhfjw9l1WFNx3xt1m+GtCZNBRPAJMHsZ0gcGnIaAqF65M?=
 =?us-ascii?Q?EtCiR7vr+Fswy7V3JBW3x3gBciHmr0xSNXDr4ebtp+ZGlE2lg71eDU/Vqte/?=
 =?us-ascii?Q?seTsRnpNLnsuLuF0CEtlzdRlqy31HfNEb6o8NPkw8wQBKCUWtpd7k6pja4lD?=
 =?us-ascii?Q?kDwpGZlCvV4hAi7C2GLr+KcD46T5tajoyYMYtY84yTgvskDahsWDP9/SqTW7?=
 =?us-ascii?Q?Uk36p4AUHzFafyS0yw60K9Lft4dUvHSihrYHJ9ZehSG5OkCBqJlrit3YNFW3?=
 =?us-ascii?Q?WnfZO3rcNfC78sNN/wXDia5TDD2QHki23faXDMPyJ5jYmgeVwrMAu/Wips+3?=
 =?us-ascii?Q?5bG5x020Ai1C+X80Lg6IHTFUOtn38aCXo6whNKc+d0qQC/DEeoxFYUHS+SGY?=
 =?us-ascii?Q?rFNkJRl7+edh0UQh1TxxDGX1Iy/b4RE=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 599868e6-ece3-4874-abce-08d9e1c7f161
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0802MB2426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 19:05:11.5181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5BAhio4VLAsN78BIrLEAkoz+CVCH0VHndH1mrgxy3M8lV6EPaYDDOU26bPWc+cQT8+IWULhzw4InJoXlW9l7PzBKV7H1/21wqbBpNb/DlU4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4072
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Activate the USB2 controller and phy nodes in the device tree of the
RK3568 EVB1.

Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
---
 .../boot/dts/rockchip/rk3568-evb1-v10.dts     | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts b/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
index 184e2aa2416a..c68bade0d99b 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
@@ -53,6 +53,28 @@ vcc5v0_sys: vcc5v0-sys {
 		vin-supply = <&dc_12v>;
 	};
 
+	vcc5v0_usb: vcc5v0-usb {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0_usb";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&dc_12v>;
+	};
+
+	vcc5v0_usb_host: vcc5v0-usb-host {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio0 RK_PA6 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&vcc5v0_usb_host_en>;
+		regulator-name = "vcc5v0_usb_host";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vcc5v0_usb>;
+	};
+
 	vcc3v3_lcd0_n: vcc3v3-lcd0-n {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_lcd0_n";
@@ -345,6 +367,12 @@ pmic_int: pmic_int {
 				<0 RK_PA3 RK_FUNC_GPIO &pcfg_pull_up>;
 		};
 	};
+
+	usb {
+		vcc5v0_usb_host_en: vcc5v0_usb_host_en {
+			rockchip,pins = <0 RK_PA6 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
 };
 
 &pmu_io_domains {
@@ -390,3 +418,33 @@ &sdmmc0 {
 &uart2 {
 	status = "okay";
 };
+
+&usb_host0_ehci {
+	status = "okay";
+};
+
+&usb_host0_ohci {
+	status = "okay";
+};
+
+&usb_host1_ehci {
+	status = "okay";
+};
+
+&usb_host1_ohci {
+	status = "okay";
+};
+
+&usb2phy1 {
+	status = "okay";
+};
+
+&usb2phy1_host {
+	phy-supply = <&vcc5v0_usb_host>;
+	status = "okay";
+};
+
+&usb2phy1_otg {
+	phy-supply = <&vcc5v0_usb_host>;
+	status = "okay";
+};
-- 
2.30.2


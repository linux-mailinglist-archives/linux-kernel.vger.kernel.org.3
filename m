Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98B184D535C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 22:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343862AbiCJVFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 16:05:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343814AbiCJVFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 16:05:13 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2043.outbound.protection.outlook.com [40.107.20.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF486EDF3F;
        Thu, 10 Mar 2022 13:04:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dzaqDztG6LhAOsai6eFCrDHD09lCIS+EOo3bodu4nceyuHtQ3128k5AMLda6NcexcbhXdoB84X7N1ac9+4WBIY+YM6gfls/OgLpSCszcZ9wQdG4I0kxXQ2DrCn3zRHgEg73lj0Dvj2octx7jo/2bFBQM5tN5z/GMZNxNZnfQk8LBCquszFG4u92jcBZvJxNjG1yoyQojHPyewGzTw5xZiY7wclE57pNQzFSLzo5GebO0oCjl206C5/ugdyPJYztqnzQmAH4NEz8vOdlisr+6TifTg1XIOZCC02SjSmqDRjyZWmexdzSMGSIigE6EJw2mbyLsIcfjq+tKtKVPRqrQLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LZw1+VtLOQLBFtratwHT1jmRlN9tWZHxciODuakdhR8=;
 b=ZBA3lbXNiDLXCyHcpg4mQx7e8duzlyb5md054n4QkN/r/SPbDys7Nh4VeMa/X/kR+K9ykb/6Cwpx521B+8xpsT5hzDsrvCcFxefBz19uTd8L0wTMTUX6cS/4sKRETJrfVON8wMv8zhXC1UJ2qfdqsfLQLJNbqQwWGraFVwPSzGUdgeb7g2cLoSXQzfqAylny5j0tJBrPXYfV7ftZ4HFa/8ES4jUZMb7H2WwiMBfck9+n6LxE1T13eSGHKjaV5jzxyRlMvCliiSf/pHOMrsfwB/yEmZGUJ3o0d8tqkEV+KpLOEwLK2AUau88QvgtdZAuqOKpFj3ijSiDPFt9f/W3RHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LZw1+VtLOQLBFtratwHT1jmRlN9tWZHxciODuakdhR8=;
 b=QBlyU9Xs9z9eT40UlwBZ4coTdKIF6gQUAqQ3t2M+/xMHH8XeIbOTsEJoK6sCJn46MWkWOY5LPJwtkvJWzP2YiEXj+VgXsKMPUyjhE8bb2xw9ZWR2IzFY62N/r7ftxf4Y4Mbf+j3J3HO6qvpYvTZrX+XN6H6UTAO5BhAkLTV+T1Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com (2603:10a6:3:e1::23)
 by AM6PR08MB5078.eurprd08.prod.outlook.com (2603:10a6:20b:e7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Thu, 10 Mar
 2022 21:04:10 +0000
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::f9ee:a333:b115:5049]) by HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::f9ee:a333:b115:5049%4]) with mapi id 15.20.5038.030; Thu, 10 Mar 2022
 21:04:10 +0000
From:   Michael Riesch <michael.riesch@wolfvision.net>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Levin Du <djw@t-chip.com.cn>, Tianling Shen <cnsztl@gmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Alex Bee <knaerzche@gmail.com>, Liang Chen <cl@rock-chips.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>
Subject: [PATCH v2 3/3] arm64: dts: rockchip: enable vop2 and hdmi tx on rock-3a
Date:   Thu, 10 Mar 2022 22:03:52 +0100
Message-Id: <20220310210352.451136-4-michael.riesch@wolfvision.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220310210352.451136-1-michael.riesch@wolfvision.net>
References: <20220310210352.451136-1-michael.riesch@wolfvision.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0132.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::11) To HE1PR0802MB2426.eurprd08.prod.outlook.com
 (2603:10a6:3:e1::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a12c305-f5d1-4c0b-1442-08da02d985f7
X-MS-TrafficTypeDiagnostic: AM6PR08MB5078:EE_
X-Microsoft-Antispam-PRVS: <AM6PR08MB50785D4C40C23F0ED946D8C2F20B9@AM6PR08MB5078.eurprd08.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aSY9x0XXSjjvxeBB85Z3KM7JNlAsk+EsXL3E6wX/gk+fLp2j+Y14zV6nsxIogjuzmyyMEB9El98XoSS1LkFba9Zuq49r8mXEszDtKCeJ35ooQgz6HTJrM4ZDlDtRgOfbce8oxzovsxxZtU4hwoM6irtwK4yNAoVwmIwjlAwfmEjausR1SOvuRHFHrVTlHaXk6bao65xic0KEhiwo+QxEddvPOM0DWJA0pjRSQnFuT0qBcJRkQhQTydUvIsBTCjGZY/KOJsm5A6oVmOVP5F+9DjpKh8X4KTbBK9VfI4XEnFxBby3QXpTwU/ZYutnk/58a0FcYetbHKL8U5Fs9ITV4dKiNqJITZA7FD/m5GsLsi2hObcKLSGe018kZz+4Ve3U1MI0XTW9rFtS93jBUQPfscm4TJc8CKu3F+gOv/arsfYka7d++pfPsCCXBR5xRWiriU2IEJtnCgEo8fzUTundvxkRLDNEa1Ji0R3v5uHO31EvFFlBHzypVJeDFIZ4Rnor3R+aN7xubHKxfbNVa3giop9IZRrEYOmDjDLzpH944bdIP2vrn+7Xa6S0AAS9oc1wFPvPnSeex9rnbQwO5H28LfSHZ64emTVjl1yKVTJqoZGG4cYkDTs0h3+aMtVZcqurUpM+7mH4uDS6VkXvJOobseg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0802MB2426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(54906003)(186003)(44832011)(52116002)(86362001)(6486002)(66556008)(66476007)(4326008)(7416002)(5660300002)(6666004)(8936002)(66946007)(316002)(36756003)(6506007)(6512007)(38100700002)(8676002)(2906002)(107886003)(2616005)(1076003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ehyOSJ086Re8uTfWd5OZf8nnK1eZXA7QTBBBeCrx+0RDtmWWjR3f6fnLquB5?=
 =?us-ascii?Q?no2b6SIi54ewDokeBRA5qmOu+ebXLi0Fg3rSABgHCQil39wi+Pkp3Yjrqv/F?=
 =?us-ascii?Q?Ew99JV1Vda5gJ4NXBG9EzdSQThgJaCnoSVtyx7DYlSknoErGEhgVk1meotCb?=
 =?us-ascii?Q?UVPTE4XrdEO+6L3nZo0UvAeNGbXa+Jj6+C3d8kMl7rdY3GNNMqPQ+3eq61Mb?=
 =?us-ascii?Q?S1MLgNKsF4Tm9xedCo5t0gTt3UI7Sk5TAx7MrchNNEgZYFi/tine5+HXz4f/?=
 =?us-ascii?Q?4VWUTIvF8IU7ZyTxd+o6O1DkMlwLSrizDaQpfKOccFY8Xi2wcSHJU+luy4sR?=
 =?us-ascii?Q?6mU+R/j3+UwvWo5esHmgbdcuTIO8xz/DUEUO/qlnCMwqQE19/R4X9wxPBMV+?=
 =?us-ascii?Q?vYiscklHoHNMBGYDr7sbP1YsFEyfmBu4hCSm5MZcmdC9i43TYplmgMe//1vi?=
 =?us-ascii?Q?LSGt6V8WCZ0Hg9fdipC/KiTJmCfKexAqujHeHNohfasRQxEm1KKsB7BvZ/PQ?=
 =?us-ascii?Q?55XxWDQ9SlZJtqyG7ldvcuhs4IGYPkG01GWo63AMRe73izyFvGDey3lezX/W?=
 =?us-ascii?Q?tbQAJk64LpSdT+zo+5yfvNFDVIoK5TdcfEvQ36ozTfSEdxMYWcKKdXg/1eGL?=
 =?us-ascii?Q?y5Zs6OP470Kjti15cUxree7AJB9fXiAJNYq5yCZBHL/4s1oxpNm9MdBFF3bR?=
 =?us-ascii?Q?ep1Bw8wv1yCfJLob1Gy7MZFN8d/6EMa+gz65AUJrMd1Lr7IMItOy5Ko4MVVf?=
 =?us-ascii?Q?sGBdS8qU3AbMlDyd1kh2KluGwBTi+5Lv5HwDXPYtOV85UA/bOyPOcGzTTBpO?=
 =?us-ascii?Q?PavDanvEl7VlbQHSVAnQwVxMhq8dp5AHGWIV8FwbCIBkNK33LdZj5ZbtF6KE?=
 =?us-ascii?Q?4DmGCNO+KXAsPd90hpjrw9wWWu7ubweG2fyqzRAqMCzzvDkYPNgaNcpMPeHX?=
 =?us-ascii?Q?PLvOotlVPefUAn+de9z8j0JFi5CiJXpecMWT66CgGz3ALJCN72ItLrBfu5Kh?=
 =?us-ascii?Q?TVLLSPtkR7njLSOihBFXdjUXTAvHnheB6F7l+yi69KpMHB+0kjd7RPnGui1/?=
 =?us-ascii?Q?iCDH/mtrtOjnDo6s6BrHe4LkAZXU3pddtZJui91xiAKR/DcZw+B7hAwNSsOA?=
 =?us-ascii?Q?snSD03G4sAPM6cO1jfZjT4zG4bZmg63Jj0iv0w9cASZt0GvE/9WyDJo9L84Y?=
 =?us-ascii?Q?0jc3KFn0r9fua71XRfWKS9XqBjavfEXamcZRKgyUO3dLgCrz+T/XWoLfvfFH?=
 =?us-ascii?Q?ORVB7GizNovACo7+EXVgCssC+RCBwUCebt/QrvP7C+hnL13Qch0xEM+dwaj8?=
 =?us-ascii?Q?BEzFr9Pca/hG72MweGz1HZrPpdSJ9H7uW+WAnwfoe9vqIRZpFiNgFD6LDkL9?=
 =?us-ascii?Q?ognSckkNZFhKQdbSed7guPonmbOVx2KbmG0U7ysr0kK6gVn2GeIP7WXeaHIz?=
 =?us-ascii?Q?t3X3QUTnvQHiGeEi75BiUufJHTRSWG2GFqvAzf3WlK8M49ge+YNDsynwXeqZ?=
 =?us-ascii?Q?NNyBY0EcLabDs/I1TWO4uKf0JycPI9EEI/x0ktEhBDbEHX0ghj0xYYAJ4mfp?=
 =?us-ascii?Q?jyFn5r5vkPg7DZPSMfc=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a12c305-f5d1-4c0b-1442-08da02d985f7
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0802MB2426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 21:04:10.6317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dcNQ3ZorheHV3LUc97MvGqRsaAbucSBIRCZ72IHw+8vhzV+QgjMimYLQcA/6vWRupwXUZYwkk4gdQwxvj6s8vn1CNB5OZ/uUND1B+XbKdSw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5078
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the RK356x Video Output Processor (VOP) 2 on the Radxa
ROCK3 Model A.

Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
---
 .../boot/dts/rockchip/rk3568-rock-3a.dts      | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
index 18d2d8e5e693..e568ce377055 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
@@ -4,6 +4,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/leds/common.h>
 #include <dt-bindings/pinctrl/rockchip.h>
+#include <dt-bindings/soc/rockchip,vop2.h>
 #include "rk3568.dtsi"
 
 / {
@@ -20,6 +21,17 @@ chosen: chosen {
 		stdout-path = "serial2:1500000n8";
 	};
 
+	hdmi-con {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_con_in: endpoint {
+				remote-endpoint = <&hdmi_out_con>;
+			};
+		};
+	};
+
 	leds {
 		compatible = "gpio-leds";
 
@@ -134,6 +146,24 @@ &gpu {
 	status = "okay";
 };
 
+&hdmi {
+	avdd-0v9-supply = <&vdda0v9_image>;
+	avdd-1v8-supply = <&vcca1v8_image>;
+	status = "okay";
+};
+
+&hdmi_in {
+	hdmi_in_vp0: endpoint {
+		remote-endpoint = <&vp0_out_hdmi>;
+	};
+};
+
+&hdmi_out {
+	hdmi_out_con: endpoint {
+		remote-endpoint = <&hdmi_con_in>;
+	};
+};
+
 &i2c0 {
 	status = "okay";
 
@@ -499,3 +529,20 @@ &usb2phy1_otg {
 	phy-supply = <&vcc5v0_usb_host>;
 	status = "okay";
 };
+
+&vop {
+	assigned-clocks = <&cru DCLK_VOP0>, <&cru DCLK_VOP1>;
+	assigned-clock-parents = <&pmucru PLL_HPLL>, <&cru PLL_VPLL>;
+	status = "okay";
+};
+
+&vop_mmu {
+	status = "okay";
+};
+
+&vp0 {
+	vp0_out_hdmi: endpoint@ROCKCHIP_VOP2_EP_HDMI0 {
+		reg = <ROCKCHIP_VOP2_EP_HDMI0>;
+		remote-endpoint = <&hdmi_in_vp0>;
+	};
+};
-- 
2.30.2


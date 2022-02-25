Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 762DD4C45BA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 14:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241047AbiBYNQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 08:16:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241028AbiBYNQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 08:16:50 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2056.outbound.protection.outlook.com [40.107.20.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2493C1FE56D;
        Fri, 25 Feb 2022 05:16:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M7FFMfkl2pe7l9jRq2uUQIQASuWUgakko/IH12KVtkQ6/5Nsa00FzlxXAVyORxd70rzw0gXHZCN22Q7AxoQO8XSkwmnHdxhIc+7tTh7wG1yqz8RzEFOgoTspgtST4t8dbZ8t+ExWOqRs7IcPPEDNwleZ+5oNbTU1Nmby91NL0/r8dnJU30HWhxG9/H8hPEbyEmhPJ2yFRVod9PN6+OAk1twn6s0Lo7HCRqnbLlFLRi8Y4cK4d0TX251kP7ihROJz8pploDJFSVsIMN0KvfFKywAP3q0kCzI1NEji5doWIMvY4B2xAFD7yRrmtqGUQoeu2PMLOKXaSPfqX5qLpLnTdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z3kAs0swyfnpbUiF9qjTfOasD7sQzcfqY77EHcr8Q30=;
 b=QC6fMdH/lyH5gEk1tXL350RsvCDtKFNp8UUOA23hSoiu4WX21WYSp+PrT080OxwURANP0IhDaNBqMgKc19Eh5Qk/UW0JCtUQL0RIZqOaR1o/Z0kWPttGFfmhdd6wRFTfxD9X5FH693pA6xWTb2TZspDzGyCoaAWGo2qsS07ZWOnZ9GEY3xMmKZAPTWrRQIcPfUduZzXpvY77wAWJNJrh4cSdkbOpZ7OJH6ZY7wOG0+JOit0WUL+CyA63fA4By6ueCGAOv3aSjk5VFGsbfWRbsNGqn1zAA+QBIa8YYBCTATKQBf3KxRS2uoZryfiNP5aib5B+IVFE0+g+m/H7so1DsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z3kAs0swyfnpbUiF9qjTfOasD7sQzcfqY77EHcr8Q30=;
 b=yIkBmcUWDIEXJDhGVyF8SpnuNnU1yYZJ36ldCsCuspYxzDmfqJfHStM+ldvR3yRYYuG/LIrl71+BWfEesyKzRRBFPct9HvHEcEcVSSq8EB94WhziKCIwVc8i4sekPcHQLZoKoZItSk2p7+Vy46cKEULa6MTdlsuDOXEIk1tbI/M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com (2603:10a6:3:e1::23)
 by PAXPR08MB6591.eurprd08.prod.outlook.com (2603:10a6:102:150::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.17; Fri, 25 Feb
 2022 13:16:16 +0000
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::f9ee:a333:b115:5049]) by HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::f9ee:a333:b115:5049%4]) with mapi id 15.20.4995.028; Fri, 25 Feb 2022
 13:16:16 +0000
From:   Michael Riesch <michael.riesch@wolfvision.net>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Wunderlich <frank-w@public-files.de>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Liang Chen <cl@rock-chips.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Johan Jonker <jbx6244@gmail.com>,
        Simon Xue <xxm@rock-chips.com>,
        Yifeng Zhao <yifeng.zhao@rock-chips.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Subject: [PATCH v2 1/4] arm64: dts: rockchip: move power domain PD_PIPE to rk356x
Date:   Fri, 25 Feb 2022 14:15:59 +0100
Message-Id: <20220225131602.2283499-2-michael.riesch@wolfvision.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220225131602.2283499-1-michael.riesch@wolfvision.net>
References: <20220225131602.2283499-1-michael.riesch@wolfvision.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0109.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::6) To HE1PR0802MB2426.eurprd08.prod.outlook.com
 (2603:10a6:3:e1::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ce1fa9c-d02c-4db9-f81f-08d9f8610107
X-MS-TrafficTypeDiagnostic: PAXPR08MB6591:EE_
X-Microsoft-Antispam-PRVS: <PAXPR08MB6591C16FA2CAC9348933BCEEF23E9@PAXPR08MB6591.eurprd08.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7DoNLZui3Doeg9xmKxcw94EPQvgSqfOEzhytYGzth329iXBkp5PvbPFC2lhXXVou9bTkUc6GYXHr/MOiDWT6c1tr0181BqZt90f7z7w/ZIQGbaXZDmHUMnMNs6ReEBo8CQEOn369wdd7acKacSMf5gQOh6Zir97NTD05IyAu98KTV1zn4c/0Bm9tRL3/2pPkAU7VqPDlt9epZpnAZ9az8Zk/dyT1/bz+A3Yt1FrSDiQfiNjZLKy9NYbfxnqMXOstwrjGSHN3c2mMHAJg7UCx056gpJlu5FdmaVC4cB53QP/KJLBHqzAW4d4nuNw0j2qZTEnt1/UHJ2VYxdn/ZGB2Y8C8KAfmEZQdYjKNKISwoAZnX+RtyKHJiRuFFeftfT9rI6he0bL4hA1XdQEqQDjLqJroZ1LKIUUIbwtpn1LG/XA4oh5nwoseSuscx0wePw3jPxRuFWXQsqzzKvnjPrFr9lw0+I7UaEY0VlIwQbEr0Q+thLKrnxmaQod8Q6MbxKrNQcLWgsmD/ada756BAnYUSdX2YiPP3UMZSrGaliBwIX5A1dT2t+lFBf9gAnMdtuapJmYXuRIoWZ/VG6Tgx8kpjQdepULL4h81qwaocNqQwJs+JJt2IfhLX5jJRuFWGFicguVgAbD29yaowNL2DMaT/g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0802MB2426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(39850400004)(346002)(396003)(376002)(136003)(186003)(44832011)(6506007)(36756003)(83380400001)(1076003)(2906002)(8936002)(86362001)(8676002)(316002)(7416002)(4326008)(2616005)(52116002)(6666004)(508600001)(6512007)(38100700002)(66556008)(54906003)(5660300002)(66946007)(66476007)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aCf1uKzj6I8xJxWzsZ5/nAleb+tguvmcXYTCbhMlXofEKrlRUl04jkfW58gr?=
 =?us-ascii?Q?sSpaGxuGG2MkgBU5lySPIHr2Md6PROzWbHr0W5xxASad4JGBwezxES9gQ8XL?=
 =?us-ascii?Q?PI9jqi107wMyslr8I8GBDLKXIS30nQR6lXFZ84YVcB5sT1aHfsVu5k/ExC1V?=
 =?us-ascii?Q?Y436TqbFXn6bXJeCI6A3hp11++R51sMLhci2LYWuqkRWtrh93BBa7RfYpP3P?=
 =?us-ascii?Q?IcLVpJTTdd0pzTHjWDlLCr2SMhx7xm0xe0rlGu1S6SGBCYePQnaVTeZk6aZT?=
 =?us-ascii?Q?/QL0TMVqrK9Pvf4lhdV50XoSPQC/fpbiJWlUoxWfdvRyF6KZLnmGeg+E/gw6?=
 =?us-ascii?Q?sepyrxxQwN94Eu6w8y6ByenXd+tVqt/LuZk53sAWvfdi2HA2dE2wCH4dITBr?=
 =?us-ascii?Q?FLJLiV+t9GVQFWu6M2ZQRsl3SK1C78tnxPx7BcrktzMa8T7QNqeb82vt0ig8?=
 =?us-ascii?Q?RSmE4rv4bBGQO9GWl32NI6GS6vl5owX5msztK+CcZT8Y59uNmlo1KEsv2P1I?=
 =?us-ascii?Q?oZNn8R1Uk2BOImtUtuUmRQnrScY3Chj851v0m4GYBaStyPruAmZZuhdTVDIE?=
 =?us-ascii?Q?XVC9rnK3CS2t48Z9TSDaMqKT28VfMacbDjdeS869xK6ewCFHwposBMqnOxko?=
 =?us-ascii?Q?F/6MU+szWtIg3r1nV1QMguqOxBU6c/hZ9Erkg5dc1oHNF1RUxEF5qnF6CsxF?=
 =?us-ascii?Q?LUYJn06xXXuIhqji8G8FdHIbhvu4RYfcB1hdmu3LHciYIKfb7f5eGUL257wD?=
 =?us-ascii?Q?8TrWFRAvpBZ4aJ2aR1pBBR7iyX0Tp1WQFRf2q3t1CjBJI8t95AuQKhVdQKQO?=
 =?us-ascii?Q?x0ClEnFCpAx7aY5+dPzsbglTf6EFGrkZSrZ8+TJz5dcq2XRC0g/5hHv3kRFr?=
 =?us-ascii?Q?BkC/ZGEy1TMs6aNIrstpPcP5a1J8D/FK8rq7+xZSAPYQ4lRgSqXDl0gyogcF?=
 =?us-ascii?Q?K8yIT94hBZGZzKs22ECPZGkodpK2YoDd/ASoQHHzaJHLNx4T4pLEO3aJGIma?=
 =?us-ascii?Q?ZEbuf8wwsiSXQIFlXN84nO48MNs+TxOIL7LmGw7BT6I3553ThZfQXh3W01Cm?=
 =?us-ascii?Q?e1jFQXEKCQE/oydS0GRt/dRdQiaBDLah/XYbvzq0RfFsMIeZ6EpeMsYIkQZ1?=
 =?us-ascii?Q?q1Rbx+F6CzPX/+I9qEQG4zCQVa+cCulr9fY2K8NEtzD1RFKL19bPsmzAuxne?=
 =?us-ascii?Q?bVKRmtIiLmyW3TJVZA0Vp7ti7xKIPUZtPfBxSzkdKqWXNZXXvxTHgNVKinj8?=
 =?us-ascii?Q?Gtn4PYiSwCdzV3Cy+Les/hpKRin9i9IlX4xp0eQgmwKuEhncMh6YXQOa84xE?=
 =?us-ascii?Q?oUcV3eQA+XAHxiNlDow2tUx7cuhJSYOB9Wm0L+HCKwKG2yxEyT+sd6VS2G0I?=
 =?us-ascii?Q?qfrT5WS7Qn0fLTFyOzWL8lG+ITww7FBRqOOeKjoRv0qVKIavDx2caWJWFD20?=
 =?us-ascii?Q?E6YVgns1zuBEzAJkSAfbJtx1Fg0lzOZUep21QjqT1KwDFIFv4OQHumYixpwK?=
 =?us-ascii?Q?m4cpA103dZLmZglD0od1iPUCIvtGlplHjILtFE4ployyMbbhqLhy6kWgpXMg?=
 =?us-ascii?Q?d3X6nLg2drKYlIPtstgvDlpyDaRlD+xw85dqlpHDFwvfhFUvNOviowPKDguv?=
 =?us-ascii?Q?dHyUIAaNCgV29JSL5wrClExJrPIQ0q+Kx6oVdJZ2JdFR7CAZ9ukzA5VDwFOu?=
 =?us-ascii?Q?kIBbiyOxiep3iH/OfYaAeMql+1L2XVs4teQ/9fW+fDqiYLvx+Y2nxGIFFISH?=
 =?us-ascii?Q?CgXTyzkZIvnZkCQsPw1gXlyXWIyXyxY=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ce1fa9c-d02c-4db9-f81f-08d9f8610107
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0802MB2426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 13:16:16.4795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: esdpuyweA8lLFS8tFGrTWYSsqUVicjjXSE+ScoriP/adNgj+nqrlXon2TP71l/T8jTwQ55wgz8HhaAOzCmpF6AlHrHbdiL2rXBVlrlk/t4Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6591
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The power domain PD_PIPE was moved to the RK3568 specific dtsi but
is available on the RK3566 as well. Move it back to the shared dtsi.

Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
---
 arch/arm64/boot/dts/rockchip/rk3568.dtsi | 16 ----------------
 arch/arm64/boot/dts/rockchip/rk356x.dtsi | 14 ++++++++++++++
 2 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568.dtsi b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
index 91a0b798b857..ecc0f3015915 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
@@ -100,19 +100,3 @@ opp-1992000000 {
 		opp-microvolt = <1150000 1150000 1150000>;
 	};
 };
-
-&power {
-	power-domain@RK3568_PD_PIPE {
-		reg = <RK3568_PD_PIPE>;
-		clocks = <&cru PCLK_PIPE>;
-		pm_qos = <&qos_pcie2x1>,
-			 <&qos_pcie3x1>,
-			 <&qos_pcie3x2>,
-			 <&qos_sata0>,
-			 <&qos_sata1>,
-			 <&qos_sata2>,
-			 <&qos_usb3_0>,
-			 <&qos_usb3_1>;
-		#power-domain-cells = <0>;
-	};
-};
diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
index 8b9fae3d348a..742f5adcdf2b 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
@@ -490,6 +490,20 @@ power-domain@RK3568_PD_RKVENC {
 					 <&qos_rkvenc_wr_m0>;
 				#power-domain-cells = <0>;
 			};
+
+			power-domain@RK3568_PD_PIPE {
+				reg = <RK3568_PD_PIPE>;
+				clocks = <&cru PCLK_PIPE>;
+				pm_qos = <&qos_pcie2x1>,
+					 <&qos_pcie3x1>,
+					 <&qos_pcie3x2>,
+					 <&qos_sata0>,
+					 <&qos_sata1>,
+					 <&qos_sata2>,
+					 <&qos_usb3_0>,
+					 <&qos_usb3_1>;
+				#power-domain-cells = <0>;
+			};
 		};
 	};
 
-- 
2.30.2


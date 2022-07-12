Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7918571B56
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 15:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233043AbiGLNc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 09:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbiGLNcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 09:32:22 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2073.outbound.protection.outlook.com [40.107.22.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35991B5D2E;
        Tue, 12 Jul 2022 06:32:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QN3+qdHfNY1EwcI9hEoOeMzvv2Lkb5Ly0T6Pctg9oPEcu+xbByYyhYHptt/M7YdH17mss5cVz8WWGPcDMK6+cL031OJGLQ6XTv16jGs8EMmreFH5X06h8zkC/AE3Dln3VfP6uH22XsLl2jAyeDS6hn6U9+q4rPqK/n9Hb3c3k8KyBwHdhzVqqdeTNHCZ/LTMJmrToCY93C1oQY+nt7R9lKqW/oh8Rz0DysqkZw2rH8fpsQC3QbiwRs8PdMV7Xjld7lrLwlrAeshJogM7rHD9wi0lg58X6mgeFhv3prsX8vLqmkSEstgpFw8yss6ITGkut6aJR/n1PF0kRZrCOvRgqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iEFyyf8Bngkw48Q0dhDnxLweiKRmVCSUu2UYuv2NziE=;
 b=IJi3ChltdbiNr0N6YM4eWOaozbsQXAX8lAp6KTZKEHl/QjlZqn/h3v6bW45amDgwkjdekPeO/KLWBjwVPoEwPejOlTm8xFVk/cltRA+gPWEhqIKeu8AFNzhtS5rIs35LgR/TdhvErr4skQCn49h+i/65HG5kBpiWkpkUc7JcK5748Jnx8LF6dxeDpFv32A9UahziA4aX1dJl6J9EqKC6pKL5wqRZFvmMYE++OqZhFBSl5LEebEjsdrD53/Xq/4obY87uSRakpGZn2WX7UxMFWqqOpG3z13LhxbaJYhhmTEUuxkOMypJWczvWaiGjOIRWPRXLFtRlNseVFZW3zMIIfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iEFyyf8Bngkw48Q0dhDnxLweiKRmVCSUu2UYuv2NziE=;
 b=eQkR8GdyAjHm+wfQ8C6nxua7s7KmLT4H1DB8/r8VOqoho7NqIIyQcBk6np/6nS8e+Sm2bSSKrGGPCBT5sABAZu2rZK5xA3DsvlisqghRhwms7A0IUQVSt6ChfNzBqXdYOoPXs1Mm3mWMGYtA2noll0uuoSOvarDBFWsYuLrpyO8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from AM4PR0802MB2131.eurprd08.prod.outlook.com
 (2603:10a6:200:5c::22) by DBAPR08MB5608.eurprd08.prod.outlook.com
 (2603:10a6:10:1a5::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Tue, 12 Jul
 2022 13:32:19 +0000
Received: from AM4PR0802MB2131.eurprd08.prod.outlook.com
 ([fe80::dcaa:905c:ff8:1f5b]) by AM4PR0802MB2131.eurprd08.prod.outlook.com
 ([fe80::dcaa:905c:ff8:1f5b%9]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 13:32:19 +0000
From:   Michael Riesch <michael.riesch@wolfvision.net>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Michael Riesch <michael.riesch@wolfvision.net>
Subject: [PATCH 2/3] arm64: dts: rockchip: add vcc_mipi regulator to rock-3a
Date:   Tue, 12 Jul 2022 15:32:03 +0200
Message-Id: <20220712133204.2524942-2-michael.riesch@wolfvision.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220712133204.2524942-1-michael.riesch@wolfvision.net>
References: <20220712133204.2524942-1-michael.riesch@wolfvision.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR09CA0076.eurprd09.prod.outlook.com
 (2603:10a6:802:29::20) To AM4PR0802MB2131.eurprd08.prod.outlook.com
 (2603:10a6:200:5c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc763ec1-2832-4604-4ef7-08da640af170
X-MS-TrafficTypeDiagnostic: DBAPR08MB5608:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OwB0BjWVDyLxYH+lMp/ha8cU1bs0jfR1NTQVIMJgDZe5IF35DSbphbbmH+OXLblMsq/7F3vK539BV3/DMw9oG4zOBgjNHv/OSu3kTPArl6TYn0nhHxgPe/BQJwADTZIzkWxxleL+m9BKfnweGWPAaZjOH++efg6NlyD/XAmFmCR99vOpn2lSYB5K9qHP4LQ+hVkdG6uD7HLT7Vqm7MECPMPNMGiVQ05VaT3pMCVRq34ilDHDHJorXhCxquVWK1BsQ9P6y7VOMUs6ugExX0ySFpVWeuzrCWSQPf/HZlxZ6HqhcuyKyRJ23Vi9I0MamvwPDcb6KdvC0KxmkzU5QC4OeBxqaREjfVfOjjk5h1kliW/JRbc0zlC83yESYl3PCdfrxa+FgZ1XKedS4CbG2dw75VMaYsTrfRoufOyS8F6pW/KaJLkLHnJ4V2u67i3g2GKMFt3DXf4Z2YbRHReptNR3i2QHXD/GPYSzeYQx0IhypovxDQTg4k634IFurQYXUc4nqcT3zRqUSLhkoCc1tSTzwIfSeHyv6UoOO5v0XgDfrJbVv9o0bok4IyLtEuwAZnJ081+qgupnjudzuXcUkCSkrX7sG2rBelufb/D6wiBrxabDEPF03u9Lv+UmqN0IHxrbzocVOtmdUBQ1YULxgDSFaCUDfep1d1I+QqRDjU/c9imEIFBNAs35Onljjr36iEml2wJXmjzKlWiGSrONkX95oeXDPthUo7C9FPfFJEgPfOxe0cUwo31SvodUExh/cee5Z0xrTvdE6kA1U4Rs+tOFj6op5+MDQXvMubQcibERkBIy5G2Hd5eO+kdTdqaYfdK+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0802MB2131.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39840400004)(376002)(136003)(346002)(366004)(396003)(478600001)(41300700001)(6486002)(66946007)(38100700002)(2906002)(38350700002)(6506007)(52116002)(26005)(66476007)(86362001)(8676002)(4326008)(186003)(66556008)(316002)(107886003)(1076003)(54906003)(2616005)(36756003)(8936002)(5660300002)(6666004)(44832011)(83380400001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aIgW5BsiojkNlmYIFsC720zRAmJjf8msbDrCODMekaaYp9pPHxycDrpw3GBj?=
 =?us-ascii?Q?miQa4mNx7Uf4XVEMwXnmoGrnelqgmu+1ur+cNdyEA2Gbt9W+gtIsf0nym8AC?=
 =?us-ascii?Q?8z83mVLE8ZrjPRPSSZEiFkdFO8Z+XGVEDMBQCIkwbRvt74if6Uj8/SrkvM1n?=
 =?us-ascii?Q?u9J0LyWFQ2lT7NQ5PwZUjQPQxY8bOdOisn/1AoVMWavy0SsBAKMQHgMJDKJv?=
 =?us-ascii?Q?iy5+cRCl+Wn1+J86rfpyCdxdqPjizu5GA9LL5MbvCS3bTjtJ0VkN3+jcgd2n?=
 =?us-ascii?Q?aQEIsY9pxpZiaw4aN7C7lVhTsGwoi9qDBugu0dtHjrF7v7w9/iVPs7Yew7R4?=
 =?us-ascii?Q?TEi7BdreZqpblPIziRY3ZlMB/ieMI1h/IKU4u3Hd+1yE4s8vJAuGmMNqQIP9?=
 =?us-ascii?Q?CDczKN6OCG7cNj8jSm22SqSeQh0FiSidy3E69baRHEYcrXsCyHD1XWXYFoc5?=
 =?us-ascii?Q?cMkCSwGA8rA2HEOUdQjRABVTdhVDlO4kECtqEAiv+G58LkNsiTz04n/RSVHr?=
 =?us-ascii?Q?qNKYKQTuHj4m23IWtB8+dEsQ/ScvDVTH9cWvx6pB3H1Z+zEzsYrcccii7XB0?=
 =?us-ascii?Q?reeD8rBKUdu66a7TMGQTE5QOG7/gbtEAfU0Lr9pVIP3XjIrQi8mEF9Be0A+u?=
 =?us-ascii?Q?M9iPN7GTJwSD2X4L5mPXo+vJcLwf3xQWv6SUNFwXRCFn/Rd8Z4TLMM+DJB+r?=
 =?us-ascii?Q?JvWjdQoZXO/uDkegKkQ7+PwVTCAH4v8HKds9r3oo3Edgu6wCWVTqwBdfS1Ps?=
 =?us-ascii?Q?oD3JGrEtJsSkp0yccn1qweEBmUxmCUx6B60h+jwPWTdOyFEX4bIrGS8VY0v0?=
 =?us-ascii?Q?ClTQzdNoyz7uaLqTnFnPN51tf3/ggTt1deltuK15DuCKsOnJZn2I9Gts41UP?=
 =?us-ascii?Q?IjVSsKkRpp4qP2l9RVniXS1piBPO+HbzRACu/UpCjPp236bBM198KgfWH1Mz?=
 =?us-ascii?Q?zKzxVBVxVSurEDNGPdblxg5bemX8b0Pp5ma1EECPZeqLiXajGPCHZK0Ngez2?=
 =?us-ascii?Q?+pMPYY1/c8fQ1ojmsAOb8s215VKWUL1xTcHQ9rxrAnwfbUtvs0H+elMLXHAB?=
 =?us-ascii?Q?V/SsbOWbUN02ccSBw1MF8tOsZBTkQAgDZpsujlDZ/ohCxnJsUXokc2lf+p+a?=
 =?us-ascii?Q?vgqe+i6FxijS0vjcQsD3ll6DF+1PoIHnqvSW/BXM1cg1J8L2YccG2mj/0T0l?=
 =?us-ascii?Q?mLAtYfgkGw2QON1yNAystMJlT+VdlJHGAFDNSOx/Kzk7s+iXCJIYSUCWaGYo?=
 =?us-ascii?Q?Y9mL508+cROc9F+g7+YgmH+1jR/mSQ+C8TjIK59zRaq4cMmtJSBnS8gR22Kg?=
 =?us-ascii?Q?2RmSO/8nQUYy+5KJNOTPxk6mFDEJ8/4nT2unzUsKRLOZuyfBX1LF2yLJ3cBL?=
 =?us-ascii?Q?GICFE04h9MKdHqZwabrWjvQyYt5hvPVnela0IAmKsUcAABNEbfL0a5tfWRcu?=
 =?us-ascii?Q?eF3fOkC5SXMQKSriWkJw8bhLwd6XxgSQuiuX+p6SvYlyzfIhg+LzbqRImSCu?=
 =?us-ascii?Q?ALkewlCFV8fRaOvYsAy4Jbxov72AfLUawRWnqntdmyM4dyASxF541LRg2EiN?=
 =?us-ascii?Q?uT9L6aOMzR1vvokXt1M5yFSD9FJiOFEsdgV5ZicMgx3bf36fbC5O0YQtz2bI?=
 =?us-ascii?Q?Ew=3D=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: cc763ec1-2832-4604-4ef7-08da640af170
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0802MB2131.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 13:32:19.0403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PbimkNot5zYDff+uiRI38L8fd1tTox8cGoOJ3krKMR6S6s1UoyqbgZuD+WzAIQKddyftq8WZLPTCuzZejWW8QESQr8pkcWVC4fwIf+ooUk4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5608
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Radxa ROCK3 Model A features a voltage regulator that provides
a 3V3 supply to the MIPI DSI connector. Add this regulator to the
device tree of the board.

Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
---
 .../boot/dts/rockchip/rk3568-rock-3a.dts      | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
index 821f9b96914b..33581a36c9c3 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
@@ -147,6 +147,22 @@ regulator-state-mem {
 			regulator-off-in-suspend;
 		};
 	};
+
+	vcc_mipi: vcc-mipi {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio3 RK_PC0 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&vcc_mipi_en>;
+		regulator-name = "vcc_mipi";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc3v3_sys>;
+
+		regulator-state-mem {
+			regulator-off-in-suspend;
+		};
+	};
 };
 
 &combphy0 {
@@ -476,6 +492,12 @@ vcc_cam_en: vcc_cam_en {
 		};
 	};
 
+	display {
+		vcc_mipi_en: vcc_mipi_en {
+			rockchip,pins = <3 RK_PC0 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
 	ethernet {
 		eth_phy_rst: eth_phy_rst {
 			rockchip,pins = <3 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
-- 
2.30.2


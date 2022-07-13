Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46520572E47
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 08:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234389AbiGMGgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 02:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234167AbiGMGf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 02:35:59 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2078.outbound.protection.outlook.com [40.107.21.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C8AD6CC1;
        Tue, 12 Jul 2022 23:35:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CQb7Y+KRLJGeU3IC+ACgmEknYZOi+j5zJ0BVkJva62Cd5bg4+h5bC8pPTdC/R1BnoHAjcFAIz3vrKm06uumHhfVJPvK/OI1/A+vmeEcQ7xgAEQOmJAxjW7N6XeIWgODkr9Wg0o1i0VH3Udr5WCuEp+y00GgQul+X3E59QAV9b+zFPSV9P1eraRI43iDZZYXeg+lCy4aye35+FC+UdwG62Fv5uRt8gZ78RcYb/Lde0LcIH+P9KDFDXvUhxg8pDG2KNLuW5KOefFxlYGH/+ZMmUcw1vpBWwYdJcJ90m2c26WIBryJvAylZxFPT7M4QEZdQ5sj5OWGcYo1Zt8nXBQOOWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=olONIe1IcfxoeeiMmRevLFQZZOGiT0LONaCz3vBzlbo=;
 b=D4rq6Ybl+j/Qm0vbrZuQOl4FHrpZTRlG3fyKWR2quBuAUYFM926mm2uvoAhDv2VYPnI+u5Uk5bKFty4bxGyUT+yutWNqP4iUBXfV5eykjfA+qnMH0vL9pm+AfARlcVmfqvN9AM3DxmLib09ajPHxv031b4iM7w8L+Se8WYVPbhu4+Z33dQzjrQPI2s1f+FjBEcZS333qAidrher25+smkPRDds9g15Z2G+h+4x5+ygxFQLcWncmImkayzauV0rjuLxGyQ1eYKr+grVqG5Ev0CVXj/p+rZaouoclO0dIt+afTWMx9Ltf8hpkr+x9V0I522CESW7XYKBzGqEK2srnzFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=olONIe1IcfxoeeiMmRevLFQZZOGiT0LONaCz3vBzlbo=;
 b=msYBip0Wc3ExHGZpmnFVVLT2i+/rmQyzKHVADqaLwaIJ/U6fhmC3q54H4wNECcKNEI35kb3GCbRmqP3oVVuxkxUclzYuwCBNsMeT6HhYHplRU0noVXBI3RpnvTB09n5okPUQhKkqQ7mMox+ddbF8Y+UhHt18cmoZ/murdgnZLeE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB6026.eurprd04.prod.outlook.com (2603:10a6:10:d2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Wed, 13 Jul
 2022 06:35:51 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d%7]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 06:35:51 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, l.stach@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        laurent.pinchart@ideasonboard.com, marex@denx.de,
        paul.elder@ideasonboard.com, aford173@gmail.com,
        Markus.Niebel@ew.tq-group.com, alexander.stein@ew.tq-group.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, aisheng.dong@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 6/6] arm64: dts: imx8mp: add VPU blk ctrl node
Date:   Wed, 13 Jul 2022 14:36:53 +0800
Message-Id: <20220713063653.2584488-7-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220713063653.2584488-1-peng.fan@oss.nxp.com>
References: <20220713063653.2584488-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KL1P15301CA0052.APCP153.PROD.OUTLOOK.COM
 (2603:1096:820:3d::10) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bda36431-e77a-4fba-b033-08da6499edc3
X-MS-TrafficTypeDiagnostic: DBBPR04MB6026:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TccjlKo7gnnqlayKnBZq3spwkrzz/8b2IWHd/cglqRyMNkTIy6KBqwwq28yQSJM4cMqAzxn+TVttM7k3W6o81rX1BmBC2zlzsxVO8h+AyuEMV8J86v5RAANPqnN2j/OMylSgeWKSJph4MQJMuuNEDFMh2N+3dhNhqtV7XNxdsW2/TirGCIWMJnkPWBuPIHGYW3lOqOngIG5zypx+GWV4dqK3tQuDC/mZyQh5yl8pR83c8IDoFAfypzFRO5qcA93LDBXJ13FrC6NNeoMZKM2oHZf1fovdr8JcThxmDjn6O3LWwFhelrMpcUq8iJQ3FPHJlxYhTQ5qFJRYJRNsXCS8FwjoC/MsiNZiw3QZpumKQLYZ59ybegO0sEjWERdVLrljyWN34wXXtpC1ASd0+lnHxuqAYtCec3xaJQYxYAmNzN7hOUq+9WX5/v3MZiPD/jFHYrtgBPUuirQnBezaRLx28U/tkRBIwOCHxWNQm9q7ws1Xm1uiHk+R2LZiYuthLBZjaV+rghQMS5FSwiXAb4rMGtuRwgP/u6RrBoxklZAqzfG3cPZ9T9wCwgLFZWKXBu3P1GAim00oicf43SD4XK8/2eib2pbuyczVPx+fA6k4MjRWnQyUofVEqheRM1d9/uo6Fj8usIl6EtQFlXnNPzxfNznXCxXgTz0E6DA8SX6QAI4U2hfIPZqtmp/R+2acd8QQPd9Dglf5PYtetH5jNFNg3u49O5o9YLxreoamUMDgtDvDgoewZMiIX/GLBP/ID2WO9ObmsTVf/+g/xCPq2fbGyNK7ANczkovblytOicqQ5eV0So7I50Qm0BSowZAYqe+6ktvj/aIfErgntKdWg49O/g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(6486002)(2906002)(83380400001)(186003)(6506007)(1076003)(41300700001)(38350700002)(4326008)(8936002)(86362001)(52116002)(8676002)(66476007)(66556008)(26005)(6512007)(66946007)(316002)(478600001)(5660300002)(7416002)(2616005)(38100700002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aPBdAL4ZiwlIa1frRH/I8N8aVESbGRYsTgu0D8jyPvqZr2tjv6WkU1CHgYKR?=
 =?us-ascii?Q?MvwCBrnpGbTUhye9P2TTQ7NeC6KaupFeza7XtW6BfCaK1rmCN3vF2pIcb8Mg?=
 =?us-ascii?Q?45wLx9yVQjBoeUq720EKCuQ8LriFwqIj9x7TrlQgixB7xqMjLthw8u/GHbML?=
 =?us-ascii?Q?h3YOUGHtja4LOKb0C9RN3E5XWS0+wr+MrTc5oEFWFTSRbWPseaB4+YksY7Hl?=
 =?us-ascii?Q?DqAiZ8sqOqHlyYzb68oTRr/idSnZM9RtZamIaNwW0E4umLoY5O1ZaoKOkM5I?=
 =?us-ascii?Q?jNOj/Um+R+zXQwfVHpRX8X+AwJ6Zmi6p91UsxqlwyIbPuheMHtne3BXOqBL6?=
 =?us-ascii?Q?4eGsoChSbAbSo2ATic6Z7gJgKeALqpkkzaY/BtWWJUrUe2ES6hSw2PFSAO0a?=
 =?us-ascii?Q?2ldAFIB9Ka2ydSgFG4OJflVEf9To5q7SRcRGH49QWQwsvbaus86KVrZzdTqK?=
 =?us-ascii?Q?OcJB8kn82aI/L58fhhlLaUis7yOs+HCPtib1voeSz55+o7uw7jHrOu5ZbCRR?=
 =?us-ascii?Q?HvrGgxhLVM5yB6/xPVgB0uLjKWX5j6bBCyR/eHMnRGBwniQKGWgN3iLQHHtH?=
 =?us-ascii?Q?t28JFFvzh/Y2m3/tyOhfBY/7i6rNi4/rSWoGf96kD5rYdn6ekuNf5rK1tKKV?=
 =?us-ascii?Q?UVJyACjqemJ/K4fSj9be4tqczXgNwiCu6moWKsqC+TzJPE/HoQ6ve5uR+83t?=
 =?us-ascii?Q?akcjPWocQHuSRqOBQrWtO8GU9ew/+SDg0pQn9o4UgqAmkCHz/5Ce6oMvetrW?=
 =?us-ascii?Q?qKkULLlCHHnSdtcHE2ko5AKo+YtVHZvGmCiig/lmajfFm36jMhcW4hd90oLH?=
 =?us-ascii?Q?qeYlU9OZvk/b29HO7ycRiyOZPAQQkdrdvH1EvXaSyLzjaxx21ye/FzcmR1XX?=
 =?us-ascii?Q?hpaYbcVF/Gd92GJe//CDTZ0E+OsfVZOXLaUOUXyFzAJudkIkIrUUV1a2AsZ+?=
 =?us-ascii?Q?yfJEtNbd/oQjU6dEn+4jxxQ/gmolfxCLp0mlqgsdDJ7yNGn+EoZDyp74fRc2?=
 =?us-ascii?Q?My3clLhJUVHZ1UfAhv62CWiz7sP0GIQtacbCpWBn7xeCqcsRU2rsmDiw1D6G?=
 =?us-ascii?Q?goJWiyh4dkE+/s2WBFeFk1nJTFNhFhdW2cQTk+zDgN+NLvEVpy9PHeGKYcW4?=
 =?us-ascii?Q?cXtdaCPndEnHg1G9/xAgRf9z28MW/wKYmA8h2End8cjMpguDkCjSqH6CmBgz?=
 =?us-ascii?Q?yYSsQN/qJ9s3V3mDl3mOTIi8MA2kb/o/tZP0m7c8B5QhrtYThI9IBvg2/XHn?=
 =?us-ascii?Q?krNmkcMx8B8ZNcR0LnKyijcb5tTpCyMKFnrdA4GZ1kiAPi5/xAYbTd6hD7up?=
 =?us-ascii?Q?tNWCqIaZlwDQ0piSJl5AFNguQF84GPmKCdynZCD1pvMGI1PVD6h+HLVZxS0/?=
 =?us-ascii?Q?GehEnN+og2275H1gZLajfnXzQ+R76F48u+vpknAMAKtpO4zP8P1j+LoWoleK?=
 =?us-ascii?Q?6TIueonBHMLHiMKymtK6sw6Sp3TzeliDMJ78BL22uAe7LpiAWz3rgOmYtvOZ?=
 =?us-ascii?Q?n4dtSI+p4vIHjVN3H0XJHPNk2eiLUx5fxbCq6kXwk12EjsV2ZeZf8062qE/v?=
 =?us-ascii?Q?h93I1MoE1R3suem4MY67Gi/su0JNRlJ3zA4LVPnz?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bda36431-e77a-4fba-b033-08da6499edc3
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 06:35:51.0019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y1xcRTyrZmLh9A5KULO5odi2n34nT8lW5fyf44e8i3YY9xIkqiKxT0imQJIsgcn7h4y7auqzzu2hDIRaPdwO+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB6026
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX8MP VPU blk ctrl node

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 34af983b0210..493fc3ceec1f 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -1185,6 +1185,24 @@ gic: interrupt-controller@38800000 {
 			interrupt-parent = <&gic>;
 		};
 
+		vpumix_blk_ctrl: blk-ctrl@38330000 {
+			compatible = "fsl,imx8mp-vpu-blk-ctrl", "syscon";
+			reg = <0x38330000 0x100>;
+			#power-domain-cells = <1>;
+			power-domains = <&pgc_vpumix>, <&pgc_vpu_g1>,
+					<&pgc_vpu_g2>, <&pgc_vpu_vc8000e>;
+			power-domain-names = "bus", "g1", "g2", "vc8000e";
+			clocks = <&clk IMX8MP_CLK_VPU_G1_ROOT>,
+				 <&clk IMX8MP_CLK_VPU_G2_ROOT>,
+				 <&clk IMX8MP_CLK_VPU_VC8KE_ROOT>;
+			clock-names = "g1", "g2", "vc8000e";
+			interconnects = <&noc IMX8MP_ICM_VPU_G1 &noc IMX8MP_ICN_VIDEO>,
+					<&noc IMX8MP_ICM_VPU_G2 &noc IMX8MP_ICN_VIDEO>,
+					<&noc IMX8MP_ICM_VPU_H1 &noc IMX8MP_ICN_VIDEO>;
+			interconnect-names = "g1", "g2", "vc8000e";
+		};
+
+
 		edacmc: memory-controller@3d400000 {
 			compatible = "snps,ddrc-3.80a";
 			reg = <0x3d400000 0x400000>;
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 664DC57E1C2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 14:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235409AbiGVM5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 08:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235265AbiGVM4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 08:56:45 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60084.outbound.protection.outlook.com [40.107.6.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE17EA6F90;
        Fri, 22 Jul 2022 05:56:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KGxUf9hohOisCgrXHjiNd3HeUWR5gvzm6yhLWOQXyTH0Y0oUG9b2MjvfwjTjW5Z4STSTyq6tqQq7NJcjeq3OpHJIT9T+M9vMkxJ2WfEXYtpAEYUSfHqk/ClbUh5ITLa1xV9kxRXL+/kzOCX4xqhvFNGllnHre+QsZfhu73W+dgP0qFAp1ZiG1tRSBE6el3jpBzZCzOJN1Tw+hui3hm1+EMofgHh538pXL+QFXefTbqRiZ5VUt+BvZHv/CoRhYEyaTBhYcFYAPu8lzk3m2csEYkV2IhQylOSj+ecjCnp8q9yhQKCQc1MIKxbBfBURvo9KS/13XcXvc99wWNshTFWpyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1AorRxksbXeVxubLoSc+lsLswoLaLtAUA5dm1bM1U1k=;
 b=MI9D2rIbLFZxJ+Mh5v9NgqAi+OWVad/DLlADqvOR6cXx+w5URUP5NJsq8ylVFNGeJWxLR8+n1d103GHbMvf7T8aYWOBpXlthP989khCDxzIRH7NQ8sapAY5KYeoCCsyn3qnyKx+q5LoL7RjdPE3Q7ykU2wFgiGAWuesH6zNUKGZnPg9v5MRC2pesDy/l9so8Uox+yk8SYhABkeYtIiIxKzN24IkJc5vHH2tLu96TJvMlWXaxzbELOlaYZW8WexhAzSJQToh2O3DvIH64Es00371goGp66nDFrz+KpCxAqF+WONVF2GgXG1aku3JZh2sH4lChmGNhvEuegf94rH0hQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1AorRxksbXeVxubLoSc+lsLswoLaLtAUA5dm1bM1U1k=;
 b=ERz4ifu8GYSWWqH1zNtp4ofrdkXKQRmSsSmwxmWDll5giRCW91AS0NJOtNfm3Gf/7t8qZM4wge7y7QjrV8HlMvzbqKgzsY3UHrkgq9ptubvUaMlUkmM/vdixOpsT6mVtwyOKOxhUaa3lO3M7FhA+mATLhruupk9pdaqAm8knus8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR0402MB3565.eurprd04.prod.outlook.com (2603:10a6:803:12::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Fri, 22 Jul
 2022 12:56:35 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597%3]) with mapi id 15.20.5458.019; Fri, 22 Jul 2022
 12:56:35 +0000
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
Subject: [PATCH V4 7/8] arm64: dts: imx8mp: add vpu pgc nodes
Date:   Fri, 22 Jul 2022 20:57:29 +0800
Message-Id: <20220722125730.3428017-8-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220722125730.3428017-1-peng.fan@oss.nxp.com>
References: <20220722125730.3428017-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0019.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::31)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b43ffd1f-bb5a-47cd-d44b-08da6be19b7f
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3565:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0lpMRLqqQ8zt/oeKf93AQR7xvcdTkw6qRU9IK6wtoKXG9CjdDHsG7vm7AhGoINCN0bYrdvfpfy89qFKN6qFvncrRv72DRJf4EQbk14+Z490JgVMFvQXBbw1PXi0vnDF+ExEMAHsdj4bjfiA1R+YvbzjcFbU41uS7bXgpm6RSKcEO3QduewMNxSYQwRvs5V4nLSTvpN3PIl6ETMrcizNYcZBZQv52QpZKm5m1RpIpv/k8klL5ukI4aZ9CKgJ1LaoFFvI+8+X85Iy21j5ZXEU5qbC+feFmunyEzrO8MhBGunTXtgj6Y4CctA5Yd6mY78mfAy7TSSU6j5a2eaLqV1ZKGdoejz8vx8sf54Fw6OQ6VFmUi2s0wg/BTKS/v+YmWHFKZ8HEBD+zY3D5PY/P5QndiBmcQKDZIhPWmke3785TUlCgkrtkgHJEvq4UhCZJDbLg5huOz1Iq5YIP8f4MFovkDxEaZpye6dzl3bSrhAQZHRrq4/onG/JqfkgytPOuaUuurqnBi8ScrBZL2S7+tgAfkK/uA2CgRwJpmNqWF0EYih9TMjW+Z92DrkrCJAapQixdHL49BWGijTUoPDsqHhQfCJSob3Pe8gB5NXqmbI03qlcyfJ1QeFlBIsT+Dht2aXHCqBZCMaDydfv6iIRt1On/l3PlNqf8T65w5ADsWIiV0te75kOoyKv8Srk7avXkjSswKKOQS9lzSe/WgRLcS1Es+H+bB7Tc3CltwG4lKIr50qzDvNcF4F/UmrFfOB+qdngBksYZzTt0jrKCvOkLzkKD408Sji1M2s+uas9QhrlqxthuUFcuhbnrJh0VmjrLNzzwDBckF2VYD/ZjRvvB5e5nhA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(376002)(136003)(346002)(39860400002)(2616005)(186003)(1076003)(26005)(86362001)(6666004)(38100700002)(6506007)(6512007)(52116002)(83380400001)(316002)(41300700001)(66476007)(66946007)(2906002)(38350700002)(4326008)(7416002)(478600001)(5660300002)(8936002)(66556008)(8676002)(6486002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fmXwCEBSxJXBFHAhQaIiljoXxNf1WH40ONKhJlt47HZmQfjwUBpH0Q8ZKAju?=
 =?us-ascii?Q?gHcTWLPjW/ZShz3BnPP2hwsl7xVSEgcYa9n1Fqpu1gxldV8Z0APECHfmt+rV?=
 =?us-ascii?Q?Wgq6+dMY1kPMgNB/Cgbk9YgqYZKMGwXJf3Mj60bnPzZ+4DlMYjC45AwEslRf?=
 =?us-ascii?Q?QwaLWCWF6zQiX6GgvwhLonYmX971G7HhjVk5NHEKKpus0X8tl+XDdWOKuzB4?=
 =?us-ascii?Q?nvH24DAKOGQWY/OeV4vjrTQYgyiHoq+35VZwdMnPXF95NuXK66ijUX65ZBE1?=
 =?us-ascii?Q?+VDRgYMX+pGFK5n4x/WgFV2DpEa6vt1Kn19NnYC/4nMUF6Tn1n2o5SgPzuJa?=
 =?us-ascii?Q?SceHIrNZCInJxMy+pWh+nWwoU0Au0VuZ9Y7qTWTGtuG/MYCQKYF0eMsttjgb?=
 =?us-ascii?Q?nHQSHUCkrtJiib/0p9jMXI76af3FVdmdCvZoRZhQV/OV8/o2wiiFTXWXBnEa?=
 =?us-ascii?Q?UjkL//aPP+XYyOdJ1iiUsWi0LzisS/ljyK24uBscPEApfuzdQZO3DVOW9zlX?=
 =?us-ascii?Q?TApK6gwV8Gw5wmr+rsOZJnN8avpzs+9OEy7NrbWXouyZoXqzmjSrKZbqxIlE?=
 =?us-ascii?Q?jmDxAzxaBl8mFTeTJ7bZ7ZHv71darwWOVHVFpvK0h1lx/Zo1ku0lNXftbW0J?=
 =?us-ascii?Q?ceCPtJQM+u99IgDqnAj6d9BTJrNEI0kYKeC6KGNHG61FVjb+LKdHlFo/icpT?=
 =?us-ascii?Q?lP+Mgmeh2P/hatSExgItjM7zjzvQdh+wHZiLrOwh7DrnCW15tS/cAqZXRF3o?=
 =?us-ascii?Q?wDdkcColWvPLJoS9f+s1RTXgN9OE8Y5PE3oIgmGacxAjTqcIJf4IxtkyNJMr?=
 =?us-ascii?Q?A+rYvfcn78VAw72gy73gsgAV0hxYZU5f0gD4iC/b8vzvBvgU2kLQqEps0R1V?=
 =?us-ascii?Q?hHBkkPbN8AxcrgsB7lWPTrh1+yMJX96n1/E27m1an15QnjyCw10v/p3p2KEu?=
 =?us-ascii?Q?y5zI/5c+Mmvdhmba0549AZITyCBw7PF8McHQJF+KJd47wClSgrdU0aRFXqu5?=
 =?us-ascii?Q?FYCETnjEcf8YfTV0txnUkOYM3FEVlfuSW2O253C33cyDNm5p2HHFMhwwLcK+?=
 =?us-ascii?Q?fW71YEySyy3sY+Cm6rlcAt6mySOP1jU5kClwzv/Q6JeuMc/MchFwdNJvZfCw?=
 =?us-ascii?Q?yEePqdwikBSgXa0sJS5tTVKHY56FW+6HPintQgoJHCVU+EKXtrw9LB3Ge1IF?=
 =?us-ascii?Q?6Ihw4pLQ5N24D2sksBB466FDvTmW7TH9OLEk+Bq3iEdcCBLu5Bq2fLLUVOEo?=
 =?us-ascii?Q?DgHUxD1gcjvXwEeMdnHtycYkxvNsLBNmQ+lH0degOYOPRILODTnP6IFOTatU?=
 =?us-ascii?Q?faWJXcJC0Fw/oFWFysFkiYTvekKhRiyCAhqg0KxQaXRmcWqIQf1I7yOtPQ26?=
 =?us-ascii?Q?ONA/iwGF45TaAEmrlXGkbAQUcEm3VC/jOtLizlb+7yyoxT3vp+EM8uU/wnWd?=
 =?us-ascii?Q?UlhFdb06u+hp+vkfWSa2QKU9zNN6wp+6ndwHRv5RTcgVKKlxdfJhSDRY5hkD?=
 =?us-ascii?Q?h93fxG6SFrGItVRc5aILfi1seOJIxtcZoZ+awlsVJHXBXCLdbwCsQ5Mxoabl?=
 =?us-ascii?Q?0A7RpPhfbvQgivFOB3YXF73ggmgwWOKp6DUb+6JL?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b43ffd1f-bb5a-47cd-d44b-08da6be19b7f
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 12:56:34.9818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UdyBBvyCJy6+j/SRl2veDO9YIXQZgDVokg+PJPJ6ejAA/ZkByaaQuPqE/+IAAxrQjXeygBFRxNFeW6y9Emfbdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3565
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX8MP PGC nodes for vpu, which are used to supply power for VPU.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 27 +++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 0b165f98a82c..34af983b0210 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -598,6 +598,33 @@ pgc_ispdwp: power-domain@18 {
 						reg = <IMX8MP_POWER_DOMAIN_MEDIAMIX_ISPDWP>;
 						clocks = <&clk IMX8MP_CLK_MEDIA_ISP_ROOT>;
 					};
+
+					pgc_vpumix: power-domain@19 {
+						#power-domain-cells = <0>;
+						reg = <IMX8MP_POWER_DOMAIN_VPUMIX>;
+						clocks =<&clk IMX8MP_CLK_VPU_ROOT>;
+					};
+
+					pgc_vpu_g1: power-domain@20 {
+						#power-domain-cells = <0>;
+						power-domains = <&pgc_vpumix>;
+						reg = <IMX8MP_POWER_DOMAIN_VPU_G1>;
+						clocks = <&clk IMX8MP_CLK_VPU_G1_ROOT>;
+					};
+
+					pgc_vpu_g2: power-domain@21 {
+						#power-domain-cells = <0>;
+						power-domains = <&pgc_vpumix>;
+						reg = <IMX8MP_POWER_DOMAIN_VPU_G2>;
+						clocks = <&clk IMX8MP_CLK_VPU_G2_ROOT>;
+					};
+
+					pgc_vpu_vc8000e: power-domain@22 {
+						#power-domain-cells = <0>;
+						power-domains = <&pgc_vpumix>;
+						reg = <IMX8MP_POWER_DOMAIN_VPU_VC8000E>;
+						clocks = <&clk IMX8MP_CLK_VPU_VC8KE_ROOT>;
+					};
 				};
 			};
 		};
-- 
2.25.1


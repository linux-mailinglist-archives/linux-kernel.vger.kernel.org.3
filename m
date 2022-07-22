Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1376D57E1C4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 14:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234532AbiGVM5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 08:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235296AbiGVM4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 08:56:55 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60084.outbound.protection.outlook.com [40.107.6.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1954BA875A;
        Fri, 22 Jul 2022 05:56:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M3j8BO5AGbuii3vE1NU3nfZngnUePGJJlKUcNj2a2EptbfgY6kFqmo3s/KL6qcDoSGJavjLnywInh0tICUZgYQbCE67eR/MGlTfkNQp67Ti1slO/Qqvd+w/aYjlk29uVnwokTnfc3AkfKnOIIS7+8DhgRI8KgzQB4QzcrxRLJOhDqmXcgAC/ZFSY3bSnlgWvKrEEfuxiYb34hmhGjJ7mgnfuhmXCXVyBYu3EOYCwn1DOKyyL8kFYc0gDhreQGfrVypxR/fE75hg9KsquFEzF2zWYErHv0qjc9CZ/XiDDpbZTRnW36DZL3pYVVXdKhMTNSPpq7KIVE0YFtHkzMty14g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=olONIe1IcfxoeeiMmRevLFQZZOGiT0LONaCz3vBzlbo=;
 b=jG1kTKoaZnwxLQQe1NBeVB4NpqHwTZn2Dz87LD5XqE3GjfqI51j0VVe/bdHyJC4QiaLdT4cfEUKX6YO42wFM/o9kSZyBicph+N1c+a6Gw5rpkii6CEEc+IYOCjNQjqXaeGLwg5Ez5zUeeMxKcU3euBkyF7bvmX1waybMne5rkn0YvWq4vfZU5xOvtToHiEgFhux/9/+ZiwXGfDs0g2K0APjWYfv8nYSdI9klhs+2z+gtiohk+I3OwWrOA/h1V69MOs3AgGM8CSkmFbumW4DgVmMWQCbRTZJ3nLiGgMZuui3fX7yP1Ioy8W/qC4RqU5Dc/yw2RoQo3KVyUQWpf/XDyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=olONIe1IcfxoeeiMmRevLFQZZOGiT0LONaCz3vBzlbo=;
 b=mRka0Zio7P4xQuGE7B1SaLCeIIN6CHxLffghPL759TZhBhi+5VZCtkatkU0B2M0C9MRaKpUIr0xmAbJASWR6E8pRmvZCt2MPMmUlEIx1D6SljnJ2vkJoDtxRHzZrxWS/ZkED1rULAcm6SKEd+dTnzn7pdXcKiWAs10ulyc54IMc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR0402MB3565.eurprd04.prod.outlook.com (2603:10a6:803:12::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Fri, 22 Jul
 2022 12:56:40 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597%3]) with mapi id 15.20.5458.019; Fri, 22 Jul 2022
 12:56:40 +0000
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
Subject: [PATCH V4 8/8] arm64: dts: imx8mp: add VPU blk ctrl node
Date:   Fri, 22 Jul 2022 20:57:30 +0800
Message-Id: <20220722125730.3428017-9-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: d239af66-8c7d-4775-4f73-08da6be19ecc
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3565:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lXAsbYGfMe5qu6guOL/fNs8BYVuSHYKytyMFvZOqesTurCqsntldcTA1ZAEZvbyY5SEqFOgZiBo2unwvV2ONX0jYDu4/HCZkARySVS4WvF24enVBx1/N+m0IVCMEuqUtQjkfNiBGkWx4ahiEQE1J6jOK7U4lUsnWlbm/PZgk8yJeY02Fi8w4UKzsnd1abJK4nmy1u1hYl0wT6sEv/6+FYVghY+sF/igWiwPBOJlNoDGbg8SSP35wdgJBCuktPQz9j5C47fmrUZhoZ5thSwR177j1MHSlkm7vsoyvHAclCNUPb5dwxbEQQ93rffHxUjK7Nr6HqLywH/PNicwNy5YVS7Pov9PeqSdf+FHNGW1pvoG84HKWHdm5w/yzDhCCm+/3KPKMZILH2f3ftfaJFWxiLHB2lufPj8CFh30rBXio33Bax1eSXPF3ZBo7hY5XalFMb4Ppta/L3dsaX4IgXTBxtS58pZU/7v4KleUIHWTaZnBjjql4mwZQ0OACe2D09WsuVapfy0yCB1L17yaMssJ1aKYWzAfZSRYPhpTIWhWlVeb7q85O9CU1GJv5AyIVhFVmTrrswL8Y3unTyVspGfHzW2jPoK2ZAEkb/xoGNmDHEliG2eAGz8SD2P8HQQrSuSYMfXRr5Wdzh3JhJiuda4aZJWQHnTpe0rACCPt+tB0tNoy08bOq1Sw20J7a0yyKVcRTAgH6nZa0oRVmpzzWgk6PfVqJWeFrKGI2I0wAzjrHAUvygsF9DOZ0Aj0kTW7c3L3+JCDXkylyCqPpr4jL2FxPliYqw5m4BCkwJ9lIwxBQKTZD2R/RgAzEWGA3+lt6q7jJKuEOd8zgKDAWONVnQYHzaA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(376002)(136003)(346002)(39860400002)(2616005)(186003)(1076003)(26005)(86362001)(6666004)(38100700002)(6506007)(6512007)(52116002)(83380400001)(316002)(41300700001)(66476007)(66946007)(2906002)(38350700002)(4326008)(7416002)(478600001)(5660300002)(8936002)(66556008)(8676002)(6486002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OyOG/IAYIx8frFuTs5y62+Bbv1mWKUa+ecqKY1HUYCpCPPKTGNO7kF/mPI/8?=
 =?us-ascii?Q?tCwjxsA90l2JMR5pf7ORmSNCCc1ZM9O7MVHLytOw+DqeY5nWoYSEfoGzqmhy?=
 =?us-ascii?Q?NwEFNIEf3v3OId0Ttq0S4j3o7EEPYQF7X6zn7ygguWwn3YGPJd3TwGQQJb5a?=
 =?us-ascii?Q?OdYqoSpu5UtnrsR58UBo3PA1d5U0K2oXx2ZtiqO2/DNUpgvbnDe73Cb54cnL?=
 =?us-ascii?Q?HnKYB4VZxuMxwA2kPrj1zIhaN3SbofN5R3W0sn5LdEIkTdIbdNiIrA+EVKzw?=
 =?us-ascii?Q?6OhBECs4K3SdgP0eSYeJNrrWSi58M22bMRJORvuLxrjUHJIE+tGFxraX0K+M?=
 =?us-ascii?Q?eimaarR15v5mP5CgAgEjBV0xW7MKsYvYlBs5sEpyKjyN8gchuXQojZrtmOUK?=
 =?us-ascii?Q?Eh8nvtX2O1z386EX1eAY6e/IlFewEni91AclDcspY30h22ZsmACRBZ9QXF3G?=
 =?us-ascii?Q?tfR2Q4+dnQmswTd5JJtXKHoUswWkec+E9nqqhygb2S5QKZIa5YQtMdmifQE/?=
 =?us-ascii?Q?XmBvdBNo8Dl1iypI39OtBIiPK5JOQlN+j8ZoFZbbrpnWvOlkNpccJa9clW+O?=
 =?us-ascii?Q?e1i61+5P1TZt7OuGwOjP4rfAJsY3YE9SFdXE4MpDcdgeyDkcRIWNdiMmnSGx?=
 =?us-ascii?Q?VpguRfuSSkXTcIW7q/KJicmIDZvK666BJ5e9UhkPhyqGFjUGHbLy3iSU/ZzS?=
 =?us-ascii?Q?5g7NGoKqXR9WD05MXdwzLTmea2xSP2mPe4RjWDniVckhB+bWipcYTD28bG/T?=
 =?us-ascii?Q?mYAkC3zj1tYrj9wBFxs714lIYpXkdZSvsJtu830FDvOYUHD75uXr8CErNd3g?=
 =?us-ascii?Q?+blbMH7ZdGbcS8T15CV3LqjVDE28j2uOh9i1ZmZ6ao9bcan6tcn1DCCuJePs?=
 =?us-ascii?Q?Za3Jn6aQKqVm0YAS0MFLcqkxz6y+xfXQsdRmHG98OdVZonnCtIBNxIOsKy9b?=
 =?us-ascii?Q?98By8YRQJm+ipiMzms66DunyaKHsHqzj4x3ScgFH2uDpIfcWynnluvIOghOp?=
 =?us-ascii?Q?eBremPixUnTFII44OsUi+LjEihinmM82FGcIeWvmQDYHa6hG/5tq21EqvYEX?=
 =?us-ascii?Q?OY955xFDxczViSlvAoU/GCgtTIiuq5/icQ4LlHWwzaIU+TE/NpwFZ6hrv28a?=
 =?us-ascii?Q?+Phdq04cEkW0gQ1AiXGDC1mcEuoak/Hu77jDJnZyKw/Ry/Jtv3nGV0LRawJU?=
 =?us-ascii?Q?zbrm5vVPqhtO7ql2zcRL0LXkz+glMKNmCH4gQ5hV+Uu0Vc2oyLnIprpVOoBJ?=
 =?us-ascii?Q?Zz+k3P0V1vluJKsqaNA+OoieXQMrRRrduki0/B4KNx1bbM8lNwu2fOz368EV?=
 =?us-ascii?Q?UlM/zBZXFblc8Z7EAg3bEV14gWtLKHyEyS2/O5Xs+c8oThyEfWdg17fPOqo5?=
 =?us-ascii?Q?Kii8061C1ABwXrWwRKloIYtQim0MtRTkfGMuET6S/yrPYFou8n5rb6UTtJtO?=
 =?us-ascii?Q?1lfxpluH/rRH19Wyqj0dBbJf9mdM1xiZ5Ok3A7y0lqJbTWYm2/DmG5M8Oavd?=
 =?us-ascii?Q?PaiZ5ADYc1SXQFBIq+7YStReCI8WRtvJkWqxd4NyZN+L+v71AOrrXTuk4n0X?=
 =?us-ascii?Q?6xGRJky5+DDOXy0LHEbdFcDB0Uttf3LxB05Ddz4D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d239af66-8c7d-4775-4f73-08da6be19ecc
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 12:56:40.4537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hEshmW5lvUhAwJVSO/IbUYABWQB8Ul/yfHZIiAOXz0JAjly8qoCNcNh45H9cJGaqhGZQiDmPMqweTnHkQm7nQg==
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


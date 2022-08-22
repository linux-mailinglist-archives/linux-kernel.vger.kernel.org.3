Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCC459BBAF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 10:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234019AbiHVIba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 04:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233965AbiHVI34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 04:29:56 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2055.outbound.protection.outlook.com [40.107.105.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA3429821;
        Mon, 22 Aug 2022 01:29:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uk0PQHoFVfvFfo9yXLQxWRRI232bRZchSIVCQ2jmO8/1YbmAXrmBMRWL2PHf/HhncwtvR//y3fp97e3NpHu4+uz952c/9loqmgGKxVldbHwKsWnT5w43E6h+YgzVdpg+eim5YclJ2xBPFe3scW5fvo7N795jwkerAcfVda1An/Z0a3yzbeaHtr40LwwD8MNYoNGtvP1uIU2+IkXDIJTHOTeWyVxS4SOd1ckPSCPx2nWBc/9Y42ZYZ0Sh25eRsqAZZdLvzoPmmEXc/Fs1RnmKJV7BrgQekuLEcQyuYFB6taOw5OyP0wpKvcJL01wzfHKgy4+i5sBOsXlxQTNf/2Z9qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iINQD28DzOkRmE/tAFH5kLwvRi/YffQp0vo5JEZarNM=;
 b=hcOq2DeXDMWpuM++wwHbdVtawRUvYvyggUgGdqGeEGr0TanyDkzBpOmkgJzVMvmoZXG51n+8aLc2qTmbSM0eS+brU0n+y7DhbujwJ2yV9eYHwWTfHti91RsM7O9leXP5wayFJTjC9y3/H1sto7hrwPk/rIeAkPMNiLxXZ7VucCUzQq/7sQJnSYaR+o5CoXdJoMpwxgMGV2SDPA7xpH05+hoHjfcGigx+BLJ22hVcX4knUA4BweYOYRQ4wWMswHr2aYf7SXMquDa6FudhkB5lB3mEDPkO/ODkj/HP/gGqOqJq4DDNkuenWxqn0opGVdhFtQlDG/fvEOekYu3homBp2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iINQD28DzOkRmE/tAFH5kLwvRi/YffQp0vo5JEZarNM=;
 b=dyr5ju/psRDNqNtux+jju3lnp2gdp2eTXeqH6Yo2yEXShi/yCxzdLaMafi7dchIaayujWOELtS+ZzpsfMYXm468bni1KwlkpDWiG7oxI1JeiqKpXQz1yMH+fOrF/cS+6QQIUdJHjCJmV8OejUJ12mm7wnAHM9xyHUvi2MBVn5nU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB3997.eurprd04.prod.outlook.com (2603:10a6:803:4a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Mon, 22 Aug
 2022 08:29:49 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442%6]) with mapi id 15.20.5546.021; Mon, 22 Aug 2022
 08:29:49 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V7 5/6] arm64: dts: imx93: add src node
Date:   Mon, 22 Aug 2022 16:31:05 +0800
Message-Id: <20220822083106.156914-6-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220822083106.156914-1-peng.fan@oss.nxp.com>
References: <20220822083106.156914-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0041.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::15) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b1a15f2-ce03-4636-2d16-08da841879f3
X-MS-TrafficTypeDiagnostic: VI1PR04MB3997:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jpQQ4A3U7VyjfZ8VqV8XddIQlKJd88lRaSnUz8zkmEOY0BpfSbaCZ0XDt1/Iu2+cQ2KhJvjsynjaRG7YMOC4A4Y9Jt8l2gxgvyrY8O2+87OQhzCZ2sGMd5AjmfWy+L2yVMVxvamGtlIAstWiiSk96Psc+AgrEwdIHrlr9GIUMIULobfe40mQQucZVkYHraef93nqGvO1b6epsNJvxd6JQ83Jx4RfCS57dFPDYnvRnxwQOkANm/xIH/zvqiisYclSJKMXcNscoPCTrIlec8LaNlCzGHj6aHoh9w8I9Z1VozEEC1N6FvYkPA2UQlIipXlDU2bzO4sl6Cj1+iBTdmUIjqbEqUZUbNoufrIumC3Efa1ubaZTixLXM44MpvyTJNfLQTYN6ft0/Ijhqw7RgDd0bCP0O3QzoOxrjz/xf9yez6WN/sFC1I4t4OHsvelZN+ajIC9Utbtk5oomu/EwT5VbmGLCNeprVR7bw4k2FGhu8iZwdd7bOTS/2UTkYBc1PNqxH7r2iz31Bt485gBVwF/GTuDG7Hsv+jl35vFoNAm8YszmIqBDE6i/0eYhKj5rh3TsNmPN59DXZ1yfSiW6ynO3qk33vzzfcCWTU+iyeqI1jLF628oGdN+vSaesTkPuXIdut5NbANId5i6xyhfTFgzXZM/GriGP6+d45nnvf3KL6ZM6juS4fncaYvo2fdM0IzAtFqlJxBq8VNw0StIyQLvMHnNcArJpiPfgw7jbAMZb7SPHqL077x69uaQocms0827f8uZDAYi1M6ZBEIQzNv1mlQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(346002)(136003)(366004)(376002)(83380400001)(86362001)(38350700002)(38100700002)(66946007)(66556008)(8676002)(66476007)(4326008)(478600001)(6486002)(5660300002)(8936002)(316002)(6512007)(26005)(2906002)(186003)(2616005)(1076003)(6506007)(52116002)(41300700001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?73jBJDHyyGOt5Las3bjNUBYn9m4ev6E8gnpNPBOvUITC6SV5xYQDbZ4FKs7f?=
 =?us-ascii?Q?IpBEtb06yOCWFQd28uuOXMZ2fYa9lkmADDDRHoHkMqSCt2w9OXriS+niAkbv?=
 =?us-ascii?Q?XRc32oOCZ1Law0ZTRXP4IZZkqRFnYWcjbTAnXTkC6bT1hixLDKZcAAxptyms?=
 =?us-ascii?Q?+aV1GKQGlAUHoYk7/F+moW4+Iscvns6J/UTKqovYv3lMh28vHveNo5VQycGr?=
 =?us-ascii?Q?b/pTTqdM06pnRC40QGD/9fBnZFEpgCiZF1VbqDE7A3ientlvwD6HZ5cv72hD?=
 =?us-ascii?Q?jatoKAVT0F59T4VisaE42XOdtTDm6M523k0yEsEfxI6ieq+arrY+oTDn1+ES?=
 =?us-ascii?Q?+A8WLTyOiRS/SOeshE3W6Byj3REvVHNXtgS/zfgxz653jkbpLGMN00bGx1c4?=
 =?us-ascii?Q?1J8++89LnQGcGYuSt6c1Mh4s3JkDXnaRrNGZRqmf9G7vFJUSYbxhvUaRZJx6?=
 =?us-ascii?Q?0NUmjxJ90L3lB+5tLV7ZxAmW4ZwvaeJo8x0hy2ER2EiIE0aBOTBbz1GZV1hD?=
 =?us-ascii?Q?SyTNm+XHvsrY/YGL9BP/gYLpHk7D1CBuXNd9Qt7PpK9HAW9Hj5oBq29hoSSV?=
 =?us-ascii?Q?r+t8Cgp+qOZ3zuWL2se3RcFyZtG5BEhkG6SYo0e2rV1gj0uqpovjFzpGV53z?=
 =?us-ascii?Q?xkYVjO7YuWEyIwL/rungmKCU6z0cpy5HXDsGQ3P7Aa/3Hfoa1Jkw1yEoYbAk?=
 =?us-ascii?Q?3pGXeoxWNTinxVqxi+XRjymuAVJzC3v71uo3mtS4XorjJulPjctjxZJggE/B?=
 =?us-ascii?Q?2JHkt1oNb/JDt3y3Z7bkEjMXYiT2AIAq1XyK9oXtyTViM+3c3E96M53yIx1i?=
 =?us-ascii?Q?fPaueE/bJDgqje64kEFQ0VGyD+xrC4jAVkpIBuqCQ7uOvmJpkBY7QIcEVAnp?=
 =?us-ascii?Q?HIWOaeRiL8jNDfXzzpPC3FV4Yd9/T94NZmNDzK9tHlXb80hhmH1s3Dz7Yd4h?=
 =?us-ascii?Q?WfcXdxI+bskzQQX5t9abJjw1OUOlT4wShZ2FHDiU2isfPKayi2n7C+W87Yer?=
 =?us-ascii?Q?V+HCgxDMQCCBcNXFFKUcpNej313GuxeHu9zjjj88FwgKQRFzIOBlfHP+lcP4?=
 =?us-ascii?Q?6V991llOaLpG97oJIBg62B1qLJcBBKCJD9m8QQTQXjP+lwawq54RxJhh28lU?=
 =?us-ascii?Q?nmHpfBFC5Kn/bjfpFnDunCNyAy32jywdKE594HLINUwILgFsM2LtpwkoVz4S?=
 =?us-ascii?Q?F3CAY4wu2jq0Fpt4PeSuL60S+hlWjlIaGt/v3/5W6rSsW7NVdWWMClKuXM2E?=
 =?us-ascii?Q?xXnhkFonugh6foLMIYIpYgT9gdgO47tsASWEgZwyXPsBRt4+fPIDggEf8Lsa?=
 =?us-ascii?Q?ev/IJz9VuzslRuPPc88of3WpYfhWU9/j2Wi6KwezuWqQOPD/VUV8cXRtNOtV?=
 =?us-ascii?Q?4ESroPZtmARvDyskqM+wTtCfOhShvc14E6iUUKi1KromonjIf7CCEfBNjUSb?=
 =?us-ascii?Q?Y1g1g4dga7agH8n2G081auSsHJA2cuSMGXPoFP7QFu/xnktDCn+0k/UjjfHK?=
 =?us-ascii?Q?lGyVy2QA68x8iJuYDlrae6He0ui8N1LLaWEa1D1NmzNhFDmQvut4yoaP0Rp+?=
 =?us-ascii?Q?EI0o/HnXzgPCJ41+VLl1UDUjFYOm4Lv0sFME+02z?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b1a15f2-ce03-4636-2d16-08da841879f3
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 08:29:49.0001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OzVUf3N6AcNv+vlWRnKnaMs+migHO1Fz8hfEW3lPsBa6UAcfm9eNo03rUnFgG4j26OADrd9s85m2KsVQKrG2OQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3997
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX93 SRC node

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index f83a07c7c9b1..3281b554ed92 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -161,6 +161,30 @@ clk: clock-controller@44450000 {
 				status = "okay";
 			};
 
+			src: system-controller@44460000 {
+				compatible = "fsl,imx93-src", "syscon";
+				reg = <0x44460000 0x10000>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges;
+
+				mediamix: power-domain@44462400 {
+					compatible = "fsl,imx93-src-slice";
+					reg = <0x44462400 0x400>, <0x44465800 0x400>;
+					#power-domain-cells = <0>;
+					clocks = <&clk IMX93_CLK_MEDIA_AXI>,
+						 <&clk IMX93_CLK_MEDIA_APB>;
+				};
+
+				mlmix: power-domain@44461800 {
+					compatible = "fsl,imx93-src-slice";
+					reg = <0x44461800 0x400>, <0x44464800 0x400>;
+					#power-domain-cells = <0>;
+					clocks = <&clk IMX93_CLK_ML_APB>,
+						 <&clk IMX93_CLK_ML>;
+				};
+			};
+
 			anatop: anatop@44480000 {
 				compatible = "fsl,imx93-anatop", "syscon";
 				reg = <0x44480000 0x10000>;
-- 
2.37.1


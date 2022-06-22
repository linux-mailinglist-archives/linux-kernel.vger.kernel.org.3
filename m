Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3F85542C7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 08:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233631AbiFVGPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 02:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350717AbiFVGNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 02:13:22 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2089.outbound.protection.outlook.com [40.107.22.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB6A11F;
        Tue, 21 Jun 2022 23:13:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=doPLRMljrW/I01x1asX6MYv3DkTkctUEIEVjKnbB01TCvsCgJK8Wn57gH0hx1ao81u/akDbFyT9ay1l9hhJ56NZ+jbgrgCuj1AkcpkfVmjs9GiwrzhR5QbWOPojZEd1/Xk2whJvs7kMLnj3zVCskwoxo+u9Phj3TW9M+hibMfvd5682kv2+pXJRS0YVbhn8sA77dHn189mG04Pp/pq5c0ZUWhuSt9I8ftjyeEJ8Mw8xyp0IkbyAKyrqEWY8OM0dOdUEJQqVBPggrhoJYaHXTE+mt/UsB4MsEVcBxA3guYbRpFirIqcXP31MwJm1tP96ia7wlyzLyGo/xYTZ5yl4wXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BrfXRsR3KgdwDO3XObCii6ggB6ARSCA6KsK1KNKNVgg=;
 b=MTkQ2S1BqHy2VMOvme53GzJAzzklUKlQvWnTTLhFpKc1w0PsaVh0MtQ8SYnUhpfCyHQDwItTbyg21mQ/s9OKjZS5BYjKmUmu6eea+wPSaZnhaUPmlYOi0EhE9NaAkluR1Gt9EnPCWIeLQ3mBTTrh4E7CM63BblhaGmPSNq6R/FaDQKVjBarLEmaLI/yK3IXDn2Kp7uDJVGNtPlmOJ0jPqihKmRQo1QebCe7r5WidIH2SXCbazn4bh8RSYWBPh2fxJvfreoUmU7+YtIb75acae3RUUKmgqhZDfqSO32V/oE0mH+FwlQx3s9l66UiTQHZ3poGadYl0pUjVWXVDvvwjpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BrfXRsR3KgdwDO3XObCii6ggB6ARSCA6KsK1KNKNVgg=;
 b=LB1Q9LZD7PAwCSRDmCT+ASD/Y5QP34/8Bv1JK1rqTW3881YgTi5nIBbHcYnzDWbpclT7fLbrOFgCqqOnrSlk2YZanbMohA0X4Ouv9pkNjHZBDLC2Q17FqW0WitqQpe1QT4B4Fiwj+Kp7drb9+WaKo9DvKmVbWwRWPyvaQ0uYXuQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by HE1PR0402MB2796.eurprd04.prod.outlook.com (2603:10a6:3:e2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.22; Wed, 22 Jun
 2022 06:13:17 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::71af:d414:52be:d531]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::71af:d414:52be:d531%6]) with mapi id 15.20.5353.022; Wed, 22 Jun 2022
 06:13:17 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     festevam@gmail.com, linux-imx@nxp.com, hvilleneuve@dimonoff.com,
        l.stach@pengutronix.de, abbaraju.manojsai@amarulasolutions.com,
        jagan@amarulasolutions.com, matteo.lisi@engicam.com,
        tharvey@gateworks.com, t.remmet@phytec.de,
        u.kleine-koenig@pengutronix.de, t.remmet@phytec.deh,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 08/14] arm64: dts: imx8mp-evk: correct I2C1 pad settings
Date:   Wed, 22 Jun 2022 14:14:04 +0800
Message-Id: <20220622061410.853301-9-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220622061410.853301-1-peng.fan@oss.nxp.com>
References: <20220622061410.853301-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0007.apcprd04.prod.outlook.com
 (2603:1096:4:197::19) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47039ef7-36ad-4d44-6e7b-08da54164c59
X-MS-TrafficTypeDiagnostic: HE1PR0402MB2796:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-Microsoft-Antispam-PRVS: <HE1PR0402MB27965E8246E157871DCA61C9C9B29@HE1PR0402MB2796.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LjL+Hca/LWPjBLBEPb4j8TH/nvNi1nA3ipttYV2IdzL3OBOCYuzUYO5RCUZ8qBUY5weLppWHjPDhmSgOf1MwAMK36HbjXltgPSf7h7pZI0Li1dWxvZZVz97u7oAevNbzgpvxGeqE8oQntTTLZ0OyGFyzKMfzQvU/NqjbaOD9UuFLNoO1T27EIEIa9Q5W3dDUr3O70uEziKok9Zn0aECqpiJyInRvI04hBAjyhMzHb9KDoxt3bxlO6DClxYRP9tidt4VvtXwLbSdG2k71MJvqV0gna2HGowwZK6DTaHameWsVzDnIAWkz8+Xt7nMwcsdFiDRotznnx7VTBIyyUNrD10+rpLKzeOqZpsV4tBta/GbUcGW/hnWcjdnrK2SKpFEFzcx7ixZjgZzO45cC3XeFtnY/Yc77tsIOBuXl4nu7GrFq26ovhHW8Fm2ccugDu83y0YJ61mIrBCu5Lj3+AVzsT9p+Rni0Rf29RIBBCNZCqMvoHdEH5aKLymR9pDIsVy2Pd6vmEiQrwvyqwnEukH4Prn53A3otbfOOnJMCh6eAEKHLiSqnHdrDe30s5AuLv8TOOJ3u04c6CB6NsWWnAu9Jk+vR/OC04REAre2/9iVkja5Xv+kbPSYEuV43Z0IgCZTCefo1W/VaXZ8mHsCMX/25xKXjFdLUskaKHb1Nw5qO0RgWPyd0DaRpabSWajpvewwc5PlG2D1uwfzOggX+ck8kUvkIZoPX6LOL069bm/1NWoWusEP0/GKcSHsiiTmYd9/95izDNB78BU0cvaMX0IT93TkaGAR9MqghqIyq8MyP/mY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(366004)(39860400002)(376002)(396003)(8676002)(478600001)(4326008)(8936002)(66476007)(186003)(316002)(66556008)(1076003)(66946007)(83380400001)(2616005)(6486002)(5660300002)(41300700001)(6512007)(38350700002)(6506007)(86362001)(26005)(7416002)(4744005)(52116002)(2906002)(38100700002)(6666004)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9+AE0ekF00e5qm5Y745CY0cIu0s6WSAkuXl/Kc6XDeFGK84I4HGMuc7Fbyfe?=
 =?us-ascii?Q?qOldLjbu5EjwoYz0QAXJvZm81b86HhbXEPRSNn/cvBW/Oh7Ip0ZYFAuxLAdS?=
 =?us-ascii?Q?n6+Fx4TUcltauuzmp0lNXP3TZSJ3nbx/4uEfIO5A4GOjuC5t3lHctJH7hx2h?=
 =?us-ascii?Q?jMXSP1si2cx0RLQIkDHlqvrEWXSlkvuj4FRfOPWUz6fc9tFHFgC2NbgrKeiD?=
 =?us-ascii?Q?6wFYG9f67pqzueLFeVBytyjiRWE9Sls/OOF41OwB2bNa5iNe1zzvMxPVK0Mu?=
 =?us-ascii?Q?zYHadP+whPpcYTsfCo/KnyglabXIkyPkHkc3YVD3jQK4NN8Uq9feptUyK0ha?=
 =?us-ascii?Q?eh0jLrKWEIIY2ssaZh4DX/9HtH91G5ey5ke+ZG4EtydQtiFK3W4FUGCNEWPL?=
 =?us-ascii?Q?WzQg4aOUM0ajiTyOU5rv05g8QnFTQsgTIRlT6O4GJAJU8WBjF650Vrpe2qyT?=
 =?us-ascii?Q?CRpNyoBsFhwV5IeQtez+DkrDp3o2NoGDQKahwQyjBxtPMQZ1DNjp8opacMDh?=
 =?us-ascii?Q?F0nNYpXWVKDffdXR6ZnZP6g91qcdNpzI8BhEj4E179gQAjfvJ5YOlxUkxg5V?=
 =?us-ascii?Q?Sogj46/pz2Y0CZxrQsjtSWk+nOcSLrHuiNKP8iIVOcQl0xAwLxA7CF8143oD?=
 =?us-ascii?Q?pnCvsjnA21FK4csULo2sq3eSBOmx/J1eEai6xELp9kihF+XRLxkKmcsbOXJP?=
 =?us-ascii?Q?6+TB+RD19npmQ4DEN/6v+BlCqdynA/D0ZYHjxFL9l7nl4x1frovhLxec6RIp?=
 =?us-ascii?Q?acZwq6S/WJCUQJMBJtXuIBeIhU1AozSahB8gXBuseJHkeaTrHNOTRQSiLeBb?=
 =?us-ascii?Q?FOwGz9NxMwEyW5c51B198pe8zge1vnweD1WTVVz4e/C3QaEiXss5WJRA8oNd?=
 =?us-ascii?Q?3kFJUb+nd7ncCfI7xl6ABTzWAx7eT8/wCkFrmYaB79adk2lvmCOX+QbKGlG8?=
 =?us-ascii?Q?HRNbpG+lda1AWCRoamhLUFI3ZqcEOARE4lEk9mQEiB8KlsDB0f6eQUuZb+aV?=
 =?us-ascii?Q?MSYBHpVrIkqUCk0oZZEvGkCAw9ceWnTIOp4G8oNSt7tb+/mao/WYkFfwy4xE?=
 =?us-ascii?Q?Mp0FJOxkTgVe9G722aeTaBVj2uofggBDi3mCTq8HLay9Xl+lEInJDKsbIJd+?=
 =?us-ascii?Q?KhlbxonnM2Ab2h8CD43BYJgK9kN+pG8iqDjU9gZFpN1rZ9ZYubamXerMlSIo?=
 =?us-ascii?Q?9RhwOw/PjoloMQKkDAZrGqDfGwZXloaggiceEH497qW/o1xm/tC9qn5xGyRg?=
 =?us-ascii?Q?LnQw+oW5urRI9rcU4o0qIwGq2ZLzpYQHUjIK5XrE/2wlozWD5qGyr57l2ALX?=
 =?us-ascii?Q?WjprFYV06C20vcHEis6DUWv8Dq6MotgbsBZS3faJdgJuARd621IosiD3skBj?=
 =?us-ascii?Q?196i5ahHNfagTuxQ7lcBvLkymbI8UXsRSOmcBQQeWv/psb4Bqx2dprS0M3T5?=
 =?us-ascii?Q?llucbwP+O0hdcT3gaEkP1bkkjW30RtIMICtVkFCu17NrieBbypvewekGuoxK?=
 =?us-ascii?Q?Wo6gHpD1eak9j7wLTTGUbCdHwB5FBD0AP26cW4Ns99jQe7GVqUjA2/UNcxtd?=
 =?us-ascii?Q?oMJF7+Pyu877he98dmWRZ3KMF3CeI8PGMt0MUrntHqv7+NkmvvFrJkj+uA8W?=
 =?us-ascii?Q?zKDKx44VwUTDBsVM+eS5JUCugHe6LiaWn+Ohn5E5FT42yZ1qv473u09RkO3f?=
 =?us-ascii?Q?mBXe4k3aLoyfY9TtymerB1f09IveXYvCzmgE9Vw1IN71dFANeDiU3GoB38FS?=
 =?us-ascii?Q?N4OKHxAvGg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47039ef7-36ad-4d44-6e7b-08da54164c59
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 06:13:17.6726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gYuF0FYnlBha/74+htw6xynVvYhDgRnK33Vu5occzo4p+YuY3eAL3omtGiSo3LfGb/sySi6prwz5Cpt19SJ1IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB2796
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

According to RM bit layout, BIT3 and BIT0 are reserved.
 8  7   6   5   4   3  2 1  0
PE HYS PUE ODE FSEL X  DSE  X

Although function is not broken, we should not set reserved bit.

Fixes: 5497bc2a2bff ("arm64: dts: imx8mp-evk: Add PMIC device")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index defba22da183..510f10fc8e1f 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -483,8 +483,8 @@ MX8MP_IOMUXC_NAND_READY_B__GPIO3_IO16	0x140
 
 	pinctrl_i2c1: i2c1grp {
 		fsl,pins = <
-			MX8MP_IOMUXC_I2C1_SCL__I2C1_SCL		0x400001c3
-			MX8MP_IOMUXC_I2C1_SDA__I2C1_SDA		0x400001c3
+			MX8MP_IOMUXC_I2C1_SCL__I2C1_SCL		0x400001c2
+			MX8MP_IOMUXC_I2C1_SDA__I2C1_SDA		0x400001c2
 		>;
 	};
 
-- 
2.25.1


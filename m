Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99BED56A28C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 14:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235816AbiGGMwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 08:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235737AbiGGMvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 08:51:38 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70049.outbound.protection.outlook.com [40.107.7.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07992BB11;
        Thu,  7 Jul 2022 05:51:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mmbj2yVUEVear9B9dN6akjaYlS6wd+WXern9Yjl01gV8zL0L1m0h2gXSioKPmDk1AW78YmamiuGKKcrn1nilImD0U3EJWRdsZtbKZxvPchD27uIcrGVXAZlMfdM2zIYjotN5nhSRdb1gLoQS1HWNoLKctR9RSWuOPMQZ7smDqBKFVRFRL2q3ph9zoYovQ/1cypjEAhzAuWHSjQ12vZlIWnWjZ9MukqdMyjYML3GKVSFY6fPGHSB4jDcCjp89kQugbLgaKKwLckEfwT8zUm3HJn5SMj2rYbr3QSFxJWgU4ofwGdbwVSdwaAwjm9imH2SP1P3Xa4OLIhGH39v/qmuyuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/rSBLwEg9Ywy/odhIL35m14Ux9xPXDXGX4gRctHFqyI=;
 b=AXdHErPVtksJutobEqD5WzDQzl/9bLPpLG0Af9ueqU/Zs5+FBwKiRLsrzE+NkaoUeb7rXPoXEZjUmedEO2FGGXck90NsUme7/SMwps7/bD2ALDEcNJjPAA0U1U/xFdvPJ00+ag/TOg+f2bEjNTiwGpo09aXj6yYyY+wXTjYTQhN8S6qXaD8+Ae8Qc1QYQxfXa7clRrhZ8BM1v83+p3Q1+5IwT9bH7+XHrMhT1tsRTUuL5aUXcFZ/LvncSEJ5/B7CyExji8V8FXiCNVASwPuqdQBq9X0ByOqvAAUplJmYZLEs5UWtbkw7STRoPxn/LP+rcfGbxRcguZzie2/Z/a5ZoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/rSBLwEg9Ywy/odhIL35m14Ux9xPXDXGX4gRctHFqyI=;
 b=ZdoQXvKr7RumLigJwlcbk4Wuj6oK3xNS2Bmrt2mlfu0i1fev0WYJqkzv5Ther+p0qIdNPX4Y6wBVAQ8qKQyx5nI0WQ/MX4KBf5gwYQzKuR+Xxe/xUNBojx+yHhjji+rE5/BbRuK4Ks0Vto10RDug3boUdxEKL9MK1om2xvxHuMs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by DU0PR04MB9276.eurprd04.prod.outlook.com (2603:10a6:10:357::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15; Thu, 7 Jul
 2022 12:51:34 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f%5]) with mapi id 15.20.5417.016; Thu, 7 Jul 2022
 12:51:34 +0000
From:   "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Viorel Suman <viorel.suman@nxp.com>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Peng Fan <peng.fan@nxp.com>, Liu Ying <victor.liu@nxp.com>,
        Shijie Qin <shijie.qin@nxp.com>, Ming Qian <ming.qian@nxp.com>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-input@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Viorel Suman <viorel.suman@oss.nxp.com>
Subject: [PATCH v8 14/15] arm64: dts: freescale: imx8: Fix the system-controller node name
Date:   Thu,  7 Jul 2022 15:50:21 +0300
Message-Id: <20220707125022.1156498-15-viorel.suman@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220707125022.1156498-1-viorel.suman@oss.nxp.com>
References: <20220707125022.1156498-1-viorel.suman@oss.nxp.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM9P192CA0026.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::31) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4878a296-4454-42fd-b215-08da60176c46
X-MS-TrafficTypeDiagnostic: DU0PR04MB9276:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BzqZ04C/O8YrC7+kvJrENW1xsVzGFZrNoq3kVX5qyTRITcOc5aT0ebHlXBCivk3iZgcznQvbSR+2P9Lt6vcDTw2e2u8pCFftWuE28Eu98XPXd8aBMEA3w2cP7pUQW9JMF6UrOlnI7t/aVnWFMteSoQzVAbmSC8Q++tLA/7Bmpub5SYFuUe+L8G+4RV9tCi1Vz634EJyn4rRjptTjR5Wzsla8xMLFciGctXKRHpEP1N52jmTEK/MMQ+pVrmOQaLk3VZE1tpCJ1GfqvrN2EbQtyRc+T/VUSY/XSg5TOzim69HP9PqIL3a+HuhJIeKJhJ7H9A1zqZ+CUDm1jQn9E0H+ibVZCZn4AA5GUNSTeMrEPwbm+uk4ZjJLPjLn0NHBmy5U/6ZsPdHKL3BKkHI/sePJaLQiKWrwcc44ls3VAxlaNQymZJasERTHEzJFylQHipvFbvcQTbQQdM12uc4eTP+jQwr2LnoGQs3KbrXlKtWKgrBKpW3yisVHLMW09QT3F2iO8Eva5D5t25JqGBYxtXzCPiiScVctoG/u3e8D9Nj7sAnFe9Sau7KmqbAgJV5B9OztZVUXwz3mB8C2Gy9ZUY1mCUucnrn+ffz3CP2JbFyk7sakUCEaDrFhHIGTl+rcUkIIxK0ZZG8uXTrRxgpg31pJ/mQosk5Z7Pze2Osd4Lld+w+LZSPl9iqbEGsghxw4UvoIkS4djZbT9JsVmEvWiDEPFf3Do24LohSr9gUjD0y5K61kwG2ELioBFp9EPNcWOioSDIjPv447BSGAhtcw2IHgTsJZ6bWa5qRYzyzB+3ahZQBC2//d+eQT2QTAeb7tfDQ/cRoi6i9tPenP582PGhmQOA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(136003)(366004)(376002)(39860400002)(921005)(5660300002)(7406005)(7416002)(8936002)(8676002)(66476007)(66946007)(83380400001)(6512007)(86362001)(316002)(26005)(2616005)(4326008)(186003)(1076003)(38350700002)(6666004)(478600001)(6486002)(38100700002)(52116002)(66556008)(6506007)(110136005)(2906002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?bS4yipvH8QMz/djWC64Uzv9cY81zDgN41M8yuaX4B+4li/7n94cLRB82CE?=
 =?iso-8859-1?Q?fO7oN1EdYu6bs7RdLDG67ISz2zwixX6CK8qyvX8qumADcg3oaHOr5jR1/l?=
 =?iso-8859-1?Q?VzBg/p519wwRc5PotL5J8UD1gaq48SH9KynizvBQvWfkTytSjjX0DHQK45?=
 =?iso-8859-1?Q?/n7O5n7lJFGmPE0MC3ScxKJcCa2tJIP3nb3dhBWX2q2PimNsbFPHqbQFx5?=
 =?iso-8859-1?Q?3NVwEXM3H0BFjhcAg5bnhoeUB6naxzu1dWG182O8gIaQMmm565B+30DUQA?=
 =?iso-8859-1?Q?iNvJzl30wOdoC/uTexSoHl9uGxzSOvIQXvX7lWXYPsNfSSORCFeYvoevEa?=
 =?iso-8859-1?Q?/iyryTi/r+eU3Y9YlAqkP1MGX8WrBvGgZDOgvqlP+0O9egg6o984DnSB8R?=
 =?iso-8859-1?Q?fW4VKMkXaz2CEWMaqg+l6VRaIws7LXpCfqxdTSTSF/Mzsszl1aLsCXcNyp?=
 =?iso-8859-1?Q?M3pfqFSeAB8QRA0XJBhTnyw2+qllECHP0D/vor9IJnwz3lfvUm8YzWpWDu?=
 =?iso-8859-1?Q?Sv8zcnWhiGgLT9Jnd/Sk6LgScF1vBILC0w1sfBuZZrYI5qzBH97yE9mMsK?=
 =?iso-8859-1?Q?3OPU4IoxY2bUCmtbFSugR1U2ci5l0FhXz308C0LLfwtJkHXYa5H1W+1sK0?=
 =?iso-8859-1?Q?OGA05/iCJkgSTdPmRSP+fBsQcLeGccYwsnem28D99rOxdroO1P87QmX+mC?=
 =?iso-8859-1?Q?ZWeUTB/xwmgR0U8BD9oZAued31lLWvh48wLV0lTESqOP8siach/O/Q1oeQ?=
 =?iso-8859-1?Q?GKmy3EBBoKVZmB3pFa6RcXtnhIj7j6JAfIw7J8FOi99gZlHYM8Eqs9DTSM?=
 =?iso-8859-1?Q?kv7buDcFMa9M9RKujGByGLDOyTkt0Sbfk0LHLPLtK6ZHuB1URcwaOj1lLE?=
 =?iso-8859-1?Q?BXz/kqrZfjYctTq49+AthTnykA/1lOeSsJ/Iuem3tC8vfVTXokSg+va+9M?=
 =?iso-8859-1?Q?XZwYP8jRXV/SoyGIVfk+gau5FsNQ6Cj6Zlmi+erAtcAQ8pvUmXMQ7fMHfH?=
 =?iso-8859-1?Q?vAK9yU/bBWMjzPO7OyZx/f1P4/ELFjywnFqISkekSbWMB3esm2a5jE8zJQ?=
 =?iso-8859-1?Q?IJ/rxoJoqeVtBTpx4Vg2jDzADLFcSxzJy/12xrBxIvNeQFIqtLD3PlDSk6?=
 =?iso-8859-1?Q?1lgC0pWmQp/zbUsXjJP4+uZianu4ZqeHRT79bVukD9oUHOTWezGsHkegLP?=
 =?iso-8859-1?Q?fV2tFAwYlXIdzPo4njhBx8XH90FlOMigNcGFFiX3Ci2YiiyN4ZgX2Jt7+a?=
 =?iso-8859-1?Q?PAvdbj3e19OS92hv3xlPtXlnx2/NhwyLmpWXo+Ot5Sp5XW0Jdczsw9oS1g?=
 =?iso-8859-1?Q?pBWUCsgv6951AAgURZJDFYLqnmz2/KFE5tQUS+zNymfPoitKp923ZqRjsz?=
 =?iso-8859-1?Q?IdW2ElPKJlffYbIFUPLQnGaNVKtihXtX92lEDWeYVvcLbgI2+Ay3RAxiWZ?=
 =?iso-8859-1?Q?WtV6C0D3vzA+QAuWnHweDXbWMWnAKw7/p5WFJkDNlgxqEFbUN1+jhy2P4S?=
 =?iso-8859-1?Q?d9a6WrnFvThAs3eqdBfaH7vL3gtW1WcK24v291KgEiGtRNytgk+xV2F13p?=
 =?iso-8859-1?Q?vtjmkN+zvIJdQElczI2MsO2b17Ouw2QseQXZuPaXJGr6NDpu+ljN7WMrTk?=
 =?iso-8859-1?Q?9Xmn7PXVkpgAn7UCcFD+9ymwh6Y8O5c0Wd?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4878a296-4454-42fd-b215-08da60176c46
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 12:51:34.5467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d85e7fiqfrhju0n8neiYZLW2saXrW8wXRLjc4tdVTW1IYBWAPPZn5TyJg4V7Vwr24HY667rwiUd6VYxDKW1Ynw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9276
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Viorel Suman <viorel.suman@nxp.com>

The proper name is 'system-controller', not 'scu'.

Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm.dtsi  | 2 +-
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm.dtsi b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
index 5ad1c9a5933c..c9c2b6536233 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
@@ -181,7 +181,7 @@ timer {
 			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>; /* Hypervisor */
 	};
 
-	scu {
+	system-controller {
 		compatible = "fsl,imx-scu";
 		mbox-names = "tx0",
 			     "rx0",
diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
index 563a006ababe..ddcc0131b861 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -201,7 +201,7 @@ psci {
 		method = "smc";
 	};
 
-	scu {
+	system-controller {
 		compatible = "fsl,imx-scu";
 		mbox-names = "tx0",
 			     "rx0",
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0626590CCF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 09:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237566AbiHLHpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 03:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237545AbiHLHo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 03:44:59 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00042.outbound.protection.outlook.com [40.107.0.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C60FA6C04;
        Fri, 12 Aug 2022 00:44:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S99uCF53IEBkarWdgIyayTuMbdC12eD89IFppnCbnXzHL6mWjkRNrf3dmLET6qb2Pc5thRPuTtJT6pOzVt8K6lqAWlKoAdUP+xe0bBcfAZlexAzSjECfZbt+q4M39x1Mg5yrDWHxYLuWUyMKSbYifFJNO1ktNTl1A0DS6j1B4vwmUHItH3oRjSduv22jXVXm5heDPh49mR23mY+xsecMzoq+v3n4mdIAfNT6s6WEnnJnqDUMsbzdKgMbxFtTMqvNKmi+/7Kdnq3OMdj+1aV2sxg6sxoOK+ar4H5sk5x6W5IX9UXULn56T+oLpOcyfTfLY9ngM/yLKDHvaPrpiW9z4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5tjp7jpfTVqacF+23CAlu6sgUJOG0mkNixtAs9B6ArA=;
 b=OkUj/emZZ0pDunF2W+Gn1cl5Fo6LpbKp0OOy7/VXzImiuEpCkPDKLyjiGX7F9oqKiTMVbvaqZ3M/hqJldJKf04Vj/SnShsIQKUPo/Q46WqbPknAJIIr2JxOOFeikCIiEt21zeW77qzh8JO+lxnxeLgp5/5TD3m2CwbUaVLv4Rb3Vx0Iazz50JZHWjTmvIgM1p3Er6usu9AYEDIZ/XaJ65Zvzf1acVyq3Fpfwjw71S6AJZ+Zv450C+9XnsSjBiRYmn9cskayKn2bYe4iB/wZSnf5Fq9+7Kx2lFZ4oP0fPbqQLGr5cb2TMAXMKT2Ijscv7I7WeYf2U+UqWb0+c1jbhsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5tjp7jpfTVqacF+23CAlu6sgUJOG0mkNixtAs9B6ArA=;
 b=lAkGxmFO0LC/tZUi1Vg4KUwd3exs55lHEAsqfgpsJW/e5TBdRjTZEWTAXwPI0GtQQ8mcfF4WtcSX0HaCPLVONU+DwYd3I/j9yQ7fXN56AUwaeNo5V0jqKJqAVUTsTXoSfAwA/NH61EEq51Z9Nq9KZB4mPC6tvKE/J7WkRIcHgLQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by GV1PR04MB9181.eurprd04.prod.outlook.com (2603:10a6:150:25::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.21; Fri, 12 Aug
 2022 07:44:50 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442%4]) with mapi id 15.20.5525.011; Fri, 12 Aug 2022
 07:44:50 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        Ye Li <ye.li@nxp.com>
Subject: [PATCH 5/7] arm64: dts: imx93: add a55 pmu
Date:   Fri, 12 Aug 2022 15:46:07 +0800
Message-Id: <20220812074609.53131-6-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220812074609.53131-1-peng.fan@oss.nxp.com>
References: <20220812074609.53131-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0032.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::23) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d00bfd6d-6584-439c-4879-08da7c36893c
X-MS-TrafficTypeDiagnostic: GV1PR04MB9181:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NLtgAjbV2HcajG3l1S1jOQTFhe9vuwiGJikNyh480CORXY9wsUnVnVnU1D4R/EOTdAV/d+nTg7C94Wb8QKcw34yiwjD4o1hJ6jNvEgeA9023V0HjVm/ARcucB2ec69FbcMeeAiLb60cbSq7rrD9nLatbRcLGUrLs/eChROs7yiK9fuCYpAIRCtg4jfcY51yXBhf7ZBgmA4fQy+9mk026aBqBPcA55+BqOSmexR2OAXDt0AguCpgALhoqBswZf80Wk1rOwNJBJsmppvVBcQSW153qxMjluH8mdvUTCjf4sK58/e6apZLYlP65W3iIXlxaD6SG7kcXx1mCvarQsOpE6rHj4P7fuecetd0ICzhzRmiGlrNQVay65H3UTi/sle1N5XOFE4hJnImKm4SU9DVDX2yZ4RigLzklWhfCrziL9OZU2jqVCCAO8kktviv5OxTRp3wuGPVA+GtCts8GjJ6t6vYK1pCJsTyshc/SZaoGjYKiBHByFShjXLxGearWQ1J1RgyF5VgswGPRJ+y3dTl3jYpt8kc5uZz0R3/1FddZZ8xUxntl1a3L+UXXgLSF9moO/2uf/dPjob7gMKwWtLK/GWvEkAwiPZPIZEbvY3ysaaYHNKKQhlhZxT2M2DDZhWyWNODblNAnFS1Bae8e3pQ5hjITbff02dXeUWlq4OGg3sa9Ea3cdVRm7OWr5RUJuPeOO1gejIIWfdDCglBUQ1ZRiqMkUhAl5BSH7kfmHDQ9Nya0hb8wbdr9RBYRA5qGCknGl3qQVG6fFMPV9CvqWLRnAZH4yFhusZfHrnyDh0GxLhA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(136003)(39860400002)(396003)(366004)(38350700002)(38100700002)(2906002)(4744005)(5660300002)(8936002)(6486002)(83380400001)(6512007)(66556008)(8676002)(66476007)(2616005)(66946007)(4326008)(478600001)(186003)(41300700001)(52116002)(6666004)(26005)(86362001)(316002)(1076003)(54906003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hh++oY4XUX6ZEtq9SxkiijDB0/Z+QyE0BPEzam0/OHn4knQjl/H9bDGUAiS7?=
 =?us-ascii?Q?hjcOFxABngiXmXv5tdrQisxjhnTjlmBoTpKMrOsSx6Lk9TR68SpG0vl9qw+L?=
 =?us-ascii?Q?y76r8z1hAdgsXpIwfajys0jP39v5DHGjVtLI7QKVVz554jf3gEUskI6f4hgU?=
 =?us-ascii?Q?16WVJY+LGBaZx3z5CWb8/Tlmq7cSy4vPsv/dlCXTP5p0ZqQ1Zxd2JMOpz0g3?=
 =?us-ascii?Q?xfrQtY4blsAKuytLl9Wp4+TRFbn8e7/v7ajYEvx5Nt4Yv5IZ5H5NMCArO0yV?=
 =?us-ascii?Q?fKiNuRbjny1rhim8vvyQQPePMor8Na62KDRWrSNNbIEWkpc4vOHgwBI4O4iP?=
 =?us-ascii?Q?Q5MhvB7xUbNUWW0EoC8Q0B42DPgFZOEujUy61tCMqk1GBhokNyahqK6bI3Is?=
 =?us-ascii?Q?2b8EVBwNI+cI9DMBsJFVPKy6esf3tCp/0N642fLePb95/2mji17f/3YOBLJX?=
 =?us-ascii?Q?AQHEn/EDD20kFEyqJDHCDE5nAedl9oVFi7NOCSU4kx39gPtC7vlGZt7wqvhN?=
 =?us-ascii?Q?MO56jROrhJjSjkdONIoSSHk3c96eg3owyYYE7vuUo+qZXJxcutN3sHTs8PeS?=
 =?us-ascii?Q?97YuUW+ST3SxECp45zCZunvZAuk0/S3zsQ8gVlYkKlzbkJFoL9q/tM4JOIBP?=
 =?us-ascii?Q?Js8HBBS8FEmWk8Lj9LNwoNE+tVVSZARwZ5HWA2e5veqURUDP/FXWmTlVTKZ7?=
 =?us-ascii?Q?Q8OxJpj1lSp7HnGrmXDqI0sOvoCiaIUpJ7mAaVDoGqGXLGQifLjBTMdPGexa?=
 =?us-ascii?Q?9rpHc4o80qvPpoEorgON3AxPl8Ge7q+FNLwl7Vh/0nqLtw2O2uuXsinJOa8N?=
 =?us-ascii?Q?iXmD1YiFFfXLj0qOVT+75A4NwMJYWdr3lw3o/ZycgJJ6VCstL5T8j2ENDpPh?=
 =?us-ascii?Q?bxLr6sJWwCIHjWT1IJGcVSTgoG5gY+l9EETcuWw8kGElEQ9LDks0rKIcL6U3?=
 =?us-ascii?Q?o7p/lMZSd4ROlB878DzWzF5DmQYRrcyT2PZxlO3dOnjKOdW9euUVz7zt1Y29?=
 =?us-ascii?Q?+m48CgCiLzOtmhbpypiG55mF8r15fEablttLO6bJ0ginsr2qOHYT90Nq84Mw?=
 =?us-ascii?Q?n6qJXFvS5FKGkVVZHZ7vpem3f/icKoLrFiGtYlYDR7806ZMSIQ+HLkFcf7ES?=
 =?us-ascii?Q?N4SC/LcUpbfzwQ0ielUR/ZTMMPbgUhTGu2HJUK+obpZfgU1eMHI5lqHd5g4W?=
 =?us-ascii?Q?a8Yrxo10oiGmdQeya2NnxojU6RnZ+Yerjy9fO3kJJvDO1EfOVexnVmib9sdZ?=
 =?us-ascii?Q?fGx/Xk7l4gL1HpC3vHD2cTsI4mxOM36FnVCIZChIg13Ps3hVl1OMkfWAGuLp?=
 =?us-ascii?Q?iKmkXWjeUgblzecpejkTZgxkIzCw7Hgp2noWRXYAj0wS2foCCnWsJ8pkPVsm?=
 =?us-ascii?Q?Y3oVdlevQdqdBTp2DV0ziRT/VYVGaLzfwdui+ZEckEnjERzmbPjRl3PYXgDZ?=
 =?us-ascii?Q?Q43ZeRpgRPD5qAwrz7i2vlo4eSgH01qwNiu/jMkZa2QXY3WU4M3M+gkyHSa5?=
 =?us-ascii?Q?eeWDyhvusH+Vc2AsN3z2NMRX+zNo12knw21nHobbvFgv/HuTtIzt9kgjrZ0c?=
 =?us-ascii?Q?Yy0avfYWC10P9RLBA0QmVERathCzcCw8Ug9K0jNJ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d00bfd6d-6584-439c-4879-08da7c36893c
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2022 07:44:50.1997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e7nn6pviK+Fby4r+ufPICOyi4xs3+Vl9SFkRrhat06YKt26gYZaBJR0Mj52AJWz3M/mSRzVma6J5ykCUfXAoMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9181
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add A55 PMU node for perf usage

Reviewed-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 55f396723adb..fd687d78cd03 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -72,6 +72,11 @@ clk_ext1: clock-ext1 {
 		clock-output-names = "clk_ext1";
 	};
 
+	pmu {
+		compatible = "arm,cortex-a55-pmu";
+		interrupts = <GIC_PPI 7 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
+	};
+
 	psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
-- 
2.37.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F096D5ACA2C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 08:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236636AbiIEF7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 01:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236387AbiIEF6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 01:58:50 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2052.outbound.protection.outlook.com [40.107.21.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687B225C7F;
        Sun,  4 Sep 2022 22:58:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KhM/vHxmsPglsAxXMCL39izjiZzduJmInNyKR3kr+cYt3eJBySVDinoueQKw8Xvk+ASLouuivQrVM5IESXBchEAtIuSl/CJBpxNPBFGapcmM3a4yGNegew6PPz1Cw8lT47CScuEbOp4zWibW97DDEbdojN61FtC8HkLVKWMyxWH+tCspTQymVuz2aRZ0Q2kX8tKMTt1oSQnRQ6FSluShgFOmQcfeSuJWwZ39UmYBPL8Jyv+2WZ13PbuFGLM9IiDc6uBkRm1EvpixtLNZVg5h3bNKZHODEe4nPujjaq6x9nwSSpqqcwPGqZostFv5P3y62caDnxiE15Q7OzX+ZSkzqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FWYlFfOoGhmqV415d1flSJPGU/m3dkeaty68wBgRjrM=;
 b=b3m8se48eAo23c1xOgZr9a/k1gVPz5iqCmDtELsXINSg9+ZhhvqLqQySN6Uh1EWJ37pe4ondovk3J68wy66bYcBQalihZJrPlxQZmFcZ6pA+oLSHjtunwvywdxJOSvgUtuKeoNgyqIoA3ksFccgqYowljeAYaQw6nYaeGqbHBpcATEu1JwU5EXaep00v6ulEeg/YSuU5g7hBTcO+IRyDW9xWktKfNlW9IVhR6fiTD+7bfzXsaH6Pf1IkwTc6A62Zbwc2AOUzaKTUxiozV3iXWTIuNggqgzgUrjDn+xoyZhlWubRgHlv8iHCkbnorQuJqmlIqxexPr4JCZM/dtNm67w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FWYlFfOoGhmqV415d1flSJPGU/m3dkeaty68wBgRjrM=;
 b=aiqiC9EYz4NBC2XAfUeFMQw9UCgSBRZfAwi6HI8/fQTdBgNLoejygQKWo1QZ/Urbky8MiuGaydIQNpO7nL5elUMo/ECGbpdmvZ6HNCrzfaCAI8ZSBzrI4NhjDeoO6+8ggZcQdN3vQvKlHNEuSicbO+SEEuzhlJMXbxjVj+ylKOo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8740.eurprd04.prod.outlook.com (2603:10a6:20b:42d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Mon, 5 Sep
 2022 05:58:06 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7%5]) with mapi id 15.20.5588.017; Mon, 5 Sep 2022
 05:58:05 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
Subject: [PATCH V4 6/8] arm64: dts: imx93: add a55 pmu
Date:   Mon,  5 Sep 2022 13:59:13 +0800
Message-Id: <20220905055915.3878000-7-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220905055915.3878000-1-peng.fan@oss.nxp.com>
References: <20220905055915.3878000-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0004.APCP153.PROD.OUTLOOK.COM (2603:1096::14) To
 DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 693e06c4-a2a9-43c0-0439-08da8f0399ca
X-MS-TrafficTypeDiagnostic: AS8PR04MB8740:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cmNun5gOQgkfxvOPo1otT/qtStXSZCewQd+rhEnMNnVBwIn8mF6EaALPNZZH0Lm8XSUs0+j7DGA0ZSeJX3tSaeLxPBccQZO3PojF2R51swBatiAMJ7xxDZni/cKdF/CY+tnQh9zbwNY/Fx8ClZjrw/sYR4Zds4zgKQJCeUZZlh3kRKcP6/jTXCn8+BKdJA6/yfySrOfRfBi/RwwJEnlCg1waXlYQNCNapTihqXe69lVN9OwRYOkk+RUlCQ2rqRBGYamU1E+FNN7XF8mk6XgFPcUPpN9FStra9dBX86K9XsZQ6AAwBtbbTpokA621pys4npz+/t5dGtxg/6PRuKV2EmU8A2l0aSvyDAYIQlfFJVPQtXn0OqVwU6wB4LYT5THTIJkxrP6oqNvVoZPv9ht51X+yyXrUP8zxNQXB+54yi3lNh1uR/x/NLjShwYvdUZHlx9uc/PWsndy+BX+AJlxSpegClH8hDozoL9cs/UcQbpvK9ZzzVDWU0vwz7yFr0MlC2yraWpvkisb1xzulkDn9VgWBKAw8BQEgrjbBh4LBeh9GH3O0E/da/z6gd+vhGiF5CMVyQulYirysZVEzfaZmMDRpqcFaCx3kZo/QWd7TP6bJiG7RIxt855HyA4YO1rUOu0CYVU9tTdtnhXcdHCrCzfSSENMpet9gCKf7WUh7QkygE3eATVH3f5wNlzShDbDGWJWanDLIjkpKnMyRaGPi+PJfW1l2dlrP9o6ffBmZQ1B3fX/NTqAChvvMYZDuq/yiyXzYIaSCWCBEzZxBZ52alw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(136003)(346002)(366004)(396003)(2906002)(83380400001)(38100700002)(316002)(4326008)(38350700002)(66476007)(66946007)(8676002)(66556008)(54906003)(26005)(4744005)(6506007)(52116002)(6512007)(8936002)(186003)(2616005)(1076003)(5660300002)(6486002)(6666004)(478600001)(41300700001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y3/PXspOaV3dtSByiJrgwCmRPTIGLAiPtIDlC//z9k5xht0m1wAGq645W84P?=
 =?us-ascii?Q?P5QhqJ8YUEAZgNOyQTj39NB4m7Icdham4gE4nOAy6X+nXTQ95TbZoSjaagh0?=
 =?us-ascii?Q?EqZyMU+L0A5v8iWuO3pMtRxKXV1sfTqj6i32t6mROsp7wXa/J0BHLpf0VZXr?=
 =?us-ascii?Q?Fi/jOfRugBMEv7UzI6hz2x4rqp8bCvp1L6h+iltWaSST/ZwSKsGBa5ZV68Vy?=
 =?us-ascii?Q?8XKFYxgkg7/PW+K3xSNrCnf2DCEK/FyllNPLEBpKd6o+OwCfrjYK7C5+GY98?=
 =?us-ascii?Q?b1M5zy1NkiTDse7dNuE6jQ+OYg7biwuT8eUMAyzIBoFF0iEv0IEQ9KF6R/fy?=
 =?us-ascii?Q?kB3E7X03JeC95RnpdEpHu9azjvJx3HI+CaaiMnzYzdpHrhpX525joi0zo/9E?=
 =?us-ascii?Q?SMj3jUB/LFSpy3HxNnZf3uj+01/rpVcUj5EYxQ85X0nuPwPcxiXL4gNVzfmK?=
 =?us-ascii?Q?9yutZPo8wtawXaKQgzKlnkCcP2oBOR1tzH4klSyh+d7a5paj2YZnF/JA0xnv?=
 =?us-ascii?Q?CxnkAIS2dgVypTNLecE91iL9FWlzb46IIs62hdGp6pZe2XFMqKzpfOE3ePHV?=
 =?us-ascii?Q?jkvhKnihlpdUL1vLjnvrjMFCTYMt5NE5+cJSrOrGb2YSagTFLQ8NUeYrpV+I?=
 =?us-ascii?Q?oWHbarxWjrQ2TACJ2cm9cQv5cSF22pb6lqHA5Jbdb/XmoTtqCDzDqgFbE/2Q?=
 =?us-ascii?Q?wfVNif+LQ6a2JKtF327kO5Elaq9leuRhcI3vXaaE9Ho/DneZCLqYTkivJ1xE?=
 =?us-ascii?Q?bnwYBC87Zx9dZUkJiJJJtIDeiHMY2v1IxGkJRa+i7eSaSqf5Z7WmEwG5U90I?=
 =?us-ascii?Q?yfFjoHE3Z8XqSolRLVIX6G7L4eEzHz5UJHkk3UJNDom8ZSZWerpZCNISiN+W?=
 =?us-ascii?Q?LNV5+N91j0hZtNiK3kSS6SCgd2Cou4Aj9BSzB7Dlq/HQObODYj8hCZxda0p/?=
 =?us-ascii?Q?VIUiFIiipsDWFI31yUvsWE1Ive/ciOLH9hucttk0jNI1d5irkOn/AnpuxA6m?=
 =?us-ascii?Q?Mz4XCRK7W1uVg1Zzq9dmpvISnD/HSQ+macYHYtM+cGV3in1PnIrqUGkS28Q2?=
 =?us-ascii?Q?8xahZwHe0H9Y6McsnVeCek6HI7syULzWPFMxIpEuISciBHnkwFemJCSl5O16?=
 =?us-ascii?Q?WYg9P1icsPm9BrCol/nYmwRdojxMY4XeMDVWOd55RV8vDI8Y35ovMII5meiG?=
 =?us-ascii?Q?mX9bnvtMZbNphMLLI+fKMFBTNxHmEug45wyQrlJyFKKCmlcqOYe2r42eBhua?=
 =?us-ascii?Q?ZlKtm2zOHkrnFESZZ1oVMCnEWqh8TO8/u7FjMlKIhHhbHL6qsGHNQY42C6Sa?=
 =?us-ascii?Q?3traYqA8/lIPb6Uv6pdCwb9Fc13knhnp/wZELuF0ir4uZ51xl2hhv44kyjl4?=
 =?us-ascii?Q?6GQCAOaBcVHXQkSdTX/ujymaooYUBkmPRHUZLwLQ9uFRBCFGjPkegKBN0vy2?=
 =?us-ascii?Q?TSYbz17qftlqpQY+6NBAXIvtqFqVWVLg4Pu5Wwh5/EL85MDtrTdhdy39b2sk?=
 =?us-ascii?Q?WboWu0tGoZq9LSXNbrGRCjRKtT4UoyJx/Cu1F/1/IgqMZyli26dsr2dhaSSk?=
 =?us-ascii?Q?t/wBScVZjn4pnG15ak5kH1rHeFgtHnBPuLl6oVXm?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 693e06c4-a2a9-43c0-0439-08da8f0399ca
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2022 05:58:05.7298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rIA5LRadX3nkRkP8M2kL10DJ7v1JpigYZOmgM06lcBbJEDN1gdJrE1gTHfWby08Ddxnhjgyf/qMpo4Q/NoW0Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8740
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
index 93f96067456e..9f6e8a386071 100644
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 894AD5A59F7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 05:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbiH3DaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 23:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiH3DaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 23:30:13 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10056.outbound.protection.outlook.com [40.107.1.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0001817E1D;
        Mon, 29 Aug 2022 20:30:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IQpGPzHvz9lY32S74KVsvbX01ZcuVtxHe3ciQU8TsjXKH2aMZBSnhLfYIIzZ/DM+PfkJrdnhLRYjULWQ9LBNJJjNQ8IMO4ab+BNszyes2V9nEszS+hWyt8rpq5tmYdNVyt/I1ood7z4lrGcNHDLxGEHI/ROSFUqr+A2yiJxbhGdlx8BxHRUiRybqj5J53dEEFwJwlybUsqBj8HWsynB5QOYZo+WbIXHYXlLiUvLXkDMKJIamKF/TY717JhvBiwtwZkFqR3o0AzgIBmlgks4F7H6Aogx29ipCC1+lpZQI/OOHgm8mcNCi4NYKAThRs0LRDbx+nA0SdiFAYLsXR0dp+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gc541HXKqO8uUr0x0Fk5w9iH44fqczPNZ1kUMmREbHk=;
 b=ZRavPmO6X7QdDmiWv1N1xqagF8JoONGo98MmjYZQ5WimdpRRv0lcb9/JsquXwJe/NgKqHI+x+eavFBebMAC0KPLpoNCRB8UZoIwuPizpJeseFbAgB6ZwhudYqSkJYxMCWPG1yugl6ZCi1CxjM0uQr7G3Vhp20trfefUaC5Hm1J+Oa3xkZhItvS0zKmruHnv29RXIplcfo3O4OKPViG82wLFYLvGn7rFefpa+z4XQgPAYEwk+L2m4SYYUuEh40zvhTMKP7mpwhdmmthyLBkjTA3AflPWK0cxgWr46tce+6M316NxW75F7Qya8XG3FXQTidsKxJuX0FH8QMOqoSVAU8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gc541HXKqO8uUr0x0Fk5w9iH44fqczPNZ1kUMmREbHk=;
 b=N1akp66q3H6nJKoeKNnxK3h4Q90Z495Cj/6FcnNhCH57QrgHuvFupi/3SNxiDKnUHCTF+cYmCUwtr/2y87aiFhc4PGmIirrErpkNWJiJ+BixaS/8bcQDA4pKnrG5OKivru2dYgdAG2sSvOfTexhzHqrInB7UoOJsvX5Il7dBFJI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS1PR04MB9359.eurprd04.prod.outlook.com (2603:10a6:20b:4db::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Tue, 30 Aug
 2022 03:30:08 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7%6]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 03:30:07 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, abel.vesa@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH V3 1/8] dt-bindings: clock: imx93-clock: add more MU/SAI clocks
Date:   Tue, 30 Aug 2022 11:31:30 +0800
Message-Id: <20220830033137.4149542-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220830033137.4149542-1-peng.fan@oss.nxp.com>
References: <20220830033137.4149542-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::34)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a991146a-9016-45cc-7554-08da8a37efa9
X-MS-TrafficTypeDiagnostic: AS1PR04MB9359:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a+QgsIFtbmwaaglwu675BX73JnfNmlvQIs+nw4wMPa2YelH5g0xGdu7tVEqw2KBa+gvgduh4+4eLHTmQ+9NN8TGtAXeqigFC9GN/GDpcGV96d5AXmoUiy2Rqt40aO7geDu515tKSXG82K+M88RmS8F+QIMw9B2lK70xwNjucD0l3qQKclG7Ybn9DQNUbTh+Uq/arLVL2xjGZbNJR7ioC/SbfH1InbpGdMC2KKxw/wclBBeqgz2kd/uAXcDsjgtXihS0lskgYpPAY08ypEfQYvsk2JnxhaRWLryFgx1zKkBsSuaawiNH0w7/dLViJ72/i+MW7litQj0wb/GbFoumsBNedkTP9KFMGTFJ0R3lDwyuXGiN7sOCyVotUzIy+UkArFD4q4aQn2tjlTVsmsxzTGu9HqXilzKD75prGSsGqWzQtyo84NbitqYc3HVbh5U8ChZP8NIA43d9UkA9pebTAs8nzCPofoL8DNwkXfLM8WMwLyWqVKeOAStoc4DU+oxUq6Fe8KJnV6/CCgyEp5XM6KjQ7OOKxzxe91E1vgp1zMOiJF1pxarMsk0MzkTX8lIWxgvyNdeEi1LOs5oaquGA16cAAaOP+QI5yVxFFA2VAaE11ZyMpNjhiiXNfWJXfHkNBHwZMmKmWyZpPCtpExjqP0wz3+izoXR8dH7acaTF4P1XVkzp4lc7WUGlVsbEbpo5lII5TCteQP6LuyINuB8En2SUrctkhyHtR1KYtcrqQyp14qi/y1iK1FQ0B9k1deyJTNKHcEnMoPhiibS2hd3eNPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(376002)(136003)(396003)(366004)(8676002)(4326008)(66946007)(66556008)(38350700002)(38100700002)(86362001)(83380400001)(186003)(41300700001)(1076003)(7416002)(478600001)(6506007)(26005)(6666004)(6512007)(66476007)(2616005)(2906002)(54906003)(316002)(52116002)(5660300002)(6486002)(8936002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q0214H1fdYLx8Mv7XDpqJk2djOD3UpwlHL9TYIqUBoUn10XESssOA/Jf7896?=
 =?us-ascii?Q?y9zJBenpYm9x6iUl3u2VU2rl+Z55IgATsVJHtGlLGLEN875H80mwxR733Yyu?=
 =?us-ascii?Q?BZzvh7MamLFAxlof91bodkTmDsxI6SCsAawUEDg5jNz675L7AQ5h3ObrYE8a?=
 =?us-ascii?Q?zfS5pVvmHbLvjdprajow0xqJ93f6bOVTObLE6PkFXJn1iRNe6WW0S48vOi49?=
 =?us-ascii?Q?/FKCXbDUgU1RPeoihpMCMicDnIAq5ScMN/TZHFs6uKVqdIZeFBtUiqmqicYP?=
 =?us-ascii?Q?+bqSQwximUENNXm9l0Q+hidyUNcvet+wZavlse+M4q9w8ojwjAa4SSjEPhhp?=
 =?us-ascii?Q?FXgE80GTxRFo8aIBulNDt4rViuqTAuGS2lILBQyyrHuAQrRaORlVm+j5I37n?=
 =?us-ascii?Q?72wbr9Df9wjZ1lN50DT7zsQeGHFUcO/NpdnaWn1ohx25E3HXZUbY74CfuvhA?=
 =?us-ascii?Q?z9udcjl90iVMWqfYMNDPKSGESzbnQfiJ0mRIuaNTlXPR2Tm61179RK8qPwwR?=
 =?us-ascii?Q?UmUiHiJ6AjHeiglwc0Xf7hX6kIF5l6j3624eH0Kf+SIknK2H9tidI8aP1xMs?=
 =?us-ascii?Q?+vcQ9Gi9olJyp0w2t1uxxtMTsBTBWCUyGRPJ/d9wlNn8auad9Tuu0StqNGlH?=
 =?us-ascii?Q?DdxnS9AVjZV7MpmeybZwG7g3Lgg0jzpyXaytPHjpJolGqOJd13NBcpeRBosv?=
 =?us-ascii?Q?4IxZ+nPRrfSpdoK6Djr3d/5+kO+1a/yldw7EqjAGEAB1XBNulm0viZhINg22?=
 =?us-ascii?Q?Jz2wnoDXAy9yNqkYQgEEBPcS7RhdTPDDf+vFDJfGjOPc4fpO5f5bGhWNyE8N?=
 =?us-ascii?Q?BDE4Hv+bV5YlYLvTritYCnTSUpHpUHGewPkUlDa6SmNwZOfiEaXQwaHM2rt4?=
 =?us-ascii?Q?cvbzNvDLMNwBHOEThUFL9SRiVKlgPay2lHqscxl289yL9Xb5DFLbbHCs/hlx?=
 =?us-ascii?Q?8mhJCRw1axtfyXTxTBPcPaD1IQN4QRHgkiq6E1K80Nc9XhxUFzEnm4a3VLLi?=
 =?us-ascii?Q?MCTCK088ZE9WY21VNPnDR0RSWL8oGfJsIyWoA61yr4w1J9WEfN75XLfAHnwE?=
 =?us-ascii?Q?fEv6YN+o4s7EA58nna2xi90l0PGJBMwbBx9Z6S/nKo5pAIbgGfCdYYIa+3VV?=
 =?us-ascii?Q?oVVEEImclCwcC0Ie8+5ZC2a3zDuk9iH3JM0ASQEb0XD3Zw8Wt7uGYkekR7Hw?=
 =?us-ascii?Q?xG0e4FhHds5t8T7K6TxGdHfv9MN40DDFyLC6OvgKbbeUQOE6rD2VW4L+nKXT?=
 =?us-ascii?Q?RvRTVATqF39tkrMJv/NYcQPWmy8BnHzohe2cn7ili1IkcJiuiy8amTK9m8dg?=
 =?us-ascii?Q?FoHhyvOuXZqhDMuYzSLG9ELFbyCFiU9zU/ROjxbXO64Q5XYIgHPJBbp7v3/T?=
 =?us-ascii?Q?mia0vTkzDAUkaGyRnDxw6pBEj2SzC63A5//Z8JAa4SsAyQtyQeOpeq5aPZ+T?=
 =?us-ascii?Q?GPyxtNYwAjmJxdF8tzQgyR6JxHOPPI8DAbdlhQPJgRncs6d9BC8KZB/0fGJT?=
 =?us-ascii?Q?HUtAa8enNo0d7fKGsy8xjSFLBDxAYDLDYWdF4ajP+BAOsVSrYI/56zOXYroo?=
 =?us-ascii?Q?BGiBPTburpB9KH+VeFuDaLddIaqt3TDH39zwJuMF?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a991146a-9016-45cc-7554-08da8a37efa9
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 03:30:07.8467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sbo/PfxYiWN0IwQYRIdtM+mUHpXW732N/egQvp/8wtNkdSIksQVyRmRxBzN1UQ2zMLoih/ldeZa+FahxAwSaNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9359
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add MU[1,2]_[A,B] clock entries.
Add SAI IPG clock entries.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
---
 include/dt-bindings/clock/imx93-clock.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/dt-bindings/clock/imx93-clock.h b/include/dt-bindings/clock/imx93-clock.h
index 21fda9c5cb5e..19bc32788d81 100644
--- a/include/dt-bindings/clock/imx93-clock.h
+++ b/include/dt-bindings/clock/imx93-clock.h
@@ -196,6 +196,13 @@
 #define IMX93_CLK_TMC_GATE		187
 #define IMX93_CLK_PMRO_GATE		188
 #define IMX93_CLK_32K			189
-#define IMX93_CLK_END			190
+#define IMX93_CLK_SAI1_IPG		190
+#define IMX93_CLK_SAI2_IPG		191
+#define IMX93_CLK_SAI3_IPG		192
+#define IMX93_CLK_MU1_A_GATE		193
+#define IMX93_CLK_MU1_B_GATE		194
+#define IMX93_CLK_MU2_A_GATE		195
+#define IMX93_CLK_MU2_B_GATE		196
+#define IMX93_CLK_END			197
 
 #endif
-- 
2.37.1


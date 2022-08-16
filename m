Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A495953C4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 09:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbiHPH2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 03:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbiHPH1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 03:27:34 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2062b.outbound.protection.outlook.com [IPv6:2a01:111:f400:7d00::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E9D385C9A;
        Mon, 15 Aug 2022 21:39:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W7RHtRMzIiw1J5fhbWxj8q0eiCkaURXnvl8PVW3rp/f/rixm6/+Nnyb4q0eo45ERY4v5wQdXIwLE9/FM6glTRR30lZ+ylOVUwJvGLzUNiJl9P/JZtE1cwqCd6EyN/eItACooy2FPk6vI3FXGpfqoCr6RLnsxUMf6uIdRiTOfIQBj+iFyvgreRxqH60bTuGZm0FAXFJwQaq1XWb9zVEXP0x4tLMcGcexrLYr3RmhDQGwiyFQqHuGRnL/I1Dplbrroo0xKyEt6jyaAH/XGgEHygeqOPAW8Osj3Oj/KdMhBc5Jb/0CLzVK0df0JwQ1Hq0mGrIuaqClFQ8LPOZP+tdJ0gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mAw8oyWLOxCLx45tJz7GhSsan1KQMNYfM9w0MZxAHPo=;
 b=I5fabj4UhEBN8DlL1EQ+v67LsR/O52VA6lUexSer4e06p/B9Q24BQFJyrj0f76VYXdgBOTjZqOuC7L2Zp7RSzdb9A6jdciLaqffuH0T4E10sj7cdUaoOu3TOHyf0BunC9HqYF7mbHYhV31oUunQl6vo2+GLUP8zYVCGDtHzCrF2JH3Tks+8IcsPAXvcZBjTjhRdReIuxVLkkrJJoQVSfZ3tTbVpH6/e8/UAQfydGGk6A5P0lOIA2Hg/ABbqvhHfxq0qC34DMOgYRYsoAQFd8XTTFwH+Pm0p3KtqnsRlYQFcYwAbcD2d5xRVnKIb9QuKF8L0sh1jysSrgJQs0t+YQ2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mAw8oyWLOxCLx45tJz7GhSsan1KQMNYfM9w0MZxAHPo=;
 b=ecLLZNy2QOxmwKOloOqLqp1V5o/P42SDhgUdlaK5tNsw1VXvW34QzlShSKiSIUrRebGuPMD/57ZW38WDSaOmvnES4p8XfON0oU07CGyey1vb4NIITwqG/z3+ZSnWa2BxnOyZ7MvISiLuHFBqQSuKTaOvi1d11G5tSbbDrKis+UI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
 by DB8PR04MB7036.eurprd04.prod.outlook.com (2603:10a6:10:12f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.28; Tue, 16 Aug
 2022 04:38:18 +0000
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::6cd5:f11c:4e5c:d79c]) by AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::6cd5:f11c:4e5c:d79c%3]) with mapi id 15.20.5525.011; Tue, 16 Aug 2022
 04:38:18 +0000
From:   "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] watchdog: imx7ulp: Add explict memory barrier for unlock sequence
Date:   Tue, 16 Aug 2022 12:36:38 +0800
Message-Id: <20220816043643.26569-3-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220816043643.26569-1-alice.guo@oss.nxp.com>
References: <20220816043643.26569-1-alice.guo@oss.nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:3:17::27) To AM6PR04MB6053.eurprd04.prod.outlook.com
 (2603:10a6:20b:b9::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18d34d1f-70bf-46fe-19fa-08da7f412420
X-MS-TrafficTypeDiagnostic: DB8PR04MB7036:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0cmhOoEn1o0M3f6tqf5Sjt1PYNLYi1Ed6o6rrYA++shnCOeyLYsamfCM3OCNq59sQTYjN8wdjCKBk40AQt0AXsiH/tJ9MMxQZkQoC3t24qdT5NWv4cMudjvKqSWRbPeB5EbndmBbocB607Pqbk6qqA4tMSYD5pzvY/nH3t283whwT7qBoYvervDTutyxPLlTxExT8pLnaPUl9EDntllt2TGtyVI1ox5bgw77jiJJov517atUrJXAdQOSSOVVrYPVydSMDY25elyeh/HyBxmGq9P4oFlDg7++amP6ijGRhrNc8U3bjJNE+m0W1cmNCvJaC5iOFfX2g1dRaFldRiLbxqN+4bF7D2qR9NaQqpD5rYUaPQErzvxd0iXgIzmIEYOKcsh1rC+q3M50QQJgOdNeYm99ZOUI2QdslHmXT83/nbJ+kH8TFs9XIV97++hoNddYnqUUaI36ApYbrbBwDiiK77RL9BhdMcr4vI7K41eyby7V6OBAo3kG7fJ1tcJoa2XnqlPD7E6LaaVuU3mG2DfvT5k/Z2z/Qp+fTMokVopL2DfubnOPSbiC+j+LAy9A0BE5SUwbcAqfkM1feliofMq7hv2zIlmDgnEMSAtxPyziH90TfyjkFOrAN7kSinui6CMStstvWiVMESUaMjI8DRXU+F9Z7ZjTuUkGBX3kssBQLRfzbx+mrrv840MoHTfTtoa9XzQzppK6MTX8mEEqlyyW3FuJjP1h3kVaHnRFfdZ0rV6zHZD2ylNiKRQcoJY95UEHTDEkub060WGy8M2fiK7ffYPW6SYITT9DZb+CEdinZ58=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(396003)(39860400002)(376002)(136003)(83380400001)(38350700002)(86362001)(38100700002)(4326008)(8676002)(66556008)(66946007)(66476007)(316002)(2906002)(8936002)(5660300002)(6512007)(6506007)(4744005)(26005)(1076003)(41300700001)(2616005)(186003)(52116002)(6666004)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p/SsIi3/pK6j43TYzyIY0JbvGbo/RyaxBPXIgFH//astOvnpzzQjlScXC57J?=
 =?us-ascii?Q?eWKs6W9tHFmnlczO4oPQMaf4pzzy6s09L2NnyUfVj6BLHgAUNnaDP2RIj1r8?=
 =?us-ascii?Q?XbiX9f+tPpCcxEMAKehtxQ+y6ZdN3D9XBLzm+05BpH3vfYxnwFOiTVftPkkb?=
 =?us-ascii?Q?whbcTsaqQmt6ZRwvxn1Y5EpzoOvsoN2U3gKezhq4NdtkLwj3sNd2oSldPtj+?=
 =?us-ascii?Q?2WWEZEcllVpVjqw6LNQe4p/Z0pXxBqZ25jf4s7UAQETthiVC/D4x/YMItsYD?=
 =?us-ascii?Q?b+A1qD0R4dtNPC34SnMTYWEDngM+RRi8W0QoR3CzMi7uf7/2v8j6c9Kp1RTA?=
 =?us-ascii?Q?dsUWefMw7g9PPyJuMcjqVKkVYSDAi6XZlW9pmp/jvEZ9/bK9VeVUEJ189XUU?=
 =?us-ascii?Q?cckH4u6J4Tk6K/QWjMpOc7DJNjD2c7nwBr5XSw5lX44cqy0ImiAzQxotmyxT?=
 =?us-ascii?Q?bQ98YITHmnL+xLwvNmuhEymTdx6cDIKQwnpGGqfsKmCdh0Y1W5kWkKPDUbFo?=
 =?us-ascii?Q?gdv86sFP+qAqpn4HdGptEkAQxajtdX1j7SO3ElJpDobhdRG7xwkj5d4xh1p5?=
 =?us-ascii?Q?Z37zVSVl419CByI/5/pi2YbWvbj6mCVVnvydMyzJJ8vs2axd2BFZrkMHofuL?=
 =?us-ascii?Q?OrAecBsUYQA1IN25P9npD2Ed5n2QFomWiypxoZJgwhzaXC4hvClMuL4WI3xl?=
 =?us-ascii?Q?ZbcjOvwekjRVD2ZMV38yX6FQqvuBC67Tko7zKUW/PIN3r+STHwTAebOP0dqd?=
 =?us-ascii?Q?T3aL2+MMdHrRu6rLbsumGMNqtPQ2oYCr+Rj9zvBYxDBjTwWFikezRuj6YKsI?=
 =?us-ascii?Q?5BpGOjWdVo4vyjl5r64pw2yS1UZzIUu9bobD0O8hfJjgvS2qCD+2Sdm7babT?=
 =?us-ascii?Q?5pY+mP2e1htZOzedksxWDoufO8YlWSWlhklS2xcw75LZEaBSlbEgzDeZFdGm?=
 =?us-ascii?Q?9OSh7oss/NuIaU7XycrIfiPuOEshVWVZZwJX2Lu0+1kfzEeBUxAxGelQOzJk?=
 =?us-ascii?Q?cSe2BiEAcmzgSbAgatAJAxPgxCklb223Oaf+1yUZxlBJKGq4zSB+uD3j59SC?=
 =?us-ascii?Q?zOcsvCRXN2hCppiTStd0TaeHSE+dXdbxcq27b3/HgXC8OZi8CWr2cOkQ2WXY?=
 =?us-ascii?Q?B4AFsF6XAlfaTvfzOq9avUBahOsr5/u9bnqnhfxEY7Wn11ztZN5t/YBUf70Z?=
 =?us-ascii?Q?KCjG/FU76Nzr0FUITLIXxVBQriNFquF4SvWhrxk2KZFvx9bOCcFRK8m2I4Dv?=
 =?us-ascii?Q?oNeH4n+ndeZwcPd9SQ5XKl7JcSenLzrcndQaXHdulT/7EX1nqoxY2BwHsoEx?=
 =?us-ascii?Q?BD5nubZiC9Q+BbrFozNy0LSyHZhiJB464KWUoccD3cfATwT+gi281606HTQN?=
 =?us-ascii?Q?hIt59DInwQb+yulOHd8qocwb2uYgRUIWhvg9PafJchxFrWt/DX+t8ieBKLB0?=
 =?us-ascii?Q?0g3EH8zB6AlnJjl1P8waSlxG+Un6KXYv+GWGF0/+X5rsQbxl718j9+APuG+q?=
 =?us-ascii?Q?kvK1q/lZ1tSwHP4AcUvdF2jDxs6j01+aCU8wvaVNNa67MOYUH0mJRRwEBhMk?=
 =?us-ascii?Q?quh2gRTz3E1KtbENQLyXUMM9nFNxHYimMTZAButO?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18d34d1f-70bf-46fe-19fa-08da7f412420
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2022 04:38:18.5156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O2g5RIOkrXpKlz4R5RJm1AN47cTn4gggik/GSLlucNezXpFKTDuyadA+eZD/ZnGrf2wqCtoCxzq4t/ede6J+hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7036
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacky Bai <ping.bai@nxp.com>

Add explict memory barrier for the wdog unlock sequence.

Suggested-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
---
 drivers/watchdog/imx7ulp_wdt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/watchdog/imx7ulp_wdt.c b/drivers/watchdog/imx7ulp_wdt.c
index 014f497ea0dc..b8ac0cb04d2f 100644
--- a/drivers/watchdog/imx7ulp_wdt.c
+++ b/drivers/watchdog/imx7ulp_wdt.c
@@ -179,9 +179,13 @@ static int imx7ulp_wdt_init(void __iomem *base, unsigned int timeout)
 	int ret;
 
 	local_irq_disable();
+
+	mb();
 	/* unlock the wdog for reconfiguration */
 	writel_relaxed(UNLOCK_SEQ0, base + WDOG_CNT);
 	writel_relaxed(UNLOCK_SEQ1, base + WDOG_CNT);
+	mb();
+
 	ret = imx7ulp_wdt_wait(base, WDOG_CS_ULK);
 	if (ret)
 		goto init_out;
-- 
2.17.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B81E5953C3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 09:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbiHPH2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 03:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232109AbiHPH13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 03:27:29 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2062b.outbound.protection.outlook.com [IPv6:2a01:111:f400:7d00::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C7D3864EA;
        Mon, 15 Aug 2022 21:39:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JQHsc9DiWxCPVeRB+WyAxa1C2qv5zgw9qyui0zfkObcFYw4yYVwZ8IpLGt+Mvo2KHzpvu46QWpnLg+ZIm69rqbMfsC8A/JPmr1YY8PjfM/FhJN7fLkxayED5cjVQG5QJ3Qls3zaXVrSMuPnr9eYYdI4+LqEOA77Kw4xh7y8aEgyxMZlELrMzVkWO2YJa+bes3V/f9M+cF6s+lTfLzX6pWOjEKDzzTyXL++mrURiTZQn4q6RCHZOTwxmIb8OaOZKZAe4ISn8z5ulm0nCm8euzQ9ThPeL7T7m5FpdhUMntsz293mELbelwx1Xa6zYgrTV+gt2PmGyvH8VF3jOUtHSNAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T5hpjNwbk8vQDqaCUukofnGkqq9KOzgrcN2F/SeyUQw=;
 b=Tncts5SxQ9nO+3oIGEdPOxAUW2NB5vxHR8TuxC/EAO5JFOsGZUuKkHV1appT2LKBlUHo91wBKfccfzPIpKHGPUWZS3sJBaouBdK3HlCP+Dq7w+MkG4V7QojX1MbFejjMOqfKJxVmRNiyfZCZLtaAS6oA26iyXx8Iyk19kAYKFncjgGwuRUEtofD3lhm7EYw3A49ez9gpNHDYYj1e2tIh7bIVqSG6AMhzFsUl9X/zeiCwZn87cFBBVoF8X7hhdCJ+Cz3tFjCn4oHX7rICNIdNy3ReGMzVggCyjUSgZrgH2Fev5yIIu1qJ6QYGcWNvfhd3m/jn5D7luet6tU41kmStmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T5hpjNwbk8vQDqaCUukofnGkqq9KOzgrcN2F/SeyUQw=;
 b=KZqdcWQLLwnIPgxdM2J1WCgspC2QLxoUUo63fBbYhuMLOZD/jHnQxTyx5zfkZePU0L8OUDTnj62xeP2uN1yWupfklgXbJT3UOJ2tTNHAR2BqywlFYuIDFlw7fMAzqYydMb5hFSAX6YuuIAd9/Qd2DtXSyRWZxc2smg+pvXWVElg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
 by DB8PR04MB7036.eurprd04.prod.outlook.com (2603:10a6:10:12f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.28; Tue, 16 Aug
 2022 04:38:23 +0000
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::6cd5:f11c:4e5c:d79c]) by AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::6cd5:f11c:4e5c:d79c%3]) with mapi id 15.20.5525.011; Tue, 16 Aug 2022
 04:38:23 +0000
From:   "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] watchdog: imx7ulp_wdt: Check CMD32EN in wdog init
Date:   Tue, 16 Aug 2022 12:36:39 +0800
Message-Id: <20220816043643.26569-4-alice.guo@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 72ed86bc-4c01-42c5-d555-08da7f412713
X-MS-TrafficTypeDiagnostic: DB8PR04MB7036:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KQIpHroOdNG2Gd+qzA1iUgy/PKvXJcJ+DzZWYwpdlob7uHr843lsFwb9AFE+Ag0+hZxDlYzTEqEOHOajOmQ7mZzW+65ntInr63QGSckjxJcgxm7nxXdDSC327xyt7vPgkyWdvBvmjs7pmBwRzejRWei9Ujn31kbdjvjrQM4515p9ptPIT/y1kZapiGj0G9tR6WKu7AgyC/yLEFmkV1J61IO0cd76XvEQ/YB+ZDZMHLNmQayHRGzVQ2UvSZgsftHGU4pFWDzn6nrKp4JMNEuK7CbqIQ87cbRCB1LTcLkRHx1lrhjx7HkAUu/WmuLwtxC8YBSgUqVRlRQyINSaGlLITuflaSE8qTm5n6Ix8Zuy1gDHMikjwbYRPHIo9MqQfQCSEvJ3P/Z7plOZE/fXR9Vh0zvjlJ2GlIFUCPkU+vxGZJfVwhbW9ugMtMkt+7XWMeeDE/OJtYwrpTn1llJT2XuIf8Insb1mDPoUZaGdJN7cuOKTCpqG/6xo2EBhwgQ2kaKfW9CjTUsjDsp2qP8BUHCMEN6yAmdBLP3ymsKh1kdkE2/I3LETS4bqMSldke+9anxIclifAcpOoBxWqeC9ZLH1k7fNWiad+vtK7VwFvQ8OlBdi3xzWAaePDj9+US5x1HkPaDmzqxeUiFYtGw+49JspEW8X/SHkqEaYrnCIlSMm0wWgwoMQgiawVcc0LsmL5ALNbDoZJZcIxojgrl3KXEh+57Mn547SccoxUu63GADXm6fdircJc3GchGKN7GQbT4EFOdkQHQqAens2RuleIgPU164FsHeO/fQbPhrG7RrMjqs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(396003)(39860400002)(376002)(136003)(83380400001)(38350700002)(86362001)(38100700002)(4326008)(8676002)(66556008)(66946007)(66476007)(316002)(2906002)(8936002)(5660300002)(6512007)(6506007)(26005)(1076003)(41300700001)(2616005)(186003)(52116002)(6666004)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bKguP+eNNwJzMmebtuo8Ur4edd5l8gUUEJw2e98SqsokHupbjso1BFLdKPZn?=
 =?us-ascii?Q?kJB+BTagx4F/O9mnHCKnQ2JTW600hYEK+BBG6esUrlVvDqeb7I2z6gKD7B3a?=
 =?us-ascii?Q?lky7+wCTGweizdjDJWWXl5BxJlodSVT1qS0mmgb02miJIKnhj2b9pRg+pkdC?=
 =?us-ascii?Q?acP/fTW2kUIL6F0ylyPca9SoXfGZzYRdVjh9mxBhus49QeVtYPypir80Trxr?=
 =?us-ascii?Q?0APOoLNOzffZs9R2na6oGk+N1J2j0e+bzFjN3QFBVdUKZ04vOAkaO6YaBlFt?=
 =?us-ascii?Q?93YnADzFLRv9mhKKw1ncBiecYfNFHApbYsd9sRKFOUPZqw0ahg5Zgq4+MBeE?=
 =?us-ascii?Q?xRYmqEi2RTXOD99qdNyNHbliB9jtRn/FMzYvLXq1O5k8Ny9j/MEYJV33Omvs?=
 =?us-ascii?Q?OP8kkbgabCAUCgu/PIG1Ph1mdxWhS2QNfgWP9YLXmHWSLcCERYxWNze50FS0?=
 =?us-ascii?Q?hSyYMdzKgRsI1es9og09ksznzs1yKyviSlJmatali6TkW23+Pwo98cnqi2W+?=
 =?us-ascii?Q?qKP7D3bFjDkqArrKuZZhFcudVtakv2r+qly1o2GfbYEjH58xXemaGzLKANQa?=
 =?us-ascii?Q?yZFLQT3Y4f3vSUzGOOUJxxlSR7IQdOC2KAWZOuREou5pMpcaQ+2ethtnNMBx?=
 =?us-ascii?Q?XKA1rfVgXzvhSWSDwE7C7I3DNbbOlojs5vXTgsG/u2H7e63GMam63X8+6nvx?=
 =?us-ascii?Q?S0hIQyh7IjoYNUilS7fBFzCB9E17bj+hme9YU2EoSAZkdtRrsogkm6xQTnhp?=
 =?us-ascii?Q?Zh0xt1R2xlAWdJaCaCJVFVXH+wJ21INoIxici/SJMdnYoozNDZGyv7UYT7Rf?=
 =?us-ascii?Q?Imofi6sp8/FG62TpN/IuIFw6TzyfG735B+kAwcLvQMTX9mfZFFKwiBoPvEwf?=
 =?us-ascii?Q?DZ283eED4VraPbjfprZ+nfghBH53TOCra428SFbmAdRYgpdExO8o5nQaonm8?=
 =?us-ascii?Q?6kZ3o313XGYCyh8363KdebvXTo06SGj0W7ZoY6qMFSe09QOVjeMBjMyP5qie?=
 =?us-ascii?Q?2Yy8q7ur2ZRBIcJlHIrVH9/t5t6+isKJTMopVKQG78QQqJ6+7mpt/69q7KB1?=
 =?us-ascii?Q?ncQqn0a05mTf6AcMJJB83MzepekLileab9spIdFX2Xk0H7NYuuNAvWfFGEQk?=
 =?us-ascii?Q?zZCXDVhIsgtoIu++WsVDPCEUiKhHQkpG7iQD+MEeOFi+GC3/4qSPnfXPQziP?=
 =?us-ascii?Q?bAExALiscYdR6u85IvthTTieI5ibxWAPNvvV5OIE1UyFnZ3u33C9Ukr1kTxY?=
 =?us-ascii?Q?LyFs3ndBmyXNl0uUW7Pc3LXkcKBSTZCBGmI9HtDPwSnI3gD6IAyYk6QdphiE?=
 =?us-ascii?Q?vECrTbe6c8aiRwiUCbPsW7OYaHrsQVc9Pstup5PTmAhH8VL40ugcveq8L/tP?=
 =?us-ascii?Q?937HghTkNIStqyhcwFyGddvhqJIHO2KhhyYvTlAeoAIUWdIr+MU7ZAelbPsE?=
 =?us-ascii?Q?1kbIDMjogRCOegLn8+TXxlXzpQQX0J3cIXQcMuwtaIFp8AfSyrwYWASNknRM?=
 =?us-ascii?Q?xe8oO2k5InWT4ipMcdD6oIFK0VzAlX033Z225MN2/c6hTL7EX6XFmKqSX5/0?=
 =?us-ascii?Q?3xwNk/T+GHbfFTVz3/5vhKCoppkWaKowjcODTVMs?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72ed86bc-4c01-42c5-d555-08da7f412713
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2022 04:38:23.4528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8+LBMrVEUyd3ly3Say73HSVUi7Pl9LgvBbRIxwnOouY5qxOlDxb4YvduzwDGZS2HycllNDE6GG9wWZSFcdJEzA==
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

From: Ye Li <ye.li@nxp.com>

When bootloader has enabled the CMD32EN bit, switch to use 32bits
unlock command to unlock the CS register. Using 32bits command will
help on avoiding 16 bus cycle window violation for two 16 bits
commands.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Jacky Bai <ping.bai@nxp.com>
Acked-by: Jason Liu <jason.hui.liu@nxp.com>
---
 drivers/watchdog/imx7ulp_wdt.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/imx7ulp_wdt.c b/drivers/watchdog/imx7ulp_wdt.c
index b8ac0cb04d2f..a0f6b8cea78f 100644
--- a/drivers/watchdog/imx7ulp_wdt.c
+++ b/drivers/watchdog/imx7ulp_wdt.c
@@ -180,11 +180,16 @@ static int imx7ulp_wdt_init(void __iomem *base, unsigned int timeout)
 
 	local_irq_disable();
 
-	mb();
-	/* unlock the wdog for reconfiguration */
-	writel_relaxed(UNLOCK_SEQ0, base + WDOG_CNT);
-	writel_relaxed(UNLOCK_SEQ1, base + WDOG_CNT);
-	mb();
+	val = readl(base + WDOG_CS);
+	if (val & WDOG_CS_CMD32EN) {
+		writel(UNLOCK, base + WDOG_CNT);
+	} else {
+		mb();
+		/* unlock the wdog for reconfiguration */
+		writel_relaxed(UNLOCK_SEQ0, base + WDOG_CNT);
+		writel_relaxed(UNLOCK_SEQ1, base + WDOG_CNT);
+		mb();
+	}
 
 	ret = imx7ulp_wdt_wait(base, WDOG_CS_ULK);
 	if (ret)
-- 
2.17.1


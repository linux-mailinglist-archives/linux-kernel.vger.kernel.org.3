Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29CD5504ADF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 04:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235815AbiDRCWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 22:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234709AbiDRCWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 22:22:08 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80078.outbound.protection.outlook.com [40.107.8.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E6217052;
        Sun, 17 Apr 2022 19:19:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ERY14ywOI0dnbVZDHiYV0sxGV1lSXjYt3EmZJB58+wJG1cShib1imJWU6LiF8Tu/bXbz8Mfs8lo8tzCeTrv/b8TpBQtQRSK/ptAbm3kV+nT0lzsPAXQxP4RoeAgfKcfJuosDAq/tnxODaxBlewkedKn9E5fp8CWJ149zOKUqYSCuCZtO1+mWSEUsFt23MFNeO8c6wZDdn2iDhos5AocMc63MzA0KpLdrke0XGexn+fUquL0U2Wejgc32GUN2OUsvzV8rDVn25HHkoh9ZRBJ9h/Of6QSs0I9uIzwCCuseQb0BWyTG6yrYcbReqbMT7JGajvzMdlZS1fwxDNQHRXDsew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qXfgdddB1A8dkjses+br2jufWcgxgXEpcGJdAyxHLMo=;
 b=NJQYHp2JFekGuSjrRUK8wbib+sCgTJmdXQpFSLZIPSKFZWaAc9LWk+X8nETlqY+uhOV4i/kzenUtoiJSb3bEG8+nbigG7DdEk5IgzDu+4IsSTwMfxe5hZNjqSwC/1oY9m00ScgwIaHsTr1tBN10eqi0wJF77qbwsJboY3d1mV683NwO8MKvsZgoQrHMl6KE7eKkP/yzPcxUe1rOV0YSNyovMy4Dc20rCwaWVITFSVzEYNrpQavI+c/nJIbKaX+Z+Bl9dRw5Qoh0Kw9Odsb/5PTuQ8LVWQJg9/AdMloZ5ucPIMasPt+F80lQQkqD0OdN0D4xFYVcP8A1mIRFb6JKtPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qXfgdddB1A8dkjses+br2jufWcgxgXEpcGJdAyxHLMo=;
 b=WzNhfp/QDrUTYnRXLNVYe+Am8KEV1o1KhH+ivxOmIxTMb9D6AzRzY94TONytkq0+H11GqyfRAKzz1xTNlERmbteFNA0JvbScatlJ+bgStD4GJqkcRJEqFeXvFIQ8rn+dcWUeJR6XI/QHnedhGgxs26eE2RsIV6vFAB9nlvzWCfI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AM6PR04MB5542.eurprd04.prod.outlook.com (2603:10a6:20b:2c::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Mon, 18 Apr
 2022 02:19:27 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::7df0:c9b1:13f9:f712]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::7df0:c9b1:13f9:f712%5]) with mapi id 15.20.5164.025; Mon, 18 Apr 2022
 02:19:27 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH] tty: serial: fsl_lpuart: remove the count initialization as it is not needed
Date:   Mon, 18 Apr 2022 10:18:44 +0800
Message-Id: <20220418021844.29591-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:4:195::12) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3d59274-d5cb-40f6-553b-08da20e1dcf5
X-MS-TrafficTypeDiagnostic: AM6PR04MB5542:EE_
X-Microsoft-Antispam-PRVS: <AM6PR04MB554242E3EDA7997BB7F6D4B692F39@AM6PR04MB5542.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TzmD2WE5Z/KZqwuZxfnq/P8QcknpI/Zsw8eX8RRQ8j9dv2xEHOUoKIyDxD3TiG0VIEMZZ2gP+nNx9AXlizqbZDoWo6YrlFRTanw3HJPu5JOHcNfO4YSd1+IUfy1mSWnpMZSU8XEqZWGZmVLh2Qeqpf57QdXUs5U5MfmwYEeUcoS9kzHwvzIXVmvNn0Xs6CVXCCj1tcKg9WJ3f56vnIwctgP5kZIwvWXLP9WCjQH38mWsbpowIdkmVQXuf3QOuHhz1GYkXjyVkJukp1uSsr2qRRMcXAjHPCF/aat0C2FnI7k7mzLt1NMdahwizQSZgrXzOCFr21oUaVAQheB/L0f78zdfFEdvd8kddTSvYxVRhD7dj1Hclr1nJ0X60NfCvuQKvNCL6hfd6iduz1G8G6aHkb7WfVOTvWJgytd5w1HhGumxPupqYT8XawU/MWVArT2X8+U3F1fChGZdH4L8sVJ1GY6SVKdBtSejovPDaDbSy0pO3uYwDjRG3dEwOLHDnsS4xi8TOBR35nupMtx8KC54jB67nuk4s8d7EwPDvS37mx7GtYUEOe0c3kWkcMBMpg1M3lXo6+lOnrTOuP4dZazKd/jN3c0O9LIouwiI8wiJ03C1tzL5jCSierrK9enBXY15FU1/b+k7bXG7AdFmVKR+HMh/ywMEgdWHHcUCSqPbkGQ1Egy4G+hbPqVm3pKaBGtIIOdQ2wqyi3+q5XQnex+vZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(36756003)(2616005)(316002)(38100700002)(508600001)(38350700002)(2906002)(4326008)(52116002)(66476007)(66556008)(26005)(1076003)(5660300002)(186003)(86362001)(66946007)(8676002)(6512007)(6666004)(6506007)(4744005)(83380400001)(8936002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hoA+LQxPmSSyXfe71KBDvYhN/T0RKNvQXdgTKiaO65ZAg0KbQTP2ULswLkSM?=
 =?us-ascii?Q?b+1aEOQhL61YR/VXzyMRUOGncCqAcb3aI5eeyiYvaWEAvf++zNqgaHf/ZAYN?=
 =?us-ascii?Q?YM+jVDydmELRHWy9DII33na3SQPdAopBOMLkrWQ+YjTvjOW53Cf3s+jNV/fp?=
 =?us-ascii?Q?OYnhhv/xyGFgkxV3sg9gPnAdaydZvd5shIQEC5aHTUZYo2pxB8JNhPYMc6ND?=
 =?us-ascii?Q?nqRdUTvQkQEAy3RsYNGGt8lTBasqkwDxl6sqhAAmcI5duWPzla68vUChpaaF?=
 =?us-ascii?Q?7OzXg/o7B/e6rsqYhL7ScFUopAEkmuAG3kaivJBBe7zdWzX2JYxPsnRA6im2?=
 =?us-ascii?Q?9PkkUTVNTEAiNVDDoH0bfhXS+HGs2xYjVWoMe+7nibz14tDjld7hQY/8RzKj?=
 =?us-ascii?Q?UgJWv4PUjUrVnbaZBVMGu05KZ4+eVbWVsq/qnaF4yxl+L/mXI9kML2w1RwKM?=
 =?us-ascii?Q?JdpC0kjm5Xg/z2nPoUqWZRe7HsIdx1RJ7jzlymR7z9jURMQMVdChWtbsR6ed?=
 =?us-ascii?Q?4UW8QbxZur9LwxeP4/7mVIBxpe/XtgQyWiOphC23y8Tgit4hMPerAj3yRisW?=
 =?us-ascii?Q?R7RYGNmzL+oZxNjqpKC3FJOVsx9ARy2PG/5rZs1EChcfLGZrU/HsAkD24gNO?=
 =?us-ascii?Q?W3McQ6tID2KiBCJOGB/5VQtqOIYhAjUjbXS0W1bG0Fp4ziOLgzFjJNGlyysV?=
 =?us-ascii?Q?lgwa1PHcoJnV1ED6M0jWYUIFdvj9thhd1OC5v5GkKRkezcLPm/KdoaMow8MR?=
 =?us-ascii?Q?VyU+nNuFbgCqSOIHlDJz55pcjqld3pEy4EDWwR4p2NkEGZ+gjXltaCfDF35N?=
 =?us-ascii?Q?tBMJSoEBp7a3vSIe8s5tgbHz1oGFKovoNWiuC3oL5EiJnc3LOPut20yS4vmD?=
 =?us-ascii?Q?Oh16zyhIN42JjTwdD7ya18Z+dITDhv+Il2oifhGqB1/oAIz2rLwzBOssJ1NP?=
 =?us-ascii?Q?C+Zl8CRsAs2IufwqgsWT0AGcvd4zwyvtyLv5ZXfHN9s0lZh8b9CYkrh2d1Y6?=
 =?us-ascii?Q?2BnKp1J3Lbek2V+1HiHNTjLvI5En+6lBgg3k1wNPQtQhkgF7NMriw/BjctUV?=
 =?us-ascii?Q?2yK3ahZciavGzdw5xYzryspE6EVjJf9cbOQLzJEpTSUjGTEcpgFg/VrUH5Fg?=
 =?us-ascii?Q?LSY/2jnZ42En9nW32QiFwtCZjP+5vUfCaeRcUUQFLYQIwYLZKREYTECE1riV?=
 =?us-ascii?Q?hb8V3W++1mzLK+qD/6GSRMV2CEEbFm7VXWtLopWoEmwII1jQpz2slPyXtaMi?=
 =?us-ascii?Q?AXHtQ57T+IGsr3r94CEeQljQcjcrjg+XUlag7sYkrm4kkSSvcOPMaOfX8lSM?=
 =?us-ascii?Q?DTiH6JBouKmWWkG9wn9UY15jPS/B3v11u+B+RjnVxdV39zjrC9IFrBxFmuQZ?=
 =?us-ascii?Q?LpAknOq67NgfcrjrzSomospQzac5lXMv8QYZm5OmuteGQKud+2eH4bzIObDj?=
 =?us-ascii?Q?rnduv+IiyxdPVyNBMRJvGAZrWs/k2fJL3b/e5AIzgUYlF6DikwbxjoW1WOcM?=
 =?us-ascii?Q?h7Mgbgap8Poa6muo06Kt0QJ78iEpsxjm4iqbuOwAOCAtIhhjJyweFImKHGyq?=
 =?us-ascii?Q?tesTvVf3iWDyJxKKoTexdoXYrQB234KnocGapdMG2XGDCiJ2hOafTr7umiF/?=
 =?us-ascii?Q?MU8/R17W9Q9FdQ56k59BYyoZXzMYKtUS3Hk5P74InrSq2Tt28Pj+wZRKp7yq?=
 =?us-ascii?Q?sRWNya6Fgf+qyXxvMoMEB7SMUSlKe1KQib4wFSdsQhd7TV9M7SMBOYbYrlZX?=
 =?us-ascii?Q?gpPyzGbRzA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3d59274-d5cb-40f6-553b-08da20e1dcf5
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2022 02:19:27.6579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gQzSawQAR+6b/8xS0lkX5q7DL3eRUaDh/OOFJMwYvUWaAAJ9wqTAY0VBPltBWr2XKbBTMp5IBENuVF99iOpgIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5542
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need to initialize the count variable in lpuart_copy_rx_to_tty(),
so let's remove it here.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 87789872f400..452a015825ba 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1118,7 +1118,7 @@ static void lpuart_copy_rx_to_tty(struct lpuart_port *sport)
 	struct dma_chan *chan = sport->dma_rx_chan;
 	struct circ_buf *ring = &sport->rx_ring;
 	unsigned long flags;
-	int count = 0, copied;
+	int count, copied;
 
 	if (lpuart_is_32(sport)) {
 		unsigned long sr = lpuart32_read(&sport->port, UARTSTAT);
-- 
2.17.1


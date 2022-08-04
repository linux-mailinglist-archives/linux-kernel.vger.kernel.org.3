Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04360589814
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 09:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239044AbiHDHGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 03:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238670AbiHDHGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 03:06:11 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2072.outbound.protection.outlook.com [40.107.22.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA96B48B;
        Thu,  4 Aug 2022 00:06:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TbbxVVyL5Gv1tmc4YaIhC33V9GWsLgaWhcuFvWNVH5mapRWAwhcurkpWWG66DW0ew4L+3lzR6OO753YxYQioShQ8SeVEHRmzOB9s4I90s4iT0jniZDiCTWIp5J6u10czYxjNWNMWJZY1QjE9vgJhpx8PojXIsiOsjnn731pVeF+lrzMBcZN2JwdYsUe0jQ3w+K4a02Ek/jAXu1RtkfBObveNA/0RY4S6qRL1ZMrnrSUUc3gfr5RnxHBSUsKMbAqTz2DQLjNfAAd8x2jWrF+azU/SIW7XZNpXhe25vFz6GQVDhZHRiMWDsEh5DobgAaVPnPcnC//MYX7sHeLmXI2mEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=du2K431GQBW00Tcl78KNjgEYq3D6TF6FA1/0XSU7bsw=;
 b=IfEyGCzp0nN/FJqZC/buJq1vn78z7GFJErYmFEgVBLXtGTTZD5Mira+8UeANhKV0qbwgsvrYyx+32UDd4sg+qwD1IO0oXfh8UERpX7vU5R+0DfQ8kx3KF5gUWlcb9TVp3Vs1yaiwRi0hHnYRmyFbVAUZagd54nLd7fxtmOWKnGXmg0C67GUhUSVv6NMYsYuQr7oPHeyUVnZDIjjqe5Rf3xjmdFhps2g3ykikUVWIaiCf422DbPRGG76wf2Y/oGsekPOHXgYdshA9uXetBrgrYQI9m3yEgItRDJrP07BqO3dPiAjzBGsL0A1o1ORG6rLhbpo+e/0rFb/i9vGGNRmV5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=du2K431GQBW00Tcl78KNjgEYq3D6TF6FA1/0XSU7bsw=;
 b=YNmxKeaixXXEhTNvJvzsK2qFttakNTVJ8YdM2ceVxHkIuklPYo0OxK/NZx2882AqDjaY75G+YTewk37auTV1MSkdajMV7BZJ1VZZu4p5QQo40nIXHo79AiHxfQx7i85zqQgnjYt/P+zhYGYV8YZmVOQxWaPJwyM0KFG7aEZruFo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by VI1PR04MB4079.eurprd04.prod.outlook.com (2603:10a6:803:48::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Thu, 4 Aug
 2022 07:06:07 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::d547:3040:284e:580c]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::d547:3040:284e:580c%6]) with mapi id 15.20.5504.015; Thu, 4 Aug 2022
 07:06:06 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH V2] tty: serial: lpuart: disable flow control while waiting for the transmit engine to complete
Date:   Thu,  4 Aug 2022 15:04:20 +0800
Message-Id: <20220804070420.32186-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0004.apcprd06.prod.outlook.com
 (2603:1096:4:186::20) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9290758-a991-4f52-2b54-08da75e7cd15
X-MS-TrafficTypeDiagnostic: VI1PR04MB4079:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E+AY1Sp0dbp3t8wmWetxigKT+crCRPmrYOjZCDuHTrZCUbeN+uotyOeJKILnAI3AYF67z6aLY/5hTDRN8zDCOdmdUEs3YF8CIgjVH7/r/UK1H/Y2t+A8VBa0RwGihKEG4EFr/0Th9GTu1io41C6E54jNpIlauHLZLP9/Jb2SKQmeBklCbTGEPTTzhbPI/jFZh+jAMtmKaS7QcMDoB3OB7wlBRHwuvwswKKHPEFNtaLc+voLYXyOVvUXOjOTtUWco1D6Qg2abIFnzw58o8NuetXggB6laDYAgAVsVK+/zg5ULzE3H18L8iqSBs7C3bd+8tQKjt8wWtirVvjvT1GEMwv3HDeLh3ifXelNAy/Pv5HdB7sufSUNDXNLTBcy3sqjRoZX2s6AdK9lHHdvEF72obE1pyckzH92W/3zfGtEw7af8fOXh8NoAHbKwGPXDlvRQj6z8+PyXvU0TyrWymIyxpZKkQ3ldQzKdZnmGInUzA1tABydSUnIn7uVgA9i6FSFJm74OjafB/FzFY6kMaI7gIrdSNWPqr82zBbgyrghb/IY0UitmMzm/IRHvaLXJ2y50BipL0cjeBAqXtgFHPjieBwCZFpqwdN3iT1CUTf4sRQHZRSP6hRlzaAI+YxQ5GN2cj5mb+gxK1LShgCnkhNSBGjbfgIMoRpAfDONBAmGFKlWUFZkJWJxliRlPWLYTRq18pvc37uRRWnVdUOZNH4fqQE1vl/ueH0W3hCKP6Mi695KawAiI0Jr++APuNvqgHYXwJu1jPdunWSQjUIormFAuipu3JXLkBV6l9nl0+uJVpBk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(346002)(376002)(39860400002)(396003)(52116002)(38100700002)(2906002)(316002)(38350700002)(36756003)(6512007)(6666004)(86362001)(41300700001)(26005)(83380400001)(8936002)(2616005)(478600001)(5660300002)(1076003)(66476007)(6486002)(8676002)(6506007)(4326008)(44832011)(66556008)(186003)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4M8WJLXTLznMGVIgVLPvtYFx881UCZRpkP1JWLee9cLLwH2sXmJped55z+E3?=
 =?us-ascii?Q?LYp2zTBhrRZge331pYrmG0voBiyLBI3BrhEpiWOQst8MjJzPtXUSxeuUyu8+?=
 =?us-ascii?Q?XknqZNMuzvT1k2mrwNNXIuSMEprN+XoiWXMA9jeNCVyshb0IdNXjYRv7enOn?=
 =?us-ascii?Q?hl1+tuXZhQrC/EMXn095vdTv/Ce1pRClVwfHoLe8gLjd7Od876zcZPI886eV?=
 =?us-ascii?Q?dab9LjsmZ4FSieTPQ7mkQqVGhahIWmWjtZNaoi7zZnRoGYdhR7MPPjzmdN+6?=
 =?us-ascii?Q?+rRkZMSczb26uhYapr0xxVf+4W0DPDAQF80Q7+AUAdbIWuihXMoWA8o4t7Of?=
 =?us-ascii?Q?G9T2bieYxYT4JJyh/gddWx/GrBmkyphJKFKpCX19bofpZZIh19jN9vcGMSzu?=
 =?us-ascii?Q?HJPHlQBBzBmCwW2Zn2fET3DBxJ85VIRBTdgCy1HlQUH1OInNks2LmBxCRy5D?=
 =?us-ascii?Q?JGihw4gRGeiat6ic2+Vs6lgccL5YrgB3nwAGqyOi558l2NOWoNGmROnpmCSr?=
 =?us-ascii?Q?fInRtz9P7qxhnw4bI+kxTJf7ynlrJDvoAyUqERzonq0riYIH7vi+sIwwSiw+?=
 =?us-ascii?Q?/XPT4Z0KOoAfDP6tNt7ABbx5QKMLwpXiA+lG+g75DMzLm3URr94NeCQ/I1n7?=
 =?us-ascii?Q?mCnV/8oYo3mAMt7pxr+eeHBQeLkwnRjzRHHXBJvBeb9AYjsrikKDOEThnxwX?=
 =?us-ascii?Q?Nm/Lr/ty7g4t/r1UGpNzy5whrcBXzriJLOQAM5sGzwVgi0T4zifcqUjaiUQN?=
 =?us-ascii?Q?SN5bnN0SdkOlJRc+oIHdgUoPLyD6096uxWA/FSz80vzeBkNO87MThIYSsaO6?=
 =?us-ascii?Q?OM6lJUN+cih9uzBfPKxyJpMlAx9czsXEW+rOt9GJD2ZPier86mBThNssxfYi?=
 =?us-ascii?Q?qbhr/tU1/HcmD48HrB8m47LKsaGmJmbQnOvAWOqFBwKCGsLOT0zpM7DmkfhI?=
 =?us-ascii?Q?ZVHyt2TmvplMzmO13fk01eA1Q1BizhqBuLKcw9YYBHBbZfl454XzCjfS5JXa?=
 =?us-ascii?Q?wwLN2IIqw/WYS13PoxAF6atSRwQ8p1eNhey9wOMf4gZU3FEVUfdFaLAX789O?=
 =?us-ascii?Q?jrI0Ta/kJe8A3Gp06a06sgBFIA/DGiQ3Aqkh3Nafk9e/Oor4nJIfJ38T3jfr?=
 =?us-ascii?Q?kq8XWbkuOx24qFwxoJS8zPGwK4/43SHHBCzEpKwvdI0Ua5F4ksOJZqCDkeqd?=
 =?us-ascii?Q?+p/ABFAoC9Hl/Uu48KJMamlBu3ZxrWGcE/uD1tU1WwdsX6ShNCfuLuQnb3xy?=
 =?us-ascii?Q?6DdCHg0WcUZSQafz9LIwV8Mm79c4+XSeE6nNdifRgn3VTnUegRPQ1s5FCfbY?=
 =?us-ascii?Q?C4HBDm+wsaK0FsZr9wxVsUdoU9REaiCWe9Rtqqb8eVWdVESq53At8e2CK62U?=
 =?us-ascii?Q?5B2PxYUuvAQP+1K3KVsNnrVdrwsDoA0k/H8cINP6xkA9ZXJFfDTxTmaHdzIz?=
 =?us-ascii?Q?4nLCNSviW9Q6i55QMA7pQmVw/DcSq4PAg+nWXbmxy/QYFPMs1ELdmVZtV3X7?=
 =?us-ascii?Q?CrTsbYDKspKP6zS+LtusU1K5cq62XibecopfA+CEV50Cs3rqlYXFkeB4E0Ji?=
 =?us-ascii?Q?ncohSFj44RML2BM6esndSKgucvpyH/8x78s5DULL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9290758-a991-4f52-2b54-08da75e7cd15
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2022 07:06:06.7926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cfDyYCfDtTHWKP82UR6pSpr0n+C4xZovgT9OhkqnMsC8BXIdajk8+q2lrXNCsAbOE0wHV2ONTbBpPls21tY/gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4079
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the user initializes the uart port, and waits for the transmit
engine to complete in lpuart32_set_termios(), if the UART TX fifo has
dirty data and the UARTMODIR enable the flow control, the TX fifo may
never be empty. So here we should disable the flow control first to make
sure the transmit engin can complete.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
Changes in V2:
1. Rephrase the commit log as suggested by Jiri.
---
 drivers/tty/serial/fsl_lpuart.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index fc7d235a1e27..f0fccd2ff7ac 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -2172,6 +2172,7 @@ lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
 	uart_update_timeout(port, termios->c_cflag, baud);
 
 	/* wait transmit engin complete */
+	lpuart32_write(&sport->port, 0, UARTMODIR);
 	lpuart32_wait_bit_set(&sport->port, UARTSTAT, UARTSTAT_TC);
 
 	/* disable transmit and receive */
-- 
2.17.1


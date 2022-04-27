Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27CBC5117DA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 14:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbiD0MGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 08:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233513AbiD0MGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 08:06:45 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2093.outbound.protection.outlook.com [40.107.117.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F44541AD;
        Wed, 27 Apr 2022 05:03:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mi65aNKxLngKzcMxl4Q8SwbrTeO+UWGWsn58JSG7pDOTlWL6Nd0j6rTRbtuE2FGVUj91VsE0seoHqHACgpNeEcbcmvOftO2dCB52a1fJVpMzY3KuXqfNRvpGEi6l5Z0BsOjl3I+Qk8Y7FEMW3Mb63u3GfuEKIvagmoysdKDGBXK4YMct7QyT7UxUoYnoV4s2yryFrxRe9lJpwBNwQfvBkwHV0+t8adXcq8AshmbxZGC3RxjWDi163sgO3r43os2lZlqcqIcv2Sn7Pq7EVL2rPPoGHmFILbvWHoHb4qpjYLa06/GggdCcZNQkuqhwEAELwlHykR+nY7NyEb0lVLGA5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eT4GvEkcJukxhYJSxCmjRuqSGasYCwRX7p3QE6jQWAg=;
 b=YLCDDJROUZwaCoorHQmDoHyFuwJ5/SEhIDjrRyfCWjR33zzvYEgyyZipJGDSk86qLap+B78Z/2zz9mGMvHZSpI73xfmLRoYOI9yybfb1D17qXNlsLVspEt9tiFvv16qyGU3/U/925d4C7IU3eRR3zEwEYPwW06hLWh05owm4TqfuvYX45QZXMD3VSn9EC5iJm/WOzbd0lNQ25OO0CQmQEWECA7WZtPVqsuH2VoNGExdr9vN4CjBH2qMTIfpUN1Mc8dEKQXvgs61JhpVbXOA/I152vDQlcsVU8l/d9uHbajYbQtOs86v5LzkmS+DlG+4yl1TJc2WDOyvO2F6afwxYXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eT4GvEkcJukxhYJSxCmjRuqSGasYCwRX7p3QE6jQWAg=;
 b=cAA6Fsac7tKzsYDh0Ze0yh8x+OzYu5HfFvOR8ip6DiVyXc02c/o6V30OrYAvP8U7SQ7JSfiKSAvlDkjUFJpKbaPp/J0nvbePk700Aw8KCCD2IERF/73aESHl8aO3F3aVMtjPmf3Qlekyu57fXJGn1n6pf3C3AuoAq/vIGYTbHLs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19) by
 TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Wed, 27 Apr
 2022 12:03:30 +0000
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::4591:4f3e:f951:6c8c]) by SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::4591:4f3e:f951:6c8c%7]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 12:03:30 +0000
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] mmc: atmel-mci: Simplify if(chan) and if(!chan)
Date:   Wed, 27 Apr 2022 20:03:09 +0800
Message-Id: <20220427120310.838843-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0137.apcprd02.prod.outlook.com
 (2603:1096:202:16::21) To SG2PR06MB3367.apcprd06.prod.outlook.com
 (2603:1096:4:78::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5fb98a8c-365e-4f0e-e71d-08da2845f1c5
X-MS-TrafficTypeDiagnostic: TYZPR06MB4980:EE_
X-Microsoft-Antispam-PRVS: <TYZPR06MB498036278ADD5CF3B0D41877ABFA9@TYZPR06MB4980.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JHHk1Ifo2UQsmt/jWokaYZQWWPMKeVHlYYe4Wu5pvjWHF2PeJgMTU1RgcAVjy2oqEGxfPoFQGMhyptQCCX5i1y7yWgml8HiT4KrqY8CYyS5aYAysQYLVuHSLMMedXd91+RKtYEnLwjqQpJ3xWV+KgWote2SuYcbQQRlfIkaZ4lPQFqJryS+7wxhUzcvQJ7J2bavxzOk5mqjcVHyI8udfspU62XgvDop/WFat3ktUQp0B9CoOaBcum8ryon0B0g7XUQynofRcfnU1gJ1k+wa/XCLqh1QOqIAyzjqh3rSMT/hyh7xW4Ocm6J2mJUHKQt3U+ccUsRJvKO21S67pMAPeEiyWAAcPatWPO6Q6KgfYNSligJk4NfSTf/4bBLdZV4zHARFdYwJhEUO0Hg7XPq71McM2S3NhXw49lbWlXRFoht8uVf9xbwS4NJryrqQn4gSZk2taR7NZvu4EeHvvMuQaWCBycowP5aM7fm7ZfvUc+S+ovJOt72+STFibYs9cjpIS+tTXuuNnmJz6uOjDNVNG7dwX2uW+TD1kCXu5UJNntSZ/2b5v8+4KKEQ+7GPnom1QgqT4hA7VbbkVRlCKntTdRwWL0fJmFdzz9/B9ZlJz37PDjAIA9wSGCcTeHFE7SK7LeZsqTkoQ0p3TCxYPEWd5ojuxYZd9tWPdTXmSCOUKqhvRA5o6wTfzBufJy3hT9qzYC99YDLL5yoqQchuYkoenqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3367.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4744005)(4326008)(2616005)(86362001)(66476007)(66556008)(6512007)(38350700002)(38100700002)(26005)(6666004)(8676002)(6506007)(52116002)(6486002)(2906002)(83380400001)(1076003)(8936002)(508600001)(66946007)(316002)(36756003)(5660300002)(186003)(107886003)(110136005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NFqP8QktZ9KFuzSvic6kiDznrnS3bPFqFM96V65Jb9trBfqK+M8InoOcD/Y0?=
 =?us-ascii?Q?ykrwq9gzOi4Pah9as8RyCpr+k53ESAmt8QR9HOcdxls3KGIWYxpyJGdGVIdE?=
 =?us-ascii?Q?rl31V9tMUiDnEKtW/Llhn0jPJXc9Re7psjGuOgT70IdHSIXeZTd72UqVEFRw?=
 =?us-ascii?Q?NSqvCnVXk9vBtDrgM6TAZxFF4gdVDs6iEooRBa2kZ0uF1xFikX8svQ20u7hS?=
 =?us-ascii?Q?Tbdt3N/r51XSh0CHqsIPEsfyhE6KueBgm+jZ2q3ewVDfpYXRBv8VqrHstiUR?=
 =?us-ascii?Q?CJfEGXreRQOe4BvqP+erYJ13dJdPedmqdVXHGsPRxVIXQBtIs7t52P30GQgC?=
 =?us-ascii?Q?4noGzmocq4wuidQFjb3e9NEDLecDkbzK96h03VpYepjA2MohBOuDQJYh2Szz?=
 =?us-ascii?Q?iL/Dxn1JckcIwRvwMEclrUNEuTiIcrnSnHHM9C0M6QpTu1dvU76uEHfyXu20?=
 =?us-ascii?Q?8H+fyoZ+wdYMKU3JcFkwbh6ArqpHDdSRRWX/6GOMKPSvEg2sTmfLKIcq/bOM?=
 =?us-ascii?Q?0kwzs8yU88TrCHCiE3AVDSQ0EcrWVHY8am+KAFjrvfeD1G4LFLkEoC50jR4d?=
 =?us-ascii?Q?xCSz+PXENu1lCiKOMiV2M8q9x2+1wM0qMkFv5+WsErnFMr90/KnABOqzt3ht?=
 =?us-ascii?Q?jIMzQhi9y+8S0UmdxOQIPHic/AYSG/ZrYj5ojfPr5EY0Wqk1hmjZDbo12Cyu?=
 =?us-ascii?Q?aTZGEeGgPD0ZjaRebkl+fateGW82oCyFrudDvJyeF7xCS0dFoM58srWANaHE?=
 =?us-ascii?Q?F0QLk8CbACRAirUwpmDhlBGuBQr0d+9jPPvMyx9cWLSa73BtkKzuHksKnOAw?=
 =?us-ascii?Q?GFprk0kh8xGklptimYjlB4WJNCT76IP4fnL18zqwtnlZMLatdwhr3P1qg7gE?=
 =?us-ascii?Q?IovaQs65nU2SZrG4y6sX4qBvZQMMop4t5GUjg+KHTokLxAuD2yaJ5zPWiBCa?=
 =?us-ascii?Q?AzgmACPqivkqMdWIw3VXfZn5zdjTyx5bRfwPW11VUWN6unWQUqd9asTX7s8I?=
 =?us-ascii?Q?/vKjCjHPaRaSRZ/chH90FNM8NG6lELxw+b0ehA4YcHaehokF3zkpbm61eipQ?=
 =?us-ascii?Q?O55KkXzRJbA3XCi86rgfyOeWa4GJN2LdppFLK8vNCFC0sfMMu5ZBhxoZ5TqN?=
 =?us-ascii?Q?tsx0HY83YkLTeFAFd5yNNlCNAU+7CUHVE5b/j/OoamE8V2YXWo+66gLEQj6S?=
 =?us-ascii?Q?fQGv70DVnwB5W5a0JFWiD6N7BWXlsyaUEPjQBrUS3TKbqIEP1jnXr51DKjca?=
 =?us-ascii?Q?/3wRt0dYYdj9Rr2nsmLOMBZzzkLinYMadcnwNdk3FWOoqUWRHoWz+Wu0++ih?=
 =?us-ascii?Q?oYn7NOhHZ3uNlU2iY9U0s68fu45AHZKfmKJtuqfnNaa6gljF+cJyBHfoFcRb?=
 =?us-ascii?Q?iTpgT0pvHlvLQv1cIGO8H+UkVXEWhtaD5e66r9CBUWkyv6nPCdnT8O2Onit4?=
 =?us-ascii?Q?DtzeezT4J0Oyeoi6gLzucYtZGA4wTBex7yVfXCwVOGj8whUvmTAsRyOOt1YP?=
 =?us-ascii?Q?C77L3PIpBWCZUHnTsnEunS/eTK5kcVoeex3hJSPGt+ajHUY5s+/S0w4i0Hi1?=
 =?us-ascii?Q?Bz8eouOsviT2jjRTa7/+WrrulIHTETFH/41woFjjI8VSZOt0LSHgeQu5QjYg?=
 =?us-ascii?Q?7mS5ltNPKSQQFl1VMiwWEpz8XH0Toh3Mt++ueIHvcbIkVcqKlI5ut5n8ymfE?=
 =?us-ascii?Q?7T7uTJEMnXWEia2ZET8x4Y0wDr/OEju05BZoiQeKTveNinCwb+Mz29bKeDif?=
 =?us-ascii?Q?xVfw33JlCQ=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fb98a8c-365e-4f0e-e71d-08da2845f1c5
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3367.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 12:03:30.2667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YE7UHX6FggvKmwCj+5a1O/KIvMTmd8UcUqKtWwweNTJh8XsNf9zTFyJKvk9hn8ILItkIbZ2h8LU8nbIcCV9ZHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4980
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use if(!host->dma.chan) instead of if(chan) and if(!chan) to make
code better.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 drivers/mmc/host/atmel-mci.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 807177c953f3..91d52ba7a39f 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -1122,13 +1122,12 @@ atmci_prepare_data_dma(struct atmel_mci *host, struct mmc_data *data)
 	}
 
 	/* If we don't have a channel, we can't do DMA */
-	chan = host->dma.chan;
-	if (chan)
-		host->data_chan = chan;
-
-	if (!chan)
+	if (!host->dma.chan)
 		return -ENODEV;
 
+	chan = host->dma.chan;
+	host->data_chan = chan;
+
 	if (data->flags & MMC_DATA_READ) {
 		host->dma_conf.direction = slave_dirn = DMA_DEV_TO_MEM;
 		maxburst = atmci_convert_chksize(host,
-- 
2.35.3


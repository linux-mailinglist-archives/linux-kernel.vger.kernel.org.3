Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B04528512
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 15:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233708AbiEPNNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 09:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242905AbiEPNNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 09:13:22 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2096.outbound.protection.outlook.com [40.107.215.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DDEF1EEC9;
        Mon, 16 May 2022 06:13:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SjGxY04iwetvNIPowEOUqy793ZdbhRGF/n6P76E571xSAuoa4oFzGQElcR2U92n0Dxn4O8FyOLkJISdKcRjeVaUfzbmYAct3rbInm3mYPHA4EWHoGor76CcCczFarX2ZiWLceQxElDDWKVhWOWpysrrxjvmAYuc+7O8QLSF6udtVaLbLnMUpC1X8uAt6hlfX2RFMxzodzxGGxe2GwJyOfiMHJ4EkL22+IC4yQcFDJTd3VbwTP6C8njH0v7zwJdqhUzbAM4/0nWygGN8+lGLRhlxsaGCcdNpepxnjo9N7Kba7kBQb5S9/lGvzbwJVTsRYGcaZMfccrMDEWZD+C70YFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aKBtXHgYlvP252Hp/ME5+RomaLAqJR00olQ/hbsWPqc=;
 b=hC2WqjkzXFmhZMDUJb2SHKjKmbh9zu2tga35oHSe5VIhPqnAtS2kCewviXd523nEN/+n1LAL4V9tyPsnDj9ecBxqgA2L7/sO79X5ce5Yc9MorBm/WRnUz97tNuCDDVxhovqsC6+/IRy3/21LaDhzQGDKAEZe1iJMbKWM3NeUnla9nPTWL35SmDurxQlzcfypt+v1avGxjUO6bR5MZE8IRtelGAeTGVVKKvV3S0K297098GfaoeIb/g+J4eOaHeB5fSgSrlDbrsHMTWG5+MVdS2NRloeXLowBgEazcdzj2RHz1OdVE6lgML3AAChz+7akAzxPS8jgVoEpV5wV3IVd4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aKBtXHgYlvP252Hp/ME5+RomaLAqJR00olQ/hbsWPqc=;
 b=HOUe7+C3wrXu1gC1nIGz4TgFfkhcxwaM4ExTfMvsB2GHXAFYYDtHwjzSR8vabTfdTMvJ6GBfc1IwLuBCD3XzEIHNmMzB+RBrTQ201pn+sZgyIxtqt98bPo/NozePCsowWfZm9cyNjYIYzKTqpk+ZGFEgHx7zhth10U3xFhOAATQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19) by
 SEYPR06MB5112.apcprd06.prod.outlook.com (2603:1096:101:58::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.13; Mon, 16 May 2022 13:13:13 +0000
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::ccb7:f612:80b2:64d5]) by SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::ccb7:f612:80b2:64d5%4]) with mapi id 15.20.5250.018; Mon, 16 May 2022
 13:13:13 +0000
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Patrice Chotard <patrice.chotard@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] [media] c8sectpfe: Remove unneeded NULL check before clk_disable_unprepare
Date:   Mon, 16 May 2022 21:12:54 +0800
Message-Id: <20220516131254.13816-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.36.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0141.apcprd02.prod.outlook.com
 (2603:1096:202:16::25) To SG2PR06MB3367.apcprd06.prod.outlook.com
 (2603:1096:4:78::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4eea71ff-9f58-4519-ca01-08da373dd46c
X-MS-TrafficTypeDiagnostic: SEYPR06MB5112:EE_
X-Microsoft-Antispam-PRVS: <SEYPR06MB5112C5BFA59817E2F399FC8FABCF9@SEYPR06MB5112.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sP8DLX0MJpSo+ptRLVvU8rVgLCELzN3Rpa6dhRszkEdeExZR5Eg/VYYWhLZ5/fSWhjqu202LDQ3CtEllL0K+WYs2hSlFYgyYSIZyhUheopZxHtUY8HbdFzrX1ijHs+7n0T+0GKKkv3BXBVnXN/Ax5G51qFIxqqSwdqCNSVjyRhkgftWAUA/bjbjYP2Mt6qqDNnBgHX9PITXqefoNo6oVgoEFcDjrx2ErTrUWUwDMR9XFkQZiGOG2vhieP83sJkgMR+wBHMnvaOK1n7mck+T5P0FjCwVEcG1sWveq53qDqkPpbViOAEjk/7LWRnfiL+8D1ibdQT18a7fwKNHp4dLJKeg4daWLZJck0baDTu2ZBQ791hWRW6addgePr2UeRTO2oC4whEuI3OoX1V0sNtAZKE2Tyj9xyAAcR5Ig8DRfSH5Gc5O0KS/EBWMy6yrzV7lANuOYyoCxDnLOqLvzCv7qIEviI/uwfIHBkvDvKg1oA7v0UdtQ2Tb5sog02fqH8b9c8ZygPJgzG3J4GqZ2YO41gY1sDiGciAcphvbdeXxlJ73R17NocfjC13keTM34xMrvJBEcBolpk1OLtgNB+Y/CY1NExpkkAECqcINi1o1H/+Ncnni1WvssepqExgPd9Vu54FAJiMh2mRIXLb8oFJ1C+sFi0RzZz4Nw/AbzhZu6T8BsENtFcP9vByDA7kiaeLOYrN21MSxEGD63pSfw1N50FBA+clSNUeNqM3eBsLfmpO4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3367.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66476007)(110136005)(66556008)(38350700002)(26005)(316002)(8936002)(38100700002)(36756003)(66946007)(6512007)(52116002)(83380400001)(8676002)(107886003)(4744005)(6486002)(6506007)(508600001)(6666004)(186003)(86362001)(4326008)(2906002)(1076003)(2616005)(5660300002)(32563001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tt74wvKN0pBpdeHGxgqv/cFaSpEHotFmnjiCBxgkfzyAfXBK+2Yx/zZOTDqj?=
 =?us-ascii?Q?IuV2nSO2KASYvSNDTkurVIjTCg1tDdcFSUBA9nVI6fJI+c/CoBtsMgW2j+a4?=
 =?us-ascii?Q?N8/BquQdTpfeU+yWFCoZWg6LruqFtlOoP1JKUPsC+hINwU0yuvJo4QhmFcBJ?=
 =?us-ascii?Q?QLwkdSG59LcvLPcB99iAIac+7CkkiJlDcXEpwBlAEfpqwZ8bbFZbW69AC0OK?=
 =?us-ascii?Q?0FCqXQClWMq1VxLgzeBtii+JPjAhddYxW9TIgnCaM17N19CEYabLCRQuLffF?=
 =?us-ascii?Q?AUSkY2ThXPR7rkpBCDzcwsnMYuZ/ZUK5XzhlTChQMTHrXznIZUdUzTXOT4gT?=
 =?us-ascii?Q?qFRyykglv1Kqpw+kCZCJDvp7v/FldkXOCtWqbrwj51jjUtXsnpz0ATfxnpcg?=
 =?us-ascii?Q?wuYYbQrM8s5Jb9o3A2S1lP8oS9gniRFHbcX6v7O/A57yVWVBvYW4eCDA587m?=
 =?us-ascii?Q?06B/qfKXdgmCttI9WWwY4iKgt5E42a8cTJ0FaUVHEeWXM+Zky1smtN9Eq9zC?=
 =?us-ascii?Q?K1BKQyqcaqtkEE9ZRf25xZYlFMEJaugLJMHwtOWkG6azyeBfrjVNNRdcYSCx?=
 =?us-ascii?Q?yE79v22djlWBuiECNXQ3+uO+mqdMXPMwE7sJDNH4lnLbVRQCLj2n7vLrgdtX?=
 =?us-ascii?Q?W0x43EMM91hRE/dGsi4hGw9h6Iv28KU40R+cSJQt9btDeV1tz/XOZckaQKkl?=
 =?us-ascii?Q?hTCTQ0cYRlm/+/Qofey65fTH1bHLc0sXCTst6GNTwpbxVkubLIaKV7FB5+Z8?=
 =?us-ascii?Q?omC31BFQSAp4GNytaBEBNdFw3YjMV1XaSp5uWbzIoN7eOO+DIOe+2A/FtkjT?=
 =?us-ascii?Q?TVOIZ2rRA3Rj0YZp+UsmEDRnVD9BTLpFG75OFgQ1XITa8JFMszM5cKuTxoYA?=
 =?us-ascii?Q?n/6PExeodRDvT0mjfEpcQzaKinh+OTdyeV3JUFBbx8EUiTPNVLqXSExvQRD9?=
 =?us-ascii?Q?sDN6FNfUyK2DLwq+LhOcXyD6C2UXwUctA04TullcxVZLbXrpFrhy3ldfVqpV?=
 =?us-ascii?Q?XP4iH7+CWhXqwRTXBS8W3ox5Jg3xuBfonn5kXn33TNtn6xio5ADL7jBKutfG?=
 =?us-ascii?Q?J+5abG7rJOw/wMsKKpI5ULjDjKMM/afRoTsyVSIgyiJGQJFBZAF+B68p8eLW?=
 =?us-ascii?Q?KPlh2GNvNy5za7qWyvQTQ5bC6BTM1pfEedYnkYgZ5CCaqZYwH1GWhLc7Rpzg?=
 =?us-ascii?Q?ZVRWZ0pjonWTzYlZQgIx+7zPuC44pNeSIZFe1ufFFMGQVN1WlFoUWFfkX+n2?=
 =?us-ascii?Q?ucEHq0qp4NBx9VKqo+EoEPhCLgRGXgxEyiPwJucsGwc4t11iWcaXGQVHYc7w?=
 =?us-ascii?Q?iAobvtWSZFFuMd6ryL/Y3OWNGUox7VMpYkZggQZlYLf9OrjGhZFTCefeJ841?=
 =?us-ascii?Q?VAhSI+0zfwkdByvmEGTqqh4DiqtX088Q4G3zx9PAh28fRSHR+iVJPIiEcq6+?=
 =?us-ascii?Q?ilS0Zas0Y+ThnQz64E/6oTZujA9ohFkXfEq/tRPQ04bjbX7V5iUd/q6sdgFD?=
 =?us-ascii?Q?aaqLw+ZhFpZnjy03dku6R/Fu7KbSl9ytcVidMT8NzWkvCb3Lua89xpP6seKb?=
 =?us-ascii?Q?gOwrSvNuzEDAnG6eneiz5d4gJf3YAie5Vp6zfXORaeeIpWLyzaO7Oi/8KuyM?=
 =?us-ascii?Q?a/OJWXDg4lwZ7i4omxBS8QM4AiuKNRnc7gq0UYpcYirZYf0OussSx/fa/OhN?=
 =?us-ascii?Q?w8RIml4k6vpRmDCR6wtI9QpcH+9MjWL/c63SNawm1i7JZdIQRcBfFqygQPFa?=
 =?us-ascii?Q?loG/YQcIZw=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eea71ff-9f58-4519-ca01-08da373dd46c
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3367.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2022 13:13:12.5590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gKcNfipQ8HC2Y5GbOZI13yZvUm1W/g6Hqjv+Mq3HgQcGuzsT8d167HAAGhcgnpKeACig/GQkkpxjc6wCqNhA9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5112
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clk_disable_unprepare() already checks NULL by using IS_ERR_OR_NULL.
Remove unneeded NULL check for fei->c8sectpfeclk.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.c b/drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.c
index 7bb1384e4bad..7d63e56ae14c 100644
--- a/drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.c
+++ b/drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.c
@@ -915,8 +915,7 @@ static int c8sectpfe_remove(struct platform_device *pdev)
 	if (readl(fei->io + SYS_OTHER_CLKEN))
 		writel(0, fei->io + SYS_OTHER_CLKEN);
 
-	if (fei->c8sectpfeclk)
-		clk_disable_unprepare(fei->c8sectpfeclk);
+	clk_disable_unprepare(fei->c8sectpfeclk);
 
 	return 0;
 }
-- 
2.36.1


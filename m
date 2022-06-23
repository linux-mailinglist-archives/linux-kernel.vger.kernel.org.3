Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65100557CF5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 15:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbiFWN2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 09:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231660AbiFWN2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 09:28:46 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-oln040092072024.outbound.protection.outlook.com [40.92.72.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A09C4A
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 06:28:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WriuBsaTeQXZTTgqINjG4j3vGX+PLLnZOAiWxQbrcntL5FFCXH+ZTlWnU+EaPryNlN9XMEOdRiiArpozuK4dvB0pLe1jTmC0b0n1A0RDpFHtSpWNF2p4N68z469i9Ys2FZmnwoZ+0Tp1Jcj/n4uOgaotDDrrDxlqqWXEM5weWjvKOTc+3Hc6q2hgCXf27c9UH/wSXI0omylBUaKKLDn4PEz9Py1wHEqvJPVDpVkc77i2qqrk0xh2RRpyBaRW+YLFO5CRhZyzJCNCW6g/1/fdTvxfE22HJqFsW3I797xKz7wxaem4lmOvyzjxHMoOlU5LmF+k+5s9rBpt8LshAIn9tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zVFFf2YPFHvBQg+aepMbzCOIcZg6Aa66AzPHUIYDW4E=;
 b=W78350xFobmCFH5xbsMqFqUQnblYdisAG5Ku3lco8D2Hb3grPI+ghefLEzXyA2CsVeIv5ZXvp3WKX3Dj7gkbUV9WJX6Xt8vbr0unxlsszIq2p+bbT5Bx3jw3/ezl54wTjgLMYlEXtoPwa1QwAKAXe0RfwuA8BBYhnjvgN14SR+YKO2LEAsn1Gs+dvER3yFe7u13ABILt5Lv/4FpV37hI3zR4RrWvoT4IzJ7xixTT/jeTLgTqItT+9pENk3RiNQYrML5uYdtNkxAXx0QR213h0DRft5LlLARFVrHamvrgZ/EkHVMZ0749s1lqcjY1hxLXytpZCQFGbpbaLJpjmN4Ung==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zVFFf2YPFHvBQg+aepMbzCOIcZg6Aa66AzPHUIYDW4E=;
 b=ZACme9/1SJDmEncssw1B0PePFMpinEtVpNqn7pnYdUAK5QGiNQiPRIlyLebkzDU2VPWFsuPsdH0/xUZJHNWdJ57oZmBS8hbvkk7KSRjvciaIlJ+vqrr0+sts4vokRxFWnQ7rQqH3UoLxLRcy4GdWME0okRoEkJWAba+B4W2VhN9uaJruNH0YbMzrikNL/3s4Pzs+bgrzrmjkQ1Jb6dotf6ckPnaoSIiWNNDSuBK0LQeVybvUKmQQ4YZXFrGncwqqvPPluNbsr/ruForDu+CEAWqMB/MJ/4v+bHDSzczbfEEQjq94igJuJRAVuqc72O0vD4aLFUnpBLijvISqqpVUfQ==
Received: from AM9P190MB1299.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:267::9)
 by AM0P190MB0658.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:192::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16; Thu, 23 Jun
 2022 13:28:37 +0000
Received: from AM9P190MB1299.EURP190.PROD.OUTLOOK.COM
 ([fe80::c0f4:a98e:332a:2397]) by AM9P190MB1299.EURP190.PROD.OUTLOOK.COM
 ([fe80::c0f4:a98e:332a:2397%5]) with mapi id 15.20.5353.022; Thu, 23 Jun 2022
 13:28:37 +0000
From:   Felix Schlepper <f3sch.git@outlook.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Felix Schlepper <f3sch.git@outlook.com>
Subject: [PATCH v4 1/3] Staging: rtl8192e: Use struct_size
Date:   Thu, 23 Jun 2022 15:28:27 +0200
Message-ID: <AM9P190MB129941B5516344B2C321F5C1A5B59@AM9P190MB1299.EURP190.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <AM9P190MB12995A5916BDAE3F2A8222CCA5B59@AM9P190MB1299.EURP190.PROD.OUTLOOK.COM>
References: <AM9P190MB12995A5916BDAE3F2A8222CCA5B59@AM9P190MB1299.EURP190.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [PHaMKm7sx5QJUDK7giSovXrQFHkNUUpM]
X-ClientProxiedBy: AS9PR06CA0523.eurprd06.prod.outlook.com
 (2603:10a6:20b:49d::24) To AM9P190MB1299.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:267::9)
X-Microsoft-Original-Message-ID: <54ea62a2b7628d3bdd5aa52df82c3e91704a2127.1655975970.git.f3sch.git@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27539aa7-b822-4cf3-0320-08da551c47b4
X-MS-Exchange-SLBlob-MailProps: 6H6McBavlAg3x/+3LEOY9jnKuPfemMPEOW+ZI2iR0JeNJ3LCsm+9jAipYe8q5zM155sy1MWJAOq61XO1rYM29GgctvCaytBkSu0PPmmvPEMC1U8HmxKiZqoDL5DwR8BnF1p0/xvvLvj9bu8mmVLG4PFd73ZTSIWi4fHF+++qc3TMWRl+UuZ7ZO1jwKn4L+aUHEg59CbC1hBvcAE+vhDlfoUuEt30BsbN0sECwzvmi6Oi32SLTjKylF3+50IXcfFQ4HjAoFa2pJnSIHyRNqRgueNqbU+bm7axmJEf358FQVIamVNbNrs2H1qiPRj5gii9giJRIc6Nmsbs6O7SnH6j+hvUG641Sz63xaIiR4xNUaOYlpcLOyjNuLYFTDtJplV+po4Vo12PvMib8MO9g3Yfn13a8e3aEqFe6B4jwTtxOsQCTETLzcuvA26cI5XCYNcZdk5wdG+gMVtLxmFxvnnFwd/ey36kLW4NTwQgvNJIGT9ftMZMdYEAbfDqPwjguDy7yM9rlVYjGhLtXStmPDeSEtzEClHOcwN6Qv53JLc/1Z3ciueZhHkn6J1BeLNpp+Kh+pCuQP/Mmhr5bAvvIp0CtvthML49rHIVJdaY5FT8ELis6iHN00HZn1YQZLP5AwL6ynyvm3qKxTKkqpwryu6QdjcN753saqETk9jLQpTmPYUewN5CxLKHC2hTQ6/65d74QIG2zQWdIMyJrFdbqkQ/JJinANE4uZ3LWBSdsfOZDMzCVZGuEo3daoMYrupD43akShgvMtbSGOU=
X-MS-TrafficTypeDiagnostic: AM0P190MB0658:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YMlRKJrGYiopizsQS+PMxbKOvpDYRrZnbSgtc0tH2LhxvCBXMHmYN+UPWmgoU4mqTNZNQP+QPBi2vYJrOKVpPEqOScgigdgWZ4T8qvjY3NOBSWd+O+M4mcsNpNuJ2xyhXkl9v5Ay54+Lpg6NlVeqhUtt+OCoABD/YxsOj4gWzEz80UPcVL/qXqG4zEg9tFNtAfEeq9CQVVxjjnX71M6xdA1QYKslfxPH8uKaaeA3OxQAOJGnAPfEFF8fHNDD56eDLtVYyNSMJieGJ9aDlTfMom1nIVrNUz35PFvGkWfrveJVxJJ+zkVGWis7FM6YHkjnfM4VbXx7Q1S7dqFJwiHd7KUxhewYa33ywHVQcX8Jy4U199OpSCnG9/Ps6A8ps85uDwHKKx1dpCtoiEotJwHYRQ9q0PGhH5bUQcQMS0SQF3iq7brG9hzuQi1KuT6WXNDLwl8C1Vpl5VyvOp0FpdsV6l5i+iC9RyzXistcz22aLVQkFrsGm7FJHD9LWqQ2FVbOfuBwMfZdW7HdZ6VVynDguVmhoOpNk/dxAQ9qsuyOh0lsWY5IWUwg0mHWHOrAjrjOQlSiJR8m7AuK2xo3E+96vY/U3MvkNP01JrY9VihNPpwIEE0uWrdyNbIJ8fj4Xdrs0t2C7Kj12l9Mcnzek2h/jg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zTJ98xrFNkoOPzJsvtgP22CyUCT1R6vkMq61KEJ8msFK+5bxverQc+fkCTm7?=
 =?us-ascii?Q?zNI2Nfg9GjH95lI0EOcznkZ5gF4HAGDg9ol1MpHt14Mj55ZnIuAzkdFtj51T?=
 =?us-ascii?Q?Mb5XyPS43LVpEyu0M0REqLv3D9836nYYEhyQj9PgGkeq0F8WhOLjQSLPc9B4?=
 =?us-ascii?Q?b7Rr1/nszieSd0cYf0LyRztXkxFV8d1TtFzjz0tILRufky0jjiE2n4fHva/A?=
 =?us-ascii?Q?xVSOx9y1bYA/J6aKFSeXAGbcmtKFFE1nrC49TcdJY3OKGlihFfl//DEoOnzN?=
 =?us-ascii?Q?7HfzUOc/Wfy2lmZlcUic/YE4npTo8rz80TvRZklVoB4VXALaPcpZLg4muL67?=
 =?us-ascii?Q?24T4p4CEnD14IjQ4Hz3NuabvOe73wT5aDYYEAug7/H5aWGyAoVUIeopMJoo4?=
 =?us-ascii?Q?6FSYcHm+aBcAzo1xvcyb3PipSO2HqB2FPyCkrUQLGxlzYJFqIgH1jMDwMtx9?=
 =?us-ascii?Q?uPJvdAbUyUYAmfX6g72TpThMCU93acdYgZ4KEwPsqa6RucXJTTmXvyDxmwhi?=
 =?us-ascii?Q?i3Gq6z4ewL+UUJDME0Aj+XxXzCMaRKWeTxlxfg9Y4Pp0Uwqfe8gx4ljyDj90?=
 =?us-ascii?Q?I23W4sktvACLqiVj/TyW8eu82tQvcaux7SCmgTMDpLHlSWWpNv1Ji+BhZrmu?=
 =?us-ascii?Q?/5DG3EKNMtFfo9AWFJ7Ihq4LfRzlhHapKchJPs54J5wlWJCncTbKOZXcmcAG?=
 =?us-ascii?Q?MNF0vBCZkC5MU/xfbF+LgKHh2zq85N2GtB7amo+mYnLZxfSAurzzWNyTsRuB?=
 =?us-ascii?Q?n8zfYnoDv76ifIvv9d+FmgRO+5xoSKzbxKBR13FIKautViTn6yzv5k9tvSiY?=
 =?us-ascii?Q?11dXIC/5SK7LmS0iAwlZr13SzHo0D2pvbCZsrewRVt5buhSsrqquLTGJGN5l?=
 =?us-ascii?Q?wVovuSKuqTC+nyThRPHicWmyJCFAUj2pAx7uZpA9nD/x8NXn+BfV+ya/yy2r?=
 =?us-ascii?Q?B0aVfFwqIPbncS416nggBZ0Xll1S6bCsAscPMmgZK0PQoQByD8wHT/fzKEFZ?=
 =?us-ascii?Q?MnRCJAOl8d+omqDZZB00KQjBr7jkCPHMg9lQ3VGxbduElmxiPASds4tLxJk+?=
 =?us-ascii?Q?KARQ7lYw5a2xlVjISdZvSNiqi0haVdpSW5n/dGVnaWjvrvk5zTXB6S0JV9HG?=
 =?us-ascii?Q?QPTupdqNduTIyS5yaCFLV1hA7KKf5Q286aoF+GrxcMwshbc492p2PrX2dsO0?=
 =?us-ascii?Q?jMj4Nt2vuOnl0vQvs1WsciAZY7PATLcVpY3raQO7l2ZF7Q+ygiImfOK5J6Lt?=
 =?us-ascii?Q?3JV3GApeScZUa80WvtyMj250CokvEUXR/3jST7WqAw=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27539aa7-b822-4cf3-0320-08da551c47b4
X-MS-Exchange-CrossTenant-AuthSource: AM9P190MB1299.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2022 13:28:37.8177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P190MB0658
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using struct_size is encouraged because it is safer
than using sizeof and calculations by hand.

Signed-off-by: Felix Schlepper <f3sch.git@outlook.com>
---
 drivers/staging/rtl8192e/rtllib_tx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index 37715afb0210..f2ef32e943ae 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -205,8 +205,7 @@ static struct rtllib_txb *rtllib_alloc_txb(int nr_frags, int txb_size,
 	struct rtllib_txb *txb;
 	int i;
 
-	txb = kmalloc(sizeof(struct rtllib_txb) + (sizeof(u8 *) * nr_frags),
-		      gfp_mask);
+	txb = kmalloc(struct_size(txb, fragments, nr_frags), gfp_mask);
 	if (!txb)
 		return NULL;
 
-- 
2.36.1


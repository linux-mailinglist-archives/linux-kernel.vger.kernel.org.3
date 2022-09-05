Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E1A5AD416
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 15:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238158AbiIENfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 09:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238061AbiIENfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 09:35:10 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2057.outbound.protection.outlook.com [40.107.22.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9265D4A820
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 06:35:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dVXLvrwxtF33m4y7efYfAsUTlsUcIDhJ7adsAK8OTmdusqxq2EYcqUgt7lMa1MK8WH5cUaJAmNb/vm6GQTD5z10bgCdJgzVnFodDglxfZuXSm1yI8BfUim200+3arrtGaHSkf1NkSPvRL0P+Gj22XzJ2U/9NTjQSCvhnf+RZzlWRWFbykrTqXATzigR8XuJkFMxln9cQAdDGYZsVFPCNyqoXHZkRvZqlSoq/eRH7WuGWtV8cvU3oH4jugvhFaYzgqj40TFBgd6JNpw4qWdop6u+YdVhbI8xXRsxwxeK8F5ukTRiXZnSxH3znsxXqFCM72w/RgKTmZMQygEboQk72hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tTSJ4DEQZ1rlAIrW9LGVy1RJjj1BmzngUFmb3iC1gGY=;
 b=kg4x7DdkzqOkK9Umsth1xUlbe/WPfhE5Vk4Zvgand+wbJlm8pTpRugTdskr4YiMVoS7iDE5OGBEKdMA0437WliEgyhzlVmBwt78rgjui3ibpAirlwnNtTEAMlqjvJRIBN7IRcLeMaZ27pwPuULzh1qXJ4Mgs7UNUCXdiuNePbd14K7SXQSZqhHuTxQJrnXHtfG6f1KsqAeOUfRqlmMJbPhg7d3Vn/zCLmSyLLhLKo9DHAGtCzFcDootk+hnONZXNPiFBspT54kbSUNe0OWORgio1nYb6XC94wWnLI3GJZnzt8FdDk1EuMPkPCfqy0Yn1v4nSLqwxPEM5qQz0zCIkWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tTSJ4DEQZ1rlAIrW9LGVy1RJjj1BmzngUFmb3iC1gGY=;
 b=bxXYiUNULQfO8AsqkF204ZcLXYkTyBFGSYdAZyh/quDkWJYm0xYCrNlEq74JtaUqeEgS6W0di2SM/t6KiTx1COlpOLcXOgcG6PnPVtvXa1cWtk+gT6T9lojhBOrmmwy34hqMG/5Xe+Fnt3uZMZg1cjjl7edEQcoCqVOFdHG/DMs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by DU0PR04MB9276.eurprd04.prod.outlook.com (2603:10a6:10:357::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.14; Mon, 5 Sep
 2022 13:35:07 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::6cde:8704:ed0a:c87b]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::6cde:8704:ed0a:c87b%4]) with mapi id 15.20.5588.018; Mon, 5 Sep 2022
 13:35:07 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     gaurav.jain@nxp.com, sahil.malhotra@nxp.com,
        kshitiz.varshney@nxp.com, horia.geanta@nxp.com,
        linux-kernel@vger.kernel.org, V.Sethi@nxp.com
Cc:     Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: [RFC PATCH HBK: 8/8] dm-crypt: consumer-app setting the flag-is_hbk
Date:   Mon,  5 Sep 2022 20:06:31 +0530
Message-Id: <20220905143631.2832-9-pankaj.gupta@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220905143631.2832-1-pankaj.gupta@nxp.com>
References: <20220905143631.2832-1-pankaj.gupta@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0173.apcprd04.prod.outlook.com (2603:1096:4::35)
 To DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 00e2e8f7-7adf-4c06-1787-08da8f437229
X-MS-TrafficTypeDiagnostic: DU0PR04MB9276:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y22yyOnH1k871vZ4PMG2VD3W8ZJJolmtqXownJiriRjSi1gmx4JM1GHCSCDkhJGz2iAqlA3lJjygL1kdKeThIdcHkGvpBiLWASInWM5RULalZdz3FmvN9OB/YrrZgwTalZlg8iODPH8kBj7M/3XCFAT6OyqIwlSoLNTexun5E6zAsc6mOCK3ME28A0iYVEA//OE7QObgjUGj/TiRyFnuAUEwR2oXOh/UKVWrUhziqeZ2jrZ8nLCioJzDescNwTx+m34Kei91xu6alDuTKyQdsxNyVHAmXzJb+rFi6mvvT4t4NLa/tjJ9Ueb5bCpS1hH9JXJ3icYpxdBNnpptgE3lZOFn54ZzoXMGOhA8c2NwhWBDcd/NvVSBo4uDjQyyPWDKeMmJH9n1pOXa9v15WuyDz7znQbxYjhikz+qHBB0hSVMtddHq1zHPKiFlbL+joB2bYInRc1q/A8ipdUt6vp7T/a6uikyeE2TYDbtDuHGoEwr1HWjCGKfWCVoDrzeAmWivQifo9ycdACxObwuSOeDQXYLkJH7jE9mkNuQS7THwocG/zo2v75VEs0aZ8AP22RO88Hj1nECiWn8ggbi4Ng8ol4Uq1iMxtZ65BBmMgrY5q5SCJqId9/ZXcbzOc9TuJyJLkw5IX36GopzZbMY9PwFf3WJX3zWIgSHn+2TTfHyD5J3LctS71OvPiyor91bOagND42zVgG3O3DwyHPKtsi00Abt5XjBKMx5PsomSWMg0Vtd3MYWKJ4llM91TijaRLmsf5xpbFwSBFwYX9wX0IuqgDAN0kCkB3fPI8NGZsyj2SL0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(366004)(346002)(39860400002)(136003)(83380400001)(38100700002)(38350700002)(4326008)(8676002)(66946007)(66556008)(66476007)(316002)(6636002)(2906002)(6506007)(478600001)(52116002)(5660300002)(8936002)(44832011)(26005)(186003)(1076003)(2616005)(6666004)(6486002)(41300700001)(36756003)(86362001)(6512007)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BUjTxJ4hLRUXUHbjowwQy8C+1unwp1kVXK4EQb2IW8v3bHd1GnXrFWsCTqTk?=
 =?us-ascii?Q?hEx9+EDUZDt3hFcOLAGJMF9oBkecu3GSrnuf/ell2w0RUYXbYME+0pRxfiI4?=
 =?us-ascii?Q?lQtgPSocVxXuS904MnURJxMQV0BvmqTOSXtowB5Ves4GhH9x/vkCPawBvrxx?=
 =?us-ascii?Q?4k4CcGnCVi2R64mQUpmS4yjsR+9WGRdL9XWYbVg1uEYq11G3z0M33Nk4G9Pp?=
 =?us-ascii?Q?iyuk1UWDgVGpXb9Xr7jsX8lm09qO5lOUawpFNKhFceiPi4Ccl84AP/+eg/wv?=
 =?us-ascii?Q?TFzkm9SQY4kbZpBU5gZgO7ZBVdsZJX+bhbLHk3iHrLOVgO2rTKtD2beP3Ul1?=
 =?us-ascii?Q?LelkQMFS7/5woEQpm/xR3LgRkBMBS8+LoNN7HAqrSBanNlxTRzj9lZhBAdG8?=
 =?us-ascii?Q?WHngRpgscIkuhELdkOf494w4CIhiSFL5AD+4c5WKTCXrACEz6cH5+OaScAdC?=
 =?us-ascii?Q?wtdpKRhzSUKN8/qRkZkumTNFHepYNGZQSi9oDInJKwtwag9cGuNRGaoLtEPO?=
 =?us-ascii?Q?rVbvm8Wp08HlNmLe1/JfOH3CMu1w2cDnbNWoHK15wpHCSMWDANF308llBiEP?=
 =?us-ascii?Q?srirEX14R5zeuaesW7qF89Mn+QNj0IV3Geo4LwgiuVyZ8DyuVoUEIe5iO4QQ?=
 =?us-ascii?Q?ESaxbRRsBG8UMmeOOYlxk5DijrzFe2R+0SWe+Q4DwtQyae6MySnkHNWzlqe0?=
 =?us-ascii?Q?4KG01BWkmhv7/LG021uvNzaoTa6IbJWY34fD8kpfoWp09c+6N6Epq/IFXbg2?=
 =?us-ascii?Q?CBuy3U+9FnyFLVLcZtr2z1Arnb0ffYYraNB98Kx0to2Fl/aoM/cVEtBJIz60?=
 =?us-ascii?Q?AyJV+IK0NMZ/93lnuDTbMUAYxKrkGsKnWN5rWxb3APsCd1pQaKkqNq38VlaL?=
 =?us-ascii?Q?mPcKZwtES9ZFOZo/j/+AlrOTPKcVgN8ldvNP2hUYmU3k7Crw392JKx/lHaRP?=
 =?us-ascii?Q?Ls+kTtiQcKsR8+vpFhFHMz4KA+BD4Dw5Rf6RCqvjFD1erW1wUZWExgAy3XsR?=
 =?us-ascii?Q?4RfHGFV2GlQ5q5Ds0iQt+gQwYYR2wHT/1aswD0PYhQEFzX4GBVgQ5uhFDu2I?=
 =?us-ascii?Q?Rm7jau2Gz46rumDMMOjNeb9HA+wX0k2Vzm0mrr6TEmgv4dpoTlXvVPIYHkYm?=
 =?us-ascii?Q?Ely2YD74jnuduigI2YEs9McbxytDzv7iYiAdtuOBTm8Qpgd5oMQinrEgvfJE?=
 =?us-ascii?Q?Hhqy80DvsaKZfHm+R2p9hkr1ylLVi1PrRMmztLpzpRxB0dF2pfoITZvI4yfa?=
 =?us-ascii?Q?8LuQQlDtftUfzU1+1GXDRV6xXZK6Eu0XJr3gGxQNtRjv2sXUpYYrktSlQwGD?=
 =?us-ascii?Q?+zlb6+GcUMkjKjrJZg5WS0WoKOCb1Fg5zVy+rLq9muVTtQnecOOLRTbpFMdw?=
 =?us-ascii?Q?oC2y9vk3TfjETzWF9ylhub801R75w/KAsEDo2/4v7JMg7F7q3D3LJQW8mH43?=
 =?us-ascii?Q?soF7k66Uhhp0XsuhNiwPHP4LAZy61cDtXVeV71tZTkNfAW0KIQzhvTIF5nJm?=
 =?us-ascii?Q?khB0H52fqC4PSkAnUUisXEzKuuI1kUmRi9paXQ2NGHXU3CYEb1blIkmU0M9w?=
 =?us-ascii?Q?nrbcxfEWyGObcVTwex2XThqsS0xwgmI8hc5Emof9?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00e2e8f7-7adf-4c06-1787-08da8f437229
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2022 13:35:06.9097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vz1cG/3LGjM4iFU5JGnEmDloTLAJpZ+Za1HSqZ2dHazmgY+eO/Yug9nIlEunPm88YoMSjjCOgtQin/W50eDtpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9276
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Consumer application:
- Adding a flag 'is_hbk', in its "struct crypto_config".

- After fetching the keys, it is setting the above
  mentioned flag, based on the key fetched.
  -- Note: Supported for trusted keys only.

- After allocating the tfm, and before calling
  crypto_xxx_setkey(), setting the tfm flag 'is_hbk':
          cc->cipher_tfm.tfms[i]->base.is_hbk = cc->is_hbk;
  -- Note: Supported for symmetric-key ciphers only.

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 drivers/md/dm-crypt.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 159c6806c19b..12b400e06cbf 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -221,6 +221,7 @@ struct crypt_config {
 	struct mutex bio_alloc_lock;
 
 	u8 *authenc_key; /* space for keys in authenc() format (if used) */
+	unsigned int is_hbk;
 	u8 key[];
 };
 
@@ -2397,10 +2398,12 @@ static int crypt_setkey(struct crypt_config *cc)
 			r = crypto_aead_setkey(cc->cipher_tfm.tfms_aead[i],
 					       cc->key + (i * subkey_size),
 					       subkey_size);
-		else
+		else {
+			cc->cipher_tfm.tfms[i]->base.is_hbk = cc->is_hbk;
 			r = crypto_skcipher_setkey(cc->cipher_tfm.tfms[i],
 						   cc->key + (i * subkey_size),
 						   subkey_size);
+		}
 		if (r)
 			err = r;
 	}
@@ -2461,6 +2464,7 @@ static int set_key_trusted(struct crypt_config *cc, struct key *key)
 	if (!tkp)
 		return -EKEYREVOKED;
 
+	cc->is_hbk = tkp->is_hw_bound;
 	if (cc->key_size != tkp->key_len)
 		return -EINVAL;
 
-- 
2.17.1


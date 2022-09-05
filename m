Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 025475AD408
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 15:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237471AbiIENf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 09:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237993AbiIENfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 09:35:00 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60076.outbound.protection.outlook.com [40.107.6.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248181CFD4
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 06:34:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H4QBnBu1ZrL23neJOfnfLYIPtngEUyAfD7YnEotD5U3o9W+JpheBIckuoDAG82JT9JMt1ezyBTYwFC3FdpEd4QemxghLB5mVICdIv183a8CXbVGdQ3BhNlOcaM75qS6GbJVCMTzbRUgPlek8BWah0ljuj3BA7W3xSHymjDDOzlc5DMgiC9gKh/vaCqevlDOQZNxcki26fHYmJWgWc9v8wj+1FJ25sIioO0CNu61EFIBxC+9u7Haja6vYaBwvOSoAyufyW2Wta5i58ab3ACEmTMlqwiSwu5BQikjgsDKgUzWGyg2ii9UFU6hBpJYntdrpSXLpdv85h/9zY0k5ZlKARA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XZNSue1BB98oOwbk5xjFV6FMaUS6f3bYXUbZ7gMa0J0=;
 b=CTSkjFVZb6zQZAIm4YsHu/LZ5PaeOxvIh7Db0j49mVgKnP+57bI+6VrUEd6bHgl1IoKtyDcIThmtLdcnZu4NkKTLrlc1+RLrCWX3UAZOSPLDJakPv1ItmGPU3OItof24tK4dbEeIrlptMTC+LlRgKWV1+Q5VTVe98ePBVfiw3pSeIN0iqCyRIn7pWWv75EqZn2NI2PVzJHo5gsuSKCKwF2I6dnPYkrcCyCOhGVJDyTSY4KcCEXfyvsBc/MO2UBpLZN1x6eUIqqonTsH2P290VwaSes6BcbTOpajS7D5hIXIgQy2nGrshN1EdCNubB0Ah7PeDWNHTRMVjCrx7NpiIhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XZNSue1BB98oOwbk5xjFV6FMaUS6f3bYXUbZ7gMa0J0=;
 b=Rn3v7tdrDd3b9LE0568cMtAFLW1/kh6/vpIcVFAxmrHgprL3ObsytLm9J/orZuwwWMLYFMD4Hqsuhbh1N6UpNJK9I7choDsiZroYpl62pEAXqCPgM4YG7O/wCk3mshMDzuAMPm3z2OprtQalBPEDQcXN3vF7LlgBS2lP0NqphIA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by AM0PR04MB5585.eurprd04.prod.outlook.com (2603:10a6:208:133::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Mon, 5 Sep
 2022 13:34:53 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::6cde:8704:ed0a:c87b]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::6cde:8704:ed0a:c87b%4]) with mapi id 15.20.5588.018; Mon, 5 Sep 2022
 13:34:53 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     gaurav.jain@nxp.com, sahil.malhotra@nxp.com,
        kshitiz.varshney@nxp.com, horia.geanta@nxp.com,
        linux-kernel@vger.kernel.org, V.Sethi@nxp.com
Cc:     Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: [RFC PATCH HBK: 3/8] sk_cipher: checking for hw bound operation
Date:   Mon,  5 Sep 2022 20:06:26 +0530
Message-Id: <20220905143631.2832-4-pankaj.gupta@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220905143631.2832-1-pankaj.gupta@nxp.com>
References: <20220905143631.2832-1-pankaj.gupta@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0173.apcprd04.prod.outlook.com (2603:1096:4::35)
 To DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6703f8df-e93d-4c3e-da66-08da8f436a41
X-MS-TrafficTypeDiagnostic: AM0PR04MB5585:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pAQe9RaWWz6C+bDt3g82hvs4Ni3UTyiONVU3p+HeJ24iqJ5tggu5Qg2ARpun949nYSeKNfoRPiouuKJn0lr0cmWaFi/sbLi34FubHUaNTHQO+z85oWRqcP5Xmvk4AJ5lQUybt8ieEBNYqBFw8N8/AHe8gZGZtxjDUImX8v9l8NBD1pXkeERLtYXnybA77mv00/N8BClgZg/P4uydSlrZpu/60uyB4AFVryVQzjJenlb5GCLnDucwJbxJbm4UgSWK/Fl2WSOinEO2B5EA4GYQQnr023tdlw5qvtxWEHCUkFs5wk5ds+ZB4tcgdV2NdnB4YXdjdqlYJN0aDZoJBy+fauiWxCd1ofxugi0TCFgAkiwBzhhJ1ttf1tnT9Eldk8aZCjlXN5fK79GuRvUN6f4bQVAnBKZVQKvDAZZDHBNrju+2+uj/67L3AHPidYHKlNBF6gfJxqdDF9AUWZas4+DzA/V1Yc3T8C/G26Di8bADWafORQxewIE03wTKj7E42/BzRckxvN+H+wD4qawjnkmMm6pTZmlOaC/emgur7sLGj6MVTWEsTV0mXjQZCQf9XPuuPQJzdH3jL1VxVclrIm6LpKYO7PYsDtEPPdgYsG77UdicEc5zTN+hgt1qwO57ywCkjMsLDP8BvL8gtES4LAsdboqtYLHlIZJmKpIIcQMziBO3iacA8tK8/e+KxCOn5S2nLDEnxTfbR0+Ygcu6yYfnUkHXy5lTs/mFOb56RMYSv27H7icGTs6sgQBBHcE9y72OfTr06SvpRp3yrDvvNYub3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(376002)(346002)(39860400002)(366004)(4744005)(316002)(86362001)(6636002)(36756003)(2906002)(38350700002)(38100700002)(44832011)(8936002)(5660300002)(8676002)(4326008)(83380400001)(66476007)(66946007)(6512007)(41300700001)(6486002)(2616005)(1076003)(186003)(6666004)(6506007)(478600001)(66556008)(26005)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rwivga/toirCXeJHjFHALsAnsQN1XbvzG76r9KlQSdIel2lXV1L9mHjFRskK?=
 =?us-ascii?Q?9eskS6g9Xs8VThyWsQjGVH3J40iwGiFiTcm5lQ+RNLnm22/rWHK9sEDex95R?=
 =?us-ascii?Q?/qeFwKmHQ+aVSWKBXXLNabY+DSyA5i1fc5KtjctPdtR4ReRzs6rMO9PN2IGL?=
 =?us-ascii?Q?m9H05gxoLb9p94quwqxgMKn8MYmUhsAW8Y7n9JvMo3iffBqKngd9OZHnRNuf?=
 =?us-ascii?Q?+EV4V5vRy0V0d0nlMU/g+w/2EemalJKf1bQZfSy4cbs60febLoFmn2bQqwvM?=
 =?us-ascii?Q?ci50Caj8CeoGOuGNps7QyfbQVXdD0f8Exjn+Fn6138/a2uYY7fE9uWsbsqBh?=
 =?us-ascii?Q?xblfEK2w+TjveoO594WgZrO60onix+foDc4VB7NHTFEEHRaGwJnUdsFV2v9q?=
 =?us-ascii?Q?wVLrHvwH/LvRHlRul0VE/q9Acnk2CSRrQqg+Su1hPhpEMgRXEFCw8qCuMJeG?=
 =?us-ascii?Q?JkEkSStlnt3U3PJMponHFBs94X65xoFJZa3LyX1JrlWYDicH9k94EnqOgPDb?=
 =?us-ascii?Q?XhFtaWHIKNEbmRBQHKD4boxJ8kF+FQJeyQkNwn2ftD1DB+0s/AD2etys/N6Y?=
 =?us-ascii?Q?mQAmmBzBj8XrDHFSmQ5Jw2izY8ne2l+MoZEPNvKcFG0uUjCBDJonLoT7QDdG?=
 =?us-ascii?Q?5IUBXuqMUr7zUp5UamFGjB7fM4CLgJx+8RfC6z834cEn+YEPJhdfql5NZDW9?=
 =?us-ascii?Q?njralVMzW8JDtYymS1b9dOW7rTuJy4orxtaV7ZOZ4biKpSuymKbGrIS325UN?=
 =?us-ascii?Q?3qxri7mVr9z6BF+HynM9wD0hCCnZ5ywB8gJDKouFiYffcnVkDh6yogzyYcEf?=
 =?us-ascii?Q?cyVRJikd166oBnAPi10m7koqEJtFK6brpqnaVEGxoqeBimFJjacgAuLzZif1?=
 =?us-ascii?Q?hGJNiJ/TRbKsoW6EXiX0PsMW13oOoRYMmPHTQZy945GPlsxJnTi0j2F5IXFv?=
 =?us-ascii?Q?VdQjpHq25GfFaQJUGj8YrP0yqmTvzzyOIBoKCkQ6uMMpmuzFhnThC7CEOA79?=
 =?us-ascii?Q?C2gGjOzXcvUIbjUwHkTHwbGp034yjU5PW57SxNyYdtwEJ3dT0hRUxEngL91O?=
 =?us-ascii?Q?7cuoOpsp9M6NJ4W6zCTJmexTIZgx8zOgttrHVNVnUWzbfoWSdary0KoxMmFd?=
 =?us-ascii?Q?OhYIKmiQFwlFcNVdh3DNp9dnJ22S9cr180U9CiOomK35hyjZs846wl7UTBIN?=
 =?us-ascii?Q?mAuRlXwLATw0f/CaWOek0SWhzDsMzk+Id6GpCAiuoeVjqCwRNegc9ruOJVA3?=
 =?us-ascii?Q?TJDWyMuMGFZTsVofmP88aYV67nfS9gDqG/c86oPCcHHUN+/S1nWmVL4qj2c6?=
 =?us-ascii?Q?ljndmBGkR1gU64Z330gV2toSbikJnuVQZ7liPHEFJjRexcTkd1Q6dcKCh00G?=
 =?us-ascii?Q?KojcN2EH27q2yPf5pCxjwTPaROW+upi8fLlgG0z1ive/4wk75Ax6JSmif9K3?=
 =?us-ascii?Q?aR1SsSbmVIu2JE+01z9foh22lum+9IAlHXWaCKDxvPrPzRJBD2j5I+BGZjp/?=
 =?us-ascii?Q?ZFlpZkWW/yoPxSkhpu6EmL9J152CXxHvHpypcM260H1Sx7GiNAaIMkpMlAtN?=
 =?us-ascii?Q?7EVpeiWnQGe8aTSOWrxELf2O8RUnmagPj46RyVbp?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6703f8df-e93d-4c3e-da66-08da8f436a41
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2022 13:34:53.7742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iOPL5yso48JaNaB5+l5PXXZ3cBCGZufEgPsHBxdg7Ke3qLjTixi8hBmSU1Rinfwqs3bY7kkmcwCeD+/aRZ4M2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5585
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checking for hw bound key. If yes,
 - skipping the key-length validation, against the valid min-max range.

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 crypto/skcipher.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/crypto/skcipher.c b/crypto/skcipher.c
index 418211180cee..0f2d0228d73e 100644
--- a/crypto/skcipher.c
+++ b/crypto/skcipher.c
@@ -598,7 +598,8 @@ int crypto_skcipher_setkey(struct crypto_skcipher *tfm, const u8 *key,
 	unsigned long alignmask = crypto_skcipher_alignmask(tfm);
 	int err;
 
-	if (keylen < cipher->min_keysize || keylen > cipher->max_keysize)
+	if ((!tfm->base.is_hbk)
+	    && (keylen < cipher->min_keysize || keylen > cipher->max_keysize))
 		return -EINVAL;
 
 	if ((unsigned long)key & alignmask)
-- 
2.17.1


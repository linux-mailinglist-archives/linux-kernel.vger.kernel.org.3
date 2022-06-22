Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0265554ECE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 17:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235799AbiFVPNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 11:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359118AbiFVPMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 11:12:54 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-oln040092065104.outbound.protection.outlook.com [40.92.65.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FDE8138
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 08:12:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SZWga6wyn5z035n7WV8vo7tACbAoajlnIa9wnceP0qaegzoTCgyCz9l1cnaPBAXMQWEro6YFOU4MJMGGiR8WfpEmmnl6UwvCLEXmCNzqFd/6uQEebtD1YBNZt00b2i0j2vFV6bxAZ8Nt2j8U0/etqaN0M+M3+qxQZYVzqQCGZJOdKkZmVjtHec59G9hO7qfT8lmzXgaqOWI7AHh96RvDQKDDSuHy69noGKXYF7Tz+lpK3V9MqwtbIP1ou+q1loVPm+cYDztFejdTqduPas4eRo5/w2anGq4TU52LWSOvcbniDLUjSKFGs+dKjR65YyQ/JAZvvacrGv3A5jbaIw65ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zVFFf2YPFHvBQg+aepMbzCOIcZg6Aa66AzPHUIYDW4E=;
 b=a9GoDhNqdzUJCGaMQVJdlQlP//sKuppRWmPJlnHHDNl+VoUQxmk/MnuZ+Xghz328XOOebpe3a9lg/au+blYajkwDkSoAc97gJM3L8Q1qDUnYI7cP5ltc4136dVg5EKQX1bPsGMbuQy856ONB8W3AWlvX558s5dvy5YUQ5KoUEU1WB15/LgQnB39cptmzTcnE4gunKWMG72+TSANz6Jcoioip2LjrD+E7aRltAkzhv6W+TxL0SkFBoguXrU+pEIKqCrvP6oW3Gt7AWgZmsk+Yto/7rrIx7+cD/Emr82DMla7Gg2Uv05LEjXqm8HslWCoM2ku1GbEh+PzlEDDGuGVktw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zVFFf2YPFHvBQg+aepMbzCOIcZg6Aa66AzPHUIYDW4E=;
 b=axl0dxo3UZlzevRsOUmjn+3R3PBBKimIjwN3xwfU5O2pEFa+0KYh0VPYMOuN1uMmCAalGZQy6LB08ukRGKMI5m3SQqfOXw+WwUTdV3nuQr/lfdKV5JTnGuRnkE8gdndBduVNQuVLQ+OUpbTt8FI6d8PWT78zx9qbhxQ/V5Wy3mzpWzigk0DhlRsBr/aDPGGij9zrVkBhgGZfhiTzTzthLfEVvbqqkqJ5jR9wK831Nxw+0vMO1sXY17vgLwulQcl+kkty+9QOPWha5QtnUsSDqq5DOLieCmQ9dXqZDfwnJcSWzLZaJaI1+UGc6pF/BpJ1+rft0ejbmliur48EYKMZXw==
Received: from AM9P190MB1299.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:267::9)
 by AM9P190MB1041.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:261::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Wed, 22 Jun
 2022 15:12:49 +0000
Received: from AM9P190MB1299.EURP190.PROD.OUTLOOK.COM
 ([fe80::c0f4:a98e:332a:2397]) by AM9P190MB1299.EURP190.PROD.OUTLOOK.COM
 ([fe80::c0f4:a98e:332a:2397%5]) with mapi id 15.20.5353.022; Wed, 22 Jun 2022
 15:12:49 +0000
From:   Felix Schlepper <f3sch.git@outlook.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] Staging: rtl8192e: Use struct_size
Date:   Wed, 22 Jun 2022 17:12:44 +0200
Message-ID: <AM9P190MB1299196F6CE98835AC3245C0A5B29@AM9P190MB1299.EURP190.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1655909205.git.f3sch.git@outlook.com>
References: <cover.1655909205.git.f3sch.git@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [4grtCLqZ/qgfN1Trng1wjkO+1qQOezzx]
X-ClientProxiedBy: AM6PR0202CA0070.eurprd02.prod.outlook.com
 (2603:10a6:20b:3a::47) To AM9P190MB1299.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:267::9)
X-Microsoft-Original-Message-ID: <54ea62a2b7628d3bdd5aa52df82c3e91704a2127.1655909205.git.f3sch.git@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c130de06-683a-482d-76be-08da5461ab84
X-MS-TrafficTypeDiagnostic: AM9P190MB1041:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /AG+nr4gid2rqNOgisv8sgB5wvpKKa8RrRaewk1BuxT2HIoWzVQ3xQD6+77FqcEtlWAHu3uTPK+bPmrYFYi108bn+uI6BWuQZWE7RK9eVSCflM/tX1c4jdUe75LyIwyJxLRzUtYJLJ3zirCMtwFOlY1j5WKwhwuCVMF2FTkWgspc91yvtZbci9X/HtWBDqizclePGheRZpokuqMF+6a/mHut/CqRQskRGX60tTV63jiMg3h5RuvuGPbXSSqC72/uqG0rJE+FGK7ojy6+pzBWBVrm9BdIr1Q4xEhF7ISf1IXLPngRvLgaNDP1HfiRYgpkuTMvPxUlADb6+RvWumDsflgvgq6eCrNcbRcRbIta5TYa0ZsGBx0rDfddq8q2P9lXZ02Eql/owcXB1fHPRhEZ1QUY5qq4ONyMjCLmLWScANk7ddfRrP96Ne24bqMGYBFNWeaUHzZZfKZYNAU2i1iWXP/tpc1x+ppMopo5+1UU+XH1ZF+W2x6dQxyayMBE+vr7OHguDqCyyHjRGe3LXsEto0rDtMFAUveUmdQa6d3fAd/NyOyTZy/+qP9nK3RPJQEnsEB2/FafDAWLSdP1zJqtXQw+0CmzIpnAp574teLEL8+v1Yzi+OQYl1lvP05azhNomjBJNylOLi+ZdmoTmSRF5Q==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RWfsCONbAyUXw4+Y6Pv41KNhP/D1V1Ommjx+IJTIek+UZQzyawr7oEisiSx7?=
 =?us-ascii?Q?GOE/5+DjOLoYD5srixK+2AeCmh2sCcq79Lj9OuMgN1vVT/s6fpbM5TaMGFn2?=
 =?us-ascii?Q?bTVyj+zZm+5XW9/w62sjdH/2V3PGmBTnFSe359FpgVZ9vdfg/MvPmNpfZbhk?=
 =?us-ascii?Q?wa5KQ6Ocb0ezic00pam65S9fsDcHeUAtql3EaCE345FOyS6PiWwTH1OY5w7u?=
 =?us-ascii?Q?ceK1ssJow8XxylA2A4sfsiRMu58+JzMUljD3cKpZPE3l/dP41k8AmS5+J0tF?=
 =?us-ascii?Q?Gv+IzEPZIgvll0AIbRg6F59bof7f+711HWJGEEMe1om88xcUBUWHYYh1Zrgg?=
 =?us-ascii?Q?f5YUoHq4P/RLjTIUeykfjhOsrzdYpoVMSBBcR4TJ9UZw2eiZzje1TLvRdwjY?=
 =?us-ascii?Q?V3SHnQ7G29hKcpu6nCE5yLq/04qhs3hpVFwUmFfOsX03D0wtJjJQo/2ekfUY?=
 =?us-ascii?Q?zUarDRMQtdsFyRT+jKtJnRDKsIzEIq4b6dSvMwwwuKw4L6ONMV22Xmf+UPtc?=
 =?us-ascii?Q?zbHDQlKaZergBfkJGRVRWwjW5hKBrUz6n5/w95KkD1899XLNxPvwA+PUj/O/?=
 =?us-ascii?Q?OSgJr+L887IjYK/jxiSJdY16Fzns+sapOJ9M06FU51mjs4YPW4OJLxWd8WhQ?=
 =?us-ascii?Q?P8/t9JtngBQ+cOKHQrzIQd3x6umEv/5eAiPj97/W5Dz6I3Yq56X0P2A9FuUz?=
 =?us-ascii?Q?3yrFtShmWzV9S0Nl6CdeTrFkl4RWMGvi7Xqb3cp+2EMXXe21PPtVtTindm5h?=
 =?us-ascii?Q?SUgzaLQQPHKYt7UnQLBNP4SRHECaT3NAiQKYxxFhEJNZ4ksbcl/KL/G5SmJ2?=
 =?us-ascii?Q?t5AYG9W1h47xX5VIbtAv29pPOYL8VHSNkB1XcNgD2c5y48V/Iyk7Vh0dpNW/?=
 =?us-ascii?Q?PatcALza6cyVKjpWTMAYB03GypI3xeDlthDGPW+RtEwhRf3Ru+sHZsxKUmzV?=
 =?us-ascii?Q?T55WFs0xgljjHYT6KFCSVQrMgBkUiaoOio35WsBL6v/qNeMAB5eIONeDPcEb?=
 =?us-ascii?Q?uXBY3HROUJ7LBT1oyqwduG0zrgo25LIhEqEhvNJ2MDf7Uj/cT6f+/eu45Xb3?=
 =?us-ascii?Q?g7bZE7wu71RUPXwNLt39D2qyOQ5DbpmBUK7Keca6VyZyXg2eyGRzjOKuGi4R?=
 =?us-ascii?Q?t1HBFdp9zH/1HrsLCXDz5xNWXYOaw07nCiROEVtQ7DDLhZ/06ictJwUcVcTi?=
 =?us-ascii?Q?na8YuyC80/jhgGa7tjpDk/9u7QUVNn4OLTgS1dsaSHvz6g43Xk1lBqimUFmR?=
 =?us-ascii?Q?KJVYX0h02TcubrhYLN0EO1wN1OWsRrZwY3VBPyNP6wzDDcbLWFErsIFhP0iD?=
 =?us-ascii?Q?0SC7lD1VN0giVZNwWbBhsgw/yTuz50QumZfFyrp1YqgVdLqCx79Oyq0zx0z8?=
 =?us-ascii?Q?JXsKSoA8iK4s8o/LBilr8HLf0HTsftRiC635NjCcYLhRn5+1QHURduVi53S4?=
 =?us-ascii?Q?bKrzyWhKCJI=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c130de06-683a-482d-76be-08da5461ab84
X-MS-Exchange-CrossTenant-AuthSource: AM9P190MB1299.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 15:12:49.3742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P190MB1041
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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


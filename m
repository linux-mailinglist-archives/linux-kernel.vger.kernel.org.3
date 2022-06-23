Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE11557761
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 12:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbiFWKGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 06:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbiFWKGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 06:06:10 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-oln040092066039.outbound.protection.outlook.com [40.92.66.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0663849CB6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 03:06:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MBDzWq0h+vr3r204eLy8be/P/b5eVcMxrPfY5a+0j/B7X+3iNpTaHgSib8tw2kvoNOdSC94C3nkBhEBEwWLqN2kAWmjC2pdaKc4t8/ppAD4+tZwjtq1daSyzzeVQd3nqtiD+Ggq9QLTwOWbx4hJkPOZqmUbGJuhpJN5VpqKJW4mmIuO8FyfMUr723Hk889ebsmorhnOrf3EDKECFrP2QCFAYiyV+6E15kvMjKlq3V0tHI63bhw6ywi4rYzNCtDhQSp1FYKUhrzCIRSdgmEdzw6Yj00rTmQHrwbNkqzFy6Nyhe4sNI0nM/t2FjnPkqXg+B99IEwuqHN7Qcm4MsOGRQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zVFFf2YPFHvBQg+aepMbzCOIcZg6Aa66AzPHUIYDW4E=;
 b=GuHAHTblhF2WsqHM92tytQPZydhH6AQb1PrgDulzDMRrR8fzqvwRonLMcNAnl2IgzLnXdogFlR7T1FKpwUOG5/TQ7KxWtwN6+eaK9A205N+xBBtFSbrhtTAJ+I4qo2tI8HZSFHpM9NaHMyj7iizJdnNo1ralDYCbMpJ3MsSZcK02ODg3bAkG0BSJqvzxdotOkjlce2cNefIZmHcnXrv8dtu+89WdeY/bJhtdEAMWmyLm8tjK+zn0FLfT57NHNsXGn5KbLo8gbJ4bD7bAjsRVhssxIIk5C96v9mMCBp/eiTXaaFKDXSF/366/z974wrsE7Ft8pZzgA2seC+3DugOCfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zVFFf2YPFHvBQg+aepMbzCOIcZg6Aa66AzPHUIYDW4E=;
 b=lLuivtSuPao4RSV9yYe2LVvibjOyieZY81CLCPWanVjQRmpb4sKEaYDW7u39Lk8VwqbKYrjyRYdJe7eFs79HQVUJS2DKEnYT/25SzNVMfDDux9e7PHxbnePuTMrp+vqr7127ZaKzgeavWPlUuO8POLXGcuAlErVi5x7BkhvJ4rYe6SE2b4cB9KYklxtLFfLqLFkLAT2mFYVxZhwQifA1UykJksMrC4s5eLkYK7+nR5TU1VS8Du1Y0Q8tes+cYuCqXGZq9DJC68G+025dfYO2awIj2Inc1Mf1Ok1ZT8FBZiogCD1nd4zRiXsYYRMZ/4c/ZKzlV8cBbqGsWy+6oHuiRA==
Received: from AM9P190MB1299.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:267::9)
 by DB6P190MB0263.EURP190.PROD.OUTLOOK.COM (2603:10a6:6:32::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.16; Thu, 23 Jun 2022 10:06:06 +0000
Received: from AM9P190MB1299.EURP190.PROD.OUTLOOK.COM
 ([fe80::c0f4:a98e:332a:2397]) by AM9P190MB1299.EURP190.PROD.OUTLOOK.COM
 ([fe80::c0f4:a98e:332a:2397%5]) with mapi id 15.20.5353.022; Thu, 23 Jun 2022
 10:06:06 +0000
From:   Felix Schlepper <f3sch.git@outlook.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Felix Schlepper <f3sch.git@outlook.com>
Subject: [PATCH v4 1/3] Staging: rtl8192e: Use struct_size
Date:   Thu, 23 Jun 2022 12:05:55 +0200
Message-ID: <AM9P190MB1299DC80EE63712B0EECECF6A5B59@AM9P190MB1299.EURP190.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1655975970.git.f3sch.git@outlook.com>
References: <cover.1655975970.git.f3sch.git@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [7sXhUuv257+aRESGD8u3S+WKSgG4GTfO]
X-ClientProxiedBy: AM6PR10CA0038.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:209:80::15) To AM9P190MB1299.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:267::9)
X-Microsoft-Original-Message-ID: <54ea62a2b7628d3bdd5aa52df82c3e91704a2127.1655975970.git.f3sch.git@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6dc78836-cf43-486c-bab5-08da54fffcc0
X-MS-Exchange-SLBlob-MailProps: EpEO96k6WokJw9qhnqKg7+E0MqObEIk6jipd4eOFDx/Oyu+Wl7XZFcDsLTGz/FusbHL0KrB7kgM5NGzDhYXQLXEXRiVzV8brAAvMLlX0Z9wGpukV8JFJNMYlz5LgvwPj+lF+En6+M1WkrTbS6axmiUgKsUHLAmv1o2gaC48JM1BvFOmX38i7RaGC+40WU83Cl9+uB7UM0/73sMNS/LRt7EgYg4x+AMZFhLuVu6+mcoLLe5oPKVHRdthDM/Mcpc7t8IuFwL1pCmSRk6b8oq0xNjQAsFz6rEFjKUukm8pdl5DaIKTfo9p/2qMbPhq4+Ug1pViRWVnnG3F8CSKqAyoT4vBheBfOp1SceLvXfOIzlykHnLikYCHg9zWHQ5O+5LfOvxyaiFaLORHuEQImsmb45AmtpCA/W+Uu1tgHUV39q6V9TPbpwDlcJrQ4O3D3tx+N0N3A/CKLoU1/98TDWuzyq58IdRTgM4z/THM8Xya8GF61JCa+UtyhdqM4vDY4oou0LZO1p5WJZG9xX17rSb5lI5BdVbO7BtozazfZWULa9SH7Yzvp7sBmwloDTMGY8R6bvMVDTVrqiAQL5x7VmtWNwYWrm4rIoOTFMfLMo+/O/U7Jq1rTBnJH27zhDGSLCJa6MkJQt7kXMRRdpyz5/kvcIgIP2mvc9N57xP/loyxz20ww+YCf87rHgOl2JAwcjsDlLAiAORgtTzaeJA1Mi5TIYGWGPR3IjHfvj2XljnxzHPzO13w2u3q0naMX3LI546u5rQeISk/qlT4=
X-MS-TrafficTypeDiagnostic: DB6P190MB0263:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: frZpBci9S1A70MFVabPjQkmBtMGFpMatWPPWz83UsjeK7cwJYWP5fjvqcszeleaGvDtOeozrJ3W0Ba8Lu/9LCWaNsPiMOrYHu5WJ0nJyyALrheULkxC0S//V5KSXydl7cQv3tb7TC87ZrQSXsmvrVQYIK2mg2PxpvrVjXh6TchyUZLK2/dT2Tgth9Zivqe7pe7sTi95tLpcse04nL97xAKwg10253/miu6RAZrGkL24ofa+M4piEkpheuuqBjFw3JY5m7c8EHYb6f/mdK7Yuk17Bn7y2Y+WwePpfouAABSBk6mvy7RbZho41Q+3jQp31RQIgxO1xVXo/QG4m6pAjXnVTjXfutZfP8Iy8X2kOnsmOXfPugWRQE3t6/hz4m69cXunoEJ4M/UYeo81wc2PprQTbPbkI1nqzpG+GFbpnJnyQ5c6oOGWjyDzM5JPb21abkMqHrwnNKjflNtLmiAxzG/WQoreyp1rtd+/rGYvgchwyhrx5u892KpRIg/DDXUFyey5RsRY6VmsbF2lLOtVU/C3RX/J70E911YodaV5zRA8l+MH4vOqZeYdWPbb4wlZuq2bDs44xkdOmhqqq4YpCVTRz6L3oLkocnAvNGyxr3FHWYyZbk/+fJPe8nly/6G9+OcpWsdnsxWd1CXdXqOhTOQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mmuRsxewlyP0zbmRIMoEFGhYujjBTJMhz8LypcXRZahpePaSXhuDlrfOOUSl?=
 =?us-ascii?Q?xvSOw20U3ZQiBsvwvO1w0GrlTEmHPaCsuSQ630/ANkwbugeMfy4+ViLeT6+s?=
 =?us-ascii?Q?IjsAiyR9AQgsIRMNdpEvqsroU8S0cWU9KI7JM/U1QmwSfnUhhObrEcpd2AI0?=
 =?us-ascii?Q?41cnr9hjljn03P+TGKQJYJlYuk44A15zplUShps/3cF6xb1RRI7CJ/kLoC5P?=
 =?us-ascii?Q?/3IyMMgQd2c85Lkl4PHML+NKxuWUYPZ3smMKoPUWsd2szM6gCsUrHq4SA62S?=
 =?us-ascii?Q?dGrpW9oAVZKstGInD1oMUqgwF8w/bjgjyVroHpMEBi5ifbpoWH57cjaS7a05?=
 =?us-ascii?Q?5YLI6WnBPKlP5tWAUPW4pJQT6Bbr11W5AY7v3zC4ent6Ux3jcWMxtXjwNnXv?=
 =?us-ascii?Q?mqBRIaIzkcFp4Bab5zLtuz92qoK7pQQW0X3iMJNZ0H7eBfHBUC9n+Vc/8daq?=
 =?us-ascii?Q?LLRmcMKCqqS54AzHvtvw/kFn4j3LGpZo1W4vkL2JZL3cIXqcCbzh1XvIgMED?=
 =?us-ascii?Q?N7walDXXmqF/qWpcEU+jSAExvsbtu0avZRpGGa8SCshc+zwgNH8GlHnRBWKn?=
 =?us-ascii?Q?wH1Q1EcD3sjZQvZzA9ZVsTb7/NcRUiuQpaI10NE0xTvQVv/WY9zUbX9YcIEg?=
 =?us-ascii?Q?xeRv+Pqq+jecdqubxv9W3FN/z3IZHS1XgyiF3E3EFEuPaXt3JZ85EBuX6iuF?=
 =?us-ascii?Q?ewe/bg+TpVftH0gJEIjOXhh46EmF52kdW2i1T6W8oNB5qWgzjRSSNnOELjLE?=
 =?us-ascii?Q?JvhIKgDilf6kvy6EJ9smgKQBKfHpVv//++pcUn1etBu9h3D2jV/vBOfUngCM?=
 =?us-ascii?Q?brphETOYF4RYXmR+XnGNJEo8IbFpNWTjy7cNQw3zJXh0N/BFIpCETcn0hBGu?=
 =?us-ascii?Q?cqFqBddPJiSi6r7TDn9PDiteDawJ+VqFqnikW72WhY6TXtwM60Y3YMqa9xdL?=
 =?us-ascii?Q?O4Eg+ahvAyr7M1y82Xv6kUtd6MpXVH5JgwaBzeeXeTvzoZXzAROOnOyOQyAA?=
 =?us-ascii?Q?GT7OZSDfRkmarwlCmSrSQ8pL+WhPJM8XsFuP2kW9upNNaKCQW2SW7cfl5ibP?=
 =?us-ascii?Q?GjPM1IN3soapVn46r9KioceWMrwQGN7Xv2b/mZp0o2yqbgiLfD6G4u4bbIME?=
 =?us-ascii?Q?k70+w5mTwitZVg8v+yas1LGSnYPQTXtrnOb5lNgXq9hLCCfx1BlnyGC3nsFn?=
 =?us-ascii?Q?0LTkod+sxlKoHYBTpo517qNbNzwgXyEKVVvoFeed7F4sfVYhaTAvzazrpFbs?=
 =?us-ascii?Q?R64vcl0BYbLPVPvdElgnq8mfANruJLzSaOf9WMEeDQ=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dc78836-cf43-486c-bab5-08da54fffcc0
X-MS-Exchange-CrossTenant-AuthSource: AM9P190MB1299.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2022 10:06:06.1479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6P190MB0263
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


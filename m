Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9313A554ED1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 17:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359150AbiFVPNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 11:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359127AbiFVPM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 11:12:57 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-oln040092065104.outbound.protection.outlook.com [40.92.65.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1F4624B
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 08:12:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XuN6fkL2nFlXL2HA1lyb0fe3FTp2g/4zbFkq6EapEK/UuwHk59jOOZvV7k97TJCnxzJeYO7EXKQbAJEkg5dm791RF6JtBLJuiUQqUS4VpI3Vf2bw6BZAslo1l3FTMkzVn4so2Ira6rpHYj4J/9v/k+cMnvuEFAGVowjcHoUwIn8/eCCahFla+0NLvzo3bm9vVCRTuxVTgv464h6MsfS+PGI+TEo5XwE34jWmKvB2GlwWlHgwFjDOMZRLy7Zw4dqza0t8cP73iAnr6/8mb/m928rHaMGaVCVpv/9qBGBUwZ3hqb3UW/2oXoVDJX25jWJ4t3vBh/BoZneiYfqAqaWLsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z/wicY753Hhz2QvvQmOXGJ1ASpyW6qXHnf+vKds1o+4=;
 b=ayNx64B5N4uC790UtrmH26tg53rrEQLu7McB63jlyB4Gd4Ekvtnsw56WhXs6R6XmLTdcWKHW1zIncQlqUXJxpbLvMfKZFdsG+hudzdjhZBZ3ncYsHP1XbLAaUD8XMmbbaUvUIwu/rS/YdvvtEE7099YUxwtevRUQ9w8MQqwShOlsn1fQK2eMMN+i4F8/qfL6hArERXgwct3FvxMvoOuKqU72u3kiG15TcNgebeI1JI/j078N53PUjhlwv79sv7TL9gsjttHsJ96RUkCH6FLJZmjGk+uZ0TgiOY/+MmikWIwYNBQTaZGInrjxcynIY3qArNMWlX68c+zywp2vaCmALw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/wicY753Hhz2QvvQmOXGJ1ASpyW6qXHnf+vKds1o+4=;
 b=oLJE/vCqOvApgataibW3kLX5rvbBJPclTuexGYysJQrykiLqQhw9vBiUSYzMhF4zbiIjnKHKFAiRnUNmD035lMXO7tcP28ojunKEfqDad6zACefVXV07gf6uDcy8CKKOBjxjTFNQ2x2ZOhuCI3GTu+ptDeV/j5ZG0RZZsVph3E4M+bNpvylqXe4OEvML7ZQ8cHKWYb1U0tf2ld0SW1qodibDek0QQnjMi0dVT/5NqQxPIwTzzcnLAyoClZMkYtuM24XgxtkrfD82SWVf9T3CzqOF/dak+bZFl+tmbM1Bo3KZO10BtaltjxdvGSWpenzPIME1Sgx8WHFId+OWVOfs5Q==
Received: from AM9P190MB1299.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:267::9)
 by AM9P190MB1041.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:261::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Wed, 22 Jun
 2022 15:12:52 +0000
Received: from AM9P190MB1299.EURP190.PROD.OUTLOOK.COM
 ([fe80::c0f4:a98e:332a:2397]) by AM9P190MB1299.EURP190.PROD.OUTLOOK.COM
 ([fe80::c0f4:a98e:332a:2397%5]) with mapi id 15.20.5353.022; Wed, 22 Jun 2022
 15:12:52 +0000
From:   Felix Schlepper <f3sch.git@outlook.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] Staging: rtl8192e: Cleaning up error handling
Date:   Wed, 22 Jun 2022 17:12:46 +0200
Message-ID: <AM9P190MB1299C167B21A1FAA157AF1C7A5B29@AM9P190MB1299.EURP190.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1655909205.git.f3sch.git@outlook.com>
References: <cover.1655909205.git.f3sch.git@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [GSw7RXvoOScbjFOl1Tyf+cmfkcmaKUYl]
X-ClientProxiedBy: AS8P189CA0009.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:31f::19) To AM9P190MB1299.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:267::9)
X-Microsoft-Original-Message-ID: <d4419f7ee0f90c11ecf2dc1ed58e75fba1a5f062.1655909205.git.f3sch.git@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 651dfbb6-830b-4262-4528-08da5461ad5a
X-MS-TrafficTypeDiagnostic: AM9P190MB1041:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SWE2di/wUSDifWptz1wfPb158TRf6S8gH/OSolLgPdUhJe3g8sSz9O+oTwmLKDVb6xVzEk2z5dF0LX/aFdthrhSH/qS9tPxWRovYcx2zzxImAFeIISe6Owx4YecwYs3XuL3kjQ6NjPpTm64aV7QOgHG6xVG6RON54GBw6ECqIFcZOXQjheyfBfML2a7i8vDxBa+6R9nvH5FziMXqoRGB3AfKKIdSx5iHoz/iMOcFHAYs45kn93hAHfHMoauoN8BiwlJiekhhEX8rzc+NpxiaZpE7jV87pe+Xm0Mlh7sJUbr+8Un0neRNKRV68Ie0Lj3RgDYANpB8MP0XgiXgBumdAi/REi8apzNXZMby4il1ZO5U7yzJK18yrFRwUFow5rDZfF58J9+/WOaXmKDLE3+eM8LCh7le86eMBBWXC5WeWEcSMzAhIWngeey2XIK6UeG6GJBanpFKzNs3Alc4ZcoOd/EP6Zu6bUcZrvjMPu8TsC0UxaXfyp46NQ00Fo+bS7PZvaEsYz0oFovkVHHEhCb+NynZv+tjydee1GVqgvn3VdiGjyRPfDJxMmRsMiAK3PkLyhxuyxQ3TmIglXpVQBH0vAN90PuQbpN6MtRklKjCjvF5dsWTi+wMWSJjau5aikQICiVngJCZLUBgcvVtZBH3GA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nVw6A/GudvU0uElzrV73ZQ7qWhlBVwxKll8olNyG5aNBxr9qDok2bqJIXLtO?=
 =?us-ascii?Q?1hAsj461Sj+RuD+iqkhTYMfu4Jp/RbJd/+DESrrVIrMB62tCh0qqoBHAvM9D?=
 =?us-ascii?Q?xQ3F56tRJnVAbhRej59WF1KD6aofJDJds17VS5UotuS6vIzumB1V6Mgookxh?=
 =?us-ascii?Q?mr+TZflBhvirbA5aIKyw9GOPwqWAU05MwBIDCsn75QO+PuyLopNqjb5yWqmz?=
 =?us-ascii?Q?QwzQ2AKtkYvBd0NYvYOJsDsFdd3p9MiF/b3OtW9p0mDpQd0xm6xmxtPJRCuU?=
 =?us-ascii?Q?b4eCMRfUKeoNyO8sUph60JDB+zIS+zBiN/zJr25az/y8itbZv5czaZ/Zzt5/?=
 =?us-ascii?Q?OZsQZMoUbpE/YlFsFPX27eoBzcsToikmer/skGVtBf9cI1rSdQuLXdCL4+04?=
 =?us-ascii?Q?Kxx1sMMC7wmeE0ZHXXZDtGttwHryEKjb3Hic/bF4WuDyqz3znhEfAoSUL0uw?=
 =?us-ascii?Q?wLnGxSM3Ao1Sab+88TJevEDAJmFvlQttGxww7ZduCdGJr1Oa33rhv9At7pET?=
 =?us-ascii?Q?r0yNTb3s9sidbWoebO35dCjE0QadzWlT6l9MrSiIsWx5+W3gmrtgTtsls98t?=
 =?us-ascii?Q?lxjMZ5AY7nwxBkWhnvG44gxHLMqgf/9fbWgZ5DklUuXzAzxtJSQarZ8GpQz6?=
 =?us-ascii?Q?Z2i+Ygkru6rafvLniptS+QQKFDPTt4Yw0LKRkhym3SPi2A7zgh23mgGQtvjW?=
 =?us-ascii?Q?70OIhmCSuqixqilQoyYqXiyU3XPWsA31y9EVYheqLpNOBabPnxm68tYzw+Lt?=
 =?us-ascii?Q?Ta/XS7K1tWHHoBMPZb56UTVDPPcLNQfdUpCg7gQZxjmzxz7uez7wD5WWR4bG?=
 =?us-ascii?Q?n3cXtNWbG5vLAL+2i1KqHB2KKs9Ido3pFrNfwj4fOuk5GRdc2ws8XKkziasK?=
 =?us-ascii?Q?nc8ciUAgxXQ++HjdO6dFMgWXVBqUVqR4BWkQAP0RVcWtdcBVqjEPtbkxmpiB?=
 =?us-ascii?Q?sqQfH5Hr77EK4xggBHGFgvqecPr8152yabQdIkLxePLIXpLhUz54UgRslKP7?=
 =?us-ascii?Q?SNeP9ODOR82oVI0PKGqhoMRnA6dgqqt6iXvVdSQwAMYwP136Q0U5DCY65FJz?=
 =?us-ascii?Q?1K8HmAJXDmxuvviF0JO4drrm4ZFR6V4nTim5noIg0v/HbFiU7farBVZn7HV+?=
 =?us-ascii?Q?EI/f8OQww1kipApabPq8I52OnddqAycQB4woq65QBfBkpEl6z5B3jmjVnRu6?=
 =?us-ascii?Q?+19/lKUZiEoE5HMnMSVXF3QpkuZe0oYZ4c5WQ2Nmj28NepA5Y2/mkhNOlA/G?=
 =?us-ascii?Q?jwoQn7aPT6/1t2Izh/lfDyTHO5VRYY5Wo2B3b1hbMGvDll/ayFnoC1ZfQxCK?=
 =?us-ascii?Q?weO2BQbJZ4MRcVsSBH8U1e3VbgF6ZounRLJW3Yk+5VCLYCRpjeZXD9mAztAH?=
 =?us-ascii?Q?qc31FHPwb0Y5atCiHdq58wpGaxZNUPQpHFA/hY1S1sCBny+jd6MKa+Oi3VBp?=
 =?us-ascii?Q?3GPoBF5tGwo=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 651dfbb6-830b-4262-4528-08da5461ad5a
X-MS-Exchange-CrossTenant-AuthSource: AM9P190MB1299.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 15:12:52.4374
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

This error handling is more readable and reduces code size.

Signed-off-by: Felix Schlepper <f3sch.git@outlook.com>
---
 drivers/staging/rtl8192e/rtllib_tx.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index 1307cf55741a..b246f5e0cad7 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -214,19 +214,18 @@ static struct rtllib_txb *rtllib_alloc_txb(int nr_frags, int txb_size,
 
 	for (i = 0; i < nr_frags; i++) {
 		txb->fragments[i] = dev_alloc_skb(txb_size);
-		if (unlikely(!txb->fragments[i])) {
-			i--;
-			break;
-		}
+		if (unlikely(!txb->fragments[i]))
+			goto err_free;
 		memset(txb->fragments[i]->cb, 0, sizeof(txb->fragments[i]->cb));
 	}
-	if (unlikely(i != nr_frags)) {
-		while (i >= 0)
-			dev_kfree_skb_any(txb->fragments[i--]);
-		kfree(txb);
-		return NULL;
-	}
+
 	return txb;
+
+err_free:
+	while (--i >= 0)
+		dev_kfree_skb_any(txb->fragments[i]);
+
+	return NULL;
 }
 
 static int rtllib_classify(struct sk_buff *skb, u8 bIsAmsdu)
-- 
2.36.1


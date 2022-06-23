Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04BD557CF6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 15:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbiFWN27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 09:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbiFWN2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 09:28:47 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-oln040092072024.outbound.protection.outlook.com [40.92.72.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9132CDD8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 06:28:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mm1pF7XRqgwLEcL4JlyTBotNoFMd3+jYq5c5wA2CvAuxQqQ+aWsDQwUaIr2E4LJh8pvv+xh74KIYLdpDKuPH/2Y0VLGvwopyhg5yendfWp6TnW0XblNxxoYP92e8NI/S18udsn8487wck4mv5poQriMS3lRtMwmFeTuYt2uTIFYcRmyQ7RVurI+fyltHv/yqu6j9ae07E6ekvJhMjAXSX6v33Do0sp1T/HqisTpI+/SCeXPNTmDLRGCOdC4mB5uiAopYI58INeZLsaFTh2trFa2tE6xNxqBEKt9+XPN+jhRTSHXaUxEqO0JlluebIJdEOvevTjwhl0nOE9X1di58tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v5KgDpnFfukyo2JjpZ39r1xxGFxbCzXHBbU2i6LiqU4=;
 b=UQIwUdpOx5nG4PvrxH9ApPBATsqjouUmMz7AhmqoJNAkLpIlgURhWg9By/jDqX95/700U9U60wl2wdE/u4kSVCwUXmYpGzwD8jaNQuejrsFmwUrvr7f9oP+ihY7GPkY5iPof/UiQ8L1Sa7dnsV60iWT5qsKdgJnbXJzF9xfqscZwrWUoveYF3lZPcPfrxO6kTIYEfIuloVmc1QbMQOrSeM5rNdSpjn2AWDr0r9T3q07cA0JXeHYit9M+5L1XcGdOlVb423G5VzB+S8ZP/LLUzxs6/pgDd2g5aewcHy55nYt4evnagTYdwMCPKenon6exSz/fMCm3TaFBy+6MRSpggg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v5KgDpnFfukyo2JjpZ39r1xxGFxbCzXHBbU2i6LiqU4=;
 b=aMb4E9JFjygS7StwfwS36AYMM6LMWqS6kYfIaCar851t89owtN9IoS5P8dLwEUtJtl4PYrzqpQ1cS0xx7zGbcr2jtR+Lsv8TB8pXnJRo2edsPNWxqrydif39RlHCVH8YZyLhc7kAYb3X8nd6O1JpgFG95xM5KnNIYh2lHfFuwt0rE0s0tCJKurEdStTmo639r9x/UBL9epFwB4GC56Hsu1dFUdufcka33IdD+a1q/lVX2qDAGAX3nnc+FfRUeoPgWf+bs3iFSThDU3I49mqYpdJwBI7mlp+JT+pv1dJSJGmWwGhFmJ9KACdSd8Xz7RTJbP2EnxE3pu1lD+nv93kTbg==
Received: from AM9P190MB1299.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:267::9)
 by AM0P190MB0658.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:192::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16; Thu, 23 Jun
 2022 13:28:40 +0000
Received: from AM9P190MB1299.EURP190.PROD.OUTLOOK.COM
 ([fe80::c0f4:a98e:332a:2397]) by AM9P190MB1299.EURP190.PROD.OUTLOOK.COM
 ([fe80::c0f4:a98e:332a:2397%5]) with mapi id 15.20.5353.022; Thu, 23 Jun 2022
 13:28:40 +0000
From:   Felix Schlepper <f3sch.git@outlook.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Felix Schlepper <f3sch.git@outlook.com>
Subject: [PATCH v4 2/3] Staging: rtl8192e: Using kzalloc and delete memset
Date:   Thu, 23 Jun 2022 15:28:28 +0200
Message-ID: <AM9P190MB129937C063A2C903164468CAA5B59@AM9P190MB1299.EURP190.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <AM9P190MB12995A5916BDAE3F2A8222CCA5B59@AM9P190MB1299.EURP190.PROD.OUTLOOK.COM>
References: <AM9P190MB12995A5916BDAE3F2A8222CCA5B59@AM9P190MB1299.EURP190.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [t0+9FlcULXtL+RRf/wRWMT37PwHdGjkM]
X-ClientProxiedBy: AM5PR0301CA0029.eurprd03.prod.outlook.com
 (2603:10a6:206:14::42) To AM9P190MB1299.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:267::9)
X-Microsoft-Original-Message-ID: <9727fe31c675f2f3052ca2fa586d137dd856ac91.1655975970.git.f3sch.git@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc081243-631b-4dac-e9c6-08da551c4946
X-MS-Exchange-SLBlob-MailProps: 6H6McBavlAg3x/+3LEOY9jnKuPfemMPEJ2bvZWRXrY/LNwATFfLFTmSNPSI3k8mxKIPmxoUX/orDTlRaJO+FqatRGYeARMdP+o8t6x0xjYsRmo5n9Nc+nAE0FpmhKn7ano7B1SD5isKkMXS2z0mY+6TI6ogICAzWQxUfuEpQdjSKhYlF9ZOJjObBkf/0JqaA8ZzYasWaUPJp5vQVz65Ra6KVcpYSSOUYqKRIOzOxYfaAB72H7jTLKMnJW0tFs/xg49XFgMfXe6R5MZXxemSNzIGwUOl7bPmAiJMPTZv/vZzwgFirh2IUQ2z+y6z6+dS4ngMEE4dNuBRC3s/wrJr1zGMdT6to1mQQ5vRhLTCb91iDq5tZPeGe022uTyg7+YXQ+X1eMcThQ9VsRvTMGyfsyWMYHqu3HkxmVPtWSfLBeZgx7EbHBbH0gn5iogRfh0tuegZxB/YmvxCtHPUr4Y7Tbto9l3OZjVKARVsfu5j9FkofWyXdUH5VbMIoTaVVWuJ5VIXb4+jSOde2cPJSzi7GcYLyPmMjpW7HQrNx7nbmNGue2VWuqqegVfjOnOmJf6BUY4i8KNQldfthyIbv9TD5k9JA9AUFoFQjlNwSOeujTlPlpb/rmPZ0Oa/HlHWryTHe4t11j89ZTsCosFD94GYfLL4F+f3u7O2xL8sgZaiuGYSgYrP83mQ8hasDxjDr/dyb/KxX4j1P5fYbmgYywbWWseekp+il8dyB/mlUW6HHykcWezdNKQqLyHndqencY1Osi6Vews3lWnk=
X-MS-TrafficTypeDiagnostic: AM0P190MB0658:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IPNHa3SgaIHMH6KWO82/gfL8MQGdfhbGMzIlNxZ87XAO99MQUOcSPds0r0LCfq7d5pjxnOZ2xXTL56Yt3IXpzi229y8cUfW8NlohwWdwObgG6gJTXeGD+UogqlN1PpXec+z1XuD9G2fk85PqcspOy4CUiqxSNfsEDBw80ZqA3/BJzb47ixlI1h965bTZNC3cxHXZJwgs3jHtjA/KBiNUHC2aKppeT6qrdzKCGzXUMA6xGRB9M52Bd0X7zjTHU+SJbjmVFSy2t65TTKHVophngm6SJ2kxS9LKMa5CKcnve5eGo1vpeVo5BZe414Z65VHLnO/A+eZM0c0zItoiYkQXCg0fSvqJ8UIw2ib9/w94CAhbGyXhBWDRd8cl++xTAA62LzVfwfqepdEZH8nWAV3mrA9QcD/GKuUAZulCR0LhTY9Ove7mhAop4g9IX9SovTD1WxrwOsXihzbcjNyzkhNnRmkS9VvI7kyy4z5v650Sv8pflQhqk7Av2T48+cXfHbWBCkeajRrw+M/vXL/Zeq0UO3MtnXmWKZbBtfrG/0kIA2h52dnDQPzJGH46axWkddP+hTgijVTAoacMyzBaYLi+ANy18jRmeDJFLx9V/uY035ZZ5IEgyyJ5xmChkkY7anvhDYDXX2HnpgUO0mmQJjsTng==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2h2QKns1hjTdOcziTPbS6BCQaJRkjh948vwcVJg1YkfKDTiq/T/fBq+93N4W?=
 =?us-ascii?Q?7BNJXqTN0amksAKT1ZfUzgAo/7Us3crJhxR2Z6ozFPL/UzW/odquEJ7W+bKb?=
 =?us-ascii?Q?STb/tjM9gSyWZ+a40Q4PAKVmr1oYnZLqD7K7D9R3jBdZlQoX4GqU1F0hxkku?=
 =?us-ascii?Q?L5/sEsa2U1R2R+2P+qlizvT4xcQ9PNCDB1yVQ4nGlJtBhqkDikYhFO9dUmN6?=
 =?us-ascii?Q?famMdXUfZcoEsfohYAT8V2kIarbMWVFt/QulbCrNYI2MJdtAywhvw50XIDlV?=
 =?us-ascii?Q?1/MYn4DUZSfYRgcA7blsu1pqjmTf9Y1BYH11sShOpHjuOfZ1RcUuhTFRbUkk?=
 =?us-ascii?Q?zwqBf3oayZE9YI2D+zeit2fe9NQ3zdph7KBIA3Q4l7yqkNxynhBxexFU9ZPc?=
 =?us-ascii?Q?Hl3zYatm7uja8wsO34S4XexrnaP2eSy273GZ6Mols0RieP2P415LhBjry9/V?=
 =?us-ascii?Q?+wF8Zm54GrobEg4y/hMh9LSt/jrnuBaipbsde3o3HnKNe1u1JWIVPqnlJbyn?=
 =?us-ascii?Q?bXrUmw7pkPXwK+JnDbCmp1DODxD0fmcwXh+54BRKDEKbFGajQOvofqSw4SfG?=
 =?us-ascii?Q?tym8oYgfF2ZG6y4aE+MqrPHfDB1mPr5GCS7XGsT3RapaAgU7agTKPRetTlgS?=
 =?us-ascii?Q?a2I+j3GdG4ywkYFU4HfFv0BuS5nNWlsvK0UxGaeknj4HWkFs3icXhZlNjkAl?=
 =?us-ascii?Q?Va9fXs+D9hpJq6fM80/gujS+uH9X/+niF7mcxGwf3WFnFqjRITZBOmoeAoBZ?=
 =?us-ascii?Q?V6FAsALrDcXFoT89Q6Sn6ffgajZaEUWRiy948s8Yz54jcbuUiM0VSx8yAMdN?=
 =?us-ascii?Q?xpCFIJ+SQz7wLaG3UlIisynmLoZnGSANKZjZD6Fs+dxGdsRrfLCbl9z+6x/j?=
 =?us-ascii?Q?wYaT2Ix8GydGDkSBAU/MZe+R255lOZIKleuwqfpfFRfTIOYQUd8sjQIAorek?=
 =?us-ascii?Q?Fw4I4yRBBMEDCVmvuhBPRYkzfNa3bKGeXE+RRr22xQlDNytWGMZR1SMK6AsH?=
 =?us-ascii?Q?oavHTFlVHpOl2pKk4kz3l99iGU1X/HirYmTqIkqML82QUU/ESL1Rg0E4C+6I?=
 =?us-ascii?Q?r/mDsPVYyIv0goPdLqs4kjIHbhyADRW5uu44HBhIhmQIqRzepmiPYtMt1F7u?=
 =?us-ascii?Q?ljV9Ro5w0wSLD5DCPHOGCSmfnVGLSpKVF1I/wLZsbEifziy/BIX0/UjDvmbD?=
 =?us-ascii?Q?nCuqoFqIIGeK2tqzCYzcBp4oj/93ntSpG8ONpn5/k8jseBXRSmwTor19kROO?=
 =?us-ascii?Q?0UxV97n6l1Q8WK2fLEwG4rwUIKqmAc+eI6509oIZkA=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc081243-631b-4dac-e9c6-08da551c4946
X-MS-Exchange-CrossTenant-AuthSource: AM9P190MB1299.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2022 13:28:40.4738
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

By using kzalloc, we can delete a memset.  The practical difference
is that using kzalloc() will zero out the txb->fragments[] array.
The original code worked fine, but zeroing everything seems nicer.

Signed-off-by: Felix Schlepper <f3sch.git@outlook.com>
---
 drivers/staging/rtl8192e/rtllib_tx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index f2ef32e943ae..1307cf55741a 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -205,11 +205,10 @@ static struct rtllib_txb *rtllib_alloc_txb(int nr_frags, int txb_size,
 	struct rtllib_txb *txb;
 	int i;
 
-	txb = kmalloc(struct_size(txb, fragments, nr_frags), gfp_mask);
+	txb = kzalloc(struct_size(txb, fragments, nr_frags), gfp_mask);
 	if (!txb)
 		return NULL;
 
-	memset(txb, 0, sizeof(struct rtllib_txb));
 	txb->nr_frags = nr_frags;
 	txb->frag_size = cpu_to_le16(txb_size);
 
-- 
2.36.1


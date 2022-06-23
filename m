Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6284F557768
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 12:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbiFWKGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 06:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbiFWKGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 06:06:13 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-oln040092066039.outbound.protection.outlook.com [40.92.66.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B951849F01
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 03:06:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XoJmh/DBeQpW2NJUFa5U0Wfk7iCnwRk4vQq4s6qlzMBg2xqbAm+nQFSFKwYNdYVaI59VGbkFe6AU7zUQjuo53gg5vQj3rrw0ar9/fWdlwWUzp7txuP7OPmrRPD87PfRPpdnm/4olj2Ne+X0WIKExNmud9tIYIlVzVjNbzLHuW/HCXpar3A8smiPdQ8j8XU0vzVGalqTm/JVrgmAvBXdEsUXsD3HFDPw9eoqkgW44sf53jvNKb7lqM2pOGK8eB5m8mSqwgsbgO3sYDEsox7lPeAr+YcXPqSzdUqTMkWNIPEfD85tvOqUAAy8IOqD+CW1L6N2VRs0UJcsofyBdSQ93QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v5KgDpnFfukyo2JjpZ39r1xxGFxbCzXHBbU2i6LiqU4=;
 b=hUOntrYTu4eYtF1pVDVrJDbjvIVPOLOGJcVE/jLLQ7jnjcTmkMOIM6jUuAX47zO9v2mrfTDhTDJnz+CI3h0BdVQ7kMBp7mSoUkD4i0AsnaMFfVqKhlLJKUny89T9+xMvjp1QqQENTvQaPpMA2wqeo7O8QdyNnhiYL3UlWc1LX0MPdPQeuVMfrPbCFlvF4zfjszf1RDnfbEO/Odw5QXkmmyxsJK60j9e1lcoG+krI4JF9Bh9yM0gIPx5KAeM5AK57ikTRnZIH6SbYkua6FGvAku6R3NJfD2c+NkzeXrJjIoX7Y3s0aDdnsnlc6O0UkaEb5492+79gKsbtj3oEYOPpHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v5KgDpnFfukyo2JjpZ39r1xxGFxbCzXHBbU2i6LiqU4=;
 b=qkc4zzc8mA44Taznfwdd4v1hMxSmYBUSQAmxgbc36fmcFIhxcjDog83bFhbP2jOSwGhgKY2FrRRjpIKhSLhIm7Q16GayC85iMeZd01uxCB4a2ncLHt4Ah+ibxs2Fks6XI6me28qk5v+afItFu2biDJYpppPO6Qu7Evq6q9vtqQ2iTl3wxUXk6dKtAFvwNilHjqa5xrs5bO25NpqRlipsAOgejUqAoEjGyIwG2bvWoAD+vPqr07uGzfIkHPkFw0M1xp2D/nd058EROHnf0811MDfhjgjrnN1fChdcxv81GBjuFmufuK8T52Y35KoNgxddMRxecdFgqWOcYBlU2/RniQ==
Received: from AM9P190MB1299.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:267::9)
 by DB6P190MB0263.EURP190.PROD.OUTLOOK.COM (2603:10a6:6:32::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.16; Thu, 23 Jun 2022 10:06:08 +0000
Received: from AM9P190MB1299.EURP190.PROD.OUTLOOK.COM
 ([fe80::c0f4:a98e:332a:2397]) by AM9P190MB1299.EURP190.PROD.OUTLOOK.COM
 ([fe80::c0f4:a98e:332a:2397%5]) with mapi id 15.20.5353.022; Thu, 23 Jun 2022
 10:06:08 +0000
From:   Felix Schlepper <f3sch.git@outlook.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Felix Schlepper <f3sch.git@outlook.com>
Subject: [PATCH v4 2/3] Staging: rtl8192e: Using kzalloc and delete memset
Date:   Thu, 23 Jun 2022 12:05:56 +0200
Message-ID: <AM9P190MB1299B9A4EE0EF0E3A4C1B1E0A5B59@AM9P190MB1299.EURP190.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1655975970.git.f3sch.git@outlook.com>
References: <cover.1655975970.git.f3sch.git@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [h0JSroi5kMgBXKGIiMPF6ENbfrWox0xf]
X-ClientProxiedBy: AM6PR10CA0049.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:209:80::26) To AM9P190MB1299.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:267::9)
X-Microsoft-Original-Message-ID: <9727fe31c675f2f3052ca2fa586d137dd856ac91.1655975970.git.f3sch.git@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a41c7a55-e900-4365-4791-08da54fffdce
X-MS-Exchange-SLBlob-MailProps: EpEO96k6WokJw9qhnqKg7+E0MqObEIk6kRyhAIeTFL2dia6wMVe7R8D4IdiONv5HsgFfla73KD2QxZt4bg4ykGMOnx+k5iUuuMJcfr2kgiMDe0Y7RsI5ofBgzUIe5+YecK/LT3YnA4cRWPtlZ0Za74F3US/IpWo+HMqMiHljzouxsCAHsd3ti4ObOPsMHmGd2A6Q5nsP+/jpzXVgioAo+qo1+7APaGLB2QlsFg+47gvY3CtZNY8X81TD66+BKvjAnNhWlg/C5BmNx14bUomRr/5WlhTYJR/JK9LlWox3n7l3BsNr4/filmR5a73XkoWK9k8yHMRD0c5Q6Q6LBVru4uVIQ3Q2YpYm7aBjhK2Tedkbzn0iTf85ppx+TYpE+EjX5cTOFMjYGCDgjN8bNiVRPxTG7sY5CHyY2MGyc4uUCotyw8SqeLOVVmf7OylyeGLFOxBN/1jvCSmn0oa5oGjcDLRV6Dnv6ARaRH88zlNB8GNNYHEf5VBSuYAMiOblwP8lpff2lbOaUd+zhArmCCuodKRYmDT76AeskbX5ZHmLa/9bNq0gOPWeTiijwqByYznmzqlGZN3oonqJCxGuK3Lb0bep30OCnnBDsHnPjDX5/UiNbG6H66L+MrCJlfq8bak9Dfr+5t8WERKKww0HHaDWkR+8XpWzHVsDW0b+c87yD9lsX7Lf6oBKALSqjvAEaVRjMBdmBS8P1wWlzB9dz1vRcvI5b40gfuCr93m/HWg5XboEZEHSjcOjWLVtdTn3Mjw7IyOXQ9DfrbM=
X-MS-TrafficTypeDiagnostic: DB6P190MB0263:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2mN0eRHUmoziSqa3iW31TB/iWtQyKtKVzuODxqihv2SljajPAE4MWkWG3OqwckxHeR+cIQLqvaJTiV9zM+NaNYTSBk6bGX7CS6tzxEKJOqHJlpF+fPsBhKccPVt48bdAItfgyJspiPJGCfweWPOmwx5CbzST/woxPvoyDlP/1hSXNPLbhkmBTAaoEsmno/cNQKSgIlUrgQF0HcM+30xFenAeP6qzf9R3TG9oje5SN5fR43SnqnExMG0pcgJFJk+3935mttaTECOS1uBgdHPuyI2ONmNHWDxVYyUxhx6WYsnX6AsY5jPMLiAthWyY+IWQyKOsQeQ3QLb4PVGtXrlSO03XgQu18rFND7utGjk6rSSfoQk9eWC8/4noucwx9jwBSb6dMwCskDPsC10h2i0AvowbwtTYbrjv5rGpTuo4eCp1wBTCq4RzNwm3d3HTTWIf0Rm2vns3CruHK8AgilDh9XUMYeBgCv+E1My4kZwVM3bd7jYvHSOxtaoMcyU240mD4hRmZs54BEux67D8DJqodaQUgqj5PyhgzepvYpokD0+bJI3Uf6kgg/FDY6SPSHEoeJiVrvqMOkjIIhHf0jOrtyaHbd4ICw97eFRRMj5gm3sMe6QTzvfeNdSNM62aGAXJ6No2IkUJCVVB6wdYsGua/g==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rFNeuQGFGXBwwothIi0l2pzYYSDbbwj6vrbDQL2Z8yCUhso3WdBC7XMTXEng?=
 =?us-ascii?Q?Hn6I8a0FA0MaBQ1Pr9mPKbJstp6UbNZCxDL6UH8+7GAZ8tIBELIZafJM1IOK?=
 =?us-ascii?Q?g3yiuaLya/y1TZUpiGzz9rD3k20wzZ4jVGULntL09SrofYkpVhbqP5iMMj9o?=
 =?us-ascii?Q?j/e2JhJHr+yZ/Qszqr3UIHnI49HaA2e+7RHzp0nYXiavBWdp44b5xvZg+4DI?=
 =?us-ascii?Q?BEPcL1POgrTWPs+pytll/DveV2vk4+awt15brz5GLqIIIOOU0SDdv469CIta?=
 =?us-ascii?Q?E9qfNOx3Y6hnBwVob7zzfkjuMWKjdt8fUIIc9oap5716n/jjekP6A4hqVh/f?=
 =?us-ascii?Q?xPH4/rYjt+v4RkVJkpvYbixZtlJnfV432NDx/bvg1zO41rCx16kK6Ji1KWfW?=
 =?us-ascii?Q?Ab3vtzk0mjuKOJWWNGH5BB6Dxs2/iWnFsj/o657j1TfGmCoxtXmTrl3R12dr?=
 =?us-ascii?Q?+nfSyZ6aux1/4s8sc49asMkaJ1zMy17p9GtARoI6H0ONLKG3f75FoYMYfk2b?=
 =?us-ascii?Q?4yLzphmDfP32eGdrYZnKuavedsRQFjg+6IF3NFkI4kWsLfy9Mq3GB61pqTDR?=
 =?us-ascii?Q?moIuDaMCOQIx9Ew3yBZI8cj9c15yR+Ur6fQI7WlMbhSyl9iyScJrYNxe+oPo?=
 =?us-ascii?Q?qxjgnztkWsYlSQDMJHsAY0JBLJEiMNmGrp0lnv3R4c+kZJnoYkcisH/vjV9g?=
 =?us-ascii?Q?xz5HGmD6nEe6VoY9ggSr1B/qTilfaGD6UEkcc+6kCUWKd+vPq3dWpbvIhyo/?=
 =?us-ascii?Q?3/V2/QS9nAlfGjgEEYh8LTRx93OH2C0SbWGEpuJpB9xiFUgb3+ZxA8Gnwod0?=
 =?us-ascii?Q?VuN2i0ud7fjSca9wDrAOV/Oia1BWZMgft2tMnf8J6rWkAIAFnWXH8NMWc6ew?=
 =?us-ascii?Q?aA/ASGptGC/dtSShwbITWlrQpZ3rfUz7eE9wAEBU6MtWp5vWJmmMEUb+cnn5?=
 =?us-ascii?Q?ZSffBEP7u4Sx0FDesWZlvqzQlz89LY6elGgGvMhGVJKspgHgvKAflNhHhMXT?=
 =?us-ascii?Q?qvsWQZZE9Mnayyp/Pa/gpFsZQIatpwy2LcqB9BHEfthp9XtOtQhQJrMDtwFd?=
 =?us-ascii?Q?bWLs8I6XVUprTn0ccy8Gp5+fb6kPaKQblyc+YLgM0KOZof30NkLWRpzlNFzw?=
 =?us-ascii?Q?4RGQuy4AEkPotNU3IbylxFQmrGFF3CakHKzOdxyNumUCCmerueu7DUp4wrvQ?=
 =?us-ascii?Q?lrDNvOCsTsLAy+gLsihF9AiK9o5hB9ywFkHQCGjlyYB262e4koBINGjjfhOc?=
 =?us-ascii?Q?kKF13oj/J5yR+3CfJ88meCiOV1fhPaXN1o/TUBmQiw=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a41c7a55-e900-4365-4791-08da54fffdce
X-MS-Exchange-CrossTenant-AuthSource: AM9P190MB1299.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2022 10:06:07.9300
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


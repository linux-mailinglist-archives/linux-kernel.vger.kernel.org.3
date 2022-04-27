Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 211FB512448
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 23:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237260AbiD0VIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 17:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236944AbiD0VH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 17:07:56 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9CC7DABD
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 14:04:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aIK8mKbjNaNHcuJnHNAX8RpkB6tBsQ93FZTwXqXF2av/37d2MWnjmXOGzioVPUu3Vq/Od8ZrMdk2cnQ+Fe/YUavp0HnFc/FjvytIrI2YpEP03K6TJAXQ3zTjWNSL9utS4c31Fk0pyRChMW6ankDfbCV3Q+PGLkyQnSK3Z6ivYqJLkEVgSz0gq+MbvjhagCzLqaa1VRtc1O4cCyd6OXsgkGNLDQZd23A0OJlfrE/SKt5+T128gJ5v8YU4nJrZSDTyOSY5DsQKvzQjlx3Ti3vqylXWD5ioEqrjl7ZbXD6lf2b40h4pDp3ptVfRZfmdGI+2IzluefFgsPfzeHSdiW7pGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IKPiiJcFWpFUwKjox9Ka8z9FjLftCKUsev3Nqd4vpG0=;
 b=MQzwlL+20mK5FwEbF7JNJvhNByjXGuOWBAooP+KHLRNzO71hxN26ekDehYMOb8+KjjdNp8GDaTtm7B4uolKmcWAcf750StfSG/C1zC5YPCJv8x5+d9nrE/kUO+2h+rVrtqqnB14HvEdmk01xf8YIii9D/KqLdokrKRPLETuh2S5DS2nd32xxQDqWdKpI8QmduMegyqg4TB14QuSJxWXVSlnuhQAGhU5DCLTgEq4Z0aVW/gxdTwN0eDGF6QNIrjE9MIgT/k2zFgNwLse4Rc9Qmqw7pbsBoIVnfoBz+ptg+7JZpGykjwndY0xee8g9EXlfBwxInbNcB/XG23XsHruiFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IKPiiJcFWpFUwKjox9Ka8z9FjLftCKUsev3Nqd4vpG0=;
 b=uWWOXbdLVP1zg0CZCviUVO+x3Z254LxGFuy1uHQwKqL+5nJ3vN91OnUus0ZSKB8KQkRv5i1SH97+G4eFN9JlWoGq7bwrB/HklWGcq+FSbBO2abOcjI70QoEqtxR2/5pVAlj0tx3UBZv3kyCKnnfmL4kdFK/m+3FYZkDXJBvPEtiZOLIaoAVJ54swOGLPqbqMocy57axICtTmWIkF4v7qP6p4FnBcu/FM23bimaUz/sUVSHxnxC1VaUh46y2nOhsSLThvIpq3GotFWzl/5+R4sUXn0aJMiGg9EEzGvYh1aDu0U9rbT0cdiXC4t5s9YfYN8rlyPWTaPosBat1LgC5D0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by DM8PR12MB5430.namprd12.prod.outlook.com (2603:10b6:8:28::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.14; Wed, 27 Apr 2022 21:04:42 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::920:970d:6f94:1f10]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::920:970d:6f94:1f10%4]) with mapi id 15.20.5206.013; Wed, 27 Apr 2022
 21:04:41 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Eric Ren <renzhengeek@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v11 0/6] Use pageblock_order for cma and alloc_contig_range alignment.
Date:   Wed, 27 Apr 2022 17:04:39 -0400
X-Mailer: MailMate (1.14r5870)
Message-ID: <A1956578-A851-4BF3-BD57-12571244DB5E@nvidia.com>
In-Reply-To: <1D88AE1B-4DFC-400F-A054-662E3824C9AF@nvidia.com>
References: <20220425143118.2850746-1-zi.yan@sent.com>
 <20220426201855.GA1014@qian>
 <B621B4DD-5D11-4F0E-AFF5-F8684AE37E57@nvidia.com>
 <20220426210801.GA1038@qian>
 <2B9844C8-6D35-41E2-ACB2-9854E7A9C29F@nvidia.com> <20220427132720.GC71@qian>
 <1D88AE1B-4DFC-400F-A054-662E3824C9AF@nvidia.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_B57DF712-AF9D-4405-BC0C-0F8EAC51B603_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1P221CA0005.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::19) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1141a769-8e3c-47c4-49f9-08da28918c57
X-MS-TrafficTypeDiagnostic: DM8PR12MB5430:EE_
X-Microsoft-Antispam-PRVS: <DM8PR12MB5430CB8CEE85901C154D14AFC2FA9@DM8PR12MB5430.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZMvbsWST/iIZbSZNpvxRspOaQKIP7qE6xGZsTSkD5Blyb8qmlzqyoEIlNhMIhwt/dkamIS6HTueiAro1ZsBHsaPSJfyek4IMtK23h4PAY0yOLS7rsMZMAFxzG2sNN6HDiNzYevC08o3XmkmJFmuP9/Ks8AlNxIlB7psI35AiDyiaDzngpkpYCkfprmLB1PNg1ZV1GkvzsIDbD8czRFXelSoZurpTZa4aeECAV/W25hCzvqBI/LuR03jdoIMz5KPyWmOaJ+X7hIEHptN78dWf9FuKwPCRRz05ioIazlQxiaJduySmzuUL/WwrXcgMyrGNzGyORzBblHaQ0RZgdkAQeXICC6JjcttXiNT5muvM0wyApomzwX5HWNeBGZXiJGzBWVGnmzURp/BwEgSTtxr852D/Zhmm9xdHJfQ3dC1S/7VuHR0YtpCe9OkOujluJg3TalJkwQItJQEFDvNVUg5klq8YzlSSq6skBB0TbSg9j7t2PqrNity/fNk7Ag81TbZoUnVssfNE32u+5zq6N9rdKqNBth8I9QFWjjBAND1Qzr3auwkZfnfSZ/+GH+DYhNQq1CICmn0tp1MGq0Wzze4bVUzDMrLTqEDFcTJaSYm8dEYL0aUkQGS5LPjdMFTNFDTV4dsqf7slQFVYfO5SuXuAEB1tSz0mIsMGd1KIcz4rZa8VDnxag1f8pSRYIur5sl8D+N0ntsndtFWPEeVl82O5hfEnLjGzpnkA2Jcu216eqKA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(508600001)(6486002)(8936002)(33656002)(2616005)(38100700002)(5660300002)(6916009)(8676002)(4326008)(86362001)(66946007)(54906003)(66556008)(66476007)(235185007)(36756003)(21480400003)(316002)(6512007)(83380400001)(6506007)(7416002)(53546011)(2906002)(186003)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FbCdJdE47cNLzxtbUvrv23Wz2iaXe7KvYFI9+7Sy+OOZ4gVHkERrPB7U7PUb?=
 =?us-ascii?Q?NzqHQ8mjWfO4Xv52jfJm0JPrHeU/1IfDxrJ2LbjoSimHtY1KyYmNpOpW9Rg8?=
 =?us-ascii?Q?MnAP1Vzn6tVAGsrpwcqem/FqsAHIxsCST5Bme2BHfxKM7DNi909m2KmWS9J9?=
 =?us-ascii?Q?mfgVA2nG04FCgVjY8+Acx/q7Awx8t44QFfvaSYkQ9w3pzKaTqsc48eUrhScs?=
 =?us-ascii?Q?5jpY7Pu4kilSa0RIClfJCGOQHF94p0latsfHKhoaPYAAgk12uWVunKtbo2hi?=
 =?us-ascii?Q?PwSrdqWsbcyElg0HsVwq3XKMiJiWy2d4PLAqNp+rdGKnFamlpBmp4vk1x8+R?=
 =?us-ascii?Q?lqlQl7dVvEoaGiLrqHUdNa8BMIqt0qHKfJR3q1Df71qE4O4Jjn9+Pfkg5b2T?=
 =?us-ascii?Q?m4AXr8MD8c3SICMXe6sOsq64grRBxqe5RBqVA+5+Szsa0FeEjAtGWMcHsuwH?=
 =?us-ascii?Q?cVDhAln+75xddteg+S9X40ylTMcSnInNeY9zMib9up6tIbmFg+p5PRhYaAMy?=
 =?us-ascii?Q?pn8zdBzg1drYgv8vxfDpfpVQNza2y3rI0TqBuVF8/ZTw4rFzIq53HFBZbhr3?=
 =?us-ascii?Q?MDIWAFt3Bnz0JgiHaocTOctNYK/DtskdbnWt88/Mda+2vsq/NdfnyNbzzCmE?=
 =?us-ascii?Q?GwZsI9HePpPzsPTUUB8bbUV9OP95BdhCukoG+7q3U7eZ2r9FKO2VLQo6Ttqd?=
 =?us-ascii?Q?AFsyZ0dCtuxNykPtZOJUKKovOsod4RfmKS/EEGLGLtgSbc34VTLGnt63WS+s?=
 =?us-ascii?Q?TTlw90eluR92tgHZykrcdESFDVmnfqLU74dk312lJb26+VLxnYzi/FoMeOXM?=
 =?us-ascii?Q?+A6mImmWU1MaV611Wi0xkmLTtvHXwxt9JBy7jVBoxyLdPw/nwOAnms+kAOGO?=
 =?us-ascii?Q?7F54/I5uxE+YmkI1Xvamfjwal4o3XvKY/+bi+k99F111cfSYjcwiLexBqOhn?=
 =?us-ascii?Q?FJLschrhaO6Ycmpz+74+zE/0ZYlhYk/vaY9ztPd8Dmn5rdMA32XRB9IemC/B?=
 =?us-ascii?Q?q8MRXMmWJOmCdEo4pOovX42jZa87AZHQzLPlbgyhjRz5P0YjGZOwgok46Cqq?=
 =?us-ascii?Q?2kDHDGRlbPjeGDk4/4yGq+KjbzHFWsed/y72+/ckt/zTs7BlCoLn0TfVp5J3?=
 =?us-ascii?Q?gylSlA7lXHaU22B60JRWwIV84nPRIer//TRICT3gcFretU5NXljtngxnUU45?=
 =?us-ascii?Q?XEGN9Q0qq8FFN5zjhm+W1twiLalV9Rbp9t/NRRZjK7C1n4jBh8FDNiLkqHWo?=
 =?us-ascii?Q?vo3EumkP/MnyB+mPG0JqCFkrOBKPebwOv5M3nBQ7GP427OkUzbwSgtBFU4lT?=
 =?us-ascii?Q?iHK4e2VnDJkj91upg42M7iIZurCy8jMRPDyWn6U1qDDHQI0+7eNHaFlv9LQi?=
 =?us-ascii?Q?Mt2176OLo6BZJEfCZatMWEFjL3DR+FVVM0l0VaqqPCC6EcN1io1QCuqEuoL3?=
 =?us-ascii?Q?k9bXhGzX34NFhd2CQWIi85c4ab+yxFw5UGml5tYBGxYGvPN7btVAYUbhnfhL?=
 =?us-ascii?Q?BSsZEhN3c8PggFHOCZsm9YA7aOQyLTJhQJoQmMzLHu6KLl1e9eVIiO6tkJHo?=
 =?us-ascii?Q?p4RNj4XZxmuWiZNnBhml7zeNAnDpmZXozZ2JBQzYSxf+/GftemYStIb5sr3H?=
 =?us-ascii?Q?2nWdSVeD1gKtqC4bZC3+2CRIhFJ9Fs3kMsmrAq91RUmFC3kGIRN/oZ9n82Cn?=
 =?us-ascii?Q?Yu7VqsrpCKSvuD3qCAMH1bopAqz5DLdwM9rUVYW+fx/CfMrm5zBt9VNWJYbP?=
 =?us-ascii?Q?19UP+Exjxg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1141a769-8e3c-47c4-49f9-08da28918c57
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 21:04:41.8121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qo7nJUaBplWy6g5AJboj8iE/IbchKNCqOQuXHYgYzczU/62hS9qzfN/zbAbV+er3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5430
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_B57DF712-AF9D-4405-BC0C-0F8EAC51B603_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 27 Apr 2022, at 9:30, Zi Yan wrote:

> On 27 Apr 2022, at 9:27, Qian Cai wrote:
>
>> On Tue, Apr 26, 2022 at 05:38:58PM -0400, Zi Yan wrote:
>>> Thanks. Do you mind attaching your config file? I cannot reproduce
>>> the deadlock locally using my own config. I also see kmemleak_scan
>>> in the dumped stack, so it must be something else in addition to
>>> memory online/offline causing the issue.
>>
>> Actually, it is one of those *offline* operations, i.e.,
>>
>> echo 0 > /sys/devices/system/memory/memoryNNN/online
>>
>> looping forever which never finish after more than 2-hour.
>
> Thank you for the detailed information. I am able to reproduce the
> issue locally. I will update the patch once I fix the bug.

Hi Qian,

Do you mind checking if the patch below fixes the issue? It works
for me.

The original code was trying to migrate non-migratible compound pages
(high-order slab pages from my tests) during isolation and caused
an infinite loop. The patch avoids non-migratible pages.

I will update my patch series once we confirm the patch fixes
the bug.

Thanks.

diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index 75e454f5cf45..c39980fce626 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -367,58 +367,68 @@ static int isolate_single_pageblock(unsigned long b=
oundary_pfn, gfp_t gfp_flags,
                }
                /*
                 * migrate compound pages then let the free page handling=
 code
-                * above do the rest. If migration is not enabled, just f=
ail.
+                * above do the rest. If migration is not possible, just =
fail.
                 */
-               if (PageHuge(page) || PageTransCompound(page)) {
-#if defined CONFIG_COMPACTION || defined CONFIG_CMA
+               if (PageCompound(page)) {
                        unsigned long nr_pages =3D compound_nr(page);
-                       int order =3D compound_order(page);
                        struct page *head =3D compound_head(page);
                        unsigned long head_pfn =3D page_to_pfn(head);
-                       int ret;
-                       struct compact_control cc =3D {
-                               .nr_migratepages =3D 0,
-                               .order =3D -1,
-                               .zone =3D page_zone(pfn_to_page(head_pfn)=
),
-                               .mode =3D MIGRATE_SYNC,
-                               .ignore_skip_hint =3D true,
-                               .no_set_skip_hint =3D true,
-                               .gfp_mask =3D gfp_flags,
-                               .alloc_contig =3D true,
-                       };
-                       INIT_LIST_HEAD(&cc.migratepages);

                        if (head_pfn + nr_pages < boundary_pfn) {
-                               pfn +=3D nr_pages;
+                               pfn =3D head_pfn + nr_pages;
                                continue;
                        }

-                       ret =3D __alloc_contig_migrate_range(&cc, head_pf=
n,
-                                               head_pfn + nr_pages);
-
-                       if (ret)
-                               goto failed;
+#if defined CONFIG_MIGRATION
                        /*
-                        * reset pfn, let the free page handling code abo=
ve
-                        * split the free page to the right migratetype l=
ist.
-                        *
-                        * head_pfn is not used here as a hugetlb page or=
der
-                        * can be bigger than MAX_ORDER-1, but after it i=
s
-                        * freed, the free page order is not. Use pfn wit=
hin
-                        * the range to find the head of the free page an=
d
-                        * reset order to 0 if a hugetlb page with
-                        * >MAX_ORDER-1 order is encountered.
+                        * hugetlb, lru compound (THP), and movable compo=
und pages
+                        * can be migrated. Otherwise, fail the isolation=
=2E
                         */
-                       if (order > MAX_ORDER-1)
+                       if (PageHuge(page) || PageLRU(page) || __PageMova=
ble(page)) {
+                               int order;
+                               unsigned long outer_pfn;
+                               int ret;
+                               struct compact_control cc =3D {
+                                       .nr_migratepages =3D 0,
+                                       .order =3D -1,
+                                       .zone =3D page_zone(pfn_to_page(h=
ead_pfn)),
+                                       .mode =3D MIGRATE_SYNC,
+                                       .ignore_skip_hint =3D true,
+                                       .no_set_skip_hint =3D true,
+                                       .gfp_mask =3D gfp_flags,
+                                       .alloc_contig =3D true,
+                               };
+                               INIT_LIST_HEAD(&cc.migratepages);
+
+                               ret =3D __alloc_contig_migrate_range(&cc,=
 head_pfn,
+                                                       head_pfn + nr_pag=
es);
+
+                               if (ret)
+                                       goto failed;
+                               /*
+                                * reset pfn to the head of the free page=
, so
+                                * that the free page handling code above=
 can split
+                                * the free page to the right migratetype=
 list.
+                                *
+                                * head_pfn is not used here as a hugetlb=
 page order
+                                * can be bigger than MAX_ORDER-1, but af=
ter it is
+                                * freed, the free page order is not. Use=
 pfn within
+                                * the range to find the head of the free=
 page.
+                                */
                                order =3D 0;
-                       while (!PageBuddy(pfn_to_page(pfn))) {
-                               order++;
-                               pfn &=3D ~0UL << order;
-                       }
-                       continue;
-#else
-                       goto failed;
+                               outer_pfn =3D pfn;
+                               while (!PageBuddy(pfn_to_page(outer_pfn))=
) {
+                                       if (++order >=3D MAX_ORDER) {
+                                               outer_pfn =3D pfn;
+                                               break;
+                                       }
+                                       outer_pfn &=3D ~0UL << order;
+                               }
+                               pfn =3D outer_pfn;
+                               continue;
+                       } else
 #endif
+                               goto failed;
                }

                pfn++;
--
Best Regards,
Yan, Zi

--=_MailMate_B57DF712-AF9D-4405-BC0C-0F8EAC51B603_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmJpr+cPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhU5LkP/22n64mIZf/90jtCyzOzAP7nDAfvxLKZFzoq
Onc+NAqywcwzXrzUSNsBb2ZOlWMwqEkV3A5bg3MC+TEAyfgbrJNJILPqrzUKXrUG
64UDBTcwLNSPVWRIn9Nm5GguE/9c60348RD6y6qBwkq2KnGIw3rw+VeNamNXONFb
/1G5rAVDEquNCGqqmYcjltsEM6m9y6fFAdELA5W6Z0b29FKC8JZK3vOTJBCxOk8O
8Gw92DSg4apmbX/1UGsu+z4JQ8MT9sOILH/cGvKLvVHNEp71ETcPWpBXuBPhxa1q
WYlAd4enolDlo14dFBMZr1Qu4sdyk/htvo/X1fq1UQxf0Fmr1yCKoAc1VL2CXSXp
OFMOEtWyYIu13/cp88an3t1ZTIHmJxZgQX7NN/9hKL2UvTQhADIp68iCojbq6AXo
hR3D8iPEZkoLEFuMgiY22QnNTaYzIu9//5RPMin7DMXqR4yxno/eRxy0WrN7fclM
pmYNXuyX/5YGYUAhT+Nrn6O0m3LFTohLFHgf3NIF4wgraNc8Z32QApLmwQFTafZy
QDafEDeATL3FZN3cWj1gS7YigRFYHx/IgVilfJ8kVxqkuyUamCYYVF+DMciE54Cx
Ks8XoBDtDnQ68unZlSUz9cYh0UOdpUYMVS3mUI3EGMFZmKR/MhV/pEvBW+JGL2vN
VSJ/7VVs
=Bznq
-----END PGP SIGNATURE-----

--=_MailMate_B57DF712-AF9D-4405-BC0C-0F8EAC51B603_=--

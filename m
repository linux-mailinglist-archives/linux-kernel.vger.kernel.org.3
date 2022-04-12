Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C03AE4FE8B4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 21:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235227AbiDLTg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 15:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236301AbiDLTgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 15:36:51 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B4126558
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 12:34:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UuPTQouWW2ciF2ifTV35YjjiUeZ3m7fed1Cly/r/LFHMQ6FA27ZKpKGYo6eKQucVLUSEldpnu5zF9XuhVBrQffh5TT1ml2Kl8VzKLdLkBuvegv3Q1Kvw0l8dn/tWge1p4/FSAJXXpdluaB65eaQ39ZvS14jV5CJOVFIFfhi2B+irCULVaQUXh8B8YoqO8UYVacHENqvIUvoslY3k1nfOCNRjzYjs9u1Ire76JBolmygo4bds750lVpQ0CXCkZINIDZSJLny2i1vu0BN5WrszQXGe82ly1CKFZBJ8IqHCQQsSJDKxsQjN4dmHK+r9iz1kTICQK+7pmvCKjmKVmUlwFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F2C+J87ROGTDyvjkaA4CMZ6d3XjJmumAVJbVoDV0a64=;
 b=B4VZXM4dBZ1EK2VDala/XOs2l0bWaosUmff2/fD1vUoNR6XER3HjmiH+t3AAD+ca2Kr8K6L5T7BtzrVx9v7rJwa3EZ2YfGr04/kOARTOiRh1rn+N8dMYdbRj4fRsshEw9Ap73wdUOKwq43524NXfZ5HZ6MBs97s8o9zBuDkyNrNJqxA5e+hyFXvJh3cH1xrqbYP8PH8SfnLTe1eri3PWfQ9LWwP8YRwZcctwrLWkcGv6M2z7QzW0WwwtceKixOz5G0RQ7+Ts0ljYA0DsulZz2Cu+0JTP6sXssHi+9jPMchbheJPWFt08MSCiDuKZS6ZbhOPXlpa0wkbQkfan/9d3Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F2C+J87ROGTDyvjkaA4CMZ6d3XjJmumAVJbVoDV0a64=;
 b=Z4KL2Kizmq/6MX5dYnb+agTPZy56SG5gJmOICg9uj6Mtzpih9dm/IjJS3LxKdrOemqSk2EZwafOE9nqs+5cR6/tPkl3/4j6h3TgC1kIQpNwaStvAMNROegLFMajO2U6moSR09iDqGaZtLFnPxiAX5GhkQDgQfIaMOuGAFMiKoKXU/wv4y+V75tpqhu+TZ8HznvonWKyo5ZYUEiIz+vK917W6c/sp7JBhoL+4cQu7Nv5rFozOmRYDmteevEIzasuSIokKW8Pb/S/g86AVrphPcF0dH9sji0DVQgx/jFRcVwojB3pISh/0h36qU5LQuew+F6upZtC/pSorNHGXBv4pkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by DM5PR12MB1323.namprd12.prod.outlook.com (2603:10b6:3:75::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Tue, 12 Apr
 2022 19:34:29 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::69f1:dff6:826b:7d9c]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::69f1:dff6:826b:7d9c%5]) with mapi id 15.20.5144.030; Tue, 12 Apr 2022
 19:34:29 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Eric Ren <renzhengeek@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v10 2/5] mm: page_isolation: check specified range for unmovable pages
Date:   Tue, 12 Apr 2022 15:34:26 -0400
X-Mailer: MailMate (1.14r5870)
Message-ID: <0F913CA1-4530-465F-A2CE-7CB11E96B43F@nvidia.com>
In-Reply-To: <D53C41E3-E934-4577-9286-387AF3DDBE03@nvidia.com>
References: <20220406151858.3149821-1-zi.yan@sent.com>
 <20220406151858.3149821-3-zi.yan@sent.com>
 <ccae12f9-a452-95a8-f404-3398dcdf5bdf@redhat.com>
 <039317AF-985C-43D7-BB99-714DD6022B5C@nvidia.com>
 <428828e1-6b59-8db7-62e0-1429863cb13f@redhat.com>
 <B4336C2E-E728-49E2-B84B-5728B9A1EA69@nvidia.com>
 <afa115e6-d2ae-eeff-ba31-f8b2a5715b95@redhat.com>
 <D53C41E3-E934-4577-9286-387AF3DDBE03@nvidia.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_0BD2808D-31C0-4590-9F87-AFC70EE1725D_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR19CA0034.namprd19.prod.outlook.com
 (2603:10b6:208:178::47) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c0f4e6fb-b6b5-4cdf-c7db-08da1cbb75ae
X-MS-TrafficTypeDiagnostic: DM5PR12MB1323:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1323DCB10011EB9A13F41588C2ED9@DM5PR12MB1323.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8uMTqC7y4lfCqDQ/YXv7JTTDXMBf/uXQuVHM8dpQAcBTR/E0qc07M62XVw02qEVub72V4oNpCIvMywOwf9TKTECKCIFmLazGRdG+/WT8dYfkJG4rZGnuhezeZCdpiipz1qMCIGmjIn/66UyS4P9CKHcu7vT20zsrUYq6wcJ3jD+PTyeRyDtwKLWKIxuQWpHwLidY96yQdvnQSCIwWFKsK0Vq82pHoHid1eJyaE0FRU1D4U/tMHo5ftFT7eTL3KVHao5WYnIWVMY1hiLdZBzKa5Nj1ejECd9C3TqcTEurCdVtyx94mZ2e3okTo7+pzLNyUQRjGhstyo2flCE56VV4bFI+o9qe6TuuUYftwD1gbGTDb5MpmZk1fhCLd89oIG4z65V53E8k+RzqdjI3xiNlcvFovxDJPgpE2pwj65OfcMQd7jPAjAFSmfUHtvAJE8wHggQof7oZjHHlhWtp0mAzIsUIbn1DuB7Cy2REZqDcR8HdmjgAXpbLIVzRNMDIiFYOwSs0uvqvT8j19dqk6XjMjiyrGtifeaBXAgmG/mBxHDHTWXaH0vC4MvKy1CxxzMBc7FGNGpnzpx1Ii8pTdDBSsAFSbIIr+iEq93Lms5omC7qKZMCI9FtmnbQ1yXqfd9JCLEMZfCLncP0AMNC8S9v7xMbmPJcFEzL2rFEXQ/Gkc4MqpOmTwzX7Kv9qm0+gPf/sPYgkojQj2j2jLL5Ga9DLcRKNpKzCc28nZYGE3Zlo9kg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66476007)(66556008)(66946007)(8676002)(6916009)(54906003)(316002)(86362001)(6512007)(38100700002)(4326008)(2616005)(21480400003)(26005)(83380400001)(53546011)(508600001)(186003)(5660300002)(6486002)(7416002)(6666004)(235185007)(36756003)(8936002)(2906002)(33656002)(6506007)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3vPXG1Hzhh/pqZA6IKu2HoppcxI17Jwbsslr7uJhbg/ND0cPYzQ0RTbYJX6K?=
 =?us-ascii?Q?xVULGgUVs84Rz85+1AMBFcgcI/HuNDubQW3vLRDGZKF56qEJl6APeDDoKC/A?=
 =?us-ascii?Q?mrpjIEcGcPHBwIbdeTr/14pcU5pJdluBSm/W8b5ljSdYKMsurjo4ToHE96sh?=
 =?us-ascii?Q?Lp/N1JsFajSgg3x5gwgA2ew+YuPTN2KAqfU1D4EbgwwfVJxiAlps2fC+9rsE?=
 =?us-ascii?Q?neC2iTFmTirslTYzTKCsOqqZp43bTndnW9Yq/UcNDoG0gccQcPC8lZbvYBn+?=
 =?us-ascii?Q?GwibpbcUzImOGylCDIVratg1oUEYKxqPoj+dDpuImmKteWICC1oYUxEdO939?=
 =?us-ascii?Q?lrSCKi0mkNtd3co/n8hqzST1UXtGhiUjRo60KicnNkiTQspxUa7QyETQVfNs?=
 =?us-ascii?Q?gLjjh/xptx/tdDOAjeC9EyMGRcbPsXRjyO/zs8gnfpon5x+O6jbrFq98TEM6?=
 =?us-ascii?Q?No6+DDcFY5c52VKBOhUZqKVD7obJZ/PRTkWUdbDE+VLgum/zvUoRS1wWXa31?=
 =?us-ascii?Q?zpPl28cqYrmDlyfMjtATAUeSrDhQirwn3uq420zb8wqdNNTNvf4KuB5cJPCK?=
 =?us-ascii?Q?gu5u+2MBn660yIV4/AeepUB7ngFeuSRjP0BeOpCuD8m8ybJUYbwLORmf4cdC?=
 =?us-ascii?Q?oCmImhSxJQ5irfIywF3/eDksknCns9kZWp48rr7VIbealm0PoAq9l4a/0L/O?=
 =?us-ascii?Q?DxKL+7xBf1N5z+hZ4E+47Aipnu+PONLw6QI0rBN9kJ5UYJMhn13DE48lQvIp?=
 =?us-ascii?Q?2Tvk0EmvPlKQQhXkzV/+TbJ79P+NIbhBZ+wYVWoQuB4JZbaVj+mI1EKuFOr6?=
 =?us-ascii?Q?xBGVmo4Fnn9vnxyc1eAKqg25FBS75WnKWXcqy2kBtJH4+pn8zvP7mkNpEX7p?=
 =?us-ascii?Q?sd9A0JyHucuTOUEnzEqzfyYqwH4nSvcAIWidjCv6I/Foxp4wzjLlx9QnqHUF?=
 =?us-ascii?Q?UdR38CxQZ48OiDIS7ikC5k10cQzehYovDjPf1txUZap7bhxG2wOI5Dxu7tcN?=
 =?us-ascii?Q?oIP/5OJTWVRuNQP6bWdoPdxge2Iq/9rUt3U4kSdwYqOaK0+bFDo0WfunNrIA?=
 =?us-ascii?Q?ut9lmg37IBvLLdBcZmMY/ca2L4F1MX8NVTtxdx4+jA4YcoSlEGdHMlzLc8WS?=
 =?us-ascii?Q?xMmmWOnV84bo6Peh/5gH/LyRnCkPl9mBSTiThtSmmdRnXVhIb0JVIAwqlKK/?=
 =?us-ascii?Q?DVoTR7dfS4On+YSdaHPc5SM/Y+orRfSjhi9Eofb5QM+P5D/pzZQ7Yo3BGcYc?=
 =?us-ascii?Q?s7FVSwCPlFL64RN6KwJFSJG0IC2Euuzb/t2iAOAXlRR9uZLzbBYg/OQoeW/R?=
 =?us-ascii?Q?0NzK2O+x8PriQ9Ka/Ms7XMOjhnmYVoSiQQLYJ9blMBs37grU1gy7bYvZtLKO?=
 =?us-ascii?Q?M3C3IL3tbjfM2585Hnjp8nlq5GDls7FxCdUb1e5e7xpVKtoraB8VS7ZXvCVQ?=
 =?us-ascii?Q?S0sMDskrlt00Tvdlf3kF0+K0ShVM5UYGcyTSeFAgLofKgwuyLz8mywPkMd4O?=
 =?us-ascii?Q?qTXvV3B63FWYQRZhsyEPbAzkoGpJAHBHUQk8sR6lald8Lhf8mevL5A8rnuVh?=
 =?us-ascii?Q?SLmKIWMJ/PuS6jFNoiEzDzRx8sTS4ICubLwOeWKX09PlbjAMu1Ohn15K0ig0?=
 =?us-ascii?Q?H7nMlE9jtT3aIe30wYaBSUlTzaWKAD1h1mN+AKzZ6ZpSzGKMxyNrbMBvK3Xd?=
 =?us-ascii?Q?/iu/OhuUqTDNudm0tSyjedMRQN0Ub6e0L2wMQsUppvUv270nqJQA4N4+6lc+?=
 =?us-ascii?Q?k4n9uQ7z5A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0f4e6fb-b6b5-4cdf-c7db-08da1cbb75ae
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2022 19:34:29.3165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZEsWFPOPLaTPRWu6yRi3OVDV3qGf+8ajo2cypJ7Zeir9JzI5HvFJVU4JvW9JqH9u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1323
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_0BD2808D-31C0-4590-9F87-AFC70EE1725D_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 12 Apr 2022, at 13:41, Zi Yan wrote:

> On 12 Apr 2022, at 11:06, David Hildenbrand wrote:
>
>> On 12.04.22 17:01, Zi Yan wrote:
>>> On 12 Apr 2022, at 10:49, David Hildenbrand wrote:
>>>
>>>> On 12.04.22 16:07, Zi Yan wrote:
>>>>> On 12 Apr 2022, at 9:10, David Hildenbrand wrote:
>>>>>
>>>>>> On 06.04.22 17:18, Zi Yan wrote:
>>>>>>> From: Zi Yan <ziy@nvidia.com>
>>>>>>>
>>>>>>> Enable set_migratetype_isolate() to check specified sub-range for=

>>>>>>> unmovable pages during isolation. Page isolation is done
>>>>>>> at MAX_ORDER_NR_PAEGS granularity, but not all pages within that
>>>>>>> granularity are intended to be isolated. For example,
>>>>>>> alloc_contig_range(), which uses page isolation, allows ranges wi=
thout
>>>>>>> alignment. This commit makes unmovable page check only look for
>>>>>>> interesting pages, so that page isolation can succeed for any
>>>>>>> non-overlapping ranges.
>>>>>>>
>>>>>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>>>>>> ---
>>>>>>
>>>>>> [...]
>>>>>>
>>>>>>>  /*
>>>>>>> - * This function checks whether pageblock includes unmovable pag=
es or not.
>>>>>>> + * This function checks whether the range [start_pfn, end_pfn) i=
ncludes
>>>>>>> + * unmovable pages or not. The range must fall into a single pag=
eblock and
>>>>>>> + * consequently belong to a single zone.
>>>>>>>   *
>>>>>>>   * PageLRU check without isolation or lru_lock could race so tha=
t
>>>>>>>   * MIGRATE_MOVABLE block might include unmovable pages. And __Pa=
geMovable
>>>>>>> @@ -28,12 +30,14 @@
>>>>>>>   * cannot get removed (e.g., via memory unplug) concurrently.
>>>>>>>   *
>>>>>>>   */
>>>>>>> -static struct page *has_unmovable_pages(struct zone *zone, struc=
t page *page,
>>>>>>> -				 int migratetype, int flags)
>>>>>>> +static struct page *has_unmovable_pages(unsigned long start_pfn,=
 unsigned long end_pfn,
>>>>>>> +				int migratetype, int flags)
>>>>>>>  {
>>>>>>> -	unsigned long iter =3D 0;
>>>>>>> -	unsigned long pfn =3D page_to_pfn(page);
>>>>>>> -	unsigned long offset =3D pfn % pageblock_nr_pages;
>>>>>>> +	unsigned long pfn =3D start_pfn;
>>>>>>> +	struct page *page =3D pfn_to_page(pfn);
>>>>>>
>>>>>>
>>>>>> Just do
>>>>>>
>>>>>> struct page *page =3D pfn_to_page(start_pfn);
>>>>>> struct zone *zone =3D page_zone(page);
>>>>>>
>>>>>> here. No need to lookup the zone again in the loop because, as you=

>>>>>> document "must ... belong to a single zone.".
>>>>>>
>>>>>> Then, there is also no need to initialize "pfn" here. In the loop =
header
>>>>>> is sufficient.
>>>>>>
>>>>>
>>>>> Sure.
>>>>>
>>>>>>> +
>>>>>>> +	VM_BUG_ON(ALIGN_DOWN(start_pfn, pageblock_nr_pages) !=3D
>>>>>>> +		  ALIGN_DOWN(end_pfn - 1, pageblock_nr_pages));
>>>>>>>
>>>>>>>  	if (is_migrate_cma_page(page)) {
>>>>>>>  		/*
>>>>>>> @@ -47,8 +51,11 @@ static struct page *has_unmovable_pages(struct=
 zone *zone, struct page *page,
>>>>>>>  		return page;
>>>>>>>  	}
>>>>>>>
>>>>>>> -	for (; iter < pageblock_nr_pages - offset; iter++) {
>>>>>>> -		page =3D pfn_to_page(pfn + iter);
>>>>>>> +	for (pfn =3D start_pfn; pfn < end_pfn; pfn++) {
>>>>>>> +		struct zone *zone;
>>>>>>> +
>>>>>>> +		page =3D pfn_to_page(pfn);
>>>>>>> +		zone =3D page_zone(page);
>>>>>>>
>>>>>>>  		/*
>>>>>>>  		 * Both, bootmem allocations and memory holes are marked
>>>>>>> @@ -85,7 +92,7 @@ static struct page *has_unmovable_pages(struct =
zone *zone, struct page *page,
>>>>>>>  			}
>>>>>>>
>>>>>>>  			skip_pages =3D compound_nr(head) - (page - head);
>>>>>>> -			iter +=3D skip_pages - 1;
>>>>>>> +			pfn +=3D skip_pages - 1;
>>>>>>>  			continue;
>>>>>>>  		}
>>>>>>>
>>>>>>> @@ -97,7 +104,7 @@ static struct page *has_unmovable_pages(struct=
 zone *zone, struct page *page,
>>>>>>>  		 */
>>>>>>>  		if (!page_ref_count(page)) {
>>>>>>>  			if (PageBuddy(page))
>>>>>>> -				iter +=3D (1 << buddy_order(page)) - 1;
>>>>>>> +				pfn +=3D (1 << buddy_order(page)) - 1;
>>>>>>>  			continue;
>>>>>>>  		}
>>>>>>>
>>>>>>> @@ -134,11 +141,18 @@ static struct page *has_unmovable_pages(str=
uct zone *zone, struct page *page,
>>>>>>>  	return NULL;
>>>>>>>  }
>>>>>>>
>>>>>>> -static int set_migratetype_isolate(struct page *page, int migrat=
etype, int isol_flags)
>>>>>>> +/*
>>>>>>> + * This function set pageblock migratetype to isolate if no unmo=
vable page is
>>>>>>> + * present in [start_pfn, end_pfn). The pageblock must intersect=
 with
>>>>>>> + * [start_pfn, end_pfn).
>>>>>>> + */
>>>>>>> +static int set_migratetype_isolate(struct page *page, int migrat=
etype, int isol_flags,
>>>>>>> +			unsigned long start_pfn, unsigned long end_pfn)
>>>>>>
>>>>>> I think we might be able do better, eventually not passing start_p=
fn at
>>>>>> all. Hmm.
>>>>>
>>>>> IMHO, having start_pfn and end_pfn in the parameter list would make=
 the
>>>>> interface easier to understand. Otherwise if we remove start_pfn,
>>>>> the caller needs to adjust @page to be within the range of [start_p=
fn,
>>>>> end_pfn)
>>>>>
>>>>>>
>>>>>> I think we want to pull out the
>>>>>> start_isolate_page_range()/undo_isolate_page_range() interface cha=
nge
>>>>>> into a separate patch.
>>>>>
>>>>> You mean a patch just adding
>>>>>
>>>>> unsigned long isolate_start =3D pfn_max_align_down(start_pfn);
>>>>> unsigned long isolate_end =3D pfn_max_align_up(end_pfn);
>>>>>
>>>>> in start_isolate_page_range()/undo_isolate_page_range()?
>>>>>
>>>>> Yes I can do that.
>>>>
>>>> I think we have to be careful with memory onlining/offlining. There =
are
>>>> corner cases where we get called with only pageblock alignment and
>>>> must not adjust the range.
>>>
>>> In the patch below, you added a new set of start_isolate_pageblocks()=

>>> and undo_isolate_pageblocks(), where start_isolate_pageblocks() still=

>>> calls set_migratetype_isolate() and noted their range should not be
>>> adjusted. But in my patch, set_migratetype_isolate() adjusts
>>> the range for has_unmovable_pages() check. Do you mean
>>
>> Right, that's broken in your patch. Memory onlining/offlining behavior=

>> changed recently when "vmemmap on memory" was added. The start range
>> might only be aligned to pageblocks but not MAX_ORDER -1 -- and we mus=
t
>> not align u..
>>
>> The core thing is that there are two types of users: memory offlining
>> that knows what it's doing when it aligns to less then MAX_ORDER -1 ,
>> and range allocators, that just pass in the range of interest.
>
> Oh, you mean the pfn_max_align_down() and pfn_max_align_up() are wrong
> for memory onlining/offlining callers. Got it. And in patch 3, this is
> not a concern any more, since we move to pageblock_nr_pages alignment.
>
>>
>>> start_isolate_pageblocks() should call a different version of
>>> set_migratetype_isolate() without range adjustment? That can be done
>>> with an additional parameter in start_isolate_page_range(), like
>>> bool strict, right?
>>
>> Random boolean flags are in general frowned upon ;)
>
> I misunderstood about the alignment	issue. No need for this additional
> parameter.
>
> Thanks. Will take your patch and adjust this one based on yours.
>
> I will wait for your reviews on patch 3 and onwards before sending
> out a new version.

As I am editing my patch 2 and 3 based on your patch, it becomes redundan=
t
to have start_isolate_pageblocks() in patch 3, since start_isolate_page_r=
ange()
will only require pageblock size alignment after patch 3.
start_isolate_pageblocks() and start_isolate_page_range() do the same thi=
ng.

Since moving MAX_ORDER-1 alignment into start_isolate_page_range() is wro=
ng
in patch 2, I think it is better to move it in patch 3, when
start_isolate_page_range() is ready for pageblock size alignment. Patch 2=

then will have no functional change, since the range does not change and
has_unmovable_pages() will make its in in patch 3 eventually.

If you think moving the range alignment adjustment should be a separate
patch, I can move it to patch 4 after patch 3 when all the related
functions are ready for the new pageblock size alignment.

--
Best Regards,
Yan, Zi

--=_MailMate_0BD2808D-31C0-4590-9F87-AFC70EE1725D_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmJV1EIPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUNG4QAJtOWQcoVtqwtHdKyhz59tAodFV2ot5Kp7Su
V0kWvIEI9EfuzFqmI5fMjoUFCPqZw9OLHe8NFA4mLNZN5hcBRuWLFnERvKDbyXvD
DQwOWk5yYyRluwBiUpe7c6z5mJ+X2Kp0kOl0e3LcrV5FENDzyQb+CzBG7lwPZr8R
nqByJotjvpOjXnj1ZDwsrBG/ve6b86Tov/lx2SfCnOyY0wk+eqE+JHEfUf4z+YUF
Q0acMDuFiQkCQ9zDiBqh9AMnp2pDeqFL3q9Xcyij+H3c6x/gt78xG+MUoU/pQEi3
Fh2qZdyrAOa/9qw7knzunlZDzQJ+0pd1xdLxWi7EjxGTKNylEdZWqheYvVSrBC2Q
nSFy4q7vx+Iik+rMf5tkqGAguTtGJ7sUC6qakK+D2s/0ShuvdOOJdplP1RVeXH7z
0XyDh10HCegEmyCGrXbFY2yUJu2eEJoCO6Ixp0mRs5oifhGgF8FHFAdABKoiDI2m
pN9z+84CjSY4i7bAlG3NQCdOENZq8RhuoO1rvegD48UcTPXcFrZRDfD4RwcBIqL3
WhZN6EhQ7doGAWXMKkQgmqm98U5SI/bOaFa06UysS0zmnmTu6YO6cC2s3jqTUwSz
EDYcSwl4oAwINsf8+I1alaLzCB2VilbqyUI+WregjMRvPyxF306KcSKfGCUFGZlx
UP0MEdBW
=4yWY
-----END PGP SIGNATURE-----

--=_MailMate_0BD2808D-31C0-4590-9F87-AFC70EE1725D_=--

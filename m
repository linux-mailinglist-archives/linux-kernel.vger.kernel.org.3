Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1F74E2FE4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 19:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352097AbiCUSYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 14:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352106AbiCUSYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 14:24:37 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5361D339
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 11:23:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ANKJabyS3ewlHuOoZj+mrW/QWsQsSm860pb8IWAGMoIGj42xjuScm8MARHfoz2Ny/kcISObYkJDXkyYBhu6Jm7plP291aiMmI6q5SWLQmusdAcWA9bQN8/NoRfebAOmNRqTRVX7nPriqc0AP0zpeujvYUK+n0PjvZFAIenAMeTgJP+kfYSWKkNp5HUHTu5Vskyt8QPhqGIIEAAk9pFH8JQ96MvdwOphMtXGY27M+shOLglY0pj4TIWg6q0r3WX9/758CXZ3kr+jY/hRw+dxvqjiI6S1h76jQ9XFb9efLqwDCzAog0RXsZzuSxb/fDM53XDikbMAQsCwirWS5otOIoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fQwDxK/gdIHqbqOeEp/IQxRlNZ4A2bHTRBpng4gQ7m8=;
 b=H3svOxFgmy1we5y9MX/AST84BUJ60SsCXVqDLKWSVb4F7Z3RxiFV0cYon10CQsBV+gI1duA5MOgI9HgZaAa8SiQqCyu9ZS6W9efNk/dipYfQ5leHWNwAVA5nuJL2exqo4fV8T2qOKJPc/bCK6tjpElxG9Yi483gDlb4aatN9KB63q4ksh7xObwnvPUJW2s3HzyaozP3JU8AE8B1wk6Sgrh0QLIze27WDQZqQrqdNjGTw0ll4TuNJViwJo1u3Ba4Ettu4nUXguYroW3eNFsWYMWW1pUf+gpM+1KDAED59BGwABQUdVCzp9H/lQ7ZIVYw+1AQPqFo+rKSzeBkGLXk5lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fQwDxK/gdIHqbqOeEp/IQxRlNZ4A2bHTRBpng4gQ7m8=;
 b=P0cImXvud7d2jluMyngiDjKZatqO4LB4aLdwjWrd0Okp+pTkd0NV+cVobEIs1mS67ZWWHHRpkoGL/l8irrziXM3yjZQiOuHfOyqwv61mBvA76Cfonmr+FCFr6SekQNlxkNsGeTNzodN5H1F0Qzb7qQPRBAzA2MQamS69cRBCk/yJLF0XcgEIyQ/N65OCkF4yPtlld8lUz9dGmmqwm9JphxNIMGXy1KkcJvUJMcGhsP+8aQmLq41hv//XlVlY9UrXHwq9Siq0Ap7pjSJjgBITKvO+saVgEv0X+dxM4kKlvSy48gH/NEHQnTrSIfKgL+t3FwZg4e1yx7q2YXvmcDJkFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by BY5PR12MB4212.namprd12.prod.outlook.com (2603:10b6:a03:202::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Mon, 21 Mar
 2022 18:23:09 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::40a6:6e1d:b057:a036]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::40a6:6e1d:b057:a036%6]) with mapi id 15.20.5081.023; Mon, 21 Mar 2022
 18:23:09 +0000
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
Subject: Re: [PATCH v8 2/5] mm: page_isolation: check specified range for unmovable pages
Date:   Mon, 21 Mar 2022 14:23:07 -0400
X-Mailer: MailMate (1.14r5870)
Message-ID: <3379379B-489B-460F-8B01-9A1D584A5036@nvidia.com>
In-Reply-To: <44a512ba-1707-d9c7-7df3-b81af9b5f0fb@redhat.com>
References: <20220317153733.2171277-1-zi.yan@sent.com>
 <20220317153733.2171277-3-zi.yan@sent.com>
 <44a512ba-1707-d9c7-7df3-b81af9b5f0fb@redhat.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_605DE710-A1C7-453D-9556-8FFF53B4648D_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR20CA0060.namprd20.prod.outlook.com
 (2603:10b6:208:235::29) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12600e52-92ef-43ad-cb86-08da0b67d9f9
X-MS-TrafficTypeDiagnostic: BY5PR12MB4212:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4212465F352A01AED49B25BAC2169@BY5PR12MB4212.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aTxrWCN0uPm6KVPI34AST8oyg8UwgpEFilHglwNyGfJxaOkIdZKJycgRXgdQR2VZ4ful5a955GAGuUyai1+fLKcGTFEzp+KoK12RKFXW3a8NfEbE59wUegLHUtXQHxXZaAXZQjDtrnclr/uXmv7c3V8hceM53leTh6HVPmu3oyhgEOYGNPg0Gwq9+pBrcztKAqUIqsFqyeJ3A/cbGc1EHonFwJW7WYXXGQ/LM1foR1ilcP6kqkhHT6lwNlGdwiT2RyghAkI3qkkCOTWI1VgIayS6iJlCanZvd1QBUybmRdfWe11EL33TCmXVxPzqI0DE0Z6h55rCgJch/ZqdORoqN72GKeFzmlUvVKBoPnj6E+x4Fj4FnlwthVriEi0WlckQyNUbU/HES+N8HouZDBbvWgFik3l1gbRFKev6w6gGAz4p6s9VJPxe29ca5UJ8tp11jZYdCtwtQM8z+7tgb/R7Nlk8Z5YZXYAAdGUuA0o9oyyR6kq9KB8wz7fGNDORi1/p8J7QwtADrZLsKUD3cV3g4NJNtJOs6nESmZ+a+M0yVzY7p3yvnR7W1ROG7+v2m3JQ2+EngHBaHk+borIhXmlOS4Yj1KHLSGFu+g4i1TD88LS9ZIXvZvFckD0X5pd5WxGvmkI+K+cVaOOKWjCkgrF/tuwqEJ+15QzFvndNAIlDvVHwq93ibXady8OBlS7t/QDiXsVRuiEJkRwK04JPEnfzIq2EhnwRJyVyIFxf8xcoIv8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(33656002)(86362001)(2906002)(508600001)(8936002)(8676002)(66476007)(66556008)(66946007)(4326008)(6916009)(316002)(54906003)(6486002)(6506007)(53546011)(6512007)(38100700002)(26005)(2616005)(186003)(83380400001)(235185007)(7416002)(5660300002)(36756003)(21480400003)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VP0C+hs07kBx5LX2SrxNBEQAcDIs1PBWr7gmNwVmvGuEwHBgh/XIVWl+E/Iy?=
 =?us-ascii?Q?hcl2JQuzOP3NlIdxHDuAbw8hKN2frmL/ryEAdn1mCnBUHlfgVXWAde+EE0Ak?=
 =?us-ascii?Q?bpw1CRSZqrtzNtcPis1qj029XbsCjwNRwl1T/W+48Mub3oWAH7O+96HkPzWf?=
 =?us-ascii?Q?TKuvlrh4rVeQVDipdKjA//ftFLlphxEdyXGQ9eliz1KlMRx0Ugd/PRejTL+y?=
 =?us-ascii?Q?jzgN23RhViGNzMnTU38ugxRBXUKhmV+oisXOYhq/1dRDTCDgz+X1lR5XSLQ9?=
 =?us-ascii?Q?DDGqHMKMtxnWI90CG+DZdT0twFAsV5yr6SSI6CBu0mwgyGWbPOa6+j7UOUws?=
 =?us-ascii?Q?b7NsgcU9MfWV6VjF9uaV7vMA9rIrpv8LOy1qajoKlq1354vPijLdD/NSZUpV?=
 =?us-ascii?Q?WqpsWpPMu1IPfNUkSVn2IAPMfbi84i3aJ+FAKvoPpetxhaQ90yUUQNo67UVw?=
 =?us-ascii?Q?hXncykHi53LHCl6JJQ4tq2+l/tm7MPsCiptZ6RC1VR3SxftJW/bkxlRbwbJp?=
 =?us-ascii?Q?wOxNZDN820xG3a9vv7LX+23UALGYAhGGnSxX7KI3QeVamjbyruTWgAW80YV+?=
 =?us-ascii?Q?kyvkPMDkw91mLVwqQYGLk8XefpaTjYt98LDFHMDjvtF83q4rBOUAUsv0s6lu?=
 =?us-ascii?Q?IWik4uMLcqWry22KRKwWwHOCP9DEc4DvZKoRyNK4AXoNpvMQ4K1fJjq9SB8I?=
 =?us-ascii?Q?wV3Oe5Oun9IG5TSyBZNUAGQnSPT30xIhR/MNXeXkdDIpdGxcp+mwEghSmzZZ?=
 =?us-ascii?Q?IyJvlri2iaIOFbnR00b1r9Da7GgnlBIP9DjF/rKiz1UsGXkKxJnZrMcQQa2B?=
 =?us-ascii?Q?RV52HpNUEidkYUzYV8qq9yBh3/nTTjnd0yAenIrea12Q1p9x2MATUvWpsG7L?=
 =?us-ascii?Q?dnuYjynRGLraiGOsFc3ZD/HJNqFcE6dAldmSd4xAEwgX6EzZ9+wBMyo3u45Z?=
 =?us-ascii?Q?eIiSch0NsRRLEzTRTCDj5S7pAF5h4qAe6kx1yZU++YgoH2GjHVbSFrENGbW+?=
 =?us-ascii?Q?aJVQz+SzpM3NgWsIMIsT8jWot2X9HSkGql7OJ8/YkNRnRRDSD6EHVZ5T/qmX?=
 =?us-ascii?Q?hZ5Ff8+0tJbqxs354iktRE3SEdXb210qnjEkTRZJ+IplmLWNcqPAEboyX/zp?=
 =?us-ascii?Q?jMi+o6NtSkbVOBp0QTO/Gl/IBiTf4VI5z8GOy+pxy0cJ+seBwUGCmGIUG65u?=
 =?us-ascii?Q?7b9yhj5/vP8qQmeJk0R56icKTwSyRqzQztaE9EpPFOy7KktHwIjEyZAGhdqp?=
 =?us-ascii?Q?2D8ADyGTZydxWDrgTSjAV9n10QGaCuD67JkwN9gt4NkyA8/cmoNuwSTqn6Xu?=
 =?us-ascii?Q?zftzA7vrid4KkNYcdORP1NQcW8YnADgF75eHObj6Ru+OYc5wwiSmCElvVGkH?=
 =?us-ascii?Q?3JKcIT6cWplvgnvuarAlBjzFcaQNPCRRTR0+1qs8Ljejl317uYAJ9Qrsqwaw?=
 =?us-ascii?Q?Lgwbuw1bxagg/EyWAY/D86rNjahKeSpH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12600e52-92ef-43ad-cb86-08da0b67d9f9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2022 18:23:09.5566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dtZtp5S7INtMx5hohsKvQ2UgxMf2HgXi1o4AZid/XC4SLoohyMrjoqDmBLGlSEIS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4212
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_605DE710-A1C7-453D-9556-8FFF53B4648D_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 21 Mar 2022, at 13:30, David Hildenbrand wrote:

> On 17.03.22 16:37, Zi Yan wrote:
>> From: Zi Yan <ziy@nvidia.com>
>>
>> Enable set_migratetype_isolate() to check specified sub-range for
>> unmovable pages during isolation. Page isolation is done
>> at max(MAX_ORDER_NR_PAEGS, pageblock_nr_pages) granularity, but not al=
l
>> pages within that granularity are intended to be isolated. For example=
,
>> alloc_contig_range(), which uses page isolation, allows ranges without=

>> alignment. This commit makes unmovable page check only look for
>> interesting pages, so that page isolation can succeed for any
>> non-overlapping ranges.
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> ---
>>  include/linux/page-isolation.h | 10 +++++
>>  mm/page_alloc.c                | 13 +------
>>  mm/page_isolation.c            | 69 ++++++++++++++++++++-------------=
-
>>  3 files changed, 51 insertions(+), 41 deletions(-)
>>
>> diff --git a/include/linux/page-isolation.h b/include/linux/page-isola=
tion.h
>> index e14eddf6741a..eb4a208fe907 100644
>> --- a/include/linux/page-isolation.h
>> +++ b/include/linux/page-isolation.h
>> @@ -15,6 +15,16 @@ static inline bool is_migrate_isolate(int migratety=
pe)
>>  {
>>  	return migratetype =3D=3D MIGRATE_ISOLATE;
>>  }
>> +static inline unsigned long pfn_max_align_down(unsigned long pfn)
>> +{
>> +	return ALIGN_DOWN(pfn, MAX_ORDER_NR_PAGES);
>> +}
>> +
>> +static inline unsigned long pfn_max_align_up(unsigned long pfn)
>> +{
>> +	return ALIGN(pfn, MAX_ORDER_NR_PAGES);
>> +}
>> +
>>  #else
>>  static inline bool has_isolate_pageblock(struct zone *zone)
>>  {
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 6de57d058d3d..680580a40a35 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -8937,16 +8937,6 @@ void *__init alloc_large_system_hash(const char=
 *tablename,
>>  }
>>
>>  #ifdef CONFIG_CONTIG_ALLOC
>> -static unsigned long pfn_max_align_down(unsigned long pfn)
>> -{
>> -	return ALIGN_DOWN(pfn, MAX_ORDER_NR_PAGES);
>> -}
>> -
>> -static unsigned long pfn_max_align_up(unsigned long pfn)
>> -{
>> -	return ALIGN(pfn, MAX_ORDER_NR_PAGES);
>> -}
>> -
>>  #if defined(CONFIG_DYNAMIC_DEBUG) || \
>>  	(defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DYNAMIC_DEBUG_MODULE)=
)
>>  /* Usage: See admin-guide/dynamic-debug-howto.rst */
>> @@ -9091,8 +9081,7 @@ int alloc_contig_range(unsigned long start, unsi=
gned long end,
>>  	 * put back to page allocator so that buddy can use them.
>>  	 */
>>
>> -	ret =3D start_isolate_page_range(pfn_max_align_down(start),
>> -				       pfn_max_align_up(end), migratetype, 0);
>> +	ret =3D start_isolate_page_range(start, end, migratetype, 0);
>>  	if (ret)
>>  		return ret;
>
> Shouldn't we similarly adjust undo_isolate_page_range()? IOW, all users=

> of pfn_max_align_down()/pfn_max_align_up(). would be gone from that fil=
e
> and you can move these defines into mm/page_isolation.c instead of
> include/linux/page-isolation.h?

undo_isolate_page_range() faces much simpler situation, just needing
to unset migratetype. We can just pass pageblock_nr_pages aligned range
to it. For start_isolate_page_range(), start and end are also used for
has_unmovable_pages() for precise unmovable page identification, so
they cannot be pageblock_nr_pages aligned. But for readability and symmet=
ry,
yes, I can change undo_isolate_page_range() too.

>
> Maybe perform this change in a separate patch for
> start_isolate_page_range() and undo_isolate_page_range() ?

The change is trivial enough to be folded into this one.

>
>>
>> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
>> index b34f1310aeaa..419c805dbdcd 100644
>> --- a/mm/page_isolation.c
>> +++ b/mm/page_isolation.c
>> @@ -16,7 +16,8 @@
>>  #include <trace/events/page_isolation.h>
>>
>>  /*
>> - * This function checks whether pageblock includes unmovable pages or=
 not.
>> + * This function checks whether pageblock within [start_pfn, end_pfn)=
 includes
>> + * unmovable pages or not.
>
> I think we still want to limit that to a single pageblock (see below),
> as we're going to isolate individual pageblocks. Then an updated
> description could be:
>
> "This function checks whether the range [start_pfn, end_pfn) includes
> unmovable pages or not. The range must fall into a single pageblock and=

> consequently belong to a single zone."
>

Sure.

>>   *
>>   * PageLRU check without isolation or lru_lock could race so that
>>   * MIGRATE_MOVABLE block might include unmovable pages. And __PageMov=
able
>> @@ -28,27 +29,26 @@
>>   * cannot get removed (e.g., via memory unplug) concurrently.
>>   *
>>   */
>> -static struct page *has_unmovable_pages(struct zone *zone, struct pag=
e *page,
>> -				 int migratetype, int flags)
>> +static struct page *has_unmovable_pages(unsigned long start_pfn, unsi=
gned long end_pfn,
>> +				int migratetype, int flags)
>>  {
>> -	unsigned long iter =3D 0;
>> -	unsigned long pfn =3D page_to_pfn(page);
>> -	unsigned long offset =3D pfn % pageblock_nr_pages;
>> +	unsigned long pfn =3D start_pfn;
>>
>> -	if (is_migrate_cma_page(page)) {
>> -		/*
>> -		 * CMA allocations (alloc_contig_range) really need to mark
>> -		 * isolate CMA pageblocks even when they are not movable in fact
>> -		 * so consider them movable here.
>> -		 */
>> -		if (is_migrate_cma(migratetype))
>> -			return NULL;
>
> If we're really dealing with a range that falls into a single pageblock=
,
> then you can leave the is_migrate_cma_page() in place and also lookup
> the zone only once. That should speed up things and minimize the
> required changes.
>
> You can then further add VM_BUG_ON()s that make sure that start_pfn and=

> end_pfn-1 belong to a single pageblock.

Sure.

>
>> +	for (pfn =3D start_pfn; pfn < end_pfn; pfn++) {
>> +		struct page *page =3D pfn_to_page(pfn);
>> +		struct zone *zone =3D page_zone(page);
>>
>> -		return page;
>> -	}
>> +		if (is_migrate_cma_page(page)) {
>> +			/*
>> +			 * CMA allocations (alloc_contig_range) really need to mark
>> +			 * isolate CMA pageblocks even when they are not movable in fact
>> +			 * so consider them movable here.
>> +			 */
>> +			if (is_migrate_cma(migratetype))
>> +				return NULL;
>>
>> -	for (; iter < pageblock_nr_pages - offset; iter++) {
>> -		page =3D pfn_to_page(pfn + iter);
>> +			return page;
>> +		}
>>
>>  		/*
>>  		 * Both, bootmem allocations and memory holes are marked
>> @@ -85,7 +85,7 @@ static struct page *has_unmovable_pages(struct zone =
*zone, struct page *page,
>>  			}
>>
>>  			skip_pages =3D compound_nr(head) - (page - head);
>> -			iter +=3D skip_pages - 1;
>> +			pfn +=3D skip_pages - 1;
>>  			continue;
>>  		}
>>
>> @@ -97,7 +97,7 @@ static struct page *has_unmovable_pages(struct zone =
*zone, struct page *page,
>>  		 */
>>  		if (!page_ref_count(page)) {
>>  			if (PageBuddy(page))
>> -				iter +=3D (1 << buddy_order(page)) - 1;
>> +				pfn +=3D (1 << buddy_order(page)) - 1;
>>  			continue;
>>  		}
>>
>> @@ -134,7 +134,13 @@ static struct page *has_unmovable_pages(struct zo=
ne *zone, struct page *page,
>>  	return NULL;
>>  }
>>
>> -static int set_migratetype_isolate(struct page *page, int migratetype=
, int isol_flags)
>> +/*
>> + * This function set pageblock migratetype to isolate if no unmovable=
 page is
>> + * present in [start_pfn, end_pfn). The pageblock must intersect with=

>> + * [start_pfn, end_pfn).
>> + */
>> +static int set_migratetype_isolate(struct page *page, int migratetype=
, int isol_flags,
>> +			unsigned long start_pfn, unsigned long end_pfn)
>>  {
>>  	struct zone *zone =3D page_zone(page);
>>  	struct page *unmovable;
>> @@ -155,8 +161,13 @@ static int set_migratetype_isolate(struct page *p=
age, int migratetype, int isol_
>>  	/*
>>  	 * FIXME: Now, memory hotplug doesn't call shrink_slab() by itself.
>>  	 * We just check MOVABLE pages.
>> +	 *
>> +	 * Pass the intersection of [start_pfn, end_pfn) and the page's page=
block
>> +	 * to avoid redundant checks.
>>  	 */
>
> I think I'd prefer some helper variables for readability.

Will do.

>
>> -	unmovable =3D has_unmovable_pages(zone, page, migratetype, isol_flag=
s);
>> +	unmovable =3D has_unmovable_pages(max(page_to_pfn(page), start_pfn),=

>> +			min(ALIGN(page_to_pfn(page) + 1, pageblock_nr_pages), end_pfn),
>> +			migratetype, isol_flags);
>>  	if (!unmovable) {
>>  		unsigned long nr_pages;
>>  		int mt =3D get_pageblock_migratetype(page);
>> @@ -267,7 +278,6 @@ __first_valid_page(unsigned long pfn, unsigned lon=
g nr_pages)
>>   * be MIGRATE_ISOLATE.
>>   * @start_pfn:		The lower PFN of the range to be isolated.
>>   * @end_pfn:		The upper PFN of the range to be isolated.
>> - *			start_pfn/end_pfn must be aligned to pageblock_order.
>>   * @migratetype:	Migrate type to set in error recovery.
>>   * @flags:		The following flags are allowed (they can be combined in
>>   *			a bit mask)
>> @@ -309,15 +319,16 @@ int start_isolate_page_range(unsigned long start=
_pfn, unsigned long end_pfn,
>>  	unsigned long pfn;
>>  	struct page *page;
>>
>> -	BUG_ON(!IS_ALIGNED(start_pfn, pageblock_nr_pages));
>> -	BUG_ON(!IS_ALIGNED(end_pfn, pageblock_nr_pages));
>> +	unsigned long isolate_start =3D pfn_max_align_down(start_pfn);
>> +	unsigned long isolate_end =3D pfn_max_align_up(end_pfn);
>>
>> -	for (pfn =3D start_pfn;
>> -	     pfn < end_pfn;
>> +	for (pfn =3D isolate_start;
>> +	     pfn < isolate_end;
>>  	     pfn +=3D pageblock_nr_pages) {
>>  		page =3D __first_valid_page(pfn, pageblock_nr_pages);
>> -		if (page && set_migratetype_isolate(page, migratetype, flags)) {
>> -			undo_isolate_page_range(start_pfn, pfn, migratetype);
>> +		if (page && set_migratetype_isolate(page, migratetype, flags,
>> +					start_pfn, end_pfn)) {
>> +			undo_isolate_page_range(isolate_start, pfn, migratetype);
>>  			return -EBUSY;
>>  		}
>>  	}
>
>
> -- =

> Thanks,
>
> David / dhildenb

Thanks for your review.


--
Best Regards,
Yan, Zi

--=_MailMate_605DE710-A1C7-453D-9556-8FFF53B4648D_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmI4wowPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUs1EP/RRBRjXVcCmRswBgj6F68TLqEX/1tScdYVuP
OCH3+MD4120X0MNfajVSd6Uajh9N0Ng1zPyO2lqnFIVzoVbuMViSMQQ2HpFinalF
gBjGg00IJYC7sy7dO5als7JtlXSTus+K8FF7kdBhxIbQwfVpAqBpH81FVrjwyvog
Dw47W1pVfrtIA4i1lPlbjxlT7vuf3cdzrIMlyhsSsc2J7bGYlT4xoJDTpuXhJn1h
vAEpymCxwJqajkgEIe7gEm4i/z24UMS2RHjtveX7VIul7aPQeVUNuRcFAs4vqrxV
sVRHmVa0m+T7rcMK91N1MZV59PZmfcRI05/sR+NqsO/lTKcRvzQ/qfjkWUSepQLs
PXIQhR2X9G3cbYrrxlfnYeQSbx7papJxtSHPhTJHt+qe8f/LVnwDj4S5h/t44fYN
KspVH36ZK5PrL0yguVfMnt/p4+lA0Y9SYuAZ0jdczEt4XVw1XtMq3uCTsbs+7urh
5ETHo4YFAELhkSw+O1ULtc68V93qeZlCN5uxhECtVc5DlKuXL3pkLr+u1hKNOlsH
PD2518FVOonxMv9PWS3672brRjpYqobGQiOM4LQFEn0B1nsPYdFEuf36GJF9Ya00
09uNfzOOKztyLUGtnvXgM8F76S/3XyBsM6wGX9q1gWn9ByrPMtIGNs3iZUDUTsWF
6XjXaTsp
=czjX
-----END PGP SIGNATURE-----

--=_MailMate_605DE710-A1C7-453D-9556-8FFF53B4648D_=--

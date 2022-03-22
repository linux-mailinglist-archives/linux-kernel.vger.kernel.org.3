Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A39C44E4892
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 22:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236232AbiCVVo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 17:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236169AbiCVVoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 17:44:03 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2059.outbound.protection.outlook.com [40.107.212.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F895F4C8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 14:42:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NhxQSoFAgAQMT4aqjZKqHZ+ZZLQihBdzLvxiWqNIBHeGZUWwuqLkDZIXUitP64VCIyo/dwYDtlj8KgwiD+h/kxwPkpnVcY5HlCtlphofGb7YGHEyJBPdI2JD10f5OXgktn29ejlE7bIL3MocET1ijtFEZV7uVxFP4DnBYcJjyP4dAhnXRLVhBtCyguGKyBsENKWX9YByrbsuVR/D/LlXitwVTsGujjRD26c1uG63nC6+xKabcclZ1zjCGzY9m1/De+8IuZGgMTt+GO2buirc+JH+Jvv/W3xRd71uPKidyh7ULI3jwXcIfjCwD7U1rSQKn1C5q+tiAJgrPW2rgnin7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rbo5xttb3nA1tIJXyi/l60LOgXmMeakpL8QTm19PHfE=;
 b=OxKTZUE1n9b3cUFu74l948OeQ3bCI5XQRPRZtqHLWnnFi6CWkV0ooUkvs9YAAs1AHsD7cHl1EdMTcafubJ0C9FxgsI3d69vCMmPy4z2lMsKvoesLUACPScmPFNt56P7tLiAgc3LvZAeh8LW4SSJQIe3nf8ERQ8KKD+sjmko9ff4a2kp8/QPo1VpOcBsHiyLFo5N/+RZs/qYSEI4+rET/++Wp5qQWBQ6Kl81TxRFK+jl/zU4QRTrLn2shqysvpupEymzgRE4Tdzzuz1W+aVVEplr+S6LtUawZTGC0zrrJZPXEIfaqc5VV5sqPn7p1dHOfY93UKnBguA/Vd39aBpGPlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rbo5xttb3nA1tIJXyi/l60LOgXmMeakpL8QTm19PHfE=;
 b=iSWeQB+opdWCBBK/0CmbuI62JeCueeQ5F/klS6Sqa3zE+qUPjjlZM+W/iCvLW6ZabmLzGnYgSfAf9W6VCu2aJqN1JNm+qemlEaZ4Wy/JaBtagLiH1lxgUoQ51ch2SseG3Trx9ra0acR5XQh+YQfVJuTVOn5+sXtSckqomDlN3Yyd1fwh0LZoBbXglWdCE8PAsYRSBBv4884TJmbUBo9YN3u49bkixFOR68IyKhzIM7XeLTSRt5PCZZoQB6fvrXbxhuwWn/Yo1nFQ5fnvBBA+O4iWRaB2GplFStMYHIzRt5tPz/5mYYcEPpC0/Dg8vTaWLnGs1e/M/JlCEtCFXUhwtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by DM8PR12MB5415.namprd12.prod.outlook.com (2603:10b6:8:25::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.16; Tue, 22 Mar 2022 21:42:26 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::40a6:6e1d:b057:a036]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::40a6:6e1d:b057:a036%6]) with mapi id 15.20.5081.023; Tue, 22 Mar 2022
 21:42:26 +0000
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
Date:   Tue, 22 Mar 2022 17:42:23 -0400
X-Mailer: MailMate (1.14r5870)
Message-ID: <C7B712AC-D280-4C74-8910-1A9524669E6A@nvidia.com>
In-Reply-To: <a4c81f17-b32c-8873-ff73-a8729171e93f@redhat.com>
References: <20220317153733.2171277-1-zi.yan@sent.com>
 <20220317153733.2171277-3-zi.yan@sent.com>
 <44a512ba-1707-d9c7-7df3-b81af9b5f0fb@redhat.com>
 <3379379B-489B-460F-8B01-9A1D584A5036@nvidia.com>
 <a4c81f17-b32c-8873-ff73-a8729171e93f@redhat.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_6851798D-CD15-4D07-AB86-04DA6985BD27_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR17CA0030.namprd17.prod.outlook.com
 (2603:10b6:208:15e::43) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73c262b5-cd89-4861-086a-08da0c4cdaff
X-MS-TrafficTypeDiagnostic: DM8PR12MB5415:EE_
X-Microsoft-Antispam-PRVS: <DM8PR12MB54159177E6E58536D31081D3C2179@DM8PR12MB5415.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W7BiEldtzpZvw6wgaouynlw1/9aaXhX62Vh5Jjfp5kwo3m7Z3MhgfZa2xNrPZ/AaRDEY+6yjDbnxkO5W/+377Hx++UAyY47rzxfTWQPJFxP91jI2nYnYQkyWlTkfsnJ5PmT3lS/D4H3lUc8/GzJbCuAkQLye7Id8hrsAjRF8tJ5szLf69rPB30a6hm7scR+tMzXtehB7aZZPNFu1jsrhb84cTQk5ULd9WbZlfmm5SfJxbFcn6cMwdY5CH5Pag3MCs0UkniT06VTNSq8XetcNYtnsyC9b6FuYho92oCd0xve2G/UEQb4uKJJr80ueJo+vrwX25Q6SCAFb9JdLXVB+DCCxEudsUQRB6osAxXTxZZYvHN1ZJdmYJODfvtCp2GTwnArZxGAV/2oP0MJuaMBuGeXgzWEz1FN9H3pcrNUIUvKjo702UnB9NTtiA/b1buZfNBAKncz2NkZaO5E8t2Xh7KPDPi5WDCzX2J8BZaKz6Q+yChlky7hvhFxSDG5p28xpkUuN/RSc0M75VyfWZcblmTpwtlgmFhacvOqO1kQwQmi5L6w7D1mERNDCRv3Ol0TU8lkkuo/YaNxgPIgi2VXSasvZqHZH1XV/tmwM51gdtGCVNlBXdDh9n9/eF16rjZQgipjACOi0HeYU27F5G9b8ndEar72N+sRsx/R67sf/5PnpBf8/u5Su2QZfZGmPgSJI9SMMwdilNrnMCDgCKqmXtRp3HBoubMfBRx+i5V6jwWg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(54906003)(66946007)(66476007)(66556008)(6916009)(2616005)(26005)(186003)(316002)(4326008)(36756003)(8676002)(6506007)(6512007)(6666004)(53546011)(33656002)(6486002)(21480400003)(86362001)(508600001)(83380400001)(235185007)(38100700002)(2906002)(5660300002)(7416002)(8936002)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kUWIuSZWbfUCTEpxzSnPzn+T81FqKN1PR100wvYBsYrBc3m/lbOmyZmE+SKc?=
 =?us-ascii?Q?nmaW/1uvaGAvaHE0HXRLiAXb4l406c2Afj6NeH9hjwiGnLJrE+qwa3/EsFQJ?=
 =?us-ascii?Q?BLA7JUmjt7mLQH4A5rdnli6GryUx3bEyVmRhga4OBQJjv7fj6UqbN7wo2RSq?=
 =?us-ascii?Q?sGRs4CVpfdI36qLLTaKDoHb/qN5bW8n067Pk9XC7PMBFJ9ML81Uxzpfuv7E6?=
 =?us-ascii?Q?IEmD7ubUQqp4uj/dtOF4DZr+bsIYrw4ePBbyUcIir82kgzE60x3WII+RryaC?=
 =?us-ascii?Q?d6VSgWxVmKhKYn5VKBeYuI9BreobScXrG6UWF6Sond24D6SXkRH4g2G8TNIc?=
 =?us-ascii?Q?to0swxQ+/1s3OfSGT2hARGQJTaVdsKcOr9NiDq+X4Zyk8C5uiXT3JJzoqePY?=
 =?us-ascii?Q?aw6ZOFQFI/nIKZ8+p6mFLcT2+DASYXh293hi4HaZVud+iTDSOdflC7dyZvjY?=
 =?us-ascii?Q?DIdj520xfajlVxPN6AIqTPjW7W4OCJuMg2hHhDnzQ1YO97LjMj6wl9FRZ4dr?=
 =?us-ascii?Q?iPKbNczY3jeYJq3i5cWL1EOI1FxtZtNZuyzBOeghLcXMhPDPrZXQCAwoDx/e?=
 =?us-ascii?Q?bcLdRiX1dhW2KeaIpcVnGFGoYIGx0Ae//MjEDflYV0ggyiP/YIddzgFJg8tA?=
 =?us-ascii?Q?b6qTx7lvMkKfeyhiaFAL9G2iCWRBPqBgO2xoCxnoDUR972QkvxCKhSftb77d?=
 =?us-ascii?Q?JG7VI71MNpeRxBhpZZRqqO3uiWuoL8WOzz0OdTOrhX48865k+Wd4OQU1YLQT?=
 =?us-ascii?Q?Gbyok2pfvo78xbSBk/62eB+nCI40jBeqn7iEc15M4BD9x/Vg0Ne2oe9TZPJK?=
 =?us-ascii?Q?CVIHE4jAGpChSvM3FW05E+VLcIy4RUGJXEVgdCMD3mT9B4mgd63T0wECvIn9?=
 =?us-ascii?Q?24du62VBWT4jBSgTRUcGHqilwy0Bq/V3eOKu0FRSeb9pEOfQHCsHiNDCfodA?=
 =?us-ascii?Q?Y/w8RaSOQWWgVKHlzCfLLpIspEjOSITXCASlFJAppTkcFfbH45V3jtiS26fX?=
 =?us-ascii?Q?dLDcZCPnAS5UrrWZyX1/hycD7UVNenfMWK/efQ0ecxckBeXktE/awRXDZ9q7?=
 =?us-ascii?Q?JR/xlwRs3BIHD1GJoBfsZcPd3eSZ3JC5oelec6JHpDFpNDBQRFjo2suG7m0g?=
 =?us-ascii?Q?gew0c2FebJACvKiN1bRCMhfnZlQzQh0vIN8RxntnAaorcUtJx86KHVtKA3og?=
 =?us-ascii?Q?QEB2uFMYAIrkbPw/QnFkPA+zMA/DXl4cdEtxL9DzdaGKM1yntX1lgEv2rr0K?=
 =?us-ascii?Q?iQcGwn7wnfrbrQ4MU7gSePGCsRU8owxSxvURTiuFpxPdcKQIyrv556i30LjU?=
 =?us-ascii?Q?ckBFH/0VPpi0J9ddYOtUa42rfcBGj1SB0EMGoOk2HsqQ3ra1Bi4kzxDB12ss?=
 =?us-ascii?Q?vvna+yJDPfE4PbTnW+FpnnlR0O/tXKkUIXpipHDIqBs4E6IKwmsb6RXfnjd6?=
 =?us-ascii?Q?U7AMGgqGGVK3Py6GNnWC8sAaUzfEK4aS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73c262b5-cd89-4861-086a-08da0c4cdaff
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2022 21:42:26.0822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ND9chwoSbu4DPm8cPQa4hRXJEgPnONrlExNkqQDU/NVjKULSIAQJqP5t8wCspqND
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5415
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_6851798D-CD15-4D07-AB86-04DA6985BD27_=
Content-Type: text/plain

On 22 Mar 2022, at 12:42, David Hildenbrand wrote:

> On 21.03.22 19:23, Zi Yan wrote:
>> On 21 Mar 2022, at 13:30, David Hildenbrand wrote:
>>
>>> On 17.03.22 16:37, Zi Yan wrote:
>>>> From: Zi Yan <ziy@nvidia.com>
>>>>
>>>> Enable set_migratetype_isolate() to check specified sub-range for
>>>> unmovable pages during isolation. Page isolation is done
>>>> at max(MAX_ORDER_NR_PAEGS, pageblock_nr_pages) granularity, but not all
>>>> pages within that granularity are intended to be isolated. For example,
>>>> alloc_contig_range(), which uses page isolation, allows ranges without
>>>> alignment. This commit makes unmovable page check only look for
>>>> interesting pages, so that page isolation can succeed for any
>>>> non-overlapping ranges.
>>>>
>>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>>> ---
>>>>  include/linux/page-isolation.h | 10 +++++
>>>>  mm/page_alloc.c                | 13 +------
>>>>  mm/page_isolation.c            | 69 ++++++++++++++++++++--------------
>>>>  3 files changed, 51 insertions(+), 41 deletions(-)
>>>>
>>>> diff --git a/include/linux/page-isolation.h b/include/linux/page-isolation.h
>>>> index e14eddf6741a..eb4a208fe907 100644
>>>> --- a/include/linux/page-isolation.h
>>>> +++ b/include/linux/page-isolation.h
>>>> @@ -15,6 +15,16 @@ static inline bool is_migrate_isolate(int migratetype)
>>>>  {
>>>>  	return migratetype == MIGRATE_ISOLATE;
>>>>  }
>>>> +static inline unsigned long pfn_max_align_down(unsigned long pfn)
>>>> +{
>>>> +	return ALIGN_DOWN(pfn, MAX_ORDER_NR_PAGES);
>>>> +}
>>>> +
>>>> +static inline unsigned long pfn_max_align_up(unsigned long pfn)
>>>> +{
>>>> +	return ALIGN(pfn, MAX_ORDER_NR_PAGES);
>>>> +}
>>>> +
>>>>  #else
>>>>  static inline bool has_isolate_pageblock(struct zone *zone)
>>>>  {
>>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>>> index 6de57d058d3d..680580a40a35 100644
>>>> --- a/mm/page_alloc.c
>>>> +++ b/mm/page_alloc.c
>>>> @@ -8937,16 +8937,6 @@ void *__init alloc_large_system_hash(const char *tablename,
>>>>  }
>>>>
>>>>  #ifdef CONFIG_CONTIG_ALLOC
>>>> -static unsigned long pfn_max_align_down(unsigned long pfn)
>>>> -{
>>>> -	return ALIGN_DOWN(pfn, MAX_ORDER_NR_PAGES);
>>>> -}
>>>> -
>>>> -static unsigned long pfn_max_align_up(unsigned long pfn)
>>>> -{
>>>> -	return ALIGN(pfn, MAX_ORDER_NR_PAGES);
>>>> -}
>>>> -
>>>>  #if defined(CONFIG_DYNAMIC_DEBUG) || \
>>>>  	(defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DYNAMIC_DEBUG_MODULE))
>>>>  /* Usage: See admin-guide/dynamic-debug-howto.rst */
>>>> @@ -9091,8 +9081,7 @@ int alloc_contig_range(unsigned long start, unsigned long end,
>>>>  	 * put back to page allocator so that buddy can use them.
>>>>  	 */
>>>>
>>>> -	ret = start_isolate_page_range(pfn_max_align_down(start),
>>>> -				       pfn_max_align_up(end), migratetype, 0);
>>>> +	ret = start_isolate_page_range(start, end, migratetype, 0);
>>>>  	if (ret)
>>>>  		return ret;
>>>
>>> Shouldn't we similarly adjust undo_isolate_page_range()? IOW, all users
>>> of pfn_max_align_down()/pfn_max_align_up(). would be gone from that file
>>> and you can move these defines into mm/page_isolation.c instead of
>>> include/linux/page-isolation.h?
>>
>> undo_isolate_page_range() faces much simpler situation, just needing
>> to unset migratetype. We can just pass pageblock_nr_pages aligned range
>> to it. For start_isolate_page_range(), start and end are also used for
>> has_unmovable_pages() for precise unmovable page identification, so
>> they cannot be pageblock_nr_pages aligned. But for readability and symmetry,
>> yes, I can change undo_isolate_page_range() too.
> Yeah, we should call both with the same range and any extension of the
> range should be handled internally.
>
> I thought about some corner cases, especially once we relax some (CMA)
> alignment thingies -- then, the CMA area might be placed at weird
> locations. I haven't checked to which degree they apply, but we should
> certainly keep them in mind whenever we're extending the isolation range.
>
> We can assume that the contig range we're allocation
> a) Belongs to a single zone
> b) Does not contain any memory holes / mmap holes
>
> Let's double check
>
>
> 1) Different zones in extended range
>
> ...   ZONE A  ][ ZONE B ....
> [ Pageblock X ][ Pageblock Y ][ Pageblock Z ]
> [        MAX_ORDER - 1       ]
>
> We can never create a higher-order page between X and Y, because they
> are in different zones. Most probably we should *not* extend the range
> to cover pageblock X in case the zones don't match.
>
> The same consideration applies to the end of the range, when extending
> the isolation range.
>
> But I wonder if we can have such a zone layout. At least
> mm/page_alloc.c:find_zone_movable_pfns_for_nodes() makes sure to always
> align the start of ZONE_MOVABLE to MAX_ORDER_NR_PAGES. I hope it applies
> to all other zones as well? :/

AFAICT, it is not. Physical page ranges are read from E820 on x86_64 and
put into memblocks, then added to zones. zone ranges are not aligned
during pgdat initialization.

>
> Anyhow, it should be easy to check when isolating/un-isolating. Only
> conditionally extend the range if the zones of both pageblocks match.
>
>
> When eventually growing MAX_ORDER_NR_PAGES further, could we be in
> trouble because we could suddenly span multiple zones with a single
> MAX_ORDER - 1 page? Then we'd have to handle that I guess.

Yes. Good catch. I need to check whether the MAX_ORDER_NR_PAGES aligned
down PFN is in the same zone as the isolation PFN. I will add the check
in the next version.

>
>
> 2) mmap holes
>
> I think that's already covered by the existing __first_valid_page()
> handling.
>
>
> So, I feel like we might have to tackle the zones issue, especially when
> extending MAX_ORDER_NR_PAGES?

Yes. Will add it in the next version.

Great thanks for pointing this out!


--
Best Regards,
Yan, Zi

--=_MailMate_6851798D-CD15-4D07-AB86-04DA6985BD27_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmI6QsAPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhU4SYP/2z9uIxAqXG0mySOUiNH0oUrjmeTQd0ksG4l
yyg3A3WPRb6Lo97d9qlUuovTGzwpx9sK91gHiaEkN5pb6ZO+XtDbL0x8cOmUQq1f
QFpukkezzRb4AssuCAmPOAd3BUuds811MGTpqghem0HWIT9UJYoaxBXTT5s4hWPo
m8lQL6TQWBAOswNsgm8QuxvU/hf+G0esS1dVz/mpWZ3Hl27cc7RtQNeoE1czUcgS
82xN/ZdaoV/XS9klToPiT6oM1bPIT1ZEP6hyNiAB9FdwapZPamrkGky9WgrM01dA
8vzp48JJRbF4I4VmtI5mw85DO8FQ/nsEF91Fyp7jV1mvQV5pL6tylJaY+Dq3OaqP
kn3Oafv9Z8C6RG4rke8TyJvSpbhjMt5LVfh7MinfGI5g5CexnhjqVWkJ/ijm8YqW
gRYFgbTOpD+YTAWtofJOQ1UjD5JoMmNFkAXlxyr8+VWVeOUnnXtwHGTd1qyK8M+V
j09cBJD6KDYz+KWC9xVJURZ0SVJjVdpGMlSwv7fb9sXW1GPfstmEeFUmynuEjC+K
lha1XQtEBtTzP5pKsxTuHYMQqL4jzow3cKqPAaGHNGCuGkxD6sQncjJT034cUvQe
m1w/mdH9f3fxFY1RGHpOgbLLWJLFj73bBdsJTpr+wwNvZl/uNaW3KA9EKdixCDJ1
/7yskYVp
=7P53
-----END PGP SIGNATURE-----

--=_MailMate_6851798D-CD15-4D07-AB86-04DA6985BD27_=--

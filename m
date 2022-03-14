Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 508474D8B37
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 18:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243550AbiCNR7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 13:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241393AbiCNR7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 13:59:48 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2063.outbound.protection.outlook.com [40.107.236.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0FE417045
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 10:58:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eTmsBJfhUfrIpihVAJAgTrUCC9AX84ds1oq56T8FrGHE2PQlKVzba4N0WVEpnYwINIkk8oKFuwjIHaRG5zfhE2MCRt0FFHY77B8Ue+Eo5sT6ezdYPPnf/G6thgBcXZWOjkkBcTpr0xVzo8rD031tOpVJfrHl5PdH7+EpESX6keykXjx3+uXmjvxxLFWSVABJ0oO1ZrjxCmVk0vbR3Kg3w7YmPF2rIQ6ipN6v1ONKjZtqbSchnM34ygs25vjYqt/FsuIFLFmvyh8hW2h4kq4GFt0gEjMKZ2Sxz5Hh5zxMTCXlOWSCKKsPWChE/vtvx7TXKNv3w6dOKulaLZCvlqG7Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KFsnM4uQCbrlClvt8Gu9B8JeBX/j8caCar/v0vxVLyg=;
 b=B2oHOnCRjcrfEGp6ixnohTHCbb/0WgWBxwDlRB2qWTc4retJxgkYWmaxQdyxA6dOEUykWfCYVbtmO9NuAixwzhhBMk+7uCD15H/hNRc8nKBwxH5Z92Iu1X5t1DSmoUrK66M4h1ARwQvTjl+ZI/XJoJu5Y3y83DANEgz5CSVHIE2CWRsqrE1xaWYv5s0W3rRjdgD+mDrkNnPhzBL5flG58ttEdtmtk6b7Z8sObX/X4a8HEkXJwBnf4Fqwi+AosH6GM2SlNnKABPx3Mcloko8ThhUA0LzeNmoUMAGiWSasPQ626nuUVeLR67tBuetBWkI+uwF8PkR3WtG7VqJ3/KP0Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KFsnM4uQCbrlClvt8Gu9B8JeBX/j8caCar/v0vxVLyg=;
 b=BmtV2OfR8v5LNxFkYSkY9lGysbGbmmas8NmJB67pXRm4+8Ky5PsDj01oMTz2z/xoaj1oHZlh5+ZgkDf0AHQrO7ciNsfNo+sW41Nvfh+OIUeWPPzhLbPUOCGtPLb+1agr8UIdKwJ7e5F2pCe/p0FlDHeoqxIDWLmziBoF+e403PmOSOTWJpb8s/ZzH/J4OgTWadF3QSQDYVeiv4Q2SJpTpU1CFiLwRyW4MsZjcM+/HXWt+sGxGSTAvGjtVOdb2t2zBAWitHML6H0puzDBVRYRO+NmonpcCcsdIowhDWye6OM+CmOyG7PeVBHXB+Y+AdrOO7/XMLFJJ6VNO35N/ZyxNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by MN2PR12MB2877.namprd12.prod.outlook.com (2603:10b6:208:ae::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Mon, 14 Mar
 2022 17:58:35 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::40a6:6e1d:b057:a036]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::40a6:6e1d:b057:a036%6]) with mapi id 15.20.5061.028; Mon, 14 Mar 2022
 17:58:35 +0000
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
Subject: Re: [PATCH v7 2/5] mm: page_isolation: check specified range for unmovable pages
Date:   Mon, 14 Mar 2022 13:58:31 -0400
X-Mailer: MailMate (1.14r5870)
Message-ID: <373FA5C0-087A-414F-91F8-4CC75C1DC5F0@nvidia.com>
In-Reply-To: <1623cd68-8437-9404-f183-153741bbf84c@redhat.com>
References: <20220311183656.1911811-1-zi.yan@sent.com>
 <20220311183656.1911811-3-zi.yan@sent.com>
 <1623cd68-8437-9404-f183-153741bbf84c@redhat.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_E63DF5ED-FB85-4359-B875-517A7B6F877D_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL0PR0102CA0055.prod.exchangelabs.com
 (2603:10b6:208:25::32) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c0ef5d20-c872-4be3-41a2-08da05e4427a
X-MS-TrafficTypeDiagnostic: MN2PR12MB2877:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB28778C724D53296388FC406EC20F9@MN2PR12MB2877.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e+Ngd5P7xaR0Ahq/PKRoHQ8U1nrRjIt7DdNzH/nnf1IqJ42o7YLSJuioG2HcSXbofzmURcSoOeo9SFKRv7S2bgMeXr8aed1vsuwhGVxgM0GG7sknPJ5NfLaWidJEB8gKaKR2OYdZzUoIH/Cs13BVNv6JnBHqgZOYJ24wjg2Mxk1zavbcdvR2N6vn7Ft2Qzd4lCrw7CF5WPlQSlWmlWW2gAUxDTMk6cbzVGDcPHeuivhaTJ3buPKdGkcbInGKtB7v+FqITG+Nub5/jMlQ3nNlamCFuSyJv6LJvg1m1TzjNV2I10U0OqD9y8A9UgxunfC2ocnunfI6wyOBH0NaLS+wTnTcp8733Tx82gxIviDID3WXP1FPBvpa0K/koKEy+j24EDI4SW7lLJibBBMyMNAzHYGCjk7HvNPVUz1cPlIJng4UZtz6iavQnWAz2SlqgC4S0RZesh2OviLrj4ARUrApzKGn3y26RaPOFtALhENn2Ng79f8cf1UIYSiVOqBx8LzCyVgH6wsJK9msxYzn1AfQEpHaO5TNGA1cJlh3UvMBqAm/hoxQixQOiTMzLVBphR2Bsl6cQ//5WTpHW0auupy3OPV1Jvkd3W7Yp1h05sMqD8QqTwcm7W6agmpIcDcj2Rh2/kYThJtNXL1WCsPtJtHevjkuuzVuN9n2DtEo+6i4PRQrFNYeBuCfMcvJmzZLBZuAIvJjbVlFK3O89PDnEgX07Xe3yGTm3R/RQAIMwH3kGlU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(54906003)(21480400003)(53546011)(6916009)(316002)(5660300002)(235185007)(2906002)(83380400001)(26005)(2616005)(186003)(6512007)(6666004)(6506007)(86362001)(33964004)(33656002)(508600001)(38100700002)(36756003)(6486002)(8676002)(66946007)(66556008)(66476007)(8936002)(7416002)(4326008)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dm9FZkxFNm1najFqMkkwOXowcWVBOWc2SDRnRTQ4MCtqbWJGaFl1ZXR0SjlR?=
 =?utf-8?B?Q3lTSktQbEM5MXF1WitGdXp3QnpqbDFPM3pTWHhFbFRxZEI4aitjSjhSc2tW?=
 =?utf-8?B?UXBDTmFkckhxVE1WRkRYYnRzcktRS29yTlVLdS8vVG1RNUZyYkFpVEdxdTQ2?=
 =?utf-8?B?TElsOXh5SkdHSlVRalk4TmR3eXdtSU9aL3A4L0x5c3B2OGxNS2d6UWkvN2Nn?=
 =?utf-8?B?elNBWldabXBCYVRWRVVrejlaTkNLZzUrSm1IYlcxUVpyNUthUDVSbC9wS0Rw?=
 =?utf-8?B?cUVtdCt6YllEWlYvVktITjczQm8wRWZZOTRGLzcwQWZZMGxWbjZwQzJ6K2RL?=
 =?utf-8?B?bnRDamRoUHc0K2lXQWNRK28wY1llTTFyMjR6RnFBQ1V4ZVkyZU5TVzg0cC90?=
 =?utf-8?B?cUVQbFJ4RFFRNzhyMTFnSzBheGRHMkJJSVVOa0JLK29SNnFianhieU95TDhj?=
 =?utf-8?B?dlBDS09xY0RMTUVia0RQb05QNnRENTcraHhHME1pald2bkZLTGQ4N1JtVCtr?=
 =?utf-8?B?ZzlGWmFXeXZrOUFPcmt3Z3lWTE1vVmlwOEtMQ3ZQSlRZblpVdW96TW00Y21y?=
 =?utf-8?B?QzdFK0ZZVW9HY081ZU42OTUrcng2NEdNbHRkRWtIdHJUUkR3dEJEeHEwK0pU?=
 =?utf-8?B?SHphNXM0dXJDdmRlVzdSTk5SekF2OHVWVyszTEdkQTlQbXNEdGZuQTZUUUVC?=
 =?utf-8?B?dnJJTUJ5emRhcTJEU3ROdndhTEx3STcrdXRJekFIeDIwdEMzb0tOY0VScCtC?=
 =?utf-8?B?aUtGWjBRWExodTVFS29BYTFyRHhYWjNScGErWWZ5Sk5HajhxYTFHekpQM3VB?=
 =?utf-8?B?L3FDQUlibllVTHFRdkV6cGpoS0FTdkFEeDJsL2dEczVyRHFaOThNV0dhaXln?=
 =?utf-8?B?aTlxaXVHZ2REa2UxYlZ6azUwS1dOZ2xIRkEyV2EyUTRJK0lia01zMDl6a1k5?=
 =?utf-8?B?YTBOdFM0UnNiS2ZpV1dqT2dKejJ2Mmh0MWo4NzNtakVPN28yanAyUUdPQ2U0?=
 =?utf-8?B?THRlcytzamRHMCtjYTk1WVBFRFBxMy9RZ1hLZEN5VEQxUVhycW4xZ0xHN0Jk?=
 =?utf-8?B?S2hEcy9pQkhjMDJaM2ZzMzAwemttWVBpVXdKNjYwYks1NHp1NnhpNThXazBW?=
 =?utf-8?B?dURpcmhCaytucG54R1ZCTkhRZGc4ZVFUaFVZdXllTjRaZ01mOUNXbjJOZlFy?=
 =?utf-8?B?Q2JzNDdZSmNheHZ1RFhQajhwaGxHbWQwWXh0emZialZBVTV0dkIza2hneFFs?=
 =?utf-8?B?QjZhamN5UjNyTE5MYi8ycmY3eko2a085MnRRblNiK01qZUdCZFVnbGNkUjZl?=
 =?utf-8?B?VjN4cUpzcjdIRjZnZkM3SHdFd1pJT1g1VHZ6dW5ud3hGMVZTYVFmYnFWMzN3?=
 =?utf-8?B?MkNYMmhldzg1emJ6b1gwU21CMTVHVUpXTW9jWWx4NjhYTW5jUEdwM0EzTSs1?=
 =?utf-8?B?MnJWUS9MbDZVbmhRd1h4QkQ4SEtJZFBXUk93Q2dzYVJHOHFUalRHcHZSKyty?=
 =?utf-8?B?YndpV094Y25HYzZIWmVXVzUvRkF2c1JJVGZqL0s3eEkwWGZPcWxOd2V5ZTl1?=
 =?utf-8?B?RndqTDE5MFVPclU4cGVjc0V5ejI1d2wwRnZqb2lZdGFZZXZkMFdKNjlqUk9F?=
 =?utf-8?B?WnlFUTJGRFliQXViUWZuQjZBRHpWdVNDOTFBdndKMzJmbDgwVkFaMjdKRndQ?=
 =?utf-8?B?bjAya0RIcURrSzVRVG9pR0JCa0l3TVlUeStsbnhjY3pzd3Y0bXZiVE5rQ2NQ?=
 =?utf-8?B?ajQwcVk4dWJiVVd4ZUxZcU5MU0o3ZVNYQ1V4MzdOUUQ3dmJXRWxjWERvY3Rj?=
 =?utf-8?B?VUJDbjcvWWNqZ0tmSjJXdEc3SUNOSWhUMXpHcG53RGptN2gxVU5nazVDQXNE?=
 =?utf-8?B?bUQxNGs3N2ZjN0o0T2d0VFVGS2ZFbkxGVk8yUTRkNkZXSUpybkNyS2wrQTgv?=
 =?utf-8?Q?qJN2DHcHcJhFKd973xW01BVqJiM3Y04y?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0ef5d20-c872-4be3-41a2-08da05e4427a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2022 17:58:35.3430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QHLghEPX6o9/AVr3nh9h/tykAssCPP5hE8gp4qvuf1dQAnV3vb1Ut3UVwZ2KbeRm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2877
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_E63DF5ED-FB85-4359-B875-517A7B6F877D_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 14 Mar 2022, at 13:13, David Hildenbrand wrote:

> On 11.03.22 19:36, Zi Yan wrote:
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
>>  include/linux/page-isolation.h | 10 ++++++++
>>  mm/page_alloc.c                | 13 +---------
>>  mm/page_isolation.c            | 47 +++++++++++++++++++++------------=
-
>>  3 files changed, 40 insertions(+), 30 deletions(-)
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
>>
>> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
>> index b34f1310aeaa..e0afc3ee8cf9 100644
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
>>   *
>>   * PageLRU check without isolation or lru_lock could race so that
>>   * MIGRATE_MOVABLE block might include unmovable pages. And __PageMov=
able
>> @@ -29,11 +30,14 @@
>>   *
>>   */
>>  static struct page *has_unmovable_pages(struct zone *zone, struct pag=
e *page,
>> -				 int migratetype, int flags)
>> +				 int migratetype, int flags,
>> +				 unsigned long start_pfn, unsigned long end_pfn)
>>  {
>> -	unsigned long iter =3D 0;
>> -	unsigned long pfn =3D page_to_pfn(page);
>> -	unsigned long offset =3D pfn % pageblock_nr_pages;
>> +	unsigned long first_pfn =3D max(page_to_pfn(page), start_pfn);
>> +	unsigned long pfn =3D first_pfn;
>> +	unsigned long last_pfn =3D min(ALIGN(pfn + 1, pageblock_nr_pages), e=
nd_pfn);
>> +
>> +	page =3D pfn_to_page(pfn);
>
> I think we should get rid of the page argument completely. The caller
> should pass in a reasonable [start_pfn, end_pfn) range, and to any
> necessary fixups to the range outside of this function.
>
> The goal should be to have
>
> pfn =3D start_pfn
>
> and replacing last_pfn by end_pfn.
>
>
> Ideally we'd end up with "This function checks whether the range
> [start_pfn, end_pfn) contains unmovable pages or not."
>
>
> What would be missing to achieve that?
>

Sure, I will do that in the next version. Thanks for pointing this out.

The intersection of the pageblock of the =E2=80=9Cpage=E2=80=9D and [star=
t_pfn, end_pfn)
will be moved to set_migratetype_isolate() and the resulting range will
be passed into has_unmovable_pages() to avoid redundant unmovable page ch=
ecks.


--
Best Regards,
Yan, Zi

--=_MailMate_E63DF5ED-FB85-4359-B875-517A7B6F877D_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmIvgkgPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqK9wkP/2DFb6E438J8n3K53HNmUp+bRIvCJd54uTEB
sSSacWuKWPVxHJGxCPvfTvnWeNFgwPEQVx8dHf3Px/RpjmkiSiBJ7BjmYOSseTfD
OcqlY1WDwDSgu3T/myT9hBW8ejEaJt7u43BM+ToCd7V1p27OLpvWLvEtp3uvmtGN
C0nnDTs2wgZj+7MxvZr9cuG9AtC9NXdf2aENEiqX9G+NvObkVI/BIOrOmIkNdL0P
UEigk+8LUDzFQ2UbVYfOcXQd0Wte5dlYOir6HScNZsYJUlGfOu5+nvKxyNVnVYuu
8BEcz4tmMVBHpJ8PSWqxkDKu2IPC70pn+KvE2hKR4/my0L6IWdqbjpuqbUYAlbdy
DWZv5ZIWCjlk9K2OrQf6BYtG2uv7SoXw3oaZyM04pqsFhp27fLgUitjg2VXYQXec
kGsvvOtyFkP7SSRX2j1NwFKVRG1x/cmBTzMZlRnzXs2lFcdA1QWSbWKPjLd4hyt4
Inta/RS/xMqy+R7mSjwKaQg6Wd2OS873H3i/sIDQjyMrZyHKAt6qK8mfJxgOD210
BTW7tRIBAj9LgJiTrNi2HuLLljYlgAEyau4FT+wWRj/9XsJ5tEib5s8pAsvWvYQH
n5UYr4Ol17PLRFQlOTWaANI5LEKLRCHOdi5+ZipJ8j4CrToCoLoPeoUJzIUiXlCM
0zre2uSR
=o0Sr
-----END PGP SIGNATURE-----

--=_MailMate_E63DF5ED-FB85-4359-B875-517A7B6F877D_=--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA7B4FE44B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 17:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356824AbiDLPE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 11:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240667AbiDLPE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 11:04:26 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4984FC6F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 08:02:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U0GI/xG8e8ZJCTcc8i/LUakomQftCy3M9gD6yVL8EDa6VcZgrSLadvwo731ltSnvOhAI46zDaz+UFhhcCqi/denJAXVytIeQq+xbfyNPK8cT5G9+hWJc0xNGVbRkDPQtQHAd/aZmrBAEMjMneTzHuWorZ/0+JZZjdvFHH2s/IDikBj5oXgij2qD3aYuI+T/D376pxdK6zOVUS4aItrvvWg3kVQ6k66PqZBNATKEmKWFw03Hq28ayPncZIFTQbsUSj+M+7151CIyD1arEytEiTgBuuceqrPJv2w1vJqQbkUxv+q6NMFqHVxRuvPlHQtJld7YJediWpIl931YhPq+h7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RF9pGupCt5JJULdMB3OPJi+W78l9MmRANE52uM87jVM=;
 b=mbL0PlNQf+esGpH826b0hqBvJ+CB80bY8sPwiotdz6aAJWbfF9kQ/XEnStAdzmGPQFQnQ4cmZyjBAL0eTet9dFZgWiZgOFgn0zRX98DzhSJ7xNGZds7QyD1zeem1CNCyvdUf8ZylyVW5c+CLYXm6FRDXG5Bw8Fpv5ZxgQuYycuZU2xOqa+M0B41Ge2btmGcu+qS98ielcLrN9OiCezv49VSAW2cU3Ovm9lTqU4fIaf6J4AoFcrmN3lCLFcFIUQdR5oHDdEOzvbEH71HBubOelIHPSewrrGN3NVDRCenm2NkpzL0kci5QvBkZ+yJedMbJqxiKMpq+hZu/WPNEoi7HXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RF9pGupCt5JJULdMB3OPJi+W78l9MmRANE52uM87jVM=;
 b=G7accJcq9UlxLmTX/OLYXon3IZb/p4izokQXdpXzLcqMEFoFFXb2eS1F8g0/ZZXIZd+8c6uqYlZkD6Ap+yW7wdNoFMUKyeR6ya3krtEo2ssBefJrsqRqLtwhzurqEnJWCWRZK2GhYIAdFB+QUjjc/+9hog++7vKPp5qGlDzrB7K6C0SCPjY/rHbWsC0cOpeh5aVbXmNzD7fDKO1Ypcl3yc7v3Zeca5tJNN95qHmRUV6YJ4pQfZE4H6C+44RPLIklf/24vAvtCK1tUi8FDTv45I75tUP92nXzijXxO2sBY36JC7icDbTwj5VDHlZY2HW7BzawaVPVcTb3SxW9GGoFrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by DM6PR12MB3707.namprd12.prod.outlook.com (2603:10b6:5:1c1::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 15:02:05 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::69f1:dff6:826b:7d9c]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::69f1:dff6:826b:7d9c%5]) with mapi id 15.20.5144.030; Tue, 12 Apr 2022
 15:02:05 +0000
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
Date:   Tue, 12 Apr 2022 11:01:36 -0400
X-Mailer: MailMate (1.14r5870)
Message-ID: <B4336C2E-E728-49E2-B84B-5728B9A1EA69@nvidia.com>
In-Reply-To: <428828e1-6b59-8db7-62e0-1429863cb13f@redhat.com>
References: <20220406151858.3149821-1-zi.yan@sent.com>
 <20220406151858.3149821-3-zi.yan@sent.com>
 <ccae12f9-a452-95a8-f404-3398dcdf5bdf@redhat.com>
 <039317AF-985C-43D7-BB99-714DD6022B5C@nvidia.com>
 <428828e1-6b59-8db7-62e0-1429863cb13f@redhat.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_77CAFF19-22EA-4F06-AA4A-AA2D5CB8B923_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR05CA0060.namprd05.prod.outlook.com
 (2603:10b6:208:236::29) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71a38118-bfa6-4ab6-5949-08da1c95686e
X-MS-TrafficTypeDiagnostic: DM6PR12MB3707:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3707297C054E0B3D93A44484C2ED9@DM6PR12MB3707.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Td5scZ2GwY3s8bhRnaiMmmXRlMPF4bNF4MpoB791MbVqRYdQC6boU7A2ZpzWI34zJSC2kQcCBRHMYdA2F3aBWozhOo7yaD0saiIimx6OkGaTIK/gB2JMTZjUycc4iIO3nRVwow5KxzA729ikcLC48jpQLDVVBBBi69KcN9zi+j2UF9HVS8c06oLc4qztXRNTrxS7GyHCkJhTsNU3xnDIRCkXp8topKqaXh3+k3K1sapvQsDJS/QWsqDJ3nYujNfICOQbEpPSsnGU2dxIoe+LibA/8EBv2VvH9nfUJ7HGzzK2gIEf4k5J8fE0p+/7KYQUOdrby+IrsroCz/6GY8wseCIcOI20NOUnN3Ihya0RFG/cM4OBBX6QLO8RgT3l59L6OnkjnBSoPNlLOtwZLDANejrpBjUXhFg0YAUcWNip/+VjPQqI/IFjBHTXjcdmwy+6OdQkthObSGPtrQ9HgWC6Q6/Pd4sUPxFTLkfSS1RV+xFwfCip1Qcyy7m6sOUJhY33cnCUR0nkpThk+PpomHfjC+lfMqqaKgoLEdDMvcBeLVITWNwgfxbGWsoCAMgls5mUnTQDbLi+rqcxSLb8A/C1sOVYZyfoce0UiVkKaSGoZ5qOlGicg4GTQGbuVbKL+duLOCAsAgWbFtzYA+9HNoohlmYb4XGw1XFVJtMkjIN60EZlGE5nCMkbnIwF2j4AOiEx/dyn9tlGtQuCxKJZXy4/tqh7oM7mPvfv3AlwNTfmoks=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(8936002)(66556008)(38100700002)(508600001)(6486002)(6506007)(30864003)(5660300002)(7416002)(66946007)(4326008)(316002)(54906003)(8676002)(235185007)(66476007)(21480400003)(186003)(26005)(6916009)(83380400001)(6666004)(2616005)(6512007)(53546011)(36756003)(33656002)(2906002)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?STt9kts+K55r81P9T+YntlJtt7yYg2ys0/fX1OIAucZSSh0DpuK5ZGmdU5fl?=
 =?us-ascii?Q?dSD2P2cvbkEHN42DNboHxAME96/tXPk/XKvLkuSKSGUn15iBeVk1rbxI9EMb?=
 =?us-ascii?Q?3lMjbkHf/5og73ZH9BC2vqeiedrfODRsDuqcMueShbGRb1VZqrzvwkXDQh0L?=
 =?us-ascii?Q?VC7OkpaZzklIdt/PiHPWYvh/6r+aGunqQ4Tqj3KAtKayKPcePg3iGT+EU4IH?=
 =?us-ascii?Q?URYQ2PEhpik7jp0xqKTC9BkakEcINoj50Mfu1BOdNVY4Icpe4gnTRrO3AOPZ?=
 =?us-ascii?Q?Fb/yjP39yxKVqh4s+Ch+5F3i3DYZ/HLDW9cWBPP5s8eyqwV95hI24gDY/Bzj?=
 =?us-ascii?Q?7HbyNbkD6CS8o6nnkIIK0FX5qzOKlFE2Eq1ocgoh5FQ2dtuMa6zZZzLewx2n?=
 =?us-ascii?Q?8aLIet52pyu3TM1EspMozP2D6AZdwD7iZtEaClu6OO90Nsx/iNkFTT9nRGWX?=
 =?us-ascii?Q?F+Ftd7cqzXrb8TyScqrEW6YG5qIbwLN1H7gLA7weEi8N/6x7M/+GFoI3uZCY?=
 =?us-ascii?Q?yul5W6DOAitkP+ZWWspMi05Pi+3NSUin5GNjuyLNgbYNorbCeyMwQOpeKAZW?=
 =?us-ascii?Q?2222bzNDxo5cS2i10bNgY+jraIgtwhndQT2F1CGdUERILI3y+d4eus6bgYqA?=
 =?us-ascii?Q?lTPd9xIfolWyFnyoUPEkRboHBI1XH7jLy8VInF4M6JbPxv6q+19RFhC9hxwQ?=
 =?us-ascii?Q?JOqb5a+seODIZbiNdy3fyaCLM2OfVQa1tC6eySSUgwW/UVsiWhe16ZLP4ujx?=
 =?us-ascii?Q?K0SLQ1XmeHDv3gn5WLlkOc/ppvMbHMfllokJN8Vqwv31nqBFB3r2ewuN5e1F?=
 =?us-ascii?Q?pOmxUnTlpu6Yz0lvqDS/AMwaCEp4dW+TCUYadYbuDpnkSIBACSsz5c7g6nFx?=
 =?us-ascii?Q?KHjuEL+S989qDBM0o/f3wfBlQEazFKau63hUNZxMsV7KhLhDKDMuMYKKlm7e?=
 =?us-ascii?Q?mk1/K2AKduVc2G1TrFzCaqGQi48vhyS8aBv+CEnintJHGtkty+Q3iJWPhClM?=
 =?us-ascii?Q?Kf9QCf3JJHrbcQZQfN094BRukRNW4yjwK7zVrYBN9yMofKG2vgiveKHqYHVe?=
 =?us-ascii?Q?Xeb+cFujgPT6pGXgAIjxuKn/6H8XvYr1bdn0l1ZarWLIcBXqvd4bbhxNjAjm?=
 =?us-ascii?Q?7kkHlIwqaNr4QekOQ3a7iHDV02r+gnxsXJ7ncDn75dxbDu1j+nAj05+1/jK0?=
 =?us-ascii?Q?EHqHLf6TLbt9TX8I48YhpNOZlw2ra+6t6FAPfD0MWRE3ZqID/UJYxMBJrLbw?=
 =?us-ascii?Q?Awu2GBnvKSWS+IsK3WBe8WnaIcmlSsKX5cd6Lk1+N9kGnrvdKvZWO2bSz2xR?=
 =?us-ascii?Q?7istzCvtoFPU7HpOztEUsLWMDepRI2Buta5cgpYCTnaYeRKqIIIfqh9mcRhd?=
 =?us-ascii?Q?JI/4qxFm8++1VhEs9brUgNVB02l3yMjCnlFKTYtzx1LtYDvgz3SimuAKlnwy?=
 =?us-ascii?Q?pGQRnhhSAa0n2jqbp+JeXLdKwjhzBTnvCkev2SThaBF0nv3CXngoNHr6KBoE?=
 =?us-ascii?Q?1NzNoluKfRay/9bhV7QUi/PZxqd6ulgCMsblyI5tLkuB6z1J/fkZhQPSSbnX?=
 =?us-ascii?Q?nRNU8arwKdBTeYOFNQxnm5sZ5j8hlxGRxPYi4bVsiT9emoN0tZvWiBSdZdPF?=
 =?us-ascii?Q?C+Vb5lt0q3G16/rYUIxyvbhYszm+eZxBymIc+Vy6qLFo7DJTAuzNu/oqcyi7?=
 =?us-ascii?Q?C0y/YUt3YYxgpXri+AM2vOqqVqIzl0UfL7jz9SOlhHSS1FHfLN5NWw7q/7Ul?=
 =?us-ascii?Q?LFC+EJOXPQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71a38118-bfa6-4ab6-5949-08da1c95686e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2022 15:02:05.5988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qrUlJxT8CFqKPRZcraVck97n9ZFJ0PFa+/eQD+KKfR9WjaDa/lu7idjB3G4I2T5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3707
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_77CAFF19-22EA-4F06-AA4A-AA2D5CB8B923_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 12 Apr 2022, at 10:49, David Hildenbrand wrote:

> On 12.04.22 16:07, Zi Yan wrote:
>> On 12 Apr 2022, at 9:10, David Hildenbrand wrote:
>>
>>> On 06.04.22 17:18, Zi Yan wrote:
>>>> From: Zi Yan <ziy@nvidia.com>
>>>>
>>>> Enable set_migratetype_isolate() to check specified sub-range for
>>>> unmovable pages during isolation. Page isolation is done
>>>> at MAX_ORDER_NR_PAEGS granularity, but not all pages within that
>>>> granularity are intended to be isolated. For example,
>>>> alloc_contig_range(), which uses page isolation, allows ranges witho=
ut
>>>> alignment. This commit makes unmovable page check only look for
>>>> interesting pages, so that page isolation can succeed for any
>>>> non-overlapping ranges.
>>>>
>>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>>> ---
>>>
>>> [...]
>>>
>>>>  /*
>>>> - * This function checks whether pageblock includes unmovable pages =
or not.
>>>> + * This function checks whether the range [start_pfn, end_pfn) incl=
udes
>>>> + * unmovable pages or not. The range must fall into a single pagebl=
ock and
>>>> + * consequently belong to a single zone.
>>>>   *
>>>>   * PageLRU check without isolation or lru_lock could race so that
>>>>   * MIGRATE_MOVABLE block might include unmovable pages. And __PageM=
ovable
>>>> @@ -28,12 +30,14 @@
>>>>   * cannot get removed (e.g., via memory unplug) concurrently.
>>>>   *
>>>>   */
>>>> -static struct page *has_unmovable_pages(struct zone *zone, struct p=
age *page,
>>>> -				 int migratetype, int flags)
>>>> +static struct page *has_unmovable_pages(unsigned long start_pfn, un=
signed long end_pfn,
>>>> +				int migratetype, int flags)
>>>>  {
>>>> -	unsigned long iter =3D 0;
>>>> -	unsigned long pfn =3D page_to_pfn(page);
>>>> -	unsigned long offset =3D pfn % pageblock_nr_pages;
>>>> +	unsigned long pfn =3D start_pfn;
>>>> +	struct page *page =3D pfn_to_page(pfn);
>>>
>>>
>>> Just do
>>>
>>> struct page *page =3D pfn_to_page(start_pfn);
>>> struct zone *zone =3D page_zone(page);
>>>
>>> here. No need to lookup the zone again in the loop because, as you
>>> document "must ... belong to a single zone.".
>>>
>>> Then, there is also no need to initialize "pfn" here. In the loop hea=
der
>>> is sufficient.
>>>
>>
>> Sure.
>>
>>>> +
>>>> +	VM_BUG_ON(ALIGN_DOWN(start_pfn, pageblock_nr_pages) !=3D
>>>> +		  ALIGN_DOWN(end_pfn - 1, pageblock_nr_pages));
>>>>
>>>>  	if (is_migrate_cma_page(page)) {
>>>>  		/*
>>>> @@ -47,8 +51,11 @@ static struct page *has_unmovable_pages(struct zo=
ne *zone, struct page *page,
>>>>  		return page;
>>>>  	}
>>>>
>>>> -	for (; iter < pageblock_nr_pages - offset; iter++) {
>>>> -		page =3D pfn_to_page(pfn + iter);
>>>> +	for (pfn =3D start_pfn; pfn < end_pfn; pfn++) {
>>>> +		struct zone *zone;
>>>> +
>>>> +		page =3D pfn_to_page(pfn);
>>>> +		zone =3D page_zone(page);
>>>>
>>>>  		/*
>>>>  		 * Both, bootmem allocations and memory holes are marked
>>>> @@ -85,7 +92,7 @@ static struct page *has_unmovable_pages(struct zon=
e *zone, struct page *page,
>>>>  			}
>>>>
>>>>  			skip_pages =3D compound_nr(head) - (page - head);
>>>> -			iter +=3D skip_pages - 1;
>>>> +			pfn +=3D skip_pages - 1;
>>>>  			continue;
>>>>  		}
>>>>
>>>> @@ -97,7 +104,7 @@ static struct page *has_unmovable_pages(struct zo=
ne *zone, struct page *page,
>>>>  		 */
>>>>  		if (!page_ref_count(page)) {
>>>>  			if (PageBuddy(page))
>>>> -				iter +=3D (1 << buddy_order(page)) - 1;
>>>> +				pfn +=3D (1 << buddy_order(page)) - 1;
>>>>  			continue;
>>>>  		}
>>>>
>>>> @@ -134,11 +141,18 @@ static struct page *has_unmovable_pages(struct=
 zone *zone, struct page *page,
>>>>  	return NULL;
>>>>  }
>>>>
>>>> -static int set_migratetype_isolate(struct page *page, int migratety=
pe, int isol_flags)
>>>> +/*
>>>> + * This function set pageblock migratetype to isolate if no unmovab=
le page is
>>>> + * present in [start_pfn, end_pfn). The pageblock must intersect wi=
th
>>>> + * [start_pfn, end_pfn).
>>>> + */
>>>> +static int set_migratetype_isolate(struct page *page, int migratety=
pe, int isol_flags,
>>>> +			unsigned long start_pfn, unsigned long end_pfn)
>>>
>>> I think we might be able do better, eventually not passing start_pfn =
at
>>> all. Hmm.
>>
>> IMHO, having start_pfn and end_pfn in the parameter list would make th=
e
>> interface easier to understand. Otherwise if we remove start_pfn,
>> the caller needs to adjust @page to be within the range of [start_pfn,=

>> end_pfn)
>>
>>>
>>> I think we want to pull out the
>>> start_isolate_page_range()/undo_isolate_page_range() interface change=

>>> into a separate patch.
>>
>> You mean a patch just adding
>>
>> unsigned long isolate_start =3D pfn_max_align_down(start_pfn);
>> unsigned long isolate_end =3D pfn_max_align_up(end_pfn);
>>
>> in start_isolate_page_range()/undo_isolate_page_range()?
>>
>> Yes I can do that.
>
> I think we have to be careful with memory onlining/offlining. There are=

> corner cases where we get called with only pageblock alignment and
> must not adjust the range.

In the patch below, you added a new set of start_isolate_pageblocks()
and undo_isolate_pageblocks(), where start_isolate_pageblocks() still
calls set_migratetype_isolate() and noted their range should not be
adjusted. But in my patch, set_migratetype_isolate() adjusts
the range for has_unmovable_pages() check. Do you mean
start_isolate_pageblocks() should call a different version of
set_migratetype_isolate() without range adjustment? That can be done
with an additional parameter in start_isolate_page_range(), like
bool strict, right?


>
>
> Something like this as a base for the next cleanups/extensions:
>
>
> From 18d29b53600d6d0d6ac87cdc6b7517e989fa3dac Mon Sep 17 00:00:00 2001
> From: David Hildenbrand <david@redhat.com>
> Date: Tue, 12 Apr 2022 15:51:50 +0200
> Subject: [PATCH] mm: page-isolation: Move alignment logic into
>  start_isolate_page_range()/undo_isolate_page_range()
>
> For ordinary range allocations, we actually have to isolate all pageblo=
cks
> in a MAX_ORDER - 1 range. Only memory onlining/offlining is special: it=

> knows exactly which pageblocks to isolate/unisolate and we must not mes=
s
> with the pageblocks to isolate (memory onlining/offlining alwayes passe=
d
> MAX_ORDER - 1 - aligned ranges, unless we're dealing with vmemmap
> located on hotplugged memory, whereby the start pfn might only be
> pageblock aligned).
>
> Further, for ordinary allcoations, we'll want to know the exact range
> we want to allocate -- to check only that range for unmovable pages.
> Right now we lose that information.
>
> So let's move the alignment logic into start_isolate_page_range() /
> undo_isolate_page_range(), such that we have the actual range of
> interest available and the alignment logic contained in there.
>
> Provide start_isolate_pageblocks()/undo_isolate_pageblocks() for memory=

> onlining/offlining.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  include/linux/page-isolation.h | 23 ++++-----
>  mm/memory_hotplug.c            |  8 ++--
>  mm/page_alloc.c                | 15 +-----
>  mm/page_isolation.c            | 85 ++++++++++++++++++++++++++--------=

>  4 files changed, 81 insertions(+), 50 deletions(-)
>
> diff --git a/include/linux/page-isolation.h b/include/linux/page-isolat=
ion.h
> index e14eddf6741a..8e9e9e80ba67 100644
> --- a/include/linux/page-isolation.h
> +++ b/include/linux/page-isolation.h
> @@ -37,20 +37,15 @@ void set_pageblock_migratetype(struct page *page, i=
nt migratetype);
>  int move_freepages_block(struct zone *zone, struct page *page,
>  				int migratetype, int *num_movable);
>
> -/*
> - * Changes migrate type in [start_pfn, end_pfn) to be MIGRATE_ISOLATE.=

> - */
> -int
> -start_isolate_page_range(unsigned long start_pfn, unsigned long end_pf=
n,
> -			 unsigned migratetype, int flags);
> -
> -/*
> - * Changes MIGRATE_ISOLATE to MIGRATE_MOVABLE.
> - * target range is [start_pfn, end_pfn)
> - */
> -void
> -undo_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn=
,
> -			unsigned migratetype);
> +int start_isolate_page_range(unsigned long start_pfn, unsigned long en=
d_pfn,
> +			     unsigned migratetype, int flags);
> +int start_isolate_pageblocks(unsigned long start_pfn, unsigned long en=
d_pfn,
> +			     unsigned migratetype, int flags);
> +
> +void undo_isolate_page_range(unsigned long start_pfn, unsigned long en=
d_pfn,
> +			     unsigned migratetype);
> +void undo_isolate_pageblocks(unsigned long start_pfn, unsigned long en=
d_pfn,
> +			     unsigned migratetype);
>
>  /*
>   * Test all pages in [start_pfn, end_pfn) are isolated or not.
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 416b38ca8def..fb7f63c800d1 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1089,7 +1089,7 @@ int __ref online_pages(unsigned long pfn, unsigne=
d long nr_pages,
>
>  	/*
>  	 * Fixup the number of isolated pageblocks before marking the section=
s
> -	 * onlining, such that undo_isolate_page_range() works correctly.
> +	 * onlining, such that undo_isolate_pageblocks() works correctly.
>  	 */
>  	spin_lock_irqsave(&zone->lock, flags);
>  	zone->nr_isolate_pageblock +=3D nr_pages / pageblock_nr_pages;
> @@ -1113,7 +1113,7 @@ int __ref online_pages(unsigned long pfn, unsigne=
d long nr_pages,
>  		build_all_zonelists(NULL);
>
>  	/* Basic onlining is complete, allow allocation of onlined pages. */
> -	undo_isolate_page_range(pfn, pfn + nr_pages, MIGRATE_MOVABLE);
> +	undo_isolate_pageblocks(pfn, pfn + nr_pages, MIGRATE_MOVABLE);
>
>  	/*
>  	 * Freshly onlined pages aren't shuffled (e.g., all pages are placed =
to
> @@ -1834,7 +1834,7 @@ int __ref offline_pages(unsigned long start_pfn, =
unsigned long nr_pages,
>  	lru_cache_disable();
>
>  	/* set above range as isolated */
> -	ret =3D start_isolate_page_range(start_pfn, end_pfn,
> +	ret =3D start_isolate_pageblocks(start_pfn, end_pfn,
>  				       MIGRATE_MOVABLE,
>  				       MEMORY_OFFLINE | REPORT_FAILURE);
>  	if (ret) {
> @@ -1937,7 +1937,7 @@ int __ref offline_pages(unsigned long start_pfn, =
unsigned long nr_pages,
>
>  failed_removal_isolated:
>  	/* pushback to free area */
> -	undo_isolate_page_range(start_pfn, end_pfn, MIGRATE_MOVABLE);
> +	undo_isolate_pageblocks(start_pfn, end_pfn, MIGRATE_MOVABLE);
>  	memory_notify(MEM_CANCEL_OFFLINE, &arg);
>  failed_removal_pcplists_disabled:
>  	lru_cache_enable();
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index badc05fc1b2f..76f8c19e37a2 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8950,15 +8950,6 @@ void *__init alloc_large_system_hash(const char =
*tablename,
>  }
>
>  #ifdef CONFIG_CONTIG_ALLOC
> -static unsigned long pfn_max_align_down(unsigned long pfn)
> -{
> -	return ALIGN_DOWN(pfn, MAX_ORDER_NR_PAGES);
> -}
> -
> -static unsigned long pfn_max_align_up(unsigned long pfn)
> -{
> -	return ALIGN(pfn, MAX_ORDER_NR_PAGES);
> -}
>
>  #if defined(CONFIG_DYNAMIC_DEBUG) || \
>  	(defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DYNAMIC_DEBUG_MODULE))=

> @@ -9104,8 +9095,7 @@ int alloc_contig_range(unsigned long start, unsig=
ned long end,
>  	 * put back to page allocator so that buddy can use them.
>  	 */
>
> -	ret =3D start_isolate_page_range(pfn_max_align_down(start),
> -				       pfn_max_align_up(end), migratetype, 0);
> +	ret =3D start_isolate_page_range(start, end, migratetype, 0);
>  	if (ret)
>  		return ret;
>
> @@ -9186,8 +9176,7 @@ int alloc_contig_range(unsigned long start, unsig=
ned long end,
>  		free_contig_range(end, outer_end - end);
>
>  done:
> -	undo_isolate_page_range(pfn_max_align_down(start),
> -				pfn_max_align_up(end), migratetype);
> +	undo_isolate_page_range(start, end, migratetype);
>  	return ret;
>  }
>  EXPORT_SYMBOL(alloc_contig_range);
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index b34f1310aeaa..7c1f7724c5bb 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -15,6 +15,16 @@
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/page_isolation.h>
>
> +static unsigned long pfn_max_align_down(unsigned long pfn)
> +{
> +	return ALIGN_DOWN(pfn, MAX_ORDER_NR_PAGES);
> +}
> +
> +static unsigned long pfn_max_align_up(unsigned long pfn)
> +{
> +	return ALIGN(pfn, MAX_ORDER_NR_PAGES);
> +}
> +
>  /*
>   * This function checks whether pageblock includes unmovable pages or =
not.
>   *
> @@ -262,12 +272,40 @@ __first_valid_page(unsigned long pfn, unsigned lo=
ng nr_pages)
>  	return NULL;
>  }
>
> +/*
> + * Make page-allocation-type of pageblocks to be MIGRATE_ISOLATE.
> + *
> + * Most users should actually use start_isolate_page_range(). Only mem=
ory
> + * onlining/offlining that knows exactly what it's doing in regard to
> + * isolating only some pageblocks of MAX_ORDER - 1 pages (for the vmem=
map)
> + * should use this interface.
> + */
> +int start_isolate_pageblocks(unsigned long start_pfn, unsigned long en=
d_pfn,
> +			     unsigned migratetype, int flags)
> +{
> +	unsigned long pfn;
> +	struct page *page;
> +
> +	BUG_ON(!IS_ALIGNED(start_pfn, pageblock_nr_pages));
> +	BUG_ON(!IS_ALIGNED(end_pfn, pageblock_nr_pages));
> +
> +	for (pfn =3D start_pfn;
> +	     pfn < end_pfn;
> +	     pfn +=3D pageblock_nr_pages) {
> +		page =3D __first_valid_page(pfn, pageblock_nr_pages);
> +		if (page && set_migratetype_isolate(page, migratetype, flags)) {
> +			undo_isolate_pageblocks(start_pfn, pfn, migratetype);
> +			return -EBUSY;
> +		}
> +	}
> +	return 0;
> +}
> +
>  /**
>   * start_isolate_page_range() - make page-allocation-type of range of =
pages to
>   * be MIGRATE_ISOLATE.
>   * @start_pfn:		The lower PFN of the range to be isolated.
>   * @end_pfn:		The upper PFN of the range to be isolated.
> - *			start_pfn/end_pfn must be aligned to pageblock_order.
>   * @migratetype:	Migrate type to set in error recovery.
>   * @flags:		The following flags are allowed (they can be combined in
>   *			a bit mask)
> @@ -306,29 +344,23 @@ __first_valid_page(unsigned long pfn, unsigned lo=
ng nr_pages)
>  int start_isolate_page_range(unsigned long start_pfn, unsigned long en=
d_pfn,
>  			     unsigned migratetype, int flags)
>  {
> -	unsigned long pfn;
> -	struct page *page;
> -
> -	BUG_ON(!IS_ALIGNED(start_pfn, pageblock_nr_pages));
> -	BUG_ON(!IS_ALIGNED(end_pfn, pageblock_nr_pages));
> +	start_pfn =3D =3D pfn_max_align_down(start_pfn);
> +	end_pfn =3D pfn_max_align_up(end_pfn);
>
> -	for (pfn =3D start_pfn;
> -	     pfn < end_pfn;
> -	     pfn +=3D pageblock_nr_pages) {
> -		page =3D __first_valid_page(pfn, pageblock_nr_pages);
> -		if (page && set_migratetype_isolate(page, migratetype, flags)) {
> -			undo_isolate_page_range(start_pfn, pfn, migratetype);
> -			return -EBUSY;
> -		}
> -	}
> -	return 0;
> +	return start_isolate_pageblocks(start_pfn, end_pfn, migratetype, flag=
s);
>  }
>
>  /*
> - * Make isolated pages available again.
> + * Make isolated pageblocks, isolated via start_isolate_pageblocks, av=
ailable
> + * again.
> + *
> + * Most users should actually use undo_isolate_page_range(). Only memo=
ry
> + * onlining/offlining that knows exactly what it's doing in regard to
> + * isolating only some pageblocks of MAX_ORDER - 1 pages (for the vmem=
map)
> + * should use this interface.
>   */
> -void undo_isolate_page_range(unsigned long start_pfn, unsigned long en=
d_pfn,
> -			    unsigned migratetype)
> +void undo_isolate_pageblocks(unsigned long start_pfn, unsigned long en=
d_pfn,
> +			     unsigned migratetype)
>  {
>  	unsigned long pfn;
>  	struct page *page;
> @@ -345,6 +377,21 @@ void undo_isolate_page_range(unsigned long start_p=
fn, unsigned long end_pfn,
>  		unset_migratetype_isolate(page, migratetype);
>  	}
>  }
> +
> +/*
> + * Make isolated pageblocks, isolated via start_isolate_page_range(), =
available
> + * again. The pageblock isolation range will be extended just like for=

> + * start_isolate_page_range().
> + */
> +void undo_isolate_page_range(unsigned long start_pfn, unsigned long en=
d_pfn,
> +			     unsigned migratetype)
> +{
> +	start_pfn =3D =3D pfn_max_align_down(start_pfn);
> +	end_pfn =3D pfn_max_align_up(end_pfn);
> +
> +	return undo_isolate_pageblocks(start_pfn, end_pfn, migratetype);
> +}
> +
>  /*
>   * Test all pages in the range is free(means isolated) or not.
>   * all pages in [start_pfn...end_pfn) must be in the same zone.
> -- =

> 2.35.1
>
>
>
> -- =

> Thanks,
>
> David / dhildenb


--
Best Regards,
Yan, Zi

--=_MailMate_77CAFF19-22EA-4F06-AA4A-AA2D5CB8B923_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmJVlFAPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUDz0P/RJ/acqFWTz5pvwtFpsOYMKtbK0vdqxPxkIW
Pr32Ney0UZaEuKExU/tit+/I04AaeapxJM/87sNgQu2+QesCueNbsbeaV65N6fuk
HJI861/tooBZrFOeYbMz8sQQLHsR4dQG5lcJGrviU1Wa7ovxHKJsp9mcGavbKGtY
Yrd97gzdEotdo1APmdf6QhGTvv8aCYHU5QZAHSTfqXbmbaA4SkEg7+2c8f8DSb28
Fr7D18lX12ceB49FDtT/l/loD2G4F9NZjF4CG/ueSGgHEWQQAg3BLvQAy3xDE0jg
zigL8TewpDNdEhUF5/isUIqcPBxeXRwPWteCBLsjgt0/S2uskSEl7ouXRQEECL+K
Ued78HilHc1GvyDT8w3junQKtGvknSN4IT6h0TrPco++ne/PmNN8zBUG+LqYGCEi
Wm5FWgFENrwMnKkbFdA2PuFOwcaCd7Og658YhZYwuCG/TAD/naeQy5yOutuiZWNN
hLtVQ+CCyaLgYc5IDW9cA/UiP69MIZJ7Fbv2WFmPjdhc9DsiSXgHBstCMPyLD03m
pd5pPB2xXM2G5i9y2tXseqSuE3omaDerunT4sWXY8SUuUn1sVKq0PBBApUpzpT1y
xm5onwI98TKrfs6rgoecCDtwwwoCVHY+2ZVu7Q/jeRTjuQm42tTZS0JNsCxb7WSk
jzgQXxRA
=6n6q
-----END PGP SIGNATURE-----

--=_MailMate_77CAFF19-22EA-4F06-AA4A-AA2D5CB8B923_=--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFCE4FE767
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 19:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358513AbiDLRoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 13:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbiDLRoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 13:44:05 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2051.outbound.protection.outlook.com [40.107.236.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD53A5DE49
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 10:41:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SFL23OJfl3gCjuTLxuSamx36mact0qOfeffOWl7s+FSgrqTDJkwnR5J2hU7ali9vf8GAo+X6eN+3//Tmoy3vCO8dn138A604M4EoEOfLIxBtYiBbEoFjefEPg1KMOh5I5oPEsY3N5swizY/f01W6F20+q/9PrFW4WfBkf6fryG4bNV3LKHqdaipHjCzeCrVxsx5KNOAiDKn2dBh9vvXAHpYfNi15eb8y9ZeKTIvUlO50CwlfwSfO2ATI2jFc9ZhvveCkHUh0qib+GLTUIQCg3fUTdVku9nEqGkGNnr9/CxR/Q33E2CxNH7E34xeMPXAUHRB8gymvlYSPmFZKA8iQBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=piA8NsGzSebP3Yaidxtd2r1BiMPlLDohl2nK4JScJBw=;
 b=ZO14NNRMiV3laqZCp0A0kIFnj53OfV+XTEVoongyEvyQBGfTwTBwqjxG2bdEYCH9s/SuL0DRag9WS3BfIZbA8V6JG06MKZKwu2X/kUNfdQTYh7RefKkaN7gIz2QGvGkKUxXXXweIhkg7uRG/aL2v4F20f83LBJURJtX2bD1uSq4MSdfg8OS47dUA2jeFiApij7WqTWZgWAf4M2+Ji5XJBTyVwuvAXh1B9s65NVRcEyt8w8ejOyv2kphgXG1uy7unDrV8fdJvjhGQV9pTXkNZ5KmQx2rhkwASneBfv7rK+FT26ZbErDehJTZFECWNA1s+hKqqyeHXChqMI8rA6yWLew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=piA8NsGzSebP3Yaidxtd2r1BiMPlLDohl2nK4JScJBw=;
 b=ivY+w0GpswhGrFUVVb9hPGLK0JH1rM98FkMeeF9Guotgt3TA2wbDLVNV4Cj+ey5m7PYnkVOnrXsu74vaWX58bxeYYlfAd2aF0IYnDQ7yK6LFP0d6TQXQx0FvWx7baUdA4RJdxhXGfmtGCi6ZJ6DWyKi9tJwHG2xRwBzKBwMVkTmnMCLWnlQ2m7bfP+C9muZIadfefMqiZXGFeJQRtqBMIwsxAZVUQxece5nNXJbTXfMUfiNlSWMsnmpd6q9HDBI24GgIwbxmol44v+2MUpeS/suSIHv29tJAyaI/UZVGwxcJXi40bybKw6PqwxnlGrb7clCnTAd7x+7Bw/QptLPPDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.30; Tue, 12 Apr
 2022 17:41:43 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::69f1:dff6:826b:7d9c]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::69f1:dff6:826b:7d9c%5]) with mapi id 15.20.5144.030; Tue, 12 Apr 2022
 17:41:43 +0000
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
Date:   Tue, 12 Apr 2022 13:41:41 -0400
X-Mailer: MailMate (1.14r5870)
Message-ID: <D53C41E3-E934-4577-9286-387AF3DDBE03@nvidia.com>
In-Reply-To: <afa115e6-d2ae-eeff-ba31-f8b2a5715b95@redhat.com>
References: <20220406151858.3149821-1-zi.yan@sent.com>
 <20220406151858.3149821-3-zi.yan@sent.com>
 <ccae12f9-a452-95a8-f404-3398dcdf5bdf@redhat.com>
 <039317AF-985C-43D7-BB99-714DD6022B5C@nvidia.com>
 <428828e1-6b59-8db7-62e0-1429863cb13f@redhat.com>
 <B4336C2E-E728-49E2-B84B-5728B9A1EA69@nvidia.com>
 <afa115e6-d2ae-eeff-ba31-f8b2a5715b95@redhat.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_11EF2232-C3B4-4B30-A2B3-54C367B19DEA_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR10CA0020.namprd10.prod.outlook.com
 (2603:10b6:208:120::33) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fdad591a-a349-43aa-4f03-08da1cabb549
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB475860A82107A7F3C662EF5FC2ED9@BYAPR12MB4758.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VWlYpMTmlciLJzTgfntXjIIsdG8m3oPJSdS4zublqMycdN4uattDQwiQulWjFxTtrtBfkn9vCYblx9r4kP4q6xpSQX3pFkKU0lJ53jtGXDMzsUvyraxHaAIG5SeF/6pgvRGKnb9tBmGlTHVJ3z1dxNtjEFd9gPF+67Y2ccei3QNYH0BbVBxrWwUAA6M5mRK3nrECbYwFg6xqg+QJYhg67dXn+vBllWUAX9uzyg6SzV6i1B7MK0UOmiOtORUECuxExboQ+wf4T+chqkUa6cTcGRUiWEyLqLPO1RGTHj/310+cH7NGxtTZ0oHk4XnF+VoSGh0bjuJ+VNy/rib+VrhwduekpSv+8lssEPi+sk9omTQ7WOQhbRg3A1j/gAjmuyvMPWboDro36v5/l7ARII+39Y8bejQ+AB6j/KEppQ7lHi4GHMg2hVZm1jKsXZAsXsOs4I8vK0yiEH2mFPiCjnLGZozT1IwUugobKW/0nmqdxtfDKRQXJ9BalZ3Av8+QlVU0UE4VJNpfuquT0jBlEpjA/1BJRuGyp6PLO0pRocNC6PVs3sjxSiGehor1xuHvdICm62G2qOdCAIkWtlHW3YMZ6dI684nIzWBZVDNwXqNMUCfFeX6snS8KB13GVYrEm9ot3bj2qxKhZDWh/oD7iEDFXZ2SPsyjS1z17Yoxeoh59f+IvOB6Snm9aQEcYcjJN/K1UjmX8U+mkOqsDcaWpkk+uu/c/IukIWYMj7tK4a64rzQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(66946007)(4326008)(8676002)(66556008)(6486002)(66476007)(6916009)(86362001)(53546011)(5660300002)(508600001)(8936002)(33656002)(7416002)(235185007)(6506007)(26005)(38100700002)(186003)(316002)(54906003)(21480400003)(2906002)(6512007)(83380400001)(36756003)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XZ+9R4wUKLXfFMFgUjuETpu0wPaScRwUF4a/0SkJY/XHUhisujdKLXvJp4zm?=
 =?us-ascii?Q?0kUEbSxjDvDjhT9s/EagsD8YYeqmu5+14TQ5iy0GW1k5eDrxk9lJdugRd3Mv?=
 =?us-ascii?Q?B3hCWgM0P8KjVhf9GGEz/QhmscsYMYXMYb3MxfI536Q36Q+3+zfP5Wzq5qml?=
 =?us-ascii?Q?+7apwLHtfEi3GqWAu8lb/FKwHFIDyJi6qZgWr6/1iDFmL1m587/gnWT9C4Tl?=
 =?us-ascii?Q?xkTXAZ/7di2mB9uWzbmgPAc1mXaMOIqydiT6PnzUrn8nSBnyBoLcKoN+pH3N?=
 =?us-ascii?Q?yTEMpHCsLHLBnzCNS4F+GoHkD2dXSM1nzE7WL3WgbpHypYqwvNR3DrKUgG0T?=
 =?us-ascii?Q?QVCpAVGJSMbOeyefjomZLp4WJRNEppruw+/fRYSUPo9EBXNifxokjqCWMSeN?=
 =?us-ascii?Q?d4j+imEfWS7/DlH016uI3QtEeuOWEL0Rgev6gcB9f/2RKpYPyfauAveLt/YU?=
 =?us-ascii?Q?EvcvrW1rHaJ7ROczpdGDaSEo1HP3Ts823F4nvKJkp7uAv+gsWidwIRcdktL5?=
 =?us-ascii?Q?YiBS9AoW0WfzCOWLS++dUpArr7/9r1f6lew4obgbGrXf99l8o35xx2VuhR9c?=
 =?us-ascii?Q?LtjLEZ8gWgxfEsBf8vtAw6xqeB1P3kYHxKlBbfGiQVWagFFNJk8Veljbq7h5?=
 =?us-ascii?Q?njvWC0jHgActhV3yH1bPaOyM6dw86rGrM/Mz5PE84WFYDPAXlYbVBjtCdgay?=
 =?us-ascii?Q?JeXyvOb20RYTWvRcOwaBt1/jzWA3s3Eca/lHVnvavLlrqAGsOyYivAVAQR0M?=
 =?us-ascii?Q?U5/dNlT1gWb+7lRvYqnATSKoh0wQDSae5JR7OJfYDb2yFcEFNzaNZ0oou9j3?=
 =?us-ascii?Q?O2zgbQx8f6cT7q1P77NJifoIlk7hydI1q2RkJgnGZ9xVTW0/D2nZezOKRaor?=
 =?us-ascii?Q?GUDviaB8yhw2+kInpZuk0GCsBiyWXgoWmeH6r9Jv2W/100pHXztC8WqoOrm2?=
 =?us-ascii?Q?x9BB4BbF1Asd8impzYDxxJpTqsTQhhCYrzXD9eT9ubNyAW7dvxQfKaca0Fl0?=
 =?us-ascii?Q?4aSETCb01SgQxDICEyIK/lb6xxsz+6JZPQnT83EOHnVxI2o3SWZSNzfvVZcJ?=
 =?us-ascii?Q?qB0OKAMuxXXePUOJt9yM1ry/g8nyk9gXmoGR5JueDSimlW4uGFVl1E1WYAjf?=
 =?us-ascii?Q?PlKOIdCJF+f/7l/2R3T9DKsvo/Lo+gvRLio+i7pwRKLoad02mJHzPEH9hY08?=
 =?us-ascii?Q?VoD2h860+s89t6Xe0wdhkThZVpVZN14NbNRqgI4eOF2ZADQKN70UHmIWcLzW?=
 =?us-ascii?Q?L/ISrL2DrHad3/8CZgMkqPaP+0AaOVJUu/Qbgq52WeTlN8FKY3NpIGwqhT07?=
 =?us-ascii?Q?xhdnDYwR/1y31mJfRdUaCZ2B6qnzV5AxEz/ZZYVSPL16BRIVPh/qkAyn7nRJ?=
 =?us-ascii?Q?FdzinWPyjS+76Aghef6bDkJmCfSJuSdf/AYJjGaYRKJi6R5/8KOgi4V+ZHuy?=
 =?us-ascii?Q?OH4TstTQtUIHFqjvW0EVwguvWpRNM2B9ovD/HK/Yl1ckvf4rtnUuWsVehiej?=
 =?us-ascii?Q?gSZOGpi+ahsWrpxzHJ/JNS3xoPl73iIO1YF1CF2ROUZeiJlX/+3dPEIT/Agq?=
 =?us-ascii?Q?mCKD/HS1YEnCYpcoXX59zu0PbzE3f/uFfnUcP6o3ttm5lhOowj6GfOLnI33V?=
 =?us-ascii?Q?h1RHBZouti8DzO32/1qayH0TeqBcv1bBgqpYr94eGE3ULI7b3mFqaljfNnBq?=
 =?us-ascii?Q?zZMtMD7t28dgbcCuLZ68sPyr84nwclaP+lE9BRyErFgf3W8h11nZoBsBe3+q?=
 =?us-ascii?Q?8tAAb/DNjQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdad591a-a349-43aa-4f03-08da1cabb549
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2022 17:41:43.4999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AEToGxLfa107lZeu2jIaF7xbo5iL+XkwWo80PaUXTqhfQkO0gzSvolamy0PTM8ri
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4758
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_11EF2232-C3B4-4B30-A2B3-54C367B19DEA_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 12 Apr 2022, at 11:06, David Hildenbrand wrote:

> On 12.04.22 17:01, Zi Yan wrote:
>> On 12 Apr 2022, at 10:49, David Hildenbrand wrote:
>>
>>> On 12.04.22 16:07, Zi Yan wrote:
>>>> On 12 Apr 2022, at 9:10, David Hildenbrand wrote:
>>>>
>>>>> On 06.04.22 17:18, Zi Yan wrote:
>>>>>> From: Zi Yan <ziy@nvidia.com>
>>>>>>
>>>>>> Enable set_migratetype_isolate() to check specified sub-range for
>>>>>> unmovable pages during isolation. Page isolation is done
>>>>>> at MAX_ORDER_NR_PAEGS granularity, but not all pages within that
>>>>>> granularity are intended to be isolated. For example,
>>>>>> alloc_contig_range(), which uses page isolation, allows ranges wit=
hout
>>>>>> alignment. This commit makes unmovable page check only look for
>>>>>> interesting pages, so that page isolation can succeed for any
>>>>>> non-overlapping ranges.
>>>>>>
>>>>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>>>>> ---
>>>>>
>>>>> [...]
>>>>>
>>>>>>  /*
>>>>>> - * This function checks whether pageblock includes unmovable page=
s or not.
>>>>>> + * This function checks whether the range [start_pfn, end_pfn) in=
cludes
>>>>>> + * unmovable pages or not. The range must fall into a single page=
block and
>>>>>> + * consequently belong to a single zone.
>>>>>>   *
>>>>>>   * PageLRU check without isolation or lru_lock could race so that=

>>>>>>   * MIGRATE_MOVABLE block might include unmovable pages. And __Pag=
eMovable
>>>>>> @@ -28,12 +30,14 @@
>>>>>>   * cannot get removed (e.g., via memory unplug) concurrently.
>>>>>>   *
>>>>>>   */
>>>>>> -static struct page *has_unmovable_pages(struct zone *zone, struct=
 page *page,
>>>>>> -				 int migratetype, int flags)
>>>>>> +static struct page *has_unmovable_pages(unsigned long start_pfn, =
unsigned long end_pfn,
>>>>>> +				int migratetype, int flags)
>>>>>>  {
>>>>>> -	unsigned long iter =3D 0;
>>>>>> -	unsigned long pfn =3D page_to_pfn(page);
>>>>>> -	unsigned long offset =3D pfn % pageblock_nr_pages;
>>>>>> +	unsigned long pfn =3D start_pfn;
>>>>>> +	struct page *page =3D pfn_to_page(pfn);
>>>>>
>>>>>
>>>>> Just do
>>>>>
>>>>> struct page *page =3D pfn_to_page(start_pfn);
>>>>> struct zone *zone =3D page_zone(page);
>>>>>
>>>>> here. No need to lookup the zone again in the loop because, as you
>>>>> document "must ... belong to a single zone.".
>>>>>
>>>>> Then, there is also no need to initialize "pfn" here. In the loop h=
eader
>>>>> is sufficient.
>>>>>
>>>>
>>>> Sure.
>>>>
>>>>>> +
>>>>>> +	VM_BUG_ON(ALIGN_DOWN(start_pfn, pageblock_nr_pages) !=3D
>>>>>> +		  ALIGN_DOWN(end_pfn - 1, pageblock_nr_pages));
>>>>>>
>>>>>>  	if (is_migrate_cma_page(page)) {
>>>>>>  		/*
>>>>>> @@ -47,8 +51,11 @@ static struct page *has_unmovable_pages(struct =
zone *zone, struct page *page,
>>>>>>  		return page;
>>>>>>  	}
>>>>>>
>>>>>> -	for (; iter < pageblock_nr_pages - offset; iter++) {
>>>>>> -		page =3D pfn_to_page(pfn + iter);
>>>>>> +	for (pfn =3D start_pfn; pfn < end_pfn; pfn++) {
>>>>>> +		struct zone *zone;
>>>>>> +
>>>>>> +		page =3D pfn_to_page(pfn);
>>>>>> +		zone =3D page_zone(page);
>>>>>>
>>>>>>  		/*
>>>>>>  		 * Both, bootmem allocations and memory holes are marked
>>>>>> @@ -85,7 +92,7 @@ static struct page *has_unmovable_pages(struct z=
one *zone, struct page *page,
>>>>>>  			}
>>>>>>
>>>>>>  			skip_pages =3D compound_nr(head) - (page - head);
>>>>>> -			iter +=3D skip_pages - 1;
>>>>>> +			pfn +=3D skip_pages - 1;
>>>>>>  			continue;
>>>>>>  		}
>>>>>>
>>>>>> @@ -97,7 +104,7 @@ static struct page *has_unmovable_pages(struct =
zone *zone, struct page *page,
>>>>>>  		 */
>>>>>>  		if (!page_ref_count(page)) {
>>>>>>  			if (PageBuddy(page))
>>>>>> -				iter +=3D (1 << buddy_order(page)) - 1;
>>>>>> +				pfn +=3D (1 << buddy_order(page)) - 1;
>>>>>>  			continue;
>>>>>>  		}
>>>>>>
>>>>>> @@ -134,11 +141,18 @@ static struct page *has_unmovable_pages(stru=
ct zone *zone, struct page *page,
>>>>>>  	return NULL;
>>>>>>  }
>>>>>>
>>>>>> -static int set_migratetype_isolate(struct page *page, int migrate=
type, int isol_flags)
>>>>>> +/*
>>>>>> + * This function set pageblock migratetype to isolate if no unmov=
able page is
>>>>>> + * present in [start_pfn, end_pfn). The pageblock must intersect =
with
>>>>>> + * [start_pfn, end_pfn).
>>>>>> + */
>>>>>> +static int set_migratetype_isolate(struct page *page, int migrate=
type, int isol_flags,
>>>>>> +			unsigned long start_pfn, unsigned long end_pfn)
>>>>>
>>>>> I think we might be able do better, eventually not passing start_pf=
n at
>>>>> all. Hmm.
>>>>
>>>> IMHO, having start_pfn and end_pfn in the parameter list would make =
the
>>>> interface easier to understand. Otherwise if we remove start_pfn,
>>>> the caller needs to adjust @page to be within the range of [start_pf=
n,
>>>> end_pfn)
>>>>
>>>>>
>>>>> I think we want to pull out the
>>>>> start_isolate_page_range()/undo_isolate_page_range() interface chan=
ge
>>>>> into a separate patch.
>>>>
>>>> You mean a patch just adding
>>>>
>>>> unsigned long isolate_start =3D pfn_max_align_down(start_pfn);
>>>> unsigned long isolate_end =3D pfn_max_align_up(end_pfn);
>>>>
>>>> in start_isolate_page_range()/undo_isolate_page_range()?
>>>>
>>>> Yes I can do that.
>>>
>>> I think we have to be careful with memory onlining/offlining. There a=
re
>>> corner cases where we get called with only pageblock alignment and
>>> must not adjust the range.
>>
>> In the patch below, you added a new set of start_isolate_pageblocks()
>> and undo_isolate_pageblocks(), where start_isolate_pageblocks() still
>> calls set_migratetype_isolate() and noted their range should not be
>> adjusted. But in my patch, set_migratetype_isolate() adjusts
>> the range for has_unmovable_pages() check. Do you mean
>
> Right, that's broken in your patch. Memory onlining/offlining behavior
> changed recently when "vmemmap on memory" was added. The start range
> might only be aligned to pageblocks but not MAX_ORDER -1 -- and we must=

> not align u..
>
> The core thing is that there are two types of users: memory offlining
> that knows what it's doing when it aligns to less then MAX_ORDER -1 ,
> and range allocators, that just pass in the range of interest.

Oh, you mean the pfn_max_align_down() and pfn_max_align_up() are wrong
for memory onlining/offlining callers. Got it. And in patch 3, this is
not a concern any more, since we move to pageblock_nr_pages alignment.

>
>> start_isolate_pageblocks() should call a different version of
>> set_migratetype_isolate() without range adjustment? That can be done
>> with an additional parameter in start_isolate_page_range(), like
>> bool strict, right?
>
> Random boolean flags are in general frowned upon ;)

I misunderstood about the alignment	issue. No need for this additional
parameter.

Thanks. Will take your patch and adjust this one based on yours.

I will wait for your reviews on patch 3 and onwards before sending
out a new version.

--
Best Regards,
Yan, Zi

--=_MailMate_11EF2232-C3B4-4B30-A2B3-54C367B19DEA_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmJVudUPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUuh4P/2v+Fu51yErcoIwY+Q5/59xf/9E9CI99cJM4
qspfWXexh9hsi8u7XblHiXwpSPuQWq4oZNCXziyQDN5x0uvuqHPNRCLuK9RwEpwn
kD5u0i7T2GNgNoFaIPYOmyhToonAazp0n6qT1ocOucvkRgvhQkTzWeL4hbMZbgZ+
YV6Ffuckr0ghScIsK0qdwSrtRd3a2PdcDtZmP4ca+RXpDMktAb51unK2a+2obnvf
AzxpQG3/1I9PNZrIJ1EMk5QeAtv+SW4thR312Y2Gg91WJlWFOvTV38CemhSl0OM7
PUvxDA6qhqWccdu1F/0AKXFLdPHpgYfFp2R1vqa0njOsvkoWVseGbp2UDiL9g0P/
kZa3AeqeRQJeivZQ4qsHbWm1aUk5KxdxRYiAmV5onRt3TC8/icZymjpS6h6iaudd
SUovmqN7BpP7KZnqA6XiBxjcbCSRER88WJlkp7txZ1p2ZIr4bINFvMCZYuZJ5WQq
GXjIZHirOTKY5NxGCOlLNJDObAgeTa2i1hELbCNscVsXGq6Mx3+cGOTVWWPiKZtC
gf6jwzf+LxqxcccKZ/XiBDpPJs9AxlGc0+MwsLYUYxNpAT2v97DZMSLx3up/1/eJ
c+RLSpFkF/PkPFD0c1/txVDdv5mOrp59pY61SEz1ZK28chrFp64Ey+GkDPwELllM
N2Qp73Fs
=wYA/
-----END PGP SIGNATURE-----

--=_MailMate_11EF2232-C3B4-4B30-A2B3-54C367B19DEA_=--

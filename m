Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B394ECEF5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 23:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351292AbiC3VpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 17:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351280AbiC3Vo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 17:44:58 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A238C6A411
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 14:43:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e7cjwzYci6+hTRIhWKEMhERmcT8rKNEHXAZ9ozgIvA/cGv6IEL7geeO7uNbcFIetGR3SCxL6LXnm04hTG5PpJjaQ9woW3mFdNv+rNpDaUgt22olP4xDbMCT+/YGVvgTxVvljS//8tE3ZoJaBoZHbEO9jn6Tudg1bTOzZ69rZ8y0UzPec+mQrsfNeu3xjhkta+H/rvmtkiJR9clJ2lz5nK72zGGIQcBBBsLHZjzWBptdImmZJamdXVXziQzOisjczdkgFQwx9WLlVbVxHLtIS5PKd5oyTpQkmuZRiDNiuLXCdPQZNMf6VNnuAnslA9RGhwInXz8aiychSiDgaK2pcMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bgh8b2vtoC+W12Aq6XwpDHeFAYAy3+k4eAKuZTveOB0=;
 b=eAysAueRkvJqaG2pZ4r8KxSRaHbAU37/OKvZxa8cy4U76tI0EoV27D3RyYn4KfS/UqM53nDde6splMoQXVBh3ioGqCLLoVHtGeFBXCQHTymKj5q+asyXVm3kXW8GKL3ZpASjSNMQcHOod3HTiSOe0bPNiTUbbFH44sHuk2l7SlrfmTlOFRoNxGjGp2mAOMyOGcQx57E0UusRXY/lHGSZlCX6bHr3nchmSSX0CiTkJ/+OBdiiOt3Nipx9mAgO1k9JTmrkUjS0jpcXOCCW4WcA5a9+iXavkRM98QLSDF9EGEyP51oi5HBfA79zFOyGMFl1zIcYLafgNYn7Iv8Alj6VLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bgh8b2vtoC+W12Aq6XwpDHeFAYAy3+k4eAKuZTveOB0=;
 b=qgHYrUhhrmS35Vygng+LOZCxo0gYM4EP6zcc8jKkWdPETM5nCU42E1truavj3yaYRDf1Q4fz/buQ6Wj1XUvS93bBWpjOKK6VnfL6FAciVVU0DSmXP1veOq2s/SNxnWEv0bSQLxmn7G1dG3iAGUxtntU+HP+yE5irzCeyXYmGSdHLcNaebCATYdgfPIK42kbDeywOr6HUNH6Kq9wUkrU6H7YF/w34JCaEyDGf1+y8MNTK0AmorRh0uT9sugq70h+ewrMtaVLVxsVikBu9yCL9znahZZtRhyPSNy8rwtNBruGsGV+SjrijcL32ZmVJ9m82SLlhXYeF0tXrjjHHplkppQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by MW2PR12MB2572.namprd12.prod.outlook.com (2603:10b6:907:6::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Wed, 30 Mar
 2022 21:43:07 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::69f1:dff6:826b:7d9c]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::69f1:dff6:826b:7d9c%5]) with mapi id 15.20.5102.023; Wed, 30 Mar 2022
 21:43:07 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [BUG] Crash on x86_32 for: mm: page_alloc: avoid merging non-fallbackable pageblocks with others
Date:   Wed, 30 Mar 2022 17:43:05 -0400
X-Mailer: MailMate (1.14r5870)
Message-ID: <733F211D-9717-46A7-A0A2-40353E12F65A@nvidia.com>
In-Reply-To: <AF9D3EF9-B070-4ADE-A2D3-C466A4A2D125@nvidia.com>
References: <20220330154208.71aca532@gandalf.local.home>
 <CAHk-=whz_8tRNGCr09X59nMW3JBzFLE-g-F-brxd+AkK+RceCw@mail.gmail.com>
 <B7789993-75EC-4F74-B4E6-AF1CC2CBD9D4@nvidia.com>
 <20220330165337.7138810e@gandalf.local.home>
 <AF9D3EF9-B070-4ADE-A2D3-C466A4A2D125@nvidia.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_3164F1AF-856D-4B25-BF74-6C87D860CE21_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL0PR02CA0047.namprd02.prod.outlook.com
 (2603:10b6:207:3d::24) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b880f23a-e68f-4276-b9ac-08da129646d8
X-MS-TrafficTypeDiagnostic: MW2PR12MB2572:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB25728AEBA6F1F58CED0DE9FEC21F9@MW2PR12MB2572.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G9uG/S71pmIrO5hoOiAUHuiD3yWiqHW40pD/VL2RjhfeD2bC7OrfE7eiBwUAjNKzxV0Oo+GlVgQmhxTH3aozEkwg3zhMYGusrSQ3TQQcMU0tlvreQ0/tkX3zQvbtk/9xyDfT/0J6sFC51SsLwMQjzzbQXttAB4+WcDf0/9OeoL0kBvImI+5cEQxJqRgQ5KdrRKrda0++7giFzdMRc0ZThDfly6ZKy/WILF0E0nDB5a4ejgPl9YRQxBfTOwbx5p6Vf7i6E6RUkOqdRgmCS8PDBpuhxt/rxx3i8HOyv6wH6tfdV1jPEZIwv5fd46C0aqET+lX/jv/4ZfMM9s/x4C4LMyHUE1WNbFgLLNqw+2W/LLAhg4jZIzjQ7NRphKbpaWtzcUJKtU3Yx5XCtl26J3Asgas8ajH4opuNKti69Q8HjznsTfhmDoR9kWpMjw8FyCHBYWgDZ/P2L3rbHSnOjQz0moEDADr0VNUUVTxRLhR/PZtsCJa5R21vt5zAUhVAfWDUlnEH81DR5mUtE/UsS0Wthoeu3AC1lRCUgrcV4EjarpauT5Dm/5LQ53HtKQJXHO0XV4aj8Tu3W/3yF0bjmuJmk2/QKY9r3xcvbcnOI7+uTgjdHpA2FopwgI/wC0yOP/VFccEs2q+GQ1XwSMAA/10LDdUd6Q2jJyV0ELIkCRRHkORGmyypRl0nkSTihYd+QqsKbXgTi/1E8z82j3WdcU/fhA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6916009)(316002)(21480400003)(186003)(2616005)(26005)(83380400001)(36756003)(508600001)(2906002)(6486002)(6506007)(6512007)(86362001)(33656002)(8936002)(66556008)(235185007)(7416002)(54906003)(66476007)(53546011)(33964004)(5660300002)(4326008)(66946007)(8676002)(38100700002)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTR6NW05MWUwWjNyTVgzOTd0eTQ1SS9qN2FSYS9xMlVDZUhwRGt4LzJRNjlz?=
 =?utf-8?B?dUFsdldyZ1VqVEVYb01Wd2lLeWorQ0cwNHNBeUQvaU9qbHN2d25yemk0UnRn?=
 =?utf-8?B?aGYvR25IUHJSUmhjNENpQnM1SFlzT2pGZlQyVHpXSUQ1WkJOeElwOVJ1U1k4?=
 =?utf-8?B?dituQmYxbnppcTRROHZ0OW84RXpTYXlEWnRuRk84T0tScDNEeTVSK2NQVlhG?=
 =?utf-8?B?RFNKS200TmgzaERzellFT000Kys1dExmYWJRWW1qdmxEVW9RMmdYREpyQ0tV?=
 =?utf-8?B?S3lNVHhNTC9QdHdnRGlHRW1leHpxeFQyS3k0eDdCa2F5RkIwTHVDRUJXQ0VM?=
 =?utf-8?B?a2pla2dGS014eVI4YVg4OHdiOTZwcGxOMGhBQkF2Y0V5dFNvaGVyWmF4b0dV?=
 =?utf-8?B?YXlhZFh2UG9vczljVk1QcWt6NFJ3cUQ3aG1mUitBNThSQUhTVXNXUmFJNzhu?=
 =?utf-8?B?SlZTMFY1aFUrVHRXMnJkZXI2QlhPZWd0ci81bUh1RXpXUHB5c01hLzFaM3RD?=
 =?utf-8?B?alcyb2x1SVFMMnlpOWpCZ05XK3UrQW8vUHZOS0dMejJvVmorQUxpa1ZWL3hL?=
 =?utf-8?B?bjU2aUpBSXVtTUtXcDJ5RDI1QXdmS2kyeTE1THFqbHg5S25KOVg1MGFUMDNW?=
 =?utf-8?B?eXI0QmFMbDZZYk9JRVFmdXd2N1RKeUZralA0RDZpTjRYRTV1UlN3YXMxODJy?=
 =?utf-8?B?Vm5KRzNFc0kxdXlyc2tLa29LSUJ3Nkw5ZzR2SWQvcXdvZ3FETlUvT2pEM1FG?=
 =?utf-8?B?MDdjYldVVWh6R0hjcUJ3ZmpQNEJJYTNURndiaVRnNkdhbzNBZkR4OTNnbWdz?=
 =?utf-8?B?LzR1N3pTbzM2M0ZndngzLzBFNUhselZ4WFNONjU4cjJHVEhqaldLS0I3TmlX?=
 =?utf-8?B?MUhpUjFTTkFnb3kyZTFmaERMeGdJSzlDZWNwUjdYTW5pWDFvb1p2aDlsMTh1?=
 =?utf-8?B?NGIvcnBaaExRdTAzcFVQS3h6VjdEMlJCbUNwQ3V1cTVpUlpsaWwyajhYV0dM?=
 =?utf-8?B?ZCtBTXU4UU1vZXBPeTQ4a1ZZd2pXQThmenF1V0tRSExaaEFTUXc5UDRrODZ3?=
 =?utf-8?B?S0VsZVlyOFVRZG9pbmZxQVB3VzhMdU5oYWN0eXFzaXltazNlTVNVVXdoMFF6?=
 =?utf-8?B?MldhQ09LenZLMER5MmlWUmJqR3Nuay9xZ3VSTVNlMnIrNWJ2VTJ1OUI5T0pN?=
 =?utf-8?B?STdkR3U5ZitkK0JlQkdOTTJtUUc0amdHYzhrRkUrRkd4TW9QWDNpT2x5Y2JJ?=
 =?utf-8?B?UWRra3EwbVB2eDhLRHl6SUdmcy9pTVJyQ0VvdHRjLzRweFhUL21ZeHJDMjM5?=
 =?utf-8?B?d244ZkRhVmhrTFhMUkEveHlmNW5xRzdkaWF1SmtaWEtSMUlaeTc5M2Y0cUJM?=
 =?utf-8?B?Zk9YMXpURStvbjdxT3RMR2V5ZzhNTjZWemVEdHczWXM3bCtEc0E5bnRBTnpr?=
 =?utf-8?B?RGhJRk9TTkZzZEduM1FPV1VyTGJUTjBBWHFrWnlNMVVrVFAxVnJ2MzdxbVIv?=
 =?utf-8?B?UXBValNYV0QzakdxcWNveG5EZDFZZDNWQlZUekdoQ3IrN1hMZ1RobWs5MCtB?=
 =?utf-8?B?aGIrU1hlOURKUys3ejZTUmo5WjhaYkdFQWwrTVdtKzBKOTQrVUZYOGY3VTFO?=
 =?utf-8?B?dW0zb1ZqbXV5eDVlSkUvSlBjNTh3bG9reW4xR0UyQ0lLaHI5d0UvekpwNzBI?=
 =?utf-8?B?UDZTK2RJajVaY1YveGNoYjliN2tsenZITTJ1Zy9kZHI0V1h6Q1B3bllGWlRU?=
 =?utf-8?B?YStuM1cvVUgrdTdsU0xpRE9GZk93eXYrZ2dYVnVuYUtpbzFFS1YwNmxTZFBJ?=
 =?utf-8?B?MjVSSHpRWjhNa29KSFVOM08wTDRjM25ZRW5XdERHODBlbDVlTVlwR0orU0J5?=
 =?utf-8?B?cTI4YmhVMWhva2FwQUVLVWpuR09lakNGT2Rqc3ZVUitwaklkWnF4ZVN2VWtJ?=
 =?utf-8?B?TnN5bVJpdkEwaXV0eVM1bzQ3U0VrT3Fienk0blgxbDZzZ2g1eDJrMWFmcDQx?=
 =?utf-8?B?dXJoR1BKUExtL3h3R1A4S0pSUStNU08vOWFrbVZ6aDc1Sk81RHJQWTIvVXJr?=
 =?utf-8?B?eXJFUUdjNW1XTC9iajUwVUZNSlQvMjBaYi9DRW5la0Vhc1ZxcjA0NXJzY2FR?=
 =?utf-8?B?bnhUMllmakxyaUdMSjh2N3U5L29OUkc4bjUzSVBzdS91a0RyY2IvYmUvbnV6?=
 =?utf-8?B?aUVrak1EZG5FZ1ZMSlE0Wmp2N2dSQ3VjTlYzd0tzUUpZQ0w5bU1TeDBJcUpJ?=
 =?utf-8?B?eVRodHlvS25pNGdjOUIreGxlV2Y0RVNPa1VyTWpEVXZGZzFySDRlWHljWUhw?=
 =?utf-8?B?NzhwbWhFZ2k5c2Q5VUFXS3ZkekI3RldZWlJNNFd0S2dCWDJPSENGZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b880f23a-e68f-4276-b9ac-08da129646d8
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2022 21:43:07.1536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 31ve1GhsQmyWL8NnlyA2TXoqtw53w8roN+acLfPkWDOzClBhDLpTWGlcOdx1JhUO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2572
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_3164F1AF-856D-4B25-BF74-6C87D860CE21_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 30 Mar 2022, at 17:25, Zi Yan wrote:

> On 30 Mar 2022, at 16:53, Steven Rostedt wrote:
>
>> On Wed, 30 Mar 2022 16:29:28 -0400
>> Zi Yan <ziy@nvidia.com> wrote:
>>
>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>> index bdc8f60ae462..83a90e2973b7 100644
>>> --- a/mm/page_alloc.c
>>> +++ b/mm/page_alloc.c
>>> @@ -1108,6 +1108,8 @@ static inline void __free_one_page(struct page =
*page,
>>>
>>>                 buddy_pfn =3D __find_buddy_pfn(pfn, order);
>>>                 buddy =3D page + (buddy_pfn - pfn);
>>> +               if (!page_is_buddy(page, buddy, order))
>>> +                       goto done_merging;
>>>                 buddy_mt =3D get_pageblock_migratetype(buddy);
>>>
>>>                 if (migratetype !=3D buddy_mt
>>>
>>
>> The above did not apply to Linus's tree, nor even the problem commit
>> (before or after), but I found where the code is, and added it manuall=
y.
>>
>> It does appear to allow the machine to boot.
>>
> I just pulled Linus=E2=80=99s tree and grabbed the diff. Anyway, thanks=
=2E
>
> I would like to get more understanding of the issue before blindly send=
ing
> this as a fix.
>
> Merge the other thread:
>>
>> Not sure if this matters or not, but my kernel command line has:
>>
>>   crashkernel=3D256M
>>
>> Could that have caused this to break?
>
> Unlikely, 256MB is MAX_ORDER_NR_PAGES aligned (MAX_ORDER is 11 here).
> __find_buddy_pfn() will not get any buddy_pfn from crashkernel memory
> region, since that would cross MAX_ORDER_NR_PAGES boundary.
>
> page_is_buddy() checks page_is_guard(buddy), PageBuddy(buddy),
> buddy_order(buddy), and page_zone_id(buddy), where page_is_guard(buddy)=

> is always false since CONFIG_DEBUG_PAGEALLOC is not set in your config.=

> So either PageBuddy(buddy) is false, buddy_order(buddy) !=3D order,
> or page_zone_id(buddy) is not the same as page_zone_id(page).
>
> Do you mind adding the following code right before my fix code above
> and provide a complete boot log? I would like to understand what
> went wrong. Thanks.
>
> pr_info("buddy_pfn: %lx, PageBuddy: %d, buddy_order: %d (vs %d), page_z=
one_id: %d (vs %d)\n",
>         buddy_pfn, PageBuddy(buddy), buddy_order(buddy), order, page_zo=
ne_id(buddy),
>         page_zone_id(page));
>
>

This seems to be a bug in the original code too.
But "if (unlikely(has_isolate_pageblock(zone)))" is too rare to trigger i=
t.
I do not see how having isolated pageblocks in a zone could get us away
from checking page_is_buddy().

--
Best Regards,
Yan, Zi

--=_MailMate_3164F1AF-856D-4B25-BF74-6C87D860CE21_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmJEzukPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhU5mEQAJLaGIxob8+0Qg+kpWEl6Q/GkZeo4MuILSlU
UZCiAsde8whU5xJOWo5GY14V31mL9oTQ/AKM4KFH6/FWlYJgg5qsj0vrzvy/6xhb
30/KNfg8Jmj8gY2aLb+fpvONOiMaKM0m4tbIMCmk77o1HhnbsGIBwx27mUclKfU4
pQtehSYHplOLhDVZfakuChYyG4BqhRf7D6TN9XH7z+zBuTSEPL6mFABT/v4KeCU0
TD870aC43E45N9mMTjac3Ue7J6b/9QnDhJsB1PIv9DyWbJZxuoCSi2IOew+9sP9Y
5+5YY/Iip0WNket/BnD0FayolvO4wrbVhcKmwrYla5U2VO1bV5RI/ZBRCaJtEwKY
sPC7kwZv3D3/dMb38iMFsiEHkreUeJmbuOkrCt7k8HhWPOGYwAi2sTt/A4+liN+9
59tKBE1QdcK2nG/pPpbyYcyxV5Fwbx0z11Dg99jkCaWTdAFu3Zm4193F7AHfm+vg
nsZa9vsjcoP65pg/HaHyOBjP89VXV63aD5vUGuDyLW3vjn3bTqWM9U7bXdTcOIdd
EwaBTVMaDklNzH+ZsT14NmYaq0L9U6VsfLgdvZ+kSt01Tetp5bha7ye5gXWxrtL3
QrB/VCi3k9XXV66CEr0bYiQs+Pf57fjD5S/IsGqLs5OkI7IPkde0/gnljwdd0qB1
Qd1DZRNt
=lWlU
-----END PGP SIGNATURE-----

--=_MailMate_3164F1AF-856D-4B25-BF74-6C87D860CE21_=--

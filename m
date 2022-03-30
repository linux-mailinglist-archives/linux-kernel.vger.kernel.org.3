Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6594ECEAC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 23:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348849AbiC3V1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 17:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbiC3V1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 17:27:17 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0775C6623B
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 14:25:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mXHTeCuZgA40fDH70QCPQBd/y0AxAehEPzhRwrQQhrScQza2DVn3bhSs8R7ppjg8OUpIpxOakrKSLZl7VmdxTSTP3icmqnSNCqPoWMoblYA+aiSRK4K7lg4qz1pobAnObzXb+Qw+bay1RqipTnt1kDmGyK2XHXHNT2bM2HTNnCulsWlQldT2GGokGYR9nN7FxvkGzdPCdg5PeoSvgxUjWDnmJpWis0cY6Vhjef+SfDHlEg6HI5BAACde0BbJFinNxiH6nfsA05fil1wE0QsfDohl1UjqaQHOY9DWxO/r1MnrcnFQZpeSRcP6Gk20zOBOuGvOMNBjL+XFqwViEGXUGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4biywbqyqRUmF1oZat2GwMSkE6CZL988mBWzZIBHEnk=;
 b=YmsnqhEtCDBtWy+SVFtQUShIpA8oXBpa5EpPKqVhDJufHN1oBqpVed2aTGjMyIYG3Qtz8Gd87skQRsSQ4s11W57RVnUwUicJCJ/n3MxTwd08Cf3k2E+jJDOfwxwYSxuOrCKkfU/BUD1mkSL+yEjedj+KDvhM+CF8HX6+uAhPw5moz6SCEzIbt2k0KWJ5SnlIki0dia7rtC0wujheS07KIPDemojhDa5Ssz6SIWCkfXpZ8SZF1FTkbGASp0ly8dYDmW7h9V4To7jpDRDVJDfByrvBZal42YhUD+H5yJSX9OOK8JBLKGa/YtUhL2YodPbT3+/yStFozQkiTyq1j5e81Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4biywbqyqRUmF1oZat2GwMSkE6CZL988mBWzZIBHEnk=;
 b=Xu+bj1CAxt5MQQBIgDutqqj35hs5F7KUxfDKXQMnWEZS09m3QeIZFrQJF4H7Q3cG9c9r91ikhasA6/L1Tc7xABmiEkAQdsbQJJlqJbVtSFiQG7e1NbrrpZi39JKjNVVHArsq2FpZH3z1wi4PEU3li7GdbsJS1Sim1Z/Hnx6CUbPj955IJGPVpIiyKrPRUNaDAc2u6QRmWVIBtsziM9BZSK1UCNWjP53aQvxRpNevUB+pT74oF/k55nVzD5XSfm5EAKzQtpBGPgoNtx73jGb2nDqMiopKXoI8j4K5cueR37zwGIj0Za3wsTd4NveWNjEkmk5AOAVm9L7hVviEMjb0RQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by BN8PR12MB3425.namprd12.prod.outlook.com (2603:10b6:408:61::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Wed, 30 Mar
 2022 21:25:30 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::69f1:dff6:826b:7d9c]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::69f1:dff6:826b:7d9c%5]) with mapi id 15.20.5102.023; Wed, 30 Mar 2022
 21:25:30 +0000
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
Date:   Wed, 30 Mar 2022 17:25:28 -0400
X-Mailer: MailMate (1.14r5870)
Message-ID: <AF9D3EF9-B070-4ADE-A2D3-C466A4A2D125@nvidia.com>
In-Reply-To: <20220330165337.7138810e@gandalf.local.home>
References: <20220330154208.71aca532@gandalf.local.home>
 <CAHk-=whz_8tRNGCr09X59nMW3JBzFLE-g-F-brxd+AkK+RceCw@mail.gmail.com>
 <B7789993-75EC-4F74-B4E6-AF1CC2CBD9D4@nvidia.com>
 <20220330165337.7138810e@gandalf.local.home>
Content-Type: multipart/signed;
 boundary="=_MailMate_BA3F1FA9-3595-45EA-AFF3-25218BF01ED9_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1P223CA0015.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::20) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 843e861f-e286-477f-4092-08da1293d0ef
X-MS-TrafficTypeDiagnostic: BN8PR12MB3425:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3425B3245F73C4FC6FE80674C21F9@BN8PR12MB3425.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Am8zOFnwMYm7yWFfEsdyIqS4EWWgyp2GvYbiG72mb/V3UygJ3kqwLxvR7WbkNu/P4puUCCZ/EZxwXdvwf8CPkbPszYdC/ckOTcMxkLt8lq75/bYBdDWs/eWSH7cWqf5tY/+7Kie8YwNXF/q+JaIQ4studuBJi+6JglgCK2KSW8M+W2wBDE/Pab/6jWfMjeuOiBBIiNQi7e4CRCNOqCy8NfKUiFPbmJ5ITqnHkPC0M0+OtuzyyeTeprnzGMpiKqRFMdpJtTwNyvWmmz5RmsK+aejXv7VkGeLBWVEMOAAQNbz27ck/AW9l48lHJ//5ZQSITBbjn98PwjG8VyGb5mQbI5gptCDrZg9GDWzRyrs8qzsIEsbC4rPQ/dDKQIAYVW/vVih8kyu024PsT0P/Ub+39xMFEieGpj1c398ylamilNRODUa3iUMDILOPPfapvkSTDVulYaMUlcNS60zgnawxBLjcAwj2cJGE2tM9QLabNTHz6KrLywHvTFbOU1Y9v5npa0yL1exKFB8LUM8PLni4FiJIfeZkGgAcfxiezJ+PKj0j5cTAlfKiso/8Xe4lM4a4YcsdA/R59AzIkvwqnG+Adzu/CLEMPA4q/4/Oj23FCr6KBCS69J8Yd1xFwNL0mMzI/nUUMfnYTdxmTO3Hk286a6LADAFmLFzJdGsHP/1+8tVIr3ECrQpAgbpLCPTZ0hw2VbbDTpECI6k3ioUKxiAQRjKtq/0JlqpkqE3DgNYMv0M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(6486002)(6506007)(508600001)(6916009)(33964004)(54906003)(26005)(83380400001)(53546011)(66476007)(186003)(21480400003)(86362001)(8936002)(6512007)(7416002)(36756003)(2906002)(235185007)(4326008)(2616005)(33656002)(66946007)(66556008)(5660300002)(38100700002)(8676002)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlhJNHB5RTJSWlYxcHdMYWM5UGIrbjRXRytRZkNhbUZsdlVGY0kwZVJrNTA2?=
 =?utf-8?B?RUdNUy9LUVA0Ulk0M1YyUStSTWhNTDlLL3ArSDNlcGlJZE5ROG1qbTR0dWlr?=
 =?utf-8?B?N2VKbHl0MnJRNlNsNmxaMTNqLy9FN0ZHb2JRODBNWDJwdXVwbElwZ1VSNzZT?=
 =?utf-8?B?N3dYL1VsQ2luOWVjbU5MQWlGUHVkRElubEViQnp4c1Z4Z0hBaWQ3ZUJqUXlE?=
 =?utf-8?B?R0oxemFjT2ZObEJHdkFCVzVmZWtkVThxT3VMN014eHkxT05IQnJZa3hrOFll?=
 =?utf-8?B?ekxnbEMvaXlPWm00Q1E5L0xLVEpIQ0FDUjJSV2Q4QVlReXllakNYMjE1aXVn?=
 =?utf-8?B?ZTc2YTJkYktaSDRKTmEwOU1KcnQ5dlB6U0RLT3NJMVBFcm9vd3U0Wkk5M2xr?=
 =?utf-8?B?akp2SGJrYitoQmRsS0duQW5Wc2tJbjJBQUZEL2FROWRyMjExWjBkMG9pQXM2?=
 =?utf-8?B?YkYvelNyQnlvWVp2OTl2KzFJek1NUGM0K0x3emF1b0k4a2pwV3JBSkJ4VDJ2?=
 =?utf-8?B?S0ZYeFFSbVRZZVJMd3VtNUN2N1VEd2QxTE1SZFRKRnhHR0JpNVF4MDFNNUJ6?=
 =?utf-8?B?T2JRSmlJcGh5eS93MGh1QTJGdC82NTdRMVc4UjdvVnBwMldNajU4T1RUUElZ?=
 =?utf-8?B?QXZITElzalBUbm9XTVFmSytNWGJXVXBFVnlhVlQxeHpQbzFrM3Z6aGpxVG9M?=
 =?utf-8?B?bEVCVkNGY2c0eGxlVHNXbkh4R0Z2NTZ2c0FBNEFIYlYwS2JWK3VtSk1wRnF2?=
 =?utf-8?B?YzJYaEhXUmNHT3NGYmlZZUR6SFpFdzVEWU0rSXlnMldheXlETEQ2MHYvZjJu?=
 =?utf-8?B?cnVQOXNmQWQ5akhhWlEwOC9nUldZWXg2K0tPZUxVWklvbW1wQjNiNjBsQ3lY?=
 =?utf-8?B?TmZ1SVNEVEtJK2NVempJTloxc1RMODlLVEFSUk1XaXlnZFNXeHprdlRJMyto?=
 =?utf-8?B?R08xVUFJYXdtZVFHU2t3SHRMN2ZxYytzSUZnQis4VlVKemp4Wk1SNzlwZXND?=
 =?utf-8?B?cjJCSVJWTEV5cC80MHlLamFMZEJuR3NSVWZtZXZ5TUtPOW5VRVpIYkwzY1FS?=
 =?utf-8?B?NjlWWGtVbDVlTUhDV2VkNVRITU9ibkZIWU50dTloQ2lGNWZJY01QU3JlQkpm?=
 =?utf-8?B?Nm9CeVk1aGhBYitna0hxM2FyQlM0VUNkRTJ4Qi9jaVB3ZWxMRVc3bEFiTENp?=
 =?utf-8?B?eEFGWkNzeERCNmhSeHJDaFVHQlI3R292MGs5Yml2Q1BJOHVSd2VYTS8vaG1G?=
 =?utf-8?B?T0F0bklKdmxwRUxEbEFFdndEaC8rRGhOd1BRcXlpUUxiZUVnOURhV3U4OHhi?=
 =?utf-8?B?L1ZrREloTjNoelIrajlBY21DVWRzcWloMGRkRTRUaUR1c1ptdzlXbU1QYi9s?=
 =?utf-8?B?djFRbjJwMzNOeDgxTDg1N1l5Y0xxd3FMcm5pQ3FoaVRtSE9QUXpXN0xsSlpJ?=
 =?utf-8?B?Q1MwZ2RLemtTd0I4MDF2d3J6TEZMbnhRL1lmZERZc3JVMFkzOEpqd3BydDA3?=
 =?utf-8?B?Umx0eTFsUVh1WGtaWWNKZkV3NFJXVGJacFRPMnNJMlc1L1FESFU0K2tFYm1r?=
 =?utf-8?B?d1VaK2VUallaY0xTVzFjcFBranJnZUFmT0JkbjludDlDVnl6V3B2d01TbHVn?=
 =?utf-8?B?UTJlMWZDOVJsSERva0crd3NBNkxHVEFTVHRCUUNiRUpIZ29HVTE5QU53Y1RD?=
 =?utf-8?B?L1lRaXRUdWNwSjU2aldqOWhQYm5xOUJLcC9YN3lIbTFpNjdrZnRmR3l5TTkr?=
 =?utf-8?B?SnlBcEZEMGNJVHRNNUR0VkpVR0w5MGNkSHdRT2JTMDJDTUtUL01uemF0eFhp?=
 =?utf-8?B?c0FxSlBzb0VkYW80dnJGT0N5YStZNEk0dkIrTW9hT0xuVHhrY1ZGSHNxbjBZ?=
 =?utf-8?B?aXNJTDNHM0xFcFY1UEJnL3B3NHhZdDhveUFFZGVTa3NBdmxWNkNIWTNRSFUx?=
 =?utf-8?B?ZHNhN0lzSlA4V0VWelR4ZEROUmpFUWwxcDhRakZKOThiTDhKM0NMaFVkanZF?=
 =?utf-8?B?clNmODJBRng2ZzVkRWdtSDhEdWdITnpsME9VSkZtVU9FNFBaS2ZOWWRFcXNE?=
 =?utf-8?B?aURtRVdkK09HL09LamNxLzE2QlZZV09JRW0rQ2JkS3lzb0JHc1podW1FYTd1?=
 =?utf-8?B?d3NVRHE3KzBubFQycHozY2FPRnRmUXcxS3JkR3NJNlhMSHR0aFNBSWdQYUZB?=
 =?utf-8?B?NE5vVzJsL1k5TGd5ekJmN0tXd202azlaWWNZUFhDbDArei9wMkozRno1VXRT?=
 =?utf-8?B?b2ZSQm9xSlNmRXBzMDRvWS8zREUzbDUrcWdJcE1hMXF0RDJMZVZldEpId3lG?=
 =?utf-8?B?Uy9zVnBIWDNhcDROVC9pZFZHaEZkTmxBZllRTkVPWDVEbm5rWHN4dz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 843e861f-e286-477f-4092-08da1293d0ef
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2022 21:25:30.2898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pqJrs2T4jNnFIdnv/5tdOxt+jIZ/CJJiL/XSeOItNXTa6KwGghbVEN83mIYPeNvI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3425
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_BA3F1FA9-3595-45EA-AFF3-25218BF01ED9_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 30 Mar 2022, at 16:53, Steven Rostedt wrote:

> On Wed, 30 Mar 2022 16:29:28 -0400
> Zi Yan <ziy@nvidia.com> wrote:
>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index bdc8f60ae462..83a90e2973b7 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -1108,6 +1108,8 @@ static inline void __free_one_page(struct page *=
page,
>>
>>                 buddy_pfn =3D __find_buddy_pfn(pfn, order);
>>                 buddy =3D page + (buddy_pfn - pfn);
>> +               if (!page_is_buddy(page, buddy, order))
>> +                       goto done_merging;
>>                 buddy_mt =3D get_pageblock_migratetype(buddy);
>>
>>                 if (migratetype !=3D buddy_mt
>>
>
> The above did not apply to Linus's tree, nor even the problem commit
> (before or after), but I found where the code is, and added it manually=
=2E
>
> It does appear to allow the machine to boot.
>
I just pulled Linus=E2=80=99s tree and grabbed the diff. Anyway, thanks.

I would like to get more understanding of the issue before blindly sendin=
g
this as a fix.

Merge the other thread:
>
> Not sure if this matters or not, but my kernel command line has:
>
>   crashkernel=3D256M
>
> Could that have caused this to break?

Unlikely, 256MB is MAX_ORDER_NR_PAGES aligned (MAX_ORDER is 11 here).
__find_buddy_pfn() will not get any buddy_pfn from crashkernel memory
region, since that would cross MAX_ORDER_NR_PAGES boundary.

page_is_buddy() checks page_is_guard(buddy), PageBuddy(buddy),
buddy_order(buddy), and page_zone_id(buddy), where page_is_guard(buddy)
is always false since CONFIG_DEBUG_PAGEALLOC is not set in your config.
So either PageBuddy(buddy) is false, buddy_order(buddy) !=3D order,
or page_zone_id(buddy) is not the same as page_zone_id(page).

Do you mind adding the following code right before my fix code above
and provide a complete boot log? I would like to understand what
went wrong. Thanks.

pr_info("buddy_pfn: %lx, PageBuddy: %d, buddy_order: %d (vs %d), page_zon=
e_id: %d (vs %d)\n",
        buddy_pfn, PageBuddy(buddy), buddy_order(buddy), order, page_zone=
_id(buddy),
        page_zone_id(page));


--
Best Regards,
Yan, Zi

--=_MailMate_BA3F1FA9-3595-45EA-AFF3-25218BF01ED9_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmJEysgPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUuJIQAJZXnQfS7HSasI03ON7nskoLMx22gOAurHIM
Gk6j5YhPSeQWMEiI/zbM/oEPhs/L02O22gKzvDrmAYu4ocTkKijxR9a0NJjuoI88
oHx4iMN5xoVcUwRbUXoqjDDT9x1xft6ePdnFtctVroc+ZlyUMjHZjurnvydiN1T6
2YoUx2/eEsHZhQs8SRvtRrN09LusZv9HJDZit+y3WB1eMB6QTmOdBhJBrFkqB474
clNWGP+oikICTzeQ13zqiR0G8I4nzyIJHB8BdYz9m3oNo/1F871vLw4yedH5WosJ
FPBJOSalDhEZidUMD/1OzvKkQRlA0AFusv257EZJaIA33fzzqlA7yvVqW0eZAPZh
4kWPdAS9pKkrjNREO/lCQlTDe46379tLozj5+woAptlcCIZTlkBgsKR4nA3JHB49
+0KcRGIv5GLJmAbZi7PJC/KY9kKIrjKZo+mxvoOIYb7ycZa3/Zn43GBrSeMTAzJx
hNueeg0zONcp7lnZHXSCgWngJNcG0RDlHoK2fpB9Gvett9c9Ya/FASANX/uOnuQv
PIPe/zorqXB2QXscMtlVbX858XkurgVguXrcDppu329WxLp6ZZzHL5rnw6VErfBx
R+8hTEneJ7moYEZol8wTzn7e0E9bIkU/5VDwOSSxQk+HLFkpxOZdJYz+Mf8LVdXv
y0F6tNto
=7fuB
-----END PGP SIGNATURE-----

--=_MailMate_BA3F1FA9-3595-45EA-AFF3-25218BF01ED9_=--

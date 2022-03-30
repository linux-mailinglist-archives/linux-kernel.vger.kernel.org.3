Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3FC4ECF50
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 00:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351457AbiC3WFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 18:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345235AbiC3WF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 18:05:28 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ACC815FD4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 15:03:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ogfowS5Rqq2JRQVvA82yahLEffS2F/de1aC8hpEPWOZx6wDLfEDS8zcMK2Kcpjgb8jCiPehwl51cUlzY7X2sXAGf0NMGbDEJR6Wa8TLyiWGWd4V+zQgI1fS0W9i1rFi+72dnuBETsjXn9idfpixMRmnDNgHOg+/QkkIU6v5ooFuXVspoBR1vmLzfgk90sdIVuI7Ju+mrcUvXkZmYGMeG/shE9GO/Iv6l+53o7VVN7+hMQHRdiK0JwLYurwZw6xv2S8H8syH6g+sADu625N6dQ3J1YQPXVDUttU0sBZ9hx7X2VXW/TZdgSKWQv3UW4A7IV6Awp5XBwy1aY93+zZMiLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YCUSjEVQbN7LN7HuR/YGbU43ENA6+i2hVWwXxHGo8kc=;
 b=RzdKvpcu7Ir98cxxR/e6pJChb8uPIFlghK09/lifrbTbuD2NlqG+b6YxHVGhFy6C5q13lqCrE1DvX7ZJaL33yrZ3eEGs6hVZ5AyiySIn7/LETsi/WF4DUHHMD5oqU49sB+J+aIeOZ1gBZAWaJNgyMpgkfYTfa7NMffQldLxYoqbenOgKW3JK4AHIRxMnbbgzPXgHR8O4iIj6E+ZdSmkQLCh4QsV6Xmclqt8NzvFymwVhbB+xtRgNjkCmyZcnYlgvg/N/y/F5T8LE7alSEOPdri7F0YAK0u6mL44f6g3nVW2qhEWSl0YpCujnjL5ZmlS41bMffZWrswQMdS9V6Ja1YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YCUSjEVQbN7LN7HuR/YGbU43ENA6+i2hVWwXxHGo8kc=;
 b=q59N2qM/ERzZ0oqFEyJm1Mzbnzd4GBqDlffzTee7F6N5nArMrheNq/rp+2NeQ04u97/LX+WkaFJOtfmzHqOz0nSADQrG1WH95sFEej3aKkp3MAHp57kaPqhpM+NsVXriJ0uqYKiDtEa6d0mWAHm+TpbWWf4Z1RK3bpTxa9egeOY6mbd945Kc7h3XQ/l4SUY/ghee+qlinHNbdeZBASkYS/IKUf7oTXpY9aBScRjCEQSS5I96Bx17vMU2vD0cu/5yo0vCuTbFqjD3mN3ES+L53oJwkUcZ1EcBW6691SoEglNS9vP+3Ch0LM5Kjd7cc5kNGwBsnLkhbDe/I/c+f8cE0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by MN0PR12MB5787.namprd12.prod.outlook.com (2603:10b6:208:376::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18; Wed, 30 Mar
 2022 22:03:38 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::69f1:dff6:826b:7d9c]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::69f1:dff6:826b:7d9c%5]) with mapi id 15.20.5102.023; Wed, 30 Mar 2022
 22:03:38 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [BUG] Crash on x86_32 for: mm: page_alloc: avoid merging non-fallbackable pageblocks with others
Date:   Wed, 30 Mar 2022 18:03:36 -0400
X-Mailer: MailMate (1.14r5870)
Message-ID: <EDB4B100-3CC4-4797-A32D-3DCAE7C76D8B@nvidia.com>
In-Reply-To: <27ff69f9-60c5-9e59-feb2-295250077551@suse.cz>
References: <20220330154208.71aca532@gandalf.local.home>
 <CAHk-=whz_8tRNGCr09X59nMW3JBzFLE-g-F-brxd+AkK+RceCw@mail.gmail.com>
 <27ff69f9-60c5-9e59-feb2-295250077551@suse.cz>
Content-Type: multipart/signed;
 boundary="=_MailMate_9B93EC9A-E426-4BA7-80C5-020D84B7D077_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR19CA0062.namprd19.prod.outlook.com
 (2603:10b6:208:19b::39) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2507c89b-e065-4c38-f82f-08da129924f4
X-MS-TrafficTypeDiagnostic: MN0PR12MB5787:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB57873BBFE5EF9526442B9E27C21F9@MN0PR12MB5787.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZR2fsBc9wV98R0gdDFeG1K8zoHWl0dK294aWwtPHZAM9aekJxIxPK7B+zWp8xNbXCqzRBOmOPDoQ1mFgtemNUVe9cKjEb83Hmt5oUHfam137Wyuc33tqgjenBaLoq2NlfeXdYhjhdXu9jlkImSXeUZ500YwKHWNGyCF9dFQBF+7eBm0xYvyvnFvF7e8CYL/WphpV4VgTp1Px0qRS/5CwqUmTVw8x6koRIxYcB5LGaIZ5S5RReVkBfidU9Tdk/SGoS93UHlPzGmsL1+GzUIIfkvstIhfnsMPPB9oOljoN6f889eNiPw5lzt9+IRVkS3oS4hl5KKGoH246DzTbs5alN1zPAbUBGuaHlE9/kgyj9g4XJtRQINVlLMOQX/6egaAslM5m/Qts9CQ6JOC4SgLkkzxVIRiEPSVPw+yUdOrN3Jk3G9F00+XEjB1ctIJtnnLwAV+BwIxJz1F6rSr8j8VBvhQI7RegfPsUyvzDqtYEJbyptkaDzZmF36OEX/bATFPp4qzIVN5MJ3MWKeQNbjS7roBPD8nca02pNi96yCYILXu5iTfTGDfYy7LBoM2tN3EJ3DZhVwhcrBJ+pu+lzqRtpnRNWLCUj3VeRbud3zF1VALsHtJ4Fj0oemtbf7+GSBcVK8OSGjpNpuvZIv8bVYi9stkNzJL2nma8i/EN3egwbDdfE5Kali/unIrG/rQaI8e+dp1qVLsKJdov66uEO8flSDKGqTPMwMTWzU55inilMQw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(66946007)(66556008)(316002)(7416002)(6486002)(8676002)(33656002)(8936002)(6512007)(6506007)(2616005)(235185007)(26005)(2906002)(54906003)(6916009)(53546011)(86362001)(38100700002)(5660300002)(186003)(83380400001)(36756003)(66476007)(508600001)(21480400003)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tC+ARx+lUNRluLm7RE2oSncXvP1sxw09FLehWSlwAQKa1i8bZNdj+Pu/8clF?=
 =?us-ascii?Q?i6KnKylgGO8wz30u/rS1cDFNVOhZ6Aa0wHfyIUWT0iagpaDrGijnMDZ9c6Wz?=
 =?us-ascii?Q?xJUSrKc+nSgFno1wdRr7LpYr+abUcRnEQIEMXQTuN+8DLaXUG75yP2dM4P/U?=
 =?us-ascii?Q?ydpTwL1M/jg2x+qJBuTOFI6m6GXLU10YyWtGhxGgMX8E7nSQuePOfk4ZTvR/?=
 =?us-ascii?Q?O+y7AR/oItQ5cIDWgxWD/i3uswYQ4jL1MsUKNoHXl4LS4Ul3bT/NWYHqMXgv?=
 =?us-ascii?Q?ye1vKKwUmSD1Fnk22+wDiyY8hwiyR78BuYQmAVNSykfdFxA2U9TOONYcLnXR?=
 =?us-ascii?Q?alDHvYsukWusMY1eIerLm5HGZwvmRlk1qEuHNZB/5UnwxYM67svRPhYzC7Fg?=
 =?us-ascii?Q?0sojeWHYvxyM7zgll7a6Ku/y6R++xzUs4wbGCAiMmxOplgZAR0gXmUoZRRKj?=
 =?us-ascii?Q?BV8T6rTNffph7vet6IDHAF4WtijL86jKUHKY1BA4N2LIK+5Ln/osdHcDwjL4?=
 =?us-ascii?Q?5xsXXqU/rzbb+NOKcwh0llhQhDBXWYsy4y9qHL9keUsCUZqH1h6D+yGdvKQK?=
 =?us-ascii?Q?OafczmfA+Gz105Km+rHyzBhkzjTyDhwKg8UsCkL8sDc78PgERDM/qiRb/1ie?=
 =?us-ascii?Q?mMuloOJ2eNwfTRZ2/Ekz0jdbPgJ9PfG9l4kA9wg9sFV0s/fEiO+WGwUVRorg?=
 =?us-ascii?Q?MA1lONbA1QW64S6hkdD39lEf7MfhV5UZimqoYn2dFSF/GWc3nqtE+Ve4A9oH?=
 =?us-ascii?Q?sxw+/Iq9iJSx2AY/HC/avbj4RyYN0/ak1xOVm2/mWWhru+tsv5SRBPXt9nNL?=
 =?us-ascii?Q?D8PZCbQH/kWjV0lj8db5RRnZ52g+j6SGNT1+oGTAgCTo+GS1wR2SynYxz0Io?=
 =?us-ascii?Q?n5EkTYB3kGGfvLkQBbbGoJwChoQlylcL6vAzoQ2iPO9Y1V3Qd8aGfdHQx7Dp?=
 =?us-ascii?Q?ozbIkXV0Crt0BImQfgUccyiIIlD+TtzQn8cePxC7rO3INkxELL/v+hb7MJcp?=
 =?us-ascii?Q?JgmGN8/LAMpy029IP5qQ8zgsNbdjsfJC06TH1zGq2+yjcs3dbBu0iTY7+VBu?=
 =?us-ascii?Q?L+FfNuirvPnsuTa5ST3JZTttksUJbwOqe8fsmK6TBp7h/1wp/Mp8Wwesop9W?=
 =?us-ascii?Q?+ee0OMTRyvpdU7g9zgkn6vCEMvYdV4+Oi1dBKMEnNUsqiRJzzyiQZRnr1gMw?=
 =?us-ascii?Q?+2DMtn6pAhY4X/z6J5CfxPEAjHtbt7CItZDkZ7RZi67DKFwvvhQXeWeglgzx?=
 =?us-ascii?Q?vxx1YX1Bwv/5YgFCYX4nbaUEmpEm+f6ALOawRlgiOSMO9EtIlzzihbUN4p3t?=
 =?us-ascii?Q?GngB4A49dnE8mBCgzMlbd8BdwHWKt1n4zlnL/lU/nQw9n+YB5iKTlJ6j8bOA?=
 =?us-ascii?Q?1/wGwp7X7sE5rb0FrtVa+OVv1sAaI3V0RVdsPIji3nFy5WGB+/pvnCBID6V1?=
 =?us-ascii?Q?Nz55K2lr4zJVO2qVjEI7rsv3E0++E6S4CZ/FTiEHqwS++Mi+Pf+SsChVo46A?=
 =?us-ascii?Q?ck5CGex9Ou9/8jjnjBDxZgin1X6A+nYGiqqBI4DOLYHALfExuTehxWcT2l1k?=
 =?us-ascii?Q?yIlTxFwhpFCkgq3ZIGt/epvUwjgIbWfHod9ohr2DjXQwPyn4ZYl4ZfCPCxeL?=
 =?us-ascii?Q?G+pBJ4kBFHHLxyI8AwrHRnA2SEnqErWBPUTVphFc5wTI8BOzaKyczb8IuhaL?=
 =?us-ascii?Q?VUeZekAo+lEB9CPPI9nElNvgqZJ5UamUMCVxmgLw+WA73eXt5nJLnREa+BeL?=
 =?us-ascii?Q?aNO7klnlSg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2507c89b-e065-4c38-f82f-08da129924f4
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2022 22:03:38.7551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i/Q8Z3B9s7wtHe0PWHpyY1mQp8e6ldufpM7gJJS2CungHeHZ+CNv/ByZZ5FBsF3g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5787
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_9B93EC9A-E426-4BA7-80C5-020D84B7D077_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 30 Mar 2022, at 17:43, Vlastimil Babka wrote:

> On 3/30/22 22:05, Linus Torvalds wrote:
>> On Wed, Mar 30, 2022 at 12:42 PM Steven Rostedt <rostedt@goodmis.org> =
wrote:
>>>
>>> I started testing new patches and it crashed when doing the x86-32 te=
st on
>>> boot up.
>>>
>>> Initializing HighMem for node 0 (000375fe:0021ee00)
>>> BUG: kernel NULL pointer dereference, address: 00000878
>>> #PF: supervisor read access in kernel mode
>>> #PF: error_code(0x0000) - not-present page
>>> *pdpt =3D 0000000000000000 *pde =3D f0000000f000eef3
>>> Oops: 0000 [#1] PREEMPT SMP PTI
>>> CPU: 0 PID: 0 Comm: swapper Not tainted 5.17.0-test+ #469
>>> Hardware name: MSI MS-7823/CSM-H87M-G43 (MS-7823), BIOS V1.6 02/22/20=
14
>>> EIP: get_pfnblock_flags_mask+0x2c/0x36
>>> Code: 6d ea ff 55 89 e5 56 89 ce 53 8b 18 89 d8 c1 eb 1e e8 f7 fb ff =
ff 69 db c0 02 00 00 89 c1 89 c2 c1 ea 05 8b 83 7c d7 79 c1 5b <8b> 04 90=
 d3 e8 21 f0 5e 5d c3 55 89 e5 57 56 89 d6 53 89 c3 64 a1
>>
>> The whole function is in that Code: thing, and it decodes to:
>>
>>    0: 55                    push   %ebp
>>    1: 89 e5                mov    %esp,%ebp
>>    3: 56                    push   %esi
>>    4: 89 ce                mov    %ecx,%esi
>>    6: 53                    push   %ebx
>>    7: 8b 18                mov    (%eax),%ebx
>>    9: 89 d8                mov    %ebx,%eax
>>    b: c1 eb 1e              shr    $0x1e,%ebx
>>    e: e8 f7 fb ff ff        call   0xfffffc0a
>>   13: 69 db c0 02 00 00    imul   $0x2c0,%ebx,%ebx
>>   19: 89 c1                mov    %eax,%ecx
>>   1b: 89 c2                mov    %eax,%edx
>>   1d: c1 ea 05              shr    $0x5,%edx
>>   20: 8b 83 7c d7 79 c1    mov    -0x3e862884(%ebx),%eax
>>   26: 5b                    pop    %ebx
>>   27:* 8b 04 90              mov    (%eax,%edx,4),%eax <-- trapping in=
struction
>>   2a: d3 e8                shr    %cl,%eax
>>   2c: 21 f0                and    %esi,%eax
>>   2e: 5e                    pop    %esi
>>   2f: 5d                    pop    %ebp
>>   30: c3                    ret
>>
>> with '%eax' being NULL, and %edx being 0x21e.
>>
>> (The call seems to be to 'pfn_to_bitidx().isra.0' if my compiler does
>> similar code generation, so it's out-of-lined part of pfn_to_bitidx()
>> despite being marked inline)
>>
>> So that oops is that
>>
>>         word =3D bitmap[word_bitidx];
>>
>> line, with 'bitmap' being NULL (and %edx contains 'word_bitidx').
>>
>> Looking around, your 'config-bad' doesn't even have
>> CONFIG_MEMORY_ISOLATION enabled, and so I suspect the culprit is this
>> part of the change:
>>
>> -               if (unlikely(has_isolate_pageblock(zone))) {
>>
>> which used to always be false for that config, and now the code is
>> suddenly enabled.
>
> If CONFIG_MEMORY_ISOLATION was enabled then the zone layout would be th=
e
> same, so I think it's not simply that. I think it's the timing -
> has_isolate_pageblock(zone) would only be possible to become true later=

> in runtime when some isolation is ongoing, but here it seems we are
> still in the early boot. Probably at a boundary of highmem with another=

> zone that doesn't have the pageblock bitmap yet initialized? While late=
r
> it would have, and all would be fine.

It seems so based on the boot log from Steven.

>
> As Zi Yan said, the usual merging code will, through page_is_buddy()
> find safely enough the buddy is not applicable, so I agree with his
> patch direction. Seems this also shows the code tried to become too
> smart and for the next merge window we should try just move the
> migratetype checks into the main while loop (under something like "if
> (order >=3D max_order)") and simplify the function a lot, hopefully wit=
h
> negligible perf impact.

Something like this?

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 6c6af8658775..568ecaf5700d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1053,7 +1053,6 @@ static inline void __free_one_page(struct page *pag=
e,
                int migratetype, fpi_t fpi_flags)
 {
        struct capture_control *capc =3D task_capc(zone);
-       unsigned int max_order =3D pageblock_order;
        unsigned long buddy_pfn;
        unsigned long combined_pfn;
        struct page *buddy;
@@ -1069,8 +1068,7 @@ static inline void __free_one_page(struct page *pag=
e,
        VM_BUG_ON_PAGE(pfn & ((1 << order) - 1), page);
        VM_BUG_ON_PAGE(bad_range(zone, page), page);

-continue_merging:
-       while (order < max_order) {
+       while (order < MAX_ORDER - 1) {
                if (compaction_capture(capc, page, order, migratetype)) {=

                        __mod_zone_freepage_state(zone, -(1 << order),
                                                                migratety=
pe);
@@ -1081,6 +1079,27 @@ static inline void __free_one_page(struct page *pa=
ge,

                if (!page_is_buddy(page, buddy, order))
                        goto done_merging;
+
+               if (order >=3D pageblock_order) {
+                       /* If we are here, it means order is >=3D pageblo=
ck_order.
+                        * We want to prevent merge between freepages on =
pageblock
+                        * without fallbacks and normal pageblock. Withou=
t this,
+                        * pageblock isolation could cause incorrect free=
page or CMA
+                        * accounting or HIGHATOMIC accounting.
+                        *
+                        * We don't want to hit this code for the more fr=
equent
+                        * low-order merging.
+                        */
+                       int buddy_mt;
+
+                       buddy_mt =3D get_pageblock_migratetype(buddy);
+
+                       if (migratetype !=3D buddy_mt
+                                       && (!migratetype_is_mergeable(mig=
ratetype) ||
+                                               !migratetype_is_mergeable=
(buddy_mt)))
+                               goto done_merging;
+               }
+
                /*
                 * Our buddy is free or it is CONFIG_DEBUG_PAGEALLOC guar=
d page,
                 * merge with it and move up one order.
@@ -1094,32 +1113,6 @@ static inline void __free_one_page(struct page *pa=
ge,
                pfn =3D combined_pfn;
                order++;
        }
-       if (order < MAX_ORDER - 1) {
-               /* If we are here, it means order is >=3D pageblock_order=
=2E
-                * We want to prevent merge between freepages on pagebloc=
k
-                * without fallbacks and normal pageblock. Without this,
-                * pageblock isolation could cause incorrect freepage or =
CMA
-                * accounting or HIGHATOMIC accounting.
-                *
-                * We don't want to hit this code for the more frequent
-                * low-order merging.
-                */
-               int buddy_mt;
-
-               buddy_pfn =3D __find_buddy_pfn(pfn, order);
-               buddy =3D page + (buddy_pfn - pfn);
-
-               if (!page_is_buddy(page, buddy, order))
-                       goto done_merging;
-               buddy_mt =3D get_pageblock_migratetype(buddy);
-
-               if (migratetype !=3D buddy_mt
-                               && (!migratetype_is_mergeable(migratetype=
) ||
-                                       !migratetype_is_mergeable(buddy_m=
t)))
-                       goto done_merging;
-               max_order =3D order + 1;
-               goto continue_merging;
-       }

 done_merging:
        set_buddy_order(page, order);

--
Best Regards,
Yan, Zi

--=_MailMate_9B93EC9A-E426-4BA7-80C5-020D84B7D077_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmJE07kPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUXuYP/0Xtv0YIS4sgUiGbLSFGp9Nk7yPB9bPEeCUS
nCcixSPYJ1V/x1r5Q+8s4q9/YrcX2MNaD1mGFv2+Kr+yZbfMKNCCeXfv+mXX85RO
YCi3dCOU2LBoSF9GTIiwen9/K03gGgGxwMAg9SdPBumgCvT6iyUeDuEEYLidJcvn
fU/ROgo1B/bbvYX9dEhF9gbbCF5bBTs9RXUd94NRMa0tQgfZdOsdvt2DDAtQKw3b
OqE4zxkm6TdUnNZN1BxAtpXu0iUlrLe48eQPWVwZcciWNqdynJdb1gtcg8VzNFmN
8x3Wj3onUYMTviAyv0uo51OznO8ldbLdDHJ3An2UgrFsLXtorWjrKqcm3AFmInCs
Ln5aCuKyQJgbhu5ESvdA09g/y46zB83hQyZQvj5s9+9PjSegYivumOqejZRnzCQh
wZy6tOqkH6cCfznoFHJQqT/RRw3PlRUyqQbmOxaH3RCDyLh4Q0nrqJ1+k7ROLGYE
JZMW574anwDc4nk6UxphG6ebK/Zlhmxavk5ibTyLLKZlQdG3gSjOlrbgZr79GYL5
92+Orj7/GxWnyrWHzgnvKR3esOe5YVLaIkjEf/9ghIyGr9g/bIHLm1KvbxUjRr8B
7UCTSnHl8SVM8C/tli7ngbWK7lt906hIqOss+BvKi37Cbi0v4kb41+mJvqkSW8cx
0Ra4z/yg
=ZNUH
-----END PGP SIGNATURE-----

--=_MailMate_9B93EC9A-E426-4BA7-80C5-020D84B7D077_=--

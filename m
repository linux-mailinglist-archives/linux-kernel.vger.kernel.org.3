Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5246F4ECF9B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 00:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351572AbiC3W0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 18:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343856AbiC3W0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 18:26:16 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB9550B15
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 15:24:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m85YH/688J27ZWPuPd5td3gBAsE8BLHBA6EzcLMy4D6C9fmENo4+zc3uK/YGvCJCXT7D/Vtk5sV+awl6oGmTrtYGfn10JDYyFIxIq9FaC8Glx/Cmzh+yLdh+P/9PV4o8RnS8u81N1mw8xoT4MFX8uswvJSb73L1uT+Bo5hOxTJZO/6RVRQG4oIKDCcNocR5Jr8R3Pz0IfU51mNerGx2RZ/+25Vu/MKWNNg/2FUUT+msolq2mtLQBX1G6eJDKXvioIlTjxvdXeqwYsylb1i5XA7SaMdU4yX927qsu3wrSflvEWIE73OEsaNTK9ABYN6Fah5DcEq3fj1v9viy0HNkLwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OGS5TwcD3cfNc2fLvNH5uBEwGI9pi/4md5dSp2zge0g=;
 b=aPoXzl9KNaIjjN8w7Y3fjPQ8CEBRenc7KsWz8cNpOYc7to4xH00H2X+WNvCZizlrAfgc+flREWVOWOhRFF7d4a50DRAOB6HsYFcsp8n2725m9Q4Rv3X+/Z43ZlIt60+a+8sOT2zDGEWK6zz8iSig+MbEAqMRTLJpFHPANQeo1fauAQ8oP85Fx/jYdet75241V2hWiHg97g9iFKpdaJS8rDVEIObLfd1ZCN0o6taV7T3I03g07AqD4cAxKSfwDO8VJ7fFdtIoMFvABbI/vi8GhWoR7/jtjh6QHOUvSZODTCgYq2NA51x68Kgw1gQ60UWNAsX7d90DuFXW8aYZgVi1Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OGS5TwcD3cfNc2fLvNH5uBEwGI9pi/4md5dSp2zge0g=;
 b=ZdIMbTGXDAsTkIdFVFzI6wQ2MUYB2eTWqHe6Vb8BgQle+tBo7122VLvAaEEeZH5IqDUC1Prl/QSdpWAHwQV9zW/zpa4Pq3w/4IdsRvNiGL29HXN/NK9f634vzCWZiVm7QXwB4RNqHFzVmUGDziEo7RVFLYSZwW+95So1bJWjZn5VD2j2NkMEJMSriZIAsLlCfiZBh2hltVjYM/vukSSiT0ngENANwo4lwBU/epcdV7axI6Zlc0gNziYCNCiKUyT3lGbawJWXOhM19CvDxdHm4dioT8fiqpJdgCLvZ58VM11a5t4BkEyGM3OP/TMJ2pns1Wf/6L4/foN3DxUgt9Eidw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by BY5PR12MB3763.namprd12.prod.outlook.com (2603:10b6:a03:1a8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.19; Wed, 30 Mar
 2022 22:24:28 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::69f1:dff6:826b:7d9c]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::69f1:dff6:826b:7d9c%5]) with mapi id 15.20.5102.023; Wed, 30 Mar 2022
 22:24:27 +0000
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
Date:   Wed, 30 Mar 2022 18:24:26 -0400
X-Mailer: MailMate (1.14r5870)
Message-ID: <3FFB0B7F-058D-4DD6-9F09-D18C8EA4344C@nvidia.com>
In-Reply-To: <1ac57f1d-46ba-e28f-c541-70d57ca7b704@suse.cz>
References: <20220330154208.71aca532@gandalf.local.home>
 <CAHk-=whz_8tRNGCr09X59nMW3JBzFLE-g-F-brxd+AkK+RceCw@mail.gmail.com>
 <27ff69f9-60c5-9e59-feb2-295250077551@suse.cz>
 <EDB4B100-3CC4-4797-A32D-3DCAE7C76D8B@nvidia.com>
 <1ac57f1d-46ba-e28f-c541-70d57ca7b704@suse.cz>
Content-Type: multipart/signed;
 boundary="=_MailMate_AFC5B6E7-9A30-47FC-9B99-CE5FCAC3A306_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR07CA0029.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::39) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6844b6f4-dada-4c72-48a9-08da129c0d7f
X-MS-TrafficTypeDiagnostic: BY5PR12MB3763:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB37633A68519D8412238B81A3C21F9@BY5PR12MB3763.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hec+Z362aOMd9xttwExaTzYxk8DHWHYv2YoWNlNP0srRpA1FUsnzrMi8A8SJn/R28XKyN3iWEaSw99F35ZNCczZyNNDY8NYxp0Hp3irS8crq5LdBMhKTTjQoOcuF5fXyO6jHJ80QcyeNyBmySCVz/YsasKcZOuf9h1GvqgtN1JNZqUgqu7bzcs2f7My/LYGEugXtZUp+vSG6bcx6GKQhtxnseiWWxzDrqgKUU0n5sxupubwl63CQvmH4Z1Osbd1oG0/B5Fx4WvD7DZcC8Vs6SrmHrqxCLNRwWDPAV7vaEv/nd0aWN58VNHKkjWh0aUwiUv5NECH5cwJ2xmCvp4prQsAK6CzLBg97I4BFhexFa9znZY/vQVYU/VD6ze9Wq3QK6ynCig4+luiULGoGOFrnKN+9HzlitpyuzvoX4xcWKNmTbwE6Y1gb6FN82q2Urv/f7KlDMEScui12ZV0ngQSOCcnlp+iCr1BwEAbGKvKepxq9auVfvyHId+aq7+oCalxgH1O8uiQ3Fzu6zpmGvyprAfKsVhaUI4RazEAiaIUIQIJM0p9n2tfrV2rlU5b3gyBjVM+fnvIgZrv3spMqJtYHT/lLnX0N4MJUaYZtpKdaZGswi5SxWtbZzFfpV2GoPb1ifwnLLnKL1miUAeevBMoXJNU9JZutyQP8bX3e2xCzmB6U0R2fE5S8YJrN/gcs3KOtGEp/dwFvdcXjfgRn5ET/jm0Z6fUuTzarMBblfW1mI7Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(6512007)(6506007)(2616005)(33656002)(508600001)(5660300002)(53546011)(8936002)(26005)(186003)(7416002)(235185007)(2906002)(36756003)(4326008)(8676002)(21480400003)(66946007)(66476007)(66556008)(6916009)(316002)(86362001)(83380400001)(6486002)(54906003)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KTvqHV5GFBChXVd8G7vNyQmHMYrh2zUCQO8vRj6XREaNtnyak5jKSlGFCh2d?=
 =?us-ascii?Q?sLWLA/4/nOl/3sUH2NvfkjPJ46CEMLpz5t2M4rJmkaY+DXA8nMDh0ptwJWGu?=
 =?us-ascii?Q?5Al7Uyk00QAaKeNLwRFAUL1Aa+siqAE1WHZevGoqOP4cp8GREjQiAnzFqIXt?=
 =?us-ascii?Q?kn0lisLBWqrpu4XOErey2SwmQfi9QhmenTxo4uO/G2CMh8/R/lUhkmK8KrUI?=
 =?us-ascii?Q?KEFtLV3Qv/S2roWnR9HRdYqeBUbf9j+qeox1TIP9qu15QkU6QAy8+YsaKkKi?=
 =?us-ascii?Q?K97J44rG06d12ConGnypEjneXrzQZDrmcOvqMplSWxD1yBb2by697WM/BX9t?=
 =?us-ascii?Q?0p0U8D8m9A9NT1PNHGnNfI2wxGX5u1uxgp9gpuE7c4lOgoIqKsiWe819GR/N?=
 =?us-ascii?Q?ETf90V6sdJP3jGUKm4hPb3UauVJk0GDfc30E3apHaKXsIJyfoUW1yztbrzak?=
 =?us-ascii?Q?LBOXRWkLOTgJokQ5xY/dTkqGjbrhzGgYDCkQ6vxYhPi80ehhBVAv77GhdTva?=
 =?us-ascii?Q?IUwb38HEIGBc9TlLfZDVUytG8zMPee7HPmb2AeHloqLco43YJH83TxJ58N8S?=
 =?us-ascii?Q?OLAnU1jlcyGVdHEnv+qAx6neKh5fXMuUBdz5LyM0ZiMRMzB/K1l7Fe1jGLTZ?=
 =?us-ascii?Q?cTnWcR52iIccQ48y2WGvM855uPJc/M2ndAN7AMTZOn8+N8zHqsSyrZbqBDT7?=
 =?us-ascii?Q?P3tSeEmPSVAIWtsFiEt/qFLVMQWF9tZFxONCTRBXqiWvJpzwjj120mhbJ9rW?=
 =?us-ascii?Q?AaeA85+OAh1NlT6Rz2BsTxiX4Zyi0rFPj/5Gyt4B+F1fmtSTf6puMc+V4xVw?=
 =?us-ascii?Q?5OLJ6yrQzYmAYWeQMX1gCxVwwv0u7ME3KpUb3HPj0T6bfunDZf6AfMNly9Kz?=
 =?us-ascii?Q?BPg9LeaHVZbce/4Jk1+f0SPcaHeSuBlOhdTIG6cx9gCKgBQn0fzKp653PXaA?=
 =?us-ascii?Q?W4L7Gbig6XTsVvBq1yKIl//VwEhdRGPyXlBe6c7CusyDSjM84sF8ywdwmeel?=
 =?us-ascii?Q?K6SfsvGpaj2vkwxbZMtQSEETVo65TXzESiYTL8yUWm2A0mACBpkdUqdRE1ii?=
 =?us-ascii?Q?iYRzPpLO49msGCGYpSky7Inw8LiruXHeqpntncWPfTI197F5FBkXcKLedLT7?=
 =?us-ascii?Q?huwC+hgnP8mRcFbIShN4Oyrd4TAISEQG/jBVrP+NEUm5Ifc6GV3SghY3z8/y?=
 =?us-ascii?Q?/FAKfkixNrEu2DaXszGjkL55NSHY+R0PhQweI6jGEnyLZVTMlpBByAdGjgdq?=
 =?us-ascii?Q?KgxS9DcWT0z/uhbVJ0jfucCrVdgDaOPCqBKWH42NBjfJKuUI4tdrOCgGT9A4?=
 =?us-ascii?Q?+Wj071vpTwZaBOrMtM1p+IPridJ/4CgFveiIyHp1TtPJcwgeiVlL2Gpa6jRs?=
 =?us-ascii?Q?3hAZ69MgozY1OvgXTyx3CWf40VD8N5SxH5IZNk/wEsR7dJmpoNZaBVIX9dat?=
 =?us-ascii?Q?cLGGeNnLrpd02PxeXKxa7O4Z9GzCTUWHvlmhWMxnAskZu+RtvKua3Cmeir/w?=
 =?us-ascii?Q?0P7Me1XPLaVqFloR3qroH4NyUKNzx2retm86XzFml3ldVdt+LGJ+397Ed4JV?=
 =?us-ascii?Q?F8mqnXwgWAp+tpUUbo5byZOOo7Cfux6h0yYb0B3GHTS45mML7lTYk/PAPK1x?=
 =?us-ascii?Q?oEjHCVok4VEXBghVGA2qt2Lx2zmTrWRgpxmgUPDwomCl+SOXj4eX1DmjSih3?=
 =?us-ascii?Q?0YTq4PeqmfBxwUV1A5zI/0WOMqbFOmhHH3LAGuFXGkL4emNrBcRNJRuzilQc?=
 =?us-ascii?Q?TysNKjbQWw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6844b6f4-dada-4c72-48a9-08da129c0d7f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2022 22:24:27.8865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HVH7lUVhBpEuduct9L7CgUjYXSdOQ4+tqIPJqyfIVxn7b44lq4C/W4yIgqEUmeY1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3763
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_AFC5B6E7-9A30-47FC-9B99-CE5FCAC3A306_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 30 Mar 2022, at 18:15, Vlastimil Babka wrote:

> On 3/31/22 00:03, Zi Yan wrote:
>> On 30 Mar 2022, at 17:43, Vlastimil Babka wrote:
>>
>>> On 3/30/22 22:05, Linus Torvalds wrote:
>>>> On Wed, Mar 30, 2022 at 12:42 PM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>>>>>
>>>>> I started testing new patches and it crashed when doing the x86-32 =
test on
>>>>> boot up.
>>>>>
>>>>> Initializing HighMem for node 0 (000375fe:0021ee00)
>>>>> BUG: kernel NULL pointer dereference, address: 00000878
>>>>> #PF: supervisor read access in kernel mode
>>>>> #PF: error_code(0x0000) - not-present page
>>>>> *pdpt =3D 0000000000000000 *pde =3D f0000000f000eef3
>>>>> Oops: 0000 [#1] PREEMPT SMP PTI
>>>>> CPU: 0 PID: 0 Comm: swapper Not tainted 5.17.0-test+ #469
>>>>> Hardware name: MSI MS-7823/CSM-H87M-G43 (MS-7823), BIOS V1.6 02/22/=
2014
>>>>> EIP: get_pfnblock_flags_mask+0x2c/0x36
>>>>> Code: 6d ea ff 55 89 e5 56 89 ce 53 8b 18 89 d8 c1 eb 1e e8 f7 fb f=
f ff 69 db c0 02 00 00 89 c1 89 c2 c1 ea 05 8b 83 7c d7 79 c1 5b <8b> 04 =
90 d3 e8 21 f0 5e 5d c3 55 89 e5 57 56 89 d6 53 89 c3 64 a1
>>>>
>>>> The whole function is in that Code: thing, and it decodes to:
>>>>
>>>>    0: 55                    push   %ebp
>>>>    1: 89 e5                mov    %esp,%ebp
>>>>    3: 56                    push   %esi
>>>>    4: 89 ce                mov    %ecx,%esi
>>>>    6: 53                    push   %ebx
>>>>    7: 8b 18                mov    (%eax),%ebx
>>>>    9: 89 d8                mov    %ebx,%eax
>>>>    b: c1 eb 1e              shr    $0x1e,%ebx
>>>>    e: e8 f7 fb ff ff        call   0xfffffc0a
>>>>   13: 69 db c0 02 00 00    imul   $0x2c0,%ebx,%ebx
>>>>   19: 89 c1                mov    %eax,%ecx
>>>>   1b: 89 c2                mov    %eax,%edx
>>>>   1d: c1 ea 05              shr    $0x5,%edx
>>>>   20: 8b 83 7c d7 79 c1    mov    -0x3e862884(%ebx),%eax
>>>>   26: 5b                    pop    %ebx
>>>>   27:* 8b 04 90              mov    (%eax,%edx,4),%eax <-- trapping =
instruction
>>>>   2a: d3 e8                shr    %cl,%eax
>>>>   2c: 21 f0                and    %esi,%eax
>>>>   2e: 5e                    pop    %esi
>>>>   2f: 5d                    pop    %ebp
>>>>   30: c3                    ret
>>>>
>>>> with '%eax' being NULL, and %edx being 0x21e.
>>>>
>>>> (The call seems to be to 'pfn_to_bitidx().isra.0' if my compiler doe=
s
>>>> similar code generation, so it's out-of-lined part of pfn_to_bitidx(=
)
>>>> despite being marked inline)
>>>>
>>>> So that oops is that
>>>>
>>>>         word =3D bitmap[word_bitidx];
>>>>
>>>> line, with 'bitmap' being NULL (and %edx contains 'word_bitidx').
>>>>
>>>> Looking around, your 'config-bad' doesn't even have
>>>> CONFIG_MEMORY_ISOLATION enabled, and so I suspect the culprit is thi=
s
>>>> part of the change:
>>>>
>>>> -               if (unlikely(has_isolate_pageblock(zone))) {
>>>>
>>>> which used to always be false for that config, and now the code is
>>>> suddenly enabled.
>>>
>>> If CONFIG_MEMORY_ISOLATION was enabled then the zone layout would be =
the
>>> same, so I think it's not simply that. I think it's the timing -
>>> has_isolate_pageblock(zone) would only be possible to become true lat=
er
>>> in runtime when some isolation is ongoing, but here it seems we are
>>> still in the early boot. Probably at a boundary of highmem with anoth=
er
>>> zone that doesn't have the pageblock bitmap yet initialized? While la=
ter
>>> it would have, and all would be fine.
>>
>> It seems so based on the boot log from Steven.
>>
>>>
>>> As Zi Yan said, the usual merging code will, through page_is_buddy()
>>> find safely enough the buddy is not applicable, so I agree with his
>>> patch direction. Seems this also shows the code tried to become too
>>> smart and for the next merge window we should try just move the
>>> migratetype checks into the main while loop (under something like "if=

>>> (order >=3D max_order)") and simplify the function a lot, hopefully w=
ith
>>> negligible perf impact.
>>
>> Something like this?
>
> Exactly (with some nits).

Thanks for the comment. Should I send the patch below with nits fix to
supersede the patch I just sent?

>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 6c6af8658775..568ecaf5700d 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -1053,7 +1053,6 @@ static inline void __free_one_page(struct page *=
page,
>>                 int migratetype, fpi_t fpi_flags)
>>  {
>>         struct capture_control *capc =3D task_capc(zone);
>> -       unsigned int max_order =3D pageblock_order;
>>         unsigned long buddy_pfn;
>>         unsigned long combined_pfn;
>>         struct page *buddy;
>> @@ -1069,8 +1068,7 @@ static inline void __free_one_page(struct page *=
page,
>>         VM_BUG_ON_PAGE(pfn & ((1 << order) - 1), page);
>>         VM_BUG_ON_PAGE(bad_range(zone, page), page);
>>
>> -continue_merging:
>> -       while (order < max_order) {
>> +       while (order < MAX_ORDER - 1) {
>>                 if (compaction_capture(capc, page, order, migratetype)=
) {
>>                         __mod_zone_freepage_state(zone, -(1 << order),=

>>                                                                 migrat=
etype);
>> @@ -1081,6 +1079,27 @@ static inline void __free_one_page(struct page =
*page,
>>
>>                 if (!page_is_buddy(page, buddy, order))
>>                         goto done_merging;
>> +
>> +               if (order >=3D pageblock_order) {
>
> Would use unlikely() here.
>
>> +                       /* If we are here, it means order is >=3D page=
block_order.
>
> Can drop this like as it became quite obvious now :)
>
>> +                        * We want to prevent merge between freepages =
on pageblock
>> +                        * without fallbacks and normal pageblock. Wit=
hout this,
>> +                        * pageblock isolation could cause incorrect f=
reepage or CMA
>> +                        * accounting or HIGHATOMIC accounting.
>> +                        *
>> +                        * We don't want to hit this code for the more=
 frequent
>> +                        * low-order merging.
>
> The last two lines should be also dropped now.
>
>> +                        */
>> +                       int buddy_mt;
>> +
>> +                       buddy_mt =3D get_pageblock_migratetype(buddy);=

>
> Can be now single line.
>
>> +
>> +                       if (migratetype !=3D buddy_mt
>> +                                       && (!migratetype_is_mergeable(=
migratetype) ||
>> +                                               !migratetype_is_mergea=
ble(buddy_mt)))
>> +                               goto done_merging;
>> +               }
>> +
>>                 /*
>>                  * Our buddy is free or it is CONFIG_DEBUG_PAGEALLOC g=
uard page,
>>                  * merge with it and move up one order.
>> @@ -1094,32 +1113,6 @@ static inline void __free_one_page(struct page =
*page,
>>                 pfn =3D combined_pfn;
>>                 order++;
>>         }
>> -       if (order < MAX_ORDER - 1) {
>> -               /* If we are here, it means order is >=3D pageblock_or=
der.
>> -                * We want to prevent merge between freepages on pageb=
lock
>> -                * without fallbacks and normal pageblock. Without thi=
s,
>> -                * pageblock isolation could cause incorrect freepage =
or CMA
>> -                * accounting or HIGHATOMIC accounting.
>> -                *
>> -                * We don't want to hit this code for the more frequen=
t
>> -                * low-order merging.
>> -                */
>> -               int buddy_mt;
>> -
>> -               buddy_pfn =3D __find_buddy_pfn(pfn, order);
>> -               buddy =3D page + (buddy_pfn - pfn);
>> -
>> -               if (!page_is_buddy(page, buddy, order))
>> -                       goto done_merging;
>> -               buddy_mt =3D get_pageblock_migratetype(buddy);
>> -
>> -               if (migratetype !=3D buddy_mt
>> -                               && (!migratetype_is_mergeable(migratet=
ype) ||
>> -                                       !migratetype_is_mergeable(budd=
y_mt)))
>> -                       goto done_merging;
>> -               max_order =3D order + 1;
>> -               goto continue_merging;
>> -       }
>>
>>  done_merging:
>>         set_buddy_order(page, order);
>>
>> --
>> Best Regards,
>> Yan, Zi


--
Best Regards,
Yan, Zi

--=_MailMate_AFC5B6E7-9A30-47FC-9B99-CE5FCAC3A306_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmJE2JoPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUqM4QAKE2WWBQKoKmVnKGaE3jHEmCvG48d3dFF7dx
tdoLYICTSudZ3autFxoBZE2Ftleiy8xx9xsKFoDrEQKcsUjHjnLDnE/0yfAZtrFG
hAc0O6qTHaTT/2AubbYxkgmWPTBsVdjNWPa/1l1evWmNxgZLWgt6al7ch29L68kc
7x4wDX4zGve6EYQNqlC5y5za+sLBEXRF8Cn0zXPoiRSyMJWSjP/zmqm/J36w6eXm
DZo/D27NL0cCpO67gS3ab/EgXsikLhS2YORyDLKRCkvQPSQqDGJc1lv2dGDVGbUp
WRqEWJ34vbnkorKzvdEejGRbjUQIX5RJta1B/dB9jjLeLeB6qxTBRAbENp4iEhyx
LTOY6g3a7V4j2RmeRG5sdSFPMY5IsxJDTr8y910uie1fToyy5N95m2phbCoI+VGI
VurKCjWWlTm6JZyt8Srbrj/9J4lSvq7O0N7pLUMoZ9cCPlWlUz8aIJHEntvh4DFA
EFG+PBxfr75PnQzXuOo/JmB/CdjJhyfGCD6tYe7+cpPFmc+oMEVsJGRniUO601D6
p+RQDcFeUfK8Jh0iMTgSrfLRG2K/FL4P81n7gCVku0H/li/BmA52NX96j/HgfCb2
9D28U1bnP/mjKcvHusDkbkR0IJCtZYyIEqTA72kzLV6RRFVdBGjh32yMsI9IKXuu
IjSU3s6o
=G7ug
-----END PGP SIGNATURE-----

--=_MailMate_AFC5B6E7-9A30-47FC-9B99-CE5FCAC3A306_=--

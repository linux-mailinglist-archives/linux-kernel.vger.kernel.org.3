Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A168D4EE3CF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 00:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242270AbiCaWJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 18:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbiCaWJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 18:09:23 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA412102AA
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 15:07:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AAoUISOnjkgfGE8cPMv8dLAzqFX2Hm9Z2OUMaop0sWMWo6a1872iLioRLylUXJDQgYSjhnyCbnH1dLNZs4w0yva3iNlhgeGAP+FnWtuvocgrsuMDWYIjJ9G6OjpsBD8GG+h5z5hTho5hclU6RiChnl60tic0pktmJHmJipDk6bbb9n5Htcxas71Ja/tMQFb8YbiN2tkBrhuEQxCpun8ILmRaNzbPmgxBUgj/U83O4dGHoSTD6yQx9VkMV9C5wUtiyrzCfSsWthWWBIfYM8ZdxQ9Vjby+1x/5nrZ6zBqLDwSHMFiVwyq2Kq4w8awbJBTGZ5Wv2rYEUhvU3+H2DZ+IVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=elVA2EhqejWzAYn7RgSqHEaXfeGBdU08zhp07H4fG3M=;
 b=GqMa43xhPB8CwYrK9Mz4hBhdVC1DeWdTmcc/GYF34FrbYTk4OJfgi24uNo3B45N2txsOPMOx2phAhqy84E5PCYSsaZXsyF8SPk9YIr0cptluhZR09DMVRtelYIjPciFQ+pHuAbtjCMqQF8/74NbqRy6u+aJsdNUIrnxqhXeURsfvjCtf0et20M/RQopx4XmtinieuMTnSdxtYkWIfDgZdmlyxZvL2ymfiJQlh30nd7GnX9iMuqS6Xk37cXZKBXvWvZQgseV88uD+2ZgK7wPpdnWeeP7OK5LJgz1rGIOqsl1NOZQQpqfo2J1rbsT7sXrUJWOQzNgzao9175AwVjS9EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=elVA2EhqejWzAYn7RgSqHEaXfeGBdU08zhp07H4fG3M=;
 b=Z0PRcNBCOOZMAKhgbp2w8KtmtGwhG4P9Z0mvsqiHaEkJc9llK5ud3DW8hmrQ/cHVVezNlmBhiY0VYUVMpJuEzssfy7ZH9ah2aqEUXoudpX99Ur8959sm7deMVcsXlyPuYcv1cLtxZMkLYZQV/9VTbs+S2zkew+V1V+0peBvIvhFcKCdz7SlWcwxl1axSzXb9heTxlyivaFREcCtV5Shy6qWRHA3l8r7zOLlvF6vlFEuT+n5wz2ydBJ5p4w/zdkw2CpbZVSXyB6G/J5eP9fzPPmO0RzGjivrRdpRNliJyAprjqgpp9tv4xWkVo7Ftg/nmbh6rzJE9ghS22Nq2pilQGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by BN8PR12MB3091.namprd12.prod.outlook.com (2603:10b6:408:44::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18; Thu, 31 Mar
 2022 22:07:30 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::69f1:dff6:826b:7d9c]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::69f1:dff6:826b:7d9c%5]) with mapi id 15.20.5123.021; Thu, 31 Mar 2022
 22:07:30 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        David Hildenbrand <david@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: page_alloc: validate buddy before check its migratetype.
Date:   Thu, 31 Mar 2022 18:07:28 -0400
X-Mailer: MailMate (1.14r5870)
Message-ID: <14E17D8F-2187-44C0-BF39-03EB4BDD5191@nvidia.com>
In-Reply-To: <3c30c5e9-c2fb-9f24-1207-8c342045996b@suse.cz>
References: <20220330221238.396357-1-zi.yan@sent.com>
 <CAHk-=whZ7d8Z4rv5oV9+FLEEk_1A1X=JsJaeAmFZzhDxLqDLFg@mail.gmail.com>
 <63234E12-AF64-4D85-A2BF-8A4EF5359F91@nvidia.com>
 <7586AEB3-FE81-4D51-ADAE-737E74625444@nvidia.com>
 <3c30c5e9-c2fb-9f24-1207-8c342045996b@suse.cz>
Content-Type: multipart/signed;
 boundary="=_MailMate_3E6FB210-AD4D-4AA2-9919-369F76F3F378_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL0PR05CA0023.namprd05.prod.outlook.com
 (2603:10b6:208:91::33) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4872146c-efc6-47c1-3523-08da1362d93c
X-MS-TrafficTypeDiagnostic: BN8PR12MB3091:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3091A1EAAFED5F89703B3CBEC2E19@BN8PR12MB3091.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AdzS8rYYEHWKcscxE8esqKAPMK47kLMTEpJFRwff793wT+9cBsQ3hd1p5Chryasl3M58K62K9NXaz2vCi5mEpyEecn0gvP4AthHEBPiL7zdnKiKdrXw734f4CTHGfLooNqNJczmo+Rmj67H4HPVGuHy3xuDw8ai1DDP2k9TVK8/cXIUhw6dmaMctecTuez4sDCZFTFaSLKUL6qsJFMfHBMxRTA6C15Fa1GKI7YDgg4Koq8eeP8AD8oS7y/Rg/tMZjDsz3qUDKemfh/waBxLU5I6w3PyrUj055dpl7SbjFZNWNnn3wHRbmU56mHNrcAd+iFrzjnqZTJ77sfxJM6zIwQU8zmbeJLGG5pE86ednh+qTS+kQlymbRBMSFoiG0fCXJifFFiAntHtLMeeOGAoP9UYOaaDIVoRVGDKxF12MRy5fV8i8c+lDmQEdlvasO9uJ9Y25Klrffe+zfVMaIVevCZLNr+7VL1ZDmDPaNGLwyKU/k7wDGi+FCWRmbVX11NFkhvsuQ1hDKK8TgNF3TSjwN3xSNGz8Hjx8myYuWYE3sUUH3/yus/OWvA3M72O6mfGwYts29PcHvVxh5INJhIhljXov0Pk2aV6xIU2BI66JSlEcxx/nMIpBQoMI4e7v6OHXZ0Yqpf91dbHonw3sg61nOvEZOuYNJJ/1FlOCMXsl+Cf+mjUTimzg6iGDwaTeBMNnWwHKBEr0vDMSk04G77uci0WyGiQbcPKCziM9kTgom4Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66476007)(4326008)(7416002)(66946007)(8676002)(8936002)(235185007)(5660300002)(66556008)(316002)(2616005)(86362001)(38100700002)(6916009)(54906003)(26005)(53546011)(2906002)(186003)(83380400001)(6512007)(6506007)(36756003)(21480400003)(33656002)(508600001)(6486002)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?476otC3sZFxseftRSdsUiYD519LoyWlJYXRPlK1To3T21cljUuJ859X5YqNn?=
 =?us-ascii?Q?x0b8O4HGPZb7+eCC9xZyE2J4kpTNvTb7BQHUAPuEmLoL2IlF+rumw+zA5lFp?=
 =?us-ascii?Q?5iTANjRYON8PgLHAuc48L6o07WTUtzsz5lU5a+BjLovDbC8jMAIrV1/Sx3+a?=
 =?us-ascii?Q?yACbzXCR4cUbm4VMas4osRw5q4nXKea6/gwiUN89wIBckiq2WXUkFIzaf6Gv?=
 =?us-ascii?Q?YN5EDPX8JPWNohoVIvcvFRBESvGgK7e3uWrIdZhWCUDDptRXaExdI18TR2mr?=
 =?us-ascii?Q?tJUOwX8wlSaeZYjcLJfLJMeo3wux629rUbvUhSrEleFZqDpuHxILcXvUg0wZ?=
 =?us-ascii?Q?gf8h/0YvReC7e3REy+oGpLq335J1Z9Ea8BS3TWCZPLerdO//aM0Tn7eawGo3?=
 =?us-ascii?Q?YnN38Brch+HaM42LnBhw4xaS4zcK0XH+YL/+84adJAovGxSKFzhFiyj6wYz7?=
 =?us-ascii?Q?abVlurXvH4F3THZ2snAWJ44TG75LPv2fR2XWme2RlXa3QE7Hxaf+RiEj/Lod?=
 =?us-ascii?Q?U8iVRveyJ8TQABKToCWKPfV+AU2hEheQ1lo+is6slMDpbG7JsBfQiUNRDm48?=
 =?us-ascii?Q?RfvFzixtykKwMWgH5bJZ/escGhmiy291b0tiEkigXbeCx7PBSSjRLbrx9mbR?=
 =?us-ascii?Q?ED5yautGmj+Eme9l0QmRfbaeBI3TkBAV6WnH0cSGx44eNC+n0LhXTM0eMmon?=
 =?us-ascii?Q?SjZ6GsULZT/iyvP0u4FVpbB/1zFUefzVyMsI4zO21CZJEY4ZIeHJK+5WZ/vS?=
 =?us-ascii?Q?Tr1R2lOD6Kin6naEsKz/4w3AmChQclgyq+bqw13bIcEyWp181yLx425E6Tpm?=
 =?us-ascii?Q?mdVQPpGj5UE+n4nsDNJiKJk6uApriwzRdxyHhJhfmPsBom56w7fbDgFbN1vc?=
 =?us-ascii?Q?7rNMhgQ5lvDqQ9yienzD5d1THiK39IrcmQp6Vtq1wUbtzBYbO8RjxtRvn64k?=
 =?us-ascii?Q?SzviSz3rLDnrMWqbTszLQBKZytXWHOke+ef0ijxI4OtZ4sRI1vSnHWWFOkI5?=
 =?us-ascii?Q?rJ5Qxt/zONtCEb3npl70F8jaE74chx3TkNu8rfLMoVUiAAhvOUYs6ysRB34+?=
 =?us-ascii?Q?px3yBDHbPyewNKxWWD+I4q2cpdewnDzXjrMAhv5oGsq+GwYM7UbxezSI6LBA?=
 =?us-ascii?Q?fjG3p6yuJJOMB/mi8dZ0mJZgrvn/GJZGNd820K+t83nAHz9cQwb4tC2zS8er?=
 =?us-ascii?Q?6tYHkJ4sLcqfEKdCWc3hUm8Xoeo/ZGXCeOhYpUIlHvLgQui+VWk0gcU2e3es?=
 =?us-ascii?Q?A5N+n6reou2D0bR+gWmVsdYKg4jV82oGo8V6KtbXiVTCSEo4d3PCT7f/xpuP?=
 =?us-ascii?Q?0G8tX1CKj58q1KBeqxMHkS+mXoRdDKH6gjmINUYvlzGVZjAViYf9ngfFnmRq?=
 =?us-ascii?Q?i8fKjmvk84Xx1zYe7FGUUXz64fAXkXqR9RuiKlVQzPW5pjTGTAKWrnzjtKl5?=
 =?us-ascii?Q?4qWkPVN6n+COT9dJOodh/cs5SR65H4VkhQiUPVo4NhC1CwOPW9yAe1G/r2ez?=
 =?us-ascii?Q?g+OebgEdg3fbfCWyz6KF+zWm5AlnA/MAIefCIcRZvcJwnswxZ5nIJygSX4PO?=
 =?us-ascii?Q?TZVgeDxUeOE1VurAmWrv0EhI5Rql/ExCNURg0o0QWSwdFDKogjWDjZqQAXxu?=
 =?us-ascii?Q?aC1vXNYHDhzr2oYGOkl0RZkzCw9G70ktUS+y02AJRX561xuZHAsmnibmCa+j?=
 =?us-ascii?Q?e1M+w5nkvN/g6xyzfFazkewq8gIyyaSWQnLdXeSABfvXmagzXUep+yupAxPc?=
 =?us-ascii?Q?HXzG/3slog=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4872146c-efc6-47c1-3523-08da1362d93c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 22:07:30.3358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KfyRMGQlyN4mfGOikVgZfmhkG1fDw4jHnhFf2NzbLYdGRnQUDJPFckftkhjbX2ZC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3091
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_3E6FB210-AD4D-4AA2-9919-369F76F3F378_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 31 Mar 2022, at 4:57, Vlastimil Babka wrote:

> On 3/31/22 02:10, Zi Yan wrote:
>> On 30 Mar 2022, at 19:48, Zi Yan wrote:
>>
>>> On 30 Mar 2022, at 19:03, Linus Torvalds wrote:
>>>
>>>> On Wed, Mar 30, 2022 at 3:12 PM Zi Yan <zi.yan@sent.com> wrote:
>>>>>
>>>>> Fixes: 1dd214b8f21c ("mm: page_alloc: avoid merging non-fallbackabl=
e pageblocks with others")
>>>>
>>>> Oh, btw - should this perhaps be backported further back than that
>>>> alleged "fixes" commit?
>>>>
>>>> It does look like maybe the problem potentially existed before too,
>>>> and was just much harder to trigger.
>>>>
>>>> That said, google doesn't find any other reports that look like
>>>> Steven's oops, so maybe it really never happened and backporting isn=
't
>>>> called for.
>>>>
>>>> Or possibly my google-fu is just bad.
>>>>
>>>
>>> There might not be any issue with the original code because this bug
>>> could only be triggered when CONFIG_FLATMEM and CONFIG_MEMORY_ISOLATI=
ON
>>> are both set, which never happens, since CONFIG_MEMORY_ISOLATION
>>> depends on CONFIG_SPARSEMEM.
>
> Good point. Which means unset_migratetype_isolate() that Linus pointed
> out, is currently also safe as it's a CONFIG_MEMORY_ISOLATION code.
> We could still implement the suggested page_find_buddy() wrapper using
> page_is_buddy() internally, as well as the cleanup of __free_one_page()=
,
> but it's not urgent.
>
Sure. Will do that.

>>> By checking Steven's boot log, it should be PFN 0x21ee00 that trigger=
s
>>> the bug, since the physical memory range ends at PFN 0x21edff.
>>> PFN 0x21ee00 is 2MB aligned instead of MAX_ORDER-1 (4MB) aligned.
>>> The original code assumes all physical memory ranges are at least
>>> MAX_ORDER-1 aligned, which is true when CONFIG_SPARSEMEM is set
>>> (CONFIG_MEMORY_ISOLATION depends on it), since CONFIG_SPARSEMEM
>>> allocates pageblock_flags array (the NULL-deferenced bitmap points
>>> to) at section size granularity (128MB > 4MB). However, CONFIG_FLATME=
M
>>> does not do this. It allocates pageblock_flags array at the exact siz=
e
>>> of the physical memory. So checking 0x21ee00 will not cause NULL
>>> dereferencing when CONFIG_MEMORY_ISOLATION is set and the original
>>> if statement can be true.


For the record, the actual situation is that struct page of PFN 0x21ee00
is allocated but uninitialized. In CONFIG_FLATMEM, pageblock flags are
stored in zone->pageblock_flags. When reading PFN 0x21ee00's pageblock
flags, the page's zone is determined to be ZONE_MOVABLE, since page->flag=
s
is -1UL and page_zonenum() is 3. The system does not have ZONE_MOVABLE,
so zone->pageblock_flags is NULL and reading it caused NULL pointer
dereferencing.

>>>
>>> Now I am wondering if the page_is_buddy() check is correct for
>>> CONFIG_FLATMEM. Is mem_map allocation aligned to MAX_ORDER-1
>>> or just the present physical memory range? Is PageBuddy(0x21ee00)
>>> accessing some random memory location?
>>
>> OK. mem_map seems to be MAX_ORDER-1 aligned, so there is no
>> problem with PageBuddy(0x21ee00).
>
> Yeah mem_map has to be in all config variants, otherwise buddy merging
> would have been blowing up in page_is_buddy() even prior to all the
> "sometimes avoid merging pageblock" changes.
>>
>> --
>> Best Regards,
>> Yan, Zi


--
Best Regards,
Yan, Zi

--=_MailMate_3E6FB210-AD4D-4AA2-9919-369F76F3F378_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmJGJiAPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUP/UP/30HJ2ke/DePvgA3ZudF4Nu+W4yqwUUg94zh
v+AfAuwfb7MLUORGG8BYjYhz64/xs2MYSVPqQRLBWM37LhE4FQsGm3Bci4blqOE+
nVU4fpTksHOVTRWyJnoxSaLV+K8LM9gYeYwsNxKmGJ9i89Dqfljn0IOmPWtQJjnz
DmdK4QtJVZUheeHapAfEPnYFGxPQaBp8JHF+ASjLOwxqQglY6Wj2TVn/ZiZvkvZV
7OWKp+YiIGE8QHKM1eniq3hJV2X6sr/MDPvVkk6j0dfaQOv6Y6qpj91ZJE4wmTTf
HIAsh+kUDBB2gdwy2RdyglKE8LxGrJUQhV87vC/uvjGeDTzIsVqmoW95Ww5Usjjo
I5mF86ByXK2N3+nexsz/wEIvkWojJnhn+mbX+jBJQPzKk0TCJELscGK0cDieHtlJ
OEbwjyaR4O42XZIHDzHK+7HpkXTDrQ27jPQ5OY335uVmDSGQAmH/VaRLjuVSFW80
Mu6Yd0HiDKNtzQd7wwrnox5MsjS3Jw9w7iEjIlnEONcwz2vGWFhPXDyTWBxi9oZK
uf3M782yy/6IVmyhZlMcqVpNsLAZTHymQIANtqVW/S8lgIvWSri0IFN2f2HHtysu
yjyhYJEP8XXWzgw0lYjS1PUyRn+prcVzEusvyNhQhEdLQwxVTZWaVEY6Lf+qpqY0
nu+jqqmE
=gtGh
-----END PGP SIGNATURE-----

--=_MailMate_3E6FB210-AD4D-4AA2-9919-369F76F3F378_=--

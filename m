Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0FF4ED0B6
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 02:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352023AbiCaAMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 20:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343702AbiCaAML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 20:12:11 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2043.outbound.protection.outlook.com [40.107.102.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151A9B0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 17:10:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q0SxP790mFjwDGE0qk1HRSG2vuYZm5mhqpQRyjQ0RLXgP0mWZuVZtevrvshR6RQAiUsWVtBl6hkCV3VN+Gqlcg5SvJq8x5Kk6NjkHVDBVLK/d463UVe3ap3cxNSAj+52LPl3rqlM9uUTLeW5+LkwyxChClGvtDhd94TgSo8GquI49xxMtr0fIETojx5PYcbQaBBF8ceu/14lII3ZIS9ZyqX3EGsEkktVOfSjomVjQ5OWlz1dM6jxvcXrEuZaeV+CR19RAqqxzRJ3Ea2F9EhtCZrj6g1r5dZXVTW09KzNtFmPBohEIso41WAeW0Tcrym1ns1YnQel9Q8QnZxC5t8jpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lMEJ7Aw8bsnE57clCzDuBJonrMViRbIBixrzUmoYQeY=;
 b=EmRu/uk4+AvnOeQIUaS7o0s50LxuqClh4Vq6rUhXhe+1hE70RWtmRKGwVBpbRXh+3SsRFiW8izLusYfpu0rfavXlRZU4v6BTiEEYBA6v8mnyJnaK0J2KIht8sqigUQH/8YlcKvSCURe/wBbwxvcq7xjlrOc5fCFGqTZwOB+On7RFTx/4/7qQFDPfXi+GZ2whid1uJ7/pT9GDHUJrzpX1yobeCGX4684dL1OaeoVo7etGXvSQjrdcO6nQ/cHk1D2GH4UaKRP2754pEu7GjLOkKOCi/V9yz+3RSbD0NGryUn5xRuWRWpADYsnrDfcRRSMYLc2+XERdDRp0WyTmKLaN0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lMEJ7Aw8bsnE57clCzDuBJonrMViRbIBixrzUmoYQeY=;
 b=GExYPzIyFjj2f889EOXocYuCZjFrJTfzrTuglJ+WOsvF0EQ5WQhp6TMowhfRm5ieTJMmbgBjMYwqTizHi3KdYAPmBR2nQkAKkVAQ4vZtZEqn94n12HJaY+26VIuM7UxPnycuXSOAQ6R0S2JnOWAr2afhAojJWa/fJtyYc4XqZVsa76jiruEhqzH6YmbTsbgqY+o6HeqUNrw3FZAmIMZbGMisHeojNoD+XXzOUa9efSe2m9Frvin6aD53MtWw/uO861eebHeSytgfMwJJ0ntoGSDqlbvpC89M7leyFo4Vxq/ErR8X9RXcSKntyen32pa0CKoCw8YI30L2VFvb5I/r3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by SA0PR12MB4350.namprd12.prod.outlook.com (2603:10b6:806:92::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.20; Thu, 31 Mar
 2022 00:10:22 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::69f1:dff6:826b:7d9c]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::69f1:dff6:826b:7d9c%5]) with mapi id 15.20.5102.023; Thu, 31 Mar 2022
 00:10:22 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: page_alloc: validate buddy before check its migratetype.
Date:   Wed, 30 Mar 2022 20:10:20 -0400
X-Mailer: MailMate (1.14r5870)
Message-ID: <7586AEB3-FE81-4D51-ADAE-737E74625444@nvidia.com>
In-Reply-To: <63234E12-AF64-4D85-A2BF-8A4EF5359F91@nvidia.com>
References: <20220330221238.396357-1-zi.yan@sent.com>
 <CAHk-=whZ7d8Z4rv5oV9+FLEEk_1A1X=JsJaeAmFZzhDxLqDLFg@mail.gmail.com>
 <63234E12-AF64-4D85-A2BF-8A4EF5359F91@nvidia.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_6BF551C9-2F66-4F24-8894-52350FA3B962_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1P221CA0026.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::27) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb01ef21-9862-4521-5a49-08da12aad8e2
X-MS-TrafficTypeDiagnostic: SA0PR12MB4350:EE_
X-Microsoft-Antispam-PRVS: <SA0PR12MB435076B0330A652500C9217AC2E19@SA0PR12MB4350.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QttlME4BHFoN5dlTBzM7ocm0LMzKWJdWu7XW5fA8YUiATtEJzrKNAg4YB0kBC8HtSt4ZnTkwzq0kiWu0aGHh11tqTjFjrbhmUlxWZJHa0aq5BzMG1AkWGK5DbbH3ehiVCJD1lY/ftWvNyCTlXueuiPH5whAH2xnEk/BzRvtCyT3RaP+oz+oSDpfCkqDd+eqVDbGJMseJ/yEa9DnsrCHsyW0b59H0K7U7u/1PxnxCOO9n3sHF6lXTco988YDBVDKMKXUPB3SQc/ae9hZ+/u5/sqOXuX4qjj4b3lXOVWq760wUi3cuOD8qZgjajF7NukhNo7YGvAVy/Z/Nn2XjorYwJibz6clPZKCj4x1wGkez2WKVqJPo4LbChdpkaVJTGQMWgCwztTlr84rjRstF94QjrBrbmxaMmAWFEKmnuQqx9r2KG7VbcxDrpoy0SJb1mlZJn9YpdpC0WiHPfztZAayMXXA9ejkvOScAy4UJrGT3cK24z4yPIT5/rQe2LvRHri+TzO/LhpF02M5aZcKMoZDGq0a37kEZbbO+XkgADRsdUOe6/K2KIs3X/xec2oPF8BfGXp4IU3BL4vMQPvuVMS9CjTtO1jdkWNmWkUuayoI+qhbD2S/QJi7FY/JWa6mmy+DgDbop44J6RCQU+AIsml+7T2iPfSCHDmZG2MG1KMCJxwP+OFiQzKRtU50b5zGTxe4VoW79iHlC33STqtAi5BlTFcfaT50w04gSrcBoyadoYCI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(53546011)(5660300002)(2616005)(316002)(2906002)(6916009)(38100700002)(36756003)(86362001)(6506007)(508600001)(6512007)(66556008)(66946007)(8676002)(4326008)(6486002)(66476007)(186003)(7416002)(83380400001)(235185007)(21480400003)(8936002)(26005)(54906003)(33656002)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lQRCb1ZqOhfLnjuDUJ+pPwT32VEjbjD3bQvIgeP0LSMbvni1dnauac1wsRwp?=
 =?us-ascii?Q?j4m1VMPUS8KReSMBPFGzb1CtSw8L3gfstulhMbjkjkRHWlf0t/BSC/N3C/YD?=
 =?us-ascii?Q?KOcTiznMRJnJjoSkD1LTNFomrzD+0JwLAkI5KB4BSV94qPJoodyQzTWRvkH+?=
 =?us-ascii?Q?HoVToXaRVLk5RncqiNPHkAPmUjWUb05ZoCEMm4vN7eeuLAQGR4GJufVJhmDU?=
 =?us-ascii?Q?K7CShH/v2vqUGunwOH53U7l2yipp1Uo9Qt6LdAyHteOCrdfE5amDng6BA9Vf?=
 =?us-ascii?Q?zG7vtkALSHA6O6ZKCAORXRQgS4/u882cLHnkb7uTqpijJGT1Bsgv7NKUXxl7?=
 =?us-ascii?Q?8RYM7SJtJexKW9yM/HCK6Q7QzJWdqGMhrPLQvGxf/INx65lRTAKx20zrhRZi?=
 =?us-ascii?Q?kxvzoW3hqH2QyWwy/4hXnKBQb/jRMiMP+7N545F6mVIieY/NEpKRmRl/k8C5?=
 =?us-ascii?Q?FDwGTNoGFV2S8sbMrYAHQqeJrJX8ZNACr/KhjcoP1P1bAJw0NX1kPKl+6MJB?=
 =?us-ascii?Q?FfkQzxndoQy10OTalzxzBOeqyoJWW1rYq+0h9ZafgSKNzYGmUW+2pfhrKJec?=
 =?us-ascii?Q?th1Tubfk0/fIVJMHpwxCPfqg4GHiBG/qZFAr5MvXqO92v6+Uys23f58hcC9E?=
 =?us-ascii?Q?WPOGr3Ew8mPuwRyWaAiX8rx8D2+aLJdn5d4kbhWtRVaa/f81AR8N3KEOD3qi?=
 =?us-ascii?Q?NyqHj9b+tTAi+QYKBs1+NT7FEsPosnWsUL1MHcRZMwwXJebXxuFxzWS23S5m?=
 =?us-ascii?Q?c9Vd11g8mMzYK8AgduzeuEZWMcmJp52eVjVQYUcO2UCJ+XQvG+RK8cw/s9ub?=
 =?us-ascii?Q?+SSc8739su/ArbZdunMAiDNML6nCRpiuu947agBlz9X7fl9oHYsRQELS+yjN?=
 =?us-ascii?Q?0Vozyswq7l8DCZ3DeClRJbGPzqL7QwYw55JyiCbBj4oH8nQ3qgHrtfHIBGRX?=
 =?us-ascii?Q?vZzcc9X95ZE208ahBsQVrvqCfkhAv7S2sTNXzDEjrZXjWTZFSIZjWWBAEDwM?=
 =?us-ascii?Q?+kfgJ0qIZHr+zUmoVD67bAtZMu9Pk/SZtlDKqbPUU9rsSxTpQPkkNQ3jB8wB?=
 =?us-ascii?Q?UGSzN1IjSmJ3KDOHpN3n7Oku2tIxCw9zK0Lip3vVK/a8Tc0ikADyURcDW4pT?=
 =?us-ascii?Q?xpjoBQZVQY8Ji15T+vlRwZ/SAg8QJjKkKATlOH1c03fUhd6wci9kjENulsEF?=
 =?us-ascii?Q?yXBRQmk9bsH3XXxICuCPrFRriO7VZrx2Bb5znhvr28SPVfOVQ0SzuKeXYfmz?=
 =?us-ascii?Q?/ee3hEbVYgFQa5sUpTDAmGevRuKxsc5t6Aj7YJcQ/IK6yo//m+/Voy0N8Fkb?=
 =?us-ascii?Q?d3xDYOSKb5+N6zwvdOzPkUm5yg27wTmy3Pb0tIpJElMJvAOjq4Z22wYSUqsr?=
 =?us-ascii?Q?eYjYFk/NQrGaMORx89SvmfzvnyoWwUS/Q3oW/MtCMF0JBH2KA74dObhV6Ab0?=
 =?us-ascii?Q?BGQDHSxAZfPdekfmEqW+fA7+bu5jZ3lcaRNibx1Cx9Xpnlg90AEB8c+ophZA?=
 =?us-ascii?Q?xcpjQ7jzAAvFhyfH4Zz8iY4+EQpczwa7oSOcxATOtvjuDJntcRavFF2n+Nai?=
 =?us-ascii?Q?vXyryNQeAAQC035b3UOTlA0VMDmon2HYpIzhlZklSNWs9LMXQEhSstChDVMZ?=
 =?us-ascii?Q?AthZaOcCh1M6aXCYuCDFMNilq/B4lL2W8YJiLcvInPao4jwhlGK54Kt2x3jS?=
 =?us-ascii?Q?7o33iH6Em1WCKmXFTn5f1IZyqlITH37kja3BY8BYhZdXgmh4GYSs54O6UfiN?=
 =?us-ascii?Q?mAc2TIHcBw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb01ef21-9862-4521-5a49-08da12aad8e2
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 00:10:22.3643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cXOFE3a7cXYoZDeU4j0fo5RlXUM7nwrabHdQPZjH1tNmUx3jeKh4Oi3KF/gVTvNF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4350
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_6BF551C9-2F66-4F24-8894-52350FA3B962_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 30 Mar 2022, at 19:48, Zi Yan wrote:

> On 30 Mar 2022, at 19:03, Linus Torvalds wrote:
>
>> On Wed, Mar 30, 2022 at 3:12 PM Zi Yan <zi.yan@sent.com> wrote:
>>>
>>> Fixes: 1dd214b8f21c ("mm: page_alloc: avoid merging non-fallbackable =
pageblocks with others")
>>
>> Oh, btw - should this perhaps be backported further back than that
>> alleged "fixes" commit?
>>
>> It does look like maybe the problem potentially existed before too,
>> and was just much harder to trigger.
>>
>> That said, google doesn't find any other reports that look like
>> Steven's oops, so maybe it really never happened and backporting isn't=

>> called for.
>>
>> Or possibly my google-fu is just bad.
>>
>
> There might not be any issue with the original code because this bug
> could only be triggered when CONFIG_FLATMEM and CONFIG_MEMORY_ISOLATION=

> are both set, which never happens, since CONFIG_MEMORY_ISOLATION
> depends on CONFIG_SPARSEMEM.
>
> By checking Steven's boot log, it should be PFN 0x21ee00 that triggers
> the bug, since the physical memory range ends at PFN 0x21edff.
> PFN 0x21ee00 is 2MB aligned instead of MAX_ORDER-1 (4MB) aligned.
> The original code assumes all physical memory ranges are at least
> MAX_ORDER-1 aligned, which is true when CONFIG_SPARSEMEM is set
> (CONFIG_MEMORY_ISOLATION depends on it), since CONFIG_SPARSEMEM
> allocates pageblock_flags array (the NULL-deferenced bitmap points
> to) at section size granularity (128MB > 4MB). However, CONFIG_FLATMEM
> does not do this. It allocates pageblock_flags array at the exact size
> of the physical memory. So checking 0x21ee00 will not cause NULL
> dereferencing when CONFIG_MEMORY_ISOLATION is set and the original
> if statement can be true.
>
> Now I am wondering if the page_is_buddy() check is correct for
> CONFIG_FLATMEM. Is mem_map allocation aligned to MAX_ORDER-1
> or just the present physical memory range? Is PageBuddy(0x21ee00)
> accessing some random memory location?

OK. mem_map seems to be MAX_ORDER-1 aligned, so there is no
problem with PageBuddy(0x21ee00).



--
Best Regards,
Yan, Zi

--=_MailMate_6BF551C9-2F66-4F24-8894-52350FA3B962_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmJE8WwPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUo5EP/1uZdo4IZmuPAvIZlJRyq+6T++2x/ao/GJFz
Y5XKRsgro3Z63MPvSWwgLYXVsYxl/7/S3JgSc+5Xx/Hyevhw/zct7IYvLQ9/Cm2y
/WXG0C/Br6s6WIKBmB6CQrtXwhzuatuZs/SxWD0VX5oUCbGj8eSUjDEWVuUWqeYJ
LnY7WBq07C2wH6tnY56HVgGGGWJOEpxtGOWwuO4Dc6z24N2u0gwk3y5nxpguG02q
5O4pZq4OnjwflIW8LI/tE0g8kt2jw7X8XToVOr0zrq9ZLwFZXwGqG+NXsY1tp8+w
LKoi76m0PUtUXxs+v4z56eOSFu1NPTiUX3NebiDuDYiI5Zjn4NpKqPd5G7a+U9Oe
5Ml8U6IBJewdEsjhdCu1ubuWr8vU/kgDC8tXz2NzvyjCVCluR84Zz0nOVXPMpzcv
Amibbpbals46lEi3lkvpscZaF7xGPWnLGFYkXo206mYkqLZhsBTTXkbT4lZyc2s+
FlUcRu2mSmTwyXJd+fdeE7q63VGXJ837A03oWCFQO8RWNYkJrY6uJI+jMiQLGEJP
rt1oSopML1GvwdSU42Jry3vDSe2ENXqGzs5taaiy339pQ2NBK0zto0LH4cIXB2Cb
USFIoysN45GxXWxpy/mUJRsoh36/sIJr09Mxft4Ipdt4PX1etLT56dMLbZTb6SBt
Soky0r1W
=UatY
-----END PGP SIGNATURE-----

--=_MailMate_6BF551C9-2F66-4F24-8894-52350FA3B962_=--

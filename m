Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4860B510A65
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 22:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354693AbiDZU3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 16:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355099AbiDZU3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 16:29:22 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4F4496A3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 13:26:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AWYyhjzlIwFOX75ywnZdMhkBsADg7p0inZCVa/YPJqp4a3kZP7sUNS5o+iwVNFgNReaE96DreaccLlioCOskbLKRwUqKHJa3ujc5a5bwfS+eyA6+6/b+9JRcVn8fOcAwQ1RK0iZTjMKSUACv4YYkd/ULFQIV4t3R6FiX53aTo8dqSc9fdBCZZYgwLXLrgRcxbkJ8vn22aDpaETrTp0SRBy+Gsx2qVBTktmMeT2CPjalpRsSArTUfDw3/gHw9852zb7UC8BkAfUQvmFH1f6EE8CohNqGNYnqbO65FUfJFS7CyBv9s/ad3xNdZn1deCI2zV3MCGvH6ADhlTkw5biITYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SDKvpPlrI9rN5xSB+rhk8iubODbXxozYZEjXV+XHSHE=;
 b=d0CthhoIDYkf8nY+BB7g+s9/K6UGIJIhwycvT+EmCAW2MJhuQ0uRUKl+pgPNDHAUJWCD5UT84MIhiNz6myqX0OkCGJ3AcMLY3EQuWSJtciQRjr9Er5LFLYbxrzMezznKLm5tMxoG7SW2g8BJPeLh6SukIjEFmOxrEeNNgX4E5Wz0SsYptZccxj0gqQ0oItXe5FfWEMInNr/vlelnU9nFT+hju//fi4UrZGglk5g/LoGQoxddE3cdEbH3r2mfZprznTdxCFJ8Jq+amJtV2aCKveACffhev00vc89XpKRcZRDZMnw0+eUvCUUt7XS+UY85oHuTIl6HS7bq3ZvjFfdXdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SDKvpPlrI9rN5xSB+rhk8iubODbXxozYZEjXV+XHSHE=;
 b=sa2W5azOBZNwR1U/61BvyrvW5Du+zH2KyKFWSdwnX3ds2AAVKTlzhUoKc2hXnPK/3wKnoenH3NhtjgsgXVfYrWM8jH/ZzIXuKl908Dck82lUfkaj2tZ7wbJ+5eqldlmJnOXxmAXtQsezsjR11WTHiQkp2NueVgA83fdcjS0dippUeJLxYTFoBdWopbNzEh0Kd9XfiI1XgMeky6vvZ94/Rm0JF/vRGmKlKHMJR/ukk6awa0Ors1eZEB2qdZfbhQZocVy60mdS9ZxJh6YPbimd5JbsUHEANvzqqRhRkiLY9shte4bXhowJDfYpbBBXABu1FoW9xm+TBtt97/kWPsZNEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by CH2PR12MB4839.namprd12.prod.outlook.com (2603:10b6:610:b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.12; Tue, 26 Apr
 2022 20:26:10 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::920:970d:6f94:1f10]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::920:970d:6f94:1f10%4]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 20:26:10 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Eric Ren <renzhengeek@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v11 0/6] Use pageblock_order for cma and alloc_contig_range alignment.
Date:   Tue, 26 Apr 2022 16:26:08 -0400
X-Mailer: MailMate (1.14r5870)
Message-ID: <B621B4DD-5D11-4F0E-AFF5-F8684AE37E57@nvidia.com>
In-Reply-To: <20220426201855.GA1014@qian>
References: <20220425143118.2850746-1-zi.yan@sent.com>
 <20220426201855.GA1014@qian>
Content-Type: multipart/signed;
 boundary="=_MailMate_C241F173-DCD9-4A5F-863C-706EA67A973D_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR01CA0017.prod.exchangelabs.com (2603:10b6:208:10c::30)
 To MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b03f4e2-c643-45db-9e29-08da27c30046
X-MS-TrafficTypeDiagnostic: CH2PR12MB4839:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB483906EC0535E6C1E2967A14C2FB9@CH2PR12MB4839.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D4u5EFwmkAmdy+cWY5b0mD0QrfOowBuvvDDvXE1hs0KN0Gdc0xig1xjB2O1n+TpzyN41+ZSt0bgLFI9zDkpB6Fsch6nUZ26NpAJDuhzEmingPU0M05MrO1Z3YPygXLpmJtyq2LB5eFu19E0K7WFCSGAqhPA5cANiC+vjoKG5W6vF7lBU7P2aNoizQ1/TGzWd8HlvwH0g97aSFmDmMO7w6ycVqKrfWdDRH+u75KySpK0/iR++Bv6AXbBIYv1n+wLFzDz7ESO80g2IlMYvfYozQUlMQ6oVp8BoeSZTK6KaYIKiWk4A0GVLa7FOnFCM3No7c7x4vK7epZ76N+R8tgCcMIdpzg0rKZYmdf0u2AqqXyo3KssdnWuBUrIC90VLtJvONkQoU9jn0BxJw4crI6+0eAXHs1MpnjJM1jgBnMrj5DMqaY8mYliR7E2aNnKEep8Bn7NsQ9ZaFbh+qLWo0fQPWTrWdmFez8GBYQ4POThbDm9uEH2d8Re/7giUn91L0njulBFzoJSlSP3qtAekY6jfxK3RjwOZKDaMhyIxNYqXpPcjQlHlSgDC9HhdIFwAGBo7jyFOtbwh+kFiCQm7MmEg0uYK+OuWuWjh+wQZ/uTU/ODRFXaPBGkQ7uQOIhwsYiZtd1jYq+Ng7fAtQnTWdg0FEuWnLX3IorDu0Bptia5j75SMiyFKWIuQQxB75aDLNZcqy/7lafSq+XWmQvGjv5825krX+Q7KqUrNefyPkUpN0VG7oPoI/KA5lxra6PwA5m/fJCHtGLGFxNaHOwTwQImv/faZgyMDfGIGki9Hg9cbgR1KgMXZlB86X4UkCiGrDil4LBvSa3Leypps4ubF1o3PB6VyA08H/gHhEiC42Wum9Ng=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(66556008)(4326008)(66476007)(8676002)(83380400001)(186003)(21480400003)(26005)(2906002)(6512007)(86362001)(6506007)(53546011)(6486002)(966005)(508600001)(5660300002)(33656002)(8936002)(7416002)(2616005)(235185007)(45080400002)(30864003)(38100700002)(316002)(54906003)(6916009)(36756003)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IsFlZvrHWkxSiTfkAorqHPWxSCF/Od9UuyRpHTy9b6bWylmW3Bw/QlqRer76?=
 =?us-ascii?Q?/EeE1BNc8eR8Zh2HSZ7CyrQMGzg9oKnvWYmiuuCqrlVS5xcmN6lQaEKr3qCm?=
 =?us-ascii?Q?9rF1aPUjY7sx0Od8q2Mcu99yqJDaRWOKw0SKiZ/tNFqdas9agGEFiJUR7umx?=
 =?us-ascii?Q?GnGJpgdCZmvB2dBOHTFJat39HK2R0ojSqEAu/GxuV8yxodsg6+LMSbdqhJg+?=
 =?us-ascii?Q?TrveAXqYtDLyIndnPZrER1OuQeYlga1qqQ1q3G0UKPS91UF/CTOo7VdmnKhU?=
 =?us-ascii?Q?sVDS+AiHZgpZYAGhQSHMm9FiQNuR+RVlGPsVH00S9ryEN18Es0RjFNRWyAco?=
 =?us-ascii?Q?iVzCpv4FpFn/rXY+MyKQ11UNBoPoDqBqFpGMwM+tiWY1tXZareve0Rb0CCVm?=
 =?us-ascii?Q?NUbbjfbIBHYb6ZMLPnXl3DlCDApk3C/6Hpvk3vv31sCXmSZP96RDaDAgo34c?=
 =?us-ascii?Q?UrE6Rpx+AuJ3km8P8vbXDbhS5FWybVyCDp6Gj7JUv0Y/jOwefEWpmR4MvZMU?=
 =?us-ascii?Q?nHr094j7IaniMVTeUCdFSmCkqU7t9HUq0bQQVpU7wJ2SxdUcvz0j3Zogdhdp?=
 =?us-ascii?Q?AdeR9XnyY6PZQfKtRSkzElbxG7LvdmC+1tfsclIdgY/0WbvcEKpDg9T6j3jC?=
 =?us-ascii?Q?1RoJtgtfu7kxbB1SNJst/ZSccDJQcsoAxSkPESHSpAuSDDCNz8DgN0SIqvdl?=
 =?us-ascii?Q?Xf96wXGfJOvVjcNUZtb8CNgn7s3LSHupiphNY2t4+yH6mxMcU/iDWl6LqZQ4?=
 =?us-ascii?Q?wFOPJ4Y5Yp3V0Tk8lgxPB2vb+f/F0TIV92P5vuSMhm1L5muOWAL6cakRP+rw?=
 =?us-ascii?Q?sfUfJialZZqReHPhraUFcCiZ8Vd+t3YkRNEvH5/1mHRpIhgvX611zC5gd6TN?=
 =?us-ascii?Q?qKp3Kot9dYbE17PirtqGbUGGMDIVqLZGtnVwBNZ2L1gL1Yj3J/txqx5fN3CA?=
 =?us-ascii?Q?C220z2Yjn115cjzGGKqmN7/ZF6SD5XzmhCledWAtDVItKiMm98XWthYsYVz1?=
 =?us-ascii?Q?H6Rp/u+/bZWjRalUEujP46TzRoM6PQ4kIotCB19nhtKKFO5gsEXKX/pSpSKp?=
 =?us-ascii?Q?QsZE4NOltxs9ZrptTgKTejYR5ARsxOZymWvwYkBFalc8eFWoBit93/kKImvm?=
 =?us-ascii?Q?xTNstY8OBGp5KjK0lwKm2QCtzY8d2usS5FsA/lYKkItTSMP0+VWVGKEMJ2VL?=
 =?us-ascii?Q?Myg91Cb6DgN/xuEwm3HC+aeIG8duYUKzxtuoWfHusOvm+/PAc0RyPWNaedR/?=
 =?us-ascii?Q?WYXr5ZwtQIIGaIWrsa+embN27YBaeSaPdVJPW79zLHH2KznUOcFykuxLQF3D?=
 =?us-ascii?Q?nXm4XqUg4Hy2PNodiWeYOHg69OIukvTKfOeUhpupwzwfp4xBpepM0o+L7be3?=
 =?us-ascii?Q?BrLUVT9uRW80lKm4jvwepGzdpNmr9qBeTjFr93DcF+NHfJIEp7GD/HGFqy44?=
 =?us-ascii?Q?uHy63h+2RrSYFJzFodBlrVV3a0Kiid4A5fl7cBkOVMte+iKnPgrFCuLEFcT3?=
 =?us-ascii?Q?wft1Nml5Gp1UdTdLhekFuDb72E0hT2AWe2pkh3vEnwe6MGWw8G+nO3bxDkki?=
 =?us-ascii?Q?yB/M50FBK2zOvoSm1eB3nwnKfKjVie8y4crLG2RsYlybapi9gT3nvcXsbU1p?=
 =?us-ascii?Q?hhjR2H+EPocadQE1s3RD9Cybz6Ffl2eWqZIbAmWd7fc99TSyYKCrMuti0LOf?=
 =?us-ascii?Q?mm7VYyA45uaV5Pz3NyGJQJ+HBXL600uHo9ZIb8uBIh0cni9c3NCWBoxcTs/P?=
 =?us-ascii?Q?HgfAh8HdIg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b03f4e2-c643-45db-9e29-08da27c30046
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 20:26:10.4330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 43mcbXxP/KAJDnm3bhkZE+FqOOZFtND+hDB9WkCKHBrW5aKRKzqv2SYXpKVi8xqO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4839
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_C241F173-DCD9-4A5F-863C-706EA67A973D_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 26 Apr 2022, at 16:18, Qian Cai wrote:

> On Mon, Apr 25, 2022 at 10:31:12AM -0400, Zi Yan wrote:
>> From: Zi Yan <ziy@nvidia.com>
>>
>> Hi David,
>>
>> This patchset tries to remove the MAX_ORDER-1 alignment requirement fo=
r CMA
>> and alloc_contig_range(). It prepares for my upcoming changes to make
>> MAX_ORDER adjustable at boot time[1]. It is on top of mmotm-2022-04-20=
-17-12.
>>
>> Changelog
>> =3D=3D=3D
>> V11
>> ---
>> 1. Moved start_isolate_page_range()/undo_isolate_page_range() alignmen=
t
>>    change to a separate patch after the unmovable page check change an=
d
>>    alloc_contig_range() change to avoid some unwanted memory
>>    hotplug/hotremove failures.
>> 2. Cleaned up has_unmovable_pages() in Patch 2.
>>
>> V10
>> ---
>> 1. Reverted back to the original outer_start, outer_end range for
>>    test_pages_isolated() and isolate_freepages_range() in Patch 3,
>>    otherwise isolation will fail if start in alloc_contig_range() is i=
n
>>    the middle of a free page.
>>
>> V9
>> ---
>> 1. Limited has_unmovable_pages() check within a pageblock.
>> 2. Added a check to ensure page isolation is done within a single zone=

>>    in isolate_single_pageblock().
>> 3. Fixed an off-by-one bug in isolate_single_pageblock().
>> 4. Fixed a NULL-deferencing bug when the pages before to-be-isolated p=
ageblock
>>    is not online in isolate_single_pageblock().
>>
>> V8
>> ---
>> 1. Cleaned up has_unmovable_pages() to remove page argument.
>>
>> V7
>> ---
>> 1. Added page validity check in isolate_single_pageblock() to avoid ou=
t
>>    of zone pages.
>> 2. Fixed a bug in split_free_page() to split and free pages in correct=

>>    page order.
>>
>> V6
>> ---
>> 1. Resolved compilation error/warning reported by kernel test robot.
>> 2. Tried to solve the coding concerns from Christophe Leroy.
>> 3. Shortened lengthy lines (pointed out by Christoph Hellwig).
>>
>> V5
>> ---
>> 1. Moved isolation address alignment handling in start_isolate_page_ra=
nge().
>> 2. Rewrote and simplified how alloc_contig_range() works at pageblock
>>    granularity (Patch 3). Only two pageblock migratetypes need to be s=
aved and
>>    restored. start_isolate_page_range() might need to migrate pages in=
 this
>>    version, but it prevents the caller from worrying about
>>    max(MAX_ORDER_NR_PAEGS, pageblock_nr_pages) alignment after the pag=
e range
>>    is isolated.
>>
>> V4
>> ---
>> 1. Dropped two irrelevant patches on non-lru compound page handling, a=
s
>>    it is not supported upstream.
>> 2. Renamed migratetype_has_fallback() to migratetype_is_mergeable().
>> 3. Always check whether two pageblocks can be merged in
>>    __free_one_page() when order is >=3D pageblock_order, as the case (=
not
>>    mergeable pageblocks are isolated, CMA, and HIGHATOMIC) becomes mor=
e common.
>> 3. Moving has_unmovable_pages() is now a separate patch.
>> 4. Removed MAX_ORDER-1 alignment requirement in the comment in virtio_=
mem code.
>>
>> Description
>> =3D=3D=3D
>>
>> The MAX_ORDER - 1 alignment requirement comes from that alloc_contig_r=
ange()
>> isolates pageblocks to remove free memory from buddy allocator but iso=
lating
>> only a subset of pageblocks within a page spanning across multiple pag=
eblocks
>> causes free page accounting issues. Isolated page might not be put int=
o the
>> right free list, since the code assumes the migratetype of the first p=
ageblock
>> as the whole free page migratetype. This is based on the discussion at=
 [2].
>>
>> To remove the requirement, this patchset:
>> 1. isolates pages at pageblock granularity instead of
>>    max(MAX_ORDER_NR_PAEGS, pageblock_nr_pages);
>> 2. splits free pages across the specified range or migrates in-use pag=
es
>>    across the specified range then splits the freed page to avoid free=
 page
>>    accounting issues (it happens when multiple pageblocks within a sin=
gle page
>>    have different migratetypes);
>> 3. only checks unmovable pages within the range instead of MAX_ORDER -=
 1 aligned
>>    range during isolation to avoid alloc_contig_range() failure when p=
ageblocks
>>    within a MAX_ORDER - 1 aligned range are allocated separately.
>> 4. returns pages not in the range as it did before.
>>
>> One optimization might come later:
>> 1. make MIGRATE_ISOLATE a separate bit to be able to restore the origi=
nal
>>    migratetypes when isolation fails in the middle of the range.
>>
>> Feel free to give comments and suggestions. Thanks.
>>
>> [1] https://lore.kernel.org/linux-mm/20210805190253.2795604-1-zi.yan@s=
ent.com/
>> [2] https://lore.kernel.org/linux-mm/d19fb078-cb9b-f60f-e310-fdeea1b94=
7d2@redhat.com/
>>
>> Zi Yan (6):
>>   mm: page_isolation: move has_unmovable_pages() to mm/page_isolation.=
c
>>   mm: page_isolation: check specified range for unmovable pages
>>   mm: make alloc_contig_range work at pageblock granularity
>>   mm: page_isolation: enable arbitrary range page isolation.
>>   mm: cma: use pageblock_order as the single alignment
>>   drivers: virtio_mem: use pageblock size as the minimum virtio_mem
>>     size.
>>
>>  drivers/virtio/virtio_mem.c    |   6 +-
>>  include/linux/cma.h            |   4 +-
>>  include/linux/mmzone.h         |   5 +-
>>  include/linux/page-isolation.h |   6 +-
>>  mm/internal.h                  |   6 +
>>  mm/memory_hotplug.c            |   3 +-
>>  mm/page_alloc.c                | 191 +++++-------------
>>  mm/page_isolation.c            | 345 +++++++++++++++++++++++++++++++-=
-
>>  8 files changed, 392 insertions(+), 174 deletions(-)
>
> Reverting this series fixed a deadlock during memory offline/online
> tests and then a crash.

Hi Qian,

Thanks for reporting the issue. Do you have a reproducer I can use to deb=
ug the code?

>
>  INFO: task kmemleak:1027 blocked for more than 120 seconds.
>        Not tainted 5.18.0-rc4-next-20220426-dirty #27
>  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this messa=
ge.
>  task:kmemleak        state:D stack:27744 pid: 1027 ppid:     2 flags:0=
x00000008
>  Call trace:
>   __switch_to
>   __schedule
>   schedule
>   percpu_rwsem_wait
>   __percpu_down_read
>   percpu_down_read.constprop.0
>   get_online_mems
>   kmemleak_scan
>   kmemleak_scan_thread
>   kthread
>   ret_from_fork
>
>  Showing all locks held in the system:
>  1 lock held by rcu_tasks_kthre/11:
>   #0: ffffc1e2cefc17f0 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_=
tasks_one_gp
>  1 lock held by rcu_tasks_rude_/12:
>   #0: ffffc1e2cefc1a90 (rcu_tasks_rude.tasks_gp_mutex){+.+.}-{3:3}, at:=
 rcu_tasks_one_gp
>  1 lock held by rcu_tasks_trace/13:
>   #0: ffffc1e2cefc1db0 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at=
: rcu_tasks_one_gp
>  1 lock held by khungtaskd/824:
>   #0: ffffc1e2cefc2820 (rcu_read_lock){....}-{1:2}, at: debug_show_all_=
locks
>  2 locks held by kmemleak/1027:
>   #0: ffffc1e2cf1aa628 (scan_mutex){+.+.}-{3:3}, at: kmemleak_scan_thre=
ad
>   #1: ffffc1e2cf14e690 (mem_hotplug_lock){++++}-{0:0}, at: get_online_m=
ems
>  2 locks held by cppc_fie/1805:
>  1 lock held by in:imklog/2822:
>  8 locks held by tee/3334:
>   #0: ffff0816d65c9438 (sb_writers#6){.+.+}-{0:0}, at: vfs_write
>   #1: ffff40025438be88 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_i=
ter
>   #2: ffff4000c8261eb0 (kn->active#298){.+.+}-{0:0}, at: kernfs_fop_wri=
te_iter
>   #3: ffffc1e2d0013f68 (device_hotplug_lock){+.+.}-{3:3}, at: online_st=
ore
>   #4: ffff0800cd8bb998 (&dev->mutex){....}-{3:3}, at: device_offline
>   #5: ffffc1e2ceed3750 (cpu_hotplug_lock){++++}-{0:0}, at: cpus_read_lo=
ck
>   #6: ffffc1e2cf14e690 (mem_hotplug_lock){++++}-{0:0}, at: offline_page=
s
>   #7: ffffc1e2cf13bf68 (pcp_batch_high_lock){+.+.}-{3:3}, at: zone_pcp_=
disable
>  __zone_set_pageset_high_and_batch at mm/page_alloc.c:7005
>  (inlined by) zone_pcp_disable at mm/page_alloc.c:9286
>
> Later, running some kernel compilation workloads could trigger a crash.=

>
>  Unable to handle kernel paging request at virtual address fffffbfffe00=
0030
>  KASAN: maybe wild-memory-access in range [0x0003dffff0000180-0x0003dff=
ff0000187]
>  Mem abort info:
>    ESR =3D 0x96000006
>    EC =3D 0x25: DABT (current EL), IL =3D 32 bits
>    SET =3D 0, FnV =3D 0
>    EA =3D 0, S1PTW =3D 0
>    FSC =3D 0x06: level 2 translation fault
>  Data abort info:
>    ISV =3D 0, ISS =3D 0x00000006
>    CM =3D 0, WnR =3D 0
>  swapper pgtable: 4k pages, 48-bit VAs, pgdp=3D00000817545fd000
>  [fffffbfffe000030] pgd=3D00000817581e9003, p4d=3D00000817581e9003, pud=
=3D00000817581ea003, pmd=3D0000000000000000
>  Internal error: Oops: 96000006 [#1] PREEMPT SMP
>  Modules linked in: bridge stp llc cdc_ether usbnet ipmi_devintf ipmi_m=
sghandler cppc_cpufreq fuse ip_tables x_tables ipv6 btrfs blake2b_generic=
 libcrc32c xor xor_neon raid6_pq zstd_compress dm_mod nouveau drm_ttm_hel=
per ttm crct10dif_ce mlx5_core drm_display_helper drm_kms_helper nvme mpt=
3sas xhci_pci nvme_core drm raid_class xhci_pci_renesas
>  CPU: 147 PID: 3334 Comm: tee Not tainted 5.18.0-rc4-next-20220426-dirt=
y #27
>  pstate: 10400009 (nzcV daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
>  pc : isolate_single_pageblock
>  lr : isolate_single_pageblock
>  sp : ffff80003e767500
>  x29: ffff80003e767500 x28: 0000000000000000 x27: ffff783c59963b1f
>  x26: dfff800000000000 x25: ffffc1e2ccb1d000 x24: ffffc1e2ccb1d8f8
>  x23: 00000000803bfe00 x22: ffffc1e2cee39098 x21: 0000000000000020
>  x20: 00000000803c0000 x19: fffffbfffe000000 x18: ffffc1e2cee37d1c
>  x17: 0000000000000000 x16: 1fffe8004a86f14c x15: 1fffe806c89e154a
>  x14: 1fffe8004a86f11c x13: 0000000000000004 x12: ffff783c5c455e6d
>  x11: 1ffff83c5c455e6c x10: ffff783c5c455e6c x9 : dfff800000000000
>  x8 : ffffc1e2e22af363 x7 : 0000000000000001 x6 : 0000000000000003
>  x5 : ffffc1e2e22af360 x4 : ffff783c5c455e6c x3 : ffff700007cece90
>  x2 : 0000000000000003 x1 : 0000000000000000 x0 : fffffbfffe000030
>  Call trace:
>  Call trace:
>   isolate_single_pageblock
>   PageBuddy at ./include/linux/page-flags.h:969 (discriminator 3)
>   (inlined by) isolate_single_pageblock at mm/page_isolation.c:414 (dis=
criminator 3)
>   start_isolate_page_range
>   offline_pages
>   memory_subsys_offline
>   device_offline
>   online_store
>   dev_attr_store
>   sysfs_kf_write
>   kernfs_fop_write_iter
>   new_sync_write
>   vfs_write
>   ksys_write
>   __arm64_sys_write
>   invoke_syscall
>   el0_svc_common.constprop.0
>   do_el0_svc
>   el0_svc
>   el0t_64_sync_handler
>   el0t_64_sync
>  Code: 38fa6821 7100003f 7a411041 54000dca (b9403260)
>  ---[ end trace 0000000000000000 ]---
>  Kernel panic - not syncing: Oops: Fatal exception
>  SMP: stopping secondary CPUs
>  Kernel Offset: 0x41e2c0720000 from 0xffff800008000000
>  PHYS_OFFSET: 0x80000000
>  CPU features: 0x000,0021700d,19801c82
>  Memory Limit: none

--
Best Regards,
Yan, Zi

--=_MailMate_C241F173-DCD9-4A5F-863C-706EA67A973D_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmJoVWAPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUiXwP/0X2c1iH/Zo/rxkAeRtQkZ4U7daZBNBm77ts
kh6Qqj1wI1GXdXJC9n2RAuQVWmQzPtvRpiPiA7AhXwRB8YsWHAuS+kwnwWuzRZ3l
wUaAzcL7uXCRGw4Kbd02S3ZI8EzRw9YjQFHI5S+wVwdVbeVfmnseB4jnUEO+ftyb
mV2pvB5rju3VIXdjGcb0DE38w2A7+hTIgRe7PoXO0v7JAm8TSALtPLT4XpT705PV
X6ThBA2jKQXS6TDWbDJseUXbzTGvZgvr7f7YxOQonhpj4tvwMRPPSSnP1lExXteU
gEwpLNuKbUU1Lx4SxNHQLLo34JxOxyF2ujcYnzqZPAWS9+ynJMLc1iGaMxRJ1QmU
O7A+te6L6jFauvuUJeBhdzNMJuVwL68Q0tgo0Td/QTBlWT/GRIrF+3Ch1n46C07z
mCPiijBj04J/phWd85EIwOKZgNVtLGXqMy1y9ON618QMtirytBC+QuF4fsUcCzFN
jhC824dlOoZPl2PJX2Wa48a3Rbme7MHj7xEKrPlO/3rZg60dUZ4AObtWht9g3/3r
qMGtcI1Kz6u94bNip+NeKGDxgPLIXYQqwXozzLfXdIaMN4NQIdvfANvqLsTB9oTK
tf/UY1I9ser8zZAZnHOwSQadlHBvrXt46PC94YVOutf/lEMLmLLg2iHENZNfbc2q
VClWFXaA
=gaWN
-----END PGP SIGNATURE-----

--=_MailMate_C241F173-DCD9-4A5F-863C-706EA67A973D_=--

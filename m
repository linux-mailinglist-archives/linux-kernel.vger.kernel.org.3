Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22DC84FEC59
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 03:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbiDMBj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 21:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiDMBjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 21:39:55 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2051.outbound.protection.outlook.com [40.107.95.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AABB4B87C
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 18:37:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DconjhDp6EzL5aQWW4bvj6CTT7QEWwZLswEfUGT/UlypolM0TEaTDXTjExEWhWygmUwRuKOvAcH0JsI3/w7BuzwAuZTVqp5bzAugMzEDRJE43Xr/Br1ijp32KuKnrzekgCS5lE3pbwV8Ccd9zErwWTzIOGyLHiU2qTcD2AP1BYwydzBLnH3HLqhbKkOhcS0p7LnlCmWvdQqsjVzTa22MQuhBngheqmHLSd6GEqgohTqivWm8/CminSGlUGOdhjKhYdTBpZjBrQD6y2fKmgUB41aOsW3DZvr4ATVBcF/FMd/PGkj7Kb/H8OZhsrv2nQmMHBGnj7qca+kBB/SQHK51fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=clF/vE5L/DhmJceSjSr4YyVuixPkWjkStoa8U3n3ORg=;
 b=BJUJRuLSok5DguA3sr/WVCOLSVd2hOqh9M5cadqI1pmObQikhDZiAOmas//fmUgq0G3nuF0Dt6d5FlNVyEDqtTVrUaOurUWUh8ndNQF9HxKvx+dJwhvPZT7QaZOf50B9FIXmfdsLYgO9/tiRsUJ5LDK6B8zaT7KQAMg1g8ngGY+j3PyHCeUZ5euC+Uh6yuNOUERXeuXqVeoqxegeVEoOeVUORJtKgg1fGdvPvWTDmqnZ5HMsgHm/bPlVHXpa/TLDYeRKBnk6lvHfBWFvx11IONlBlX2TD+EvCmHYubyk1Th0gCr9djwkLy4Ggae+yDxmRC3nEMzPr+/KLSGOJ/ORhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=clF/vE5L/DhmJceSjSr4YyVuixPkWjkStoa8U3n3ORg=;
 b=thBwIusnjT9JH38gCbf6dm0bgLYaDVqhC3WceurMu8vycCgywe3NxcKIgg+jzLq+L9g3gBBtKT8J2zzGsoFmEn6lC1uHtOt0LwNNVbnXS+ReHg9cpE0EE/lmbTq2KxbKGekL3yXzUQuGlzzsZ/Uj7lKd5sX/ixxm9A92kjy4mt6b/5IPB5E4SO4Kw+kLl/VTQrOT+/OtLQBz6hBMf3RegocRlRhlRVGJixNvl9/UQf7meYeJNgFykoFx0AQBl75OySWFTAZkAeUnDqgKCx/wfBgW5VnL52Mj60Giv+Bp2zrH8FQEKAqACne5JcOAKrvLO324HRTg5dpMz/IJPnYRTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by MW3PR12MB4586.namprd12.prod.outlook.com (2603:10b6:303:53::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Wed, 13 Apr
 2022 01:37:32 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::2d17:b68a:e101:4c18]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::2d17:b68a:e101:4c18%6]) with mapi id 15.20.5144.029; Wed, 13 Apr 2022
 01:37:32 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [PATCH v8 01/23] mm: Introduce PTE_MARKER swap entry
Date:   Wed, 13 Apr 2022 10:30:33 +1000
References: <20220405014646.13522-1-peterx@redhat.com>
 <20220405014646.13522-2-peterx@redhat.com>
 <87bkx7ayfs.fsf@nvdebian.thelocal> <YlXWzf3nF+lGA5fn@xz-m1.local>
User-agent: mu4e 1.6.9; emacs 27.1
In-reply-to: <YlXWzf3nF+lGA5fn@xz-m1.local>
Message-ID: <8735ihbw6g.fsf@nvdebian.thelocal>
Content-Type: multipart/mixed; boundary="=-=-="
X-ClientProxiedBy: BYAPR07CA0008.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::21) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ece6ac03-a639-4dac-a590-08da1cee2cd2
X-MS-TrafficTypeDiagnostic: MW3PR12MB4586:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB45861F205C80BC29649ACAE8DFEC9@MW3PR12MB4586.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qe59RPWhALG6j7Yxv0BWlyyc1ZCnyz6DLz4i7AUBYRQjgnAcxHDYgIAVakqMPgGGSC/7/j+9/5yr0eND+BARDqvlpuTz4Tr3URxEyXvULz2J6HLZ4JC7CVo2y7vztBRBNeEZtE/qI5dfRpsKhjTl2CiVCpn/nbaLMASOtHa8NaFdI7QvTPaKTFMfXhd+Kf2vfxSbFRTCN07hIiXQr+xvX3JdsRcc3kyIU9ukvuWW03fGuEpYKJsOts1oe6AZC9YVbtL9hIsAE99ytcZzQIV+ZpQuKNcWD/XsbjC5Tb1CBQMDUFFYLmhncstyZ9xxxyDVTOgJpjhQxjPDlml10OQROcsXLz5SENuwDbwa2XsK/SIbCOa/CN75gH5oIVGMG8qY4vfjoqop7vm+E2UqA2Va8g1UW7sXtz4PALB0NadO+dhfLO/t3bsi6zj9tUukEYGc2VfXwGOr8b8j9hnDD4JmEFf7P0boRve/vjdfHvGxUv1M7lbauvMxJ6ZB/08rrP7E7OveF+hog4bYPXM9TtyGmZKEU1LAnxjOtOhtwcDoiMeVrLYLkjaBBrq7L1O083ZVJJpGf8YBNadQLwlfz2koJ42PGT5+yXvot1RrLvVEQdYquT+NytKP6VImXSg/wlGyO+G4fL2iwwCoWnvK2hGEXBv5FhT6pN5FxWBDj7IUhZqA06iOKybIE9KOQmcamwFS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(8936002)(4326008)(8676002)(7416002)(5660300002)(26005)(186003)(2906002)(83380400001)(508600001)(86362001)(66946007)(316002)(66476007)(54906003)(66556008)(6506007)(6512007)(44144004)(9686003)(38100700002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eWkeK/sD07F/5j4AjlTxhjru9iAkMNJe76TTJfyEFMCYjLNnMcUNLcq/jgm8?=
 =?us-ascii?Q?DYldQP1U8JP115uosRg3zjuuLF+KVEjWcZl934k8He03iaRco19uUYAi4REc?=
 =?us-ascii?Q?AiWqL5ebkEECWh/rMF5MyTYLE5BKV0IObFCcjzqir1yD1THKl8jPGyium3+p?=
 =?us-ascii?Q?nC9YKSfvaN5nSsdYX7IsJJeoj1xrAOhf6Pizxk57y2VJ13vnjm5hiiR5agYv?=
 =?us-ascii?Q?Hjqr1HUi05lDvNgu/Q4Gr4U5Mdux1XMK4ZARAiCJn5EDoavbC7ejoVXuhHjY?=
 =?us-ascii?Q?pMeVlqfb+oba8JK1nT6TSRetKZfHR2SzTHPxSrYN7dfdeoeqUvx/gLmuTwKH?=
 =?us-ascii?Q?HCRaY9rvPOBg/pJqnIXBTxPGqw4ovfDDPQEQsxntjIHW7c2lC/M4AIZriWEI?=
 =?us-ascii?Q?MVmSPqb4O2+7jpL0D+6I23oWs3PgU9+AVWR3GgBBZ5zBnM29jPEYTMy9fCw9?=
 =?us-ascii?Q?Kr1tYo1W1zNKUgxZVOwUPYDVCb9jbBG8DYpt2eeQrUjBYTivdSkrAEECLcZs?=
 =?us-ascii?Q?DjDsVDUJphh/azfilKXa75R7R8xGcJZswPGR8C92un+3VVJ5jPYqEkPbNJhi?=
 =?us-ascii?Q?IgtDUuuMfBjVxKPz+xlklLUBAKpS2XpGvSIJgpKxsWLlJZOhr/8eJrgpDRak?=
 =?us-ascii?Q?hJy9x+H4urCbvVC59ztujjiSM4SZ7nVg0ke4eDK/Lzk3R5ugR/JeetUUEVRD?=
 =?us-ascii?Q?yyEIXpZXSnQckMH8yhClVqK4exkVGlJb3tNkrpRZ6mJKmR86YVuBM8CSiejE?=
 =?us-ascii?Q?zyWU7NzPVm06XyOGkQ99Wpen7xKI/t9xSqkr7Mhj8VdkztRmdJvkkbIbpS8f?=
 =?us-ascii?Q?nSkEt+1qTsZDJvzMH5n/gaFa05p5T6fVbM6/AaIBLJSXp3LHwd3/ljgZmiOS?=
 =?us-ascii?Q?Z/M5eST01gaf1d3LzlMz3iYGrdmKuoyQfNxM056q5NUJn/nATIHa8h6c8tNJ?=
 =?us-ascii?Q?ck4PGK55tCZhZslItgtoIo4LplxOZI42aJE7W2rjYoTu9MGTbQBFhaR9bSeD?=
 =?us-ascii?Q?1U4W0RMyky7Ofi1ocpSQNvT0BAWn18KqmR8IkLO0/TNEOkAzKP4QtK2W/BBp?=
 =?us-ascii?Q?K0ELaAb/3/+99pkrUz6hwSCuejEOxa56hr2XrMMmzWV1xa6sh+U0oI3Y7WPu?=
 =?us-ascii?Q?ok/PWcYbOfUpS8eaGMD0xDB/lw4iQjbntZbwtkRhAFT6zx1xBfxY5COLkk2l?=
 =?us-ascii?Q?vU3PHKlE+FlksD5TlyGUKjC7TXCLRPJfKqZvt3/E60nrMhiR85/aSx4c4Kmz?=
 =?us-ascii?Q?grQrILtsyQg8eoCMv/UA+VKdYuYEju8HyiyRgGrG0bT4X6ZLKwnP0i+n22O0?=
 =?us-ascii?Q?YKfolrK7aNhdztMymUjdtWkTJrblhaXXdxQFe0VsIQXqvxAVUNw/9ya+DCBt?=
 =?us-ascii?Q?SOdLZmQn+ie09eA+7EUoFw355Xh2fKa8uIBgc8/Dg5jK937t9ptVTJcRXB7q?=
 =?us-ascii?Q?qG+swe3na+qNZOx1QPcsUMzsaXdWJNojJhdZ5O/ZlqyL5LQvoc/vbYToGCjN?=
 =?us-ascii?Q?m3p3H5ixaQ6K9dc614OVMsTb0lLsSBSeFEI6Qgy5jT3eDcCd5HCmDYpRN7Ci?=
 =?us-ascii?Q?jIZqhhLmPYGjeHXTJTzEoQVeh2y+cWjYv1wN6NTNluLeXLnYNj9nVzfS9JgY?=
 =?us-ascii?Q?COk7YWJJJe59P0HZyRRiMaOqNQZ/WIi3A1I8O/T8nCSn8bKhWjqSzs/3MCp9?=
 =?us-ascii?Q?X2Gm4JOXg7QKl34it5jrvd2Gs6GTL2c/t/BPGMZ6IvRzzVWSpqPhwKgEHHE+?=
 =?us-ascii?Q?E7FZEm2F6Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ece6ac03-a639-4dac-a590-08da1cee2cd2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2022 01:37:32.7235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: njHwQqCzsxzRsCswHlVMHjW+g2nC5m7vAAeHFk5LrD4Ahtl38f7XlGeJnk8n+YieA8lhwDf0WQympAMJAEwZtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4586
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Disposition: inline

Peter Xu <peterx@redhat.com> writes:

> On Tue, Apr 12, 2022 at 11:07:56AM +1000, Alistair Popple wrote:
>> Hi Peter,
>
> Hi, Alistair,
>
>>
>> I noticed this while reviewing the next patch in the series. I think you need to
>> add CONFIG_PTE_MARKER to the below as well:
>>
>> #if defined(CONFIG_MEMORY_FAILURE) || defined(CONFIG_MIGRATION) || \
>>     defined(CONFIG_DEVICE_PRIVATE)
>> static inline int non_swap_entry(swp_entry_t entry)
>> {
>> 	return swp_type(entry) >= MAX_SWAPFILES;
>> }
>> #else
>> static inline int non_swap_entry(swp_entry_t entry)
>> {
>> 	return 0;
>> }
>> #endif
>>
>> Otherwise marker entries will be treated as swap entries, which is wrong for
>> example in swapin_walk_pmd_entry() as marker entries are no longer considered
>> pte_none().
>
> Thanks for the comment, that makes sense.
>
> Instead of adding PTE_MARKER into this equation, I'm going backward and
> wondering purely on why we need to bother with non_swap_entry() at all if
> MAX_SWAPFILES is already defined with proper knowledges of all these bits.

I was going to suggest it was to help the compiler optimise the non-swap entry
code away. But I just tested and it makes no difference in .text section size
either way so I think your suggestion is good unless that isn't true for other
architecture/compiler combinations (I only tried gcc-10.2.1 and x86_64).

That's a possibility because the optimisation isn't obvious to me at least.

non_swap_entry() is equivalent to:

(entry.val >> SWP_TYPE_SHIFT) >= MAX_SWAPFILES;
(entry.val >> (BITS_PER_XA_VALUE - MAX_SWAPFILES_SHIFT)) >= (1<<5);
(entry.val >> (BITS_PER_LONG - 1 - 5)) >= (1<<5);
(entry.val >> 58) >= (1<<5);

Where entry.val is a long. So from that alone it's not obvious this could be
optimised away, because nothing there implies entry.val != (1<<63) which would
make the conditional true. But there's a lot of inlining going on in the
creation of swap entries which I didn't trace, so something must end up implying
entry.val < (1<<63).

>
> #define MAX_SWAPFILES \
> 	((1 << MAX_SWAPFILES_SHIFT) - SWP_DEVICE_NUM - \
> 	SWP_MIGRATION_NUM - SWP_HWPOISON_NUM)
>
> So, I agree with your analysis, but instead of adding PTE_MARKER, what do
> you think about we dropping that complexity as a whole (possibly with a
> standalone patch)?
>
> ---8<---
> diff --git a/include/linux/swapops.h b/include/linux/swapops.h
> index d356ab4047f7..5af852b68805 100644
> --- a/include/linux/swapops.h
> +++ b/include/linux/swapops.h
> @@ -387,18 +387,10 @@ static inline void num_poisoned_pages_inc(void)
>  }
>  #endif
>
> -#if defined(CONFIG_MEMORY_FAILURE) || defined(CONFIG_MIGRATION) || \
> -    defined(CONFIG_DEVICE_PRIVATE)
>  static inline int non_swap_entry(swp_entry_t entry)
>  {
>         return swp_type(entry) >= MAX_SWAPFILES;
>  }
> -#else
> -static inline int non_swap_entry(swp_entry_t entry)
> -{
> -       return 0;
> -}
> -#endif
>
>  #endif /* CONFIG_MMU */
>  #endif /* _LINUX_SWAPOPS_H */
> ---8<---
>
> Thanks,

--=-=-=--

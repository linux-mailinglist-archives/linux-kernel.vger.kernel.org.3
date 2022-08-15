Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA4C592942
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 08:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbiHOGFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 02:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbiHOGFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 02:05:10 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2063.outbound.protection.outlook.com [40.107.95.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F7517A9D
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 23:05:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ke0+5/w2hOZNPbnBgKp8jc7APlD+1bHam17dQN9n8A+dtaNLtKMb/316zwzJctwkjkuDUUyM2Fb0u3+WbEK8+bswcBCMs6wjcenELBAg+sa++bhjjvdNRmUo03ANLhN8ftRM3TyYdozjQs/qGfqve1lwxEUhpMNYcX+VRPbc3Tqw6ZusrcCWt5/nofh9zL1OEWxx3tjN/0dgMi6Xa3Sw4Ai7Al/bGUq2NsK+zH5wgZLIHDtdmxmosb/J4N2bt9GR9aGUurqBl8YTWR/N4/+msbqJJUyI1c+RoogPmsQ2wCIpfcgt1ZYKmz6z1bc7dKWPHUm0rlU//uK29HMXsuvRIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=90GrA8jyDLNaaMZ9iSvWjv08G7dG2IXJRaJmyfUJ/Xs=;
 b=ZwMimuFj3IyYcllHPKk2sJeDQkA3oddoM+7frGSoCjsfMlfI+qI7OtIyKqeaXs6dE3PQfzmcdyFUKWo3icJ6EBY+q4Onst6jA/E5vUaih9zdlyWPzKOiBIP/Qoy9fPaZASzyAeDmSBM+XB+d1NYZxi4XPaoQ2pZFz4xsEusxw+gwEMjq6pl2/z5/VEpXAZpmX9VIItQBTwA7I3exLJhZwvmWRTk1TzDG5cL5QYdyW7GPjS9IBh2mjkWQlwUqCpFmg8tKNii7Zpo10TL9dsjRBoznAFFkUXMpS7QKcxVgf7WHpYOB7934rqAJYuq1oOwZ1nZO8UWxmyBrCd8SuUpP7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=90GrA8jyDLNaaMZ9iSvWjv08G7dG2IXJRaJmyfUJ/Xs=;
 b=EDhGFM7Ct9KNM37PLHi3yL5/2SiTy9mJ47qYxm4kOxcSjaQd7d04a00MrANHPmAd9ZfK3khlsbYzTWAiq4VdfRySLsoXLUtdVh/+mMcg+Zi2QxJyxNzxVOA+0Hk7J36O8JmZm9QEJBPMuQMPbPCPl4XXYK7GAjekwHjI18Lv7NcwucDBCsQ8NWFDx4dAnjH3QhOXRg3GQMi70TOyoPnzaKGbfa2gEAtLhxNb3dY8gGC4jAXIsBh0IsZHlUBgcIMI2VOfFISg9WH4OmmXErTOR80RtYaoXfFw4DsPK85cSga+7N8GBNdjltUoq6EhNxoawW+IzeNKWKHDaVljo0xBXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by BN9PR12MB5226.namprd12.prod.outlook.com (2603:10b6:408:11f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15; Mon, 15 Aug
 2022 06:05:07 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7%5]) with mapi id 15.20.5504.027; Mon, 15 Aug 2022
 06:05:06 +0000
References: <20220811161331.37055-1-peterx@redhat.com>
 <20220811161331.37055-3-peterx@redhat.com>
User-agent: mu4e 1.6.9; emacs 27.1
From:   Alistair Popple <apopple@nvidia.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Huang Ying <ying.huang@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v4 2/7] mm/swap: Comment all the ifdef in swapops.h
Date:   Mon, 15 Aug 2022 16:03:31 +1000
In-reply-to: <20220811161331.37055-3-peterx@redhat.com>
Message-ID: <878rnqvy7l.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0357.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::32) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8fc1ff98-4fda-4820-ba2b-08da7e8419de
X-MS-TrafficTypeDiagnostic: BN9PR12MB5226:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vk0R+bEPBZM8erzWHf5R0r4bqmlvtd67iZNCtDqMSp2rRCwd541y4w8EGWtECSeapOB5OmoXJcZVl5XDBrra8aY+9muXMzJek8I5+0mLw5mtujTGMefaQenEWlXTvIPHyZRinYkbggXDOACJqEiuTXHvghWYwrupqTtvPrZk3OKmZ9uDpKaG8NmYeAH37h6iTDRsOhygkqNyl+H7e+46DcSIB5vLrue1mw/EikVUav1Ub199MV0PFXLIKtNPZXo0RCM+nPHDq32HkZiavfPYTmyqKAKIqvsnpYzkMbI+WJI1aTcVfGp3ExHcQVvkKoY5I9RLBsDGdFvi2gVk30u3+rO4U5AEZefKgCjq5MnzFiXRAIIePeSc164VpKE8Yh5absAAelZM5KaGJxPk25YnQhw37YppnGHo9FIkQpwmhsUjyoSEU5aDhmA2BpskGLVBInmLZ64TC/FbXBUPJLca+ti47PMT6Z/adzxhAuVrdKqvRZVlwUXpLXnZOe1oQsFj153Oeu2iarDYS7+s6FU6UCHideBMgnORpfe5XUkY2N83oxaIZWNi8nW5TJWmS6eCt545BGXqn3u/TCkheOZrtYSz0LxE8k73m1U/HEstMRP8c9icoolAJGhKQb6MXdk1YMe2Raj9O7SQ5yNmU3VZ2grcbJ+5duaSS9CgviIM1K0msQC8jdSFEjvKHVn5NVq4XBg0CD7F1G9iYe2tRnwgo+m84tMedI6nj3uS15DuI+KrzLBMyAxXBYlGXGCyhrzA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(366004)(136003)(39860400002)(346002)(396003)(6512007)(8676002)(26005)(8936002)(9686003)(66556008)(66946007)(66476007)(4326008)(6666004)(41300700001)(5660300002)(2906002)(6506007)(7416002)(478600001)(186003)(83380400001)(86362001)(6486002)(38100700002)(316002)(54906003)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XPzNLwyLD8qK7HYtf6qUu/eVBij5gcmcySBunNeF6rQooC/Rsuj6Hfw3E5F+?=
 =?us-ascii?Q?2SNKuaj8qPWxdsllP4TrjuCPr25Zhkmorm0/Q6JHj/MjC01rCqbdNcxbY/hF?=
 =?us-ascii?Q?sQl1/mgl+mSWZc+Hu++R2GV+WLzyDAqIoMD3CHe3gR19kifhIbzdIT2EDzQX?=
 =?us-ascii?Q?te+FoYgXBcxAKVCt+5Bamh4cs6OVLiDPRqP0uiCve1GE8L6pdFL7IGsfT8d9?=
 =?us-ascii?Q?lJTBtQOAplxuPkjBpgSRH8cvQqHqRLYAW7on7lqq29X4GBBUvUzzDSMjY4kJ?=
 =?us-ascii?Q?rmOL0FoRLy/a1NqQaLiXhgmIOzqyyuAffWW1T3eEs8BgfraXFAA2Jqg9GoUV?=
 =?us-ascii?Q?N5nv7GMPXokrysoBa/MX6MBbR8BrV0izVTJLg78RazYpTsaKDjEMtuyuga3P?=
 =?us-ascii?Q?awRavx4clsyz4QUsbhUb+TX7rAdDKTebj1lCNvLBhX9bJQYGB3c6N0UhayPX?=
 =?us-ascii?Q?bzGhCelewiLJtIMBfafCo1DuRQ6omLO1RkBeg83/E71YcjwgB5EEiKAVQJgW?=
 =?us-ascii?Q?kpGWywkrq6iqnTrSpHFo2pYvrz6G3kfXRm4Zac7CDCbW9ca5gkfTiC1myWAr?=
 =?us-ascii?Q?YmTUnp+GfM2UpBzl3ZVGtD+fB5RGBIFJhIL+4aOgsbaf7oKkr+64M5g3imO1?=
 =?us-ascii?Q?nbJYyIMZUPXDfmCWmxIOoVq/xcW3RujZzEYXTVRo4n778UchtyEoY4Cllkdf?=
 =?us-ascii?Q?O9Q7ierfkYHcjh6WHPdZU8bXAVyqHe5Mkr8UHRgCGpP/e/WMOGyuN+g+fwfc?=
 =?us-ascii?Q?d7vsbWidG9qwCYZyK/1C24WlzSpur4wOdhJFb26Z+7bt7ywZjtKDJYg6ssmw?=
 =?us-ascii?Q?/qnCKGMQ4qSezs/JzjX6dNjtr0tw3voz0wenPLcZIxHMPKOoqtpmSvFsumGT?=
 =?us-ascii?Q?9o3Sg6HqqH1Z3ROzXBGO4G2xHSxua6tC+ya+xdXYeH8uCQoqfEiUYBGzOjoX?=
 =?us-ascii?Q?HFWjb0KegeE0xpqiBGGKr0Xw8s3CD+Qb2pj2TUTk98Zvy5sD9DBzoYvCMswZ?=
 =?us-ascii?Q?BRoKO/U/9EIIrI4Sfvipop6UA5Fneg/tqKokW/JLVKAXWsUI147MVMCgvIDL?=
 =?us-ascii?Q?EdYTa0F6lIgQqqzhDYIuwQ7dio4YYBmXwe4oDeGIeeL117LT1HWWPC897XyA?=
 =?us-ascii?Q?mxScbfTuvOofhQ41j1lDkA2cPcWrivFnyqbE3bzJJUW9NEl3QsiO/eV6Voxo?=
 =?us-ascii?Q?evfho/wkgtx/EK1MyMOlqZjILabvjxEyEdFxW2T2/VOwaK/H93IjuAreuJoD?=
 =?us-ascii?Q?ZGBTwTidh2rheTj3G4Q42ccVwW173zQPc+ThRBGm0pmTzGEZa2/VO2+ixhHT?=
 =?us-ascii?Q?m+RB4hlIGT+lLRQrG1tnuHcPdnH+guhMAaxz/3hCULusgJPAVUKwgR4rYIMI?=
 =?us-ascii?Q?7CS0T8BXC2tORXgUl9p9TcwT+k6d+MA2PMJGSi0Sbshlc91mo2K0KzOlfTLp?=
 =?us-ascii?Q?8sMakgaVUJ9jJrm5dn/8bkfzTfCBUEy1Sm/HKyGmUuhmB+oLQ2PuHjuzShaB?=
 =?us-ascii?Q?kcfq3c2LxI+gozwkrPpeTQqH5pRhWcxNQA5Njyz1POe056lxcPPtIgW6y/El?=
 =?us-ascii?Q?tRV9U2p0xocpKsyvJrl0iIC9BprZ5wfGjlF3wkZd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fc1ff98-4fda-4820-ba2b-08da7e8419de
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 06:05:06.3030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SYnWi9rqofiBMgWOvKIPHaNBFaibJ00vWXCSH0KS8VpkOwnExup5gKt4K5qEUnweAJChrHSuqKaYmJQCnD1R+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5226
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Looks good:

Reviewed-by: Alistair Popple <apopple@nvidia.com>

Peter Xu <peterx@redhat.com> writes:

> swapops.h contains quite a few layers of ifdef, some of the "else" and
> "endif" doesn't get proper comment on the macro so it's hard to follow on
> what are they referring to.  Add the comments.
>
> Suggested-by: Nadav Amit <nadav.amit@gmail.com>
> Reviewed-by: Huang Ying <ying.huang@intel.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/linux/swapops.h | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/include/linux/swapops.h b/include/linux/swapops.h
> index a3d435bf9f97..3a2901ff4f1e 100644
> --- a/include/linux/swapops.h
> +++ b/include/linux/swapops.h
> @@ -247,8 +247,8 @@ extern void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
>  #ifdef CONFIG_HUGETLB_PAGE
>  extern void __migration_entry_wait_huge(pte_t *ptep, spinlock_t *ptl);
>  extern void migration_entry_wait_huge(struct vm_area_struct *vma, pte_t *pte);
> -#endif
> -#else
> +#endif	/* CONFIG_HUGETLB_PAGE */
> +#else  /* CONFIG_MIGRATION */
>  static inline swp_entry_t make_readable_migration_entry(pgoff_t offset)
>  {
>  	return swp_entry(0, 0);
> @@ -276,7 +276,7 @@ static inline void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
>  #ifdef CONFIG_HUGETLB_PAGE
>  static inline void __migration_entry_wait_huge(pte_t *ptep, spinlock_t *ptl) { }
>  static inline void migration_entry_wait_huge(struct vm_area_struct *vma, pte_t *pte) { }
> -#endif
> +#endif	/* CONFIG_HUGETLB_PAGE */
>  static inline int is_writable_migration_entry(swp_entry_t entry)
>  {
>  	return 0;
> @@ -286,7 +286,7 @@ static inline int is_readable_migration_entry(swp_entry_t entry)
>  	return 0;
>  }
>
> -#endif
> +#endif	/* CONFIG_MIGRATION */
>
>  typedef unsigned long pte_marker;
>
> @@ -426,7 +426,7 @@ static inline int is_pmd_migration_entry(pmd_t pmd)
>  {
>  	return is_swap_pmd(pmd) && is_migration_entry(pmd_to_swp_entry(pmd));
>  }
> -#else
> +#else  /* CONFIG_ARCH_ENABLE_THP_MIGRATION */
>  static inline int set_pmd_migration_entry(struct page_vma_mapped_walk *pvmw,
>  		struct page *page)
>  {
> @@ -455,7 +455,7 @@ static inline int is_pmd_migration_entry(pmd_t pmd)
>  {
>  	return 0;
>  }
> -#endif
> +#endif  /* CONFIG_ARCH_ENABLE_THP_MIGRATION */
>
>  #ifdef CONFIG_MEMORY_FAILURE
>
> @@ -495,7 +495,7 @@ static inline void num_poisoned_pages_sub(long i)
>  	atomic_long_sub(i, &num_poisoned_pages);
>  }
>
> -#else
> +#else  /* CONFIG_MEMORY_FAILURE */
>
>  static inline swp_entry_t make_hwpoison_entry(struct page *page)
>  {
> @@ -514,7 +514,7 @@ static inline void num_poisoned_pages_inc(void)
>  static inline void num_poisoned_pages_sub(long i)
>  {
>  }
> -#endif
> +#endif  /* CONFIG_MEMORY_FAILURE */
>
>  static inline int non_swap_entry(swp_entry_t entry)
>  {

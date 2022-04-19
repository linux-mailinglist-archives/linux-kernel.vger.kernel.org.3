Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24FA45066FF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 10:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350043AbiDSIgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 04:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343749AbiDSIgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 04:36:15 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C24301D0EE
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 01:33:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TGUxycgxHGm1B+q/tW1HtGr8jreP0w4MwVrAYmGDxxSWvkc+3p57tln32vnQp6WA27NNLjo7TWkpXDN5I21uznCqzkmD83KBh4Uf07LnQVpNVWTTPSrSn7YW/HuaDZEAh8dwEmN+9aXgntMW90FmYodepvfnlOEfoebj6w7yWVu2oB/ygYCRHQsR7zGbd0nzKGc8BrxagCSNC8vXlZ8ixl5Xiw+tx1mlbe3yvCPpeziURp8aq1W+wurdsmo3gD/F/O03mx7+CS2+KaXjcJRa6CPsz107KIxOZClv53eFtoja6WZftFCwaKqfbhEz3ZgnlQNTL+1CWb9UzSCsE00m5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8lauG364Nj6Pl5XSlU2odqDc3wMHDCQBBZyZ1iP3KEc=;
 b=by+BoLXty2SVnseKz3HbLmJOuYVtvf6mqd7VztwrpTbia8Kmsm54LbiE/ysCIA3591aYlLx/2LlU4myZuMcwnsJeFV2H/8h8XTCh7sJsplJAzvW/xIfe9JM455N1+jYWWDoymgFnbislOSLkODZuuoQ97K2+0TLtwnaWtUWXT01h0Pj8BKOQmg+PVqJXQIj95LvGxmBwk+Ea7VMCJIvKBkK7fEWCynoLgJPF1mFX2i7TMyTKffe4mIzi4H/WtR0L8ChtqozbDIzcJIonecRiaG7HcebQZM6slzbS9JvQhjWYySrKtbNxQtoLnxKW7b4/5t5Pe0FnYbThUJWtHDryow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8lauG364Nj6Pl5XSlU2odqDc3wMHDCQBBZyZ1iP3KEc=;
 b=YhmV/FoB4qShRpM5Spxx98HahsfXMpdm2VgN/yUCVUluIsHtqfq33Cvlgf8/gKWGdJyN1+EPWDHA6sRmcclNhgYERjyneX/U/wDH1hsSsD4ypk/l13TEO7Io8FUjvThwAoW/6SaIhQ0qpd2F8tNKK6CVvHWP3cw5tu8cnAkUc7HyNZDknY7XSasKWadPSGUryz2BmYwJSRrQABjHyaeXizbQ/sJedEXIlAWWqjkiJC154ocEXHBRZrjEVzh4Wtzz6/yjBmKP81JQlPNtXdD2bxM71oF6bF4z48RxTEgPzScnpDfSL5AO54+M+SgZtWX/OsRfXIGovMUZwq3kSkToYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by MW3PR12MB4506.namprd12.prod.outlook.com (2603:10b6:303:53::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Tue, 19 Apr
 2022 08:33:32 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::2d17:b68a:e101:4c18]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::2d17:b68a:e101:4c18%6]) with mapi id 15.20.5164.025; Tue, 19 Apr 2022
 08:33:31 +0000
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
Date:   Tue, 19 Apr 2022 18:25:31 +1000
References: <20220405014646.13522-1-peterx@redhat.com>
 <20220405014646.13522-2-peterx@redhat.com>
User-agent: mu4e 1.6.9; emacs 27.1
In-reply-to: <20220405014646.13522-2-peterx@redhat.com>
Message-ID: <87o80xjwvd.fsf@nvdebian.thelocal>
Content-Type: multipart/mixed; boundary="=-=-="
X-ClientProxiedBy: BYAPR02CA0005.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::18) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1bf0980a-2afa-4246-b1c6-08da21df4810
X-MS-TrafficTypeDiagnostic: MW3PR12MB4506:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB450601039643A863CA3B2D84DFF29@MW3PR12MB4506.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HiDnt2xUaz1kTs23se37laGAhlcm/YR2fLP0GczY12WBlP+SyTsMZb05d/6JGVqjDjhefdzc+gGGTNv/IGLln9fpxJ+dFIQm/E16Kx4O57z75SsvjOQqu2wqUTiyEuvJDngYXItePO7VQQ4xr8dj/tZpUx3EM/+WVfyCVSMWnJ7iSAB5IcnnaK5xM3D9whCzUjFnRVit09Du/gWnvGUgiweEdqq1doUBZVMzDUJx7IA3/hwjVXbkbjrgN7sTPZNxz4BrRnhqpk1ETnzyEvO0kN3aaAF/WT3zF0qOLeGvn1Qnj1yPuWnJPMWK+Dz2+XdmD26C3f+oQ6raR5VobX1n/Y4rlm9AuUTnAOY0/e12hDlNmhhysm2XVP6ZlY+4m6d2IEjzpzX+kDEpTn2K9/H0QoXvLvN/bXqwq8S/Kg0lUFqCncZs61SdR2BwCLMsu8CeIcHI4WG8T2T3t6W27Y9rwAr3pjemP2Q+ilzy87ZFZSCea3/A+pWMgBU5HjTpD7qSkke4HQjCfHkk0/I+QgZZbrUeXtHMJEPBqc7CONpTaiJmUTrMZaxhtplaDGTfpKjkHO0oFpxi7UOJ0gfhnDjJiGpLzQ47qezOkK6ttWXR/rXKK1U9eIXImDa6NN7vmj0eXMYQ7vgUqoFhAPqBjfJh46SEvudw47STefCFyRD4oN8ehwZ0l52afUoS7v13G06OlGs3ZXNLRCWZoUjaUP9PpfsrVhSLOpyngdeDdNOYqaQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(38100700002)(7416002)(8676002)(4326008)(2906002)(186003)(66476007)(66946007)(66556008)(83380400001)(5660300002)(86362001)(508600001)(9686003)(6512007)(8936002)(6916009)(54906003)(26005)(44144004)(6506007)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D16fvS413GaLPK5EgJ2FSmcS3slvFDFE0Bs6k1d0rWOITfW7BUYCOPP9JLkV?=
 =?us-ascii?Q?ocb5K4niSt4A3zHiZuqecoXIhbnFYzqgqKQIq32KRG61fWGd3dpN27oP9I3r?=
 =?us-ascii?Q?0feQotohThAyHVK9dqRgRNTPBdM2y56/SkhyoWvYvIz3gI2GI83MwGr4prwR?=
 =?us-ascii?Q?COe74NPCj6ImzGO71CdxCA5YGdKiDofT7WHz2jQVBMaY9/uilVD4EPfzS+L6?=
 =?us-ascii?Q?VrUdH1IibsXCuvjb3anUijm3H3ijLWUZtgYoVoeNVFK40EG0ye00cL5RAzem?=
 =?us-ascii?Q?75XQHm7k70LfGz6CjTlvu1uXq04QDE3NJ1FkwVa1CY6GqAdvbQpDD/1WJpW9?=
 =?us-ascii?Q?SyA31hMDnmZhgw/ELYAR0xl8dvS7VAxhjno8VGsAG+RZoSV0Wks6H+v2lvts?=
 =?us-ascii?Q?7Zo96MReoSRLZ7EDrBNHkrOywjRxgDMAUdvZhflop7qoXUhoi6FOCRho7hwd?=
 =?us-ascii?Q?8R8g8N0mzFiN5Lu4b8H5NwEZklVdiiJjugtMJOnIIcNHbPdD/SbT2w0uhuhP?=
 =?us-ascii?Q?rY7QWMxWo8mVHNd7vafN8vmHgdGaoF9dpkNL6jyGMI2qbnDyVCCx/6l1N3bi?=
 =?us-ascii?Q?BJq6rceJrjQBQYhQ1Q/3gD7lSjKDu5IpjT//eHMVg6k3uRhv0eXIQIZ8YOfg?=
 =?us-ascii?Q?LRyRluP3omNu4v+jy4kme0Tx8NckGZiXV252JNZqAkBhJgHI3lw6/XLZwusm?=
 =?us-ascii?Q?qcvY8/h3jGJu0ofW10k+jLoVWsTmRc057f06mgrxUeBT9LndeDY1n2DVgSe/?=
 =?us-ascii?Q?6oU5htXsjOKyeOvb2xn4ldTsfxme2aety8K/bRpx7Grr8G4f/GISHOxjaw/D?=
 =?us-ascii?Q?Eg2+WayxYWdmjmdPNWDiDLGkI/3SLkOl6LpXobnMshworGNbm4PtO9ZQo30/?=
 =?us-ascii?Q?abhxUZFmfuYw495aQJboMXAAQoC//BY6l0o+0qcPs2benD+xAscsbnedUj7O?=
 =?us-ascii?Q?feYAgUChpfukXieEEUzLZZT816Tratr0137vSfTPvvxcQb0gmgceDQLR7hle?=
 =?us-ascii?Q?ZM+ItMAhGq0bHr22iIALU79ZXWDZhuWm/nM5/IgbUcWJcV41KZsuPncdoUnT?=
 =?us-ascii?Q?80aXESciPCtlD7snAf+aEdXsHzeAnzDE68PRCTygtd7TAMMbG8xxn3o7WExM?=
 =?us-ascii?Q?7/eig+idsyVcHnzdsNEHr05cHOm9yVSmgt0M9FpVkWoi421Iqjrc8D8u0eGF?=
 =?us-ascii?Q?WVEDgjlNdgcgKUQr1iWBlmkw+r6UXb9zLrIkoJO1eUTGnIgkrxCPAIHYnjiF?=
 =?us-ascii?Q?ePMMigPpdxtw9wpVz+Q1dmLSSYs2PpOZRiS0vQnktKZVuqTiLSxY/cyekkFl?=
 =?us-ascii?Q?Iod+F5B2ciicSjdEvBRPcQAJ3cdkZgkl59pnIvF2Fohhu7qUj8whZDILKxCD?=
 =?us-ascii?Q?Z4gw8SEhiQQakyJEGfhpb1D54747GKS6YvkqAh/xgacvz8QjBgBZKRSaV9qC?=
 =?us-ascii?Q?VbACTA/EgmQQVs8k46DMq4i38d9zqhbau51sVS25D06PyVZTu/p8noy54xvh?=
 =?us-ascii?Q?EI8U2iEpBB83hEm/eQeci0dNOh31lvw1hO7Ud38pxyWs14tWJp58V+8aaIrg?=
 =?us-ascii?Q?IzmpuYlhpRextvc8/WHcPxQnE+9E8GY/tDOPFmf41poPtHNVe9p9Bauz1Ree?=
 =?us-ascii?Q?ZJfeu5KWNItCqNT5K6cw1RjA4W4Z4TCWtvhJ79ey9PXKYw3WvNEm/oRkWp9J?=
 =?us-ascii?Q?GnGZGlKKRgSlCSRqRu41JE0NLBcw7QbRo6Jkxa2fvRpa2Il3A443NQQ8N1y2?=
 =?us-ascii?Q?hJVzYsBIZQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bf0980a-2afa-4246-b1c6-08da21df4810
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2022 08:33:31.8228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JgUeCJvE4agXzEg6KpzOTiP1ZzNjyBspLFW3d/L7b0UcPm7x1Lklo7m3dA4c5WMjDvcMV7OELjSG/HfOyYLzZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4506
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

> This patch introduces a new swap entry type called PTE_MARKER.  It can be
> installed for any pte that maps a file-backed memory when the pte is
> temporarily zapped, so as to maintain per-pte information.

Hi Peter,

Is there something I have missed that means PTE markers can only be used with
file-backed memory? Obviously that's all you care about for this patch series,
but if we needed to mark some anonymous PTE for special processing is there
anything that would prevent us using a PTE marker? Specifically I was thinking
about it in relation to this series:
<https://lore.kernel.org/linux-mm/87pmldjxiq.fsf@nvdebian.thelocal/>

> The information that kept in the pte is called a "marker".  Here we define the
> marker as "unsigned long" just to match pgoff_t, however it will only work if
> it still fits in swp_offset(), which is e.g. currently 58 bits on x86_64.
>
> A new config CONFIG_PTE_MARKER is introduced too; it's by default off.  A bunch
> of helpers are defined altogether to service the rest of the pte marker code.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/asm-generic/hugetlb.h |  9 ++++
>  include/linux/swap.h          | 15 ++++++-
>  include/linux/swapops.h       | 78 +++++++++++++++++++++++++++++++++++
>  mm/Kconfig                    |  6 +++
>  4 files changed, 107 insertions(+), 1 deletion(-)
>
> diff --git a/include/asm-generic/hugetlb.h b/include/asm-generic/hugetlb.h
> index 8e1e6244a89d..f39cad20ffc6 100644
> --- a/include/asm-generic/hugetlb.h
> +++ b/include/asm-generic/hugetlb.h
> @@ -2,6 +2,9 @@
>  #ifndef _ASM_GENERIC_HUGETLB_H
>  #define _ASM_GENERIC_HUGETLB_H
>
> +#include <linux/swap.h>
> +#include <linux/swapops.h>
> +
>  static inline pte_t mk_huge_pte(struct page *page, pgprot_t pgprot)
>  {
>  	return mk_pte(page, pgprot);
> @@ -80,6 +83,12 @@ static inline int huge_pte_none(pte_t pte)
>  }
>  #endif
>
> +/* Please refer to comments above pte_none_mostly() for the usage */
> +static inline int huge_pte_none_mostly(pte_t pte)
> +{
> +	return huge_pte_none(pte) || is_pte_marker(pte);
> +}
> +
>  #ifndef __HAVE_ARCH_HUGE_PTE_WRPROTECT
>  static inline pte_t huge_pte_wrprotect(pte_t pte)
>  {
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 7daae5a4b3e1..5553189d0215 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -55,6 +55,19 @@ static inline int current_is_kswapd(void)
>   * actions on faults.
>   */
>
> +/*
> + * PTE markers are used to persist information onto PTEs that are mapped with
> + * file-backed memories.  As its name "PTE" hints, it should only be applied to
> + * the leaves of pgtables.
> + */
> +#ifdef CONFIG_PTE_MARKER
> +#define SWP_PTE_MARKER_NUM 1
> +#define SWP_PTE_MARKER     (MAX_SWAPFILES + SWP_HWPOISON_NUM + \
> +			    SWP_MIGRATION_NUM + SWP_DEVICE_NUM)
> +#else
> +#define SWP_PTE_MARKER_NUM 0
> +#endif
> +
>  /*
>   * Unaddressable device memory support. See include/linux/hmm.h and
>   * Documentation/vm/hmm.rst. Short description is we need struct pages for
> @@ -107,7 +120,7 @@ static inline int current_is_kswapd(void)
>
>  #define MAX_SWAPFILES \
>  	((1 << MAX_SWAPFILES_SHIFT) - SWP_DEVICE_NUM - \
> -	SWP_MIGRATION_NUM - SWP_HWPOISON_NUM)
> +	SWP_MIGRATION_NUM - SWP_HWPOISON_NUM - SWP_PTE_MARKER_NUM)
>
>  /*
>   * Magic header for a swap area. The first part of the union is
> diff --git a/include/linux/swapops.h b/include/linux/swapops.h
> index 32d517a28969..7a00627845f0 100644
> --- a/include/linux/swapops.h
> +++ b/include/linux/swapops.h
> @@ -274,6 +274,84 @@ static inline int is_readable_migration_entry(swp_entry_t entry)
>
>  #endif
>
> +typedef unsigned long pte_marker;
> +
> +#define  PTE_MARKER_MASK     (0)
> +
> +#ifdef CONFIG_PTE_MARKER
> +
> +static inline swp_entry_t make_pte_marker_entry(pte_marker marker)
> +{
> +	return swp_entry(SWP_PTE_MARKER, marker);
> +}
> +
> +static inline bool is_pte_marker_entry(swp_entry_t entry)
> +{
> +	return swp_type(entry) == SWP_PTE_MARKER;
> +}
> +
> +static inline pte_marker pte_marker_get(swp_entry_t entry)
> +{
> +	return swp_offset(entry) & PTE_MARKER_MASK;
> +}
> +
> +static inline bool is_pte_marker(pte_t pte)
> +{
> +	return is_swap_pte(pte) && is_pte_marker_entry(pte_to_swp_entry(pte));
> +}
> +
> +#else /* CONFIG_PTE_MARKER */
> +
> +static inline swp_entry_t make_pte_marker_entry(pte_marker marker)
> +{
> +	/* This should never be called if !CONFIG_PTE_MARKER */
> +	WARN_ON_ONCE(1);
> +	return swp_entry(0, 0);
> +}
> +
> +static inline bool is_pte_marker_entry(swp_entry_t entry)
> +{
> +	return false;
> +}
> +
> +static inline pte_marker pte_marker_get(swp_entry_t entry)
> +{
> +	return 0;
> +}
> +
> +static inline bool is_pte_marker(pte_t pte)
> +{
> +	return false;
> +}
> +
> +#endif /* CONFIG_PTE_MARKER */
> +
> +static inline pte_t make_pte_marker(pte_marker marker)
> +{
> +	return swp_entry_to_pte(make_pte_marker_entry(marker));
> +}
> +
> +/*
> + * This is a special version to check pte_none() just to cover the case when
> + * the pte is a pte marker.  It existed because in many cases the pte marker
> + * should be seen as a none pte; it's just that we have stored some information
> + * onto the none pte so it becomes not-none any more.
> + *
> + * It should be used when the pte is file-backed, ram-based and backing
> + * userspace pages, like shmem.  It is not needed upon pgtables that do not
> + * support pte markers at all.  For example, it's not needed on anonymous
> + * memory, kernel-only memory (including when the system is during-boot),
> + * non-ram based generic file-system.  It's fine to be used even there, but the
> + * extra pte marker check will be pure overhead.
> + *
> + * For systems configured with !CONFIG_PTE_MARKER this will be automatically
> + * optimized to pte_none().
> + */
> +static inline int pte_none_mostly(pte_t pte)
> +{
> +	return pte_none(pte) || is_pte_marker(pte);
> +}
> +
>  static inline struct page *pfn_swap_entry_to_page(swp_entry_t entry)
>  {
>  	struct page *p = pfn_to_page(swp_offset(entry));
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 034d87953600..a1688b9314b2 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -909,6 +909,12 @@ config ANON_VMA_NAME
>  	  area from being merged with adjacent virtual memory areas due to the
>  	  difference in their name.
>
> +config PTE_MARKER
> +	bool "Marker PTEs support"
> +
> +	help
> +	  Allows to create marker PTEs for file-backed memory.
> +
>  source "mm/damon/Kconfig"
>
>  endmenu

--=-=-=--

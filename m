Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4364FCBDA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 03:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244232AbiDLBYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 21:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbiDLBYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 21:24:09 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C4D19C26
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 18:21:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xz5uCqgOMiG1ZspAUP2x545FyYalUsfuXPuft/HIyQv27mUZPZOSzhIM/7OgKr6DGMKbdnmg0lG6N29C6/XoCQCHUAd8G+3FMVk65dtL8zB2ODhi7UERu40jpakihxlMhxmNU9bMbUT5WwxGU/0NRiF62+3b3Tk/LZthiao0YKWCYYzSyjktUT/+qgTZ5HNwwp/+tyt9dR7Beqo8VZxC5bkhTUFUqOWEmAlt8UO9lGM0cxmTfNDbL3AkcO5YA9CZF2snhCfaMoveFuHVy1D5XXhpc2M6ko2xya0dfAPIW7Egq7uEHWAT1mFJpbkogEDYMGvmN943vXTSUoErMgeFag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BruyzIvEInL/1/D9FKwmp7t7sv6ekkPrfCebeqibZXc=;
 b=E0X2fkFTm+0wEjjIc6QoldzYoGtAUUuiFSfMPcAK5Edse70XyFGv3pYPXAAuMwUEEPwYkpkJkXHTUGOBJ1i3Sq+SVbvfuhndHg956em0BSkYMA1BB3kQHx6hL5fmLsKBPB9meT3EGDuYOg5hdIkHbw74cTbHF7bQEEwdc55kS7zfbWXuaKB1TnMJKfi6j1rCl+So/bOzfBENf3Ge6TNcmkvDllQBDHMahqM1oc3dvFkJRcjwG09izpUeut1tSOKFBjJV9/xZAcNg+067K0oDHfcRAJO4x8A0EJbfB8uD1d9Hh4MSZlsbhK/AI+nj/ZTLuOjzq/ljG4xE1duOGSShSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BruyzIvEInL/1/D9FKwmp7t7sv6ekkPrfCebeqibZXc=;
 b=D5UE5w0yGFf9efnG6+wD2T3BHMj6snKdPeOKzNNZHDbwGEsDn1YXhJ2bYwqJsphO5rhspc0icRJo6iVZewJQZUNVyDxzjD4xvM/Dta2VGHIIzlOZYie80JaZwngRURAejFvEKu6kvJxFwr45JZUhZsQExifesgsoCs+ehRhGmxyo9KrbXRPNS/+ExLuOI6aZlXwk53rhD3ag6KaycIRmpdRTJOlEnPn70HIZgUV5D+5MU8j4TU53tXJW/KyE2pQvWzsAedJd3xBoF7NuSr6jhjGUSh6GnEB4/DcXO2V0ebGC221xPPmvsMMdKI7uV98ImGgnxC09f3eqgU9Bj5OZaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by MN0PR12MB5931.namprd12.prod.outlook.com (2603:10b6:208:37e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 01:21:51 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::2d17:b68a:e101:4c18]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::2d17:b68a:e101:4c18%6]) with mapi id 15.20.5144.029; Tue, 12 Apr 2022
 01:21:50 +0000
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
Date:   Tue, 12 Apr 2022 11:07:56 +1000
References: <20220405014646.13522-1-peterx@redhat.com>
 <20220405014646.13522-2-peterx@redhat.com>
User-agent: mu4e 1.6.9; emacs 27.1
In-reply-to: <20220405014646.13522-2-peterx@redhat.com>
Message-ID: <87bkx7ayfs.fsf@nvdebian.thelocal>
Content-Type: multipart/mixed; boundary="=-=-="
X-ClientProxiedBy: SY3PR01CA0094.ausprd01.prod.outlook.com
 (2603:10c6:0:19::27) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e1f4ec14-75e2-4208-90e7-08da1c22d216
X-MS-TrafficTypeDiagnostic: MN0PR12MB5931:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB5931893502F00C0E76305FA0DFED9@MN0PR12MB5931.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NMLY4bJRZMd1/lTDJ8ztSl5C4Y9muIFahLBIhpXv5C+z2k1ehVwea8v8Ek0YmwdytyBW5KkbvnXCRi9q0HFUQZ1CnQAqnggojIvkssCstCphirney+7P0MtO38BA4Tm+FPQKg8SxKnYy2V40VRFm12pGDuAw/+YuTjdwh///Z8CkuzixEO+WbHjk3GgYzaef612FGOnzFU+3IOXKAAe1XHDs6zQsF21Yn7wEZL3DngFMJvreww7BhB7+HubByXeAaTtH1fCAgbYqCtLrmXHG3IAr13jezkMkrqyaSAwjfQlLSkqChP4f+82NAdsg4f+XhFqIJ3XF2uDl4401jrg0tecWChd/2qbzavdTfb3yxW1wupcqyiKU6j12wWIJW6Yr+61QIjmbenSRvlYwcYO58C5i3dHb5OYNNyCwagnNYpwWOAQK2Vov734AvVvoyaABxuxpH4qtsEZOTm81cqXS7Ccw5DnGv48KHsq/366QTr4PO3tq/KVxVwTBoeDT+vqyXm0xdFNso1/XWZUq8+wZkT3d7KpS0OEChuo9PCu8IWHIz97XehBUU3MGWPRG88WsZwW7hk68Ut7ae4FvrxWzROh/YX4JMMRnuTuASnA/hfQf9c+fzzUS0p09dt157BWywWGpziC+2qY3OH4QL+sHtg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(6512007)(6486002)(6506007)(316002)(26005)(186003)(7416002)(38100700002)(6916009)(54906003)(44144004)(83380400001)(4326008)(9686003)(8676002)(66946007)(66556008)(66476007)(2906002)(8936002)(508600001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IMqOwo/mnHqeLRlLG9F2qnVqL9TDES0wcRxUByliZx+g/aiN2fFT8w9MbhGP?=
 =?us-ascii?Q?KMn/VXzxDZuvWI5DyMHrvifjMePDfO/6gU9zLUu2vswzSL9g1oMk9f+s7aDh?=
 =?us-ascii?Q?uCn6QVlHRvga0SiWZ3q0OoUBJfVw7/UwVg0QIOLhm7lAs2fP/9eseJE69LUW?=
 =?us-ascii?Q?8qHV4wStJN7YfqlKCRDn5iVDwmarqQEhL8dNMRVG+SBTFTOP7+o/b4iPELG4?=
 =?us-ascii?Q?274esD0ILUp/d8+wT8FUjccPSyJt8tjmODY0XM9A8Tbj5TGYPRNmP01ZoJ3h?=
 =?us-ascii?Q?I+F2nXQGwWyy5GjX2Wm91L3okRnKheBoIuFT+vfRNV4Go58orKXmM4XZKIYb?=
 =?us-ascii?Q?3yo59F0dd1yB49hEvqW5MS2d/0A0xfEFEVYjokCTFrp8qjRmoXrcTbvSF6HA?=
 =?us-ascii?Q?F05OUhVPDqegCxGyIYz/KCFt2+NEt6JWOKVS9ZEHJz7ADLcN3iEouZqtxYXl?=
 =?us-ascii?Q?JIhgyAM1GjRu8EFdPraIZgTHuzRqhYHJwkU/qEA27gQat1DW2l6FNZSRNTj2?=
 =?us-ascii?Q?w94upLUbzuIZtx/jVUoozmMU5igkpi11M7WIcxbIOW4wt1yAivPcjaIsK6la?=
 =?us-ascii?Q?r3Cg9i5fnD7KeUap0rfGD54368iJ8g/V9eBwzfjmy0Z2Lw9BFnsZSUKMJagO?=
 =?us-ascii?Q?T4Zi+XzwY1mlysZTQJGBK8fkQ9bqr3LCgghhkk1/MN64mVRipox28yTt/aX7?=
 =?us-ascii?Q?tDlR/7Ct2OqpVyO/rPswdXSb4iAGGSVkceQtlPH+fqwO0se38lzXI7/7LZin?=
 =?us-ascii?Q?rxNV8FRn84UgIZMV9ATW0Vgl6hsGc59S6fFtP0uWKZM0gn6QdmqS3g9QK/CW?=
 =?us-ascii?Q?Ofp22ugGm56kwllCe0K6og1eIqEpd4Go5gTvs7UJQ290ZuTh1GVpR9FqnD19?=
 =?us-ascii?Q?uJloQQMy7FLEvl415/rZv7rC5MM+gq0/qFvj/asV3wZF57KGXZMryFMBLoG6?=
 =?us-ascii?Q?Gz8QMctZHHSMSm5Fq8DAgnD3VT+Q83lUocg/JympELlFyEYLeL2Bx52LswmJ?=
 =?us-ascii?Q?m8MrclGmg8oyNdu2W0PSV39wSJuIQFISDvoXxHeoN9I6ko8NiPZDAyYpXFEi?=
 =?us-ascii?Q?U0ATGe2bc9qbZFz8wszAW/Q5C2TGrF8619i+AWht7zUkcbPGmUZv8vhSzl7x?=
 =?us-ascii?Q?V/KFYieF2F6XC/eV6DtGmh2oeZ4WJZcxCw3zh9Au8+tnJT1DM+9Qz6RrNlLp?=
 =?us-ascii?Q?J+ftCntc+wHyPU8JmBhw240/NrcAvMrSwibTFCLqm3MpvzvnQM9HyaMD1BT7?=
 =?us-ascii?Q?RFLj8EPeOMyHeb3xbqqNtYru2+1ZFv/e8N+SCidzVuS9DtR4Bw2LNSlKeGHA?=
 =?us-ascii?Q?jDutBGvO/tw2FDDUcjRsuw3WvPOLrGkwLIQB4UFKoOdcGCT3yd/krKgT50DO?=
 =?us-ascii?Q?4HK09v4jgqdb5eWFujdwQei+7au5YLJHpIDbY1k9RYAJI0XcrHjSt2dO2ih1?=
 =?us-ascii?Q?1F3Sm8XLPuKylhVElGf1yEesr5JF13NKXU1UDOtGC2wmC4pVIowgW4SdjEVb?=
 =?us-ascii?Q?qcxokppxZ8XpRpZ63uauRzsaJ5egkohVqeaPVcxGcQQe2gI/cxhwiwgBv6we?=
 =?us-ascii?Q?kw6DodqmjmYWzvd/kPF5jEnGPeRxXe6Har/JoARY/SUiTOaX2oExk0iPcoh4?=
 =?us-ascii?Q?CFskk5wQEFFVPgAxG7DnsiwjOBa7RnCgz1/h2g5935XtgDaEX19WyBAPJlPS?=
 =?us-ascii?Q?Y4pbjXi1wn8Ngqni/q1IuaFe8s0TyxY0WT2qKSi2ZlBVngmHamq3DyaksjRZ?=
 =?us-ascii?Q?DwYFAlPE1Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1f4ec14-75e2-4208-90e7-08da1c22d216
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2022 01:21:50.6756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: je84pWh8iDiFQAbt3AiYNwtslL3raMuuePZYwd8eICbpoOUfxUzIsncGlaDg5YEbTsEg6boO8S87BVZ1VUxzvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5931
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

Hi Peter,

I noticed this while reviewing the next patch in the series. I think you need to
add CONFIG_PTE_MARKER to the below as well:

#if defined(CONFIG_MEMORY_FAILURE) || defined(CONFIG_MIGRATION) || \
    defined(CONFIG_DEVICE_PRIVATE)
static inline int non_swap_entry(swp_entry_t entry)
{
	return swp_type(entry) >= MAX_SWAPFILES;
}
#else
static inline int non_swap_entry(swp_entry_t entry)
{
	return 0;
}
#endif

Otherwise marker entries will be treated as swap entries, which is wrong for
example in swapin_walk_pmd_entry() as marker entries are no longer considered
pte_none().

- Alistair

Peter Xu <peterx@redhat.com> writes:

> This patch introduces a new swap entry type called PTE_MARKER.  It can be
> installed for any pte that maps a file-backed memory when the pte is
> temporarily zapped, so as to maintain per-pte information.
>
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

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539FE5062EC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 05:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347229AbiDSEAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 00:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbiDSEAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 00:00:20 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF3F21815
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 20:57:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YwFk17IPqqnx/oyz2v+H+84HbpNBfJRl4n9qAPwTjIbub31LcrRqNHJ11roL2RDDUn8mCbGd3XiRv576lxSDlLq4jlnFn28IYdtvwU/xNWX9St7yF4u8sqXwM8yXZ3KczaC9Ugw9or+I4vg8pM8ohCGBUpgUa9mgytbpn+k7jYTs6Me0GKH2vdAz9ZsgJA+PZUXFg+j6H+CcoZ+buGMqaTcLuwQhV87YNTL8h0QoZ5/HXp3C73QT9cHuEYyHIdTxXLivB3w/LcghH2No6GXGC+7pcuN1wrUGK7pk01y4o4PTV5CL+rkJV7c6F6wlN+sYWEvpgp4nHx7mPjMMRFG9MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uRt+96/ExaWjZrS2e5sB39D7EGSGcsk2nzBRucGiCfU=;
 b=ZDEnK/3dd0Z3yP2ueLnqeB7z803kabyoyJUWByoo1EKzZcJbmaY3vb7521sZc7NoNl8g9k48NIRRfVAgtSAy85+jsSFr4uTvVQHSmQp0uZnUohIO2/dNbQsEt/lqabvMx1e1UPQq/hW7KwNUicQ0PdhxP6+FWBC2FNmuNkhMxITHrS4Ax9dhC9hm2pM6aSLaSudkjb2XFrY8w9e+ZDWel2hNWDyAIuRF3DyCsOxij+Q8bFgolbVQCee4/BU9wY2NbgU9GsjwulPoCpVMxI7J+jbPDbXOEgjrMKW+IcX/Y4zWexRklh8MDd3HceVrfGM7+1/4dsr2KuQVouajMT1ZWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uRt+96/ExaWjZrS2e5sB39D7EGSGcsk2nzBRucGiCfU=;
 b=JHUCyKJa8Ibr9hTaGGEoLtWMpT8AarKjVsDPGQJA54F1NWJWlpFZb3VwhULxWVOwpCgKWbnBsWGLFib2jjbcMglwBdFeG2eGh7HWa3b0uoaZ4zI0IVdZS3s6389AKBDYl5s0Ra1kaGbrRlrqybDLSHk1NXZkt4O5GT+Sp5w1tdQ8vPlh9TkwIdY++ehNROIZ2lF+b+a1CfHDs0V5oyaxwhJPU/THZdJ+I4VT2Cbgq4WqvNECBA7vzcME66AtjNvh6A5BBHLYPQnZOPHVSi69D8xHzhBlHEzpcqPYa8DHjC2o4i5vPGsR99slkoyn8XRpc7EhjeOH8XjjqhoKJvh63A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by MN2PR12MB4224.namprd12.prod.outlook.com (2603:10b6:208:1dd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Tue, 19 Apr
 2022 03:57:36 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::2d17:b68a:e101:4c18]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::2d17:b68a:e101:4c18%6]) with mapi id 15.20.5164.025; Tue, 19 Apr 2022
 03:57:36 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, vbabka@suse.cz,
        dhowells@redhat.com, neilb@suse.de, david@redhat.com,
        surenb@google.com, minchan@kernel.org, peterx@redhat.com,
        sfr@canb.auug.org.au, rcampbell@nvidia.com,
        naoya.horiguchi@nec.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/swapfile: unuse_pte can map random data if swap
 read fails
Date:   Tue, 19 Apr 2022 13:51:26 +1000
References: <20220416030549.60559-1-linmiaohe@huawei.com>
User-agent: mu4e 1.6.9; emacs 27.1
In-reply-to: <20220416030549.60559-1-linmiaohe@huawei.com>
Message-ID: <87tuapk9n7.fsf@nvdebian.thelocal>
Content-Type: multipart/mixed; boundary="=-=-="
X-ClientProxiedBy: BYAPR11CA0080.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::21) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd262e06-7d80-496f-da17-08da21b8bd21
X-MS-TrafficTypeDiagnostic: MN2PR12MB4224:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB42240A81D0923B868E501811DFF29@MN2PR12MB4224.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Vsw0nN33jsfu4sSq1QeK28QKGTzqhyaygJMhADAurF94YWUk71UUUYZLDYacE+/l8p+1yQGDxsscoKlId8IKZZ+H70aTKbM3S3fAJ4/IPjkwerAVZiEB3cqkNtaZ/CmdwW6bscbeHMT0O84VJwc2nMSg0lo3LGsvycDknE3XQuP+EVWmttQ0AAwVEFa3pNWSDyNc88hnF3ltAuZLJ/XB5511xgbFrzuOnX53HkDMxFDNCykydwiNPyOdVRV8ZyQy2x+GRJQUH0FsrvvEg8IlN/2fUEv5NWawxHy7TxfXiW5uORwhhy49oEnObIIHzjfgFZu88TO/MWO4t53B+OABdjcVN1xJLcDd19sMRzCfaSJf9LOhAknymGrrTcWUhFoKH33EHKHIRsF9jLxavkblwdD9XPcxq49G2wcipNli71mVteyktUjLqJ+QRir3zgqQ3X1CS+PrKjvcRs2Pjpc2jwaRaltjF4LB9f/3Z7zSm2BkdBg6x977Ks0PvujXL6mwo3YN01DsQ8Tv3dVA9zP5cG4juZmnaJ4EZrtZutVvTFY00xeefFvhuODKdFZj2MF+igI9OpX890NsLhlr9c/PZAdK/VGFZHXs38F8aEeJurnS0JRGHxDMz1EFAczdDqrsHAjDYWqzoMK/7Pb/L10BfFOAuFD5H6Q42lx/BZdZhikd/mkIU1pDferFCkbjzF3FYWxXro2COC9VYMzGJn877NgmhCSEUBegS7/T9rELkQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7416002)(6916009)(26005)(8676002)(6512007)(9686003)(38100700002)(8936002)(6666004)(6506007)(66946007)(66556008)(4326008)(5660300002)(83380400001)(86362001)(66476007)(316002)(508600001)(2906002)(6486002)(44144004)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YmVFTbbCvuHIp+CtqaotH7DfH491ngrfGDzLXMwSEWhEFKCLRLZtW0THfmkx?=
 =?us-ascii?Q?6ViGAuWSs8MwlK2p+kJwuvvzG4c+u4slKAh0L1PywK4UOU01TrWcZePTHNsq?=
 =?us-ascii?Q?4X4/cyFGkhPEobQvmFGa6Ywhc4KSi+y1Q/MK4w7wflXYreE0IC/3m0/adOHT?=
 =?us-ascii?Q?SFH0pIi3NJkffuOjXfxcFjE8onNws+4cMUyBHf0bgCJrP5TMRZOUvqwB8cQE?=
 =?us-ascii?Q?mJ3o0roeSRq0va4dMMbN2ePgEJVUUneTxwXoIfoaIIGdsV3xIfpOp7OlrzBj?=
 =?us-ascii?Q?cFtmpuaGjihuKFnRdzfrwRtXIDzV99RoY6QhmYeg+2USSVFwuJx7zvP228sh?=
 =?us-ascii?Q?cNon6Jxash1ED86/uXAJSRASZWRoX43ZH8QCO7zCOlSol6w+4pOGz1WpBE4M?=
 =?us-ascii?Q?qCcxVrvLP9yxv1P0krHZrPrEIF63eGLhhyPpcCIKRgE9SxYcH7fdKODzAf6k?=
 =?us-ascii?Q?DS6rfPAkbLE2HVg52GrN8DE0qPBsYAUo9UeedunWGs5hgb2nXOu3hFIW754v?=
 =?us-ascii?Q?VEyg8qYx0QCQGHo2nqxsAghC7ZwUvFbt7XbpndxPkB5LYqVPT61dUmGM5ior?=
 =?us-ascii?Q?n4v6z1vivujRatvsmEgcHkeWrCP9VzuxyRgoZMaeCT0g3/FSKqfcSgrIc1O8?=
 =?us-ascii?Q?L5qUhLLRshykYS4SNng2G/YX8itQUGm9LzXvA7wHeWHcJFvm0enPYVDGfupC?=
 =?us-ascii?Q?MV7uk9i+gbrc9ZmSMuzRB4ctdfAfj3vimm6kxcfkD3wWNKQLMvLsmiCBvfKC?=
 =?us-ascii?Q?ZyKAWqxAIZsaNbIe0g5pCN+hSyzw2zH+ty0SmJI0VzDlco5rw6zhTBkAExOr?=
 =?us-ascii?Q?uiA03Qr7N3xLl7jkurr4+MnZaBbRyMdFgnxQipNYKrtWf8ZHt8Rj/NfpUl6q?=
 =?us-ascii?Q?yzWw68pG/Qm/QPdLlg0r1gK1bgzLB2jHDrOoeolRkV5bfuktXzvp0Zx9+JQV?=
 =?us-ascii?Q?q/0HwSZ2yJypnqw9s9WwFH40a17oqNZclQidBmd/ia6umIHrvhl4A6KTbu22?=
 =?us-ascii?Q?4RZYcjpudnNozZBM0gMI6Tz/tMP9TK5HscjrXlWOVwowP0igrHmG4WLSCZii?=
 =?us-ascii?Q?ONlyuKUBEL4m7yLWK+wDnjwmD5Mj3LooRPEGan6kplkpa3ry3BZjS2VWKAM+?=
 =?us-ascii?Q?jdCr3zozzKpoy9M7XXu0dOMi9ShW7gQM0BUdku9Z6eDa07llr0MI4NKBlFWW?=
 =?us-ascii?Q?jGmTgqKXFlYSEOZygflCC4Oy8jdn5PhlLDkS9IRF7YpVWRc3JLwrQzS2ZYFy?=
 =?us-ascii?Q?00LyaSqLihqzbdubCZmTmf8VzO8ISGOsYhAxlstc4pkwkPywUEiMbLL5SEx0?=
 =?us-ascii?Q?XIkIWjTqNxWetXjOM58SYBRlPY4GwwyEJd+5pbKZVbwebue32no6By1AN5z9?=
 =?us-ascii?Q?JZXMAYzKjHPrl+FB2FsmKYlnnhFXJO6UrjQE0E6DshYB7p8hF5xWkR1brBe8?=
 =?us-ascii?Q?37JaVNqe9zCqUBmNC3TMQIia31jaI1HsTpyScpvjAKz3i9T8XxNdf/6/aqvA?=
 =?us-ascii?Q?WVqRhFCQ4qivSaKolg40JRpBmsOvtYKug87jmJtK1a8hoICceLpE0egdEAle?=
 =?us-ascii?Q?Mm65FAkK3ldkNvinHLZZqw5R9xldfGKy3mO2eIfXX0/5OLGJS0cn4g73hy7w?=
 =?us-ascii?Q?qkVJB+SYMqoOd36mzHyKTy68WQD6v5g/5c3z4mR1DOZPHPD/lnA3lvi22AmT?=
 =?us-ascii?Q?J0pkm4f7vhDUQ0f+ZUo4PGI9x0h+QMes3GgcI6OzhLdDZpgI7URrbrnfZrXy?=
 =?us-ascii?Q?iHImICe2qA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd262e06-7d80-496f-da17-08da21b8bd21
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2022 03:57:36.0595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a8sUypq1/ujSWPDyWcBW9acNi/8d94mZjvPH8wkuY2t6ROYgdoIEcuNOm98fFsH6RMyD8WqOjF9K/DCHvkfH7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4224
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

Miaohe Lin <linmiaohe@huawei.com> writes:

> There is a bug in unuse_pte(): when swap page happens to be unreadable,
> page filled with random data is mapped into user address space. In case
> of error, a special swap entry indicating swap read fails is set to the
> page table. So the swapcache page can be freed and the user won't end up
> with a permanently mounted swap because a sector is bad. And if the page
> is accessed later, the user process will be killed so that corrupted data
> is never consumed. On the other hand, if the page is never accessed, the
> user won't even notice it.

Hi Miaohe,

It seems we're not actually using the pfn that gets stored in the special swap
entry here. Is my understanding correct? If so I think it would be better to use
the new PTE markers Peter introduced[1] rather than adding another swap entry
type.

[1] - <https://lore.kernel.org/linux-mm/20220405014833.14015-1-peterx@redhat.com/>

> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
> v2:
>   use special swap entry to avoid permanently mounted swap
>   free the bad page in swapcache
> ---
>  include/linux/swap.h    |  7 ++++++-
>  include/linux/swapops.h | 10 ++++++++++
>  mm/memory.c             |  5 ++++-
>  mm/swapfile.c           | 11 +++++++++++
>  4 files changed, 31 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index d112434f85df..03c576111737 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -55,6 +55,10 @@ static inline int current_is_kswapd(void)
>   * actions on faults.
>   */
>
> +#define SWAP_READ_ERROR_NUM 1
> +#define SWAP_READ_ERROR     (MAX_SWAPFILES + SWP_HWPOISON_NUM + \
> +			     SWP_MIGRATION_NUM + SWP_DEVICE_NUM + \
> +			     SWP_PTE_MARKER_NUM)
>  /*
>   * PTE markers are used to persist information onto PTEs that are mapped with
>   * file-backed memories.  As its name "PTE" hints, it should only be applied to
> @@ -120,7 +124,8 @@ static inline int current_is_kswapd(void)
>
>  #define MAX_SWAPFILES \
>  	((1 << MAX_SWAPFILES_SHIFT) - SWP_DEVICE_NUM - \
> -	SWP_MIGRATION_NUM - SWP_HWPOISON_NUM - SWP_PTE_MARKER_NUM)
> +	SWP_MIGRATION_NUM - SWP_HWPOISON_NUM - \
> +	SWP_PTE_MARKER_NUM - SWAP_READ_ERROR_NUM)
>
>  /*
>   * Magic header for a swap area. The first part of the union is
> diff --git a/include/linux/swapops.h b/include/linux/swapops.h
> index fffbba0036f6..d1093384de9f 100644
> --- a/include/linux/swapops.h
> +++ b/include/linux/swapops.h
> @@ -108,6 +108,16 @@ static inline void *swp_to_radix_entry(swp_entry_t entry)
>  	return xa_mk_value(entry.val);
>  }
>
> +static inline swp_entry_t make_swapin_error_entry(struct page *page)
> +{
> +	return swp_entry(SWAP_READ_ERROR, page_to_pfn(page));
> +}
> +
> +static inline int is_swapin_error_entry(swp_entry_t entry)
> +{
> +	return swp_type(entry) == SWAP_READ_ERROR;
> +}
> +
>  #if IS_ENABLED(CONFIG_DEVICE_PRIVATE)
>  static inline swp_entry_t make_readable_device_private_entry(pgoff_t offset)
>  {
> diff --git a/mm/memory.c b/mm/memory.c
> index e6434b824009..34d1d66a05bd 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1476,7 +1476,8 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
>  			/* Only drop the uffd-wp marker if explicitly requested */
>  			if (!zap_drop_file_uffd_wp(details))
>  				continue;
> -		} else if (is_hwpoison_entry(entry)) {
> +		} else if (is_hwpoison_entry(entry) ||
> +			   is_swapin_error_entry(entry)) {
>  			if (!should_zap_cows(details))
>  				continue;
>  		} else {
> @@ -3724,6 +3725,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  			ret = vmf->page->pgmap->ops->migrate_to_ram(vmf);
>  		} else if (is_hwpoison_entry(entry)) {
>  			ret = VM_FAULT_HWPOISON;
> +		} else if (is_swapin_error_entry(entry)) {
> +			ret = VM_FAULT_SIGBUS;
>  		} else if (is_pte_marker_entry(entry)) {
>  			ret = handle_pte_marker(vmf);
>  		} else {
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 9398e915b36b..95b63f69f388 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1797,6 +1797,17 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
>  		goto out;
>  	}
>
> +	if (unlikely(!PageUptodate(page))) {
> +		pte_t pteval;
> +
> +		dec_mm_counter(vma->vm_mm, MM_SWAPENTS);
> +		pteval = swp_entry_to_pte(make_swapin_error_entry(page));
> +		set_pte_at(vma->vm_mm, addr, pte, pteval);
> +		swap_free(entry);
> +		ret = 0;
> +		goto out;
> +	}
> +
>  	/* See do_swap_page() */
>  	BUG_ON(!PageAnon(page) && PageMappedToDisk(page));
>  	BUG_ON(PageAnon(page) && PageAnonExclusive(page));

--=-=-=--

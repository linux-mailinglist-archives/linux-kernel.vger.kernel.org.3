Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D1D4CFCB5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 12:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240206AbiCGLZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 06:25:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238642AbiCGLZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 06:25:18 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B62CF8
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 02:57:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nYuOqTdXtt59LDFdmAcH6nbHG+ATVxce7DFBSAOJYt0TkbU7JmQnHyJwUAa0VdOqLZ/FkhNQ0lxD0qxid0EnceyLkJfmDbOY3poZxck7jtXjYulggugjBnR/Khc10cxYAutpwm4GmfNwhVakeA0SCP6wSWGpok95CkN0Yz4xKbOCCbb3WR/rIuF1XmxUxw8cJyThoU2qVMebpniCet+WKGn9oESa82c1vqtTAbZ/L4RBcy0xCeo5Xx2bCKy0d8/sulhFlwLKNd6OW3L/cqnfSb1t84nWLeaJqg64prcDFyw6WL3+YVBUdKeJ7PYnbRLID7b7SxavmgEZMKbELFJ0Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vkMX+b4cdaPCspP5hQerNf4A2LgC9Wo0Va2YNVrZ1JY=;
 b=NCTqBVLfeB0/AebNxnFjj3LTJGoaO2HaI0kepvF3bgotQiLYEhnaX/UYxXKSc/L2raWL/AxCSN4IrZlCYJj/m0jUdsjVE8TG3J4nOD4+bh5Q9E+GNBlZw7wYoVX6DBANaiUPzFrL8DFitjleFvJnwiG58uxyZIhy4BTsneBrCMLVq5RNJI6gqIUfe2MPqUD/3B8NlUmmbpa0e0bBdBpVBv1Zd8S43j1ugSjjfwX4Oi5SJpc9fs9KX1p3+KcpgNAl2t+G/6IC6XzwtpCK4aNZc5smCXB8a9u9joo2AUM9ZCWyrExux2ZNfn/b/Ul8zgGxGpS6trb3k0XTP3pjfPIKhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vkMX+b4cdaPCspP5hQerNf4A2LgC9Wo0Va2YNVrZ1JY=;
 b=PsbY6lS55isaVB/vICwhq9+OKdaKW/VtdUcGZC7kuhjx54T7QNa1IOKD6XXTnlqP7SL+ov2zL/DE6ubRAjN9I22QarcofsvpkJcplidTpA0EcZ7rzq700qdJSp5G8LLxtZ88xjpLy6KZ/r0uVMAID08WyNBPMGMO7CZd+qmkxhHc8MXSa+I2O/g/XwH9+30WVfMUucnXrMyPKsnkfTfc2uV2DLXQBXEBZIVHhRNKTb8/iQ+iGqQu7M3xZany86t51tkzH8DVaKTpa9e1nQfyWDCukYbQ5/lbq+oIFWnApZbKMz/xtx8elw1ugXo96fSNCOJ7CYW5oySgutGKcaIWdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by DM6PR12MB3689.namprd12.prod.outlook.com (2603:10b6:5:1c7::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Mon, 7 Mar
 2022 10:57:23 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::c8a0:e8df:3661:63b8]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::c8a0:e8df:3661:63b8%3]) with mapi id 15.20.5038.027; Mon, 7 Mar 2022
 10:57:23 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, mike.kravetz@oracle.com,
        shy828301@gmail.com, willy@infradead.org, ying.huang@intel.com,
        ziy@nvidia.com, minchan@kernel.org, ave.hansen@linux.intel.com,
        o451686892@gmail.com, almasrymina@google.com, jhubbard@nvidia.com,
        rcampbell@nvidia.com, peterx@redhat.com, naoya.horiguchi@nec.com,
        mhocko@suse.com, riel@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 16/16] mm/migration: fix potential pte_unmap on an not
 mapped pte
Date:   Mon, 07 Mar 2022 18:35:51 +1100
References: <20220304093409.25829-1-linmiaohe@huawei.com>
 <20220304093409.25829-17-linmiaohe@huawei.com>
User-agent: mu4e 1.6.9; emacs 27.1
In-reply-to: <20220304093409.25829-17-linmiaohe@huawei.com>
Message-ID: <87y21mrpww.fsf@nvdebian.thelocal>
Content-Type: multipart/mixed; boundary="=-=-="
X-ClientProxiedBy: SJ0PR13CA0083.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::28) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 985bbb87-ed3e-4be7-ad00-08da0029421d
X-MS-TrafficTypeDiagnostic: DM6PR12MB3689:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3689B7C813FD9C38519D730BDF089@DM6PR12MB3689.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FXdTZ41mh7gFMSgJevovOdjURg3X5aN6dTYs6nLVK5BaK4FLak7xIam87ssKs0iJXQkWtTcY6GH8jfHt6pxbDY7ZYFbGGcibIKuGPQbyt7z/prLHk+3iWVqA9xu6YSw5NPZwqWO1Nt5CkC9uKSH4uQnwVpiJGpYQ9sy2MhS29wJwcvQIJa1anjBspquYz0V3D4rubs0qguDpSai0FwXObjI/be5HDrEm6nlUWZ6NqFuFH2hhWKy2yrQvHcOV9Ng1yl2v4U8PsKOKkcSQ4tWtWQFcCQ4mHfgm1AcXeEVtCXsHnE7OhrVp5jshhnedi5oLZKGCABZC4ap7HW8EZZpgsmcRzrJgiaGz5BQqR93mJMl7KVe4k3cAB/scAwXzNBEr8xkL2YVbnnLZAwGsGGQ01wk8M47uuH0l4ELYcg1+H9LtcelpiRgkB8HdOYysdefSsp33vec9KReBQjg264+x+aiy+2YraJSDwS6aEfpfyqPA4ixzppYFZJ6UiR2caCaWbP+aVHBuANSNfRSFlAnmRIRe5ugQezSE76QSAWTh+jej7QV90MBd6/CErPeBx4YAQTDdWdtweZbAxhSu8ROK3JvwBCLpuIlFW2LcXbix6hZpa/AZSM7wCH6GFEMpFgCT1M+gpwSuv7U4nWfpautQYA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(9686003)(6512007)(38100700002)(86362001)(186003)(5660300002)(2906002)(6506007)(4326008)(8676002)(66946007)(83380400001)(66476007)(66556008)(6486002)(6666004)(6916009)(316002)(7416002)(8936002)(508600001)(44144004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KsIWjKguEnUcfgIU2vhBzlnAGeoOlvmn69MHRW+G/KtRJsL5ab4PlKO7aMUQ?=
 =?us-ascii?Q?U97qFWEFN+EkMx0kEsykwxFc+ZPqwaxLNjhFIoE1U9VSyefhCr8LMlSkObgD?=
 =?us-ascii?Q?+adp+9FU0XfKwmbeqkbojQ4LcrPKgwyStVJungeYU313Bhen5ERcv+hs059t?=
 =?us-ascii?Q?gf74T7PfB50EuTXckxiTL5Xc39bz5mhOG4yy+BuH3eJSmEUFMaKqUANeoHBK?=
 =?us-ascii?Q?mcvMamitbIv5kt4D9jDyNA7LWUPNsjA8+3Xbqn/NM/quqUiJSgdCqKZ/a0j5?=
 =?us-ascii?Q?CVjuy49fL4Ob2FgTJPe7rXqEffm1AApecDB+LWf4F2E2547CK16sJsgmF2JG?=
 =?us-ascii?Q?CUZB7Px0bzJN2quQz34no2TPpfCwM629UzD2QDIUp8lKEYImHBk0z1VSHZQo?=
 =?us-ascii?Q?C0O0Qj3emQy44Fz+Qfrei2F842J1pXdqyTFePZtBiUKZ+EvGe5hGWZyV1FE/?=
 =?us-ascii?Q?3vuN/omNI+uvfqaq0XNBq6yuZZsyGoZlJj+eh7Nmm//9+Hih42GQfkoLA1vK?=
 =?us-ascii?Q?rilmc2mhn5O6DBZIFubhxOBlE0Gin+nY3O78eC8+tacscw6DfNnOaIWz1Cdp?=
 =?us-ascii?Q?8jT1U+TWGIFTMQuoSDdpncTR9IL/N0nGeVoHtpouJN4oNtMe565dPd+nhot1?=
 =?us-ascii?Q?Q8vpNbhxMMKJCIUpBMUn/2fesaaMn3Vn6TK7DsAk8/3CeAyJT+lIdpeYRfHb?=
 =?us-ascii?Q?5blTO5RMrZPM6KrYRZ015zr5CgXXglAxmAnEAlTC6Jp4hPXZny+WKL1vrMnA?=
 =?us-ascii?Q?eRwysiIwG5IAeL5qDM8JmzarNBvhOhjKsHoxZ++kUrFpG1ajiZEcxinbqwEs?=
 =?us-ascii?Q?i8q2XfexsSv92WUdM0SmjcPyjqoi93Uf/54CyLkHF+Ft2mTwiCud3mX6UDBn?=
 =?us-ascii?Q?6SMaxngtUGPzNegpROw/g+W2YNx0fo1CKH8kxbDRCfdnvlb0zk0yN2oo/rj6?=
 =?us-ascii?Q?L5EKULyw6ADyEAc9cWv46AGL7T35r2Wn7Xqd9sr1aa9SKJb4UPLTUI6LeHVm?=
 =?us-ascii?Q?gEwrb7g0xfL6fX95oYB50pI/t+F/86YUS9gdhp5WyL3C9d6LBRjXwrXwrVUN?=
 =?us-ascii?Q?QN0kZvN9dXWR/8ko1GMRfortq7+MD7Jn1CRm2SzW+LnxchRxb2XIdFAEyJG3?=
 =?us-ascii?Q?o1Isj8nnVelZbeb74tF+gskEtrlLIo6/Bsy4XcAn/lpAxcjE3LDBGDjt+0PS?=
 =?us-ascii?Q?dDccGxyaeTNvTneBIVC9Qywx5owBffxSAZDqADP8zxgyAGFJCF1sSi7nUlJr?=
 =?us-ascii?Q?fyITAFi3+7TP6ASp1x9GrBCKWUrUnSbN/biUshXBRDCvorId3dRmOnM13cxi?=
 =?us-ascii?Q?HmaJaWhzxgOWm+B+737+G7H5kwWttIL8ntrAilEC7RS53z1vgVl6IO8SBezH?=
 =?us-ascii?Q?+zLq6s+hKS1PaScZR07f02JrfQJJ1HFJEu1QnvOsA0RploPuXka+FAjxQAwB?=
 =?us-ascii?Q?Lghw7oqN7dCLBXyLN1aLoPvNF4I7JqVP7nTu2kIqbvFtoPoJRECDAQxuFWqu?=
 =?us-ascii?Q?SpUHxTfLLQ1UTBXuA0/J2Df80LGbuvB9S7uCDKvQNosWnoYKU354kpCTL+ZB?=
 =?us-ascii?Q?ml/LSXO8cJ1XXC6e41JfP3QivZ/Gr/cUaHtNu0vecbTe1+olLDVXpOluR+Kf?=
 =?us-ascii?Q?1Ccu8WhdRDnHxzcKOadXM7I=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 985bbb87-ed3e-4be7-ad00-08da0029421d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 10:57:23.2215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EH8ffVtO8CZkWiuhAsxGlljI0/Swwjcb2gOoa3GOCVU5M1QrmjOMYQdXND+U203ISr43URoY7pArR0s5xwPCYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3689
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Disposition: inline

Miaohe Lin <linmiaohe@huawei.com> writes:

> __migration_entry_wait and migration_entry_wait_on_locked assume pte is
> always mapped from caller. But this is not the case when it's called from
> migration_entry_wait_huge and follow_huge_pmd. And a parameter unmap to
> indicate whether pte needs to be unmapped to fix this issue.

[...]

> diff --git a/mm/filemap.c b/mm/filemap.c
> index 8f7e6088ee2a..18c353d52aae 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1389,6 +1389,7 @@ static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
>   * @ptep: mapped pte pointer. Will return with the ptep unmapped. Only required
>   *        for pte entries, pass NULL for pmd entries.
>   * @ptl: already locked ptl. This function will drop the lock.
> + * @unmap: indicating whether ptep need to be unmapped.
>   *
>   * Wait for a migration entry referencing the given page to be removed. This is
>   * equivalent to put_and_wait_on_page_locked(page, TASK_UNINTERRUPTIBLE) except
> @@ -1402,7 +1403,7 @@ static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
>   * there.
>   */
>  void migration_entry_wait_on_locked(swp_entry_t entry, pte_t *ptep,
> -				spinlock_t *ptl)
> +				spinlock_t *ptl, bool unmap)

It's a pity we have to pass unmap all the way down to
migration_entry_wait_on_locked().

>  {
>  	struct wait_page_queue wait_page;
>  	wait_queue_entry_t *wait = &wait_page.wait;
> @@ -1439,10 +1440,9 @@ void migration_entry_wait_on_locked(swp_entry_t entry, pte_t *ptep,
>  	 * a valid reference to the page, and it must take the ptl to remove the
>  	 * migration entry. So the page is valid until the ptl is dropped.
>  	 */
> -	if (ptep)
> -		pte_unmap_unlock(ptep, ptl);
> -	else
> -		spin_unlock(ptl);
> +	spin_unlock(ptl);
> +	if (unmap && ptep)
> +		pte_unmap(ptep);

However we might not have to - afaict this is the only usage of ptep so callers
could do the pte_unmap() prior to calling migration_entry_wait_on_locked(). We
could then remove both the `ptep` and `unmap` parameters. Ie:

migration_entry_wait_on_locked(swp_entry_t entry, spinlock_t *ptl)

This does assume it's ok to change the order of pte unmap/ptl unlock operations.
I'm not terribly familiar with CONFIG_HIGHPTE systems, but it seems like that
should be ok.

- Alistair

>
>  	for (;;) {
>  		unsigned int flags;
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 07668781c246..8088128c25db 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6713,7 +6713,7 @@ follow_huge_pmd(struct mm_struct *mm, unsigned long address,
>  	} else {
>  		if (is_hugetlb_entry_migration(pte)) {
>  			spin_unlock(ptl);
> -			__migration_entry_wait(mm, (pte_t *)pmd, ptl);
> +			__migration_entry_wait(mm, (pte_t *)pmd, ptl, false);
>  			goto retry;
>  		}
>  		/*
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 98a968e6f465..5519261f54fe 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -281,7 +281,7 @@ void remove_migration_ptes(struct folio *src, struct folio *dst, bool locked)
>   * When we return from this function the fault will be retried.
>   */
>  void __migration_entry_wait(struct mm_struct *mm, pte_t *ptep,
> -				spinlock_t *ptl)
> +				spinlock_t *ptl, bool unmap)
>  {
>  	pte_t pte;
>  	swp_entry_t entry;
> @@ -295,10 +295,12 @@ void __migration_entry_wait(struct mm_struct *mm, pte_t *ptep,
>  	if (!is_migration_entry(entry))
>  		goto out;
>
> -	migration_entry_wait_on_locked(entry, ptep, ptl);
> +	migration_entry_wait_on_locked(entry, ptep, ptl, unmap);
>  	return;
>  out:
> -	pte_unmap_unlock(ptep, ptl);
> +	spin_unlock(ptl);
> +	if (unmap)
> +		pte_unmap(ptep);
>  }
>
>  void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
> @@ -306,14 +308,14 @@ void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
>  {
>  	spinlock_t *ptl = pte_lockptr(mm, pmd);
>  	pte_t *ptep = pte_offset_map(pmd, address);
> -	__migration_entry_wait(mm, ptep, ptl);
> +	__migration_entry_wait(mm, ptep, ptl, true);
>  }
>
>  void migration_entry_wait_huge(struct vm_area_struct *vma,
>  		struct mm_struct *mm, pte_t *pte)
>  {
>  	spinlock_t *ptl = huge_pte_lockptr(hstate_vma(vma), mm, pte);
> -	__migration_entry_wait(mm, pte, ptl);
> +	__migration_entry_wait(mm, pte, ptl, false);
>  }
>
>  #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
> @@ -324,7 +326,7 @@ void pmd_migration_entry_wait(struct mm_struct *mm, pmd_t *pmd)
>  	ptl = pmd_lock(mm, pmd);
>  	if (!is_pmd_migration_entry(*pmd))
>  		goto unlock;
> -	migration_entry_wait_on_locked(pmd_to_swp_entry(*pmd), NULL, ptl);
> +	migration_entry_wait_on_locked(pmd_to_swp_entry(*pmd), NULL, ptl, false);
>  	return;
>  unlock:
>  	spin_unlock(ptl);

--=-=-=--

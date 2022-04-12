Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C54B4FCC01
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 03:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbiDLBzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 21:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbiDLBzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 21:55:15 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3687672
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 18:52:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E0dEGMrvgTCIkeRtqOa9zB/MUTleJSGjkasIFUjrQmirV7kniqX0zJ0WyVLizaDke1k+h3iHnn9Vc2YBLH8J7dytzySvLbVLP+y0BKW6cXnt+GfOQKAvl6U9jyKVS8sgcjbzwqdbfEuivKRKS/HDZ/ccM9hGDE0PE7r6GKCQO25iiDXafpGgZVJQUup7lNjuImRW9wsp5Anoah8v+nf6otLwll1dF2Abpq3DLO/M/4bb5ZfWzDSrbYmvswuev65tz8V6sQPa3vj/+7Hg5jFcEuU7CDjdNkb5VI6GSsM1QIC70OOCmU2HKd1jQT8q7gK8LlEue2KpAHlecM+aMegzJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oknOcAgc2Q2iXqkZUXM+b+m2e+vP3UETLhWrrqzhCv4=;
 b=T/sA1hrZdRMuB8DsIo4T/Dk8dDX2gB+Foq2eo5w21r70I7p507uHWZvjl3P6rFir79O2y8qCi4IQXjDvjhtEG+Av7bRv9ApVFetcQlNa5XtckK7BQCo36jfcKnpB6IyiuMe52+HXCxlChq974USkN7FFodBuFZ9DVOdGpOG54cvv4p9XxZiZ2KCgQlxx3OIY0x7UdS8kw5tLeo6qYl7C0yx6h07o4Ktb+KyL+e0VFraUVvb6u9df8ZLabvbAzyyK2oIpMY3FEf7CYBGWh4ZjGtuyWnn/e1/5NvO5Gzevdh1NEHJUlGOMgYrNNj66odWZcEMLEcYHK2h4OAf4IXsoeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oknOcAgc2Q2iXqkZUXM+b+m2e+vP3UETLhWrrqzhCv4=;
 b=dC1z1oGtxXwtqig0q8yJsu1OojxCXUN2eLsqtJm/jL7z5zry/mngB5qcEnFIBrDI1GTskElACwIPaXty/T0Hrb5BgrbtUZjyCr+CYavBHYzootDGVfoXtZpxkna2CDNj9YUGuFrCKzi/NlatqNYV9OOXO5D0hAkg3Owrwv2REfbY1KbD6/0W1Y5dC5cXwDBwvsCLE67PUvCkY8K1042Dhln7tMXRY3pBpZEzXXOuJg8b/TiasUTSjLwJCjzPT1idDPOLQkRiuI+UmHYOFxu7b9pVVYKV1yZCna9joLfhKhFNt61dXGOqFmoWYgdy0wZYfcW62nS30MI1Kzc79vO3Vg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by MN2PR12MB3885.namprd12.prod.outlook.com (2603:10b6:208:16c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 01:52:57 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::2d17:b68a:e101:4c18]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::2d17:b68a:e101:4c18%6]) with mapi id 15.20.5144.029; Tue, 12 Apr 2022
 01:52:57 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>
Subject: Re: [PATCH v8 02/23] mm: Teach core mm about pte markers
Date:   Tue, 12 Apr 2022 11:22:01 +1000
References: <20220405014646.13522-1-peterx@redhat.com>
 <20220405014833.14015-1-peterx@redhat.com>
User-agent: mu4e 1.6.9; emacs 27.1
In-reply-to: <20220405014833.14015-1-peterx@redhat.com>
Message-ID: <87a6crawzy.fsf@nvdebian.thelocal>
Content-Type: multipart/mixed; boundary="=-=-="
X-ClientProxiedBy: SYCPR01CA0017.ausprd01.prod.outlook.com
 (2603:10c6:10:31::29) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e2aa190-0a19-42ca-b65d-08da1c272a6d
X-MS-TrafficTypeDiagnostic: MN2PR12MB3885:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3885C1E31D44F1E2A023511FDFED9@MN2PR12MB3885.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +nFm++nqpzd5CNN4G/JMsKSjr+A4GdJfGdZlFme5oqkDrsyZIIdpj+fQoUVYem5p6+1Pz39G3ljfLJDpoWMlL2ux5VDloUz9tq43+gw0sTgnuXPm1rUS8rhPKDVvlLiqwHuyg5+SnVmu+sQXkHJxr5quk5k5BK0gK/fvbg38eHr0Bx9FXJeqIh2FfXa0m06gwweduY7I4JWVE9YYMAqFq9opPZKBqGgnfjBU1E50IIFM78bf61SDEZfH0Y8WFKS5plNzDjlCU/J4K/4dSaG8k2H/2VkZhp+hW5AiUn2F8zwLGbc2CTY6u26JR4ko4lcMutv3nYAn4JvFAcL6irvRMqSLotsmgSdsyvP5zkXmLV5uKXjekShXtHTQLKQGbQ4WnFhFR51kuW2qeKRzWpzduLSvhBkZ7J87RrN4d3u4lFkFjjvan6+IKHEHJhkdH7/IWQz6owKrgYddpPo0oeLAjrwEt81zUIToE3Gsr6dOBf/Mrl53xsDb/SFdng07a47YHHEg5qto7tzLndjGPc3j4h11ARh3vd+Z9rG25v1GQ3XQEV+vKLhgs3R6td3h1Z6kKUCbEAynOpaYR9BP0fELEWYMhtpFEaVJ+k0j5Vn2gn5qR02CCyihb7H5phBhXm3oy9UEJlSVt9nEX77GOMRf7A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(66476007)(8936002)(7416002)(5660300002)(508600001)(9686003)(6512007)(186003)(44144004)(26005)(6506007)(6666004)(38100700002)(66946007)(83380400001)(86362001)(66556008)(54906003)(2906002)(4326008)(8676002)(6916009)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nBTPQxw6QSObYxmHPRCMYPG3NhiXAEaJbh3HMOe9Kcmrov8F+1Fm+CVkKYz1?=
 =?us-ascii?Q?/mDswzY8KHSngdR3a9/DE4jdDMNFyxJZaB8NT/3TXeq+ApHOlqw/BLniP4U+?=
 =?us-ascii?Q?sPUvYxe94cNAvV7cb+/dtHo+DR56O6pCbmxSnCD7aj1E7Ix7La3uYGbtDp6J?=
 =?us-ascii?Q?uxkZ/wzCArbJH/r5HqjNqNVmq7kRTiban6UC2BGhAnNFprxGh2A+Ot9QBX7n?=
 =?us-ascii?Q?0VXVxyTcyOCqH3fIW/3YTGHqNc0qIpUic0Tw1ZPhbZIOSGY8UlbUBXvNKLvB?=
 =?us-ascii?Q?A8XQW1V2BbIyP3f9ei3xoIEtKistM5t5DwtkECyL+1HhlVGM+6v226EucAWY?=
 =?us-ascii?Q?sjnGBOBJM0qzNczgdKDtWaUet3HLyKJAQgOJCqwbM4MGyoD45pkf+wXZ8lpM?=
 =?us-ascii?Q?X5sWjvIwZ1G4JFdGFjqNJ3c2V4w4MKXnUGMWzgMM5jvQJ/qtFl/z16tRnd22?=
 =?us-ascii?Q?sjfgHNTmO+ylWM6ZYLvbLdhdylUpwy9nIJSn97oqKxpX0yeNb2BbojzZTvs8?=
 =?us-ascii?Q?2KM4TaT19AWCn4FnwM480njxrlQaK+oSjWKPAGMVDtnAo12Tpu1mqYcPGd1l?=
 =?us-ascii?Q?c4Qxhp+pD08In0fSe/5TlFfgPpP/fa+uPC0jZrrNw+DwOtyx3ztVywwNI3qy?=
 =?us-ascii?Q?vSorafnzwmyyfbjE6liASxKKSpTwXrXDBTGXwXbamriHZAzlbA22N5X9jnQ9?=
 =?us-ascii?Q?hAt3wrsqOVcoK5IcQQLKkfAkXvKMhAuCBP222L8rR38UVVuAQuq23XSD0rOa?=
 =?us-ascii?Q?4Qc1YSg8/3EKqn65w/c0Y2huAsrjM8ZBwnyf0a/dl18hOu13C2/qwhyVRyAF?=
 =?us-ascii?Q?Tcj8BCgx+de0AWCdDn+0HnZfLD77/A0Bqxo1HtWZStjFYxCHaVZ8CjX5N3Tz?=
 =?us-ascii?Q?sj9j0wx3lXRs3tKhwVJklnlZ1mtNGWYRjrtBrR8JbvMc2ekJRpU+7nx31a5z?=
 =?us-ascii?Q?hnWChytX09jd5RoxuzNuWiy948yvdGrgrvXesE5ZRkJeb9UQ2vT+mKXjQhtB?=
 =?us-ascii?Q?Y5uV9MGG1bf6yzriYMhaf9+BFl3ee/R6RPZKolXP12tCNhMWoTK+5Sj9b4Df?=
 =?us-ascii?Q?LSdsJVv+X2hq+BgzrJsFFo5cBl2xgLUVhvfW1TBuZ5nU2hklOrXClxLPFbHt?=
 =?us-ascii?Q?gnniF3Vt+FRlqHDehbe5N9Cn/sO5N17l+4wMJCXRqcJ4JvLGP+AGnSn8Akof?=
 =?us-ascii?Q?sDwc16Vi9g9DmVJ7z9wqMidhnMs6xfuu0U3Ege2hV4rkkDMhknlcH6Gmfbfe?=
 =?us-ascii?Q?GlZnfBOke6BwYrIb16LXXtm9em4Wj/DRkzZRrFZxeKcnmy3IRRcutiebOOz1?=
 =?us-ascii?Q?Xa1lo1U8w0FjNf1iM/CNzShASkGh4BvoFUfSgjxPc/CrZD0sqDk0nvXMeAbt?=
 =?us-ascii?Q?tAkPHTT8+BonI5pV+yHaut2JzkHPFk1FetoYzwLXrqsOzCgXKfucGhm+5vbc?=
 =?us-ascii?Q?x5i92Im5bBL+ae67Muzmm+9oz8xBo8UjqRJckbKZex61QzQGxdSGiEkGxLTM?=
 =?us-ascii?Q?jtQs6F/umcMbDtJoOmYgAF+3fToLDcPvDbTtWNTb84HMi0q2x8689e2qRqwp?=
 =?us-ascii?Q?go9YJmtBUMjTZy7ikt3jmxoXzOO0/Qs5+Nyyu3bcHPmPQojwRrmaNiuYaJB3?=
 =?us-ascii?Q?+QCfThuJtZmMYU3ixBD81UWyLg8b8jojp2ZP5GtrhaA/Q29wfnihyF03cFR0?=
 =?us-ascii?Q?gFTRH+1RtOM3RoYguienRYvw2XUnUrpNEKeymEvL8pPbOKS8rIwPOmKj4eYR?=
 =?us-ascii?Q?GXqYlj25Qg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e2aa190-0a19-42ca-b65d-08da1c272a6d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2022 01:52:57.0450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uT2JA0EH/ldz76c+ME4GWPtzkMU/adtnxDu8OhKeivOhmUqYwMK85PCtE24wNt4Sz/1DaC8x9/vdQtJj415a8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3885
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

I've been reviewing existing pte_none() call sites and noticed the following:

From khugepaged_scan_pmd():

pte_t pteval = *_pte;
if (is_swap_pte(pteval)) {
    if (++unmapped <= khugepaged_max_ptes_swap) {
        /*
* Always be strict with uffd-wp
* enabled swap entries.  Please see
* comment below for pte_uffd_wp().
         */
        if (pte_swp_uffd_wp(pteval)) {
            result = SCAN_PTE_UFFD_WP;
            goto out_unmap;
        }
        continue;
    } else {
        result = SCAN_EXCEED_SWAP_PTE;
        count_vm_event(THP_SCAN_EXCEED_SWAP_PTE);
        goto out_unmap;
    }
}
if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
    if (!userfaultfd_armed(vma) &&
        ++none_or_zero <= khugepaged_max_ptes_none) {
        continue;
    } else {
        result = SCAN_EXCEED_NONE_PTE;
        count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
        goto out_unmap;
    }
}

I think the above could encounter a marker PTE right? So the behviour would be
wrong in that case. As I understand things the is_swap_pte() path will be taken
rather than pte_none() but in the absence of any special handling shouldn't
marker PTE's mostly be treated as pte_none() here?

I think you need to s/pte_none/pte_none_mostly/ here and swap the order of
conditionals around.

- Alistair

Peter Xu <peterx@redhat.com> writes:

> This patch still does not use pte marker in any way, however it teaches the
> core mm about the pte marker idea.
>
> For example, handle_pte_marker() is introduced that will parse and handle all
> the pte marker faults.
>
> Many of the places are more about commenting it up - so that we know there's
> the possibility of pte marker showing up, and why we don't need special code
> for the cases.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  fs/userfaultfd.c | 10 ++++++----
>  mm/filemap.c     |  5 +++++
>  mm/hmm.c         |  2 +-
>  mm/memcontrol.c  |  8 ++++++--
>  mm/memory.c      | 23 +++++++++++++++++++++++
>  mm/mincore.c     |  3 ++-
>  mm/mprotect.c    |  3 +++
>  7 files changed, 46 insertions(+), 8 deletions(-)
>
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index aa0c47cb0d16..8b4a94f5a238 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -249,9 +249,10 @@ static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *ctx,
>
>  	/*
>  	 * Lockless access: we're in a wait_event so it's ok if it
> -	 * changes under us.
> +	 * changes under us.  PTE markers should be handled the same as none
> +	 * ptes here.
>  	 */
> -	if (huge_pte_none(pte))
> +	if (huge_pte_none_mostly(pte))
>  		ret = true;
>  	if (!huge_pte_write(pte) && (reason & VM_UFFD_WP))
>  		ret = true;
> @@ -330,9 +331,10 @@ static inline bool userfaultfd_must_wait(struct userfaultfd_ctx *ctx,
>  	pte = pte_offset_map(pmd, address);
>  	/*
>  	 * Lockless access: we're in a wait_event so it's ok if it
> -	 * changes under us.
> +	 * changes under us.  PTE markers should be handled the same as none
> +	 * ptes here.
>  	 */
> -	if (pte_none(*pte))
> +	if (pte_none_mostly(*pte))
>  		ret = true;
>  	if (!pte_write(*pte) && (reason & VM_UFFD_WP))
>  		ret = true;
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 3a5ffb5587cd..ef77dae8c28d 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3382,6 +3382,11 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
>  		vmf->pte += xas.xa_index - last_pgoff;
>  		last_pgoff = xas.xa_index;
>
> +		/*
> +		 * NOTE: If there're PTE markers, we'll leave them to be
> +		 * handled in the specific fault path, and it'll prohibit the
> +		 * fault-around logic.
> +		 */
>  		if (!pte_none(*vmf->pte))
>  			goto unlock;
>
> diff --git a/mm/hmm.c b/mm/hmm.c
> index af71aac3140e..3fd3242c5e50 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -239,7 +239,7 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
>  	pte_t pte = *ptep;
>  	uint64_t pfn_req_flags = *hmm_pfn;
>
> -	if (pte_none(pte)) {
> +	if (pte_none_mostly(pte)) {
>  		required_fault =
>  			hmm_pte_need_fault(hmm_vma_walk, pfn_req_flags, 0);
>  		if (required_fault)
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 7a08737bac4b..08af97c73f0f 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5644,10 +5644,14 @@ static enum mc_target_type get_mctgt_type(struct vm_area_struct *vma,
>
>  	if (pte_present(ptent))
>  		page = mc_handle_present_pte(vma, addr, ptent);
> +	else if (pte_none_mostly(ptent))
> +		/*
> +		 * PTE markers should be treated as a none pte here, separated
> +		 * from other swap handling below.
> +		 */
> +		page = mc_handle_file_pte(vma, addr, ptent);
>  	else if (is_swap_pte(ptent))
>  		page = mc_handle_swap_pte(vma, ptent, &ent);
> -	else if (pte_none(ptent))
> -		page = mc_handle_file_pte(vma, addr, ptent);
>
>  	if (!page && !ent.val)
>  		return ret;
> diff --git a/mm/memory.c b/mm/memory.c
> index 2c5d1bb4694f..3f396241a7db 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -100,6 +100,8 @@ struct page *mem_map;
>  EXPORT_SYMBOL(mem_map);
>  #endif
>
> +static vm_fault_t do_fault(struct vm_fault *vmf);
> +
>  /*
>   * A number of key systems in x86 including ioremap() rely on the assumption
>   * that high_memory defines the upper bound on direct map memory, then end
> @@ -1415,6 +1417,8 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
>  			if (!should_zap_page(details, page))
>  				continue;
>  			rss[mm_counter(page)]--;
> +		} else if (is_pte_marker_entry(entry)) {
> +			/* By default, simply drop all pte markers when zap */
>  		} else if (is_hwpoison_entry(entry)) {
>  			if (!should_zap_cows(details))
>  				continue;
> @@ -3555,6 +3559,23 @@ static inline bool should_try_to_free_swap(struct page *page,
>  		page_count(page) == 2;
>  }
>
> +static vm_fault_t handle_pte_marker(struct vm_fault *vmf)
> +{
> +	swp_entry_t entry = pte_to_swp_entry(vmf->orig_pte);
> +	unsigned long marker = pte_marker_get(entry);
> +
> +	/*
> +	 * PTE markers should always be with file-backed memories, and the
> +	 * marker should never be empty.  If anything weird happened, the best
> +	 * thing to do is to kill the process along with its mm.
> +	 */
> +	if (WARN_ON_ONCE(vma_is_anonymous(vmf->vma) || !marker))
> +		return VM_FAULT_SIGBUS;
> +
> +	/* TODO: handle pte markers */
> +	return 0;
> +}
> +
>  /*
>   * We enter with non-exclusive mmap_lock (to exclude vma changes,
>   * but allow concurrent faults), and pte mapped but not yet locked.
> @@ -3592,6 +3613,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  			ret = vmf->page->pgmap->ops->migrate_to_ram(vmf);
>  		} else if (is_hwpoison_entry(entry)) {
>  			ret = VM_FAULT_HWPOISON;
> +		} else if (is_pte_marker_entry(entry)) {
> +			ret = handle_pte_marker(vmf);
>  		} else {
>  			print_bad_pte(vma, vmf->address, vmf->orig_pte, NULL);
>  			ret = VM_FAULT_SIGBUS;
> diff --git a/mm/mincore.c b/mm/mincore.c
> index f4f627325e12..fa200c14185f 100644
> --- a/mm/mincore.c
> +++ b/mm/mincore.c
> @@ -122,7 +122,8 @@ static int mincore_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
>  	for (; addr != end; ptep++, addr += PAGE_SIZE) {
>  		pte_t pte = *ptep;
>
> -		if (pte_none(pte))
> +		/* We need to do cache lookup too for pte markers */
> +		if (pte_none_mostly(pte))
>  			__mincore_unmapped_range(addr, addr + PAGE_SIZE,
>  						 vma, vec);
>  		else if (pte_present(pte))
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index 56060acdabd3..709a6f73b764 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -188,6 +188,9 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
>  					newpte = pte_swp_mksoft_dirty(newpte);
>  				if (pte_swp_uffd_wp(oldpte))
>  					newpte = pte_swp_mkuffd_wp(newpte);
> +			} else if (is_pte_marker_entry(entry)) {
> +				/* Skip it, the same as none pte */
> +				continue;
>  			} else {
>  				newpte = oldpte;
>  			}

--=-=-=--

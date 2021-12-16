Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 922A5476A09
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 06:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbhLPF4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 00:56:53 -0500
Received: from mail-co1nam11on2076.outbound.protection.outlook.com ([40.107.220.76]:9537
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230525AbhLPF4v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 00:56:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XhLXpQ0NRtg4QkSwipuQM5TPRYkTn3tAm3MHQ4aX04ATEufGV7LO6HFeVljfn6L7PHzxMTSsYaRddKrnOT/nrdoyqVSPOxJv54DiJB1+KYX3GiEtdpGhTFosRpEdSIQErwCOUgn7eyqtzl970EfmoF8lt1KXvE438uzk5o3cNfn71OBfIw+p3e5hppI8guwClI9pR+/LOtGX0/VXpRp/5p9jlg+NrdPhV0+Xkpihqc3ukigwhBee/4K2O/FT3A2jKqjSlgrxuMBeQ1on5Uox4Uiik04ZaxvBI4cPK+xEbKqj4Lp+TiQVPAxPVbnpT9VWFGpqzOUH8MojL/E3LXfaRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=giD7Hvp9dfBJ7xCErgLtrFaZf1+jDEF2LwS21UHZ/cI=;
 b=WqERgEJ+TQhLwCIcsAXBm7Z54ukbAj1LS9EGUXTEHThwuj0ID4EcOG7RerpG2HjOA5N0wr6U2wdyx6VknpGaeRuusBWm71vGe3fn5qNbL3biEenklrFG1WBOiowHc7ABXZIOwfZRL+Fw85FWv1pLYpQt+l1WwTzATcYAPMtiWTbmmK4dfnCcgGdxzYuzrc9ZVLT/nYAMXivq3edZ0ra56X6YG+FYXjEJvmoNbgor9Zic24Jndyuv1yghhTxMTXSZ+uFTr/an9G+X9b0mVjb0ihE6YmuHlHp7WRVtJ92uBKwA9Z+yYnwlOgxbejKMpuy+rn2etXmOIk0JRWSE+TRvGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=giD7Hvp9dfBJ7xCErgLtrFaZf1+jDEF2LwS21UHZ/cI=;
 b=jItAbqQrfmD4WaPEGbj9mDP7w7R5B0GrcGEydcOvJUqzBjVq71Etfmxc5QOgFqTqCiaIQPXiXcUutKw1vZJX0so2r4LYs9+ceIWvVpJ5Cr97PRFEZnlsNELNI3RiFma2mLFxejOVQNvLdGzc+HfPmX+TD/t2vXiwjEZtrRFJ8ftZtN/4mZuAtqz/2z9RMG4CZkJc2H3AprbWWEMyUxebwW77lpBzlx+dXxpnYfQ53lRNmpU9nu5xaUl7wCrWqHq0u37J2/IWEIfBZ53uFW4djOHp5O4g78LEniBWj6XuWsMK58M6vFwV8rjohKVidg4yJeZQVSn41FRv5z0v5o9VqQ==
Received: from DM6PR04CA0006.namprd04.prod.outlook.com (2603:10b6:5:334::11)
 by MN2PR12MB3901.namprd12.prod.outlook.com (2603:10b6:208:16c::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Thu, 16 Dec
 2021 05:56:49 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::f8) by DM6PR04CA0006.outlook.office365.com
 (2603:10b6:5:334::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17 via Frontend
 Transport; Thu, 16 Dec 2021 05:56:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4801.14 via Frontend Transport; Thu, 16 Dec 2021 05:56:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 16 Dec
 2021 05:56:48 +0000
Received: from nvdebian.localnet (172.20.187.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.9; Wed, 15 Dec 2021
 21:56:44 -0800
From:   Alistair Popple <apopple@nvidia.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Peter Xu <peterx@redhat.com>
CC:     Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Hugh Dickins <hughd@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jerome Glisse <jglisse@redhat.com>,
        "Matthew Wilcox" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH v6 06/23] mm/shmem: Handle uffd-wp special pte in page fault handler
Date:   Thu, 16 Dec 2021 16:56:42 +1100
Message-ID: <6587740.tPqSsf18xI@nvdebian>
In-Reply-To: <20211115075522.73795-7-peterx@redhat.com>
References: <20211115075522.73795-1-peterx@redhat.com> <20211115075522.73795-7-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 089aa827-ed3f-4fa0-30b6-08d9c058d9c0
X-MS-TrafficTypeDiagnostic: MN2PR12MB3901:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB39011A1403953B4971FEDEACDF779@MN2PR12MB3901.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c+dwpNjYYj+4Zrvt8N/0jSZC7BQH+EAHMFLUMdqwLl1nnGWGz4Wa6sI0v0XOAAkUH9oD4hyrXey8FLUoJIeEuN3k6MbZ0pCjA71bT2IRAMh9svyQinLjKkrFvWZfT4FuID45ns4Uq9RZA0S+2EDtQwlW4vR3aYd45Y/ET4vQQSSH0kR4tgy1rzkqckn/CoqDpabdxOa5IP4JGg612FfnlnyNOej/ipVR1pW4QJ+vLtIoL9SMuphdsCbVlOZzntipIyoGn/Fk4bXUdvZThqzp1eU/3RPuvVhWMs4e+4bg0PWoGF0FnZH5NugxDxKRw1te9QPrLPdVoQEYfU/Vzkk4Meqkp5MrpZrZXnlIJQEC2UlzfoN8nk0zeDJj/SysNbMgAFWOifDBwnY4bVtaStoxvSULPYUjyXiLyNW/0CARVwBo38Ok6zDC3Bl7dnQrMnFrrlYiIsCbr4ROwza4tsfFTjgDpaA6ckMY99uemT6XaI1mfvKzQTCXY24yKdg+5VQDpl54AK46SVPIXLvbNfnievm8XRWCecNdX8j70fIkjZCx2/7ycbr7+9S2dcPNuQkN8yQUeiHUFGG44gnNjBQZ68MNxdpENw1qyeZ9OgyA8Mm530UviURJ646dWwUaL49nfID/CQ8yEnidAe+XFmES+H5h0DffzMrMae+O3e8nYAEr10c+eIZez7ehT4JRJqEqmB6/cTG8lSCrJpZ0fbkn9E9ti2Ysz9egMU6b9+XYg7p9cpDI2m9UD8mDC/HTzydkDa00OWn76lJyqmp+25tBGSzdzYD3GRlA56DteCSNwfwcW1q+MNBASdRBczGabR+62CXtrq/IyZrnBJvmZN1d7Y1P0de1wIId4gPKtwNDhjdjz4UrH42gqV+Vv0hfE1sQ
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(426003)(34020700004)(2906002)(316002)(82310400004)(16526019)(186003)(40460700001)(33716001)(508600001)(26005)(4326008)(5660300002)(81166007)(356005)(47076005)(7416002)(8676002)(9576002)(83380400001)(36860700001)(70586007)(70206006)(9686003)(8936002)(86362001)(54906003)(110136005)(336012)(39026012)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 05:56:49.1224
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 089aa827-ed3f-4fa0-30b6-08d9c058d9c0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3901
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 15 November 2021 6:55:05 PM AEDT Peter Xu wrote:

[...]

> diff --git a/mm/memory.c b/mm/memory.c
> index d5966d9e24c3..e8557d43a87d 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3452,6 +3452,43 @@ static vm_fault_t remove_device_exclusive_entry(struct vm_fault *vmf)
>  	return 0;
>  }
>  
> +static vm_fault_t pte_marker_clear(struct vm_fault *vmf)
> +{
> +	vmf->pte = pte_offset_map_lock(vmf->vma->vm_mm, vmf->pmd,
> +				       vmf->address, &vmf->ptl);
> +	/*
> +	 * Be careful so that we will only recover a special uffd-wp pte into a
> +	 * none pte.  Otherwise it means the pte could have changed, so retry.
> +	 */
> +	if (is_pte_marker(*vmf->pte))
> +		pte_clear(vmf->vma->vm_mm, vmf->address, vmf->pte);
> +	pte_unmap_unlock(vmf->pte, vmf->ptl);
> +	return 0;
> +}
> +
> +/*
> + * This is actually a page-missing access, but with uffd-wp special pte
> + * installed.  It means this pte was wr-protected before being unmapped.
> + */
> +static vm_fault_t pte_marker_handle_uffd_wp(struct vm_fault *vmf)
> +{
> +	/* Careful!  vmf->pte unmapped after return */
> +	if (!pte_unmap_same(vmf))

Hasn't vmf->pte already been unmapped by do_swap_page() by the time we get
here?

> +		return 0;
> +
> +	/*
> +	 * Just in case there're leftover special ptes even after the region
> +	 * got unregistered - we can simply clear them.  We can also do that
> +	 * proactively when e.g. when we do UFFDIO_UNREGISTER upon some uffd-wp
> +	 * ranges, but it should be more efficient to be done lazily here.
> +	 */
> +	if (unlikely(!userfaultfd_wp(vmf->vma) || vma_is_anonymous(vmf->vma)))
> +		return pte_marker_clear(vmf);
> +
> +	/* do_fault() can handle pte markers too like none pte */
> +	return do_fault(vmf);
> +}
> +
>  static vm_fault_t handle_pte_marker(struct vm_fault *vmf)
>  {
>  	swp_entry_t entry = pte_to_swp_entry(vmf->orig_pte);
> @@ -3465,8 +3502,11 @@ static vm_fault_t handle_pte_marker(struct vm_fault *vmf)
>  	if (WARN_ON_ONCE(vma_is_anonymous(vmf->vma) || !marker))
>  		return VM_FAULT_SIGBUS;
>  
> -	/* TODO: handle pte markers */
> -	return 0;
> +	if (marker & PTE_MARKER_UFFD_WP)

Can we make this check `marker == PTE_MARKER_UFFD_WP`? There is currently only
one user of pte markers, and from what I can tell pte_marker_handle_uffd_wp()
wouldn't do the correct thing if other users were added because it could clear
non-uffd-wp markers. I don't think it's worth making it do the right thing now,
but a comment noting that would be helpful.

> +		return pte_marker_handle_uffd_wp(vmf);
> +
> +	/* This is an unknown pte marker */
> +	return VM_FAULT_SIGBUS;
>  }
>  
>  /*
> @@ -3968,6 +4008,7 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
>  void do_set_pte(struct vm_fault *vmf, struct page *page, unsigned long addr)
>  {
>  	struct vm_area_struct *vma = vmf->vma;
> +	bool uffd_wp = is_pte_marker_uffd_wp(vmf->orig_pte);
>  	bool write = vmf->flags & FAULT_FLAG_WRITE;
>  	bool prefault = vmf->address != addr;
>  	pte_t entry;
> @@ -3982,6 +4023,8 @@ void do_set_pte(struct vm_fault *vmf, struct page *page, unsigned long addr)
>  
>  	if (write)
>  		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
> +	if (unlikely(uffd_wp))
> +		entry = pte_mkuffd_wp(pte_wrprotect(entry));
>  	/* copy-on-write page */
>  	if (write && !(vma->vm_flags & VM_SHARED)) {
>  		inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES);
> @@ -4155,9 +4198,21 @@ static vm_fault_t do_fault_around(struct vm_fault *vmf)
>  	return vmf->vma->vm_ops->map_pages(vmf, start_pgoff, end_pgoff);
>  }
>  
> +/* Return true if we should do read fault-around, false otherwise */
> +static inline bool should_fault_around(struct vm_fault *vmf)
> +{
> +	/* No ->map_pages?  No way to fault around... */
> +	if (!vmf->vma->vm_ops->map_pages)
> +		return false;
> +
> +	if (uffd_disable_fault_around(vmf->vma))
> +		return false;
> +
> +	return fault_around_bytes >> PAGE_SHIFT > 1;
> +}
> +
>  static vm_fault_t do_read_fault(struct vm_fault *vmf)
>  {
> -	struct vm_area_struct *vma = vmf->vma;
>  	vm_fault_t ret = 0;
>  
>  	/*
> @@ -4165,12 +4220,10 @@ static vm_fault_t do_read_fault(struct vm_fault *vmf)
>  	 * if page by the offset is not ready to be mapped (cold cache or
>  	 * something).
>  	 */
> -	if (vma->vm_ops->map_pages && fault_around_bytes >> PAGE_SHIFT > 1) {
> -		if (likely(!userfaultfd_minor(vmf->vma))) {
> -			ret = do_fault_around(vmf);
> -			if (ret)
> -				return ret;
> -		}
> +	if (should_fault_around(vmf)) {
> +		ret = do_fault_around(vmf);
> +		if (ret)
> +			return ret;
>  	}
>  
>  	ret = __do_fault(vmf);
> 





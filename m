Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD37476A5D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 07:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234111AbhLPGaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 01:30:22 -0500
Received: from mail-mw2nam12on2069.outbound.protection.outlook.com ([40.107.244.69]:9697
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234099AbhLPGaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 01:30:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gwarj1YwG2n9ORrW6SQzSfByxDdZumNvKT7Evv/loZdUJG8aD4svjyfTVZvCTv3s57dlJY20Y80Eb0aYIyYPAc2PalyKut2MOODsGHBWZS78r3wWK/YupLP9K20rb1pAOjg4MTncQCIFgdBDb3sgtk6Jev0mda1c64Fk+YuwxsoLsOsn4FaqV3CEG5KqjN+zHrcbVdT40wZMjjfKm3KYEyDXr/c0uACMfEVlU9xpwoaJ+4U0sdZWv+5zPTXn4GTNi3/z3MGIW1Eh8ErQvr/v2wYoKrRXL9I1sjo8WNtjuXY4pYdLhdk58dSJepN2gtZI+XeXTvxcZ6xbql2FNLa9JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=axX94IBOwqM5tzJRDgpZyIMR9KCF8MufZTtLT7QDbiQ=;
 b=jFt7RDuLoCk8vbkeM4RZZrykB6MRnuurCm6ptsA9zEFHd4BqQvaDZn7FzpEDIibMG81nzHnxov0ZYZjlzQVO/1SVJrQ0/gnSmvSRe98rT6jgAJOUhfB3vrejoKe7oFXnsJlvv6cCgqv/kvkIrNVXxRCcB7yNj7IWRLtc9BoewJYCXai1bYuGXDH8e1+b9sh7Y3l4RO7nbFrAqMaakAgBOV2USZ8vXfVsmBSWwRD4hrAjK7XWlS+w3j5cLHXNnohBaR4Xyk11KJdY4OAxR6axA8o7ngXtTMN5Roxkn5FrkHR9EOR4wwup5dUfIxWuTdJIoOFrXIs4AVOPlyT3Aq4UpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=axX94IBOwqM5tzJRDgpZyIMR9KCF8MufZTtLT7QDbiQ=;
 b=BLXWmHeReI5nsxxqE2i+/RiPkp28gdua5Ntit+GpAJzC4pi0IYI8VNF2XACEJS8bBxJJjnhdTkvwgY7tEwXqkZN8jRLm9rHlPQc3EzWmxuCE1Ny0d9vS+58HFyBdLM9DW9spe5xY/vwsZAEu/0JqILMbomws/za6yHZI+q2tEQRSmN5z7Pz9GbXGYc/+f4o98vvhWvbAJw/dW+tXnYAlFlhsR7UZh57Tz64yxf0Og7q9lGo7MNwfTReJa/I0hw0GU6j66yVrD7oHnM/nvO6T0R4gpCah3iP2BOJwQDcr+OmZK/lL+RPv5hGSo8mmLvEysAnUbAKcE3asQsV2K3h8Dg==
Received: from BN9PR03CA0983.namprd03.prod.outlook.com (2603:10b6:408:109::28)
 by CY4PR12MB1303.namprd12.prod.outlook.com (2603:10b6:903:40::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Thu, 16 Dec
 2021 06:30:20 +0000
Received: from BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::3a) by BN9PR03CA0983.outlook.office365.com
 (2603:10b6:408:109::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14 via Frontend
 Transport; Thu, 16 Dec 2021 06:30:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT061.mail.protection.outlook.com (10.13.177.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4778.13 via Frontend Transport; Thu, 16 Dec 2021 06:30:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 16 Dec
 2021 06:30:18 +0000
Received: from nvdebian.localnet (172.20.187.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.9; Wed, 15 Dec 2021
 22:30:14 -0800
From:   Alistair Popple <apopple@nvidia.com>
To:     Peter Xu <peterx@redhat.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Hugh Dickins <hughd@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jerome Glisse <jglisse@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH v6 06/23] mm/shmem: Handle uffd-wp special pte in page fault handler
Date:   Thu, 16 Dec 2021 17:30:12 +1100
Message-ID: <8160258.WfFtTLUMm5@nvdebian>
In-Reply-To: <YbrZ+p8MPLdk/Lvi@xz-m1.local>
References: <20211115075522.73795-1-peterx@redhat.com> <6587740.tPqSsf18xI@nvdebian> <YbrZ+p8MPLdk/Lvi@xz-m1.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea99ec2e-e120-49ef-8dc4-08d9c05d8860
X-MS-TrafficTypeDiagnostic: CY4PR12MB1303:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1303E218DA5309E3641E6110DF779@CY4PR12MB1303.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i5XzOixvOKgaQcKKKQdy5cf6cPRU25C+pMe1+ecZlzZCWEo/oGe3qHTQ22nQyXvx60s7L6WZl37sCzPmIjFEZ9N3v+tJ4DNk1wTdiIahjQOyDURVTdlJ2EvdtGRx/zlyDmLpADJg7WgeuhQ7Z3d8aYrEVJAi8wdIeEU6iTfyQqO3mTnYMhYhMHe+QCSzxVzJXMK5jv78+L4kuWt/l7FHwNOrA7r3qy2gOTgB+ds8wbhpAeASVR6f/yoydB4xolH0pfnMybpkdqpXfFsZKHQ40Kr3cxxd46n6yxDUhqT0XmP1DubvcIVZ03jJVXAg+niDrrZTJ4U9INlnlhXSxzFzJUbeORsPB0sYmn/6Kq32WEWmZUtVoGIFayHoPLpu1buRVUfs8gg68+koEZ2nlhv9GJNW1h1Gj7d86z2xu1tvPS2wv1HuCKdhySuy+AJFLxIMQjdZw+WPcfgMzDJ3IAAGX2Y+IWGgTM/rONGGecHkrKgjaYqDdr8/ZpQsvDCKg8nW8k0bq4KhHnkReeXF3JS+W0dnIFzoXaBf3d5pY5r0GN03Y12o7QyUE7710U36m/0CoqKWa/gCQqoJkFCskkQyb4mzi0bjqWD+caRVNCT7gbfYUNYJLZrof0jROSctWR+ffq0aQ7L6XkJoQoqV1Qyb2galbkqA/lLE0xDFT62kAZwWGq9IDLQbAQv5wv1GmzCfEUOyKCUT1EKEndTvNnmenw8dUlF731UBlMpHpq208NdUgxOmjPbgxbwkZR3ieXjgCigsuOdAXPKyyTSrt/LNM+iiyGd2zAtUOmWQHqt1yYGB+t7ChUh0CgkLdCIPwQZgO5hYV5Mhf4HmIzI8iHZPkoyGsXqwcvNBQ+Jhw+xRn2I=
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(7416002)(26005)(86362001)(54906003)(6916009)(5660300002)(336012)(70586007)(8676002)(356005)(70206006)(34020700004)(81166007)(508600001)(8936002)(47076005)(4326008)(2906002)(33716001)(426003)(82310400004)(40460700001)(36860700001)(316002)(16526019)(9686003)(83380400001)(9576002)(186003)(39026012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 06:30:20.0281
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea99ec2e-e120-49ef-8dc4-08d9c05d8860
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1303
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 16 December 2021 5:17:30 PM AEDT Peter Xu wrote:
> On Thu, Dec 16, 2021 at 04:56:42PM +1100, Alistair Popple wrote:
> > On Monday, 15 November 2021 6:55:05 PM AEDT Peter Xu wrote:
> > 
> > [...]
> > 
> > > diff --git a/mm/memory.c b/mm/memory.c
> > > index d5966d9e24c3..e8557d43a87d 100644
> > > --- a/mm/memory.c
> > > +++ b/mm/memory.c
> > > @@ -3452,6 +3452,43 @@ static vm_fault_t remove_device_exclusive_entry(struct vm_fault *vmf)
> > >  	return 0;
> > >  }
> > >  
> > > +static vm_fault_t pte_marker_clear(struct vm_fault *vmf)
> > > +{
> > > +	vmf->pte = pte_offset_map_lock(vmf->vma->vm_mm, vmf->pmd,
> > > +				       vmf->address, &vmf->ptl);
> > > +	/*
> > > +	 * Be careful so that we will only recover a special uffd-wp pte into a
> > > +	 * none pte.  Otherwise it means the pte could have changed, so retry.
> > > +	 */
> > > +	if (is_pte_marker(*vmf->pte))
> > > +		pte_clear(vmf->vma->vm_mm, vmf->address, vmf->pte);
> > > +	pte_unmap_unlock(vmf->pte, vmf->ptl);
> > > +	return 0;
> > > +}
> > > +
> > > +/*
> > > + * This is actually a page-missing access, but with uffd-wp special pte
> > > + * installed.  It means this pte was wr-protected before being unmapped.
> > > + */
> > > +static vm_fault_t pte_marker_handle_uffd_wp(struct vm_fault *vmf)
> > > +{
> > > +	/* Careful!  vmf->pte unmapped after return */
> > > +	if (!pte_unmap_same(vmf))
> > 
> > Hasn't vmf->pte already been unmapped by do_swap_page() by the time we get
> > here?
> 
> Great catch, thanks!
> 
> It was needed before with the "swap special pte" version because that was
> handled outside do_swap_page().  After the rebase I forgot to remove it.

No worries, and for what it's worth IMHO this version that handles it inside
do_swap_page() along with all the other "special" cases is much nicer.

> I believe it didn't crash simply because we've got commit 2ca99358671a ("mm:
> clear vmf->pte after pte_unmap_same() returns", 2021-11-06) very recently so it
> just became a safe no-op, so all things will still work.
> 
> I'll drop it.
> 
> > 
> > > +		return 0;
> > > +
> > > +	/*
> > > +	 * Just in case there're leftover special ptes even after the region
> > > +	 * got unregistered - we can simply clear them.  We can also do that
> > > +	 * proactively when e.g. when we do UFFDIO_UNREGISTER upon some uffd-wp
> > > +	 * ranges, but it should be more efficient to be done lazily here.
> > > +	 */
> > > +	if (unlikely(!userfaultfd_wp(vmf->vma) || vma_is_anonymous(vmf->vma)))
> > > +		return pte_marker_clear(vmf);
> > > +
> > > +	/* do_fault() can handle pte markers too like none pte */
> > > +	return do_fault(vmf);
> > > +}
> > > +
> > >  static vm_fault_t handle_pte_marker(struct vm_fault *vmf)
> > >  {
> > >  	swp_entry_t entry = pte_to_swp_entry(vmf->orig_pte);
> > > @@ -3465,8 +3502,11 @@ static vm_fault_t handle_pte_marker(struct vm_fault *vmf)
> > >  	if (WARN_ON_ONCE(vma_is_anonymous(vmf->vma) || !marker))
> > >  		return VM_FAULT_SIGBUS;
> > >  
> > > -	/* TODO: handle pte markers */
> > > -	return 0;
> > > +	if (marker & PTE_MARKER_UFFD_WP)
> > 
> > Can we make this check `marker == PTE_MARKER_UFFD_WP`? There is currently only
> > one user of pte markers, and from what I can tell pte_marker_handle_uffd_wp()
> > wouldn't do the correct thing if other users were added because it could clear
> > non-uffd-wp markers. I don't think it's worth making it do the right thing now,
> > but a comment noting that would be helpful.
> 
> Sure thing, and yeah I agree it's trivial and shouldn't matter in real-life.
> 
> I'll change it to "marker == PTE_MARKER_UFFD_WP" as you suggested, so if
> there's surprise we'll get a sigbus.
> 
> Thanks,
> 
> > 
> > > +		return pte_marker_handle_uffd_wp(vmf);
> > > +
> > > +	/* This is an unknown pte marker */
> > > +	return VM_FAULT_SIGBUS;
> > >  }
> 
> 





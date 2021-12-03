Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE6594671B1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 06:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378508AbhLCFjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 00:39:13 -0500
Received: from mail-bn8nam08on2057.outbound.protection.outlook.com ([40.107.100.57]:62335
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1378490AbhLCFjL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 00:39:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h6f+32FXd0ZOIwbEQKXzs9cImJ/sCfBVR2vKSKplDWPqPVV8YK9H3kPjbabtPG1DQhzhI4xBtolxNT+94656sRF4fzIAKc9iZd+SX/JWpjp0NB9yEM0kdtRt9IZ921tk6E5JmSWaPCc2CTJ2DnXGkAJoUmWj1h5WDKM2ADVpeDnx8EFHk/nWrb/5h3XxLma2PyfMLs/JWTRCXy5cle+9MYg71yLZCgf+Zds+aAGYsypYxbKpVZ+XrCbsIi21rfWHaVHvYX3f+g1BhBAoPmZxYPyayr3JeTGq2ulSjNaOc9mBDDVAlxYDyLxpD2Dd6Rzq7xDJ73V1Kds/od5aPjDw6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L6Tvs+yqSAQ519e+yGcETckQAOarcl+pD1wVIQFPauE=;
 b=EVc95BNhQwFU385GqsApcv1qgFOnhY2mzm8jFYmPjznIVGAuwIutwdwr+XLqMmcBFe2sVGttEkDK984Xvh56HcjWZHKPJylbbeYMI8NItAIhU1SfO5JyHb90I1wxls3o+DgDiCJJx8/aNpBL7UaEm9LzY2FaZR0Ro+PV5JJ+rydDZZt+VKeIKl/sRrcGSditerDjGvIJdiNF1y32OKNOPtkcL0bU5Dbpx+ZnTV+Wijk5sXAPuU8N3Legjup/XB8Wi2E2yXFul+MQtgGkPuqs3iPBb1IUYX5gDgxXK3cxWhe4LGNFvq6t8bexCPYAcnTDrqW6G6O/wCB4PEZ0eypXpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L6Tvs+yqSAQ519e+yGcETckQAOarcl+pD1wVIQFPauE=;
 b=sMVCtWqMo1/5EhrojnDjsVFVrjQgEoK0uJd5D5LKcNLK8QzClG9EJgepiCqkh0cvf5yF2ZlUt0Rnrnw6J85tTwAZHC8az261SlQVON9s3n/fMEfi+0Ez+OFafwf8AsENH2INyzVLc3/+Zg3SBjxRq/1gxc4bcO65bzm8NbLG91fjpvmSPFZniRg4wywDIiJJhWpg3VOTcgklPhY0Zj0NJnuECNSnF81hnDctu4LVkBSplVME9QkQQWsk2vYkY1qQakONS2iHO5kerLMHvzmZPZ8HsNmE5pOrpfIhm3VJRwh6+PV0+M+zOqBM4Tz8g/5nkJnzxgT8Pdq1hhoFp8XqXg==
Received: from CO2PR04CA0188.namprd04.prod.outlook.com (2603:10b6:104:5::18)
 by DM5PR12MB1900.namprd12.prod.outlook.com (2603:10b6:3:10f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Fri, 3 Dec
 2021 05:35:44 +0000
Received: from CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:5:cafe::3d) by CO2PR04CA0188.outlook.office365.com
 (2603:10b6:104:5::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11 via Frontend
 Transport; Fri, 3 Dec 2021 05:35:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 CO1NAM11FT022.mail.protection.outlook.com (10.13.175.199) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4755.13 via Frontend Transport; Fri, 3 Dec 2021 05:35:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 3 Dec
 2021 05:35:43 +0000
Received: from nvdebian.localnet (172.20.187.5) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.9; Thu, 2 Dec 2021
 21:35:40 -0800
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
Subject: Re: [PATCH v6 01/23] mm: Introduce PTE_MARKER swap entry
Date:   Fri, 3 Dec 2021 16:35:38 +1100
Message-ID: <3832555.7SGzcYD3YQ@nvdebian>
In-Reply-To: <YambOGGK/K7saiHM@xz-m1.local>
References: <20211115075522.73795-1-peterx@redhat.com> <11462319.U46FXHIEPT@nvdebian> <YambOGGK/K7saiHM@xz-m1.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2215670e-a580-4e93-7e60-08d9b61ec06a
X-MS-TrafficTypeDiagnostic: DM5PR12MB1900:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1900CA892D83773CA103D42FDF6A9@DM5PR12MB1900.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ygp7fhs9hztPUaGxNRr0WNESfTFxgdOodxBT6EH32ujL65SCO7kWXz6OVvslwJefFaXqWiAoW5yGgz8sVam/WdXblv29NFtx+jczrmMrQI+Gx5eYGPCsg5kNE7eyrfHTOopq0X9Xp3gwOsBmu8abS5YgQGeK0JlBt2ZTcZpmI8Uv+lXSLFxnmb/4kdRlvmTcqTWyKqdsMYYuA8ymBCbrGagGNwaMW9w7ssD6KjZ33uY+i8SiSZPM3ozL1UGPABXqFCH3PJYRvaEIBShaGEr998GAoViUVW3e+NQsEJu0vILLHhCmX+xOHHM2u6mJCWcZsQkDjov0pc8/F4fvkY/f4O1q8ceSXqxtvnMLEQU7HSZIw81PyGKI7WhQbxSUzy77qxjNlXFPQiNABtwJzAGZDM14vwsEooU6Ku+jmNPAJcsHrPxPQt3qKS1/AMVTJQMeV3d37x8G0w4zYM2AL+uvxpXk361JbuJbiTK1Z6dapjsXa00b2kjQRCkipriSSQnDnAvnYo34IwgSheRC4BeOMvM3HwI08VV8OPmRxY2irrOX2n/2SgESYZ8tX3fBHvp99hM3I774CmTxdnM2PTsq8abKop2M9HtjvIzrSgH7V5pgTRZAeVkKW4DkresDpTasnQ+YS2fqDy4zSwWriifX3y+9YYqhxGvjmN+mfG7R0mvCkASQ4lBGPaWqGibxGIlAO/3RvKhojrxnDtldAIlRYv2oeJpJAbmY12VTcLw3RiuZxJkD6Zr7fr5rnTQj3IWtCMemTwL6+wJMfL4IQ9PjH0CsflERz7i17u4ryzNNtMY=
X-Forefront-Antispam-Report: CIP:216.228.112.35;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid02.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(47076005)(6916009)(5660300002)(33716001)(4326008)(86362001)(9576002)(8676002)(508600001)(70206006)(7636003)(16526019)(83380400001)(356005)(186003)(70586007)(36860700001)(336012)(426003)(7416002)(8936002)(26005)(2906002)(54906003)(316002)(9686003)(82310400004)(40460700001)(39026012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 05:35:44.2020
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2215670e-a580-4e93-7e60-08d9b61ec06a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.35];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1900
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 3 December 2021 3:21:12 PM AEDT Peter Xu wrote:
> On Fri, Dec 03, 2021 at 02:30:00PM +1100, Alistair Popple wrote:
> > On Monday, 15 November 2021 6:55:00 PM AEDT Peter Xu wrote:
> > 
> > [...]
> > 
> > > diff --git a/include/linux/swapops.h b/include/linux/swapops.h
> > > index d356ab4047f7..5103d2a4ae38 100644
> > > --- a/include/linux/swapops.h
> > > +++ b/include/linux/swapops.h
> > > @@ -247,6 +247,84 @@ static inline int is_writable_migration_entry(swp_entry_t entry)
> > >  
> > >  #endif
> > >  
> > > +typedef unsigned long pte_marker;
> > > +
> > > +#define  PTE_MARKER_MASK     (0)
> > > +
> > > +#ifdef CONFIG_PTE_MARKER
> > > +
> > > +static inline swp_entry_t make_pte_marker_entry(pte_marker marker)
> > > +{
> > > +	return swp_entry(SWP_PTE_MARKER, marker);
> > > +}
> > > +
> > > +static inline bool is_pte_marker_entry(swp_entry_t entry)
> > > +{
> > > +	return swp_type(entry) == SWP_PTE_MARKER;
> > > +}
> > > +
> > > +static inline pte_marker pte_marker_get(swp_entry_t entry)
> > > +{
> > > +	return swp_offset(entry) & PTE_MARKER_MASK;
> > 
> > I'm not sure the PTE_MARKER_MASK adds much, especially as we only have one
> > user. I don't see a problem with open-coding these kind of checks (ie.
> 
> It's more or less a safety belt to make sure anything pte_marker_get() returned
> will be pte_marker defined bits only.
> 
> > swp_offset(entry) & PTE_MARKER_UFFD_WP) as you kind of end up doing that anyway.
> > Alternatively if you want helper functions I think it would be better to define
> > them for each marker. Eg: is_pte_marker_uffd_wp().
> 
> Yes we can have something like is_pte_marker_uffd_wp(), I didn't do that
> explicitly because I want us to be clear that pte_marker is a bitmask, so
> calling "is_*" will be slightly opaque - strictly speaking it should be
> "pte_marker_has_uffd_wp_bit()" if there will be more bits defined, but then the
> name of the helper will look a bit odd too.  Hence I just keep the only
> interface to fetch the whole marker and use "&" in the call sites to check.

Why does a caller need to care if it's a bitmask or not though? Isn't that an
implementation detail that could be left to the "is_*" functions? I must admit
I'm still working through the rest of this series though - is it because you
end up storing some kind of value in the upper bits of the PTE marker?

> > 
> > > +}
> > > +
> > > +static inline bool is_pte_marker(pte_t pte)
> > > +{
> > > +	return is_swap_pte(pte) && is_pte_marker_entry(pte_to_swp_entry(pte));
> > > +}
> > > +
> > > +#else /* CONFIG_PTE_MARKER */
> > > +
> > > +static inline swp_entry_t make_pte_marker_entry(pte_marker marker)
> > > +{
> > > +	/* This should never be called if !CONFIG_PTE_MARKER */
> > 
> > Can we leave this function undefined then? That way we will get an obvious
> > build error.
> 
> We can, but then we need more macros to cover the common code.  E.g. currently
> in hugetlb_change_protection() we have:
> 
>         /* None pte */
>         if (unlikely(uffd_wp))
>                 /* Safe to modify directly (none->non-present). */
>                 set_huge_pte_at(mm, address, ptep,
>                                 make_pte_marker(PTE_MARKER_UFFD_WP));
> 
> If we drop this definition, to let it compile with !PTE_MARKER, we'll need:
> 
> +#ifdef PTE_MARKER
>         /* None pte */
>         if (unlikely(uffd_wp))
>                 /* Safe to modify directly (none->non-present). */
>                 set_huge_pte_at(mm, address, ptep,
>                                 make_pte_marker(PTE_MARKER_UFFD_WP));
> +#endif
> 
> Comparing to adding macro checks over a few other places, I figured maybe it's
> easier to define them in the header once then we proper WARN_ON_ONCE() if
> triggered (while they should just never).

Ok, makes sense. Agree that adding macro checks everywhere isn't great.

> > 
> > Overall I'm liking the swap entry approach a lot more than the special pte
> > approach, but maybe that's just because I'm more familiar with special swap
> > entries :-)
> 
> Swap entry solution is definitely cleaner to me if not considering wasting it
> with one bit.
> 
> Operating on pte directly is actually slightly more challenging, because we
> don't have the protection of is_swap_pte() anymore.  It can help shield out
> quite some strange stuff due to the pte->swp level hierachy.

So I guess now we have the protection of is_swap_pte() there are probably a few
places where we need to check for marker pte entries when we find swap entries.
I'm not suggesting you haven't already found all of those cases of course, just
noting that it's something to review.

> Thanks,
> 
> 





Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC82446B081
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 03:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240110AbhLGCQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 21:16:03 -0500
Received: from mail-mw2nam12on2055.outbound.protection.outlook.com ([40.107.244.55]:6177
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239999AbhLGCQC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 21:16:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z3YJkfSNcqrPwySlPDFQkZT/yE8MIFE0Y5hNjavgSat4QhSI3aGAAHsI7bQ1Bg3bj+ns9uQAo93+uLud5gOJj3Wi3P4CEC8SrCKhUIwVhrt69reOc9+qoUFJr2Sog3EOTAT07wjyHj42FQlUGGdJR4U7Zv5TADB+uVqSec/9odhxUAStJuJ5bMUIX+1n2vjehcCt7aM65dWr9gLTnGuMbWS3I2AHC7AVPfdXHgr6QkbUKHGpAJ2rB4vgVZV0xvRc5HX+diAevtu6yzpQ1zDqZt95e1Yq8JwiJH2ybPXuyITDumt02E7MV78mx6BOu0kC8zTFVkyUnDCG7AFAFT5KKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yUJNCUl85PvHR+JQsywrUmDUSSD29LHgHfA7Sd4qsA4=;
 b=MoUzkiKe3FTRCVs6Yu06fKptfwRk+DkTTIh6JvR1NJ2Y1R4EB6u0/cWsdI6YVimlwprG4b8kUcrC289vy/Hd/Rb4ndylOYecn4sasjOEqjhXqJGMFmEUwyJbUrfiT/tBM8UnK3YSnqD0GC+C5w/5rn9nXQQsZB/wQCuKTYezc7FFyxjr89M323E/lwHpTKR27db6t+ZF8VQysrK+f5pL+iQtK8PpS52fVqwLncoc0X2gRbs+E2oavzlsjuKBACZUCrc8n7noBC76hK71sB5uDmfIlPWyKT5JgfOszNS38j5NTkfSwXDcw26WP8XmuveONG5YEWXHPm55j/ZhKssTeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yUJNCUl85PvHR+JQsywrUmDUSSD29LHgHfA7Sd4qsA4=;
 b=iRxvMrSGptkSeycmbwENWJRZHDqSSUIfMq7wpNx7vabJw1AfpwdBYwxz6gZFM7mOYt/wvbC/nnnLnKE1W4wrUqia9Pf9aI2U7RT8XgeaOhmGJ+NGN5xqpFvIk1OCn7jW/DCRpz6jn3RtymzdURaccxegBoJAAJqxRdOduvWQZzL8DDso+JmGNx55Vb13cd4FdZi1zmB7+sp5OXQ5iy4OmcNoNKSnCmklWvU2NXoT1/CQ4LluC/v1Hio8a6hm/iif+5VoA0i3YTveC9F/FaXFJyD7Fn+tBzK+TgRfAMrm7oXpufezdlrrUCY1jBL40ax8uJv4ZIxF+3tA5UdnXQ5BaQ==
Received: from MWHPR2201CA0045.namprd22.prod.outlook.com
 (2603:10b6:301:16::19) by BYAPR12MB3159.namprd12.prod.outlook.com
 (2603:10b6:a03:134::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Tue, 7 Dec
 2021 02:12:30 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:16:cafe::ef) by MWHPR2201CA0045.outlook.office365.com
 (2603:10b6:301:16::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend
 Transport; Tue, 7 Dec 2021 02:12:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4755.13 via Frontend Transport; Tue, 7 Dec 2021 02:12:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 6 Dec
 2021 18:12:30 -0800
Received: from nvdebian.localnet (172.20.187.5) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.9; Mon, 6 Dec 2021
 18:12:27 -0800
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
Date:   Tue, 7 Dec 2021 13:12:23 +1100
Message-ID: <2190897.LADUpQAO2C@nvdebian>
In-Reply-To: <Yam9EezLTANRA+Rf@xz-m1.local>
References: <20211115075522.73795-1-peterx@redhat.com> <3832555.7SGzcYD3YQ@nvdebian> <Yam9EezLTANRA+Rf@xz-m1.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73c89b15-59c7-4657-6ed8-08d9b927062e
X-MS-TrafficTypeDiagnostic: BYAPR12MB3159:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB31592B91F142C5048FF83550DF6E9@BYAPR12MB3159.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PbCAJploi4E/AkvBhwBqKdm2BK8KCRm9ZRCEs9E9LYOehrmOnf0W3V/1ff1LFTyq77O6JBBu5nrtNTVJgD/zDMEwq0vdI+g5uIvWpia/RNjjoSddbFakO4CiYtvuMJC/mW1EVBERLCozBxpX0LvpNvmmuClQFk5s6CVXRoVvqa2Taq3EbJIuz6BRZ35zWc7VelQKFCdl+SNv5cL3Va8Sm7sZ9EyKkHmkbNG0F5RYwdb91pLm/sAdhkezSGwsJGj2AGtjOM6nI7MoDkUz0RitLCJdqKw9nX0PvHL6B9WjNcOpwc38zSVjLrbVoE1rcTLTJc7OqD2fUtTXS1OKIH2RT8A5m0sV09Kpd2ggDInxPF6idPy1CE8WkGBGQdVA5pnz37HLIVIS98keXa59m1mcyJzblU7xe0X7Sp1ZSpfaYQNoxleQxGEIGRk4laHMl8ArVErbxPBgYR5KgiQkZ3M4OIpcT072dihdqiBBOB8wrJ1EDxF3Z57+/6cpPlaUWWNE0xh1aBJtDw2Wp2q2lEpqXweAZRQ1eO2cRnPli/jHrBT/RmxAzzK0vlRvpZCa4VC/i2zm7dXTsyPE3VXfbyW6pYiH6Gt97j3625FVBlQIse61Bte13R6O45nO31TI1306jfjJpn62nZHfibaojN5lJj7o2Zc+Y64mUrmQuM/yQPA6YY5t2gh46CARGUy9g4sf4IlaOsBs8aMQiV1fMNV7Q0pgIMrJcCVx9vYpCN4gjlTuYT8NXQmwUO6s8WrBXQd2Y1YaflK9+qazBSd52/1TDNsdFbtbSt8qtYLkexuAO4Xk3oSc/49byWUjKJqAAWS6fK+D5qVBqS+Q57YyhA5Qwg==
X-Forefront-Antispam-Report: CIP:216.228.112.32;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(36860700001)(7416002)(316002)(336012)(34070700002)(33716001)(356005)(47076005)(8676002)(83380400001)(426003)(16526019)(508600001)(9686003)(6916009)(6666004)(70206006)(82310400004)(86362001)(70586007)(26005)(7636003)(54906003)(186003)(2906002)(8936002)(40460700001)(9576002)(5660300002)(4326008)(39026012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 02:12:30.7111
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73c89b15-59c7-4657-6ed8-08d9b927062e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.32];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3159
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 3 December 2021 5:45:37 PM AEDT Peter Xu wrote:
> On Fri, Dec 03, 2021 at 04:35:38PM +1100, Alistair Popple wrote:
> > > > > +static inline pte_marker pte_marker_get(swp_entry_t entry)
> > > > > +{
> > > > > +	return swp_offset(entry) & PTE_MARKER_MASK;
> > > > 
> > > > I'm not sure the PTE_MARKER_MASK adds much, especially as we only have one
> > > > user. I don't see a problem with open-coding these kind of checks (ie.
> > > 
> > > It's more or less a safety belt to make sure anything pte_marker_get() returned
> > > will be pte_marker defined bits only.
> > > 
> > > > swp_offset(entry) & PTE_MARKER_UFFD_WP) as you kind of end up doing that anyway.
> > > > Alternatively if you want helper functions I think it would be better to define
> > > > them for each marker. Eg: is_pte_marker_uffd_wp().
> > > 
> > > Yes we can have something like is_pte_marker_uffd_wp(), I didn't do that
> > > explicitly because I want us to be clear that pte_marker is a bitmask, so
> > > calling "is_*" will be slightly opaque - strictly speaking it should be
> > > "pte_marker_has_uffd_wp_bit()" if there will be more bits defined, but then the
> > > name of the helper will look a bit odd too.  Hence I just keep the only
> > > interface to fetch the whole marker and use "&" in the call sites to check.
> > 
> > Why does a caller need to care if it's a bitmask or not though? Isn't that an
> > implementation detail that could be left to the "is_*" functions? I must admit
> > I'm still working through the rest of this series though - is it because you
> > end up storing some kind of value in the upper bits of the PTE marker?
> 
> Nop. I'm just afraid the caller could overlook the fact that it's a bitmask,
> then there can be code like:
> 
>   if (is_pte_marker_uffd_wp(*ptep) && drop_uffd_wp)
>       pte_clear(ptep)
> 
> While we should only do:
> 
>   if (is_pte_marker_uffd_wp(*ptep) && drop_uffd_wp)
>       // remove uffd-wp bit in the pte_marker, keep the reset bitmask

I'm not sure how having the helper function prevents or changes this though? In
fact I just noticed this in patch 8:

                             if (uffd_wp_resolve &&
                                    (pte_marker_get(entry) & PTE_MARKER_UFFD_WP)) {
                                        pte_clear(vma->vm_mm, addr, pte);
                                        pages++;
                                }

And if I'm understanding your point correctly isn't that wrong because if there
were other users of pte markers they would inadvertently get cleared? Unless of
course I've missed something - I haven't looked at patch 8 yet for context. To
help with the above situation I think you would need a helper for clearing
ptes.

> I could be worrying too much, there's no real user of it.  If you prefer the
> helper a lot I can add it in the new version.  Thanks,

It's not a massive issue, but I do think either defining a helper or open
coding the bit check is clearer. I think we can worry about other users if/when
they appear.

 - Alistair



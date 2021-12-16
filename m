Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 625E0476B20
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 08:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234452AbhLPHpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 02:45:19 -0500
Received: from mail-bn7nam10on2076.outbound.protection.outlook.com ([40.107.92.76]:6112
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230092AbhLPHpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 02:45:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dtbZ5T07N3uIpz1uCibUG56wMJAnQEvXKT1vcwG8kY5lVLSSDso8DVWb3I5JOwyi5WDys+DvTQSlwuE1gBQ+A8kLzZZJKlPPbyqO3mXCUR07Kb4NOAeqRuJ6/8OxuZVJHQjPq/qkI4PXzqYlLIZmnqKx6Mwq9EbzL3NAzmGq/gU7NqHy0oWJzT7rgDdaLCyNTqeG7RE7a13+z+YR01aZ/REA6wDg/7jCta3PGpF+CliJM/kjTkKRp+4TuBHHE1wDshGVKb/xCY30bAw2s58qL8UfsLj1e3Nh2SM8H9kMWTTIhlFO2D1UG5UP+/mzWTqJJ1sgOxFaSK/La6GcjOfv2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A7keWmjmfFR21632l3V85mX8SwKBEg5MiGgq4ce3JhE=;
 b=VTw3IxS84Ol5LMxqvPDZFr9kdpDgbZpAGelFWLkc1+wE/KIBj17Spf0ZnZG3v7pUOtaV3TqH8AnR652w3mVXtfUOLtchzsp6wXj5B2Kv4o+yPYxtbXm1E4bdWSdz3S9NitDtTWhoHWUYDLiCaOf9ol5o4xL/qEWn2ME2HAWLN0zOZeKgUcfF1wXFqD3qAORsQM2zdmP0jHFs2UCpS153js/ygG1P1I6s+axeAyda1OGTTQEOnRPvS0xunjFSMY+LdSWZYRasOzcDQYfzOYP+3npl4/oUp3n/k9quTaU9dj9DY8XzzNT1vBvqzajm8uRUT7aDRlLm4bwspKLXem8/hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A7keWmjmfFR21632l3V85mX8SwKBEg5MiGgq4ce3JhE=;
 b=G9onEDVumtiQdqlA4q1uFq+DO/zQSstSMWfscFyq9JuEUFL27QdJGkoxni7vPcf6EVXAUMjvdY4V9lpdJHBmOiBgoViozs3ohoBlrMZaClGam05CE8+5gU2K+FX6WR7EoZajlaTRsA7sJcu2bqg0ojiyIu6lJVLUbWoOlL8r4xh2Rxmipp140X6lQ+iCsCommWUDcPRaHxSsyVp/sjhlmELwnpZPyN159mRZK0eD5QKjf92sun8zQQdkkPHa/9iM5nnhFlXCGRQZHZH5bC9260j3zHhobyir2wKgRSbwU84xyUKQ8957kcWsvXzvxTFl1vmo1uxTmSvqmP9QzE+BGw==
Received: from BN9PR03CA0283.namprd03.prod.outlook.com (2603:10b6:408:f5::18)
 by DM5PR12MB2534.namprd12.prod.outlook.com (2603:10b6:4:b4::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.14; Thu, 16 Dec
 2021 07:45:14 +0000
Received: from BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f5:cafe::e0) by BN9PR03CA0283.outlook.office365.com
 (2603:10b6:408:f5::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17 via Frontend
 Transport; Thu, 16 Dec 2021 07:45:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 BN8NAM11FT021.mail.protection.outlook.com (10.13.177.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4801.14 via Frontend Transport; Thu, 16 Dec 2021 07:45:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 16 Dec
 2021 07:45:12 +0000
Received: from nvdebian.localnet (172.20.187.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.9; Wed, 15 Dec 2021
 23:45:09 -0800
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
Subject: Re: [PATCH v6 03/23] mm: Check against orig_pte for finish_fault()
Date:   Thu, 16 Dec 2021 18:45:07 +1100
Message-ID: <2472202.YjDCsHb11M@nvdebian>
In-Reply-To: <Ybrljg7nWppMpfMG@xz-m1.local>
References: <20211115075522.73795-1-peterx@redhat.com> <1760244.MLhrlNdmRJ@nvdebian> <Ybrljg7nWppMpfMG@xz-m1.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 56dd2b38-0e69-4d9a-f1d1-08d9c067fedf
X-MS-TrafficTypeDiagnostic: DM5PR12MB2534:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB25348BA8F31E6AE8398E9DDADF779@DM5PR12MB2534.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ejiuyQ9WwxXjumXsWWXoqgmOdP/afaso/kfV0Oe3x7pac211mDy1YpblWoUyn1T1f0Y8Sfz8KztLADq3FtBXVDGqzmfpof9/Z6+u+lI7dssLO8xmUGPAneIusDyoTIx1BzzmJITWDeCs5Jdv+5ZTaS4VTqTkLNatEKs9kFVeNkN+fpZ8V1FyNOiL840yQ9RyE7Buuzs/gm3E5dqR5G8Z0e1VZimp+aPwOYc7utbeTkgoIRETjSgSxW9ZoFV9hhtRTttJcppYV7I2hH9ZlJWx8DtKqI5t8/iNHQ+LpBkYIHJEagIiaHoy8x766boAhMORyGhVygU6/Ls4bffQ7dXe2wz71Xhws+f6nFemWwKCPXDHxFTzLqkvfenGGKh3g2gVkfsGX36RET6ubEtlJFkhRuCZHSX4cNnasRNhoiliUjzeYofu3aMkXjCpagW7MyBhmlm0MK7wPEH28bJFKNV/eqWYfI45n+Q5iKNTV9RovK4q7zgAHIq+Jd2zjukdunypGZcoVJus0SqL0danbjCekFCrF58AGIqo2MiB5YfLz6Pr1XX9zCLdCLhq0aDuxe1I5+Ysgio1HPMOO/GAbrTH+kxndokt8WyJUxH8pCYiF2vymHtfytP1UiH8e7WOox8HNGWKL9af/bzbI0OkIkf/aZNPmO2lIGFOTJ9F6Hku60i3ZT/nSeoOlxW7SRzm+JwIchIl0VfI3P0CLnCVldkCZdvpF3ncQIQHhRIBMibJirQZ5PD8M2FQ3oUNu1jIpZpa+omW7WeleXVzKlaLO26bozQxIj/TruLbr05wjsRFI7U2Nd0jG+b/54ZTUgUgaiJ72esuxbJjR754KAqACAz4DuLlnJz7YQ56P11guwbGD/o=
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(86362001)(34020700004)(40460700001)(36860700001)(9686003)(54906003)(83380400001)(336012)(4326008)(7416002)(82310400004)(9576002)(8936002)(2906002)(70206006)(508600001)(316002)(356005)(8676002)(5660300002)(70586007)(33716001)(26005)(426003)(81166007)(47076005)(16526019)(186003)(6916009)(39026012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 07:45:13.8152
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56dd2b38-0e69-4d9a-f1d1-08d9c067fedf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2534
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 16 December 2021 6:06:54 PM AEDT Peter Xu wrote:

[...]

> I wondered how it could have worked - I thought e.g. pte_alloc_one() will
> always return a pgtable page will all zero-filled, whose allocation should
> require __GFP_ZERO anyway.  But then I quickly noticed that pte_alloc_one() is
> per-arch too..  That explains, because per-arch can re-initialize the default
> pte values.

Yes, I have wondered the same things before as well. It's all a little bit of
fun some of this stuff.

> I thought this patch can greatly simplify things but I overlooked the
> pte_none() check you mentioned.  So it seems I have no good choice but add that
> flag back.
> 
> There's another alternative is we do pte_clear() on vmf->orig_pte as the new
> way to initialize it.  I believe it should work too for s390 and xtensa.
> 
> Any preference?

I prefer the later approach (initialising to pte_clear) as it seems cleaner,
and pte_none(pte_clear()) is true for every architecture afaik.

> Thanks,
> 
> > 
> > > > 
> > > > Thanks,
> > > > 
> > > > > 
> > > > > > This change prepares us to be able to call do_fault() on !none ptes.  For
> > > > > > example, we should allow that to happen for pte marker so that we can restore
> > > > > > information out of the pte markers.
> > > > > > 
> > > > > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > > > > ---
> > > > > >  mm/memory.c | 2 +-
> > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > 
> > > > > > diff --git a/mm/memory.c b/mm/memory.c
> > > > > > index 04662b010005..d5966d9e24c3 100644
> > > > > > --- a/mm/memory.c
> > > > > > +++ b/mm/memory.c
> > > > > > @@ -4052,7 +4052,7 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
> > > > > >  				      vmf->address, &vmf->ptl);
> > > > > >  	ret = 0;
> > > > > >  	/* Re-check under ptl */
> > > > > > -	if (likely(pte_none(*vmf->pte)))
> > > > > > +	if (likely(pte_same(*vmf->pte, vmf->orig_pte)))
> > > > > >  		do_set_pte(vmf, page, vmf->address);
> > > > > >  	else
> > > > > >  		ret = VM_FAULT_NOPAGE;
> > > > > > 
> > > > > 
> > > > > 
> > > > > 
> > > > > 
> > > > 
> > > 
> > > 
> > 
> > 
> > 
> > 
> 
> 





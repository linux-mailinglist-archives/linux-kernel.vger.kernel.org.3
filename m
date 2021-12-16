Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D973D476A52
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 07:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234059AbhLPGXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 01:23:50 -0500
Received: from mail-dm3nam07on2060.outbound.protection.outlook.com ([40.107.95.60]:16864
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234048AbhLPGXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 01:23:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=heIndn2cTdsukjYIH4dhLY+ftR1bMsZ2jntcGjAsea6us+T0Kzs9sqtVKY+PsY6M32UO5CUcSGA3c+OdlOm1NFmqbkCCsi5b/Cc82dhBXgUuRojE213LL5ClvG4wc/VmGP/nA8JvS9Z7UF+aXoZq5sy6ADjRMGHf88RL8qOcnFYeiJ6PjnsOx19WdgIXyx1VpOjkfoG0O8S8NInGFNnuFuGu/XdKgpzpGgv+VdMpxB9PHpvOBZoEkGtEGy0qnbGw0mU8tA0vw0RR6fobzYs6RjqYgP1ReIzMtQsUD1JzalVO3c9ux2SRt2qmpbkGAao4QlqsrJ1RKf5QntsK3xNBug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qx8YQOP08qffRiwjvTw6ai1ByeEqKOgHMgZy948r+b4=;
 b=hBcrvxP2OMjTLarhIJxA8/GvdL36NGHihG9erWdlrm75XxZrFBFgzJeconvwcoWJ7eWABiIaMwwJImB+vMDwRWv160TlVrLoaG5L9KpTjDSuGXy+Mie3a8lMhvbk3m4rvVsQLMB9V06m7TULLqpMFSCOxGEpaay3E9EZQK/TXHTht5Wst9xAtfN2S/VY+/NXZF4PXjQpnqCppC4tlzU/f0MnlsN0rW99x0SmMcyre9UX7MBPL+SUzbbNtBocBbI87M96HjxGgeiDk+rpRz1h/RNuAebYYgCCCdAijlGb7iVA/4N+/KZTytpAmYvSjM+2LrPEe31imqIb/YcaEMDMJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qx8YQOP08qffRiwjvTw6ai1ByeEqKOgHMgZy948r+b4=;
 b=krkocmcxyjxMvZTpAgo4q1jGgnJL8GV3d4FULLYPSduYala/5/abcRmLVrUn4aCSqx8h1EM90MoFsnkWFXeTOFufkOWYnQH1Vx/4sFZv6BgoyK3FcrXzcinhqkBAVX2q2SGtx5DibvXDzOu41IS6sRtbj8IQi2ydZZtvgt9e52A/9u96qhVn7CXzGvowaVVNu78OCZvCZe36mRM+1lOIkkxGcZ+cFs4uYxorSZ8VeJc8Rl0IW+UORlNEn8gKf3IioZ9LTOUn73vJxmrF5OSCCWsp7MrNzAmXE1+F/IQp6+SI1X64FEe6ycmttKMg++9jpo1zvZrxmF+DQSepzHZ0Pg==
Received: from CO2PR18CA0046.namprd18.prod.outlook.com (2603:10b6:104:2::14)
 by MN2PR12MB3885.namprd12.prod.outlook.com (2603:10b6:208:16c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12; Thu, 16 Dec
 2021 06:23:47 +0000
Received: from CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:2:cafe::cd) by CO2PR18CA0046.outlook.office365.com
 (2603:10b6:104:2::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14 via Frontend
 Transport; Thu, 16 Dec 2021 06:23:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 CO1NAM11FT026.mail.protection.outlook.com (10.13.175.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4801.14 via Frontend Transport; Thu, 16 Dec 2021 06:23:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 16 Dec
 2021 06:23:45 +0000
Received: from nvdebian.localnet (172.20.187.5) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.9; Wed, 15 Dec 2021
 22:23:42 -0800
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
Date:   Thu, 16 Dec 2021 17:23:40 +1100
Message-ID: <1760244.MLhrlNdmRJ@nvdebian>
In-Reply-To: <YbrTtx7gtOX+ZCia@xz-m1.local>
References: <20211115075522.73795-1-peterx@redhat.com> <YbrQ2bsEYsfHrIIV@xz-m1.local> <YbrTtx7gtOX+ZCia@xz-m1.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 142519a8-73a1-4eeb-d6f9-08d9c05c9dbd
X-MS-TrafficTypeDiagnostic: MN2PR12MB3885:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3885E446EF11B365A4631BBCDF779@MN2PR12MB3885.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iYkDWVmdo6IlDoukZgUaXae8tDgGrSdRJ4L6+rqreP9QWVVlR2pydiAWXAn/AtjD645xxQJf9B042Ktn8eWF8QRMKqIe7J+vFM4NJ4m7YyFovWk3/P7xSHIINMy5pOOnqvD1bitB4HI6f/pYjc160XI7ob3VnvnblkZV+NAKVOYFcRL7LWQh7vmvkqf8fbikzVIArLjIPxhLvhnRDoQkugynjFBAuo5DiXgEdiqdCDkIz1Szn+H+/ECY7pCLycm3zFiOftrf0CMsalTprh6iqVnlqJ/GkVed96z5OoVUgYcgkcu6S4rZUob7B9GHoYeAgHfSHpv96GF42jC5kvvVGrIOohgRHodAS955K1URc8hpTL5PZSQMiFax+g1suipF1vlzp67NJp0xbP01XTbm94TjrOHibNRZqlzaU9ultFGiRFAKsCXP78VzsqLzEB/VXn7TLzetEIX7QAMRutOuilV8bmVIMl8NGRFIi3ZomAQat1a/yek/AOQq+gsG9UZRr0aF4ZoYo/u1dgAwYhu6eK1MLtoRnelXo+s7+LzKqugt4PBeyeqSzgdCgXluE2NETVlo3GXRm7y3IaZuGy+NZbzTDcM6K9lc+oiXtJ8oqc667j4w/TCeWJlqF5+XmQshQ2V2qkONIq+szh2Ga9UXZ/1WYbYQeBcGxE+xGJ/AY4maZK0ZJpSEuchxkLgj7d67qnsbwZG9UkaL6ZH5mV5WTu4pRsJ63deOFixaYudhlOJMV8tHzS9iooxIxcg82qVxcI0lmAnyVliHIw1ITGyb3jeYcJUOYCEnxBlJ+EnG6sNLdnST2ZrsjQzwwmM7/7nirlO7mpc5nKnQT3hHc5eiCg==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(70206006)(47076005)(82310400004)(9576002)(6916009)(4326008)(81166007)(8676002)(36860700001)(86362001)(8936002)(70586007)(16526019)(316002)(54906003)(508600001)(83380400001)(40460700001)(26005)(186003)(9686003)(336012)(356005)(34020700004)(2906002)(5660300002)(426003)(7416002)(33716001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 06:23:46.4530
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 142519a8-73a1-4eeb-d6f9-08d9c05c9dbd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3885
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 16 December 2021 4:50:47 PM AEDT Peter Xu wrote:
> On Thu, Dec 16, 2021 at 01:38:33PM +0800, Peter Xu wrote:
> > On Thu, Dec 16, 2021 at 04:01:47PM +1100, Alistair Popple wrote:
> > > On Monday, 15 November 2021 6:55:02 PM AEDT Peter Xu wrote:
> > > > We used to check against none pte and in those cases orig_pte should always be
> > > > none pte anyway.
> > > 
> > > Is that always true? From what I can see in handle_pte_fault() orig_pte only
> > > gets initialised in the !pmd_none() case so might not be pte_none.
> > 
> > I believe it's true, otherwise I must have overlooked.
> > 
> > IMHO it's not "when we set orig_pte" that matters - note that finish_fault()
> > (that this patch modifies) is only called for file-backed memories, and it's
> > only called in do_fault() where the pte is not mapped at all.
> > 
> > DAX seems to call it too, but still DAX comes from do_fault() too, afaict.
> > 
> > The pte will not be mapped in two cases in handle_pte_fault():
> > 
> >   - When pmd_none
> > 
> >   - When !pmd_none, however if we find that pte_none==true, that's:
> > 
> >         if (pte_none(vmf->orig_pte)) {
> >                 pte_unmap(vmf->pte);
> >                 vmf->pte = NULL;
> >         }
> > 
> > So when we're already in do_fault(), afaict, orig_pte must be pte_none().
> > Another side note is that, IIUC pte_none() is a looser check than the
> > pte_val()==0 and it should be arch dependent.
> 
> So one more thing I forgot to mention... Of course above is based on the fact
> that orig_pte will be initialized to zero when creating vmf structure, and
> that's done in __handle_mm_fault():
> 
> 	struct vm_fault vmf = {
> 		.vma = vma,
> 		.address = address & PAGE_MASK,
> 		.flags = flags,
> 		.pgoff = linear_page_index(vma, address),
> 		.gfp_mask = __get_fault_gfp_mask(vma),
> 	};
> 
> I'm not sure whether I should explicitly set it to pte_val(0), in most C
> programs we'll already assume it's a proper reset of orig_pte value in c99
> initialization format, but if anyone thinks we should do that explicitly plus
> some comments I can do that too.

Ok, that was really my question. Is:

	if (likely(pte_none(*vmf->pte)))

equivalent to:

	if (likely(pte_same(*vmf->pte, __pte(0))))

for every architecture? Looking at Xtensa for example suggests it might not be:

arch/xtensa/include/asm/pgtable.h:
# define pte_none(pte)	 (pte_val(pte) == (_PAGE_CA_INVALID | _PAGE_USER))

> > 
> > Thanks,
> > 
> > > 
> > > > This change prepares us to be able to call do_fault() on !none ptes.  For
> > > > example, we should allow that to happen for pte marker so that we can restore
> > > > information out of the pte markers.
> > > > 
> > > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > > ---
> > > >  mm/memory.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/mm/memory.c b/mm/memory.c
> > > > index 04662b010005..d5966d9e24c3 100644
> > > > --- a/mm/memory.c
> > > > +++ b/mm/memory.c
> > > > @@ -4052,7 +4052,7 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
> > > >  				      vmf->address, &vmf->ptl);
> > > >  	ret = 0;
> > > >  	/* Re-check under ptl */
> > > > -	if (likely(pte_none(*vmf->pte)))
> > > > +	if (likely(pte_same(*vmf->pte, vmf->orig_pte)))
> > > >  		do_set_pte(vmf, page, vmf->address);
> > > >  	else
> > > >  		ret = VM_FAULT_NOPAGE;
> > > > 
> > > 
> > > 
> > > 
> > > 
> > 
> 
> 





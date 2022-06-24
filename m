Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD1FA558F6F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 06:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbiFXECb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 00:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiFXEC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 00:02:27 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E5A532EF
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 21:02:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d9L4UGqdlPtfcFfxaHPI7wfOAwVO17eGEfZnT6DtUtLi2KdD9nkCCOPC+DWdKKwIBROEPsxiEJ9ZGs2YqgshiZaZho+Z+z4WX7XoakFr8JiTsdZ9Gsgw6A0hz/G3AsvcWcwinOdbDCsWMYKYyXs68XHcqBdCkY4dVlR8XkiGqPLBlogLp1SD9HC041PIzKiqkaruHWXQv5KNmJ7+Qt4sF5YiU2zm9HlWU1VagoSJWXFe6WDA0qrfGVI9yWK4jro0d7ECtYxwQ/imrWb61GrLH6lDWzINzf3OYcRqgYaoPx/UssCNs8h3LO2H8mio6Jqo8snoRvtjOrPPEdP/W7NFPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MRxFJ9kR3CYqpEsBUhsxYn7e46wApwmmnzkXq+UiTRs=;
 b=oEt0XY2q499nGLHiYynq3bQaY0fG0pVKAYTBI3uNZGPZJfdbXd/cRHma+MUTyPL+TcLAugs5OBSowc+Sjv5tIBpp6bDAdxDEwjC7sy3PAWXiHmuzX5eu6iX+0n466NRB/Wah4gqp4nzssYEYbJsJSe8MZ0NKvnCu/PZ1p4dM3Tv3ni3SM2E7pxfahMJzT3vAoE4pAMdB2KK+Pig8dK/X+vl4cTvM5Je8AZtAWGKyYo69h1yZO41+YjI1DWbEu2FBAJ3HxIngt9VS8Koslewxuui6IMTR4OSvPe7gitFs6TEwo77KsD0WWYKp4aIkqXSAeveTjpOjen/YsZCJ10owPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MRxFJ9kR3CYqpEsBUhsxYn7e46wApwmmnzkXq+UiTRs=;
 b=nDWJzof8hjoXFvWu/eI21IlwFIQ5uG2m5qTSB9U4K2Wgne9VkNBCqBCGiTTx2UsGNWg0fX67MlxB9U4aYMk+WaxXmlp/oE5fXrmgx//Jo8+iKSblEDONwe4ysOge99JreOmICAT/ik7vJJskq9+5KGFz8OtkrObto7F/i1HfWTM7AYyOoZYTxQP2kYTNB/nRYbN4KJy3U+EKV2RCwz8T0ckWLkiRJhAYtzXWURRQ+CunDLeoi7Qh3oOwO0sd2KyMD9XxsROZxyUVjhQFyPM6CAeEoeKaXQpONWTtIsKv0TXqmkHeyn1E/n6r5ax1xuFekk3q+bTG5eUohL6leaQiFg==
Received: from DM5PR07CA0104.namprd07.prod.outlook.com (2603:10b6:4:ae::33) by
 DM4PR12MB5772.namprd12.prod.outlook.com (2603:10b6:8:63::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.18; Fri, 24 Jun 2022 04:02:24 +0000
Received: from DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::9a) by DM5PR07CA0104.outlook.office365.com
 (2603:10b6:4:ae::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15 via Frontend
 Transport; Fri, 24 Jun 2022 04:02:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.238) by
 DM6NAM11FT018.mail.protection.outlook.com (10.13.172.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5373.15 via Frontend Transport; Fri, 24 Jun 2022 04:02:24 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Fri, 24 Jun
 2022 04:02:24 +0000
Received: from nvdebian.localnet (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 23 Jun
 2022 21:02:21 -0700
From:   Alistair Popple <apopple@nvidia.com>
To:     <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>
CC:     <linux-mm@kvack.org>, David Hildenbrand <david@redhat.com>,
        "Sierra Guiza, Alejandro (Alex)" <alex.sierra@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: Re: [PATCH v1] mm/rmap: fix dereferencing invalid subpage pointer in try_to_migrate_one()
Date:   Fri, 24 Jun 2022 14:02:18 +1000
Message-ID: <4103648.vua3ulmFvg@nvdebian>
In-Reply-To: <20220623205332.319257-1-david@redhat.com>
References: <20220623205332.319257-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b3315b6-3c39-4ea2-3b78-08da5596588e
X-MS-TrafficTypeDiagnostic: DM4PR12MB5772:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tzAEOegMSJulraq0tlOcQaK4hZh71JQz96jKSvSaP0sIruRoWTePzn+XZ1QLWotfeDfecZbWCaSmu4WHLXxbqGAZE+c6BhGeAESFqRwKnO7OVr0/ydUe/8i1Z2IRBH115UxMikFq1Si+Ft3tJzmOdPDUXz4eYXY7ZLR9ZV/UWvjZdk5O0bngXBhnx8hdX1lqj+WCwqR7gwzQxsjPWGCl4PqzgGIz52eG/ZDjptrVH4aS0W7d/teQZCzTfDm877khU7QYHIoaCIebBo+0UGjVUTKpRdoEl6AM9sDvtQ/5VXD1lVDCqoFTcv3MRFlCS9cpx35gbOK4Ht0giN8htJW+NdeYZ34JWY3sgCVt8rfiIeSEhy4vr57F/syTlGT+hzKVMH12hwDKWZLXwQvCEFLe07XMPQG3dcHlI+NReDKqBcsV7FcJJWmPWMtELkD2XtlVUuEEzSctDDNBp8ale8pmIJt8neIUoXOx1VQ2EaivOEAH03OAEiHJg9z37ApZrFD1k6wTo8DuLNNs1YVKwSil1e0ozXP1gKK8t6vaRm0xzzFaGRM9Nl0A9nYqAwrXo4sRxmSfJ5U+xxy11lZv7nmswCZvhyBnEo9TqqM6f6KxVVEDrIRHcGx7MLP+RPQKksoV83JJKBrKK+qJhmEUwmU6LhC00raYncg5YXrkgycoJQikuQdrDJSq3ZtuLgxzbt1blxwpvZA5htJCPK7DTw/SLgti8uMVOxvQ71SnE0E/UGK9SoqMFie5Ce+MXsWI0qm4+ENezUu1B/nT7qT2ZGIE7Y3kF3RSH7Ek4Mmnf5Jluve22qmUaEh+rO4gxVb/5xwO8jSW4TGlw/11bVOZlpS3gg==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(39860400002)(136003)(396003)(36840700001)(40470700004)(46966006)(82310400005)(110136005)(26005)(83380400001)(316002)(186003)(6666004)(356005)(81166007)(86362001)(2906002)(5660300002)(54906003)(336012)(47076005)(41300700001)(40480700001)(9576002)(8676002)(426003)(70586007)(8936002)(36860700001)(70206006)(478600001)(33716001)(40460700003)(16526019)(82740400003)(9686003)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2022 04:02:24.4268
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b3315b6-3c39-4ea2-3b78-08da5596588e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5772
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I ran into a similar problem today. I can't see any issue with this patch and
it fixed the problem for me so feel free to add:

Reviewed-by: Alistair Popple <apopple@nvidia.com>
Tested-by: Alistair Popple <apopple@nvidia.com>

On Friday, 24 June 2022 6:53:32 AM AEST David Hildenbrand wrote:
> The subpage we calculate is an invalid pointer for device private pages,
> because device private pages are mapped via non-present device private
> entries, not ordinary present PTEs.
> 
> Let's just not compute broken pointers and fixup later. Move the proper
> assignment of the correct subpage to the beginning of the function and
> assert that we really only have a single page in our folio.
> 
> This currently results in a BUG when tying to compute anon_exclusive,
> because:
> 
> [  528.727237] BUG: unable to handle page fault for address: ffffea1fffffffc0
> [  528.739585] #PF: supervisor read access in kernel mode
> [  528.745324] #PF: error_code(0x0000) - not-present page
> [  528.751062] PGD 44eaf2067 P4D 44eaf2067 PUD 0
> [  528.756026] Oops: 0000 [#1] PREEMPT SMP NOPTI
> [  528.760890] CPU: 120 PID: 18275 Comm: hmm-tests Not tainted 5.19.0-rc3-kfd-alex #257
> [  528.769542] Hardware name: AMD Corporation BardPeak/BardPeak, BIOS RTY1002BDS 09/17/2021
> [  528.778579] RIP: 0010:try_to_migrate_one+0x21a/0x1000
> [  528.784225] Code: f6 48 89 c8 48 2b 05 45 d1 6a 01 48 c1 f8 06 48 29
> c3 48 8b 45 a8 48 c1 e3 06 48 01 cb f6 41 18 01 48 89 85 50 ff ff ff 74
> 0b <4c> 8b 33 49 c1 ee 11 41 83 e6 01 48 8b bd 48 ff ff ff e8 3f 99 02
> [  528.805194] RSP: 0000:ffffc90003cdfaa0 EFLAGS: 00010202
> [  528.811027] RAX: 00007ffff7ff4000 RBX: ffffea1fffffffc0 RCX: ffffeaffffffffc0
> [  528.818995] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffc90003cdfaf8
> [  528.826962] RBP: ffffc90003cdfb70 R08: 0000000000000000 R09: 0000000000000000
> [  528.834930] R10: ffffc90003cdf910 R11: 0000000000000002 R12: ffff888194450540
> [  528.842899] R13: ffff888160d057c0 R14: 0000000000000000 R15: 03ffffffffffffff
> [  528.850865] FS:  00007ffff7fdb740(0000) GS:ffff8883b0600000(0000) knlGS:0000000000000000
> [  528.859891] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  528.866308] CR2: ffffea1fffffffc0 CR3: 00000001562b4003 CR4: 0000000000770ee0
> [  528.874275] PKRU: 55555554
> [  528.877286] Call Trace:
> [  528.880016]  <TASK>
> [  528.882356]  ? lock_is_held_type+0xdf/0x130
> [  528.887033]  rmap_walk_anon+0x167/0x410
> [  528.891316]  try_to_migrate+0x90/0xd0
> [  528.895405]  ? try_to_unmap_one+0xe10/0xe10
> [  528.900074]  ? anon_vma_ctor+0x50/0x50
> [  528.904260]  ? put_anon_vma+0x10/0x10
> [  528.908347]  ? invalid_mkclean_vma+0x20/0x20
> [  528.913114]  migrate_vma_setup+0x5f4/0x750
> [  528.917691]  dmirror_devmem_fault+0x8c/0x250 [test_hmm]
> [  528.923532]  do_swap_page+0xac0/0xe50
> [  528.927623]  ? __lock_acquire+0x4b2/0x1ac0
> [  528.932199]  __handle_mm_fault+0x949/0x1440
> [  528.936876]  handle_mm_fault+0x13f/0x3e0
> [  528.941256]  do_user_addr_fault+0x215/0x740
> [  528.945928]  exc_page_fault+0x75/0x280
> [  528.950115]  asm_exc_page_fault+0x27/0x30
> [  528.954593] RIP: 0033:0x40366b
> ...
> 
> Fixes: 6c287605fd56 ("mm: remember exclusively mapped anonymous pages with PG_anon_exclusive")
> Reported-by: "Sierra Guiza, Alejandro (Alex)" <alex.sierra@amd.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/rmap.c | 27 +++++++++++++++++----------
>  1 file changed, 17 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 5bcb334cd6f2..746c05acad27 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1899,8 +1899,23 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
>  		/* Unexpected PMD-mapped THP? */
>  		VM_BUG_ON_FOLIO(!pvmw.pte, folio);
>  
> -		subpage = folio_page(folio,
> -				pte_pfn(*pvmw.pte) - folio_pfn(folio));
> +		if (folio_is_zone_device(folio)) {
> +			/*
> +			 * Our PTE is a non-present device exclusive entry and
> +			 * calculating the subpage as for the common case would
> +			 * result in an invalid pointer.
> +			 *
> +			 * Since only PAGE_SIZE pages can currently be
> +			 * migrated, just set it to page. This will need to be
> +			 * changed when hugepage migrations to device private
> +			 * memory are supported.
> +			 */
> +			VM_BUG_ON_FOLIO(folio_nr_pages(folio) > 1, folio);
> +			subpage = &folio->page;
> +		} else {
> +			subpage = folio_page(folio,
> +					pte_pfn(*pvmw.pte) - folio_pfn(folio));
> +		}
>  		address = pvmw.address;
>  		anon_exclusive = folio_test_anon(folio) &&
>  				 PageAnonExclusive(subpage);
> @@ -1993,15 +2008,7 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
>  			/*
>  			 * No need to invalidate here it will synchronize on
>  			 * against the special swap migration pte.
> -			 *
> -			 * The assignment to subpage above was computed from a
> -			 * swap PTE which results in an invalid pointer.
> -			 * Since only PAGE_SIZE pages can currently be
> -			 * migrated, just set it to page. This will need to be
> -			 * changed when hugepage migrations to device private
> -			 * memory are supported.
>  			 */
> -			subpage = &folio->page;
>  		} else if (PageHWPoison(subpage)) {
>  			pteval = swp_entry_to_pte(make_hwpoison_entry(subpage));
>  			if (folio_test_hugetlb(folio)) {
> 





Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A75048A88F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 08:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348583AbiAKHkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 02:40:52 -0500
Received: from mail-mw2nam12on2064.outbound.protection.outlook.com ([40.107.244.64]:57441
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235730AbiAKHkv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 02:40:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BJyS6+1DTSnZp2KXaQnPhPiBsH9JMZ73XpJzj6/Iv5idzIud+zEVf0g09hwoi81rB3+D7+NMfkPANyz688v3edrzozVaVUodYCwtHqzRjTDD7Xb6rbzxr2EJeoBqWZN15NBggf5rOwwsn0Am2qGQxh0DB8ePU2ASChCoxmDDCXYXq3jlCbEKuqIFbynf3K9jiRNIoBze+oU1qgFW/douWeurX/21A8u8Gc4LvrzksczZDAzeB+p5fsrVj/9SGixU1namI0cHitWvMkDAJu668IvGqrNPCiA9SGx4uX8+pSMZ+zQYno/ysF9uNJjh7Oja0/rbTxcVcIaY37PQ0RvXBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lFXJiAoC9pTsb6esebHr9bUSTP2zXt7r/8VIt9Qt5I8=;
 b=elLynFmIwbkuTav8N9fPGigwE21gjie9rKtnAWDYTwRieUwPjL+Dj1ZwLasxt2ui2x5bke1JddMmRDaTFSwTHU488GZA0fEP3gZzEsWZnlUIbmFbMRxhxOnSVF4Vdm7v/4qjmj5FtMuP2IvWLsUOvaDK3OIrj6fO0Lv2K2J2cuxrpGNvRTiBBBFlm4eUEa3UuwIkchQFMXw4pFTKnRaDOINvkmDLjmfzN/TmMWqrWZzRskvdSg1Mnf/1xgMhsg/CLAvTKJnodFZ9zheb0e4ksAGFbi2l9adXRaMBq01aYh7yBa56HFIC+0rLorIBk155XUrHv2lwQ+QBOXfYSnB/Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=suse.cz smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFXJiAoC9pTsb6esebHr9bUSTP2zXt7r/8VIt9Qt5I8=;
 b=NBzlDzglwcVnrNCKBxavWjH0bt27Xu284WqUXgf4ZcGa+sflvEg0AhhdvwiaQOM8s5YzQ96cCVZx4R8KIixECEztRkGiUWdD9vuZk4s5vFzXP1HpmmbrVmLUdkq+IxxtlpLQyxrgFakZzU1zxLeUMp/4k4mF51hImhgFq94L0DcXpIKO7W3GcrVdgI6EayX1GsRkFuroRjnWXDlPoizJZZz1b8TNus7UMv6yXwxZSJ+cAqgXWG+RCRo1ChAOVfZRoz46klvlyUdaAjquXlDpNvDTqjBVITtsst/jsMWYocRaUrw02vQ8Lgu3FzJo3c4dBddnoGVfITHzyqxcCZ124w==
Received: from BN9PR03CA0750.namprd03.prod.outlook.com (2603:10b6:408:110::35)
 by CO6PR12MB5443.namprd12.prod.outlook.com (2603:10b6:303:13a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Tue, 11 Jan
 2022 07:40:50 +0000
Received: from BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:110:cafe::6c) by BN9PR03CA0750.outlook.office365.com
 (2603:10b6:408:110::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9 via Frontend
 Transport; Tue, 11 Jan 2022 07:40:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 BN8NAM11FT036.mail.protection.outlook.com (10.13.177.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4867.7 via Frontend Transport; Tue, 11 Jan 2022 07:40:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 11 Jan
 2022 07:40:48 +0000
Received: from nvdebian.localnet (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.9; Mon, 10 Jan 2022
 23:40:45 -0800
From:   Alistair Popple <apopple@nvidia.com>
To:     Peter Xu <peterx@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, David Hildenbrand <david@redhat.com>
CC:     Andrea Arcangeli <aarcange@redhat.com>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH RFC v2 1/2] mm: Don't skip swap entry even if zap_details specified
Date:   Tue, 11 Jan 2022 18:40:43 +1100
Message-ID: <4711362.BPgp0156Pq@nvdebian>
In-Reply-To: <849f1e44-d35e-b8c6-c7c3-a73941028ba7@redhat.com>
References: <20211115134951.85286-1-peterx@redhat.com> <20211115134951.85286-2-peterx@redhat.com> <849f1e44-d35e-b8c6-c7c3-a73941028ba7@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9294a5d7-57c7-4248-e8d0-08d9d4d5b003
X-MS-TrafficTypeDiagnostic: CO6PR12MB5443:EE_
X-Microsoft-Antispam-PRVS: <CO6PR12MB5443963EDE23907EE3D34D52DF519@CO6PR12MB5443.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: thymBTMisOrjR7+0S9MkKND7K2ZtjLgBaZEnmQFFfOzLMh40U3qdKSWxH94OipmNwSwP/NJ+U1nbL+nnHzIeLr93wMD5OmoZ46Y0472boyJPo2FeaFRtCvUDqLy73DN1/qls4SlxTD49jHvg9D9JQaa7Hhp9dPS5w7979npIkF5XJ3bBmSG9C6c2vhlnj4y8i6+jdydg2Yogdp9v+ABtbWBUZrt9PgaGch/R9sMGkfFe5i3uIu4SFqBUUsxbKNzcYmTaEMKNOBrc3StGXrr6if3nbN/1rCu2CCEl8yHTdfstWeSNtgBTPoDoz7dwVOUlVQ2sXFl2jzX+AiwhZZXQs1US9BfXSg6NOwn7Z3SyabUqByl2u27hRhbr7BCV/B7JvvPl8YL3zk0OkgSs5wGhdyR7LDQmM1Mc3SW87jHz7sGtJLHn6hU5tn5UTcOIt9DR0+pQgMiqD5SMHhMsEKjx/Lzj0lt+T7dS5oBDWm0eeCHWlvMPdjtuwAYBHtmGoTTy279TCiqeXgGbxnvq5n/SeNJ205/uuTWrQSQktqQGwlRm6WSYrM8TyjigXtqB/+Wrywko0/8WHudlw9xQwqiTGK4rr3sPdoecku6xur91tPS/80w1KLBejbtFXvVIMio5c8nQwljfFle9Uej60rOGdvtSIokGCNjb8xminXPPh3UVvcLdpUEexEn/ChAFJW35TL5Gr0BnNO7b1dHRNl9Mn1ba6i06lPoJA1MrtphIstAlAEKemqj6nY+3grlVyKjNC0YNGKrVufQhGen0NmFsk2/4TG6ni7OT6fiygF7vyvQD2wLY/cMhfzWrKC4Ddyu9
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700002)(5660300002)(83380400001)(9576002)(508600001)(356005)(81166007)(36860700001)(86362001)(47076005)(336012)(33716001)(70586007)(70206006)(110136005)(40460700001)(426003)(4326008)(82310400004)(26005)(54906003)(316002)(7416002)(2906002)(8936002)(186003)(53546011)(9686003)(16526019)(8676002)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 07:40:49.4085
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9294a5d7-57c7-4248-e8d0-08d9d4d5b003
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5443
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 10 January 2022 7:37:15 PM AEDT David Hildenbrand wrote:
> On 15.11.21 14:49, Peter Xu wrote:
> > This check existed since the 1st git commit of Linux repository, but at that
> > time there's no page migration yet so I think it's okay.
> > 
> > With page migration enabled, it should logically be possible that we zap some
> > shmem pages during migration.  When that happens, IIUC the old code could have
> > the RSS counter accounted wrong on MM_SHMEMPAGES because we will zap the ptes
> > without decreasing the counters for the migrating entries.  I have no unit test
> > to prove it as I don't know an easy way to trigger this condition, though.
> > 
> > Besides, the optimization itself is already confusing IMHO to me in a few points:
> > 
> >   - The wording "skip swap entries" is confusing, because we're not skipping all
> >     swap entries - we handle device private/exclusive pages before that.
> 
> I think one part of the confusion is "swap vs non-swap" entries.
> For !pte_none() && !pte_present() we can have
> 
> * swap entry
> * non-swap entry
> ** device exclusive entry
> ** device private entry
> ** HWpoison entry
> ** migration entry
> 
> So the comment claims to skip "swap entries" but also skips HWpoison and
> migration entries, and I think that's the confusing part.
> Both only apply to PageAnon().

I must be missing something but why do these only apply to PageAnon()?

> IIUC, the only way we could get details != NULL is via unmap_mapping_page()+unmap_mapping_pages().
> 
> I do wonder if any of the callers really cares about PageAnon() pages where this would be relevant.
> 
> Am I wrong or is unmap_mapping_pages() never called with "even_cows == true" and we can remove
> that paremeter:

Except that unmap_mapping_range() takes `even_cows` as a parameter and passes
that to unmap_mapping_pages(), and from what I can tell there are callers of
unmap_mapping_range() that set `even_cows = true`.

> git grep -C2 unmap_mapping_pages
> fs/afs/callback.c-      struct afs_vnode *vnode = container_of(work, struct afs_vnode, cb_work);
> fs/afs/callback.c-
> fs/afs/callback.c:      unmap_mapping_pages(vnode->vfs_inode.i_mapping, 0, 0, false);
> fs/afs/callback.c-}
> fs/afs/callback.c-
> --
> fs/dax.c-               if (dax_is_zero_entry(entry)) {
> fs/dax.c-                       xas_unlock_irq(xas);
> fs/dax.c:                       unmap_mapping_pages(mapping,
> fs/dax.c-                                       xas->xa_index & ~PG_PMD_COLOUR,
> fs/dax.c-                                       PG_PMD_NR, false);
> --
> fs/dax.c-        * get_user_pages() slow path.  The slow path is protected by
> fs/dax.c-        * pte_lock() and pmd_lock(). New references are not taken without
> fs/dax.c:        * holding those locks, and unmap_mapping_pages() will not zero the
> fs/dax.c-        * pte or pmd without holding the respective lock, so we are
> fs/dax.c-        * guaranteed to either see new references or prevent new
> fs/dax.c-        * references from being established.
> fs/dax.c-        */
> fs/dax.c:       unmap_mapping_pages(mapping, start_idx, end_idx - start_idx + 1, 0);
> fs/dax.c-
> fs/dax.c-       xas_lock_irq(&xas);
> --
> fs/dax.c-               /* we are replacing a zero page with block mapping */
> fs/dax.c-               if (dax_is_pmd_entry(entry))
> fs/dax.c:                       unmap_mapping_pages(mapping, index & ~PG_PMD_COLOUR,
> fs/dax.c-                                       PG_PMD_NR, false);
> fs/dax.c-               else /* pte entry */
> fs/dax.c:                       unmap_mapping_pages(mapping, index, 1, false);
> fs/dax.c-       }
> fs/dax.c-
> --
> include/linux/mm.h-                         bool *unlocked);
> include/linux/mm.h-void unmap_mapping_page(struct page *page);
> include/linux/mm.h:void unmap_mapping_pages(struct address_space *mapping,
> include/linux/mm.h-             pgoff_t start, pgoff_t nr, bool even_cows);
> include/linux/mm.h-void unmap_mapping_range(struct address_space *mapping,
> --
> include/linux/mm.h-}
> include/linux/mm.h-static inline void unmap_mapping_page(struct page *page) { }
> include/linux/mm.h:static inline void unmap_mapping_pages(struct address_space *mapping,
> include/linux/mm.h-             pgoff_t start, pgoff_t nr, bool even_cows) { }
> include/linux/mm.h-static inline void unmap_mapping_range(struct address_space *mapping,
> --
> mm/khugepaged.c-
> mm/khugepaged.c-                if (page_mapped(page))
> mm/khugepaged.c:                        unmap_mapping_pages(mapping, index, 1, false);
> mm/khugepaged.c-
> mm/khugepaged.c-                xas_lock_irq(&xas);
> --
> mm/memory.c- * Unmap this page from any userspace process which still has it mmaped.
> mm/memory.c- * Typically, for efficiency, the range of nearby pages has already been
> mm/memory.c: * unmapped by unmap_mapping_pages() or unmap_mapping_range().  But once
> mm/memory.c- * truncation or invalidation holds the lock on a page, it may find that
> mm/memory.c- * the page has been remapped again: and then uses unmap_mapping_page()
> --
> mm/memory.c-
> mm/memory.c-/**
> mm/memory.c: * unmap_mapping_pages() - Unmap pages from processes.
> mm/memory.c- * @mapping: The address space containing pages to be unmapped.
> mm/memory.c- * @start: Index of first page to be unmapped.
> --
> mm/memory.c- * cache.
> mm/memory.c- */
> mm/memory.c:void unmap_mapping_pages(struct address_space *mapping, pgoff_t start,
> mm/memory.c-            pgoff_t nr, bool even_cows)
> mm/memory.c-{
> --
> mm/memory.c-    i_mmap_unlock_write(mapping);
> mm/memory.c-}
> mm/memory.c:EXPORT_SYMBOL_GPL(unmap_mapping_pages);
> mm/memory.c-
> mm/memory.c-/**
> --
> mm/memory.c-    }
> mm/memory.c-
> mm/memory.c:    unmap_mapping_pages(mapping, hba, hlen, even_cows);
> mm/memory.c-}
> mm/memory.c-EXPORT_SYMBOL(unmap_mapping_range);
> --
> mm/truncate.c-                           * zap the rest of the file in one hit.
> mm/truncate.c-                           */
> mm/truncate.c:                          unmap_mapping_pages(mapping, index,
> mm/truncate.c-                                          (1 + end - index), false);
> mm/truncate.c-                          did_range_unmap = 1;
> --
> mm/truncate.c-   */
> mm/truncate.c-  if (dax_mapping(mapping)) {
> mm/truncate.c:          unmap_mapping_pages(mapping, start, end - start + 1, false);
> mm/truncate.c-  }
> mm/truncate.c-out:
> 
> 
> 





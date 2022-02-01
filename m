Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80F0E4A59A9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 11:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236361AbiBAKLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 05:11:19 -0500
Received: from mail-bn8nam12on2058.outbound.protection.outlook.com ([40.107.237.58]:9568
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236321AbiBAKLP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 05:11:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ioHUEBZOcK4sN4eHXwdYgm1tJZETSjinW28t6DC/RPiOhwywqMs9PNRADQmF80dRc4+5oH9ULKVdGerElGdE8qpN9BXpSglOavWa6USQF3i46qEwOi+Xc5PSyOXjia+3xU/WNNcJN/WRmnY7j8qNqdCchTD+V39F5NSSjuDOyFtI31AUg0r2GTMPswMY+6uUaHTTnxKIEOnxEd1VbNpX2oqHLooZyHhLGxmeuZ6YgTvj7pS1KMlohw7z3r474Jw8JneAPnv37eiIyONMMbzPOdMBzvRcw60BvmLVwf2nGy6HE6K3M6lNC25PVEhtrZwKl1QK+2qIY2F2slrY2jJHdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bVK+Q2hRvNDiHPDLJbuTJ8EUAlC1wW1dJUMEVYIcSr8=;
 b=CvLR/EUz7b1WASM/tXRFdF4ASeEcsi4kbod2wVqmKU2c0jhC8hpFhNpO2TEGshwiGhtTfgS8NJXDAr1dJbMIZS640xX2OvXG8veRYtwOSX7/fnGsFK1I9VLSW+B0pZKeClFaRMvvhuzvbIaPa7pO/ZFTjjdhTZBT3ymA+oydbATqMlN+WpCFFswxzS003rYVAu021SLoS3DxuwbeOgO9dXA/WD8NF3/OHRo0TpcmkAIbA53Yl6ypm6rlBp+69m/rWZQ1YGzkobdalJJ9xVQoS/EllNVmjW0SUGt+7u9xB8F58fStW913mVmK9/alOO1jUP8JiFMglv1Xdj92qRnyfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bVK+Q2hRvNDiHPDLJbuTJ8EUAlC1wW1dJUMEVYIcSr8=;
 b=PpJBWmoGUYOLHHTSfruLUkSiPLWypRWca3OsX0WD7K2B5jGTOl7fgm3SmuKSdgfWgcuK0kIY1oVGc1LuBy/wgmx3K0RNsOGka/qot5O+vAt51PHJZ0TrefkYGrd8ETtIcy3wZ0WbJY05vHsFqbOEynF6IYKrQ2dl+93yJj2YrS1tWUJnqAPK4xE6p/vnb9023eNCbzxoIs5MGwwCak/EGgRo3FjrMQtltnun6hLX3OLmBurnMFRSJdxsMqIt7zAK49wRa9F90yfdB/oWZeWAAl2aG1/cmff0X0vQhtAS9c+NiSHS/86hPPG11xqRw3iD0032roDD3ruGdAiihl76qQ==
Received: from MWHPR12CA0046.namprd12.prod.outlook.com (2603:10b6:301:2::32)
 by DM6PR12MB3372.namprd12.prod.outlook.com (2603:10b6:5:11b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.19; Tue, 1 Feb
 2022 10:11:14 +0000
Received: from CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:2:cafe::23) by MWHPR12CA0046.outlook.office365.com
 (2603:10b6:301:2::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.22 via Frontend
 Transport; Tue, 1 Feb 2022 10:11:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT024.mail.protection.outlook.com (10.13.174.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4930.15 via Frontend Transport; Tue, 1 Feb 2022 10:11:13 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 1 Feb
 2022 10:11:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Tue, 1 Feb 2022
 02:11:12 -0800
Received: from sandstorm.attlocal.net (10.127.8.12) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Tue, 1 Feb 2022 02:11:12 -0800
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC:     David Hildenbrand <david@redhat.com>, Jan Kara <jack@suse.cz>,
        "Claudio Imbrenda" <imbrenda@linux.ibm.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2 4/4] mm/gup: remove get_user_pages_locked()
Date:   Tue, 1 Feb 2022 02:11:08 -0800
Message-ID: <20220201101108.306062-5-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220201101108.306062-1-jhubbard@nvidia.com>
References: <20220201101108.306062-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a96c0c2-1171-419f-f22a-08d9e56b2d73
X-MS-TrafficTypeDiagnostic: DM6PR12MB3372:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB337247557ACBAFED99CF4488A8269@DM6PR12MB3372.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vj/PkckrSjGwtu6epH9C155uyleUB0svapf+8nvMAYLByL4hmtZTta3Fs59HnLSwKhxHRZo97WKyA1ES0o5zJVlclaF6vgC69Gu0xc1kKBIxtsToRCFhvsfIOYCi/moxsjRg0I104KLky8qdxAz/1dM8CBKaSx4L7g1rSHeOC2gHorg5RlXPKNEtYYCMQ0C0xiEAC7MhN0DQ2l7FAY3M3d+JNW8LQGFhnYU/bJ7q01EORZZxi5zdUOcEGXlwMxyi+rJCodDLApOnvV5Shz/OxU5M1vBymM1LQ4hlsux5wgFR0fOzSFQJHlE0cIRRImtjcPpj3pkmdjeXtx5aShVguPMgfNlDWAHQGqoIaI8cmq2Z8J6IBYMOYjCHIMo5Ts4s3qEf97SIo4ul3/NPUAs31hgQv6R0hEv4sf99q1Ra2waS0Q1cCPDhkM/o0nbdQslsH03voRJdqbl22Nye500W7J/EShhbofjkSnnj5BuMAsLVKh5YGPM08Tplzc58lKNBJintH5uLfPffQZleiH51hgjba1tHj4/m6DbT0U/1XcJ4/prLByLdpW/xFiCYJbPVSowwP2jwsxqhDH/fcCBLSMfeRO2+doBmB3+ZleJHry8F8on4xHLM+PJNGvPs9Wp+2MV6fEkYb91RQFVHx2mioC5jgGler+HAOdlO8wJWdhY39kQB5RdbFSgnKlUyjYUkcFzKDpi3K7hAGqTa7/pVig==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(36756003)(4326008)(6666004)(110136005)(8676002)(83380400001)(5660300002)(70206006)(70586007)(2906002)(316002)(54906003)(8936002)(356005)(81166007)(7416002)(40460700003)(1076003)(186003)(2616005)(26005)(82310400004)(107886003)(47076005)(426003)(336012)(508600001)(36860700001)(86362001)(36900700001)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2022 10:11:13.5220
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a96c0c2-1171-419f-f22a-08d9e56b2d73
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3372
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is only one caller of get_user_pages_locked(). The purpose of
get_user_pages_locked() is to allow for unlocking the mmap_lock when
reading a page from the disk during a page fault (hidden behind
VM_FAULT_RETRY). The idea is to reduce contention on the heavily-used
mmap_lock. (Thanks to Jan Kara for clearly pointing that out, and in
fact I've used some of his wording here.)

However, it is unlikely for lookup_node() to take a page fault. With
that in mind, change over to calling get_user_pages_fast(). This
simplifies the code, runs a little faster in the expected case, and
allows removing get_user_pages_locked() entirely.

Cc: Jan Kara <jack@suse.cz>
Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 include/linux/mm.h |  2 --
 mm/gup.c           | 59 ----------------------------------------------
 mm/mempolicy.c     | 21 +++++++----------
 3 files changed, 9 insertions(+), 73 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 80c540c17d83..528ef1cb4f3a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1916,8 +1916,6 @@ long get_user_pages(unsigned long start, unsigned long nr_pages,
 long pin_user_pages(unsigned long start, unsigned long nr_pages,
 		    unsigned int gup_flags, struct page **pages,
 		    struct vm_area_struct **vmas);
-long get_user_pages_locked(unsigned long start, unsigned long nr_pages,
-		    unsigned int gup_flags, struct page **pages, int *locked);
 long get_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
 		    struct page **pages, unsigned int gup_flags);
 long pin_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
diff --git a/mm/gup.c b/mm/gup.c
index 58d01a96ab30..4a43c79f0972 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2119,65 +2119,6 @@ long get_user_pages(unsigned long start, unsigned long nr_pages,
 }
 EXPORT_SYMBOL(get_user_pages);
 
-/**
- * get_user_pages_locked() - variant of get_user_pages()
- *
- * @start:      starting user address
- * @nr_pages:   number of pages from start to pin
- * @gup_flags:  flags modifying lookup behaviour
- * @pages:      array that receives pointers to the pages pinned.
- *              Should be at least nr_pages long. Or NULL, if caller
- *              only intends to ensure the pages are faulted in.
- * @locked:     pointer to lock flag indicating whether lock is held and
- *              subsequently whether VM_FAULT_RETRY functionality can be
- *              utilised. Lock must initially be held.
- *
- * It is suitable to replace the form:
- *
- *      mmap_read_lock(mm);
- *      do_something()
- *      get_user_pages(mm, ..., pages, NULL);
- *      mmap_read_unlock(mm);
- *
- *  to:
- *
- *      int locked = 1;
- *      mmap_read_lock(mm);
- *      do_something()
- *      get_user_pages_locked(mm, ..., pages, &locked);
- *      if (locked)
- *          mmap_read_unlock(mm);
- *
- * We can leverage the VM_FAULT_RETRY functionality in the page fault
- * paths better by using either get_user_pages_locked() or
- * get_user_pages_unlocked().
- *
- */
-long get_user_pages_locked(unsigned long start, unsigned long nr_pages,
-			   unsigned int gup_flags, struct page **pages,
-			   int *locked)
-{
-	/*
-	 * FIXME: Current FOLL_LONGTERM behavior is incompatible with
-	 * FAULT_FLAG_ALLOW_RETRY because of the FS DAX check requirement on
-	 * vmas.  As there are no users of this flag in this call we simply
-	 * disallow this option for now.
-	 */
-	if (WARN_ON_ONCE(gup_flags & FOLL_LONGTERM))
-		return -EINVAL;
-	/*
-	 * FOLL_PIN must only be set internally by the pin_user_pages*() APIs,
-	 * never directly by the caller, so enforce that:
-	 */
-	if (WARN_ON_ONCE(gup_flags & FOLL_PIN))
-		return -EINVAL;
-
-	return __get_user_pages_locked(current->mm, start, nr_pages,
-				       pages, NULL, locked,
-				       gup_flags | FOLL_TOUCH);
-}
-EXPORT_SYMBOL(get_user_pages_locked);
-
 /*
  * get_user_pages_unlocked() is suitable to replace the form:
  *
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 028e8dd82b44..3f8dc58da3e8 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -907,17 +907,14 @@ static void get_policy_nodemask(struct mempolicy *p, nodemask_t *nodes)
 static int lookup_node(struct mm_struct *mm, unsigned long addr)
 {
 	struct page *p = NULL;
-	int err;
+	int ret;
 
-	int locked = 1;
-	err = get_user_pages_locked(addr & PAGE_MASK, 1, 0, &p, &locked);
-	if (err > 0) {
-		err = page_to_nid(p);
+	ret = get_user_pages_fast(addr & PAGE_MASK, 1, 0, &p);
+	if (ret > 0) {
+		ret = page_to_nid(p);
 		put_page(p);
 	}
-	if (locked)
-		mmap_read_unlock(mm);
-	return err;
+	return ret;
 }
 
 /* Retrieve NUMA policy */
@@ -968,14 +965,14 @@ static long do_get_mempolicy(int *policy, nodemask_t *nmask,
 	if (flags & MPOL_F_NODE) {
 		if (flags & MPOL_F_ADDR) {
 			/*
-			 * Take a refcount on the mpol, lookup_node()
-			 * will drop the mmap_lock, so after calling
-			 * lookup_node() only "pol" remains valid, "vma"
-			 * is stale.
+			 * Take a refcount on the mpol, because we are about to
+			 * drop the mmap_lock, after which only "pol" remains
+			 * valid, "vma" is stale.
 			 */
 			pol_refcount = pol;
 			vma = NULL;
 			mpol_get(pol);
+			mmap_read_unlock(mm);
 			err = lookup_node(mm, addr);
 			if (err < 0)
 				goto out;
-- 
2.35.1


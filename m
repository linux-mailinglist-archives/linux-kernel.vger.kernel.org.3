Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD6D4A3D3A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 06:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357729AbiAaFSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 00:18:12 -0500
Received: from mail-co1nam11on2082.outbound.protection.outlook.com ([40.107.220.82]:4562
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1357706AbiAaFSB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 00:18:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YiGqts87PS8Kn5xxihaXGCVJqpUcapPrjW+Y/caV7pCoZk5xsvfXyMLcMITVna4BQunIO4LCYqByqv3PNDzxuFx0LL8V7xK6ofjahxHZvbuKTPpLAkLKqAgFzDEdIY0lHG5Jfgs7AK/cpc8HrR3jZsbskhSwes2zASuPT5wllciZzagLNlUh7Ea4FX8PQ7+77aLESX7lBvXYiYBFN0eMuIFn8CQYVsAU4QCkZ6WT9CZJ/sBwgoZtHMNuNyQcigktY7GOiS11rqPiHk9YziAVXtNrSjtmLSDVLq+19ARYFxwNXO+CPgJGeNraWApC+PTa2yF9MpPEjuXkbPAGuEiltQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Kk9+4kEkcKxj6kf0o9k3q2cGrwV89GKLhSq1i0xxEE=;
 b=EbVs3wrP8oAnIRoDZwwGosmhcZvFctKf+UblTf/YnskZSAZf6/GBY319N7BWKI3M0AGp2DnNnqb4bG9Lm0zQvir6WHRIHOXdCmAl0toVUAytQeU9+tGZskV85uCfLpLsqLQ3mizgalXkuRbVbXCL3+GOV4sU0Qew13SJB/Mg4o9bc/sVdqPe26XQVCjRYC8RA1JBBdtRbhFqdCOjPtG1SGhphItqHnKZemyE2tTwN0a+0ZAfJ9GsJNO9OSG49MHr0KamCmv8S+vp4irhZVjTNF/u4yW0Z+YUJoXDD9ptlLSsr5HXqUfEWIGNy1LY3GHW4Q0IIsBGhBoEuXqshldMUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Kk9+4kEkcKxj6kf0o9k3q2cGrwV89GKLhSq1i0xxEE=;
 b=J+1oh2cyjLJJhtsNXxotlz2zs6bClB2LmqktcgAZat1TB1nQ69EEbziXTuyXpJQj1gyVV4hNFEJst/ZzV3Glc7+S/GHFPSWmZW0ug+Nbee4IDah7Y3z/c4HopW+USy5i36j0Vo/4p7qv6WW7A3I9JjLSjxi53ex/we2SXG0J00/esi5FiJ2BN+T2BPiXfEndFn1IcfHmg/+F1XwbAmvACqqZD8crOcehifYla8CtT3suIh1L0rLnrmA6cpq9DIUDu+FDoL0mB/7o5r29BZgfwiaG+v6wONXtrpcNL+rU55tep4UeAfDBUWOWK96TY4Mqbi5ZF/zCfDpvTZonhkxTpg==
Received: from BN9PR03CA0570.namprd03.prod.outlook.com (2603:10b6:408:138::35)
 by BY5PR12MB3698.namprd12.prod.outlook.com (2603:10b6:a03:194::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Mon, 31 Jan
 2022 05:17:57 +0000
Received: from BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:138:cafe::2c) by BN9PR03CA0570.outlook.office365.com
 (2603:10b6:408:138::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17 via Frontend
 Transport; Mon, 31 Jan 2022 05:17:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT046.mail.protection.outlook.com (10.13.177.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4930.15 via Frontend Transport; Mon, 31 Jan 2022 05:17:56 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 DRHQMAIL101.nvidia.com (10.27.9.10) with Microsoft SMTP Server (TLS) id
 15.0.1497.18; Mon, 31 Jan 2022 05:17:55 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9;
 Sun, 30 Jan 2022 21:17:54 -0800
Received: from sandstorm.attlocal.net (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Sun, 30 Jan 2022 21:17:54 -0800
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC:     Jan Kara <jack@suse.cz>, Claudio Imbrenda <imbrenda@linux.ibm.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 4/4] mm/gup: remove get_user_pages_locked()
Date:   Sun, 30 Jan 2022 21:17:52 -0800
Message-ID: <20220131051752.447699-5-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220131051752.447699-1-jhubbard@nvidia.com>
References: <20220131051752.447699-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 058af1f6-fcc0-49da-1c64-08d9e4790a60
X-MS-TrafficTypeDiagnostic: BY5PR12MB3698:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB3698E778D0285DFFC96902FFA8259@BY5PR12MB3698.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Htr9nMywcMjGFOxARl6uVx0g9YyQHdCQBV0CmdDV0l2aEEQq0P8THGdHNJ42D1oTYXB9ixPVhyAdQ11pt7qtQHbok9oTz/lzPz0QNUWFgyVaBsfpiBJUvvYk8aVBJD+9Sm4pcTjbHBbyQioJc3WkQfU6TfCVWoZ7t+sUjiOwDmIcF3Ua4Z7i5VqlEyglD8uyfmFUDlSGGwxfXlBNei3I5iMzNJb3FypwnnnHF47HHE4UYse9ulYaKCABZAJri7fqrigYA4AaigMeOoFiEJyzp2Zoqhvz5ZaKh8tr/6whGqB3AKugbR9M7P2CDDu/Ah93+GGw75LS7DSQi78igwt/Tcg0YMfgacuMS6J0VBhNL4tC+nbtxUYyUxGLn0pWqluUgvsWiDHkzxmyzLxi4LQ5BJ88Kr/U2BnTvA7QSAtSlgVcKKKSMv4i5bogaoXGJmIDT2AOPKSfMK+4Jm2b54o5SrruyRnwFSKxmyGQjf0qJt3kOGbfCRZ/vEFUoF3AInt1V+j17FD+2dDG5+9xG2dQ0ckVNoxUQKCtHDp+ksq0ZqSaDmQ1GWHzkFmxLdnC8ZPV9O+kJTF6QbdkgQ7quxWbBuwxUcNWfgWYdgaRZaOK296Cp3Q/eJ8CH/u+rlQ+dQa3qGQELr/nGQnjhyktZdZO3/1MZ2cAxxnA7e/ExgAPwycfA604359CfL9nCtMk4y4Ecve5FvKP02xKxNLyh9WkMw==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(8936002)(8676002)(2906002)(508600001)(356005)(81166007)(316002)(54906003)(110136005)(4326008)(426003)(1076003)(336012)(107886003)(186003)(2616005)(86362001)(26005)(7416002)(47076005)(5660300002)(36756003)(70586007)(70206006)(83380400001)(40460700003)(82310400004)(36860700001)(36900700001)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2022 05:17:56.4163
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 058af1f6-fcc0-49da-1c64-08d9e4790a60
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3698
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unraveling the rat's nest set of APIs in mm/gup.c a bit more.
get_user_pages_locked() was not helping at all, so remove it.

Also, lookup_node() has only a single caller, but it is still worth
having a clearer locking policy there. Changing it so that the caller
both takes and releases the mmap_lock, thus leaving lookup_node() with
the sole job of translating a virtual address into a numa node ID.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 include/linux/mm.h |  2 --
 mm/gup.c           | 59 ----------------------------------------------
 mm/mempolicy.c     | 22 ++++++++---------
 3 files changed, 10 insertions(+), 73 deletions(-)

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
index 028e8dd82b44..040d88354cfa 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -907,17 +907,15 @@ static void get_policy_nodemask(struct mempolicy *p, nodemask_t *nodes)
 static int lookup_node(struct mm_struct *mm, unsigned long addr)
 {
 	struct page *p = NULL;
-	int err;
+	int ret;
 
-	int locked = 1;
-	err = get_user_pages_locked(addr & PAGE_MASK, 1, 0, &p, &locked);
-	if (err > 0) {
-		err = page_to_nid(p);
+	mmap_assert_locked(mm);
+	ret = get_user_pages(addr & PAGE_MASK, 1, 0, &p, NULL);
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
@@ -968,15 +966,15 @@ static long do_get_mempolicy(int *policy, nodemask_t *nmask,
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
 			err = lookup_node(mm, addr);
+			mmap_read_unlock(mm);
 			if (err < 0)
 				goto out;
 			*policy = err;
-- 
2.35.0


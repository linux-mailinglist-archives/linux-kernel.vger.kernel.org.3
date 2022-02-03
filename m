Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85BC14A8181
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 10:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349772AbiBCJdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 04:33:20 -0500
Received: from mail-bn7nam10on2088.outbound.protection.outlook.com ([40.107.92.88]:45792
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1349725AbiBCJdF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 04:33:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SHnS3wCIVup09iv3oPMXf+wqVYKFwTTjjBlqkWwrIC7sseJFobSDxIK3SP6GoP5pVbOd/c6SDFqRo4haAKvHnCXpWImf3+VmSxutTmZi7N/qHj47BSZHZvptafpUOKqZNhxgaO9a+8uN+gjEqlaedhrwEshghVYZTaf8r71gBl770kMpYbPt5z8d5WZSf1gBGEYiHl7QvmC51OqUl11c/fxx3b3/y6QF819IAo86j1BJIZH43VBuoX40GJwa5LyjskaKJf+KcwOavsCHrmKWrCptNJzbx1AzZmKfKSIJ11iIZVVxVmbmkgl8oxAMIbEIQ6dRjvarLowKy+SHYc35gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ZOQlvAvDS4/SPLvLjBz/5Ap3tNIGRbwmHAPau7fsxo=;
 b=WirnxRda0noN1ISeRX6JA2FV/xPKiRJb9Hao1IQkaK9QtjbhGETGpGjlFGh8iGFqv6NRx0xm3eIItRNrO5WKpSu7nhss/tkp9Zm2P21slmQVh5DC+itbuj9eHeYxRpgNIDMZ57YsUBm3pSJBhR4oZCpDqrUtX4aNLowJ2qrCzRa76RAMhEgvEZuEgpotRvBEJXhAvUPoROPFFqP1/mEJRWD+/V5fQ8+DqRAKa9sT+DgS/QaM7mE+sEa2Iod2CTDm/mQl+ouAgY5x1zc11r0QKzsGATO17IFFAqeCfUAlDMVQmqeKWi7KmkDrkjpehddpm7BfMWqa4W5DxvYXmEXcnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ZOQlvAvDS4/SPLvLjBz/5Ap3tNIGRbwmHAPau7fsxo=;
 b=f4GOiChxOf+T4oDV64oYZ5nHk6j073bC6gj4hY8I/vWzXGQx/voaO3uI5OVl7dXpqi+1LOwyVEjDFSJg9G9cSQ/bhPJkOsApzXWrLxe6FPG7a8snBMOquZiKqx3aRwvvlDeJyHDMGVweQ5kPmFZ26+wBOQa2YXWp1Cd1QQ89BNeZ4hBcTi+rqN01fmlH8rYZPkj0j1K7rQYNzPE6INoBTmuRWkonQ97t7kJYqWl820J/6MGlM0diWcvGutkv7moVkMVeyjX2A/HPP+S2m6k6ptyw/xd2xlPHQe1/KHWw4BYhqDotZFsEHcEkzNU6sk4pjCJlLiS6ldBlkvGNlZtmeQ==
Received: from MWHPR1701CA0019.namprd17.prod.outlook.com
 (2603:10b6:301:14::29) by BN6PR1201MB0004.namprd12.prod.outlook.com
 (2603:10b6:404:ac::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 3 Feb
 2022 09:33:03 +0000
Received: from CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:14:cafe::18) by MWHPR1701CA0019.outlook.office365.com
 (2603:10b6:301:14::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.13 via Frontend
 Transport; Thu, 3 Feb 2022 09:33:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 CO1NAM11FT041.mail.protection.outlook.com (10.13.174.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4951.12 via Frontend Transport; Thu, 3 Feb 2022 09:33:02 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 3 Feb
 2022 09:33:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Thu, 3 Feb 2022
 01:33:01 -0800
Received: from sandstorm.attlocal.net (10.127.8.12) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Thu, 3 Feb 2022 01:33:01 -0800
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC:     David Hildenbrand <david@redhat.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Jan Kara <jack@suse.cz>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v3 4/4] mm/gup: remove get_user_pages_locked()
Date:   Thu, 3 Feb 2022 01:32:32 -0800
Message-ID: <20220203093232.572380-5-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220203093232.572380-1-jhubbard@nvidia.com>
References: <20220203093232.572380-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: acdca6a0-5072-47d9-e2f3-08d9e6f82ce3
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0004:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0004483BCF6E0DB5EB075DDAA8289@BN6PR1201MB0004.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1X6Krkv+Q8BDDCjh6cYyH+lMFUkgYIIGD1/a0gX8H+YcCIugs8G1BQ92EwfnCpPaRi8nb+JHQhAaFD/7g/uZuxwtdEm+dnFcEx3D37Zy3x4kU0JfdQrxsZMUdYVWCEaLe0Bns/5NjEwXH6jDLKHpTcMfeVoSbJY1xSVHrlCWJczU0iDUXOVYYuYJic1rz9Vq+NwahcsGM64wfHFPGAgWGtttc5o8o2vkF85TqGOpS7m8/R/ZmfPpU0B+NCAlRfmWQMQClzo4WRf0SQp02Tsn3300J0HxK6GyUkBQmyW9E5XW2eoJsLFkPcTT4St5ewR5L0qGhc7OVvtFf896jfd8sPy0rBl5QnWCS8S/+IB1a2X6hBBWNV2T28YSsIVwCBK3wxc4e2EdjcpxcKRhZ3TXeDn3ZCJ2srq+DcJSne/H1Ez0L50mSC4TnQBknDscTzUW6FB4DOKESj8v9gtmZ+g6031SgNpBDjmXRq69KF2gDgjE7J2GXC4Cwlk+IpMNxowbThrA4UXdQZ1bui0tgPtohjuvAvgIKb0eTMHtqRlyyuAgcUxjJderAQBrhVA8CBWPdmW7BdjI9xiJMAHjKbTMxQwS8TzxtldCHLgxAWit9SOUZJU57jQuU9Rx2CpGnpdAzcEyzP6Wn7H8bRuGLsKCF0nrwTepjM8XtmT/rt1JPtubYm1LNpRmEF2SWblMU6tc8jMCkYaM2kDQ30UlUzYd5Q==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(356005)(2906002)(110136005)(426003)(86362001)(40460700003)(186003)(336012)(26005)(36756003)(107886003)(47076005)(5660300002)(81166007)(7416002)(36860700001)(70586007)(508600001)(70206006)(8676002)(8936002)(4326008)(83380400001)(54906003)(82310400004)(316002)(1076003)(2616005)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 09:33:02.7952
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acdca6a0-5072-47d9-e2f3-08d9e6f82ce3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0004
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

Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
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
index b0ecbfe03928..7da49df59110 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2118,65 +2118,6 @@ long get_user_pages(unsigned long start, unsigned long nr_pages,
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


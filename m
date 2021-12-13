Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D70EF471FA1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 04:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbhLMDjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 22:39:08 -0500
Received: from mail-mw2nam12on2065.outbound.protection.outlook.com ([40.107.244.65]:23872
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229724AbhLMDjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 22:39:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DgwdxK0HIYEm5moSOxldxNY74HBQV57dbxF0STrmwzu+KCFduD5Hi0HyvaNIxE/mzMyKH+1luYhBp9qypVmO7W1p/H+Qbv9zgFD5YXDJPP+v+xP+znp1Dz6lEY+ic8nkwx2IDma3G5XqmXvwDUDiwrk/VzE6w/Z8ru5X3Ry7wfjP7vsLAkqTbyqlXzbSe8T6FY71v4BzXBkLgca+QjtwhGrTupR14ae5aEadQpyhWmMZQhFXLKFFTV6SDgVSoN7PNcc9/drbf+1/Rnvot2NEEUDWu6PDWOsRHR0nL5CeG7TAs/7sCGZAwwjDMBh0Cw6wEDDHMVRKg8KFQfZrzJJ1EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ugm+73fvKABQjoPl74ZxwZtoIDBSI5lj7bZRrVuk+aE=;
 b=CkoAl+p1AVdhd6zxZhpKUZ51uFj6vX6bw8IHF6BOJBOCHL3qzJbkRV5oiYldhR56cqF2C8qeBPycpdodCCvevgquQJ84xcdlcNF92j/obcxp8Dv9kCu9DCUkjg1gMTmiEyOQ49KtTXNBOc1RNHyM3URj2+wZkFeh/q41ivQyQRvZVw5HzyZ7t7aQcdR1DnF0xfaL1AkZm/JxOQQJd5l6a1Oh7K1O6/BKXg0PdemMxUtxNyKFAugAU7/et0UnSVgsu52+2y8sfwH3JhSIc8AzZHLwCzd4biy1L9nCDry0/lL7mUg2S6wMatYFkgJKAE9VnSQaVnzDdR5vdYCvYudxtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 203.18.50.12) smtp.rcpttodomain=kvack.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ugm+73fvKABQjoPl74ZxwZtoIDBSI5lj7bZRrVuk+aE=;
 b=PCKVzXXLOAWS23nCQZE/1pw6DdI0nPQw4dr+QF08IwWChX7+0QSraJxSEs6gLMWPtjBGXYkUKstcwzPX/i/BeBn3nIsQDMk0TCaUbyYllOkmFQuBd0+xG6D0ItRF5nRm7h6HxGYe1S/t/3s0yxgIfjxpbQ5Ei36r85Y7husdU2Vk933iz4CunHTEsTqDJoWEW1BooYCwiPipsfvmXZ8c5TVBx7WS0+PH0iZeXpCIaSlOzu26lH620NowWuzwdhEfhmNpeYHgHf+Mi8UUslpeYWXVBUEv8sO6C+ZKwPyS8P0d0qgLEQZl4zuohUJvjykOXdOKAllYZakrhJmlqpTpBg==
Received: from DS7PR03CA0022.namprd03.prod.outlook.com (2603:10b6:5:3b8::27)
 by BN6PR12MB1300.namprd12.prod.outlook.com (2603:10b6:404:1a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Mon, 13 Dec
 2021 03:39:04 +0000
Received: from DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b8:cafe::e3) by DS7PR03CA0022.outlook.office365.com
 (2603:10b6:5:3b8::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17 via Frontend
 Transport; Mon, 13 Dec 2021 03:39:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 203.18.50.12)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 203.18.50.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=203.18.50.12; helo=mail.nvidia.com;
Received: from mail.nvidia.com (203.18.50.12) by
 DM6NAM11FT009.mail.protection.outlook.com (10.13.173.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4778.13 via Frontend Transport; Mon, 13 Dec 2021 03:39:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 13 Dec
 2021 03:39:01 +0000
Received: from localhost (172.20.187.5) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.9; Sun, 12 Dec 2021
 19:38:58 -0800
From:   Alistair Popple <apopple@nvidia.com>
To:     <akpm@linux-foundation.org>
CC:     <willy@infradead.org>, <dhowells@redhat.com>, <hughd@google.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <jglisse@redhat.com>, <jgg@nvidia.com>, <rcampbell@nvidia.com>,
        <jhubbard@nvidia.com>, <david@redhat.com>,
        Alistair Popple <apopple@nvidia.com>
Subject: [PATCH v5] mm/migrate.c: Rework migration_entry_wait() to not take a pageref
Date:   Mon, 13 Dec 2021 14:38:48 +1100
Message-ID: <20211213033848.1973946-1-apopple@nvidia.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c956a546-71b6-4c6d-7816-08d9bdea1c2d
X-MS-TrafficTypeDiagnostic: BN6PR12MB1300:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1300652C49EF61866AD58DBCDF749@BN6PR12MB1300.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aXU7TifKxzYCYgGbecvkiid+dzNVfl3K6t8Y5tXlUtGfU2RvilohmvUmk16SuqixkI0vj6ORYyvz1LhBdrsmRSFjuRsbsIGMXm/3y/WD8JqxCvdOlc45rwI7BVH+INHPkmL4WHiXf2QsV0eqM2+cWVBxGzoOxa2cwEfGGd2p6X/qYWp9FXIqlGuT8MMpKkJAeX6VPYlgTp3wyFvJ+SQtsQIu++PmVaiddQa3UP/MpeF4WjeIdUSDZ0dg30YDcxI+BAJ57T+E2ieD/Vbh6RAP5qsPCQQiLvSsxx/9O+rYQDg0/o3EdOKoFU7ulfpMU2cdUHrb/0oDAmal3ssbfyU1G+2beLuq623zEFaXXjPoNOoghpEMGwL5ibpKhFf2BSq/WqkTmTFRVh33Y0hCM3SgpEZrjWGkUV8pXpXhL1mg5AZqrPeiGSn3cBp50tepEfUnYJOUJ+bYK6tAt0KdHW9nXzKl86Q0AQNikYshvMmJQFRW6UwYa/58oaXYOVIGYHg4nyrOinWUTQ0ZzLZgDmq962dNzYyIZq2xfJVo8uN9o1vibfDz3/DUen7vV1Z/hU+Y18ZOyN0eNJ/6Rmdjlr1zfhKsxRqEI7Aump3iMuTCDwUiVFwDRonyXDpjq0QeTmq8V0h7XADIXyKiz17Y0P9JygWA2PSstCySNxasODXicbG9wJ9FFpUfwTVS+vcUv3X2YD7SFRaN9tUHYqN6yq2l86zoefSUmb+wXupUb4bTha3tY/voltbhrRWmc8a/3QD7kNGtILylu2Ub/RlOTNcR+Jdt4fDpHk8/5GPU8SC3g1Q=
X-Forefront-Antispam-Report: CIP:203.18.50.12;CTRY:HK;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:hkhybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(316002)(8676002)(1076003)(2616005)(7636003)(356005)(34020700004)(26005)(6916009)(5660300002)(86362001)(82310400004)(186003)(54906003)(336012)(6666004)(47076005)(8936002)(40460700001)(36756003)(83380400001)(426003)(70206006)(107886003)(508600001)(4326008)(70586007)(36860700001)(2906002)(16526019);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 03:39:03.5968
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c956a546-71b6-4c6d-7816-08d9bdea1c2d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[203.18.50.12];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1300
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the FIXME in migrate_vma_check_page().

Before migrating a page migration code will take a reference and check
there are no unexpected page references, failing the migration if there
are. When a thread faults on a migration entry it will take a temporary
reference to the page to wait for the page to become unlocked signifying
the migration entry has been removed.

This reference is dropped just prior to waiting on the page lock,
however the extra reference can cause migration failures so it is
desirable to avoid taking it.

As migration code already has a reference to the migrating page an extra
reference to wait on PG_locked is unnecessary so long as the reference
can't be dropped whilst setting up the wait.

When faulting on a migration entry the ptl is taken to check the
migration entry. Removing a migration entry also requires the ptl, and
migration code won't drop its page reference until after the migration
entry has been removed. Therefore retaining the ptl of a migration entry
is sufficient to ensure the page has a reference. Reworking
migration_entry_wait() to hold the ptl until the wait setup is complete
means the extra page reference is no longer needed.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Acked-by: David Hildenbrand <david@redhat.com>

---

v5:
 - Documentation/comment fixes from David H
 - Added David's Acked-by
 - Changed functions to take swap entries instead of struct pages as
   suggested by Matthew W

v4:
 - Fixed compiler warning
 - Updated comments/description missed during page -> folio rebase

v3:
 - Fix a build issue for CONFIG_MMU=n by only building
   migration_entry_wait_on_locked() if CONFIG_MIGRATION=y

v2:
 - Rebase to master with folios
 - Avoid taking a pageref in pmd_migration_entry_wait() as well
---
 include/linux/migrate.h |  2 +
 mm/filemap.c            | 91 +++++++++++++++++++++++++++++++++++++++++
 mm/migrate.c            | 39 ++----------------
 3 files changed, 97 insertions(+), 35 deletions(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 4850cc5bf813..db96e10eb8da 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -40,6 +40,8 @@ extern int migrate_huge_page_move_mapping(struct address_space *mapping,
 				  struct page *newpage, struct page *page);
 extern int migrate_page_move_mapping(struct address_space *mapping,
 		struct page *newpage, struct page *page, int extra_count);
+void migration_entry_wait_on_locked(swp_entry_t entry, pte_t *ptep,
+				spinlock_t *ptl);
 void folio_migrate_flags(struct folio *newfolio, struct folio *folio);
 void folio_migrate_copy(struct folio *newfolio, struct folio *folio);
 int folio_migrate_mapping(struct address_space *mapping,
diff --git a/mm/filemap.c b/mm/filemap.c
index daa0e23a6ee6..bf8c62ac7d2b 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -21,6 +21,7 @@
 #include <linux/gfp.h>
 #include <linux/mm.h>
 #include <linux/swap.h>
+#include <linux/swapops.h>
 #include <linux/mman.h>
 #include <linux/pagemap.h>
 #include <linux/file.h>
@@ -41,6 +42,7 @@
 #include <linux/psi.h>
 #include <linux/ramfs.h>
 #include <linux/page_idle.h>
+#include <linux/migrate.h>
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 #include "internal.h"
@@ -1426,6 +1428,95 @@ static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
 	return wait->flags & WQ_FLAG_WOKEN ? 0 : -EINTR;
 }
 
+#ifdef CONFIG_MIGRATION
+/**
+ * migration_entry_wait_on_locked - Wait for a migration entry to be removed
+ * @entry: migration swap entry.
+ * @ptep: mapped pte pointer. Will return with the ptep unmapped. Only required
+ *        for pte entries, pass NULL for pmd entries.
+ * @ptl: already locked ptl. This function will drop the lock.
+ *
+ * Wait for a migration entry referencing the given page to be removed. This is
+ * equivalent to put_and_wait_on_page_locked(page, TASK_UNINTERRUPTIBLE) except
+ * this can be called without taking a reference on the page. Instead this
+ * should be called while holding the ptl for the migration entry referencing
+ * the page.
+ *
+ * Returns after unmapping and unlocking the pte/ptl with pte_unmap_unlock().
+ *
+ * This follows the same logic as folio_wait_bit_common() so see the comments
+ * there.
+ */
+void migration_entry_wait_on_locked(swp_entry_t entry, pte_t *ptep,
+				spinlock_t *ptl)
+{
+	struct wait_page_queue wait_page;
+	wait_queue_entry_t *wait = &wait_page.wait;
+	bool thrashing = false;
+	bool delayacct = false;
+	unsigned long pflags;
+	wait_queue_head_t *q;
+	struct folio *folio = page_folio(pfn_swap_entry_to_page(entry));
+
+	q = folio_waitqueue(folio);
+	if (!folio_test_uptodate(folio) && folio_test_workingset(folio)) {
+		if (!folio_test_swapbacked(folio)) {
+			delayacct_thrashing_start();
+			delayacct = true;
+		}
+		psi_memstall_enter(&pflags);
+		thrashing = true;
+	}
+
+	init_wait(wait);
+	wait->func = wake_page_function;
+	wait_page.folio = folio;
+	wait_page.bit_nr = PG_locked;
+	wait->flags = 0;
+
+	spin_lock_irq(&q->lock);
+	folio_set_waiters(folio);
+	if (!folio_trylock_flag(folio, PG_locked, wait))
+		__add_wait_queue_entry_tail(q, wait);
+	spin_unlock_irq(&q->lock);
+
+	/*
+	 * If a migration entry exists for the page the migration path must hold
+	 * a valid reference to the page, and it must take the ptl to remove the
+	 * migration entry. So the page is valid until the ptl is dropped.
+	 */
+	if (ptep)
+		pte_unmap_unlock(ptep, ptl);
+	else
+		spin_unlock(ptl);
+
+	for (;;) {
+		unsigned int flags;
+
+		set_current_state(TASK_UNINTERRUPTIBLE);
+
+		/* Loop until we've been woken or interrupted */
+		flags = smp_load_acquire(&wait->flags);
+		if (!(flags & WQ_FLAG_WOKEN)) {
+			if (signal_pending_state(TASK_UNINTERRUPTIBLE, current))
+				break;
+
+			io_schedule();
+			continue;
+		}
+		break;
+	}
+
+	finish_wait(q, wait);
+
+	if (thrashing) {
+		if (delayacct)
+			delayacct_thrashing_end();
+		psi_memstall_leave(&pflags);
+	}
+}
+#endif
+
 void folio_wait_bit(struct folio *folio, int bit_nr)
 {
 	folio_wait_bit_common(folio, bit_nr, TASK_UNINTERRUPTIBLE, SHARED);
diff --git a/mm/migrate.c b/mm/migrate.c
index cf25b00f03c8..08204bf4ac0b 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -291,7 +291,6 @@ void __migration_entry_wait(struct mm_struct *mm, pte_t *ptep,
 {
 	pte_t pte;
 	swp_entry_t entry;
-	struct page *page;
 
 	spin_lock(ptl);
 	pte = *ptep;
@@ -302,18 +301,7 @@ void __migration_entry_wait(struct mm_struct *mm, pte_t *ptep,
 	if (!is_migration_entry(entry))
 		goto out;
 
-	page = pfn_swap_entry_to_page(entry);
-	page = compound_head(page);
-
-	/*
-	 * Once page cache replacement of page migration started, page_count
-	 * is zero; but we must not call put_and_wait_on_page_locked() without
-	 * a ref. Use get_page_unless_zero(), and just fault again if it fails.
-	 */
-	if (!get_page_unless_zero(page))
-		goto out;
-	pte_unmap_unlock(ptep, ptl);
-	put_and_wait_on_page_locked(page, TASK_UNINTERRUPTIBLE);
+	migration_entry_wait_on_locked(entry, ptep, ptl);
 	return;
 out:
 	pte_unmap_unlock(ptep, ptl);
@@ -338,16 +326,11 @@ void migration_entry_wait_huge(struct vm_area_struct *vma,
 void pmd_migration_entry_wait(struct mm_struct *mm, pmd_t *pmd)
 {
 	spinlock_t *ptl;
-	struct page *page;
 
 	ptl = pmd_lock(mm, pmd);
 	if (!is_pmd_migration_entry(*pmd))
 		goto unlock;
-	page = pfn_swap_entry_to_page(pmd_to_swp_entry(*pmd));
-	if (!get_page_unless_zero(page))
-		goto unlock;
-	spin_unlock(ptl);
-	put_and_wait_on_page_locked(page, TASK_UNINTERRUPTIBLE);
+	migration_entry_wait_on_locked(pmd_to_swp_entry(*pmd), NULL, ptl);
 	return;
 unlock:
 	spin_unlock(ptl);
@@ -2484,22 +2467,8 @@ static bool migrate_vma_check_page(struct page *page)
 		return false;
 
 	/* Page from ZONE_DEVICE have one extra reference */
-	if (is_zone_device_page(page)) {
-		/*
-		 * Private page can never be pin as they have no valid pte and
-		 * GUP will fail for those. Yet if there is a pending migration
-		 * a thread might try to wait on the pte migration entry and
-		 * will bump the page reference count. Sadly there is no way to
-		 * differentiate a regular pin from migration wait. Hence to
-		 * avoid 2 racing thread trying to migrate back to CPU to enter
-		 * infinite loop (one stopping migration because the other is
-		 * waiting on pte migration entry). We always return true here.
-		 *
-		 * FIXME proper solution is to rework migration_entry_wait() so
-		 * it does not need to take a reference on page.
-		 */
-		return is_device_private_page(page);
-	}
+	if (is_zone_device_page(page))
+		extra++;
 
 	/* For file back page */
 	if (page_mapping(page))
-- 
2.30.2


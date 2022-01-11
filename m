Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C655E48A780
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 06:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347575AbiAKFxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 00:53:44 -0500
Received: from foss.arm.com ([217.140.110.172]:42064 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347510AbiAKFxk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 00:53:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D96181FB;
        Mon, 10 Jan 2022 21:53:39 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.72.245])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C024A3F774;
        Mon, 10 Jan 2022 21:53:36 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm/debug_vm_pgtable: Update comments regarding migration swap entries
Date:   Tue, 11 Jan 2022 11:23:37 +0530
Message-Id: <1641880417-24848-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 4dd845b5a3e5 ("mm/swapops: rework swap entry manipulation code")
had changed migtation entry related helpers. Just update debug_vm_pgatble()
synced documentation to reflect those changes.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-doc@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This applies on v5.16

 Documentation/vm/arch_pgtable_helpers.rst | 14 +++++++-------
 mm/debug_vm_pgtable.c                     |  4 ++--
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/vm/arch_pgtable_helpers.rst b/Documentation/vm/arch_pgtable_helpers.rst
index 552567d863b8..b3166c33db39 100644
--- a/Documentation/vm/arch_pgtable_helpers.rst
+++ b/Documentation/vm/arch_pgtable_helpers.rst
@@ -247,12 +247,12 @@ SWAP Page Table Helpers
 | __swp_to_pmd_entry        | Creates a mapped PMD from a swapped entry (arch) |
 +---------------------------+--------------------------------------------------+
 | is_migration_entry        | Tests a migration (read or write) swapped entry  |
-+---------------------------+--------------------------------------------------+
-| is_write_migration_entry  | Tests a write migration swapped entry            |
-+---------------------------+--------------------------------------------------+
-| make_migration_entry_read | Converts into read migration swapped entry       |
-+---------------------------+--------------------------------------------------+
-| make_migration_entry      | Creates a migration swapped entry (read or write)|
-+---------------------------+--------------------------------------------------+
++-------------------------------+----------------------------------------------+
+| is_writable_migration_entry   | Tests a write migration swapped entry        |
++-------------------------------+----------------------------------------------+
+| make_readable_migration_entry | Creates a read migration swapped entry       |
++-------------------------------+----------------------------------------------+
+| make_writable_migration_entry | Creates a write migration swapped entry      |
++-------------------------------+----------------------------------------------+
 
 [1] https://lore.kernel.org/linux-mm/20181017020930.GN30832@redhat.com/
diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index 228e3954b90c..2a2b24e87877 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -888,8 +888,8 @@ static void __init swap_migration_tests(struct pgtable_debug_args *args)
 	pr_debug("Validating swap migration\n");
 
 	/*
-	 * make_migration_entry() expects given page to be
-	 * locked, otherwise it stumbles upon a BUG_ON().
+	 * make_[readable|writable]_migration_entry() expects given page to
+	 * be locked, otherwise it stumbles upon a BUG_ON().
 	 */
 	__SetPageLocked(page);
 	swp = make_writable_migration_entry(page_to_pfn(page));
-- 
2.20.1


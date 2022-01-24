Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1F98498003
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 13:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242703AbiAXM5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 07:57:25 -0500
Received: from foss.arm.com ([217.140.110.172]:32832 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242240AbiAXM5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 07:57:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 459B4ED1;
        Mon, 24 Jan 2022 04:57:13 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.43.190])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8DBA03F774;
        Mon, 24 Jan 2022 04:57:10 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, hch@infradead.org,
        akpm@linux-foundation.org,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [RFC V1 01/31] mm/debug_vm_pgtable: Directly use vm_get_page_prot()
Date:   Mon, 24 Jan 2022 18:26:38 +0530
Message-Id: <1643029028-12710-2-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1643029028-12710-1-git-send-email-anshuman.khandual@arm.com>
References: <1643029028-12710-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although protection_map[] contains the platform defined page protection map
, vm_get_page_prot() is the right interface to call for page protection for
a given vm_flags. Hence lets use it directly instead. This will also reduce
dependency on protection_map[].

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 mm/debug_vm_pgtable.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index a7ac97c76762..07593eb79338 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -93,7 +93,7 @@ struct pgtable_debug_args {
 
 static void __init pte_basic_tests(struct pgtable_debug_args *args, int idx)
 {
-	pgprot_t prot = protection_map[idx];
+	pgprot_t prot = vm_get_page_prot(idx);
 	pte_t pte = pfn_pte(args->fixed_pte_pfn, prot);
 	unsigned long val = idx, *ptr = &val;
 
@@ -101,7 +101,7 @@ static void __init pte_basic_tests(struct pgtable_debug_args *args, int idx)
 
 	/*
 	 * This test needs to be executed after the given page table entry
-	 * is created with pfn_pte() to make sure that protection_map[idx]
+	 * is created with pfn_pte() to make sure that vm_get_page_prot(idx)
 	 * does not have the dirty bit enabled from the beginning. This is
 	 * important for platforms like arm64 where (!PTE_RDONLY) indicate
 	 * dirty bit being set.
@@ -188,7 +188,7 @@ static void __init pte_savedwrite_tests(struct pgtable_debug_args *args)
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 static void __init pmd_basic_tests(struct pgtable_debug_args *args, int idx)
 {
-	pgprot_t prot = protection_map[idx];
+	pgprot_t prot = vm_get_page_prot(idx);
 	unsigned long val = idx, *ptr = &val;
 	pmd_t pmd;
 
@@ -200,7 +200,7 @@ static void __init pmd_basic_tests(struct pgtable_debug_args *args, int idx)
 
 	/*
 	 * This test needs to be executed after the given page table entry
-	 * is created with pfn_pmd() to make sure that protection_map[idx]
+	 * is created with pfn_pmd() to make sure that vm_get_page_prot(idx)
 	 * does not have the dirty bit enabled from the beginning. This is
 	 * important for platforms like arm64 where (!PTE_RDONLY) indicate
 	 * dirty bit being set.
@@ -323,7 +323,7 @@ static void __init pmd_savedwrite_tests(struct pgtable_debug_args *args)
 #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
 static void __init pud_basic_tests(struct pgtable_debug_args *args, int idx)
 {
-	pgprot_t prot = protection_map[idx];
+	pgprot_t prot = vm_get_page_prot(idx);
 	unsigned long val = idx, *ptr = &val;
 	pud_t pud;
 
@@ -335,7 +335,7 @@ static void __init pud_basic_tests(struct pgtable_debug_args *args, int idx)
 
 	/*
 	 * This test needs to be executed after the given page table entry
-	 * is created with pfn_pud() to make sure that protection_map[idx]
+	 * is created with pfn_pud() to make sure that vm_get_page_prot(idx)
 	 * does not have the dirty bit enabled from the beginning. This is
 	 * important for platforms like arm64 where (!PTE_RDONLY) indicate
 	 * dirty bit being set.
@@ -1104,14 +1104,14 @@ static int __init init_args(struct pgtable_debug_args *args)
 	/*
 	 * Initialize the debugging data.
 	 *
-	 * protection_map[0] (or even protection_map[8]) will help create
-	 * page table entries with PROT_NONE permission as required for
-	 * pxx_protnone_tests().
+	 * vm_get_page_prot(VM_NONE) or vm_get_page_prot(VM_SHARED|VM_NONE)
+	 * will help create page table entries with PROT_NONE permission as
+	 * required for pxx_protnone_tests().
 	 */
 	memset(args, 0, sizeof(*args));
 	args->vaddr              = get_random_vaddr();
 	args->page_prot          = vm_get_page_prot(VMFLAGS);
-	args->page_prot_none     = protection_map[0];
+	args->page_prot_none     = vm_get_page_prot(VM_NONE);
 	args->is_contiguous_page = false;
 	args->pud_pfn            = ULONG_MAX;
 	args->pmd_pfn            = ULONG_MAX;
@@ -1246,12 +1246,15 @@ static int __init debug_vm_pgtable(void)
 		return ret;
 
 	/*
-	 * Iterate over the protection_map[] to make sure that all
+	 * Iterate over each possible vm_flags to make sure that all
 	 * the basic page table transformation validations just hold
 	 * true irrespective of the starting protection value for a
 	 * given page table entry.
+	 *
+	 * Protection based vm_flags combinatins are always linear
+	 * and increasing i.e VM_NONE ..[VM_SHARED|READ|WRITE|EXEC].
 	 */
-	for (idx = 0; idx < ARRAY_SIZE(protection_map); idx++) {
+	for (idx = VM_NONE; idx <= (VM_SHARED | VM_READ | VM_WRITE | VM_EXEC); idx++) {
 		pte_basic_tests(&args, idx);
 		pmd_basic_tests(&args, idx);
 		pud_basic_tests(&args, idx);
-- 
2.25.1


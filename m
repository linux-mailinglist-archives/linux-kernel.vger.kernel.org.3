Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3773B498005
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 13:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242716AbiAXM50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 07:57:26 -0500
Received: from foss.arm.com ([217.140.110.172]:32844 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242629AbiAXM5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 07:57:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF7A4D6E;
        Mon, 24 Jan 2022 04:57:16 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.43.190])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1590B3F774;
        Mon, 24 Jan 2022 04:57:13 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, hch@infradead.org,
        akpm@linux-foundation.org,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [RFC V1 02/31] mm/mmap: Clarify protection_map[] indices
Date:   Mon, 24 Jan 2022 18:26:39 +0530
Message-Id: <1643029028-12710-3-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1643029028-12710-1-git-send-email-anshuman.khandual@arm.com>
References: <1643029028-12710-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

protection_map[] maps vm_flags access combinations into page protection
value as defined by the platform via __PXXX and __SXXX macros. The array
indices in protection_map[], represents vm_flags access combinations but
it's not very intuitive to derive. This makes it clear and explicit.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 mm/mmap.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 1e8fdb0b51ed..254d716220df 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -102,8 +102,22 @@ static void unmap_region(struct mm_struct *mm,
  *								x: (yes) yes
  */
 pgprot_t protection_map[16] __ro_after_init = {
-	__P000, __P001, __P010, __P011, __P100, __P101, __P110, __P111,
-	__S000, __S001, __S010, __S011, __S100, __S101, __S110, __S111
+	[VM_NONE]				= __P000,
+	[VM_READ]				= __P001,
+	[VM_WRITE]				= __P010,
+	[VM_READ|VM_WRITE]			= __P011,
+	[VM_EXEC]				= __P100,
+	[VM_EXEC|VM_READ]			= __P101,
+	[VM_EXEC|VM_WRITE]			= __P110,
+	[VM_EXEC|VM_READ|VM_WRITE]		= __P111,
+	[VM_SHARED]				= __S000,
+	[VM_SHARED|VM_READ]			= __S001,
+	[VM_SHARED|VM_WRITE]			= __S010,
+	[VM_SHARED|VM_READ|VM_WRITE]		= __S011,
+	[VM_SHARED|VM_EXEC]			= __S100,
+	[VM_SHARED|VM_READ|VM_EXEC]		= __S101,
+	[VM_SHARED|VM_WRITE|VM_EXEC]		= __S110,
+	[VM_SHARED|VM_READ|VM_WRITE|VM_EXEC]	= __S111
 };
 
 #ifndef CONFIG_ARCH_HAS_FILTER_PGPROT
-- 
2.25.1


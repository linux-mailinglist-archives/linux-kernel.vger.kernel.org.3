Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDFD9464101
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 23:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344489AbhK3WLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 17:11:10 -0500
Received: from out2.migadu.com ([188.165.223.204]:44223 "EHLO out2.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344581AbhK3WKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 17:10:46 -0500
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1638310045;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OFKLwR0n61M6N9uSIaGXlIm7A+MUpLcvomUMG6SjeVA=;
        b=VdAAuU8y+GmIwkqPmRZYuLKv8OBJ3Dgu8rVOhGedNbsu78hASLgdHoilkcU7vGisS7YqUc
        LPPTi3X8KYw8dtwxg//oMFWPW4DJVYSR7ejRKSXr4Rdq3yn6AksiHjG76uyXSY+jGRmbOa
        EQ0xZiQ6wvuuhLUe8UMVaTZAfzOiBik=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Collingbourne <pcc@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Evgenii Stepanov <eugenis@google.com>,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH 20/31] kasan, vmalloc: reset tags in vmalloc functions
Date:   Tue, 30 Nov 2021 23:07:05 +0100
Message-Id: <f405e36b20bd5d79dffef3f70b523885dcc6b163.1638308023.git.andreyknvl@google.com>
In-Reply-To: <cover.1638308023.git.andreyknvl@google.com>
References: <cover.1638308023.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

In preparation for adding vmalloc support to SW/HW_TAGS KASAN,
reset pointer tags in functions that use pointer values in
range checks.

vread() is a special case here. Resetting the pointer tag in its
prologue could technically lead to missing bad accesses to virtual
mappings in its implementation. However, vread() doesn't access the
virtual mappings cirectly. Instead, it recovers the physical address
via page_address(vmalloc_to_page()) and acceses that. And as
page_address() recovers the pointer tag, the accesses are checked.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/vmalloc.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index c5235e3e5857..a059b3100c0a 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -72,7 +72,7 @@ static const bool vmap_allow_huge = false;
 
 bool is_vmalloc_addr(const void *x)
 {
-	unsigned long addr = (unsigned long)x;
+	unsigned long addr = (unsigned long)kasan_reset_tag(x);
 
 	return addr >= VMALLOC_START && addr < VMALLOC_END;
 }
@@ -630,7 +630,7 @@ int is_vmalloc_or_module_addr(const void *x)
 	 * just put it in the vmalloc space.
 	 */
 #if defined(CONFIG_MODULES) && defined(MODULES_VADDR)
-	unsigned long addr = (unsigned long)x;
+	unsigned long addr = (unsigned long)kasan_reset_tag(x);
 	if (addr >= MODULES_VADDR && addr < MODULES_END)
 		return 1;
 #endif
@@ -804,6 +804,8 @@ static struct vmap_area *find_vmap_area_exceed_addr(unsigned long addr)
 	struct vmap_area *va = NULL;
 	struct rb_node *n = vmap_area_root.rb_node;
 
+	addr = (unsigned long)kasan_reset_tag((void *)addr);
+
 	while (n) {
 		struct vmap_area *tmp;
 
@@ -825,6 +827,8 @@ static struct vmap_area *__find_vmap_area(unsigned long addr)
 {
 	struct rb_node *n = vmap_area_root.rb_node;
 
+	addr = (unsigned long)kasan_reset_tag((void *)addr);
+
 	while (n) {
 		struct vmap_area *va;
 
@@ -2143,7 +2147,7 @@ EXPORT_SYMBOL_GPL(vm_unmap_aliases);
 void vm_unmap_ram(const void *mem, unsigned int count)
 {
 	unsigned long size = (unsigned long)count << PAGE_SHIFT;
-	unsigned long addr = (unsigned long)mem;
+	unsigned long addr = (unsigned long)kasan_reset_tag(mem);
 	struct vmap_area *va;
 
 	might_sleep();
@@ -3361,6 +3365,8 @@ long vread(char *buf, char *addr, unsigned long count)
 	unsigned long buflen = count;
 	unsigned long n;
 
+	addr = kasan_reset_tag(addr);
+
 	/* Don't allow overflow */
 	if ((unsigned long) addr + count < count)
 		count = -(unsigned long) addr;
-- 
2.25.1


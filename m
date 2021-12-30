Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66B0F481FA6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 20:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240621AbhL3TPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 14:15:16 -0500
Received: from out2.migadu.com ([188.165.223.204]:60347 "EHLO out2.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237142AbhL3TPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 14:15:12 -0500
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1640891710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/m7yWk0TB8ReTTBYiN5UEq4jCzWx0qUSGwpwtza3XBc=;
        b=iZqQLEZg8az84o+hGCTf27CTTdVUXqmU9oKKU346aO4d6J4lpaAxPuOy32SzKmF1jucO9W
        nVID7GC78ESQSJKqCOibjqlVu1SviTs2hisQNNyhUqrjdIrKSnPZ29KJYYWA7kcTwNJl0A
        yZor+HjsFVKu46EX5vdemovzHxSU0C8=
From:   andrey.konovalov@linux.dev
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH mm v5 22/39] kasan, fork: reset pointer tags of vmapped stacks
Date:   Thu, 30 Dec 2021 20:14:47 +0100
Message-Id: <0a01ad4e71a0861702922ceda87a34a1b4313aca.1640891329.git.andreyknvl@google.com>
In-Reply-To: <cover.1640891329.git.andreyknvl@google.com>
References: <cover.1640891329.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Once tag-based KASAN modes start tagging vmalloc() allocations,
kernel stacks start getting tagged if CONFIG_VMAP_STACK is enabled.

Reset the tag of kernel stack pointers after allocation in
alloc_thread_stack_node().

For SW_TAGS KASAN, when CONFIG_KASAN_STACK is enabled, the
instrumentation can't handle the SP register being tagged.

For HW_TAGS KASAN, there's no instrumentation-related issues. However,
the impact of having a tagged SP register needs to be properly evaluated,
so keep it non-tagged for now.

Note, that the memory for the stack allocation still gets tagged to
catch vmalloc-into-stack out-of-bounds accesses.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

---

Changes v2->v3:
- Update patch description.
---
 kernel/fork.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/fork.c b/kernel/fork.c
index 40f7a6c2a710..5fdb74c7db83 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -254,6 +254,7 @@ static unsigned long *alloc_thread_stack_node(struct task_struct *tsk, int node)
 	 * so cache the vm_struct.
 	 */
 	if (stack) {
+		stack = kasan_reset_tag(stack);
 		tsk->stack_vm_area = find_vm_area(stack);
 		tsk->stack = stack;
 	}
-- 
2.25.1


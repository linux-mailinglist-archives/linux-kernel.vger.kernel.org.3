Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 719A74736EF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 22:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238437AbhLMVyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 16:54:41 -0500
Received: from out0.migadu.com ([94.23.1.103]:19716 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243397AbhLMVyh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 16:54:37 -0500
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1639432476;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IMzV1X5Nd86e4oY4hBFTxC35nepZUwTPpD8+HwJgmqo=;
        b=udatEMOwk5I3nWvaD5ENT7vRiUqEyQkL/DfK/zBcriZ9wlQF9FOmWKvt13GARWO4Rk5Eqp
        3mNhKVcYTU8GR0gPh1QA7psqKuUvElQkZ+FNvHMtgGt+5+HwjGFmaA13fJTmcJw3Q8tr8j
        3U724pXY8+/BLDAXWHfk+1rd/rfuXdI=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
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
Subject: [PATCH mm v3 22/38] kasan, fork: reset pointer tags of vmapped stacks
Date:   Mon, 13 Dec 2021 22:54:18 +0100
Message-Id: <4f7e671a95dd4b2cc1b9188da0da23302a94f6a7.1639432170.git.andreyknvl@google.com>
In-Reply-To: <cover.1639432170.git.andreyknvl@google.com>
References: <cover.1639432170.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: andrey.konovalov@linux.dev
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

---

Changes v2->v3:
- Update patch description.
---
 kernel/fork.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/fork.c b/kernel/fork.c
index 2993a0058f9b..9e488921424e 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -253,6 +253,7 @@ static unsigned long *alloc_thread_stack_node(struct task_struct *tsk, int node)
 	 * so cache the vm_struct.
 	 */
 	if (stack) {
+		stack = kasan_reset_tag(stack);
 		tsk->stack_vm_area = find_vm_area(stack);
 		tsk->stack = stack;
 	}
-- 
2.25.1


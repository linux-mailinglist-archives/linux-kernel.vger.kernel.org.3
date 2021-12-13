Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE7B54736F1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 22:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243298AbhLMVym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 16:54:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243304AbhLMVyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 16:54:41 -0500
X-Greylist: delayed 68 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 13 Dec 2021 13:54:41 PST
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38951C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 13:54:41 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1639432479;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yrzW1sRI0uWg5UfgxRnOwTnc7XfDGQwyJkjr78hdM+k=;
        b=etceA798k1UaBRGEO6qMaUWUvf+IP6vuXL8XiJwI1lnrIAjCNM62Fd9UCSXZz3lYonzjkd
        WMw52NsxZWo2gI3kDdMUXC2WIyvZbIhEQYXujW+csEMiIGm+nH8SmFEBjcsDUn6BFGVgn6
        IsI/anyc8OrjCXc/tuI6vVWg60cmgl0=
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
Subject: [PATCH mm v3 23/38] kasan, arm64: reset pointer tags of vmapped stacks
Date:   Mon, 13 Dec 2021 22:54:19 +0100
Message-Id: <bc9f6cb3df24eb076a6d99f91f97820718f3e29e.1639432170.git.andreyknvl@google.com>
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
arch_alloc_vmap_stack().

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
- Add this patch.
---
 arch/arm64/include/asm/vmap_stack.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/vmap_stack.h b/arch/arm64/include/asm/vmap_stack.h
index 894e031b28d2..20873099c035 100644
--- a/arch/arm64/include/asm/vmap_stack.h
+++ b/arch/arm64/include/asm/vmap_stack.h
@@ -17,10 +17,13 @@
  */
 static inline unsigned long *arch_alloc_vmap_stack(size_t stack_size, int node)
 {
+	void *p;
+
 	BUILD_BUG_ON(!IS_ENABLED(CONFIG_VMAP_STACK));
 
-	return __vmalloc_node(stack_size, THREAD_ALIGN, THREADINFO_GFP, node,
+	p = __vmalloc_node(stack_size, THREAD_ALIGN, THREADINFO_GFP, node,
 			__builtin_return_address(0));
+	return kasan_reset_tag(p);
 }
 
 #endif /* __ASM_VMAP_STACK_H */
-- 
2.25.1


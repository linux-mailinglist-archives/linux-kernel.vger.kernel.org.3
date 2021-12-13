Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0283B473700
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 22:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243361AbhLMVzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 16:55:06 -0500
Received: from out0.migadu.com ([94.23.1.103]:20013 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243367AbhLMVzC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 16:55:02 -0500
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1639432501;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xS/npKqLDOlLS7GUOQeVJqvjcgKhqLlgaKGLm1W4Mro=;
        b=OSZF9QehuGKytjp2/V1w0fMRG10MR9MmO52qSTWcoIrkp76qmfS0edl98byJlLha85CH4x
        LE6vwlT5oxQJGzDUDpWdP+l/GyhHTrdxyzlRKMJT+57/IAD4DYZrweDhDoNawziCAzYMaY
        xOJDoLSnWAy1yXCwwhcyWEFqmNwycbo=
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
Subject: [PATCH mm v3 31/38] kasan, arm64: don't tag executable vmalloc allocations
Date:   Mon, 13 Dec 2021 22:54:27 +0100
Message-Id: <4a5ec956a2666c1f967c9789534a8ac4d4fe26f9.1639432170.git.andreyknvl@google.com>
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

Besides asking vmalloc memory to be executable via the prot argument
of __vmalloc_node_range() (see the previous patch), the kernel can skip
that bit and instead mark memory as executable via set_memory_x().

Once tag-based KASAN modes start tagging vmalloc allocations, executing
code from such allocations will lead to the PC register getting a tag,
which is not tolerated by the kernel.

Generic kernel code typically allocates memory via module_alloc() if
it intends to mark memory as executable. (On arm64 module_alloc()
uses __vmalloc_node_range() without setting the executable bit).

Thus, reset pointer tags of pointers returned from module_alloc().

However, on arm64 there's an exception: the eBPF subsystem. Instead of
using module_alloc(), it uses vmalloc() (via bpf_jit_alloc_exec())
to allocate its JIT region.

Thus, reset pointer tags of pointers returned from bpf_jit_alloc_exec().

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

---

Changes v2->v3:
- Add this patch.
---
 arch/arm64/kernel/module.c    | 3 ++-
 arch/arm64/net/bpf_jit_comp.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
index d3a1fa818348..f2d4bb14bfab 100644
--- a/arch/arm64/kernel/module.c
+++ b/arch/arm64/kernel/module.c
@@ -63,7 +63,8 @@ void *module_alloc(unsigned long size)
 		return NULL;
 	}
 
-	return p;
+	/* Memory is intended to be executable, reset the pointer tag. */
+	return kasan_reset_tag(p);
 }
 
 enum aarch64_reloc_op {
diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 07aad85848fa..381a67922c2d 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -1147,7 +1147,8 @@ u64 bpf_jit_alloc_exec_limit(void)
 
 void *bpf_jit_alloc_exec(unsigned long size)
 {
-	return vmalloc(size);
+	/* Memory is intended to be executable, reset the pointer tag. */
+	return kasan_reset_tag(vmalloc(size));
 }
 
 void bpf_jit_free_exec(void *addr)
-- 
2.25.1


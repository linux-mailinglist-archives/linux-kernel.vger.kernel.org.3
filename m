Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 664BA4987D7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 19:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235540AbiAXSHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 13:07:49 -0500
Received: from out0.migadu.com ([94.23.1.103]:19471 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230334AbiAXSH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 13:07:29 -0500
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1643047648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TFKsp+57v018bGervn3rQX2/toL0nwmJo1LVwhe4qDg=;
        b=tAzFc3657Ljq58oSs1g1Uh5gBAS52GUGRtRzaAWSSDmM8vIMziT4XUSKTfHYQDufsnQiCv
        9SA7a0/7slRa/2S4ClTsPByHC/qvHasd5HObqMOL5D9RPZ/Xg3D+0G8QX3KRuXrNFltFqx
        h1C9iGZMrHa5r64q9R3LHZv+a9jDzzI=
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
Subject: [PATCH v6 32/39] kasan, arm64: don't tag executable vmalloc allocations
Date:   Mon, 24 Jan 2022 19:05:06 +0100
Message-Id: <b7b2595423340cd7d76b770e5d519acf3b72f0ab.1643047180.git.andreyknvl@google.com>
In-Reply-To: <cover.1643047180.git.andreyknvl@google.com>
References: <cover.1643047180.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
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

Resetting tags for these pointers results in untagged pointers being
passed to set_memory_x(). This causes conflicts in arithmetic checks
in change_memory_common(), as vm_struct->addr pointer returned by
find_vm_area() is tagged.

Reset pointer tag of find_vm_area(addr)->addr in change_memory_common().

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>

---

Changes v3->v4:
- Reset pointer tag in change_memory_common().

Changes v2->v3:
- Add this patch.
---
 arch/arm64/kernel/module.c    | 3 ++-
 arch/arm64/mm/pageattr.c      | 2 +-
 arch/arm64/net/bpf_jit_comp.c | 3 ++-
 3 files changed, 5 insertions(+), 3 deletions(-)

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
diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
index a3bacd79507a..64e985eaa52d 100644
--- a/arch/arm64/mm/pageattr.c
+++ b/arch/arm64/mm/pageattr.c
@@ -85,7 +85,7 @@ static int change_memory_common(unsigned long addr, int numpages,
 	 */
 	area = find_vm_area((void *)addr);
 	if (!area ||
-	    end > (unsigned long)area->addr + area->size ||
+	    end > (unsigned long)kasan_reset_tag(area->addr) + area->size ||
 	    !(area->flags & VM_ALLOC))
 		return -EINVAL;
 
diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index e96d4d87291f..2198af06ae6a 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -1150,7 +1150,8 @@ u64 bpf_jit_alloc_exec_limit(void)
 
 void *bpf_jit_alloc_exec(unsigned long size)
 {
-	return vmalloc(size);
+	/* Memory is intended to be executable, reset the pointer tag. */
+	return kasan_reset_tag(vmalloc(size));
 }
 
 void bpf_jit_free_exec(void *addr)
-- 
2.25.1


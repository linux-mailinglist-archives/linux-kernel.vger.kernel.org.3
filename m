Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C751A4736EB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 22:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243284AbhLMVx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 16:53:58 -0500
Received: from out0.migadu.com ([94.23.1.103]:19317 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243275AbhLMVx5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 16:53:57 -0500
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1639432434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DErGD3M4prwe4k38EJQv474oTAHhfYAOppngSPgJwzw=;
        b=xFIm1kk8g+WiU8pAzgzpuH5fydOw1q1u1vCSYeSMuZkffiX6dCbyDl/XjehGxErowQgC0c
        oJl0kOVg3z6PPytt+7Fb51ZY3rw6V3p9QmHYcledP21es6vtUAzdTH7ZwUZ32XOGivh6lv
        1QF99N8XfxMvSxYDzVP0XHQtTT9N32I=
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
Subject: [PATCH mm v3 18/38] kasan, vmalloc: drop outdated VM_KASAN comment
Date:   Mon, 13 Dec 2021 22:53:08 +0100
Message-Id: <678a2184509f5622d4a068f762691eb3ef5897af.1639432170.git.andreyknvl@google.com>
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

The comment about VM_KASAN in include/linux/vmalloc.c is outdated.
VM_KASAN is currently only used to mark vm_areas allocated for
kernel modules when CONFIG_KASAN_VMALLOC is disabled.

Drop the comment.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 include/linux/vmalloc.h | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index df5f14458e46..28becb10d013 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -35,17 +35,6 @@ struct notifier_block;		/* in notifier.h */
 #define VM_DEFER_KMEMLEAK	0
 #endif
 
-/*
- * VM_KASAN is used slightly differently depending on CONFIG_KASAN_VMALLOC.
- *
- * If IS_ENABLED(CONFIG_KASAN_VMALLOC), VM_KASAN is set on a vm_struct after
- * shadow memory has been mapped. It's used to handle allocation errors so that
- * we don't try to poison shadow on free if it was never allocated.
- *
- * Otherwise, VM_KASAN is set for kasan_module_alloc() allocations and used to
- * determine which allocations need the module shadow freed.
- */
-
 /* bits [20..32] reserved for arch specific ioremap internals */
 
 /*
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25A254987B9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 19:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244949AbiAXSFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 13:05:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241629AbiAXSFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 13:05:18 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A919C06173D
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 10:05:18 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1643047517;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9A/aiRr/eeAtuJgRH9CgKix3liywKVtjCGXmP7PCGKU=;
        b=tbxWzIiyor4endaQATbidklnt+syNwmi7hm5yMdHV/C61qeV/L0qewDmLZBPYSQ+zsDRZ/
        7OnBdrdpNZVCh+9SEtM3qEhN1Vp/J+5bVgsZSIIYFcybmneoDbonBvyjLV9oysEtgmEHvS
        VRFLR80lfIXwhpaou6epRhjOvXLjwMo=
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
Subject: [PATCH v6 18/39] kasan, vmalloc: drop outdated VM_KASAN comment
Date:   Mon, 24 Jan 2022 19:04:52 +0100
Message-Id: <780395afea83a147b3b5acc36cf2e38f7f8479f9.1643047180.git.andreyknvl@google.com>
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

The comment about VM_KASAN in include/linux/vmalloc.c is outdated.
VM_KASAN is currently only used to mark vm_areas allocated for
kernel modules when CONFIG_KASAN_VMALLOC is disabled.

Drop the comment.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
---
 include/linux/vmalloc.h | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 880227b9f044..87f8cfec50a0 100644
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


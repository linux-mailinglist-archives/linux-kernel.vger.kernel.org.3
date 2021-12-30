Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 370AE481F84
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 20:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241887AbhL3TNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 14:13:04 -0500
Received: from out0.migadu.com ([94.23.1.103]:57577 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241815AbhL3TMw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 14:12:52 -0500
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1640891571;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C7bL1Zr1naNl/Uo665wUTq0llGclMt9lfTghUSLQOMw=;
        b=VjUsadY10wVNgk5lXJf6EPVC01JU+PVX6X7U0/I6zySRYE9zmGB+n8D8czFGxnpysOY9sU
        XpmYkGqFnBKyKVkmc17yCUmYsJdadoIIFLVqj2QJGQKM+1AbU8fkhhKpYH3Rt9gMC5fLLw
        vJwvx3N8KtgDB064e+SZbyF49uE1Cm4=
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
Subject: [PATCH mm v5 07/39] mm: clarify __GFP_ZEROTAGS comment
Date:   Thu, 30 Dec 2021 20:12:09 +0100
Message-Id: <4ef9f470c0d41437d7a2a111e2c739957f49ee39.1640891329.git.andreyknvl@google.com>
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

__GFP_ZEROTAGS is intended as an optimization: if memory is zeroed during
allocation, it's possible to set memory tags at the same time with little
performance impact.

Clarify this intention of __GFP_ZEROTAGS in the comment.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

---

Changes v4->v5:
- Mention optimization intention in the comment.
---
 include/linux/gfp.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 5f893d994dcd..19e55f3fdd04 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -228,8 +228,10 @@ struct vm_area_struct;
  *
  * %__GFP_ZERO returns a zeroed page on success.
  *
- * %__GFP_ZEROTAGS returns a page with zeroed memory tags on success, if
- * __GFP_ZERO is set.
+ * %__GFP_ZEROTAGS zeroes memory tags at allocation time if the memory itself
+ * is being zeroed (either via __GFP_ZERO or via init_on_alloc). This flag is
+ * intended for optimization: setting memory tags at the same time as zeroing
+ * memory has minimal additional performace impact.
  *
  * %__GFP_SKIP_KASAN_POISON returns a page which does not need to be poisoned
  * on deallocation. Typically used for userspace pages. Currently only has an
-- 
2.25.1


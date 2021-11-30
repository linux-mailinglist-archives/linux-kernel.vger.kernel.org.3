Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3D7464088
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 22:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344427AbhK3Vps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 16:45:48 -0500
Received: from out1.migadu.com ([91.121.223.63]:50394 "EHLO out1.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344323AbhK3Vo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 16:44:59 -0500
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1638308497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2VlRNVgjD8s3LiQBttrzG+uL14gJGV2zDjLV32J+vek=;
        b=O1N5ChXOugWJB6+QRXIZUB5o0s8EIG4DrohccwfveR/ePyG/uOTU2Vr3uQ5CLC5yZ0d+0A
        eGSsm6vFEgIjBpqKJdRm/maniY9N+gPYUEDQvLIb0sapJp7Yek5uLmAeDiRXfQRcILFV2y
        bxPZpZ/X4eJsx3ImbI/t3f5FciFB7xs=
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
Subject: [PATCH 06/31] mm: clarify __GFP_ZEROTAGS comment
Date:   Tue, 30 Nov 2021 22:41:28 +0100
Message-Id: <4f6d3dd6f1ab9d7774c96ca0ad6d8cabebf0914b.1638308023.git.andreyknvl@google.com>
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

__GFP_ZEROTAGS is intended as an optimization: if memory is zeroed during
allocation, it's possible to set memory tags at the same time with little
performance impact.

Clarify this intention of __GFP_ZEROTAGS in the comment.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 include/linux/gfp.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index b976c4177299..dddd7597689f 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -232,8 +232,8 @@ struct vm_area_struct;
  *
  * %__GFP_ZERO returns a zeroed page on success.
  *
- * %__GFP_ZEROTAGS returns a page with zeroed memory tags on success, if
- * __GFP_ZERO is set.
+ * %__GFP_ZEROTAGS zeroes memory tags at allocation time if the memory itself
+ * is being zeroed (either via __GFP_ZERO or via init_on_alloc).
  *
  * %__GFP_SKIP_KASAN_POISON returns a page which does not need to be poisoned
  * on deallocation. Typically used for userspace pages. Currently only has an
-- 
2.25.1


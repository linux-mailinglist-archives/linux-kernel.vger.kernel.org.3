Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC8FD46AAB2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 22:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352538AbhLFVsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 16:48:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352402AbhLFVsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 16:48:07 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2AA7C061D5F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 13:44:34 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1638827073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2VlRNVgjD8s3LiQBttrzG+uL14gJGV2zDjLV32J+vek=;
        b=TD3DS7kX7rNKsdKtOiQfPuRZoLtKBoyf7SJg3jpF4rxc0wxHBoJHLYeR2c6s/YbyY6uLog
        5APt5A1zwI3YC58xavMrB9D7v31ne2TlVFuxLLSpZf+HaEztsc2oWCXxMaaVxulkDWL0aM
        J4XRIiAZyUo1nVCnDbXOAGcx88Hqa+4=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Collingbourne <pcc@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Evgenii Stepanov <eugenis@google.com>,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v2 07/34] mm: clarify __GFP_ZEROTAGS comment
Date:   Mon,  6 Dec 2021 22:43:44 +0100
Message-Id: <a2b2528f6d96fbc6a0c68f16e7212f80f3ef1505.1638825394.git.andreyknvl@google.com>
In-Reply-To: <cover.1638825394.git.andreyknvl@google.com>
References: <cover.1638825394.git.andreyknvl@google.com>
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


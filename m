Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B73D481FB4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 20:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241903AbhL3TPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 14:15:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240258AbhL3TPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 14:15:47 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8568C061401
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 11:15:46 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1640891745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ADPuMcEd3Xni1DgUQrhnIN4hiRS8YivzP0ls/GzEPcc=;
        b=KoP5wR6ShGuSJ9zhobBOcmfKNNfTYsPHM70XlRbAV+2MjI744gw9S28wYM+L4VofAPKyNK
        +I3Q6dRVPQizguUqysqb0ISlCiUDlWeCTVQkPEQGfyxK6XuazqqZ4CqpqiAfsGCeMUsjpj
        WXHZK0vsu0CbUsdi4IViISrbchE7OpE=
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
Subject: [PATCH mm v5 27/39] kasan, mm: only define ___GFP_SKIP_KASAN_POISON with HW_TAGS
Date:   Thu, 30 Dec 2021 20:14:52 +0100
Message-Id: <715abda1793c68cc49c833876b6ca993fd2535f9.1640891329.git.andreyknvl@google.com>
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

Only define the ___GFP_SKIP_KASAN_POISON flag when CONFIG_KASAN_HW_TAGS
is enabled.

This patch it not useful by itself, but it prepares the code for
additions of new KASAN-specific GFP patches.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

---

Changes v3->v4:
- This is a new patch.
---
 include/linux/gfp.h            |  8 +++++++-
 include/trace/events/mmflags.h | 12 +++++++++---
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 19e55f3fdd04..9dce456d147a 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -54,7 +54,11 @@ struct vm_area_struct;
 #define ___GFP_THISNODE		0x200000u
 #define ___GFP_ACCOUNT		0x400000u
 #define ___GFP_ZEROTAGS		0x800000u
+#ifdef CONFIG_KASAN_HW_TAGS
 #define ___GFP_SKIP_KASAN_POISON	0x1000000u
+#else
+#define ___GFP_SKIP_KASAN_POISON	0
+#endif
 #ifdef CONFIG_LOCKDEP
 #define ___GFP_NOLOCKDEP	0x2000000u
 #else
@@ -247,7 +251,9 @@ struct vm_area_struct;
 #define __GFP_NOLOCKDEP ((__force gfp_t)___GFP_NOLOCKDEP)
 
 /* Room for N __GFP_FOO bits */
-#define __GFP_BITS_SHIFT (25 + IS_ENABLED(CONFIG_LOCKDEP))
+#define __GFP_BITS_SHIFT (24 +					\
+			  IS_ENABLED(CONFIG_KASAN_HW_TAGS) +	\
+			  IS_ENABLED(CONFIG_LOCKDEP))
 #define __GFP_BITS_MASK ((__force gfp_t)((1 << __GFP_BITS_SHIFT) - 1))
 
 /**
diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index 30f492256b8c..414bf4367283 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -48,12 +48,18 @@
 	{(unsigned long)__GFP_RECLAIM,		"__GFP_RECLAIM"},	\
 	{(unsigned long)__GFP_DIRECT_RECLAIM,	"__GFP_DIRECT_RECLAIM"},\
 	{(unsigned long)__GFP_KSWAPD_RECLAIM,	"__GFP_KSWAPD_RECLAIM"},\
-	{(unsigned long)__GFP_ZEROTAGS,		"__GFP_ZEROTAGS"},	\
-	{(unsigned long)__GFP_SKIP_KASAN_POISON,"__GFP_SKIP_KASAN_POISON"}\
+	{(unsigned long)__GFP_ZEROTAGS,		"__GFP_ZEROTAGS"}	\
+
+#ifdef CONFIG_KASAN_HW_TAGS
+#define __def_gfpflag_names_kasan					      \
+	, {(unsigned long)__GFP_SKIP_KASAN_POISON, "__GFP_SKIP_KASAN_POISON"}
+#else
+#define __def_gfpflag_names_kasan
+#endif
 
 #define show_gfp_flags(flags)						\
 	(flags) ? __print_flags(flags, "|",				\
-	__def_gfpflag_names						\
+	__def_gfpflag_names __def_gfpflag_names_kasan			\
 	) : "none"
 
 #ifdef CONFIG_MMU
-- 
2.25.1


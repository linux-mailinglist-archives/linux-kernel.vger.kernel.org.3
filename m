Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2435046AAE5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 22:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353623AbhLFVug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 16:50:36 -0500
Received: from out2.migadu.com ([188.165.223.204]:65010 "EHLO out2.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238802AbhLFVu1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 16:50:27 -0500
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1638827217;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H+x4/GNYyuJ4olLesp51NHArgpf+Wp1NvuW2iXEozGc=;
        b=mAzNzcsSBYCdZLIQLvxhgKJyEv+94RCDE0NW/I8ThfTBTWQcoPwEV4ejLqmoraovWDrHXN
        QG4PRjKrnYOllVYAWn2+ezBBymFuz/h/YuzxEU5k0u0tprs2rmuL+VOuSYpfyXGkYHvRzF
        Vn3XzrJp1oVgI+s0T6UvX/AGAQAemqk=
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
Subject: [PATCH v2 30/34] kasan: simplify kasan_init_hw_tags
Date:   Mon,  6 Dec 2021 22:44:07 +0100
Message-Id: <1de4bcc3b3f7da3574a2e8e3f6dab48f47aa03b5.1638825394.git.andreyknvl@google.com>
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

Simplify kasan_init_hw_tags():

- Remove excessive comments in kasan_arg_mode switch.
- Combine DEFAULT and ON cases in kasan_arg_stacktrace switch.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

---

Changes v1->v2:
- Add this patch.
---
 mm/kasan/hw_tags.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
index 983ae15ed4f0..e12f2d195cc9 100644
--- a/mm/kasan/hw_tags.c
+++ b/mm/kasan/hw_tags.c
@@ -159,20 +159,15 @@ void __init kasan_init_hw_tags(void)
 
 	switch (kasan_arg_mode) {
 	case KASAN_ARG_MODE_DEFAULT:
-		/*
-		 * Default to sync mode.
-		 */
+		/* Default to sync mode. */
 		fallthrough;
 	case KASAN_ARG_MODE_SYNC:
-		/* Sync mode enabled. */
 		kasan_mode = KASAN_MODE_SYNC;
 		break;
 	case KASAN_ARG_MODE_ASYNC:
-		/* Async mode enabled. */
 		kasan_mode = KASAN_MODE_ASYNC;
 		break;
 	case KASAN_ARG_MODE_ASYMM:
-		/* Asymm mode enabled. */
 		kasan_mode = KASAN_MODE_ASYMM;
 		break;
 	}
@@ -180,14 +175,13 @@ void __init kasan_init_hw_tags(void)
 	switch (kasan_arg_stacktrace) {
 	case KASAN_ARG_STACKTRACE_DEFAULT:
 		/* Default to enabling stack trace collection. */
+		fallthrough;
+	case KASAN_ARG_STACKTRACE_ON:
 		static_branch_enable(&kasan_flag_stacktrace);
 		break;
 	case KASAN_ARG_STACKTRACE_OFF:
 		/* Do nothing, kasan_flag_stacktrace keeps its default value. */
 		break;
-	case KASAN_ARG_STACKTRACE_ON:
-		static_branch_enable(&kasan_flag_stacktrace);
-		break;
 	}
 
 	pr_info("KernelAddressSanitizer initialized (hw-tags, mode=%s, stacktrace=%s)\n",
-- 
2.25.1


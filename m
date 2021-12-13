Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF4D473709
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 22:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243362AbhLMVzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 16:55:43 -0500
Received: from out0.migadu.com ([94.23.1.103]:20397 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233924AbhLMVzn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 16:55:43 -0500
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1639432542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kHZOj5WZAaymd3SINeiupzKAuzG4dvu/muRorIs4Zec=;
        b=n8IiezgrzN8zdTtIMuJrNXQ/ymRm8PgEfng+OeLdiDaaaCB0RJOQw4qGL0VEQWrTc4LMpA
        BvARbDU4ohnR+GLRMKL6Rarr2sJmXUBhhe2b54sVZxC88N55B7OilLOVtEPXgaZx9FjmUC
        QyuYlb3t4Dqm0VX6iEOv43wEP/wcmAQ=
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
Subject: [PATCH mm v3 33/38] kasan: simplify kasan_init_hw_tags
Date:   Mon, 13 Dec 2021 22:55:35 +0100
Message-Id: <8c59009047ebbb0a8ba3d8c30e2c4fe820fb0c78.1639432170.git.andreyknvl@google.com>
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
index fb08fe1a3cf7..6f7ed8e3180c 100644
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


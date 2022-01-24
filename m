Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4D249843D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 17:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243410AbiAXQH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 11:07:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236170AbiAXQHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 11:07:55 -0500
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96222C06173B
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 08:07:54 -0800 (PST)
Received: by mail-ed1-x54a.google.com with SMTP id c8-20020a05640227c800b003fdc1684cdeso13398654ede.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 08:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=+AGye14zUPVTO5AZFKONKRmJ1sfYnaX/7sKikyozmko=;
        b=QXGUwCgt1+kK6OcCemwNcuv0PgKoZWFn89I0RX5BwEJuTdfddVOpxolfDA5VFaGqL6
         0t7BgDpLEYhLPYW7RjPwR5Bq2kbBosjG3F59mLqDhJ8ia0gHXxs04LrPE7EcjtFhzADK
         dERxkYpDjulnwu8zDxveSCd7o6LJJKAwwFJU5TVJGKrcigJHP6vrT57tWvOjNz5/xN9T
         N3/Oug4u8oKXb9t46GjNrrv86zIRqhnzyiCeNZ1XjZrDzhTW6ww0YZBdbmXMUNgKJsd5
         nFvnoyQDIhL19F9vA/FzzHLT6pMAvGkepr+EJgtg+5Uvhy5g+Gjy39wGGAmwR5cqLo07
         ++9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=+AGye14zUPVTO5AZFKONKRmJ1sfYnaX/7sKikyozmko=;
        b=jtzHxRKZCz+3dlqG6E7Xz8KWt3rKQHGl8NoKV00m5KoBjAANq3yR4Hf2uUMnbhZb15
         sUlIH8PxqbazE/UpWD3T0lrErAZ+VRu3Hjb5eM0CeCzcBbju8qDnPZHFRDokXgnHzT7I
         5ujwwfwWdJfDTnqg16QIkTvDm3Cd9QcGqes5fWGxl7ZXh7Qi0Yyb5T9j9kTpMOehh9pN
         YFe1IZMs13CRY4DWqKvBNKt0n4PwcCrsjx7YM7m52UjDPY9hmThtvFvAj/YCO+8EPo8D
         GjnlPRhepBcnY00zfOaoaTOLi+1jiMYVtku6IN/d2HeCY4bGwBVRwG4TykrSYLZmiUB2
         y3Ag==
X-Gm-Message-State: AOAM530MZgr7q7miOF044kMKgdBeA7h2zmt4UlrNWM8f4+sDXqvK0hTY
        ErEyP+k9lZeH9BdreD51tkwlkTneLg==
X-Google-Smtp-Source: ABdhPJw5GaRdp0oIWma4V0SyalPQKMjbqS0Pow6hsewfsqFxweHT8lqeOWm/2zbmbFE/HF62wEOQldin5A==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:88a9:37db:5c27:10e])
 (user=elver job=sendgmr) by 2002:a17:906:150c:: with SMTP id
 b12mr12577805ejd.284.1643040472427; Mon, 24 Jan 2022 08:07:52 -0800 (PST)
Date:   Mon, 24 Jan 2022 17:07:44 +0100
Message-Id: <20220124160744.1244685-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
Subject: [PATCH] kasan: test: fix compatibility with FORTIFY_SOURCE
From:   Marco Elver <elver@google.com>
To:     elver@google.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Kees Cook <keescook@chromium.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-hardening@vger.kernel.org, Nico Pache <npache@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_FORTIFY_SOURCE enabled, string functions will also perform
dynamic checks using __builtin_object_size(ptr), which when failed will
panic the kernel.

Because the KASAN test deliberately performs out-of-bounds operations,
the kernel panics with FORITY_SOURCE, for example:

 | kernel BUG at lib/string_helpers.c:910!
 | invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
 | CPU: 1 PID: 137 Comm: kunit_try_catch Tainted: G    B             5.16.0-rc3+ #3
 | Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
 | RIP: 0010:fortify_panic+0x19/0x1b
 | ...
 | Call Trace:
 |  <TASK>
 |  kmalloc_oob_in_memset.cold+0x16/0x16
 |  ...

Fix it by also hiding `ptr` from the optimizer, which will ensure that
__builtin_object_size() does not return a valid size, preventing
fortified string functions from panicking.

Reported-by: Nico Pache <npache@redhat.com>
Signed-off-by: Marco Elver <elver@google.com>
---
 lib/test_kasan.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index 847cdbefab46..26a5c9007653 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -492,6 +492,7 @@ static void kmalloc_oob_in_memset(struct kunit *test)
 	ptr = kmalloc(size, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
 
+	OPTIMIZER_HIDE_VAR(ptr);
 	OPTIMIZER_HIDE_VAR(size);
 	KUNIT_EXPECT_KASAN_FAIL(test,
 				memset(ptr, 0, size + KASAN_GRANULE_SIZE));
@@ -515,6 +516,7 @@ static void kmalloc_memmove_negative_size(struct kunit *test)
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
 
 	memset((char *)ptr, 0, 64);
+	OPTIMIZER_HIDE_VAR(ptr);
 	OPTIMIZER_HIDE_VAR(invalid_size);
 	KUNIT_EXPECT_KASAN_FAIL(test,
 		memmove((char *)ptr, (char *)ptr + 4, invalid_size));
@@ -531,6 +533,7 @@ static void kmalloc_memmove_invalid_size(struct kunit *test)
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
 
 	memset((char *)ptr, 0, 64);
+	OPTIMIZER_HIDE_VAR(ptr);
 	KUNIT_EXPECT_KASAN_FAIL(test,
 		memmove((char *)ptr, (char *)ptr + 4, invalid_size));
 	kfree(ptr);
@@ -893,6 +896,7 @@ static void kasan_memchr(struct kunit *test)
 	ptr = kmalloc(size, GFP_KERNEL | __GFP_ZERO);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
 
+	OPTIMIZER_HIDE_VAR(ptr);
 	OPTIMIZER_HIDE_VAR(size);
 	KUNIT_EXPECT_KASAN_FAIL(test,
 		kasan_ptr_result = memchr(ptr, '1', size + 1));
@@ -919,6 +923,7 @@ static void kasan_memcmp(struct kunit *test)
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
 	memset(arr, 0, sizeof(arr));
 
+	OPTIMIZER_HIDE_VAR(ptr);
 	OPTIMIZER_HIDE_VAR(size);
 	KUNIT_EXPECT_KASAN_FAIL(test,
 		kasan_int_result = memcmp(ptr, arr, size+1));
-- 
2.35.0.rc0.227.g00780c9af4-goog


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E21F510419
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 18:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353167AbiDZQsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 12:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353096AbiDZQru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 12:47:50 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413421906BA
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 09:44:42 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id sa27-20020a1709076d1b00b006e8b357a2e7so9325546ejc.14
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 09:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/0H5A8X92xIp0p19j3P2M66qBbmfiGtveehlyZCJw24=;
        b=FvkMkIGRscjUzYZMvLVFQr9H/QRVOHYZw4hHknosvP6NOZtQxpNsZd0RtzhJXelcRc
         z988hAfskDDmoJnPIiI0jXNGvUulB8rFxBfA8ab5Sms91LUTaW4M13z8UFY9KvIBTi0U
         mydviyOj8aDprvPJfYeUMhjCpbeC8rH4hZxCn8OWbU3YolhExGVHn2JyusklOjF/6sO4
         vYyxMokIMpAW+3L8FTBFk9+HgjrICCnt0AsWcRVYbtUA2ELiqXnXSxBNwEJZcwS3tI4o
         91Z59BTGhx3wH4FUgP2JaAvwZ5iQeqRkzHHrNtLbtKEtxaZ4rzTmakhpwXtIFjy1dzme
         JxoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/0H5A8X92xIp0p19j3P2M66qBbmfiGtveehlyZCJw24=;
        b=7O25rQT98YP6Rxfu6TYJ6A1FB8UfRV7Oyid2sXuGOD6Wotfeixo4ApuDuuXgj68RmA
         8yGQpWWwbZ7C1APPKbAwjKcSAdbKI5HeOaUZUCow+Ey3jiy2A9EpikrMxeoO76NXaTQv
         38ICYtPlz5EGIrqwId1wkecn24sByGGJcPksuLAT5z7VtF29KHdFPo0ARaOLNcDMGSvQ
         5XUMy8V3JTkmXXXkE+tcVVxRkXBZTgVM4E9EhWFVB5oA9YXYj1x/9j7h/YgobpcJotwU
         t1gD5VIBJxMmVSqwtqGVoncRP3vl+LdIws2H/5XWu+aCJ7V7tcJUzxdqBzqaenFIqLaM
         LLow==
X-Gm-Message-State: AOAM533jfSUs8XgY7MlSR4sH+JRKLSoo3RmP4PpQEvtdG3F/yaUdxTLU
        DGicIRsF2feT7k09NrSQUkwccV84V3s=
X-Google-Smtp-Source: ABdhPJyznSX2i8WSeLQTTkki2cbZTho3ac9KkIH//+BcoF3wC20oGterW7mlNzbNsl8P2+ms/2tHQUoo1l8=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:d580:abeb:bf6d:5726])
 (user=glider job=sendgmr) by 2002:aa7:d310:0:b0:425:f22f:763f with SMTP id
 p16-20020aa7d310000000b00425f22f763fmr9236955edq.163.1650991480781; Tue, 26
 Apr 2022 09:44:40 -0700 (PDT)
Date:   Tue, 26 Apr 2022 18:42:37 +0200
In-Reply-To: <20220426164315.625149-1-glider@google.com>
Message-Id: <20220426164315.625149-9-glider@google.com>
Mime-Version: 1.0
References: <20220426164315.625149-1-glider@google.com>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH v3 08/46] kmsan: introduce __no_sanitize_memory and __no_kmsan_checks
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__no_sanitize_memory is a function attribute that instructs KMSAN to
skip a function during instrumentation. This is needed to e.g. implement
the noinstr functions.

__no_kmsan_checks is a function attribute that makes KMSAN
ignore the uninitialized values coming from the function's
inputs, and initialize the function's outputs.

Functions marked with this attribute can't be inlined into functions
not marked with it, and vice versa. This behavior is overridden by
__always_inline.

__SANITIZE_MEMORY__ is a macro that's defined iff the file is
instrumented with KMSAN. This is not the same as CONFIG_KMSAN, which is
defined for every file.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
Link: https://linux-review.googlesource.com/id/I004ff0360c918d3cd8b18767ddd1381c6d3281be
---
 include/linux/compiler-clang.h | 23 +++++++++++++++++++++++
 include/linux/compiler-gcc.h   |  6 ++++++
 2 files changed, 29 insertions(+)

diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index babb1347148c5..c561064921449 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -51,6 +51,29 @@
 #define __no_sanitize_undefined
 #endif
 
+#if __has_feature(memory_sanitizer)
+#define __SANITIZE_MEMORY__
+/*
+ * Unlike other sanitizers, KMSAN still inserts code into functions marked with
+ * no_sanitize("kernel-memory"). Using disable_sanitizer_instrumentation
+ * provides the behavior consistent with other __no_sanitize_ attributes,
+ * guaranteeing that __no_sanitize_memory functions remain uninstrumented.
+ */
+#define __no_sanitize_memory __disable_sanitizer_instrumentation
+
+/*
+ * The __no_kmsan_checks attribute ensures that a function does not produce
+ * false positive reports by:
+ *  - initializing all local variables and memory stores in this function;
+ *  - skipping all shadow checks;
+ *  - passing initialized arguments to this function's callees.
+ */
+#define __no_kmsan_checks __attribute__((no_sanitize("kernel-memory")))
+#else
+#define __no_sanitize_memory
+#define __no_kmsan_checks
+#endif
+
 /*
  * Support for __has_feature(coverage_sanitizer) was added in Clang 13 together
  * with no_sanitize("coverage"). Prior versions of Clang support coverage
diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 52299c957c98e..f1a7ce3f6e6fd 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -133,6 +133,12 @@
 #define __SANITIZE_ADDRESS__
 #endif
 
+/*
+ * GCC does not support KMSAN.
+ */
+#define __no_sanitize_memory
+#define __no_kmsan_checks
+
 /*
  * Turn individual warnings and errors on and off locally, depending
  * on version.
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog


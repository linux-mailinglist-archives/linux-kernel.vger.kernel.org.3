Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D145A2AAB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 17:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245212AbiHZPJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 11:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244402AbiHZPJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 11:09:02 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33123DD4E6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 08:08:34 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id gt9-20020a1709072d8900b0073d82402ea6so731360ejc.21
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 08:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=c5NepUxkZ67sJe7jHUeDkh2lejA2rZ0n/lgzGJfAW+w=;
        b=c+6A8OMgE+PXXvaKjkvUnzf0Zny9FaGQw3ITZ0eOqhvk/xJ6RvxfKh+stOxXyatXl4
         YGr0F0FGxuPcv8CUWTObk59qFjdxmNbRa0oHquDksvKKfT8Zu2vHF6G0vca6kOpAbhNI
         OVOEZTiTMx/xUIeNXpsat3eCswFWmSuMpYNt42aS00HKw95twaAXWDw2g1FqoKpczn16
         IuVC8oufvBy3n96QICaiFTQbEIjqBDPQxH/4XN690eGkbiZ3y/ft7KJ0uT7Yb+5MevGJ
         DRahR3sL+vhkXEP7eUoI9WqyhhSukcLsMWy7BqvewYy5XGfr72OPIP7WRVR5q3FgsYZn
         IVMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=c5NepUxkZ67sJe7jHUeDkh2lejA2rZ0n/lgzGJfAW+w=;
        b=WeHv4rZuqj6WBSof5IVNxUbmNXUk+QYYI9HepB/Ve85/EpteGbNocaWA6VuNH2eTb3
         5phi7rmCUFRVGyP6w5uFdpYHtRQH1z5DR6FpTh4NdCBpRD34HJHbTkGSTO8qDpDtN2fP
         rVI7Vq8hRLaIfQxrd6DyqrBbhxzh61cS2BWNqfPD+q8CSvGoC8oC9y/jYVit91+IG1Sq
         O7pKNvSAv1+6JIDkVZphRGWDpUlmCyFuZwRHR+CeVJGr7JePlnYCs7S3eX0XGAQh8jXZ
         5lFF5MTT56P9pEuqzHDbWXabMt1ujyUVkppdh1T6N5aTRqjhp1weZJxy67Jm9+IVZ/vV
         vdKg==
X-Gm-Message-State: ACgBeo0PCmpDnRDxnAYSPHBg1x8Cdy6MJ5nHwV7s5Vf52LwrCLMCWMqb
        PkYFuL7bkoxywI0jbfLuUh5QE6IqoNg=
X-Google-Smtp-Source: AA6agR5ehbhUugsFXAPBIbmUJl2ccI1z6E6toZVNB9pK3XsABZI5EGu5QKmG8MsBqiQScrt+e+ok3n5vJiE=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:5207:ac36:fdd3:502d])
 (user=glider job=sendgmr) by 2002:a05:6402:515:b0:447:780c:39d6 with SMTP id
 m21-20020a056402051500b00447780c39d6mr7244136edv.265.1661526512626; Fri, 26
 Aug 2022 08:08:32 -0700 (PDT)
Date:   Fri, 26 Aug 2022 17:07:30 +0200
In-Reply-To: <20220826150807.723137-1-glider@google.com>
Mime-Version: 1.0
References: <20220826150807.723137-1-glider@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220826150807.723137-8-glider@google.com>
Subject: [PATCH v5 07/44] kmsan: introduce __no_sanitize_memory and __no_kmsan_checks
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexei Starovoitov <ast@kernel.org>,
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
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
Reviewed-by: Marco Elver <elver@google.com>

---
Link: https://linux-review.googlesource.com/id/I004ff0360c918d3cd8b18767ddd1381c6d3281be
---
 include/linux/compiler-clang.h | 23 +++++++++++++++++++++++
 include/linux/compiler-gcc.h   |  6 ++++++
 2 files changed, 29 insertions(+)

diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index c84fec767445d..4fa0cc4cbd2c8 100644
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
index 9b157b71036f1..f55a37efdb974 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -114,6 +114,12 @@
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
2.37.2.672.g94769d06f0-goog


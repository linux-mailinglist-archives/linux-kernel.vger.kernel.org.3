Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC8147479C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 17:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235728AbhLNQWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 11:22:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235693AbhLNQWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 11:22:15 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21AA4C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 08:22:14 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id a85-20020a1c7f58000000b0033ddc0eacc8so13388428wmd.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 08:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cymMxq8X/aG1qXHBjowqDi5l9Htb+dr7152LeU2UVMg=;
        b=WncnmFGwOheZzwj3lQVcaMmEmmbs5r8KC0pxfY3vrRTBhm0vWTPYKdVu6SuZ/lDOBN
         oo427lD+CO6vG97uePW3RveiP+oSrjPgOcLUHNljqIMlZPHOKZe7Wj7tBoNAQPMrJnw9
         KqsuI9B2HZpdTFGR3B2S/hdL6j5LLLVSPvTeuYQUCkYfd+NAADNU+fpr+TNZrqrtAlV7
         QDZ46XIqfqYP04Vuo8iPBydPbj1h6rshvISKhDAfitvyrcjxJn9MZ3oJv/1vX4zzE4EC
         u3rDgbQW+Ttcm2Fx7+ojv/HG7vMx3ZVQtjNbFbOEeX3tMT77CgmULH5SI48+r9l6CPCB
         GRzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cymMxq8X/aG1qXHBjowqDi5l9Htb+dr7152LeU2UVMg=;
        b=p6uomHZWAYV7tlw8tIoB7ZEqnnHuQUnHHy9Sz0YSSRNxhl3jSWgI6ibZtYamui3pew
         /YuZf3Q+tJ4YGt1Ty/FPJpX33mz9g/LPSI4MlaR2YSEIBXY5wnSsLc0Snya69q9bdoVH
         4dJlxNVZQ/pgI6naN6CxQ6eirQ0vfBNx72tOOlk83INfO+K2yYg14Trp2tjGvFbDuBrz
         kD3R2hBbQqoM1fIHX5GTLbLWj5tJcQ4+FlSbJPBacfkaRGOUtdEsiCi1JHBdMZAQ1cMI
         OTCcvrmEHGBDb6lthSWx39lo+Si2SkBKRMMDNfwp5c53dZa6rqYvL5t3nVCVyzLKIe2j
         WLcA==
X-Gm-Message-State: AOAM530wRDpkhhzzd9Agsv4ZuIzKezkLLGKLwFFxZmBSqw2bZrsmCria
        zGGQJ2dvSpBtxF4ZujE/L+2o336whzo=
X-Google-Smtp-Source: ABdhPJw7rnlyWmyiG+/6/FPFfhBexKn+2IQc1y0wrMK33WZwdvgtnE0Ywc99AkwQL+Q5SKgG2g6TjGgsUOs=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:357e:2b9d:5b13:a652])
 (user=glider job=sendgmr) by 2002:a5d:522b:: with SMTP id i11mr14310wra.2.1639498932629;
 Tue, 14 Dec 2021 08:22:12 -0800 (PST)
Date:   Tue, 14 Dec 2021 17:20:14 +0100
In-Reply-To: <20211214162050.660953-1-glider@google.com>
Message-Id: <20211214162050.660953-8-glider@google.com>
Mime-Version: 1.0
References: <20211214162050.660953-1-glider@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH 07/43] compiler_attributes.h: add __disable_sanitizer_instrumentation
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
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
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new attribute maps to
__attribute__((disable_sanitizer_instrumentation)), which will be
supported by Clang >= 14.0. Future support in GCC is also possible.

This attribute disables compiler instrumentation for kernel sanitizer
tools, making it easier to implement noinstr. It is different from the
existing __no_sanitize* attributes, which may still allow certain types
of instrumentation to prevent false positives.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
Link: https://linux-review.googlesource.com/id/Ic0123ce99b33ab7d5ed1ae90593425be8d3d774a
---
 include/linux/compiler_attributes.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
index b9121afd87331..37e2600202216 100644
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -308,6 +308,24 @@
 # define __compiletime_warning(msg)
 #endif
 
+/*
+ * Optional: only supported since clang >= 14.0
+ *
+ * clang: https://clang.llvm.org/docs/AttributeReference.html#disable-sanitizer-instrumentation
+ *
+ * disable_sanitizer_instrumentation is not always similar to
+ * no_sanitize((<sanitizer-name>)): the latter may still let specific sanitizers
+ * insert code into functions to prevent false positives. Unlike that,
+ * disable_sanitizer_instrumentation prevents all kinds of instrumentation to
+ * functions with the attribute.
+ */
+#if __has_attribute(disable_sanitizer_instrumentation)
+# define __disable_sanitizer_instrumentation \
+	 __attribute__((disable_sanitizer_instrumentation))
+#else
+# define __disable_sanitizer_instrumentation
+#endif
+
 /*
  *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-weak-function-attribute
  *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#index-weak-variable-attribute
-- 
2.34.1.173.g76aa8bc2d0-goog


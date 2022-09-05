Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1826C5AD280
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 14:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237628AbiIEMZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 08:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237347AbiIEMZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 08:25:13 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFF61C92D
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 05:25:12 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id f14-20020a0564021e8e00b00448da245f25so5685627edf.18
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 05:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=fFq4uMFAQOrpNZLU6ydmQ4L19fVmnSZ8zUbgI7i1GQ4=;
        b=cCxag6KhRzMmnFVgfur/MISL9l4M5Ts+EjiLMP524JfvXCm4VLcLN7LzmXBjiZcaXb
         tlmiubyC93h17zTr+LO/dsylFcdxii7RwDPGn7qVnv6xTfjMkw0Cmoc7esbeBQP5TY9I
         YMNzkKVgI5RiZP85BOt8+Kx6fVfZgqQPOft+QNgQuRzLtUpRoXrN0PbcsG9nX9970XBG
         IBzqQiigJF2SIPyYv8PSiIFJrlq4x8iKcxDedH268UB7rpLHat8Rs+Z89FEg2QhX2aCA
         UNpAZdA9qSiszdY2MHTipaEnHXo6YveoRZNUVH6fz9F+WSwEd/H/4G01oo+H2EC8PkLV
         j68A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=fFq4uMFAQOrpNZLU6ydmQ4L19fVmnSZ8zUbgI7i1GQ4=;
        b=6DOfEpYNosuP9hqNw7bKwk84RrPeBGxBdEAL9ApNMjQO+9+axAQVT2s5dWz/yla4LC
         HMnnJBBSJvmAMABgZjrTmx+VaHOGv9p1iYjGAnVa56b0ocK4R1j5fhzlhnUQxAY5sj8V
         t6Pt8DtvKV7uetF/94CwgJe0l/UDvrZJBZiYJHL7LxOg8ofb7oNwTUo42SPF7ly2uVGz
         qzHOb9QwV6e67AN6+TrnRi4RJv61C03XYh2RIlZn7EVAhWZ6tYTVhiw+dZj7en1m3XXM
         qJFd5FeOcnRNkcO0vF/VVEMQSTVTidscdan5lrkgRh8UFZp+tkR6N0g2uvVzVHl2c/5c
         vfNQ==
X-Gm-Message-State: ACgBeo061+RNAbq9s5jDpPYXnJmJOANqKO+hq5N2KSBKftUwE1dBUV6k
        kUScRCgBmtQDwATQ1E3ZwJeQOLlQOBE=
X-Google-Smtp-Source: AA6agR6U2run9tld0JOCd4AYP6RzPopWiBDxZtk42V7MPQ3Pjs2lgYt8aiDTWOU8Ssa/Mvqp6YaAqq5ka0Y=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:b808:8d07:ab4a:554c])
 (user=glider job=sendgmr) by 2002:a17:907:2c5b:b0:741:6b8f:d3ab with SMTP id
 hf27-20020a1709072c5b00b007416b8fd3abmr26797162ejc.447.1662380710753; Mon, 05
 Sep 2022 05:25:10 -0700 (PDT)
Date:   Mon,  5 Sep 2022 14:24:13 +0200
In-Reply-To: <20220905122452.2258262-1-glider@google.com>
Mime-Version: 1.0
References: <20220905122452.2258262-1-glider@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220905122452.2258262-6-glider@google.com>
Subject: [PATCH v6 05/44] asm-generic: instrument usercopy in cacheflush.h
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

Notify memory tools about usercopy events in copy_to_user_page() and
copy_from_user_page().

Signed-off-by: Alexander Potapenko <glider@google.com>
Reviewed-by: Marco Elver <elver@google.com>

---
v5:
 -- cast user pointers to `void __user *`

Link: https://linux-review.googlesource.com/id/Ic1ee8da1886325f46ad67f52176f48c2c836c48f
---
 include/asm-generic/cacheflush.h | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/cacheflush.h b/include/asm-generic/cacheflush.h
index 4f07afacbc239..f46258d1a080f 100644
--- a/include/asm-generic/cacheflush.h
+++ b/include/asm-generic/cacheflush.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_GENERIC_CACHEFLUSH_H
 #define _ASM_GENERIC_CACHEFLUSH_H
 
+#include <linux/instrumented.h>
+
 struct mm_struct;
 struct vm_area_struct;
 struct page;
@@ -105,14 +107,22 @@ static inline void flush_cache_vunmap(unsigned long start, unsigned long end)
 #ifndef copy_to_user_page
 #define copy_to_user_page(vma, page, vaddr, dst, src, len)	\
 	do { \
+		instrument_copy_to_user((void __user *)dst, src, len); \
 		memcpy(dst, src, len); \
 		flush_icache_user_page(vma, page, vaddr, len); \
 	} while (0)
 #endif
 
+
 #ifndef copy_from_user_page
-#define copy_from_user_page(vma, page, vaddr, dst, src, len) \
-	memcpy(dst, src, len)
+#define copy_from_user_page(vma, page, vaddr, dst, src, len)		  \
+	do {								  \
+		instrument_copy_from_user_before(dst, (void __user *)src, \
+						 len);			  \
+		memcpy(dst, src, len);					  \
+		instrument_copy_from_user_after(dst, (void __user *)src, len, \
+						0);			  \
+	} while (0)
 #endif
 
 #endif /* _ASM_GENERIC_CACHEFLUSH_H */
-- 
2.37.2.789.g6183377224-goog


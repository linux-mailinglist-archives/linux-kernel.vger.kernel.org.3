Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2F9B5AD2D6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 14:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238164AbiIEMc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 08:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237813AbiIEMa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 08:30:29 -0400
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102702317C
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 05:26:39 -0700 (PDT)
Received: by mail-ej1-x64a.google.com with SMTP id hp14-20020a1709073e0e00b00741a2093c4aso2312207ejc.20
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 05:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=yflFKH40jmwCCGQluWMEQ//gU/gWIMkmRe3xdXByGVQ=;
        b=fAxph5Y6U04CXZrajhFkL+LMhlfmAqX1mOptfFGFa+34F1+59OCoqL+hyS00yE9PU3
         JiQF8Q7PP63alm8LFCcaO0ZZHzZ5WxGFto4GmMcgZr9o9k0lEZRIQVzzKRElWx4oA9Ez
         7ZjbmW+o8zPS23NFbXCbrLPnQaO1lqjWBLYh2MePrjtDiEAPdC3lrLsuRUbPOH3mzVEQ
         PgdyG8vgJN4Qnre4Ot1waLJj7+TH2C6/GbnJwovqjOPhmu9jof0uYhctQHZkHtEoZesE
         L4Z7jgUgDUS3X3M2bfaQgTzxuHr1pPSXpKXdHYlPC0r3legvJZAdTPNLBXX4Lymsq/aN
         mAFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=yflFKH40jmwCCGQluWMEQ//gU/gWIMkmRe3xdXByGVQ=;
        b=pXsHzJvyLxFrFzxJUE4fkUuPU2kU86KsDiO9kgksN83yYLZlhSKOFNkNq5JCezbv8K
         xJ1WxZUTazjEA5QWkbwMjFcJpoBrMXYdIP4cNJIzPrXZVaz9+9P4E1xpsBVxjrEtFFVb
         03Z07IP60faRQur1i1D7cVhntWMR/HTOe+ZFprH2PUm1kxGMmHC5Vhe98cOgyTyLIC7q
         Y1lVDruQjIoCBFRwFquGKsESVr07/5mILP3VKGnaswKbAUBoAZ4iqVW0GHIZRsLgJG11
         EmTeZRZSFvyBhPQQEkRGz3sEOUXFzxYHjmcR0aGxuQjn/NFqp0htildTQV7LRU8wbMTv
         RUmw==
X-Gm-Message-State: ACgBeo02sslZYbZOPAsxQYZByliECOMLwpmggh947OMrzsXkQM7v1Eg/
        pwuKb6/FMDH09vBhqpJEFe5tcEE7Akk=
X-Google-Smtp-Source: AA6agR7p8f0oX7Qv/mGgEi+wXgphK2AAXJizc5KwHHFoVlbMDXfcad2dvQIIPWVBGG5QIQ/9evyI4QEPVGs=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:b808:8d07:ab4a:554c])
 (user=glider job=sendgmr) by 2002:a17:907:2722:b0:731:2aeb:7942 with SMTP id
 d2-20020a170907272200b007312aeb7942mr35645383ejl.734.1662380793723; Mon, 05
 Sep 2022 05:26:33 -0700 (PDT)
Date:   Mon,  5 Sep 2022 14:24:43 +0200
In-Reply-To: <20220905122452.2258262-1-glider@google.com>
Mime-Version: 1.0
References: <20220905122452.2258262-1-glider@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220905122452.2258262-36-glider@google.com>
Subject: [PATCH v6 35/44] x86: kmsan: handle open-coded assembly in lib/iomem.c
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

KMSAN cannot intercept memory accesses within asm() statements.
That's why we add kmsan_unpoison_memory() and kmsan_check_memory() to
hint it how to handle memory copied from/to I/O memory.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
Link: https://linux-review.googlesource.com/id/Icb16bf17269087e475debf07a7fe7d4bebc3df23
---
 arch/x86/lib/iomem.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/lib/iomem.c b/arch/x86/lib/iomem.c
index 3e2f33fc33de2..e0411a3774d49 100644
--- a/arch/x86/lib/iomem.c
+++ b/arch/x86/lib/iomem.c
@@ -1,6 +1,7 @@
 #include <linux/string.h>
 #include <linux/module.h>
 #include <linux/io.h>
+#include <linux/kmsan-checks.h>
 
 #define movs(type,to,from) \
 	asm volatile("movs" type:"=&D" (to), "=&S" (from):"0" (to), "1" (from):"memory")
@@ -37,6 +38,8 @@ static void string_memcpy_fromio(void *to, const volatile void __iomem *from, si
 		n-=2;
 	}
 	rep_movs(to, (const void *)from, n);
+	/* KMSAN must treat values read from devices as initialized. */
+	kmsan_unpoison_memory(to, n);
 }
 
 static void string_memcpy_toio(volatile void __iomem *to, const void *from, size_t n)
@@ -44,6 +47,8 @@ static void string_memcpy_toio(volatile void __iomem *to, const void *from, size
 	if (unlikely(!n))
 		return;
 
+	/* Make sure uninitialized memory isn't copied to devices. */
+	kmsan_check_memory(from, n);
 	/* Align any unaligned destination IO */
 	if (unlikely(1 & (unsigned long)to)) {
 		movs("b", to, from);
-- 
2.37.2.789.g6183377224-goog


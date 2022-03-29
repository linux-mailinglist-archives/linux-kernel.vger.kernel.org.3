Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C384EAD9C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 14:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236718AbiC2Mt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 08:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236831AbiC2MsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 08:48:07 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758BF224749
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 05:42:22 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id gv17-20020a1709072bd100b006dfcc7f7962so8127026ejc.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 05:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6EKMd0bjP1WkGhZZPkjCgU25E3DWfYJCasURW7mFnYs=;
        b=P1k71GssRqu7HsErV73nnblS85PhkUFheLyBFZgmPWLpl7OKiy1Bqi/JlOtZzfJVPy
         VAc7cvO8fwjHIxHwD4P9pVu2rdNH8e0p6iE439JugyKP3tEZpAogt6YoEY/b5rvhs6YN
         OlYMWP+8vwtXjv8eNiLfoejuKaPkdCuMEozoeNlW8PpIb+edtD9db/0+pmWKLdNhwURR
         5E3Lth/p8S4d05TzSLze03fVsfkwrT++EyTKtUjOhLVyC4kbo3lKGGRltm0PtD2GB/IH
         Q3WE4SbVcH6AFhiknkVN5O3R1HMm1J+ZfOcalpdSexIx4dKDpVcT7q34bBD07dT9kvEi
         C7Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6EKMd0bjP1WkGhZZPkjCgU25E3DWfYJCasURW7mFnYs=;
        b=rPJuR5MEzyzLKzKLm81Sz3UQ4ii9YtT0rVjc7jime4/vS1Lc6FS7XfhYjvdMyHp7tG
         8TCrefZGujaFe/KvRe3mpezAoR6uryr6KnnSqR39RujTzZuY1MpDcvxZzxye2PNmZ9JY
         iuMAl24Uay7SlUb4HVLni4aRpltGx+XCCkbnpaA/3EeMpky3gX0OA9t6gghNcdvLrjiL
         pAKSsNZs5e0LoHDoXF9K/HzxB+xGmhSIRTdr3xx+ZswM2Ef5OPXF82KcPSN1J3rVVQR5
         GxMNwm6C0Mbka5uIAxGfeZNA11wFb88LA5oMJXMD13WnQNN508K8dTEXxLhNCyQ1lrsc
         V48g==
X-Gm-Message-State: AOAM531a6mAMO552v74Dz5dQ7/9kSOIQEZ+u0GdiMEGzKeDvfmFjng5p
        nXXgJ4Fh75eV0XTknYf0Qnu1f4XX+GA=
X-Google-Smtp-Source: ABdhPJyN/u61iYoRLkPCDJv7Xs3UegKZjTjkx8b5A87Fx1oaelxWk3uqKnX5mytmcMKvTp7b3Wewv/gEEvA=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:36eb:759:798f:98c3])
 (user=glider job=sendgmr) by 2002:a17:906:3042:b0:6cd:20ed:7c5c with SMTP id
 d2-20020a170906304200b006cd20ed7c5cmr33818169ejd.241.1648557740796; Tue, 29
 Mar 2022 05:42:20 -0700 (PDT)
Date:   Tue, 29 Mar 2022 14:40:11 +0200
In-Reply-To: <20220329124017.737571-1-glider@google.com>
Message-Id: <20220329124017.737571-43-glider@google.com>
Mime-Version: 1.0
References: <20220329124017.737571-1-glider@google.com>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH v2 42/48] x86: kmsan: handle open-coded assembly in lib/iomem.c
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
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
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
index df50451d94ef7..2307770f3f4c8 100644
--- a/arch/x86/lib/iomem.c
+++ b/arch/x86/lib/iomem.c
@@ -1,6 +1,7 @@
 #include <linux/string.h>
 #include <linux/module.h>
 #include <linux/io.h>
+#include <linux/kmsan-checks.h>
 
 #define movs(type,to,from) \
 	asm volatile("movs" type:"=&D" (to), "=&S" (from):"0" (to), "1" (from):"memory")
@@ -37,6 +38,8 @@ void memcpy_fromio(void *to, const volatile void __iomem *from, size_t n)
 		n-=2;
 	}
 	rep_movs(to, (const void *)from, n);
+	/* KMSAN must treat values read from devices as initialized. */
+	kmsan_unpoison_memory(to, n);
 }
 EXPORT_SYMBOL(memcpy_fromio);
 
@@ -45,6 +48,8 @@ void memcpy_toio(volatile void __iomem *to, const void *from, size_t n)
 	if (unlikely(!n))
 		return;
 
+	/* Make sure uninitialized memory isn't copied to devices. */
+	kmsan_check_memory(from, n);
 	/* Align any unaligned destination IO */
 	if (unlikely(1 & (unsigned long)to)) {
 		movs("b", to, from);
-- 
2.35.1.1021.g381101b075-goog


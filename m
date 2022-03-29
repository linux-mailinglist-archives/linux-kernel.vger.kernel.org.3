Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484514EAD79
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 14:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236622AbiC2Moo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 08:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236609AbiC2Mni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 08:43:38 -0400
Received: from mail-lf1-x149.google.com (mail-lf1-x149.google.com [IPv6:2a00:1450:4864:20::149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F103222C6F0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 05:41:30 -0700 (PDT)
Received: by mail-lf1-x149.google.com with SMTP id bq6-20020a056512150600b0044840cccf4bso5250778lfb.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 05:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BAzeUERAw6yLQmtyQnYKjc6/ZWWpRBj0mGa3aEgUqwY=;
        b=ZXTRoZrgutkv7II3RgLRe7BIf7v6I4j8hJJZqYQ4g8PulMF1nWo8ubAU21o9zCo6og
         7XBKKviqr7NMytXoYSl85SE+bb3+8jznUOcFKa7H4EfRJL1oCEVy4UXGzDb0BQ4KlMwY
         EBXkG4Uwv5g0U86kh/wZsWl0ZxVsJugX71jrS1cq2SiiKeYxM2S9e9CzF0yqfyAB7oMi
         T4oGblkIF/ayb7nfMcBDRVAt1sbzaznoywLIxzm1ieHGWctjb5MdaLEykaspo2SdhHvF
         4nzwX4TkXzi+AOfJ+V1Cf2u4NZt6lo6PUhaz3zGGMcsWgjPIXLv2JnNVaViWv1sI8XVk
         WNew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BAzeUERAw6yLQmtyQnYKjc6/ZWWpRBj0mGa3aEgUqwY=;
        b=tN4aIXVmcTTqW8JUnwEZvSWn3metoK8JIt3ySRO73c70gkWWd6GlQqIlEZZe5vdPsq
         9wT+LGY4CkKs8HGFGrqZkOqBSIWVi++xk7lX439tjPS3h8+P5lHfR1ByCrtPMgRLEOlM
         /BU+/ZM7zRlYypMstWiNRojtU1ix0lK0rUsaYMlUHOkxnHfH4kL0yabvDFYUYjipJM41
         C9OLZBzlnTsH1rPX76txOpLmBCNrtw11Ej3pkW1haQDnCcbD5sSxM3LTR2KTPNy6xBSv
         22dJv9/p2fvsXefgWmb49v1HbH+LCbwYO40yDDD1ZmUlhQex15k+tRJ+y23K3yD2oVpC
         b0+Q==
X-Gm-Message-State: AOAM531RnS7E2ovfAh3/G2nBmRjAY/WPlkTGxVc2WYM4f5mr4iYfRTP5
        Ph1faAiTd93sZzoGowEJdeETepaayxw=
X-Google-Smtp-Source: ABdhPJx1CLANrsI9lz+hySXN8o14iMay2HDGrWuM+l9vsgDilsmJEoz0jnKi7yedCbB7BcBmZTRdVovSVm0=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:36eb:759:798f:98c3])
 (user=glider job=sendgmr) by 2002:a19:e05c:0:b0:44a:15b9:68b9 with SMTP id
 g28-20020a19e05c000000b0044a15b968b9mr2466190lfj.575.1648557688677; Tue, 29
 Mar 2022 05:41:28 -0700 (PDT)
Date:   Tue, 29 Mar 2022 14:39:51 +0200
In-Reply-To: <20220329124017.737571-1-glider@google.com>
Message-Id: <20220329124017.737571-23-glider@google.com>
Mime-Version: 1.0
References: <20220329124017.737571-1-glider@google.com>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH v2 22/48] kmsan: unpoison @tlb in arch_tlb_gather_mmu()
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

This is a hack to reduce stackdepot pressure.

struct mmu_gather contains 7 1-bit fields packed into a 32-bit unsigned
int value. The remaining 25 bits remain uninitialized and are never used,
but KMSAN updates the origin for them in zap_pXX_range() in mm/memory.c,
thus creating very long origin chains. This is technically correct, but
consumes too much memory.

Unpoisoning the whole structure will prevent creating such chains.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
Link: https://linux-review.googlesource.com/id/I76abee411b8323acfdbc29bc3a60dca8cff2de77
---
 mm/mmu_gather.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index afb7185ffdc45..2f3821268b311 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -1,6 +1,7 @@
 #include <linux/gfp.h>
 #include <linux/highmem.h>
 #include <linux/kernel.h>
+#include <linux/kmsan-checks.h>
 #include <linux/mmdebug.h>
 #include <linux/mm_types.h>
 #include <linux/mm_inline.h>
@@ -253,6 +254,15 @@ void tlb_flush_mmu(struct mmu_gather *tlb)
 static void __tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm,
 			     bool fullmm)
 {
+	/*
+	 * struct mmu_gather contains 7 1-bit fields packed into a 32-bit
+	 * unsigned int value. The remaining 25 bits remain uninitialized
+	 * and are never used, but KMSAN updates the origin for them in
+	 * zap_pXX_range() in mm/memory.c, thus creating very long origin
+	 * chains. This is technically correct, but consumes too much memory.
+	 * Unpoisoning the whole structure will prevent creating such chains.
+	 */
+	kmsan_unpoison_memory(tlb, sizeof(*tlb));
 	tlb->mm = mm;
 	tlb->fullmm = fullmm;
 
-- 
2.35.1.1021.g381101b075-goog


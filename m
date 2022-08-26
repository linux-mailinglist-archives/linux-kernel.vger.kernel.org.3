Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B16CC5A2AC0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 17:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245678AbiHZPMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 11:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244026AbiHZPKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 11:10:55 -0400
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C499DEB45
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 08:09:12 -0700 (PDT)
Received: by mail-ej1-x64a.google.com with SMTP id sc3-20020a1709078a0300b0073d77f805b3so731691ejc.22
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 08:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=9AAV0khTKYQgqo5/UGS2nmhcIjrHMBeghL7l+ejLApU=;
        b=sDB5PJpJBZJ8zJUYHqSaroGLwunSs5Rwaz9QmpK5RO8+mlf1nYQAGNhjMXl1m0oFZH
         vzMQVlJHXNGU9aieZuBV0ihX2Xs7GeZCanFYLMBLdccTjtufIvPj0/C/g25QTIwI6/Qp
         sReL0ZmVrFu7c6GRkrze5jnIbC0eHcDyF/YHGMdyIlE3tPtruebYgAGRN7/qwGwqWIG0
         d7O6U7dzRkmvp5N9Pl4k3vT+ZH5Z9JXhcKEWunCg7MMWVXl8aGl5D3s28uVHexHgHJDm
         JLeAgRz2XBzUtSevuOYUNl/dsbWhlT4VB5dIjKptqOcveXztv31OO3ARcYOVZyimZv3m
         XuFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=9AAV0khTKYQgqo5/UGS2nmhcIjrHMBeghL7l+ejLApU=;
        b=UiLuob3j4ASArGdGEcE7T22NIztV3iOfpPJfUi5D3u2cuJtM4EmoQmcqJA5dPlREa7
         Yt8h4a/qFXQ6sIRGgt4GSFu6crUUlPao/WhR3PNVDDnqiuj4OY5VDnKvfidhCmnc3+Pu
         kAxGyicjpNK+sM6kAeNo/rYCU78z5RKuAvjcOCwkxynCU/wilWBd7knk4TXUa3YcvdHq
         fW3V4Izfqkc2ANzYzCcl5zlXvx9pbTZjNx/OrBBi7IhYwn+wBTZHVhzfgZCopCuucg0z
         ig1bNE4lyXdk6ShgjQdLrNQeViD80zmOvBHMt3TLZphTGmy0rN9GUQLD0nDxxcc2LbHx
         woSA==
X-Gm-Message-State: ACgBeo2GstpkX5VhMmK+c96G8QMvaUMUk+ujNUav5QBx0DAwlNcMv728
        i6oJl8IPyOFAyGy7Bc2t+HS88g1JW4w=
X-Google-Smtp-Source: AA6agR7OB7JfBU0FR/Gx7VVFS0BYXkDkX/D+5e1f7tZDKGDtu48HBg9ANVBecrhroNJG7bsthdjAB8Rc34M=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:5207:ac36:fdd3:502d])
 (user=glider job=sendgmr) by 2002:a17:906:8a77:b0:73d:deef:8f76 with SMTP id
 hy23-20020a1709068a7700b0073ddeef8f76mr3332086ejc.765.1661526545890; Fri, 26
 Aug 2022 08:09:05 -0700 (PDT)
Date:   Fri, 26 Aug 2022 17:07:42 +0200
In-Reply-To: <20220826150807.723137-1-glider@google.com>
Mime-Version: 1.0
References: <20220826150807.723137-1-glider@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220826150807.723137-20-glider@google.com>
Subject: [PATCH v5 19/44] kmsan: unpoison @tlb in arch_tlb_gather_mmu()
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an optimization to reduce stackdepot pressure.

struct mmu_gather contains 7 1-bit fields packed into a 32-bit unsigned
int value. The remaining 25 bits remain uninitialized and are never used,
but KMSAN updates the origin for them in zap_pXX_range() in mm/memory.c,
thus creating very long origin chains. This is technically correct, but
consumes too much memory.

Unpoisoning the whole structure will prevent creating such chains.

Signed-off-by: Alexander Potapenko <glider@google.com>
Acked-by: Marco Elver <elver@google.com>

---
v5:
 -- updated description as suggested by Marco Elver

Link: https://linux-review.googlesource.com/id/I76abee411b8323acfdbc29bc3a60dca8cff2de77
---
 mm/mmu_gather.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index a71924bd38c0d..add4244e5790d 100644
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
@@ -265,6 +266,15 @@ void tlb_flush_mmu(struct mmu_gather *tlb)
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
2.37.2.672.g94769d06f0-goog


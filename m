Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4945AD2FB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 14:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237853AbiIEM2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 08:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237403AbiIEM1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 08:27:45 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939CA5F218
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 05:25:50 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id r11-20020a05640251cb00b004484ec7e3a4so5724489edd.8
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 05:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=JDbXYbJWwPmgAZI0cqV5N9fdafuEA5LdQ6bM1NbJ2qU=;
        b=FI/NN8FVkqveVSoB6HG4Dkazuf6XYCk/EwCAfidqLj4dNPa0BRhM4P5S4TqXDGIZaI
         qrEKGE+r+7Jt5yWEty94dld142fuFuiBwTfOiFHQUY5nxSHJ+D8ob7Cf47AnhjKOGoR5
         Bklr3XpZrOoyXRce7z6Tw6kGBroRdXW/XXVfP6gsABeJuQtlQH3SmKvkiqAGb4lTB6cD
         7eYPHMVcX5DUnPnmRo4rO7LVehmhKNFjhaZP9RF8f0ksJZ1mSX0p7FROg8hQn24pzOBV
         K93l7+1ykcepxF58K6O1XQpgozdC1Jvz1hxtlrAemelvnVlo8kdLN50VY5GotqXyWFJ4
         nDnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=JDbXYbJWwPmgAZI0cqV5N9fdafuEA5LdQ6bM1NbJ2qU=;
        b=A5/kl9s2slHrggm0kn1JFG9JHZQmSI4+IJDaLANoCswRfyXWbFoK5dvxfGmBF++y9q
         bHEoY99dHbm5MB/xy52jyxVJuhYh3Nk8DxFHrgVqdJoNTZ6lmA3OHZ1BkXeh4qf7XUPl
         HAZeX68mUNcGaOpD+JG071OXvtfY9tdeobScuavuJ9Ywd0jX/fd3tjbQKsX7ii40Woa+
         B9mjfJrOCQ25TEXoSEB0mzbTh3IrFyRc3G/A+wyTBSst/8WF03oFOy+15JSP/stPI39j
         W3d3bG44jH5RWWXH81Dv39H8ZRQVGLj+aaYgggSxURyRCPvpwjcgQA1sZD2AMiII6lIs
         dTbw==
X-Gm-Message-State: ACgBeo0zdWkDgWjezIol8JSXaB2nqzK8PTQ6uawJT6+euX81T/PIan+4
        vZG1WhkhqcHT2FPrF2NsJd1KvRNNTcc=
X-Google-Smtp-Source: AA6agR6EtI+wppo4BmYhDO6R8PujqfTGTJqoZccyFkAtKf4bzdO9HJQ/6nSdJYuTNsjvrOtwDoN6L9AHrrA=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:b808:8d07:ab4a:554c])
 (user=glider job=sendgmr) by 2002:a17:907:7242:b0:741:7cd6:57d5 with SMTP id
 ds2-20020a170907724200b007417cd657d5mr25769275ejc.419.1662380749795; Mon, 05
 Sep 2022 05:25:49 -0700 (PDT)
Date:   Mon,  5 Sep 2022 14:24:27 +0200
In-Reply-To: <20220905122452.2258262-1-glider@google.com>
Mime-Version: 1.0
References: <20220905122452.2258262-1-glider@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220905122452.2258262-20-glider@google.com>
Subject: [PATCH v6 19/44] kmsan: unpoison @tlb in arch_tlb_gather_mmu()
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
2.37.2.789.g6183377224-goog


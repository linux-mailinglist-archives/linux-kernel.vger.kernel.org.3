Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5482C5A2AB8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 17:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245033AbiHZPOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 11:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243853AbiHZPNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 11:13:02 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42ED6DF0BC
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 08:09:38 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id y20-20020a056402359400b00447a871c48fso1248296edc.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 08:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=RpdJ5KT5GAuxqWidUZuS2M2CiPNp+gZwFhAUBa4xHko=;
        b=TJz1UTJBESEdKuAr0m8ClDSUAjamVWg2DEv+2WQqCh6Zcxv2oRD55g+O0oye9l40zE
         VbOvZ3R60SbIN++3IKS2yh90SOwgtqzaCgsQtPATI2d4WJvG5qImDFrX2yJUjrWx8T39
         MQQKFjvZ3fA1TYUVsHaA5FR0hdMwNCkK7TJVCIsBqtjkpd/DAEBvNeqI5bfg6Gepswe+
         l1jCxIh1lrZEBivplg5yDUBpa6io4UGCJ9ztmW+CUFCm1dTP8QhVkTov1blbHQ6U4xC3
         IWO5hCXy6iolpqSQIc2bH9AGoDcxJQSD0LkhoSBkctagTpdhEEFLo7Y5mpIRWVWOlKNE
         COTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=RpdJ5KT5GAuxqWidUZuS2M2CiPNp+gZwFhAUBa4xHko=;
        b=baZQ/MYYXyhOqxWjpnjrSg+w5kBuf0S/Xg6WOoXc2VwTz0mhCGHET9vQhalsEsZOad
         uMLN6+3bBg7n450OMa21hTa/383xwlTmPIZhkuNdGVwQZGWDTokUDV5qHDC4F5VSnPUA
         GrY63YUpXB/AscUee4zUSAA7jbLqDTHbpM6c8cr1jGinmY7R7BCSbsJNHUSHmnzGDdPa
         i4pMvj13vxmjTsMuYfnl9Sqtz0K1OJ9Pnk9OgUZuO78TYGHO1qwjvq9P7/tI5EhAq2tq
         odwtf83svwqhv+jh2L1aBJ9Bzo3toOssmU3+3EpcpnZ7b9cAP7iIRuqUu6EaK8ymmIJm
         lqBQ==
X-Gm-Message-State: ACgBeo3b/SNtK2dthjJPD6RxufilLCh08f+noawU/13QLTIrsJJE6Aoa
        XIK6KovoGz4zAxCObtlv3QXOKJVgi1U=
X-Google-Smtp-Source: AA6agR5j/r012ARsOS/cLTFyia8pItWWXJH9zXKKE4ubXclVuI6mHNquDQgDo/C5PUvhnsbEwfNt5cuHLt4=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:5207:ac36:fdd3:502d])
 (user=glider job=sendgmr) by 2002:a17:907:2173:b0:73d:c95d:1179 with SMTP id
 rl19-20020a170907217300b0073dc95d1179mr5669815ejb.89.1661526576513; Fri, 26
 Aug 2022 08:09:36 -0700 (PDT)
Date:   Fri, 26 Aug 2022 17:07:53 +0200
In-Reply-To: <20220826150807.723137-1-glider@google.com>
Mime-Version: 1.0
References: <20220826150807.723137-1-glider@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220826150807.723137-31-glider@google.com>
Subject: [PATCH v5 30/44] kcov: kmsan: unpoison area->list in kcov_remote_area_put()
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

KMSAN does not instrument kernel/kcov.c for performance reasons (with
CONFIG_KCOV=y virtually every place in the kernel invokes kcov
instrumentation). Therefore the tool may miss writes from kcov.c that
initialize memory.

When CONFIG_DEBUG_LIST is enabled, list pointers from kernel/kcov.c are
passed to instrumented helpers in lib/list_debug.c, resulting in false
positives.

To work around these reports, we unpoison the contents of area->list after
initializing it.

Signed-off-by: Alexander Potapenko <glider@google.com>
---

v4:
 -- change sizeof(type) to sizeof(*ptr)
 -- swap kcov: and kmsan: in the subject

Link: https://linux-review.googlesource.com/id/Ie17f2ee47a7af58f5cdf716d585ebf0769348a5a
---
 kernel/kcov.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/kcov.c b/kernel/kcov.c
index e19c84b02452e..e5cd09fd8a050 100644
--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -11,6 +11,7 @@
 #include <linux/fs.h>
 #include <linux/hashtable.h>
 #include <linux/init.h>
+#include <linux/kmsan-checks.h>
 #include <linux/mm.h>
 #include <linux/preempt.h>
 #include <linux/printk.h>
@@ -152,6 +153,12 @@ static void kcov_remote_area_put(struct kcov_remote_area *area,
 	INIT_LIST_HEAD(&area->list);
 	area->size = size;
 	list_add(&area->list, &kcov_remote_areas);
+	/*
+	 * KMSAN doesn't instrument this file, so it may not know area->list
+	 * is initialized. Unpoison it explicitly to avoid reports in
+	 * kcov_remote_area_get().
+	 */
+	kmsan_unpoison_memory(&area->list, sizeof(area->list));
 }
 
 static notrace bool check_kcov_mode(enum kcov_mode needed_mode, struct task_struct *t)
-- 
2.37.2.672.g94769d06f0-goog

